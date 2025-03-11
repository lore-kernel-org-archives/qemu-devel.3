Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B746C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 03:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqaC-0003Hc-1a; Mon, 10 Mar 2025 23:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqZQ-0000NJ-To
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:46:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqZO-0002nY-Mb
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741664777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LJ4pydQtkhnjdiiSMVnmJ2Ab8Zbe4sSqS2QdibscKM=;
 b=II70HEM/DsKpGxFUihVIR817q/f+cguH7Mgz2/3ag/E6E0TxgAu9bxI4vn5jRrRQzFigXE
 h5hYnEC9cJd8UdF9Kb71JHs5kgXGvXo+QI8461FbnOrPqBAWv6pva8Tz25AeuLfjymqhNN
 J09IqBA360lLXX+bSUauCH2NE9x8tfs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-RhJNTQ-GMsq0f-1hGh1kWA-1; Mon,
 10 Mar 2025 23:46:15 -0400
X-MC-Unique: RhJNTQ-GMsq0f-1hGh1kWA-1
X-Mimecast-MFC-AGG-ID: RhJNTQ-GMsq0f-1hGh1kWA_1741664774
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C793419560B0; Tue, 11 Mar 2025 03:46:14 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6533A1800366; Tue, 11 Mar 2025 03:46:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 54/63] docs/qapidoc: implement transmogrify() method
Date: Mon, 10 Mar 2025 23:42:52 -0400
Message-ID: <20250311034303.75779-55-jsnow@redhat.com>
In-Reply-To: <20250311034303.75779-1-jsnow@redhat.com>
References: <20250311034303.75779-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This is the true top-level processor for the new transmogrifier;
responsible both for generating the intermediate rST and then running
the nested parse on that generated document to produce the final
docutils tree that is then - very finally - postprocessed by sphinx for
final rendering to HTML &c.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 49 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index aaf5b6e22bc..32baf66a390 100644
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
@@ -56,6 +57,7 @@
 from sphinx import addnodes
 from sphinx.directives.code import CodeBlock
 from sphinx.errors import ExtensionError
+from sphinx.util import logging
 from sphinx.util.docutils import switch_source_input
 from sphinx.util.nodes import nested_parse_with_titles
 
@@ -74,7 +76,9 @@
     from sphinx.util.typing import ExtensionMetadata
 
 
-__version__ = "1.0"
+__version__ = "2.0"
+
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


