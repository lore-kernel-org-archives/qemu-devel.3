Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BCEE7719E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWCaa-0004zR-Jd; Fri, 10 Jan 2025 05:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tWCaY-0004yd-GZ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:50:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tWCaW-00013h-2C
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736506199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8L4pVRrBzojyzRJly6Lh/Qiv4PNwCZbSoICVu3xGnz8=;
 b=f+vixweoUoBk21KMYCLLyWSU2PWOWg1FccwTWTQ7PpEhGDetq15mL4+DX01aATivSM+ekp
 3yrGisBHN9IDgONtkbfPtWgBhEsTS4EXyjFYUfFzAvpPI/iU5e2IQKJHbWjXKSfjm3Lvh3
 xqnENJsI+kPU9lQqsO2gClt68OCE4eA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-1ay7IKloMrWswzOeubWTug-1; Fri,
 10 Jan 2025 05:49:58 -0500
X-MC-Unique: 1ay7IKloMrWswzOeubWTug-1
X-Mimecast-MFC-AGG-ID: 1ay7IKloMrWswzOeubWTug
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2914E1954185
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:49:57 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.45.225.126])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4CF291955BE3; Fri, 10 Jan 2025 10:49:54 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v3 2/8] qapi: golang: Generate alternate types
Date: Fri, 10 Jan 2025 11:49:40 +0100
Message-ID: <20250110104946.74960-3-victortoso@redhat.com>
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

This patch handles QAPI alternate types and generates data structures
in Go that handles it.

Alternate types are similar to Union but without a discriminator that
can be used to identify the underlying value on the wire.

1. Over the wire, we need to infer underlying value by its type

2. Pointer to types are mapped as optional. Absent value can be a
   valid value.

3. We use Go's standard 'encoding/json' library with its Marshal
   and Unmarshal interfaces.

4. As an exceptional but valid case, there are types that accept
   JSON NULL as value. Due to limitations with Go's standard library
   (point 3) combined with Absent being a possibility (point 2), we
   translante NULL values to a boolean field called 'IsNull'. See the
   second example and docs/devel/qapi-golang-code-gen.rst under
   Alternate section.

* First example:

qapi:
  | ##
  | # @BlockdevRef:
  | #
  | # Reference to a block device.
  | #
  | # @definition: defines a new block device inline
  | #
  | # @reference: references the ID of an existing block device
  | #
  | # Since: 2.9
  | ##
  | { 'alternate': 'BlockdevRef',
  |   'data': { 'definition': 'BlockdevOptions',
  |             'reference': 'str' } }

go:
  | // Reference to a block device.
  | //
  | // Since: 2.9
  | type BlockdevRef struct {
  | 	// defines a new block device inline
  | 	Definition *BlockdevOptions
  | 	// references the ID of an existing block device
  | 	Reference *string
  | }
  |
  | func (s BlockdevRef) MarshalJSON() ([]byte, error) {
  |     ...
  | }
  |
  | func (s *BlockdevRef) UnmarshalJSON(data []byte) error {
  |     ...
  | }

usage:
  | input := `{"driver":"qcow2","data-file":"/some/place/my-image"}`
  | k := BlockdevRef{}
  | err := json.Unmarshal([]byte(input), &k)
  | if err != nil {
  |     panic(err)
  | }
  | // *k.Definition.Qcow2.DataFile.Reference == "/some/place/my-image"

* Second example:

qapi:
 | { 'alternate': 'StrOrNull',
 |   'data': { 's': 'str',
 |             'n': 'null' } }

  | // This is a string value or the explicit lack of a string (null
  | // pointer in C).  Intended for cases when 'optional absent' already
  | // has a different meaning.
  | //
  | // Since: 2.10
  | type StrOrNull struct {
  | 	// the string value
  | 	S *string
  | 	// no string value
  | 	IsNull bool
  | }
  |
  | // Helper function to get its underlying Go value or absent of value
  | func (s *StrOrNull) ToAnyOrAbsent() (any, bool) {
  |     ...
  | }
  |
  | func (s StrOrNull) MarshalJSON() ([]byte, error) {
  |     ...
  | }
  |
  | func (s *StrOrNull) UnmarshalJSON(data []byte) error {
  |     ...
  | }

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang.py | 346 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 343 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
index 1e04c99f1c..805e54427c 100644
--- a/scripts/qapi/golang.py
+++ b/scripts/qapi/golang.py
@@ -14,10 +14,11 @@
 from __future__ import annotations
 
 import os, textwrap
-from typing import List, Optional
+from typing import List, Optional, Tuple
 
 from .schema import (
     QAPISchema,
+    QAPISchemaAlternateType,
     QAPISchemaBranches,
     QAPISchemaEnumMember,
     QAPISchemaFeature,
@@ -30,6 +31,7 @@
 )
 from .source import QAPISourceInfo
 
+FOUR_SPACES = "    "
 
 TEMPLATE_ENUM = """
 {maindoc}
@@ -40,6 +42,72 @@
 )
 """
 
+TEMPLATE_HELPER = """
+// Creates a decoder that errors on unknown Fields
+// Returns nil if successfully decoded @from payload to @into type
+// Returns error if failed to decode @from payload to @into type
+func StrictDecode(into interface{}, from []byte) error {
+    dec := json.NewDecoder(strings.NewReader(string(from)))
+    dec.DisallowUnknownFields()
+
+    if err := dec.Decode(into); err != nil {
+        return err
+    }
+    return nil
+}
+"""
+
+TEMPLATE_ALTERNATE_CHECK_INVALID_JSON_NULL = """
+    // Check for json-null first
+    if string(data) == "null" {{
+        return errors.New(`null not supported for {name}`)
+    }}"""
+
+TEMPLATE_ALTERNATE_NULLABLE_CHECK = """
+        }} else if s.{var_name} != nil {{
+            return *s.{var_name}, false"""
+
+TEMPLATE_ALTERNATE_MARSHAL_CHECK = """
+    if s.{var_name} != nil {{
+        return json.Marshal(s.{var_name})
+    }} else """
+
+TEMPLATE_ALTERNATE_UNMARSHAL_CHECK = """
+    // Check for {var_type}
+    {{
+        s.{var_name} = new({var_type})
+        if err := StrictDecode(s.{var_name}, data); err == nil {{
+            return nil
+        }}
+        s.{var_name} = nil
+    }}
+
+"""
+
+TEMPLATE_ALTERNATE_NULLABLE_MARSHAL_CHECK = """
+    if s.IsNull {
+        return []byte("null"), nil
+    } else """
+
+TEMPLATE_ALTERNATE_NULLABLE_UNMARSHAL_CHECK = """
+    // Check for json-null first
+    if string(data) == "null" {
+        s.IsNull = true
+        return nil
+    }"""
+
+TEMPLATE_ALTERNATE_METHODS = """
+func (s {name}) MarshalJSON() ([]byte, error) {{
+{marshal_check_fields}
+    return {marshal_return_default}
+}}
+
+func (s *{name}) UnmarshalJSON(data []byte) error {{
+{unmarshal_check_fields}
+    return fmt.Errorf("Can't convert to {name}: %s", string(data))
+}}
+"""
+
 
 # Takes the documentation object of a specific type and returns
 # that type's documentation and its member's docs.
@@ -80,10 +148,88 @@ def gen_golang(schema: QAPISchema, output_dir: str, prefix: str) -> None:
     vis.write(output_dir)
 
 
+def qapi_to_field_name(name: str) -> str:
+    return name.title().replace("_", "").replace("-", "")
+
+
 def qapi_to_field_name_enum(name: str) -> str:
     return name.title().replace("-", "")
 
 
+def qapi_schema_type_to_go_type(qapitype: str) -> str:
+    schema_types_to_go = {
+        "str": "string",
+        "null": "nil",
+        "bool": "bool",
+        "number": "float64",
+        "size": "uint64",
+        "int": "int64",
+        "int8": "int8",
+        "int16": "int16",
+        "int32": "int32",
+        "int64": "int64",
+        "uint8": "uint8",
+        "uint16": "uint16",
+        "uint32": "uint32",
+        "uint64": "uint64",
+        "any": "any",
+        "QType": "QType",
+    }
+
+    prefix = ""
+    if qapitype.endswith("List"):
+        prefix = "[]"
+        qapitype = qapitype[:-4]
+
+    qapitype = schema_types_to_go.get(qapitype, qapitype)
+    return prefix + qapitype
+
+
+# Helper for Alternate generation
+def qapi_field_to_alternate_go_field(
+    member_name: str, type_name: str
+) -> Tuple[str, str, str]:
+    # Nothing to generate on null types. We update some
+    # variables to handle json-null on marshalling methods.
+    if type_name == "null":
+        return "IsNull", "bool", ""
+
+    # On Alternates, fields are optional represented in Go as pointer
+    return (
+        qapi_to_field_name(member_name),
+        qapi_schema_type_to_go_type(type_name),
+        "*",
+    )
+
+
+def fetch_indent_blocks_over_args(
+    args: List[dict[str:str]],
+) -> Tuple[int, int]:
+    maxname, maxtype = 0, 0
+    blocks: tuple(int, int) = []
+    for arg in args:
+        if "comment" in arg or "doc" in arg:
+            blocks.append((maxname, maxtype))
+            maxname, maxtype = 0, 0
+
+            if "comment" in arg:
+                # They are single blocks
+                continue
+
+        if "type" not in arg:
+            # Embed type are on top of the struct and the following
+            # fields do not consider it for formatting
+            blocks.append((maxname, maxtype))
+            maxname, maxtype = 0, 0
+            continue
+
+        maxname = max(maxname, len(arg.get("name", "")))
+        maxtype = max(maxtype, len(arg.get("type", "")))
+
+    blocks.append((maxname, maxtype))
+    return blocks
+
+
 def fetch_indent_blocks_over_enum_with_docs(
     name: str, members: List[QAPISchemaEnumMember], docfields: Dict[str, str]
 ) -> Tuple[int]:
@@ -106,6 +252,137 @@ def fetch_indent_blocks_over_enum_with_docs(
     return blocks
 
 
+# Helper function for boxed or self contained structures.
+def generate_struct_type(
+    type_name,
+    type_doc: str = "",
+    args: List[dict[str:str]] = None,
+    indent: int = 0,
+) -> str:
+    base_indent = FOUR_SPACES * indent
+
+    with_type = ""
+    if type_name != "":
+        with_type = f"\n{base_indent}type {type_name}"
+
+    if type_doc != "":
+        # Append line jump only if type_doc exists
+        type_doc = f"\n{type_doc}"
+
+    if args is None:
+        # No args, early return
+        return f"""{type_doc}{with_type} struct{{}}"""
+
+    # The logic below is to generate fields of the struct.
+    # We have to be mindful of the different indentation possibilities between
+    # $var_name $var_type $var_tag that are vertically indented with gofmt.
+    #
+    # So, we first have to iterate over all args and find all indent blocks
+    # by calculating the spaces between (1) member and type and between (2)
+    # the type and tag. (1) and (2) is the tuple present in List returned
+    # by the helper function fetch_indent_blocks_over_args.
+    inner_indent = base_indent + FOUR_SPACES
+    doc_indent = inner_indent + "// "
+    fmt = textwrap.TextWrapper(
+        width=70, initial_indent=doc_indent, subsequent_indent=doc_indent
+    )
+
+    indent_block = iter(fetch_indent_blocks_over_args(args))
+    maxname, maxtype = next(indent_block)
+    members = " {\n"
+    for index, arg in enumerate(args):
+        if "comment" in arg:
+            maxname, maxtype = next(indent_block)
+            members += f"""    // {arg["comment"]}\n"""
+            # comments are single blocks, so we can skip to next arg
+            continue
+
+        name2type = ""
+        if "doc" in arg:
+            maxname, maxtype = next(indent_block)
+            members += fmt.fill(arg["doc"])
+            members += "\n"
+
+        name = arg["name"]
+        if "type" in arg:
+            namelen = len(name)
+            name2type = " " * max(1, (maxname - namelen + 1))
+
+        type2tag = ""
+        if "tag" in arg:
+            typelen = len(arg["type"])
+            type2tag = " " * max(1, (maxtype - typelen + 1))
+
+        gotype = arg.get("type", "")
+        tag = arg.get("tag", "")
+        members += (
+            f"""{inner_indent}{name}{name2type}{gotype}{type2tag}{tag}\n"""
+        )
+
+    members += f"{base_indent}}}\n"
+    return f"""{type_doc}{with_type} struct{members}"""
+
+
+def generate_template_alternate(
+    self: QAPISchemaGenGolangVisitor,
+    name: str,
+    variants: Optional[QAPISchemaVariants],
+) -> str:
+    args: List[dict[str:str]] = []
+    nullable = name in self.accept_null_types
+    if nullable:
+        # Examples in QEMU QAPI schema: StrOrNull and BlockdevRefOrNull
+        marshal_return_default = """[]byte("{}"), nil"""
+        marshal_check_fields = TEMPLATE_ALTERNATE_NULLABLE_MARSHAL_CHECK[1:]
+        unmarshal_check_fields = TEMPLATE_ALTERNATE_NULLABLE_UNMARSHAL_CHECK
+    else:
+        marshal_return_default = f'nil, errors.New("{name} has empty fields")'
+        marshal_check_fields = ""
+        unmarshal_check_fields = (
+            TEMPLATE_ALTERNATE_CHECK_INVALID_JSON_NULL.format(name=name)
+        )
+
+    doc = self.docmap.get(name, None)
+    content, docfields = qapi_to_golang_struct_docs(doc)
+    if variants:
+        for var in variants.variants:
+            var_name, var_type, isptr = qapi_field_to_alternate_go_field(
+                var.name, var.type.name
+            )
+            args.append(
+                {
+                    "name": f"{var_name}",
+                    "type": f"{isptr}{var_type}",
+                    "doc": docfields.get(var.name, ""),
+                }
+            )
+            # Null is special, handled first
+            if var.type.name == "null":
+                assert nullable
+                continue
+
+            skip_indent = 1 + len(FOUR_SPACES)
+            if marshal_check_fields == "":
+                skip_indent = 1
+            marshal_check_fields += TEMPLATE_ALTERNATE_MARSHAL_CHECK[
+                skip_indent:
+            ].format(var_name=var_name)
+            unmarshal_check_fields += TEMPLATE_ALTERNATE_UNMARSHAL_CHECK[
+                :-1
+            ].format(var_name=var_name, var_type=var_type)
+
+    content += string_to_code(generate_struct_type(name, args=args))
+    content += string_to_code(
+        TEMPLATE_ALTERNATE_METHODS.format(
+            name=name,
+            marshal_check_fields=marshal_check_fields[:-6],
+            marshal_return_default=marshal_return_default,
+            unmarshal_check_fields=unmarshal_check_fields[1:],
+        )
+    )
+    return "\n" + content
+
+
 def generate_content_from_dict(data: dict[str, str]) -> str:
     content = ""
 
@@ -115,20 +392,56 @@ def generate_content_from_dict(data: dict[str, str]) -> str:
     return content.replace("\n\n\n", "\n\n")
 
 
+def string_to_code(text: str) -> str:
+    DOUBLE_BACKTICK = "``"
+    result = ""
+    for line in text.splitlines():
+        # replace left four spaces with tabs
+        limit = len(line) - len(line.lstrip())
+        result += line[:limit].replace(FOUR_SPACES, "\t")
+
+        # work with the rest of the line
+        if line[limit : limit + 2] == "//":
+            # gofmt tool does not like comments with backticks.
+            result += line[limit:].replace(DOUBLE_BACKTICK, '"')
+        else:
+            result += line[limit:]
+        result += "\n"
+
+    return result
+
+
 class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
     # pylint: disable=too-many-arguments
     def __init__(self, _: str):
         super().__init__()
-        types = ("enum",)
+        types = (
+            "alternate",
+            "enum",
+            "helper",
+        )
         self.target = dict.fromkeys(types, "")
         self.schema: QAPISchema
         self.golang_package_name = "qapi"
         self.enums: dict[str, str] = {}
+        self.alternates: dict[str, str] = {}
+        self.accept_null_types = []
         self.docmap = {}
 
     def visit_begin(self, schema: QAPISchema) -> None:
         self.schema = schema
 
+        # We need to be aware of any types that accept JSON NULL
+        for name, entity in self.schema._entity_dict.items():
+            if not isinstance(entity, QAPISchemaAlternateType):
+                # Assume that only Alternate types accept JSON NULL
+                continue
+
+            for var in entity.alternatives.variants:
+                if var.type.name == "null":
+                    self.accept_null_types.append(name)
+                    break
+
         # iterate once in schema.docs to map doc objects to its name
         for doc in schema.docs:
             if doc.symbol is None:
@@ -136,12 +449,36 @@ def visit_begin(self, schema: QAPISchema) -> None:
             self.docmap[doc.symbol] = doc
 
         # Every Go file needs to reference its package name
+        # and most have some imports too.
         for target in self.target:
             self.target[target] = f"package {self.golang_package_name}"
 
+            imports = "\n"
+            if target == "helper":
+                imports += """
+import (
+    "encoding/json"
+    "fmt"
+    "strings"
+)
+"""
+            else:
+                imports += """
+import (
+    "encoding/json"
+    "errors"
+    "fmt"
+)
+"""
+            if target != "enum":
+                self.target[target] += string_to_code(imports)
+
+        self.target["helper"] += string_to_code(TEMPLATE_HELPER)
+
     def visit_end(self) -> None:
         del self.schema
         self.target["enum"] += generate_content_from_dict(self.enums)
+        self.target["alternate"] += generate_content_from_dict(self.alternates)
 
     def visit_object_type(
         self,
@@ -163,7 +500,10 @@ def visit_alternate_type(
         features: List[QAPISchemaFeature],
         variants: QAPISchemaVariants,
     ) -> None:
-        pass
+        assert name not in self.alternates
+        self.alternates[name] = generate_template_alternate(
+            self, name, variants
+        )
 
     def visit_enum_type(
         self,
-- 
2.47.1


