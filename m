Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7219EC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 20:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXo7u-0002WQ-Bg; Wed, 07 Feb 2024 15:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rXo7r-0002Tk-Rc; Wed, 07 Feb 2024 15:02:31 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX02.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rXo7q-0003Ra-Dl; Wed, 07 Feb 2024 15:02:31 -0500
Received: from TWMBX02.aspeed.com (192.168.0.25) by TWMBX02.aspeed.com
 (192.168.0.25) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Feb
 2024 04:02:23 +0800
Received: from twmbx02.aspeed.com (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Feb 2024 04:02:23 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <jamin_lin@aspeedtech.com>
Subject: [PATCH v2 2/2] aspeed: fix hardcode boot address 0
Date: Thu, 8 Feb 2024 04:02:19 +0800
Message-ID: <20240207200220.453244-3-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240207200220.453244-1-jamin_lin@aspeedtech.com>
References: <20240207200220.453244-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: Fail (TWMBX02.aspeed.com: domain of jamin_lin@aspeedtech.com
 does not designate 192.168.10.10 as permitted sender)
 receiver=TWMBX02.aspeed.com; client-ip=192.168.10.10;
 helo=twmbx02.aspeed.com;
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX02.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_FAIL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In the previous design of ASPEED SOCs QEMU model, it set the boot
address at "0" which was the hardcode setting for ast10x0, ast2600,
ast2500 and ast2400.

According to the design of ast2700, it has bootmcu which is used for
executing SPL and initialize DRAM, then, CPUs(cortex-a35)
execute u-boot, kernel and rofs. QEMU will only support CPU(cortex-a35)
parts and the boot address is "0x4 00000000" for ast2700.
Therefore, fixed hardcode boot address 0.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed.c             | 4 +++-
 hw/arm/aspeed_ast2400.c     | 4 ++--
 hw/arm/aspeed_ast2600.c     | 2 +-
 include/hw/arm/aspeed_soc.h | 2 --
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 06d863958b..39758557be 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -289,12 +289,14 @@ static void aspeed_install_boot_rom(AspeedMachineState *bmc, BlockBackend *blk,
                                     uint64_t rom_size)
 {
     AspeedSoCState *soc = bmc->soc;
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(soc);
 
     memory_region_init_rom(&bmc->boot_rom, NULL, "aspeed.boot_rom", rom_size,
                            &error_abort);
     memory_region_add_subregion_overlap(&soc->spi_boot_container, 0,
                                         &bmc->boot_rom, 1);
-    write_boot_rom(blk, ASPEED_SOC_SPI_BOOT_ADDR, rom_size, &error_abort);
+    write_boot_rom(blk, sc->memmap[ASPEED_DEV_SPI_BOOT],
+                   rom_size, &error_abort);
 }
 
 void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index 95da85fee0..d125886207 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -26,7 +26,7 @@
 #define ASPEED_SOC_IOMEM_SIZE       0x00200000
 
 static const hwaddr aspeed_soc_ast2400_memmap[] = {
-    [ASPEED_DEV_SPI_BOOT]  =  ASPEED_SOC_SPI_BOOT_ADDR,
+    [ASPEED_DEV_SPI_BOOT]  = 0x00000000,
     [ASPEED_DEV_IOMEM]  = 0x1E600000,
     [ASPEED_DEV_FMC]    = 0x1E620000,
     [ASPEED_DEV_SPI1]   = 0x1E630000,
@@ -61,7 +61,7 @@ static const hwaddr aspeed_soc_ast2400_memmap[] = {
 };
 
 static const hwaddr aspeed_soc_ast2500_memmap[] = {
-    [ASPEED_DEV_SPI_BOOT]  = ASPEED_SOC_SPI_BOOT_ADDR,
+    [ASPEED_DEV_SPI_BOOT]  = 0x00000000,
     [ASPEED_DEV_IOMEM]  = 0x1E600000,
     [ASPEED_DEV_FMC]    = 0x1E620000,
     [ASPEED_DEV_SPI1]   = 0x1E630000,
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index f74561ecdc..174be53770 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -22,7 +22,7 @@
 #define ASPEED_SOC_DPMCU_SIZE       0x00040000
 
 static const hwaddr aspeed_soc_ast2600_memmap[] = {
-    [ASPEED_DEV_SPI_BOOT]  = ASPEED_SOC_SPI_BOOT_ADDR,
+    [ASPEED_DEV_SPI_BOOT]  = 0x00000000,
     [ASPEED_DEV_SRAM]      = 0x10000000,
     [ASPEED_DEV_DPMCU]     = 0x18000000,
     /* 0x16000000     0x17FFFFFF : AHB BUS do LPC Bus bridge */
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 5ab0902da0..bf43ad8351 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -224,8 +224,6 @@ enum {
     ASPEED_DEV_FSI2,
 };
 
-#define ASPEED_SOC_SPI_BOOT_ADDR 0x0
-
 qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev);
 bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp);
 void aspeed_soc_uart_set_chr(AspeedSoCState *s, int dev, Chardev *chr);
-- 
2.25.1


