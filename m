Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6E0C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 14:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5RHJ-0004lY-7z; Fri, 10 May 2024 10:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s5RGo-0004cv-9t; Fri, 10 May 2024 10:30:48 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s5RGk-0004B3-84; Fri, 10 May 2024 10:30:46 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6f4d6b7168eso1111774b3a.2; 
 Fri, 10 May 2024 07:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715351439; x=1715956239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4H+y2yih6+go7Fz8vg2Vv4pEdJZkjGtHvDitSqWPBA4=;
 b=nNZtQTdNif4tCb0OYp4l/SidTiDVIO6UGFHVeh9TBO+d4kNVC3U7LVoBfFT5eviD0Y
 bDS3uixJiuyZE4GsVbS/Abcl4TmSrAEX/DiXi7u+XPq/n5bl4+M2eCVJzlTPn7BWr5ul
 qjNzu7dzAgYTD/gxjogQNbZgqFAzhFRpDh75egXCXD0IjocuFm6ERsAe1nScFlZ9N6k+
 ZEi3n0SLi6/BXwp0EXl17V6uwNIxipwSPHgLaDcmowWYZidLJLnNAA3jIPZGnaRYEieJ
 nEwYsTyEwQfLJdLUxx+y+ua/cyPHwEyibGDqwIoUeeJDltwTnGrhq4esd8nDtQhURbnK
 hPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715351439; x=1715956239;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4H+y2yih6+go7Fz8vg2Vv4pEdJZkjGtHvDitSqWPBA4=;
 b=XGoq6wmmuKR5H4MuFOGOm9M40JYrbKrDnvUbnr4kNJkHtlRNkbtBX/EutzT9/lS+qn
 IyMtEUK5fzFbrvJkVHyYK4xEdzIRMxgQtGfSgK2Hk2F2GntQWOPYNc284sR1HVPwVxmM
 b5WepqqVRKL42pl6GK3EDRHwW0WxPXnbBE5zBewmCFLl4DEIo296ns0CKb7Gy6/MR16l
 9iz1iaOKui6qSrvJI9IHRgiQWnAsZi4gDcev/j4Pwz0YlVL4XsYhVHy6ZBOYn4GbdXVl
 fItqnZmEq14T2gMXtlFJLmfcR/PIoO4suMqcf5yzX/gWVVlDIRIhd9FyIkv8g8llAKLa
 LJuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSUXYwdKDu+uZOZTL99y65PPcP3k3k8PNeTOOLd8d7P22WcjoMpZuMSAs9s/iMdKfJDPG9QCvAc+Gwfs9vQjHPNGmBRnY=
X-Gm-Message-State: AOJu0Ywz0bPQsG4XXZzswke5YNQOyr7GtR4oud8H5EhFSVDtVvPOhTZl
 tXQFQlmempv1Hsb9wjsq9F9JdGEqhPrgYHAqedilIJ2czi8sn9xDjkG+nQ==
X-Google-Smtp-Source: AGHT+IG2U6eR1XryPkmbb5Gfx6pfIuKKvSMc0A2VQY2dDJoTNG5G6OGvTRViRFBV1SE62GB6Ws7N5g==
X-Received: by 2002:a05:6a00:234a:b0:6f0:c828:65c1 with SMTP id
 d2e1a72fcca58-6f4e029c23emr3205130b3a.2.1715351439377; 
 Fri, 10 May 2024 07:30:39 -0700 (PDT)
Received: from wheely.local0.net (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2af2a98sm2986830b3a.169.2024.05.10.07.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 07:30:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH] ppc/pnv: Implement POWER9 LPC PSI serirq outputs and
 auto-clear function
Date: Sat, 11 May 2024 00:30:26 +1000
Message-ID: <20240510143026.109098-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The POWER8 LPC ISA device irqs all get combined and reported to the line
connected the PSI LPCHC irq. POWER9 changed this so only internal LPC
host controller irqs use that line, and the device irqs get routed to
4 new lines connected to PSI SERIRQ0-3.

POWER9 also introduced a new feature that automatically clears the irq
status in the LPC host controller when EOI'ed, so software does not have
to.

The powernv OPAL (skiboot) firmware managed to work because the LPCHC
irq handler scanned all LPC irqs and handled those including clearing
status even on POWER9 systems. So LPC irqs worked despite OPAL thinking
it was running in POWER9 mode. After this change, UART interrupts show
up on serirq1 which is where OPAL routes them to:

 cat /proc/interrupts
 ...
 20:          0  XIVE-IRQ 1048563 Level     opal-psi#0:lpchc
 ...
 25:         34  XIVE-IRQ 1048568 Level     opal-psi#0:lpc_serirq_mux1

Whereas they previously turn up on lpchc.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv_lpc.h |  12 ++++-
 hw/ppc/pnv.c             |  38 +++++++++++++--
 hw/ppc/pnv_lpc.c         | 100 +++++++++++++++++++++++++++++++++++----
 3 files changed, 136 insertions(+), 14 deletions(-)

diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index 5d22c45570..57e324b4dc 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -84,8 +84,18 @@ struct PnvLpcController {
     /* XSCOM registers */
     MemoryRegion xscom_regs;
 
+    /*
+     * In P8, ISA irqs are combined with internal sources to drive the
+     * LPCHC interrupt output. P9 ISA irqs raise one of 4 lines that
+     * drive PSI SERIRQ irqs, routing according to OPB routing registers.
+     */
+    bool psi_serirq;
+
     /* PSI to generate interrupts */
-    qemu_irq psi_irq;
+    qemu_irq psi_irq_lpchc;
+
+    /* P9 introduced a serirq mode */
+    qemu_irq psi_irq_serirq[4];
 };
 
 struct PnvLpcClass {
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6e3a5ccdec..3b1c05a1d8 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -744,18 +744,48 @@ static ISABus *pnv_chip_power8nvl_isa_create(PnvChip *chip, Error **errp)
 static ISABus *pnv_chip_power9_isa_create(PnvChip *chip, Error **errp)
 {
     Pnv9Chip *chip9 = PNV9_CHIP(chip);
-    qemu_irq irq = qdev_get_gpio_in(DEVICE(&chip9->psi), PSIHB9_IRQ_LPCHC);
 
-    qdev_connect_gpio_out(DEVICE(&chip9->lpc), 0, irq);
+    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "LPCHC", 0,
+                                qdev_get_gpio_in(DEVICE(&chip9->psi),
+                                PSIHB9_IRQ_LPCHC));
+
+    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "SERIRQ", 0,
+                                qdev_get_gpio_in(DEVICE(&chip9->psi),
+                                PSIHB9_IRQ_LPC_SIRQ0));
+    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "SERIRQ", 1,
+                                qdev_get_gpio_in(DEVICE(&chip9->psi),
+                                PSIHB9_IRQ_LPC_SIRQ1));
+    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "SERIRQ", 2,
+                                qdev_get_gpio_in(DEVICE(&chip9->psi),
+                                PSIHB9_IRQ_LPC_SIRQ2));
+    qdev_connect_gpio_out_named(DEVICE(&chip9->lpc), "SERIRQ", 3,
+                                qdev_get_gpio_in(DEVICE(&chip9->psi),
+                                PSIHB9_IRQ_LPC_SIRQ3));
+
     return pnv_lpc_isa_create(&chip9->lpc, false, errp);
 }
 
 static ISABus *pnv_chip_power10_isa_create(PnvChip *chip, Error **errp)
 {
     Pnv10Chip *chip10 = PNV10_CHIP(chip);
-    qemu_irq irq = qdev_get_gpio_in(DEVICE(&chip10->psi), PSIHB9_IRQ_LPCHC);
 
-    qdev_connect_gpio_out(DEVICE(&chip10->lpc), 0, irq);
+    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "LPCHC", 0,
+                                qdev_get_gpio_in(DEVICE(&chip10->psi),
+                                PSIHB9_IRQ_LPCHC));
+
+    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "SERIRQ", 0,
+                                qdev_get_gpio_in(DEVICE(&chip10->psi),
+                                PSIHB9_IRQ_LPC_SIRQ0));
+    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "SERIRQ", 1,
+                                qdev_get_gpio_in(DEVICE(&chip10->psi),
+                                PSIHB9_IRQ_LPC_SIRQ1));
+    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "SERIRQ", 2,
+                                qdev_get_gpio_in(DEVICE(&chip10->psi),
+                                PSIHB9_IRQ_LPC_SIRQ2));
+    qdev_connect_gpio_out_named(DEVICE(&chip10->lpc), "SERIRQ", 3,
+                                qdev_get_gpio_in(DEVICE(&chip10->psi),
+                                PSIHB9_IRQ_LPC_SIRQ3));
+
     return pnv_lpc_isa_create(&chip10->lpc, false, errp);
 }
 
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index d692858bee..e28eae672f 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -64,6 +64,7 @@ enum {
 #define   LPC_HC_IRQSER_START_4CLK      0x00000000
 #define   LPC_HC_IRQSER_START_6CLK      0x01000000
 #define   LPC_HC_IRQSER_START_8CLK      0x02000000
+#define   LPC_HC_IRQSER_AUTO_CLEAR      0x00800000
 #define LPC_HC_IRQMASK          0x34    /* same bit defs as LPC_HC_IRQSTAT */
 #define LPC_HC_IRQSTAT          0x38
 #define   LPC_HC_IRQ_SERIRQ0            0x80000000 /* all bits down to ... */
@@ -420,6 +421,34 @@ static const MemoryRegionOps pnv_lpc_mmio_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+/* POWER9 serirq routing, see below */
+static int irq_to_serirq_route[ISA_NUM_IRQS];
+
+/* Program the POWER9 LPC irq to PSI serirq routing */
+static void pnv_lpc_eval_serirq_routes(PnvLpcController *lpc)
+{
+    int irq;
+
+    if (!lpc->psi_serirq) {
+        if ((lpc->opb_irq_route0 & PPC_BITMASK(8, 13)) ||
+            (lpc->opb_irq_route1 & PPC_BITMASK(4, 31))) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "OPB: setting serirq routing on POWER8 system, ignoring.\n");
+        }
+        return;
+    }
+
+    for (irq = 0; irq <= 13; irq++) {
+        int serirq = (lpc->opb_irq_route1 >> (31 - 5 - (irq * 2))) & 0x3;
+        irq_to_serirq_route[irq] = serirq;
+    }
+
+    for (irq = 14; irq < ISA_NUM_IRQS; irq++) {
+        int serirq = (lpc->opb_irq_route0 >> (31 - 9 - (irq * 2))) & 0x3;
+        irq_to_serirq_route[irq] = serirq;
+    }
+}
+
 static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
 {
     bool lpc_to_opb_irq = false;
@@ -445,7 +474,33 @@ static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
     lpc->opb_irq_stat |= lpc->opb_irq_input & lpc->opb_irq_mask;
 
     /* Reflect the interrupt */
-    qemu_set_irq(lpc->psi_irq, lpc->opb_irq_stat != 0);
+    if (!lpc->psi_serirq) {
+        /*
+         * POWER8 ORs all irqs together (also with LPCHC internal interrupt
+         * sources) and outputs a single line that raises the PSI LPCHC irq.
+         */
+        qemu_set_irq(lpc->psi_irq_lpchc, lpc->opb_irq_stat != 0);
+    } else {
+        /*
+         * POWER9 and POWER10 have routing fields in OPB master registers that
+         * send LPC irqs to 4 output lines that raise the PSI SERIRQ irqs. The
+         * LPCHC internal interrupts still go to the PSI LPCHC irq line,
+         * although no such internal sources are implemented yet.
+         */
+        bool serirq_out[4] = { false, false, false, false };
+        int irq;
+
+        for (irq = 0; irq < ISA_NUM_IRQS; irq++) {
+            if (lpc->lpc_hc_irqstat & (LPC_HC_IRQ_SERIRQ0 >> irq)) {
+                serirq_out[irq_to_serirq_route[irq]] = true;
+            }
+        }
+
+        qemu_set_irq(lpc->psi_irq_serirq[0], serirq_out[0]);
+        qemu_set_irq(lpc->psi_irq_serirq[1], serirq_out[1]);
+        qemu_set_irq(lpc->psi_irq_serirq[2], serirq_out[2]);
+        qemu_set_irq(lpc->psi_irq_serirq[3], serirq_out[3]);
+    }
 }
 
 static uint64_t lpc_hc_read(void *opaque, hwaddr addr, unsigned size)
@@ -536,10 +591,10 @@ static uint64_t opb_master_read(void *opaque, hwaddr addr, unsigned size)
     uint64_t val = 0xfffffffffffffffful;
 
     switch (addr) {
-    case OPB_MASTER_LS_ROUTE0: /* TODO */
+    case OPB_MASTER_LS_ROUTE0:
         val = lpc->opb_irq_route0;
         break;
-    case OPB_MASTER_LS_ROUTE1: /* TODO */
+    case OPB_MASTER_LS_ROUTE1:
         val = lpc->opb_irq_route1;
         break;
     case OPB_MASTER_LS_IRQ_STAT:
@@ -568,11 +623,15 @@ static void opb_master_write(void *opaque, hwaddr addr,
     PnvLpcController *lpc = opaque;
 
     switch (addr) {
-    case OPB_MASTER_LS_ROUTE0: /* TODO */
+    case OPB_MASTER_LS_ROUTE0:
         lpc->opb_irq_route0 = val;
+        pnv_lpc_eval_serirq_routes(lpc);
+        pnv_lpc_eval_irqs(lpc);
         break;
-    case OPB_MASTER_LS_ROUTE1: /* TODO */
+    case OPB_MASTER_LS_ROUTE1:
         lpc->opb_irq_route1 = val;
+        pnv_lpc_eval_serirq_routes(lpc);
+        pnv_lpc_eval_irqs(lpc);
         break;
     case OPB_MASTER_LS_IRQ_STAT:
         lpc->opb_irq_stat &= ~val;
@@ -583,6 +642,10 @@ static void opb_master_write(void *opaque, hwaddr addr,
         pnv_lpc_eval_irqs(lpc);
         break;
     case OPB_MASTER_LS_IRQ_POL:
+        if (val != 0) {
+            qemu_log_mask(LOG_UNIMP, "OPBM: interrupt polarity register "
+                                     "unimplemented\n");
+        }
         lpc->opb_irq_pol = val;
         pnv_lpc_eval_irqs(lpc);
         break;
@@ -657,6 +720,8 @@ static void pnv_lpc_power9_realize(DeviceState *dev, Error **errp)
     PnvLpcClass *plc = PNV_LPC_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    object_property_set_bool(OBJECT(lpc), "psi-serirq", true, &error_abort);
+
     plc->parent_realize(dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -666,6 +731,9 @@ static void pnv_lpc_power9_realize(DeviceState *dev, Error **errp)
     /* P9 uses a MMIO region */
     memory_region_init_io(&lpc->xscom_regs, OBJECT(lpc), &pnv_lpc_mmio_ops,
                           lpc, "lpcm", PNV9_LPCM_SIZE);
+
+    /* P9 LPC roues ISA irqs to 4 PSI SERIRQ lines */
+    qdev_init_gpio_out_named(dev, lpc->psi_irq_serirq, "SERIRQ", 4);
 }
 
 static void pnv_lpc_power9_class_init(ObjectClass *klass, void *data)
@@ -744,13 +812,19 @@ static void pnv_lpc_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&lpc->opb_mr, LPC_HC_REGS_OPB_ADDR,
                                 &lpc->lpc_hc_regs);
 
-    qdev_init_gpio_out(dev, &lpc->psi_irq, 1);
+    qdev_init_gpio_out_named(dev, &lpc->psi_irq_lpchc, "LPCHC", 1);
 }
 
+static Property pnv_lpc_properties[] = {
+    DEFINE_PROP_BOOL("psi-serirq", PnvLpcController, psi_serirq, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pnv_lpc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    device_class_set_props(dc, pnv_lpc_properties);
     dc->realize = pnv_lpc_realize;
     dc->desc = "PowerNV LPC Controller";
     dc->user_creatable = false;
@@ -796,7 +870,7 @@ static void pnv_lpc_isa_irq_handler_cpld(void *opaque, int n, int level)
     }
 
     if (pnv->cpld_irqstate != old_state) {
-        qemu_set_irq(lpc->psi_irq, pnv->cpld_irqstate != 0);
+        qemu_set_irq(lpc->psi_irq_lpchc, pnv->cpld_irqstate != 0);
     }
 }
 
@@ -804,9 +878,16 @@ static void pnv_lpc_isa_irq_handler(void *opaque, int n, int level)
 {
     PnvLpcController *lpc = PNV_LPC(opaque);
 
-    /* The Naples HW latches the 1 levels, clearing is done by SW */
+    /*
+     * Naples and later hardware latches the 1 levels, clearing is done by SW.
+     * POWER9 introduced an auto-clear mode so software can avoid clearing.
+     */
     if (level) {
-        lpc->lpc_hc_irqstat |= LPC_HC_IRQ_SERIRQ0 >> n;
+        lpc->lpc_hc_irqstat |= (LPC_HC_IRQ_SERIRQ0 >> n);
+        pnv_lpc_eval_irqs(lpc);
+    } else if (lpc->psi_serirq &&
+               (lpc->lpc_hc_irqser_ctrl & LPC_HC_IRQSER_AUTO_CLEAR)) {
+        lpc->lpc_hc_irqstat &= ~(LPC_HC_IRQ_SERIRQ0 >> n);
         pnv_lpc_eval_irqs(lpc);
     }
 }
@@ -838,6 +919,7 @@ ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool use_cpld, Error **errp)
         handler = pnv_lpc_isa_irq_handler;
     }
 
+    /* POWER has a 17th irq, QEMU only implements the 16 regular device irqs */
     irqs = qemu_allocate_irqs(handler, lpc, ISA_NUM_IRQS);
 
     isa_bus_register_input_irqs(isa_bus, irqs);
-- 
2.43.0


