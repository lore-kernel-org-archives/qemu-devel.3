Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F210FC88E41
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfPV-0004as-G9; Tue, 27 Jan 2026 04:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkfOu-00042U-E1; Tue, 27 Jan 2026 04:30:30 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkfOr-0004dA-Cm; Tue, 27 Jan 2026 04:30:18 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 27 Jan
 2026 17:29:45 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 27 Jan 2026 17:29:45 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v2 04/11] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM remap
Date: Tue, 27 Jan 2026 17:29:33 +0800
Message-ID: <20260127092943.3731635-5-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127092943.3731635-1-jamin_lin@aspeedtech.com>
References: <20260127092943.3731635-1-jamin_lin@aspeedtech.com>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This commit adds two MemoryRegion aliases to support PSP access to
SSP SDRAM through shared memory remapping, as defined by the default SCU
configuration.

The SSP exposes two DRAM aliases:
  - remap1 maps PSP DRAM at 0x400000000 (32MB) to SSP SDRAM offset 0x2000000
  - remap2 maps PSP DRAM at 0x42c000000 (32MB) to SSP SDRAM offset 0x0

These regions correspond to the default SCU register values, which control
the mapping between PSP and coprocessor memory windows.

Set SSP CPUID 4 and bumps the SCU VMState version to 3.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/misc/aspeed_scu.h |  5 +++++
 hw/arm/aspeed_ast27x0-fc.c   |  2 ++
 hw/arm/aspeed_ast27x0-ssp.c  |  6 ++++++
 hw/arm/aspeed_ast27x0.c      |  4 ++++
 hw/misc/aspeed_scu.c         | 38 ++++++++++++++++++++++++++++++++++--
 5 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index 9e28bd4d2e..6f7f7d2766 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -39,6 +39,10 @@ struct AspeedSCUState {
     uint32_t hw_strap1;
     uint32_t hw_strap2;
     uint32_t hw_prot_key;
+
+    MemoryRegion dram_remap_alias[3];
+    MemoryRegion *dram;
+    int ssp_cpuid;
 };
 
 #define AST2400_A0_SILICON_REV   0x02000303U
@@ -73,6 +77,7 @@ struct AspeedSCUClass {
     uint32_t nr_regs;
     bool clkin_25Mhz;
     const MemoryRegionOps *ops;
+    void (*dram_remap)(AspeedSCUState *s);
 };
 
 #define ASPEED_SCU_PROT_KEY      0x1688A8A8
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 0502a137f3..b788e6ca2a 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -101,6 +101,8 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
                             sc->uarts_num, serial_hd(1));
     aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART7, sc->uarts_base,
                             sc->uarts_num, serial_hd(2));
+    object_property_set_int(OBJECT(&s->ca35), "ssp-cpuid", 4,
+                            &error_abort);
     if (!qdev_realize(DEVICE(&s->ca35), NULL, errp)) {
         return false;
     }
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index cba59ae11a..cf1339e2c7 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -198,6 +198,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],
                                 &s->scu_alias);
 
+    /* SDRAM remap alias used by PSP to access SSP SDRAM */
+    memory_region_add_subregion(&s->sdram, 0, &s->scu->dram_remap_alias[1]);
+    memory_region_add_subregion(&s->sdram,
+            memory_region_size(&s->scu->dram_remap_alias[1]),
+            &s->scu->dram_remap_alias[0]);
+
     /* INTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
         return;
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 74a004adca..ae8b22fc1c 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -389,6 +389,8 @@ static void aspeed_soc_ast2700_init(Object *obj)
                               "hw-strap1");
     object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
                               "hw-prot-key");
+    object_property_add_alias(obj, "ssp-cpuid", OBJECT(&s->scu),
+                              "ssp-cpuid");
 
     object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUIO);
     qdev_prop_set_uint32(DEVICE(&s->scuio), "silicon-rev",
@@ -740,6 +742,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
                                 sc->memmap[ASPEED_DEV_VBOOTROM], &s->vbootrom);
 
     /* SCU */
+    object_property_set_link(OBJECT(&s->scu), "dram", OBJECT(s->dram_mr),
+                             &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 6829efa2dc..f8d0d3a3fc 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -20,6 +20,7 @@
 #include "qemu/guest-random.h"
 #include "qemu/module.h"
 #include "trace.h"
+#include "qemu/units.h"
 
 #define TO_REG(offset) ((offset) >> 2)
 
@@ -602,12 +603,20 @@ static void aspeed_scu_realize(DeviceState *dev, Error **errp)
                           TYPE_ASPEED_SCU, SCU_IO_REGION_SIZE);
 
     sysbus_init_mmio(sbd, &s->iomem);
+
+    if (s->ssp_cpuid > 0) {
+        if (!s->dram) {
+            error_setg(errp, TYPE_ASPEED_SCU ": 'dram' link not set");
+            return;
+        }
+        asc->dram_remap(s);
+    }
 }
 
 static const VMStateDescription vmstate_aspeed_scu = {
     .name = "aspeed.scu",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedSCUState, ASPEED_AST2600_SCU_NR_REGS),
         VMSTATE_END_OF_LIST()
@@ -619,6 +628,9 @@ static const Property aspeed_scu_properties[] = {
     DEFINE_PROP_UINT32("hw-strap1", AspeedSCUState, hw_strap1, 0),
     DEFINE_PROP_UINT32("hw-strap2", AspeedSCUState, hw_strap2, 0),
     DEFINE_PROP_UINT32("hw-prot-key", AspeedSCUState, hw_prot_key, 0),
+    DEFINE_PROP_INT32("ssp-cpuid", AspeedSCUState, ssp_cpuid, -1),
+    DEFINE_PROP_LINK("dram", AspeedSCUState, dram, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
 };
 
 static void aspeed_scu_class_init(ObjectClass *klass, const void *data)
@@ -872,6 +884,27 @@ static const TypeInfo aspeed_2600_scu_info = {
     .class_init = aspeed_2600_scu_class_init,
 };
 
+static void aspeed_2700_scu_dram_remap_alias_init(AspeedSCUState *s)
+{
+    if (s->ssp_cpuid > 0) {
+        /*
+         * The SSP coprocessor uses two memory aliases (remap1 and remap2)
+         * to access shared memory regions in the PSP DRAM:
+         *
+         * - remap1 maps PSP DRAM at 0x400000000 (size: 32MB) to SSP SDRAM
+         *   offset 0x2000000
+         * - remap2 maps PSP DRAM at 0x42c000000 (size: 32MB) to SSP SDRAM
+         *   offset 0x0
+         */
+        memory_region_init_alias(&s->dram_remap_alias[0], OBJECT(s),
+                                 "ssp.dram.remap1", s->dram,
+                                 0, 32 * MiB);
+        memory_region_init_alias(&s->dram_remap_alias[1], OBJECT(s),
+                                 "ssp.dram.remap2", s->dram,
+                                 0x2c000000, 32 * MiB);
+    }
+}
+
 static uint64_t aspeed_ast2700_scu_read(void *opaque, hwaddr offset,
                                         unsigned size)
 {
@@ -982,6 +1015,7 @@ static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *data)
     asc->nr_regs = ASPEED_AST2700_SCU_NR_REGS;
     asc->clkin_25Mhz = true;
     asc->ops = &aspeed_ast2700_scu_ops;
+    asc->dram_remap = aspeed_2700_scu_dram_remap_alias_init;
 }
 
 static uint64_t aspeed_ast2700_scuio_read(void *opaque, hwaddr offset,
-- 
2.43.0


