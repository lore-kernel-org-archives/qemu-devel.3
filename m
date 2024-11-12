Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9B1D41D45
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 02:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAgTm-0007Cl-2p; Mon, 11 Nov 2024 21:18:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tAgTe-0007BM-8t
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 21:17:59 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tAgTb-00046R-8G
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 21:17:58 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxIK_OujJnMLg7AA--.28809S3;
 Tue, 12 Nov 2024 10:17:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCx98DCujJniixSAA--.12416S5;
 Tue, 12 Nov 2024 10:17:49 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: [PATCH v4 3/6] hw/loongarch/virt: Add generic function to init
 interrupt pin of CPU
Date: Tue, 12 Nov 2024 10:17:35 +0800
Message-Id: <20241112021738.1952851-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241112021738.1952851-1-maobibo@loongson.cn>
References: <20241112021738.1952851-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx98DCujJniixSAA--.12416S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Here generic function virt_init_cpu_irq() is added to init interrupt
pin of CPU object, IPI and extioi interrupt controllers are connected
to interrupt pin of CPU object.

The generic function can be used to both cold-plug and hot-plug CPUs.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c         | 78 ++++++++++++++++++++++++-------------
 include/hw/loongarch/virt.h |  2 +
 2 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index b6b616d278..621380e2b3 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -58,6 +58,20 @@ static bool virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
     return true;
 }
 
+static CPUState *virt_get_cpu(MachineState *ms, int index)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *possible_cpus;
+
+    /* Init CPUs */
+    possible_cpus = mc->possible_cpu_arch_ids(ms);
+    if (index < 0 || index >= possible_cpus->len) {
+        return NULL;
+    }
+
+    return possible_cpus->cpus[index].cpu;
+}
+
 static void virt_get_veiointc(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
@@ -365,7 +379,7 @@ static void create_fdt(LoongArchVirtMachineState *lvms)
 static void fdt_add_cpu_nodes(const LoongArchVirtMachineState *lvms)
 {
     int num;
-    const MachineState *ms = MACHINE(lvms);
+    MachineState *ms = MACHINE(lvms);
     int smp_cpus = ms->smp.cpus;
 
     qemu_fdt_add_subnode(ms->fdt, "/cpus");
@@ -375,7 +389,7 @@ static void fdt_add_cpu_nodes(const LoongArchVirtMachineState *lvms)
     /* cpu nodes */
     for (num = smp_cpus - 1; num >= 0; num--) {
         char *nodename = g_strdup_printf("/cpus/cpu@%d", num);
-        LoongArchCPU *cpu = LOONGARCH_CPU(qemu_get_cpu(num));
+        LoongArchCPU *cpu = LOONGARCH_CPU(virt_get_cpu(ms, num));
         CPUState *cs = CPU(cpu);
 
         qemu_fdt_add_subnode(ms->fdt, nodename);
@@ -783,16 +797,42 @@ static void virt_devices_init(DeviceState *pch_pic,
     lvms->platform_bus_dev = create_platform_bus(pch_pic);
 }
 
+static void virt_init_cpu_irq(MachineState *ms, CPUState *cs)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env;
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
+    int pin;
+
+    if (!lvms->ipi || !lvms->extioi) {
+        return;
+    }
+
+    env = &(cpu->env);
+    env->address_space_iocsr = &lvms->as_iocsr;
+    env->ipistate = lvms->ipi;
+    /* connect ipi irq to cpu irq, logic cpu index used here */
+    qdev_connect_gpio_out(lvms->ipi, cs->cpu_index,
+                              qdev_get_gpio_in(DEVICE(cs), IRQ_IPI));
+
+    /*
+     * connect ext irq to the cpu irq
+     * cpu_pin[9:2] <= intc_pin[7:0]
+     */
+    for (pin = 0; pin < LS3A_INTC_IP; pin++) {
+        qdev_connect_gpio_out(lvms->extioi, cs->cpu_index * LS3A_INTC_IP + pin,
+                              qdev_get_gpio_in(DEVICE(cs), pin + 2));
+    }
+}
+
 static void virt_irq_init(LoongArchVirtMachineState *lvms)
 {
     MachineState *ms = MACHINE(lvms);
-    DeviceState *pch_pic, *pch_msi, *cpudev;
+    DeviceState *pch_pic, *pch_msi;
     DeviceState *ipi, *extioi;
     SysBusDevice *d;
-    LoongArchCPU *lacpu;
-    CPULoongArchState *env;
     CPUState *cpu_state;
-    int cpu, pin, i, start, num;
+    int cpu, i, start, num;
     uint32_t cpuintc_phandle, eiointc_phandle, pch_pic_phandle, pch_msi_phandle;
 
     /*
@@ -843,6 +883,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     ipi = qdev_new(TYPE_LOONGARCH_IPI);
     qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
+    lvms->ipi = ipi;
 
     /* IPI iocsr memory region */
     memory_region_add_subregion(&lvms->system_iocsr, SMP_IPI_MAILBOX,
@@ -853,18 +894,6 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     /* Add cpu interrupt-controller */
     fdt_add_cpuic_node(lvms, &cpuintc_phandle);
 
-    for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
-        cpu_state = qemu_get_cpu(cpu);
-        cpudev = DEVICE(cpu_state);
-        lacpu = LOONGARCH_CPU(cpu_state);
-        env = &(lacpu->env);
-        env->address_space_iocsr = &lvms->as_iocsr;
-
-        /* connect ipi irq to cpu irq */
-        qdev_connect_gpio_out(ipi, cpu, qdev_get_gpio_in(cpudev, IRQ_IPI));
-        env->ipistate = ipi;
-    }
-
     /* Create EXTIOI device */
     extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
     qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
@@ -872,6 +901,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
         qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
     }
     sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
+    lvms->extioi = extioi;
     memory_region_add_subregion(&lvms->system_iocsr, APIC_BASE,
                     sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 0));
     if (virt_is_veiointc_enabled(lvms)) {
@@ -879,16 +909,10 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
                     sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 1));
     }
 
-    /*
-     * connect ext irq to the cpu irq
-     * cpu_pin[9:2] <= intc_pin[7:0]
-     */
+    /* Connect irq to cpu, including ipi and extioi irqchip */
     for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
-        cpudev = DEVICE(qemu_get_cpu(cpu));
-        for (pin = 0; pin < LS3A_INTC_IP; pin++) {
-            qdev_connect_gpio_out(extioi, (cpu * 8 + pin),
-                                  qdev_get_gpio_in(cpudev, pin + 2));
-        }
+        cpu_state = virt_get_cpu(ms, cpu);
+        virt_init_cpu_irq(ms, cpu_state);
     }
 
     /* Add Extend I/O Interrupt Controller node */
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 9ba47793ef..260e6bd7cf 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -60,6 +60,8 @@ struct LoongArchVirtMachineState {
     MemoryRegion iocsr_mem;
     AddressSpace as_iocsr;
     struct loongarch_boot_info bootinfo;
+    DeviceState *ipi;
+    DeviceState *extioi;
 };
 
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
-- 
2.39.3


