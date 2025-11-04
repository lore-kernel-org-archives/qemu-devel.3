Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C34CCF9F8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 02:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG6ph-0008Jz-7n; Mon, 03 Nov 2025 21:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vG6oX-0007Bx-Pu
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:30:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vG6oO-0004DU-4w
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762223418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s50QRA/rLv/AfBMFQovHiUMR4s2eim1uG7Zw00xAHis=;
 b=C5wTtwObVha1g1JEA0e/CtcAV2Z0FHmmRQmH76FKqdYxTizJt5YwgV+EvaU6I9H/sCFwip
 lNTdwsqquYPIkenvO8kH/0cZzSrf31HziQbCIDPFmwV3kX6o38ujdeozv0bqa0n8l0FA3C
 mJS5im/6xLEnHshSxvCIkOjAw/UZE1A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-M4tlqM_dP8eE1RmDplgQFw-1; Mon,
 03 Nov 2025 21:30:13 -0500
X-MC-Unique: M4tlqM_dP8eE1RmDplgQFw-1
X-Mimecast-MFC-AGG-ID: M4tlqM_dP8eE1RmDplgQFw_1762223412
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DF331956053; Tue,  4 Nov 2025 02:30:12 +0000 (UTC)
Received: from localhost (unknown [10.2.16.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D364D1956056; Tue,  4 Nov 2025 02:30:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 eblake@redhat.com, Hanna Czenczek <hreitz@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, hibriansong@gmail.com
Subject: [PATCH v6 14/15] block/io_uring: use aio_add_sqe()
Date: Mon,  3 Nov 2025 21:29:32 -0500
Message-ID: <20251104022933.618123-15-stefanha@redhat.com>
In-Reply-To: <20251104022933.618123-1-stefanha@redhat.com>
References: <20251104022933.618123-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

AioContext has its own io_uring instance for file descriptor monitoring.
The disk I/O io_uring code was developed separately. Originally I
thought the characteristics of file descriptor monitoring and disk I/O
were too different, requiring separate io_uring instances.

Now it has become clear to me that it's feasible to share a single
io_uring instance for file descriptor monitoring and disk I/O. We're not
using io_uring's IOPOLL feature or anything else that would require a
separate instance.

Unify block/io_uring.c and util/fdmon-io_uring.c using the new
aio_add_sqe() API that allows user-defined io_uring sqe submission. Now
block/io_uring.c just needs to submit readv/writev/fsync and most of the
io_uring-specific logic is handled by fdmon-io_uring.c.

There are two immediate advantages:
1. Fewer system calls. There is no need to monitor the disk I/O io_uring
   ring fd from the file descriptor monitoring io_uring instance. Disk
   I/O completions are now picked up directly. Also, sqes are
   accumulated in the sq ring until the end of the event loop iteration
   and there are fewer io_uring_enter(2) syscalls.
2. Less code duplication.

Note that error_setg() messages are not supposed to end with
punctuation, so I removed a '.' for the non-io_uring build error
message.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/aio.h     |   7 -
 include/block/raw-aio.h |   5 -
 block/file-posix.c      |  40 ++--
 block/io_uring.c        | 489 ++++++++++------------------------------
 stubs/io_uring.c        |  32 ---
 util/async.c            |  35 ---
 block/trace-events      |  12 +-
 stubs/meson.build       |   3 -
 8 files changed, 130 insertions(+), 493 deletions(-)
 delete mode 100644 stubs/io_uring.c

diff --git a/include/block/aio.h b/include/block/aio.h
index 05d1bf4036..540bbc5d60 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -310,8 +310,6 @@ struct AioContext {
     struct LinuxAioState *linux_aio;
 #endif
 #ifdef CONFIG_LINUX_IO_URING
-    LuringState *linux_io_uring;
-
     /* State for file descriptor monitoring using Linux io_uring */
     struct io_uring fdmon_io_uring;
     AioHandlerSList submit_list;
@@ -615,11 +613,6 @@ struct LinuxAioState *aio_setup_linux_aio(AioContext *ctx, Error **errp);
 /* Return the LinuxAioState bound to this AioContext */
 struct LinuxAioState *aio_get_linux_aio(AioContext *ctx);
 
-/* Setup the LuringState bound to this AioContext */
-LuringState *aio_setup_linux_io_uring(AioContext *ctx, Error **errp);
-
-/* Return the LuringState bound to this AioContext */
-LuringState *aio_get_linux_io_uring(AioContext *ctx);
 /**
  * aio_timer_new_with_attrs:
  * @ctx: the aio context
diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index 6570244496..30e5fc9a9f 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -74,15 +74,10 @@ static inline bool laio_has_fua(void)
 #endif
 /* io_uring.c - Linux io_uring implementation */
 #ifdef CONFIG_LINUX_IO_URING
-LuringState *luring_init(Error **errp);
-void luring_cleanup(LuringState *s);
-
 /* luring_co_submit: submit I/O requests in the thread's current AioContext. */
 int coroutine_fn luring_co_submit(BlockDriverState *bs, int fd, uint64_t offset,
                                   QEMUIOVector *qiov, int type,
                                   BdrvRequestFlags flags);
-void luring_detach_aio_context(LuringState *s, AioContext *old_context);
-void luring_attach_aio_context(LuringState *s, AioContext *new_context);
 bool luring_has_fua(void);
 #else
 static inline bool luring_has_fua(void)
diff --git a/block/file-posix.c b/block/file-posix.c
index 8c738674ce..8b7c02d19a 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -755,14 +755,23 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     }
 #endif /* !defined(CONFIG_LINUX_AIO) */
 
-#ifndef CONFIG_LINUX_IO_URING
     if (s->use_linux_io_uring) {
+#ifdef CONFIG_LINUX_IO_URING
+        if (!aio_has_io_uring()) {
+            error_setg(errp, "aio=io_uring was specified, but is not "
+                             "available (disabled via io_uring_disabled "
+                             "sysctl or blocked by container runtime "
+                             "seccomp policy?)");
+            ret = -EINVAL;
+            goto fail;
+        }
+#else
         error_setg(errp, "aio=io_uring was specified, but is not supported "
-                         "in this build.");
+                         "in this build");
         ret = -EINVAL;
         goto fail;
-    }
 #endif /* !defined(CONFIG_LINUX_IO_URING) */
+    }
 
     s->has_discard = true;
     s->has_write_zeroes = true;
@@ -2522,27 +2531,6 @@ static bool bdrv_qiov_is_aligned(BlockDriverState *bs, QEMUIOVector *qiov)
     return true;
 }
 
-#ifdef CONFIG_LINUX_IO_URING
-static inline bool raw_check_linux_io_uring(BDRVRawState *s)
-{
-    Error *local_err = NULL;
-    AioContext *ctx;
-
-    if (!s->use_linux_io_uring) {
-        return false;
-    }
-
-    ctx = qemu_get_current_aio_context();
-    if (unlikely(!aio_setup_linux_io_uring(ctx, &local_err))) {
-        error_reportf_err(local_err, "Unable to use linux io_uring, "
-                                     "falling back to thread pool: ");
-        s->use_linux_io_uring = false;
-        return false;
-    }
-    return true;
-}
-#endif
-
 #ifdef CONFIG_LINUX_AIO
 static inline bool raw_check_linux_aio(BDRVRawState *s)
 {
@@ -2595,7 +2583,7 @@ raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr, uint64_t bytes,
     if (s->needs_alignment && !bdrv_qiov_is_aligned(bs, qiov)) {
         type |= QEMU_AIO_MISALIGNED;
 #ifdef CONFIG_LINUX_IO_URING
-    } else if (raw_check_linux_io_uring(s)) {
+    } else if (s->use_linux_io_uring) {
         assert(qiov->size == bytes);
         ret = luring_co_submit(bs, s->fd, offset, qiov, type, flags);
         goto out;
@@ -2692,7 +2680,7 @@ static int coroutine_fn raw_co_flush_to_disk(BlockDriverState *bs)
     };
 
 #ifdef CONFIG_LINUX_IO_URING
-    if (raw_check_linux_io_uring(s)) {
+    if (s->use_linux_io_uring) {
         return luring_co_submit(bs, s->fd, 0, NULL, QEMU_AIO_FLUSH, 0);
     }
 #endif
diff --git a/block/io_uring.c b/block/io_uring.c
index dd4f304910..dd930ee57e 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -11,28 +11,20 @@
 #include "qemu/osdep.h"
 #include <liburing.h>
 #include "block/aio.h"
-#include "qemu/queue.h"
 #include "block/block.h"
 #include "block/raw-aio.h"
 #include "qemu/coroutine.h"
-#include "qemu/defer-call.h"
-#include "qapi/error.h"
 #include "system/block-backend.h"
 #include "trace.h"
 
-/* Only used for assertions.  */
-#include "qemu/coroutine_int.h"
-
-/* io_uring ring size */
-#define MAX_ENTRIES 128
-
-typedef struct LuringAIOCB {
+typedef struct {
     Coroutine *co;
-    struct io_uring_sqe sqeq;
-    ssize_t ret;
     QEMUIOVector *qiov;
-    bool is_read;
-    QSIMPLEQ_ENTRY(LuringAIOCB) next;
+    uint64_t offset;
+    ssize_t ret;
+    int type;
+    int fd;
+    BdrvRequestFlags flags;
 
     /*
      * Buffered reads may require resubmission, see
@@ -40,36 +32,51 @@ typedef struct LuringAIOCB {
      */
     int total_read;
     QEMUIOVector resubmit_qiov;
-} LuringAIOCB;
 
-typedef struct LuringQueue {
-    unsigned int in_queue;
-    unsigned int in_flight;
-    bool blocked;
-    QSIMPLEQ_HEAD(, LuringAIOCB) submit_queue;
-} LuringQueue;
+    CqeHandler cqe_handler;
+} LuringRequest;
 
-struct LuringState {
-    AioContext *aio_context;
-
-    struct io_uring ring;
-
-    /* No locking required, only accessed from AioContext home thread */
-    LuringQueue io_q;
-
-    QEMUBH *completion_bh;
-};
-
-/**
- * luring_resubmit:
- *
- * Resubmit a request by appending it to submit_queue.  The caller must ensure
- * that ioq_submit() is called later so that submit_queue requests are started.
- */
-static void luring_resubmit(LuringState *s, LuringAIOCB *luringcb)
+static void luring_prep_sqe(struct io_uring_sqe *sqe, void *opaque)
 {
-    QSIMPLEQ_INSERT_TAIL(&s->io_q.submit_queue, luringcb, next);
-    s->io_q.in_queue++;
+    LuringRequest *req = opaque;
+    QEMUIOVector *qiov = req->qiov;
+    uint64_t offset = req->offset;
+    int fd = req->fd;
+    BdrvRequestFlags flags = req->flags;
+
+    switch (req->type) {
+    case QEMU_AIO_WRITE:
+#ifdef HAVE_IO_URING_PREP_WRITEV2
+    {
+        int luring_flags = (flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
+        io_uring_prep_writev2(sqe, fd, qiov->iov,
+                              qiov->niov, offset, luring_flags);
+    }
+#else
+        assert(flags == 0);
+        io_uring_prep_writev(sqe, fd, qiov->iov, qiov->niov, offset);
+#endif
+        break;
+    case QEMU_AIO_ZONE_APPEND:
+        io_uring_prep_writev(sqe, fd, qiov->iov, qiov->niov, offset);
+        break;
+    case QEMU_AIO_READ:
+    {
+        if (req->resubmit_qiov.iov != NULL) {
+            qiov = &req->resubmit_qiov;
+        }
+        io_uring_prep_readv(sqe, fd, qiov->iov, qiov->niov,
+                            offset + req->total_read);
+        break;
+    }
+    case QEMU_AIO_FLUSH:
+        io_uring_prep_fsync(sqe, fd, IORING_FSYNC_DATASYNC);
+        break;
+    default:
+        fprintf(stderr, "%s: invalid AIO request type, aborting 0x%x.\n",
+                        __func__, req->type);
+        abort();
+    }
 }
 
 /**
@@ -78,385 +85,115 @@ static void luring_resubmit(LuringState *s, LuringAIOCB *luringcb)
  * Short reads are rare but may occur. The remaining read request needs to be
  * resubmitted.
  */
-static void luring_resubmit_short_read(LuringState *s, LuringAIOCB *luringcb,
-                                       int nread)
+static void luring_resubmit_short_read(LuringRequest *req, int nread)
 {
     QEMUIOVector *resubmit_qiov;
     size_t remaining;
 
-    trace_luring_resubmit_short_read(s, luringcb, nread);
+    trace_luring_resubmit_short_read(req, nread);
 
     /* Update read position */
-    luringcb->total_read += nread;
-    remaining = luringcb->qiov->size - luringcb->total_read;
+    req->total_read += nread;
+    remaining = req->qiov->size - req->total_read;
 
     /* Shorten qiov */
-    resubmit_qiov = &luringcb->resubmit_qiov;
+    resubmit_qiov = &req->resubmit_qiov;
     if (resubmit_qiov->iov == NULL) {
-        qemu_iovec_init(resubmit_qiov, luringcb->qiov->niov);
+        qemu_iovec_init(resubmit_qiov, req->qiov->niov);
     } else {
         qemu_iovec_reset(resubmit_qiov);
     }
-    qemu_iovec_concat(resubmit_qiov, luringcb->qiov, luringcb->total_read,
-                      remaining);
+    qemu_iovec_concat(resubmit_qiov, req->qiov, req->total_read, remaining);
 
-    /* Update sqe */
-    luringcb->sqeq.off += nread;
-    luringcb->sqeq.addr = (uintptr_t)luringcb->resubmit_qiov.iov;
-    luringcb->sqeq.len = luringcb->resubmit_qiov.niov;
-
-    luring_resubmit(s, luringcb);
+    aio_add_sqe(luring_prep_sqe, req, &req->cqe_handler);
 }
 
-/**
- * luring_process_completions:
- * @s: AIO state
- *
- * Fetches completed I/O requests, consumes cqes and invokes their callbacks
- * The function is somewhat tricky because it supports nested event loops, for
- * example when a request callback invokes aio_poll().
- *
- * Function schedules BH completion so it  can be called again in a nested
- * event loop.  When there are no events left  to complete the BH is being
- * canceled.
- *
- */
-static void luring_process_completions(LuringState *s)
+static void luring_cqe_handler(CqeHandler *cqe_handler)
 {
-    struct io_uring_cqe *cqes;
-    int total_bytes;
+    LuringRequest *req = container_of(cqe_handler, LuringRequest, cqe_handler);
+    int ret = cqe_handler->cqe.res;
 
-    defer_call_begin();
+    trace_luring_cqe_handler(req, ret);
 
-    /*
-     * Request completion callbacks can run the nested event loop.
-     * Schedule ourselves so the nested event loop will "see" remaining
-     * completed requests and process them.  Without this, completion
-     * callbacks that wait for other requests using a nested event loop
-     * would hang forever.
-     *
-     * This workaround is needed because io_uring uses poll_wait, which
-     * is woken up when new events are added to the uring, thus polling on
-     * the same uring fd will block unless more events are received.
-     *
-     * Other leaf block drivers (drivers that access the data themselves)
-     * are networking based, so they poll sockets for data and run the
-     * correct coroutine.
-     */
-    qemu_bh_schedule(s->completion_bh);
-
-    while (io_uring_peek_cqe(&s->ring, &cqes) == 0) {
-        LuringAIOCB *luringcb;
-        int ret;
-
-        if (!cqes) {
-            break;
+    if (ret < 0) {
+        /*
+         * Only writev/readv/fsync requests on regular files or host block
+         * devices are submitted. Therefore -EAGAIN is not expected but it's
+         * known to happen sometimes with Linux SCSI. Submit again and hope
+         * the request completes successfully.
+         *
+         * For more information, see:
+         * https://lore.kernel.org/io-uring/20210727165811.284510-3-axboe@kernel.dk/T/#u
+         *
+         * If the code is changed to submit other types of requests in the
+         * future, then this workaround may need to be extended to deal with
+         * genuine -EAGAIN results that should not be resubmitted
+         * immediately.
+         */
+        if (ret == -EINTR || ret == -EAGAIN) {
+            aio_add_sqe(luring_prep_sqe, req, &req->cqe_handler);
+            return;
         }
-
-        luringcb = io_uring_cqe_get_data(cqes);
-        ret = cqes->res;
-        io_uring_cqe_seen(&s->ring, cqes);
-        cqes = NULL;
-
-        /* Change counters one-by-one because we can be nested. */
-        s->io_q.in_flight--;
-        trace_luring_process_completion(s, luringcb, ret);
-
+    } else if (req->qiov) {
         /* total_read is non-zero only for resubmitted read requests */
-        total_bytes = ret + luringcb->total_read;
+        int total_bytes = ret + req->total_read;
 
-        if (ret < 0) {
-            /*
-             * Only writev/readv/fsync requests on regular files or host block
-             * devices are submitted. Therefore -EAGAIN is not expected but it's
-             * known to happen sometimes with Linux SCSI. Submit again and hope
-             * the request completes successfully.
-             *
-             * For more information, see:
-             * https://lore.kernel.org/io-uring/20210727165811.284510-3-axboe@kernel.dk/T/#u
-             *
-             * If the code is changed to submit other types of requests in the
-             * future, then this workaround may need to be extended to deal with
-             * genuine -EAGAIN results that should not be resubmitted
-             * immediately.
-             */
-            if (ret == -EINTR || ret == -EAGAIN) {
-                luring_resubmit(s, luringcb);
-                continue;
-            }
-        } else if (!luringcb->qiov) {
-            goto end;
-        } else if (total_bytes == luringcb->qiov->size) {
+        if (total_bytes == req->qiov->size) {
             ret = 0;
-        /* Only read/write */
         } else {
             /* Short Read/Write */
-            if (luringcb->is_read) {
+            if (req->type == QEMU_AIO_READ) {
                 if (ret > 0) {
-                    luring_resubmit_short_read(s, luringcb, ret);
-                    continue;
-                } else {
-                    /* Pad with zeroes */
-                    qemu_iovec_memset(luringcb->qiov, total_bytes, 0,
-                                      luringcb->qiov->size - total_bytes);
-                    ret = 0;
+                    luring_resubmit_short_read(req, ret);
+                    return;
                 }
+
+                /* Pad with zeroes */
+                qemu_iovec_memset(req->qiov, total_bytes, 0,
+                                  req->qiov->size - total_bytes);
+                ret = 0;
             } else {
                 ret = -ENOSPC;
             }
         }
-end:
-        luringcb->ret = ret;
-        qemu_iovec_destroy(&luringcb->resubmit_qiov);
-
-        /*
-         * If the coroutine is already entered it must be in ioq_submit()
-         * and will notice luringcb->ret has been filled in when it
-         * eventually runs later. Coroutines cannot be entered recursively
-         * so avoid doing that!
-         */
-        assert(luringcb->co->ctx == s->aio_context);
-        if (!qemu_coroutine_entered(luringcb->co)) {
-            aio_co_wake(luringcb->co);
-        }
     }
 
-    qemu_bh_cancel(s->completion_bh);
+    req->ret = ret;
+    qemu_iovec_destroy(&req->resubmit_qiov);
 
-    defer_call_end();
-}
-
-static int ioq_submit(LuringState *s)
-{
-    int ret = 0;
-    LuringAIOCB *luringcb, *luringcb_next;
-
-    while (s->io_q.in_queue > 0) {
-        /*
-         * Try to fetch sqes from the ring for requests waiting in
-         * the overflow queue
-         */
-        QSIMPLEQ_FOREACH_SAFE(luringcb, &s->io_q.submit_queue, next,
-                              luringcb_next) {
-            struct io_uring_sqe *sqes = io_uring_get_sqe(&s->ring);
-            if (!sqes) {
-                break;
-            }
-            /* Prep sqe for submission */
-            *sqes = luringcb->sqeq;
-            QSIMPLEQ_REMOVE_HEAD(&s->io_q.submit_queue, next);
-        }
-        ret = io_uring_submit(&s->ring);
-        trace_luring_io_uring_submit(s, ret);
-        /* Prevent infinite loop if submission is refused */
-        if (ret <= 0) {
-            if (ret == -EAGAIN || ret == -EINTR) {
-                continue;
-            }
-            break;
-        }
-        s->io_q.in_flight += ret;
-        s->io_q.in_queue  -= ret;
-    }
-    s->io_q.blocked = (s->io_q.in_queue > 0);
-
-    if (s->io_q.in_flight) {
-        /*
-         * We can try to complete something just right away if there are
-         * still requests in-flight.
-         */
-        luring_process_completions(s);
-    }
-    return ret;
-}
-
-static void luring_process_completions_and_submit(LuringState *s)
-{
-    luring_process_completions(s);
-
-    if (s->io_q.in_queue > 0) {
-        ioq_submit(s);
+    /*
+     * If the coroutine is already entered it must be in luring_co_submit() and
+     * will notice req->ret has been filled in when it eventually runs later.
+     * Coroutines cannot be entered recursively so avoid doing that!
+     */
+    if (!qemu_coroutine_entered(req->co)) {
+        aio_co_wake(req->co);
     }
 }
 
-static void qemu_luring_completion_bh(void *opaque)
+int coroutine_fn luring_co_submit(BlockDriverState *bs, int fd,
+                                  uint64_t offset, QEMUIOVector *qiov,
+                                  int type, BdrvRequestFlags flags)
 {
-    LuringState *s = opaque;
-    luring_process_completions_and_submit(s);
-}
-
-static void qemu_luring_completion_cb(void *opaque)
-{
-    LuringState *s = opaque;
-    luring_process_completions_and_submit(s);
-}
-
-static bool qemu_luring_poll_cb(void *opaque)
-{
-    LuringState *s = opaque;
-
-    return io_uring_cq_ready(&s->ring);
-}
-
-static void qemu_luring_poll_ready(void *opaque)
-{
-    LuringState *s = opaque;
-
-    luring_process_completions_and_submit(s);
-}
-
-static void ioq_init(LuringQueue *io_q)
-{
-    QSIMPLEQ_INIT(&io_q->submit_queue);
-    io_q->in_queue = 0;
-    io_q->in_flight = 0;
-    io_q->blocked = false;
-}
-
-static void luring_deferred_fn(void *opaque)
-{
-    LuringState *s = opaque;
-    trace_luring_unplug_fn(s, s->io_q.blocked, s->io_q.in_queue,
-                           s->io_q.in_flight);
-    if (!s->io_q.blocked && s->io_q.in_queue > 0) {
-        ioq_submit(s);
-    }
-}
-
-/**
- * luring_do_submit:
- * @fd: file descriptor for I/O
- * @luringcb: AIO control block
- * @s: AIO state
- * @offset: offset for request
- * @type: type of request
- *
- * Fetches sqes from ring, adds to pending queue and preps them
- *
- */
-static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
-                            uint64_t offset, int type, BdrvRequestFlags flags)
-{
-    int ret;
-    struct io_uring_sqe *sqes = &luringcb->sqeq;
-
-    switch (type) {
-    case QEMU_AIO_WRITE:
-#ifdef HAVE_IO_URING_PREP_WRITEV2
-    {
-        int luring_flags = (flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
-        io_uring_prep_writev2(sqes, fd, luringcb->qiov->iov,
-                              luringcb->qiov->niov, offset, luring_flags);
-    }
-#else
-        assert(flags == 0);
-        io_uring_prep_writev(sqes, fd, luringcb->qiov->iov,
-                             luringcb->qiov->niov, offset);
-#endif
-        break;
-    case QEMU_AIO_ZONE_APPEND:
-        io_uring_prep_writev(sqes, fd, luringcb->qiov->iov,
-                             luringcb->qiov->niov, offset);
-        break;
-    case QEMU_AIO_READ:
-        io_uring_prep_readv(sqes, fd, luringcb->qiov->iov,
-                            luringcb->qiov->niov, offset);
-        break;
-    case QEMU_AIO_FLUSH:
-        io_uring_prep_fsync(sqes, fd, IORING_FSYNC_DATASYNC);
-        break;
-    default:
-        fprintf(stderr, "%s: invalid AIO request type, aborting 0x%x.\n",
-                        __func__, type);
-        abort();
-    }
-    io_uring_sqe_set_data(sqes, luringcb);
-
-    QSIMPLEQ_INSERT_TAIL(&s->io_q.submit_queue, luringcb, next);
-    s->io_q.in_queue++;
-    trace_luring_do_submit(s, s->io_q.blocked, s->io_q.in_queue,
-                           s->io_q.in_flight);
-    if (!s->io_q.blocked) {
-        if (s->io_q.in_flight + s->io_q.in_queue >= MAX_ENTRIES) {
-            ret = ioq_submit(s);
-            trace_luring_do_submit_done(s, ret);
-            return ret;
-        }
-
-        defer_call(luring_deferred_fn, s);
-    }
-    return 0;
-}
-
-int coroutine_fn luring_co_submit(BlockDriverState *bs, int fd, uint64_t offset,
-                                  QEMUIOVector *qiov, int type,
-                                  BdrvRequestFlags flags)
-{
-    int ret;
-    AioContext *ctx = qemu_get_current_aio_context();
-    LuringState *s = aio_get_linux_io_uring(ctx);
-    LuringAIOCB luringcb = {
+    LuringRequest req = {
         .co         = qemu_coroutine_self(),
-        .ret        = -EINPROGRESS,
         .qiov       = qiov,
-        .is_read    = (type == QEMU_AIO_READ),
+        .ret        = -EINPROGRESS,
+        .type       = type,
+        .fd         = fd,
+        .offset     = offset,
+        .flags      = flags,
     };
-    trace_luring_co_submit(bs, s, &luringcb, fd, offset, qiov ? qiov->size : 0,
-                           type);
-    ret = luring_do_submit(fd, &luringcb, s, offset, type, flags);
 
-    if (ret < 0) {
-        return ret;
-    }
+    req.cqe_handler.cb = luring_cqe_handler;
 
-    if (luringcb.ret == -EINPROGRESS) {
+    trace_luring_co_submit(bs, &req, fd, offset, qiov ? qiov->size : 0, type);
+    aio_add_sqe(luring_prep_sqe, &req, &req.cqe_handler);
+
+    if (req.ret == -EINPROGRESS) {
         qemu_coroutine_yield();
     }
-    return luringcb.ret;
-}
-
-void luring_detach_aio_context(LuringState *s, AioContext *old_context)
-{
-    aio_set_fd_handler(old_context, s->ring.ring_fd,
-                       NULL, NULL, NULL, NULL, s);
-    qemu_bh_delete(s->completion_bh);
-    s->aio_context = NULL;
-}
-
-void luring_attach_aio_context(LuringState *s, AioContext *new_context)
-{
-    s->aio_context = new_context;
-    s->completion_bh = aio_bh_new(new_context, qemu_luring_completion_bh, s);
-    aio_set_fd_handler(s->aio_context, s->ring.ring_fd,
-                       qemu_luring_completion_cb, NULL,
-                       qemu_luring_poll_cb, qemu_luring_poll_ready, s);
-}
-
-LuringState *luring_init(Error **errp)
-{
-    int rc;
-    LuringState *s = g_new0(LuringState, 1);
-    struct io_uring *ring = &s->ring;
-
-    trace_luring_init_state(s, sizeof(*s));
-
-    rc = io_uring_queue_init(MAX_ENTRIES, ring, 0);
-    if (rc < 0) {
-        error_setg_errno(errp, -rc, "failed to init linux io_uring ring");
-        g_free(s);
-        return NULL;
-    }
-
-    ioq_init(&s->io_q);
-    return s;
-
-}
-
-void luring_cleanup(LuringState *s)
-{
-    io_uring_queue_exit(&s->ring);
-    trace_luring_cleanup_state(s);
-    g_free(s);
+    return req.ret;
 }
 
 bool luring_has_fua(void)
diff --git a/stubs/io_uring.c b/stubs/io_uring.c
deleted file mode 100644
index 622d1e4648..0000000000
--- a/stubs/io_uring.c
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * Linux io_uring support.
- *
- * Copyright (C) 2009 IBM, Corp.
- * Copyright (C) 2009 Red Hat, Inc.
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-#include "qemu/osdep.h"
-#include "block/aio.h"
-#include "block/raw-aio.h"
-
-void luring_detach_aio_context(LuringState *s, AioContext *old_context)
-{
-    abort();
-}
-
-void luring_attach_aio_context(LuringState *s, AioContext *new_context)
-{
-    abort();
-}
-
-LuringState *luring_init(Error **errp)
-{
-    abort();
-}
-
-void luring_cleanup(LuringState *s)
-{
-    abort();
-}
diff --git a/util/async.c b/util/async.c
index 00e46b99f9..a216cf8695 100644
--- a/util/async.c
+++ b/util/async.c
@@ -386,14 +386,6 @@ aio_ctx_finalize(GSource *source)
     }
 #endif
 
-#ifdef CONFIG_LINUX_IO_URING
-    if (ctx->linux_io_uring) {
-        luring_detach_aio_context(ctx->linux_io_uring, ctx);
-        luring_cleanup(ctx->linux_io_uring);
-        ctx->linux_io_uring = NULL;
-    }
-#endif
-
     assert(QSLIST_EMPTY(&ctx->scheduled_coroutines));
     qemu_bh_delete(ctx->co_schedule_bh);
 
@@ -468,29 +460,6 @@ LinuxAioState *aio_get_linux_aio(AioContext *ctx)
 }
 #endif
 
-#ifdef CONFIG_LINUX_IO_URING
-LuringState *aio_setup_linux_io_uring(AioContext *ctx, Error **errp)
-{
-    if (ctx->linux_io_uring) {
-        return ctx->linux_io_uring;
-    }
-
-    ctx->linux_io_uring = luring_init(errp);
-    if (!ctx->linux_io_uring) {
-        return NULL;
-    }
-
-    luring_attach_aio_context(ctx->linux_io_uring, ctx);
-    return ctx->linux_io_uring;
-}
-
-LuringState *aio_get_linux_io_uring(AioContext *ctx)
-{
-    assert(ctx->linux_io_uring);
-    return ctx->linux_io_uring;
-}
-#endif
-
 void aio_notify(AioContext *ctx)
 {
     /*
@@ -630,10 +599,6 @@ AioContext *aio_context_new(Error **errp)
     ctx->linux_aio = NULL;
 #endif
 
-#ifdef CONFIG_LINUX_IO_URING
-    ctx->linux_io_uring = NULL;
-#endif
-
     ctx->thread_pool = NULL;
     qemu_rec_mutex_init(&ctx->lock);
     timerlistgroup_init(&ctx->tlg, aio_timerlist_notify, ctx);
diff --git a/block/trace-events b/block/trace-events
index 8e789e1f12..c9b4736ff8 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -62,15 +62,9 @@ qmp_block_stream(void *bs) "bs %p"
 file_paio_submit(void *acb, void *opaque, int64_t offset, int count, int type) "acb %p opaque %p offset %"PRId64" count %d type %d"
 
 # io_uring.c
-luring_init_state(void *s, size_t size) "s %p size %zu"
-luring_cleanup_state(void *s) "%p freed"
-luring_unplug_fn(void *s, int blocked, int queued, int inflight) "LuringState %p blocked %d queued %d inflight %d"
-luring_do_submit(void *s, int blocked, int queued, int inflight) "LuringState %p blocked %d queued %d inflight %d"
-luring_do_submit_done(void *s, int ret) "LuringState %p submitted to kernel %d"
-luring_co_submit(void *bs, void *s, void *luringcb, int fd, uint64_t offset, size_t nbytes, int type) "bs %p s %p luringcb %p fd %d offset %" PRId64 " nbytes %zd type %d"
-luring_process_completion(void *s, void *aiocb, int ret) "LuringState %p luringcb %p ret %d"
-luring_io_uring_submit(void *s, int ret) "LuringState %p ret %d"
-luring_resubmit_short_read(void *s, void *luringcb, int nread) "LuringState %p luringcb %p nread %d"
+luring_cqe_handler(void *req, int ret) "req %p ret %d"
+luring_co_submit(void *bs, void *req, int fd, uint64_t offset, size_t nbytes, int type) "bs %p req %p fd %d offset %" PRId64 " nbytes %zd type %d"
+luring_resubmit_short_read(void *req, int nread) "req %p nread %d"
 
 # qcow2.c
 qcow2_add_task(void *co, void *bs, void *pool, const char *action, int cluster_type, uint64_t host_offset, uint64_t offset, uint64_t bytes, void *qiov, size_t qiov_offset) "co %p bs %p pool %p: %s: cluster_type %d file_cluster_offset %" PRIu64 " offset %" PRIu64 " bytes %" PRIu64 " qiov %p qiov_offset %zu"
diff --git a/stubs/meson.build b/stubs/meson.build
index 27be2dec9f..0b2778c568 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -32,9 +32,6 @@ if have_block or have_ga
   stub_ss.add(files('cpus-virtual-clock.c'))
   stub_ss.add(files('icount.c'))
   stub_ss.add(files('graph-lock.c'))
-  if linux_io_uring.found()
-    stub_ss.add(files('io_uring.c'))
-  endif
   if libaio.found()
     stub_ss.add(files('linux-aio.c'))
   endif
-- 
2.51.1


