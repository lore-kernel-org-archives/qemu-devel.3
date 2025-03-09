Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070DBC282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 08:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trCA6-0004Yy-OB; Sun, 09 Mar 2025 04:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCA4-0004KK-SK
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCA2-0002UG-TB
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wa1Xi1ebmSpbrQKxKvSJI+EMuuyJ3SeCmG/4SFx/eQw=;
 b=DjfmK74Uz7wI2luWaAT4DuXkJjImQ3NPrWUU8GKp5mpjv5SNF1rPM8jBZ1Kt+8Po4y/Cqp
 D9ezLmDEry5CI+68wGMtTrCzvupz9uXoxJz/AGEQ7DtJV0KZqIv8bWW59VaMoDruktXjk5
 g1Sg8xFxmbKZZLzZpTgT1z580m10BmE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-KH2XqWSvMnehc6PDuAwCLw-1; Sun,
 09 Mar 2025 04:37:23 -0400
X-MC-Unique: KH2XqWSvMnehc6PDuAwCLw-1
X-Mimecast-MFC-AGG-ID: KH2XqWSvMnehc6PDuAwCLw_1741509441
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C741B1955D4B; Sun,  9 Mar 2025 08:37:21 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F240319560AB; Sun,  9 Mar 2025 08:37:18 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 35/62] docs/qapidoc: add transmogrifier stub
Date: Sun,  9 Mar 2025 04:35:22 -0400
Message-ID: <20250309083550.5155-36-jsnow@redhat.com>
In-Reply-To: <20250309083550.5155-1-jsnow@redhat.com>
References: <20250309083550.5155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

This commit adds a stubbed option to the qapi-doc directive that opts-in
to the new rST generator; the implementation of which will follow in
subsequent commits.

Once all QAPI documents have been converted, this option and the old
qapidoc implementation can be dropped.

Note that moving code outside of the try...except block has no impact
because the code moved outside of that block does not ever raise a
QAPIError.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index d622398f1da..dc72f3fd3f3 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -452,9 +452,9 @@ def _parse_text_into_node(self, doctext, node):
         rstlist.append("", self._cur_doc.info.fname, self._cur_doc.info.line)
         self._sphinx_directive.do_parse(rstlist, node)
 
-    def get_document_nodes(self):
-        """Return the list of docutils nodes which make up the document"""
-        return self._top_node.children
+    def get_document_node(self):
+        """Return the root docutils node which makes up the document"""
+        return self._top_node
 
 
 # Turn the black formatter on for the rest of the file.
@@ -503,7 +503,10 @@ class QAPIDocDirective(NestedDirective):
 
     required_argument = 1
     optional_arguments = 1
-    option_spec = {"qapifile": directives.unchanged_required}
+    option_spec = {
+        "qapifile": directives.unchanged_required,
+        "transmogrify": directives.flag,
+    }
     has_content = False
 
     def new_serialno(self):
@@ -511,10 +514,24 @@ def new_serialno(self):
         env = self.state.document.settings.env
         return "qapidoc-%d" % env.new_serialno("qapidoc")
 
+    def transmogrify(self, schema) -> nodes.Element:
+        raise NotImplementedError
+
+    def legacy(self, schema) -> nodes.Element:
+        vis = QAPISchemaGenRSTVisitor(self)
+        vis.visit_begin(schema)
+        for doc in schema.docs:
+            if doc.symbol:
+                vis.symbol(doc, schema.lookup_entity(doc.symbol))
+            else:
+                vis.freeform(doc)
+        return vis.get_document_node()
+
     def run(self):
         env = self.state.document.settings.env
         qapifile = env.config.qapidoc_srctree + "/" + self.arguments[0]
         qapidir = os.path.dirname(qapifile)
+        transmogrify = "transmogrify" in self.options
 
         try:
             schema = QAPISchema(qapifile)
@@ -522,20 +539,18 @@ def run(self):
             # First tell Sphinx about all the schema files that the
             # output documentation depends on (including 'qapifile' itself)
             schema.visit(QAPISchemaGenDepVisitor(env, qapidir))
-
-            vis = QAPISchemaGenRSTVisitor(self)
-            vis.visit_begin(schema)
-            for doc in schema.docs:
-                if doc.symbol:
-                    vis.symbol(doc, schema.lookup_entity(doc.symbol))
-                else:
-                    vis.freeform(doc)
-            return vis.get_document_nodes()
         except QAPIError as err:
             # Launder QAPI parse errors into Sphinx extension errors
             # so they are displayed nicely to the user
             raise ExtensionError(str(err)) from err
 
+        if transmogrify:
+            contentnode = self.transmogrify(schema)
+        else:
+            contentnode = self.legacy(schema)
+
+        return contentnode.children
+
 
 class QMPExample(CodeBlock, NestedDirective):
     """
-- 
2.48.1


