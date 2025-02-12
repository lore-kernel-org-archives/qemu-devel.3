Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B1BC0219E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 03:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti3F8-0000g9-Td; Tue, 11 Feb 2025 22:16:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ti3F4-0000e4-RV
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:16:50 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ti3F0-00017Q-3F
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:16:50 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxrOKZEqxnfshyAA--.29641S3;
 Wed, 12 Feb 2025 11:16:41 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxPseSEqxnkg0NAA--.51828S8;
 Wed, 12 Feb 2025 11:16:41 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 6/6] hw/loongarch/virt: CPU irq line connection improvement
Date: Wed, 12 Feb 2025 11:16:33 +0800
Message-Id: <20250212031633.3548108-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250212031633.3548108-1-maobibo@loongson.cn>
References: <20250212031633.3548108-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPseSEqxnkg0NAA--.51828S8
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

Interrupt controller extioi and ipi connect to CPU with irq line method.
With command -smp x, -device la464-loongarch-cpu, smp.cpus is not
accurate for all possible CPU objects, possible_cpu_arch_ids() is used.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c         | 60 ++++++++++++++++++++++---------------
 include/hw/loongarch/virt.h |  2 ++
 2 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index da98b21c58..f2aa0a9782 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -318,14 +318,43 @@ static void virt_devices_init(DeviceState *pch_pic,
     lvms->platform_bus_dev = create_platform_bus(pch_pic);
 }
 
-static void virt_irq_init(LoongArchVirtMachineState *lvms)
+static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
 {
+    int num, pin;
     MachineState *ms = MACHINE(lvms);
-    DeviceState *pch_pic, *pch_msi, *cpudev;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *possible_cpus;
+    CPUState *cs;
+
+    /* cpu nodes */
+    possible_cpus = mc->possible_cpu_arch_ids(ms);
+    for (num = 0; num < possible_cpus->len; num++) {
+        cs = possible_cpus->cpus[num].cpu;
+        if (cs == NULL) {
+            continue;
+        }
+
+        /* connect ipi irq to cpu irq */
+        qdev_connect_gpio_out(lvms->ipi, num,
+                              qdev_get_gpio_in(DEVICE(cs), IRQ_IPI));
+
+        /*
+         * connect ext irq to the cpu irq
+         * cpu_pin[9:2] <= intc_pin[7:0]
+         */
+        for (pin = 0; pin < LS3A_INTC_IP; pin++) {
+            qdev_connect_gpio_out(lvms->extioi, (num * LS3A_INTC_IP + pin),
+                                  qdev_get_gpio_in(DEVICE(cs), pin + 2));
+        }
+    }
+}
+
+static void virt_irq_init(LoongArchVirtMachineState *lvms)
+{
+    DeviceState *pch_pic, *pch_msi;
     DeviceState *ipi, *extioi;
     SysBusDevice *d;
-    CPUState *cpu_state;
-    int cpu, pin, i, start, num;
+    int i, start, num;
 
     /*
      * Extended IRQ model.
@@ -373,6 +402,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
 
     /* Create IPI device */
     ipi = qdev_new(TYPE_LOONGARCH_IPI);
+    lvms->ipi = ipi;
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
 
     /* IPI iocsr memory region */
@@ -381,16 +411,9 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     memory_region_add_subregion(&lvms->system_iocsr, MAIL_SEND_ADDR,
                    sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 1));
 
-    for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
-        cpu_state = qemu_get_cpu(cpu);
-        cpudev = DEVICE(cpu_state);
-
-        /* connect ipi irq to cpu irq */
-        qdev_connect_gpio_out(ipi, cpu, qdev_get_gpio_in(cpudev, IRQ_IPI));
-    }
-
     /* Create EXTIOI device */
     extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
+    lvms->extioi = extioi;
     if (virt_is_veiointc_enabled(lvms)) {
         qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
     }
@@ -402,18 +425,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
                     sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 1));
     }
 
-    /*
-     * connect ext irq to the cpu irq
-     * cpu_pin[9:2] <= intc_pin[7:0]
-     */
-    for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
-        cpudev = DEVICE(qemu_get_cpu(cpu));
-        for (pin = 0; pin < LS3A_INTC_IP; pin++) {
-            qdev_connect_gpio_out(extioi, (cpu * 8 + pin),
-                                  qdev_get_gpio_in(cpudev, pin + 2));
-        }
-    }
-
+    virt_cpu_irq_init(lvms);
     pch_pic = qdev_new(TYPE_LOONGARCH_PIC);
     num = VIRT_PCH_PIC_IRQ_NUM;
     qdev_prop_set_uint32(pch_pic, "pch_pic_irq_num", num);
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index f01350017b..661efae61d 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -60,6 +60,8 @@ struct LoongArchVirtMachineState {
     MemoryRegion iocsr_mem;
     AddressSpace as_iocsr;
     struct loongarch_boot_info bootinfo;
+    DeviceState *ipi;
+    DeviceState *extioi;
 };
 
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
-- 
2.43.5


