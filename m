Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A04E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnhP-0006Y9-Pc; Sun, 29 Dec 2024 02:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhM-0006Wv-Lc
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:53 -0500
Received: from mail-ej1-f46.google.com ([209.85.218.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhK-00029B-Np
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:52 -0500
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-aa696d3901bso762751266b.1
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457209; x=1736062009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8g4JDK2gP7kBGIRp58PLikXD1WmmiHmJeQox3/MKTjs=;
 b=m5xNMUTUgfBgw91/9PWAvUwUYBPXBMXyxGx6E8GaqacxD/ud7V3tBw/J2LlVFJiG5e
 KjCvq/8NkngP/NHpcC5+21UuveYXt2HldAN0477qIK6YlRo3+at5/rXMqThH4CV9gyyt
 kFM6W+kLXUgUDN/MlWXSVNUh/3XPAoLBd+TVQM8sd7WfMQl48jYGZc6ATI/eYHS0Jivy
 wKBZ2TxphqLc+2Knk07PRPk2ijUe3qbTCmuXVDsrCtNdn0/erIQBFwndMFQsZx93vZcC
 zMNpAx8z+ATPGe4NogyMuc+awZEh9UA0RGBGeDgqX0AnIU0/R9hUomAcJ02Tfix+1H79
 rwcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk1OqycUmdZkGH5UTVxTV5BkgxUrVfe+2k4YU6CldL3g6FS4WWU2lnITdriTtN1cuU8qu2cMMZ+s34@nongnu.org
X-Gm-Message-State: AOJu0YymN3SMJ/JOgXTSFXEH7Zd/3Z+osLnqoWpkQgbB5bqSdY8Knf9B
 KbMQvLUmxDFTaqgGNVQ5YChPBDXiy2d/KnggAG/eYQ+1KCDBsluu
X-Gm-Gg: ASbGnctpY1KcDEF3edg/0QEpIA3C/WuFYkrjNNQl3I/J2mAXA3vL1FIp/Lw23OwKFIW
 mkiIV/+otYsGoauRkqavHACkR9swOF5qFQOeZ3iMxxkiCN3CE8VbC67QuUGbuKW2KPhOkYgZmMJ
 w4VuWsfsY3cWnM+t8xZMYgqjd8Tiw3vLZxLwX2HAYtXEhey+X1pD1ZfEtDD8EvchYDsWiMuezx/
 9LDAx6/nNyZwyUUDGDTEmWorjHw1UbH1njrUdADsigKC70vJyoHEMgDS/klUUOJ2GX0iJe8nZ1T
 g1I=
X-Google-Smtp-Source: AGHT+IGP457vSLVn1pcZ7UqdRH1rB2XcUREvQNpeqwpJNge7QAz3g4s2hjFyW0skv/h/6ylILhAqaA==
X-Received: by 2002:a17:907:3da0:b0:aab:cd45:5d3c with SMTP id
 a640c23a62f3a-aac33685df3mr2770574866b.50.1735457209031; 
 Sat, 28 Dec 2024 23:26:49 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:26:48 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 10/35] next-cube: move SCSI 4020/4021 logic from next-pc device
 to next-scsi device
Date: Sun, 29 Dec 2024 08:25:01 +0100
Message-ID: <20241229072526.166555-11-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.46; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f46.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The SCSI 4020/4021 logic refers to the offset of the SCSI CSRs within the NeXTCube
address space. Due to the previously overlapping memory regions, there were
duplicate MMIO accessors in the next.scr memory region for these registers but
this has now been resolved.

Move the remaining SCSI 4020/4021 logic from the next-pc device to the next-scsi
device, with the exception that the SCSI 4021 register now returns its previous
value like a normal register instead of a hardcoded 0x40 value. This also matches
how the registers are implemented in the Previous emulator.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-9-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 139 ++++++++++++++++++++------------------------
 1 file changed, 62 insertions(+), 77 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 687d1b3cb0..402e268f6b 100644
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
2.47.1


