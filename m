Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA542C3ABCB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 01:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEeYk-0002Gp-RK; Mon, 12 May 2025 21:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uEeYi-0002Ez-AG; Mon, 12 May 2025 21:35:52 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uEeYf-00021S-VD; Mon, 12 May 2025 21:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=+L+BU/R0UiYOQwIozPYQoIx70UFXZ5v2qWVT4AX4P+k=; b=NunU+OlPGWG5
 LSJYo929eb6VBFhzL7W4jiA4pDRDuawj0nwHUzXmz3DnJCRiZeEygk48Vbr4wPBkVDREAp99fbI7Y
 jSffTuBvXystnAvZNmKSzmF2ROG0Ml+Yc50XL42OMsqK7s/Kuc3f+H0uJZas78Ah0B4BrPTjub96w
 ZKPp41DFHCI4bX3ntF2pomPzzJOxb4QvLWx4/lJUxGUS/cxq502G+o610dyFaiuQog4jTPEczQ6rq
 VuHde+tHVLYaFu/gfLQ8JuCWHfnjd3ryyxGk3iM8v9N4HZN8PS1Y2k+7NLlBNaBVubGI003i3ndy2
 Ho6SVyZPDsSPUleyxG2yFg==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=debian.fritz.box)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uEeUe-00DboQ-1z; Tue, 13 May 2025 03:35:37 +0200
From: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
To: qemu-block@nongnu.org,
	vsementsov@yandex-team.ru,
	eblake@redhat.com
Cc: jsnow@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-devel@nongnu.org, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 2/4] hbitmap: introduce hbitmap_reverse()
Date: Tue, 13 May 2025 03:32:36 +0200
Message-ID: <20250513013238.1213539-3-andrey.zhadchenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250513013238.1213539-1-andrey.zhadchenko@virtuozzo.com>
References: <20250513013238.1213539-1-andrey.zhadchenko@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.zhadchenko@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

and bdrv_dirty_bitmap_reverse() helper

Signed-off-by: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
---
 block/dirty-bitmap.c         |  9 +++++++++
 include/block/block_int-io.h |  1 +
 include/qemu/hbitmap.h       |  8 ++++++++
 util/hbitmap.c               | 15 +++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 13a1979755..c7f453fdb9 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -888,3 +888,12 @@ void bdrv_dirty_bitmap_merge_internal(BdrvDirtyBitmap *dest,
         }
     }
 }
+
+void bdrv_dirty_bitmap_reverse(BdrvDirtyBitmap *bitmap)
+{
+    assert(!bdrv_dirty_bitmap_readonly(bitmap));
+    assert(!bdrv_dirty_bitmap_inconsistent(bitmap));
+    bdrv_dirty_bitmaps_lock(bitmap->bs);
+    hbitmap_reverse(bitmap->bitmap);
+    bdrv_dirty_bitmaps_unlock(bitmap->bs);
+}
diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index 4a7cf2b4fd..093613e7d1 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -109,6 +109,7 @@ void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out);
 void bdrv_dirty_bitmap_merge_internal(BdrvDirtyBitmap *dest,
                                       const BdrvDirtyBitmap *src,
                                       HBitmap **backup, bool lock);
+void bdrv_dirty_bitmap_reverse(BdrvDirtyBitmap *bitmap);
 
 void bdrv_inc_in_flight(BlockDriverState *bs);
 void bdrv_dec_in_flight(BlockDriverState *bs);
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index 8136e33674..dbdc9aa2d4 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -350,4 +350,12 @@ bool hbitmap_status(const HBitmap *hb, int64_t start, int64_t count,
  */
 int64_t hbitmap_iter_next(HBitmapIter *hbi);
 
+/**
+ * hbitmap_reverse:
+ * @bitmap: The HBitmap to operate on
+ *
+ * Reverse the bits in the bitmap.
+ */
+void hbitmap_reverse(HBitmap *bitmap);
+
 #endif
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 16674f33e4..b99c4b1eec 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -940,3 +940,18 @@ char *hbitmap_sha256(const HBitmap *bitmap, Error **errp)
 
     return hash;
 }
+
+void hbitmap_reverse(HBitmap *bitmap)
+{
+    int64_t pnum, pos = 0;
+    int64_t size = bitmap->orig_size;
+
+    while (pos < size) {
+        if (hbitmap_status(bitmap, pos, size - pos, &pnum)) {
+            hbitmap_reset(bitmap, pos, pnum);
+        } else {
+            hbitmap_set(bitmap, pos, pnum);
+        }
+        pos += pnum;
+    }
+}
-- 
2.43.0


