Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3719CC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 21:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYYLa-0007Ii-FT; Fri, 09 Feb 2024 16:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYLY-0007FM-L2; Fri, 09 Feb 2024 16:23:44 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYLJ-00009S-4S; Fri, 09 Feb 2024 16:23:44 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 070A04BF64;
 Sat, 10 Feb 2024 00:24:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E809C77EDE;
 Sat, 10 Feb 2024 00:22:47 +0300 (MSK)
Received: (nullmailer pid 1123175 invoked by uid 1000);
 Fri, 09 Feb 2024 21:22:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 12/23] qemu-img: make -l (list) the default for "snapshot"
 subcommand
Date: Sat, 10 Feb 2024 00:22:33 +0300
Message-Id: <71d69214d43897e5649fed00804a5969b0fd718b.1707513011.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1707513011.git.mjt@tls.msk.ru>
References: <cover.1707513011.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

also remove bdrv_oflags handling (only list can use RO mode)
---
 qemu-img.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 1e09b78d00..d9dfff2f07 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3541,7 +3541,7 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
     BlockDriverState *bs;
     QEMUSnapshotInfo sn;
     char *filename, *fmt = NULL, *snapshot_name = NULL;
-    int c, ret = 0, bdrv_oflags;
+    int c, ret = 0;
     int action = 0;
     bool quiet = false;
     Error *err = NULL;
@@ -3549,7 +3549,6 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
     bool force_share = false;
     int64_t rt;
 
-    bdrv_oflags = BDRV_O_RDWR;
     /* Parse commandline parameters */
     for(;;) {
         static const struct option long_options[] = {
@@ -3583,7 +3582,6 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
                 return 0;
             }
             action = SNAPSHOT_LIST;
-            bdrv_oflags &= ~BDRV_O_RDWR; /* no need for RW */
             break;
         case 'a':
             if (action) {
@@ -3629,9 +3627,14 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
     }
     filename = argv[optind++];
 
+    if (!action) {
+        action = SNAPSHOT_LIST;
+    }
+
     /* Open the image */
-    blk = img_open(image_opts, filename, fmt, bdrv_oflags, false, quiet,
-                   force_share);
+    blk = img_open(image_opts, filename, fmt,
+                   action == SNAPSHOT_LIST ? 0 : BDRV_O_RDWR,
+                   false, quiet, force_share);
     if (!blk) {
         return 1;
     }
-- 
2.39.2


