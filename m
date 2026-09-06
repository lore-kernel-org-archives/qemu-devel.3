Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6826C79F9F
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GP4-0003vK-EB; Sun, 06 Sep 2026 13:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOo-0003fq-Jm
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOk-0000Ay-W9
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jdqGoW8t6uMKAmwi/Es2TtX2zxTdvSQabRYfzYoIRmg=;
 b=ilzd12xxqMVZ+5+bC17uu2/ti85+wFK25V8xZp/ck31SKD/fiCWWaCAbgAiHkevOaPo+Xw
 XGn9BXwmkLKJdu493BV5YXUMz/BpLd9nHeqOXS3hnR72lVFVAXuADgV5eZtaOqN05UdZ2W
 GDs4/fs0d/jOtgo+SCUWNpwUqxiU2b8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-k6BFtAu7OjiypOBKTnl3ww-1; Sun,
 06 Sep 2026 13:11:14 -0400
X-MC-Unique: k6BFtAu7OjiypOBKTnl3ww-1
X-Mimecast-MFC-AGG-ID: k6BFtAu7OjiypOBKTnl3ww_1788714673
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BB2C1801358; Sun,  6 Sep 2026 17:11:13 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6580F1955F06; Sun,  6 Sep 2026 17:11:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/40] hw/usb/aspeed-udc: Add ASPEED UDC device controller
Date: Sun,  6 Sep 2026 19:10:02 +0200
Message-ID: <20260906171021.26568-22-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

The AST2600 has a USB 2.0 Device Controller (UDC) at 0x1e6a2000 with one
control endpoint and four programmable endpoints.

Add the controller as a sysbus (system) device: the MMIO register map
described with the registerfields macros, the interrupt line and the
soft reset. This is only the register/system side.

Note: this "device controller" is the system-bus device (TYPE_ASPEED_UDC).
It is not the gadget USB device (TYPE_ASPEED_UDC_GADGET) that a host
controller enumerates, which is added in the next patch.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260902021542.3194812-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/usb/aspeed-udc.h |  49 ++++++++
 hw/usb/aspeed-udc.c         | 236 ++++++++++++++++++++++++++++++++++++
 hw/arm/Kconfig              |   1 +
 hw/usb/Kconfig              |   3 +
 hw/usb/meson.build          |   1 +
 hw/usb/trace-events         |   7 ++
 6 files changed, 297 insertions(+)
 create mode 100644 include/hw/usb/aspeed-udc.h
 create mode 100644 hw/usb/aspeed-udc.c

diff --git a/include/hw/usb/aspeed-udc.h b/include/hw/usb/aspeed-udc.h
new file mode 100644
index 000000000000..58fed5f9a2d2
--- /dev/null
+++ b/include/hw/usb/aspeed-udc.h
@@ -0,0 +1,49 @@
+/*
+ * ASPEED USB Device Controller (UDC)
+ *
+ * Copyright (c) 2026 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_USB_ASPEED_UDC_H
+#define HW_USB_ASPEED_UDC_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_ASPEED_UDC "aspeed.udc"
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedUDCState, ASPEED_UDC)
+
+/*
+ * Register map: root/global block at 0x000 - 0x087, then one 0x10 byte bank
+ * per programmable endpoint from 0x200.
+ */
+#define ASPEED_UDC_MEM_SIZE     0x300
+#define ASPEED_UDC_ROOT_NR_REGS (0x88 >> 2)
+#define ASPEED_UDC_EP_REG_BASE  0x200
+#define ASPEED_UDC_EP_NR_REGS   (0x10 >> 2)
+
+/*
+ * EP0 (control) is served through the root registers (UDC_EP0_*), so only
+ * the 4 programmable endpoints get their own register bank / ep[] entry.
+ */
+#define ASPEED_UDC_NUM_EP   4
+
+typedef struct AspeedUDCEP {
+    MemoryRegion mr;
+    uint32_t regs[ASPEED_UDC_EP_NR_REGS];
+    int index;
+} AspeedUDCEP;
+
+struct AspeedUDCState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion udc_container;
+    MemoryRegion root_mr;
+    uint32_t regs[ASPEED_UDC_ROOT_NR_REGS];
+    AspeedUDCEP ep[ASPEED_UDC_NUM_EP];
+    qemu_irq irq;
+};
+
+#endif /* HW_USB_ASPEED_UDC_H */
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c
new file mode 100644
index 000000000000..cd773e979b60
--- /dev/null
+++ b/hw/usb/aspeed-udc.c
@@ -0,0 +1,236 @@
+/*
+ * ASPEED USB Device Controller (UDC)
+ *
+ * Copyright (c) 2026 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Models the ASPEED USB Device Controller (UDC). It implements one control
+ * endpoint (EP0) and 4 programmable endpoints.
+ *
+ * This file is the system-bus side of the controller: the MMIO register map,
+ * the interrupt and the soft reset. The gadget USB device presented to a host
+ * controller (and the endpoint data path) is added on top of this.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/irq.h"
+#include "hw/core/registerfields.h"
+#include "hw/usb/aspeed-udc.h"
+#include "qemu/module.h"
+#include "trace.h"
+
+/* Root / Global registers (offset from the controller base) */
+REG32(UDC_FUNC_CTRL, 0x00)
+    FIELD(UDC_FUNC_CTRL, UPSTREAM_EN,       0, 1)
+REG32(UDC_IER, 0x08)
+REG32(UDC_ISR, 0x0C)
+    FIELD(UDC_ISR, EP_POOL_ACK,            16, 1)
+    FIELD(UDC_ISR, BUS_RESET,               6, 1)
+    FIELD(UDC_ISR, EP0_IN_ACK,              3, 1)
+    FIELD(UDC_ISR, EP0_OUT_ACK,             1, 1)
+    FIELD(UDC_ISR, EP0_SETUP,               0, 1)
+REG32(UDC_EP_ACK_IER, 0x10)
+REG32(UDC_EP_NAK_IER, 0x14)
+REG32(UDC_EP_ACK_ISR, 0x18)
+REG32(UDC_EP_NAK_ISR, 0x1C)
+REG32(UDC_DEV_RESET, 0x20)
+    FIELD(UDC_DEV_RESET, EP_POOL,           9, 1)
+    FIELD(UDC_DEV_RESET, DMA,               8, 1)
+    FIELD(UDC_DEV_RESET, ROOT,              0, 1)
+REG32(UDC_STS, 0x24)
+    FIELD(UDC_STS, HIGHSPEED,              27, 1)
+REG32(UDC_EP0_CTRL, 0x30)
+    FIELD(UDC_EP0_CTRL, RX_LEN,            16, 7)
+    FIELD(UDC_EP0_CTRL, TX_LEN,             8, 7)
+    FIELD(UDC_EP0_CTRL, RX_RDY,             2, 1)
+    FIELD(UDC_EP0_CTRL, TX_RDY,             1, 1)
+    FIELD(UDC_EP0_CTRL, STALL,              0, 1)
+REG32(UDC_EP0_DATA_BUFF, 0x34)
+/* EP0 SETUP packet buffer: SETUP0 = bytes 0...3, SETUP1 = bytes 4...7 */
+REG32(UDC_SETUP0, 0x80)
+REG32(UDC_SETUP1, 0x84)
+
+/* Per programmable-endpoint registers (offset from the EP register base) */
+REG32(EP_CONFIG, 0x00)
+    FIELD(EP_CONFIG, MAX_PKT,              16, 10)
+    FIELD(EP_CONFIG, EP_NUM,                8, 4)
+    FIELD(EP_CONFIG, DIR_OUT,               4, 1)
+    FIELD(EP_CONFIG, ENABLE,                0, 1)
+REG32(EP_DMA_CTRL, 0x04)
+    FIELD(EP_DMA_CTRL, PROC_STS,            4, 4)
+    FIELD(EP_DMA_CTRL, DESC_OP_EN,          0, 1)
+REG32(EP_DMA_BUFF, 0x08)
+REG32(EP_DMA_STS, 0x0C)
+    FIELD(EP_DMA_STS, PKT_SIZE,            16, 11)
+    FIELD(EP_DMA_STS, RPTR,                 8, 8)
+    FIELD(EP_DMA_STS, WPTR,                 0, 8)
+
+static void aspeed_udc_update_irq(AspeedUDCState *s)
+{
+    bool level;
+
+    level = (s->regs[R_UDC_ISR] & s->regs[R_UDC_IER]) ||
+            (s->regs[R_UDC_EP_ACK_ISR] & s->regs[R_UDC_EP_ACK_IER]) ||
+            (s->regs[R_UDC_EP_NAK_ISR] & s->regs[R_UDC_EP_NAK_IER]);
+
+    trace_aspeed_udc_irq(s->regs[R_UDC_ISR], s->regs[R_UDC_IER], level);
+    qemu_set_irq(s->irq, level);
+}
+
+static uint64_t aspeed_udc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    AspeedUDCState *s = ASPEED_UDC(opaque);
+    uint32_t reg = offset >> 2;
+    uint32_t val;
+
+    val = s->regs[reg];
+    trace_aspeed_udc_read(offset, val);
+
+    return val;
+}
+
+static void aspeed_udc_write(void *opaque, hwaddr offset, uint64_t data,
+                             unsigned size)
+{
+    AspeedUDCState *s = ASPEED_UDC(opaque);
+    uint32_t reg = offset >> 2;
+    uint32_t val = data;
+
+    trace_aspeed_udc_write(offset, val);
+
+    switch (reg) {
+    case R_UDC_IER:
+    case R_UDC_EP_ACK_IER:
+    case R_UDC_EP_NAK_IER:
+        s->regs[reg] = val;
+        aspeed_udc_update_irq(s);
+        break;
+    case R_UDC_ISR:
+    case R_UDC_EP_ACK_ISR:
+    case R_UDC_EP_NAK_ISR:
+        s->regs[reg] &= ~val;
+        aspeed_udc_update_irq(s);
+        break;
+    default:
+        s->regs[reg] = val;
+        break;
+    }
+}
+
+static const MemoryRegionOps aspeed_udc_ops = {
+    .read = aspeed_udc_read,
+    .write = aspeed_udc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static uint64_t aspeed_udc_ep_read(void *opaque, hwaddr offset, unsigned size)
+{
+    AspeedUDCEP *e = opaque;
+    uint32_t reg = offset >> 2;
+    uint32_t val;
+
+    val = e->regs[reg];
+    trace_aspeed_udc_ep_read(e->index, offset, val);
+
+    return val;
+}
+
+static void aspeed_udc_ep_write(void *opaque, hwaddr offset, uint64_t data,
+                                unsigned size)
+{
+    AspeedUDCEP *e = opaque;
+    uint32_t reg = offset >> 2;
+
+    trace_aspeed_udc_ep_write(e->index, offset, data);
+    e->regs[reg] = data;
+}
+
+static const MemoryRegionOps aspeed_udc_ep_ops = {
+    .read = aspeed_udc_ep_read,
+    .write = aspeed_udc_ep_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void aspeed_udc_reset_hold(Object *obj, ResetType type)
+{
+    AspeedUDCState *s = ASPEED_UDC(obj);
+    int i;
+
+    memset(s->regs, 0, sizeof(s->regs));
+    for (i = 0; i < ASPEED_UDC_NUM_EP; i++) {
+        memset(s->ep[i].regs, 0, sizeof(s->ep[i].regs));
+    }
+
+    /* Device-reset default: root, DMA and EP-pool soft-reset bits set */
+    s->regs[R_UDC_DEV_RESET] = (R_UDC_DEV_RESET_ROOT_MASK |
+                                R_UDC_DEV_RESET_DMA_MASK |
+                                R_UDC_DEV_RESET_EP_POOL_MASK);
+}
+
+static void aspeed_udc_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedUDCState *s = ASPEED_UDC(dev);
+    int i;
+
+    memory_region_init(&s->udc_container, OBJECT(s), TYPE_ASPEED_UDC,
+                       ASPEED_UDC_MEM_SIZE);
+    memory_region_init_io(&s->root_mr, OBJECT(s), &aspeed_udc_ops, s,
+                          TYPE_ASPEED_UDC ".root",
+                          ASPEED_UDC_ROOT_NR_REGS << 2);
+    memory_region_add_subregion(&s->udc_container, 0, &s->root_mr);
+
+    /* Each programmable endpoint has its own register bank */
+    for (i = 0; i < ASPEED_UDC_NUM_EP; i++) {
+        g_autofree char *name = g_strdup_printf(TYPE_ASPEED_UDC ".ep%d", i);
+
+        s->ep[i].index = i;
+        memory_region_init_io(&s->ep[i].mr, OBJECT(s), &aspeed_udc_ep_ops,
+                              &s->ep[i], name, ASPEED_UDC_EP_NR_REGS << 2);
+        memory_region_add_subregion(&s->udc_container,
+                                    ASPEED_UDC_EP_REG_BASE +
+                                    i * (ASPEED_UDC_EP_NR_REGS << 2),
+                                    &s->ep[i].mr);
+    }
+
+    sysbus_init_mmio(sbd, &s->udc_container);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static void aspeed_udc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->desc = "ASPEED USB Device Controller";
+    dc->realize = aspeed_udc_realize;
+    rc->phases.hold = aspeed_udc_reset_hold;
+}
+
+static const TypeInfo aspeed_udc_types[] = {
+    {
+        .name          = TYPE_ASPEED_UDC,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(AspeedUDCState),
+        .class_init    = aspeed_udc_class_init,
+    },
+};
+
+DEFINE_TYPES(aspeed_udc_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 5db7ce057f4a..eae06369b02f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -520,6 +520,7 @@ config ASPEED_SOC
     imply GENERIC_LOADER
     imply PCI_DEVICES
     imply E1000E_PCI_EXPRESS
+    select ASPEED_UDC
     select DS1338
     select FTGMAC100
     select I2C
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index de95686720cb..e4df15fe7c1f 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -146,3 +146,6 @@ config XLNX_USB_SUBSYS
 config USB_CHIPIDEA
     bool
     select USB_EHCI_SYSBUS
+
+config ASPEED_UDC
+    bool
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index ba55c28ef69e..d4ba60a91c4d 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -27,6 +27,7 @@ system_ss.add(when: 'CONFIG_USB_XHCI_NEC', if_true: files('hcd-xhci-nec.c'))
 system_ss.add(when: 'CONFIG_USB_DWC2', if_true: files('hcd-dwc2.c'))
 system_ss.add(when: 'CONFIG_USB_DWC3', if_true: files('hcd-dwc3.c'))
 system_ss.add(when: 'CONFIG_USB_CHIPIDEA', if_true: files('chipidea.c'))
+system_ss.add(when: 'CONFIG_ASPEED_UDC', if_true: files('aspeed-udc.c'))
 
 system_ss.add(when: 'CONFIG_IMX_USBPHY', if_true: files('imx-usb-phy.c'))
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686-uhci-pci.c'))
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 67249d69c2f6..ed05304520a2 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -377,3 +377,10 @@ canokey_handle_data_out(uint8_t ep_out, uint32_t out_len) "ep %d len %d"
 canokey_handle_data_in(uint8_t ep_in, uint32_t in_len) "ep %d len %d"
 canokey_realize(void)
 canokey_unrealize(void)
+
+# aspeed-udc.c
+aspeed_udc_read(uint64_t offset, uint32_t value) "offset 0x%" PRIx64 " value 0x%x"
+aspeed_udc_write(uint64_t offset, uint32_t value) "offset 0x%" PRIx64 " value 0x%x"
+aspeed_udc_ep_read(int ep, uint64_t offset, uint32_t value) "ep %d, offset 0x%" PRIx64 " value 0x%x"
+aspeed_udc_ep_write(int ep, uint64_t offset, uint32_t value) "ep %d, offset 0x%" PRIx64 " value 0x%x"
+aspeed_udc_irq(uint32_t isr, uint32_t ier, int level) "isr 0x%x, ier 0x%x, level %d"
-- 
2.55.0


