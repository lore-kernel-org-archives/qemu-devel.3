Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1E3103E198
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 15:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ssv-0002Z2-Ll; Wed, 18 Mar 2026 11:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2ssn-0002WH-Eb
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 11:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2ssj-0000OM-EQ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 11:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773847944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uAiGkojcHQ/1SSiJjKjsQUYUlQYXvjhlE4iBA6dpRbk=;
 b=fUT0Fs+NCLZDP1RUMnyzrPZMrtb0VxZCjcENdBL5TTX66WlyPQywkLcHKbhFDdjWd6ofUO
 4kS4JVfk4gfYBbqov5L/9oYv6mGVEyQyI0j6Qemsl6MqYzSHc7Q67Mm3PEJh8jDidUJ0W9
 uYdXhoqtAVRK/B74pKQxtZykOR2qRhg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-T2ZuqBELNHOOk7bbtN06QA-1; Wed, 18 Mar 2026 11:32:22 -0400
X-MC-Unique: T2ZuqBELNHOOk7bbtN06QA-1
X-Mimecast-MFC-AGG-ID: T2ZuqBELNHOOk7bbtN06QA_1773847941
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4839fc4cef6so12317965e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 08:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773847941; x=1774452741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uAiGkojcHQ/1SSiJjKjsQUYUlQYXvjhlE4iBA6dpRbk=;
 b=kXmW3niei62ykpPW9pmcjIRdDsMd4l8uqOFFGKjnEVFoSecifcRNXHxFC116ngJeeM
 qWHaMDgxyPOwSW92V91Xo+xo+vVO/JOor42QvU5keJ8OOpPWseYpV8kRzwpdeQA35Zpn
 LB54oxqrxyKQB3p4duD42kRAhSN2KSa3l+Qs1qMpFgTvey/Dd9e5CtuLtAvx9ewQhmId
 P1hJyHi3k9hjjnYDZmtwVtwWQgMyKQSz1Y6chKQL5gPS5mp+Ix/MiMdZusNEkcRugiI/
 1yK/ldAQhOBjrhWyV3EOvOBW4VbbsnqnSrw7vEYmD9c4QUqtBIzp+qmAwOmyxL0QcwJU
 ZqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773847941; x=1774452741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uAiGkojcHQ/1SSiJjKjsQUYUlQYXvjhlE4iBA6dpRbk=;
 b=npOp5HBIwhClupTbNq4T4szpbM1ApO7t5GGdzK3dlUzGDiDw2jtr19GQT/jV5iH805
 cJQWY9jFdmpoTjaebbk7SEuiHopS7Ij599vfNxAVCTx+nGp379qVamWslFp5PzZPSIWS
 QzudORzeUBQVWYx3VViNuDl/P1Yr0ZI7C2ZYkvbHmTyb3H8mHzHv03pfAIZpTcM7Qk1S
 RcLyXzyVFK7qVh/9u5uqjFeQnyguGdIaqdrBGWaTaftma6ZiHTc01bN10OOO05wPQtsd
 zbygCx4PQRfChz1EzGyGDofeyjfRbVH6+v46tqhTHRTz/avUbpwFd7o9uJZ0EA3kxxxn
 hPEw==
X-Gm-Message-State: AOJu0YyOncJWdDFsM8il98vAQRvQfgcjzwvpoFftqy83qgrt2e0C5XJE
 hNkSXMQX8FJ5PZGBc34X3m6trY4pJWlt5gN6f3/AHC2gzjNxNlabVQsveqW210fMqruPigasE07
 4O/enc9UzCgdj4gzX2x2GP4XfNYlKcGPq6csxiO7f7lG1zvgR0QeId5JU
X-Gm-Gg: ATEYQzzVYN05rpAy9zuNZBIk8psNr7Dwlt5Jaw2pSIYrn+nE62OWb+l8UcOub1sEcfh
 e/0jrBiaFXMF+yLbczxzzwFzJp6i6I1SYYhG1MynLM4TShftZduns8VyAqLW+KH4Ug6Lg/lU5kG
 i4sMg5Xy3oJr0qG+ZDgpECclRfH/PRM4R3XuzeGo/VCT56kq1FJzg0p05s4LZ42FoIhp9Yc4YIM
 1Qx9N3do1z9uwlM/FtGdiZ5OGJxU5MTLMCjU8t0ZMCuoazt6bKT+IAj4zs20CYK7k7Zu3V+hZqk
 /w/rT4bq3ABIk880HPPos1OwI2WtzbQCMAwXhmNhVA3/0/oWxKkY4bJtxe3Y6RHyP1IeATVeE3x
 xjjEc7bA9PYLbLL5JhCCLyy+zz4w/oVwtkWHPLy/Uq+hP3HAdOPLJEbJOvPYr4kijfJTTv+h7N1
 em+ws=
X-Received: by 2002:a05:600c:848d:b0:485:3989:b3e4 with SMTP id
 5b1f17b1804b1-486f8b219e0mr519305e9.6.1773847941238; 
 Wed, 18 Mar 2026 08:32:21 -0700 (PDT)
X-Received: by 2002:a05:600c:848d:b0:485:3989:b3e4 with SMTP id
 5b1f17b1804b1-486f8b219e0mr518775e9.6.1773847940636; 
 Wed, 18 Mar 2026 08:32:20 -0700 (PDT)
Received: from localhost
 (p200300cfd737d03304b9bf783d26f60b.dip0.t-ipconnect.de.
 [2003:cf:d737:d033:4b9:bf78:3d26:f60b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856eaffbbdsm147563775e9.15.2026.03.18.08.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 08:32:19 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-11.0 2/3] linux-aio: Resubmit tails of short reads/writes
Date: Wed, 18 Mar 2026 16:32:04 +0100
Message-ID: <20260318153206.171494-3-hreitz@redhat.com>
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

Short reads/writes can happen.  One way to reproduce them is via our
FUSE export, with the following diff applied (%s/escaped // to apply --
if you put plain diffs in commit messages, git-am will apply them, and I
would rather avoid breaking FUSE accidentally via this patch):

escaped diff --git a/block/export/fuse.c b/block/export/fuse.c
escaped index a2a478d293..67dc50a412 100644
escaped --- a/block/export/fuse.c
escaped +++ b/block/export/fuse.c
@@ -828,7 +828,7 @@ static ssize_t coroutine_fn GRAPH_RDLOCK
 fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
              const struct fuse_init_in_compat *in)
 {
-    const uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
+    const uint32_t supported_flags = FUSE_ASYNC_READ;

     if (in->major != 7) {
         error_report("FUSE major version mismatch: We have 7, but kernel has %"
@@ -1060,6 +1060,8 @@ fuse_co_read(FuseExport *exp, void **bufptr, uint64_t offset, uint32_t size)
     void *buf;
     int ret;

+    size = MIN(size, 4096);
+
     /* Limited by max_read, should not happen */
     if (size > FUSE_MAX_READ_BYTES) {
         return -EINVAL;
@@ -1110,6 +1112,8 @@ fuse_co_write(FuseExport *exp, struct fuse_write_out *out,
     int64_t blk_len;
     int ret;

+    size = MIN(size, 4096);
+
     QEMU_BUILD_BUG_ON(FUSE_MAX_WRITE_BYTES > BDRV_REQUEST_MAX_BYTES);
     /* Limited by max_write, should not happen */
     if (size > FUSE_MAX_WRITE_BYTES) {

Then:
$ ./qemu-img create -f raw test.raw 8k
Formatting 'test.raw', fmt=raw size=8192
$ ./qemu-io -f raw -c 'write -P 42 0 8k' test.raw
wrote 8192/8192 bytes at offset 0
8 KiB, 1 ops; 00.00 sec (64.804 MiB/sec and 8294.9003 ops/sec)
$ hexdump -C test.raw
00000000  2a 2a 2a 2a 2a 2a 2a 2a  2a 2a 2a 2a 2a 2a 2a 2a  |****************|
*
00002000

With aio=threads, short I/O works:
$ storage-daemon/qemu-storage-daemon \
    --blockdev file,node-name=test,filename=test.raw \
    --export fuse,id=exp,node-name=test,mountpoint=test.raw,writable=true

Other shell:
$ ./qemu-io --image-opts -c 'read -P 42 0 8k' \
    driver=file,filename=test.raw,cache.direct=on,aio=threads
read 8192/8192 bytes at offset 0
8 KiB, 1 ops; 00.00 sec (36.563 MiB/sec and 4680.0923 ops/sec)
$ ./qemu-io --image-opts -c 'write -P 23 0 8k' \
    driver=file,filename=test.raw,cache.direct=on,aio=threads
wrote 8192/8192 bytes at offset 0
8 KiB, 1 ops; 00.00 sec (35.995 MiB/sec and 4607.2970 ops/sec)
$ hexdump -C test.raw
00000000  17 17 17 17 17 17 17 17  17 17 17 17 17 17 17 17  |................|
*
00002000

But with aio=native, it does not:
$ ./qemu-io --image-opts -c 'read -P 23 0 8k' \
    driver=file,filename=test.raw,cache.direct=on,aio=native
Pattern verification failed at offset 0, 8192 bytes
read 8192/8192 bytes at offset 0
8 KiB, 1 ops; 00.00 sec (86.155 MiB/sec and 11027.7900 ops/sec)
$ ./qemu-io --image-opts -c 'write -P 42 0 8k' \
    driver=file,filename=test.raw,cache.direct=on,aio=native
write failed: No space left on device
$ hexdump -C test.raw
00000000  2a 2a 2a 2a 2a 2a 2a 2a  2a 2a 2a 2a 2a 2a 2a 2a  |****************|
*
00001000  17 17 17 17 17 17 17 17  17 17 17 17 17 17 17 17  |................|
*
00002000

This patch fixes that.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/linux-aio.c | 61 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/block/linux-aio.c b/block/linux-aio.c
index 1f25339dc9..01621d4794 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -46,6 +46,10 @@ struct qemu_laiocb {
     size_t nbytes;
     QEMUIOVector *qiov;
 
+    /* For handling short reads/writes */
+    size_t total_done;
+    QEMUIOVector resubmit_qiov;
+
     int type;
     BdrvRequestFlags flags;
     uint64_t dev_max_batch;
@@ -73,28 +77,61 @@ struct LinuxAioState {
 };
 
 static void ioq_submit(LinuxAioState *s);
+static int laio_do_submit(struct qemu_laiocb *laiocb);
 
 static inline ssize_t io_event_ret(struct io_event *ev)
 {
     return (ssize_t)(((uint64_t)ev->res2 << 32) | ev->res);
 }
 
+/**
+ * Retry tail of short requests.
+ */
+static int laio_resubmit_short_io(struct qemu_laiocb *laiocb, size_t done)
+{
+    QEMUIOVector *resubmit_qiov = &laiocb->resubmit_qiov;
+
+    laiocb->total_done += done;
+
+    if (!resubmit_qiov->iov) {
+        qemu_iovec_init(resubmit_qiov, laiocb->qiov->niov);
+    } else {
+        qemu_iovec_reset(resubmit_qiov);
+    }
+    qemu_iovec_concat(resubmit_qiov, laiocb->qiov,
+                      laiocb->total_done, laiocb->nbytes - laiocb->total_done);
+
+    return laio_do_submit(laiocb);
+}
+
 /*
  * Completes an AIO request.
  */
 static void qemu_laio_process_completion(struct qemu_laiocb *laiocb)
 {
-    int ret;
+    ssize_t ret;
 
     ret = laiocb->ret;
     if (ret != -ECANCELED) {
-        if (ret == laiocb->nbytes) {
+        if (ret == laiocb->nbytes - laiocb->total_done) {
             ret = 0;
+        } else if (ret > 0 && (laiocb->type == QEMU_AIO_READ ||
+                               laiocb->type == QEMU_AIO_WRITE)) {
+            ret = laio_resubmit_short_io(laiocb, ret);
+            if (!ret) {
+                return;
+            }
         } else if (ret >= 0) {
-            /* Short reads mean EOF, pad with zeros. */
+            /*
+             * For normal reads and writes, we only get here if ret == 0, which
+             * means EOF for reads and ENOSPC for writes.
+             * For zone-append, we get here with any ret >= 0, which we just
+             * treat as ENOSPC, too (safer than resubmitting, probably, but not
+             * 100 % clear).
+             */
             if (laiocb->type == QEMU_AIO_READ) {
-                qemu_iovec_memset(laiocb->qiov, ret, 0,
-                    laiocb->qiov->size - ret);
+                qemu_iovec_memset(laiocb->qiov, laiocb->total_done, 0,
+                                  laiocb->qiov->size - laiocb->total_done);
             } else {
                 ret = -ENOSPC;
             }
@@ -102,6 +139,7 @@ static void qemu_laio_process_completion(struct qemu_laiocb *laiocb)
     }
 
     laiocb->ret = ret;
+    qemu_iovec_destroy(&laiocb->resubmit_qiov);
 
     /*
      * If the coroutine is already entered it must be in ioq_submit() and
@@ -380,23 +418,30 @@ static int laio_do_submit(struct qemu_laiocb *laiocb)
     int fd = laiocb->fd;
     off_t offset = laiocb->offset;
 
+    if (laiocb->resubmit_qiov.iov) {
+        qiov = &laiocb->resubmit_qiov;
+    }
+
     switch (laiocb->type) {
     case QEMU_AIO_WRITE:
 #ifdef HAVE_IO_PREP_PWRITEV2
     {
         int laio_flags = (laiocb->flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
-        io_prep_pwritev2(iocbs, fd, qiov->iov, qiov->niov, offset, laio_flags);
+        io_prep_pwritev2(iocbs, fd, qiov->iov, qiov->niov,
+                         offset + laiocb->total_done, laio_flags);
     }
 #else
         assert(laiocb->flags == 0);
-        io_prep_pwritev(iocbs, fd, qiov->iov, qiov->niov, offset);
+        io_prep_pwritev(iocbs, fd, qiov->iov, qiov->niov,
+                        offset + laiocb->total_done);
 #endif
         break;
     case QEMU_AIO_ZONE_APPEND:
         io_prep_pwritev(iocbs, fd, qiov->iov, qiov->niov, offset);
         break;
     case QEMU_AIO_READ:
-        io_prep_preadv(iocbs, fd, qiov->iov, qiov->niov, offset);
+        io_prep_preadv(iocbs, fd, qiov->iov, qiov->niov,
+                       offset + laiocb->total_done);
         break;
     case QEMU_AIO_FLUSH:
         io_prep_fdsync(iocbs, fd);
-- 
2.53.0


