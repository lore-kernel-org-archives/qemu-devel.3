Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA916FE5202
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 11:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGEGL-0000Q8-Ej; Fri, 24 Apr 2026 06:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wGEGI-0000PL-V6; Fri, 24 Apr 2026 06:59:55 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wGEGG-0000zf-N3; Fri, 24 Apr 2026 06:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=MY3Ui24DiO+ty5K/7ChL4aiQuI6zKz+dZPOdvsiLArA=; b=scklV46o8rdl
 qhNrIRrCyzdpJALI1YCQ9uZ+4RU9N1kN+bOEfUulPBjlhj22rEHCSAde2XKAHssFj5hY3+Z5jsa2z
 7dicATKnB+xFkcqnYSrAORSgJgWoXr8uBGFwVluLkRyXvePOiMmorii75YkpwUuLqUL7O0WYzOl60
 LfcRAywnjftUOO/2rIOx9xaaB6rreU9VLkSLZrohfV8/OCPE7Szweft0pr3iiiG5PQ1xg9MYzicjt
 AAqfpiQNZnSD2QeXN+RcTrcPXBpK4okNd2D0ojBb3cxf/x3Ejm/rCC3TagWWIG2PKcNPgbX8os+WT
 Fu2OVDXNtTbHE/PglRV+Pw==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1wGEDW-00FcSF-24;
 Fri, 24 Apr 2026 12:59:46 +0200
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v3 1/1] qemu-img: add sub-command --remove-all to 'qemu-img
 bitmap'
Date: Fri, 24 Apr 2026 12:59:49 +0200
Message-ID: <20260424105949.254757-1-den@openvz.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From time to time it is needed to remove all bitmaps from the image.
Before this patch the process is not very convenient. One should
perform
    qemu-img info
and parse the output to obtain all names. After that one should
sequentially call
    qemu-img bitmap --remove
for each present bitmap.

The patch adds --remove-all sub-command to 'qemu-img bitmap'.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
---
Changes from v2:
* rebased to the lastest head

Changes from v1:
* rebased to latest head
* adopted bitmap help to the new layout

 docs/tools/qemu-img.rst | 10 +++++---
 qemu-img.c              | 53 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 558b0eb84d..b0c798b77a 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -301,15 +301,19 @@ Command description:
   For write tests, by default a buffer filled with zeros is written. This can be
   overridden with a pattern byte specified by *PATTERN*.
 
-.. option:: bitmap (--merge SOURCE | --add | --remove | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP
+.. option:: bitmap (--merge SOURCE | --add | --remove | --remove-all | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME [BITMAP]
 
-  Perform one or more modifications of the persistent bitmap *BITMAP*
-  in the disk image *FILENAME*.  The various modifications are:
+  Perform one or more modifications of persistent bitmaps in the disk
+  image *FILENAME*.  Most operations require *BITMAP* to be specified;
+  ``--remove-all`` operates on all bitmaps and does not take *BITMAP*.
+  The various modifications are:
 
   ``--add`` to create *BITMAP*, enabled to record future edits.
 
   ``--remove`` to remove *BITMAP*.
 
+  ``--remove-all`` to remove all bitmaps.
+
   ``--clear`` to clear *BITMAP*.
 
   ``--enable`` to change *BITMAP* to start recording future edits.
diff --git a/qemu-img.c b/qemu-img.c
index c42dd4e995..22ddc7a627 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -87,6 +87,7 @@ enum {
     OPTION_FORCE = 276,
     OPTION_SKIP_BROKEN = 277,
     OPTION_LIMITS = 278,
+    OPTION_REMOVE_ALL = 279,
 };
 
 typedef enum OutputFormat {
@@ -5018,6 +5019,7 @@ enum ImgBitmapAct {
     BITMAP_ENABLE,
     BITMAP_DISABLE,
     BITMAP_MERGE,
+    BITMAP_REMOVE_ALL,
 };
 typedef struct ImgBitmapAction {
     enum ImgBitmapAct act;
@@ -5036,7 +5038,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
     BlockDriverState *bs = NULL, *src_bs = NULL;
     bool image_opts = false;
     int64_t granularity = 0;
-    bool add = false, merge = false;
+    bool add = false, merge = false, remove_all = false, any = false;
     QSIMPLEQ_HEAD(, ImgBitmapAction) actions;
     ImgBitmapAction *act, *act_next;
     const char *op;
@@ -5052,6 +5054,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
             {"add", no_argument, 0, OPTION_ADD},
             {"granularity", required_argument, 0, 'g'},
             {"remove", no_argument, 0, OPTION_REMOVE},
+            {"remove-all", no_argument, 0, OPTION_REMOVE_ALL},
             {"clear", no_argument, 0, OPTION_CLEAR},
             {"enable", no_argument, 0, OPTION_ENABLE},
             {"disable", no_argument, 0, OPTION_DISABLE},
@@ -5070,8 +5073,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
         switch (c) {
         case 'h':
             cmd_help(ccmd, "[-f FMT | --image-opts]\n"
-"        ( --add [-g SIZE] | --remove | --clear | --enable | --disable |\n"
-"          --merge SOURCE [-b SRC_FILE [-F SRC_FMT]] )..\n"
+"        ( --add [-g SIZE] | --remove | --remove-all | --clear | --enable |\n"
+"          --disable | --merge SOURCE [-b SRC_FILE [-F SRC_FMT]] )..\n"
 "        [--object OBJDEF] FILE BITMAP\n"
 ,
 "  -f, --format FMT\n"
@@ -5086,6 +5089,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
 "     with optional multiplier suffix (in powers of 1024)\n"
 "  --remove\n"
 "     removes BITMAP from FILE\n"
+"  --remove-all\n"
+"     removes all bitmaps from FILE\n"
 "  --clear\n"
 "     clears BITMAP in FILE\n"
 "  --enable, --disable\n"
@@ -5115,7 +5120,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
             act = g_new0(ImgBitmapAction, 1);
             act->act = BITMAP_ADD;
             QSIMPLEQ_INSERT_TAIL(&actions, act, next);
-            add = true;
+            add = any = true;
             break;
         case 'g':
             granularity = cvtnum("granularity", optarg, true);
@@ -5127,28 +5132,38 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
             act = g_new0(ImgBitmapAction, 1);
             act->act = BITMAP_REMOVE;
             QSIMPLEQ_INSERT_TAIL(&actions, act, next);
+            any = true;
+            break;
+        case OPTION_REMOVE_ALL:
+            act = g_new0(ImgBitmapAction, 1);
+            act->act = BITMAP_REMOVE_ALL;
+            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
+            remove_all = true;
             break;
         case OPTION_CLEAR:
             act = g_new0(ImgBitmapAction, 1);
             act->act = BITMAP_CLEAR;
             QSIMPLEQ_INSERT_TAIL(&actions, act, next);
+            any = true;
             break;
         case OPTION_ENABLE:
             act = g_new0(ImgBitmapAction, 1);
             act->act = BITMAP_ENABLE;
             QSIMPLEQ_INSERT_TAIL(&actions, act, next);
+            any = true;
             break;
         case OPTION_DISABLE:
             act = g_new0(ImgBitmapAction, 1);
             act->act = BITMAP_DISABLE;
             QSIMPLEQ_INSERT_TAIL(&actions, act, next);
+            any = true;
             break;
         case OPTION_MERGE:
             act = g_new0(ImgBitmapAction, 1);
             act->act = BITMAP_MERGE;
             act->src = optarg;
             QSIMPLEQ_INSERT_TAIL(&actions, act, next);
-            merge = true;
+            any = merge = true;
             break;
         case 'b':
             src_filename = optarg;
@@ -5165,8 +5180,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
     }
 
     if (QSIMPLEQ_EMPTY(&actions)) {
-        error_report("Need at least one of --add, --remove, --clear, "
-                     "--enable, --disable, or --merge");
+        error_report("Need at least one of --add, --remove, --remove-all, "
+                     "--clear, --enable, --disable, or --merge");
         goto out;
     }
 
@@ -5184,10 +5199,14 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
         goto out;
     }
 
-    if (optind != argc - 2) {
+    if (any && optind != argc - 2) {
         error_report("Expecting filename and bitmap name");
         goto out;
     }
+    if (!any && remove_all && optind != argc - 1) {
+        error_report("Expecting filename");
+        goto out;
+    }
 
     filename = argv[optind];
     bitmap = argv[optind + 1];
@@ -5225,6 +5244,24 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
             qmp_block_dirty_bitmap_remove(bs->node_name, bitmap, &err);
             op = "remove";
             break;
+        case BITMAP_REMOVE_ALL: {
+            while (1) {
+                const char *name;
+                BdrvDirtyBitmap *bm = bdrv_dirty_bitmap_first(bs);
+                if (bm == NULL) {
+                    break;
+                }
+                name = bdrv_dirty_bitmap_name(bm);
+                qmp_block_dirty_bitmap_remove(bs->node_name, name, &err);
+                if (err) {
+                    /* Save name for proper error reporting */
+                    bitmap = name;
+                    break;
+                }
+            }
+            op = "remove-all";
+            break;
+        }
         case BITMAP_CLEAR:
             qmp_block_dirty_bitmap_clear(bs->node_name, bitmap, &err);
             op = "clear";
-- 
2.51.0


