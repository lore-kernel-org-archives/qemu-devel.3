Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE942D2AB12
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 09:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5iv6-0004wi-T1; Tue, 29 Oct 2024 05:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t5iv5-0004wJ-NM
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 05:53:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t5iv3-0007N2-8f
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 05:53:47 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxLOKjsCBn+5UbAA--.56986S3;
 Tue, 29 Oct 2024 17:53:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxyOKfsCBnMz0mAA--.95S4;
 Tue, 29 Oct 2024 17:53:39 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v2 2/4] hw/loongarch/virt: Implement cpu plug interface
Date: Tue, 29 Oct 2024 17:53:33 +0800
Message-Id: <20241029095335.2219343-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241029095335.2219343-1-maobibo@loongson.cn>
References: <20241029095335.2219343-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxyOKfsCBnMz0mAA--.95S4
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

Add cpu hotplug interface, however cpu hotplug feature is still
disabled for the machine. When machine is on, all created vCPUs
go through hotplug interface, and there is no remaining vCPU which
can be hot-added after power on.

Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c    | 145 +++++++++++++++++++++++++++++++++++++++++
 target/loongarch/cpu.c |  13 ++++
 2 files changed, 158 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index e138dac510..28a46bf195 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1327,6 +1327,142 @@ static void virt_get_topo_from_index(MachineState *ms,
     topo->thread_id = index % ms->smp.threads;
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
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
+    MachineState *ms = MACHINE(OBJECT(hotplug_dev));
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    CPUState *cs = CPU(dev);
+    CPUArchId *cpu_slot;
+    Error *local_err = NULL;
+    LoongArchCPUTopo topo;
+    int arch_id, index = 0;
+
+    /* sanity check the cpu */
+    if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
+        error_setg(&local_err, "Invalid CPU type, expected cpu type: '%s'",
+                   ms->cpu_type);
+        goto out;
+    }
+
+    if (lvms->acpi_ged) {
+        hotplug_handler_pre_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev,
+                                 &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+           return;
+        }
+     }
+
+    if (cpu->phy_id == UNSET_PHY_ID) {
+        error_setg(&local_err, "CPU hotplug not supported");
+        goto out;
+    } else {
+        /*
+         * For non hot-add cpu, topo property is not set. And only physical id
+         * property is set, setup topo information from physical id.
+         *
+         * Supposing arch_id is equal to cpu slot index
+         */
+        arch_id = cpu->phy_id;
+        virt_get_topo_from_index(ms, &topo, arch_id);
+        cpu->socket_id = topo.socket_id;
+        cpu->core_id   = topo.core_id;
+        cpu->thread_id = topo.thread_id;
+        cpu_slot = virt_find_cpu_slot(ms, arch_id, &index);
+    }
+
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
+    hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev,
+                                   &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
+static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
+                                DeviceState *dev, Error **errp)
+{
+    CPUArchId *cpu_slot;
+    Error *local_err = NULL;
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
+
+    hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &local_err);
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
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
+
+    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id, NULL);
+    cpu_slot->cpu = CPU(dev);
+    return;
+}
+
 static bool memhp_type_supported(DeviceState *dev)
 {
     /* we only support pc dimm now */
@@ -1345,6 +1481,8 @@ static void virt_device_pre_plug(HotplugHandler *hotplug_dev,
 {
     if (memhp_type_supported(dev)) {
         virt_mem_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        virt_cpu_pre_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -1363,6 +1501,8 @@ static void virt_device_unplug_request(HotplugHandler *hotplug_dev,
 {
     if (memhp_type_supported(dev)) {
         virt_mem_unplug_request(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        virt_cpu_unplug_request(hotplug_dev, dev, errp);
     }
 }
 
@@ -1381,6 +1521,8 @@ static void virt_device_unplug(HotplugHandler *hotplug_dev,
 {
     if (memhp_type_supported(dev)) {
         virt_mem_unplug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        virt_cpu_unplug(hotplug_dev, dev, errp);
     }
 }
 
@@ -1408,6 +1550,8 @@ static void virt_device_plug_cb(HotplugHandler *hotplug_dev,
         }
     } else if (memhp_type_supported(dev)) {
         virt_mem_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        virt_cpu_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -1417,6 +1561,7 @@ static HotplugHandler *virt_get_hotplug_handler(MachineState *machine,
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
     if (device_is_dynamic_sysbus(mc, dev) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
         memhp_type_supported(dev)) {
         return HOTPLUG_HANDLER(machine);
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 5dfc0d5c43..c31607b89c 100644
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


