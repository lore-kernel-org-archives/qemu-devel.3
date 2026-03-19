Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF21B108E1F9
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3By5-0002hw-TC; Thu, 19 Mar 2026 07:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1w3By4-0002fT-7O
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:55:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1w3By0-0002Nj-T1
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:55:11 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx76sU5LtpvaocAA--.23648S3;
 Thu, 19 Mar 2026 19:55:00 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxPMIO5Ltp3qBYAA--.36678S4;
 Thu, 19 Mar 2026 19:54:58 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, lixianglai@loongson.cn
Subject: [RFC PATCH v3 2/2] Add dintc kvm_irqchip_in_kernel support
Date: Thu, 19 Mar 2026 19:29:30 +0800
Message-Id: <20260319112930.2255004-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260319112930.2255004-1-gaosong@loongson.cn>
References: <20260319112930.2255004-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxPMIO5Ltp3qBYAA--.36678S4
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Function kvm_dintc_realize() is added if kvm_irqchip_in_kernel is
set. It is to create and initialize DINTC device in kernel mode.
and use kvm_irqchip_send_msi() to send  msi to kernel.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_dintc.c         | 13 +++++++++
 hw/intc/loongarch_dintc_kvm.c     | 48 +++++++++++++++++++++++++++++++
 hw/intc/meson.build               |  2 ++
 include/hw/intc/loongarch_dintc.h | 10 +++++++
 linux-headers/asm-loongarch/kvm.h |  4 +++
 linux-headers/linux/kvm.h         |  2 ++
 6 files changed, 79 insertions(+)
 create mode 100644 hw/intc/loongarch_dintc_kvm.c

diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
index c42a919df4..b8bd7ae015 100644
--- a/hw/intc/loongarch_dintc.c
+++ b/hw/intc/loongarch_dintc.c
@@ -53,6 +53,15 @@ static void loongarch_dintc_mem_write(void *opaque, hwaddr addr,
     cs = cpu_by_arch_id(cpu_num);
     irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
 
+    if (kvm_irqchip_in_kernel()) {
+        MSIMessage msg;
+
+        msg.address = msg_addr;
+        msg.data = val;
+        kvm_irqchip_send_msi(kvm_state, msg);
+        return;
+    }
+
     async_run_on_cpu(cs, do_set_vcpu_dintc_irq,
                          RUN_ON_CPU_HOST_INT(irq_num));
     qemu_set_irq(s->cpu[cpu_num].parent_irq, 1);
@@ -95,6 +104,10 @@ static void loongarch_dintc_realize(DeviceState *dev, Error **errp)
         qdev_init_gpio_out(dev, &s->cpu[i].parent_irq, 1);
     }
 
+    if (kvm_irqchip_in_kernel()) {
+        kvm_dintc_realize(dev, errp);
+    }
+
     return;
 }
 
diff --git a/hw/intc/loongarch_dintc_kvm.c b/hw/intc/loongarch_dintc_kvm.c
new file mode 100644
index 0000000000..16da33d0b7
--- /dev/null
+++ b/hw/intc/loongarch_dintc_kvm.c
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch DINTC interrupt kvm support
+ *
+ * Copyright (C) 2025 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include "hw/intc/loongarch_dintc.h"
+#include "linux/kvm.h"
+#include "qapi/error.h"
+#include "system/kvm.h"
+
+void kvm_dintc_realize(DeviceState *dev, Error **errp)
+{
+    LoongArchDINTCState *lds = LOONGARCH_DINTC(dev);
+    int ret;
+
+    ret = kvm_create_device(kvm_state, KVM_DEV_TYPE_LOONGARCH_DINTC, false);
+    if (ret < 0) {
+        fprintf(stderr, "create KVM_DEV_TYPE_LOONGARCH_AVEC failed: %s\n",
+               strerror(-ret));
+        abort();
+    }
+    lds->dev_fd = ret;
+
+    /* init dintc config */
+    lds->msg_addr_base = VIRT_DINTC_BASE;
+    lds->msg_addr_size = VIRT_DINTC_SIZE;
+
+    ret = kvm_device_access(lds->dev_fd, KVM_DEV_LOONGARCH_DINTC_CTRL,
+                            KVM_DEV_LOONGARCH_DINTC_MSG_ADDR_BASE,
+                            &lds->msg_addr_base, true, NULL);
+    if (ret < 0) {
+        fprintf(stderr, "KVM_DEV_LOONGARCH_DINTC_MSG_ADDR_BASE failed: %s\n",
+                strerror(ret));
+        abort();
+    }
+
+    ret = kvm_device_access(lds->dev_fd, KVM_DEV_LOONGARCH_DINTC_CTRL,
+                            KVM_DEV_LOONGARCH_DINTC_MSG_ADDR_SIZE,
+                            &lds->msg_addr_size, true, NULL);
+    if (ret < 0) {
+        fprintf(stderr, "KVM_DEV_LOONGARCH_DINTC_MSG_ADDR_SIZE failed: %s\n",
+                strerror(ret));
+        abort();
+    }
+}
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 96742df090..015c1e67e4 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -82,3 +82,5 @@ specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extio
 specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_LOONGARCH_EXTIOI'],
                if_true: files('loongarch_extioi_kvm.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_DINTC', if_true: files('loongarch_dintc.c'))
+specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_LOONGARCH_DINTC'],
+               if_true: files('loongarch_dintc_kvm.c'))
diff --git a/include/hw/intc/loongarch_dintc.h b/include/hw/intc/loongarch_dintc.h
index 1f4f65705a..95a7879e26 100644
--- a/include/hw/intc/loongarch_dintc.h
+++ b/include/hw/intc/loongarch_dintc.h
@@ -9,8 +9,13 @@
 #include "hw/core/sysbus.h"
 #include "hw/loongarch/virt.h"
 #include "system/memory.h"
+#include "hw/pci-host/ls7a.h"
 
 #define NR_VECTORS     256
+#define IRQ_BIT_BASE    5
+#define IRQ_BIT_LEN     8
+#define CPU_BIT_BASE   13
+#define CPU_BIT_LEN     8
 
 #define TYPE_LOONGARCH_DINTC "loongarch_dintc"
 OBJECT_DECLARE_TYPE(LoongArchDINTCState, LoongArchDINTCClass, LOONGARCH_DINTC)
@@ -25,7 +30,10 @@ struct LoongArchDINTCState {
     SysBusDevice parent_obj;
     MemoryRegion dintc_mmio;
     DINTCCore *cpu;
+    int dev_fd;
     uint32_t num_cpu;
+    uint64_t msg_addr_base;
+    uint64_t msg_addr_size;
 };
 
 struct LoongArchDINTCClass {
@@ -34,3 +42,5 @@ struct LoongArchDINTCClass {
     DeviceRealize parent_realize;
     DeviceUnrealize parent_unrealize;
 };
+
+void kvm_dintc_realize(DeviceState *dev, Error **errp);
diff --git a/linux-headers/asm-loongarch/kvm.h b/linux-headers/asm-loongarch/kvm.h
index de6c3f18e4..eabc61ed68 100644
--- a/linux-headers/asm-loongarch/kvm.h
+++ b/linux-headers/asm-loongarch/kvm.h
@@ -154,4 +154,8 @@ struct kvm_iocsr_entry {
 #define KVM_DEV_LOONGARCH_PCH_PIC_GRP_CTRL	        0x40000006
 #define KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT	        0
 
+#define KVM_DEV_LOONGARCH_DINTC_CTRL                   0x40000007
+#define  KVM_DEV_LOONGARCH_DINTC_MSG_ADDR_BASE         0x0
+#define  KVM_DEV_LOONGARCH_DINTC_MSG_ADDR_SIZE         0x1
+
 #endif /* __UAPI_ASM_LOONGARCH_KVM_H */
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index a4ab42dcba..c721bb9ffa 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1201,6 +1201,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_LOONGARCH_EIOINTC	KVM_DEV_TYPE_LOONGARCH_EIOINTC
 	KVM_DEV_TYPE_LOONGARCH_PCHPIC,
 #define KVM_DEV_TYPE_LOONGARCH_PCHPIC	KVM_DEV_TYPE_LOONGARCH_PCHPIC
+       KVM_DEV_TYPE_LOONGARCH_DINTC,
+#define KVM_DEV_TYPE_LOONGARCH_DINTC   KVM_DEV_TYPE_LOONGARCH_DINTC
 
 	KVM_DEV_TYPE_MAX,
 
-- 
2.41.0


