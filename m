Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFB1CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN3K-0001X7-Qn; Sat, 30 Aug 2025 10:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1uroLr-0004vK-Vd
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 21:56:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1uroLk-0001Rd-Vv
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 21:56:27 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dx+tG1CLFohGsEAA--.8999S3;
 Fri, 29 Aug 2025 09:56:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJAxvsG1CLFobLRvAA--.44421S2;
 Fri, 29 Aug 2025 09:56:05 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] hw/loongarch/virt: Fix the cpu hotplug issue
Date: Fri, 29 Aug 2025 09:32:43 +0800
Message-Id: <20250829013243.1237107-1-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxvsG1CLFobLRvAA--.44421S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
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

The hot-plugged cpu does not register the cpu reset function, so the cpu
plugged in later cannot reset properly, and there will be problems when
restarting.

Now register the cpu reset function in the cpu hotplug callback function.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
 hw/loongarch/boot.c         | 8 +-------
 hw/loongarch/virt.c         | 4 ++++
 include/hw/loongarch/virt.h | 1 +
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 14d6c52d4e..6bc1f3d50c 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -324,7 +324,7 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
     return kernel_entry;
 }
 
-static void reset_load_elf(void *opaque)
+void reset_load_elf(void *opaque)
 {
     LoongArchCPU *cpu = opaque;
     CPULoongArchState *env = &cpu->env;
@@ -429,12 +429,6 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
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
index b15ada2078..71f8ddc980 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1013,6 +1013,8 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
     /* Notify acpi ged CPU removed */
     hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &error_abort);
 
+    /* unregister reset function */
+    qemu_unregister_reset(reset_load_elf, cpu);
     cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
     cpu_slot->cpu = NULL;
 }
@@ -1037,6 +1039,8 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
                              &error_abort);
     }
 
+    /* register reset function */
+    qemu_register_reset(reset_load_elf, cpu);
     cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
     cpu_slot->cpu = CPU(dev);
 }
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 602feab0f0..15ea393386 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -71,6 +71,7 @@ struct LoongArchVirtMachineState {
 OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
 void virt_acpi_setup(LoongArchVirtMachineState *lvms);
 void virt_fdt_setup(LoongArchVirtMachineState *lvms);
+void reset_load_elf(void *opaque);
 
 static inline bool virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
 {
-- 
2.39.1


