Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F07DCA9EDE
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHCJ2-0005UD-FI; Wed, 14 Oct 2026 23:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xHCIx-0005NJ-Fa
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:38:56 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xHCIu-0008M0-Bw
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:38:55 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so3022543a91.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1792035520; x=1792640320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EJrDgCMXhmdM85GfU40H3R0tvXVAUqEEUdDEDQ/JOEI=;
 b=fuKkuuIMyg8MAl1R9OtyUEJouHdgQiq9/AVKBtojIyynX1bbwEV201vmK8snvdxwbM
 McShm9y86OYkSQtAo/IKZt/Iq48IvrI528ZsMDcvQ1NjaCZZ4AIvE2ol2wTNOCUy+mWp
 0x6Zx902guZPPhnEuGDvLRvBFxla/9FuZkpjzVGo3u5J3wQQmfSdOPIStiVmMkvm2tHa
 uP7/JAhXxuur9etxFVWlShQ4noldyxCC6njXUMlqgqAGwE9NrVCuBYEWUSKStY+TZWSG
 hWs0Y2YxyfqJ1J3TzIF0LNDET9ZWxcIM8wdgMmhIaktYrdegGN+viFZO7n8HlmOL4oim
 1QZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792035520; x=1792640320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EJrDgCMXhmdM85GfU40H3R0tvXVAUqEEUdDEDQ/JOEI=;
 b=HB9p/5JJGWBuKFIQrbfil1uEu2e+YTb8MHa5eUlct3n1EwYoVJc/T3pcsunC7YjPdY
 V0dAMnEEnCtDuZyR+mOrtRR+R8BOf7evPjbyMwB8L6rMXMef0u1EQ9R85XPGlnKNnIke
 bp9b+eAdbHj+RQpFo5d1PRTem/0Aa6j41ocNnNo9kgRXW5lSBAUXxq1a+ME7yZmkN9f2
 wo5zOtu01yIE9RTbGT6Xzjf4SmEh9WRBGZEZ73xWeomuYl9LBNPQQo1xO/LGU05Xm+tz
 o4DCBwtgw18fFKLaDzNZjpLn7XF66CcvnhABs7ULmdgUE47DpMNVfsiohWs18bUWVbdU
 0G/A==
X-Gm-Message-State: AFq9FYIuvZMrg2mBeK9Y8WR9ghKs0FOcT/sGYxpdkvg02M+5ZyLwBZZ1
 onQzShhlrCdkDZ9ZsUO7NTiKa99NDh5kJySBpWe3ZTXRNm/dO1Oh0aWEmKVCb15L6r5M1VCRRgR
 cuSMoBuN9Q7IUg1LynF02TEJ0VSFZ5QJ3d66Z2dXWn/ypjXMnSx8jG+OpMURVjBKm+O+KHR7XxO
 XXjN5WmySTtvbxsWeM2TtdnpPiFVlxpNF4qSMSfJTj
X-Gm-Gg: AYBFou3YnlMoos9AGdupt+PjqWNGuVnaEgUuWSOYnlAFVqTUkbt6zOhT8XZF4NaoBpG
 pnfwHLN8PiqjuRpaaMA693pDBRxQBvitulBe9+18pLM017LHsS5Ri3Dnpy5JapKq4Y3h+GloIuK
 WdHxpvA/HrGZ/U7GAhnieMMc0EAiSIGwsXXfx35SLRC2DpL+xP+X7J3FKLWu2O5Dwrw1YI6TEOk
 fvm8NgWhFWex1pc9pJDyJRxo4PebT4ixrQ2ym3Hi9pE4T30PgN30XUy4rgagphJJ+z5krD9J3HW
 xE/GFwJDw9A+osgnzHrnA0wwdZkU4AAzerHZ91sJr5S53LTiX3ZG2mHT7jZR5UkxjUDDmx54w12
 2vQLxZw6n1VQShptB40Pq9/cRaf8eNYqKRZYenXsCOuow/rGqGDMhefaJSGKoPNEZ2J/aaZywy6
 G+Xf4VjtbWYV3tz/hpVrUUGkeRhdfqzAsv0o8OFGFuzKh2SZ7u9FXqmPipg6s/MOKTjLbRcZwXv
 uO6EMXfyI+LPnodQnmLfYSiNXI25t/XbxYc
X-Received: by 2002:a17:90b:4c42:b0:3ac:80dc:f419 with SMTP id
 98e67ed59e1d1-3ac80dd01bcmr2772614a91.25.1792035519661; 
 Wed, 14 Oct 2026 20:38:39 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd635c612a9sm559188a12.17.2026.10.14.20.38.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Oct 2026 20:38:39 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq),
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 3/6] hw/dma/xilinx_axidma: Fix DMASR register handling
Date: Thu, 15 Oct 2026 11:37:30 +0800
Message-ID: <20261015033733.35116-4-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261015033733.35116-1-jay.chang@sifive.com>
References: <20261015033733.35116-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This patch fixes two register handling issues in the Xilinx AXI DMA
controller:

1. DMACR Start Processing Logic:
   When the guest writes to R_DMACR to start DMA processing, the
   original code cleared both DMASR_HALTED and DMASR_IDLE flags.
   However, DMASR_IDLE should only be cleared when TAILDESC is written
   (indicating actual work is queued). Incorrectly clearing IDLE on
   DMACR write can cause the DMA state machine to behave incorrectly.

2. DMASR W1C (Write-1-to-Clear) IRQ Bits:
   The original implementation had incorrect W1C logic:
       value &= ~(value & DMASR_IRQ_MASK);
       s->regs[addr] = value; // write R/O bit

   This would clear the entire register instead of just the IRQ bits.
   The correct W1C implementation should clear only the bits that are
   both set in the register AND written as 1 by the guest:
       s->regs[addr] &= ~(value & DMASR_IRQ_MASK);

3. Enhanced Error Logging:
   Added qemu_log_mask(LOG_GUEST_ERROR) when the DMA engine encounters
   a descriptor that is already marked COMPLETE. This indicates a guest
   driver error (reusing descriptors without proper reset) and helps
   debugging network issues.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 hw/dma/xilinx_axidma.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 282f92867d..6892d494c0 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -385,6 +385,10 @@ static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
 
         if (s->desc.status & SDESC_STATUS_COMPLETE) {
             s->regs[R_DMASR] |= DMASR_HALTED;
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "xilinx_axidma: HALT: curdesc=0x%016lx already"
+                          " COMPLETE status=0x%x\n",
+                          (unsigned long)curdesc, s->desc.status);
             break;
         }
 
@@ -555,15 +559,14 @@ static void axidma_writel(XilinxAXIDMA *d, struct Stream *s, hwaddr addr,
 
         if ((value & 1) && !stream_resetting(s)) {
             /* Start processing.  */
-            s->regs[R_DMASR] &= ~(DMASR_HALTED | DMASR_IDLE);
+            s->regs[R_DMASR] &= ~DMASR_HALTED;
         }
         stream_reload_complete_cnt(s);
         break;
 
     case R_DMASR:
-        /* Mask away write to clear irq lines.  */
-        value &= ~(value & DMASR_IRQ_MASK);
-        s->regs[R_DMASR] = value;
+        /* Clear W1C IRQ bits.  */
+        s->regs[R_DMASR] &= ~(value & DMASR_IRQ_MASK);
         break;
 
     case R_CURDESC:
-- 
2.48.1


