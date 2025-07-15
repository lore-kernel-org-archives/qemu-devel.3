Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6387C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublYp-0003GB-OG; Tue, 15 Jul 2025 15:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxM-0004BD-72
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxK-0001RA-De
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dyVMTv6sGhp4EucS+e3TQ9pqVVDsby/Mjxux88RCYOU=;
 b=OGLdp+lAofnAlFTwLibRKJNrP4LoIljX9CHxFYlIzOBhdlfNsN9OVNLkRQSy4nDPAXYhqP
 WUJWpSpng+dJ9JQE1cuSNPdCBwvqkECHbJTNwuFrB3YS9VLyIKbq3kjSbXPXkzND2rcmLr
 azbqcI0tfrTb9JMuV3+kOerzM5mvd5A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-FOwqosT3MmOyx3uCB1DHZA-1; Tue,
 15 Jul 2025 15:04:43 -0400
X-MC-Unique: FOwqosT3MmOyx3uCB1DHZA-1
X-Mimecast-MFC-AGG-ID: FOwqosT3MmOyx3uCB1DHZA_1752606283
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB1D31956080; Tue, 15 Jul 2025 19:04:42 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66780197702B; Tue, 15 Jul 2025 19:04:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 31/57] qemu-img: measure: convert img_size to signed,
 simplify handling
Date: Tue, 15 Jul 2025 21:03:04 +0200
Message-ID: <20250715190330.378764-32-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Michael Tokarev <mjt@tls.msk.ru>

qemu_opt_set_number() expects signed int64_t.

Use int64_t instead of uint64_t for img_size, use -1 as "unset"
value instead of UINT64_MAX, and do not require temporary sval
for conversion from string.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250531171609.197078-2-mjt@tls.msk.ru>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index e75707180d..e676602fc7 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5370,7 +5370,7 @@ static int img_measure(int argc, char **argv)
     QemuOpts *sn_opts = NULL;
     QemuOptsList *create_opts = NULL;
     bool image_opts = false;
-    uint64_t img_size = UINT64_MAX;
+    int64_t img_size = -1;
     BlockMeasureInfo *info = NULL;
     Error *local_err = NULL;
     int ret = 1;
@@ -5428,16 +5428,11 @@ static int img_measure(int argc, char **argv)
             }
             break;
         case OPTION_SIZE:
-        {
-            int64_t sval;
-
-            sval = cvtnum("image size", optarg);
-            if (sval < 0) {
+            img_size = cvtnum("image size", optarg);
+            if (img_size < 0) {
                 goto out;
             }
-            img_size = (uint64_t)sval;
-        }
-        break;
+            break;
         }
     }
 
@@ -5452,11 +5447,11 @@ static int img_measure(int argc, char **argv)
         error_report("--image-opts, -f, and -l require a filename argument.");
         goto out;
     }
-    if (filename && img_size != UINT64_MAX) {
+    if (filename && img_size != -1) {
         error_report("--size N cannot be used together with a filename.");
         goto out;
     }
-    if (!filename && img_size == UINT64_MAX) {
+    if (!filename && img_size == -1) {
         error_report("Either --size N or one filename must be specified.");
         goto out;
     }
@@ -5504,7 +5499,7 @@ static int img_measure(int argc, char **argv)
             goto out;
         }
     }
-    if (img_size != UINT64_MAX) {
+    if (img_size != -1) {
         qemu_opt_set_number(opts, BLOCK_OPT_SIZE, img_size, &error_abort);
     }
 
-- 
2.50.1


