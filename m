Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AB2FEC0F7
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 18:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w56vp-0004ne-Ei; Tue, 24 Mar 2026 14:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w56vk-0004kl-NI
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w56vi-0006ga-0p
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 14:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774378601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gQ8AtBpJCcmriLtHU5b0J/GoC8msMoDc+3xdWz4LnAs=;
 b=BsMAW2zxNX6K1PxevMsy3KldhwgZu8RodYm3bpgrLFfEKCVECTvSjqmTf6V4co9ScqZ9J+
 LhgRjhXmhsLKt6jXzK45TyhGV5MOwYdQcSTaSUPsZqleF8PiLStLQYGS07OggG9gyu1Rca
 kLeQtbnKtze87ynGwskvBTmquO8fxo4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-hEldPXqcPW2B0JOxpvPiOw-1; Tue,
 24 Mar 2026 14:56:37 -0400
X-MC-Unique: hEldPXqcPW2B0JOxpvPiOw-1
X-Mimecast-MFC-AGG-ID: hEldPXqcPW2B0JOxpvPiOw_1774378596
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F9CC19560A7; Tue, 24 Mar 2026 18:56:36 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.33.246])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 836A5300019F; Tue, 24 Mar 2026 18:56:35 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 3/4] linux-aio: Resubmit tails of short reads/writes
Date: Tue, 24 Mar 2026 19:56:18 +0100
Message-ID: <20260324185619.296946-4-kwolf@redhat.com>
In-Reply-To: <20260324185619.296946-1-kwolf@redhat.com>
References: <20260324185619.296946-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260324084338.37453-3-hreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/linux-aio.c | 56 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 6 deletions(-)

diff --git a/block/linux-aio.c b/block/linux-aio.c
index 3843f45eac8..0a7424fbb33 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -45,6 +45,10 @@ struct qemu_laiocb {
     size_t nbytes;
     QEMUIOVector *qiov;
 
+    /* For handling short reads/writes */
+    size_t total_done;
+    QEMUIOVector resubmit_qiov;
+
     int fd;
     int type;
     BdrvRequestFlags flags;
@@ -74,28 +78,61 @@ struct LinuxAioState {
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
@@ -103,6 +140,9 @@ static void qemu_laio_process_completion(struct qemu_laiocb *laiocb)
     }
 
     laiocb->ret = ret;
+    if (laiocb->resubmit_qiov.iov) {
+        qemu_iovec_destroy(&laiocb->resubmit_qiov);
+    }
 
     /*
      * If the coroutine is already entered it must be in ioq_submit() and
@@ -379,7 +419,11 @@ static int laio_do_submit(struct qemu_laiocb *laiocb)
     struct iocb *iocbs = &laiocb->iocb;
     QEMUIOVector *qiov = laiocb->qiov;
     int fd = laiocb->fd;
-    off_t offset = laiocb->offset;
+    off_t offset = laiocb->offset + laiocb->total_done;
+
+    if (laiocb->resubmit_qiov.iov) {
+        qiov = &laiocb->resubmit_qiov;
+    }
 
     switch (laiocb->type) {
     case QEMU_AIO_WRITE:
-- 
2.53.0


