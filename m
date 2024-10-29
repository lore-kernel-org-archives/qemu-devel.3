Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF65D2AB12
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 09:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5ivC-0004xH-Ua; Tue, 29 Oct 2024 05:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t5iv5-0004wI-NO
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 05:53:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t5iv3-0007ND-9M
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 05:53:47 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxLOKksCBnBJYbAA--.56989S3;
 Tue, 29 Oct 2024 17:53:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxyOKfsCBnMz0mAA--.95S6;
 Tue, 29 Oct 2024 17:53:40 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v2 4/4] hw/loongarch/virt: Enable cpu hotplug feature on virt
 machine
Date: Tue, 29 Oct 2024 17:53:35 +0800
Message-Id: <20241029095335.2219343-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241029095335.2219343-1-maobibo@loongson.cn>
References: <20241029095335.2219343-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxyOKfsCBnMz0mAA--.95S6
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

On virt machine, enable cpu hotplug feature has_hotpluggable_cpus.
For hot-added cpu after power on, interrupt pin of extioi and ipi
interrupt controller need connect to pins of new cpu.

Also change num-cpu property of extioi and ipi from smp.cpus to
smp.max_cpus

Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c         | 68 ++++++++++++++++++++++++++++++++++---
 include/hw/loongarch/virt.h |  2 ++
 2 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 655312b0fe..cecb12786b 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -851,8 +851,9 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
 
     /* Create IPI device */
     ipi = qdev_new(TYPE_LOONGARCH_IPI);
-    qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
+    qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.max_cpus);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
+    lvms->ipi = ipi;
 
     /* IPI iocsr memory region */
     memory_region_add_subregion(&lvms->system_iocsr, SMP_IPI_MAILBOX,
@@ -877,11 +878,12 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
 
     /* Create EXTIOI device */
     extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
-    qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
+    qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.max_cpus);
     if (virt_is_veiointc_enabled(lvms)) {
         qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
     }
     sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
+    lvms->extioi = extioi;
     memory_region_add_subregion(&lvms->system_iocsr, APIC_BASE,
                     sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 0));
     if (virt_is_veiointc_enabled(lvms)) {
@@ -1382,8 +1384,40 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
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
     } else {
         /*
          * For non hot-add cpu, topo property is not set. And only physical id
@@ -1465,8 +1499,33 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
                                 DeviceState *dev, Error **errp)
 {
     CPUArchId *cpu_slot;
+    Error *local_err = NULL;
     LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    CPUState *cs = CPU(cpu);
+    CPULoongArchState *env;
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
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
+
+        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+           return;
+        }
+    }
 
     cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id, NULL);
     cpu_slot->cpu = CPU(dev);
@@ -1652,6 +1711,7 @@ static void virt_class_init(ObjectClass *oc, void *data)
     mc->numa_mem_supported = true;
     mc->auto_enable_numa_with_memhp = true;
     mc->auto_enable_numa_with_memdev = true;
+    mc->has_hotpluggable_cpus = true;
     mc->get_hotplug_handler = virt_get_hotplug_handler;
     mc->default_nic = "virtio-net-pci";
     hc->plug = virt_device_plug_cb;
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 861034d614..79a85723c9 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -61,6 +61,8 @@ struct LoongArchVirtMachineState {
     MemoryRegion iocsr_mem;
     AddressSpace as_iocsr;
     struct loongarch_boot_info bootinfo;
+    DeviceState *ipi;
+    DeviceState *extioi;
 };
 
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
-- 
2.39.3


