Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C63AC531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnHqx-0001QK-1O; Fri, 24 Jul 2026 11:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wnHqh-0001Oo-Kk
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wnHqe-0001fl-Hl
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784907003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLlRZ9KI2JRHj5Nid/esGkgvo4jawCd5AOmkeY0Wn1k=;
 b=MFhtrCkCnxXOfA2+fDx0jiD820trMPLxGJYyDIMmdipo1KEBXBwVoNLx3QjpYh4AMEtakZ
 FWHpKy/jIiAG52cfeHMlxHMe0WZ3Igy+8paGfzqVq+njtnBp1poNpXOQgamFL3ibghO3BT
 Ft0QTYdXiGhIZZX4sySt124wetul5zM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-CGKwaGtTPVKb-B_2SkhmsQ-1; Fri, 24 Jul 2026 11:23:28 -0400
X-MC-Unique: CGKwaGtTPVKb-B_2SkhmsQ-1
X-Mimecast-MFC-AGG-ID: CGKwaGtTPVKb-B_2SkhmsQ_1784906607
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-472c330e555so393144f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 08:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784906607; x=1785511407; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rLlRZ9KI2JRHj5Nid/esGkgvo4jawCd5AOmkeY0Wn1k=;
 b=jFccRBVkrI7x2xd9nA5Dsfd/BBy3m1PyV4oAwsVwRI6l1EdLKVSFk/A0xxQ8TF71xU
 JhBS4pWcGyPVIG57yrR/Kus+ZEh1N8f3ztYCRr7d1LdOVnHRaneuXx4sTtvfI5JeVHH5
 gqRCPBkEVU4jyBJCps6TH6nUBNCyWjShcQFRwnsV1jPSyTsHqC0znwKcTt8IJvUujSy0
 Hul24qSmmLTDvMXn1DN+pmYjgU/qM/ueblVYyM5xpSCX9lI6uYitK1+oRU5w0ezo81Bg
 iIOnCa0pNXUu+OfCwhNt/xC+VPPi/KQRT5OJfAcN5vX3WFb8rmtL83SuTBgA9Tmj/gpP
 9okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784906607; x=1785511407;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rLlRZ9KI2JRHj5Nid/esGkgvo4jawCd5AOmkeY0Wn1k=;
 b=Elzhx+2HRVoPW5LJ2dIJAjg6TKvU/b/ClFFqkODfBur/MFNZBuBIjL0CLaALbfIvGU
 6uIRnXJbL44FYayRJihqUf/qfRAj4xnRwP+bVgWMroz+5SbZVKLEYcKBNXTggI5eFN/r
 nWjC6RQdQMpKPjJ5VQntG02WlhRi7yQx8lvOnRxlAR8cL172pEt0rJAZ3C3CJCgSJCbD
 PCQBU/ZCZaARcijuH/T2dzspY2S1hlNXF8bAw2nZggMij/hm0oin3KPIMO6kmaVzax2w
 GkkOQSP4UTrw1KAInCb0oxWRpNe2p9E2GhUfWgqpFgomQaCBJKxxhkPzJ4tSCy2HZMOY
 wD5A==
X-Gm-Message-State: AOJu0Yxa9vV7q+VbL3x4ZcOvrMuFNh5U07GjZuJRJRoEEybQQyfSdd/J
 9suU7XaBcKo/4TkOE2CvRpfxMaM0IIVohGcgWEO3TudZdu0f2QRiGSyfKDE+OR5h+4klYTi6X3O
 WpyYu/hVxbx5jODEZzqqJzYu4reSGPTs/Fk1U2Rj7QA05b7bxrF+eXmIk
X-Gm-Gg: AR+sD10FkiWaQAArhILg0HumGKVhulb68Lf8ovk2y32SmolNUk9aURQFsRCHcRtsnJ4
 CMEQoMgQvjEURIJmeKyNxFMUvn3WfJfOSE6dEGPnIFO3eBsXZFhT3K58XI97x2y3aEHHxAFHrmj
 VyzXyN/OI9FxP8x+wiUZ2uecasA2zn+EVeKYhCMj3lOCxKEWckIER+MqehYld+phNi8YJCkZoCP
 DZ7fBynSsz7ArV0iBMXy01JbqrIHGDffkKnRT8pcW4e4jVmk72VDuV7InOq9jpEaVCKLi7EuWa5
 uqoQiVWzlGZqoJvkoZJ2hAa9Vkw/dqTdIBDy+0SCz0G6fLsb1hWbbva5ayshj73IvCQiGu326l0
 8JBPf87h/NOig/FrVz58+eWfH7qPu7MWvqSjaegqjXyyQbe06ctBquh0pjSU=
X-Received: by 2002:a05:6000:455c:b0:47f:91e3:3cc9 with SMTP id
 ffacd0b85a97d-47f91e33dc2mr7348207f8f.39.1784906606847; 
 Fri, 24 Jul 2026 08:23:26 -0700 (PDT)
X-Received: by 2002:a05:6000:455c:b0:47f:91e3:3cc9 with SMTP id
 ffacd0b85a97d-47f91e33dc2mr7348173f8f.39.1784906606469; 
 Fri, 24 Jul 2026 08:23:26 -0700 (PDT)
Received: from localhost
 (p200300cfd7075d8bc03b74903e90fa9c.dip0.t-ipconnect.de.
 [2003:cf:d707:5d8b:c03b:7490:3e90:fa9c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a596sm25214877f8f.4.2026.07.24.08.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 08:23:25 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH 3/6] hw/nvme: Fix block accounting in nvme_copy()
Date: Fri, 24 Jul 2026 17:23:12 +0200
Message-ID: <20260724152315.234183-4-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724152315.234183-1-hreitz@redhat.com>
References: <20260724152315.234183-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In nvme_copy(), we start accounting for each of the copied ranges, but
only end it once (in nvme_copy_done()). We should end it after each
read/write operation is done instead, so they are properly accounted
for.

We should also actually pass the number of bytes we are reading/writing
(instead of 0), and probably account for the metadata operations also,
as they are block operations we execute.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/nvme/ctrl.c | 53 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a67e1598891..32e78881234 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2801,8 +2801,6 @@ static const AIOCBInfo nvme_copy_aiocb_info = {
 static void nvme_copy_done(NvmeCopyAIOCB *iocb)
 {
     NvmeRequest *req = iocb->req;
-    NvmeNamespace *ns = req->ns;
-    BlockAcctStats *stats = blk_get_stats(ns->blkconf.blk);
 
     if (iocb->idx != iocb->nr) {
         req->cqe.result = cpu_to_le32(iocb->idx);
@@ -2811,14 +2809,6 @@ static void nvme_copy_done(NvmeCopyAIOCB *iocb)
     qemu_iovec_destroy(&iocb->iov);
     g_free(iocb->bounce);
 
-    if (iocb->ret < 0) {
-        block_acct_failed(stats, &iocb->acct.read);
-        block_acct_failed(stats, &iocb->acct.write);
-    } else {
-        block_acct_done(stats, &iocb->acct.read);
-        block_acct_done(stats, &iocb->acct.write);
-    }
-
     iocb->common.cb(iocb->common.opaque, iocb->ret);
     qemu_aio_unref(iocb);
 }
@@ -2949,6 +2939,7 @@ static void nvme_copy_out_completed_cb(void *opaque, int ret)
     NvmeCopyAIOCB *iocb = opaque;
     NvmeRequest *req = iocb->req;
     NvmeNamespace *dns = req->ns;
+    BlockAcctStats *stats = blk_get_stats(dns->blkconf.blk);
     uint32_t nlb;
 
     nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, NULL,
@@ -2957,10 +2948,12 @@ static void nvme_copy_out_completed_cb(void *opaque, int ret)
     if (ret < 0) {
         iocb->ret = ret;
         req->status = NVME_WRITE_FAULT;
-        goto out;
-    } else if (iocb->ret < 0) {
+    }
+    if (iocb->ret < 0) {
+        block_acct_failed(stats, &iocb->acct.write);
         goto out;
     }
+    block_acct_done(stats, &iocb->acct.write);
 
     if (dns->params.zoned) {
         nvme_advance_zone_wp(dns, iocb->zone, nlb);
@@ -2977,11 +2970,18 @@ static void nvme_copy_out_cb(void *opaque, int ret)
     NvmeCopyAIOCB *iocb = opaque;
     NvmeRequest *req = iocb->req;
     NvmeNamespace *dns = req->ns;
+    BlockAcctStats *stats = blk_get_stats(dns->blkconf.blk);
     uint32_t nlb;
     size_t mlen;
     uint8_t *mbounce;
 
-    if (ret < 0 || iocb->ret < 0 || !dns->lbaf.ms) {
+    if (ret < 0 || iocb->ret < 0) {
+        block_acct_failed(stats, &iocb->acct.write);
+        goto out;
+    }
+    block_acct_done(stats, &iocb->acct.write);
+
+    if (!dns->lbaf.ms) {
         goto out;
     }
 
@@ -2994,6 +2994,7 @@ static void nvme_copy_out_cb(void *opaque, int ret)
     qemu_iovec_reset(&iocb->iov);
     qemu_iovec_add(&iocb->iov, mbounce, mlen);
 
+    block_acct_start(stats, &iocb->acct.write, mlen, BLOCK_ACCT_WRITE);
     iocb->aiocb = blk_aio_pwritev(dns->blkconf.blk, nvme_moff(dns, iocb->slba),
                                   &iocb->iov, 0, nvme_copy_out_completed_cb,
                                   iocb);
@@ -3010,6 +3011,7 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
     NvmeRequest *req = iocb->req;
     NvmeNamespace *sns = iocb->sns;
     NvmeNamespace *dns = req->ns;
+    BlockAcctStats *sstats = blk_get_stats(sns->blkconf.blk);
     NvmeCopyCmd *copy = NULL;
     uint8_t *mbounce = NULL;
     uint32_t nlb;
@@ -3022,10 +3024,12 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
     if (ret < 0) {
         iocb->ret = ret;
         req->status = NVME_UNRECOVERED_READ;
-        goto out;
-    } else if (iocb->ret < 0) {
+    }
+    if (iocb->ret < 0) {
+        block_acct_failed(sstats, &iocb->acct.read);
         goto out;
     }
+    block_acct_done(sstats, &iocb->acct.read);
 
     nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, &slba,
                                  &nlb, NULL, &apptag, &appmask, &reftag);
@@ -3100,7 +3104,7 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
     qemu_iovec_reset(&iocb->iov);
     qemu_iovec_add(&iocb->iov, iocb->bounce, len);
 
-    block_acct_start(blk_get_stats(dns->blkconf.blk), &iocb->acct.write, 0,
+    block_acct_start(blk_get_stats(dns->blkconf.blk), &iocb->acct.write, len,
                      BLOCK_ACCT_WRITE);
 
     iocb->aiocb = blk_aio_pwritev(dns->blkconf.blk, nvme_l2b(dns, iocb->slba),
@@ -3119,20 +3123,29 @@ static void nvme_copy_in_cb(void *opaque, int ret)
 {
     NvmeCopyAIOCB *iocb = opaque;
     NvmeNamespace *sns = iocb->sns;
+    BlockAcctStats *stats = blk_get_stats(sns->blkconf.blk);
     uint64_t slba;
     uint32_t nlb;
+    size_t mlen;
+
+    if (ret < 0 || iocb->ret < 0) {
+        block_acct_failed(stats, &iocb->acct.read);
+        goto out;
+    }
+    block_acct_done(stats, &iocb->acct.read);
 
-    if (ret < 0 || iocb->ret < 0 || !sns->lbaf.ms) {
+    if (!sns->lbaf.ms) {
         goto out;
     }
 
     nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, &slba,
                                  &nlb, NULL, NULL, NULL, NULL);
 
+    mlen = nvme_m2b(sns, nlb);
     qemu_iovec_reset(&iocb->iov);
-    qemu_iovec_add(&iocb->iov, iocb->bounce + nvme_l2b(sns, nlb),
-                   nvme_m2b(sns, nlb));
+    qemu_iovec_add(&iocb->iov, iocb->bounce + nvme_l2b(sns, nlb), mlen);
 
+    block_acct_start(stats, &iocb->acct.read, mlen, BLOCK_ACCT_READ);
     iocb->aiocb = blk_aio_preadv(sns->blkconf.blk, nvme_moff(sns, slba),
                                  &iocb->iov, 0, nvme_copy_in_completed_cb,
                                  iocb);
@@ -3337,7 +3350,7 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
     qemu_iovec_reset(&iocb->iov);
     qemu_iovec_add(&iocb->iov, iocb->bounce, len);
 
-    block_acct_start(blk_get_stats(sns->blkconf.blk), &iocb->acct.read, 0,
+    block_acct_start(blk_get_stats(sns->blkconf.blk), &iocb->acct.read, len,
                      BLOCK_ACCT_READ);
 
     iocb->aiocb = blk_aio_preadv(sns->blkconf.blk, nvme_l2b(sns, slba),
-- 
2.55.0


