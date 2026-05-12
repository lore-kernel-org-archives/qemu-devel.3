Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E45ECD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMu9q-0006aI-ND; Tue, 12 May 2026 16:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu9o-0006QK-LH; Tue, 12 May 2026 16:56:48 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu9m-0003T7-Mo; Tue, 12 May 2026 16:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619274; bh=USCV4JnZ/NSimDWsipGs3+8OvCXM93pU8zel/dbALAM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=idrms0dH7ll4LHC91a1ynLTtOnhmiTN/KpSsrPubKp3gcdTlSSA9uFNn0e9us9ayG
 R7sXK/JEHdSwRgDZO2SuZQQNiwBwaUJ5KZsJSSxB2graI4oP70KSEn0ZBtUHk0PJWv
 SZSieuX5ReQrw1EmvzLMlffCWkF6h0eRTJQ+6aKwcL7om5uJbxnfZTGjbtA5gx4r60
 fSnCc52StoN5BzOVq4psBCHLr3u0BDbK/GS1Ng3cYKXafXIt1eoEcVh2xr+dLaiGSv
 7a4sdp5YsvuG3AdnfswUdu+u+IUVln7Qe5tn+nADLMMOV3tXEgQWTIcoUCkKb+9ZDy
 /NKhXVLbcoNmw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D8B3C1AA2E4;
 Tue, 12 May 2026 23:54:34 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E54083ABC55;
 Tue, 12 May 2026 23:54:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 024/107] linux-aio: Put all parameters into
 qemu_laiocb
Date: Tue, 12 May 2026 23:53:11 +0300
Message-ID: <20260512205437.360850-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Hanna Czenczek <hreitz@redhat.com>

Put all request parameters into the qemu_laiocb struct, which will allow
re-submitting the tail of short reads/writes.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260324084338.37453-2-hreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit cc03b62df47a09c507e199cc043f57bdc941cc67)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/linux-aio.c b/block/linux-aio.c
index 407369f5c9..a315eb746c 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -41,9 +41,15 @@ struct qemu_laiocb {
     LinuxAioState *ctx;
     struct iocb iocb;
     ssize_t ret;
+    off_t offset;
     size_t nbytes;
     QEMUIOVector *qiov;
-    bool is_read;
+
+    int fd;
+    int type;
+    BdrvRequestFlags flags;
+
+    uint64_t dev_max_batch;
     QSIMPLEQ_ENTRY(qemu_laiocb) next;
 };
 
@@ -87,7 +93,7 @@ static void qemu_laio_process_completion(struct qemu_laiocb *laiocb)
             ret = 0;
         } else if (ret >= 0) {
             /* Short reads mean EOF, pad with zeros. */
-            if (laiocb->is_read) {
+            if (laiocb->type == QEMU_AIO_READ) {
                 qemu_iovec_memset(laiocb->qiov, ret, 0,
                     laiocb->qiov->size - ret);
             } else {
@@ -367,23 +373,23 @@ static void laio_deferred_fn(void *opaque)
     }
 }
 
-static int laio_do_submit(int fd, struct qemu_laiocb *laiocb, off_t offset,
-                          int type, BdrvRequestFlags flags,
-                          uint64_t dev_max_batch)
+static int laio_do_submit(struct qemu_laiocb *laiocb)
 {
     LinuxAioState *s = laiocb->ctx;
     struct iocb *iocbs = &laiocb->iocb;
     QEMUIOVector *qiov = laiocb->qiov;
+    int fd = laiocb->fd;
+    off_t offset = laiocb->offset;
 
-    switch (type) {
+    switch (laiocb->type) {
     case QEMU_AIO_WRITE:
 #ifdef HAVE_IO_PREP_PWRITEV2
     {
-        int laio_flags = (flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
+        int laio_flags = (laiocb->flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
         io_prep_pwritev2(iocbs, fd, qiov->iov, qiov->niov, offset, laio_flags);
     }
 #else
-        assert(flags == 0);
+        assert(laiocb->flags == 0);
         io_prep_pwritev(iocbs, fd, qiov->iov, qiov->niov, offset);
 #endif
         break;
@@ -399,7 +405,7 @@ static int laio_do_submit(int fd, struct qemu_laiocb *laiocb, off_t offset,
     /* Currently Linux kernel does not support other operations */
     default:
         fprintf(stderr, "%s: invalid AIO request type 0x%x.\n",
-                        __func__, type);
+                        __func__, laiocb->type);
         return -EIO;
     }
     io_set_eventfd(&laiocb->iocb, event_notifier_get_fd(&s->e));
@@ -407,7 +413,7 @@ static int laio_do_submit(int fd, struct qemu_laiocb *laiocb, off_t offset,
     QSIMPLEQ_INSERT_TAIL(&s->io_q.pending, laiocb, next);
     s->io_q.in_queue++;
     if (!s->io_q.blocked) {
-        if (s->io_q.in_queue >= laio_max_batch(s, dev_max_batch)) {
+        if (s->io_q.in_queue >= laio_max_batch(s, laiocb->dev_max_batch)) {
             ioq_submit(s);
         } else {
             defer_call(laio_deferred_fn, s);
@@ -425,14 +431,18 @@ int coroutine_fn laio_co_submit(int fd, uint64_t offset, QEMUIOVector *qiov,
     AioContext *ctx = qemu_get_current_aio_context();
     struct qemu_laiocb laiocb = {
         .co         = qemu_coroutine_self(),
+        .offset     = offset,
         .nbytes     = qiov ? qiov->size : 0,
         .ctx        = aio_get_linux_aio(ctx),
         .ret        = -EINPROGRESS,
-        .is_read    = (type == QEMU_AIO_READ),
         .qiov       = qiov,
+        .fd         = fd,
+        .type       = type,
+        .flags      = flags,
+        .dev_max_batch = dev_max_batch,
     };
 
-    ret = laio_do_submit(fd, &laiocb, offset, type, flags, dev_max_batch);
+    ret = laio_do_submit(&laiocb);
     if (ret < 0) {
         return ret;
     }
-- 
2.47.3


