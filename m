Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF6CE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWCai-00055b-PV; Fri, 10 Jan 2025 05:50:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tWCaf-000543-CR
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:50:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tWCad-0001GK-9j
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736506206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUx9qC+EjkbMllxMBJQcin1uYLi0gdtIM3oc0kcoKFw=;
 b=HguowF+7Gw3jeFH8lE05AlkFLzrb9VLJts0PipEWlmmhMQDbrO1oVQbXgPq9xCyzN0rDx8
 5h0gEqUrshA4wCvw1XESfp1trX+xl3AE/34EvtdlMI4PqCrwkOAYskHsybZI9BmVDPXWF7
 D6lSwjs7+2hJNtAXjcRVaT3QeldCfu0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-2T1nt7tnMo642PjNpnnfgw-1; Fri,
 10 Jan 2025 05:50:05 -0500
X-MC-Unique: 2T1nt7tnMo642PjNpnnfgw-1
X-Mimecast-MFC-AGG-ID: 2T1nt7tnMo642PjNpnnfgw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 567D219560BD
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:50:04 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.45.225.126])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D6F11954B24; Fri, 10 Jan 2025 10:50:02 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v3 5/8] qapi: golang: Generate union type
Date: Fri, 10 Jan 2025 11:49:43 +0100
Message-ID: <20250110104946.74960-6-victortoso@redhat.com>
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
 scripts/qapi/golang.py | 208 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 205 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
index ada89f0ce8..330891ede9 100644
--- a/scripts/qapi/golang.py
+++ b/scripts/qapi/golang.py
@@ -164,6 +164,81 @@
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
@@ -211,6 +286,12 @@ def qapi_name_is_object(name: str) -> bool:
     return name.startswith("q_obj_")
 
 
+def qapi_base_name_to_parent(name: str) -> str:
+    if qapi_name_is_base(name):
+        name = name[6:-5]
+    return name
+
+
 def qapi_to_field_name(name: str) -> str:
     return name.title().replace("_", "").replace("-", "")
 
@@ -648,7 +729,7 @@ def recursive_base(
         embed_base = self.schema.lookup_entity(base.base.name)
         fields, with_nullable = recursive_base(self, embed_base, discriminator)
 
-    doc = self.docmap.get(base.name, None)
+    doc = self.docmap.get(qapi_base_name_to_parent(base.name), None)
     _, docfields = qapi_to_golang_struct_docs(doc)
 
     for member in base.local_members:
@@ -728,6 +809,24 @@ def qapi_to_golang_struct(
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
@@ -741,6 +840,98 @@ def qapi_to_golang_struct(
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
@@ -851,6 +1042,7 @@ def __init__(self, _: str):
             "enum",
             "helper",
             "struct",
+            "union",
         )
         self.target = dict.fromkeys(types, "")
         self.schema: QAPISchema
@@ -858,6 +1050,7 @@ def __init__(self, _: str):
         self.enums: dict[str, str] = {}
         self.alternates: dict[str, str] = {}
         self.structs: dict[str, str] = {}
+        self.unions: dict[str, str] = {}
         self.accept_null_types = []
         self.docmap = {}
 
@@ -918,6 +1111,7 @@ def visit_end(self) -> None:
         self.target["enum"] += generate_content_from_dict(self.enums)
         self.target["alternate"] += generate_content_from_dict(self.alternates)
         self.target["struct"] += generate_content_from_dict(self.structs)
+        self.target["union"] += generate_content_from_dict(self.unions)
 
     def visit_object_type(
         self,
@@ -929,11 +1123,11 @@ def visit_object_type(
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
 
@@ -964,6 +1158,14 @@ def visit_object_type(
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
-- 
2.47.1


