Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BD1C3271E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 21:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP77B-0000eX-Tz; Wed, 03 Jul 2024 17:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP77A-0000eB-CJ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 17:02:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP778-00089O-OQ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 17:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720040526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=weZkuUwuyqy4MTMy3EjAIkediRMFFXVHhEi2kP2UMqs=;
 b=Dl6OmrnJCyLfciaVhhZJcVEkXAqaVwauYkhhyf+cxv4n4YsWf8FsgEJHwm8E55saE/0G1w
 CUd4LxeGQxvVS8qnKppHM2XvzwG3d74ZNmJDGHiJ6cxMDo3wQi70GPVDfsXZeaHqMH9IEU
 OpRv26l/QjiK/4rVlsuDNEKqgLcY4W8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-VPASe2OdMOiGj2M1tf2iBA-1; Wed,
 03 Jul 2024 17:02:02 -0400
X-MC-Unique: VPASe2OdMOiGj2M1tf2iBA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C8C3195608C; Wed,  3 Jul 2024 21:02:00 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.34.31])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A29F1955F22; Wed,  3 Jul 2024 21:01:53 +0000 (UTC)
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
Subject: [PATCH 1/8] docs/qapidoc: factor out do_parse()
Date: Wed,  3 Jul 2024 17:01:36 -0400
Message-ID: <20240703210144.339530-2-jsnow@redhat.com>
In-Reply-To: <20240703210144.339530-1-jsnow@redhat.com>
References: <20240703210144.339530-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

Factor out the compatibility parser helper into a base class, so it can
be shared by other directives.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 64 +++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index efcd84656fa..43dd99e21e6 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -494,7 +494,41 @@ def visit_module(self, name):
         super().visit_module(name)
 
 
-class QAPIDocDirective(Directive):
+class NestedDirective(Directive):
+    def run(self):
+        raise NotImplementedError
+
+    def do_parse(self, rstlist, node):
+        """
+        Parse rST source lines and add them to the specified node
+
+        Take the list of rST source lines rstlist, parse them as
+        rST, and add the resulting docutils nodes as children of node.
+        The nodes are parsed in a way that allows them to include
+        subheadings (titles) without confusing the rendering of
+        anything else.
+        """
+        # This is from kerneldoc.py -- it works around an API change in
+        # Sphinx between 1.6 and 1.7. Unlike kerneldoc.py, we use
+        # sphinx.util.nodes.nested_parse_with_titles() rather than the
+        # plain self.state.nested_parse(), and so we can drop the saving
+        # of title_styles and section_level that kerneldoc.py does,
+        # because nested_parse_with_titles() does that for us.
+        if USE_SSI:
+            with switch_source_input(self.state, rstlist):
+                nested_parse_with_titles(self.state, rstlist, node)
+        else:
+            save = self.state.memo.reporter
+            self.state.memo.reporter = AutodocReporter(
+                rstlist, self.state.memo.reporter
+            )
+            try:
+                nested_parse_with_titles(self.state, rstlist, node)
+            finally:
+                self.state.memo.reporter = save
+
+
+class QAPIDocDirective(NestedDirective):
     """Extract documentation from the specified QAPI .json file"""
 
     required_argument = 1
@@ -532,34 +566,6 @@ def run(self):
             # so they are displayed nicely to the user
             raise ExtensionError(str(err)) from err
 
-    def do_parse(self, rstlist, node):
-        """Parse rST source lines and add them to the specified node
-
-        Take the list of rST source lines rstlist, parse them as
-        rST, and add the resulting docutils nodes as children of node.
-        The nodes are parsed in a way that allows them to include
-        subheadings (titles) without confusing the rendering of
-        anything else.
-        """
-        # This is from kerneldoc.py -- it works around an API change in
-        # Sphinx between 1.6 and 1.7. Unlike kerneldoc.py, we use
-        # sphinx.util.nodes.nested_parse_with_titles() rather than the
-        # plain self.state.nested_parse(), and so we can drop the saving
-        # of title_styles and section_level that kerneldoc.py does,
-        # because nested_parse_with_titles() does that for us.
-        if USE_SSI:
-            with switch_source_input(self.state, rstlist):
-                nested_parse_with_titles(self.state, rstlist, node)
-        else:
-            save = self.state.memo.reporter
-            self.state.memo.reporter = AutodocReporter(
-                rstlist, self.state.memo.reporter
-            )
-            try:
-                nested_parse_with_titles(self.state, rstlist, node)
-            finally:
-                self.state.memo.reporter = save
-
 
 def setup(app):
     """Register qapi-doc directive with Sphinx"""
-- 
2.45.0


