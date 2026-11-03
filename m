Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B82606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gq6a2NfC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5ca-0006Uk-D7; Mon, 02 Nov 2026 22:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cY-0006Ts-NS
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cW-0000co-Cb
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793678135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uL+eo+J+d2iX5Q7E1v+V3vfgg/dyC6Zx3h7wLpXdPE8=;
 b=Gq6a2NfCWRYbLPSVzpt0/iMZn2TKBxCef3Nd08yfP3AenGxlJggYOQv1/WOKD/lKvqAp6s
 UP215/SFiFa7s4YqemR8v+ZplEHUhvsiFMDwVbzPEnsLEOMUvksblUT2siL3vNG4rUewHZ
 npGONBKK1lfTMr4JB1OLHlkmSOr8Oww=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-yDGNbosfMCidG2MvdVRzJQ-1; Mon,
 02 Nov 2026 22:55:32 -0500
X-MC-Unique: yDGNbosfMCidG2MvdVRzJQ-1
X-Mimecast-MFC-AGG-ID: yDGNbosfMCidG2MvdVRzJQ_1793678131
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED1741800EF4; Tue,  3 Nov 2026 03:55:30 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6AC437E7; Tue,  3 Nov 2026 03:55:29 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block Jobs)
Subject: [PULL 10/16] block/block-copy: track known-zero source clusters
Date: Mon,  2 Nov 2026 21:54:21 -0600
Message-ID: <20261103035506.2688772-28-eblake@redhat.com>
In-Reply-To: <20261103035506.2688772-18-eblake@redhat.com>
References: <20261103035506.2688772-18-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Denis V. Lunev" <den@openvz.org>

block_copy_reset_unallocated()'s up-front scan already queries the
source, and the same query reports zero-ness. The copy loop re-queries
per task and, having no answer up front, can only size a task by the
copy buffer, so a mostly-zero image is cut into thousands of pieces
that each turn out to read as zero.

Cache the answer in zero_bitmap, published by zero_bitmap_valid once
the scan is done. block_copy_task_create() then picks the method from
the bitmap and ends the task where the answer changes, so a zero task
never reaches into data and a copy task never swallows a zero run. The
per-task query stays as the fallback until the flag is set, since CBW
intercepts guest writes while the scan is still running.

The scan and the query it replaces must resolve BDRV_BLOCK_ZERO against
the same part of the chain, so the scan moves from bdrv_co_is_allocated()
to bdrv_co_block_status_above() and the base selection is factored out
into block_copy_status_base().

zero_bitmap is a plain HBitmap, not a BdrvDirtyBitmap: an internal cache
has no business in query-named-block-nodes. One writer and readers gated
by the flag need no mutex, but the publish needs ordering, hence
store-release and load-acquire. It is allocated on demand, so sync=none
and a standalone copy-before-write filter do not pay for it.

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20261030010613.1612771-7-den@openvz.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/block-copy.h |   1 +
 block/backup.c             |   1 +
 block/block-copy.c         | 108 ++++++++++++++++++++++++++++++++-----
 3 files changed, 98 insertions(+), 12 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 0df2771181b..e4e5b567538 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -101,5 +101,6 @@ void block_copy_call_cancel(BlockCopyCallState *call_state);
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
 int64_t block_copy_cluster_size(BlockCopyState *s);
 void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
+void block_copy_set_zero_bitmap_valid(BlockCopyState *s);

 #endif /* BLOCK_COPY_H */
diff --git a/block/backup.c b/block/backup.c
index d4713fa1cd4..11d70243e24 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -280,6 +280,7 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
             offset += count;
         }
         block_copy_set_skip_unallocated(s->bcs, false);
+        block_copy_set_zero_bitmap_valid(s->bcs);
     }

     if (s->sync_mode == MIRROR_SYNC_MODE_NONE) {
diff --git a/block/block-copy.c b/block/block-copy.c
index 33c43cdf929..507c4bab909 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -20,6 +20,8 @@
 #include "block/block_int-io.h"
 #include "block/dirty-bitmap.h"
 #include "block/reqlist.h"
+#include "qemu/hbitmap.h"
+#include "qemu/host-utils.h"
 #include "system/block-backend.h"
 #include "qemu/units.h"
 #include "qemu/co-shared-resource.h"
@@ -157,6 +159,10 @@ typedef struct BlockCopyState {
     bool skip_unallocated; /* atomic */
     /* State fields that use a thread-safe API */
     BdrvDirtyBitmap *copy_bitmap;
+    /* Clusters reading as zero; allocated on demand, frozen once valid. */
+    HBitmap *zero_bitmap;
+    /* Published only after the scan, with skip_unallocated already false. */
+    bool zero_bitmap_valid; /* atomic, store-release/load-acquire */
     ProgressMeter *progress;
     SharedResource *mem;
     RateLimit rate_limit;
@@ -190,6 +196,7 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
                        int64_t offset, int64_t bytes)
 {
     BlockCopyTask *task;
+    BlockCopyMethod method;
     int64_t max_chunk;

     QEMU_LOCK_GUARD(&s->lock);
@@ -201,6 +208,27 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
         return NULL;
     }

+    method = s->method;
+
+    /*
+     * The scan already knows how this range reads: pick the method here and
+     * stop the task where the answer changes.
+     */
+    if (qatomic_load_acquire(&s->zero_bitmap_valid)) {
+        int64_t boundary;
+
+        if (hbitmap_get(s->zero_bitmap, offset)) {
+            method = COPY_WRITE_ZEROES;
+            boundary = hbitmap_next_zero(s->zero_bitmap, offset, bytes);
+        } else {
+            boundary = hbitmap_next_dirty(s->zero_bitmap, offset, bytes);
+        }
+
+        if (boundary >= 0) {
+            bytes = boundary - offset;
+        }
+    }
+
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
     bytes = QEMU_ALIGN_UP(bytes, s->cluster_size);

@@ -215,7 +243,7 @@ block_copy_task_create(BlockCopyState *s, BlockCopyCallState *call_state,
         .task.func = block_copy_task_entry,
         .s = s,
         .call_state = call_state,
-        .method = s->method,
+        .method = method,
     };
     reqlist_init_req(&s->reqs, &task->req, offset, bytes);

@@ -271,6 +299,9 @@ void block_copy_state_free(BlockCopyState *s)

     ratelimit_destroy(&s->rate_limit);
     bdrv_release_dirty_bitmap(s->copy_bitmap);
+    if (s->zero_bitmap) {
+        hbitmap_free(s->zero_bitmap);
+    }
     shres_destroy(s->mem);
     g_free(s);
 }
@@ -619,20 +650,24 @@ static coroutine_fn int block_copy_task_entry(AioTask *task)
     return ret;
 }

+/* The scan and the per-task query must resolve BDRV_BLOCK_ZERO alike. */
+static GRAPH_RDLOCK BlockDriverState *block_copy_status_base(BlockCopyState *s)
+{
+    if (qatomic_read(&s->skip_unallocated)) {
+        return bdrv_backing_chain_next(s->source->bs);
+    }
+
+    return NULL;
+}
+
 static coroutine_fn GRAPH_RDLOCK
 int block_copy_block_status(BlockCopyState *s, int64_t offset, int64_t bytes,
                             int64_t *pnum)
 {
     int64_t num;
-    BlockDriverState *base;
+    BlockDriverState *base = block_copy_status_base(s);
     int ret;

-    if (qatomic_read(&s->skip_unallocated)) {
-        base = bdrv_backing_chain_next(s->source->bs);
-    } else {
-        base = NULL;
-    }
-
     ret = bdrv_co_block_status_above(s->source->bs, base, offset, bytes, &num,
                                      NULL, NULL);
     if (ret < 0 || num < s->cluster_size) {
@@ -652,16 +687,41 @@ int block_copy_block_status(BlockCopyState *s, int64_t offset, int64_t bytes,
     return ret;
 }

+/* Only the scan allocates, and it runs before zero_bitmap_valid. */
+static HBitmap *block_copy_zero_bitmap(BlockCopyState *s)
+{
+    if (!s->zero_bitmap) {
+        s->zero_bitmap = hbitmap_alloc(s->len, ctz32(s->cluster_size));
+    }
+
+    return s->zero_bitmap;
+}
+
+static void block_copy_mark_zero_prefix(BlockCopyState *s, int64_t offset,
+                                        int64_t zero_count)
+{
+    int64_t zero_bytes = QEMU_ALIGN_DOWN(zero_count, s->cluster_size);
+
+    if (zero_bytes > 0) {
+        hbitmap_set(block_copy_zero_bitmap(s), offset, zero_bytes);
+    }
+}
+
 /*
  * Check if the cluster starting at offset is allocated or not.
  * return via pnum the number of contiguous clusters sharing this allocation.
+ * Also marks the zero prefix of the range in zero_bitmap.
  */
 static int coroutine_fn GRAPH_RDLOCK
 block_copy_is_cluster_allocated(BlockCopyState *s, int64_t offset,
                                 int64_t *pnum)
 {
     BlockDriverState *bs = s->source->bs;
+    BlockDriverState *base = block_copy_status_base(s);
+    int64_t orig_offset = offset;
     int64_t count, total_count = 0;
+    int64_t zero_count = 0;
+    bool zero_broken = false;
     int64_t bytes = s->len - offset;
     int ret;

@@ -669,25 +729,37 @@ block_copy_is_cluster_allocated(BlockCopyState *s, int64_t offset,

     while (true) {
         /* protected in backup_run() */
-        ret = bdrv_co_is_allocated(bs, offset, bytes, &count);
+        ret = bdrv_co_block_status_above(bs, base, offset, bytes, &count,
+                                         NULL, NULL);
         if (ret < 0) {
             return ret;
         }

+        if (!zero_broken) {
+            if (ret & BDRV_BLOCK_ZERO) {
+                zero_count += count;
+            } else {
+                zero_broken = true;
+            }
+        }
+
         total_count += count;

-        if (ret || count == 0) {
+        if ((ret & BDRV_BLOCK_ALLOCATED) || count == 0) {
             /*
-             * ret: partial segment(s) are considered allocated.
+             * BDRV_BLOCK_ALLOCATED: partial segment(s) are considered
+             * allocated.
              * otherwise: unallocated tail is treated as an entire segment.
              */
             *pnum = DIV_ROUND_UP(total_count, s->cluster_size);
-            return ret;
+            block_copy_mark_zero_prefix(s, orig_offset, zero_count);
+            return !!(ret & BDRV_BLOCK_ALLOCATED);
         }

         /* Unallocated segment(s) with uncertain following segment(s) */
         if (total_count >= s->cluster_size) {
             *pnum = total_count / s->cluster_size;
+            block_copy_mark_zero_prefix(s, orig_offset, zero_count);
             return 0;
         }

@@ -747,6 +819,12 @@ block_copy_set_task_method(BlockCopyState *s, BlockCopyTask *task)
     int ret;
     int64_t status_bytes;

+    /* block_copy_task_create() already decided, from zero_bitmap. */
+    if (qatomic_load_acquire(&s->zero_bitmap_valid)) {
+        return true;
+    }
+
+    /* CBW filter could call this early. */
     ret = block_copy_block_status(s, task->req.offset, task->req.bytes,
                                   &status_bytes);
     assert(ret >= 0); /* never fail */
@@ -1076,6 +1154,12 @@ void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip)
     qatomic_set(&s->skip_unallocated, skip);
 }

+void block_copy_set_zero_bitmap_valid(BlockCopyState *s)
+{
+    block_copy_zero_bitmap(s);
+    qatomic_store_release(&s->zero_bitmap_valid, true);
+}
+
 void block_copy_set_speed(BlockCopyState *s, uint64_t speed)
 {
     ratelimit_set_speed(&s->rate_limit, speed, BLOCK_COPY_SLICE_TIME);
-- 
2.56.0


