Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFFFEE6421
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZgY-0004AE-Cn; Wed, 11 Sep 2024 22:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1soZgV-00040u-Jt
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:35:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1soZgQ-0003WO-DP
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:35:51 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxKOl9U+JmYGMFAA--.11568S3;
 Thu, 12 Sep 2024 10:35:41 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxHeR5U+JmelsEAA--.25141S3;
 Thu, 12 Sep 2024 10:35:40 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org,
 bibo mao <maobibo@loongson.cn>
Subject: [PATCH 1/5] hw/intc/loongarch_pic: Add loongarch pch pic common driver
Date: Thu, 12 Sep 2024 10:35:33 +0800
Message-Id: <20240912023537.1004979-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240912023537.1004979-1-maobibo@loongson.cn>
References: <20240912023537.1004979-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxHeR5U+JmelsEAA--.25141S3
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

From: bibo mao <maobibo@loongson.cn>

Add pch pic common driver, so that it can be shared with KVM and
TCG driver, put vmstate and property, vmstate load and store interface
in this pic common driver.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pic_common.c         | 97 ++++++++++++++++++++++++++
 include/hw/intc/loongarch_pic_common.h | 82 ++++++++++++++++++++++
 2 files changed, 179 insertions(+)
 create mode 100644 hw/intc/loongarch_pic_common.c
 create mode 100644 include/hw/intc/loongarch_pic_common.h

diff --git a/hw/intc/loongarch_pic_common.c b/hw/intc/loongarch_pic_common.c
new file mode 100644
index 0000000000..a74b6c7b44
--- /dev/null
+++ b/hw/intc/loongarch_pic_common.c
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU Loongson 7A1000 I/O interrupt controller.
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/intc/loongarch_pic_common.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+
+static int loongarch_pic_pre_save(void *opaque)
+{
+    LoongArchPICCommonState *s = (LoongArchPICCommonState *)opaque;
+    LoongArchPICCommonClass *lpcc = LOONGARCH_PIC_COMMON_GET_CLASS(s);
+
+    if (lpcc->pre_save) {
+        return lpcc->pre_save(s);
+    }
+
+    return 0;
+}
+
+static int loongarch_pic_post_load(void *opaque, int version_id)
+{
+    LoongArchPICCommonState *s = (LoongArchPICCommonState *)opaque;
+    LoongArchPICCommonClass *lpcc = LOONGARCH_PIC_COMMON_GET_CLASS(s);
+
+    if (lpcc->post_load) {
+        return lpcc->post_load(s, version_id);
+    }
+
+    return 0;
+}
+
+static void loongarch_pic_common_realize(DeviceState *dev, Error **errp)
+{
+    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(dev);
+
+    if (!s->irq_num || s->irq_num  > VIRT_PCH_PIC_IRQ_NUM) {
+        error_setg(errp, "Invalid 'pic_irq_num'");
+        return;
+    }
+}
+
+static Property loongarch_pic_common_properties[] = {
+    DEFINE_PROP_UINT32("pch_pic_irq_num", LoongArchPICCommonState, irq_num, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription vmstate_loongarch_pic_common = {
+    .name = "loongarch_pch_pic",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_save  = loongarch_pic_pre_save,
+    .post_load = loongarch_pic_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(int_mask, LoongArchPICCommonState),
+        VMSTATE_UINT64(htmsi_en, LoongArchPICCommonState),
+        VMSTATE_UINT64(intedge, LoongArchPICCommonState),
+        VMSTATE_UINT64(intclr, LoongArchPICCommonState),
+        VMSTATE_UINT64(auto_crtl0, LoongArchPICCommonState),
+        VMSTATE_UINT64(auto_crtl1, LoongArchPICCommonState),
+        VMSTATE_UINT8_ARRAY(route_entry, LoongArchPICCommonState, 64),
+        VMSTATE_UINT8_ARRAY(htmsi_vector, LoongArchPICCommonState, 64),
+        VMSTATE_UINT64(last_intirr, LoongArchPICCommonState),
+        VMSTATE_UINT64(intirr, LoongArchPICCommonState),
+        VMSTATE_UINT64(intisr, LoongArchPICCommonState),
+        VMSTATE_UINT64(int_polarity, LoongArchPICCommonState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void loongarch_pic_common_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    LoongArchPICCommonClass *lpcc = LOONGARCH_PIC_COMMON_CLASS(klass);
+
+    device_class_set_parent_realize(dc, loongarch_pic_common_realize,
+                                    &lpcc->parent_realize);
+    device_class_set_props(dc, loongarch_pic_common_properties);
+    dc->vmsd = &vmstate_loongarch_pic_common;
+}
+
+static const TypeInfo loongarch_pic_common_types[] = {
+    {
+        .name               = TYPE_LOONGARCH_PIC_COMMON,
+        .parent             = TYPE_SYS_BUS_DEVICE,
+        .instance_size      = sizeof(LoongArchPICCommonState),
+        .class_size         = sizeof(LoongArchPICCommonClass),
+        .class_init         = loongarch_pic_common_class_init,
+        .abstract           = true,
+    }
+};
+
+DEFINE_TYPES(loongarch_pic_common_types)
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
new file mode 100644
index 0000000000..2bb15b571e
--- /dev/null
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch 7A1000 I/O interrupt controller definitions
+ * Copyright (c) 2024 Loongson Technology Corporation Limited
+ */
+
+#ifndef HW_LOONGARCH_PIC_COMMON_H
+#define HW_LOONGARCH_PIC_COMMON_H
+
+#include "hw/pci-host/ls7a.h"
+#include "hw/sysbus.h"
+
+#define PCH_PIC_INT_ID_VAL              0x7000000UL
+#define PCH_PIC_INT_ID_VER              0x1UL
+#define PCH_PIC_INT_ID_LO               0x00
+#define PCH_PIC_INT_ID_HI               0x04
+#define PCH_PIC_INT_MASK_LO             0x20
+#define PCH_PIC_INT_MASK_HI             0x24
+#define PCH_PIC_HTMSI_EN_LO             0x40
+#define PCH_PIC_HTMSI_EN_HI             0x44
+#define PCH_PIC_INT_EDGE_LO             0x60
+#define PCH_PIC_INT_EDGE_HI             0x64
+#define PCH_PIC_INT_CLEAR_LO            0x80
+#define PCH_PIC_INT_CLEAR_HI            0x84
+#define PCH_PIC_AUTO_CTRL0_LO           0xc0
+#define PCH_PIC_AUTO_CTRL0_HI           0xc4
+#define PCH_PIC_AUTO_CTRL1_LO           0xe0
+#define PCH_PIC_AUTO_CTRL1_HI           0xe4
+#define PCH_PIC_ROUTE_ENTRY_OFFSET      0x100
+#define PCH_PIC_ROUTE_ENTRY_END         0x13f
+#define PCH_PIC_HTMSI_VEC_OFFSET        0x200
+#define PCH_PIC_HTMSI_VEC_END           0x23f
+#define PCH_PIC_INT_STATUS_LO           0x3a0
+#define PCH_PIC_INT_STATUS_HI           0x3a4
+#define PCH_PIC_INT_POL_LO              0x3e0
+#define PCH_PIC_INT_POL_HI              0x3e4
+
+#define STATUS_LO_START                 0
+#define STATUS_HI_START                 0x4
+#define POL_LO_START                    0x40
+#define POL_HI_START                    0x44
+
+#define TYPE_LOONGARCH_PIC_COMMON "loongarch_pic_common"
+OBJECT_DECLARE_TYPE(LoongArchPICCommonState,
+                    LoongArchPICCommonClass, LOONGARCH_PIC_COMMON)
+
+struct LoongArchPICCommonState {
+    SysBusDevice parent_obj;
+
+    qemu_irq parent_irq[64];
+    uint64_t int_mask;      /* 0x020 interrupt mask register */
+    uint64_t htmsi_en;      /* 0x040 1=msi */
+    uint64_t intedge;       /* 0x060 edge=1 level=0 */
+    uint64_t intclr;        /* 0x080 clean edge int, set 1 clean, 0 noused */
+    uint64_t auto_crtl0;    /* 0x0c0 */
+    uint64_t auto_crtl1;    /* 0x0e0 */
+    uint64_t last_intirr;   /* edge detection */
+    uint64_t intirr;        /* 0x380 interrupt request register */
+    uint64_t intisr;        /* 0x3a0 interrupt service register */
+    /*
+     * 0x3e0 interrupt level polarity selection
+     * register 0 for high level trigger
+     */
+    uint64_t int_polarity;
+
+    uint8_t route_entry[64]; /*0x100 - 0x138*/
+    uint8_t htmsi_vector[64]; /*0x200 - 0x238*/
+
+    MemoryRegion iomem32_low;
+    MemoryRegion iomem32_high;
+    MemoryRegion iomem8;
+    unsigned int irq_num;
+};
+
+struct LoongArchPICCommonClass {
+    SysBusDeviceClass parent_class;
+
+    DeviceRealize parent_realize;
+    int (*pre_save)(LoongArchPICCommonState *s);
+    int (*post_load)(LoongArchPICCommonState *s, int version_id);
+};
+#endif  /* HW_LOONGARCH_PIC_COMMON_H */
-- 
2.39.3


