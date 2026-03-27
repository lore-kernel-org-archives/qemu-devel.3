Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08C910ED65C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Dp-0001hC-1W; Fri, 27 Mar 2026 07:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CV-0007Tr-Jf
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:18:05 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CT-00008s-9g
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:18:02 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43b5bded412so1432804f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610277; x=1775215077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NrTKpprv3zreT1hOn+OhcK5Z8pr1JULBMiSX0Lhf8qo=;
 b=U3nCnWRKW3kq8bx7ryJoOUxa9S/K5or52bNiDk6ns/8jR7zZ1+WF4/8ISAm1yBDc3v
 +590L9kP8nHRAWHP+ColAoo4q6oL4TMVqRYOnfzLq6V5x5HPfdCNGZI7XC+lIym0Uew6
 /P9BjkLrLn9zWiJzBVm4/M3ijD6tGhBXnevyJGgYgT4ufPX/xVqI5QxOL9MpALfhQmR+
 Rt1+Z3a/sdRzYGq9I4bysvchO1U7n8HqKllilhtm1fQiIIg6MsoE2fKN1w3EbJxH0vcC
 AyI6SFlMguVLVANlwsF36+8ZhoLmKZZz7qKctbDxSsxTkThXb0R2J4lwUJ1x1OS60wvw
 FH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610277; x=1775215077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NrTKpprv3zreT1hOn+OhcK5Z8pr1JULBMiSX0Lhf8qo=;
 b=Uw1uMFD5LIxuE5/AUBrvXRTEuFgmnCKTPwXZ1vWcozcWxWW5KokMOeev4ZRy5aRUtK
 WzXTQdHqUqzualacDxSX541nZaIfZ1sUDOOIGcdVWV10OqULkMamvWHcENaE3JbqqVzk
 5e4GwFWRRVED8ou3BNSOCfKAhWC8NYifKLLo018pl+hDXmkiHsBS1qrHTAYF9sNOGZtk
 u8DTPIMW9+YDcx28TYGeZNFQskOAw8csXV/8YNn8qKytZLF7NZLG1raD34j/eqrxGGqY
 sVysfa9ZChVibK3OkbizV7ZgPs58DPxpHdTBHEKR0CmomBg/jNtOnA6JN0KK0vEkOWhT
 v3mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYvyM0tjqi+mJcWUilG9OoHoqy8hDvbNqQSbPN+bA5q4OAOuEZTfsULeEksA9yvh4BLsoCE+8Z/i5E@nongnu.org
X-Gm-Message-State: AOJu0YwMCJeexTiW0iYHUXuSc0eNnD0avpw5PYQahXrGGZwqXTnYnnmF
 GoSjWK3SfR+znjm9q9cEXBJfDbiZrDwmhPzhCTsSnws1IwpDRgDbXAte0QSna2+01T4=
X-Gm-Gg: ATEYQzzCP9rnMreJFQ2lZBqJHMJWEgpCeJZKgHApwiYaPNVlNUKnvT1dA1qjzdP1UNi
 Na9Gwf7GJJWywlg/EKARKHTHZN2sEvGt0fQayLVfx/48C7iJgtFr+PUlfQzgcVWQEL9xTD2s0Gv
 KqY29uGVrv5HV2NBjcPA/Am2/MDZazX7+4ysleTi4ZhDEuQsWDH68f71AerWwHxivYt81LztIQr
 mGp3yEsesdp3OpGmtQz9UhHH8+7afpqrZf0uxSeJfQjpgpTpY/v3UcrEdlGSlo7G0XXH5I7h4se
 nl7lcl1to0bfWvy2laQcF6nbzSTXawnmMd34qyriAajcab68g2Gagh3RH6rL+JX70pgoy9tbBdO
 2yelzksJQRWHDqwM4gMin/HEM5HmyPmgUNvibsFYQYknxuAJQ+yiJRn9YRsyiPqeDcplg1XavVO
 M4a79hC4Shql+bVZLf8i/WI1U1WO4MhsmZvXfu1Q/Zg6lK4NGqT01oIX+DvQHkb6YEgmraAKutm
 DQRFIMZ9yd2diynqtA1bN4xp5xi7JY=
X-Received: by 2002:a05:6000:3105:b0:43b:5672:efe with SMTP id
 ffacd0b85a97d-43b9e9db098mr2947888f8f.9.1774610276779; 
 Fri, 27 Mar 2026 04:17:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 58/65] hw/arm/virt: Pull "wire CPU interrupts" out of
 create_gic()
Date: Fri, 27 Mar 2026 11:16:53 +0000
Message-ID: <20260327111700.795099-59-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

create_gic() is quite long and mixes GICv2 and GICv3 even though
they're mostly different in their creation.  As a preliminary to
splitting it up, pull out the "wire the CPU interrupts to the GIC PPI
inputs" code out into its own function.  This is a long and
self-contained piece of code that is the main thing that we need to
do basically the same way for GICv2 and GICv3.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/arm/virt.c | 126 +++++++++++++++++++++++++++-----------------------
 1 file changed, 68 insertions(+), 58 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 544605244b..5a2cb81919 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -794,13 +794,79 @@ static bool gicv3_nmi_present(VirtMachineState *vms)
            (vms->gic_version != VIRT_GIC_VERSION_2);
 }
 
+static void gic_connect_ppis(VirtMachineState *vms)
+{
+    /*
+     * Wire the outputs from each CPU's generic timer and the GICv3
+     * maintenance interrupt signal to the appropriate GIC PPI inputs,
+     * and the GIC's IRQ/FIQ/VIRQ/VFIQ/NMI/VINMI interrupt outputs to the
+     * CPU's inputs.
+     */
+    MachineState *ms = MACHINE(vms);
+    unsigned int smp_cpus = ms->smp.cpus;
+    SysBusDevice *gicbusdev = SYS_BUS_DEVICE(vms->gic);
+
+    for (int i = 0; i < smp_cpus; i++) {
+        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
+        int intidbase = NUM_IRQS + i * GIC_INTERNAL;
+        /*
+         * Mapping from the output timer irq lines from the CPU to the
+         * GIC PPI inputs we use for the virt board.
+         */
+        const int timer_irq[] = {
+            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
+            [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
+            [GTIMER_S_EL2_PHYS] = ARCH_TIMER_S_EL2_IRQ,
+            [GTIMER_S_EL2_VIRT] = ARCH_TIMER_S_EL2_VIRT_IRQ,
+        };
+
+        for (unsigned irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
+            qdev_connect_gpio_out(cpudev, irq,
+                                  qdev_get_gpio_in(vms->gic,
+                                                   intidbase + timer_irq[irq]));
+        }
+
+        if (vms->gic_version != VIRT_GIC_VERSION_2) {
+            qemu_irq irq = qdev_get_gpio_in(vms->gic,
+                                            intidbase + ARCH_GIC_MAINT_IRQ);
+            qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
+                                        0, irq);
+        } else if (vms->virt) {
+            qemu_irq irq = qdev_get_gpio_in(vms->gic,
+                                            intidbase + ARCH_GIC_MAINT_IRQ);
+            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
+        }
+
+        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
+                                    qdev_get_gpio_in(vms->gic, intidbase
+                                                     + VIRTUAL_PMU_IRQ));
+
+        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(gicbusdev, i + smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(gicbusdev, i + 2 * smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+
+        if (vms->gic_version != VIRT_GIC_VERSION_2) {
+            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_NMI));
+            sysbus_connect_irq(gicbusdev, i + 5 * smp_cpus,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_VINMI));
+        }
+    }
+}
+
 static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 {
     MachineState *ms = MACHINE(vms);
     /* We create a standalone GIC */
     SysBusDevice *gicbusdev;
     const char *gictype;
-    int i;
     unsigned int smp_cpus = ms->smp.cpus;
     uint32_t nb_redist_regions = 0;
     int revision;
@@ -899,63 +965,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
         }
     }
 
-    /* Wire the outputs from each CPU's generic timer and the GICv3
-     * maintenance interrupt signal to the appropriate GIC PPI inputs,
-     * and the GIC's IRQ/FIQ/VIRQ/VFIQ/NMI/VINMI interrupt outputs to the
-     * CPU's inputs.
-     */
-    for (i = 0; i < smp_cpus; i++) {
-        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
-        int intidbase = NUM_IRQS + i * GIC_INTERNAL;
-        /* Mapping from the output timer irq lines from the CPU to the
-         * GIC PPI inputs we use for the virt board.
-         */
-        const int timer_irq[] = {
-            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
-            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
-            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
-            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
-            [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
-            [GTIMER_S_EL2_PHYS] = ARCH_TIMER_S_EL2_IRQ,
-            [GTIMER_S_EL2_VIRT] = ARCH_TIMER_S_EL2_VIRT_IRQ,
-        };
-
-        for (unsigned irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
-            qdev_connect_gpio_out(cpudev, irq,
-                                  qdev_get_gpio_in(vms->gic,
-                                                   intidbase + timer_irq[irq]));
-        }
-
-        if (vms->gic_version != VIRT_GIC_VERSION_2) {
-            qemu_irq irq = qdev_get_gpio_in(vms->gic,
-                                            intidbase + ARCH_GIC_MAINT_IRQ);
-            qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
-                                        0, irq);
-        } else if (vms->virt) {
-            qemu_irq irq = qdev_get_gpio_in(vms->gic,
-                                            intidbase + ARCH_GIC_MAINT_IRQ);
-            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
-        }
-
-        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
-                                    qdev_get_gpio_in(vms->gic, intidbase
-                                                     + VIRTUAL_PMU_IRQ));
-
-        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
-        sysbus_connect_irq(gicbusdev, i + smp_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
-        sysbus_connect_irq(gicbusdev, i + 2 * smp_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
-        sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
-
-        if (vms->gic_version != VIRT_GIC_VERSION_2) {
-            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus,
-                               qdev_get_gpio_in(cpudev, ARM_CPU_NMI));
-            sysbus_connect_irq(gicbusdev, i + 5 * smp_cpus,
-                               qdev_get_gpio_in(cpudev, ARM_CPU_VINMI));
-        }
-    }
+    gic_connect_ppis(vms);
 
     fdt_add_gic_node(vms);
 }
-- 
2.43.0


