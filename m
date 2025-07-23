Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423DFC83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 19:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uef9Z-000803-DA; Wed, 23 Jul 2025 15:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1uef9X-0007zJ-Mt; Wed, 23 Jul 2025 15:29:23 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1uef9V-0004xP-AP; Wed, 23 Jul 2025 15:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=VFrOV8obAfExjVNoBqsS8U1Anch+kCr4D4Zr7d4fLCI=; b=sYGCrpF5Uoyc
 jQuXJcy+BkgQq0nSpx1NyhJ7Rvejy68rDyeP0beUWZA80KwrwS5w5lVmSjDcgwxCbhm0pNpOltznk
 vCczIdizaMu28XZQYUez3ctZSVfbyxbAAZIGiSug6yOewdLsYcvkNnDpZlM2ituTd3rMFIRqxtlyW
 F72a66r6W//Pe0s2ufhLM4HNdsysz9lk8Yam6mEl+bnKjhgo6d8+FOZ9rmzrwCm3xcS9El41Sj6Mw
 TSRHKT24Vy84eyn3uitypRnz9djglp0FxixL+a0mVmg0jU4Cg0yeAvHuPY1x+hCQv+zVVBFqWUnXz
 qH8kPvSPRLNrF9VSTmEq7Q==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1uef3m-008eKJ-27;
 Wed, 23 Jul 2025 21:29:15 +0200
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v2 1/1] qemu-img: add sub-command --remove-all to 'qemu-img
 bitmap'
Date: Wed, 23 Jul 2025 21:29:16 +0200
Message-ID: <20250723192916.1065781-1-den@openvz.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From time to time it is needed to remove all bitmaps from the image.
Before this patch the process is not very convinient. One should
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
CC: Michael Tokarev <mjt@tls.msk.ru>
---
Changes from v1:
* rebased to latest head
* adopted bitmap help to the new layout

 docs/tools/qemu-img.rst |  4 +++-
 qemu-img.c              | 47 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 5e7b85079d..db739ab5c8 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -301,7 +301,7 @@ Command description:
   For write tests, by default a buffer filled with zeros is written. This can be
   overridden with a pattern byte specified by *PATTERN*.
 
-.. option:: bitmap (--merge SOURCE | --add | --remove | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP
+.. option:: bitmap (--merge SOURCE | --add | --remove | --remove-all | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP
 
   Perform one or more modifications of the persistent bitmap *BITMAP*
   in the disk image *FILENAME*.  The various modifications are:
@@ -310,6 +310,8 @@ Command description:
 
   ``--remove`` to remove *BITMAP*.
 
+  ``--remove-all`` to remove all bitmaps.
+
   ``--clear`` to clear *BITMAP*.
 
   ``--enable`` to change *BITMAP* to start recording future edits.
diff --git a/qemu-img.c b/qemu-img.c
index 7a162fdc08..ddd449c1ed 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -86,6 +86,7 @@ enum {
     OPTION_BITMAPS = 275,
     OPTION_FORCE = 276,
     OPTION_SKIP_BROKEN = 277,
+    OPTION_REMOVE_ALL = 278,
 };
 
 typedef enum OutputFormat {
@@ -4992,6 +4993,7 @@ enum ImgBitmapAct {
     BITMAP_ENABLE,
     BITMAP_DISABLE,
     BITMAP_MERGE,
+    BITMAP_REMOVE_ALL,
 };
 typedef struct ImgBitmapAction {
     enum ImgBitmapAct act;
@@ -5010,7 +5012,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
     BlockDriverState *bs = NULL, *src_bs = NULL;
     bool image_opts = false;
     int64_t granularity = 0;
-    bool add = false, merge = false;
+    bool add = false, merge = false, remove_all = false, any = false;
     QSIMPLEQ_HEAD(, ImgBitmapAction) actions;
     ImgBitmapAction *act, *act_next;
     const char *op;
@@ -5026,6 +5028,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
             {"add", no_argument, 0, OPTION_ADD},
             {"granularity", required_argument, 0, 'g'},
             {"remove", no_argument, 0, OPTION_REMOVE},
+            {"remove-all", no_argument, 0, OPTION_REMOVE_ALL},
             {"clear", no_argument, 0, OPTION_CLEAR},
             {"enable", no_argument, 0, OPTION_ENABLE},
             {"disable", no_argument, 0, OPTION_DISABLE},
@@ -5044,8 +5047,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
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
@@ -5060,6 +5063,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
 "     with optional multiplier suffix (in powers of 1024)\n"
 "  --remove\n"
 "     removes BITMAP from FILE\n"
+"  --remove-all\n"
+"     removes all bitmaps from FILE\n"
 "  --clear\n"
 "     clears BITMAP in FILE\n"
 "  --enable, --disable\n"
@@ -5089,7 +5094,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
             act = g_new0(ImgBitmapAction, 1);
             act->act = BITMAP_ADD;
             QSIMPLEQ_INSERT_TAIL(&actions, act, next);
-            add = true;
+            add = any = true;
             break;
         case 'g':
             granularity = cvtnum("granularity", optarg, true);
@@ -5101,28 +5106,38 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
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
@@ -5139,8 +5154,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
     }
 
     if (QSIMPLEQ_EMPTY(&actions)) {
-        error_report("Need at least one of --add, --remove, --clear, "
-                     "--enable, --disable, or --merge");
+        error_report("Need at least one of --add, --remove, --remove-all, "
+                     "--clear, --enable, --disable, or --merge");
         goto out;
     }
 
@@ -5158,10 +5173,14 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
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
@@ -5199,6 +5218,18 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
             qmp_block_dirty_bitmap_remove(bs->node_name, bitmap, &err);
             op = "remove";
             break;
+        case BITMAP_REMOVE_ALL: {
+            while (1) {
+                BdrvDirtyBitmap *bm = bdrv_dirty_bitmap_first(bs);
+                if (bm == NULL) {
+                    break;
+                }
+                qmp_block_dirty_bitmap_remove(bs->node_name,
+                                              bdrv_dirty_bitmap_name(bm), &err);
+            }
+            op = "remove-all";
+            break;
+        }
         case BITMAP_CLEAR:
             qmp_block_dirty_bitmap_clear(bs->node_name, bitmap, &err);
             op = "clear";
-- 
2.45.2


