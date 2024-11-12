Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F680D41D46
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 02:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAgTh-0007BJ-Gz; Mon, 11 Nov 2024 21:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tAgTc-0007AN-Ob
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 21:17:56 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tAgTa-00046T-I3
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 21:17:56 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxEK_OujJnNLg7AA--.13555S3;
 Tue, 12 Nov 2024 10:17:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCx98DCujJniixSAA--.12416S6;
 Tue, 12 Nov 2024 10:17:50 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: [PATCH v4 4/6] hw/loongarch/virt: Init interrupt pin of CPU during
 plug interface
Date: Tue, 12 Nov 2024 10:17:36 +0800
Message-Id: <20241112021738.1952851-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241112021738.1952851-1-maobibo@loongson.cn>
References: <20241112021738.1952851-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx98DCujJniixSAA--.12416S6
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

Move CPU object creation after interrupt controller ipi and extioi,
and init interrupt pin of CPU in plug interface virt_cpu_plug().

So interrupt pin initialization of the cold-plug CPUs is the same
with that of hot-plug CPUs.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 84 ++++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 621380e2b3..0e0c6c202b 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -831,8 +831,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     DeviceState *pch_pic, *pch_msi;
     DeviceState *ipi, *extioi;
     SysBusDevice *d;
-    CPUState *cpu_state;
-    int cpu, i, start, num;
+    int i, start, num;
     uint32_t cpuintc_phandle, eiointc_phandle, pch_pic_phandle, pch_msi_phandle;
 
     /*
@@ -909,12 +908,6 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
                     sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 1));
     }
 
-    /* Connect irq to cpu, including ipi and extioi irqchip */
-    for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
-        cpu_state = virt_get_cpu(ms, cpu);
-        virt_init_cpu_irq(ms, cpu_state);
-    }
-
     /* Add Extend I/O Interrupt Controller node */
     fdt_add_eiointc_node(lvms, &cpuintc_phandle, &eiointc_phandle);
 
@@ -960,6 +953,44 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     virt_devices_init(pch_pic, lvms, &pch_pic_phandle, &pch_msi_phandle);
 }
 
+static void virt_init_cpus(MachineState *machine)
+{
+    int i;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    Object *cpuobj;
+    CPUState *cpu;
+    LoongArchCPU *lacpu;
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
+
+    /* Init CPUs */
+    mc->possible_cpu_arch_ids(machine);
+    for (i = 0; i < machine->smp.cpus; i++) {
+        cpuobj = object_new(machine->cpu_type);
+        if (cpuobj == NULL) {
+            error_report("Fail to create object with type %s ",
+                         machine->cpu_type);
+            exit(EXIT_FAILURE);
+        }
+
+        cpu = CPU(cpuobj);
+        cpu->cpu_index = i;
+        lacpu = LOONGARCH_CPU(cpuobj);
+        lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
+        object_property_set_int(cpuobj, "socket-id",
+                                machine->possible_cpus->cpus[i].props.socket_id,
+                                NULL);
+        object_property_set_int(cpuobj, "core-id",
+                                machine->possible_cpus->cpus[i].props.core_id,
+                                NULL);
+        object_property_set_int(cpuobj, "thread-id",
+                                machine->possible_cpus->cpus[i].props.thread_id,
+                                NULL);
+        qdev_realize_and_unref(DEVICE(cpuobj), NULL, &error_fatal);
+    }
+
+    fdt_add_cpu_nodes(lvms);
+}
+
 static void virt_firmware_init(LoongArchVirtMachineState *lvms)
 {
     char *filename = MACHINE(lvms)->firmware;
@@ -1161,15 +1192,10 @@ static void fw_cfg_add_memory(MachineState *ms)
 
 static void virt_init(MachineState *machine)
 {
-    LoongArchCPU *lacpu;
     const char *cpu_model = machine->cpu_type;
     MemoryRegion *address_space_mem = get_system_memory();
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
-    int i;
     hwaddr base, size, ram_size = machine->ram_size;
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
-    CPUState *cpu;
-    Object *cpuobj;
 
     if (!cpu_model) {
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
@@ -1186,32 +1212,6 @@ static void virt_init(MachineState *machine)
                           machine, "iocsr_misc", 0x428);
     memory_region_add_subregion(&lvms->system_iocsr, 0, &lvms->iocsr_mem);
 
-    /* Init CPUs */
-    mc->possible_cpu_arch_ids(machine);
-    for (i = 0; i < machine->smp.cpus; i++) {
-        cpuobj = object_new(machine->cpu_type);
-        if (cpuobj == NULL) {
-            error_report("Fail to create object with type %s ",
-                         machine->cpu_type);
-            exit(EXIT_FAILURE);
-        }
-
-        cpu = CPU(cpuobj);
-        cpu->cpu_index = i;
-        lacpu = LOONGARCH_CPU(cpuobj);
-        lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
-        object_property_set_int(cpuobj, "socket-id",
-                                machine->possible_cpus->cpus[i].props.socket_id,
-                                NULL);
-        object_property_set_int(cpuobj, "core-id",
-                                machine->possible_cpus->cpus[i].props.core_id,
-                                NULL);
-        object_property_set_int(cpuobj, "thread-id",
-                                machine->possible_cpus->cpus[i].props.thread_id,
-                                NULL);
-        qdev_realize_and_unref(DEVICE(cpuobj), NULL, &error_fatal);
-    }
-    fdt_add_cpu_nodes(lvms);
     fdt_add_memory_nodes(machine);
     fw_cfg_add_memory(machine);
 
@@ -1269,6 +1269,9 @@ static void virt_init(MachineState *machine)
 
     /* Initialize the IO interrupt subsystem */
     virt_irq_init(lvms);
+
+    /* Init CPUs */
+    virt_init_cpus(machine);
     platform_bus_add_all_fdt_nodes(machine->fdt, "/platic",
                                    VIRT_PLATFORM_BUS_BASEADDRESS,
                                    VIRT_PLATFORM_BUS_SIZE,
@@ -1465,8 +1468,11 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
 {
     CPUArchId *cpu_slot;
     LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    MachineState *ms = MACHINE(hotplug_dev);
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
 
+    /* Connect irq to cpu, including ipi and extioi irqchip */
+    virt_init_cpu_irq(ms, CPU(cpu));
     cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
     cpu_slot->cpu = CPU(dev);
     return;
-- 
2.39.3


