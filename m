Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00046C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxqh-0003Kd-Do; Tue, 11 Mar 2025 07:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqb-0003GD-OX
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxq9-0006Xl-O7
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pzFyQVQRfH5SjNpXcWSgUQALoCNim2tIphkpsxRmwME=;
 b=bgnsLbSgZ/pKMmeA0yf+0uzKCQIv60ra5p4jeFxGX3hJM2J46GVT89xRk3ja+UupxWvSmL
 P+WfeTPRK9nMAH0xKQacW2F0sHOHWHOWzX7pu5ZGfMMebwCWgs6t8yjBnxUzCwrO0aRmkb
 v9tI5lxhNXRzH4echD6Wjbmo4vR4OLo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-uvpq259IPfmeoyaZFMrYdQ-1; Tue,
 11 Mar 2025 07:31:59 -0400
X-MC-Unique: uvpq259IPfmeoyaZFMrYdQ-1
X-Mimecast-MFC-AGG-ID: uvpq259IPfmeoyaZFMrYdQ_1741692718
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B04519560BB
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0AA9C19560AB
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 82AFA21E60DA; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 51/61] docs/qapidoc: implement transmogrify() method
Date: Tue, 11 Mar 2025 12:31:27 +0100
Message-ID: <20250311113137.1277125-52-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

This is the true top-level processor for the new transmogrifier;
responsible both for generating the intermediate rST and then running
the nested parse on that generated document to produce the final
docutils tree that is then - very finally - postprocessed by sphinx for
final rendering to HTML &c.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-55-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
[Use the opportunity to move the __version__ assignment to where
PEP 8 wants it]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 49 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index aaf5b6e22b..a0016f8853 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -2,6 +2,7 @@
 #
 # QEMU qapidoc QAPI file parsing extension
 #
+# Copyright (c) 2024-2025 Red Hat
 # Copyright (c) 2020 Linaro
 #
 # This work is licensed under the terms of the GNU GPLv2 or later.
@@ -26,6 +27,8 @@
 
 from __future__ import annotations
 
+__version__ = "2.0"
+
 from contextlib import contextmanager
 import os
 from pathlib import Path
@@ -56,6 +59,7 @@
 from sphinx import addnodes
 from sphinx.directives.code import CodeBlock
 from sphinx.errors import ExtensionError
+from sphinx.util import logging
 from sphinx.util.docutils import switch_source_input
 from sphinx.util.nodes import nested_parse_with_titles
 
@@ -74,7 +78,7 @@
     from sphinx.util.typing import ExtensionMetadata
 
 
-__version__ = "1.0"
+logger = logging.getLogger(__name__)
 
 
 class Transmogrifier:
@@ -95,6 +99,10 @@ def __init__(self) -> None:
         self._result = StringList()
         self.indent = 0
 
+    @property
+    def result(self) -> StringList:
+        return self._result
+
     @property
     def entity(self) -> QAPISchemaDefinition:
         assert self._curr_ent is not None
@@ -438,7 +446,43 @@ def new_serialno(self) -> str:
         return "qapidoc-%d" % env.new_serialno("qapidoc")
 
     def transmogrify(self, schema: QAPISchema) -> nodes.Element:
-        raise NotImplementedError
+        logger.info("Transmogrifying QAPI to rST ...")
+        vis = Transmogrifier()
+        modules = set()
+
+        for doc in schema.docs:
+            module_source = doc.info.fname
+            if module_source not in modules:
+                vis.visit_module(module_source)
+                modules.add(module_source)
+
+            if doc.symbol:
+                ent = schema.lookup_entity(doc.symbol)
+                assert isinstance(ent, QAPISchemaDefinition)
+                vis.visit_entity(ent)
+            else:
+                vis.visit_freeform(doc)
+
+        logger.info("Transmogrification complete.")
+
+        contentnode = nodes.section()
+        content = vis.result
+        titles_allowed = True
+
+        logger.info("Transmogrifier running nested parse ...")
+        with switch_source_input(self.state, content):
+            if titles_allowed:
+                node: nodes.Element = nodes.section()
+                node.document = self.state.document
+                nested_parse_with_titles(self.state, content, contentnode)
+            else:
+                node = nodes.paragraph()
+                node.document = self.state.document
+                self.state.nested_parse(content, 0, contentnode)
+        logger.info("Transmogrifier's nested parse completed.")
+        sys.stdout.flush()
+
+        return contentnode
 
     def legacy(self, schema: QAPISchema) -> nodes.Element:
         vis = QAPISchemaGenRSTVisitor(self)
@@ -572,6 +616,7 @@ def run(self) -> List[nodes.Node]:
 
 def setup(app: Sphinx) -> ExtensionMetadata:
     """Register qapi-doc directive with Sphinx"""
+    app.setup_extension("qapi_domain")
     app.add_config_value("qapidoc_srctree", None, "env")
     app.add_directive("qapi-doc", QAPIDocDirective)
     app.add_directive("qmp-example", QMPExample)
-- 
2.48.1


