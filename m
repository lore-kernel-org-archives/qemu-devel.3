Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A6FC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2ax-0001rw-LV; Mon, 17 Aug 2026 15:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2ZE-0006Kr-7B
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:18 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Z7-0006Su-V9
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:14 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4956242332dso39995265e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993207; x=1787598007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yXQS0EBGFNdPvTyVdgIL9AVWBxhmkphkllpyggxSxkI=;
 b=Bzetl2BWfKJsCW1WRu1dEeEvqL+fiOxACPNp+bURhtjkvd19Z2kupE26brdnfOsjqA
 SD2xOhV8BlcCS3vFlaaBLRel3gwxwS/PnXmUcVIZIiY30rDyHpl01wgjzlOCdtxpXSKE
 28wbP+am7Ap9BNjLSdVOCwDjIVmqtDiAzIBis+9yixHEu5cHC5+5ReVrvBzQBTUFYbNc
 /Kh1NaNsqdVPmE+RWD3qLMD5Ct6+JlQA7lxyKmXjSTGPaNmqQ1wXsoERYcY1VeG2pDVS
 L1nMvau8e4jCWPNEIh0ymhH4yOfbE/HVtqmAsw94QUg/gW+dPcnrqODT4UGEdsGFOcDn
 Mr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993207; x=1787598007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yXQS0EBGFNdPvTyVdgIL9AVWBxhmkphkllpyggxSxkI=;
 b=Djd5+v7OwrvDbgyxZ9hVEV/tsL8M5ur24Fju4HQHxiymtU1XL43odDAaFosolAHumL
 d+Pv4CLtRC0lrDPD/rVR6KhJnkzUAwffeVmP9+n2mLAxCYr2CIwE3GJ/kUKuuaL4oP8J
 nR+29IStfzvkqjaGGcJSssPiS2wBPYwe/Yb02G1hgZlVscViWnGagHVhaBoJGt6moTmN
 uwJ2hy/D2+VRoHh8tIUErzFTVRVmU09m4iFjvpgVcViKPRSnt4DFREc68nwIHczb7IFG
 sBGeBSXdAyuIZudL1gfTplsbMpIWDa5+urYXE5iDEP7kmtf4qtjuYOBhi/McZnlYy0Ui
 cWLg==
X-Gm-Message-State: AOJu0YwpWOVM5U5VCkJ634rGF0jVE7vd4tlAzLUkGqR79a4x7luh3HN/
 k5VMA36jmOSbVJ8HlEKdOYTNHnU5yt2mHJGY1lY+gc3IZR2RTpAWtlM4c9DKoeHBZMuDiisF0QI
 pzaOI
X-Gm-Gg: AR+sD13EN1BtFDqd9EtA6aT3H0ouzg6n4EwTC2mmXIknp7A3hXboEGH/pErzn9yiamQ
 pu6M6EPNtmK1HqUdoriJ92T7WCEs1Mx0gxDC1RpiN/w6a5p/1hCgOrmTiyREreQM3uyA92r+30F
 wh1pDiYXK8n5UUXWVATW0kstekCLnufgPJL9H+RJ0zMEC914Ec89SeBzPtvItXsUbd+nuZzInKA
 9w/xge11l35OHeBbke8OIQP0DWkOn0kMyNp+MBH0qSTMy6XIGlHqLhbtv1OGtKu4+zF4GX9A/wC
 kh7emkccaXyCjYquS6axw/TKvCYRThJRpi6OsjPGHKuFPXgzP3IYpsJ3FP854j1FwHA4LB/wklD
 HclA7yyBIfP/+pyTAwJ+JGrAnLIkHIgkxfnFuki/qQWYnqWKzR9NVroOMt6DpT/aDkSm067G1ss
 Eshp6mV70zEVhdYaKzzPHbmwwDAJfQWR6QZfs0WNSwnUPQX6e6fw==
X-Received: by 2002:a05:600c:6051:b0:499:737c:8a8b with SMTP id
 5b1f17b1804b1-49987980774mr288986705e9.12.1786993207093; 
 Mon, 17 Aug 2026 12:00:07 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.12.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 12:00:06 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v6 19/25] parallels: report the stored dirty bitmaps in
 qemu-img info
Date: Mon, 17 Aug 2026 20:59:36 +0200
Message-ID: <20260817185942.1065143-20-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=den@openvz.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
as qcow2 reports the contents of its bitmap directory:

    Format specific information:
        bitmaps:
            [0]:
                name: b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45
                granularity: 65536

The list is built from the bitmaps loaded at open time rather than from
a second pass over the Format Extension, as every bitmap the extension
carries is loaded and marked persistent there. On a node which is open
that also covers a bitmap which was created but not stored yet, which is
what the field says: qemu-img info opens the image on its own, so there
the two are the same thing.

An image with no bitmaps leaves the structure empty, and
bdrv_image_info_specific_dump() prints nothing for an empty one, so the
output for such an image does not change.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c                         | 22 ++++++++++
 block/parallels.c                             | 20 ++++++++++
 block/parallels.h                             |  3 ++
 qapi/block-core.json                          | 40 ++++++++++++++++++-
 tests/qemu-iotests/tests/parallels-checks     |  3 ++
 tests/qemu-iotests/tests/parallels-checks.out |  9 +++++
 6 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index f687f2da7c..ad87ecfbc1 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -736,3 +736,25 @@ parallels_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
 
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
index 1f87b07850..4bc8b45efe 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -200,7 +200,7 @@
 # Since: 1.7
 ##
 { 'enum': 'ImageInfoSpecificKind',
-  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file' ] }
+  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file', 'parallels' ] }
 
 ##
 # @ImageInfoSpecificQCow2Wrapper:
@@ -255,6 +255,41 @@
 { 'struct': 'ImageInfoSpecificFileWrapper',
   'data': { 'data': 'ImageInfoSpecificFile' } }
 
+##
+# @ParallelsBitmapInfo:
+#
+# Parallels dirty bitmap information.
+#
+# @name: the name of the bitmap
+#
+# @granularity: granularity of the bitmap in bytes
+#
+# Since: 11.2
+##
+{ 'struct': 'ParallelsBitmapInfo',
+  'data': { 'name': 'str', 'granularity': 'uint32' } }
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
@@ -273,7 +308,8 @@
       'vmdk': 'ImageInfoSpecificVmdkWrapper',
       'luks': 'ImageInfoSpecificLUKSWrapper',
       'rbd': 'ImageInfoSpecificRbdWrapper',
-      'file': 'ImageInfoSpecificFileWrapper'
+      'file': 'ImageInfoSpecificFileWrapper',
+      'parallels': 'ImageInfoSpecificParallelsWrapper'
   } }
 
 ##
diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index 916d423a64..4c8fc17fa9 100755
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
 
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index 4dfadd68d6..7aaa4636d7 100644
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
-- 
2.53.0


