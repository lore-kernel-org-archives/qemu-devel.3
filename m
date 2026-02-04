Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3827FE95396
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncqN-0003LL-DG; Wed, 04 Feb 2026 08:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vncqJ-0003JX-Rw; Wed, 04 Feb 2026 08:22:51 -0500
Received: from mail.avm.de ([2001:bf0:244:244::120])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vncqH-00031u-I9; Wed, 04 Feb 2026 08:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1770211360; bh=q4twjt2E4pRsujRgtku8JrJOS12+2byH1d3KqcJv0Gs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=hx98ePk1z1z2qXnJ7JjFA5kEZbqkTslaJqE0hz42YgNsBxUl5a2HGHdSVEjxgNkDe
 JZ3z3ZZR+WeXHOq/JqZinWVLDWxiHyNwOGilHBrskEVcUoMgbosrFmi3ZeVaKlxodb
 11k/Ax9+bRGV9mdzyJDf7BwEgXMY5byTO8MdbNiA=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.0)
 (envelope-from <c.speich@avm.de>)
 id 69834820-cb91-7f0000032729-7f000001d936-1
 for <multiple-recipients>; Wed, 04 Feb 2026 14:22:40 +0100
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Wed,  4 Feb 2026 14:22:40 +0100 (CET)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2026020414223966-15151 ;
 Wed, 4 Feb 2026 14:22:39 +0100 
From: Christian Speich <c.speich@avm.de>
Date: Wed, 04 Feb 2026 14:22:28 +0100
Subject: [PATCH v3 4/6] hw/sd/sdhci: Don't use bounce buffer for ADMA
MIME-Version: 1.0
Message-Id: <20260204-sdcard-performance-b4-v3-4-dc1cf172ee57@avm.de>
References: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
In-Reply-To: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, qemu-block@nongnu.org, Christian Speich
 <c.speich@avm.de>
X-Mailer: b4 0.14.2
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 04.02.2026 14:22:39,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 04.02.2026 14:22:41, Serialize complete at 04.02.2026 14:22:41
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-purgate-ID: 149429::1770211360-4BE4165A-D55E3678/0/0
X-purgate-type: clean
X-purgate-size: 6515
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=2001:bf0:244:244::120;
 envelope-from=c.speich@avm.de; helo=mail.avm.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, ADMA will temporarily store data into a local bounce buffer
when transferring it. This will produce unneeded copies of the data and
limit us to the bounce buffer size for each step.

This patch now maps the requested DMA address and passes this buffer
directly to sdbus_{read,write}_data. This allows to pass much larger
buffers down to increase the performance. sdbus_{read,write}_data is
already able to handle arbitrary length and alignments, so we do not
need to ensure this.

Signed-off-by: Christian Speich <c.speich@avm.de>
---
 hw/sd/sdhci.c | 102 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 55 insertions(+), 47 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index c86dfa281f4b0218bf6dda7a38d46abfc9638450..6e07711478cb6ca046a7d371a82e2c682ebbda00 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -775,7 +775,7 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
 
 static void sdhci_do_adma(SDHCIState *s)
 {
-    unsigned int begin, length;
+    unsigned int length;
     const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
     const MemTxAttrs attrs = { .memory = true };
     ADMADescr dscr = {};
@@ -817,66 +817,74 @@ static void sdhci_do_adma(SDHCIState *s)
             if (s->trnmod & SDHC_TRNS_READ) {
                 s->prnsts |= SDHC_DOING_READ;
                 while (length) {
-                    if (s->data_count == 0) {
-                        sdbus_read_data(&s->sdbus, s->fifo_buffer, block_size);
-                    }
-                    begin = s->data_count;
-                    if ((length + begin) < block_size) {
-                        s->data_count = length + begin;
-                        length = 0;
-                     } else {
-                        s->data_count = block_size;
-                        length -= block_size - begin;
-                    }
-                    res = dma_memory_write(s->dma_as, dscr.addr,
-                                           &s->fifo_buffer[begin],
-                                           s->data_count - begin,
-                                           attrs);
-                    if (res != MEMTX_OK) {
+                    dma_addr_t dma_len = length;
+
+                    void *buf = dma_memory_map(s->dma_as, dscr.addr, &dma_len,
+                                               DMA_DIRECTION_FROM_DEVICE,
+                                               attrs);
+
+                    if (buf == NULL) {
+                        res = MEMTX_ERROR;
                         break;
+                    } else {
+                        res = MEMTX_OK;
                     }
-                    dscr.addr += s->data_count - begin;
-                    if (s->data_count == block_size) {
-                        s->data_count = 0;
-                        if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
-                            s->blkcnt--;
-                            if (s->blkcnt == 0) {
-                                break;
-                            }
+
+                    sdbus_read_data(&s->sdbus, buf, dma_len);
+                    length -= dma_len;
+                    dscr.addr += dma_len;
+
+                    dma_memory_unmap(s->dma_as, buf, dma_len,
+                                     DMA_DIRECTION_FROM_DEVICE, dma_len);
+
+                    if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
+                        size_t transfered = s->data_count + dma_len;
+
+                        s->blkcnt -= transfered / block_size;
+                        s->data_count = transfered % block_size;
+
+                        if (s->blkcnt == 0) {
+                            s->data_count = 0;
+                            break;
                         }
                     }
                 }
             } else {
                 s->prnsts |= SDHC_DOING_WRITE;
                 while (length) {
-                    begin = s->data_count;
-                    if ((length + begin) < block_size) {
-                        s->data_count = length + begin;
-                        length = 0;
-                     } else {
-                        s->data_count = block_size;
-                        length -= block_size - begin;
-                    }
-                    res = dma_memory_read(s->dma_as, dscr.addr,
-                                          &s->fifo_buffer[begin],
-                                          s->data_count - begin,
-                                          attrs);
-                    if (res != MEMTX_OK) {
+                    dma_addr_t dma_len = length;
+
+                    void *buf = dma_memory_map(s->dma_as, dscr.addr, &dma_len,
+                                               DMA_DIRECTION_TO_DEVICE, attrs);
+
+                    if (buf == NULL) {
+                        res = MEMTX_ERROR;
                         break;
+                    } else {
+                        res = MEMTX_OK;
                     }
-                    dscr.addr += s->data_count - begin;
-                    if (s->data_count == block_size) {
-                        sdbus_write_data(&s->sdbus, s->fifo_buffer, block_size);
-                        s->data_count = 0;
-                        if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
-                            s->blkcnt--;
-                            if (s->blkcnt == 0) {
-                                break;
-                            }
+
+                    sdbus_write_data(&s->sdbus, buf, dma_len);
+                    length -= dma_len;
+                    dscr.addr += dma_len;
+
+                    dma_memory_unmap(s->dma_as, buf, dma_len,
+                                     DMA_DIRECTION_TO_DEVICE, dma_len);
+
+                    if (s->trnmod & SDHC_TRNS_BLK_CNT_EN) {
+                        size_t transfered = s->data_count + dma_len;
+
+                        s->blkcnt -= transfered / block_size;
+                        s->data_count = transfered % block_size;
+
+                        if (s->blkcnt == 0) {
+                            s->data_count = 0;
+                            break;
                         }
                     }
                 }
             }
+
             if (res != MEMTX_OK) {
                 s->data_count = 0;
                 if (s->errintstsen & SDHC_EISEN_ADMAERR) {

-- 
2.43.0


