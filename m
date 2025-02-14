Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA760C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 20:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj2KM-00048U-BQ; Fri, 14 Feb 2025 15:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2KH-00047m-Ux
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2KF-00020S-Ag
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739565013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=obSlDwh3TsaJPeAE7rBADduh9KD7yNBRlbve9w1ILBk=;
 b=U1gOV8SEVUp276cncsRt7ujS0+jYyZbvFJuZHJ1n7bc6JZvsf8zbEXRCcG3/k3hO967s8m
 cxTTQ2/V+uwkpYa4cLtOZATiU8ey8nwkijchnGW32LjBFD8a7ZttUdKDmt32v1Z9BR2nZZ
 Wi4MJrSEPWiy0NGWvtlyusyok58yL+k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-_gE6C0o_PeyC8lVHP2T91A-1; Fri,
 14 Feb 2025 15:30:09 -0500
X-MC-Unique: _gE6C0o_PeyC8lVHP2T91A-1
X-Mimecast-MFC-AGG-ID: _gE6C0o_PeyC8lVHP2T91A_1739565009
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DACE180087F
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 20:30:09 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8BDFA180087D; Fri, 14 Feb 2025 20:30:05 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v4 05/11] qapi: golang: structs: Address nullable members
Date: Fri, 14 Feb 2025 21:29:38 +0100
Message-ID: <20250214202944.69897-6-victortoso@redhat.com>
In-Reply-To: <20250214202944.69897-1-victortoso@redhat.com>
References: <20250214202944.69897-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=ham autolearn_force=no
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

Explaining why this is needed needs some context, so taking the
example of StrOrNull alternate type and considering a simplified
struct that has two fields:

qapi:
 | { 'struct': 'MigrationExample',
 |   'data': { '*label': 'StrOrNull',
 |             'target': 'StrOrNull' } }

We have an optional member 'label' which can have three JSON values:
 1. A string: { "target": "a.host.com", "label": "happy" }
 2. A null  : { "target": "a.host.com", "label": null }
 3. Absent  : { "target": null}

The member 'target' is not optional, hence it can't be absent.

A Go struct that contains an optional type that can be JSON Null like
'label' in the example above, will need extra care when Marshaling and
Unmarshaling from JSON.

This patch handles this very specific case:
 - It implements the Marshaler interface for these structs to properly
   handle these values.
 - It adds the interface AbsentAlternate() and implement it for any
   Alternate that can be JSON Null. See its uses in map_and_set()

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang/golang.py | 290 ++++++++++++++++++++++++++++++++--
 1 file changed, 279 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi/golang/golang.py b/scripts/qapi/golang/golang.py
index e8a47b4a1e..0637bb3e3e 100644
--- a/scripts/qapi/golang/golang.py
+++ b/scripts/qapi/golang/golang.py
@@ -59,6 +59,17 @@
 )
 """
 
+TEMPLATE_ALTERNATE = """
+// Only implemented on Alternate types that can take JSON NULL as value.
+//
+// This is a helper for the marshalling code. It should return true only when
+// the Alternate is empty (no members are set), otherwise it returns false and
+// the member set to be Marshalled.
+type AbsentAlternate interface {
+    ToAnyOrAbsent() (any, bool)
+}
+"""
+
 TEMPLATE_ALTERNATE_CHECK_INVALID_JSON_NULL = """
     // Check for json-null first
     if string(data) == "null" {{
@@ -98,6 +109,19 @@
         return nil
     }"""
 
+TEMPLATE_ALTERNATE_NULLABLE = """
+func (s *{name}) ToAnyOrAbsent() (any, bool) {{
+    if s != nil {{
+        if s.IsNull {{
+            return nil, false
+{absent_check_fields}
+        }}
+    }}
+
+    return nil, true
+}}
+"""
+
 TEMPLATE_ALTERNATE_METHODS = """
 func (s {name}) MarshalJSON() ([]byte, error) {{
 {marshal_check_fields}
@@ -111,6 +135,26 @@
 """
 
 
+TEMPLATE_STRUCT_WITH_NULLABLE_MARSHAL = """
+func (s {type_name}) MarshalJSON() ([]byte, error) {{
+    m := make(map[string]any)
+{map_members}{map_special}
+    return json.Marshal(&m)
+}}
+
+func (s *{type_name}) UnmarshalJSON(data []byte) error {{
+    tmp := {struct}{{}}
+
+    if err := json.Unmarshal(data, &tmp); err != nil {{
+        return err
+    }}
+
+{set_members}{set_special}
+    return nil
+}}
+"""
+
+
 # Takes the documentation object of a specific type and returns
 # that type's documentation and its member's docs.
 def qapi_to_golang_struct_docs(doc: QAPIDoc) -> (str, Dict[str, str]):
@@ -359,20 +403,30 @@ def get_struct_field(
     qapi_name: str,
     qapi_type_name: str,
     field_doc: str,
+    within_nullable_struct: bool,
     is_optional: bool,
     is_variant: bool,
-) -> dict[str:str]:
+) -> Tuple[dict[str:str], bool]:
     field = qapi_to_field_name(qapi_name)
     member_type = qapi_schema_type_to_go_type(qapi_type_name)
+    is_nullable = False
 
     optional = ""
     if is_optional:
-        if member_type not in self.accept_null_types:
+        if member_type in self.accept_null_types:
+            is_nullable = True
+        else:
             optional = ",omitempty"
 
     # Use pointer to type when field is optional
     isptr = "*" if is_optional and member_type[0] not in "*[" else ""
 
+    if within_nullable_struct:
+        # Within a struct which has a field of type that can hold JSON NULL,
+        # we have to _not_ use a pointer, otherwise the Marshal methods are
+        # not called.
+        isptr = "" if member_type in self.accept_null_types else isptr
+
     fieldtag = (
         '`json:"-"`' if is_variant else f'`json:"{qapi_name}{optional}"`'
     )
@@ -384,38 +438,228 @@ def get_struct_field(
     if field_doc != "":
         arg["doc"] = field_doc
 
-    return arg
+    return arg, is_nullable
+
+
+# This helper is used whithin a struct that has members that accept JSON NULL.
+def map_and_set(
+    is_nullable: bool, field: str, field_is_optional: bool, name: str
+) -> Tuple[str, str]:
+    mapstr = ""
+    setstr = ""
+    if is_nullable:
+        mapstr = f"""
+    if val, absent := s.{field}.ToAnyOrAbsent(); !absent {{
+        m["{name}"] = val
+    }}
+"""
+        setstr += f"""
+    if _, absent := (&tmp.{field}).ToAnyOrAbsent(); !absent {{
+        s.{field} = &tmp.{field}
+    }}
+"""
+    elif field_is_optional:
+        mapstr = f"""
+    if s.{field} != nil {{
+        m["{name}"] = s.{field}
+    }}
+"""
+        setstr = f"""    s.{field} = tmp.{field}\n"""
+    else:
+        mapstr = f"""    m["{name}"] = s.{field}\n"""
+        setstr = f"""    s.{field} = tmp.{field}\n"""
+
+    return mapstr, setstr
+
+
+def recursive_base_nullable(
+    self: QAPISchemaGenGolangVisitor, base: Optional[QAPISchemaObjectType]
+) -> Tuple[List[dict[str:str]], str, str, str, str]:
+    fields: List[dict[str:str]] = []
+    map_members = ""
+    set_members = ""
+    map_special = ""
+    set_special = ""
+
+    if not base:
+        return fields, map_members, set_members, map_special, set_special
+
+    doc = self.docmap.get(base.name, None)
+    _, docfields = qapi_to_golang_struct_docs(doc)
+
+    if base.base is not None:
+        embed_base = self.schema.lookup_entity(base.base.name)
+        (
+            fields,
+            map_members,
+            set_members,
+            map_special,
+            set_special,
+        ) = recursive_base_nullable(self, embed_base)
+
+    for member in base.local_members:
+        field_doc = docfields.get(member.name, "")
+        field, _ = get_struct_field(
+            self,
+            member.name,
+            member.type.name,
+            field_doc,
+            True,
+            member.optional,
+            False,
+        )
+        fields.append(field)
+
+        member_type = qapi_schema_type_to_go_type(member.type.name)
+        nullable = member_type in self.accept_null_types
+        field_name = qapi_to_field_name(member.name)
+        tomap, toset = map_and_set(
+            nullable, field_name, member.optional, member.name
+        )
+        if nullable:
+            map_special += tomap
+            set_special += toset
+        else:
+            map_members += tomap
+            set_members += toset
+
+    return fields, map_members, set_members, map_special, set_special
+
+
+# Helper function. This is executed when the QAPI schema has members
+# that could accept JSON NULL (e.g: StrOrNull in QEMU"s QAPI schema).
+# This struct will need to be extended with Marshal/Unmarshal methods to
+# properly handle such atypical members.
+#
+# Only the Marshallaing methods are generated but we do need to iterate over
+# all the members to properly set/check them in those methods.
+def struct_with_nullable_generate_marshal(
+    self: QAPISchemaGenGolangVisitor,
+    name: str,
+    base: Optional[QAPISchemaObjectType],
+    members: List[QAPISchemaObjectTypeMember],
+    variants: Optional[QAPISchemaVariants],
+) -> str:
+    (
+        fields,
+        map_members,
+        set_members,
+        map_special,
+        set_special,
+    ) = recursive_base_nullable(self, base)
+
+    doc = self.docmap.get(name, None)
+    _, docfields = qapi_to_golang_struct_docs(doc)
+
+    if members:
+        for member in members:
+            field_doc = docfields.get(member.name, "")
+            field, _ = get_struct_field(
+                self,
+                member.name,
+                member.type.name,
+                field_doc,
+                True,
+                member.optional,
+                False,
+            )
+            fields.append(field)
+
+            member_type = qapi_schema_type_to_go_type(member.type.name)
+            nullable = member_type in self.accept_null_types
+            tomap, toset = map_and_set(
+                nullable,
+                qapi_to_field_name(member.name),
+                member.optional,
+                member.name,
+            )
+            if nullable:
+                map_special += tomap
+                set_special += toset
+            else:
+                map_members += tomap
+                set_members += toset
+
+    if variants:
+        for variant in variants.variants:
+            if variant.type.is_implicit():
+                continue
+
+            field, _ = get_struct_field(
+                self,
+                variant.name,
+                variant.type.name,
+                True,
+                variant.optional,
+                True,
+            )
+            fields.append(field)
+
+            member_type = qapi_schema_type_to_go_type(variant.type.name)
+            nullable = member_type in self.accept_null_types
+            tomap, toset = map_and_set(
+                nullable,
+                qapi_to_field_name(variant.name),
+                variant.optional,
+                variant.name,
+            )
+            if nullable:
+                map_special += tomap
+                set_special += toset
+            else:
+                map_members += tomap
+                set_members += toset
+
+    type_name = qapi_to_go_type_name(name)
+    struct = generate_struct_type("", args=fields, indent=1)
+    return string_to_code(
+        TEMPLATE_STRUCT_WITH_NULLABLE_MARSHAL.format(
+            struct=struct[1:-1],
+            type_name=type_name,
+            map_members=map_members,
+            map_special=map_special,
+            set_members=set_members,
+            set_special=set_special,
+        )
+    )
 
 
 def recursive_base(
     self: QAPISchemaGenGolangVisitor,
     base: Optional[QAPISchemaObjectType],
-) -> List[dict[str:str]]:
+    discriminator: Optional[str] = None,
+) -> Tuple[List[dict[str:str]], bool]:
     fields: List[dict[str:str]] = []
+    with_nullable = False
 
     if not base:
-        return fields
+        return fields, with_nullable
 
     if base.base is not None:
         embed_base = self.schema.lookup_entity(base.base.name)
-        fields = recursive_base(self, embed_base)
+        fields, with_nullable = recursive_base(self, embed_base, discriminator)
 
     doc = self.docmap.get(base.name, None)
     _, docfields = qapi_to_golang_struct_docs(doc)
 
     for member in base.local_members:
+        if discriminator and member.name == discriminator:
+            continue
+
         field_doc = docfields.get(member.name, "")
-        field = get_struct_field(
+        field, nullable = get_struct_field(
             self,
             member.name,
             member.type.name,
             field_doc,
+            False,
             member.optional,
             False,
         )
         fields.append(field)
+        with_nullable = True if nullable else with_nullable
 
-    return fields
+    return fields, with_nullable
 
 
 # Helper function that is used for most of QAPI types
@@ -431,7 +675,8 @@ def qapi_to_golang_struct(
     indent: int = 0,
     doc_enabled: bool = True,
 ) -> str:
-    fields = recursive_base(self, base)
+    discriminator = None if not variants else variants.tag_member.name
+    fields, with_nullable = recursive_base(self, base, discriminator)
 
     doc = self.docmap.get(name, None)
     type_doc, docfields = qapi_to_golang_struct_docs(doc)
@@ -441,15 +686,17 @@ def qapi_to_golang_struct(
     if members:
         for member in members:
             field_doc = docfields.get(member.name, "") if doc_enabled else ""
-            field = get_struct_field(
+            field, nullable = get_struct_field(
                 self,
                 member.name,
                 member.type.name,
                 field_doc,
+                False,
                 member.optional,
                 False,
             )
             fields.append(field)
+            with_nullable = True if nullable else with_nullable
 
     exists = {}
     if variants:
@@ -460,15 +707,17 @@ def qapi_to_golang_struct(
 
             exists[variant.name] = True
             field_doc = docfields.get(variant.name, "") if doc_enabled else ""
-            field = get_struct_field(
+            field, nullable = get_struct_field(
                 self,
                 variant.name,
                 variant.type.name,
                 field_doc,
+                False,
                 True,
                 True,
             )
             fields.append(field)
+            with_nullable = True if nullable else with_nullable
 
     type_name = qapi_to_go_type_name(name)
     content = string_to_code(
@@ -476,6 +725,10 @@ def qapi_to_golang_struct(
             type_name, type_doc=type_doc, args=fields, indent=indent
         )
     )
+    if with_nullable:
+        content += struct_with_nullable_generate_marshal(
+            self, name, base, members, variants
+        )
     return content
 
 
@@ -484,6 +737,7 @@ def generate_template_alternate(
     name: str,
     variants: Optional[QAPISchemaVariants],
 ) -> str:
+    absent_check_fields = ""
     args: List[dict[str:str]] = []
     nullable = name in self.accept_null_types
     if nullable:
@@ -517,6 +771,12 @@ def generate_template_alternate(
                 assert nullable
                 continue
 
+            if nullable:
+                absent_check_fields += string_to_code(
+                    TEMPLATE_ALTERNATE_NULLABLE_CHECK[1:].format(
+                        var_name=var_name
+                    )
+                )
             skip_indent = 1 + len(FOUR_SPACES)
             if marshal_check_fields == "":
                 skip_indent = 1
@@ -528,6 +788,12 @@ def generate_template_alternate(
             ].format(var_name=var_name, var_type=var_type)
 
     content += string_to_code(generate_struct_type(name, args=args))
+    if nullable:
+        content += string_to_code(
+            TEMPLATE_ALTERNATE_NULLABLE.format(
+                name=name, absent_check_fields=absent_check_fields[:-1]
+            )
+        )
     content += string_to_code(
         TEMPLATE_ALTERNATE_METHODS.format(
             name=name,
@@ -629,6 +895,8 @@ def visit_begin(self, schema: QAPISchema) -> None:
             )
             self.types[qapitype] += generate_template_imports(imports)
 
+        self.types["alternate"] += string_to_code(TEMPLATE_ALTERNATE)
+
     def visit_end(self) -> None:
         del self.schema
         self.types["enum"] += generate_content_from_dict(self.enums)
-- 
2.48.1


