Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525B0C369A6
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 01:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u32sJ-0006Q6-9z; Thu, 10 Apr 2025 21:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u32s7-0006KM-Rs
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 21:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u32s1-0004II-FF
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 21:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744333668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2XlW1B2WDydl2Tod2K+A87pfWAWvqaLPOqLUZrYyvtc=;
 b=FCXGALIQtzvCIXOuSBG6z0Jd7QgtiYgmQG9G2siEo6yBu4Yotx9LZ/ggKtO8lAuvJ1m/Ez
 visrywE3EK0I96l4Vh38gW1Useakt7nSZrIuB5kTHc01rwWFldO5dA4ibRI3wJnW6MhhLC
 6Y/FTl+eh/2dthlT1D/yVkhog4t1Uak=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-qMN_mlKwMI6L7qJ6j6boIQ-1; Thu,
 10 Apr 2025 21:07:46 -0400
X-MC-Unique: qMN_mlKwMI6L7qJ6j6boIQ-1
X-Mimecast-MFC-AGG-ID: qMN_mlKwMI6L7qJ6j6boIQ_1744333665
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66BAE1801A06; Fri, 11 Apr 2025 01:07:45 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC4E8180174E; Fri, 11 Apr 2025 01:07:43 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block Jobs)
Subject: [PATCH 3/6] mirror: Skip writing zeroes when target is already zero
Date: Thu, 10 Apr 2025 20:04:53 -0500
Message-ID: <20250411010732.358817-11-eblake@redhat.com>
In-Reply-To: <20250411010732.358817-8-eblake@redhat.com>
References: <20250411010732.358817-8-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

When mirroring, the goal is to ensure that the destination reads the
same as the source; this goal is met whether the destination is sparse
or fully-allocated.  However, if the destination cannot efficiently
write zeroes, then any time the mirror operation wants to copy zeroes
from the source to the destination (either during the background over
sparse regions when doing a full mirror, or in the foreground when the
guest actively writes zeroes), we were causing the destination to
fully allocate that portion of the disk, even if it already read as
zeroes.

We could just teach mirror_co_zero() to do a block_status() probe of
the destination, and skip the zeroes if the destination already reads
as zero, but we know from past experience that block_status() calls
are not always cheap (tmpfs, anyone?).  So this patch takes a slightly
different approach: any time we have to transfer the full image,
mirror_dirty_init() is _already_ doing a pre-zero pass over the entire
destination.  Therefore, if we track which clusters of the destination
are zero at any given moment, we don't have to do a block_status()
call on the destination, but can instead just refer to the zero bitmap
associated with the job.

With this patch, if I externally create a raw sparse destination file
('truncate --size=$N dst.raw'), connect it with QMP 'blockdev-add'
while leaving it at the default "discard":"ignore", then run QMP
'blockdev-mirror' with "sync":"full", the destination remains sparse
rather than fully allocated.

However, a raw destination file created with 'blockdev-create' still
gets fully allocated, because more work is needed in file-posix to
still identify reads-as-zeroes even when the first 4k has to be
allocated to make alignment probing work.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/mirror.c | 94 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 78 insertions(+), 16 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 2e1e14c8e7e..98da5a6dc27 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -73,6 +73,7 @@ typedef struct MirrorBlockJob {
     size_t buf_size;
     int64_t bdev_length;
     unsigned long *cow_bitmap;
+    unsigned long *zero_bitmap;
     BdrvDirtyBitmap *dirty_bitmap;
     BdrvDirtyBitmapIter *dbi;
     uint8_t *buf;
@@ -408,15 +409,32 @@ static void coroutine_fn mirror_co_read(void *opaque)
 static void coroutine_fn mirror_co_zero(void *opaque)
 {
     MirrorOp *op = opaque;
-    int ret;
+    bool write_needed = true;
+    int ret = 0;

     op->s->in_flight++;
     op->s->bytes_in_flight += op->bytes;
     *op->bytes_handled = op->bytes;
     op->is_in_flight = true;

-    ret = blk_co_pwrite_zeroes(op->s->target, op->offset, op->bytes,
-                               op->s->unmap ? BDRV_REQ_MAY_UNMAP : 0);
+    if (op->s->zero_bitmap) {
+        unsigned long last = (op->offset + op->bytes) / op->s->granularity;
+        assert(QEMU_IS_ALIGNED(op->offset, op->s->granularity));
+        assert(QEMU_IS_ALIGNED(op->bytes, op->s->granularity) ||
+               op->offset + op->bytes == op->s->bdev_length);
+        if (find_next_zero_bit(op->s->zero_bitmap, last,
+                               op->offset / op->s->granularity) == last) {
+            write_needed = false;
+        }
+    }
+    if (write_needed) {
+        ret = blk_co_pwrite_zeroes(op->s->target, op->offset, op->bytes,
+                                   op->s->unmap ? BDRV_REQ_MAY_UNMAP : 0);
+    }
+    if (ret >= 0 && op->s->zero_bitmap) {
+        bitmap_set(op->s->zero_bitmap, op->offset / op->s->granularity,
+                   op->bytes / op->s->granularity);
+    }
     mirror_write_complete(op, ret);
 }

@@ -441,6 +459,9 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
     Coroutine *co;
     int64_t bytes_handled = -1;

+    assert(QEMU_IS_ALIGNED(offset, s->granularity));
+    assert(QEMU_IS_ALIGNED(bytes, s->granularity) ||
+           offset + bytes == s->bdev_length);
     op = g_new(MirrorOp, 1);
     *op = (MirrorOp){
         .s              = s,
@@ -452,12 +473,21 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,

     switch (mirror_method) {
     case MIRROR_METHOD_COPY:
+        if (s->zero_bitmap) {
+            bitmap_clear(s->zero_bitmap, offset / s->granularity,
+                         bytes / s->granularity);
+        }
         co = qemu_coroutine_create(mirror_co_read, op);
         break;
     case MIRROR_METHOD_ZERO:
+        /* s->zero_bitmap handled in mirror_co_zero */
         co = qemu_coroutine_create(mirror_co_zero, op);
         break;
     case MIRROR_METHOD_DISCARD:
+        if (s->zero_bitmap) {
+            bitmap_clear(s->zero_bitmap, offset / s->granularity,
+                         bytes / s->granularity);
+        }
         co = qemu_coroutine_create(mirror_co_discard, op);
         break;
     default:
@@ -851,10 +881,17 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
     }
     bdrv_graph_co_rdunlock();

-    if (s->zero_target && ret <= 0) {
+    if (s->zero_target) {
+        int64_t length;
+
         if (ret < 0) {
             return ret;
         }
+        length = DIV_ROUND_UP(s->bdev_length, s->granularity);
+        s->zero_bitmap = bitmap_new(length);
+        if (ret > 0) {
+            bitmap_set(s->zero_bitmap, 0, length);
+        }
         if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
             bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
             return 0;
@@ -1169,6 +1206,7 @@ immediate_exit:
     assert(s->in_flight == 0);
     qemu_vfree(s->buf);
     g_free(s->cow_bitmap);
+    g_free(s->zero_bitmap);
     g_free(s->in_flight_bitmap);
     bdrv_dirty_iter_free(s->dbi);

@@ -1347,7 +1385,8 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
 {
     int ret;
     size_t qiov_offset = 0;
-    int64_t bitmap_offset, bitmap_end;
+    int64_t dirty_bitmap_offset, dirty_bitmap_end;
+    int64_t zero_bitmap_offset, zero_bitmap_end;

     if (!QEMU_IS_ALIGNED(offset, job->granularity) &&
         bdrv_dirty_bitmap_get(job->dirty_bitmap, offset))
@@ -1391,31 +1430,54 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
     }

     /*
-     * Tails are either clean or shrunk, so for bitmap resetting
-     * we safely align the range down.
+     * Tails are either clean or shrunk, so for dirty bitmap resetting
+     * we safely align the range down.  But for zero bitmap, round range
+     * up for checking or clearing, and down for setting.
      */
-    bitmap_offset = QEMU_ALIGN_UP(offset, job->granularity);
-    bitmap_end = QEMU_ALIGN_DOWN(offset + bytes, job->granularity);
-    if (bitmap_offset < bitmap_end) {
-        bdrv_reset_dirty_bitmap(job->dirty_bitmap, bitmap_offset,
-                                bitmap_end - bitmap_offset);
+    dirty_bitmap_offset = QEMU_ALIGN_UP(offset, job->granularity);
+    dirty_bitmap_end = QEMU_ALIGN_DOWN(offset + bytes, job->granularity);
+    if (dirty_bitmap_offset < dirty_bitmap_end) {
+        bdrv_reset_dirty_bitmap(job->dirty_bitmap, dirty_bitmap_offset,
+                                dirty_bitmap_end - dirty_bitmap_offset);
     }
+    zero_bitmap_offset = offset / job->granularity;
+    zero_bitmap_end = DIV_ROUND_UP(offset + bytes, job->granularity);

     job_progress_increase_remaining(&job->common.job, bytes);
     job->active_write_bytes_in_flight += bytes;

     switch (method) {
     case MIRROR_METHOD_COPY:
+        if (job->zero_bitmap) {
+            bitmap_clear(job->zero_bitmap, zero_bitmap_offset,
+                         zero_bitmap_end - zero_bitmap_offset);
+        }
         ret = blk_co_pwritev_part(job->target, offset, bytes,
                                   qiov, qiov_offset, flags);
         break;

     case MIRROR_METHOD_ZERO:
+        if (job->zero_bitmap) {
+            if (find_next_zero_bit(job->zero_bitmap, zero_bitmap_end,
+                                   zero_bitmap_offset) == zero_bitmap_end) {
+                ret = 0;
+                break;
+            }
+        }
         assert(!qiov);
         ret = blk_co_pwrite_zeroes(job->target, offset, bytes, flags);
+        if (job->zero_bitmap && ret >= 0) {
+            bitmap_set(job->zero_bitmap, dirty_bitmap_offset / job->granularity,
+                       (dirty_bitmap_end - dirty_bitmap_offset) /
+                       job->granularity);
+        }
         break;

     case MIRROR_METHOD_DISCARD:
+        if (job->zero_bitmap) {
+            bitmap_clear(job->zero_bitmap, zero_bitmap_offset,
+                         zero_bitmap_end - zero_bitmap_offset);
+        }
         assert(!qiov);
         ret = blk_co_pdiscard(job->target, offset, bytes);
         break;
@@ -1436,10 +1498,10 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
          * at function start, and they must be still dirty, as we've locked
          * the region for in-flight op.
          */
-        bitmap_offset = QEMU_ALIGN_DOWN(offset, job->granularity);
-        bitmap_end = QEMU_ALIGN_UP(offset + bytes, job->granularity);
-        bdrv_set_dirty_bitmap(job->dirty_bitmap, bitmap_offset,
-                              bitmap_end - bitmap_offset);
+        dirty_bitmap_offset = QEMU_ALIGN_DOWN(offset, job->granularity);
+        dirty_bitmap_end = QEMU_ALIGN_UP(offset + bytes, job->granularity);
+        bdrv_set_dirty_bitmap(job->dirty_bitmap, dirty_bitmap_offset,
+                              dirty_bitmap_end - dirty_bitmap_offset);
         qatomic_set(&job->actively_synced, false);

         action = mirror_error_action(job, false, -ret);
-- 
2.49.0


