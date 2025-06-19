Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E139C761AE
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 08:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSAzQ-0004PJ-Qq; Thu, 19 Jun 2025 04:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uSAzO-0004Oz-JL
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 04:51:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uSAzK-0002w2-Vl
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 04:51:18 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxzOJ6z1NoeLUZAQ--.58196S3;
 Thu, 19 Jun 2025 16:51:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMAxDcVtz1NohtwgAQ--.30176S3;
 Thu, 19 Jun 2025 16:51:03 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 01/14] hw/intc/loongarch_extioi: Add kernel irqchip realize
 function
Date: Thu, 19 Jun 2025 16:28:04 +0800
Message-Id: <20250619082817.1517996-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250619082817.1517996-1-gaosong@loongson.cn>
References: <20250619082817.1517996-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxDcVtz1NohtwgAQ--.30176S3
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

From: Bibo Mao <maobibo@loongson.cn>

Function kvm_extioi_realize() is added if kvm_irqchip_in_kernel is
set. It is to create and initialize ExtIOI device in kernel mode.

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20250606063033.2557365-2-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_extioi.c         | 31 ++++++++++++--------
 hw/intc/loongarch_extioi_kvm.c     | 46 ++++++++++++++++++++++++++++++
 hw/intc/meson.build                |  2 ++
 include/hw/intc/loongarch_extioi.h |  3 ++
 4 files changed, 70 insertions(+), 12 deletions(-)
 create mode 100644 hw/intc/loongarch_extioi_kvm.c

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 7c38c4c9b7..837f649d6c 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -12,6 +12,7 @@
 #include "hw/irq.h"
 #include "hw/loongarch/virt.h"
 #include "system/address-spaces.h"
+#include "system/kvm.h"
 #include "hw/intc/loongarch_extioi.h"
 #include "trace.h"
 
@@ -351,23 +352,29 @@ static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    for (i = 0; i < EXTIOI_IRQS; i++) {
-        sysbus_init_irq(sbd, &s->irq[i]);
-    }
-
-    qdev_init_gpio_in(dev, extioi_setirq, EXTIOI_IRQS);
-    memory_region_init_io(&s->extioi_system_mem, OBJECT(s), &extioi_ops,
-                          s, "extioi_system_mem", 0x900);
-    sysbus_init_mmio(sbd, &s->extioi_system_mem);
-
     if (s->features & BIT(EXTIOI_HAS_VIRT_EXTENSION)) {
-        memory_region_init_io(&s->virt_extend, OBJECT(s), &extioi_virt_ops,
-                              s, "extioi_virt", EXTIOI_VIRT_SIZE);
-        sysbus_init_mmio(sbd, &s->virt_extend);
         s->features |= EXTIOI_VIRT_HAS_FEATURES;
     } else {
         s->status |= BIT(EXTIOI_ENABLE);
     }
+
+    if (kvm_irqchip_in_kernel()) {
+        kvm_extioi_realize(dev, errp);
+    } else {
+        for (i = 0; i < EXTIOI_IRQS; i++) {
+            sysbus_init_irq(sbd, &s->irq[i]);
+        }
+
+        qdev_init_gpio_in(dev, extioi_setirq, EXTIOI_IRQS);
+        memory_region_init_io(&s->extioi_system_mem, OBJECT(s), &extioi_ops,
+                              s, "extioi_system_mem", 0x900);
+        sysbus_init_mmio(sbd, &s->extioi_system_mem);
+        if (s->features & BIT(EXTIOI_HAS_VIRT_EXTENSION)) {
+            memory_region_init_io(&s->virt_extend, OBJECT(s), &extioi_virt_ops,
+                                  s, "extioi_virt", EXTIOI_VIRT_SIZE);
+            sysbus_init_mmio(sbd, &s->virt_extend);
+        }
+    }
 }
 
 static void loongarch_extioi_unrealize(DeviceState *dev)
diff --git a/hw/intc/loongarch_extioi_kvm.c b/hw/intc/loongarch_extioi_kvm.c
new file mode 100644
index 0000000000..e6d5dd379a
--- /dev/null
+++ b/hw/intc/loongarch_extioi_kvm.c
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch EXTIOI interrupt kvm support
+ *
+ * Copyright (C) 2025 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/typedefs.h"
+#include "hw/intc/loongarch_extioi.h"
+#include "linux/kvm.h"
+#include "qapi/error.h"
+#include "system/kvm.h"
+
+void kvm_extioi_realize(DeviceState *dev, Error **errp)
+{
+    LoongArchExtIOICommonState *lecs = LOONGARCH_EXTIOI_COMMON(dev);
+    LoongArchExtIOIState *les = LOONGARCH_EXTIOI(dev);
+    int ret;
+
+    ret = kvm_create_device(kvm_state, KVM_DEV_TYPE_LOONGARCH_EIOINTC, false);
+    if (ret < 0) {
+        fprintf(stderr, "create KVM_LOONGARCH_EIOINTC failed: %s\n",
+                strerror(-ret));
+        abort();
+    }
+
+    les->dev_fd = ret;
+    ret = kvm_device_access(les->dev_fd, KVM_DEV_LOONGARCH_EXTIOI_GRP_CTRL,
+                            KVM_DEV_LOONGARCH_EXTIOI_CTRL_INIT_NUM_CPU,
+                            &lecs->num_cpu, true, NULL);
+    if (ret < 0) {
+        fprintf(stderr, "KVM_LOONGARCH_EXTIOI_INIT_NUM_CPU failed: %s\n",
+                strerror(-ret));
+        abort();
+    }
+
+    ret = kvm_device_access(les->dev_fd, KVM_DEV_LOONGARCH_EXTIOI_GRP_CTRL,
+                            KVM_DEV_LOONGARCH_EXTIOI_CTRL_INIT_FEATURE,
+                            &lecs->features, true, NULL);
+    if (ret < 0) {
+        fprintf(stderr, "KVM_LOONGARCH_EXTIOI_INIT_FEATURE failed: %s\n",
+                strerror(-ret));
+        abort();
+    }
+}
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 602da304b0..70e7548c52 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -74,3 +74,5 @@ specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: files('loongarch_ipi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c', 'loongarch_pic_common.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c', 'loongarch_extioi_common.c'))
+specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_LOONGARCH_EXTIOI'],
+               if_true: files('loongarch_extioi_kvm.c'))
diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
index 4a6ae903e9..69565e14ab 100644
--- a/include/hw/intc/loongarch_extioi.h
+++ b/include/hw/intc/loongarch_extioi.h
@@ -15,6 +15,7 @@ OBJECT_DECLARE_TYPE(LoongArchExtIOIState, LoongArchExtIOIClass, LOONGARCH_EXTIOI
 
 struct LoongArchExtIOIState {
     LoongArchExtIOICommonState parent_obj;
+    int dev_fd;
 };
 
 struct LoongArchExtIOIClass {
@@ -25,4 +26,6 @@ struct LoongArchExtIOIClass {
     ResettablePhases parent_phases;
 };
 
+void kvm_extioi_realize(DeviceState *dev, Error **errp);
+
 #endif /* LOONGARCH_EXTIOI_H */
-- 
2.47.0


