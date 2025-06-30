Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C142FC7EE2A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 05:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW6th-0005X8-4k; Mon, 30 Jun 2025 01:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uW6te-0005Vl-Tq; Mon, 30 Jun 2025 01:17:38 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uW6td-0003fn-5Z; Mon, 30 Jun 2025 01:17:38 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 30 Jun
 2025 13:17:21 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Jun 2025 13:17:21 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v3 1/3] hw/misc/aspeed_otp: Add OTP device model with fallback
 RAM storage
Date: Mon, 30 Jun 2025 13:17:18 +0800
Message-ID: <20250630051721.254207-2-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630051721.254207-1-kane_chen@aspeedtech.com>
References: <20250630051721.254207-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

This patch introduces a QEMU model of the ASPEED One-Time Programmable
(OTP) memory, used for secure fuse storage. The model simulates a
word-addressable OTP region with a memory-like interface via a dedicated
AddressSpace.

If no external block backend is provided via the "drive" property, the
model automatically allocates an internal RAM-backed storage buffer
to hold OTP data, enabling simplified usage without CLI configuration.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 include/hw/nvram/aspeed_otp.h |  33 ++++++++++
 hw/nvram/aspeed_otp.c         | 113 ++++++++++++++++++++++++++++++++++
 hw/nvram/meson.build          |   4 ++
 3 files changed, 150 insertions(+)
 create mode 100644 include/hw/nvram/aspeed_otp.h
 create mode 100644 hw/nvram/aspeed_otp.c

diff --git a/include/hw/nvram/aspeed_otp.h b/include/hw/nvram/aspeed_otp.h
new file mode 100644
index 0000000000..22b2195a00
--- /dev/null
+++ b/include/hw/nvram/aspeed_otp.h
@@ -0,0 +1,33 @@
+/*
+ *  ASPEED OTP (One-Time Programmable) memory
+ *
+ *  Copyright (C) 2025 Aspeed
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ASPEED_OTP_H
+#define ASPEED_OTP_H
+
+#include "system/memory.h"
+#include "hw/block/block.h"
+#include "system/address-spaces.h"
+
+#define TYPE_ASPEED_OTP "aspeed.otp"
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedOTPState, ASPEED_OTP)
+
+typedef struct AspeedOTPState {
+    DeviceState parent_obj;
+
+    BlockBackend *blk;
+
+    uint64_t size;
+
+    AddressSpace as;
+
+    MemoryRegion mmio;
+
+    uint8_t *storage;
+} AspeedOTPState;
+
+#endif /* ASPEED_OTP_H */
diff --git a/hw/nvram/aspeed_otp.c b/hw/nvram/aspeed_otp.c
new file mode 100644
index 0000000000..f018c58713
--- /dev/null
+++ b/hw/nvram/aspeed_otp.c
@@ -0,0 +1,113 @@
+/*
+ *  ASPEED OTP (One-Time Programmable) memory
+ *
+ *  Copyright (C) 2025 Aspeed
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "system/block-backend-global-state.h"
+#include "system/block-backend-io.h"
+#include "hw/qdev-properties.h"
+#include "hw/nvram/aspeed_otp.h"
+
+static uint64_t aspeed_otp_read(void *opaque, hwaddr offset, unsigned size)
+{
+    AspeedOTPState *s = opaque;
+    uint64_t val = 0;
+
+    memcpy(&val, s->storage + offset, size);
+
+    return val;
+}
+
+static void aspeed_otp_write(void *opaque, hwaddr offset,
+                                uint64_t val, unsigned size)
+{
+    AspeedOTPState *s = opaque;
+
+    memcpy(s->storage + offset, &val, size);
+}
+
+static bool aspeed_otp_init_storage(AspeedOTPState *s, Error **errp)
+{
+    uint32_t *p;
+    int i, num;
+    uint64_t perm;
+
+    if (s->blk) {
+        perm = BLK_PERM_CONSISTENT_READ |
+               (blk_supports_write_perm(s->blk) ? BLK_PERM_WRITE : 0);
+        if (blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp) < 0) {
+            return false;
+        }
+        if (blk_pread(s->blk, 0, s->size, s->storage, 0) < 0) {
+            error_setg(errp, "Failed to read the initial flash content");
+            return false;
+        }
+    } else {
+        num = s->size / sizeof(uint32_t);
+        p = (uint32_t *)s->storage;
+        for (i = 0; i < num; i++) {
+            p[i] = (i % 2 == 0) ? 0x00000000 : 0xFFFFFFFF;
+        }
+    }
+    return true;
+}
+
+static const MemoryRegionOps aspeed_otp_ops = {
+    .read = aspeed_otp_read,
+    .write = aspeed_otp_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+};
+
+static void aspeed_otp_realize(DeviceState *dev, Error **errp)
+{
+    AspeedOTPState *s = ASPEED_OTP(dev);
+
+    if (s->size == 0) {
+        error_setg(errp, "aspeed.otp: 'size' property must be set");
+        return;
+    }
+
+    s->storage = blk_blockalign(s->blk, s->size);
+
+    if (!aspeed_otp_init_storage(s, errp)) {
+        return;
+    }
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &aspeed_otp_ops,
+                          s, "aspeed.otp", s->size);
+    address_space_init(&s->as, &s->mmio, NULL);
+}
+
+static const Property aspeed_otp_properties[] = {
+    DEFINE_PROP_UINT64("size", AspeedOTPState, size, 0),
+    DEFINE_PROP_DRIVE("drive", AspeedOTPState, blk),
+};
+
+static void aspeed_otp_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = aspeed_otp_realize;
+    device_class_set_props(dc, aspeed_otp_properties);
+}
+
+static const TypeInfo aspeed_otp_info = {
+    .name          = TYPE_ASPEED_OTP,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(AspeedOTPState),
+    .class_init    = aspeed_otp_class_init,
+};
+
+static void aspeed_otp_register_types(void)
+{
+    type_register_static(&aspeed_otp_info);
+}
+
+type_init(aspeed_otp_register_types)
diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
index 10f3639db6..b66f23605b 100644
--- a/hw/nvram/meson.build
+++ b/hw/nvram/meson.build
@@ -19,3 +19,7 @@ system_ss.add(when: 'CONFIG_XLNX_BBRAM', if_true: files('xlnx-bbram.c'))
 
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_nvram.c'))
 specific_ss.add(when: 'CONFIG_ACPI', if_true: files('fw_cfg-acpi.c'))
+
+system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
+  'aspeed_otp.c',
+  ))
\ No newline at end of file
-- 
2.43.0


