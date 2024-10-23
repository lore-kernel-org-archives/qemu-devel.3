Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265ACD2E02A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XDR-0008S0-NI; Wed, 23 Oct 2024 04:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDQ-0008Oh-G1
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:40 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDO-0000LM-SV
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=0wv4Bd0qGIUaO87TgMqgo6+C19k2RpbDJdR6XFSsc8M=; b=dkohGiqOZ+wdkRFgq4IsE1saLw
 l5OpcPt8YWtJWxbDJn9XkVyjXetkB8J44wjBbmQms2QonOnclwcgle+Olw5Rf/PmBs0eqogfAKvd+
 VFIjWqxVCIZ8q77C55+jEfrOgekRLU2/X7fzRTdXLVvsoRTZbQXKqazCa6NHq1e2BwDnJKOoJvn0V
 1Oe52gJnw+nhy/DTw+WQft/phGFuXWajhvtD0ZPj1s1n8xyk2jwIE1XaJX6XhxonXlVWVKjIbRMOo
 4/H7OubsJJ3mn5stjpIyedA+ciBp111kg+LzBV9+hAT0Js2+F2Ujlljez4EIw9hXm6WzSf+2bUpWe
 RyOkkwoNKlsBxCEBxKRY4ryTprx2L5Urk2s5PG8nGmvxaVfUBKrZbRhtgWmZo0QquIw9SgWnvHwgo
 UX1HuwqyEx7/vSIK9GDEYV3VODqJ+tkUXAraGxwOrH9EgPljg+Kt0tYZNTuXoRGQnsdea5svQZOEj
 eTJVnfB7x0K7t6h5j2kxa/b7Lh6zo+2FNaax1O3hUlqsrZEdZqAwQuoLfOvd39ooXgkDZp1gNqjsG
 faPxXsU0JcCvw+NKoh2PEdKyavX2AnUT8LPh0ZRCPhYRR0Yb4EM5Dr+Eu3hDve8/uFfzE3JXbyQ+Q
 dvbNtQ1ypgH2ah9RtDBOd0BXav1DbljyK3Jk3jq4A=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XD4-0008EL-Kg; Wed, 23 Oct 2024 09:59:22 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:26 +0100
Message-Id: <20241023085852.1061031-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 10/36] next-cube: move SCSI 4020 logic from next-pc device to
 next-scsi device
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The SCSI 4020 logic refers to the offset of the SCSI CSRs within the NeXTCube
address space. Due to the previously overlapping memory regions, there were
duplicate MMIO accessors in the next.scr memory region for these registers but
now this has been resolved. This allows us to move the more complex prototype
logic into the next-scsi MMIO accessors.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 139 ++++++++++++++++++++------------------------
 1 file changed, 62 insertions(+), 77 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 32466a425f..22da777006 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -365,8 +365,6 @@ static const MemoryRegionOps next_mmio_ops = {
 
 static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
 {
-    NeXTPC *s = NEXT_PC(opaque);
-    NeXTSCSI *ns = NEXT_SCSI(&s->next_scsi);
     uint64_t val;
 
     switch (addr) {
@@ -375,16 +373,6 @@ static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
         val = 0x40 | 0x04 | 0x2 | 0x1;
         break;
 
-    case 0x14020:
-        DPRINTF("SCSI 4020  STATUS READ %X\n", ns->scsi_csr_1);
-        val = ns->scsi_csr_1;
-        break;
-
-    case 0x14021:
-        DPRINTF("SCSI 4021 STATUS READ %X\n", ns->scsi_csr_2);
-        val = 0x40;
-        break;
-
     /*
      * These 4 registers are the hardware timer, not sure which register
      * is the latch instead of data, but no problems so far.
@@ -413,9 +401,6 @@ static uint64_t next_scr_readfn(void *opaque, hwaddr addr, unsigned size)
 static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
                              unsigned size)
 {
-    NeXTPC *s = NEXT_PC(opaque);
-    NeXTSCSI *ns = NEXT_SCSI(&s->next_scsi);
-
     switch (addr) {
     case 0x14108:
         DPRINTF("FDCSR Write: %"PRIx64 "\n", val);
@@ -424,68 +409,6 @@ static void next_scr_writefn(void *opaque, hwaddr addr, uint64_t val,
         }
         break;
 
-    case 0x14020: /* SCSI Control Register */
-        if (val & SCSICSR_FIFOFL) {
-            DPRINTF("SCSICSR FIFO Flush\n");
-            /* will have to add another irq to the esp if this is needed */
-            /* esp_puflush_fifo(esp_g); */
-        }
-
-        if (val & SCSICSR_ENABLE) {
-            DPRINTF("SCSICSR Enable\n");
-            /*
-             * qemu_irq_raise(s->scsi_dma);
-             * s->scsi_csr_1 = 0xc0;
-             * s->scsi_csr_1 |= 0x1;
-             * qemu_irq_pulse(s->scsi_dma);
-             */
-        }
-        /*
-         * else
-         *     s->scsi_csr_1 &= ~SCSICSR_ENABLE;
-         */
-
-        if (val & SCSICSR_RESET) {
-            DPRINTF("SCSICSR Reset\n");
-            /* I think this should set DMADIR. CPUDMA and INTMASK to 0 */
-            qemu_irq_raise(s->scsi_reset);
-            ns->scsi_csr_1 &= ~(SCSICSR_INTMASK | 0x80 | 0x1);
-            qemu_irq_lower(s->scsi_reset);
-        }
-        if (val & SCSICSR_DMADIR) {
-            DPRINTF("SCSICSR DMAdir\n");
-        }
-        if (val & SCSICSR_CPUDMA) {
-            DPRINTF("SCSICSR CPUDMA\n");
-            /* qemu_irq_raise(s->scsi_dma); */
-            s->int_status |= 0x4000000;
-        } else {
-            /* fprintf(stderr,"SCSICSR CPUDMA disabled\n"); */
-            s->int_status &= ~(0x4000000);
-            /* qemu_irq_lower(s->scsi_dma); */
-        }
-        if (val & SCSICSR_INTMASK) {
-            DPRINTF("SCSICSR INTMASK\n");
-            /*
-             * int_mask &= ~0x1000;
-             * s->scsi_csr_1 |= val;
-             * s->scsi_csr_1 &= ~SCSICSR_INTMASK;
-             * if (s->scsi_queued) {
-             *     s->scsi_queued = 0;
-             *     next_irq(s, NEXT_SCSI_I, level);
-             * }
-             */
-        } else {
-            /* int_mask |= 0x1000; */
-        }
-        if (val & 0x80) {
-            /* int_mask |= 0x1000; */
-            /* s->scsi_csr_1 |= 0x80; */
-        }
-        DPRINTF("SCSICSR Write: %"PRIx64 "\n", val);
-        /* s->scsi_csr_1 = val; */
-        break;
-
     /* Hardware timer latch - not implemented yet */
     case 0x1a000:
     default:
@@ -846,13 +769,73 @@ static void next_scsi_csr_write(void *opaque, hwaddr addr, uint64_t val,
                                 unsigned size)
 {
     NeXTSCSI *s = NEXT_SCSI(opaque);
+    NeXTPC *pc = NEXT_PC(container_of(s, NeXTPC, next_scsi));
 
     switch (addr) {
     case 0:
+        if (val & SCSICSR_FIFOFL) {
+            DPRINTF("SCSICSR FIFO Flush\n");
+            /* will have to add another irq to the esp if this is needed */
+            /* esp_puflush_fifo(esp_g); */
+        }
+
+        if (val & SCSICSR_ENABLE) {
+            DPRINTF("SCSICSR Enable\n");
+            /*
+             * qemu_irq_raise(s->scsi_dma);
+             * s->scsi_csr_1 = 0xc0;
+             * s->scsi_csr_1 |= 0x1;
+             * qemu_irq_pulse(s->scsi_dma);
+             */
+        }
+        /*
+         * else
+         *     s->scsi_csr_1 &= ~SCSICSR_ENABLE;
+         */
+
+        if (val & SCSICSR_RESET) {
+            DPRINTF("SCSICSR Reset\n");
+            /* I think this should set DMADIR. CPUDMA and INTMASK to 0 */
+            qemu_irq_raise(pc->scsi_reset);
+            s->scsi_csr_1 &= ~(SCSICSR_INTMASK | 0x80 | 0x1);
+            qemu_irq_lower(pc->scsi_reset);
+        }
+        if (val & SCSICSR_DMADIR) {
+            DPRINTF("SCSICSR DMAdir\n");
+        }
+        if (val & SCSICSR_CPUDMA) {
+            DPRINTF("SCSICSR CPUDMA\n");
+            /* qemu_irq_raise(s->scsi_dma); */
+            pc->int_status |= 0x4000000;
+        } else {
+            /* fprintf(stderr,"SCSICSR CPUDMA disabled\n"); */
+            pc->int_status &= ~(0x4000000);
+            /* qemu_irq_lower(s->scsi_dma); */
+        }
+        if (val & SCSICSR_INTMASK) {
+            DPRINTF("SCSICSR INTMASK\n");
+            /*
+             * int_mask &= ~0x1000;
+             * s->scsi_csr_1 |= val;
+             * s->scsi_csr_1 &= ~SCSICSR_INTMASK;
+             * if (s->scsi_queued) {
+             *     s->scsi_queued = 0;
+             *     next_irq(s, NEXT_SCSI_I, level);
+             * }
+             */
+        } else {
+            /* int_mask |= 0x1000; */
+        }
+        if (val & 0x80) {
+            /* int_mask |= 0x1000; */
+            /* s->scsi_csr_1 |= 0x80; */
+        }
+        DPRINTF("SCSICSR1 Write: %"PRIx64 "\n", val);
         s->scsi_csr_1 = val;
         break;
 
     case 1:
+        DPRINTF("SCSICSR2 Write: %"PRIx64 "\n", val);
         s->scsi_csr_2 = val;
         break;
 
@@ -868,10 +851,12 @@ static uint64_t next_scsi_csr_read(void *opaque, hwaddr addr, unsigned size)
 
     switch (addr) {
     case 0:
+        DPRINTF("SCSI 4020  STATUS READ %X\n", s->scsi_csr_1);
         val = s->scsi_csr_1;
         break;
 
     case 1:
+        DPRINTF("SCSI 4021 STATUS READ %X\n", s->scsi_csr_2);
         val = s->scsi_csr_2;
         break;
 
-- 
2.39.5


