Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DADC10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzYL4-00011J-Rb; Wed, 24 Apr 2024 04:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzYL2-0000xB-N9; Wed, 24 Apr 2024 04:50:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzYL0-0003ty-VO; Wed, 24 Apr 2024 04:50:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E17416152A;
 Wed, 24 Apr 2024 11:50:42 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 17BE1BE0DA;
 Wed, 24 Apr 2024 11:50:36 +0300 (MSK)
Received: (nullmailer pid 1179580 invoked by uid 1000);
 Wed, 24 Apr 2024 08:50:36 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Subject: [PATCH 01/27] qemu-img: measure: convert img_size to signed,
 simplify handling
Date: Wed, 24 Apr 2024 11:50:09 +0300
Message-Id: <96a60661e238e62536306a149e353ef16b5d43fc.1713948448.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1713948448.git.mjt@tls.msk.ru>
References: <cover.1713948448.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

qemu_opt_set_number() expects signed int64_t.

Use int64_t instead of uint64_t for img_size, use -1 as "unset"
value instead of UINT64_MAX, and do not require temporary sval
for conversion from string.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qemu-img.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 7668f86769..6e7ac2048f 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5364,7 +5364,7 @@ static int img_measure(int argc, char **argv)
     QemuOpts *sn_opts = NULL;
     QemuOptsList *create_opts = NULL;
     bool image_opts = false;
-    uint64_t img_size = UINT64_MAX;
+    int64_t img_size = -1;
     BlockMeasureInfo *info = NULL;
     Error *local_err = NULL;
     int ret = 1;
@@ -5422,16 +5422,11 @@ static int img_measure(int argc, char **argv)
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
 
@@ -5446,11 +5441,11 @@ static int img_measure(int argc, char **argv)
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
@@ -5498,7 +5493,7 @@ static int img_measure(int argc, char **argv)
             goto out;
         }
     }
-    if (img_size != UINT64_MAX) {
+    if (img_size != -1) {
         qemu_opt_set_number(opts, BLOCK_OPT_SIZE, img_size, &error_abort);
     }
 
-- 
2.39.2


