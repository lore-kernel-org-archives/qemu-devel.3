Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2679C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 10:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDKir-0002Mi-IK; Fri, 09 May 2025 06:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uDKip-0002LY-UU
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:12:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uDKin-0001gQ-Lw
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:12:51 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxNHAf1R1oK2XbAA--.31410S3;
 Fri, 09 May 2025 18:12:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxXsUd1R1oACrAAA--.30666S6;
 Fri, 09 May 2025 18:12:46 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH 15/15] hw/loongarch/virt: Add kvm_irqchip_in_kernel support
Date: Fri,  9 May 2025 18:12:45 +0800
Message-Id: <20250509101245.1070255-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250509101245.1070255-1-maobibo@loongson.cn>
References: <20250509100747.1070094-1-maobibo@loongson.cn>
 <20250509101245.1070255-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxXsUd1R1oACrAAA--.30666S6
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

If kvm_irqchip_in_kernel option is set, set property irqchip-in-kernel
with ExtIOI, IPI, PCH_PCI and PCH_MSI interrupt controller, so that
irqchip in kernel is supported.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c        | 15 +++++++++++++++
 target/loongarch/cpu.h     |  1 +
 target/loongarch/kvm/kvm.c | 16 ++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 1b504047db..a79e77e663 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -398,6 +398,9 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
 
     /* Create IPI device */
     ipi = qdev_new(TYPE_LOONGARCH_IPI);
+    if (kvm_irqchip_in_kernel()) {
+        qdev_prop_set_bit(ipi, "irqchip-in-kernel", true);
+    }
     lvms->ipi = ipi;
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
 
@@ -413,6 +416,9 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     if (virt_is_veiointc_enabled(lvms)) {
         qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
     }
+    if (kvm_irqchip_in_kernel()) {
+        qdev_prop_set_bit(extioi, "irqchip-in-kernel", true);
+    }
     sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
     memory_region_add_subregion(&lvms->system_iocsr, APIC_BASE,
                     sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 0));
@@ -423,6 +429,9 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
 
     virt_cpu_irq_init(lvms);
     pch_pic = qdev_new(TYPE_LOONGARCH_PIC);
+    if (kvm_irqchip_in_kernel()) {
+        qdev_prop_set_bit(pch_pic, "irqchip-in-kernel", true);
+    }
     num = VIRT_PCH_PIC_IRQ_NUM;
     qdev_prop_set_uint32(pch_pic, "pch_pic_irq_num", num);
     d = SYS_BUS_DEVICE(pch_pic);
@@ -436,6 +445,9 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     }
 
     pch_msi = qdev_new(TYPE_LOONGARCH_PCH_MSI);
+    if (kvm_irqchip_in_kernel()) {
+        qdev_prop_set_bit(pch_msi, "irqchip-in-kernel", true);
+    }
     start   =  num;
     num = EXTIOI_IRQS - start;
     qdev_prop_set_uint32(pch_msi, "msi_irq_base", start);
@@ -449,6 +461,9 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
                               qdev_get_gpio_in(extioi, i + start));
     }
 
+    if (kvm_irqchip_in_kernel()) {
+        kvm_loongarch_init_irq_routing();
+    }
     virt_devices_init(pch_pic, lvms);
 }
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 262bf87f7b..9538e8d61d 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -503,5 +503,6 @@ static inline void kvm_loongarch_cpu_post_init(LoongArchCPU *cpu)
 {
 }
 #endif
+void kvm_loongarch_init_irq_routing(void);
 
 #endif /* LOONGARCH_CPU_H */
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index a8e5724b21..52a54f286b 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1236,6 +1236,22 @@ void kvm_arch_init_irq_routing(KVMState *s)
 {
 }
 
+void kvm_loongarch_init_irq_routing(void)
+{
+    int i;
+
+    kvm_async_interrupts_allowed = true;
+    kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
+    if (kvm_has_gsi_routing()) {
+        for (i = 0; i < 64; ++i) {
+            kvm_irqchip_add_irq_route(kvm_state, i, 0, i);
+        }
+
+        kvm_gsi_routing_allowed = true;
+        kvm_irqchip_commit_routes(kvm_state);
+    }
+}
+
 int kvm_arch_get_default_type(MachineState *ms)
 {
     return 0;
-- 
2.39.3


