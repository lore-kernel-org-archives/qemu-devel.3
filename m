Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4397DC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 08:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTct-0004fG-6w; Mon, 26 May 2025 04:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uJTcM-0004Sc-P7
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:55:34 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uJTcJ-000833-MH
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:55:34 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a4c95fc276so2494125f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 01:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1748249730; x=1748854530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3t/nIVRg+2jwmgdqscl/THpDb4n/5JCjlQr5Qe7fL8=;
 b=bExemGrAnOFexR3z7i9089Xmf3pgSTwyX1xjY4cZrnw161zJ11RIZhci32CHxAn3aa
 O8Uc81I14YsHHPAKW27orSsbtYPq0ZXgD/0uscsOgbeQ3TFC3UWyPonCpPYftTgNI004
 2MpOKLn4eSlZdpV+teuvp2rEfqm9sloTUU9t6dtxlaTMiAHYbGEPboGMoU3tG8H0KtL+
 +MuDDp5M+nJzjxmw1dqqA00Or/z0ltutDmAPUFapCyyPfCa8JWOtBjqR6NY20fGPuXdz
 KtXZr8gcx5EBlLu2WecxWXakQZ4R7tDM/0yxACwJJ28/niTEqYbCH2hL5tPFW7F/eeH5
 5TEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748249730; x=1748854530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e3t/nIVRg+2jwmgdqscl/THpDb4n/5JCjlQr5Qe7fL8=;
 b=ijQ4hlOvb6MYwGJRrFhFUThfC9eXluNpHFLtCsRIIduq57ROBO0MOtB8OgeHH4V5yE
 Qex6vCAG90IxdrJMiKiBO+HJj+FDRcHiuGOG10InsGUsyKYHDOFTJ1khPZPSC/uWBVoc
 xfwcyD2CprVcQQM7R47Nn1btB/PVWW8HQIK/rMk4zumPhOXQFBhh8uaqlwXABEYhXsE0
 zatxO1+Fz1Ukq/C1nsNkPMcYp6ibrmfv9NxMhpf9p6dvEf3NJgUKlQ6FMe5CiotRbO5w
 sGYF1mDxTuND3PCAtSaS+ydRVTVQrKoJQr7SWVzujYk8HaYIAOeO2HXViRgnfgpBwUG3
 MFPw==
X-Gm-Message-State: AOJu0Yyu5I+Yw13VeeLzzA4jRY+HM1XFweXT/wWxJvfunclTEzhVLj/x
 T5kt+Z34MyF54ZoeVcV1DUfJ4LtsDZDuLmTf/FEe4qJzBh8p2bwxZ3WbEnBuOY6q5eRgPvtIdKz
 LI/U=
X-Gm-Gg: ASbGncsjKVgrCaOo6+fxR0UZ6Jvzj2+nZe2zVT7sP4O7NGJ3hjfRLi6erxrRGOCTbFT
 dKzowfQjuZw7r+wFXGZVk1gS+uWCSBMqD+NjOKSHuCxf8lJw0cWawvB23Ueqn0s7HE0TtxiY7T7
 Oz66AE5HAIo8oK2HLn181ORyqGWQiHm5z10zZ9SNCC4MkRkZQt+FZZZee9Uf3czxzk8vx+cOUcN
 S7oacWRLaxrBWchVQsEETm96wgO5czAquNRJCend7ORIkAHnPuVY0zVW+FhWI8ZRdAU9UFPSen9
 oS/TYrv1zrOU8bkYPFQRUo7ozoKBglEvrim0ABpbhlT15wwl20E+0IDbVt/QCILUm46cKOgwdkV
 5BufWVLhfkDx/ElDWxYk117/KD8NXmvr7dfeJEfDfHyn62RZf
X-Google-Smtp-Source: AGHT+IG3eYM8ICaA6k3WKFy9YPDL5ZlZUoKeLyF/f0Nfw/lAOJyyqmHsgAvw9qdZUHFXdZoqZgsYFw==
X-Received: by 2002:a05:6000:18ad:b0:3a4:d994:be4b with SMTP id
 ffacd0b85a97d-3a4d994bfa2mr1899831f8f.1.1748249729777; 
 Mon, 26 May 2025 01:55:29 -0700 (PDT)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f23bfd54sm238911675e9.17.2025.05.26.01.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 01:55:29 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me, Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v2 3/4] hw/arm/xlnx-zynqmp: wire a second GIC for the Cortex-R5
Date: Mon, 26 May 2025 10:55:22 +0200
Message-Id: <20250526085523.809003-4-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526085523.809003-1-chigot@adacore.com>
References: <20250526085523.809003-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x42e.google.com
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
 hw/arm/xlnx-zynqmp.c         | 88 +++++++++++++++++++++++++++++++++---
 include/hw/arm/xlnx-zynqmp.h |  6 +++
 2 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index ec96a46eec..be33669f87 100644
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
@@ -206,7 +204,7 @@ static const XlnxZynqMPGICRegion xlnx_zynqmp_gic_regions[] = {
 
 static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
 {
-    return GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;
+    return XLXN_ZYNQMP_GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;
 }
 
 static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
@@ -377,6 +375,8 @@ static void xlnx_zynqmp_init(Object *obj)
     XlnxZynqMPState *s = XLNX_ZYNQMP(obj);
     int i;
     int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
+    int num_rpus = MIN((int)(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS),
+                       XLNX_ZYNQMP_NUM_RPU_CPUS);
 
     object_initialize_child(obj, "apu-cluster", &s->apu_cluster,
                             TYPE_CPU_CLUSTER);
@@ -390,6 +390,12 @@ static void xlnx_zynqmp_init(Object *obj)
 
     object_initialize_child(obj, "gic", &s->gic, gic_class_name());
 
+    if (num_rpus > 0) {
+        /* Do not create the rpu_gic in case we don't have rpus..  */
+        object_initialize_child(obj, "rpu_gic", &s->rpu_gic,
+                                gic_class_name());
+    }
+
     for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
         object_initialize_child(obj, "gem[*]", &s->gem[i], TYPE_CADENCE_GEM);
         object_initialize_child(obj, "gem-irq-orgate[*]",
@@ -439,6 +445,13 @@ static void xlnx_zynqmp_init(Object *obj)
     object_initialize_child(obj, "qspi-irq-orgate",
                             &s->qspi_irq_orgate, TYPE_OR_IRQ);
 
+    for (i = 0; i < ARRAY_SIZE(s->splitter); i++) {
+        g_autofree char *name = g_strdup_printf("irq-splitter%d", i);
+        object_initialize_child(obj, name, &s->splitter[i], TYPE_SPLIT_IRQ);
+    }
+
+
+
     for (i = 0; i < XLNX_ZYNQMP_NUM_USB; i++) {
         object_initialize_child(obj, "usb[*]", &s->usb[i], TYPE_USB_DWC3);
     }
@@ -452,10 +465,13 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     uint8_t i;
     uint64_t ram_size;
     int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
+    int num_rpus = MIN((int)(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS),
+                       XLNX_ZYNQMP_NUM_RPU_CPUS);
     const char *boot_cpu = s->boot_cpu ? s->boot_cpu : "apu-cpu[0]";
     ram_addr_t ddr_low_size, ddr_high_size;
-    qemu_irq gic_spi[GIC_NUM_SPI_INTR];
+    qemu_irq gic_spi[XLXN_ZYNQMP_GIC_NUM_SPI_INTR];
     Error *err = NULL;
+    DeviceState *splitter;
 
     ram_size = memory_region_size(s->ddr_ram);
 
@@ -502,13 +518,21 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         g_free(ocm_name);
     }
 
-    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", GIC_NUM_SPI_INTR + 32);
+    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", XLXN_ZYNQMP_GIC_NUM_SPI_INTR + 32);
     qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
     qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", num_apus);
     qdev_prop_set_bit(DEVICE(&s->gic), "has-security-extensions", s->secure);
     qdev_prop_set_bit(DEVICE(&s->gic),
                       "has-virtualization-extensions", s->virt);
 
+    if (num_rpus > 0) {
+        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "num-irq",
+                             XLXN_ZYNQMP_GIC_NUM_SPI_INTR + 32);
+        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "revision", 1);
+        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "num-cpu", num_rpus);
+        qdev_prop_set_uint32(DEVICE(&s->rpu_gic), "first-cpu-index", 4);
+    }
+
     qdev_realize(DEVICE(&s->apu_cluster), NULL, &error_fatal);
 
     /* Realize APUs before realizing the GIC. KVM requires this.  */
@@ -608,13 +632,63 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (num_rpus > 0) {
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
+    for (i = 0; i < XLXN_ZYNQMP_GIC_NUM_SPI_INTR; i++) {
+        splitter = DEVICE(&s->splitter[i]);
+        qdev_prop_set_uint16(splitter, "num-lines", 2);
+        qdev_realize(splitter, NULL, &error_abort);
+        if (num_rpus > 0) {
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
index c137ac59e8..a69953650d 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -42,6 +42,7 @@
 #include "hw/misc/xlnx-zynqmp-crf.h"
 #include "hw/timer/cadence_ttc.h"
 #include "hw/usb/hcd-dwc3.h"
+#include "hw/core/split-irq.h"
 
 #define TYPE_XLNX_ZYNQMP "xlnx-zynqmp"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPState, XLNX_ZYNQMP)
@@ -87,12 +88,14 @@ OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPState, XLNX_ZYNQMP)
                                   XLNX_ZYNQMP_MAX_HIGH_RAM_SIZE)
 
 #define XLNX_ZYNQMP_NUM_TTC 4
+#define XLXN_ZYNQMP_GIC_NUM_SPI_INTR 160
 
 /*
  * Unimplemented mmio regions needed to boot some images.
  */
 #define XLNX_ZYNQMP_NUM_UNIMP_AREAS 1
 
+
 struct XlnxZynqMPState {
     /*< private >*/
     DeviceState parent_obj;
@@ -105,6 +108,9 @@ struct XlnxZynqMPState {
     GICState gic;
     MemoryRegion gic_mr[XLNX_ZYNQMP_GIC_REGIONS][XLNX_ZYNQMP_GIC_ALIASES];
 
+    GICState rpu_gic;
+    SplitIRQ splitter[XLXN_ZYNQMP_GIC_NUM_SPI_INTR];
+
     MemoryRegion ocm_ram[XLNX_ZYNQMP_NUM_OCM_BANKS];
 
     MemoryRegion *ddr_ram;
-- 
2.34.1


