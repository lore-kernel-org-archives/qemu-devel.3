Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC10AC2BA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 00:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJjEC-0006E4-4I; Tue, 18 Jun 2024 20:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJjEA-0006DG-JU
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 20:31:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJjE8-0001Np-Sv
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 20:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718757064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=951Fu4K97h2hTiTUEle9YH03T13J0kCtQXeDDdNZL4Q=;
 b=g/E4PKknVkjTbZQCCKsS/manLb/JQzH7nfa0frou4EWgzWBGMAya4ncYPN1qTfVLNJZbYv
 P0TUjzftRDpqt7Zacp5DPZmjmKQ7BOVuuicV7vX21jKa8AfHczbai1u/UJpbWW7P6iwMb+
 gaOYIIhSEGuxgQBPbA68h1aicXUS5zE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-fn-I_8ZLNXeSUb3stJLofw-1; Tue,
 18 Jun 2024 20:30:59 -0400
X-MC-Unique: fn-I_8ZLNXeSUb3stJLofw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 402F619560B4; Wed, 19 Jun 2024 00:30:57 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.16.38])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B52261956087; Wed, 19 Jun 2024 00:30:49 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Lukas Straub <lukasstraub2@web.de>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Jiri Pirko <jiri@resnulli.us>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 03/13] docs/qapidoc: delint a tiny portion of the module
Date: Tue, 18 Jun 2024 20:30:02 -0400
Message-ID: <20240619003012.1753577-4-jsnow@redhat.com>
In-Reply-To: <20240619003012.1753577-1-jsnow@redhat.com>
References: <20240619003012.1753577-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
---
 docs/sphinx/qapidoc.py | 66 +++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index f270b494f01..e675966defa 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -28,33 +28,42 @@
 import re
 
 from docutils import nodes
+from docutils.parsers.rst import Directive, directives
 from docutils.statemachine import ViewList
-from docutils.parsers.rst import directives, Directive
-from sphinx.errors import ExtensionError
-from sphinx.util.nodes import nested_parse_with_titles
-import sphinx
-from qapi.gen import QAPISchemaVisitor
 from qapi.error import QAPIError, QAPISemError
+from qapi.gen import QAPISchemaVisitor
 from qapi.schema import QAPISchema
 
+import sphinx
+from sphinx.errors import ExtensionError
+from sphinx.util.nodes import nested_parse_with_titles
+
 
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
 
 
+# Disable black auto-formatter until re-enabled:
+# fmt: off
+
 # Function borrowed from pydash, which is under the MIT license
 def intersperse(iterable, separator):
     """Yield the members of *iterable* interspersed with *separator*."""
     iterable = iter(iterable)
-    yield next(iterable)
+    try:
+        yield next(iterable)
+    except StopIteration:
+        return
     for item in iterable:
         yield separator
         yield item
@@ -451,6 +460,10 @@ def get_document_nodes(self):
         return self._top_node.children
 
 
+# Turn the black formatter on for the rest of the file.
+# fmt: on
+
+
 class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
     """A QAPI schema visitor which adds Sphinx dependencies each module
 
@@ -458,34 +471,34 @@ class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
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
@@ -523,13 +536,14 @@ def do_parse(self, rstlist, node):
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
@@ -537,12 +551,12 @@ def do_parse(self, rstlist, node):
 
 
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
2.44.0


