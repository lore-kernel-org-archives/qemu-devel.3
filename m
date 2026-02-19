Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5F4E9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt5MN-000456-Vj; Thu, 19 Feb 2026 09:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5MC-0003uy-P5
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:50:22 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5M6-00085L-Eh
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:50:19 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso9434375e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771512594; x=1772117394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8jISgrMRUU7GJEHRBKA1C6CwoQWVbq4rD3s2gB8p7Y=;
 b=JZp5ExZiWw+7p+F5STRP7lRL0TJz14IyH61HlyxfkGpB7G17aqv7DecrsBzpXNNJOo
 tTNiWyxQiyXh8DXk3a+t+man0mlKNx+5f+XFAVbY6faN1fmEuLvaK4LaENIRztAVjskF
 QyNfssUJbN9dgABIfJXpFt9P7eQk7CNs6QQWhiTx09hmttzEYx89ITGz8pI9rWeOq2Cq
 fRTTB9QxGETmXaMdLhg66M+UTN3e4BZH2e70F1EGN/4vytm9XCLp3kXRY7tU9Q99JurK
 awiU6PBhG20dH/Kast4FkQXDhnVqGasmnH17i1a3bANXj34czkX0RBUcvOogGHoJoOLD
 pijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771512594; x=1772117394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S8jISgrMRUU7GJEHRBKA1C6CwoQWVbq4rD3s2gB8p7Y=;
 b=DHI09ZnFnLd5qLUYOMshj9yJfGUBgT12+EMsUcQ9oowd1+g2OYzZSYYvenIeC+c7Y2
 g5MCpojYs0+hD2tcDgdnqFgVJ500B3GtF8NGKtMMdtuVT4d2YepI1TEzIZ7/y2Gj8Els
 Xu1wP9aXtr3bhYqAXM7j6PTsFEiky7qmiXjDwjt6yAAb4P2XhXYSOEyIxAO+qLP0+HCm
 ixSMEgYBATExp34X/XqaT348UvgSP2nmc+O2gI7iI7tE/oDKwKPZlSNUMEMDvBEiv3pp
 /dIz3Uaat/scLhvfB8wckqInsnv9AP92UCWmHNDqi4bFpbYHOn7priiHqERG0P5wdcCQ
 3b3A==
X-Gm-Message-State: AOJu0YwuAJkR+mJfC+NB/NgXdXvano2YH99UV1FUQWkRJnk7/KPhS83W
 oUYc1sGKFgBqjCt2+2yFVahyUP/UA+fgDdGJjJj1z25O/YEpud1qEJlyXD5FpcMt
X-Gm-Gg: AZuq6aLVFOGhgO/9oLJ05QFNelaenZUxMw7ieWAKc+teAz1MzGO0+GeN23XCsJAfulR
 E4pFzrx1/tVlXO5y3YcmB9duCcha0NA43tm+2t091qUAVpE4os3O0x9k2CompU/rELzNnWtAOVu
 lMNb/YmstITFHvPJABMLHTBBNuzYfO1KUj60360sBGiCoKMfMdzIQWBxS2o5fV5Ikz8nvMKnIKI
 L81SjElw2BhhJZD0Djd976+CJpKmm4dPKSLO/GZpdJJb4reWtt//o8zCUyUT2ulj2fIctExGkCq
 unJtYm8yD8gbjT9XYKxBPxpdvOzaoW0tOJh7NN7xEgA/Z5zYZ5hPqYsGNmjAx4Uadz/gN2Gr/Xn
 t4kk8NSKn1qAyb6Bw1l03MM9shNh9NXfHVXXa8MxvfnDVagRX254xCqJRwb5cMJ7YYhBjWkoYQI
 GbG7jlc++mRrS+ftr4eubrqouqHzm8gMjiS7tUMkOp99on8UZT6ef2UMuPvoKZAW6sbhgT
X-Received: by 2002:a05:600c:1f92:b0:47d:25ac:3a94 with SMTP id
 5b1f17b1804b1-48379bfd727mr298943275e9.17.1771512594118; 
 Thu, 19 Feb 2026 06:49:54 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm50163087f8f.31.2026.02.19.06.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:49:53 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v2 29/33] hw/intc/arm_gicv3: Implement FDTGenericIntc interface
Date: Thu, 19 Feb 2026 15:48:57 +0100
Message-ID: <20260219144901.3317747-11-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219144901.3317747-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
 <20260219144901.3317747-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x32f.google.com
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

This patch implements the FDTGenericIntc interface for the
ARM GICv3 interrupt controller.

This enables the generic FDT machine infrastructure to
automatically wire up the GIC and resolve interrupts
defined in the Device Tree.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/intc/arm_gicv3.c        | 45 +++++++++++++++++++++++++
 hw/intc/arm_gicv3_common.c | 68 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 542f81ea49..e7e98ef9a5 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -18,9 +18,13 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "hw/core/cpu.h"
+#include "hw/core/boards.h"
 #include "hw/intc/arm_gicv3.h"
 #include "gicv3_internal.h"
 
+#include "hw/core/fdt_generic_util.h"
+
 static bool irqbetter(GICv3CPUState *cs, int irq, uint8_t prio, bool nmi)
 {
     /* Return true if this IRQ at this priority should take
@@ -452,14 +456,55 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
     gicv3_init_cpuif(s);
 }
 
+static void arm_gic_fdt_auto_parent(FDTGenericIntc *obj, Error **errp)
+{
+    GICv3State *s = ARM_GICV3(obj);
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
+        sysbus_connect_irq(sbd, i + 4 * num_cpus,
+                           qdev_get_gpio_in(DEVICE(cs), 4));
+        sysbus_connect_irq(sbd, i + 5 * num_cpus,
+                           qdev_get_gpio_in(DEVICE(cs), 5));
+
+        if (s->maint_irq) {
+            int intbase = s->num_irq - GIC_INTERNAL + i * GIC_INTERNAL;
+            qemu_irq irq = qdev_get_gpio_in(DEVICE(sbd),
+                                intbase + s->maint_irq);
+            qdev_connect_gpio_out_named(DEVICE(cs),
+                                               "gicv3-maintenance-interrupt",
+                                                0, irq);
+        }
+
+        i++;
+    }
+}
+
 static void arm_gicv3_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ARMGICv3CommonClass *agcc = ARM_GICV3_COMMON_CLASS(klass);
     ARMGICv3Class *agc = ARM_GICV3_CLASS(klass);
+    FDTGenericIntcClass *fgic = FDT_GENERIC_INTC_CLASS(klass);
 
     agcc->post_load = arm_gicv3_post_load;
     device_class_set_parent_realize(dc, arm_gic_realize, &agc->parent_realize);
+    fgic->auto_parent = arm_gic_fdt_auto_parent;
 }
 
 static const TypeInfo arm_gicv3_info = {
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 9200671c7a..a393540825 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -34,6 +34,7 @@
 #include "system/kvm.h"
 #include "system/whpx.h"
 
+#include "hw/core/fdt_generic_util.h"
 
 static void gicv3_gicd_no_migration_shift_bug_post_load(GICv3State *cs)
 {
@@ -367,6 +368,69 @@ void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
     }
 }
 
+#define FDT_GENERIC_GICV3_TYPE_AFFINITY_ALL 0x01000000U
+#define FDT_GENERIC_GICV3_TYPE_AFFINITY_IDX 0x02000000U
+
+static int arm_gicv3_common_fdt_get_irq(FDTGenericIntc *obj, qemu_irq *irqs,
+                                      uint32_t *cells, int ncells, int max,
+                                      Error **errp)
+{
+    GICv3State *gs = ARM_GICV3_COMMON(obj);
+    int cpu = 0;
+    uint32_t qemu_type;
+    uint32_t cpu_mask;
+    uint32_t idx;
+
+    if (ncells != 3) {
+        error_setg(errp, "ARM GIC requires 3 interrupt cells, %d cells given",
+                   ncells);
+        return 0;
+    }
+    idx = cells[1];
+    qemu_type = cells[0] & 0xff000000;
+
+    switch (cells[0] & 0x00ffffff) {
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
+        if (qemu_type == FDT_GENERIC_GICV3_TYPE_AFFINITY_IDX) {
+            cpu = cells[2] >> 8;
+            *irqs = qdev_get_gpio_in(DEVICE(obj),
+                                         gs->num_irq - 16 + idx + cpu * 32);
+            return cpu;
+        }
+
+        cpu_mask = cells[2] >> 8;
+        while ((cpu_mask || qemu_type == FDT_GENERIC_GICV3_TYPE_AFFINITY_ALL)
+               && cpu < max && cpu < gs->num_cpu) {
+            if ((cpu_mask & 1) ||
+                 qemu_type == FDT_GENERIC_GICV3_TYPE_AFFINITY_ALL) {
+                *irqs = qdev_get_gpio_in(DEVICE(obj),
+                                         gs->num_irq - 16 + idx + cpu * 32);
+                irqs++;
+            }
+            cpu_mask >>= 1;
+            cpu++;
+        }
+        return cpu;
+    default:
+        error_setg(errp, "Invalid cell 0 value in interrupt binding: %d",
+                   cells[0]);
+        return 0;
+    }
+}
+
 static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
 {
     GICv3State *s = ARM_GICV3_COMMON(dev);
@@ -624,12 +688,15 @@ static void arm_gicv3_common_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     ARMLinuxBootIfClass *albifc = ARM_LINUX_BOOT_IF_CLASS(klass);
+    FDTGenericIntcClass *fgic = FDT_GENERIC_INTC_CLASS(klass);
+
 
     rc->phases.hold = arm_gicv3_common_reset_hold;
     dc->realize = arm_gicv3_common_realize;
     device_class_set_props(dc, arm_gicv3_common_properties);
     dc->vmsd = &vmstate_gicv3;
     albifc->arm_linux_init = arm_gic_common_linux_init;
+    fgic->get_irq = arm_gicv3_common_fdt_get_irq;
 }
 
 static const TypeInfo arm_gicv3_common_type = {
@@ -641,6 +708,7 @@ static const TypeInfo arm_gicv3_common_type = {
     .abstract = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_ARM_LINUX_BOOT_IF },
+        { TYPE_FDT_GENERIC_INTC },
         { },
     },
 };
-- 
2.43.0


