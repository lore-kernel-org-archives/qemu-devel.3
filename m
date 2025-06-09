Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1236C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 12:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOaPP-0005Ef-R7; Mon, 09 Jun 2025 07:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uOaPL-0005CY-9Q
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 07:11:15 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uOaPH-00075T-0Y
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 07:11:15 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxQK9IwUZoVW4RAQ--.9089S3;
 Mon, 09 Jun 2025 19:11:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMAxzxtFwUZoiU0SAQ--.4222S8;
 Mon, 09 Jun 2025 19:11:04 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH 06/10] hw/loongarch: Implement avec controller imput and
 output pins
Date: Mon,  9 Jun 2025 18:48:29 +0800
Message-Id: <20250609104833.839811-7-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250609104833.839811-1-gaosong@loongson.cn>
References: <20250609104833.839811-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzxtFwUZoiU0SAQ--.4222S8
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

the AVEC controller supports 256*256 irqs, all the irqs connect CPU INT_AVEC irq

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_avec.c | 28 ++++++++++++++++++++++++++++
 hw/loongarch/virt.c      | 11 +++++++++--
 target/loongarch/cpu.h   |  3 ++-
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
index 50956e7e4e..c692fef43c 100644
--- a/hw/intc/loongarch_avec.c
+++ b/hw/intc/loongarch_avec.c
@@ -36,9 +36,19 @@ static const MemoryRegionOps loongarch_avec_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static void avec_irq_handler(void *opaque, int irq, int level)
+{
+    return;
+}
+
 static void loongarch_avec_realize(DeviceState *dev, Error **errp)
 {
+    LoongArchAVECState *s = LOONGARCH_AVEC(dev);
     LoongArchAVECClass *lac = LOONGARCH_AVEC_GET_CLASS(dev);
+    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const CPUArchIdList  *id_list;
+    int i, irq;
 
     Error *local_err = NULL;
     lac->parent_realize(dev, &local_err);
@@ -47,6 +57,24 @@ static void loongarch_avec_realize(DeviceState *dev, Error **errp)
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
+        for (irq = 0; irq < NR_VECTORS; irq++) {
+            qdev_init_gpio_out(dev, &s->cpu[i].parent_irq[irq], 1);
+        }
+    }
+    qdev_init_gpio_in(dev, avec_irq_handler, NR_VECTORS * s->num_cpu);
+
     return;
 }
 
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 272355da2d..718b5b4f92 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -363,7 +363,7 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
     }
 }
 
-static void virt_irq_init(LoongArchVirtMachineState *lvms)
+static void virt_irq_init(LoongArchVirtMachineState *lvms, MachineState *ms)
 {
     DeviceState *pch_pic, *pch_msi;
     DeviceState *ipi, *extioi, *avec;
@@ -459,6 +459,13 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
         sysbus_realize_and_unref(SYS_BUS_DEVICE(avec), &error_fatal);
         memory_region_add_subregion(get_system_memory(), VIRT_PCH_MSI_ADDR_LOW,
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
@@ -799,7 +806,7 @@ static void virt_init(MachineState *machine)
     }
 
     /* Initialize the IO interrupt subsystem */
-    virt_irq_init(lvms);
+    virt_irq_init(lvms, machine);
     lvms->machine_done.notify = virt_done;
     qemu_add_machine_init_done_notifier(&lvms->machine_done);
      /* connect powerdown request */
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index a1918a85da..b96df1cb2a 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -240,9 +240,10 @@ FIELD(CSR_CRMD, WE, 9, 1)
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


