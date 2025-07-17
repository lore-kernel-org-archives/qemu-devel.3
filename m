Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D38C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 03:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFZv-0002nD-HG; Wed, 16 Jul 2025 23:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFVV-0003lr-1O; Wed, 16 Jul 2025 23:42:11 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFVS-0000g2-0W; Wed, 16 Jul 2025 23:42:03 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 17 Jul
 2025 11:41:00 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 17 Jul 2025 11:41:00 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 15/21] hw/misc/aspeed_scu: Add SCU support for SSP SDRAM
 remap
Date: Thu, 17 Jul 2025 11:40:43 +0800
Message-ID: <20250717034054.1903991-16-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
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

This commit adds SCU register support for SSP SDRAM remap control and runtime
activation. It introduces logic for the PSP to dynamically configure the mapping
of its own DRAM windows into SSP-visible SDRAM space, enabling shared memory
communication via memory region aliases.

Two MemoryRegion aliases are attached to the SCU via QOM property links:
  - ssp-sdram-remap1: maps PSP DRAM at 0x400000000 (size: 32MB) to SSP SDRAM
    offset 0x2000000
  - ssp-sdram-remap2: maps PSP DRAM at 0x42c000000 (size: 32MB) to SSP SDRAM
    offset 0x0

The SCU registers AST2700_SCU_SSP_CTRL_1/2 and
AST2700_SCU_SSP_REMAP_ADDR_{1,2} / REMAP_SIZE_{1,2} allow runtime reconfiguration
of alias offset, base, and size.

Bumps the SCU VMState version to 3.

|------------------------------------------|         |----------------------------|
|               PSP DRAM                   |         |        SSP SDRAM           |
|------------------------------------------|         |----------------------------|
| 0x4_0000_0000 (SCU_124 << 4)             |     --> | 0x0000_0000                |
|   remap1 base                            |---| |   |  - SCU_150: target addr    |
|   size: 32MB    (SCU_14C)                |   | |   |    remap2                  |
|------------------------------------------|   | |   |----------------------------|
|                                          |   | |   |                            |
| 0x4_2C00_0000 (SCU_128 << 4)             |-----|   | 0x0200_0000                |
|   remap2 base                            |   |     |  - SCU_148: target addr    |
|   size: 32MB    (SCU_154)                |   |---> |    remap1                  |
|------------------------------------------|         |----------------------------|

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/misc/aspeed_scu.h |  3 ++
 hw/arm/aspeed_ast27x0.c      |  6 ++++
 hw/misc/aspeed_scu.c         | 53 ++++++++++++++++++++++++++++++++++--
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index 684b48b722..408f821379 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -39,6 +39,9 @@ struct AspeedSCUState {
     uint32_t hw_strap1;
     uint32_t hw_strap2;
     uint32_t hw_prot_key;
+
+    MemoryRegion *ssp_sdram_remap1;
+    MemoryRegion *ssp_sdram_remap2;
 };
 
 #define AST2400_A0_SILICON_REV   0x02000303U
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 0f988eaa4d..587c042c30 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -833,6 +833,12 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         memory_region_init_alias(&a->tsp.sdram_remap_alias, OBJECT(a),
                                  "tsp.sdram.remap", s->memory,
                                  0x42e000000, 32 * MiB);
+        object_property_set_link(OBJECT(&s->scu), "ssp-sdram-remap1",
+                                 OBJECT(&a->ssp.sdram_remap1_alias),
+                                 &error_abort);
+        object_property_set_link(OBJECT(&s->scu), "ssp-sdram-remap2",
+                                 OBJECT(&a->ssp.sdram_remap2_alias),
+                                 &error_abort);
     }
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index a0ab5eed8f..df379cafbe 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -143,6 +143,14 @@
 #define AST2700_HW_STRAP1_SEC2    TO_REG(0x28)
 #define AST2700_HW_STRAP1_SEC3    TO_REG(0x2C)
 
+/* SSP */
+#define AST2700_SCU_SSP_CTRL_1          TO_REG(0x124)
+#define AST2700_SCU_SSP_CTRL_2          TO_REG(0x128)
+#define AST2700_SCU_SSP_REMAP_ADDR_1    TO_REG(0x148)
+#define AST2700_SCU_SSP_REMAP_SIZE_1    TO_REG(0x14c)
+#define AST2700_SCU_SSP_REMAP_ADDR_2    TO_REG(0x150)
+#define AST2700_SCU_SSP_REMAP_SIZE_2    TO_REG(0x154)
+
 #define AST2700_SCU_CLK_SEL_1       TO_REG(0x280)
 #define AST2700_SCU_HPLL_PARAM      TO_REG(0x300)
 #define AST2700_SCU_HPLL_EXT_PARAM  TO_REG(0x304)
@@ -605,8 +613,8 @@ static void aspeed_scu_realize(DeviceState *dev, Error **errp)
 
 static const VMStateDescription vmstate_aspeed_scu = {
     .name = "aspeed.scu",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedSCUState, ASPEED_AST2600_SCU_NR_REGS),
         VMSTATE_END_OF_LIST()
@@ -618,6 +626,10 @@ static const Property aspeed_scu_properties[] = {
     DEFINE_PROP_UINT32("hw-strap1", AspeedSCUState, hw_strap1, 0),
     DEFINE_PROP_UINT32("hw-strap2", AspeedSCUState, hw_strap2, 0),
     DEFINE_PROP_UINT32("hw-prot-key", AspeedSCUState, hw_prot_key, 0),
+    DEFINE_PROP_LINK("ssp-sdram-remap1", AspeedSCUState, ssp_sdram_remap1,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
+    DEFINE_PROP_LINK("ssp-sdram-remap2", AspeedSCUState, ssp_sdram_remap2,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
 static void aspeed_scu_class_init(ObjectClass *klass, const void *data)
@@ -902,6 +914,7 @@ static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,
     int reg = TO_REG(offset);
     /* Truncate here so bitwise operations below behave as expected */
     uint32_t data = data64;
+    MemoryRegion *mr;
 
     if (reg >= ASPEED_AST2700_SCU_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -913,6 +926,36 @@ static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,
     trace_aspeed_ast2700_scu_write(offset, size, data);
 
     switch (reg) {
+    case AST2700_SCU_SSP_CTRL_1:
+    case AST2700_SCU_SSP_CTRL_2:
+        mr = (reg == AST2700_SCU_SSP_CTRL_1) ?
+            s->ssp_sdram_remap1 : s->ssp_sdram_remap2;
+        if (mr == NULL) {
+            return;
+        }
+        data &= 0x7fffffff;
+        memory_region_set_alias_offset(mr, (uint64_t) data << 4);
+        break;
+    case AST2700_SCU_SSP_REMAP_ADDR_1:
+    case AST2700_SCU_SSP_REMAP_ADDR_2:
+        mr = (reg == AST2700_SCU_SSP_REMAP_ADDR_1) ?
+            s->ssp_sdram_remap1 : s->ssp_sdram_remap2;
+        if (mr == NULL) {
+            return;
+        }
+        data &= 0x3fffffff;
+        memory_region_set_address(mr, data);
+        break;
+    case AST2700_SCU_SSP_REMAP_SIZE_1:
+    case AST2700_SCU_SSP_REMAP_SIZE_2:
+        mr = (reg == AST2700_SCU_SSP_REMAP_SIZE_1) ?
+            s->ssp_sdram_remap1 : s->ssp_sdram_remap2;
+        if (mr == NULL) {
+            return;
+        }
+        data &= 0x3fffffff;
+        memory_region_set_size(mr, data);
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Unhandled write at offset 0x%" HWADDR_PRIx "\n",
@@ -940,6 +983,12 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST2700_SCU_NR_REGS] = {
     [AST2700_HW_STRAP1_SEC1]        = 0x000000FF,
     [AST2700_HW_STRAP1_SEC2]        = 0x00000000,
     [AST2700_HW_STRAP1_SEC3]        = 0x1000408F,
+    [AST2700_SCU_SSP_CTRL_1]        = 0x40000000,
+    [AST2700_SCU_SSP_CTRL_2]        = 0x42C00000,
+    [AST2700_SCU_SSP_REMAP_ADDR_1]  = 0x02000000,
+    [AST2700_SCU_SSP_REMAP_SIZE_1]  = 0x02000000,
+    [AST2700_SCU_SSP_REMAP_ADDR_2]  = 0x00000000,
+    [AST2700_SCU_SSP_REMAP_SIZE_2]  = 0x02000000,
     [AST2700_SCU_HPLL_PARAM]        = 0x0000009f,
     [AST2700_SCU_HPLL_EXT_PARAM]    = 0x8000004f,
     [AST2700_SCU_DPLL_PARAM]        = 0x0080009f,
-- 
2.43.0


