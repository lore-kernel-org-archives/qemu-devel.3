Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4B4C021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 20:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj2K7-00043g-Lb; Fri, 14 Feb 2025 15:30:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2K6-00041h-13
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1tj2K3-0001lb-1R
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:30:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739565001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6xqYsVDH8oWpPyMWyIgRluzniD956Fyoitoj7hGAZ6g=;
 b=NZzJt339NpG1VuE6YMIrezkEMHQnUZpa+HP/RDxHeI7eIvAYGN8zvkJlboh3Wp2xRhe4L8
 tKHixpMMcZVQfkH9nElSW+GqYNVJrEmBK/nnhWq7ik9XJecFenodlJmCtyF6pLtlq07b3+
 6mOOReHbJhiB/GSmEHnUHLxCER8BIyk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-388-4pNR8iaUMoqsSa4XiRNFYw-1; Fri,
 14 Feb 2025 15:29:59 -0500
X-MC-Unique: 4pNR8iaUMoqsSa4XiRNFYw-1
X-Mimecast-MFC-AGG-ID: 4pNR8iaUMoqsSa4XiRNFYw_1739564998
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D514218004A7
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 20:29:58 +0000 (UTC)
Received: from tapioca.redhat.com (unknown [10.44.32.23])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9186A1800352; Fri, 14 Feb 2025 20:29:56 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Subject: [PATCH v4 02/11] qapi: golang: Generate enum type
Date: Fri, 14 Feb 2025 21:29:35 +0100
Message-ID: <20250214202944.69897-3-victortoso@redhat.com>
In-Reply-To: <20250214202944.69897-1-victortoso@redhat.com>
References: <20250214202944.69897-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
 scripts/qapi/golang/golang.py | 185 +++++++++++++++++++++++++++++++++-
 1 file changed, 183 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/golang/golang.py b/scripts/qapi/golang/golang.py
index 333741b47b..f074ec1f6f 100644
--- a/scripts/qapi/golang/golang.py
+++ b/scripts/qapi/golang/golang.py
@@ -13,7 +13,7 @@
 # Just for type hint on self
 from __future__ import annotations
 
-import os, shutil
+import os, shutil, textwrap
 from typing import List, Optional
 
 from ..schema import (
@@ -30,6 +30,65 @@
 )
 from ..source import QAPISourceInfo
 
+TEMPLATE_GENERATED_HEADER = """
+/*
+ * Copyright 2025 Red Hat, Inc.
+ * SPDX-License-Identifier: (MIT-0 and GPL-2.0-or-later)
+ */
+
+/****************************************************************************
+ * THIS CODE HAS BEEN GENERATED. DO NOT CHANGE IT DIRECTLY                  *
+ ****************************************************************************/
+package {package_name}
+"""
+
+TEMPLATE_GO_IMPORTS = """
+import (
+{imports}
+)
+"""
+
+TEMPLATE_ENUM = """
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
 
 def gen_golang(schema: QAPISchema, output_dir: str, prefix: str) -> None:
     vis = QAPISchemaGenGolangVisitor(prefix)
@@ -37,20 +96,90 @@ def gen_golang(schema: QAPISchema, output_dir: str, prefix: str) -> None:
     vis.write(output_dir)
 
 
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
+def generate_template_imports(words: List[str]) -> str:
+    if len(words) == 0:
+        return ""
+
+    if len(words) == 1:
+        return '\nimport "{words[0]}"\n'
+
+    return TEMPLATE_GO_IMPORTS.format(
+        imports="\n".join(f'\t"{w}"' for w in words)
+    )
+
+
 class QAPISchemaGenGolangVisitor(QAPISchemaVisitor):
     # pylint: disable=too-many-arguments
     def __init__(self, _: str):
         super().__init__()
         gofiles = ("protocol.go",)
+        # Map each qapi type to the necessary Go imports
+        types = {
+            "enum": [],
+        }
+
         self.schema: QAPISchema
         self.golang_package_name = "qapi"
         self.duplicate = list(gofiles)
+        self.enums: dict[str, str] = {}
+        self.docmap = {}
+
+        self.types = dict.fromkeys(types, "")
+        self.types_import = types
 
     def visit_begin(self, schema: QAPISchema) -> None:
         self.schema = schema
 
+        # iterate once in schema.docs to map doc objects to its name
+        for doc in schema.docs:
+            if doc.symbol is None:
+                continue
+            self.docmap[doc.symbol] = doc
+
+        for qapitype, imports in self.types_import.items():
+            self.types[qapitype] = TEMPLATE_GENERATED_HEADER[1:].format(
+                package_name=self.golang_package_name
+            )
+            self.types[qapitype] += generate_template_imports(imports)
+
     def visit_end(self) -> None:
         del self.schema
+        self.types["enum"] += generate_content_from_dict(self.enums)
 
     def visit_object_type(
         self,
@@ -83,7 +212,51 @@ def visit_enum_type(
         members: List[QAPISchemaEnumMember],
         prefix: Optional[str],
     ) -> None:
-        pass
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
+        if maindoc != "":
+            maindoc = f"\n{maindoc}"
+
+        self.enums[name] = maindoc + TEMPLATE_ENUM.format(
+            name=name, fields=fields[:-1]
+        )
 
     def visit_array_type(
         self,
@@ -133,3 +306,11 @@ def write(self, outdir: str) -> None:
             srcpath = os.path.join(srcdir, filename)
             dstpath = os.path.join(targetpath, filename)
             shutil.copyfile(srcpath, dstpath)
+
+        # Types to be generated
+        for qapitype, content in self.types.items():
+            gofile = f"gen_type_{qapitype}.go"
+            pathname = os.path.join(targetpath, gofile)
+
+            with open(pathname, "w", encoding="utf8") as outfile:
+                outfile.write(content)
-- 
2.48.1


