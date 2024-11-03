Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B7FD11101
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 15:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7cTu-0001kb-51; Sun, 03 Nov 2024 10:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t7cTs-0001kO-Or; Sun, 03 Nov 2024 10:25:32 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t7cTq-0002KY-SZ; Sun, 03 Nov 2024 10:25:32 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XhJFT081Fz6L77H;
 Sun,  3 Nov 2024 23:20:29 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id A23C1140B67;
 Sun,  3 Nov 2024 23:25:26 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.48.146.9) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 16:25:09 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>,
 <richard.henderson@linaro.org>, <peter.maydell@linaro.org>
CC: <salil.mehta@huawei.com>, <jonathan.cameron@huawei.com>,
 <alex.bennee@linaro.org>, <imammedo@redhat.com>, <pbonzini@redhat.com>,
 <gshan@redhat.com>, <maz@kernel.org>, <will@kernel.org>,
 <oliver.upton@linux.dev>, <jean-philippe@linaro.org>,
 <lpieralisi@kernel.org>, <david@redhat.com>, <philmd@linaro.org>,
 <andrew.jones@linux.dev>, <eric.auger@redhat.com>, <npiggin@gmail.com>,
 <harshpb@linux.ibm.com>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>,
 <gustavo.romero@linaro.org>
Subject: [PATCH] arm/virt: Extract common code to wire GICC<->vCPU IRQs for
 reuse
Date: Sun, 3 Nov 2024 15:24:55 +0000
Message-ID: <20241103152455.202462-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.146.9]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Extract common GIC and CPU interrupt wiring code to improve code
readability and modularity, supporting reuse in future patch sets. This
refactor is benign and introduces *no* functional changes.

Note: This patch has been isolated from a larger patch set to facilitate
early merging and reduce the complexity of the original set, as it
operates independently. All original tags and author contributions are
retained.

[!] Please note, this is a purely cosmetic change. No functional change.

Reported-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
[4/05/2024: Issue with total number of PPI available during create GIC]
Suggested-by: Miguel Luis <miguel.luis@oracle.com>
[5/05/2024: Fix the total number of PPIs available as per ARM BSA to avoid overflow]
Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c | 108 ++++++++++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 48 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a0d3bef875..d6892b0266 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -761,6 +761,65 @@ static bool gicv3_nmi_present(VirtMachineState *vms)
            (vms->gic_version != VIRT_GIC_VERSION_2);
 }
 
+/*
+ * Mapping from the output timer irq lines from the CPU to the GIC PPI inputs
+ * we use for the virt board.
+ */
+const int timer_irq[] = {
+    [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+    [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+    [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+    [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
+    [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
+};
+
+static void wire_gic_cpu_irqs(VirtMachineState *vms, CPUState *cs)
+{
+    SysBusDevice *gicbusdev = SYS_BUS_DEVICE(vms->gic);
+    unsigned int smp_cpus = MACHINE(vms)->smp.cpus;
+    DeviceState *cpudev = DEVICE(cs);
+    int i = CPU(cs)->cpu_index;
+    int intidbase, irqn;
+
+    intidbase = NUM_IRQS + i * GIC_INTERNAL;
+
+    for (irqn = 0; irqn < ARRAY_SIZE(timer_irq); irqn++) {
+        qdev_connect_gpio_out(cpudev, irqn,
+                              qdev_get_gpio_in(vms->gic,
+                                               intidbase + timer_irq[irqn]));
+    }
+
+
+    if (vms->gic_version != VIRT_GIC_VERSION_2) {
+        qemu_irq irq = qdev_get_gpio_in(vms->gic,
+                                        intidbase + ARCH_GIC_MAINT_IRQ);
+        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
+                                    0, irq);
+    } else if (vms->virt) {
+        qemu_irq irq = qdev_get_gpio_in(vms->gic,
+                                        intidbase + ARCH_GIC_MAINT_IRQ);
+        sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
+    }
+
+    qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
+                                qdev_get_gpio_in(vms->gic, intidbase
+                                                  + VIRTUAL_PMU_IRQ));
+
+    sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+    sysbus_connect_irq(gicbusdev, i + smp_cpus,
+                       qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+    sysbus_connect_irq(gicbusdev, i + 2 * smp_cpus,
+                       qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+    sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
+                       qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+    if (vms->gic_version != VIRT_GIC_VERSION_2) {
+        sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_NMI));
+        sysbus_connect_irq(gicbusdev, i + 5 * smp_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VINMI));
+    }
+}
+
 static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 {
     MachineState *ms = MACHINE(vms);
@@ -862,54 +921,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
      * CPU's inputs.
      */
     for (i = 0; i < smp_cpus; i++) {
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
+        wire_gic_cpu_irqs(vms, qemu_get_cpu(i));
     }
 
     fdt_add_gic_node(vms);
-- 
2.34.1


