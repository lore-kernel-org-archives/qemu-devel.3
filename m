Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DA3CA1010
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 02:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utdM2-0007mz-9I; Tue, 02 Sep 2025 22:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1utdLz-0007lx-AM
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 22:36:07 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1utdLw-0001sa-FO
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 22:36:07 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxLvCOqbdoGw0GAA--.12696S3;
 Wed, 03 Sep 2025 10:35:58 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDx_8ONqbdo7k96AA--.57635S5;
 Wed, 03 Sep 2025 10:35:58 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] hw/loongarch/virt: Register reset interface with CPU
 object
Date: Wed,  3 Sep 2025 10:35:56 +0800
Message-Id: <20250903023556.3082693-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250903023556.3082693-1-maobibo@loongson.cn>
References: <20250903023556.3082693-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDx_8ONqbdo7k96AA--.57635S5
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

With cpu hotplug is implemented on LoongArch virt machine, reset
interface with hot-added CPU should be registered. Otherwise there
will be problem if system reboots after cpu is hot-added.

Now register reset interface with CPU object is realized and remove
the reset interface with CPU object unrealizd.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/boot.c    | 13 -------------
 target/loongarch/cpu.c |  4 ++++
 2 files changed, 4 insertions(+), 13 deletions(-)

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
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 3a7621c0ea..9edb8ebc4d 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -668,6 +668,9 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
 
     qemu_init_vcpu(cs);
     cpu_reset(cs);
+ #ifndef CONFIG_USER_ONLY
+    qemu_register_resettable(OBJECT(dev));
+ #endif
 
     lacc->parent_realize(dev, errp);
 }
@@ -678,6 +681,7 @@ static void loongarch_cpu_unrealizefn(DeviceState *dev)
 
 #ifndef CONFIG_USER_ONLY
     cpu_remove_sync(CPU(dev));
+    qemu_unregister_resettable(OBJECT(dev));
 #endif
 
     lacc->parent_unrealize(dev);
-- 
2.39.3


