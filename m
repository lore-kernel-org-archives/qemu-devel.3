Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBEFCA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrkx-00080Z-SG; Wed, 30 Sep 2026 06:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrj2-0001cl-97
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrin-0006qL-Bu
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yv7wNVQVPg2KzX7+EHW1DqDRLlNJ0/6H8PPLae+S+q0=;
 b=Zch2N3Xq5XSilsWhYcbul9B34p3G0CV6OoGxjbnRR9DMxp82ZU91Y+cRYMsLBh6uJH3S7c
 u0KHjKbr5SnEdSoLcuTOUd5weRi0lauuC9zorsVUAdwVKRWFdOrldLNrmDaNJM7BunUK3M
 lo8tXtGtxL3TXZExkjy4C83xO8yv61Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-k4f3ZiM3MXyJ0SgXLcubAg-1; Wed,
 30 Sep 2026 06:39:28 -0400
X-MC-Unique: k4f3ZiM3MXyJ0SgXLcubAg-1
X-Mimecast-MFC-AGG-ID: k4f3ZiM3MXyJ0SgXLcubAg_1790764768
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 198681953978; Wed, 30 Sep 2026 10:39:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C35851800361; Wed, 30 Sep 2026 10:39:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0D15D21E6569; Wed, 30 Sep 2026 12:39:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 089/105] qapi: convert intro sections for unit tests
Date: Wed, 30 Sep 2026 12:38:54 +0200
Message-ID: <20260930103910.3934848-90-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260922205605.501602-3-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
[Missing update to tests/qapi-schema/doc-good.txt squashed in]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/doc-good.json                |  8 ++++----
 tests/qapi-schema/doc-good.out                 | 15 ++++++---------
 tests/qapi-schema/doc-good.txt                 |  4 ++--
 tests/qapi-schema/doc-interleaved-section.err  |  2 +-
 tests/qapi-schema/doc-interleaved-section.json |  3 +--
 5 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index fac13425b7..d9a84ccd72 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -94,10 +94,9 @@
 
 ##
 # @Variant1:
+#     A paragraph
 #
-# A paragraph
-#
-# Another paragraph
+#     Another paragraph
 #
 # @var1 is undocumented
 #
@@ -206,7 +205,8 @@
 
 ##
 # @cmd-boxed:
-# If you're bored enough to read this, go see a video of boxed cats
+#     If you're bored enough to read this, go see a video of boxed
+#     cats
 #
 # Features:
 # @cmd-feat1: a feature
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 371dd25ffc..eaaf119dea 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -126,15 +126,13 @@ doc symbol=Base
  minimally indented
 doc symbol=Variant1
     Intro
+    A paragraph
 
-    Plain
-A paragraph
-
-Another paragraph
-
-@var1 is undocumented
+    Another paragraph
     Member=var1
 
+    Plain
+@var1 is undocumented
     Feature=variant1-feat
 a feature
     Feature=member-feat
@@ -213,9 +211,8 @@ Note::
 2.10
 doc symbol=cmd-boxed
     Intro
-
-    Plain
-If you're bored enough to read this, go see a video of boxed cats
+    If you're bored enough to read this, go see a video of boxed
+    cats
     Feature=cmd-feat1
 a feature
     Feature=cmd-feat2
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
index 74b73681d3..ba089a7f94 100644
--- a/tests/qapi-schema/doc-good.txt
+++ b/tests/qapi-schema/doc-good.txt
@@ -65,11 +65,11 @@ Object Variant1
 
    Another paragraph
 
-   "var1" is undocumented
-
    Members:
       * **var1** ("string") -- Not documented
 
+   "var1" is undocumented
+
    Features:
       * **variant1-feat** -- a feature
 
diff --git a/tests/qapi-schema/doc-interleaved-section.err b/tests/qapi-schema/doc-interleaved-section.err
index e5d1ef54c1..85f01fa57a 100644
--- a/tests/qapi-schema/doc-interleaved-section.err
+++ b/tests/qapi-schema/doc-interleaved-section.err
@@ -1 +1 @@
-doc-interleaved-section.json:15:1: description of '@foobar:' follows a section
+doc-interleaved-section.json:14:1: description of '@foobar:' follows a section
diff --git a/tests/qapi-schema/doc-interleaved-section.json b/tests/qapi-schema/doc-interleaved-section.json
index eec01ed565..bc0937b860 100644
--- a/tests/qapi-schema/doc-interleaved-section.json
+++ b/tests/qapi-schema/doc-interleaved-section.json
@@ -2,8 +2,7 @@
 
 ##
 # @TestStruct:
-#
-# body
+#     body
 #
 # @integer: foo
 #           blah
-- 
2.55.0


