Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D943CC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 20:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj2Kr-000491-PC; Fri, 14 Feb 2025 15:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2KJ-00047q-9q
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2KH-00020z-0C
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739565016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c8tZQemqjYq4asfStaHd1xQomy+ne9g/9ss/GyZ19Cs=;
 b=OFZS+al52MhhnvNumTt8SftZOX1X/2FTUWWsCCASGRvOwCxfhkLqJ6zVsBJ/Vt4V5CneRd
 2VAXoJZHavbBiMC8q8qdZDBguxJidDNB7pFdu0mvHD+Wti+VfTZp4bn0JEakiZcedyLYJu
 DojXgM0Bpj64fO4WlkzxX2nMDk5LKf4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-CoED3PVoNES9-4pI28VZvA-1; Fri,
 14 Feb 2025 15:30:12 -0500
X-MC-Unique: CoED3PVoNES9-4pI28VZvA-1
X-Mimecast-MFC-AGG-ID: CoED3PVoNES9-4pI28VZvA_1739565012
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1338A1800875
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 20:30:12 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E13D1800352; Fri, 14 Feb 2025 20:30:09 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v4 06/11] qapi: golang: Generate union type
Date: Fri, 14 Feb 2025 21:29:39 +0100
Message-ID: <20250214202944.69897-7-victortoso@redhat.com>
In-Reply-To: <20250214202944.69897-1-victortoso@redhat.com>
References: <20250214202944.69897-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch handles QAPI union types and generates the equivalent data
structures and methods in Go to handle it.

The QAPI union type has two types of fields: The @base and the
@Variants members. The @base fields can be considered common members
for the union while only one field maximum is set for the @Variants.

In the QAPI specification, it defines a @discriminator field, which is
an Enum type. The purpose of the  @discriminator is to identify which
@variant type is being used.

For the @discriminator's enum that are not handled by the QAPI Union,
we add in the Go struct a separate block as "Unbranched enum fields".
The rationale for this extra block is to allow the user to pass that
enum value under the discriminator, without extra payload.

The union types implement the Marshaler and Unmarshaler interfaces to
seamless decode from JSON objects to Golang structs and vice versa.

qapi:
 | ##
 | # @SetPasswordOptions:
 | #
 | # Options for set_password.
 | #
 | # @protocol:
 | #     - 'vnc' to modify the VNC server password
 | #     - 'spice' to modify the Spice server password
 | #
 | # @password: the new password
 | #
 | # @connected: How to handle existing clients when changing the
 | #     password.  If nothing is specified, defaults to 'keep'.  For
 | #     VNC, only 'keep' is currently implemented.
 | #
 | # Since: 7.0
 | ##
 | { 'union': 'SetPasswordOptions',
 |   'base': { 'protocol': 'DisplayProtocol',
 |             'password': 'str',
 |             '*connected': 'SetPasswordAction' },
 |   'discriminator': 'protocol',
 |   'data': { 'vnc': 'SetPasswordOptionsVnc' } }

go:
 | // Options for set_password.
 | //
 | // Since: 7.0
 | type SetPasswordOptions struct {
 | 	// the new password
 | 	Password string `json:"password"`
 | 	// How to handle existing clients when changing the password. If
 | 	// nothing is specified, defaults to 'keep'. For VNC, only 'keep'
 | 	// is currently implemented.
 | 	Connected *SetPasswordAction `json:"connected,omitempty"`
 | 	// Variants fields
 | 	Vnc *SetPasswordOptionsVnc `json:"-"`
 | 	// Unbranched enum fields
 | 	Spice bool `json:"-"`
 | }
 |
 | func (s SetPasswordOptions) MarshalJSON() ([]byte, error) {
 |      ...
 | }

 |
 | func (s *SetPasswordOptions) UnmarshalJSON(data []byte) error {
 |      ...
 | }

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang/golang.py | 208 +++++++++++++++++++++++++++++++++-
 scripts/qapi/golang/utils.go  |  12 ++
 2 files changed, 217 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/golang/golang.py b/scripts/qapi/golang/golang.py
index 0637bb3e3e..59e9b1f644 100644
--- a/scripts/qapi/golang/golang.py
+++ b/scripts/qapi/golang/golang.py
@@ -155,6 +155,81 @@
 """
 
 
+TEMPLATE_UNION_CHECK_VARIANT_FIELD = """
+    if s.{field} != nil && err == nil {{
+        if len(bytes) != 0 {{
+            err = errors.New(`multiple variant fields set`)
+        }} else if err = unwrapToMap(m, s.{field}); err == nil {{
+            m["{discriminator}"] = {go_enum_value}
+            bytes, err = json.Marshal(m)
+        }}
+    }}
+"""
+
+TEMPLATE_UNION_CHECK_UNBRANCHED_FIELD = """
+    if s.{field} && err == nil {{
+        if len(bytes) != 0 {{
+            err = errors.New(`multiple variant fields set`)
+        }} else {{
+            m["{discriminator}"] = {go_enum_value}
+            bytes, err = json.Marshal(m)
+        }}
+    }}
+"""
+
+TEMPLATE_UNION_DRIVER_VARIANT_CASE = """
+    case {go_enum_value}:
+        s.{field} = new({member_type})
+        if err := json.Unmarshal(data, s.{field}); err != nil {{
+            s.{field} = nil
+            return err
+        }}"""
+
+TEMPLATE_UNION_DRIVER_UNBRANCHED_CASE = """
+    case {go_enum_value}:
+        s.{field} = true
+"""
+
+TEMPLATE_UNION_METHODS = """
+func (s {type_name}) MarshalJSON() ([]byte, error) {{
+    var bytes []byte
+    var err error
+    m := make(map[string]any)
+    {{
+        type Alias {type_name}
+        v := Alias(s)
+        unwrapToMap(m, &v)
+    }}
+{check_fields}
+    if err != nil {{
+        return nil, fmt.Errorf("marshal {type_name} due:'%s' struct='%+v'", err, s)
+    }} else if len(bytes) == 0 {{
+        return nil, fmt.Errorf("marshal {type_name} unsupported, struct='%+v'", s)
+    }}
+    return bytes, nil
+}}
+
+func (s *{type_name}) UnmarshalJSON(data []byte) error {{
+{base_type_def}
+    tmp := struct {{
+        {base_type_name}
+    }}{{}}
+
+    if err := json.Unmarshal(data, &tmp); err != nil {{
+        return err
+    }}
+{base_type_assign_unmarshal}
+    switch tmp.{discriminator} {{
+{driver_cases}
+    default:
+        return fmt.Errorf("unmarshal {type_name} received unrecognized value '%s'",
+            tmp.{discriminator})
+    }}
+    return nil
+}}
+"""
+
+
 # Takes the documentation object of a specific type and returns
 # that type's documentation and its member's docs.
 def qapi_to_golang_struct_docs(doc: QAPIDoc) -> (str, Dict[str, str]):
@@ -202,6 +277,12 @@ def qapi_name_is_object(name: str) -> bool:
     return name.startswith("q_obj_")
 
 
+def qapi_base_name_to_parent(name: str) -> str:
+    if qapi_name_is_base(name):
+        name = name[6:-5]
+    return name
+
+
 def qapi_to_field_name(name: str) -> str:
     return name.title().replace("_", "").replace("-", "")
 
@@ -639,7 +720,7 @@ def recursive_base(
         embed_base = self.schema.lookup_entity(base.base.name)
         fields, with_nullable = recursive_base(self, embed_base, discriminator)
 
-    doc = self.docmap.get(base.name, None)
+    doc = self.docmap.get(qapi_base_name_to_parent(base.name), None)
     _, docfields = qapi_to_golang_struct_docs(doc)
 
     for member in base.local_members:
@@ -719,6 +800,24 @@ def qapi_to_golang_struct(
             fields.append(field)
             with_nullable = True if nullable else with_nullable
 
+    if info.defn_meta == "union" and variants:
+        enum_name = variants.tag_member.type.name
+        enum_obj = self.schema.lookup_entity(enum_name)
+        if len(exists) != len(enum_obj.members):
+            fields.append({"comment": "Unbranched enum fields"})
+            for member in enum_obj.members:
+                if member.name in exists:
+                    continue
+
+                field_doc = (
+                    docfields.get(member.name, "") if doc_enabled else ""
+                )
+                field, nullable = get_struct_field(
+                    self, member.name, "bool", field_doc, False, False, True
+                )
+                fields.append(field)
+                with_nullable = True if nullable else with_nullable
+
     type_name = qapi_to_go_type_name(name)
     content = string_to_code(
         generate_struct_type(
@@ -732,6 +831,98 @@ def qapi_to_golang_struct(
     return content
 
 
+def qapi_to_golang_methods_union(
+    self: QAPISchemaGenGolangVisitor,
+    name: str,
+    base: Optional[QAPISchemaObjectType],
+    variants: Optional[QAPISchemaVariants],
+) -> str:
+    type_name = qapi_to_go_type_name(name)
+
+    assert base
+    base_type_assign_unmarshal = ""
+    base_type_name = qapi_to_go_type_name(base.name)
+    base_type_def = qapi_to_golang_struct(
+        self,
+        base.name,
+        base.info,
+        base.ifcond,
+        base.features,
+        base.base,
+        base.members,
+        base.branches,
+        indent=1,
+        doc_enabled=False,
+    )
+
+    discriminator = qapi_to_field_name(variants.tag_member.name)
+    for member in base.local_members:
+        field = qapi_to_field_name(member.name)
+        if field == discriminator:
+            continue
+        base_type_assign_unmarshal += f"""
+    s.{field} = tmp.{field}"""
+
+    driver_cases = ""
+    check_fields = ""
+    exists = {}
+    enum_name = variants.tag_member.type.name
+    if variants:
+        for var in variants.variants:
+            if var.type.is_implicit():
+                continue
+
+            field = qapi_to_field_name(var.name)
+            enum_value = qapi_to_field_name_enum(var.name)
+            member_type = qapi_schema_type_to_go_type(var.type.name)
+            go_enum_value = f"""{enum_name}{enum_value}"""
+            exists[go_enum_value] = True
+
+            check_fields += TEMPLATE_UNION_CHECK_VARIANT_FIELD.format(
+                field=field,
+                discriminator=variants.tag_member.name,
+                go_enum_value=go_enum_value,
+            )
+            driver_cases += TEMPLATE_UNION_DRIVER_VARIANT_CASE.format(
+                go_enum_value=go_enum_value,
+                field=field,
+                member_type=member_type,
+            )
+
+    enum_obj = self.schema.lookup_entity(enum_name)
+    if len(exists) != len(enum_obj.members):
+        for member in enum_obj.members:
+            value = qapi_to_field_name_enum(member.name)
+            go_enum_value = f"""{enum_name}{value}"""
+
+            if go_enum_value in exists:
+                continue
+
+            field = qapi_to_field_name(member.name)
+
+            check_fields += TEMPLATE_UNION_CHECK_UNBRANCHED_FIELD.format(
+                field=field,
+                discriminator=variants.tag_member.name,
+                go_enum_value=go_enum_value,
+            )
+            driver_cases += TEMPLATE_UNION_DRIVER_UNBRANCHED_CASE.format(
+                go_enum_value=go_enum_value,
+                field=field,
+            )
+
+    return string_to_code(
+        TEMPLATE_UNION_METHODS.format(
+            type_name=type_name,
+            check_fields=check_fields[1:],
+            base_type_def=base_type_def[1:],
+            base_type_name=base_type_name,
+            base_type_assign_unmarshal=base_type_assign_unmarshal,
+            discriminator=discriminator,
+            driver_cases=driver_cases[1:],
+        )
+    )
+
+
 def generate_template_alternate(
     self: QAPISchemaGenGolangVisitor,
     name: str,
@@ -855,6 +1046,7 @@ def __init__(self, _: str):
             "alternate": ["encoding/json", "errors", "fmt"],
             "enum": [],
             "struct": ["encoding/json"],
+            "union": ["encoding/json", "errors", "fmt"],
         }
 
         self.schema: QAPISchema
@@ -863,6 +1055,7 @@ def __init__(self, _: str):
         self.enums: dict[str, str] = {}
         self.alternates: dict[str, str] = {}
         self.structs: dict[str, str] = {}
+        self.unions: dict[str, str] = {}
         self.accept_null_types = []
         self.docmap = {}
 
@@ -902,6 +1095,7 @@ def visit_end(self) -> None:
         self.types["enum"] += generate_content_from_dict(self.enums)
         self.types["alternate"] += generate_content_from_dict(self.alternates)
         self.types["struct"] += generate_content_from_dict(self.structs)
+        self.types["union"] += generate_content_from_dict(self.unions)
 
     def visit_object_type(
         self,
@@ -913,11 +1107,11 @@ def visit_object_type(
         members: List[QAPISchemaObjectTypeMember],
         branches: Optional[QAPISchemaBranches],
     ) -> None:
-        # Do not handle anything besides struct.
+        # Do not handle anything besides struct and unions.
         if (
             name == self.schema.the_empty_object_type.name
             or not isinstance(name, str)
-            or info.defn_meta not in ["struct"]
+            or info.defn_meta not in ["struct", "union"]
         ):
             return
 
@@ -948,6 +1142,14 @@ def visit_object_type(
                     self, name, info, ifcond, features, base, members, branches
                 )
             )
+        else:
+            assert name not in self.unions
+            self.unions[name] = qapi_to_golang_struct(
+                self, name, info, ifcond, features, base, members, branches
+            )
+            self.unions[name] += qapi_to_golang_methods_union(
+                self, name, base, branches
+            )
 
     def visit_alternate_type(
         self,
diff --git a/scripts/qapi/golang/utils.go b/scripts/qapi/golang/utils.go
index f00c0a5d83..193e0c53bb 100644
--- a/scripts/qapi/golang/utils.go
+++ b/scripts/qapi/golang/utils.go
@@ -9,6 +9,7 @@ package qapi
 
 import (
 	"encoding/json"
+	"fmt"
 	"strings"
 )
 
@@ -24,3 +25,14 @@ func strictDecode(into interface{}, from []byte) error {
 	}
 	return nil
 }
+
+// This helper is used to move struct's fields into a map.
+// This function is useful to merge JSON objects.
+func unwrapToMap(m map[string]any, data any) error {
+	if bytes, err := json.Marshal(&data); err != nil {
+		return fmt.Errorf("unwrapToMap: %s", err)
+	} else if err := json.Unmarshal(bytes, &m); err != nil {
+		return fmt.Errorf("unwrapToMap: %s, data=%s", err, string(bytes))
+	}
+	return nil
+}
-- 
2.48.1


