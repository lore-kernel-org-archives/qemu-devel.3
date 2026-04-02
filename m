Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE940D6AB10
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q39-0000mP-72; Thu, 02 Apr 2026 17:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2Z-00006b-N7
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:27 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2X-0007DT-5v
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:27 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b932fe2e1a7so166753666b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167043; x=1775771843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OrGB8OQ0EB2XgRXWdV+EvwzSnNtuQZ55Vl1tvmUmW2w=;
 b=auKtuA1m89lxeUAXqyr9HRG/sIzSEzahQDBUAIHo8U3dmj3PpMwzs2T9YmSpe2Zllv
 wpCMyjm5SlNsYs0G4dk+T00oqJ94CnMXqxF3OnL/nBvXMwL0M82/qtmbzKn/23U8WQAp
 JltBLkVQmhPiu86mfXT7P+vjMNiNqgc1hkaEHBD3LR54z01llZzugTBnNI+wZ7WzLKgy
 wXapKxXalUI14DuHqm0jZEihwPR/fIbyHYCLOKfz5FYAlDmSOVEmxxMwgWUIgrbWeRyw
 yeDgn1d1ynUMJlb9hh3sUrLNa0ZQBQLRQEWlPr+9b73ZHS5NgI2zD662Kgt1PbzMOOr7
 hvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167043; x=1775771843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OrGB8OQ0EB2XgRXWdV+EvwzSnNtuQZ55Vl1tvmUmW2w=;
 b=oBkF3kn2qwgHfjDbgvqiAhub18p/c5+2uGHUBJe/7uKSdR+SyAR56RjZw+1O88GuQu
 PWA90Wo6svdxzpx07lCtvLKX8NSWZ77Gg2ipWrQR0rZPWXEGWje4EMLs8dZil8y8aLao
 u+2fnBBNlTNl/4cmAOBX+3AXanUSJzdoy71tkXlSGXEWE5Guz8BsSl+wh9J2OWVgTqF+
 F0K7t9S+USP2QDRx/UFvLZK9gd4xSR2IapwIUleVY8If/k0e6hM2DT62Bh562D8G/8Hi
 qStCV/zUtm4QqgCzPDr6jXtvMCI/lxHfsnsJd4nuzWYqV1yGEMxXe7jsZ2s5bhJN1JwD
 yZUg==
X-Gm-Message-State: AOJu0Ywvo/LkqwpuZxLHuIntW253G9J8Wu5ma/vNqGOHNOHCsmLbTJvF
 XKn0uVzbeNTxKZAj6mcvEyXPBvhpOOnaPB8harvgffug0X7AfFQnd8ynoqb7t4T7
X-Gm-Gg: ATEYQzw43PfmNOeRcIQrWgbSnaJj2C1WhmIvpRRxx4rrSXI3lDjE8ZXapjHBn3w5/LQ
 JZpJ9QDgqCzBHeVVyQYJgwJByRKjPvoDCBalWNZIEz3XD4VD+Spq6+8HLL7G1rpsg+i14xioKmj
 8gc7pos3elBO6WxrQVd7cMo9fCZJ5Ld9G7vrDxP22YrTaV/mhT1HsMY5hjXD3SBfkQ5pzNLRexY
 nd9hQvmEs+I4Vlc3z2ivridUQXqsiGmW23NmBnR7fIJUmEO86AoRk5sEDLzfsHLxsDIClxE9v1f
 9cYgcaT5QAo9a8+MBiULcioOaln8euO82ZPd/27WA+I8CDsxmPQr5XIg3pXUg96JV+2JVy/d4Db
 jyqObS9zCRk/GdPos/EyASXC3Kdh+0r6aoRMLuejT3FhgwtaB7GEHhvUkm3HM0jtbzqu3oaFFLE
 oldDP2oJYI7A930hSaTRzxVUJLisNbshI68L0r/LORTDRvkG9LeKnvgcUCn+5fX+R7PVikHQ==
X-Received: by 2002:a17:907:3e9f:b0:b96:e3db:9e04 with SMTP id
 a640c23a62f3a-b9c67b5fd34mr24482966b.53.1775167042926; 
 Thu, 02 Apr 2026 14:57:22 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:57:22 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v3 23/33] hw/intc/arm_gic: implement FDT_GENERIC_INTC and fdt
 support
Date: Thu,  2 Apr 2026 23:56:08 +0200
Message-ID: <20260402215629.745866-24-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

The patch implements TYPE_FDT_GENERIC_INTC interface, which
enables GIC to be instantiated and wired via the device tree
description.

The implemented interface method are following:
1. 'get_irq': Parses device tree interrupt specifiers
and return correct qemu_irq for devices which has IRQ's wired
to GIC.
2. 'auto_parent': Automatically connect the GIC's output signals
to the CPU's found in current machine configuration.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/intc/arm_gic.c        | 32 +++++++++++++++++++++++++
 hw/intc/arm_gic_common.c | 50 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 4d4b79e6f3..bbe9409ef3 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -24,12 +24,15 @@
 #include "gic_internal.h"
 #include "qapi/error.h"
 #include "hw/core/cpu.h"
+#include "hw/core/boards.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "trace.h"
 #include "system/kvm.h"
 #include "system/qtest.h"
 
+#include "hw/core/fdt_generic_util.h"
+
 /* #define DEBUG_GIC */
 
 #ifdef DEBUG_GIC
@@ -2162,12 +2165,41 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
 
 }
 
+static void arm_gic_fdt_auto_parent(FDTGenericIntc *obj, Error **errp)
+{
+    GICState *s = ARM_GIC(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    int num_cpus = s->num_cpu;
+    CPUState *cs;
+    int i = 0;
+
+    for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
+        if (i >= s->num_cpu) {
+            break;
+        }
+
+        sysbus_connect_irq(sbd, i,
+                           qdev_get_gpio_in(DEVICE(cs), 0));
+        sysbus_connect_irq(sbd, i + num_cpus,
+                           qdev_get_gpio_in(DEVICE(cs), 1));
+        sysbus_connect_irq(sbd, i + 2 * num_cpus,
+                           qdev_get_gpio_in(DEVICE(cs), 2));
+        sysbus_connect_irq(sbd, i + 3 * num_cpus,
+                           qdev_get_gpio_in(DEVICE(cs), 3));
+        i++;
+    }
+
+    /* FIXME: Add some error checking */
+}
+
 static void arm_gic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ARMGICClass *agc = ARM_GIC_CLASS(klass);
+    FDTGenericIntcClass *fgic = FDT_GENERIC_INTC_CLASS(klass);
 
     device_class_set_parent_realize(dc, arm_gic_realize, &agc->parent_realize);
+    fgic->auto_parent = arm_gic_fdt_auto_parent;
 }
 
 static const TypeInfo arm_gic_info = {
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 304d89cf56..04787cff79 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -28,6 +28,8 @@
 #include "migration/vmstate.h"
 #include "system/kvm.h"
 
+#include "hw/core/fdt_generic_util.h"
+
 static int gic_pre_save(void *opaque)
 {
     GICState *s = (GICState *)opaque;
@@ -348,6 +350,51 @@ static void arm_gic_common_linux_init(ARMLinuxBootIf *obj,
     }
 }
 
+static int arm_gic_common_fdt_get_irq(FDTGenericIntc *obj, qemu_irq *irqs,
+                                      uint32_t *cells, int ncells, int max,
+                                      Error **errp)
+{
+    GICState *gs = ARM_GIC_COMMON(obj);
+    int cpu = 0;
+    uint32_t idx;
+
+    if (ncells != 3) {
+        error_setg(errp, "ARM GIC requires 3 interrupt cells, %d cells given",
+                   ncells);
+        return 0;
+    }
+    idx = cells[1];
+
+    switch (cells[0]) {
+    case 0:
+        if (idx >= gs->num_irq) {
+            error_setg(errp, "ARM GIC SPI has maximum index of %" PRId32 ", "
+                       "index %" PRId32 " given", gs->num_irq - 1, idx);
+            return 0;
+        }
+        (*irqs) = qdev_get_gpio_in(DEVICE(obj), cells[1]);
+        return 1;
+    case 1: /* PPI */
+        if (idx >= 16) {
+            error_setg(errp, "ARM GIC PPI has maximum index of 15, "
+                       "index %" PRId32 " given", idx);
+            return 0;
+        }
+        for (cpu = 0; cpu < max && cpu < gs->num_cpu; cpu++) {
+            if (cells[2] & 1 << (cpu + 8)) {
+                *irqs = qdev_get_gpio_in(DEVICE(obj),
+                                         gs->num_irq - 16 + idx + cpu * 32);
+            }
+            irqs++;
+        }
+        return cpu;
+    default:
+        error_setg(errp, "Invalid cell 0 value in interrupt binding: %d",
+                   cells[0]);
+        return 0;
+    }
+}
+
 static const Property arm_gic_common_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", GICState, num_cpu, 1),
     DEFINE_PROP_UINT32("first-cpu-index", GICState, first_cpu_index, 0),
@@ -368,12 +415,14 @@ static void arm_gic_common_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     ARMLinuxBootIfClass *albifc = ARM_LINUX_BOOT_IF_CLASS(klass);
+    FDTGenericIntcClass *fgic = FDT_GENERIC_INTC_CLASS(klass);
 
     rc->phases.hold = arm_gic_common_reset_hold;
     dc->realize = arm_gic_common_realize;
     device_class_set_props(dc, arm_gic_common_properties);
     dc->vmsd = &vmstate_gic;
     albifc->arm_linux_init = arm_gic_common_linux_init;
+    fgic->get_irq = arm_gic_common_fdt_get_irq;
 }
 
 static const TypeInfo arm_gic_common_type = {
@@ -385,6 +434,7 @@ static const TypeInfo arm_gic_common_type = {
     .abstract = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_ARM_LINUX_BOOT_IF },
+        { TYPE_FDT_GENERIC_INTC },
         { },
     },
 };
-- 
2.43.0


