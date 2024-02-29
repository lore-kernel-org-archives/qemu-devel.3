Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF040C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 08:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfbLS-0001dI-Ew; Thu, 29 Feb 2024 03:00:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rfbLA-0001M3-Ks; Thu, 29 Feb 2024 03:00:35 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX02.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rfbL3-00033a-9A; Thu, 29 Feb 2024 03:00:25 -0500
Received: from TWMBX02.aspeed.com (192.168.0.25) by TWMBX02.aspeed.com
 (192.168.0.25) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 29 Feb
 2024 16:00:15 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 29 Feb 2024 16:00:15 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <jamin_lin@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 0/8] Add AST2700 support
Date: Thu, 29 Feb 2024 16:00:06 +0800
Message-ID: <20240229080014.1235018-1-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: Fail (TWMBX02.aspeed.com: domain of jamin_lin@aspeedtech.com
 does not designate 192.168.10.10 as permitted sender)
 receiver=TWMBX02.aspeed.com; client-ip=192.168.10.10;
 helo=localhost.localdomain;
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

Changes from v1:
The patch series supports WDT, SDMC, SMC, SCU, SLI and INTC for AST2700 SoC.

Test steps:
1. Download openbmc image for AST2700 from
   https://github.com/AspeedTech-BMC/openbmc/releases/tag/v09.00
   https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.00/
   ast2700-default-obmc.tar.gz
2. untar ast2700-default-obmc.tar.gz
   ```
   tar -xf ast2700-default-obmc.tar.gz
   ```
3. Run and the contents of scripts as following
IMGDIR=ast2700-default
UBOOT_SIZE=$(stat --format=%s -L ${IMGDIR}/u-boot-nodtb.bin)
UBOOT_DTB_ADDR=$((0x400000000 + ${UBOOT_SIZE}))

qemu-system-aarch64 -M ast2700-evb -nographic -m 8G\
 -device loader,addr=0x400000000,file=${IMGDIR}/u-boot-nodtb.bin,force-raw=on\
 -device loader,addr=${UBOOT_DTB_ADDR},file=${IMGDIR}/u-boot.dtb,force-raw=on\
 -device loader,addr=0x430000000,file=${IMGDIR}/bl31.bin,force-raw=on\
 -device loader,addr=0x430080000,file=${IMGDIR}/optee/tee-raw.bin,force-raw=on\
 -device loader,addr=0x430000000,cpu-num=0\
 -device loader,addr=0x430000000,cpu-num=1\
 -device loader,addr=0x430000000,cpu-num=2\
 -device loader,addr=0x430000000,cpu-num=3\
 -smp 4\
 -drive file=${IMGDIR}/image-bmc,format=raw,if=mtd\
 -serial mon:stdio\
 -snapshot

Known Issue:
1. QEMU supports ARM Generic Interrupt Controller, version 3(GICv3)
but not support Shared Peripheral Interrupt (SPI), yet.
Added work around in INTC patch to set GICINT132[18]
which was BMC UART interrupt if it received GICINT132, so users are
able to type any key from keyboard to trigger GICINT132 interrupt
until AST2700 boot into login prompt. It is a temporary solution.
If users encounter boot stck and no booting log,
please type any key from keyboard.

2. It is required to add "-m 8G" to set the dram size 8G.
AST2700 dram size calculation is not compatible AST2600.
According to the DDR hardware capacity behavior, if users write the
data at address which is over than the supported size, it would set
the data at address 0.
For example:
a. sdram base address "0x4 00000000"
b. sdram size is 1GiB
The available address range is from "0x4 00000000" to "0x4 40000000".
If users write 0xdeadbeef at address "0x6 00000000", the value of
DRAM address 0 (base address 0x4 00000000) should be 0xdeadbeef.
Please see ast2700_sdrammc_calc_size in
https://github.com/AspeedTech-BMC/u-boot/blob/v00.05.00/drivers/ram/aspeed/
sdram_ast2700.c

It seems we should create a new function instead of aspeed_soc_dram_init
to support AST2700.
https://github.com/qemu/qemu/blob/master/hw/arm/aspeed_soc_common.c

Jamin Lin (8):
  aspeed/wdt: Add AST2700 support
  aspeed/sli: Add AST2700 support
  aspeed/sdmc: Add AST2700 support
  aspeed/smc: Add AST2700 support
  aspeed/scu: Add AST2700 support
  aspeed/intc: Add AST2700 support
  aspeed/soc: Add AST2700 support
  aspeed: Add an AST2700 eval board

 hw/arm/aspeed.c                  |  32 +++
 hw/arm/aspeed_ast27x0.c          | 462 +++++++++++++++++++++++++++++++
 hw/arm/meson.build               |   1 +
 hw/intc/aspeed_intc.c            | 135 +++++++++
 hw/intc/meson.build              |   1 +
 hw/misc/aspeed_scu.c             | 306 +++++++++++++++++++-
 hw/misc/aspeed_sdmc.c            | 215 ++++++++++++--
 hw/misc/aspeed_sli.c             | 179 ++++++++++++
 hw/misc/meson.build              |   3 +-
 hw/misc/trace-events             |  11 +
 hw/ssi/aspeed_smc.c              | 326 ++++++++++++++++++++--
 hw/ssi/trace-events              |   2 +-
 hw/watchdog/wdt_aspeed.c         |  24 ++
 include/hw/arm/aspeed_soc.h      |  26 +-
 include/hw/intc/aspeed_vic.h     |  29 ++
 include/hw/misc/aspeed_scu.h     |  47 +++-
 include/hw/misc/aspeed_sdmc.h    |   4 +-
 include/hw/misc/aspeed_sli.h     |  32 +++
 include/hw/ssi/aspeed_smc.h      |   1 +
 include/hw/watchdog/wdt_aspeed.h |   3 +-
 20 files changed, 1787 insertions(+), 52 deletions(-)
 create mode 100644 hw/arm/aspeed_ast27x0.c
 create mode 100644 hw/intc/aspeed_intc.c
 create mode 100644 hw/misc/aspeed_sli.c
 create mode 100644 include/hw/misc/aspeed_sli.h

-- 
2.25.1


