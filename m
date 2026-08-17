Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE43C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2aV-0007DB-V9; Mon, 17 Aug 2026 15:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Yv-00061t-LC
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:59:58 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Ys-0006NU-3Q
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:59:57 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-495590dde14so47149895e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 11:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993192; x=1787597992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RXDsLBu8joIphrEfoyGx6K2aDXa33qspSB71iT/LF3I=;
 b=tSBiiXRmx7w6IKWfHg2ZeUbkughuY9dNNMI9vv8NjXYxMd+9XgpPP9ZEW34l5A68o9
 MMS8uAZKg+dailO1HpLGuRLXyVSb+jnCiBM6ckUtLWFBym4oVO6qDrPwXpJyt9lS7F0z
 AnJqw0/CmfzqqS7Gn9MxO3YBh5THdFi7S1b5AGBVQzn0NZR3HZ+VGAuCLhh4E85YkYZu
 5wEqFZGdgMIwLr6UCZMbLGTk0FqYRdogaRP87WGOilqV3y1OHOigWrl/wq2LkKRtKPBi
 q9IdX3sD/GtsX31nMV3BJUZKbov9I2Tz8dLYgJdsrkZa3Rw6FcS/Wao8J6ccZczSVU/X
 6bmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993192; x=1787597992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RXDsLBu8joIphrEfoyGx6K2aDXa33qspSB71iT/LF3I=;
 b=DAy/2/4IlyPa2wvAP7VbWtGceKtMce8DwjQkoSRZSScP80WPVRxVtjuZb2tpwx6GK+
 a0XbbNj9RB/q8VpZ4RlM5boR2fhGgoi72RELtue5qCUrjN7zRas7a3hlzUE2O/nGYufp
 fZWRTyYhel59r+nbzgw14h4XN2ek7EWZc3Nxh4JlI97+maWFG9XhJ3F2ATIrCcOTSOxn
 IMnQ9wro92n6hzhrQPEFrmmPWJJKmCLqVTptPiAg00j0bmT1ZleYai6WlM3G6KvUxAbk
 vdQxKCOguJdixdMkHQmEni3aW/YNZoSj6sy17rpSQ/DyoEPPhX8u/qMGTQmvpAyFFzUe
 kCug==
X-Gm-Message-State: AOJu0YyanyKoxQXqM2dIcxyiptEneJ8Y5KwLmJay6mTz//RhkvyjMKns
 RxpxnPT8ZFIC2zn9dmFZCK3BR15qFsBn5pdHFgxlueRowYR5XIbQDcLBSInXeiQW9k7Te2a0I0v
 kjN7S
X-Gm-Gg: AR+sD101IDFY+hNPnxzzioeQNkN5qghkhDVTAiSJbTApfgANqE31ZJHPV0DrD2T1o+l
 yzLGKh5391Dw6eY1QQm0wcGZoat9vYHwTmfgGIP/6ZuAoR9W7h5ztCmiMbJZGsbWt+wz63+U/bo
 dCVT2vVY3vdRTqhQoHx2mIhPxHftcAW5Cj3yDBTkhWvQC7WAo/hWs4iXO+wwisajBBag3ZZO2Xv
 VsEQEL8S4IVgU9yRdP5ZXo75nktcvpFv7zk0FzxD0zGfU3s/9mc7UNX2kMQzFej2SKHax6eXI94
 De5S7HT4b0Q9GkEoWOb6vzLH8y712q0+s8A4NHtJ4oxVqgwSCMz4IBgORKa/KcoCbMxyLd1uG4G
 pePOtjnfPSjMAp6fmtG8v0dO11NXgze26Nj1qjCRMDemx0GR/Jksw5jiMrlNxF5uZQyV1rgpWMM
 kNwqCYWvJBO7n7hV7dGZv8OJUF6razpZQ8zM18bMksUfEMs1xRww==
X-Received: by 2002:a05:600c:848e:b0:499:7024:9d4a with SMTP id
 5b1f17b1804b1-4999fb2ec1cmr41163195e9.8.1786993192028; 
 Mon, 17 Aug 2026 11:59:52 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.11.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:59:50 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v6 06/25] parallels: Move host clusters allocation to a
 separate function
Date: Mon, 17 Aug 2026 20:59:23 +0200
Message-ID: <20260817185942.1065143-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=den@openvz.org; helo=mail-wm1-x32d.google.com
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

For parallels images extensions we need to allocate host clusters
without any connection to BAT. Move host clusters allocation code to
parallels_allocate_host_clusters().

This function can be called not only from coroutines so all the
*_co_* functions were replaced by corresponding wrappers.

Add parallels_mark_unused(), the helper releasing an area in the used
bitmap, as the new function needs it to undo an allocation.

The size of the request and the size of the area preallocated for it
live in two variables here, where the code being moved kept them in
one. The used bitmap has to grow by the latter, as it is what tells
the allocator how far the image reaches: counting only the requested
clusters hides the preallocated tail, so the next allocation starts
over at the end it knows about and preallocates the very same space
again.

data_end has to grow past an allocation which lands in the space
preallocated by an earlier one as well, not only past one which appends
to the image. The field marks the end of the payload for the truncation
on inactivation, so an allocation which leaves it behind is cut off the
image the moment the node is closed, and the data written into it is
lost.

Based on the original work from Alexander Ivanov.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c                             | 145 +++++++++++-------
 block/parallels.h                             |   5 +
 tests/qemu-iotests/tests/parallels-checks     |  34 ++++
 tests/qemu-iotests/tests/parallels-checks.out |  17 ++
 4 files changed, 145 insertions(+), 56 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index d537b0bb53..c96bed5ed3 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -206,6 +206,25 @@ int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
     return 0;
 }
 
+int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
+                          uint32_t bitmap_size, int64_t off, uint32_t count)
+{
+    BDRVParallelsState *s = bs->opaque;
+    uint32_t cluster_index = host_cluster_index(s, off);
+    uint64_t cluster_end = (uint64_t)cluster_index + count;
+    unsigned long next_unused;
+
+    if (cluster_end > bitmap_size) {
+        return -E2BIG;
+    }
+    next_unused = find_next_zero_bit(bitmap, cluster_end, cluster_index);
+    if (next_unused < cluster_end) {
+        return -EINVAL;
+    }
+    bitmap_clear(bitmap, cluster_index, count);
+    return 0;
+}
+
 /*
  * Collect used bitmap. The image can contain errors, we should fill the
  * bitmap anyway, as much as we can. This information will be used for
@@ -260,42 +279,21 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
     s->used_bmap = NULL;
 }
 
-static int64_t coroutine_fn GRAPH_RDLOCK
-allocate_clusters(BlockDriverState *bs, int64_t sector_num,
-                  int nb_sectors, int *pnum)
+int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
+                                                      int64_t *clusters)
 {
-    int ret = 0;
     BDRVParallelsState *s = bs->opaque;
-    int64_t i, pos, idx, to_allocate, first_free, host_off;
-
-    pos = block_status(s, sector_num, nb_sectors, pnum);
-    if (pos > 0) {
-        return pos;
-    }
-
-    idx = sector_num / s->tracks;
-    to_allocate = DIV_ROUND_UP(sector_num + *pnum, s->tracks) - idx;
-
-    /*
-     * This function is called only by parallels_co_writev(), which will never
-     * pass a sector_num at or beyond the end of the image (because the block
-     * layer never passes such a sector_num to that function). Therefore, idx
-     * is always below s->bat_size.
-     * block_status() will limit *pnum so that sector_num + *pnum will not
-     * exceed the image end. Therefore, idx + to_allocate cannot exceed
-     * s->bat_size.
-     * Note that s->bat_size is an unsigned int, therefore idx + to_allocate
-     * will always fit into a uint32_t.
-     */
-    assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
+    int64_t first_free, next_used, host_off, prealloc_clusters;
+    int64_t bytes, prealloc_bytes;
+    uint32_t new_usedsize;
+    int ret = 0;
 
     first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
     if (first_free == s->used_bmap_size) {
-        uint32_t new_usedsize;
-        int64_t bytes = to_allocate * s->cluster_size;
-        bytes += s->prealloc_size * BDRV_SECTOR_SIZE;
-
         host_off = s->data_end * BDRV_SECTOR_SIZE;
+        prealloc_clusters = *clusters + s->prealloc_size / s->tracks;
+        bytes = *clusters * s->cluster_size;
+        prealloc_bytes = prealloc_clusters * s->cluster_size;
 
         /*
          * We require the expanded size to read back as zero. If the
@@ -303,33 +301,29 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
          * force the safer-but-slower fallocate.
          */
         if (s->prealloc_mode == PRL_PREALLOC_MODE_TRUNCATE) {
-            ret = bdrv_co_truncate(bs->file, host_off + bytes,
-                                   false, PREALLOC_MODE_OFF,
-                                   BDRV_REQ_ZERO_WRITE, NULL);
+            ret = bdrv_truncate(bs->file, host_off + prealloc_bytes, false,
+                                PREALLOC_MODE_OFF, BDRV_REQ_ZERO_WRITE, NULL);
             if (ret == -ENOTSUP) {
                 s->prealloc_mode = PRL_PREALLOC_MODE_FALLOCATE;
             }
         }
         if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
-            ret = bdrv_co_pwrite_zeroes(bs->file, host_off, bytes, 0);
+            ret = bdrv_pwrite_zeroes(bs->file, host_off, prealloc_bytes, 0);
         }
         if (ret < 0) {
             return ret;
         }
 
-        new_usedsize = s->used_bmap_size + bytes / s->cluster_size;
+        new_usedsize = s->used_bmap_size + prealloc_bytes / s->cluster_size;
         s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
                                           new_usedsize);
         s->used_bmap_size = new_usedsize;
     } else {
-        int64_t next_used;
         next_used = find_next_bit(s->used_bmap, s->used_bmap_size, first_free);
 
         /* Not enough continuous clusters in the middle, adjust the size */
-        if (next_used - first_free < to_allocate) {
-            to_allocate = next_used - first_free;
-            *pnum = (idx + to_allocate) * s->tracks - sector_num;
-        }
+        *clusters = MIN(*clusters, next_used - first_free);
+        bytes = *clusters * s->cluster_size;
 
         host_off = s->data_start * BDRV_SECTOR_SIZE;
         host_off += first_free * s->cluster_size;
@@ -341,14 +335,63 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
          */
         if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE &&
                 host_off < s->data_end * BDRV_SECTOR_SIZE) {
-            ret = bdrv_co_pwrite_zeroes(bs->file, host_off,
-                                        s->cluster_size * to_allocate, 0);
+            ret = bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0);
             if (ret < 0) {
                 return ret;
             }
         }
     }
 
+    if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
+        s->data_end = (host_off + bytes) / BDRV_SECTOR_SIZE;
+    }
+
+    ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
+                              host_off, *clusters);
+    if (ret < 0) {
+        /* Image consistency is broken. Alarm! */
+        return ret;
+    }
+
+    return host_off;
+}
+
+static int64_t coroutine_fn GRAPH_RDLOCK
+allocate_clusters(BlockDriverState *bs, int64_t sector_num,
+                  int nb_sectors, int *pnum)
+{
+    int ret = 0;
+    BDRVParallelsState *s = bs->opaque;
+    int64_t i, pos, idx, to_allocate, host_off;
+
+    pos = block_status(s, sector_num, nb_sectors, pnum);
+    if (pos > 0) {
+        return pos;
+    }
+
+    idx = sector_num / s->tracks;
+    to_allocate = DIV_ROUND_UP(sector_num + *pnum, s->tracks) - idx;
+
+    /*
+     * This function is called only by parallels_co_writev(), which will never
+     * pass a sector_num at or beyond the end of the image (because the block
+     * layer never passes such a sector_num to that function). Therefore, idx
+     * is always below s->bat_size.
+     * block_status() will limit *pnum so that sector_num + *pnum will not
+     * exceed the image end. Therefore, idx + to_allocate cannot exceed
+     * s->bat_size.
+     * Note that s->bat_size is an unsigned int, therefore idx + to_allocate
+     * will always fit into a uint32_t.
+     */
+    assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
+
+    host_off = parallels_allocate_host_clusters(bs, &to_allocate);
+    if (host_off < 0) {
+        return host_off;
+    }
+
+    *pnum = MIN(*pnum, (idx + to_allocate) * s->tracks - sector_num);
+
     /*
      * Try to read from backing to fill empty clusters
      * FIXME: 1. previous write_zeroes may be redundant
@@ -365,33 +408,23 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
 
         ret = bdrv_co_pread(bs->backing, idx * s->tracks * BDRV_SECTOR_SIZE,
                             nb_cow_bytes, buf, 0);
-        if (ret < 0) {
-            qemu_vfree(buf);
-            return ret;
+        if (ret == 0) {
+            ret = bdrv_co_pwrite(bs->file, host_off, nb_cow_bytes, buf, 0);
         }
 
-        ret = bdrv_co_pwrite(bs->file, s->data_end * BDRV_SECTOR_SIZE,
-                             nb_cow_bytes, buf, 0);
         qemu_vfree(buf);
         if (ret < 0) {
+            parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
+                                  host_off, to_allocate);
             return ret;
         }
     }
 
-    ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
-                              host_off, to_allocate);
-    if (ret < 0) {
-        /* Image consistency is broken. Alarm! */
-        return ret;
-    }
     for (i = 0; i < to_allocate; i++) {
         parallels_set_bat_entry(s, idx + i,
                 host_off / BDRV_SECTOR_SIZE / s->off_multiplier);
         host_off += s->cluster_size;
     }
-    if (host_off > s->data_end * BDRV_SECTOR_SIZE) {
-        s->data_end = host_off / BDRV_SECTOR_SIZE;
-    }
 
     return bat2sect(s, idx) + sector_num % s->tracks;
 }
diff --git a/block/parallels.h b/block/parallels.h
index 68077416b1..493c89e976 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -92,6 +92,11 @@ typedef struct BDRVParallelsState {
 
 int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
                         uint32_t bitmap_size, int64_t off, uint32_t count);
+int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
+                          uint32_t bitmap_size, int64_t off, uint32_t count);
+
+int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
+                                                      int64_t *clusters);
 
 int GRAPH_RDLOCK
 parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index d2a08049d9..99af4c5f52 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -301,6 +301,40 @@ echo "$(peek_file_le "$TEST_IMG" $VICTIM_OFFSET 4)"
 echo "== data reads back correctly =="
 { $QEMU_IO -r -c "read -P 0x88 0 $SMALL_CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
+# Clear image
+_make_test_img $((64 * 1024 * 1024))
+
+echo "== TEST REUSE OF PREALLOCATED SPACE =="
+
+echo "== write 16 clusters, preallocating 16 of them at a time =="
+opts=(--image-opts "driver=$IMGFMT,file.filename=$TEST_IMG,prealloc-size=16M")
+for i in $(seq 0 15); do
+    opts+=(-c "write -P 0x11 $(($i * $CLUSTER_SIZE)) $CLUSTER_SIZE")
+done
+# Die before close(), which would truncate the preallocated tail away
+opts+=(-c "sigraise $(kill -l KILL)")
+orig_io_options=$QEMU_IO_OPTIONS
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
+echo "clusters written: `$QEMU_IO "${opts[@]}" 2>&1 | grep -c '^wrote'`"
+QEMU_IO_OPTIONS=$orig_io_options
+
+echo "== the space preallocated first must have been handed out since =="
+file_size=`stat --printf="%s" "$TEST_IMG"`
+echo "clusters behind the header: $(($file_size / $CLUSTER_SIZE - 1))"
+
+# Clear image
+_make_test_img $SIZE
+
+echo "== the second cluster comes from the space preallocated for the first =="
+{ $QEMU_IO -c "write -P 0x11 0 $CLUSTER_SIZE" \
+           -c "write -P 0x22 $CLUSTER_SIZE $CLUSTER_SIZE" \
+           "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== both of them survive the close =="
+{ $QEMU_IO -r -c "read -P 0x11 0 $CLUSTER_SIZE" \
+              -c "read -P 0x22 $CLUSTER_SIZE $CLUSTER_SIZE" \
+              "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index c33f3852a8..51eb3f1ef1 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -182,4 +182,21 @@ wrote 512/512 bytes at offset 0
 == data reads back correctly ==
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+== TEST REUSE OF PREALLOCATED SPACE ==
+== write 16 clusters, preallocating 16 of them at a time ==
+clusters written: 16
+== the space preallocated first must have been handed out since ==
+clusters behind the header: 17
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== the second cluster comes from the space preallocated for the first ==
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== both of them survive the close ==
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
-- 
2.53.0


