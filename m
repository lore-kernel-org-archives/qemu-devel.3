Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672A9C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 03:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thgdp-0007C9-9U; Mon, 10 Feb 2025 22:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1thgdm-0007AO-NA
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 22:08:50 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1thgdi-0000M1-Kq
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 22:08:50 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxjXI3v6pnEtdxAA--.1578S3;
 Tue, 11 Feb 2025 11:08:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxbsUyv6pnL1YLAA--.43924S7;
 Tue, 11 Feb 2025 11:08:38 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: [PATCH v5 5/7] hw/loongarch/virt: Implement cpu plug interface
Date: Tue, 11 Feb 2025 11:08:32 +0800
Message-Id: <20250211030834.3276732-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250211030834.3276732-1-maobibo@loongson.cn>
References: <20250211030834.3276732-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxbsUyv6pnL1YLAA--.43924S7
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Implement cpu plug interface, and cold-plug cpu uses plug interface
when cpu object is created.

Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c    | 88 ++++++++++++++++++++++++++++++++++++------
 target/loongarch/cpu.c |  1 +
 2 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 44c2a277f8..917b13a58a 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -655,15 +655,13 @@ static void fw_cfg_add_memory(MachineState *ms)
 
 static void virt_init(MachineState *machine)
 {
-    LoongArchCPU *lacpu;
     const char *cpu_model = machine->cpu_type;
     MemoryRegion *address_space_mem = get_system_memory();
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
     int i;
     hwaddr base, size, ram_size = machine->ram_size;
-    const CPUArchIdList *possible_cpus;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
-    CPUState *cpu;
+    Object *cpuobj;
 
     if (!cpu_model) {
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
@@ -679,14 +677,15 @@ static void virt_init(MachineState *machine)
     memory_region_add_subregion(&lvms->system_iocsr, 0, &lvms->iocsr_mem);
 
     /* Init CPUs */
-    possible_cpus = mc->possible_cpu_arch_ids(machine);
-    for (i = 0; i < possible_cpus->len; i++) {
-        cpu = cpu_create(machine->cpu_type);
-        cpu->cpu_index = i;
-        machine->possible_cpus->cpus[i].cpu = cpu;
-        lacpu = LOONGARCH_CPU(cpu);
-        lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
-        lacpu->env.address_space_iocsr = &lvms->as_iocsr;
+    mc->possible_cpu_arch_ids(machine);
+    for (i = 0; i < machine->smp.cpus; i++) {
+        cpuobj = object_new(machine->cpu_type);
+        if (cpuobj == NULL) {
+            error_report("Fail to create object with type %s ",
+                         machine->cpu_type);
+            exit(EXIT_FAILURE);
+        }
+        qdev_realize_and_unref(DEVICE(cpuobj), NULL, &error_fatal);
     }
     fw_cfg_add_memory(machine);
 
@@ -837,9 +836,52 @@ static CPUArchId *virt_find_cpu_slot(MachineState *ms, int arch_id)
     return NULL;
 }
 
+/* Find cpu slot for cold-plut CPU object where cpu is NULL */
+static CPUArchId *virt_find_empty_cpu_slot(MachineState *ms)
+{
+    int n;
+    for (n = 0; n < ms->possible_cpus->len; n++) {
+        if (ms->possible_cpus->cpus[n].cpu == NULL) {
+            return &ms->possible_cpus->cpus[n];
+        }
+    }
+
+    return NULL;
+}
+
 static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
                               DeviceState *dev, Error **errp)
 {
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
+    MachineState *ms = MACHINE(OBJECT(hotplug_dev));
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    CPUState *cs = CPU(dev);
+    CPUArchId *cpu_slot;
+    Error *err = NULL;
+    LoongArchCPUTopo topo;
+
+    if (lvms->acpi_ged) {
+        error_setg(&err, "CPU hotplug not supported");
+        goto out;
+    } else {
+        /* For cold-add cpu, find empty cpu slot */
+        cpu_slot = virt_find_empty_cpu_slot(ms);
+        topo.socket_id = cpu_slot->props.socket_id;
+        topo.core_id = cpu_slot->props.core_id;
+        topo.thread_id = cpu_slot->props.thread_id;
+        object_property_set_int(OBJECT(dev), "socket-id", topo.socket_id, NULL);
+        object_property_set_int(OBJECT(dev), "core-id", topo.core_id, NULL);
+        object_property_set_int(OBJECT(dev), "thread-id", topo.thread_id, NULL);
+    }
+
+    cpu->env.address_space_iocsr = &lvms->as_iocsr;
+    cpu->phy_id = cpu_slot->arch_id;
+    cs->cpu_index = cpu_slot - ms->possible_cpus->cpus;
+    numa_cpu_pre_plug(cpu_slot, dev, &err);
+out:
+    if (err) {
+        error_propagate(errp, err);
+    }
 }
 
 static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
@@ -900,6 +942,30 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
 static void virt_cpu_plug(HotplugHandler *hotplug_dev,
                           DeviceState *dev, Error **errp)
 {
+    CPUArchId *cpu_slot;
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
+    Error *err = NULL;
+
+    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
+    cpu_slot->cpu = CPU(dev);
+    if (lvms->ipi) {
+        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->ipi), dev, &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
+
+    if (lvms->extioi) {
+        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), dev, &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
+
+    return;
 }
 
 static bool memhp_type_supported(DeviceState *dev)
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 7e38949c56..54b0da7492 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -962,6 +962,7 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
 #ifdef CONFIG_TCG
     cc->tcg_ops = &loongarch_tcg_ops;
 #endif
+    dc->user_creatable = true;
 }
 
 static const gchar *loongarch32_gdb_arch_name(CPUState *cs)
-- 
2.39.3


