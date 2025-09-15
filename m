Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C9ECAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 09:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy53s-0001Yt-Pr; Mon, 15 Sep 2025 04:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uy53p-0001YI-2t
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:59:45 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uy53f-00049N-Dz
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:59:43 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45f2313dd86so24690995e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 01:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1757926770; x=1758531570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xu0NbMZt6WlaBqY9vl8/Allq8aeiTc/NFNCPm9H71tI=;
 b=jWegJs8buOT+T362XxYv2pRzXGHAKvXiFii41vKlufeiNbu1DPlo0ZdXan0ZhYr7oj
 Ve6Wj7bDWPvl0jz5wn9IW9ussoSAJ29LmKAB+kuB1JUlQnEiy7nIuqEjF1J/PZAFF6dv
 Dhe4xr55hznl0hc7dbOuHA+EIx9L+pClGxPIO7LxCk778EA1xz/ZEQFII+S3i3KzbpBZ
 eu22lIvn0anNHPzgwX1FIKEAv5wnjrSPBwha35mqK8qedpFzqawO4zVOKpjPV5ZAaM8X
 SIrRhxiwGuiln1bTUZkgeEvLQKK36aDzMY4ihdRmI9jFPe6D/hVjnoDjH0Pfo8pJY9pB
 wPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757926770; x=1758531570;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xu0NbMZt6WlaBqY9vl8/Allq8aeiTc/NFNCPm9H71tI=;
 b=uUBfAOXBD6mbjWFyHFKkOy3XmD4EdopXEvcqF2fnCWQPWkSRaFHUSJ/W9beZsHTMzt
 HKX2BsOAryV0VXyivB83LzFh7F3YbXrJsbin91Orhe4s5pnY6tQfFy+7uqAKTr2XBK+Y
 RIJbzgIynD8yxp5RMZpXY6Z8OHYyxoFCZZX6Yt/+cxpZV5RsZUFUeffvOP3R7jUeREw1
 EYFdoRlIPb6jc2PzTgTAyKlLNHAg/Tlue6NWZxbCEcxu373L5pbgLqV6fy3I2aydoClU
 VbWFFfnw5LkSYxKOFZbY8keeRXC01uiAuAkFnLOFtl3hAqff6YY/Nj6mFsxlx650g9QY
 BK/Q==
X-Gm-Message-State: AOJu0YwlV5Q8NRY+rpjUPdodOPHD5F6hW/kLleQvV58GWbxwIsICwwvU
 LXxd7p5qcyZqXuydbfJgDf8FtU2H56WyQZ2gRpKRDc8WAa+CuoxGdmqQwt3ZelAzpzAaE0kun1q
 hZRE=
X-Gm-Gg: ASbGncvTj9eYVI0DnCRYnxY6XoY3s91m38CGcft4jjpUHK+meGtBl87+gBmaJ2/5f48
 fawOoEU2dztukRsev5us0MjaxVdJm5FBnu4w74RZwMhpTF7ezHvuYIdHviwcuxoh3UwaooU9uYV
 NeeFajeK9ZGCHv+bnlyxyYwtn+q7X3sFJAJ7Xw8Zi0lP16RasSuLAxuoejgHCa3LuZcs6PjfQ/d
 CsGFgsNTD1eYY7tKgR1X/rjmYPb8DJ+MflAb8AU0U9FFBeG03IKCmIekRdGegxKodwBwZqkspvN
 JhRdewYOus8JHCTFrlpE2IKm7PohfnLVj2crrzaGXooXhA0M9XqnWtKwagZ/1+WvCqZ9fMF1AcD
 qvDJsJlvrBRI9+S2HTbMCQXNps7f8q2xjcygGN5RZ8Qg6IICigym7Y7dRBkkDcTmu14w2cX/B1t
 ic8EgkPDDz2/Z5I3nRMKI=
X-Google-Smtp-Source: AGHT+IEKVyrmnuq5lnuAKfnMCp7MWHFSxHtsoHfmV88me4mbfpFb2luGFEBVjSVIztw7m+/xFyNhuA==
X-Received: by 2002:a05:600c:c4b8:b0:45f:2919:5e6c with SMTP id
 5b1f17b1804b1-45f29d33122mr61177365e9.16.1757926770173; 
 Mon, 15 Sep 2025 01:59:30 -0700 (PDT)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e03719235sm168074625e9.1.2025.09.15.01.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 01:59:29 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me, Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [RESEND PATCH] hw/arm/xlnx-zynqmp: wire a second GIC for the Cortex-R5
Date: Mon, 15 Sep 2025 10:59:14 +0200
Message-Id: <20250915085914.526890-1-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Frederic Konrad <konrad.frederic@yahoo.fr>

This wires a second GIC for the Cortex-R5, all the IRQs are split when there
is an RPU instanciated.

Signed-off-by: Clément Chigot <chigot@adacore.com>

---

Originally, this patch was member of a wider series. Other patches have
been merged since thus submit it back as a standalone patch.
 https://lists.gnu.org/archive/html/qemu-devel/2025-06/msg02328.html

---
 hw/arm/xlnx-zynqmp.c         | 103 +++++++++++++++++++++++++++++++----
 include/hw/arm/xlnx-zynqmp.h |   5 ++
 2 files changed, 98 insertions(+), 10 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index ec96a46eec..ffed6e5126 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -26,8 +26,6 @@
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 
-#define GIC_NUM_SPI_INTR 160
-
 #define ARM_PHYS_TIMER_PPI  30
 #define ARM_VIRT_TIMER_PPI  27
 #define ARM_HYP_TIMER_PPI   26
@@ -206,17 +204,26 @@ static const XlnxZynqMPGICRegion xlnx_zynqmp_gic_regions[] = {
 
 static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
 {
-    return GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;
+    return XLNX_ZYNQMP_GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;
+}
+
+static unsigned int xlnx_zynqmp_get_rpu_number(MachineState *ms)
+{
+    /*
+     * RPUs will be created only if "-smp" is higher than the maximum
+     * of APUs. Round it up to 0 to avoid dealing with negative values.
+     */
+    return MAX(0, MIN((int)(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS),
+                      XLNX_ZYNQMP_NUM_RPU_CPUS));
 }
 
 static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
                                    const char *boot_cpu, Error **errp)
 {
     int i;
-    int num_rpus = MIN((int)(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS),
-                       XLNX_ZYNQMP_NUM_RPU_CPUS);
+    int num_rpus = xlnx_zynqmp_get_rpu_number(ms);
 
-    if (num_rpus <= 0) {
+    if (!num_rpus) {
         /* Don't create rpu-cluster object if there's nothing to put in it */
         return;
     }
@@ -377,6 +384,7 @@ static void xlnx_zynqmp_init(Object *obj)
     XlnxZynqMPState *s = XLNX_ZYNQMP(obj);
     int i;
     int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
+    int num_rpus = xlnx_zynqmp_get_rpu_number(ms);
 
     object_initialize_child(obj, "apu-cluster", &s->apu_cluster,
                             TYPE_CPU_CLUSTER);
@@ -390,6 +398,12 @@ static void xlnx_zynqmp_init(Object *obj)
 
     object_initialize_child(obj, "gic", &s->gic, gic_class_name());
 
+    if (num_rpus) {
+        /* Do not create the rpu_gic if we don't have rpus */
+        object_initialize_child(obj, "rpu_gic", &s->rpu_gic,
+                                gic_class_name());
+    }
+
     for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
         object_initialize_child(obj, "gem[*]", &s->gem[i], TYPE_CADENCE_GEM);
         object_initialize_child(obj, "gem-irq-orgate[*]",
@@ -439,6 +453,15 @@ static void xlnx_zynqmp_init(Object *obj)
     object_initialize_child(obj, "qspi-irq-orgate",
                             &s->qspi_irq_orgate, TYPE_OR_IRQ);
 
+    if (num_rpus) {
+        for (i = 0; i < ARRAY_SIZE(s->splitter); i++) {
+            g_autofree char *name = g_strdup_printf("irq-splitter%d", i);
+            object_initialize_child(obj, name, &s->splitter[i], TYPE_SPLIT_IRQ);
+        }
+    }
+
+
+
     for (i = 0; i < XLNX_ZYNQMP_NUM_USB; i++) {
         object_initialize_child(obj, "usb[*]", &s->usb[i], TYPE_USB_DWC3);
     }
@@ -452,9 +475,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     uint8_t i;
     uint64_t ram_size;
     int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
+    int num_rpus = xlnx_zynqmp_get_rpu_number(ms);
     const char *boot_cpu = s->boot_cpu ? s->boot_cpu : "apu-cpu[0]";
     ram_addr_t ddr_low_size, ddr_high_size;
-    qemu_irq gic_spi[GIC_NUM_SPI_INTR];
+    qemu_irq gic_spi[XLNX_ZYNQMP_GIC_NUM_SPI_INTR];
     Error *err = NULL;
 
     ram_size = memory_region_size(s->ddr_ram);
@@ -502,13 +526,22 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         g_free(ocm_name);
     }
 
-    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", GIC_NUM_SPI_INTR + 32);
+    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq",
+                         XLNX_ZYNQMP_GIC_NUM_SPI_INTR + 32);
     qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
     qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", num_apus);
     qdev_prop_set_bit(DEVICE(&s->gic), "has-security-extensions", s->secure);
     qdev_prop_set_bit(DEVICE(&s->gic),
                       "has-virtualization-extensions", s->virt);
 
+    if (num_rpus) {
+        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "num-irq",
+                             XLNX_ZYNQMP_GIC_NUM_SPI_INTR + 32);
+        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "revision", 1);
+        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "num-cpu", num_rpus);
+        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "first-cpu-index", 4);
+    }
+
     qdev_realize(DEVICE(&s->apu_cluster), NULL, &error_fatal);
 
     /* Realize APUs before realizing the GIC. KVM requires this.  */
@@ -608,13 +641,63 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (num_rpus) {
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->rpu_gic), errp)) {
+            return;
+        }
+
+        for (i = 0; i < num_rpus; i++) {
+            qemu_irq irq;
+
+            sysbus_mmio_map(SYS_BUS_DEVICE(&s->rpu_gic), i + 1,
+                            GIC_BASE_ADDR + i * 0x1000);
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->rpu_gic), i,
+                               qdev_get_gpio_in(DEVICE(&s->rpu_cpu[i]),
+                                                ARM_CPU_IRQ));
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->rpu_gic), i + num_rpus,
+                               qdev_get_gpio_in(DEVICE(&s->rpu_cpu[i]),
+                                                ARM_CPU_FIQ));
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->rpu_gic), i + num_rpus * 2,
+                               qdev_get_gpio_in(DEVICE(&s->rpu_cpu[i]),
+                                                ARM_CPU_VIRQ));
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->rpu_gic), i + num_rpus * 3,
+                               qdev_get_gpio_in(DEVICE(&s->rpu_cpu[i]),
+                                                ARM_CPU_VFIQ));
+            irq = qdev_get_gpio_in(DEVICE(&s->rpu_gic),
+                                   arm_gic_ppi_index(i, ARM_PHYS_TIMER_PPI));
+            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_PHYS, irq);
+            irq = qdev_get_gpio_in(DEVICE(&s->rpu_gic),
+                                   arm_gic_ppi_index(i, ARM_VIRT_TIMER_PPI));
+            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_VIRT, irq);
+            irq = qdev_get_gpio_in(DEVICE(&s->rpu_gic),
+                                   arm_gic_ppi_index(i, ARM_HYP_TIMER_PPI));
+            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_HYP, irq);
+            irq = qdev_get_gpio_in(DEVICE(&s->rpu_gic),
+                                   arm_gic_ppi_index(i, ARM_SEC_TIMER_PPI));
+            qdev_connect_gpio_out(DEVICE(&s->rpu_cpu[i]), GTIMER_SEC, irq);
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->rpu_gic), 0, GIC_BASE_ADDR);
+    }
+
     if (!s->boot_cpu_ptr) {
         error_setg(errp, "ZynqMP Boot cpu %s not found", boot_cpu);
         return;
     }
 
-    for (i = 0; i < GIC_NUM_SPI_INTR; i++) {
-        gic_spi[i] = qdev_get_gpio_in(DEVICE(&s->gic), i);
+    for (i = 0; i < XLNX_ZYNQMP_GIC_NUM_SPI_INTR; i++) {
+        if (num_rpus) {
+            DeviceState *splitter = DEVICE(&s->splitter[i]);
+            qdev_prop_set_uint16(splitter, "num-lines", 2);
+            qdev_realize(splitter, NULL, &error_abort);
+            gic_spi[i] = qdev_get_gpio_in(splitter, 0);
+            qdev_connect_gpio_out(splitter, 0,
+                                  qdev_get_gpio_in(DEVICE(&s->gic), i));
+            qdev_connect_gpio_out(splitter, 1,
+                                  qdev_get_gpio_in(DEVICE(&s->rpu_gic), i));
+        } else {
+            gic_spi[i] = qdev_get_gpio_in(DEVICE(&s->gic), i);
+        }
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index c137ac59e8..0ae00e10f6 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -42,6 +42,7 @@
 #include "hw/misc/xlnx-zynqmp-crf.h"
 #include "hw/timer/cadence_ttc.h"
 #include "hw/usb/hcd-dwc3.h"
+#include "hw/core/split-irq.h"
 
 #define TYPE_XLNX_ZYNQMP "xlnx-zynqmp"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPState, XLNX_ZYNQMP)
@@ -87,6 +88,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPState, XLNX_ZYNQMP)
                                   XLNX_ZYNQMP_MAX_HIGH_RAM_SIZE)
 
 #define XLNX_ZYNQMP_NUM_TTC 4
+#define XLNX_ZYNQMP_GIC_NUM_SPI_INTR 160
 
 /*
  * Unimplemented mmio regions needed to boot some images.
@@ -105,6 +107,9 @@ struct XlnxZynqMPState {
     GICState gic;
     MemoryRegion gic_mr[XLNX_ZYNQMP_GIC_REGIONS][XLNX_ZYNQMP_GIC_ALIASES];
 
+    GICState rpu_gic;
+    SplitIRQ splitter[XLNX_ZYNQMP_GIC_NUM_SPI_INTR];
+
     MemoryRegion ocm_ram[XLNX_ZYNQMP_NUM_OCM_BANKS];
 
     MemoryRegion *ddr_ram;
-- 
2.34.1


