Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09F4C71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 21:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYtVo-0003tm-8X; Mon, 07 Jul 2025 17:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1uYsuz-0003mB-7c; Mon, 07 Jul 2025 16:58:32 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1uYsuw-00016C-MA; Mon, 07 Jul 2025 16:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=vKJfN/5eI2Tx7cOQbP82vfjVOaa6HYkeO85lIn8f0Ow=; b=iPwNuz0HIlBZ
 Hvtj1HhbeAlIyvL4fTqmDlCb7RimfojLPCN/SXl5j4Qs/d4BhVLBpzDIWGFZnhGVPSMQBJ7WPYyhG
 ada5Td0Ls3ZRFv7i5bQynY3b2lBfP3qYyGNlXCurSsLSTQJpaWqK0I9iv2tboq1mgG5QNYNzknpOV
 W7IpnaQB4hpVdYyOSNBIfoh0VV8zpWRThCRqJoH0udep9nG7svIFfi8VD5PuaVt5lLC8NU0xdVYQG
 Nqhm9F1D5P/ojWXBnzg02ouDBIgA171VMYf3AUVFdqP4NK9mwuP7WHhUnRKqK9wt/9Qq7CLNj47nO
 9TW80vE8cSBMjxl+Kk8CeQ==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1uYspc-006WQT-1F;
 Mon, 07 Jul 2025 22:58:14 +0200
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 1/1] qemu-img: add sub-command --remove-all to 'qemu-img
 bitmap'
Date: Mon,  7 Jul 2025 22:58:22 +0200
Message-ID: <20250707205822.614350-1-den@openvz.org>
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
---
 docs/tools/qemu-img.rst |  4 +++-
 qemu-img.c              | 43 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 3653adb963..a08fd6019f 100644
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
index e75707180d..920ede2a6a 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -86,6 +86,7 @@ enum {
     OPTION_BITMAPS = 275,
     OPTION_FORCE = 276,
     OPTION_SKIP_BROKEN = 277,
+    OPTION_REMOVE_ALL = 278,
 };
 
 typedef enum OutputFormat {
@@ -191,7 +192,7 @@ void help(void)
            "Parameters to bitmap subcommand:\n"
            "  'bitmap' is the name of the bitmap to manipulate, through one or more\n"
            "       actions from '--add', '--remove', '--clear', '--enable', '--disable',\n"
-           "       or '--merge source'\n"
+           "       '--remove-all' or '--merge source'\n"
            "  '-g granularity' sets the granularity for '--add' actions\n"
            "  '-b source' and '-F src_fmt' tell '--merge' actions to find the source\n"
            "       bitmaps from an alternative file\n"
@@ -4770,6 +4771,7 @@ enum ImgBitmapAct {
     BITMAP_ENABLE,
     BITMAP_DISABLE,
     BITMAP_MERGE,
+    BITMAP_REMOVE_ALL,
 };
 typedef struct ImgBitmapAction {
     enum ImgBitmapAct act;
@@ -4788,7 +4790,7 @@ static int img_bitmap(int argc, char **argv)
     BlockDriverState *bs = NULL, *src_bs = NULL;
     bool image_opts = false;
     int64_t granularity = 0;
-    bool add = false, merge = false;
+    bool add = false, merge = false, remove_all = false, any = false;
     QSIMPLEQ_HEAD(, ImgBitmapAction) actions;
     ImgBitmapAction *act, *act_next;
     const char *op;
@@ -4803,6 +4805,7 @@ static int img_bitmap(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"add", no_argument, 0, OPTION_ADD},
             {"remove", no_argument, 0, OPTION_REMOVE},
+            {"remove-all", no_argument, 0, OPTION_REMOVE_ALL},
             {"clear", no_argument, 0, OPTION_CLEAR},
             {"enable", no_argument, 0, OPTION_ENABLE},
             {"disable", no_argument, 0, OPTION_DISABLE},
@@ -4846,34 +4849,44 @@ static int img_bitmap(int argc, char **argv)
             act = g_new0(ImgBitmapAction, 1);
             act->act = BITMAP_ADD;
             QSIMPLEQ_INSERT_TAIL(&actions, act, next);
-            add = true;
+            add = any = true;
             break;
         case OPTION_REMOVE:
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
         case OPTION_OBJECT:
             user_creatable_process_cmdline(optarg);
@@ -4885,8 +4898,8 @@ static int img_bitmap(int argc, char **argv)
     }
 
     if (QSIMPLEQ_EMPTY(&actions)) {
-        error_report("Need at least one of --add, --remove, --clear, "
-                     "--enable, --disable, or --merge");
+        error_report("Need at least one of --add, --remove, --remove-all, "
+                     "--clear, --enable, --disable, or --merge");
         goto out;
     }
 
@@ -4904,10 +4917,14 @@ static int img_bitmap(int argc, char **argv)
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
@@ -4945,6 +4962,18 @@ static int img_bitmap(int argc, char **argv)
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


