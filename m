Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA536C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 07:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPzmZ-0006uy-Af; Sat, 06 Jul 2024 03:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sPzmY-0006ua-A3
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 03:24:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sPzmV-0004Z0-1j
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 03:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720250664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ka1O4zAvVaqZMyAsxyXPzxgXPaGB4GQuNtcrhi84Hkc=;
 b=GpHtH0vfx1lXFTjA6Qbg7IXivwMr/qELYO65WpQqIYL6+80f6U/1FkhgIq1IgxMWFFwZAJ
 9Pqmrf0DGIDPHSKUtTMgehNXwr+E14M61rJSQkJxJjqqIgk9MmasO0N4GQV1yKn3sgTwrg
 /qo1kLTnDqBu20nIe/67zaPqBHK3LNI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-4xP267gIPPy6V9azomxqaA-1; Sat,
 06 Jul 2024 03:24:20 -0400
X-MC-Unique: 4xP267gIPPy6V9azomxqaA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D7F519560AB; Sat,  6 Jul 2024 07:24:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA69E1955E80; Sat,  6 Jul 2024 07:24:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E8E321EC369; Sat,  6 Jul 2024 09:24:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 03/13] docs/qapidoc: delint a tiny portion of the module
Date: Sat,  6 Jul 2024 09:24:06 +0200
Message-ID: <20240706072416.1717485-4-armbru@redhat.com>
In-Reply-To: <20240706072416.1717485-1-armbru@redhat.com>
References: <20240706072416.1717485-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In a forthcoming series that adds a new QMP documentation generator, it
will be helpful to have a linting baseline. However, there's no need to
shuffle around the deck chairs too much, because most of this code will
be removed once that new qapidoc generator (the "transmogrifier") is in
place.

To ease my pain: just turn off the black auto-formatter for most, but
not all, of qapidoc.py. This will help ensure that *new* code follows a
coding standard without bothering too much with cleaning up the existing
code.

Code that I intend to keep is still subject to the delinting beam.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240626222128.406106-5-jsnow@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 62 +++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 3c0565d0ce..659e507353 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -28,26 +28,33 @@
 import re
 
 from docutils import nodes
+from docutils.parsers.rst import Directive, directives
 from docutils.statemachine import ViewList
-from docutils.parsers.rst import directives, Directive
+from qapi.error import QAPIError, QAPISemError
+from qapi.gen import QAPISchemaVisitor
+from qapi.schema import QAPISchema
+
+import sphinx
 from sphinx.errors import ExtensionError
 from sphinx.util.nodes import nested_parse_with_titles
-import sphinx
-from qapi.gen import QAPISchemaVisitor
-from qapi.error import QAPIError, QAPISemError
-from qapi.schema import QAPISchema
 
 
 # Sphinx up to 1.6 uses AutodocReporter; 1.7 and later
 # use switch_source_input. Check borrowed from kerneldoc.py.
-Use_SSI = sphinx.__version__[:3] >= '1.7'
-if Use_SSI:
+USE_SSI = sphinx.__version__[:3] >= "1.7"
+if USE_SSI:
     from sphinx.util.docutils import switch_source_input
 else:
-    from sphinx.ext.autodoc import AutodocReporter
+    from sphinx.ext.autodoc import (  # pylint: disable=no-name-in-module
+        AutodocReporter,
+    )
 
 
-__version__ = '1.0'
+__version__ = "1.0"
+
+
+# Disable black auto-formatter until re-enabled:
+# fmt: off
 
 
 class QAPISchemaGenRSTVisitor(QAPISchemaVisitor):
@@ -441,6 +448,10 @@ def get_document_nodes(self):
         return self._top_node.children
 
 
+# Turn the black formatter on for the rest of the file.
+# fmt: on
+
+
 class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
     """A QAPI schema visitor which adds Sphinx dependencies each module
 
@@ -448,34 +459,34 @@ class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
     that the generated documentation output depends on the input
     schema file associated with each module in the QAPI input.
     """
+
     def __init__(self, env, qapidir):
         self._env = env
         self._qapidir = qapidir
 
     def visit_module(self, name):
         if name != "./builtin":
-            qapifile = self._qapidir + '/' + name
+            qapifile = self._qapidir + "/" + name
             self._env.note_dependency(os.path.abspath(qapifile))
         super().visit_module(name)
 
 
 class QAPIDocDirective(Directive):
     """Extract documentation from the specified QAPI .json file"""
+
     required_argument = 1
     optional_arguments = 1
-    option_spec = {
-        'qapifile': directives.unchanged_required
-    }
+    option_spec = {"qapifile": directives.unchanged_required}
     has_content = False
 
     def new_serialno(self):
         """Return a unique new ID string suitable for use as a node's ID"""
         env = self.state.document.settings.env
-        return 'qapidoc-%d' % env.new_serialno('qapidoc')
+        return "qapidoc-%d" % env.new_serialno("qapidoc")
 
     def run(self):
         env = self.state.document.settings.env
-        qapifile = env.config.qapidoc_srctree + '/' + self.arguments[0]
+        qapifile = env.config.qapidoc_srctree + "/" + self.arguments[0]
         qapidir = os.path.dirname(qapifile)
 
         try:
@@ -513,13 +524,14 @@ def do_parse(self, rstlist, node):
         # plain self.state.nested_parse(), and so we can drop the saving
         # of title_styles and section_level that kerneldoc.py does,
         # because nested_parse_with_titles() does that for us.
-        if Use_SSI:
+        if USE_SSI:
             with switch_source_input(self.state, rstlist):
                 nested_parse_with_titles(self.state, rstlist, node)
         else:
             save = self.state.memo.reporter
             self.state.memo.reporter = AutodocReporter(
-                rstlist, self.state.memo.reporter)
+                rstlist, self.state.memo.reporter
+            )
             try:
                 nested_parse_with_titles(self.state, rstlist, node)
             finally:
@@ -527,12 +539,12 @@ def do_parse(self, rstlist, node):
 
 
 def setup(app):
-    """ Register qapi-doc directive with Sphinx"""
-    app.add_config_value('qapidoc_srctree', None, 'env')
-    app.add_directive('qapi-doc', QAPIDocDirective)
+    """Register qapi-doc directive with Sphinx"""
+    app.add_config_value("qapidoc_srctree", None, "env")
+    app.add_directive("qapi-doc", QAPIDocDirective)
 
-    return dict(
-        version=__version__,
-        parallel_read_safe=True,
-        parallel_write_safe=True
-    )
+    return {
+        "version": __version__,
+        "parallel_read_safe": True,
+        "parallel_write_safe": True,
+    }
-- 
2.45.0


