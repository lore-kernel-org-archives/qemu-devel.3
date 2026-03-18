Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B9E103E199
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 15:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ssw-0002ZF-IS; Wed, 18 Mar 2026 11:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2sst-0002Y3-OU
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 11:32:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2ssr-0000Q8-Mo
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 11:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773847952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2/+0Og3S4wOSV0lrvsiMpNrEkJuUBoXaBIw/93KO9Q=;
 b=enRTSXT3lD/ty5i+iWEFnRDw9wfbpZe5qUbWADrJgYg5/hmjh7PIZb08x6M9D4LD2nHAwf
 iMokqC/E4cOzRxgXNPMiWE6qn/qEQTBoQBmdKAVJ0/KnB4NK9yq0HUB10oni7xqKLR+q2N
 RvCdqdpAldynnfTQ22A8HF+0qXtXI5k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-4vVGwpL8OWaD-VSdYdDgNg-1; Wed, 18 Mar 2026 11:32:25 -0400
X-MC-Unique: 4vVGwpL8OWaD-VSdYdDgNg-1
X-Mimecast-MFC-AGG-ID: 4vVGwpL8OWaD-VSdYdDgNg_1773847944
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43b3c9568a3so337669f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 08:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773847944; x=1774452744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V2/+0Og3S4wOSV0lrvsiMpNrEkJuUBoXaBIw/93KO9Q=;
 b=rc5mBJ21dTQTwJma7ohMFRiylnJJ+aKypbpMSzRLFIqu+tgxa0Bko4L49i4KnwwHid
 gfciNtbCAMOLZSjBU2wa1NGzmJhUMKHOMYlBD3rKoQZcZ+eMuFpmZnJ1tt8/jHrIz1WY
 KcKRRlCECzXRHq14uaMhOJ7/lua8ZeerAApMcxhdUhGS87pvCIYeqW2oOc8bnYiFRPDv
 wkNwFdal6I32IEWjxt6DjTSUfcRCaTURes+PQ3Qd7oyS+nU2zZB/yY21alpZ4KS1lOEq
 1Yc2fNj/vQcK/nJOMqdO6x5zfbpla0FDOl/gyfIhANRHLC4hIuVOqMNHoLZy+K0LOXDk
 9thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773847944; x=1774452744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V2/+0Og3S4wOSV0lrvsiMpNrEkJuUBoXaBIw/93KO9Q=;
 b=J43tHJm4DBxB2+U1eMAqljLui/GMYxL0KZe6DFTsN8nWhZ1OCY2NmG5rB342zJTPno
 3TbTAnlqohxHcI7tKTZLG9ee2ifO5L6wFTT/MoSIBvQtxeYjKxhEKUbXryYvHu+v6ROJ
 5HnDjUmGLWvZD1Mio21cdSmxjJ3I2Tyr+4HVXTdlQy81lGAI1J2l0fDBD159A0M4LAMr
 3Ik/otaT9xleQ2pcs/OScnCyDFM38306hzPrUGtzDTN8u4kXNnKijpnY1P2ISMp22VFI
 kTC8yQu5khR4Px63zOCSjsttmR59/IGBSlxkXcCu9wR+IMjfR3wX+9k6rkElQmAOmh7O
 NsUA==
X-Gm-Message-State: AOJu0Yy7600U4Yah15WrqRdDV8qePTD1rTFjl5H/VLNG1Eg7kmnbrrgA
 vctxlnUqfOtNIVG4Rt3IYwgi2FuAV49ZoX7RgFeQmdgC7pcazsvBMlTlXmkqTT6ziM82kAWr94k
 DlALlD26ji6LRVmUMkwQCQU9rJYfx91g4SM2uolfm6vVa3ttAJ8/RPQtF
X-Gm-Gg: ATEYQzw3C7f6C5ZWQ2vWAlXIB8t4pHU7Mua2QYx75s0AjOPqsm5YPvJnW0CjLQ8N4TE
 +9hEA9NJJIfnhmQ/au8TDu+ieqpzQ+NwiQaFmTrqCCYSDNJH4kk3LL7PAg3HZR4GJPxYy+tzSMC
 65hY4F3DSFpf/eBVhb0wFM7ow8Tkg+RvPiValeSuJ+V7o5Ua4J8PEg9ZurMC6aPgpREYSsPH+F+
 4fB4rwFE/lRVLcNQjAcuy/07j62w7j72e5EzSUtMKRE3sCcKoIBTFMkPErHjgijvXJ4SrimMYaV
 wNJdAR3bJ6Iy4S9hgwdnxCiloSRfFvducNVm2Q2/vWQw28ea2l9ZYDYr8NaOXQABAxiMtf+xrBf
 3KepFQkBGPltIWJj61OGO0McSV6CtTK/RJqqm7/ZzjBNNNWeyDtSEh3Cg7kYJiiD8XzprG1qyN0
 94jfM=
X-Received: by 2002:a05:6000:4387:b0:439:b744:c601 with SMTP id
 ffacd0b85a97d-43b527c55cfmr6073007f8f.40.1773847943459; 
 Wed, 18 Mar 2026 08:32:23 -0700 (PDT)
X-Received: by 2002:a05:6000:4387:b0:439:b744:c601 with SMTP id
 ffacd0b85a97d-43b527c55cfmr6072937f8f.40.1773847942840; 
 Wed, 18 Mar 2026 08:32:22 -0700 (PDT)
Received: from localhost
 (p200300cfd737d03304b9bf783d26f60b.dip0.t-ipconnect.de.
 [2003:cf:d737:d033:4b9:bf78:3d26:f60b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b518522d7sm7490639f8f.13.2026.03.18.08.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 08:32:21 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-11.0 3/3] io-uring: Resubmit tails of short writes
Date: Wed, 18 Mar 2026 16:32:05 +0100
Message-ID: <20260318153206.171494-4-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318153206.171494-1-hreitz@redhat.com>
References: <20260318153206.171494-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/io_uring.c   | 83 ++++++++++++++++++++++++++--------------------
 block/trace-events |  2 +-
 2 files changed, 48 insertions(+), 37 deletions(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index cb131d3b8b..61b54647ae 100644
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
@@ -44,6 +44,10 @@ static void luring_prep_sqe(struct io_uring_sqe *sqe, void *opaque)
     int fd = req->fd;
     BdrvRequestFlags flags = req->flags;
 
+    if (req->resubmit_qiov.iov != NULL) {
+        qiov = &req->resubmit_qiov;
+    }
+
     switch (req->type) {
     case QEMU_AIO_WRITE:
     {
@@ -51,7 +55,8 @@ static void luring_prep_sqe(struct io_uring_sqe *sqe, void *opaque)
         if (luring_flags != 0 || qiov->niov > 1) {
 #ifdef HAVE_IO_URING_PREP_WRITEV2
             io_uring_prep_writev2(sqe, fd, qiov->iov,
-                                  qiov->niov, offset, luring_flags);
+                                  qiov->niov, offset + req->total_done,
+                                  luring_flags);
 #else
             /*
              * FUA should only be enabled with HAVE_IO_URING_PREP_WRITEV2, see
@@ -59,12 +64,14 @@ static void luring_prep_sqe(struct io_uring_sqe *sqe, void *opaque)
              */
             assert(luring_flags == 0);
 
-            io_uring_prep_writev(sqe, fd, qiov->iov, qiov->niov, offset);
+            io_uring_prep_writev(sqe, fd, qiov->iov, qiov->niov,
+                                 offset + req->total_done);
 #endif
         } else {
             /* The man page says non-vectored is faster than vectored */
             struct iovec *iov = qiov->iov;
-            io_uring_prep_write(sqe, fd, iov->iov_base, iov->iov_len, offset);
+            io_uring_prep_write(sqe, fd, iov->iov_base, iov->iov_len,
+                                offset + req->total_done);
         }
         break;
     }
@@ -73,17 +80,14 @@ static void luring_prep_sqe(struct io_uring_sqe *sqe, void *opaque)
         break;
     case QEMU_AIO_READ:
     {
-        if (req->resubmit_qiov.iov != NULL) {
-            qiov = &req->resubmit_qiov;
-        }
         if (qiov->niov > 1) {
             io_uring_prep_readv(sqe, fd, qiov->iov, qiov->niov,
-                                offset + req->total_read);
+                                offset + req->total_done);
         } else {
             /* The man page says non-vectored is faster than vectored */
             struct iovec *iov = qiov->iov;
             io_uring_prep_read(sqe, fd, iov->iov_base, iov->iov_len,
-                               offset + req->total_read);
+                               offset + req->total_done);
         }
         break;
     }
@@ -98,21 +102,26 @@ static void luring_prep_sqe(struct io_uring_sqe *sqe, void *opaque)
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
@@ -121,7 +130,7 @@ static void luring_resubmit_short_read(LuringRequest *req, int nread)
     } else {
         qemu_iovec_reset(resubmit_qiov);
     }
-    qemu_iovec_concat(resubmit_qiov, req->qiov, req->total_read, remaining);
+    qemu_iovec_concat(resubmit_qiov, req->qiov, req->total_done, remaining);
 
     aio_add_sqe(luring_prep_sqe, req, &req->cqe_handler);
 }
@@ -153,26 +162,28 @@ static void luring_cqe_handler(CqeHandler *cqe_handler)
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
 
diff --git a/block/trace-events b/block/trace-events
index d170fc96f1..950c82d4b8 100644
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


