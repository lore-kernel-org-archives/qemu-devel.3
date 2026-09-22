Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75815C98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x97Xb-0000Iw-7i; Tue, 22 Sep 2026 16:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x97XT-0000Gi-Qn
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x97XS-00045l-CQ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790110589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XK1aSGSt1xTWF7/Prx8zJTaU+O+Uyrct5dy+1HkNSpU=;
 b=CzB3fo+orkxLKqKwtHxFK1CDWfj0N8NOPBFfOM9xD7c77vKj0BxlvgxZ9hw1OZJTPdiYjw
 h8JI5aJ9l4e18m9Ux4lw3oU1RYq8wRabT9x/3KSdi2BTPb3v5ibYjFHCXCZu9HwebUkZE8
 SO9Rsh4yeYA+vXdbJY7VETJnhk/Zm6c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-MvC125T2PFWCF9OmYGe4Bw-1; Tue,
 22 Sep 2026 16:56:24 -0400
X-MC-Unique: MvC125T2PFWCF9OmYGe4Bw-1
X-Mimecast-MFC-AGG-ID: MvC125T2PFWCF9OmYGe4Bw_1790110583
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8621B1800BCE; Tue, 22 Sep 2026 20:56:22 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.125])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5CF421956086; Tue, 22 Sep 2026 20:56:19 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 2/8] qapi: convert intro sections for unit tests
Date: Tue, 22 Sep 2026 16:55:59 -0400
Message-ID: <20260922205605.501602-3-jsnow@redhat.com>
In-Reply-To: <20260922205605.501602-1-jsnow@redhat.com>
References: <20260922205605.501602-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qapi-schema/doc-good.json                |  8 ++++----
 tests/qapi-schema/doc-good.out                 | 15 ++++++---------
 tests/qapi-schema/doc-interleaved-section.err  |  2 +-
 tests/qapi-schema/doc-interleaved-section.json |  3 +--
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index fac13425b72..d9a84ccd729 100644
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
index 371dd25ffc7..eaaf119dea8 100644
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
diff --git a/tests/qapi-schema/doc-interleaved-section.err b/tests/qapi-schema/doc-interleaved-section.err
index e5d1ef54c1b..85f01fa57a7 100644
--- a/tests/qapi-schema/doc-interleaved-section.err
+++ b/tests/qapi-schema/doc-interleaved-section.err
@@ -1 +1 @@
-doc-interleaved-section.json:15:1: description of '@foobar:' follows a section
+doc-interleaved-section.json:14:1: description of '@foobar:' follows a section
diff --git a/tests/qapi-schema/doc-interleaved-section.json b/tests/qapi-schema/doc-interleaved-section.json
index eec01ed5650..bc0937b8601 100644
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


