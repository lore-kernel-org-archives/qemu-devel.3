Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3044FCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 06:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8uuY-0000xp-09; Wed, 15 Oct 2025 02:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8uuV-0000wo-P5; Wed, 15 Oct 2025 02:22:55 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8uuT-0002xW-H1; Wed, 15 Oct 2025 02:22:55 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 15 Oct
 2025 14:22:11 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 15 Oct 2025 14:22:11 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 03/12] hw/arm/ast27x0: Add SRAM link and alias mapping for
 SSP coprocessor
Date: Wed, 15 Oct 2025 14:21:58 +0800
Message-ID: <20251015062210.3128710-4-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015062210.3128710-1-jamin_lin@aspeedtech.com>
References: <20251015062210.3128710-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

AST2700 has a 128KB SRAM, physically mapped at 0x10000000–0x1001FFFF for
the PSP (CA35) processor. The SSP coprocessor shares this same SRAM but
accesses it through a different address window at 0x70000000–0x7001FFFF.

To model this shared-memory behavior in QEMU, this commit introduces a
linked SRAM property and alias mapping between the PSP and SSP subsystems.

Changes include:
- Add a "MemoryRegion *sram" link and "MemoryRegion sram_alias" to
  AspeedCoprocessorState.
- Register the new "sram" property in aspeed_coprocessor_common.c.
- In aspeed_ast27x0-fc.c, connect the SSP coprocessor’s "sram" link to
  the PSP’s SRAM region.
- In aspeed_ast27x0-ssp.c, create an alias mapping for SRAM at
  0x70000000 – 0x7001FFFF in the SSP’s memory map.

This ensures that the SSP can correctly access the shared SRAM contents
through its own address space while maintaining a consistent physical
backing region. It also guarantees that the SRAM is realized before the
SSP device, ensuring successful alias setup.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_coprocessor.h | 3 ++-
 hw/arm/aspeed_ast27x0-fc.c          | 4 ++++
 hw/arm/aspeed_ast27x0-ssp.c         | 7 +++++++
 hw/arm/aspeed_coprocessor_common.c  | 2 ++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index 0c7168a89c..d9a5f517d7 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -17,7 +17,8 @@ struct AspeedCoprocessorState {
 
     MemoryRegion *memory;
     MemoryRegion sdram;
-    MemoryRegion sram;
+    MemoryRegion *sram;
+    MemoryRegion sram_alias;
     Clock *sysclk;
 
     AspeedSCUState scu;
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index a61ecff390..25e668a648 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -118,6 +118,8 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
     AspeedCoprocessorState *soc;
     AspeedCoprocessorClass *sc;
     Ast2700FCState *s = AST2700A1FC(machine);
+    AspeedSoCState *psp = ASPEED_SOC(&s->ca35);
+
     s->ssp_sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
     clock_set_hz(s->ssp_sysclk, 200000000ULL);
 
@@ -134,6 +136,8 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
     sc = ASPEED_COPROCESSOR_GET_CLASS(soc);
     aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART4, sc->uarts_base,
                             sc->uarts_num, serial_hd(1));
+    object_property_set_link(OBJECT(&s->ssp), "sram",
+                             OBJECT(&psp->sram), &error_abort);
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {
         return false;
     }
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 9f3a1933a0..66c4ef6d1b 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -20,6 +20,7 @@
 
 static const hwaddr aspeed_soc_ast27x0ssp_memmap[] = {
     [ASPEED_DEV_SDRAM]     =  0x00000000,
+    [ASPEED_DEV_SRAM]      =  0x70000000,
     [ASPEED_DEV_INTC]      =  0x72100000,
     [ASPEED_DEV_SCU]       =  0x72C02000,
     [ASPEED_DEV_SCUIO]     =  0x74C02000,
@@ -195,6 +196,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
                                 sc->memmap[ASPEED_DEV_SDRAM],
                                 &s->sdram);
 
+    /* SRAM */
+    memory_region_init_alias(&s->sram_alias, OBJECT(s), "sram.alias",
+                             s->sram, 0, memory_region_size(s->sram));
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM],
+                                &s->sram_alias);
+
     /* SCU */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
diff --git a/hw/arm/aspeed_coprocessor_common.c b/hw/arm/aspeed_coprocessor_common.c
index 8a94b44f07..8322ad5eb5 100644
--- a/hw/arm/aspeed_coprocessor_common.c
+++ b/hw/arm/aspeed_coprocessor_common.c
@@ -25,6 +25,8 @@ static void aspeed_coprocessor_realize(DeviceState *dev, Error **errp)
 static const Property aspeed_coprocessor_properties[] = {
     DEFINE_PROP_LINK("memory", AspeedCoprocessorState, memory,
                      TYPE_MEMORY_REGION, MemoryRegion *),
+    DEFINE_PROP_LINK("sram", AspeedCoprocessorState, sram, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
 };
 
 static void aspeed_coprocessor_class_init(ObjectClass *oc, const void *data)
-- 
2.43.0


