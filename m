Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0838AC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4xAm-0004qA-64; Fri, 11 Sep 2026 05:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9h-0003Wa-Hr
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9f-0008DA-NL
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S24e5KZkbgytsFsTZMikkKLncaEvmAfRYA/x9bDr/iM=;
 b=CR21iuEiBLHc92ZQ7phIUvJQQUiRWYg7OHDyp/ogDmi0bb46V9Vcq/9xrRThHDNuXZYMwh
 eo3f6x74bEwXnni+5SWma8h9Ewe8jgdB3bXPG8Z5gNx+A5ab5VTsQ9Ey0Auk9PAsCF6ESz
 zdpQPLIvbsulrN1p0kMwVbSn1t3VPvU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-Fc9RUdY8P-ewipH1xCP2TQ-1; Fri, 11 Sep 2026 05:02:41 -0400
X-MC-Unique: Fc9RUdY8P-ewipH1xCP2TQ-1
X-Mimecast-MFC-AGG-ID: Fc9RUdY8P-ewipH1xCP2TQ_1789117361
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-482f763db88so272612f8f.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117360; x=1789722160; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=S24e5KZkbgytsFsTZMikkKLncaEvmAfRYA/x9bDr/iM=;
 b=XIkahLd1booqJa2tdCy8z/SfmVYep6lfaPk3ZwaV/IFuSDveJS6EZopZsQbDXFiVxG
 Ox/6bZe/SH7/WSjRJsJjUwkVVZXI9RKwlZSeGl1WpwNUAm92K10owQMV7ZD56p8z8KOO
 sdzKLfEOFenHna+S7brPVUNh8GYZhtj/cqDj6Xsg9uj2EWrfuLumVSWFGPYFl6RJADkS
 sLf1HsM23Q9liRyyZln/p+1KkQA5WgPLed0ECOZFfCT9zxfDoY75moh2KZg4D15Rw4IJ
 Y5bpuT+NLYwt7feBNNIgxEGZpzm7wsvgZ8a1Z6kz6//YaBqdenxOS6awIb12pGKjs9uZ
 4hfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117360; x=1789722160;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S24e5KZkbgytsFsTZMikkKLncaEvmAfRYA/x9bDr/iM=;
 b=rK2UAwXELRqqUWbvmVXqCZra5MBqOumu06vcm63FxBdNbfMOHeXGt+4fmg9CAN5SDg
 jIr1RPUkFAYhHNanA96Mk/EH1OAtalLtNoAX9wBX7xWgwCTXwKVT5PNuBDpN63WDr87X
 G2jedOwolqc8/kRS5i/1JAb8x5s9ydiY6AN1lU3RlaXx98J+yaUGCAUuOzR7Ia0+yi0j
 ducL60u2Agd2Hs6Mro/p8NsVoTp4zp3g5GqxfB5PkrNyJ4J4tocQHXnhilbPDwz5+eQy
 m5UhH/CV0tCS0J0rYBIdcCzAeX7He1L3ScR4ZT+PP5F+Jol+U4y3ktB4lOr86T5zT1Js
 kN8A==
X-Gm-Message-State: AFuF++nowg5/jikk1GwyzP9Vixs/5eUSim144D/2BD+ETBjqz6CNJINv
 d0pfGKew4cmUgHUIJuODgrlw5GHUlvMtNsUzvjijcGtB/yCVnFgph8Fu0runYDJxwdnQK6jC66+
 HKFUz2jX8o7lH/niYxoihz19ugdcU3RF88rq7I3leb4ydUzDs4H45CuR6cX95moOriZt8jSbgGm
 lI10MLIsVZKgJ1/bx5o1yfah3LqxAZtVCmiA==
X-Gm-Gg: AYBFou0+5XV2ZzOudCWYuXyWNqyeskmwVYV6U9kjnT4ind+N8eAETl0A4lFBo0AvB28
 Q+2YUhAKqT2kidygIm1nv3yKzjoK6e3fTYrjisJmgjqpNfZ/l64ThgjDdUA1OCBlsa/+62sDWcB
 +cTsMUCS+6eywCAHx1YJexoRRgbGixLCcErnaksL5kl9bNbQ7gJBlKh3hYC4/kGbTjmGtnL8+4n
 gWBbDjmK8tML0m1ENIm6h3Krb9lxwzQCg36NX9W1VAH9EAFGZGMIInCAfHSUEDSl+/lfbNeZUR/
 IgrUSOWeu9Mwwp20HhjQq0q8amK/Wm31xchi02/XRrui/9uXhllxN0wZ84VXsu1TlpSEx0lRKzc
 0WYPWU1/lUuJc1vmMFF6v3tc=
X-Received: by 2002:a05:600c:3b02:b0:49d:1f32:c911 with SMTP id
 5b1f17b1804b1-49e61982fb0mr35298925e9.3.1789117360070; 
 Fri, 11 Sep 2026 02:02:40 -0700 (PDT)
X-Received: by 2002:a05:600c:3b02:b0:49d:1f32:c911 with SMTP id
 5b1f17b1804b1-49e61982fb0mr35298145e9.3.1789117359437; 
 Fri, 11 Sep 2026 02:02:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e5765152asm91366705e9.11.2026.09.11.02.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:39 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL v2 33/75] hw/nvme: Fix block accounting in nvme_copy()
Message-ID: <426450da58d0130e1500ea85d78899a872e96be9.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In nvme_copy(), we start accounting for each of the copied ranges, but
only end it once (in nvme_copy_done()). We should end it after each
read/write operation is done instead, so they are properly accounted
for.

We should also actually pass the number of bytes we are reading/writing
(instead of 0), and probably account for the metadata operations also,
as they are block operations we execute.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260724152315.234183-4-hreitz@redhat.com>
---
 hw/nvme/ctrl.c | 53 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index c662d968db..c56725947a 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2802,8 +2802,6 @@ static const AIOCBInfo nvme_copy_aiocb_info = {
 static void nvme_copy_done(NvmeCopyAIOCB *iocb)
 {
     NvmeRequest *req = iocb->req;
-    NvmeNamespace *ns = req->ns;
-    BlockAcctStats *stats = blk_get_stats(ns->blkconf.blk);
 
     if (iocb->idx != iocb->nr) {
         req->cqe.result = cpu_to_le32(iocb->idx);
@@ -2813,14 +2811,6 @@ static void nvme_copy_done(NvmeCopyAIOCB *iocb)
     g_free(iocb->bounce);
     g_free(iocb->ranges);
 
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
@@ -2951,6 +2941,7 @@ static void nvme_copy_out_completed_cb(void *opaque, int ret)
     NvmeCopyAIOCB *iocb = opaque;
     NvmeRequest *req = iocb->req;
     NvmeNamespace *dns = req->ns;
+    BlockAcctStats *stats = blk_get_stats(dns->blkconf.blk);
     uint32_t nlb;
 
     nvme_copy_source_range_parse(iocb->ranges, iocb->idx, iocb->format, NULL,
@@ -2959,10 +2950,12 @@ static void nvme_copy_out_completed_cb(void *opaque, int ret)
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
@@ -2979,11 +2972,18 @@ static void nvme_copy_out_cb(void *opaque, int ret)
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
 
@@ -2996,6 +2996,7 @@ static void nvme_copy_out_cb(void *opaque, int ret)
     qemu_iovec_reset(&iocb->iov);
     qemu_iovec_add(&iocb->iov, mbounce, mlen);
 
+    block_acct_start(stats, &iocb->acct.write, mlen, BLOCK_ACCT_WRITE);
     iocb->aiocb = blk_aio_pwritev(dns->blkconf.blk, nvme_moff(dns, iocb->slba),
                                   &iocb->iov, 0, nvme_copy_out_completed_cb,
                                   iocb);
@@ -3012,6 +3013,7 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
     NvmeRequest *req = iocb->req;
     NvmeNamespace *sns = iocb->sns;
     NvmeNamespace *dns = req->ns;
+    BlockAcctStats *sstats = blk_get_stats(sns->blkconf.blk);
     NvmeCopyCmd *copy = NULL;
     uint8_t *mbounce = NULL;
     uint32_t nlb;
@@ -3024,10 +3026,12 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
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
@@ -3102,7 +3106,7 @@ static void nvme_copy_in_completed_cb(void *opaque, int ret)
     qemu_iovec_reset(&iocb->iov);
     qemu_iovec_add(&iocb->iov, iocb->bounce, len);
 
-    block_acct_start(blk_get_stats(dns->blkconf.blk), &iocb->acct.write, 0,
+    block_acct_start(blk_get_stats(dns->blkconf.blk), &iocb->acct.write, len,
                      BLOCK_ACCT_WRITE);
 
     iocb->aiocb = blk_aio_pwritev(dns->blkconf.blk, nvme_l2b(dns, iocb->slba),
@@ -3121,20 +3125,29 @@ static void nvme_copy_in_cb(void *opaque, int ret)
 {
     NvmeCopyAIOCB *iocb = opaque;
     NvmeNamespace *sns = iocb->sns;
+    BlockAcctStats *stats = blk_get_stats(sns->blkconf.blk);
     uint64_t slba;
     uint32_t nlb;
+    size_t mlen;
 
-    if (ret < 0 || iocb->ret < 0 || !sns->lbaf.ms) {
+    if (ret < 0 || iocb->ret < 0) {
+        block_acct_failed(stats, &iocb->acct.read);
+        goto out;
+    }
+    block_acct_done(stats, &iocb->acct.read);
+
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
@@ -3342,7 +3355,7 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
     assert(len <= blen);
     qemu_iovec_add(&iocb->iov, iocb->bounce, len);
 
-    block_acct_start(blk_get_stats(sns->blkconf.blk), &iocb->acct.read, 0,
+    block_acct_start(blk_get_stats(sns->blkconf.blk), &iocb->acct.read, len,
                      BLOCK_ACCT_READ);
 
     iocb->aiocb = blk_aio_preadv(sns->blkconf.blk, nvme_l2b(sns, slba),
-- 
MST


