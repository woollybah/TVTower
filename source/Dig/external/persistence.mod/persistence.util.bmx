SuperStrict

'Framework bah.persistence
'Import brl.standardio

Import "persistence.bmx"
Import "../string_comp.bmx"


Type TLowerStringSerializer Extends TXMLSerializer

	Method TypeName:String()
		Return "TLowerString"
	End Method
	
	Method Serialize(tid:TTypeId, obj:Object, node:TxmlNode)
		Local s:TLowerString = TLowerString(obj)
		If s Then
			node.setContent(s.orig)
		End If
	End Method
	
	Method Deserialize:Object(objType:TTypeId, node:TxmlNode)
		Local s:TLowerString = TLowerString.Create(node.getContent())
		AddObjectRefNode(node, s)
		Return s
	End Method

End Type

TXMLPersistenceBuilder.RegisterDefault(New TLowerStringSerializer)

rem
' test

Type TMyType

	Field s1:TLowerString
	Field s2:TLowerString

End Type

Local m:TMyType = New TMyType
m.s1 = TLowerString.Create("Hello World!")
m.s2 = TLowerString.Create("HOWDY")

Local persist:TPersist = New TXMLPersistenceBuilder.Build()
Local s:String = persist.SerializeToString(m)

Print s
persist.Free()

Local obj:TMyType = TMyType(persist.DeSerializeObject(s))
Print obj.s1.ToString()
Print obj.s2.ToString()

endrem
