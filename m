Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3577D2E01B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 07:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3VYm-00051Z-6K; Wed, 23 Oct 2024 03:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t3VYa-0004tr-Lv
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:13:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t3VYW-0005GK-Ua
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:13:24 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxmeANohhnZGQHAA--.17185S3;
 Wed, 23 Oct 2024 15:13:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxP+EIohhnpeYKAA--.63247S4;
 Wed, 23 Oct 2024 15:13:17 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH 2/3] hw/loongarch/virt: Add basic CPU plug support
Date: Wed, 23 Oct 2024 15:13:11 +0800
Message-Id: <20241023071312.881866-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241023071312.881866-1-maobibo@loongson.cn>
References: <20241023071312.881866-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxP+EIohhnpeYKAA--.63247S4
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

Implement interface for cpu hotplug function, and enable cpu hotplug
feature on virt machine.

Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/Kconfig        |   1 +
 hw/loongarch/virt.c         | 191 +++++++++++++++++++++++++++++++++++-
 include/hw/loongarch/virt.h |   2 +
 target/loongarch/cpu.c      |  13 +++
 4 files changed, 205 insertions(+), 2 deletions(-)

diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index fe1c6feac1..bb2838b7b5 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -17,6 +17,7 @@ config LOONGARCH_VIRT
     select LOONGARCH_EXTIOI
     select LS7A_RTC
     select SMBIOS
+    select ACPI_CPU_HOTPLUG
     select ACPI_PCI
     select ACPI_HW_REDUCED
     select FW_CFG_DMA
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 757bf6b6dc..8408412bf5 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -841,7 +841,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
 
     /* Create IPI device */
     ipi = qdev_new(TYPE_LOONGARCH_IPI);
-    qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
+    qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.max_cpus);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
 
     /* IPI iocsr memory region */
@@ -865,9 +865,11 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
         env->ipistate = ipi;
     }
 
+    lvms->ipi = ipi;
+
     /* Create EXTIOI device */
     extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
-    qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
+    qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.max_cpus);
     if (virt_is_veiointc_enabled(lvms)) {
         qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
     }
@@ -891,6 +893,8 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
         }
     }
 
+    lvms->extioi = extioi;
+
     /* Add Extend I/O Interrupt Controller node */
     fdt_add_eiointc_node(lvms, &cpuintc_phandle, &eiointc_phandle);
 
@@ -1330,6 +1334,179 @@ static int virt_get_arch_id_from_topo(MachineState *ms, LoongArchCPUTopo *topo)
     return arch_id;
 }
 
+/* find cpu slot in machine->possible_cpus by arch_id */
+static CPUArchId *virt_find_cpu_slot(MachineState *ms, int arch_id, int *index)
+{
+    int n;
+    for (n = 0; n < ms->possible_cpus->len; n++) {
+        if (ms->possible_cpus->cpus[n].arch_id == arch_id) {
+            if (index) {
+                *index = n;
+            }
+            return &ms->possible_cpus->cpus[n];
+        }
+    }
+
+    return NULL;
+}
+
+static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
+                              DeviceState *dev, Error **errp)
+{
+    MachineState *ms = MACHINE(OBJECT(hotplug_dev));
+    MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    CPUState *cs = CPU(dev);
+    CPUArchId *cpu_slot;
+    Error *local_err = NULL;
+    LoongArchCPUTopo topo;
+    int arch_id, index;
+
+    if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
+        error_setg(&local_err, "CPU hotplug not supported for this machine");
+        goto out;
+    }
+
+    /* sanity check the cpu */
+    if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
+        error_setg(&local_err, "Invalid CPU type, expected cpu type: '%s'",
+                   ms->cpu_type);
+        goto out;
+    }
+
+    if ((cpu->thread_id < 0) || (cpu->thread_id >= ms->smp.threads)) {
+        error_setg(&local_err,
+                   "Invalid thread-id %u specified, must be in range 1:%u",
+                   cpu->thread_id, ms->smp.threads - 1);
+        goto out;
+    }
+
+    if ((cpu->core_id < 0) || (cpu->core_id >= ms->smp.cores)) {
+        error_setg(&local_err,
+                   "Invalid core-id %u specified, must be in range 1:%u",
+                   cpu->core_id, ms->smp.cores - 1);
+        goto out;
+    }
+
+    if ((cpu->socket_id < 0) || (cpu->socket_id >= ms->smp.sockets)) {
+        error_setg(&local_err,
+                   "Invalid socket-id %u specified, must be in range 1:%u",
+                   cpu->socket_id, ms->smp.sockets - 1);
+        goto out;
+    }
+
+    topo.socket_id = cpu->socket_id;
+    topo.core_id = cpu->core_id;
+    topo.thread_id = cpu->thread_id;
+    arch_id =  virt_get_arch_id_from_topo(ms, &topo);
+    cpu_slot = virt_find_cpu_slot(ms, arch_id, &index);
+    if (CPU(cpu_slot->cpu)) {
+        error_setg(&local_err,
+                   "cpu(id%d=%d:%d:%d) with arch-id %" PRIu64 " exists",
+                   cs->cpu_index, cpu->socket_id, cpu->core_id,
+                   cpu->thread_id, cpu_slot->arch_id);
+        goto out;
+    }
+    cpu->phy_id = arch_id;
+    /*
+     * update cpu_index calculation method since it is easily used as index
+     * with possible_cpus array by function virt_cpu_index_to_props
+     */
+    cs->cpu_index = index;
+    numa_cpu_pre_plug(cpu_slot, dev, &local_err);
+    return ;
+
+out:
+    error_propagate(errp, local_err);
+}
+
+static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
+                                       DeviceState *dev, Error **errp)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
+    Error *local_err = NULL;
+    HotplugHandlerClass *hhc;
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    CPUState *cs = CPU(dev);
+
+    if (!lvms->acpi_ged) {
+        error_setg(&local_err, "CPU hot unplug not supported without ACPI");
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (cs->cpu_index == 0) {
+        error_setg(&local_err,
+                   "hot-unplug of boot cpu(id%d=%d:%d:%d) not supported",
+                   cs->cpu_index, cpu->socket_id,
+                   cpu->core_id, cpu->thread_id);
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    hhc = HOTPLUG_HANDLER_GET_CLASS(lvms->acpi_ged);
+    hhc->unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &local_err);
+}
+
+static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
+                                DeviceState *dev, Error **errp)
+{
+    CPUArchId *cpu_slot;
+    HotplugHandlerClass *hhc;
+    Error *local_err = NULL;
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
+
+    hhc = HOTPLUG_HANDLER_GET_CLASS(lvms->acpi_ged);
+    hhc->unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id, NULL);
+    cpu_slot->cpu = NULL;
+    return;
+}
+
+static void virt_cpu_plug(HotplugHandler *hotplug_dev,
+                                DeviceState *dev, Error **errp)
+{
+    CPUArchId *cpu_slot;
+    HotplugHandlerClass *hhc;
+    Error *local_err = NULL;
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    CPUState *cs = CPU(cpu);
+    CPULoongArchState *env;
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
+    int pin;
+
+    if (lvms->acpi_ged) {
+        env = &(cpu->env);
+        env->address_space_iocsr = &lvms->as_iocsr;
+
+        /* connect ipi irq to cpu irq, logic cpu index used here */
+        qdev_connect_gpio_out(lvms->ipi, cs->cpu_index,
+                              qdev_get_gpio_in(dev, IRQ_IPI));
+        env->ipistate = lvms->ipi;
+
+        for (pin = 0; pin < LS3A_INTC_IP; pin++) {
+            qdev_connect_gpio_out(lvms->extioi, (cs->cpu_index * 8 + pin),
+                                  qdev_get_gpio_in(dev, pin + 2));
+        }
+        hhc = HOTPLUG_HANDLER_GET_CLASS(lvms->acpi_ged);
+        hhc->plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+           return;
+        }
+    }
+
+    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id, NULL);
+    cpu_slot->cpu = CPU(dev);
+    return;
+}
+
 static bool memhp_type_supported(DeviceState *dev)
 {
     /* we only support pc dimm now */
@@ -1348,6 +1525,8 @@ static void virt_device_pre_plug(HotplugHandler *hotplug_dev,
 {
     if (memhp_type_supported(dev)) {
         virt_mem_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        virt_cpu_pre_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -1366,6 +1545,8 @@ static void virt_device_unplug_request(HotplugHandler *hotplug_dev,
 {
     if (memhp_type_supported(dev)) {
         virt_mem_unplug_request(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        virt_cpu_unplug_request(hotplug_dev, dev, errp);
     }
 }
 
@@ -1384,6 +1565,8 @@ static void virt_device_unplug(HotplugHandler *hotplug_dev,
 {
     if (memhp_type_supported(dev)) {
         virt_mem_unplug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        virt_cpu_unplug(hotplug_dev, dev, errp);
     }
 }
 
@@ -1411,6 +1594,8 @@ static void virt_device_plug_cb(HotplugHandler *hotplug_dev,
         }
     } else if (memhp_type_supported(dev)) {
         virt_mem_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        virt_cpu_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -1420,6 +1605,7 @@ static HotplugHandler *virt_get_hotplug_handler(MachineState *machine,
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
     if (device_is_dynamic_sysbus(mc, dev) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
         memhp_type_supported(dev)) {
         return HOTPLUG_HANDLER(machine);
@@ -1509,6 +1695,7 @@ static void virt_class_init(ObjectClass *oc, void *data)
     mc->numa_mem_supported = true;
     mc->auto_enable_numa_with_memhp = true;
     mc->auto_enable_numa_with_memdev = true;
+    mc->has_hotpluggable_cpus = true;
     mc->get_hotplug_handler = virt_get_hotplug_handler;
     mc->default_nic = "virtio-net-pci";
     hc->plug = virt_device_plug_cb;
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
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index f4023e25ef..c7eb0c8a68 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -613,6 +613,17 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
     lacc->parent_realize(dev, errp);
 }
 
+static void loongarch_cpu_unrealizefn(DeviceState *dev)
+{
+    LoongArchCPUClass *mcc = LOONGARCH_CPU_GET_CLASS(dev);
+
+#ifndef CONFIG_USER_ONLY
+    cpu_remove_sync(CPU(dev));
+#endif
+
+    mcc->parent_unrealize(dev);
+}
+
 static bool loongarch_get_lsx(Object *obj, Error **errp)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
@@ -800,6 +811,8 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
     device_class_set_props(dc, loongarch_cpu_properties);
     device_class_set_parent_realize(dc, loongarch_cpu_realizefn,
                                     &lacc->parent_realize);
+    device_class_set_parent_unrealize(dc, loongarch_cpu_unrealizefn,
+                                      &lacc->parent_unrealize);
     resettable_class_set_parent_phases(rc, NULL, loongarch_cpu_reset_hold, NULL,
                                        &lacc->parent_phases);
 
-- 
2.39.3


