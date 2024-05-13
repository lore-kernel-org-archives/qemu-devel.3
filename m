Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2276BC25B5F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 06:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6PEf-0007TN-BD; Mon, 13 May 2024 02:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1s6PEN-00078I-Eu; Mon, 13 May 2024 02:32:15 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1s6PEI-0003wd-Mt; Mon, 13 May 2024 02:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=r7Er1IMZmmLdiZ4Ai0KkGiQQquT7czJmB9BLklPI+r0=; b=Cpbbo3a91D6w
 33tsk+lLqeSW1dT+wPX8KPj8B3wCRbKTkZ7VATH2AlxULCwQEAxECgz4qbSPW5Kv7mNMEMi6lkDbx
 SPM+V1eLg+SJV+BUpiG1m8X5SL5yyrSMjlXcu2i5bpUEn2qfsNa922LuKPUUOEt+z/HQ9yH812qgn
 zGkFV8uGCPYp79BepCkkxpfvo1BXivtlhw21EQHGkJ5zXwS+XQfNe41fJXiIMEoI/qCNfrylAQB4m
 B0HgfOxylWKew3iZQnB1DIkiYeD63ILL5mybZRYsQd/YOd1gWzaIJX8ZivV14zu7V7XaxvoNofW2i
 AKnohCVaefy2QDoUpnij0w==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1s6PAR-000qpR-32;
 Mon, 13 May 2024 08:31:57 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 09/11] qcow2: make subclusters discardable
Date: Mon, 13 May 2024 09:32:01 +0300
Message-Id: <20240513063203.113911-10-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

This commit makes the discard operation work on the subcluster level
rather than cluster level.  It introduces discard_l2_subclusters()
function and makes use of it in qcow2 discard implementation, much like
it's done with zero_in_l2_slice() / zero_l2_subclusters().  It also
changes the qcow2 driver pdiscard_alignment to subcluster_size.  That
way subcluster-aligned discards lead to actual fallocate(PUNCH_HOLE)
operation and free host disk space.

This feature will let us gain additional disk space on guest
TRIM/discard requests, especially when using large enough clusters
(1M, 2M) with subclusters enabled.

Also rename qcow2_cluster_discard() -> qcow2_subcluster_discard() to
reflect the change.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/qcow2-cluster.c  | 106 +++++++++++++++++++++++++++++++++++++----
 block/qcow2-snapshot.c |   6 +--
 block/qcow2.c          |  25 +++++-----
 block/qcow2.h          |   4 +-
 tests/qemu-iotests/271 |   2 +-
 5 files changed, 117 insertions(+), 26 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 8d39e2f960..3c134a7e80 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -2105,25 +2105,106 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
     return nb_clusters;
 }
 
-int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
-                          uint64_t bytes, enum qcow2_discard_type type,
-                          bool full_discard)
+static int coroutine_fn GRAPH_RDLOCK
+discard_l2_subclusters(BlockDriverState *bs, uint64_t offset,
+                       uint64_t nb_subclusters,
+                       enum qcow2_discard_type type,
+                       bool full_discard)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t new_l2_bitmap, bitmap_alloc_mask, bitmap_zero_mask;
+    int ret, sc = offset_to_sc_index(s, offset);
+    g_auto(SubClusterRangeInfo) scri = { 0 };
+
+    ret = get_sc_range_info(bs, offset, nb_subclusters, &scri);
+    if (ret < 0) {
+        return ret;
+    }
+
+    new_l2_bitmap = scri.l2_bitmap;
+    bitmap_alloc_mask = QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
+    bitmap_zero_mask = QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
+
+    new_l2_bitmap &= ~bitmap_alloc_mask;
+
+    /*
+     * Full discard means we fall through to the backing file, thus we need
+     * to mark the subclusters as deallocated and clear the corresponding
+     * zero bits.
+     *
+     * Non-full discard means subclusters should be explicitly marked as
+     * zeroes.  In this case QCOW2 specification requires the corresponding
+     * allocation status bits to be unset as well.  If the subclusters are
+     * deallocated in the first place and there's no backing, the operation
+     * can be skipped.
+     */
+    if (full_discard) {
+        new_l2_bitmap &= ~bitmap_zero_mask;
+    } else if (bs->backing || scri.l2_bitmap & bitmap_alloc_mask) {
+        new_l2_bitmap |= bitmap_zero_mask;
+    }
+
+    /*
+     * If after discarding this range there won't be any allocated subclusters
+     * left, and new bitmap becomes the same as it'd be after discarding the
+     * whole cluster, we better discard it entirely.  That way we'd also
+     * update the refcount table.
+     */
+    if ((full_discard && new_l2_bitmap == 0) ||
+            (!full_discard && new_l2_bitmap == QCOW_L2_BITMAP_ALL_ZEROES)) {
+        return discard_in_l2_slice(
+            bs, QEMU_ALIGN_DOWN(offset, s->cluster_size),
+            1, type, full_discard);
+    }
+
+    if (scri.l2_bitmap != new_l2_bitmap) {
+        set_l2_bitmap(s, scri.l2_slice, scri.l2_index, new_l2_bitmap);
+        qcow2_cache_entry_mark_dirty(s->l2_table_cache, scri.l2_slice);
+    }
+
+    discard_no_unref_any_file(
+        bs, (scri.l2_entry & L2E_OFFSET_MASK) + offset_into_cluster(s, offset),
+        nb_subclusters * s->subcluster_size, scri.ctype, type);
+
+    return 0;
+}
+
+int qcow2_subcluster_discard(BlockDriverState *bs, uint64_t offset,
+                             uint64_t bytes, enum qcow2_discard_type type,
+                             bool full_discard)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t end_offset = offset + bytes;
     uint64_t nb_clusters;
+    unsigned head, tail;
     int64_t cleared;
     int ret;
 
     /* Caller must pass aligned values, except at image end */
-    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
-    assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||
+    assert(QEMU_IS_ALIGNED(offset, s->subcluster_size));
+    assert(QEMU_IS_ALIGNED(end_offset, s->subcluster_size) ||
            end_offset == bs->total_sectors << BDRV_SECTOR_BITS);
 
-    nb_clusters = size_to_clusters(s, bytes);
+    head = MIN(end_offset, ROUND_UP(offset, s->cluster_size)) - offset;
+    offset += head;
+
+    tail = (end_offset >= bs->total_sectors << BDRV_SECTOR_BITS) ? 0 :
+           end_offset - MAX(offset, start_of_cluster(s, end_offset));
+    end_offset -= tail;
 
     s->cache_discards = true;
 
+    if (head) {
+        ret = discard_l2_subclusters(bs, offset - head,
+                                     size_to_subclusters(s, head), type,
+                                     full_discard);
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+
+    nb_clusters = size_to_clusters(s, end_offset - offset);
+
     /* Each L2 slice is handled by its own loop iteration */
     while (nb_clusters > 0) {
         cleared = discard_in_l2_slice(bs, offset, nb_clusters, type,
@@ -2137,6 +2218,15 @@ int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
         offset += (cleared * s->cluster_size);
     }
 
+    if (tail) {
+        ret = discard_l2_subclusters(bs, end_offset,
+                                     size_to_subclusters(s, tail), type,
+                                     full_discard);
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+
     ret = 0;
 fail:
     s->cache_discards = false;
@@ -2286,8 +2376,8 @@ int coroutine_fn qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset,
      */
     if (s->qcow_version < 3) {
         if (!bs->backing) {
-            return qcow2_cluster_discard(bs, offset, bytes,
-                                         QCOW2_DISCARD_REQUEST, false);
+            return qcow2_subcluster_discard(bs, offset, bytes,
+                                            QCOW2_DISCARD_REQUEST, false);
         }
         return -ENOTSUP;
     }
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 92e47978bf..4e39354d02 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -736,9 +736,9 @@ int qcow2_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info)
 
     /* The VM state isn't needed any more in the active L1 table; in fact, it
      * hurts by causing expensive COW for the next snapshot. */
-    qcow2_cluster_discard(bs, qcow2_vm_state_offset(s),
-                          ROUND_UP(sn->vm_state_size, s->cluster_size),
-                          QCOW2_DISCARD_NEVER, false);
+    qcow2_subcluster_discard(bs, qcow2_vm_state_offset(s),
+                             ROUND_UP(sn->vm_state_size, s->cluster_size),
+                             QCOW2_DISCARD_NEVER, false);
 
 #ifdef DEBUG_ALLOC
     {
diff --git a/block/qcow2.c b/block/qcow2.c
index 956128b409..792b106eb6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1967,7 +1967,7 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
         bs->bl.request_alignment = qcrypto_block_get_sector_size(s->crypto);
     }
     bs->bl.pwrite_zeroes_alignment = s->subcluster_size;
-    bs->bl.pdiscard_alignment = s->cluster_size;
+    bs->bl.pdiscard_alignment = s->subcluster_size;
 }
 
 static int GRAPH_UNLOCKED
@@ -4112,19 +4112,19 @@ qcow2_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
         return -ENOTSUP;
     }
 
-    if (!QEMU_IS_ALIGNED(offset | bytes, s->cluster_size)) {
-        assert(bytes < s->cluster_size);
+    if (!QEMU_IS_ALIGNED(offset | bytes, bs->bl.pdiscard_alignment)) {
+        assert(bytes < bs->bl.pdiscard_alignment);
         /* Ignore partial clusters, except for the special case of the
          * complete partial cluster at the end of an unaligned file */
-        if (!QEMU_IS_ALIGNED(offset, s->cluster_size) ||
+        if (!QEMU_IS_ALIGNED(offset, bs->bl.pdiscard_alignment) ||
             offset + bytes != bs->total_sectors * BDRV_SECTOR_SIZE) {
             return -ENOTSUP;
         }
     }
 
     qemu_co_mutex_lock(&s->lock);
-    ret = qcow2_cluster_discard(bs, offset, bytes, QCOW2_DISCARD_REQUEST,
-                                false);
+    ret = qcow2_subcluster_discard(bs, offset, bytes, QCOW2_DISCARD_REQUEST,
+                                   false);
     qemu_co_mutex_unlock(&s->lock);
     return ret;
 }
@@ -4335,10 +4335,10 @@ qcow2_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
             goto fail;
         }
 
-        ret = qcow2_cluster_discard(bs, ROUND_UP(offset, s->cluster_size),
-                                    old_length - ROUND_UP(offset,
-                                                          s->cluster_size),
-                                    QCOW2_DISCARD_ALWAYS, true);
+        ret = qcow2_subcluster_discard(bs, ROUND_UP(offset, s->cluster_size),
+                                       old_length - ROUND_UP(offset,
+                                                             s->cluster_size),
+                                       QCOW2_DISCARD_ALWAYS, true);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Failed to discard cropped clusters");
             goto fail;
@@ -5032,8 +5032,9 @@ static int GRAPH_RDLOCK qcow2_make_empty(BlockDriverState *bs)
          * default action for this kind of discard is to pass the discard,
          * which will ideally result in an actually smaller image file, as
          * is probably desired. */
-        ret = qcow2_cluster_discard(bs, offset, MIN(step, end_offset - offset),
-                                    QCOW2_DISCARD_SNAPSHOT, true);
+        ret = qcow2_subcluster_discard(bs, offset,
+                                       MIN(step, end_offset - offset),
+                                       QCOW2_DISCARD_SNAPSHOT, true);
         if (ret < 0) {
             break;
         }
diff --git a/block/qcow2.h b/block/qcow2.h
index 197bdcdf53..a65c185b51 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -953,8 +953,8 @@ void coroutine_fn GRAPH_RDLOCK
 qcow2_alloc_cluster_abort(BlockDriverState *bs, QCowL2Meta *m);
 
 int GRAPH_RDLOCK
-qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-                      enum qcow2_discard_type type, bool full_discard);
+qcow2_subcluster_discard(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+                         enum qcow2_discard_type type, bool full_discard);
 
 int coroutine_fn GRAPH_RDLOCK
 qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
index 59a6fafa2f..04c57813c2 100755
--- a/tests/qemu-iotests/271
+++ b/tests/qemu-iotests/271
@@ -518,7 +518,7 @@ done
 ############################################################
 ############################################################
 
-# Test qcow2_cluster_discard() with full and normal discards
+# Test qcow2_subcluster_discard() with full and normal discards
 for use_backing_file in yes no; do
     echo
     echo "### Discarding clusters with non-zero bitmaps (backing file: $use_backing_file) ###"
-- 
2.39.3


