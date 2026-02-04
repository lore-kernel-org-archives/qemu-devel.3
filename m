Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F2CE95374
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaBt-00023Q-M3; Wed, 04 Feb 2026 05:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBh-0001aq-0D
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBc-00046W-VN
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h1nByeQJG390FPZelYiFPIApZxR6CBGG4X3l2yt9zDY=;
 b=RZK0TFH7CSzKUAgRH5oSjTKDSIJyNwXlL3njz4G3Gj/9vI2xiCKgEPepghiuCd5oPoQXYN
 ZlaW1xhmXx5PoZRbXIgMQMtEoseiSHry/8P5WVHG6uO9ZOnPtc5FzIqzv1WG2s9t3EHfoQ
 NuFbqgaMwZiuSUyPEbl13mMCzBAdHXA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-XmdmiKKvOPCP_xhDicUu0Q-1; Wed,
 04 Feb 2026 05:32:31 -0500
X-MC-Unique: XmdmiKKvOPCP_xhDicUu0Q-1
X-Mimecast-MFC-AGG-ID: XmdmiKKvOPCP_xhDicUu0Q_1770201150
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C716419560A5; Wed,  4 Feb 2026 10:32:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF60418003F6; Wed,  4 Feb 2026 10:32:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nabih Estefan <nabihestefan@google.com>
Subject: [PULL 24/45] hw/misc: Add LTPI controller
Date: Wed,  4 Feb 2026 11:31:15 +0100
Message-ID: <20260204103136.1795455-25-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kane Chen <kane_chen@aspeedtech.com>

LTPI (LVDS Tunneling Protocol & Interface) is defined in the OCP DC-SCM
2.0 specification:
https://www.opencompute.org/documents/ocp-dc-scm-2-0-ltpi-ver-1-0-pdf

LTPI is a protocol and physical interface for tunneling various low-speed
signals between the HPM and SCM. As shown in Figure 2, the AST27x0 (left)
integrates two LTPI controllers, allowing it to connect to up to two
extended boards.

This commit introduces a simple device model for the ASPEED LTPI
controller in QEMU.

The model includes basic MMIO read/write operations and sets default
register values during reset to emulate a link-up state.

Implements register space with read/write callbacks.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>
Link: https://lore.kernel.org/qemu-devel/20260204082113.3955407-2-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/misc/aspeed_ltpi.h |  33 ++++++
 hw/misc/aspeed_ltpi.c         | 193 ++++++++++++++++++++++++++++++++++
 hw/misc/meson.build           |   1 +
 3 files changed, 227 insertions(+)
 create mode 100644 include/hw/misc/aspeed_ltpi.h
 create mode 100644 hw/misc/aspeed_ltpi.c

diff --git a/include/hw/misc/aspeed_ltpi.h b/include/hw/misc/aspeed_ltpi.h
new file mode 100644
index 000000000000..3330a49b0564
--- /dev/null
+++ b/include/hw/misc/aspeed_ltpi.h
@@ -0,0 +1,33 @@
+/*
+ * ASPEED LTPI Controller
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef ASPEED_LTPI_H
+#define ASPEED_LTPI_H
+
+#include "hw/core/sysbus.h"
+
+#define TYPE_ASPEED_LTPI "aspeed.ltpi-ctrl"
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedLTPIState, ASPEED_LTPI)
+
+#define ASPEED_LTPI_TOTAL_SIZE  0x900
+#define ASPEED_LTPI_CTRL_SIZE   0x200
+#define ASPEED_LTPI_PHY_SIZE    0x100
+#define ASPEED_LTPI_TOP_SIZE    0x100
+
+struct AspeedLTPIState {
+    SysBusDevice parent;
+    MemoryRegion mmio;
+    MemoryRegion mmio_ctrl;
+    MemoryRegion mmio_phy;
+    MemoryRegion mmio_top;
+
+    uint32_t ctrl_regs[ASPEED_LTPI_CTRL_SIZE >> 2];
+    uint32_t phy_regs[ASPEED_LTPI_PHY_SIZE >> 2];
+    uint32_t top_regs[ASPEED_LTPI_TOP_SIZE >> 2];
+};
+
+#endif /* ASPEED_LTPI_H */
diff --git a/hw/misc/aspeed_ltpi.c b/hw/misc/aspeed_ltpi.c
new file mode 100644
index 000000000000..131cea9c6b8b
--- /dev/null
+++ b/hw/misc/aspeed_ltpi.c
@@ -0,0 +1,193 @@
+/*
+ * ASPEED LTPI Controller
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "migration/vmstate.h"
+#include "hw/misc/aspeed_ltpi.h"
+
+#define ASPEED_LTPI_CTRL_BASE   0x000
+#define ASPEED_LTPI_PHY_BASE    0x200
+#define ASPEED_LTPI_TOP_BASE    0x800
+
+#define LTPI_CTRL_LINK_MNG 0x42
+#define LTPI_PHY_MODE 0x0
+
+static uint64_t aspeed_ltpi_top_read(void *opaque, hwaddr offset, unsigned size)
+{
+    AspeedLTPIState *s = opaque;
+    uint32_t idx = offset >> 2;
+
+    return s->top_regs[idx];
+}
+
+static void aspeed_ltpi_top_write(void *opaque, hwaddr offset,
+                              uint64_t val, unsigned size)
+{
+    AspeedLTPIState *s = opaque;
+    uint32_t idx = offset >> 2;
+
+    switch (offset) {
+    default:
+        s->top_regs[idx] = (uint32_t)val;
+        break;
+    }
+}
+
+static const MemoryRegionOps aspeed_ltpi_top_ops = {
+    .read = aspeed_ltpi_top_read,
+    .write = aspeed_ltpi_top_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static uint64_t aspeed_ltpi_phy_read(void *opaque, hwaddr offset, unsigned size)
+{
+    AspeedLTPIState *s = opaque;
+    uint32_t idx = offset >> 2;
+
+    return s->phy_regs[idx];
+}
+
+static void aspeed_ltpi_phy_write(void *opaque, hwaddr offset,
+                              uint64_t val, unsigned size)
+{
+    AspeedLTPIState *s = opaque;
+    uint32_t idx = offset >> 2;
+
+    switch (offset) {
+    default:
+        s->phy_regs[idx] = (uint32_t)val;
+        break;
+    }
+}
+
+static const MemoryRegionOps aspeed_ltpi_phy_ops = {
+    .read = aspeed_ltpi_phy_read,
+    .write = aspeed_ltpi_phy_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static uint64_t aspeed_ltpi_ctrl_read(void *opaque,
+                                      hwaddr offset, unsigned size)
+{
+    AspeedLTPIState *s = opaque;
+    uint32_t idx = offset >> 2;
+
+    return s->ctrl_regs[idx];
+}
+
+static void aspeed_ltpi_ctrl_write(void *opaque, hwaddr offset,
+                              uint64_t val, unsigned size)
+{
+    AspeedLTPIState *s = opaque;
+    uint32_t idx = offset >> 2;
+
+    switch (offset) {
+    default:
+        s->ctrl_regs[idx] = (uint32_t)val;
+        break;
+    }
+}
+
+static const MemoryRegionOps aspeed_ltpi_ctrl_ops = {
+    .read = aspeed_ltpi_ctrl_read,
+    .write = aspeed_ltpi_ctrl_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
+static void aspeed_ltpi_reset(DeviceState *dev)
+{
+    AspeedLTPIState *s = ASPEED_LTPI(dev);
+
+    memset(s->ctrl_regs, 0, sizeof(s->ctrl_regs));
+    memset(s->phy_regs, 0, sizeof(s->phy_regs));
+    memset(s->top_regs, 0, sizeof(s->top_regs));
+    /* set default values */
+    s->ctrl_regs[LTPI_CTRL_LINK_MNG] = 0x11900007;
+    s->phy_regs[LTPI_PHY_MODE] = 0x2;
+}
+
+
+static const VMStateDescription vmstate_aspeed_ltpi = {
+    .name = TYPE_ASPEED_LTPI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(ctrl_regs, AspeedLTPIState,
+                             ASPEED_LTPI_CTRL_SIZE >> 2),
+        VMSTATE_UINT32_ARRAY(phy_regs, AspeedLTPIState,
+                             ASPEED_LTPI_PHY_SIZE >> 2),
+        VMSTATE_UINT32_ARRAY(top_regs, AspeedLTPIState,
+                             ASPEED_LTPI_TOP_SIZE >> 2),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void aspeed_ltpi_realize(DeviceState *dev, Error **errp)
+{
+    AspeedLTPIState *s = ASPEED_LTPI(dev);
+
+    memory_region_init(&s->mmio, OBJECT(s), TYPE_ASPEED_LTPI,
+                       ASPEED_LTPI_TOTAL_SIZE);
+
+    memory_region_init_io(&s->mmio_ctrl, OBJECT(s),
+                          &aspeed_ltpi_ctrl_ops, s,
+                          "aspeed-ltpi-ctrl", ASPEED_LTPI_CTRL_SIZE);
+
+    memory_region_init_io(&s->mmio_phy, OBJECT(s),
+                          &aspeed_ltpi_phy_ops, s,
+                          "aspeed-ltpi-phy", ASPEED_LTPI_PHY_SIZE);
+
+    memory_region_init_io(&s->mmio_top, OBJECT(s),
+                          &aspeed_ltpi_top_ops, s,
+                          "aspeed-ltpi-top", ASPEED_LTPI_TOP_SIZE);
+
+    memory_region_add_subregion(&s->mmio,
+                                ASPEED_LTPI_CTRL_BASE, &s->mmio_ctrl);
+    memory_region_add_subregion(&s->mmio,
+                                ASPEED_LTPI_PHY_BASE, &s->mmio_phy);
+    memory_region_add_subregion(&s->mmio,
+                                ASPEED_LTPI_TOP_BASE, &s->mmio_top);
+
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mmio);
+}
+
+static void aspeed_ltpi_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = aspeed_ltpi_realize;
+    dc->vmsd = &vmstate_aspeed_ltpi;
+    device_class_set_legacy_reset(dc, aspeed_ltpi_reset);
+}
+
+static const TypeInfo aspeed_ltpi_info = {
+    .name          = TYPE_ASPEED_LTPI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AspeedLTPIState),
+    .class_init    = aspeed_ltpi_class_init,
+};
+
+static void aspeed_ltpi_register_types(void)
+{
+    type_register_static(&aspeed_ltpi_info);
+}
+
+type_init(aspeed_ltpi_register_types);
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index c444e030ecda..f7f1b0da75c5 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -137,6 +137,7 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_hace.c',
   'aspeed_i3c.c',
   'aspeed_lpc.c',
+  'aspeed_ltpi.c',
   'aspeed_scu.c',
   'aspeed_sbc.c',
   'aspeed_sdmc.c',
-- 
2.52.0


