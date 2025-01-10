Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46732E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWCaY-0004yN-QN; Fri, 10 Jan 2025 05:50:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tWCaV-0004y0-6x
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:49:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tWCaS-00013X-Ux
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736506196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w8AZiIA9W1TzaVAG9+hKibFhY4H33vAecNgwWO6zvO0=;
 b=Sl8gqAjduTnGhC2LYejd0zu16RORVOhaeS93QR7t61QqG49rjmcHihGoZ7qZo86yNdvkl3
 mf8Bzhp7sDkspKW3KozbAX58ZYKnKXOhtdZVzwe6ArITP+mb9WMGDTVDoYheq2ivO6mLTB
 OcXrilg68BR63DEeGrB1tCCIcGer2Rk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-G9ig2EWfN7Wv4rFbq4RCLA-1; Fri,
 10 Jan 2025 05:49:54 -0500
X-MC-Unique: G9ig2EWfN7Wv4rFbq4RCLA-1
X-Mimecast-MFC-AGG-ID: G9ig2EWfN7Wv4rFbq4RCLA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE5BE1955F79
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:49:53 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.45.225.126])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E75F11955BE3; Fri, 10 Jan 2025 10:49:50 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v3 1/8] qapi: golang: Generate enum type
Date: Fri, 10 Jan 2025 11:49:39 +0100
Message-ID: <20250110104946.74960-2-victortoso@redhat.com>
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

This patch handles QAPI enum types and generates its equivalent in Go.
We sort the output based on enum's type name.

Enums are being handled as strings in Golang.

1. For each QAPI enum, we will define a string type in Go to be the
   assigned type of this specific enum.

2. Naming: CamelCase will be used in any identifier that we want to
   export, which is everything.

Example:

qapi:
  | ##
  | # @DisplayProtocol:
  | #
  | # Display protocols which support changing password options.
  | #
  | # Since: 7.0
  | ##
  | { 'enum': 'DisplayProtocol',
  |   'data': [ 'vnc', 'spice' ] }

go:
  | // Display protocols which support changing password options.
  | //
  | // Since: 7.0
  | type DisplayProtocol string
  |
  | const (
  | 	DisplayProtocolVnc   DisplayProtocol = "vnc"
  | 	DisplayProtocolSpice DisplayProtocol = "spice"
  | )

Signed-off-by: Victor Toso <victortoso@redhat.com>
---
 scripts/qapi/golang.py | 266 +++++++++++++++++++++++++++++++++++++++++
 scripts/qapi/main.py   |   3 +
 2 files changed, 269 insertions(+)
 create mode 100644 scripts/qapi/golang.py

diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
new file mode 100644
index 0000000000..1e04c99f1c
--- /dev/null
+++ b/scripts/qapi/golang.py
@@ -0,0 +1,266 @@
+"""
+Golang QAPI generator
+"""
+
+# Copyright (c) 2025 Red Hat Inc.
+#
+# Authors:
+#  Victor Toso <victortoso@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+
+# Just for type hint on self
+from __future__ import annotations
+
+import os, textwrap
+from typing import List, Optional
+
+from .schema import (
+    QAPISchema,
+    QAPISchemaBranches,
+    QAPISchemaEnumMember,
+    QAPISchemaFeature,
+    QAPISchemaIfCond,
+    QAPISchemaObjectType,
+    QAPISchemaObjectTypeMember,
+    QAPISchemaType,
+    QAPISchemaVariants,
+    QAPISchemaVisitor,
+)
+from .source import QAPISourceInfo
+
+
+TEMPLATE_ENUM = """
+{maindoc}
+type {name} string
+
+const (
+{fields}
+)
+"""
+
+
+# Takes the documentation object of a specific type and returns
+# that type's documentation and its member's docs.
+def qapi_to_golang_struct_docs(doc: QAPIDoc) -> (str, Dict[str, str]):
+    if doc is None:
+        return "", {}
+
+    cmt = "// "
+    fmt = textwrap.TextWrapper(
+        width=70, initial_indent=cmt, subsequent_indent=cmt
+    )
+    main = fmt.fill(doc.body.text)
+
+    for section in doc.sections:
+        # TODO is not a relevant section to Go applications
+        if section.tag in ["TODO"]:
+            continue
+
+        if main != "":
+            # Give empty line as space for the tag.
+            main += "\n//\n"
+
+        tag = "" if section.tag is None else f"{section.tag}: "
+        text = section.text.replace("  ", " ")
+        main += fmt.fill(f"{tag}{text}")
+
+    fields = {}
+    for key, value in doc.args.items():
+        if len(value.text) > 0:
+            fields[key] = " ".join(value.text.replace("\n", " ").split())
+
+    return main, fields
+
+
+def gen_golang(schema: QAPISchema, output_dir: str, prefix: str) -> None:
+    vis = QAPISchemaGenGolangVisitor(prefix)
+    schema.visit(vis)
+    vis.write(output_dir)
+
+
+def qapi_to_field_name_enum(name: str) -> str:
+    return name.title().replace("-", "")
+
+
+def fetch_indent_blocks_over_enum_with_docs(
+    name: str, members: List[QAPISchemaEnumMember], docfields: Dict[str, str]
+) -> Tuple[int]:
+    maxname = 0
+    blocks: List[int] = [0]
+    for member in members:
+        # For simplicity, every time we have doc, we add a new indent block
+        hasdoc = member.name is not None and member.name in docfields
+
+        enum_name = f"{name}{qapi_to_field_name_enum(member.name)}"
+        maxname = (
+            max(maxname, len(enum_name)) if not hasdoc else len(enum_name)
+        )
+
+        if hasdoc:
+            blocks.append(maxname)
+        else:
+            blocks[-1] = maxname
+
+    return blocks
+
+
+def generate_content_from_dict(data: dict[str, str]) -> str:
+    content = ""
+
+    for name in sorted(data):
+        content += data[name]
+
+    return content.replace("\n\n\n", "\n\n")
+
+
+class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
+    # pylint: disable=too-many-arguments
+    def __init__(self, _: str):
+        super().__init__()
+        types = ("enum",)
+        self.target = dict.fromkeys(types, "")
+        self.schema: QAPISchema
+        self.golang_package_name = "qapi"
+        self.enums: dict[str, str] = {}
+        self.docmap = {}
+
+    def visit_begin(self, schema: QAPISchema) -> None:
+        self.schema = schema
+
+        # iterate once in schema.docs to map doc objects to its name
+        for doc in schema.docs:
+            if doc.symbol is None:
+                continue
+            self.docmap[doc.symbol] = doc
+
+        # Every Go file needs to reference its package name
+        for target in self.target:
+            self.target[target] = f"package {self.golang_package_name}"
+
+    def visit_end(self) -> None:
+        del self.schema
+        self.target["enum"] += generate_content_from_dict(self.enums)
+
+    def visit_object_type(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        base: Optional[QAPISchemaObjectType],
+        members: List[QAPISchemaObjectTypeMember],
+        branches: Optional[QAPISchemaBranches],
+    ) -> None:
+        pass
+
+    def visit_alternate_type(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        variants: QAPISchemaVariants,
+    ) -> None:
+        pass
+
+    def visit_enum_type(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        members: List[QAPISchemaEnumMember],
+        prefix: Optional[str],
+    ) -> None:
+        assert name not in self.enums
+        doc = self.docmap.get(name, None)
+        maindoc, docfields = qapi_to_golang_struct_docs(doc)
+
+        # The logic below is to generate QAPI enums as blocks of Go consts
+        # each with its own type for type safety inside Go applications.
+        #
+        # Block of const() blocks are vertically indented so we have to
+        # first iterate over all names to calculate space between
+        # $var_name and $var_type. This is achieved by helper function
+        # @fetch_indent_blocks_over_enum_with_docs()
+        #
+        # A new indentation block is defined by empty line or a comment.
+
+        indent_block = iter(
+            fetch_indent_blocks_over_enum_with_docs(name, members, docfields)
+        )
+        maxname = next(indent_block)
+        fields = ""
+        for index, member in enumerate(members):
+            # For simplicity, every time we have doc, we go to next indent block
+            hasdoc = member.name is not None and member.name in docfields
+
+            if hasdoc:
+                maxname = next(indent_block)
+
+            enum_name = f"{name}{qapi_to_field_name_enum(member.name)}"
+            name2type = " " * (maxname - len(enum_name) + 1)
+
+            if hasdoc:
+                docstr = (
+                    textwrap.TextWrapper(width=80)
+                    .fill(docfields[member.name])
+                    .replace("\n", "\n\t// ")
+                )
+                fields += f"""\t// {docstr}\n"""
+
+            fields += f"""\t{enum_name}{name2type}{name} = "{member.name}"\n"""
+
+        self.enums[name] = TEMPLATE_ENUM.format(
+            maindoc=maindoc, name=name, fields=fields[:-1]
+        )
+
+    def visit_array_type(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        element_type: QAPISchemaType,
+    ) -> None:
+        pass
+
+    def visit_command(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        arg_type: Optional[QAPISchemaObjectType],
+        ret_type: Optional[QAPISchemaType],
+        gen: bool,
+        success_response: bool,
+        boxed: bool,
+        allow_oob: bool,
+        allow_preconfig: bool,
+        coroutine: bool,
+    ) -> None:
+        pass
+
+    def visit_event(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        arg_type: Optional[QAPISchemaObjectType],
+        boxed: bool,
+    ) -> None:
+        pass
+
+    def write(self, output_dir: str) -> None:
+        for module_name, content in self.target.items():
+            go_module = module_name + "s.go"
+            go_dir = "go"
+            pathname = os.path.join(output_dir, go_dir, go_module)
+            odir = os.path.dirname(pathname)
+            os.makedirs(odir, exist_ok=True)
+
+            with open(pathname, "w", encoding="utf8") as outfile:
+                outfile.write(content)
diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index 316736b6a2..f1f813b466 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -15,6 +15,7 @@
 from .common import must_match
 from .error import QAPIError
 from .events import gen_events
+from .golang import gen_golang
 from .introspect import gen_introspect
 from .schema import QAPISchema
 from .types import gen_types
@@ -54,6 +55,8 @@ def generate(schema_file: str,
     gen_events(schema, output_dir, prefix)
     gen_introspect(schema, output_dir, prefix, unmask)
 
+    gen_golang(schema, output_dir, prefix)
+
 
 def main() -> int:
     """
-- 
2.47.1


