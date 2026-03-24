Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956B6FEC0F9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 18:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w56vo-0004nG-1j; Tue, 24 Mar 2026 14:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w56vl-0004lf-Gx
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w56vi-0006gj-7o
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774378601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vYLRVkEFu3u6NRtdyf4XOOl7vJtxtDskGaH7IviXuiY=;
 b=a1sEjUp7zcsNdIcKbA/9fq10o01xzNThTCGzUNQnWjgFa4Jhv9ecIy0pQLx3Q30yupdd/j
 AwjE1PkE5xS83d9WBZf78fHWlT2wCrr2SI6x6rsd4FptnrKkEVM4OGefTzEvMgF9jiIO5n
 vHizkKx0LpZB52Hc4SXSDRt/sDYJdDg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-jx4g9OdBPEiQKKVwZr7gKw-1; Tue,
 24 Mar 2026 14:56:39 -0400
X-MC-Unique: jx4g9OdBPEiQKKVwZr7gKw-1
X-Mimecast-MFC-AGG-ID: jx4g9OdBPEiQKKVwZr7gKw_1774378599
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D60871955D84; Tue, 24 Mar 2026 18:56:38 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.33.246])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 79F81300019F; Tue, 24 Mar 2026 18:56:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 4/4] io-uring: Resubmit tails of short writes
Date: Tue, 24 Mar 2026 19:56:19 +0100
Message-ID: <20260324185619.296946-5-kwolf@redhat.com>
In-Reply-To: <20260324185619.296946-1-kwolf@redhat.com>
References: <20260324185619.296946-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

Short writes can happen, too, not just short reads.  The difference to
aio=native is that the kernel will actually retry the tail of short
requests internally already -- so it is harder to reproduce.  But if the
tail of a short request returns an error to the kernel, we will see it
in userspace still.  To reproduce this, apply the following patch on top
of the one shown in HEAD^ (again %s/escaped // to apply):

escaped diff --git a/block/export/fuse.c b/block/export/fuse.c
escaped index 67dc50a412..2b98489a32 100644
escaped --- a/block/export/fuse.c
escaped +++ b/block/export/fuse.c
@@ -1059,8 +1059,15 @@ fuse_co_read(FuseExport *exp, void **bufptr, uint64_t offset, uint32_t size)
     int64_t blk_len;
     void *buf;
     int ret;
+    static uint32_t error_size;

-    size = MIN(size, 4096);
+    if (error_size == size) {
+        error_size = 0;
+        return -EIO;
+    } else if (size > 4096) {
+        error_size = size - 4096;
+        size = 4096;
+    }

     /* Limited by max_read, should not happen */
     if (size > FUSE_MAX_READ_BYTES) {
@@ -1111,8 +1118,15 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
 {
     int64_t blk_len;
     int ret;
+    static uint32_t error_size;

-    size = MIN(size, 4096);
+    if (error_size == size) {
+        error_size = 0;
+        return -EIO;
+    } else if (size > 4096) {
+        error_size = size - 4096;
+        size = 4096;
+    }

     QEMU_BUILD_BUG_ON(FUSE_MAX_WRITE_BYTES > BDRV_REQUEST_MAX_BYTES);
     /* Limited by max_write, should not happen */

I know this is a bit artificial because to produce this, there must be
an I/O error somewhere anyway, but if it does happen, qemu will
understand it to mean ENOSPC for short writes, which is incorrect.  So I
believe we need to resubmit the tail to maybe have it succeed now, or at
least get the correct error code.

Reproducer as before:
$ ./qemu-img create -f raw test.raw 8k
Formatting 'test.raw', fmt=raw size=8192
$ ./qemu-io -f raw -c 'write -P 42 0 8k' test.raw
wrote 8192/8192 bytes at offset 0
8 KiB, 1 ops; 00.00 sec (64.804 MiB/sec and 8294.9003 ops/sec)
$ hexdump -C test.raw
00000000  2a 2a 2a 2a 2a 2a 2a 2a  2a 2a 2a 2a 2a 2a 2a 2a  |****************|
*
00002000
$ storage-daemon/qemu-storage-daemon \
    --blockdev file,node-name=test,filename=test.raw \
    --export fuse,id=exp,node-name=test,mountpoint=test.raw,writable=true

$ ./qemu-io --image-opts -c 'read -P 23 0 8k' \
    driver=file,filename=test.raw,cache.direct=on,aio=io_uring
read 8192/8192 bytes at offset 0
8 KiB, 1 ops; 00.00 sec (58.481 MiB/sec and 7485.5342 ops/sec)
$ ./qemu-io --image-opts -c 'write -P 23 0 8k' \
    driver=file,filename=test.raw,cache.direct=on,aio=io_uring
write failed: No space left on device
$ hexdump -C test.raw
00000000  17 17 17 17 17 17 17 17  17 17 17 17 17 17 17 17  |................|
*
00001000  2a 2a 2a 2a 2a 2a 2a 2a  2a 2a 2a 2a 2a 2a 2a 2a  |****************|
*
00002000

So short reads already work (because there is code for that), but short
writes incorrectly produce ENOSPC.  This patch fixes that by
resubmitting not only the tail of short reads but short writes also.

(And this patch uses the opportunity to make it so qemu_iovec_destroy()
is called only if req->resubmit_qiov.iov is non-NULL.  Functionally a
non-op, but this is how the code generally checks whether the
resubmit_qiov has been set up or not.)

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260324084338.37453-4-hreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io_uring.c   | 82 +++++++++++++++++++++++++---------------------
 block/trace-events |  2 +-
 2 files changed, 46 insertions(+), 38 deletions(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index cb131d3b8b5..c48a72d37eb 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -27,10 +27,10 @@ typedef struct {
     BdrvRequestFlags flags;
 
     /*
-     * Buffered reads may require resubmission, see
-     * luring_resubmit_short_read().
+     * Short reads/writes require resubmission, see
+     * luring_resubmit_short_io().
      */
-    int total_read;
+    int total_done;
     QEMUIOVector resubmit_qiov;
 
     CqeHandler cqe_handler;
@@ -40,10 +40,14 @@ static void luring_prep_sqe(struct io_uring_sqe *sqe, void *opaque)
 {
     LuringRequest *req = opaque;
     QEMUIOVector *qiov = req->qiov;
-    uint64_t offset = req->offset;
+    uint64_t offset = req->offset + req->total_done;
     int fd = req->fd;
     BdrvRequestFlags flags = req->flags;
 
+    if (req->resubmit_qiov.iov) {
+        qiov = &req->resubmit_qiov;
+    }
+
     switch (req->type) {
     case QEMU_AIO_WRITE:
     {
@@ -73,17 +77,12 @@ static void luring_prep_sqe(struct io_uring_sqe *sqe, void *opaque)
         break;
     case QEMU_AIO_READ:
     {
-        if (req->resubmit_qiov.iov != NULL) {
-            qiov = &req->resubmit_qiov;
-        }
         if (qiov->niov > 1) {
-            io_uring_prep_readv(sqe, fd, qiov->iov, qiov->niov,
-                                offset + req->total_read);
+            io_uring_prep_readv(sqe, fd, qiov->iov, qiov->niov, offset);
         } else {
             /* The man page says non-vectored is faster than vectored */
             struct iovec *iov = qiov->iov;
-            io_uring_prep_read(sqe, fd, iov->iov_base, iov->iov_len,
-                               offset + req->total_read);
+            io_uring_prep_read(sqe, fd, iov->iov_base, iov->iov_len, offset);
         }
         break;
     }
@@ -98,21 +97,26 @@ static void luring_prep_sqe(struct io_uring_sqe *sqe, void *opaque)
 }
 
 /**
- * luring_resubmit_short_read:
+ * luring_resubmit_short_io:
  *
- * Short reads are rare but may occur. The remaining read request needs to be
- * resubmitted.
+ * Short reads and writes are rare but may occur.  The remaining request needs
+ * to be resubmitted.
+ *
+ * For example, short reads can be reproduced by a FUSE export deliberately
+ * executing short reads.  The tail of short writes is generally resubmitted by
+ * io-uring in the kernel, but if that resubmission encounters an I/O error, the
+ * already submitted portion will be returned as a short write.
  */
-static void luring_resubmit_short_read(LuringRequest *req, int nread)
+static void luring_resubmit_short_io(LuringRequest *req, int ndone)
 {
     QEMUIOVector *resubmit_qiov;
     size_t remaining;
 
-    trace_luring_resubmit_short_read(req, nread);
+    trace_luring_resubmit_short_io(req, ndone);
 
-    /* Update read position */
-    req->total_read += nread;
-    remaining = req->qiov->size - req->total_read;
+    /* Update I/O position */
+    req->total_done += ndone;
+    remaining = req->qiov->size - req->total_done;
 
     /* Shorten qiov */
     resubmit_qiov = &req->resubmit_qiov;
@@ -121,7 +125,7 @@ static void luring_resubmit_short_read(LuringRequest *req, int nread)
     } else {
         qemu_iovec_reset(resubmit_qiov);
     }
-    qemu_iovec_concat(resubmit_qiov, req->qiov, req->total_read, remaining);
+    qemu_iovec_concat(resubmit_qiov, req->qiov, req->total_done, remaining);
 
     aio_add_sqe(luring_prep_sqe, req, &req->cqe_handler);
 }
@@ -153,31 +157,35 @@ static void luring_cqe_handler(CqeHandler *cqe_handler)
             return;
         }
     } else if (req->qiov) {
-        /* total_read is non-zero only for resubmitted read requests */
-        int total_bytes = ret + req->total_read;
+        /* total_done is non-zero only for resubmitted requests */
+        int total_bytes = ret + req->total_done;
 
         if (total_bytes == req->qiov->size) {
             ret = 0;
-        } else {
+        } else if (ret > 0 && (req->type == QEMU_AIO_READ ||
+                               req->type == QEMU_AIO_WRITE)) {
             /* Short Read/Write */
-            if (req->type == QEMU_AIO_READ) {
-                if (ret > 0) {
-                    luring_resubmit_short_read(req, ret);
-                    return;
-                }
-
-                /* Pad with zeroes */
-                qemu_iovec_memset(req->qiov, total_bytes, 0,
-                                  req->qiov->size - total_bytes);
-                ret = 0;
-            } else {
-                ret = -ENOSPC;
-            }
+            luring_resubmit_short_io(req, ret);
+            return;
+        } else if (req->type == QEMU_AIO_READ) {
+            /* Read ret == 0: EOF, pad with zeroes */
+            qemu_iovec_memset(req->qiov, total_bytes, 0,
+                              req->qiov->size - total_bytes);
+            ret = 0;
+        } else {
+            /*
+             * Normal write ret == 0 means ENOSPC.
+             * For zone-append, we treat any 0 <= ret < qiov->size as ENOSPC,
+             * too, because resubmitting the tail seems a little unsafe.
+             */
+            ret = -ENOSPC;
         }
     }
 
     req->ret = ret;
-    qemu_iovec_destroy(&req->resubmit_qiov);
+    if (req->resubmit_qiov.iov) {
+        qemu_iovec_destroy(&req->resubmit_qiov);
+    }
 
     /*
      * If the coroutine is already entered it must be in luring_co_submit() and
diff --git a/block/trace-events b/block/trace-events
index d170fc96f15..950c82d4b80 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -64,7 +64,7 @@ file_paio_submit(void *acb, void *opaque, int64_t offset, int count, int type) "
 # io_uring.c
 luring_cqe_handler(void *req, int ret) "req %p ret %d"
 luring_co_submit(void *bs, void *req, int fd, uint64_t offset, size_t nbytes, int type) "bs %p req %p fd %d offset %" PRId64 " nbytes %zd type %d"
-luring_resubmit_short_read(void *req, int nread) "req %p nread %d"
+luring_resubmit_short_io(void *req, int ndone) "req %p ndone %d"
 
 # qcow2.c
 qcow2_add_task(void *co, void *bs, void *pool, const char *action, int cluster_type, uint64_t host_offset, uint64_t offset, uint64_t bytes, void *qiov, size_t qiov_offset) "co %p bs %p pool %p: %s: cluster_type %d file_cluster_offset %" PRIu64 " offset %" PRIu64 " bytes %" PRIu64 " qiov %p qiov_offset %zu"
-- 
2.53.0


