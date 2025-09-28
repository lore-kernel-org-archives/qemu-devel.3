Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A496DCAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 09:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2o10-0001g8-7p; Sun, 28 Sep 2025 05:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v2o0y-0001fG-F2
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 05:48:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v2o0g-0006RI-Gz
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 05:48:19 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dxb_BLBNlogM4PAA--.33694S3;
 Sun, 28 Sep 2025 17:47:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDx_8NCBNloMpa5AA--.63673S6;
 Sun, 28 Sep 2025 17:47:54 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>
Subject: [PULL v2 04/11] loongarch: add a direct interrupt controller device
Date: Sun, 28 Sep 2025 17:24:01 +0800
Message-Id: <20250928092408.948035-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250928092408.948035-1-gaosong@loongson.cn>
References: <20250928092408.948035-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDx_8NCBNloMpa5AA--.63673S6
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add Loongarch direct interrupt controller device base Definition.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20250916122109.749813-5-gaosong@loongson.cn>
---
 hw/intc/Kconfig                   |  3 ++
 hw/intc/loongarch_dintc.c         | 68 +++++++++++++++++++++++++++++++
 hw/intc/meson.build               |  1 +
 hw/loongarch/Kconfig              |  1 +
 include/hw/intc/loongarch_dintc.h | 35 ++++++++++++++++
 5 files changed, 108 insertions(+)
 create mode 100644 hw/intc/loongarch_dintc.c
 create mode 100644 include/hw/intc/loongarch_dintc.h

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 7547528f2c..9f456d7e43 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -109,3 +109,6 @@ config LOONGARCH_PCH_MSI
 
 config LOONGARCH_EXTIOI
     bool
+
+config LOONGARCH_DINTC
+    bool
diff --git a/hw/intc/loongarch_dintc.c b/hw/intc/loongarch_dintc.c
new file mode 100644
index 0000000000..b2465cb022
--- /dev/null
+++ b/hw/intc/loongarch_dintc.c
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU LoongArch direct interrupt controller.
+ *
+ * Copyright (C) 2025 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/irq.h"
+#include "hw/intc/loongarch_pch_msi.h"
+#include "hw/intc/loongarch_pch_pic.h"
+#include "hw/intc/loongarch_dintc.h"
+#include "hw/pci/msi.h"
+#include "hw/misc/unimp.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+#include "hw/qdev-properties.h"
+
+
+static void loongarch_dintc_realize(DeviceState *dev, Error **errp)
+{
+    LoongArchDINTCClass *lac = LOONGARCH_DINTC_GET_CLASS(dev);
+
+    Error *local_err = NULL;
+    lac->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    return;
+}
+
+static void loongarch_dintc_unrealize(DeviceState *dev)
+{
+    return;
+}
+
+static void loongarch_dintc_init(Object *obj)
+{
+    return;
+}
+
+static void loongarch_dintc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    LoongArchDINTCClass *lac = LOONGARCH_DINTC_CLASS(klass);
+
+    dc->unrealize = loongarch_dintc_unrealize;
+    device_class_set_parent_realize(dc, loongarch_dintc_realize,
+                                    &lac->parent_realize);
+}
+
+static const TypeInfo loongarch_dintc_info = {
+    .name          = TYPE_LOONGARCH_DINTC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(LoongArchDINTCState),
+    .instance_init = loongarch_dintc_init,
+    .class_init    = loongarch_dintc_class_init,
+};
+
+static void loongarch_dintc_register_types(void)
+{
+    type_register_static(&loongarch_dintc_info);
+}
+
+type_init(loongarch_dintc_register_types)
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 3efb276b6e..faae20b93d 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -80,3 +80,4 @@ specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_
 specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c', 'loongarch_extioi_common.c'))
 specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_LOONGARCH_EXTIOI'],
                if_true: files('loongarch_extioi_kvm.c'))
+specific_ss.add(when: 'CONFIG_LOONGARCH_DINTC', if_true: files('loongarch_dintc.c'))
diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index bb2838b7b5..8024ddf1f3 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -15,6 +15,7 @@ config LOONGARCH_VIRT
     select LOONGARCH_PCH_PIC
     select LOONGARCH_PCH_MSI
     select LOONGARCH_EXTIOI
+    select LOONGARCH_DINTC
     select LS7A_RTC
     select SMBIOS
     select ACPI_CPU_HOTPLUG
diff --git a/include/hw/intc/loongarch_dintc.h b/include/hw/intc/loongarch_dintc.h
new file mode 100644
index 0000000000..aa94cd1003
--- /dev/null
+++ b/include/hw/intc/loongarch_dintc.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch  direct interrupt controller definitions
+ *
+ * Copyright (C) 2025 Loongson Technology Corporation Limited
+ */
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+#include "hw/loongarch/virt.h"
+
+
+#define NR_VECTORS     256
+
+#define TYPE_LOONGARCH_DINTC "loongarch_dintc"
+OBJECT_DECLARE_TYPE(LoongArchDINTCState, LoongArchDINTCClass, LOONGARCH_DINTC)
+
+typedef struct DINTCCore {
+    CPUState *cpu;
+    qemu_irq parent_irq;
+    uint64_t arch_id;
+} DINTCCore;
+
+struct LoongArchDINTCState {
+    SysBusDevice parent_obj;
+    DINTCCore *cpu;
+    uint32_t num_cpu;
+};
+
+struct LoongArchDINTCClass {
+    SysBusDeviceClass parent_class;
+
+    DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
+};
-- 
2.47.0


