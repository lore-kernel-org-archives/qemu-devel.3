Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6205C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 08:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trCAI-0005Wn-C2; Sun, 09 Mar 2025 04:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCAA-00052b-TP
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCA8-0002VD-My
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNqDpq0iJIveYhg6oQ1eKKTueZtlSKNrRW9Qrz0iOMU=;
 b=TXMnbWWSStwXyc8yBeXzNwMK0PrDqHWtmK0jv2KNdpUDyV+6ylCwKxjzsTPOBzRbXSN9YI
 Nlbbx3t9zwwflCassdniO9riCKpBdfhMLmRNvD4Q+yPWmRCJ9am/y4e+eBjam/i2wTgwis
 30W26o06qJpnNCIbSOWIroHG+ceJpCY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624--58jPyFTNzOZX0s-yWCh-w-1; Sun,
 09 Mar 2025 04:37:28 -0400
X-MC-Unique: -58jPyFTNzOZX0s-yWCh-w-1
X-Mimecast-MFC-AGG-ID: -58jPyFTNzOZX0s-yWCh-w_1741509447
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B01FE1800257; Sun,  9 Mar 2025 08:37:27 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC8CB19560AB; Sun,  9 Mar 2025 08:37:25 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 37/62] docs/qapidoc: Fix static typing on qapidoc.py
Date: Sun,  9 Mar 2025 04:35:24 -0400
Message-ID: <20250309083550.5155-38-jsnow@redhat.com>
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

Now that the legacy code is factored out, fix up the typing on the
remaining code in qapidoc.py. Add a type ignore to qapi_legacy.py to
prevent the errors there from bleeding out into qapidoc.py.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py        | 40 ++++++++++++++++++++++-------------
 docs/sphinx/qapidoc_legacy.py |  1 +
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index f4abf42e7bf..5246832b68c 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -24,17 +24,18 @@
 https://www.sphinx-doc.org/en/master/development/index.html
 """
 
+from __future__ import annotations
+
 import os
 import sys
-from typing import List
+from typing import TYPE_CHECKING
 
 from docutils import nodes
 from docutils.parsers.rst import Directive, directives
 from qapi.error import QAPIError
-from qapi.gen import QAPISchemaVisitor
-from qapi.schema import QAPISchema
+from qapi.schema import QAPISchema, QAPISchemaVisitor
 
-from qapidoc_legacy import QAPISchemaGenRSTVisitor
+from qapidoc_legacy import QAPISchemaGenRSTVisitor  # type: ignore
 from sphinx import addnodes
 from sphinx.directives.code import CodeBlock
 from sphinx.errors import ExtensionError
@@ -42,6 +43,15 @@
 from sphinx.util.nodes import nested_parse_with_titles
 
 
+if TYPE_CHECKING:
+    from typing import Any, List, Sequence
+
+    from docutils.statemachine import StringList
+
+    from sphinx.application import Sphinx
+    from sphinx.util.typing import ExtensionMetadata
+
+
 __version__ = "1.0"
 
 
@@ -53,11 +63,11 @@ class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
     schema file associated with each module in the QAPI input.
     """
 
-    def __init__(self, env, qapidir):
+    def __init__(self, env: Any, qapidir: str) -> None:
         self._env = env
         self._qapidir = qapidir
 
-    def visit_module(self, name):
+    def visit_module(self, name: str) -> None:
         if name != "./builtin":
             qapifile = self._qapidir + "/" + name
             self._env.note_dependency(os.path.abspath(qapifile))
@@ -65,10 +75,10 @@ def visit_module(self, name):
 
 
 class NestedDirective(Directive):
-    def run(self):
+    def run(self) -> Sequence[nodes.Node]:
         raise NotImplementedError
 
-    def do_parse(self, rstlist, node):
+    def do_parse(self, rstlist: StringList, node: nodes.Node) -> None:
         """
         Parse rST source lines and add them to the specified node
 
@@ -93,15 +103,15 @@ class QAPIDocDirective(NestedDirective):
     }
     has_content = False
 
-    def new_serialno(self):
+    def new_serialno(self) -> str:
         """Return a unique new ID string suitable for use as a node's ID"""
         env = self.state.document.settings.env
         return "qapidoc-%d" % env.new_serialno("qapidoc")
 
-    def transmogrify(self, schema) -> nodes.Element:
+    def transmogrify(self, schema: QAPISchema) -> nodes.Element:
         raise NotImplementedError
 
-    def legacy(self, schema) -> nodes.Element:
+    def legacy(self, schema: QAPISchema) -> nodes.Element:
         vis = QAPISchemaGenRSTVisitor(self)
         vis.visit_begin(schema)
         for doc in schema.docs:
@@ -109,9 +119,9 @@ def legacy(self, schema) -> nodes.Element:
                 vis.symbol(doc, schema.lookup_entity(doc.symbol))
             else:
                 vis.freeform(doc)
-        return vis.get_document_node()
+        return vis.get_document_node()  # type: ignore
 
-    def run(self):
+    def run(self) -> Sequence[nodes.Node]:
         env = self.state.document.settings.env
         qapifile = env.config.qapidoc_srctree + "/" + self.arguments[0]
         qapidir = os.path.dirname(qapifile)
@@ -185,7 +195,7 @@ def _highlightlang(self) -> addnodes.highlightlang:
         )
         return node
 
-    def admonition_wrap(self, *content) -> List[nodes.Node]:
+    def admonition_wrap(self, *content: nodes.Node) -> List[nodes.Node]:
         title = "Example:"
         if "title" in self.options:
             title = f"{title} {self.options['title']}"
@@ -231,7 +241,7 @@ def run(self) -> List[nodes.Node]:
         return self.admonition_wrap(*content_nodes)
 
 
-def setup(app):
+def setup(app: Sphinx) -> ExtensionMetadata:
     """Register qapi-doc directive with Sphinx"""
     app.add_config_value("qapidoc_srctree", None, "env")
     app.add_directive("qapi-doc", QAPIDocDirective)
diff --git a/docs/sphinx/qapidoc_legacy.py b/docs/sphinx/qapidoc_legacy.py
index 679f38356b1..13520f4c26b 100644
--- a/docs/sphinx/qapidoc_legacy.py
+++ b/docs/sphinx/qapidoc_legacy.py
@@ -1,4 +1,5 @@
 # coding=utf-8
+# type: ignore
 #
 # QEMU qapidoc QAPI file parsing extension
 #
-- 
2.48.1


