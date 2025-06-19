Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE49C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 08:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSAzX-0004TL-4R; Thu, 19 Jun 2025 04:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uSAzT-0004R1-Ob
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 04:51:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uSAzR-0002xw-IR
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 04:51:23 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxYa+Gz1NoirUZAQ--.18727S3;
 Thu, 19 Jun 2025 16:51:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMAxDcVtz1NohtwgAQ--.30176S9;
 Thu, 19 Jun 2025 16:51:17 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 07/14] hw/intc/loongarch_pch: Add kernel irqchip realize
 function
Date: Thu, 19 Jun 2025 16:28:10 +0800
Message-Id: <20250619082817.1517996-8-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250619082817.1517996-1-gaosong@loongson.cn>
References: <20250619082817.1517996-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxDcVtz1NohtwgAQ--.30176S9
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

Function kvm_pic_realize() is added if kvm_irqchip_in_kernel() return true.
It is to notify KVM kernel to create and initialize PCH PCI device in
kernel mode.

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20250606063033.2557365-8-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c         | 14 ++++++++---
 hw/intc/loongarch_pic_kvm.c         | 38 +++++++++++++++++++++++++++++
 hw/intc/meson.build                 |  2 ++
 include/hw/intc/loongarch_pch_pic.h |  3 +++
 4 files changed, 53 insertions(+), 4 deletions(-)
 create mode 100644 hw/intc/loongarch_pic_kvm.c

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index ebb33ed0b0..6ac3a72c31 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -10,6 +10,7 @@
 #include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/intc/loongarch_pch_pic.h"
+#include "system/kvm.h"
 #include "trace.h"
 #include "qapi/error.h"
 
@@ -275,10 +276,15 @@ static void loongarch_pic_realize(DeviceState *dev, Error **errp)
 
     qdev_init_gpio_out(dev, s->parent_irq, s->irq_num);
     qdev_init_gpio_in(dev, pch_pic_irq_handler, s->irq_num);
-    memory_region_init_io(&s->iomem, OBJECT(dev),
-                          &loongarch_pch_pic_ops,
-                          s, TYPE_LOONGARCH_PIC, VIRT_PCH_REG_SIZE);
-    sysbus_init_mmio(sbd, &s->iomem);
+
+    if (kvm_irqchip_in_kernel()) {
+        kvm_pic_realize(dev, errp);
+    } else {
+        memory_region_init_io(&s->iomem, OBJECT(dev),
+                              &loongarch_pch_pic_ops,
+                              s, TYPE_LOONGARCH_PIC, VIRT_PCH_REG_SIZE);
+        sysbus_init_mmio(sbd, &s->iomem);
+    }
 }
 
 static void loongarch_pic_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/intc/loongarch_pic_kvm.c b/hw/intc/loongarch_pic_kvm.c
new file mode 100644
index 0000000000..ee77f04a13
--- /dev/null
+++ b/hw/intc/loongarch_pic_kvm.c
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch kvm pch pic interrupt support
+ *
+ * Copyright (C) 2025 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "hw/intc/loongarch_pch_pic.h"
+#include "hw/loongarch/virt.h"
+#include "hw/pci-host/ls7a.h"
+#include "system/kvm.h"
+
+void kvm_pic_realize(DeviceState *dev, Error **errp)
+{
+    LoongarchPICState *lps = LOONGARCH_PIC(dev);
+    uint64_t pch_pic_base = VIRT_PCH_REG_BASE;
+    int ret;
+
+    ret = kvm_create_device(kvm_state, KVM_DEV_TYPE_LOONGARCH_PCHPIC, false);
+    if (ret < 0) {
+        fprintf(stderr, "Create KVM_LOONGARCH_PCHPIC failed: %s\n",
+                strerror(-ret));
+        abort();
+    }
+
+    lps->dev_fd = ret;
+    ret = kvm_device_access(lps->dev_fd, KVM_DEV_LOONGARCH_PCH_PIC_GRP_CTRL,
+                            KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT,
+                            &pch_pic_base, true, NULL);
+    if (ret < 0) {
+        fprintf(stderr, "KVM_LOONGARCH_PCH_PIC_INIT failed: %s\n",
+                strerror(-ret));
+        abort();
+    }
+}
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 1cc999771d..3137521a4a 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -74,6 +74,8 @@ specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: files('loongarch_ipi.c'))
 specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_LOONGARCH_IPI'],
                 if_true: files('loongarch_ipi_kvm.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c', 'loongarch_pic_common.c'))
+specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_LOONGARCH_PCH_PIC'],
+                if_true: files('loongarch_pic_kvm.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c', 'loongarch_extioi_common.c'))
 specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_LOONGARCH_EXTIOI'],
diff --git a/include/hw/intc/loongarch_pch_pic.h b/include/hw/intc/loongarch_pch_pic.h
index 839a59a43b..4b52f1165f 100644
--- a/include/hw/intc/loongarch_pch_pic.h
+++ b/include/hw/intc/loongarch_pch_pic.h
@@ -16,6 +16,7 @@ OBJECT_DECLARE_TYPE(LoongarchPICState, LoongarchPICClass, LOONGARCH_PIC)
 
 struct LoongarchPICState {
     LoongArchPICCommonState parent_obj;
+    int dev_fd;
 };
 
 struct LoongarchPICClass {
@@ -25,4 +26,6 @@ struct LoongarchPICClass {
     ResettablePhases parent_phases;
 };
 
+void kvm_pic_realize(DeviceState *dev, Error **errp);
+
 #endif /* HW_LOONGARCH_PCH_PIC_H */
-- 
2.47.0


