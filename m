Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B081DC71136
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 03:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS5YW-00075U-W6; Wed, 18 Jun 2025 23:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uS5YV-00074t-1i
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 23:03:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uS5YS-0006Be-Ug
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 23:03:10 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx7eLkfVNow44ZAQ--.23265S3;
 Thu, 19 Jun 2025 11:03:00 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCxrhu7fVNoIXkgAQ--.48014S8;
 Thu, 19 Jun 2025 11:02:55 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v2 6/9] hw/loongarch: Implement avec controller imput and
 output pins
Date: Thu, 19 Jun 2025 10:39:41 +0800
Message-Id: <20250619023944.1278716-7-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250619023944.1278716-1-gaosong@loongson.cn>
References: <20250619023944.1278716-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxrhu7fVNoIXkgAQ--.48014S8
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

the AVEC controller supports 256*256 irqs input, all the irqs connect CPU INT_AVEC irq

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_avec.c | 21 +++++++++++++++++++++
 hw/loongarch/virt.c      | 11 +++++++++--
 target/loongarch/cpu.h   |  3 ++-
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
index 4bd431220a..7dd8bac696 100644
--- a/hw/intc/loongarch_avec.c
+++ b/hw/intc/loongarch_avec.c
@@ -38,7 +38,12 @@ static const MemoryRegionOps loongarch_avec_ops = {
 
 static void loongarch_avec_realize(DeviceState *dev, Error **errp)
 {
+    LoongArchAVECState *s = LOONGARCH_AVEC(dev);
     LoongArchAVECClass *lac = LOONGARCH_AVEC_GET_CLASS(dev);
+    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const CPUArchIdList  *id_list;
+    int i;
 
     Error *local_err = NULL;
     lac->parent_realize(dev, &local_err);
@@ -47,6 +52,22 @@ static void loongarch_avec_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    assert(mc->possible_cpu_arch_ids);
+    id_list = mc->possible_cpu_arch_ids(machine);
+    s->num_cpu = id_list->len;
+    s->cpu = g_new(AVECCore, s->num_cpu);
+    if (s->cpu == NULL) {
+        error_setg(errp, "Memory allocation for AVECCore fail");
+        return;
+    }
+
+    for (i = 0; i < s->num_cpu; i++) {
+        s->cpu[i].arch_id = id_list->cpus[i].arch_id;
+        s->cpu[i].cpu = CPU(id_list->cpus[i].cpu);
+        qdev_init_gpio_out(dev, &s->cpu[i].parent_irq, 1);
+    }
+    qdev_init_gpio_in(dev, NULL, NR_VECTORS * s->num_cpu);
+
     return;
 }
 
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 664705ce6e..18ff41f2ad 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -368,7 +368,7 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
     }
 }
 
-static void virt_irq_init(LoongArchVirtMachineState *lvms)
+static void virt_irq_init(LoongArchVirtMachineState *lvms, MachineState *ms)
 {
     DeviceState *pch_pic, *pch_msi;
     DeviceState *ipi, *extioi, *avec;
@@ -464,6 +464,13 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
         sysbus_realize_and_unref(SYS_BUS_DEVICE(avec), &error_fatal);
         memory_region_add_subregion(get_system_memory(), VIRT_AVEC_BASE,
                         sysbus_mmio_get_region(SYS_BUS_DEVICE(avec), 0));
+        CPUState *cpu_state;
+        DeviceState *cpudev;
+        for (int cpu = 0; cpu < ms->smp.cpus; cpu++) {
+            cpu_state = qemu_get_cpu(cpu);
+            cpudev = DEVICE(cpu_state);
+            qdev_connect_gpio_out(avec, cpu, qdev_get_gpio_in(cpudev, INT_AVEC));
+        }
     }
 
     /* Create EXTIOI device */
@@ -809,7 +816,7 @@ static void virt_init(MachineState *machine)
     }
 
     /* Initialize the IO interrupt subsystem */
-    virt_irq_init(lvms);
+    virt_irq_init(lvms, machine);
     lvms->machine_done.notify = virt_done;
     qemu_add_machine_init_done_notifier(&lvms->machine_done);
      /* connect powerdown request */
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 231ad5a7cb..d5e64c5e8e 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -217,9 +217,10 @@ FIELD(CSR_CRMD, WE, 9, 1)
 extern const char * const regnames[32];
 extern const char * const fregnames[32];
 
-#define N_IRQS      13
+#define N_IRQS      15
 #define IRQ_TIMER   11
 #define IRQ_IPI     12
+#define INT_AVEC    14
 
 #define LOONGARCH_STLB         2048 /* 2048 STLB */
 #define LOONGARCH_MTLB         64   /* 64 MTLB */
-- 
2.34.1


