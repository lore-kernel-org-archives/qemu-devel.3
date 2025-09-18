Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDE1CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzBBt-0004Sb-A9; Thu, 18 Sep 2025 05:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uzBBp-0004Pl-FJ
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:44:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uzBBk-0003YS-By
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:44:33 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxXNJ21Mtov8ALAA--.25506S3;
 Thu, 18 Sep 2025 17:44:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxQ+Ry1Mto4ladAA--.45902S5;
 Thu, 18 Sep 2025 17:44:21 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
	Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 3/3] hw/loongarch/virt: Register reset interface with cpu plug
 callback
Date: Thu, 18 Sep 2025 17:20:47 +0800
Message-Id: <20250918092047.785269-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250918092047.785269-1-gaosong@loongson.cn>
References: <20250918092047.785269-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxQ+Ry1Mto4ladAA--.45902S5
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

From: Bibo Mao <maobibo@loongson.cn>

With cpu hotplug is implemented on LoongArch virt machine, reset
interface with hot-added CPU should be registered. Otherwise there
will be problem if system reboots after cpu is hot-added.

Now register reset interface with CPU plug callback, so that all
cold/hot added CPUs let their reset interface registered. And remove
reset interface with CPU unplug callback.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20250906070200.3749326-4-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/boot.c | 13 -------------
 hw/loongarch/virt.c |  2 ++
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 5799b4c75c..a516415822 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -350,13 +350,6 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
     return kernel_entry;
 }
 
-static void reset_load_elf(void *opaque)
-{
-    LoongArchCPU *cpu = opaque;
-
-    cpu_reset(CPU(cpu));
-}
-
 static void fw_cfg_add_kernel_info(struct loongarch_boot_info *info,
                                    FWCfgState *fw_cfg)
 {
@@ -439,12 +432,6 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
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
index 31215b7785..bd5cff1f1e 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1014,6 +1014,7 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
     /* Notify acpi ged CPU removed */
     hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &error_abort);
 
+    qemu_unregister_resettable(OBJECT(dev));
     cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
     cpu_slot->cpu = NULL;
 }
@@ -1038,6 +1039,7 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
                              &error_abort);
     }
 
+    qemu_register_resettable(OBJECT(dev));
     cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
     cpu_slot->cpu = CPU(dev);
 }
-- 
2.47.0


