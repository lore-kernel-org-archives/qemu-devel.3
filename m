Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1542ECEBF78
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 06:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su4DE-0007E6-6m; Fri, 27 Sep 2024 02:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1su4D9-0006rR-KG; Fri, 27 Sep 2024 02:12:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1su4D7-0003Sh-8l; Fri, 27 Sep 2024 02:12:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D4EB492D1F;
 Fri, 27 Sep 2024 09:10:51 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 50A27146711;
 Fri, 27 Sep 2024 09:11:22 +0300 (MSK)
Received: (nullmailer pid 573380 invoked by uid 1000);
 Fri, 27 Sep 2024 06:11:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 14/27] qemu-img: snapshot: allow specifying -f fmt
Date: Fri, 27 Sep 2024 09:11:08 +0300
Message-Id: <20240927061121.573271-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240927061121.573271-1-mjt@tls.msk.ru>
References: <20240927061121.573271-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

For consistency with other commands, and since it already
accepts --image-opts, allow specifying -f fmt too.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/tools/qemu-img.rst | 2 +-
 qemu-img-cmds.hx        | 4 ++--
 qemu-img.c              | 9 ++++++---
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 3653adb963..9b628c4da5 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -663,7 +663,7 @@ Command description:
   bitmap support, or 0 if bitmaps are supported but there is nothing
   to copy.
 
-.. option:: snapshot [--object OBJECTDEF] [--image-opts] [-U] [-q] [-l | -a SNAPSHOT | -c SNAPSHOT | -d SNAPSHOT] FILENAME
+.. option:: snapshot [--object OBJECTDEF] [-f FMT | --image-opts] [-U] [-q] [-l | -a SNAPSHOT | -c SNAPSHOT | -d SNAPSHOT] FILENAME
 
   List, apply, create or delete snapshots in image *FILENAME*.
 
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index c9dd70a892..2c5a8a28f9 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -84,9 +84,9 @@ SRST
 ERST
 
 DEF("snapshot", img_snapshot,
-    "snapshot [--object objectdef] [--image-opts] [-U] [-q] [-l | -a snapshot | -c snapshot | -d snapshot] filename")
+    "snapshot [--object objectdef] [-f fmt | --image-opts] [-U] [-q] [-l | -a snapshot | -c snapshot | -d snapshot] filename")
 SRST
-.. option:: snapshot [--object OBJECTDEF] [--image-opts] [-U] [-q] [-l | -a SNAPSHOT | -c SNAPSHOT | -d SNAPSHOT] FILENAME
+.. option:: snapshot [--object OBJECTDEF] [-f FMT | --image-opts] [-U] [-q] [-l | -a SNAPSHOT | -c SNAPSHOT | -d SNAPSHOT] FILENAME
 ERST
 
 DEF("rebase", img_rebase,
diff --git a/qemu-img.c b/qemu-img.c
index 84e2e53fb7..8adc324496 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3595,7 +3595,7 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
     BlockBackend *blk;
     BlockDriverState *bs;
     QEMUSnapshotInfo sn;
-    char *filename, *snapshot_name = NULL;
+    char *filename, *fmt = NULL, *snapshot_name = NULL;
     int c, ret = 0, bdrv_oflags;
     int action = 0;
     bool quiet = false;
@@ -3614,7 +3614,7 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
             {"force-share", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":la:c:d:hqU",
+        c = getopt_long(argc, argv, ":la:c:d:f:hqU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -3629,6 +3629,9 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
         case 'h':
             help();
             return 0;
+        case 'f':
+            fmt = optarg;
+            break;
         case 'l':
             if (action) {
                 error_exit(argv[0], "Cannot mix '-l', '-a', '-c', '-d'");
@@ -3682,7 +3685,7 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
     filename = argv[optind++];
 
     /* Open the image */
-    blk = img_open(image_opts, filename, NULL, bdrv_oflags, false, quiet,
+    blk = img_open(image_opts, filename, fmt, bdrv_oflags, false, quiet,
                    force_share);
     if (!blk) {
         return 1;
-- 
2.39.5


