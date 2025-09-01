Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0167CCA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszl1-0004Ok-M7; Mon, 01 Sep 2025 04:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uszky-0004OA-C0
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 04:19:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uszku-0006v4-GM
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 04:19:16 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dx+tH1VrVoBEoFAA--.10945S3;
 Mon, 01 Sep 2025 16:19:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJAxVOT0VrVotoZ2AA--.46439S2;
 Mon, 01 Sep 2025 16:19:01 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: [PATCH v2] hw/loongarch/virt: Add reset interface for virt-machine
Date: Mon,  1 Sep 2025 16:19:00 +0800
Message-Id: <20250901081900.2931303-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxVOT0VrVotoZ2AA--.46439S2
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

With generic cpu reset interface, pc register is entry of FLASH for
UEFI BIOS. However with direct kernel booting requirement, there is
a little different, pc register of primary cpu is entry address of ELF
file.

At the same time with requirement of cpu hotplug, hot-added CPU should
register reset interface for this cpu object. Now reset callback is
not registered for hot-added CPU.

With this patch reset callback for CPU is register when CPU instance
is created, and reset interface is added for virt-machine board. In
reset interface of virt-machine, reset for direct kernel booting
requirement is called.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
v1 ... v2:
  1. Add qemu_unregister_reset() in function loongarch_cpu_unrealizefn(),
     remove reset callback if vCPU is unrealized.
---

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/boot.c         |  9 +--------
 hw/loongarch/virt.c         | 14 ++++++++++++++
 include/hw/loongarch/boot.h |  1 +
 target/loongarch/cpu.c      | 11 +++++++++++
 4 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 14d6c52d4e..4919758a20 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -324,12 +324,11 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
     return kernel_entry;
 }
 
-static void reset_load_elf(void *opaque)
+void reset_load_elf(void *opaque)
 {
     LoongArchCPU *cpu = opaque;
     CPULoongArchState *env = &cpu->env;
 
-    cpu_reset(CPU(cpu));
     if (env->load_elf) {
         if (cpu == LOONGARCH_CPU(first_cpu)) {
             env->gpr[4] = env->boot_info->a0;
@@ -429,12 +428,6 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
 void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
 {
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
-    int i;
-
-    /* register reset function */
-    for (i = 0; i < ms->smp.cpus; i++) {
-        qemu_register_reset(reset_load_elf, LOONGARCH_CPU(qemu_get_cpu(i)));
-    }
 
     info->kernel_filename = ms->kernel_filename;
     info->kernel_cmdline = ms->kernel_cmdline;
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index b15ada2078..4fc8506c10 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1199,6 +1199,19 @@ static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int idx)
     }
 }
 
+static void virt_reset(MachineState *machine, ResetType type)
+{
+    CPUState *cs;
+
+    /* Reset all devices including CPU devices */
+    qemu_devices_reset(type);
+
+    /* Reset PC and register context for kernel direct booting method */
+    CPU_FOREACH(cs) {
+        reset_load_elf(LOONGARCH_CPU(cs));
+    }
+}
+
 static void virt_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1223,6 +1236,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
     mc->has_hotpluggable_cpus = true;
     mc->get_hotplug_handler = virt_get_hotplug_handler;
     mc->default_nic = "virtio-net-pci";
+    mc->reset = virt_reset;
     hc->plug = virt_device_plug_cb;
     hc->pre_plug = virt_device_pre_plug;
     hc->unplug_request = virt_device_unplug_request;
diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
index 9819f7fbe3..386b4406ad 100644
--- a/include/hw/loongarch/boot.h
+++ b/include/hw/loongarch/boot.h
@@ -114,5 +114,6 @@ struct memmap_entry {
 };
 
 void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info);
+void reset_load_elf(void *opaque);
 
 #endif /* HW_LOONGARCH_BOOT_H */
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 3a7621c0ea..61c8acb3c2 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -652,6 +652,13 @@ static void loongarch_cpu_disas_set_info(CPUState *s, disassemble_info *info)
     info->print_insn = print_insn_loongarch;
 }
 
+#ifndef CONFIG_USER_ONLY
+static void loongarch_cpu_reset_cb(void *opaque)
+{
+    cpu_reset((CPUState *) opaque);
+}
+#endif
+
 static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -668,6 +675,9 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
 
     qemu_init_vcpu(cs);
     cpu_reset(cs);
+#ifndef CONFIG_USER_ONLY
+    qemu_register_reset(loongarch_cpu_reset_cb, dev);
+#endif
 
     lacc->parent_realize(dev, errp);
 }
@@ -678,6 +688,7 @@ static void loongarch_cpu_unrealizefn(DeviceState *dev)
 
 #ifndef CONFIG_USER_ONLY
     cpu_remove_sync(CPU(dev));
+    qemu_unregister_reset(loongarch_cpu_reset_cb, dev);
 #endif
 
     lacc->parent_unrealize(dev);

base-commit: 91589bcd9fee0e66b241d04e5f37cd4f218187a2
-- 
2.39.3


