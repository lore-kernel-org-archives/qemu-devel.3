Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38FCC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPBC-0005QK-As; Mon, 12 May 2025 05:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uEPBA-0005Q1-KZ; Mon, 12 May 2025 05:10:32 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uEPB7-00056F-UO; Mon, 12 May 2025 05:10:31 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 12 May
 2025 17:10:15 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 12 May 2025 17:10:15 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v4 1/3] hw/misc/aspeed_otp: Add ASPEED OTP memory device model
Date: Mon, 12 May 2025 17:10:11 +0800
Message-ID: <20250512091014.3454083-2-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250512091014.3454083-1-kane_chen@aspeedtech.com>
References: <20250512091014.3454083-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Introduce a QEMU model for ASPEED One-Time Programmable (OTP) memory.

This device provides:
- Bit-level irreversible programming (0→1 for even, 1→0 for odd)
- Read, program, and default-value initialization interfaces
- File-backed OTP content via machine parameter
- Trace support for bit conflict debugging
- Error propagation via QEMU's Error** interface

The OTP backend is designed to integrate with SoCs requiring secure fuse storage
or secure boot features.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 hw/misc/aspeed_otpmem.c         | 198 ++++++++++++++++++++++++++++++++
 hw/misc/meson.build             |   1 +
 hw/misc/trace-events            |   5 +
 include/hw/misc/aspeed_otpmem.h |  39 +++++++
 4 files changed, 243 insertions(+)
 create mode 100644 hw/misc/aspeed_otpmem.c
 create mode 100644 include/hw/misc/aspeed_otpmem.h

diff --git a/hw/misc/aspeed_otpmem.c b/hw/misc/aspeed_otpmem.c
new file mode 100644
index 0000000000..4c1dee8782
--- /dev/null
+++ b/hw/misc/aspeed_otpmem.c
@@ -0,0 +1,198 @@
+/*
+ *  ASPEED OTP (One-Time Programmable) memory
+ *
+ *  Copyright (C) 2025 Aspeed
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "trace.h"
+#include "hw/misc/aspeed_otpmem.h"
+
+void aspeed_otpmem_set_backend(AspeedOTPMemState *s, const char *path)
+{
+    g_free(s->otpmem_img_path);
+    s->otpmem_img_path = g_strdup(path);
+}
+
+static void aspeed_otpmem_sync_region(AspeedOTPMemState *s,
+                                      hwaddr offset, hwaddr size)
+{
+    memory_region_msync(&s->iomem, offset, size);
+}
+
+static uint32_t aspeed_otpmem_read(AspeedOtpmemState *s,
+                                   uint32_t addr, Error **errp)
+{
+    uint32_t val = 0;
+    MemTxResult ret;
+
+    ret = address_space_read(&s->as, addr, MEMTXATTRS_UNSPECIFIED,
+                             (uint8_t *)&val, sizeof(val));
+    if (ret != MEMTX_OK) {
+        error_setg(errp, "Failed to read data from 0x%x", addr);
+        return OTPMEM_ERR_MAGIC;
+    }
+    return val;
+}
+
+static bool valid_program_data(uint32_t otp_addr,
+                                 uint32_t value, uint32_t prog_bit)
+{
+    uint32_t programmed_bits, has_programmable_bits;
+    bool is_odd = otp_addr & 1;
+
+    /*
+     * prog_bit uses 0s to indicate target bits to program:
+     *   - if OTP word is even-indexed, programmed bits flip 0->1
+     *   - if odd, bits flip 1->0
+     * Bit programming is one-way only and irreversible.
+     */
+    if (is_odd) {
+        programmed_bits = ~value & prog_bit;
+    } else {
+        programmed_bits = value & (~prog_bit);
+    }
+
+    /* If any bit can be programmed, accept the request */
+    has_programmable_bits = value ^ (~prog_bit);
+
+    if (programmed_bits) {
+        trace_aspeed_otpmem_prog_conflict(otp_addr, programmed_bits);
+        for (int i = 0; i < 32; ++i) {
+            if (programmed_bits & (1U << i)) {
+                trace_aspeed_otpmem_prog_bit(i);
+            }
+        }
+    }
+
+    return has_programmable_bits != 0;
+}
+
+static bool program_otpmem_data(void *opaque, uint32_t otp_addr,
+                             uint32_t prog_bit, uint32_t *value)
+{
+    AspeedOTPMemState *s = ASPEED_OTPMEM(opaque);
+    bool is_odd = otp_addr & 1;
+    uint32_t otp_offset = otp_addr << 2;
+    MemTxResult ret;
+
+    ret = address_space_read(&s->as, otp_offset, MEMTXATTRS_UNSPECIFIED,
+                             value, sizeof(uint32_t));
+    if (ret != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Failed to read data 0x%x\n",
+                      otp_offset);
+        return false;
+    }
+
+    if (!valid_program_data(otp_addr, *value, prog_bit)) {
+        return false;
+    }
+
+    if (is_odd) {
+        *value &= ~prog_bit;
+    } else {
+        *value |= ~prog_bit;
+    }
+
+    return true;
+}
+
+static void aspeed_otpmem_prog(AspeedOtpmemState *s, uint32_t otp_addr,
+                               uint32_t val, Error **errp)
+{
+    uint32_t otp_offset, value;
+    MemTxResult ret;
+
+    if (!program_otpmem_data(s, otp_addr, val, &value)) {
+        error_setg(errp, "Failed to program data");
+        return;
+    }
+
+    otp_offset = otp_addr << 2;
+    ret = address_space_write(&s->as, otp_offset, MEMTXATTRS_UNSPECIFIED,
+                              (uint8_t *)&value, sizeof(value));
+    if (ret != MEMTX_OK) {
+        error_setg(errp, "Failed to write %x to OTP [%x]", val, otp_addr);
+        return;
+    }
+    trace_aspeed_otpmem_prog(otp_offset, value, val);
+    aspeed_otpmem_sync_region(s, otp_offset, sizeof(value));
+}
+
+static void aspeed_otpmem_set_default(AspeedOtpmemState *s, uint32_t otp_offset,
+                                      uint32_t val, Error **errp)
+{
+    MemTxResult ret;
+
+    ret = address_space_write(&s->as, otp_offset, MEMTXATTRS_UNSPECIFIED,
+                              (uint8_t *)&val, sizeof(val));
+    if (ret != MEMTX_OK) {
+        error_setg(errp, "Failed to set value %x to OTP [%x]", val, otp_offset);
+        return;
+    }
+    aspeed_otpmem_sync_region(s, otp_offset, sizeof(val));
+}
+
+static const AspeedOTPMemOps aspeed_otpmem_default_ops = {
+    .read = aspeed_otpmem_read,
+    .prog = aspeed_otpmem_prog,
+    .set_default = aspeed_otpmem_set_default,
+};
+
+const AspeedOTPMemOps *aspeed_otpmem_get_ops(AspeedOTPMemState *s)
+{
+    return s->ops;
+}
+
+static void aspeed_otpmem_realize(DeviceState *dev, Error **errp)
+{
+    AspeedOTPMemState *s = ASPEED_OTPMEM(dev);
+    struct stat st;
+
+    s->size = OTPMEM_SIZE;
+    s->ops = &aspeed_otpmem_default_ops;
+
+    if (s->otpmem_img_path && strlen(s->otpmem_img_path)) {
+        if (stat(s->otpmem_img_path, &st) < 0) {
+            error_setg(errp, "Failed to open %s",
+                       s->otpmem_img_path);
+            return;
+        }
+        if (st.st_size != OTPMEM_SIZE) {
+            error_setg(errp, "Invalid OTP size %ld",
+                       st.st_size);
+            return;
+        }
+        memory_region_init_ram_from_file(&s->iomem, OBJECT(dev),
+                "aspeed.otpmem.backend", s->size, s->size,
+                RAM_SHARED, s->otpmem_img_path, 0, errp);
+        address_space_init(&s->as, &s->iomem, NULL);
+    }
+}
+
+static void aspeed_otpmem_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = aspeed_otpmem_realize;
+    dc->user_creatable = false;
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
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 4383808d7a..e9df349f6d 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -90,6 +90,11 @@ slavio_sysctrl_mem_readl(uint32_t ret) "Read system control 0x%08x"
 slavio_led_mem_writew(uint32_t val) "Write diagnostic LED 0x%04x"
 slavio_led_mem_readw(uint32_t ret) "Read diagnostic LED 0x%04x"
 
+# aspeed_otpmem.c
+aspeed_otpmem_prog(uint32_t addr, uint32_t prog_value, uint32_t value) "OTP Memory program: addr 0x%" PRIx32 " prog_value 0x%" PRIx32 " value 0x%" PRIx32
+aspeed_otpmem_prog_conflict(uint32_t addr, uint32_t bits) "Conflict at addr=0x%x, bits=0x%08x"
+aspeed_otpmem_prog_bit(int bit) "Programmed bit %d"
+
 # aspeed_scu.c
 aspeed_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
 aspeed_scu_read(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
diff --git a/include/hw/misc/aspeed_otpmem.h b/include/hw/misc/aspeed_otpmem.h
new file mode 100644
index 0000000000..f50f4cebf1
--- /dev/null
+++ b/include/hw/misc/aspeed_otpmem.h
@@ -0,0 +1,39 @@
+/*
+ *  ASPEED OTP (One-Time Programmable) memory
+ *
+ *  Copyright (C) 2025 Aspeed
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#ifndef ASPEED_OTPMMEM_H
+#define ASPEED_OTPMMEM_H
+
+#include "system/memory.h"
+
+#define OTPMEM_SIZE 0x4000
+#define OTPMEM_ERR_MAGIC 0x45727200
+#define TYPE_ASPEED_OTPMEM "aspeed.otpmem"
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedOTPMemState, ASPEED_OTPMEM)
+
+typedef struct AspeedOTPMemOps {
+    uint32_t (*read)(AspeedOTPMemState *s, uint32_t addr, Error **errp);
+    void (*prog)(AspeedOTPMemState *s, uint32_t addr, uint32_t val, Error **errp);
+    void (*set_default)(AspeedOTPMemState *s, uint32_t addr, uint32_t val, Error **errp);
+} AspeedOTPMemOps;
+
+typedef struct AspeedOTPMemState {
+    DeviceState parent_obj;
+
+    MemoryRegion iomem;
+    AddressSpace as;
+    size_t size;
+
+    const AspeedOTPMemOps *ops;
+    char *otpmem_img_path;
+} AspeedOtpmemState;
+
+const AspeedOTPMemOps *aspeed_otpmem_get_ops(AspeedOTPMemState *s);
+void aspeed_otpmem_set_backend(AspeedOTPMemState *s, const char *path);
+#endif /* ASPEED_OTPMMEM_H */
-- 
2.43.0


