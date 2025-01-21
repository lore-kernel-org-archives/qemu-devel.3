Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B8FC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 12:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taD5j-0002LX-5w; Tue, 21 Jan 2025 07:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1taD5g-0002GF-LN
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:10:44 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1taD5d-0007Ph-1m
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:10:44 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Axjq+6jo9nMsNmAA--.46229S3;
 Tue, 21 Jan 2025 20:10:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxrcW4jo9nQ9ApAA--.26988S5;
 Tue, 21 Jan 2025 20:10:34 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 3/3] hw/loongarch/virt: CPU irq line connection improvement
Date: Tue, 21 Jan 2025 20:10:32 +0800
Message-Id: <20250121121032.475235-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250121121032.475235-1-maobibo@loongson.cn>
References: <20250121121032.475235-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxrcW4jo9nQ9ApAA--.26988S5
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
There are two improvements, one is move it to machine done callback,
and the other is to use possible_cpu_arch_ids() rather than smp.cpus.

With command -smp x, -device la464-loongarch-cpu, smp.cpus
is not accurate for all possible CPU objects, possible_cpu_arch_ids()
is used here.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c         | 60 ++++++++++++++++++++++---------------
 include/hw/loongarch/virt.h |  2 ++
 2 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 97c7da4815..1be4ca9cfd 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -681,6 +681,37 @@ static void virt_fdt_setup(LoongArchVirtMachineState *lvms)
             rom_ptr_for_as(&address_space_memory, FDT_BASE, lvms->fdt_size));
 }
 
+static void virt_cpu_irq_setup(LoongArchVirtMachineState *lvms)
+{
+    int num, pin;
+    MachineState *ms = MACHINE(lvms);
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
+            qdev_connect_gpio_out(lvms->extioi, (num * 8 + pin),
+                                  qdev_get_gpio_in(DEVICE(cs), pin + 2));
+        }
+    }
+}
+
 static void virt_done(Notifier *notifier, void *data)
 {
     LoongArchVirtMachineState *lvms = container_of(notifier,
@@ -688,6 +719,7 @@ static void virt_done(Notifier *notifier, void *data)
     virt_build_smbios(lvms);
     loongarch_acpi_setup(lvms);
     virt_fdt_setup(lvms);
+    virt_cpu_irq_setup(lvms);
 }
 
 static void virt_powerdown_req(Notifier *notifier, void *opaque)
@@ -844,12 +876,10 @@ static void virt_devices_init(DeviceState *pch_pic,
 
 static void virt_irq_init(LoongArchVirtMachineState *lvms)
 {
-    MachineState *ms = MACHINE(lvms);
-    DeviceState *pch_pic, *pch_msi, *cpudev;
+    DeviceState *pch_pic, *pch_msi;
     DeviceState *ipi, *extioi;
     SysBusDevice *d;
-    CPUState *cpu_state;
-    int cpu, pin, i, start, num;
+    int i, start, num;
 
     /*
      * Extended IRQ model.
@@ -897,6 +927,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
 
     /* Create IPI device */
     ipi = qdev_new(TYPE_LOONGARCH_IPI);
+    lvms->ipi = ipi;
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
 
     /* IPI iocsr memory region */
@@ -905,16 +936,9 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
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
@@ -926,18 +950,6 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
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
     pch_pic = qdev_new(TYPE_LOONGARCH_PIC);
     num = VIRT_PCH_PIC_IRQ_NUM;
     qdev_prop_set_uint32(pch_pic, "pch_pic_irq_num", num);
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 9ba47793ef..260e6bd7cf 100644
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
2.39.3


