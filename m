Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED29C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 12:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rewwa-0008Vz-CE; Tue, 27 Feb 2024 07:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=hhKj=KE=kaod.org=clg@ozlabs.org>)
 id 1rewwY-0008V1-Ks; Tue, 27 Feb 2024 07:52:22 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=hhKj=KE=kaod.org=clg@ozlabs.org>)
 id 1rewwV-0002in-U2; Tue, 27 Feb 2024 07:52:22 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Tkcnr1w6Jz4wxX;
 Tue, 27 Feb 2024 23:52:16 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tkcnp1NrTz4wc1;
 Tue, 27 Feb 2024 23:52:13 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 2/2] aspeed: fix hardcode boot address 0
Date: Tue, 27 Feb 2024 13:52:01 +0100
Message-ID: <20240227125201.414060-3-clg@kaod.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227125201.414060-1-clg@kaod.org>
References: <20240227125201.414060-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=hhKj=KE=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jamin Lin <jamin_lin@aspeedtech.com>

In the previous design of ASPEED SOCs QEMU model, it set the boot
address at "0" which was the hardcode setting for ast10x0, ast2600,
ast2500 and ast2400.

According to the design of ast2700, it has a bootmcu(riscv-32) which
is used for executing SPL and initialize DRAM and copy u-boot image
from SPI/Flash to DRAM at address 0x400000000 at SPL boot stage.
Then, CPUs(cortex-a35) execute u-boot, kernel and rofs.

Currently, qemu not support emulate two CPU architectures
at the same machine. Therefore, qemu will only support
to emulate CPU(cortex-a35) side for ast2700 and the boot
address is "0x4 00000000".

Fixed hardcode boot address "0" for future models using
a different mapping address.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed_soc.h | 2 --
 hw/arm/aspeed.c             | 4 +++-
 hw/arm/aspeed_ast2400.c     | 4 ++--
 hw/arm/aspeed_ast2600.c     | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index e1a023be538b..c60fac900acb 100644
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
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 0af96afa16a6..8854581ca8de 100644
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
index 95da85fee029..d12588620751 100644
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
index f74561ecdcd5..174be537709b 100644
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
-- 
2.43.2


