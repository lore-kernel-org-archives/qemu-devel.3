Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728B9C624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28fE-0002t4-2Q; Thu, 03 Sep 2026 10:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28fB-0002q5-OT
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:37 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28f9-00046O-CC
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:37 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49b9320423cso25048235e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446613; x=1789051413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pypRYc8/MXO/3Of6gj2N/hRoWJoad4/u2unBbe1Pxck=;
 b=kzclihgMedgJNifBMd9A9RY0DOEizvejJlbtR0mPpNU/F/8YeyhXPE1vIIVYWOzSiz
 Fwk2vMBQeoL1lQ9R9V4gnpx6Msr3SmkrgfGKA+xwkvcC2XIDc7s7FBtZwtmGzNNICoZY
 +PWe9pAqfqUZ7p+c17VX9aVP3jo//4dQ9nzw+hIb4DH6a3fdHrEMSchhaFYz/EFh05kV
 gZ+SaHt833fSHuFLV2Sglw3hZThWUwGSm0G4gccEOt2I4kxvyS3p4rRb4DcXpOhQosz7
 Srlw6/sOyVSCzewePSdV6V0fSHrECl9BXCmfsyuwWetGT4XFRWrx7sNNZuolvsASdXFb
 luaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446613; x=1789051413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pypRYc8/MXO/3Of6gj2N/hRoWJoad4/u2unBbe1Pxck=;
 b=Rxq1HwveUwDFcqddG+XyjHt+0tg3I+TUJZZkAzLdzy/2JDp60w/aBiIKerzJofPaVr
 AryWulDbDBwVCKdZET5rL8mhKq5ZgdGMHC7KTmRZBJkRJQITGIW2hanVt+lmrAcj55SX
 U7t7t00Z+UPW7j0vn93oTuH8efCd+/HhVPf42lnr66oZEJt7GOtfKmTxTYe7puybY4Ks
 AfFW9vORLovsmnSJBmKLbIIqrDCLAJxt2vGSb81YcbkSR1cq1YCcyUCG6RhY6tHG9jci
 SKas9Dt2NZh6AGl/qk2PLmnOSHLROROlbTcGJoM4hjOXOK950naCBOf48KiGKjZoI6HC
 VNkA==
X-Gm-Message-State: AFuF++maUfjGyGber8vXUKRfcbs29oF4LPiZN/HJNHH5q3unXvhQ/Qyu
 G8U2/9MHyUcs1MbJeoub99NitgOTc8VYo+EluVoO3xCJkXwJCXOISJpenOby6oaRBCHw4uK4tYx
 ToPYz
X-Gm-Gg: AYBFou1+fn5R+jP4WOZmiIGavzKs4rEGYBURFWrM+Abiim3bsO6g2x0vkOPdm81O00G
 dEmMd0WFWqOCG50ICUz9GZF1VAE0NHDaoyhXwg9AFRp0kkX3NdEfzpGpP9eVfqkHOx5lrLZel7i
 moRewhX8svvkY58ZsLSjg38SeSWMK0w8/h3ZZvU2Pc8UNyuoA5tPlSI02ArlXNm0WvQAFSEat67
 y83sN3ZebeV+b0adoPOj7J++MKA/ZgO4ECFHpYcL4MCCBehZkk88jvk1tAyIA+I76f0wTguAahO
 jIAzO9yFPWLhRY0oZkZ5u3p98o+S5lqda5QPLk7VA1+2oo9b/7dbZ46j3rC64YgB3Ck4ve9bXTz
 T2swZvFlC4BbyrENmm0lkC8MWB5MePWsbwuu3aSwFHaGWsE4zpiIpKOdApbwRgUIAe6z+0Uq5vk
 PHyNn7M2CEjF5rAhhSbmB8Ph1pwPj967m5pm/i/52NfXXtyDox1Jw15ij6
X-Received: by 2002:a05:600c:83c8:b0:49c:d52e:d0ea with SMTP id
 5b1f17b1804b1-49ce581779dmr242705875e9.4.1788446613338; 
 Thu, 03 Sep 2026 07:43:33 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:43:32 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v7 19/25] parallels: report the stored dirty bitmaps in
 qemu-img info
Date: Thu,  3 Sep 2026 16:41:37 +0200
Message-ID: <20260903144143.2328870-20-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144143.2328870-1-den@openvz.org>
References: <20260903144143.2328870-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=den@openvz.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Denis V. Lunev <den@openvz.org>

Nothing tells which persistent bitmaps an image carries. qemu-img info
says nothing about them, and the only other way to see one is to export
the image over NBD and ask for a bitmap by name, which needs the name
beforehand.

Add ImageInfoSpecificParallels with the bitmaps and their granularity,
in the same way as qcow2 reports the contents of its bitmap directory:

    Format specific information:
        bitmaps:
            [0]:
                name: b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45
                granularity: 65536

For running VM process the list is built on the fly from in-memory
list. This is the best we can do. FormatExtension could be dead in
the image while VMs are running as all bitmaps are cleared on
non-clean VM stop.

A bitmap of an image which was not closed correctly is inconsistent
and can not be used. Report that as well, the way qcow2 reports its
in-use flag, so such a bitmap is not listed as a valid one.

The section is left empty for an image with no persistent dirty
bitmaps, and an empty section is not printed, so the human readable
output of "qemu-img info" and "info block" is unchanged.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c                         | 26 +++++++++++
 block/parallels.c                             | 20 ++++++++
 block/parallels.h                             |  3 ++
 qapi/block-core.json                          | 46 ++++++++++++++++++-
 tests/qemu-iotests/tests/parallels-checks     |  6 +++
 tests/qemu-iotests/tests/parallels-checks.out | 19 ++++++++
 6 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index f687f2da7c..8b8035af91 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -736,3 +736,29 @@ parallels_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
 
     return ret;
 }
+
+void parallels_get_bitmap_info_list(BlockDriverState *bs,
+                                    ParallelsBitmapInfoList **info_list)
+{
+    BdrvDirtyBitmap *bitmap;
+    ParallelsBitmapInfoList **tail = info_list;
+
+    *info_list = NULL;
+
+    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
+        ParallelsBitmapInfo *info;
+
+        if (!bdrv_dirty_bitmap_get_persistence(bitmap)) {
+            continue;
+        }
+
+        info = g_new0(ParallelsBitmapInfo, 1);
+        info->name = g_strdup(bdrv_dirty_bitmap_name(bitmap));
+        info->granularity = bdrv_dirty_bitmap_granularity(bitmap);
+        if (bdrv_dirty_bitmap_inconsistent(bitmap)) {
+            info->has_inconsistent = true;
+            info->inconsistent = true;
+        }
+        QAPI_LIST_APPEND(tail, info);
+    }
+}
diff --git a/block/parallels.c b/block/parallels.c
index 2a5ceb8978..e7d65d0458 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1624,6 +1624,25 @@ static bool parallels_is_support_dirty_bitmaps(BlockDriverState *bs)
     return 1;
 }
 
+static ImageInfoSpecific * GRAPH_RDLOCK
+parallels_get_specific_info(BlockDriverState *bs, Error **errp)
+{
+    ImageInfoSpecificParallels *parallels_info;
+    ImageInfoSpecific *spec_info;
+
+    parallels_info = g_new0(ImageInfoSpecificParallels, 1);
+    parallels_get_bitmap_info_list(bs, &parallels_info->bitmaps);
+    parallels_info->has_bitmaps = !!parallels_info->bitmaps;
+
+    spec_info = g_new(ImageInfoSpecific, 1);
+    *spec_info = (ImageInfoSpecific){
+        .type = IMAGE_INFO_SPECIFIC_KIND_PARALLELS,
+        .u.parallels.data = parallels_info,
+    };
+
+    return spec_info;
+}
+
 static BlockDriver bdrv_parallels = {
     .format_name                = "parallels",
     .instance_size              = sizeof(BDRVParallelsState),
@@ -1653,6 +1672,7 @@ static BlockDriver bdrv_parallels = {
                                   parallels_co_can_store_new_dirty_bitmap,
     .bdrv_co_remove_persistent_dirty_bitmap =
                                   parallels_co_remove_persistent_dirty_bitmap,
+    .bdrv_get_specific_info     = parallels_get_specific_info,
 };
 
 static void bdrv_parallels_init(void)
diff --git a/block/parallels.h b/block/parallels.h
index 27d8c3ac83..012f47320b 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -32,6 +32,7 @@
 #ifndef BLOCK_PARALLELS_H
 #define BLOCK_PARALLELS_H
 #include "qemu/coroutine.h"
+#include "qapi/qapi-types-block-core.h"
 
 #define HEADS_NUMBER 16
 #define SEC_IN_CYL 32
@@ -111,5 +112,7 @@ parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
 int coroutine_fn GRAPH_RDLOCK
 parallels_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
                                             const char *name, Error **errp);
+void parallels_get_bitmap_info_list(BlockDriverState *bs,
+                                    ParallelsBitmapInfoList **info_list);
 
 #endif
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 199efc1e00..7499aea641 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -188,6 +188,35 @@
       '*extent-size-hint': 'size'
   } }
 
+##
+# @ParallelsBitmapInfo:
+#
+# Parallels dirty bitmap information.
+#
+# @name: the name of the bitmap
+#
+# @granularity: granularity of the bitmap in bytes
+#
+# @inconsistent: true if the bitmap was improperly stored and cannot
+#     be used
+#
+# Since: 11.2
+##
+{ 'struct': 'ParallelsBitmapInfo',
+  'data': { 'name': 'str', 'granularity': 'uint32',
+            '*inconsistent': 'bool' } }
+
+##
+# @ImageInfoSpecificParallels:
+#
+# @bitmaps: A list of the persistent dirty bitmaps of the image,
+#     including the ones which are not written out yet
+#
+# Since: 11.2
+##
+{ 'struct': 'ImageInfoSpecificParallels',
+  'data': { '*bitmaps': ['ParallelsBitmapInfo'] } }
+
 ##
 # @ImageInfoSpecificKind:
 #
@@ -197,10 +226,12 @@
 #
 # @file: Since 8.0
 #
+# @parallels: Since 11.2
+#
 # Since: 1.7
 ##
 { 'enum': 'ImageInfoSpecificKind',
-  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file' ] }
+  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file', 'parallels' ] }
 
 ##
 # @ImageInfoSpecificQCow2Wrapper:
@@ -255,6 +286,16 @@
 { 'struct': 'ImageInfoSpecificFileWrapper',
   'data': { 'data': 'ImageInfoSpecificFile' } }
 
+##
+# @ImageInfoSpecificParallelsWrapper:
+#
+# @data: image information specific to Parallels
+#
+# Since: 11.2
+##
+{ 'struct': 'ImageInfoSpecificParallelsWrapper',
+  'data': { 'data': 'ImageInfoSpecificParallels' } }
+
 ##
 # @ImageInfoSpecific:
 #
@@ -273,7 +314,8 @@
       'vmdk': 'ImageInfoSpecificVmdkWrapper',
       'luks': 'ImageInfoSpecificLUKSWrapper',
       'rbd': 'ImageInfoSpecificRbdWrapper',
-      'file': 'ImageInfoSpecificFileWrapper'
+      'file': 'ImageInfoSpecificFileWrapper',
+      'parallels': 'ImageInfoSpecificParallelsWrapper'
   } }
 
 ##
diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index 575b736e35..84eb526f44 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -382,6 +382,9 @@ echo "== dirty a single granule of the bitmap =="
 file_size=`stat --printf="%s" "$TEST_IMG"`
 echo "file size: $file_size"
 
+echo "== the bitmap is reported by qemu-img info =="
+_img_info --format-specific
+
 echo "== the extension and its bitmap data are not a leak =="
 _check_test_img
 
@@ -425,6 +428,9 @@ $QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" $BITMAP 2>&1 | _filter_testdir
 echo "== pretend the image was not closed correctly =="
 poke_file "$TEST_IMG" "$INUSE_OFFSET" "\x59\x6e\x6f\x74"
 
+echo "== a read-only open still reports it, marked inconsistent =="
+_img_info --format-specific
+
 echo "== the bitmap is stale, so it can not be used and is dropped =="
 $QEMU_IMG bitmap --clear -f $IMGFMT "$TEST_IMG" $BITMAP 2>&1 | _filter_testdir
 
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index f390ea90d4..c6d9445440 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -241,6 +241,15 @@ qemu-img: Operation add on bitmap bitmap0 failed: Bitmap name must be a UUID to
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 file size: 4194304
+== the bitmap is reported by qemu-img info ==
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 4 MiB (4194304 bytes)
+Format specific information:
+    bitmaps:
+        [0]:
+            name: b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45
+            granularity: 65536
 == the extension and its bitmap data are not a leak ==
 No errors were found on the image.
 == extend image by 1 cluster ==
@@ -273,6 +282,16 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == pretend the image was not closed correctly ==
+== a read-only open still reports it, marked inconsistent ==
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 4 MiB (4194304 bytes)
+Format specific information:
+    bitmaps:
+        [0]:
+            name: b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45
+            granularity: 65536
+            inconsistent: true
 == the bitmap is stale, so it can not be used and is dropped ==
 Repairing image was not closed correctly
 qemu-img: Operation clear on bitmap b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45 failed: Bitmap 'b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45' is inconsistent and cannot be used
-- 
2.53.0


