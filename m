Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6953CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 09:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ullVW-0007r6-3r; Tue, 12 Aug 2025 05:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1ullV6-0007Um-Hb; Tue, 12 Aug 2025 05:41:06 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1ullUy-0000Yh-94; Tue, 12 Aug 2025 05:40:59 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 12 Aug
 2025 17:40:14 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 12 Aug 2025 17:40:14 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v5 05/10] hw/nvram/aspeed_otp: Add OTP programming semantics
 and tracing
Date: Tue, 12 Aug 2025 17:40:02 +0800
Message-ID: <20250812094011.2617526-6-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812094011.2617526-1-kane_chen@aspeedtech.com>
References: <20250812094011.2617526-1-kane_chen@aspeedtech.com>
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

Implement correct OTP programming behavior for Aspeed OTP:
- Support read-modify-write flow with one-way bit programming:
  * prog_bit uses 0s as the "to-be-programmed" mask.
  * Even-indexed words: 0->1, odd-indexed words: 1->0.
  * Reject non-programmable requests and log conflicts.
- Enable unaligned accesses in MemoryRegionOps.
  Since each OTP address maps to a 1DW (4B) or 2DW (8B) block in the
  backing store, upper-layer accesses may be unaligned to block
  boundaries.

This matches the irreversible, word-parity-dependent programming rules
of Aspeed SoCs and exposes changes via QEMU trace events.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 hw/nvram/aspeed_otp.c | 80 ++++++++++++++++++++++++++++++++++++++++++-
 hw/nvram/trace-events |  5 +++
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/hw/nvram/aspeed_otp.c b/hw/nvram/aspeed_otp.c
index abb3731823..66b2bfea28 100644
--- a/hw/nvram/aspeed_otp.c
+++ b/hw/nvram/aspeed_otp.c
@@ -12,6 +12,7 @@
 #include "system/block-backend.h"
 #include "hw/qdev-properties.h"
 #include "hw/nvram/aspeed_otp.h"
+#include "hw/nvram/trace.h"
 
 static uint64_t aspeed_otp_read(void *opaque, hwaddr offset, unsigned size)
 {
@@ -23,12 +24,87 @@ static uint64_t aspeed_otp_read(void *opaque, hwaddr offset, unsigned size)
     return val;
 }
 
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
+        trace_aspeed_otp_prog_conflict(otp_addr, programmed_bits);
+        for (int i = 0; i < 32; ++i) {
+            if (programmed_bits & (1U << i)) {
+                trace_aspeed_otp_prog_bit(i);
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
+    AspeedOTPState *s = opaque;
+    bool is_odd = otp_addr & 1;
+    uint32_t otp_offset = otp_addr << 2;
+
+    memcpy(value, s->storage + otp_offset, sizeof(uint32_t));
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
 static void aspeed_otp_write(void *opaque, hwaddr otp_addr,
                                 uint64_t val, unsigned size)
 {
     AspeedOTPState *s = opaque;
+    uint32_t otp_offset, value;
 
-    memcpy(s->storage + otp_addr, &val, size);
+    if (!program_otpmem_data(s, otp_addr, val, &value)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Failed to program data, value = %x, bit = %lx\n",
+                      __func__, value, val);
+        return;
+    }
+
+    otp_offset = otp_addr << 2;
+    memcpy(s->storage + otp_offset, &value, size);
+
+    if (s->blk) {
+        if (blk_pwrite(s->blk, otp_offset, size, &value, 0) < 0) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Failed to write %x to %x\n",
+                          __func__, value, otp_offset);
+
+            return;
+        }
+    }
+    trace_aspeed_otp_prog(otp_offset, val, value);
 }
 
 static bool aspeed_otp_init_storage(AspeedOTPState *s, Error **errp)
@@ -63,6 +139,8 @@ static const MemoryRegionOps aspeed_otp_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
+    .valid.unaligned = true,
+    .impl.unaligned = true
 };
 
 static void aspeed_otp_realize(DeviceState *dev, Error **errp)
diff --git a/hw/nvram/trace-events b/hw/nvram/trace-events
index 5e33b24d47..7084bf70d3 100644
--- a/hw/nvram/trace-events
+++ b/hw/nvram/trace-events
@@ -1,5 +1,10 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+# aspeed_otp.c
+aspeed_otp_prog(uint32_t addr, uint32_t prog_value, uint32_t value) "OTP Memory program: addr 0x%" PRIx32 " prog_value 0x%" PRIx32 " value 0x%" PRIx32
+aspeed_otp_prog_conflict(uint32_t addr, uint32_t bits) "Conflict at addr=0x%x, bits=0x%08x"
+aspeed_otp_prog_bit(int bit) "Programmed bit %d"
+
 # ds1225y.c
 nvram_read(uint32_t addr, uint32_t ret) "read addr %d: 0x%02x"
 nvram_write(uint32_t addr, uint32_t old, uint32_t val) "write addr %d: 0x%02x -> 0x%02x"
-- 
2.43.0


