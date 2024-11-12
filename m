Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65363D41D44
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 02:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAgTm-0007D5-UY; Mon, 11 Nov 2024 21:18:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tAgTe-0007BO-H9
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 21:17:59 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tAgTc-00046d-Dr
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 21:17:58 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxC+LPujJnPLg7AA--.52222S3;
 Tue, 12 Nov 2024 10:17:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCx98DCujJniixSAA--.12416S8;
 Tue, 12 Nov 2024 10:17:51 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: [PATCH v4 6/6] hw/loongarch/virt: Enable cpu hotplug feature on virt
 machine
Date: Tue, 12 Nov 2024 10:17:38 +0800
Message-Id: <20241112021738.1952851-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241112021738.1952851-1-maobibo@loongson.cn>
References: <20241112021738.1952851-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx98DCujJniixSAA--.12416S8
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

On virt machine, enable CPU hotplug feature has_hotpluggable_cpus. For
hot-added CPUs, there is socket-id/core-id/thread-id property set,
arch_id can be caculated from these properties. So that cpu slot can be
searched from its arch_id.

Also change num-cpu property of extioi and ipi from smp.cpus to
smp.max_cpus

Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c | 68 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 9 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index b49b15c0f6..5f81673368 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -890,7 +890,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
 
     /* Create IPI device */
     ipi = qdev_new(TYPE_LOONGARCH_IPI);
-    qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
+    qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.max_cpus);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
     lvms->ipi = ipi;
 
@@ -905,7 +905,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
 
     /* Create EXTIOI device */
     extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
-    qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
+    qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.max_cpus);
     if (virt_is_veiointc_enabled(lvms)) {
         qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
     }
@@ -1369,11 +1369,15 @@ static void virt_get_topo_from_index(MachineState *ms,
 }
 
 /* Find cpu slot in machine->possible_cpus by arch_id */
-static CPUArchId *virt_find_cpu_slot(MachineState *ms, int arch_id)
+static CPUArchId *virt_find_cpu_slot(MachineState *ms, int arch_id, int *index)
 {
     int n;
     for (n = 0; n < ms->possible_cpus->len; n++) {
         if (ms->possible_cpus->cpus[n].arch_id == arch_id) {
+            if (index) {
+                *index = n;
+            }
+
             return &ms->possible_cpus->cpus[n];
         }
     }
@@ -1386,10 +1390,12 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
     MachineState *ms = MACHINE(OBJECT(hotplug_dev));
+    CPUState *cs = CPU(dev);
     LoongArchCPU *cpu = LOONGARCH_CPU(dev);
     CPUArchId *cpu_slot;
     Error *local_err = NULL;
-    int arch_id;
+    LoongArchCPUTopo topo;
+    int arch_id, index;
 
     /* sanity check the cpu */
     if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
@@ -1408,12 +1414,45 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
      }
 
     if (cpu->phy_id == UNSET_PHY_ID) {
-        error_setg(&local_err, "CPU hotplug not supported");
-        goto out;
+        if ((cpu->thread_id < 0) || (cpu->thread_id >= ms->smp.threads)) {
+            error_setg(&local_err,
+                       "Invalid thread-id %u specified, must be in range 1:%u",
+                       cpu->thread_id, ms->smp.threads - 1);
+            goto out;
+        }
+
+        if ((cpu->core_id < 0) || (cpu->core_id >= ms->smp.cores)) {
+            error_setg(&local_err,
+                       "Invalid core-id %u specified, must be in range 1:%u",
+                       cpu->core_id, ms->smp.cores - 1);
+            goto out;
+        }
+
+        if ((cpu->socket_id < 0) || (cpu->socket_id >= ms->smp.sockets)) {
+            error_setg(&local_err,
+                       "Invalid socket-id %u specified, must be in range 1:%u",
+                       cpu->socket_id, ms->smp.sockets - 1);
+            goto out;
+        }
+
+        topo.socket_id = cpu->socket_id;
+        topo.core_id = cpu->core_id;
+        topo.thread_id = cpu->thread_id;
+        arch_id =  virt_get_arch_id_from_topo(ms, &topo);
+        cpu_slot = virt_find_cpu_slot(ms, arch_id, &index);
+        if (CPU(cpu_slot->cpu)) {
+            error_setg(&local_err,
+                       "cpu(id%d=%d:%d:%d) with arch-id %" PRIu64 " exists",
+                       cs->cpu_index, cpu->socket_id, cpu->core_id,
+                       cpu->thread_id, cpu_slot->arch_id);
+            goto out;
+        }
+        cpu->phy_id = arch_id;
+        cs->cpu_index = index;
     } else {
         /* For cold-add cpu, find cpu slot from arch_id */
         arch_id = cpu->phy_id;
-        cpu_slot = virt_find_cpu_slot(ms, arch_id);
+        cpu_slot = virt_find_cpu_slot(ms, arch_id, NULL);
     }
 
     numa_cpu_pre_plug(cpu_slot, dev, &local_err);
@@ -1468,7 +1507,7 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
         return;
     }
 
-    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
+    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id, NULL);
     cpu_slot->cpu = NULL;
     return;
 }
@@ -1477,14 +1516,24 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
                                 DeviceState *dev, Error **errp)
 {
     CPUArchId *cpu_slot;
+    Error *local_err = NULL;
     LoongArchCPU *cpu = LOONGARCH_CPU(dev);
     MachineState *ms = MACHINE(hotplug_dev);
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
 
     /* Connect irq to cpu, including ipi and extioi irqchip */
     virt_init_cpu_irq(ms, CPU(cpu));
-    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
+    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id, NULL);
     cpu_slot->cpu = CPU(dev);
+
+    if (lvms->acpi_ged) {
+        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
     return;
 }
 
@@ -1667,6 +1716,7 @@ static void virt_class_init(ObjectClass *oc, void *data)
     mc->numa_mem_supported = true;
     mc->auto_enable_numa_with_memhp = true;
     mc->auto_enable_numa_with_memdev = true;
+    mc->has_hotpluggable_cpus = true;
     mc->get_hotplug_handler = virt_get_hotplug_handler;
     mc->default_nic = "virtio-net-pci";
     hc->plug = virt_device_plug_cb;
-- 
2.39.3


