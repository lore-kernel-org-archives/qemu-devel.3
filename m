Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2B1C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 07:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta8KC-00071d-Gq; Tue, 21 Jan 2025 02:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ta8K9-0006yb-H7; Tue, 21 Jan 2025 02:05:21 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ta8K7-0001eA-Ku; Tue, 21 Jan 2025 02:05:21 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 21 Jan
 2025 15:04:28 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 21 Jan 2025 15:04:28 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 10/18] hw/intc/aspeed: Add Support for AST2700 INTC1
 Controller
Date: Tue, 21 Jan 2025 15:04:16 +0800
Message-ID: <20250121070424.2465942-11-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce a new ast2700 INTC1 class to support AST2700 INTC1.
Added new register definitions for INTC1, including enable and status registers
for IRQs GICINT192 through GICINT197.
Created a dedicated IRQ array for INTC1, supporting six input pins and six
output pins, aligning with the newly defined registers.
Implemented "aspeed_2700_intc1_read" and "aspeed_2700_intc1_write" to handle
INTC1-specific register access.

                 +--------------------------+
                 |         INTC1            |
                 |                          |
orgates[0]+----> |inpin[0]+------->outpin[0]|
orgates[1]|----> |inpin[1]|------->outpin[1]|
orgates[2]|----> |inpin[2]|------->outpin[2]|
orgates[3]|----> |inpin[3]|------->outpin[3]|
orgates[4]|----> |inpin[4]|------->outpin[4]|
orgates[5]+----> |inpin[5]+------->outpin[5]|
                 |                          |
                 +--------------------------+
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/intc/aspeed_intc.c         | 119 ++++++++++++++++++++++++++++++++++
 include/hw/intc/aspeed_intc.h |   1 +
 2 files changed, 120 insertions(+)

diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index c3b51cec6d..1db5e5a94d 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -36,6 +36,20 @@ REG32(INTC0_GICINT136_STATUS,     0x1804)
 REG32(INTC0_GICINT192_201_EN,         0x1B00)
 REG32(INTC0_GICINT192_201_STATUS,     0x1B04)
 
+/* AST2700 INTC1 Registers */
+REG32(INTC1_GICINT192_EN,         0x100)
+REG32(INTC1_GICINT192_STATUS,     0x104)
+REG32(INTC1_GICINT193_EN,         0x110)
+REG32(INTC1_GICINT193_STATUS,     0x114)
+REG32(INTC1_GICINT194_EN,         0x120)
+REG32(INTC1_GICINT194_STATUS,     0x124)
+REG32(INTC1_GICINT195_EN,         0x130)
+REG32(INTC1_GICINT195_STATUS,     0x134)
+REG32(INTC1_GICINT196_EN,         0x140)
+REG32(INTC1_GICINT196_STATUS,     0x144)
+REG32(INTC1_GICINT197_EN,         0x150)
+REG32(INTC1_GICINT197_STATUS,     0x154)
+
 static AspeedINTCIRQ aspeed_2700_intc0_irqs[ASPEED_INTC_MAX_INPINS] = {
     {0, 0, 10, R_INTC0_GICINT192_201_EN, R_INTC0_GICINT192_201_STATUS},
     {1, 10, 1, R_INTC0_GICINT128_EN, R_INTC0_GICINT128_STATUS},
@@ -49,6 +63,15 @@ static AspeedINTCIRQ aspeed_2700_intc0_irqs[ASPEED_INTC_MAX_INPINS] = {
     {9, 18, 1, R_INTC0_GICINT136_EN, R_INTC0_GICINT136_STATUS},
 };
 
+static AspeedINTCIRQ aspeed_2700_intc1_irqs[ASPEED_INTC_MAX_INPINS] = {
+    {0, 0, 1, R_INTC1_GICINT192_EN, R_INTC1_GICINT192_STATUS},
+    {1, 1, 1, R_INTC1_GICINT193_EN, R_INTC1_GICINT193_STATUS},
+    {2, 2, 1, R_INTC1_GICINT194_EN, R_INTC1_GICINT194_STATUS},
+    {3, 3, 1, R_INTC1_GICINT195_EN, R_INTC1_GICINT195_STATUS},
+    {4, 4, 1, R_INTC1_GICINT196_EN, R_INTC1_GICINT196_STATUS},
+    {5, 5, 1, R_INTC1_GICINT197_EN, R_INTC1_GICINT197_STATUS},
+};
+
 static const AspeedINTCIRQ *aspeed_intc_get_irq(AspeedINTCClass *aic,
                                                 uint32_t addr)
 {
@@ -453,6 +476,68 @@ static void aspeed_2700_intc0_write(void *opaque, hwaddr offset, uint64_t data,
     return;
 }
 
+static uint64_t aspeed_2700_intc1_read(void *opaque, hwaddr offset,
+                                                 unsigned int size)
+{
+    AspeedINTCState *s = ASPEED_INTC(opaque);
+    AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
+    uint32_t addr = offset >> 2;
+    uint32_t value = 0;
+
+    if (offset >= aic->reg_size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return 0;
+    }
+
+    value = s->regs[addr];
+    trace_aspeed_intc_read(aic->id, offset, size, value);
+
+    return value;
+}
+
+static void aspeed_2700_intc1_write(void *opaque, hwaddr offset, uint64_t data,
+                                      unsigned size)
+{
+    AspeedINTCState *s = ASPEED_INTC(opaque);
+    AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
+    uint32_t addr = offset >> 2;
+
+    if (offset >= aic->reg_size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return;
+    }
+
+    trace_aspeed_intc_write(aic->id, offset, size, data);
+
+    switch (addr) {
+    case R_INTC1_GICINT192_EN:
+    case R_INTC1_GICINT193_EN:
+    case R_INTC1_GICINT194_EN:
+    case R_INTC1_GICINT195_EN:
+    case R_INTC1_GICINT196_EN:
+    case R_INTC1_GICINT197_EN:
+        aspeed_2700_intc_enable_handler(s, addr, data);
+        break;
+    case R_INTC1_GICINT192_STATUS:
+    case R_INTC1_GICINT193_STATUS:
+    case R_INTC1_GICINT194_STATUS:
+    case R_INTC1_GICINT195_STATUS:
+    case R_INTC1_GICINT196_STATUS:
+    case R_INTC1_GICINT197_STATUS:
+        aspeed_2700_intc_status_handler(s, addr, data);
+        break;
+    default:
+        s->regs[addr] = data;
+        break;
+    }
+
+    return;
+}
+
 static const MemoryRegionOps aspeed_intc_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
@@ -572,10 +657,44 @@ static const TypeInfo aspeed_2700_intc0_info = {
     .class_init = aspeed_2700_intc0_class_init,
 };
 
+static const MemoryRegionOps aspeed_2700_intc1_ops = {
+    .read = aspeed_2700_intc1_read,
+    .write = aspeed_2700_intc1_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    }
+};
+
+static void aspeed_2700_intc1_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedINTCClass *aic = ASPEED_INTC_CLASS(klass);
+
+    dc->desc = "ASPEED 2700 INTC 1 Controller";
+    aic->num_lines = 32;
+    aic->num_inpins = 6;
+    aic->num_outpins = 6;
+    aic->mem_size = 0x400;
+    aic->reg_size = 0x3d8;
+    aic->reg_ops = &aspeed_2700_intc1_ops;
+    aic->irq_table = aspeed_2700_intc1_irqs;
+    aic->irq_table_count = ARRAY_SIZE(aspeed_2700_intc1_irqs);
+    aic->id = 1;
+}
+
+static const TypeInfo aspeed_2700_intc1_info = {
+    .name = TYPE_ASPEED_2700_INTC1,
+    .parent = TYPE_ASPEED_INTC,
+    .class_init = aspeed_2700_intc1_class_init,
+};
+
 static void aspeed_intc_register_types(void)
 {
     type_register_static(&aspeed_intc_info);
     type_register_static(&aspeed_2700_intc0_info);
+    type_register_static(&aspeed_2700_intc1_info);
 }
 
 type_init(aspeed_intc_register_types);
diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index c2e3906d99..7f500927a1 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -14,6 +14,7 @@
 
 #define TYPE_ASPEED_INTC "aspeed.intc"
 #define TYPE_ASPEED_2700_INTC0 TYPE_ASPEED_INTC "0" "-ast2700"
+#define TYPE_ASPEED_2700_INTC1 TYPE_ASPEED_INTC "1" "-ast2700"
 OBJECT_DECLARE_TYPE(AspeedINTCState, AspeedINTCClass, ASPEED_INTC)
 
 #define ASPEED_INTC_NR_REGS (0x2000 >> 2)
-- 
2.34.1


