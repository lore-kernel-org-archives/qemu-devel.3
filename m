Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B1ACAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 05:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1IUr-00045s-7L; Wed, 24 Sep 2025 01:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1IUo-0003xd-Dc; Wed, 24 Sep 2025 01:56:54 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1IUl-0000It-7m; Wed, 24 Sep 2025 01:56:54 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 24 Sep
 2025 13:56:04 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 24 Sep 2025 13:56:04 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v2 6/7] hw/arm/aspeed_ast27x0-fc: Map FMC0 flash contents into
 CA35 boot ROM
Date: Wed, 24 Sep 2025 13:56:00 +0800
Message-ID: <20250924055602.294857-7-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924055602.294857-1-jamin_lin@aspeedtech.com>
References: <20250924055602.294857-1-jamin_lin@aspeedtech.com>
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

This patch introduces a dedicated ca35_boot_rom memory region and
copies the FMC0 flash data into it when mmio_exec is disabled.

The main purpose of this change is to support the upcoming VBOOTROM
, which can directly fetch data from FMC0 flash at the SPI boot ROM
base address (0x100000000) without requiring any SPI controller
drivers.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0-fc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index b15cb94c39..2e6036b192 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -35,6 +35,7 @@ struct Ast2700FCState {
 
     MemoryRegion ca35_memory;
     MemoryRegion ca35_dram;
+    MemoryRegion ca35_boot_rom;
     MemoryRegion ssp_memory;
     MemoryRegion tsp_memory;
 
@@ -61,7 +62,10 @@ static void ast2700fc_ca35_init(MachineState *machine)
     Ast2700FCState *s = AST2700A1FC(machine);
     AspeedSoCState *soc;
     AspeedSoCClass *sc;
+    BlockBackend *fmc0 = NULL;
+    DeviceState *dev = NULL;
     Error **errp = NULL;
+    uint64_t rom_size;
 
     object_initialize_child(OBJECT(s), "ca35", &s->ca35, "ast2700-a1");
     soc = ASPEED_SOC(&s->ca35);
@@ -119,6 +123,16 @@ static void ast2700fc_ca35_init(MachineState *machine)
     ast2700fc_board_info.ram_size = machine->ram_size;
     ast2700fc_board_info.loader_start = sc->memmap[ASPEED_DEV_SDRAM];
 
+    if (!s->mmio_exec) {
+        dev = ssi_get_cs(soc->fmc.spi, 0);
+        fmc0 = dev ? m25p80_get_blk(dev) : NULL;
+
+        if (fmc0) {
+            rom_size = memory_region_size(&soc->spi_boot);
+            aspeed_install_boot_rom(soc, fmc0, &s->ca35_boot_rom, rom_size);
+        }
+    }
+
     arm_load_kernel(ARM_CPU(first_cpu), machine, &ast2700fc_board_info);
 }
 
-- 
2.43.0


