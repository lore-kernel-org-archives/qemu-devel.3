Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC55FC54788
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctyL-0003OJ-3b; Wed, 21 Feb 2024 16:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcty1-0002vf-Cg; Wed, 21 Feb 2024 16:17:25 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rctxz-0000vS-I0; Wed, 21 Feb 2024 16:17:25 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CB3F54F7F8;
 Thu, 22 Feb 2024 00:16:45 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 819CA869B0;
 Thu, 22 Feb 2024 00:16:23 +0300 (MSK)
Received: (nullmailer pid 2335292 invoked by uid 1000);
 Wed, 21 Feb 2024 21:16:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 16/28] qemu-img: snapshot: make -l (list) the default,
 simplify option handling
Date: Thu, 22 Feb 2024 00:15:57 +0300
Message-Id: <20240221211622.2335170-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708544927.git.mjt@tls.msk.ru>
References: <cover.1708544927.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When no -l/-a/-c/-d specified, assume -l (list).

Use the same values for SNAPSHOT_LIST/etc constants as the
option chars (lacd), this makes it possible to simplify
option handling a lot, combining cases for 4 options into
one.

Also remove bdrv_oflags handling (only list can use RO mode).

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/tools/qemu-img.rst |  2 +-
 qemu-img.c              | 52 ++++++++++++++---------------------------
 2 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 9b628c4da5..df184d15b9 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -256,7 +256,7 @@ Parameters to snapshot subcommand:
 
 .. option:: -l
 
-  Lists all snapshots in the given image
+  Lists all snapshots in the given image (default action)
 
 Command description:
 
diff --git a/qemu-img.c b/qemu-img.c
index 85c37d491d..ee35768af8 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3584,10 +3584,11 @@ out:
     return ret < 0;
 }
 
-#define SNAPSHOT_LIST   1
-#define SNAPSHOT_CREATE 2
-#define SNAPSHOT_APPLY  3
-#define SNAPSHOT_DELETE 4
+/* the same as options */
+#define SNAPSHOT_LIST   'l'
+#define SNAPSHOT_CREATE 'c'
+#define SNAPSHOT_APPLY  'a'
+#define SNAPSHOT_DELETE 'd'
 
 static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
 {
@@ -3595,7 +3596,7 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
     BlockDriverState *bs;
     QEMUSnapshotInfo sn;
     char *filename, *fmt = NULL, *snapshot_name = NULL;
-    int c, ret = 0, bdrv_oflags;
+    int c, ret = 0;
     int action = 0;
     bool quiet = false;
     Error *err = NULL;
@@ -3603,7 +3604,6 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
     bool force_share = false;
     int64_t rt;
 
-    bdrv_oflags = BDRV_O_RDWR;
     /* Parse commandline parameters */
     for(;;) {
         static const struct option long_options[] = {
@@ -3631,36 +3631,15 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
         case 'f':
             fmt = optarg;
             break;
-        case 'l':
-            if (action) {
-                error_exit(argv[0], "Cannot mix '-l', '-a', '-c', '-d'");
-                return 0;
-            }
-            action = SNAPSHOT_LIST;
-            bdrv_oflags &= ~BDRV_O_RDWR; /* no need for RW */
-            break;
-        case 'a':
+        case SNAPSHOT_LIST:
+        case SNAPSHOT_APPLY:
+        case SNAPSHOT_CREATE:
+        case SNAPSHOT_DELETE:
             if (action) {
                 error_exit(argv[0], "Cannot mix '-l', '-a', '-c', '-d'");
                 return 0;
             }
-            action = SNAPSHOT_APPLY;
-            snapshot_name = optarg;
-            break;
-        case 'c':
-            if (action) {
-                error_exit(argv[0], "Cannot mix '-l', '-a', '-c', '-d'");
-                return 0;
-            }
-            action = SNAPSHOT_CREATE;
-            snapshot_name = optarg;
-            break;
-        case 'd':
-            if (action) {
-                error_exit(argv[0], "Cannot mix '-l', '-a', '-c', '-d'");
-                return 0;
-            }
-            action = SNAPSHOT_DELETE;
+            action = c;
             snapshot_name = optarg;
             break;
         case 'q':
@@ -3683,9 +3662,14 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
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


