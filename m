Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8DDC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 22:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMb49-0000Fp-Q2; Wed, 26 Jun 2024 18:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMb3a-0007d3-8h
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 18:24:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMb3X-0002rl-R7
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 18:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719440636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GNSWdN9cWTKZDPj5/a/oNtSmKd3EdNCt0RiP98EW2Y4=;
 b=Ol+U1lOq2VF/jJ4eqW0XUXSF9dP9JJSV/GQDw9JRJu+tj8WL+3jmR4OSSZ9ay4j3b0wjgJ
 Fd83nYozJ0eoykyCePqvliTI9/da1mfAf9H1F+UV5k9jVbmG2VE5GzhY4Y/56T0FSEmHss
 iVPilBMbx3Voyru3EOV+/MSUwIQDwUg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-FMFYq9CsOOu1LrRPIbBy2Q-1; Wed,
 26 Jun 2024 18:23:52 -0400
X-MC-Unique: FMFYq9CsOOu1LrRPIbBy2Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99D8A19560AB; Wed, 26 Jun 2024 22:23:46 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.67])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 478BE1955F2D; Wed, 26 Jun 2024 22:23:38 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Jiri Pirko <jiri@resnulli.us>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 15/21] docs/qapidoc: create qmp-example directive
Date: Wed, 26 Jun 2024 18:21:21 -0400
Message-ID: <20240626222128.406106-16-jsnow@redhat.com>
In-Reply-To: <20240626222128.406106-1-jsnow@redhat.com>
References: <20240626222128.406106-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

This is a directive that creates a syntactic sugar for creating
"Example" boxes very similar to the ones already used in the bitmaps.rst
document, please see e.g.
https://www.qemu.org/docs/master/interop/bitmaps.html#creation-block-dirty-bitmap-add

In its simplest form, when a custom title is not needed or wanted, and
the example body is *solely* a QMP example:

```
.. qmp-example::

   {body}
```

is syntactic sugar for:

```
.. admonition:: Example:

   .. code-block:: QMP

      {body}
```

When a custom, plaintext title that describes the example is desired,
this form:

```
.. qmp-example::
   :title: Defrobnification

   {body}
```

Is syntactic sugar for:

```
.. admonition:: Example: Defrobnification

   .. code-block:: QMP

      {body}
```

Lastly, when Examples are multi-step processes that require non-QMP
exposition, have lengthy titles, or otherwise involve prose with rST
markup (lists, cross-references, etc), the most complex form:

```
.. qmp-example::
   :annotated:

   This example shows how to use `foo-command`::

     {body}
```

Is desugared to:

```
.. admonition:: Example:

   This example shows how to use `foo-command`::

     {body}

   For more information, please see `frobnozz`.
```

The primary benefit here being documentation source consistently using
the same directive for all forms of examples to ensure consistent visual
styling, and ensuring all relevant prose is visually grouped alongside
the code literal block.

Note that as of this commit, the code-block rST syntax "::" does not
apply QMP highlighting; you would need to use ".. code-block:: QMP". The
very next commit changes this behavior to assume all "::" code blocks
within this directive are QMP blocks.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 60 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 43dd99e21e6..a2fa05fc491 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -27,16 +27,19 @@
 import os
 import re
 import textwrap
+from typing import List
 
 from docutils import nodes
-from docutils.parsers.rst import Directive, directives
+from docutils.parsers.rst import directives
 from docutils.statemachine import ViewList
 from qapi.error import QAPIError, QAPISemError
 from qapi.gen import QAPISchemaVisitor
 from qapi.schema import QAPISchema
 
 import sphinx
+from sphinx.directives.code import CodeBlock
 from sphinx.errors import ExtensionError
+from sphinx.util.docutils import SphinxDirective
 from sphinx.util.nodes import nested_parse_with_titles
 
 
@@ -494,7 +497,7 @@ def visit_module(self, name):
         super().visit_module(name)
 
 
-class NestedDirective(Directive):
+class NestedDirective(SphinxDirective):
     def run(self):
         raise NotImplementedError
 
@@ -567,10 +570,63 @@ def run(self):
             raise ExtensionError(str(err)) from err
 
 
+class QMPExample(CodeBlock, NestedDirective):
+    """
+    Custom admonition for QMP code examples.
+
+    When the :annotated: option is present, the body of this directive
+    is parsed as normal rST instead. Code blocks must be explicitly
+    written by the user, but this allows for intermingling explanatory
+    paragraphs with arbitrary rST syntax and code blocks for more
+    involved examples.
+
+    When :annotated: is absent, the directive body is treated as a
+    simple standalone QMP code block literal.
+    """
+
+    required_argument = 0
+    optional_arguments = 0
+    has_content = True
+    option_spec = {
+        "annotated": directives.flag,
+        "title": directives.unchanged,
+    }
+
+    def admonition_wrap(self, *content) -> List[nodes.Node]:
+        title = "Example:"
+        if "title" in self.options:
+            title = f"{title} {self.options['title']}"
+
+        admon = nodes.admonition(
+            "",
+            nodes.title("", title),
+            *content,
+            classes=["admonition", "admonition-example"],
+        )
+        return [admon]
+
+    def run_annotated(self) -> List[nodes.Node]:
+        content_node: nodes.Element = nodes.section()
+        self.do_parse(self.content, content_node)
+        return content_node.children
+
+    def run(self) -> List[nodes.Node]:
+        annotated = "annotated" in self.options
+
+        if annotated:
+            content_nodes = self.run_annotated()
+        else:
+            self.arguments = ["QMP"]
+            content_nodes = super().run()
+
+        return self.admonition_wrap(*content_nodes)
+
+
 def setup(app):
     """Register qapi-doc directive with Sphinx"""
     app.add_config_value("qapidoc_srctree", None, "env")
     app.add_directive("qapi-doc", QAPIDocDirective)
+    app.add_directive("qmp-example", QMPExample)
 
     return {
         "version": __version__,
-- 
2.45.0


