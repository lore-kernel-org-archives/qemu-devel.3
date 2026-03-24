Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDAEF532F5
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 08:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4xMg-0004ab-9B; Tue, 24 Mar 2026 04:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w4xMe-0004ZZ-De
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 04:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w4xMb-0005Ku-P3
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 04:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774341829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JKWtmzsVyC/vUaJKxKrxcKgLxnja+qeqEwklaNrjqAg=;
 b=el6/U5IVTP5uMEMRHHh79VnZxknQFNlZ0sDX3w2+HwGNCSF0yer4ejz+BSSly7bYsh1xYs
 HxP9WqqR824/bVnX7CbQm+yOBy0dDRbnVR2dwB4tqg8ej5rsuGgeuOTlZMycovE5kIxbW6
 GtndCSu/Pg4SsB4ic2PbWS1kMdakabI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-uYfwWC9PPiO3lhH-Kd83SA-1; Tue, 24 Mar 2026 04:43:47 -0400
X-MC-Unique: uYfwWC9PPiO3lhH-Kd83SA-1
X-Mimecast-MFC-AGG-ID: uYfwWC9PPiO3lhH-Kd83SA_1774341826
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43b46b2b161so4062855f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 01:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774341826; x=1774946626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JKWtmzsVyC/vUaJKxKrxcKgLxnja+qeqEwklaNrjqAg=;
 b=IWLnuXOa8Jh+EP2/glL1fbEgqFU6ZFYyxXXIYDyWcqcWpTEiySQggwzd9IP20IHTaX
 euWPCOF3XYANmFsye22vHHEg0KW7ZqfRkga+jc6Gryk8ghjFgAWOZheVrzv/12Six0L0
 D/i+eUCUbImKfNH2BCsQfT/ixxQ27uAggPov99JodsIFr1WViJsnudOIpRyjD+uTLBfj
 b1DQNLlXIOdT0/G+dzyh31AbAUTuaxhYlLlWcRNWoVxQAM6zdXc6FV40yWv3LLDYSE6G
 On2O+7ZmfDzizWt54/iR4QHlPOu9LXpVZ8LdOZm5RezykBFHRMGfXAkCSWkBGohwHoYM
 gpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774341826; x=1774946626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JKWtmzsVyC/vUaJKxKrxcKgLxnja+qeqEwklaNrjqAg=;
 b=GVVgyxLOpHMw88dcqsfzwZNZd4t83PLS4Ec7d0EWXIyOPeD+Nj31WlgBTnp9Xxgh3m
 u8JAYfxpPgh3n139RqHsciIKC8rWwAE/TIYEXoApeNrdJx/xpfVkOobITFk/28ox7WYJ
 ZQE5XlIN9PiHYPTAgvJtTDZk/iIdJl9ZPw9HzL+b/rRi5gZKUJSGlB4rbvdqr2NTlFBr
 ApKwE0zz3j/6bBeJsgDfw6AtK9SF11LSIFfTzd3Ye5XDlbDY+QSWcplOoGWYMm77JQLR
 q1DbsX6PpSwl4uKUxiz03sEFvdz85Zqz1e00M7FOyxsXO5naFy/g7qvQAac8OhAnByZb
 AE3g==
X-Gm-Message-State: AOJu0YxTBhLWuxTreT0QiM4QXUokJoUD6BPnJSUoNP5DFDimagOmfPG3
 dWatqLle0nCOwHJUPNccm040hSzBs3xj82ILjJf/yl+QaBS5xxFgPRPWUuU1RgkrQUJqFbk6pVN
 yMx+QHl9cT8YBOfKSuYSFqou/UCTjUWtvQAwl4nJD2wOTqvrI87MyljT0
X-Gm-Gg: ATEYQzzqOGz25ZrRC6dFH7Uxz9qxTxplpLJ9qrVC/UQDUrQd3JYmgjrTjsA184X4GvQ
 fek9UBSx00uVhjaMBsupzwp6ZxtjYlFIfTbXSdq1oSDUJIOfjLc6vbmwfqJZvJgHJ3BIqVBK4Ci
 i/yV0ypyr7WeyI0A7eULTclxa5s30SDwVDEEKK/+8ijtEJeGQYrL2INTKHzHRmWyjdIOqy7Xhxc
 twFHj+9xaAxIklT2WRF4qG7JxVN5HUg2YbSbnRqbe0RGj/Y5vPOewSlTc9ZLj/VckhBtdDJ7MS4
 HpTnCboLCq3Kw4aYKzQuJF1N5GlMjZEEQ9/D5TBhoVSnR+KL+tcvNK49bxeOfbkSRmGRTiqSaGY
 ciluoRVK2yVL726l2ZS+ZynMLCGHKYgBM7/qXUyPP/qdRmPNHV/znxj/uQKFkjVVyBetT78a4Yt
 yEV3eM
X-Received: by 2002:a05:6000:601:b0:439:c5cf:fc73 with SMTP id
 ffacd0b85a97d-43b6423b842mr23735085f8f.12.1774341826145; 
 Tue, 24 Mar 2026 01:43:46 -0700 (PDT)
X-Received: by 2002:a05:6000:601:b0:439:c5cf:fc73 with SMTP id
 ffacd0b85a97d-43b6423b842mr23735050f8f.12.1774341825684; 
 Tue, 24 Mar 2026 01:43:45 -0700 (PDT)
Received: from localhost
 (p200300cfd737d03cdf99cbc9b4448cfa.dip0.t-ipconnect.de.
 [2003:cf:d737:d03c:df99:cbc9:b444:8cfa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470b243sm36839348f8f.26.2026.03.24.01.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 01:43:44 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-11.0 v2 1/3] linux-aio: Put all parameters into qemu_laiocb
Date: Tue, 24 Mar 2026 09:43:34 +0100
Message-ID: <20260324084338.37453-2-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324084338.37453-1-hreitz@redhat.com>
References: <20260324084338.37453-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Put all request parameters into the qemu_laiocb struct, which will allow
re-submitting the tail of short reads/writes.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/linux-aio.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/block/linux-aio.c b/block/linux-aio.c
index 53c3e9af8a..3843f45eac 100644
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
2.53.0


