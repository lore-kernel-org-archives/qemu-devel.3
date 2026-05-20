Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36CFCD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 00:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPqpZ-0007Mx-KC; Wed, 20 May 2026 20:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wPqpT-0007Lq-SW
 for qemu-devel@nongnu.org; Wed, 20 May 2026 20:00:00 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wPqpQ-0004K6-Ru
 for qemu-devel@nongnu.org; Wed, 20 May 2026 19:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=gI574Q6i5IiZa/P07RmFJJpL4OtgdZJnV8/bmztq26o=; b=CyfiHg3DZ1O+
 cCpZNJ8phP9V89raNss+0/As9bCp8bb5zXEctCou7vt7IMgCrmaew/e5coju8C9g3XB54AA/lXN5e
 mju0rcjIdO4MVTY4LbhcnjEbdNV1YX6CbRmJGaLTQDIn6/24Vc86cw594B3AL7a3lXJlyj23NgOVp
 OJlrZdYfsanDhyn0BcKRGbpRMNpckr4u07ry6JKwI9EgGW56me1H3yT4x2AsOXi7PktQOwtaR4ilo
 MsNtMLNZjUx720FZOglLFxsufzsZEQGTsAbas5k7D0/THqYGWrmEAMYVy/U5Pg4QHYmkR5rhe3YKu
 N5gzaBcR6KotIBxkpLAWRw==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1wPqm2-007GJa-0H;
 Thu, 21 May 2026 01:59:51 +0200
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 1/1] qemu-img: add sub-command --remove-all to 'qemu-img
 bitmap'
Date: Thu, 21 May 2026 01:59:52 +0200
Message-ID: <20260520235952.500250-1-den@openvz.org>
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

The patch adds --remove-all sub-command to 'qemu-img bitmap'. The
new sub-command also composes with other bitmap actions in the same
invocation, so a common "wipe and recreate" workflow can be expressed
as
    qemu-img bitmap --remove-all --add NEW FILE
instead of enumerating existing bitmaps, removing them one by one,
and only then adding the fresh one.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
---
Changes from v3:
* renamed 'any' to 'need_bitmap_name' for clarity (Kevin)
* dropped the redundant 'remove_all' flag; an empty actions list is
  already caught earlier, so '!need_bitmap_name' alone is sufficient
  to detect the --remove-all-only case (Kevin)
* one assignment per line for the action flags (Kevin)
* simplified the BITMAP_REMOVE_ALL loop to the inline-assignment
  while ((bm = bdrv_dirty_bitmap_first(bs))) form (Kevin)
* corrected the inline --help synopsis to show FILE [BITMAP], matching
  the .rst
* rewrote the parser-side comment to spell out the invariant and to
  call out that '--remove-all --add foo' is a supported composition
* expanded the commit message to motivate the wipe-and-recreate flow
* added iotest coverage in tests/qemu-iotests/tests/qemu-img-bitmaps
  for the basic sweep and the --remove-all --add composition

Changes from v2:
* rebased to the lastest head

Changes from v1:
* rebased to latest head
* adopted bitmap help to the new layout

 docs/tools/qemu-img.rst                       | 10 +++-
 qemu-img.c                                    | 55 ++++++++++++++++---
 tests/qemu-iotests/tests/qemu-img-bitmaps     | 24 ++++++++
 tests/qemu-iotests/tests/qemu-img-bitmaps.out | 46 ++++++++++++++++
 4 files changed, 125 insertions(+), 10 deletions(-)

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
index c42dd4e995..2f63d31141 100644
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
+    bool add = false, merge = false, need_bitmap_name = false;
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
@@ -5070,9 +5073,9 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
         switch (c) {
         case 'h':
             cmd_help(ccmd, "[-f FMT | --image-opts]\n"
-"        ( --add [-g SIZE] | --remove | --clear | --enable | --disable |\n"
-"          --merge SOURCE [-b SRC_FILE [-F SRC_FMT]] )..\n"
-"        [--object OBJDEF] FILE BITMAP\n"
+"        ( --add [-g SIZE] | --remove | --remove-all | --clear | --enable |\n"
+"          --disable | --merge SOURCE [-b SRC_FILE [-F SRC_FMT]] )..\n"
+"        [--object OBJDEF] FILE [BITMAP]\n"
 ,
 "  -f, --format FMT\n"
 "     specify FILE format explicitly (default: probing is used)\n"
@@ -5086,6 +5089,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
 "     with optional multiplier suffix (in powers of 1024)\n"
 "  --remove\n"
 "     removes BITMAP from FILE\n"
+"  --remove-all\n"
+"     removes all bitmaps from FILE\n"
 "  --clear\n"
 "     clears BITMAP in FILE\n"
 "  --enable, --disable\n"
@@ -5116,6 +5121,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
             act->act = BITMAP_ADD;
             QSIMPLEQ_INSERT_TAIL(&actions, act, next);
             add = true;
+            need_bitmap_name = true;
             break;
         case 'g':
             granularity = cvtnum("granularity", optarg, true);
@@ -5127,21 +5133,30 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
             act = g_new0(ImgBitmapAction, 1);
             act->act = BITMAP_REMOVE;
             QSIMPLEQ_INSERT_TAIL(&actions, act, next);
+            need_bitmap_name = true;
+            break;
+        case OPTION_REMOVE_ALL:
+            act = g_new0(ImgBitmapAction, 1);
+            act->act = BITMAP_REMOVE_ALL;
+            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
             break;
         case OPTION_CLEAR:
             act = g_new0(ImgBitmapAction, 1);
             act->act = BITMAP_CLEAR;
             QSIMPLEQ_INSERT_TAIL(&actions, act, next);
+            need_bitmap_name = true;
             break;
         case OPTION_ENABLE:
             act = g_new0(ImgBitmapAction, 1);
             act->act = BITMAP_ENABLE;
             QSIMPLEQ_INSERT_TAIL(&actions, act, next);
+            need_bitmap_name = true;
             break;
         case OPTION_DISABLE:
             act = g_new0(ImgBitmapAction, 1);
             act->act = BITMAP_DISABLE;
             QSIMPLEQ_INSERT_TAIL(&actions, act, next);
+            need_bitmap_name = true;
             break;
         case OPTION_MERGE:
             act = g_new0(ImgBitmapAction, 1);
@@ -5149,6 +5164,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
             act->src = optarg;
             QSIMPLEQ_INSERT_TAIL(&actions, act, next);
             merge = true;
+            need_bitmap_name = true;
             break;
         case 'b':
             src_filename = optarg;
@@ -5165,8 +5181,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
     }
 
     if (QSIMPLEQ_EMPTY(&actions)) {
-        error_report("Need at least one of --add, --remove, --clear, "
-                     "--enable, --disable, or --merge");
+        error_report("Need at least one of --add, --remove, --remove-all, "
+                     "--clear, --enable, --disable, or --merge");
         goto out;
     }
 
@@ -5184,11 +5200,22 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
         goto out;
     }
 
-    if (optind != argc - 2) {
+    if (need_bitmap_name && optind != argc - 2) {
         error_report("Expecting filename and bitmap name");
         goto out;
     }
 
+    /*
+     * Every action other than --remove-all sets need_bitmap_name, so
+     * !need_bitmap_name means the only action(s) given were --remove-all
+     * and the BITMAP positional argument must be omitted. Combinations
+     * like '--remove-all --add foo' remain valid via the branch above.
+     */
+    if (!need_bitmap_name && optind != argc - 1) {
+        error_report("Expecting filename");
+        goto out;
+    }
+
     filename = argv[optind];
     bitmap = argv[optind + 1];
 
@@ -5225,6 +5252,20 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
             qmp_block_dirty_bitmap_remove(bs->node_name, bitmap, &err);
             op = "remove";
             break;
+        case BITMAP_REMOVE_ALL: {
+            BdrvDirtyBitmap *bm;
+            while ((bm = bdrv_dirty_bitmap_first(bs))) {
+                const char *name = bdrv_dirty_bitmap_name(bm);
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
diff --git a/tests/qemu-iotests/tests/qemu-img-bitmaps b/tests/qemu-iotests/tests/qemu-img-bitmaps
index 7a3fe8c3d3..979bc0d6c9 100755
--- a/tests/qemu-iotests/tests/qemu-img-bitmaps
+++ b/tests/qemu-iotests/tests/qemu-img-bitmaps
@@ -161,6 +161,30 @@ $QEMU_IMG convert --bitmaps -O qcow2 "$TEST_IMG" "$TEST_IMG.copy"
 TEST_IMG="$TEST_IMG.copy" _img_info --format-specific \
     | _filter_irrelevant_img_info
 
+echo
+echo "=== Check --remove-all ==="
+echo
+
+# Start from a fresh image so prior state does not bleed into the assertions
+_rm_test_img "$TEST_IMG"
+_make_test_img 10M
+$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" b0
+$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" b1
+$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" b2
+_img_info --format-specific | _filter_irrelevant_img_info
+
+# Sweep every bitmap in a single command, no BITMAP positional
+echo
+$QEMU_IMG bitmap --remove-all -f $IMGFMT "$TEST_IMG"
+_img_info --format-specific | _filter_irrelevant_img_info
+
+# Wipe + recreate in one invocation: only 'fresh' should remain
+echo
+$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" b0
+$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" b1
+$QEMU_IMG bitmap --remove-all --add -f $IMGFMT "$TEST_IMG" fresh
+_img_info --format-specific | _filter_irrelevant_img_info
+
 # success, all done
 echo '*** done'
 rm -f $seq.full
diff --git a/tests/qemu-iotests/tests/qemu-img-bitmaps.out b/tests/qemu-iotests/tests/qemu-img-bitmaps.out
index 74b81f703b..99290d3ba5 100644
--- a/tests/qemu-iotests/tests/qemu-img-bitmaps.out
+++ b/tests/qemu-iotests/tests/qemu-img-bitmaps.out
@@ -180,4 +180,50 @@ Format specific information:
             name: b2
             granularity: 65536
     corrupt: false
+
+=== Check --remove-all ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=10485760
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 10 MiB (10485760 bytes)
+cluster_size: 65536
+Format specific information:
+    bitmaps:
+        [0]:
+            flags:
+                [0]: auto
+            name: b0
+            granularity: 65536
+        [1]:
+            flags:
+                [0]: auto
+            name: b1
+            granularity: 65536
+        [2]:
+            flags:
+                [0]: auto
+            name: b2
+            granularity: 65536
+    corrupt: false
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 10 MiB (10485760 bytes)
+cluster_size: 65536
+Format specific information:
+    corrupt: false
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 10 MiB (10485760 bytes)
+cluster_size: 65536
+Format specific information:
+    bitmaps:
+        [0]:
+            flags:
+                [0]: auto
+            name: fresh
+            granularity: 65536
+    corrupt: false
 *** done
-- 
2.51.0


