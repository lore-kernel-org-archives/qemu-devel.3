Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9951FC71136
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 06:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS8xp-0002Ue-QB; Thu, 19 Jun 2025 02:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uS8xn-0002Tv-QI; Thu, 19 Jun 2025 02:41:31 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uS8xl-0001s1-Q5; Thu, 19 Jun 2025 02:41:31 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 19 Jun
 2025 14:41:16 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 19 Jun 2025 14:41:16 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [RFC v5 1/4] hw/misc/aspeed_otp: Add ASPEED OTP memory device model
Date: Thu, 19 Jun 2025 14:41:10 +0800
Message-ID: <20250619064115.4182202-2-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619064115.4182202-1-kane_chen@aspeedtech.com>
References: <20250619064115.4182202-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Introduce a QEMU device model for ASPEED's One-Time Programmable (OTP)
memory.

This model simulates a word-addressable OTP region used for secure
fuse storage or boot-time configuration. The OTP memory can operate
with either:

- a file-backed backend via the 'drive' property, which allows
  persistent emulation of burned fuse states using -blockdev, or
- an internal fallback buffer

The OTP model provides a memory-like interface through a dedicated
AddressSpace, allowing other device models (e.g., SBC) to issue
transactions as if accessing a memory-mapped region. Actual data is
maintained in a file-backed or internal buffer.

Logging is included to assist with debugging and to indicate fallback
behavior when no backend is provided.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 hw/misc/aspeed_otpmem.c         | 117 ++++++++++++++++++++++++++++++++
 hw/misc/meson.build             |   1 +
 include/hw/misc/aspeed_otpmem.h |  35 ++++++++++
 3 files changed, 153 insertions(+)
 create mode 100644 hw/misc/aspeed_otpmem.c
 create mode 100644 include/hw/misc/aspeed_otpmem.h

diff --git a/hw/misc/aspeed_otpmem.c b/hw/misc/aspeed_otpmem.c
new file mode 100644
index 0000000000..c5a67621c9
--- /dev/null
+++ b/hw/misc/aspeed_otpmem.c
@@ -0,0 +1,117 @@
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
+#include "trace.h"
+#include "system/block-backend-global-state.h"
+#include "system/block-backend-io.h"
+#include "hw/misc/aspeed_otpmem.h"
+
+static uint64_t aspeed_otpmem_read(void *opaque, hwaddr offset, unsigned size)
+{
+    AspeedOTPMemState *s = opaque;
+    uint64_t val = 0;
+
+    memcpy(&val, s->storage + offset, size);
+
+    return val;
+}
+
+static void aspeed_otpmem_write(void *opaque, hwaddr offset,
+                                uint64_t val, unsigned size)
+{
+    int ret;
+    AspeedOTPMemState *s = opaque;
+
+    memcpy(s->storage + offset, &val, size);
+    if (s->blk) {
+        ret = blk_pwrite(s->blk, offset, size, &val, BDRV_REQ_FUA);
+        if (ret < 0) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "blk_pwrite failed offset 0x%" HWADDR_PRIx
+                          ", ret = %d\n",
+                          offset, ret);
+        }
+    }
+}
+
+static const MemoryRegionOps aspeed_otpmem_ops = {
+    .read = aspeed_otpmem_read,
+    .write = aspeed_otpmem_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+};
+
+static void aspeed_otpmem_realize(DeviceState *dev, Error **errp)
+{
+    AspeedOTPMemState *s = ASPEED_OTPMEM(dev);
+    const size_t size = OTPMEM_SIZE;
+    int i, num;
+    uint32_t *p;
+
+    s->storage = blk_blockalign(s->blk, size);
+    if (!s->storage) {
+        error_setg(errp, "Failed to allocate OTP memory storage buffer");
+        return;
+    }
+
+    if (s->blk) {
+        uint64_t perm = BLK_PERM_CONSISTENT_READ |
+                        (blk_supports_write_perm(s->blk) ? BLK_PERM_WRITE : 0);
+        if (blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp) < 0) {
+            error_setg(errp, "Failed to set permission");
+            return;
+        }
+
+        if (blk_pread(s->blk, 0, s->size, s->storage, 0) < 0) {
+            error_setg(errp, "Failed to read the initial flash content");
+            return;
+        }
+    } else {
+        num = size / sizeof(uint32_t);
+        p = (uint32_t *)s->storage;
+        for (i = 0; i < num; i++) {
+            p[i] = (i % 2 == 0) ? 0x00000000 : 0xFFFFFFFF;
+        }
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "OTP image is not presented, use local buffer\n");
+    }
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &aspeed_otpmem_ops,
+                          s, "aspeed.otpmem", size);
+    address_space_init(&s->as, &s->mmio, NULL);
+}
+
+static const Property aspeed_otpmem_properties[] = {
+    DEFINE_PROP_UINT64("size", AspeedOTPMemState, size, OTPMEM_SIZE),
+    DEFINE_PROP_DRIVE("drive", AspeedOTPMemState, blk),
+};
+
+static void aspeed_otpmem_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = aspeed_otpmem_realize;
+    device_class_set_props(dc, aspeed_otpmem_properties);
+}
+
+static const TypeInfo aspeed_otpmem_info = {
+    .name          = TYPE_ASPEED_OTPMEM,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(AspeedOTPMemState),
+    .class_init    = aspeed_otpmem_class_init,
+};
+
+static void aspeed_otpmem_register_types(void)
+{
+    type_register_static(&aspeed_otpmem_info);
+}
+
+type_init(aspeed_otpmem_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 6d47de482c..ed1eaaa2ad 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -136,6 +136,7 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_sbc.c',
   'aspeed_sdmc.c',
   'aspeed_xdma.c',
+  'aspeed_otpmem.c',
   'aspeed_peci.c',
   'aspeed_sli.c'))
 
diff --git a/include/hw/misc/aspeed_otpmem.h b/include/hw/misc/aspeed_otpmem.h
new file mode 100644
index 0000000000..7f469d9fd7
--- /dev/null
+++ b/include/hw/misc/aspeed_otpmem.h
@@ -0,0 +1,35 @@
+/*
+ *  ASPEED OTP (One-Time Programmable) memory
+ *
+ *  Copyright (C) 2025 Aspeed
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ASPEED_OTPMMEM_H
+#define ASPEED_OTPMMEM_H
+
+#include "system/memory.h"
+#include "hw/block/block.h"
+#include "system/memory.h"
+#include "system/address-spaces.h"
+
+#define OTPMEM_SIZE 0x4000
+#define TYPE_ASPEED_OTPMEM "aspeed.otpmem"
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedOTPMemState, ASPEED_OTPMEM)
+
+typedef struct AspeedOTPMemState {
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
+} AspeedOTPMemState;
+
+#endif /* ASPEED_OTPMMEM_H */
-- 
2.43.0


