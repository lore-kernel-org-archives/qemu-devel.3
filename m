Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D799BC79F87
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 12:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vck98-0004JV-1j; Mon, 05 Jan 2026 07:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck90-0004AY-OW
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8z-00083Z-12
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2tCMD84IGf4Vsqx5fEI1vPIx4poAsnadZX2OcXtZz4w=;
 b=aSxxRxAVgCBrquhdycH/O1n6vhzoAZ/tXssiiz78Pp2jbeubl5rOszEVH3Dx76TgFYwGhr
 t7W4lnOMOtg3kIEYttAEv7DDQcHeANRBblnYN8/ro+TVSv3+b/mXj/wJGz5Hil6z9myqR7
 5Uwimt1xRyB/MPyvf3OZefVtenvQGLU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-cfCqArDdNU-02eyLysAVRg-1; Mon,
 05 Jan 2026 07:57:04 -0500
X-MC-Unique: cfCqArDdNU-02eyLysAVRg-1
X-Mimecast-MFC-AGG-ID: cfCqArDdNU-02eyLysAVRg_1767617823
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D304195FCDC; Mon,  5 Jan 2026 12:57:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDC70195398A; Mon,  5 Jan 2026 12:57:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Yubin Zou <yubinz@google.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 23/36] hw/gpio/aspeed_sgpio: Add basic device model for Aspeed
 SGPIO
Date: Mon,  5 Jan 2026 13:56:00 +0100
Message-ID: <20260105125613.622667-24-clg@redhat.com>
In-Reply-To: <20260105125613.622667-1-clg@redhat.com>
References: <20260105125613.622667-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Yubin Zou <yubinz@google.com>

This initial implementation includes the basic device structure,
memory-mapped register definitions, and read/write handlers for the
SGPIO control registers.

Signed-off-by: Yubin Zou <yubinz@google.com>
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20251219-aspeed-sgpio-v5-1-fd5593178144@google.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/gpio/aspeed_sgpio.h |  66 +++++++++++++++
 hw/gpio/aspeed_sgpio.c         | 145 +++++++++++++++++++++++++++++++++
 hw/gpio/meson.build            |   1 +
 3 files changed, 212 insertions(+)
 create mode 100644 include/hw/gpio/aspeed_sgpio.h
 create mode 100644 hw/gpio/aspeed_sgpio.c

diff --git a/include/hw/gpio/aspeed_sgpio.h b/include/hw/gpio/aspeed_sgpio.h
new file mode 100644
index 000000000000..7da48920eebf
--- /dev/null
+++ b/include/hw/gpio/aspeed_sgpio.h
@@ -0,0 +1,66 @@
+/*
+ * ASPEED Serial GPIO Controller
+ *
+ * Copyright 2025 Google LLC.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef ASPEED_SGPIO_H
+#define ASPEED_SGPIO_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+#include "hw/core/registerfields.h"
+
+#define TYPE_ASPEED_SGPIO "aspeed.sgpio"
+OBJECT_DECLARE_TYPE(AspeedSGPIOState, AspeedSGPIOClass, ASPEED_SGPIO)
+
+#define ASPEED_SGPIO_MAX_PIN_PAIR 256
+#define ASPEED_SGPIO_MAX_INT 8
+
+/* AST2700 SGPIO Register Address Offsets */
+REG32(SGPIO_INT_STATUS_0, 0x40)
+REG32(SGPIO_INT_STATUS_1, 0x44)
+REG32(SGPIO_INT_STATUS_2, 0x48)
+REG32(SGPIO_INT_STATUS_3, 0x4C)
+REG32(SGPIO_INT_STATUS_4, 0x50)
+REG32(SGPIO_INT_STATUS_5, 0x54)
+REG32(SGPIO_INT_STATUS_6, 0x58)
+REG32(SGPIO_INT_STATUS_7, 0x5C)
+/* AST2700 SGPIO_0 - SGPIO_255 Control Register */
+REG32(SGPIO_0_CONTROL, 0x80)
+    SHARED_FIELD(SGPIO_SERIAL_OUT_VAL, 0, 1)
+    SHARED_FIELD(SGPIO_PARALLEL_OUT_VAL, 1, 1)
+    SHARED_FIELD(SGPIO_INT_EN, 2, 1)
+    SHARED_FIELD(SGPIO_INT_TYPE, 3, 3)
+    SHARED_FIELD(SGPIO_RESET_POLARITY, 6, 1)
+    SHARED_FIELD(SGPIO_RESERVED_1, 7, 2)
+    SHARED_FIELD(SGPIO_INPUT_MASK, 9, 1)
+    SHARED_FIELD(SGPIO_PARALLEL_EN, 10, 1)
+    SHARED_FIELD(SGPIO_PARALLEL_IN_MODE, 11, 1)
+    SHARED_FIELD(SGPIO_INT_STATUS, 12, 1)
+    SHARED_FIELD(SGPIO_SERIAL_IN_VAL, 13, 1)
+    SHARED_FIELD(SGPIO_PARALLEL_IN_VAL, 14, 1)
+    SHARED_FIELD(SGPIO_RESERVED_2, 15, 12)
+    SHARED_FIELD(SGPIO_WRITE_PROTECT, 31, 1)
+REG32(SGPIO_255_CONTROL, 0x47C)
+
+struct AspeedSGPIOClass {
+    SysBusDeviceClass parent_class;
+    uint32_t nr_sgpio_pin_pairs;
+    uint64_t mem_size;
+    const MemoryRegionOps *reg_ops;
+};
+
+struct AspeedSGPIOState {
+    /* <private> */
+    SysBusDevice parent;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    qemu_irq irq;
+    uint32_t ctrl_regs[ASPEED_SGPIO_MAX_PIN_PAIR];
+    uint32_t int_regs[ASPEED_SGPIO_MAX_INT];
+};
+
+#endif /* ASPEED_SGPIO_H */
diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c
new file mode 100644
index 000000000000..538fb5145c3d
--- /dev/null
+++ b/hw/gpio/aspeed_sgpio.c
@@ -0,0 +1,145 @@
+/*
+ * ASPEED Serial GPIO Controller
+ *
+ * Copyright 2025 Google LLC.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/host-utils.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/gpio/aspeed_sgpio.h"
+
+static uint64_t aspeed_sgpio_2700_read_control_reg(AspeedSGPIOState *s,
+                                uint32_t reg)
+{
+    AspeedSGPIOClass *agc = ASPEED_SGPIO_GET_CLASS(s);
+    uint32_t idx = reg - R_SGPIO_0_CONTROL;
+    if (idx >= agc->nr_sgpio_pin_pairs) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: pin index: %d, out of bounds\n",
+                      __func__, idx);
+        return 0;
+    }
+    return s->ctrl_regs[idx];
+}
+
+static void aspeed_sgpio_2700_write_control_reg(AspeedSGPIOState *s,
+                                uint32_t reg, uint64_t data)
+{
+    AspeedSGPIOClass *agc = ASPEED_SGPIO_GET_CLASS(s);
+    uint32_t idx = reg - R_SGPIO_0_CONTROL;
+    if (idx >= agc->nr_sgpio_pin_pairs) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: pin index: %d, out of bounds\n",
+                      __func__, idx);
+        return;
+    }
+    s->ctrl_regs[idx] = data;
+}
+
+static uint64_t aspeed_sgpio_2700_read(void *opaque, hwaddr offset,
+                                uint32_t size)
+{
+    AspeedSGPIOState *s = ASPEED_SGPIO(opaque);
+    uint64_t value = 0;
+    uint64_t reg;
+
+    reg = offset >> 2;
+
+    switch (reg) {
+    case R_SGPIO_0_CONTROL ... R_SGPIO_255_CONTROL:
+        value = aspeed_sgpio_2700_read_control_reg(s, reg);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: no getter for offset 0x%"
+                      HWADDR_PRIx"\n", __func__, offset);
+        return 0;
+    }
+
+    return value;
+}
+
+static void aspeed_sgpio_2700_write(void *opaque, hwaddr offset, uint64_t data,
+                                uint32_t size)
+{
+    AspeedSGPIOState *s = ASPEED_SGPIO(opaque);
+    uint64_t reg;
+
+    reg = offset >> 2;
+
+    switch (reg) {
+    case R_SGPIO_0_CONTROL ... R_SGPIO_255_CONTROL:
+        aspeed_sgpio_2700_write_control_reg(s, reg, data);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: no setter for offset 0x%"
+                      HWADDR_PRIx"\n", __func__, offset);
+        return;
+    }
+}
+
+static const MemoryRegionOps aspeed_sgpio_2700_ops = {
+    .read       = aspeed_sgpio_2700_read,
+    .write      = aspeed_sgpio_2700_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static void aspeed_sgpio_realize(DeviceState *dev, Error **errp)
+{
+    AspeedSGPIOState *s = ASPEED_SGPIO(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedSGPIOClass *agc = ASPEED_SGPIO_GET_CLASS(s);
+
+    /* Interrupt parent line */
+    sysbus_init_irq(sbd, &s->irq);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), agc->reg_ops, s,
+                          TYPE_ASPEED_SGPIO, agc->mem_size);
+
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void aspeed_sgpio_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = aspeed_sgpio_realize;
+    dc->desc = "Aspeed SGPIO Controller";
+}
+
+static void aspeed_sgpio_2700_class_init(ObjectClass *klass, const void *data)
+{
+    AspeedSGPIOClass *agc = ASPEED_SGPIO_CLASS(klass);
+    agc->nr_sgpio_pin_pairs = ASPEED_SGPIO_MAX_PIN_PAIR;
+    agc->mem_size = 0x1000;
+    agc->reg_ops = &aspeed_sgpio_2700_ops;
+}
+
+static const TypeInfo aspeed_sgpio_info = {
+    .name           = TYPE_ASPEED_SGPIO,
+    .parent         = TYPE_SYS_BUS_DEVICE,
+    .instance_size  = sizeof(AspeedSGPIOState),
+    .class_size     = sizeof(AspeedSGPIOClass),
+    .class_init     = aspeed_sgpio_class_init,
+    .abstract       = true,
+};
+
+static const TypeInfo aspeed_sgpio_ast2700_info = {
+    .name           = TYPE_ASPEED_SGPIO "-ast2700",
+    .parent         = TYPE_ASPEED_SGPIO,
+    .class_init     = aspeed_sgpio_2700_class_init,
+};
+
+static void aspeed_sgpio_register_types(void)
+{
+    type_register_static(&aspeed_sgpio_info);
+    type_register_static(&aspeed_sgpio_ast2700_info);
+}
+
+type_init(aspeed_sgpio_register_types);
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 74840619c01b..6a67ee958faa 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -16,5 +16,6 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
 ))
 system_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_gpio.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
+system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sgpio.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
 system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
-- 
2.52.0


