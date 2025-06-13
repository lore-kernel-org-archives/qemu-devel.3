Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62856C71151
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 13:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ4gI-0002GT-Jx; Fri, 13 Jun 2025 09:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uQ4fm-0001ir-Lv
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:42:28 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uQ4fi-0006HC-Lg
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:42:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a54836cb7fso1385987f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 06:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1749822135; x=1750426935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VtuIMGrk4cA38mwOT6svvwt5leQDrrMzrCr1wrerMs8=;
 b=igPAKDB9XocoNhr47GA7W0p9x1G0gnxTOw5h5vUjEO2BAZNOX+YoOPDDvrU0zO1wRI
 cWHRPZyr6wtu037fa4vNG0xSWUvd6kVoYO4T3zGlE/iCi+PdEC9TtbRAKQBwUu6ZPxPi
 UsrGwnNzVyti5V6p4PRXnfiL37n12o6HlvLS4q/toGqPAtu47N8Uc/53xECHV/J3jtYH
 P270NnVD/4UAFP8pziS1YJtnsJArEc41kqm3+g4GKyapJzNmDUG/3k0upfJwExu6lt+7
 Vmh9WqYRoz3tXu2DLrdu6ytSScI1JyFRoV+wusKSvK4Oy0FgUEs1QEbYMDw4QtMfQj4F
 WnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749822135; x=1750426935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VtuIMGrk4cA38mwOT6svvwt5leQDrrMzrCr1wrerMs8=;
 b=P9YE+rc5v36lCc1BqaFWZQvXtHvrRwdQXHJGlYbY0f4Rr7i5GNMhF2dOzPyF6gSClV
 XVFJz14H4Zkkm9w/wMU7P6ZEXdhlAghbtyuzRAX4LlJfeRsDRi3zBhX/qGsVkHRwL4X6
 jbbRxf5xmhOviw8Rh8PFCW3MIUqnB5vSMlp10geacXIL+WbBMDaxKZsQABhlkF9ZHzqM
 uzRUdTgt/TVah/W1gcxsa1DComRgKdxeLHiNZdr62gXRFw8ay5ho5O7li00uNwXwJyYd
 xCWnN9bJu4+YdDwP1Pb93euFt2clPwV8SW00VIZnM5XMCtlfg2tzGFehoPDrFXDWhKT2
 XiEA==
X-Gm-Message-State: AOJu0Yyf0BVZCb3iTGzzBkgoay0Cg10JgwcBUjGYAk91OcESuKAcib1Y
 qTBoNqmH4O/FGIU3ycHPWeTMf6p1BCegpFkDa5H7TRo5yerCLAKFbohUY88FocPg9/DSesZW8Ts
 TqIA=
X-Gm-Gg: ASbGncsFk3+NL8PNn7mSftWm8gLqjkReakRClEi5sWToCaqUQNwzS9fnyQJ2fma+aSF
 DNdCDadV/zIL9ehxFnZSe6WxEIVyU8FZBbMTUQxQeSuoQudIv8hsL6HnoeOrmf/v9MZ9837Vy7a
 sjYS6AzgkOdA4miPMW8IP9hHdLuhw92UTbdwqOHs14GWQGni0qE2Kk9bhBspR+KXdDo4BWYTmhR
 BfoSm9Z5PmOvf6ph+hf/TheEk+gkP2HApLj0GDxxW2TuzLR3RcMVUX9n77nCdWuFDDRaFq5ka6Z
 2mJFvFSqJDsgOx1NlZ/cYn5sxPeZdz3dpn1d4AfbJ3bVLP7aAJlX5AILuvvI3ySAuFTQ9RI=
X-Google-Smtp-Source: AGHT+IGzI1gRhn91+4rbO5onEcFo7IyYl5ISQrLKpahw2G1eQAj39t7+wCgtGiqo9rNHe1J4qOUbPA==
X-Received: by 2002:a05:6000:24c7:b0:3a5:26eb:b4af with SMTP id
 ffacd0b85a97d-3a5686fc03dmr3024839f8f.18.1749822135022; 
 Fri, 13 Jun 2025 06:42:15 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:8100:3d00:9e4f:bbb8:63a3:78f3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e224795sm53258035e9.7.2025.06.13.06.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:42:14 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me, Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v3 3/3] hw/arm/xlnx-zynqmp: wire a second GIC for the Cortex-R5
Date: Fri, 13 Jun 2025 15:42:08 +0200
Message-Id: <20250613134208.1509436-4-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250613134208.1509436-1-chigot@adacore.com>
References: <20250613134208.1509436-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x42c.google.com
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


