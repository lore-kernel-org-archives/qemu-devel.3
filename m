Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0009FC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 08:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJq10-0003Ru-9z; Tue, 27 May 2025 04:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uJq0r-0003R9-HX
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:50:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uJq0l-0001YA-DX
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:50:21 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Ax3eLFfDVo9Bn+AA--.43303S3;
 Tue, 27 May 2025 16:50:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxLsfEfDVoXPz0AA--.46111S2;
 Tue, 27 May 2025 16:50:12 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v2 12/12] hw/loongarch/virt: Add kernel irqchip support
Date: Tue, 27 May 2025 16:50:12 +0800
Message-Id: <20250527085012.3468338-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250527084430.3468174-1-maobibo@loongson.cn>
References: <20250527084430.3468174-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsfEfDVoXPz0AA--.46111S2
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

If kvm_irqchip_in_kernel() return true, interrupt controller
ExtIOI, IPI, PCH_PCI and PCH_MSI should be emlated in kernel. And
it is not necessary to create memory region for these devices in
user space.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c        | 57 ++++++++++++++++++++++----------------
 target/loongarch/cpu.h     |  1 +
 target/loongarch/kvm/kvm.c | 16 +++++++++++
 3 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 69491fa31f..abc8aa2d67 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -401,12 +401,6 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     lvms->ipi = ipi;
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
 
-    /* IPI iocsr memory region */
-    memory_region_add_subregion(&lvms->system_iocsr, SMP_IPI_MAILBOX,
-                   sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 0));
-    memory_region_add_subregion(&lvms->system_iocsr, MAIL_SEND_ADDR,
-                   sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 1));
-
     /* Create EXTIOI device */
     extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
     lvms->extioi = extioi;
@@ -414,12 +408,6 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
         qdev_prop_set_bit(extioi, "has-virtualization-extension", true);
     }
     sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
-    memory_region_add_subregion(&lvms->system_iocsr, APIC_BASE,
-                    sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 0));
-    if (virt_is_veiointc_enabled(lvms)) {
-        memory_region_add_subregion(&lvms->system_iocsr, EXTIOI_VIRT_BASE,
-                    sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 1));
-    }
 
     virt_cpu_irq_init(lvms);
     pch_pic = qdev_new(TYPE_LOONGARCH_PIC);
@@ -427,13 +415,6 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     qdev_prop_set_uint32(pch_pic, "pch_pic_irq_num", num);
     d = SYS_BUS_DEVICE(pch_pic);
     sysbus_realize_and_unref(d, &error_fatal);
-    memory_region_add_subregion(get_system_memory(), VIRT_IOAPIC_REG_BASE,
-                            sysbus_mmio_get_region(d, 0));
-
-    /* Connect pch_pic irqs to extioi */
-    for (i = 0; i < num; i++) {
-        qdev_connect_gpio_out(DEVICE(d), i, qdev_get_gpio_in(extioi, i));
-    }
 
     pch_msi = qdev_new(TYPE_LOONGARCH_PCH_MSI);
     start   =  num;
@@ -443,12 +424,40 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
     d = SYS_BUS_DEVICE(pch_msi);
     sysbus_realize_and_unref(d, &error_fatal);
     sysbus_mmio_map(d, 0, VIRT_PCH_MSI_ADDR_LOW);
-    for (i = 0; i < num; i++) {
-        /* Connect pch_msi irqs to extioi */
-        qdev_connect_gpio_out(DEVICE(d), i,
-                              qdev_get_gpio_in(extioi, i + start));
-    }
 
+    if (kvm_irqchip_in_kernel()) {
+        kvm_loongarch_init_irq_routing();
+    } else {
+        /* IPI iocsr memory region */
+        memory_region_add_subregion(&lvms->system_iocsr, SMP_IPI_MAILBOX,
+                       sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 0));
+        memory_region_add_subregion(&lvms->system_iocsr, MAIL_SEND_ADDR,
+                       sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 1));
+
+        /* EXTIOI iocsr memory region */
+        memory_region_add_subregion(&lvms->system_iocsr, APIC_BASE,
+                    sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 0));
+        if (virt_is_veiointc_enabled(lvms)) {
+            memory_region_add_subregion(&lvms->system_iocsr, EXTIOI_VIRT_BASE,
+                    sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 1));
+        }
+
+        /* PCH_PIC memory region */
+        memory_region_add_subregion(get_system_memory(), VIRT_IOAPIC_REG_BASE,
+                    sysbus_mmio_get_region(SYS_BUS_DEVICE(pch_pic), 0));
+
+        /* Connect pch_pic irqs to extioi */
+        for (i = 0; i < VIRT_PCH_PIC_IRQ_NUM; i++) {
+            qdev_connect_gpio_out(DEVICE(pch_pic), i,
+                                  qdev_get_gpio_in(extioi, i));
+        }
+
+        for (i = VIRT_PCH_PIC_IRQ_NUM; i < EXTIOI_IRQS; i++) {
+            /* Connect pch_msi irqs to extioi */
+            qdev_connect_gpio_out(DEVICE(pch_msi), i - VIRT_PCH_PIC_IRQ_NUM,
+                                  qdev_get_gpio_in(extioi, i));
+        }
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
index 6e04dfc999..fdb4f86196 100644
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


