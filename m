Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DA1C28B2E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqg0T-00026s-GN; Fri, 07 Mar 2025 17:17:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tqg03-0001ul-IR
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:16:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tqg01-0007oC-04
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741385815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RAEyVNp/AZ40N8kx3WluPGDoxq+FiGv4Fk+Txpq0sqk=;
 b=GsDpZwKfmecsJ7RFQsiCcQ6Fwtjn28iRdM5rExvhzY7hEunNyuNaE6W5CGXsh56JqTuM97
 hWNYb7x6rSe5xSfMn0oNa3C/EyHta2g91u0ocUVcply8LO/FnW80iSoL8rZO+kPep09e8v
 Ubf7jXBaqUcEeFiTyDJOf/IXIgzHyaY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-oJq7u8p-NZKQsLfEbbOhrA-1; Fri,
 07 Mar 2025 17:16:52 -0500
X-MC-Unique: oJq7u8p-NZKQsLfEbbOhrA-1
X-Mimecast-MFC-AGG-ID: oJq7u8p-NZKQsLfEbbOhrA_1741385811
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 484011955D4B; Fri,  7 Mar 2025 22:16:51 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.226.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB070180174F; Fri,  7 Mar 2025 22:16:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 afaria@redhat.com, hreitz@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 1/5] file-posix: Support FUA writes
Date: Fri,  7 Mar 2025 23:16:30 +0100
Message-ID: <20250307221634.71951-2-kwolf@redhat.com>
In-Reply-To: <20250307221634.71951-1-kwolf@redhat.com>
References: <20250307221634.71951-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Until now, FUA was always emulated with a separate flush after the write
for file-posix. The overhead of processing a second request can reduce
performance significantly for a guest disk that has disabled the write
cache, especially if the host disk is already write through, too, and
the flush isn't actually doing anything.

Advertise support for REQ_FUA in write requests and implement it for
Linux AIO and io_uring using the RWF_DSYNC flag for write requests. The
thread pool still performs a separate fdatasync() call. This can be
improved later by using the pwritev2() syscall if available.

As an example, this is how fio numbers can be improved in some scenarios
with this patch (all using virtio-blk with cache=directsync on an nvme
block device for the VM, fio with ioengine=libaio,direct=1,sync=1):

                              | old           | with FUA support
------------------------------+---------------+-------------------
bs=4k, iodepth=1, numjobs=1   |  45.6k iops   |  56.1k iops
bs=4k, iodepth=1, numjobs=16  | 183.3k iops   | 236.0k iops
bs=4k, iodepth=16, numjobs=1  | 258.4k iops   | 311.1k iops

However, not all scenarios are clear wins. On another slower disk I saw
little to no improvment. In fact, in two corner case scenarios, I even
observed a regression, which I however consider acceptable:

1. On slow host disks in a write through cache mode, when the guest is
   using virtio-blk in a separate iothread so that polling can be
   enabled, and each completion is quickly followed up with a new
   request (so that polling gets it), it can happen that enabling FUA
   makes things slower - the additional very fast no-op flush we used to
   have gave the adaptive polling algorithm a success so that it kept
   polling. Without it, we only have the slow write request, which
   disables polling. This is a problem in the polling algorithm that
   will be fixed later in this series.

2. With a high queue depth, it can be beneficial to have flush requests
   for another reason: The optimisation in bdrv_co_flush() that flushes
   only once per write generation acts as a synchronisation mechanism
   that lets all requests complete at the same time. This can result in
   better batching and if the disk is very fast (I only saw this with a
   null_blk backend), this can make up for the overhead of the flush and
   improve throughput. In theory, we could optionally introduce a
   similar artificial latency in the normal completion path to achieve
   the same kind of completion batching. This is not implemented in this
   series.

Compatibility is not a concern for io_uring, it has supported RWF_DSYNC
from the start. Linux AIO started supporting it in Linux 4.13 and libaio
0.3.111. The kernel is not a problem for any supported build platform,
so it's not necessary to add runtime checks. However, openSUSE is still
stuck with an older libaio version that would break the build. We must
detect this at build time to avoid build failures.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/raw-aio.h |  8 ++++++--
 block/file-posix.c      | 26 ++++++++++++++++++--------
 block/io_uring.c        | 13 ++++++++-----
 block/linux-aio.c       | 24 +++++++++++++++++++++---
 meson.build             |  4 ++++
 5 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index 626706827f..247bdbff13 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -17,6 +17,7 @@
 #define QEMU_RAW_AIO_H
 
 #include "block/aio.h"
+#include "block/block-common.h"
 #include "qemu/iov.h"
 
 /* AIO request types */
@@ -58,9 +59,11 @@ void laio_cleanup(LinuxAioState *s);
 
 /* laio_co_submit: submit I/O requests in the thread's current AioContext. */
 int coroutine_fn laio_co_submit(int fd, uint64_t offset, QEMUIOVector *qiov,
-                                int type, uint64_t dev_max_batch);
+                                int type, BdrvRequestFlags flags,
+                                uint64_t dev_max_batch);
 
 bool laio_has_fdsync(int);
+bool laio_has_fua(void);
 void laio_detach_aio_context(LinuxAioState *s, AioContext *old_context);
 void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context);
 #endif
@@ -71,7 +74,8 @@ void luring_cleanup(LuringState *s);
 
 /* luring_co_submit: submit I/O requests in the thread's current AioContext. */
 int coroutine_fn luring_co_submit(BlockDriverState *bs, int fd, uint64_t offset,
-                                  QEMUIOVector *qiov, int type);
+                                  QEMUIOVector *qiov, int type,
+                                  BdrvRequestFlags flags);
 void luring_detach_aio_context(LuringState *s, AioContext *old_context);
 void luring_attach_aio_context(LuringState *s, AioContext *new_context);
 #endif
diff --git a/block/file-posix.c b/block/file-posix.c
index 44e16dda87..0f1c722804 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -194,6 +194,7 @@ static int fd_open(BlockDriverState *bs)
 }
 
 static int64_t raw_getlength(BlockDriverState *bs);
+static int coroutine_fn raw_co_flush_to_disk(BlockDriverState *bs);
 
 typedef struct RawPosixAIOData {
     BlockDriverState *bs;
@@ -804,6 +805,10 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
 #endif
     s->needs_alignment = raw_needs_alignment(bs);
 
+    if (!s->use_linux_aio || laio_has_fua()) {
+        bs->supported_write_flags = BDRV_REQ_FUA;
+    }
+
     bs->supported_zero_flags = BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK;
     if (S_ISREG(st.st_mode)) {
         /* When extending regular files, we get zeros from the OS */
@@ -2477,7 +2482,8 @@ static inline bool raw_check_linux_aio(BDRVRawState *s)
 #endif
 
 static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
-                                   uint64_t bytes, QEMUIOVector *qiov, int type)
+                                   uint64_t bytes, QEMUIOVector *qiov, int type,
+                                   int flags)
 {
     BDRVRawState *s = bs->opaque;
     RawPosixAIOData acb;
@@ -2508,13 +2514,13 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
 #ifdef CONFIG_LINUX_IO_URING
     } else if (raw_check_linux_io_uring(s)) {
         assert(qiov->size == bytes);
-        ret = luring_co_submit(bs, s->fd, offset, qiov, type);
+        ret = luring_co_submit(bs, s->fd, offset, qiov, type, flags);
         goto out;
 #endif
 #ifdef CONFIG_LINUX_AIO
     } else if (raw_check_linux_aio(s)) {
         assert(qiov->size == bytes);
-        ret = laio_co_submit(s->fd, offset, qiov, type,
+        ret = laio_co_submit(s->fd, offset, qiov, type, flags,
                               s->aio_max_batch);
         goto out;
 #endif
@@ -2534,6 +2540,10 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
 
     assert(qiov->size == bytes);
     ret = raw_thread_pool_submit(handle_aiocb_rw, &acb);
+    if (ret == 0 && (flags & BDRV_REQ_FUA)) {
+        /* TODO Use pwritev2() instead if it's available */
+        ret = raw_co_flush_to_disk(bs);
+    }
     goto out; /* Avoid the compiler err of unused label */
 
 out:
@@ -2571,14 +2581,14 @@ static int coroutine_fn raw_co_preadv(BlockDriverState *bs, int64_t offset,
                                       int64_t bytes, QEMUIOVector *qiov,
                                       BdrvRequestFlags flags)
 {
-    return raw_co_prw(bs, &offset, bytes, qiov, QEMU_AIO_READ);
+    return raw_co_prw(bs, &offset, bytes, qiov, QEMU_AIO_READ, flags);
 }
 
 static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, int64_t offset,
                                        int64_t bytes, QEMUIOVector *qiov,
                                        BdrvRequestFlags flags)
 {
-    return raw_co_prw(bs, &offset, bytes, qiov, QEMU_AIO_WRITE);
+    return raw_co_prw(bs, &offset, bytes, qiov, QEMU_AIO_WRITE, flags);
 }
 
 static int coroutine_fn raw_co_flush_to_disk(BlockDriverState *bs)
@@ -2600,12 +2610,12 @@ static int coroutine_fn raw_co_flush_to_disk(BlockDriverState *bs)
 
 #ifdef CONFIG_LINUX_IO_URING
     if (raw_check_linux_io_uring(s)) {
-        return luring_co_submit(bs, s->fd, 0, NULL, QEMU_AIO_FLUSH);
+        return luring_co_submit(bs, s->fd, 0, NULL, QEMU_AIO_FLUSH, 0);
     }
 #endif
 #ifdef CONFIG_LINUX_AIO
     if (s->has_laio_fdsync && raw_check_linux_aio(s)) {
-        return laio_co_submit(s->fd, 0, NULL, QEMU_AIO_FLUSH, 0);
+        return laio_co_submit(s->fd, 0, NULL, QEMU_AIO_FLUSH, 0, 0);
     }
 #endif
     return raw_thread_pool_submit(handle_aiocb_flush, &acb);
@@ -3540,7 +3550,7 @@ static int coroutine_fn raw_co_zone_append(BlockDriverState *bs,
     }
 
     trace_zbd_zone_append(bs, *offset >> BDRV_SECTOR_BITS);
-    return raw_co_prw(bs, offset, len, qiov, QEMU_AIO_ZONE_APPEND);
+    return raw_co_prw(bs, offset, len, qiov, QEMU_AIO_ZONE_APPEND, 0);
 }
 #endif
 
diff --git a/block/io_uring.c b/block/io_uring.c
index f52b66b340..dc967dbf91 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -335,15 +335,17 @@ static void luring_deferred_fn(void *opaque)
  *
  */
 static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
-                            uint64_t offset, int type)
+                            uint64_t offset, int type, BdrvRequestFlags flags)
 {
     int ret;
     struct io_uring_sqe *sqes = &luringcb->sqeq;
+    int luring_flags;
 
     switch (type) {
     case QEMU_AIO_WRITE:
-        io_uring_prep_writev(sqes, fd, luringcb->qiov->iov,
-                             luringcb->qiov->niov, offset);
+        luring_flags = (flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
+        io_uring_prep_writev2(sqes, fd, luringcb->qiov->iov,
+                              luringcb->qiov->niov, offset, luring_flags);
         break;
     case QEMU_AIO_ZONE_APPEND:
         io_uring_prep_writev(sqes, fd, luringcb->qiov->iov,
@@ -380,7 +382,8 @@ static int luring_do_submit(int fd, LuringAIOCB *luringcb, LuringState *s,
 }
 
 int coroutine_fn luring_co_submit(BlockDriverState *bs, int fd, uint64_t offset,
-                                  QEMUIOVector *qiov, int type)
+                                  QEMUIOVector *qiov, int type,
+                                  BdrvRequestFlags flags)
 {
     int ret;
     AioContext *ctx = qemu_get_current_aio_context();
@@ -393,7 +396,7 @@ int coroutine_fn luring_co_submit(BlockDriverState *bs, int fd, uint64_t offset,
     };
     trace_luring_co_submit(bs, s, &luringcb, fd, offset, qiov ? qiov->size : 0,
                            type);
-    ret = luring_do_submit(fd, &luringcb, s, offset, type);
+    ret = luring_do_submit(fd, &luringcb, s, offset, type, flags);
 
     if (ret < 0) {
         return ret;
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 194c8f434f..1108ae361c 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -368,15 +368,23 @@ static void laio_deferred_fn(void *opaque)
 }
 
 static int laio_do_submit(int fd, struct qemu_laiocb *laiocb, off_t offset,
-                          int type, uint64_t dev_max_batch)
+                          int type, BdrvRequestFlags flags,
+                          uint64_t dev_max_batch)
 {
     LinuxAioState *s = laiocb->ctx;
     struct iocb *iocbs = &laiocb->iocb;
     QEMUIOVector *qiov = laiocb->qiov;
+    int laio_flags;
 
     switch (type) {
     case QEMU_AIO_WRITE:
+#ifdef HAVE_IO_PREP_PWRITEV2
+        laio_flags = (flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
+        io_prep_pwritev2(iocbs, fd, qiov->iov, qiov->niov, offset, laio_flags);
+#else
+        assert(flags == 0);
         io_prep_pwritev(iocbs, fd, qiov->iov, qiov->niov, offset);
+#endif
         break;
     case QEMU_AIO_ZONE_APPEND:
         io_prep_pwritev(iocbs, fd, qiov->iov, qiov->niov, offset);
@@ -409,7 +417,8 @@ static int laio_do_submit(int fd, struct qemu_laiocb *laiocb, off_t offset,
 }
 
 int coroutine_fn laio_co_submit(int fd, uint64_t offset, QEMUIOVector *qiov,
-                                int type, uint64_t dev_max_batch)
+                                int type, BdrvRequestFlags flags,
+                                uint64_t dev_max_batch)
 {
     int ret;
     AioContext *ctx = qemu_get_current_aio_context();
@@ -422,7 +431,7 @@ int coroutine_fn laio_co_submit(int fd, uint64_t offset, QEMUIOVector *qiov,
         .qiov       = qiov,
     };
 
-    ret = laio_do_submit(fd, &laiocb, offset, type, dev_max_batch);
+    ret = laio_do_submit(fd, &laiocb, offset, type, flags, dev_max_batch);
     if (ret < 0) {
         return ret;
     }
@@ -505,3 +514,12 @@ bool laio_has_fdsync(int fd)
     io_destroy(ctx);
     return (ret == -EINVAL) ? false : true;
 }
+
+bool laio_has_fua(void)
+{
+#ifdef HAVE_IO_PREP_PWRITEV2
+    return true;
+#else
+    return false;
+#endif
+}
diff --git a/meson.build b/meson.build
index 0ee79c664d..b2b2c9bb46 100644
--- a/meson.build
+++ b/meson.build
@@ -2724,6 +2724,10 @@ config_host_data.set('HAVE_OPTRESET',
                      cc.has_header_symbol('getopt.h', 'optreset'))
 config_host_data.set('HAVE_IPPROTO_MPTCP',
                      cc.has_header_symbol('netinet/in.h', 'IPPROTO_MPTCP'))
+if libaio.found()
+  config_host_data.set('HAVE_IO_PREP_PWRITEV2',
+                       cc.has_header_symbol('libaio.h', 'io_prep_pwritev2'))
+endif
 
 # has_member
 config_host_data.set('HAVE_SIGEV_NOTIFY_THREAD_ID',
-- 
2.48.1


