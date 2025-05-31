Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15AAC5AE59
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 17:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLPqi-0002rU-SP; Sat, 31 May 2025 13:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPpW-0001W9-R8; Sat, 31 May 2025 13:17:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPpV-00016C-0f; Sat, 31 May 2025 13:17:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5BDA1126B40;
 Sat, 31 May 2025 20:16:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 33FBF21BA43;
 Sat, 31 May 2025 20:16:10 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 16/27] qemu-img: snapshot: make -l (list) the default,
 simplify option handling
Date: Sat, 31 May 2025 20:15:58 +0300
Message-Id: <20250531171609.197078-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531171609.197078-1-mjt@tls.msk.ru>
References: <20250531171609.197078-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

When no -l/-a/-c/-d specified, assume -l (list).

Use the same values for SNAPSHOT_LIST/etc constants as the
option chars (lacd), this makes it possible to simplify
option handling a lot, combining cases for 4 options into
one.

Also remove bdrv_oflags handling (only list can use RO mode).

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/tools/qemu-img.rst |  2 +-
 qemu-img.c              | 52 ++++++++++++++---------------------------
 2 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 935f28bbc5..a346988292 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -256,7 +256,7 @@ Parameters to snapshot subcommand:
 
 .. option:: -l
 
-  Lists all snapshots in the given image
+  Lists all snapshots in the given image (default action)
 
 Command description:
 
diff --git a/qemu-img.c b/qemu-img.c
index 38352e54ad..8fbf0c67a7 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3583,10 +3583,11 @@ out:
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
@@ -3594,7 +3595,7 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
     BlockDriverState *bs;
     QEMUSnapshotInfo sn;
     char *filename, *fmt = NULL, *snapshot_name = NULL;
-    int c, ret = 0, bdrv_oflags;
+    int c, ret = 0;
     int action = 0;
     bool quiet = false;
     Error *err = NULL;
@@ -3602,7 +3603,6 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
     bool force_share = false;
     int64_t rt;
 
-    bdrv_oflags = BDRV_O_RDWR;
     /* Parse commandline parameters */
     for(;;) {
         static const struct option long_options[] = {
@@ -3630,36 +3630,15 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
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
@@ -3682,9 +3661,14 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
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
2.39.5


