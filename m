Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F5DC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2Dr-00048U-DJ; Wed, 17 Jul 2024 06:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sU2Do-0003x4-SR
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:49:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sU2Dm-0001Un-4Z
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721213356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1YBCJef33DxrMWKydleWXgYZn+6ydbcTfmTWGUeUR0M=;
 b=D8pQ21+lFGLcUo9+CMROUq2wJutYgTP8bYGXxIt/NC8hsCuWxU+us3sC5rMrQt6QQjHXaR
 1etTPFS6TyZhrbA+Pcgmv3LJjzASqPB8kNvAEPfKhSl0mARjf8mFMZpkpUsT67FJcJUT4t
 GwKr0nhXyJLaYYx1Kr2As+L6S21sqTU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-7OoDfojXN1yLAb4WF55GGQ-1; Wed,
 17 Jul 2024 06:49:14 -0400
X-MC-Unique: 7OoDfojXN1yLAb4WF55GGQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2E691955D56; Wed, 17 Jul 2024 10:49:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 876491955D42; Wed, 17 Jul 2024 10:49:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CE62021E6601; Wed, 17 Jul 2024 12:49:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 07/14] docs/qapidoc: factor out do_parse()
Date: Wed, 17 Jul 2024 12:49:00 +0200
Message-ID: <20240717104907.2962784-8-armbru@redhat.com>
In-Reply-To: <20240717104907.2962784-1-armbru@redhat.com>
References: <20240717104907.2962784-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Factor out the compatibility parser helper into a base class, so it can
be shared by other directives.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240717021312.606116-3-jsnow@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 62b39833ca..b3be82998a 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -481,7 +481,25 @@ def visit_module(self, name):
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
+        with switch_source_input(self.state, rstlist):
+            nested_parse_with_titles(self.state, rstlist, node)
+
+
+class QAPIDocDirective(NestedDirective):
     """Extract documentation from the specified QAPI .json file"""
 
     required_argument = 1
@@ -519,18 +537,6 @@ def run(self):
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
-        with switch_source_input(self.state, rstlist):
-            nested_parse_with_titles(self.state, rstlist, node)
-
 
 def setup(app):
     """Register qapi-doc directive with Sphinx"""
-- 
2.45.0


