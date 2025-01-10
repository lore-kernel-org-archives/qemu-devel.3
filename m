Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E116E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWCb3-0005K7-7n; Fri, 10 Jan 2025 05:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tWCam-0005E5-Us
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:50:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tWCak-0001HB-1M
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:50:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736506213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UbyH8v5IB+LF0JpFVIwtVr25iA2MVfBysA/oCZIvUvQ=;
 b=ebHY5VI/p9FZmo5M7TBbe8DxPHtR+StFyH92Oq6vKL0LnzumlCPKWJDLkcmwtEeiTMPjG/
 VYwfzDJbdsuqEatl/T7ECzpsgzRPEBKSRQFr/0eTwEV7dHnnAVVOGS3k2Ed0fsux1op/Qt
 Uu1aKWhcGNUcNdQdHqVpz23yuCgxpjo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-uzdwYg6JMZKQR3SCjL0q2A-1; Fri,
 10 Jan 2025 05:50:10 -0500
X-MC-Unique: uzdwYg6JMZKQR3SCjL0q2A-1
X-Mimecast-MFC-AGG-ID: uzdwYg6JMZKQR3SCjL0q2A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FCC819560B1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:50:09 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.45.225.126])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 63FB21955BE3; Fri, 10 Jan 2025 10:50:07 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v3 7/8] qapi: golang: Generate command type
Date: Fri, 10 Jan 2025 11:49:45 +0100
Message-ID: <20250110104946.74960-8-victortoso@redhat.com>
In-Reply-To: <20250110104946.74960-1-victortoso@redhat.com>
References: <20250110104946.74960-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch handles QAPI command types and generates data structures in
Go that handles it.

This patch also generates the Command's return type. Each command has a
specific type for its expected return value.

1. Command:

    i. Naming: Every command type has a Command suffix.

   ii. Id: Every command has a MessageId field of string type.

  iii. Every command implements the Command interface.

   iv. The Command interface includes GetReturnType() which returns the
       expected return type for that Command

2. CommandReturn:

    i. Naming: Every command return type has a CommandReturn suffix

   ii. Id: Every command return has a MessageId field of string type.

  iii. Every command return implements the CommandReturn interface.

* Example:

qapi:
 | ##
 | # @set_password:
 | #
 | # Set the password of a remote display server.
 | #
 | # Errors:
 | #     - If Spice is not enabled, DeviceNotFound
 | #
 | # Since: 0.14
 | #
 | # .. qmp-example::
 | #
 | #     -> { "execute": "set_password", "arguments": { "protocol": "vnc",
 | #                                                    "password": "secret" } }
 | #     <- { "return": {} }
 | ##
 | { 'command': 'set_password', 'boxed': true, 'data': 'SetPasswordOptions' }

go:
 | // Set the password of a remote display server.
 | //
 | // Errors:   - If Spice is not enabled, DeviceNotFound
 | //
 | // Since: 0.14
 | //
 | // .. qmp-example::    -> { "execute": "set_password", "arguments": {
 | // "protocol": "vnc",                           "password": "secret" }
 | // }   <- { "return": {} }
 | type SetPasswordCommand struct {
 |     SetPasswordOptions
 |     MessageId string `json:"-"`
 | }
 |
 | type SetPasswordCommandReturn struct {
 |     MessageId string     `json:"id,omitempty"`
 |     Error     *QAPIError `json:"error,omitempty"`
 | }

usage:
 | input := `{"execute":"set_password",` +
 |          `"arguments":{"protocol":"vnc",` +
 |          `"password":"secret"}}`
 |
 | // Straight forward if you know the event type
 | {
 |     c := SetPasswordCommand{}
 |     err := json.Unmarshal([]byte(input), &c)
 |     if err != nil {
 |         panic(err)
 |     }
 |     // c.Password == "secret"
 | }
 |
 | // Generic way, using Command interface and helper function
 | if cmd, err := GetCommandType(input); err != nil {
 |     // handle bad data or unknown event
 | }
 |
 | if err := json.Unmarshal(input, cmd); err != nil {
 |     // handle bad data or unknown event fields
 | }
 |
 | if c, ok := cmd.(*SetPasswordCommand); ok {
 |     // c.Password == "secret"
 | }

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang.py | 233 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 231 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
index 6a8f5cf230..085cdd89f6 100644
--- a/scripts/qapi/golang.py
+++ b/scripts/qapi/golang.py
@@ -43,6 +43,15 @@
 """
 
 TEMPLATE_HELPER = """
+type QAPIError struct {
+    Class       string `json:"class"`
+    Description string `json:"desc"`
+}
+
+func (err *QAPIError) Error() string {
+    return err.Description
+}
+
 // Creates a decoder that errors on unknown Fields
 // Returns nil if successfully decoded @from payload to @into type
 // Returns error if failed to decode @from payload to @into type
@@ -305,6 +314,111 @@
 }}
 """
 
+TEMPLATE_COMMAND_METHODS = """
+func (s {type_name}) MarshalJSON() ([]byte, error) {{
+	type Alias {type_name}
+	return marshalCommand(Alias(s), "{name}", s.MessageId)
+}}
+
+func (s *{type_name}) UnmarshalJSON(data []byte) error {{
+	type Alias {type_name}
+    tmp := struct {{
+        MessageId string `json:"id,omitempty"`
+        Name      string `json:"execute"`
+        Args      Alias  `json:"arguments"`
+    }}{{}}
+
+    if err := json.Unmarshal(data, &tmp); err != nil {{
+        return fmt.Errorf("Failed to unmarshal: %s", string(data))
+    }}
+
+    if !strings.EqualFold(tmp.Name, "{name}") {{
+        return fmt.Errorf("Command type does not match with %s", tmp.Name)
+    }}
+
+    *s = {type_name}(tmp.Args)
+    s.MessageId = tmp.MessageId
+    return nil
+}}
+
+func (s *{type_name}) GetReturnType() CommandReturn {{
+    return &{cmd_ret_type_name}{{}}
+}}
+"""
+
+TEMPLATE_COMMAND = """
+type Command interface {{
+    json.Marshaler
+    json.Unmarshaler
+    GetReturnType() CommandReturn
+}}
+
+func marshalCommand(obj interface{{}}, name, id string) ([]byte, error) {{
+    m := make(map[string]any)
+    m["execute"] = name
+    if len(id) > 0 {{
+        m["id"] = id
+    }}
+    if bytes, err := json.Marshal(obj); err != nil {{
+        return []byte{{}}, err
+    }} else if len(bytes) > 2 {{
+        m["arguments"] = obj
+    }}
+    return json.Marshal(m)
+}}
+
+func GetCommandType(data []byte) (Command, error) {{
+    tmp := struct {{
+        Name string `json:"execute"`
+    }}{{}}
+
+    if err := json.Unmarshal(data, &tmp); err != nil {{
+        return nil, fmt.Errorf("Failed to decode command: %s", string(data))
+    }}
+
+    switch tmp.Name {{{cases}
+    }}
+    return nil, errors.New("Failed to recognize command")
+}}
+"""
+
+TEMPLATE_COMMAND_RETURN = """
+type CommandReturn interface {
+    json.Marshaler
+}
+
+func marshalCommandReturn(result, qerror any, id string) ([]byte, error) {
+	m := make(map[string]any)
+	if len(id) > 0 {
+		m["id"] = id
+	}
+	if qerror != nil && qerror.(*QAPIError) != nil {
+		m["error"] = qerror
+	} else if result != nil {
+		m["return"] = result
+	} else {
+		m["return"] = struct{}{}
+	}
+	return json.Marshal(m)
+}
+"""
+
+TEMPLATE_COMMAND_RETURN_METHODS = """
+func (r {cmd_ret_type_name}) MarshalJSON() ([]byte, error) {{
+	return marshalCommandReturn({cmd_ret_field}, r.Error, r.MessageId)
+}}
+"""
+
+TEMPLATE_COMMAND_RETURN_MARSHAL_EMPTY = """
+func (r {cmd_ret_ype_name}) MarshalJSON() ([]byte, error) {{
+    if r.Error != nil {{
+        type Alias {cmd_ret_type_name}
+        return json.Marshal(Alias(r))
+    }}
+    return []byte(`{{"return":{{}}}}`), nil
+}}
+"""
+
 
 # Takes the documentation object of a specific type and returns
 # that type's documentation and its member's docs.
@@ -386,7 +500,7 @@ def qapi_to_go_type_name(name: str, meta: Optional[str] = None) -> str:
     name += "".join(word.title() for word in words[1:])
 
     # Handle specific meta suffix
-    types = ["event"]
+    types = ["event", "command", "command return"]
     if meta in types:
         name = name[:-3] if name.endswith("Arg") else name
         name += meta.title().replace(" ", "")
@@ -855,6 +969,10 @@ def qapi_to_golang_struct(
                 "tag": """`json:"-"`""",
             },
         )
+    elif info.defn_meta == "command":
+        fields.insert(
+            0, {"name": "MessageId", "type": "string", "tag": """`json:"-"`"""}
+        )
 
     if members:
         for member in members:
@@ -1089,6 +1207,21 @@ def generate_template_alternate(
     return "\n" + content
 
 
+def generate_template_command(commands: dict[str, Tuple[str, str]]) -> str:
+    cases = ""
+    content = ""
+    for name in sorted(commands):
+        type_name, gocode = commands[name]
+        content += gocode
+        cases += f"""
+    case "{name}":
+        return &{type_name}{{}}, nil
+"""
+    content += string_to_code(TEMPLATE_COMMAND.format(cases=cases))
+    content += string_to_code(TEMPLATE_COMMAND_RETURN)
+    return content
+
+
 def generate_template_event(events: dict[str, Tuple[str, str]]) -> str:
     content = ""
     cases = ""
@@ -1138,6 +1271,7 @@ def __init__(self, _: str):
         super().__init__()
         types = (
             "alternate",
+            "command",
             "enum",
             "event",
             "helper",
@@ -1147,6 +1281,7 @@ def __init__(self, _: str):
         self.target = dict.fromkeys(types, "")
         self.schema: QAPISchema
         self.events: dict[str, Tuple[str, str]] = {}
+        self.commands: dict[str, Tuple[str, str]] = {}
         self.golang_package_name = "qapi"
         self.enums: dict[str, str] = {}
         self.alternates: dict[str, str] = {}
@@ -1192,6 +1327,15 @@ def visit_begin(self, schema: QAPISchema) -> None:
     "fmt"
     "strings"
 )
+"""
+            elif target == "command":
+                imports += """
+import (
+    "encoding/json"
+    "errors"
+    "fmt"
+    "strings"
+)
 """
             else:
                 imports += """
@@ -1214,6 +1358,7 @@ def visit_end(self) -> None:
         self.target["struct"] += generate_content_from_dict(self.structs)
         self.target["union"] += generate_content_from_dict(self.unions)
         self.target["event"] += generate_template_event(self.events)
+        self.target["command"] += generate_template_command(self.commands)
 
     def visit_object_type(
         self,
@@ -1358,7 +1503,91 @@ def visit_command(
         allow_preconfig: bool,
         coroutine: bool,
     ) -> None:
-        pass
+        assert name == info.defn_name
+        assert name not in self.commands
+
+        type_name = qapi_to_go_type_name(name, info.defn_meta)
+
+        doc = self.docmap.get(name, None)
+        type_doc, _ = qapi_to_golang_struct_docs(doc)
+
+        cmd_ret_type_name = qapi_to_go_type_name(name, "command return")
+        cmd_ret_field = "nil"
+        retargs: List[dict[str:str]] = [
+            {
+                "name": "MessageId",
+                "type": "string",
+                "tag": """`json:"id,omitempty"`""",
+            },
+            {
+                "name": "Error",
+                "type": "*QAPIError",
+                "tag": """`json:"error,omitempty"`""",
+            },
+        ]
+        if ret_type:
+            cmd_ret_field = "r.Result"
+            ret_type_name = qapi_schema_type_to_go_type(ret_type.name)
+            isptr = "*" if ret_type_name[0] not in "*[" else ""
+            retargs.append(
+                {
+                    "name": "Result",
+                    "type": f"{isptr}{ret_type_name}",
+                    "tag": """`json:"return"`""",
+                }
+            )
+
+        content = ""
+        if boxed or not arg_type or not qapi_name_is_object(arg_type.name):
+            args: List[dict[str:str]] = []
+            if arg_type:
+                args.append(
+                    {
+                        "name": f"{arg_type.name}",
+                    }
+                )
+            args.append(
+                {
+                    "name": "MessageId",
+                    "type": "string",
+                    "tag": """`json:"-"`""",
+                }
+            )
+            content += string_to_code(
+                generate_struct_type(type_name, type_doc=type_doc, args=args)
+            )
+        else:
+            assert isinstance(arg_type, QAPISchemaObjectType)
+            content += string_to_code(
+                qapi_to_golang_struct(
+                    self,
+                    name,
+                    arg_type.info,
+                    arg_type.ifcond,
+                    arg_type.features,
+                    arg_type.base,
+                    arg_type.members,
+                    arg_type.branches,
+                )
+            )
+
+        content += string_to_code(
+            TEMPLATE_COMMAND_METHODS.format(
+                name=name,
+                type_name=type_name,
+                cmd_ret_type_name=cmd_ret_type_name,
+            )
+        )
+        content += string_to_code(
+            generate_struct_type(cmd_ret_type_name, args=retargs)
+        )
+        content += string_to_code(
+            TEMPLATE_COMMAND_RETURN_METHODS.format(
+                cmd_ret_type_name=cmd_ret_type_name,
+                cmd_ret_field=cmd_ret_field,
+            )
+        )
+        self.commands[name] = (type_name, content)
 
     def visit_event(
         self,
-- 
2.47.1


