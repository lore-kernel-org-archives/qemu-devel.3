Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53276C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 21:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP77Q-0000hg-7j; Wed, 03 Jul 2024 17:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP77O-0000hJ-Lf
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 17:02:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP77N-0000S0-0I
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 17:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720040540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yjCSx2xXZa2imboFxKPWgPHy6sZtgdQlYu7Dkui4UnQ=;
 b=dhXpDxQEL4L7Ib5/D8IspCnKQocHpvLymNtpfgJZzCeziSj3OLoCUIcQMyfvOOmeC4I3Ho
 nNBCuZNQdPn7oT1e8ydiPMunf2qIWqxKueRLBd5vpXGsJItQvdcuHrZjTLAoXMI5I7J7x0
 BvAxdfw2+zmL1VBNF5TQNai9+lkJOZg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-m6tCTfLVNk6e7JdkMKK5bA-1; Wed,
 03 Jul 2024 17:02:16 -0400
X-MC-Unique: m6tCTfLVNk6e7JdkMKK5bA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EC4B1955F69; Wed,  3 Jul 2024 21:02:14 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.34.31])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B55FC1955F22; Wed,  3 Jul 2024 21:02:07 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Hanna Reitz <hreitz@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Jiri Pirko <jiri@resnulli.us>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 3/8] docs/qapidoc: add QMP highlighting to annotated
 qmp-example blocks
Date: Wed,  3 Jul 2024 17:01:38 -0400
Message-ID: <20240703210144.339530-4-jsnow@redhat.com>
In-Reply-To: <20240703210144.339530-1-jsnow@redhat.com>
References: <20240703210144.339530-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For any code literal blocks inside of a qmp-example directive, apply and
enforce the QMP lexer/highlighter to those blocks.

This way, you won't need to write:

```
.. qmp-example::
   :annotated:

   Blah blah

   .. code-block:: QMP

      -> { "lorem": "ipsum" }
```

But instead, simply:

```
.. qmp-example::
   :annotated:

   Blah blah::

     -> { "lorem": "ipsum" }
```

Once the directive block is exited, whatever the previous default
highlight language was will be restored; localizing the forced QMP
lexing to exclusively this directive.

Note, if the default language is *already* QMP, this directive will not
generate and restore redundant highlight configuration nodes. We may
well decide that the default language ought to be QMP for any QAPI
reference pages, but this way the directive behaves consistently no
matter where it is used.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 53 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index b0f3917dc5b..fb2b23698a0 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -26,6 +26,7 @@
 
 import os
 import re
+import sys
 import textwrap
 from typing import List
 
@@ -37,6 +38,7 @@
 from qapi.schema import QAPISchema
 
 import sphinx
+from sphinx import addnodes
 from sphinx.directives.code import CodeBlock
 from sphinx.errors import ExtensionError
 from sphinx.util.nodes import nested_parse_with_titles
@@ -574,10 +576,10 @@ class QMPExample(CodeBlock, NestedDirective):
     Custom admonition for QMP code examples.
 
     When the :annotated: option is present, the body of this directive
-    is parsed as normal rST instead. Code blocks must be explicitly
-    written by the user, but this allows for intermingling explanatory
-    paragraphs with arbitrary rST syntax and code blocks for more
-    involved examples.
+    is parsed as normal rST, but with any '::' code blocks set to use
+    the QMP lexer. Code blocks must be explicitly written by the user,
+    but this allows for intermingling explanatory paragraphs with
+    arbitrary rST syntax and code blocks for more involved examples.
 
     When :annotated: is absent, the directive body is treated as a
     simple standalone QMP code block literal.
@@ -591,6 +593,33 @@ class QMPExample(CodeBlock, NestedDirective):
         "title": directives.unchanged,
     }
 
+    def _highlightlang(self) -> addnodes.highlightlang:
+        """Return the current highlightlang setting for the document"""
+        node = None
+        doc = self.state.document
+
+        if hasattr(doc, "findall"):
+            # docutils >= 0.18.1
+            for node in doc.findall(addnodes.highlightlang):
+                pass
+        else:
+            for elem in doc.traverse():
+                if isinstance(elem, addnodes.highlightlang):
+                    node = elem
+
+        if node:
+            return node
+
+        # No explicit directive found, use defaults
+        node = addnodes.highlightlang(
+            lang=self.env.config.highlight_language,
+            force=False,
+            # Yes, Sphinx uses this value to effectively disable line
+            # numbers and not 0 or None or -1 or something. ¯\_(ツ)_/¯
+            linenothreshold=sys.maxsize,
+        )
+        return node
+
     def admonition_wrap(self, *content) -> List[nodes.Node]:
         title = "Example:"
         if "title" in self.options:
@@ -605,8 +634,24 @@ def admonition_wrap(self, *content) -> List[nodes.Node]:
         return [admon]
 
     def run_annotated(self) -> List[nodes.Node]:
+        lang_node = self._highlightlang()
+
         content_node: nodes.Element = nodes.section()
+
+        # Configure QMP highlighting for "::" blocks, if needed
+        if lang_node["lang"] != "QMP":
+            content_node += addnodes.highlightlang(
+                lang="QMP",
+                force=False,  # "True" ignores lexing errors
+                linenothreshold=lang_node["linenothreshold"],
+            )
+
         self.do_parse(self.content, content_node)
+
+        # Restore prior language highlighting, if needed
+        if lang_node["lang"] != "QMP":
+            content_node += addnodes.highlightlang(**lang_node.attributes)
+
         return content_node.children
 
     def run(self) -> List[nodes.Node]:
-- 
2.45.0


