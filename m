Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889DBC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxrA-0003Yl-0M; Tue, 11 Mar 2025 07:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxql-0003MF-KR
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqA-0006Ws-Is
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wdCg+UoySTQdVH0vu4je4tNL8ddS1AXyxvzLsqmoOZw=;
 b=ap4GuyYaxb55OYUR3rAGxXCCpED2m0sg/q7h9MTKuu7ppgnKEuLD1LP+Bgts1H39TYN8zz
 Ve+uTgWYDaiNXSnabi8Owx2BW4vXR48zEWBLmNF6Uu5jdVt6mQra/GJM5gkh7BXw6Yp9oJ
 f1HbN7vh6NwOPLFzYfhqVSLx1odllpY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-65dVc_BdPxSCSb8RGiXZfQ-1; Tue,
 11 Mar 2025 07:31:58 -0400
X-MC-Unique: 65dVc_BdPxSCSb8RGiXZfQ-1
X-Mimecast-MFC-AGG-ID: 65dVc_BdPxSCSb8RGiXZfQ_1741692718
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D643B195608B
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7158C1828A99
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8A28A21E60DE; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 53/61] docs/qapidoc: add intermediate output debugger
Date: Tue, 11 Mar 2025 12:31:29 +0100
Message-ID: <20250311113137.1277125-54-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Snow <jsnow@redhat.com>

Add debugging output for the qapidoc transmogrifier - setting DEBUG=1
will produce .ir files (one for each qapidoc directive) that write the
generated rst file to disk to allow for easy debugging and verification
of the generated document.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-57-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index ebdf709594..8ddebf73f2 100644
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
 
 
@@ -414,7 +414,7 @@ def visit_module(self, name: str) -> None:
         super().visit_module(name)
 
 
-class NestedDirective(Directive):
+class NestedDirective(SphinxDirective):
     def run(self) -> Sequence[nodes.Node]:
         raise NotImplementedError
 
@@ -483,10 +483,43 @@ def transmogrify(self, schema: QAPISchema) -> nodes.Element:
                 node.document = self.state.document
                 self.state.nested_parse(content, 0, contentnode)
         logger.info("Transmogrifier's nested parse completed.")
-        sys.stdout.flush()
 
+        if self.env.app.verbosity >= 2 or os.environ.get("DEBUG"):
+            argname = "_".join(Path(self.arguments[0]).parts)
+            name = Path(argname).stem + ".ir"
+            self.write_intermediate(content, name)
+
+        sys.stdout.flush()
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


