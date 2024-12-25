Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8055DE7718F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 02:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQGp5-000804-UV; Tue, 24 Dec 2024 21:08:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tQGp2-0007z2-DA; Tue, 24 Dec 2024 21:08:29 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1tQGp0-0002ew-1y; Tue, 24 Dec 2024 21:08:28 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 25 Dec
 2024 10:03:12 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 25 Dec 2024 10:03:12 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <steven_lee@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH 0/5] Introduce AST27x0 multi-SoC machine
Date: Wed, 25 Dec 2024 10:03:06 +0800
Message-ID: <20241225020311.3718080-1-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=steven_lee@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Steven Lee <steven_lee@aspeedtech.com>
From:  Steven Lee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch series introduces full cores support for the AST27x0 SoC,
along with necessary updates to the ASPEED AST27x0 SOC.

The AST27x0 SoC is a new family of ASPEED SoCs featuring 4 Cortex-A35
cores and 2 Cortex-M4 cores. This patch set adds the following updates:

1. Public API updates:
   Modifies the sdhci_attach_drive and write_boot_rom functions to make them
   accessible for broader usage.

2. SoC memory updates:
   Maps unimplemented devices in the AST27x0 memory space.

3. AST27x0 CM4 SoC integration:
   Adds basic support for the AST27x0 CM4 SoC.

4. AST2700-FC machine:
   Introduces a new AST2700-FC machine which supports emulating 4
   cortex-a35 cores and 2 coretex-m4 cores.

5. Documentation:
   Updates the ASPEED documentation to include usage of the new
   ast2700-fc machine.

This series has been tested using ASPEED SDK image by the following
  IMGDIR=./
  UBOOT_SIZE=$(stat --format=%s -L ${IMGDIR}/u-boot-nodtb.bin)

  $ UBOOT_SIZE=$(stat --format=%s -L ${IMGDIR}/u-boot-nodtb.bin)
  $ wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/ast2700-ssp.elf
  $ wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/ast2700-tsp.elf
  $ wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/bl31.bin
  $ wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/tee-raw.bin
  $ wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/u-boot-nodtb.bin
  $ wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/u-boot.dtb
  $ wget https://github.com/stevenlee7189/zephyr/releases/download/1.0.0/image-bmc.tar.zst
  $ tar --zstd -xvf image-bmc.tar.zst

  $ qemu-system-aarch64 -machine ast2700fc \
       -device loader,force-raw=on,addr=0x400000000,file=${IMGDIR}/u-boot-nodtb.bin \
       -device loader,force-raw=on,addr=$((0x400000000 + ${UBOOT_SIZE})),file=${IMGDIR}/u-boot.dtb \
       -device loader,force-raw=on,addr=0x430000000,file=${IMGDIR}/bl31.bin \
       -device loader,force-raw=on,addr=0x430080000,file=${IMGDIR}/tee-raw.bin \
       -device loader,file=${IMGDIR}/ast2700-ssp.elf,cpu-num=4 \
       -device loader,file=${IMGDIR}/ast2700-tsp.elf,cpu-num=5 \
       -device loader,cpu-num=0,addr=0x430000000 \
       -device loader,cpu-num=1,addr=0x430000000 \
       -device loader,cpu-num=2,addr=0x430000000 \
       -device loader,cpu-num=3,addr=0x430000000 \
       -m 1G \
       -drive file=image-bmc,if=mtd,format=raw \
       -serial pty -serial pty -serial pty \
       -S -nographic

    char device redirected to /dev/pts/51 (label serial0)
    char device redirected to /dev/pts/52 (label serial1)
    char device redirected to /dev/pts/53 (label serial2)

  $ tio /dev/pts/51
  $ tio /dev/pts/52
  $ tio /dev/pts/53
  $ (qemu) c

Steven Lee (5):
  aspeed: Make sdhci_attach_drive and write_boot_rom public
  aspeed: ast27x0: Map unimplemented devices in SoC memory
  aspeed: Introduce AST27x0 SoC with Cortex-M4 support
  aspeed: Introduce ast2700-fc machine
  docs: aspeed: Add ast2700-fc machine section

 docs/system/arm/aspeed.rst  |  50 ++++-
 hw/arm/aspeed.c             |   4 +-
 hw/arm/aspeed_ast27x0-cm4.c | 397 ++++++++++++++++++++++++++++++++++++
 hw/arm/aspeed_ast27x0-fc.c  | 211 +++++++++++++++++++
 hw/arm/aspeed_ast27x0.c     |  45 +++-
 hw/arm/meson.build          |   5 +-
 include/hw/arm/aspeed.h     |   6 +
 include/hw/arm/aspeed_soc.h |  41 ++++
 8 files changed, 747 insertions(+), 12 deletions(-)
 create mode 100644 hw/arm/aspeed_ast27x0-cm4.c
 create mode 100644 hw/arm/aspeed_ast27x0-fc.c

--
2.34.1


