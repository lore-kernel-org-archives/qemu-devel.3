Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D429F47CAA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCy6-0000E5-Ub; Thu, 05 Mar 2026 12:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxC-0007N7-Q2
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:57:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCx8-0003X0-KW
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KrOTybCEud1FLjXBsSIPPZKkVlDktI9FRIIIe8sQSSk=;
 b=AQKtg8StGfTz4L3FphHMU4FUy1k4LzseO8dmw35PdWVZqNUVeXfHtgvhBmnSFgOl2PaKn3
 6bF0W8JLd7/CmGil0Q+XYntkU4sHHm60E0WsFACOANwrZbWZxZaaD0VtG8BoXU6DOAKssA
 TUdfOvgPHWoJbjm1e3bA/DnQX5vQupQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-84H0rAXxOO-0iqTV4KwV9A-1; Thu,
 05 Mar 2026 12:57:30 -0500
X-MC-Unique: 84H0rAXxOO-0iqTV4KwV9A-1
X-Mimecast-MFC-AGG-ID: 84H0rAXxOO-0iqTV4KwV9A_1772733448
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F290195605F; Thu,  5 Mar 2026 17:57:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B83B3003E9F; Thu,  5 Mar 2026 17:57:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/38] hw/i3c: Split DesignWare I3C out of Aspeed I3C
Date: Thu,  5 Mar 2026 18:56:38 +0100
Message-ID: <20260305175711.1119025-6-clg@redhat.com>
In-Reply-To: <20260305175711.1119025-1-clg@redhat.com>
References: <20260305175711.1119025-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The Aspeed I3C IP block is technically an Aspeed IP block that manages
6 DW I3C controllers.

To help reflect this better and to make it easier for other SoCs to use
the DW I3C model, we'll split out the DW portion from the Aspeed
portion.

Signed-off-by: Joe Komlodi <komlodi@google.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Tested-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260225021158.1586584-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i3c/aspeed_i3c.h |  17 +--
 include/hw/i3c/dw-i3c.h     |  33 ++++++
 hw/i3c/aspeed_i3c.c         | 181 +-------------------------------
 hw/i3c/dw-i3c.c             | 202 ++++++++++++++++++++++++++++++++++++
 hw/arm/Kconfig              |   1 +
 hw/i3c/Kconfig              |   3 +
 hw/i3c/meson.build          |   1 +
 hw/i3c/trace-events         |   6 +-
 8 files changed, 250 insertions(+), 194 deletions(-)
 create mode 100644 include/hw/i3c/dw-i3c.h
 create mode 100644 hw/i3c/dw-i3c.c

diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h
index bd0ffc84eab9..ade5c42d39ba 100644
--- a/include/hw/i3c/aspeed_i3c.h
+++ b/include/hw/i3c/aspeed_i3c.h
@@ -10,27 +10,15 @@
 #ifndef ASPEED_I3C_H
 #define ASPEED_I3C_H
 
+#include "hw/i3c/dw-i3c.h"
 #include "hw/core/sysbus.h"
 
 #define TYPE_ASPEED_I3C "aspeed.i3c"
-#define TYPE_ASPEED_I3C_DEVICE "aspeed.i3c.device"
 OBJECT_DECLARE_TYPE(AspeedI3CState, AspeedI3CClass, ASPEED_I3C)
 
 #define ASPEED_I3C_NR_REGS (0x70 >> 2)
-#define ASPEED_I3C_DEVICE_NR_REGS (0x300 >> 2)
 #define ASPEED_I3C_NR_DEVICES 6
 
-OBJECT_DECLARE_SIMPLE_TYPE(AspeedI3CDevice, ASPEED_I3C_DEVICE)
-struct AspeedI3CDevice {
-    SysBusDevice parent_obj;
-
-    MemoryRegion mr;
-    qemu_irq irq;
-
-    uint8_t id;
-    uint32_t regs[ASPEED_I3C_DEVICE_NR_REGS];
-};
-
 struct AspeedI3CState {
     SysBusDevice parent_obj;
 
@@ -39,6 +27,7 @@ struct AspeedI3CState {
     qemu_irq irq;
 
     uint32_t regs[ASPEED_I3C_NR_REGS];
-    AspeedI3CDevice devices[ASPEED_I3C_NR_DEVICES];
+    DWI3C devices[ASPEED_I3C_NR_DEVICES];
+    uint8_t id;
 };
 #endif /* ASPEED_I3C_H */
diff --git a/include/hw/i3c/dw-i3c.h b/include/hw/i3c/dw-i3c.h
new file mode 100644
index 000000000000..7143e8ca7a12
--- /dev/null
+++ b/include/hw/i3c/dw-i3c.h
@@ -0,0 +1,33 @@
+/*
+ * DesignWare I3C Controller
+ *
+ * Copyright (C) 2021 ASPEED Technology Inc.
+ * Copyright (C) 2025 Google, LLC.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef DW_I3C_H
+#define DW_I3C_H
+
+#include "hw/core/sysbus.h"
+
+#define TYPE_DW_I3C "dw.i3c"
+OBJECT_DECLARE_SIMPLE_TYPE(DWI3C, DW_I3C)
+
+#define DW_I3C_NR_REGS (0x300 >> 2)
+
+struct DWI3C {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mr;
+    qemu_irq irq;
+
+    uint8_t id;
+    uint32_t regs[DW_I3C_NR_REGS];
+};
+
+/* Extern for other controllers that use DesignWare I3C. */
+extern const VMStateDescription vmstate_dw_i3c;
+
+#endif /* DW_I3C_H */
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c
index e7cdfbfdbda6..647074d1816f 100644
--- a/hw/i3c/aspeed_i3c.c
+++ b/hw/i3c/aspeed_i3c.c
@@ -2,6 +2,7 @@
  * ASPEED I3C Controller
  *
  * Copyright (C) 2021 ASPEED Technology Inc.
+ * Copyright (C) 2025 Google, LLC.
  *
  * This code is licensed under the GPL version 2 or later.  See
  * the COPYING file in the top-level directory.
@@ -43,162 +44,6 @@ REG32(I3C6_REG1, 0x64)
     FIELD(I3C6_REG1, I2C_MODE,  0,  1)
     FIELD(I3C6_REG1, SA_EN,     15, 1)
 
-/* I3C Device Registers */
-REG32(DEVICE_CTRL,                  0x00)
-REG32(DEVICE_ADDR,                  0x04)
-REG32(HW_CAPABILITY,                0x08)
-REG32(COMMAND_QUEUE_PORT,           0x0c)
-REG32(RESPONSE_QUEUE_PORT,          0x10)
-REG32(RX_TX_DATA_PORT,              0x14)
-REG32(IBI_QUEUE_STATUS,             0x18)
-REG32(IBI_QUEUE_DATA,               0x18)
-REG32(QUEUE_THLD_CTRL,              0x1c)
-REG32(DATA_BUFFER_THLD_CTRL,        0x20)
-REG32(IBI_QUEUE_CTRL,               0x24)
-REG32(IBI_MR_REQ_REJECT,            0x2c)
-REG32(IBI_SIR_REQ_REJECT,           0x30)
-REG32(RESET_CTRL,                   0x34)
-REG32(SLV_EVENT_CTRL,               0x38)
-REG32(INTR_STATUS,                  0x3c)
-REG32(INTR_STATUS_EN,               0x40)
-REG32(INTR_SIGNAL_EN,               0x44)
-REG32(INTR_FORCE,                   0x48)
-REG32(QUEUE_STATUS_LEVEL,           0x4c)
-REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)
-REG32(PRESENT_STATE,                0x54)
-REG32(CCC_DEVICE_STATUS,            0x58)
-REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)
-    FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)
-    FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)
-REG32(DEV_CHAR_TABLE_POINTER,       0x60)
-REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)
-REG32(SLV_MIPI_PID_VALUE,           0x70)
-REG32(SLV_PID_VALUE,                0x74)
-REG32(SLV_CHAR_CTRL,                0x78)
-REG32(SLV_MAX_LEN,                  0x7c)
-REG32(MAX_READ_TURNAROUND,          0x80)
-REG32(MAX_DATA_SPEED,               0x84)
-REG32(SLV_DEBUG_STATUS,             0x88)
-REG32(SLV_INTR_REQ,                 0x8c)
-REG32(DEVICE_CTRL_EXTENDED,         0xb0)
-REG32(SCL_I3C_OD_TIMING,            0xb4)
-REG32(SCL_I3C_PP_TIMING,            0xb8)
-REG32(SCL_I2C_FM_TIMING,            0xbc)
-REG32(SCL_I2C_FMP_TIMING,           0xc0)
-REG32(SCL_EXT_LCNT_TIMING,          0xc8)
-REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)
-REG32(BUS_FREE_TIMING,              0xd4)
-REG32(BUS_IDLE_TIMING,              0xd8)
-REG32(I3C_VER_ID,                   0xe0)
-REG32(I3C_VER_TYPE,                 0xe4)
-REG32(EXTENDED_CAPABILITY,          0xe8)
-REG32(SLAVE_CONFIG,                 0xec)
-
-static const uint32_t ast2600_i3c_device_resets[ASPEED_I3C_DEVICE_NR_REGS] = {
-    [R_HW_CAPABILITY]               = 0x000e00bf,
-    [R_QUEUE_THLD_CTRL]             = 0x01000101,
-    [R_I3C_VER_ID]                  = 0x3130302a,
-    [R_I3C_VER_TYPE]                = 0x6c633033,
-    [R_DEVICE_ADDR_TABLE_POINTER]   = 0x00080280,
-    [R_DEV_CHAR_TABLE_POINTER]      = 0x00020200,
-    [A_VENDOR_SPECIFIC_REG_POINTER] = 0x000000b0,
-    [R_SLV_MAX_LEN]                 = 0x00ff00ff,
-};
-
-static uint64_t aspeed_i3c_device_read(void *opaque, hwaddr offset,
-                                       unsigned size)
-{
-    AspeedI3CDevice *s = ASPEED_I3C_DEVICE(opaque);
-    uint32_t addr = offset >> 2;
-    uint64_t value;
-
-    switch (addr) {
-    case R_COMMAND_QUEUE_PORT:
-        value = 0;
-        break;
-    default:
-        value = s->regs[addr];
-        break;
-    }
-
-    trace_aspeed_i3c_device_read(s->id, offset, value);
-
-    return value;
-}
-
-static void aspeed_i3c_device_write(void *opaque, hwaddr offset,
-                                    uint64_t value, unsigned size)
-{
-    AspeedI3CDevice *s = ASPEED_I3C_DEVICE(opaque);
-    uint32_t addr = offset >> 2;
-
-    trace_aspeed_i3c_device_write(s->id, offset, value);
-
-    switch (addr) {
-    case R_HW_CAPABILITY:
-    case R_RESPONSE_QUEUE_PORT:
-    case R_IBI_QUEUE_DATA:
-    case R_QUEUE_STATUS_LEVEL:
-    case R_PRESENT_STATE:
-    case R_CCC_DEVICE_STATUS:
-    case R_DEVICE_ADDR_TABLE_POINTER:
-    case R_VENDOR_SPECIFIC_REG_POINTER:
-    case R_SLV_CHAR_CTRL:
-    case R_SLV_MAX_LEN:
-    case R_MAX_READ_TURNAROUND:
-    case R_I3C_VER_ID:
-    case R_I3C_VER_TYPE:
-    case R_EXTENDED_CAPABILITY:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: write to readonly register[0x%02" HWADDR_PRIx
-                      "] = 0x%08" PRIx64 "\n",
-                      __func__, offset, value);
-        break;
-    case R_RX_TX_DATA_PORT:
-        break;
-    case R_RESET_CTRL:
-        break;
-    default:
-        s->regs[addr] = value;
-        break;
-    }
-}
-
-static const VMStateDescription aspeed_i3c_device_vmstate = {
-    .name = TYPE_ASPEED_I3C,
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (const VMStateField[]){
-        VMSTATE_UINT32_ARRAY(regs, AspeedI3CDevice, ASPEED_I3C_DEVICE_NR_REGS),
-        VMSTATE_END_OF_LIST(),
-    }
-};
-
-static const MemoryRegionOps aspeed_i3c_device_ops = {
-    .read = aspeed_i3c_device_read,
-    .write = aspeed_i3c_device_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static void aspeed_i3c_device_reset(DeviceState *dev)
-{
-    AspeedI3CDevice *s = ASPEED_I3C_DEVICE(dev);
-
-    memcpy(s->regs, ast2600_i3c_device_resets, sizeof(s->regs));
-}
-
-static void aspeed_i3c_device_realize(DeviceState *dev, Error **errp)
-{
-    AspeedI3CDevice *s = ASPEED_I3C_DEVICE(dev);
-    g_autofree char *name = g_strdup_printf(TYPE_ASPEED_I3C_DEVICE ".%d",
-                                            s->id);
-
-    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
-
-    memory_region_init_io(&s->mr, OBJECT(s), &aspeed_i3c_device_ops,
-                          s, name, ASPEED_I3C_DEVICE_NR_REGS << 2);
-}
-
 static uint64_t aspeed_i3c_read(void *opaque, hwaddr addr, unsigned int size)
 {
     AspeedI3CState *s = ASPEED_I3C(opaque);
@@ -275,7 +120,7 @@ static void aspeed_i3c_instance_init(Object *obj)
 
     for (i = 0; i < ASPEED_I3C_NR_DEVICES; ++i) {
         object_initialize_child(obj, "device[*]", &s->devices[i],
-                TYPE_ASPEED_I3C_DEVICE);
+                TYPE_DW_I3C);
     }
 }
 
@@ -323,20 +168,6 @@ static void aspeed_i3c_realize(DeviceState *dev, Error **errp)
 
 }
 
-static const Property aspeed_i3c_device_properties[] = {
-    DEFINE_PROP_UINT8("device-id", AspeedI3CDevice, id, 0),
-};
-
-static void aspeed_i3c_device_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->desc = "Aspeed I3C Device";
-    dc->realize = aspeed_i3c_device_realize;
-    device_class_set_legacy_reset(dc, aspeed_i3c_device_reset);
-    device_class_set_props(dc, aspeed_i3c_device_properties);
-}
-
 static const VMStateDescription vmstate_aspeed_i3c = {
     .name = TYPE_ASPEED_I3C,
     .version_id = 1,
@@ -344,7 +175,7 @@ static const VMStateDescription vmstate_aspeed_i3c = {
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedI3CState, ASPEED_I3C_NR_REGS),
         VMSTATE_STRUCT_ARRAY(devices, AspeedI3CState, ASPEED_I3C_NR_DEVICES, 1,
-                             aspeed_i3c_device_vmstate, AspeedI3CDevice),
+                             vmstate_dw_i3c, DWI3C),
         VMSTATE_END_OF_LIST(),
     }
 };
@@ -367,12 +198,6 @@ static const TypeInfo aspeed_i3c_types[] = {
         .instance_size = sizeof(AspeedI3CState),
         .class_init = aspeed_i3c_class_init,
     },
-    {
-        .name = TYPE_ASPEED_I3C_DEVICE,
-        .parent = TYPE_SYS_BUS_DEVICE,
-        .instance_size = sizeof(AspeedI3CDevice),
-        .class_init = aspeed_i3c_device_class_init,
-    },
 };
 
 DEFINE_TYPES(aspeed_i3c_types)
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
new file mode 100644
index 000000000000..6cadc5919157
--- /dev/null
+++ b/hw/i3c/dw-i3c.c
@@ -0,0 +1,202 @@
+/*
+ * DesignWare I3C Controller
+ *
+ * Copyright (C) 2021 ASPEED Technology Inc.
+ * Copyright (C) 2025 Google, LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "hw/i3c/i3c.h"
+#include "hw/i3c/dw-i3c.h"
+#include "hw/core/registerfields.h"
+#include "hw/core/qdev-properties.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+REG32(DEVICE_CTRL,                  0x00)
+REG32(DEVICE_ADDR,                  0x04)
+REG32(HW_CAPABILITY,                0x08)
+REG32(COMMAND_QUEUE_PORT,           0x0c)
+REG32(RESPONSE_QUEUE_PORT,          0x10)
+REG32(RX_TX_DATA_PORT,              0x14)
+REG32(IBI_QUEUE_STATUS,             0x18)
+REG32(IBI_QUEUE_DATA,               0x18)
+REG32(QUEUE_THLD_CTRL,              0x1c)
+REG32(DATA_BUFFER_THLD_CTRL,        0x20)
+REG32(IBI_QUEUE_CTRL,               0x24)
+REG32(IBI_MR_REQ_REJECT,            0x2c)
+REG32(IBI_SIR_REQ_REJECT,           0x30)
+REG32(RESET_CTRL,                   0x34)
+REG32(SLV_EVENT_CTRL,               0x38)
+REG32(INTR_STATUS,                  0x3c)
+REG32(INTR_STATUS_EN,               0x40)
+REG32(INTR_SIGNAL_EN,               0x44)
+REG32(INTR_FORCE,                   0x48)
+REG32(QUEUE_STATUS_LEVEL,           0x4c)
+REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)
+REG32(PRESENT_STATE,                0x54)
+REG32(CCC_DEVICE_STATUS,            0x58)
+REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)
+    FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)
+    FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)
+REG32(DEV_CHAR_TABLE_POINTER,       0x60)
+REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)
+REG32(SLV_MIPI_PID_VALUE,           0x70)
+REG32(SLV_PID_VALUE,                0x74)
+REG32(SLV_CHAR_CTRL,                0x78)
+REG32(SLV_MAX_LEN,                  0x7c)
+REG32(MAX_READ_TURNAROUND,          0x80)
+REG32(MAX_DATA_SPEED,               0x84)
+REG32(SLV_DEBUG_STATUS,             0x88)
+REG32(SLV_INTR_REQ,                 0x8c)
+REG32(DEVICE_CTRL_EXTENDED,         0xb0)
+REG32(SCL_I3C_OD_TIMING,            0xb4)
+REG32(SCL_I3C_PP_TIMING,            0xb8)
+REG32(SCL_I2C_FM_TIMING,            0xbc)
+REG32(SCL_I2C_FMP_TIMING,           0xc0)
+REG32(SCL_EXT_LCNT_TIMING,          0xc8)
+REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)
+REG32(BUS_FREE_TIMING,              0xd4)
+REG32(BUS_IDLE_TIMING,              0xd8)
+REG32(I3C_VER_ID,                   0xe0)
+REG32(I3C_VER_TYPE,                 0xe4)
+REG32(EXTENDED_CAPABILITY,          0xe8)
+REG32(SLAVE_CONFIG,                 0xec)
+
+static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] = {
+    [R_HW_CAPABILITY]               = 0x000e00bf,
+    [R_QUEUE_THLD_CTRL]             = 0x01000101,
+    [R_I3C_VER_ID]                  = 0x3130302a,
+    [R_I3C_VER_TYPE]                = 0x6c633033,
+    [R_DEVICE_ADDR_TABLE_POINTER]   = 0x00080280,
+    [R_DEV_CHAR_TABLE_POINTER]      = 0x00020200,
+    [A_VENDOR_SPECIFIC_REG_POINTER] = 0x000000b0,
+    [R_SLV_MAX_LEN]                 = 0x00ff00ff,
+};
+
+static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)
+{
+    DWI3C *s = DW_I3C(opaque);
+    uint32_t addr = offset >> 2;
+    uint64_t value;
+
+    switch (addr) {
+    case R_COMMAND_QUEUE_PORT:
+        value = 0;
+        break;
+    default:
+        value = s->regs[addr];
+        break;
+    }
+
+    trace_dw_i3c_read(s->id, offset, value);
+
+    return value;
+}
+
+static void dw_i3c_write(void *opaque, hwaddr offset, uint64_t value,
+                         unsigned size)
+{
+    DWI3C *s = DW_I3C(opaque);
+    uint32_t addr = offset >> 2;
+
+    trace_dw_i3c_write(s->id, offset, value);
+
+    switch (addr) {
+    case R_HW_CAPABILITY:
+    case R_RESPONSE_QUEUE_PORT:
+    case R_IBI_QUEUE_DATA:
+    case R_QUEUE_STATUS_LEVEL:
+    case R_PRESENT_STATE:
+    case R_CCC_DEVICE_STATUS:
+    case R_DEVICE_ADDR_TABLE_POINTER:
+    case R_VENDOR_SPECIFIC_REG_POINTER:
+    case R_SLV_CHAR_CTRL:
+    case R_SLV_MAX_LEN:
+    case R_MAX_READ_TURNAROUND:
+    case R_I3C_VER_ID:
+    case R_I3C_VER_TYPE:
+    case R_EXTENDED_CAPABILITY:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: write to readonly register[0x%02" HWADDR_PRIx
+                      "] = 0x%08" PRIx64 "\n",
+                      __func__, offset, value);
+        break;
+    case R_RX_TX_DATA_PORT:
+        break;
+    case R_RESET_CTRL:
+        break;
+    default:
+        s->regs[addr] = value;
+        break;
+    }
+}
+
+const VMStateDescription vmstate_dw_i3c = {
+    .name = TYPE_DW_I3C,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]){
+        VMSTATE_UINT32_ARRAY(regs, DWI3C, DW_I3C_NR_REGS),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static const MemoryRegionOps dw_i3c_ops = {
+    .read = dw_i3c_read,
+    .write = dw_i3c_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void dw_i3c_reset_enter(Object *obj, ResetType type)
+{
+    DWI3C *s = DW_I3C(obj);
+
+    memcpy(s->regs, dw_i3c_resets, sizeof(s->regs));
+}
+
+static void dw_i3c_realize(DeviceState *dev, Error **errp)
+{
+    DWI3C *s = DW_I3C(dev);
+    g_autofree char *name = g_strdup_printf(TYPE_DW_I3C ".%d", s->id);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+
+    memory_region_init_io(&s->mr, OBJECT(s), &dw_i3c_ops, s, name,
+                          DW_I3C_NR_REGS << 2);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
+}
+
+static const Property dw_i3c_properties[] = {
+    DEFINE_PROP_UINT8("device-id", DWI3C, id, 0),
+};
+
+static void dw_i3c_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.enter = dw_i3c_reset_enter;
+
+    dc->desc = "DesignWare I3C Controller";
+    dc->realize = dw_i3c_realize;
+    dc->vmsd = &vmstate_dw_i3c;
+    device_class_set_props(dc, dw_i3c_properties);
+}
+
+static const TypeInfo dw_i3c_types[] = {
+    {
+        .name = TYPE_DW_I3C,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(DWI3C),
+        .class_init = dw_i3c_class_init,
+    },
+};
+
+DEFINE_TYPES(dw_i3c_types)
+
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 8344b9769f7d..d545ecd712aa 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -546,6 +546,7 @@ config ASPEED_SOC
     select FTGMAC100
     select I2C
     select I3C
+    select DW_I3C
     select DPS310
     select PCA9552
     select PCA9554
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig
index e07fe445c655..ecec77d6fc81 100644
--- a/hw/i3c/Kconfig
+++ b/hw/i3c/Kconfig
@@ -1,2 +1,5 @@
 config I3C
     bool
+
+config DW_I3C
+    bool
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build
index fb127613fec5..83d75e7d5c15 100644
--- a/hw/i3c/meson.build
+++ b/hw/i3c/meson.build
@@ -1,4 +1,5 @@
 i3c_ss = ss.source_set()
 i3c_ss.add(when: 'CONFIG_I3C', if_true: files('core.c'))
 i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))
+i3c_ss.add(when: 'CONFIG_DW_I3C', if_true: files('dw-i3c.c'))
 system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events
index cdf7cb07f6e6..2d944387db29 100644
--- a/hw/i3c/trace-events
+++ b/hw/i3c/trace-events
@@ -3,8 +3,10 @@
 # aspeed_i3c.c
 aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRIx64 " data 0x%" PRIx64
 aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" PRIx64 " data 0x%" PRIx64
-aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
-aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
+
+# dw-i3c,c
+dw_i3c_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
+dw_i3c_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
 
 # core.c
 i3c_target_event(uint8_t address, uint8_t event) "I3C target 0x%" PRIx8 " event 0x%" PRIx8
-- 
2.53.0


