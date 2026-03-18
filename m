Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5AD103E199
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 15:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ssp-0002Wg-8U; Wed, 18 Mar 2026 11:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2ssl-0002Vu-Fa
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 11:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w2ssi-0000OD-LE
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 11:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773847943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nYV5RP+iiMyqxFM+ztI27k0197hYqdiP0TOvg+Wefz4=;
 b=KNDuOe/4NVYY8s3pE0kbwvnUMuCf8yFe8cg7iQ617t90qr0lkMs6OPg7PvV0ysDTTNd+8+
 gT1W1f48M9Xg3TK0N13jVBB+hxRQgsIncgxNxwdQwi8Dh7qdd5En8YVI5QdX+P/Ql7IbOw
 asSWM+WFSbtWaGY2C87qM7VCdw+H2R0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-JLsDT6acOIWMhH-e5ps_Kw-1; Wed, 18 Mar 2026 11:32:20 -0400
X-MC-Unique: JLsDT6acOIWMhH-e5ps_Kw-1
X-Mimecast-MFC-AGG-ID: JLsDT6acOIWMhH-e5ps_Kw_1773847939
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439a85832c0so5655530f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 08:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773847939; x=1774452739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nYV5RP+iiMyqxFM+ztI27k0197hYqdiP0TOvg+Wefz4=;
 b=uNMgQwapaxClfag2QB+Zb1vmVVHT+xTeOTbas3odn8mdzgbVlv/aQzeNnrub4FgNec
 W2L08TZn1j2+3pUmxJNoHTzuhoQC5R0inkGsAQ21q2pMUQb70X/3JmgnANYALh+3HPPy
 4FV690UxPLkGpFszL5Sf1MDiorcVXQcpQ7cXaVhkWCWO9n+34bgQ3eJXGaL7msiJuxEo
 C+1e5V9PZl9v5W7K6+tq4/q2+og/m3RvqKQTbEB2fTZTON/+Ap13C9iqsU2kEqg71mPC
 DMRy8xNuBe9bvMxJj2WhCfSBs6uSkueJio0N3fUnwtwKYOVBDxOivYhrpzw7WKRQRteW
 B+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773847939; x=1774452739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nYV5RP+iiMyqxFM+ztI27k0197hYqdiP0TOvg+Wefz4=;
 b=ele7ZGCZKJPAc8pzh+hVleB1pfPk3l0NCCVqA91df+Sz/m+y8CtyGlqx886PeTl3JS
 ADXRd4xq8DHrSQsCsleTYEJThZ7I5t4klM4EwmO//hXOnxsgDmoEeE2gXlkphEHo3g9J
 Hhq+d6WIKmEejr+ATApHfYbZWR5BtTREqwp1O6B0rJ5vgAzO7Y8axpbBJwoA1vS3dKGi
 XC+Y2+jx9He9be3mLiPNCuLrlyY4JwWcheQt5KOJ6vwx3hTRAg3kZOGa2PhWoZghWy7f
 vIeKy/BCNFszrbTG+rvjkjMQGWkvumP+MaiEsLYFY76l5wVvT8KpAf1LUB3S5YJXrnjf
 1JqQ==
X-Gm-Message-State: AOJu0YynNQQwM4LKBngMyVuvMY3wW2Tu7t0Ca9GgkZLv7gNDTeq82zKM
 9G+xI9OPhEEGAmyQKXB6Bhy6NfIjRGUEYjuqShmdE75JrFP7OUY045cNDoHmHda1oYVfKJXh6fW
 vK9RwA/Nr7LzW1zj4GATKZzD60bV/FvqT1Zv+keNIr0pPkvVmlMPsS5aA
X-Gm-Gg: ATEYQzxEKnZ6oyb52FhRMypyZacc5bwHkSMt41wLTcmIjlx1Z1r07rc1Yi9s4tM/f6O
 NLtzqWxWce04L72Q4dO+emSxHT1QWQivI6IEZCI3bD6dWyCyFWEInznLyoSk0GisT/CAeh8aGr4
 /NFtpQ/kZsgUeafnbZd68a2DQI22kvm0Ak6FPUitbhX0s/t8FSfcDZVy+Qrr6UuUt+oTG4A5tUb
 NZmkECUiPpLw+2jKy8stYzWU0E4tSW+pQuI1kH/mzdZJmlkkg1YzPhTW/lE7krwvAjLfSNoJhfw
 UGiGYUBd7nuoFfQuZnlaHkJGo2N8e0KC6P9x7NuUOXsNVfxHJ8MHMbxO+sz0C431rTq8+loa5S1
 YvLo4ZS2Bf1mxHIUvzz5Oh5SvJHVsyDgL2MNNNja3xU4uMFC8/ThzdyptvgujrlYJyYQ6voDQ24
 ghkTQ=
X-Received: by 2002:a05:6000:4008:b0:43b:42d3:31ac with SMTP id
 ffacd0b85a97d-43b5264dc3bmr6370570f8f.0.1773847938957; 
 Wed, 18 Mar 2026 08:32:18 -0700 (PDT)
X-Received: by 2002:a05:6000:4008:b0:43b:42d3:31ac with SMTP id
 ffacd0b85a97d-43b5264dc3bmr6370498f8f.0.1773847938398; 
 Wed, 18 Mar 2026 08:32:18 -0700 (PDT)
Received: from localhost
 (p200300cfd737d03304b9bf783d26f60b.dip0.t-ipconnect.de.
 [2003:cf:d737:d033:4b9:bf78:3d26:f60b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51852ab3sm8954215f8f.12.2026.03.18.08.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 08:32:17 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-11.0 1/3] linux-aio: Put all parameters into qemu_laiocb
Date: Wed, 18 Mar 2026 16:32:03 +0100
Message-ID: <20260318153206.171494-2-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318153206.171494-1-hreitz@redhat.com>
References: <20260318153206.171494-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Put all request parameters into the qemu_laiocb struct, which will allow
re-submitting the tail of short reads/writes.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/linux-aio.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/block/linux-aio.c b/block/linux-aio.c
index 53c3e9af8a..1f25339dc9 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -40,10 +40,15 @@ struct qemu_laiocb {
     Coroutine *co;
     LinuxAioState *ctx;
     struct iocb iocb;
+    int fd;
     ssize_t ret;
+    off_t offset;
     size_t nbytes;
     QEMUIOVector *qiov;
-    bool is_read;
+
+    int type;
+    BdrvRequestFlags flags;
+    uint64_t dev_max_batch;
     QSIMPLEQ_ENTRY(qemu_laiocb) next;
 };
 
@@ -87,7 +92,7 @@ static void qemu_laio_process_completion(struct qemu_laiocb *laiocb)
             ret = 0;
         } else if (ret >= 0) {
             /* Short reads mean EOF, pad with zeros. */
-            if (laiocb->is_read) {
+            if (laiocb->type == QEMU_AIO_READ) {
                 qemu_iovec_memset(laiocb->qiov, ret, 0,
                     laiocb->qiov->size - ret);
             } else {
@@ -367,23 +372,23 @@ static void laio_deferred_fn(void *opaque)
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
@@ -399,7 +404,7 @@ static int laio_do_submit(int fd, struct qemu_laiocb *laiocb, off_t offset,
     /* Currently Linux kernel does not support other operations */
     default:
         fprintf(stderr, "%s: invalid AIO request type 0x%x.\n",
-                        __func__, type);
+                        __func__, laiocb->type);
         return -EIO;
     }
     io_set_eventfd(&laiocb->iocb, event_notifier_get_fd(&s->e));
@@ -407,7 +412,7 @@ static int laio_do_submit(int fd, struct qemu_laiocb *laiocb, off_t offset,
     QSIMPLEQ_INSERT_TAIL(&s->io_q.pending, laiocb, next);
     s->io_q.in_queue++;
     if (!s->io_q.blocked) {
-        if (s->io_q.in_queue >= laio_max_batch(s, dev_max_batch)) {
+        if (s->io_q.in_queue >= laio_max_batch(s, laiocb->dev_max_batch)) {
             ioq_submit(s);
         } else {
             defer_call(laio_deferred_fn, s);
@@ -425,14 +430,18 @@ int coroutine_fn laio_co_submit(int fd, uint64_t offset, QEMUIOVector *qiov,
     AioContext *ctx = qemu_get_current_aio_context();
     struct qemu_laiocb laiocb = {
         .co         = qemu_coroutine_self(),
-        .nbytes     = qiov ? qiov->size : 0,
+        .fd         = fd,
+        .offset     = offset,
+        .nbytes     = (qiov ? qiov->size : 0),
         .ctx        = aio_get_linux_aio(ctx),
         .ret        = -EINPROGRESS,
-        .is_read    = (type == QEMU_AIO_READ),
         .qiov       = qiov,
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


