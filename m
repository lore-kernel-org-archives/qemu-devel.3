Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C17CC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 03:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTve1-0006HO-BY; Tue, 16 Jul 2024 23:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1sTvdv-0006G0-2C
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 23:47:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1sTvdp-00047Y-J0
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 23:47:50 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxbevaPpdm4loFAA--.13431S3;
 Wed, 17 Jul 2024 11:47:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx08TYPpdmIgdMAA--.29770S6; 
 Wed, 17 Jul 2024 11:47:38 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 kvm@vger.kernel.org, Bibo Mao <maobibo@loongson.cn>
Subject: [RFC 4/4] hw/loongarch: Add KVM pch msi device support
Date: Wed, 17 Jul 2024 11:29:56 +0800
Message-Id: <557ff785bfeb65131b0c02d6acdb015f6c09b09e.1721186636.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1721186636.git.lixianglai@loongson.cn>
References: <cover.1721186636.git.lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx08TYPpdmIgdMAA--.29770S6
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Added pch_msi interrupt controller handling
during kernel emulation of irq chip.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Paolo Bonzini <pbonzini@redhat.com> 
Cc: Song Gao <gaosong@loongson.cn> 
Cc: Huacai Chen <chenhuacai@kernel.org> 
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com> 
Cc: "Michael S. Tsirkin" <mst@redhat.com> 
Cc: Cornelia Huck <cohuck@redhat.com> 
Cc: kvm@vger.kernel.org 
Cc: Bibo Mao <maobibo@loongson.cn> 

 hw/intc/loongarch_pch_msi.c         | 42 +++++++++++++++++++++--------
 hw/loongarch/virt.c                 | 34 +++++++++++++++--------
 include/hw/intc/loongarch_pch_msi.h |  2 +-
 target/loongarch/kvm/kvm.c          |  1 -
 4 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/hw/intc/loongarch_pch_msi.c b/hw/intc/loongarch_pch_msi.c
index ecf3ed0267..c0a8b3a547 100644
--- a/hw/intc/loongarch_pch_msi.c
+++ b/hw/intc/loongarch_pch_msi.c
@@ -2,7 +2,7 @@
 /*
  * QEMU Loongson 7A1000 msi interrupt controller.
  *
- * Copyright (C) 2021 Loongson Technology Corporation Limited
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
  */
 
 #include "qemu/osdep.h"
@@ -14,6 +14,8 @@
 #include "hw/misc/unimp.h"
 #include "migration/vmstate.h"
 #include "trace.h"
+#include "sysemu/kvm.h"
+#include "hw/loongarch/virt.h"
 
 static uint64_t loongarch_msi_mem_read(void *opaque, hwaddr addr, unsigned size)
 {
@@ -26,14 +28,24 @@ static void loongarch_msi_mem_write(void *opaque, hwaddr addr,
     LoongArchPCHMSI *s = (LoongArchPCHMSI *)opaque;
     int irq_num;
 
-    /*
-     * vector number is irq number from upper extioi intc
-     * need subtract irq base to get msi vector offset
-     */
-    irq_num = (val & 0xff) - s->irq_base;
-    trace_loongarch_msi_set_irq(irq_num);
-    assert(irq_num < s->irq_num);
-    qemu_set_irq(s->pch_msi_irq[irq_num], 1);
+    MSIMessage msg = {
+        .address = addr,
+        .data = val,
+    };
+
+    if (kvm_kernel_irqchip_allowed()) {
+        kvm_irqchip_send_msi(kvm_state, msg);
+    } else {
+        /*
+         * vector number is irq number from upper extioi intc
+         * need subtract irq base to get msi vector offset
+         */
+        irq_num = (val & 0xff) - s->irq_base;
+        trace_loongarch_msi_set_irq(irq_num);
+        assert(irq_num < s->irq_num);
+
+        qemu_set_irq(s->pch_msi_irq[irq_num], 1);
+    }
 }
 
 static const MemoryRegionOps loongarch_pch_msi_ops = {
@@ -45,8 +57,16 @@ static const MemoryRegionOps loongarch_pch_msi_ops = {
 static void pch_msi_irq_handler(void *opaque, int irq, int level)
 {
     LoongArchPCHMSI *s = LOONGARCH_PCH_MSI(opaque);
-
-    qemu_set_irq(s->pch_msi_irq[irq], level);
+    MSIMessage msg = {
+        .address = 0,
+        .data = irq,
+    };
+
+    if (kvm_kernel_irqchip_allowed()) {
+        kvm_irqchip_send_msi(kvm_state, msg);
+    } else {
+        qemu_set_irq(s->pch_msi_irq[irq], level);
+    }
 }
 
 static void loongarch_pch_msi_realize(DeviceState *dev, Error **errp)
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 9e9e8f5d14..750a60ba91 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -884,24 +884,36 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
         for (i = 0; i < num; i++) {
             qdev_connect_gpio_out(DEVICE(d), i, qdev_get_gpio_in(extioi, i));
         }
+    }
 
-        /* Add PCH PIC node */
-        fdt_add_pch_pic_node(lvms, &eiointc_phandle, &pch_pic_phandle);
+    /* Add PCH PIC node */
+    fdt_add_pch_pic_node(lvms, &eiointc_phandle, &pch_pic_phandle);
 
-        pch_msi = qdev_new(TYPE_LOONGARCH_PCH_MSI);
-        start   =  num;
-        num = EXTIOI_IRQS - start;
-        qdev_prop_set_uint32(pch_msi, "msi_irq_base", start);
-        qdev_prop_set_uint32(pch_msi, "msi_irq_num", num);
-        d = SYS_BUS_DEVICE(pch_msi);
-        sysbus_realize_and_unref(d, &error_fatal);
-        sysbus_mmio_map(d, 0, VIRT_PCH_MSI_ADDR_LOW);
+    pch_msi = qdev_new(TYPE_LOONGARCH_PCH_MSI);
+    num = VIRT_PCH_PIC_IRQ_NUM;
+    start   =  num;
+    num = EXTIOI_IRQS - start;
+    qdev_prop_set_uint32(pch_msi, "msi_irq_base", start);
+    qdev_prop_set_uint32(pch_msi, "msi_irq_num", num);
+    d = SYS_BUS_DEVICE(pch_msi);
+    sysbus_realize_and_unref(d, &error_fatal);
+
+    if (kvm_kernel_irqchip_allowed()) {
+        if (kvm_has_gsi_routing()) {
+            for (i = 0; i < 64; ++i) {
+                kvm_irqchip_add_irq_route(kvm_state, i, 0, i);
+            }
+            kvm_gsi_routing_allowed = true;
+        }
+        kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
+    } else {
+        /* Connect pch_msi irqs to extioi */
         for (i = 0; i < num; i++) {
-            /* Connect pch_msi irqs to extioi */
             qdev_connect_gpio_out(DEVICE(d), i,
                                   qdev_get_gpio_in(extioi, i + start));
         }
     }
+    sysbus_mmio_map(d, 0, VIRT_PCH_MSI_ADDR_LOW);
 
     /* Add PCH MSI node */
     fdt_add_pch_msi_node(lvms, &eiointc_phandle, &pch_msi_phandle);
diff --git a/include/hw/intc/loongarch_pch_msi.h b/include/hw/intc/loongarch_pch_msi.h
index b8586fb3b6..fd4ea97a83 100644
--- a/include/hw/intc/loongarch_pch_msi.h
+++ b/include/hw/intc/loongarch_pch_msi.h
@@ -7,7 +7,7 @@
 
 #include "hw/sysbus.h"
 
-#define TYPE_LOONGARCH_PCH_MSI "loongarch_pch_msi"
+#define TYPE_LOONGARCH_PCH_MSI     "loongarch_pch_msi"
 OBJECT_DECLARE_SIMPLE_TYPE(LoongArchPCHMSI, LOONGARCH_PCH_MSI)
 
 /* MSI irq start from 32 to 255 */
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index c07dcfd85f..e1be6a6959 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -719,7 +719,6 @@ int kvm_arch_get_default_type(MachineState *ms)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
-    s->kernel_irqchip_allowed = false;
     cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
     return 0;
 }
-- 
2.39.1


