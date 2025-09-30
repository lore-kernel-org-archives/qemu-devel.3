Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E6ECCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 11:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3YzL-0000XN-2A; Tue, 30 Sep 2025 07:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1v3YzJ-0000W0-2o
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:57:45 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1v3Yz6-0001cl-CG
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:57:44 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so58865955e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 04:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1759233443; x=1759838243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQ/Lu1tU0Qj8neKJhLVxbk1XtF5ADWgaXLTN2vtV7aE=;
 b=AEYN+TLRvfosz07MDxCt48nbUAvlybAf/EZpVuPqPdGweNAs5MJqUFJHQ2TpDfX9o9
 IS6lBwTyVzqUAjYqAy0MRedwfpm5/FddetKt6hTRaVN2R1DKEc+IjV6qlypaBWtl4qfE
 y16bP0OGUNlrhIUuycMl0Wthws2CM7Gt/nYMSx9ktGhzYFCoUSML9/bIczoTQbQa27Bg
 vVqwTZ6y78VYlo7vqI329LVMkzQhBlcz3VAptF41y+Nt6kR+UoQqG/0lP08nVQmjpevR
 vEIfTWA3ON8yNP3aQnTZ/9eIzxPrDcWmx2YIx/q54rU56z3OGGkU2804d7SmjRB+FTZn
 jhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759233443; x=1759838243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQ/Lu1tU0Qj8neKJhLVxbk1XtF5ADWgaXLTN2vtV7aE=;
 b=REmPQ+oISVhHWB2Aj0Wb4Yd0MnDopWekV2xekar/hoY6lezQ8UwL5dOn9BjPP4lOgI
 UslydptAErkBGTKyyloFBsze0ar3MR9LRBiXxUHMCPU+BrGEAU/YYisobc64jNBOqBRx
 7oC/iDDBFdPdMcKf5MsP4UIty108TfX4xXgWguba/Ssb54PpMWGGukzuZpKA4dfQnROL
 w0WX4XzdIReFdJlg3YEMCDdnQoCLXi13xbILY59NSiOyjz4KYue7ZKh0IU0HdtIfuwQr
 YyekDibmluljWQ3bZzAA40IHv3XJJtYu7CDI27TgnPh2Ucu7s52xkaCVrls0pvhCctrR
 XHQQ==
X-Gm-Message-State: AOJu0YwpFZuTSQz+yx6SK3fJxw8uIWvYE/h+aQJS0QyJXBVV6DCeJUlu
 zDwFWmA/15euL0a7ciopljYPmnsa12zJdm0q1T6zNn0bL9/o5+J7TcB8LGll/4j4WAlHxOuDLiy
 xlck=
X-Gm-Gg: ASbGncv76mydqQT+lr5unzCa8OdwHih4+Kx+EeURym7P6Viqf31xQ5yQOeNeFSiJepm
 tFcWbtLNcR6kJgFC5GldMUA1Jl02oBu9he/eKLkc7S6ZFpGTQg2RgLWFS45ZH6220qNAnCXnjBs
 V0By5GffeqdS/emgGjYMzBeP/KFnGfSYbc4m6gJvFd0eh8zhya+kOZiC+Zr8RDqDLSrgBb81Bb6
 /1UcIRCgYcNK3xVh8O93gcw96sMrTFXSuSfAtfDaKTPm2hCg2txS+99NpXNJ3j4dWrk+E19SguH
 cTiGCHncljQzIgWXUa1PGndc64wqssgffEcJbhXRzr/+DozcqYnyORDZ+qZNWQJcKbG7Yw3v/IB
 EDTGdziP2cvFoWQBE2jIqlbJQPcZrrMZU7fF1LuxolrjKYr3jK/CqAB1DwkQDZoN5h3bKPiShvi
 xXKIVFyCAGfm7CVPTU6udit1QqdKLMbqrTc4wcWQXi1e3THplWzGUvnw==
X-Google-Smtp-Source: AGHT+IG/o6++1RyXT7Ee5lkCnQkJZgJv4zu0CSyFTKl+NcO1JIu9cFeylxTJqGSajEStQeuySNqq3Q==
X-Received: by 2002:a05:6000:654:b0:411:3c14:3a97 with SMTP id
 ffacd0b85a97d-4113c238757mr14851466f8f.51.1759233443282; 
 Tue, 30 Sep 2025 04:57:23 -0700 (PDT)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc7d3780asm22448289f8f.52.2025.09.30.04.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 04:57:22 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me, Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH 3/3] hw/arm/xlnx-zynqmp: wire a second GIC for the Cortex-R5
Date: Tue, 30 Sep 2025 13:57:18 +0200
Message-Id: <20250930115718.437100-4-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930115718.437100-1-chigot@adacore.com>
References: <20250930115718.437100-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x330.google.com
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
 hw/arm/xlnx-zynqmp.c         | 77 +++++++++++++++++++++++++++++++++++-
 include/hw/arm/xlnx-zynqmp.h |  4 ++
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 3d8c46986e..ffed6e5126 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -384,6 +384,7 @@ static void xlnx_zynqmp_init(Object *obj)
     XlnxZynqMPState *s = XLNX_ZYNQMP(obj);
     int i;
     int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
+    int num_rpus = xlnx_zynqmp_get_rpu_number(ms);
 
     object_initialize_child(obj, "apu-cluster", &s->apu_cluster,
                             TYPE_CPU_CLUSTER);
@@ -397,6 +398,12 @@ static void xlnx_zynqmp_init(Object *obj)
 
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
@@ -446,6 +453,15 @@ static void xlnx_zynqmp_init(Object *obj)
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
@@ -459,6 +475,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     uint8_t i;
     uint64_t ram_size;
     int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
+    int num_rpus = xlnx_zynqmp_get_rpu_number(ms);
     const char *boot_cpu = s->boot_cpu ? s->boot_cpu : "apu-cpu[0]";
     ram_addr_t ddr_low_size, ddr_high_size;
     qemu_irq gic_spi[XLNX_ZYNQMP_GIC_NUM_SPI_INTR];
@@ -517,6 +534,14 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
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
@@ -616,13 +641,63 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
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
 
     for (i = 0; i < XLNX_ZYNQMP_GIC_NUM_SPI_INTR; i++) {
-        gic_spi[i] = qdev_get_gpio_in(DEVICE(&s->gic), i);
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
index 6a407c2962..a3117bd6c5 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -42,6 +42,7 @@
 #include "hw/misc/xlnx-zynqmp-crf.h"
 #include "hw/timer/cadence_ttc.h"
 #include "hw/usb/hcd-dwc3.h"
+#include "hw/core/split-irq.h"
 
 #define TYPE_XLNX_ZYNQMP "xlnx-zynqmp"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPState, XLNX_ZYNQMP)
@@ -106,6 +107,9 @@ struct XlnxZynqMPState {
     GICState gic;
     MemoryRegion gic_mr[XLNX_ZYNQMP_GIC_REGIONS][XLNX_ZYNQMP_GIC_ALIASES];
 
+    GICState rpu_gic;
+    SplitIRQ splitter[XLNX_ZYNQMP_GIC_NUM_SPI_INTR];
+
     MemoryRegion ocm_ram[XLNX_ZYNQMP_NUM_OCM_BANKS];
 
     MemoryRegion *ddr_ram;
-- 
2.34.1


