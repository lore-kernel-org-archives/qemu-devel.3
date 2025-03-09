Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52078C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 08:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trCBf-0001R0-7N; Sun, 09 Mar 2025 04:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCAx-00086S-CC
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:38:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCAv-0002eM-H0
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OVYAL60gi2ROVrfD7P/TDHp9/H0tEV50ASuP/ZU8PAQ=;
 b=N7mR2cmq5TqBLdoDpxe+mK/hcyuVd/+a0rafDljgWJXzymeim96LG/m2PWxJmmJQYI30pO
 xgcSv3GbFJFvmEg576AFESYUjaj3kbpLllHkFdpPzKLkSyNCw+uc5DxDPM8dZ1NFnQq7Vb
 xvmfc6mhjtbo2vkdAMJ3c7Zg96uoHeM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-psMoBfzoMwOV1h1J4lFtog-1; Sun,
 09 Mar 2025 04:38:16 -0400
X-MC-Unique: psMoBfzoMwOV1h1J4lFtog-1
X-Mimecast-MFC-AGG-ID: psMoBfzoMwOV1h1J4lFtog_1741509495
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9781B1955D66; Sun,  9 Mar 2025 08:38:15 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8621219560AB; Sun,  9 Mar 2025 08:38:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 56/62] docs/qapidoc: add intermediate output debugger
Date: Sun,  9 Mar 2025 04:35:43 -0400
Message-ID: <20250309083550.5155-57-jsnow@redhat.com>
In-Reply-To: <20250309083550.5155-1-jsnow@redhat.com>
References: <20250309083550.5155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add debugging output for the qapidoc transmogrifier - setting DEBUG=1
will produce .ir files (one for each qapidoc directive) that write the
generated rst file to disk to allow for easy debugging and verification
of the generated document.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 43091b1fabc..e8719fac4c1 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -37,7 +37,7 @@
 from typing import TYPE_CHECKING
 
 from docutils import nodes
-from docutils.parsers.rst import Directive, directives
+from docutils.parsers.rst import directives
 from docutils.statemachine import StringList
 from qapi.error import QAPIError
 from qapi.parser import QAPIDoc
@@ -60,7 +60,7 @@
 from sphinx.directives.code import CodeBlock
 from sphinx.errors import ExtensionError
 from sphinx.util import logging
-from sphinx.util.docutils import switch_source_input
+from sphinx.util.docutils import SphinxDirective, switch_source_input
 from sphinx.util.nodes import nested_parse_with_titles
 
 
@@ -422,7 +422,7 @@ def visit_module(self, name: str) -> None:
         super().visit_module(name)
 
 
-class NestedDirective(Directive):
+class NestedDirective(SphinxDirective):
     def run(self) -> Sequence[nodes.Node]:
         raise NotImplementedError
 
@@ -491,10 +491,43 @@ def transmogrify(self, schema: QAPISchema) -> nodes.Element:
                 node.document = self.state.document
                 self.state.nested_parse(content, 0, contentnode)
         logger.info("Transmogrifier's nested parse completed.")
+
+        if self.env.app.verbosity >= 2 or os.environ.get("DEBUG"):
+            argname = "_".join(Path(self.arguments[0]).parts)
+            name = Path(argname).stem + ".ir"
+            self.write_intermediate(content, name)
+
         sys.stdout.flush()
-
         return contentnode
 
+    def write_intermediate(self, content: StringList, filename: str) -> None:
+        logger.info(
+            "writing intermediate rST for '%s' to '%s'",
+            self.arguments[0],
+            filename,
+        )
+
+        srctree = Path(self.env.app.config.qapidoc_srctree).resolve()
+        outlines = []
+        lcol_width = 0
+
+        for i, line in enumerate(content):
+            src, lineno = content.info(i)
+            srcpath = Path(src).resolve()
+            srcpath = srcpath.relative_to(srctree)
+
+            lcol = f"{srcpath}:{lineno:04d}"
+            lcol_width = max(lcol_width, len(lcol))
+            outlines.append((lcol, line))
+
+        with open(filename, "w", encoding="UTF-8") as outfile:
+            for lcol, rcol in outlines:
+                outfile.write(lcol.rjust(lcol_width))
+                outfile.write(" |")
+                if rcol:
+                    outfile.write(f" {rcol}")
+                outfile.write("\n")
+
     def legacy(self, schema: QAPISchema) -> nodes.Element:
         vis = QAPISchemaGenRSTVisitor(self)
         vis.visit_begin(schema)
-- 
2.48.1


