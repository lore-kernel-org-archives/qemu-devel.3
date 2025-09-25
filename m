Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810EFCAC5AA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 05:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1eBG-0008Vr-1x; Thu, 25 Sep 2025 01:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1eB9-0008VH-Lp; Thu, 25 Sep 2025 01:06:03 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1eAu-0006qM-M9; Thu, 25 Sep 2025 01:05:55 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 25 Sep
 2025 13:05:36 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 25 Sep 2025 13:05:36 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v3 0/8] Support VBOOTROM to ast2700fc machine
Date: Thu, 25 Sep 2025 13:05:26 +0800
Message-ID: <20250925050535.2657256-1-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

v1
 1. Added support for Vboot ROM.
 2. Moved coprocessor initialization from machine level to SoC level
 3. Unified SCU controllers between PSP and coprocessors
 4. Shared the same SRAM between PSP and coprocessors
 5. Support PSP DRAM remaps coprocessor SDRAM
 6. Added support for controlling coprocessor reset via SCU registers.

v2
Split the original patch set into smaller sub-patches for review.
 This patch focuses on:
  1. Adding support for Vboot ROM.
  2. Moving common APIs to SoC-level code for reuse in different
     platforms and reducing duplication.

v3
  1. Drop dead return checks.
  2. Make sub-init functions return bool with errp.

Dependencies

Based on https://github.com/legoater/qemu at the aspeed-next branch.

Jamin Lin (8):
  hw/arm/aspeed: Move aspeed_board_init_flashes() to common SoC code
  hw/arm/aspeed: Move write_boot_rom to common SoC code
  hw/arm/aspeed: Move aspeed_install_boot_rom to common SoC code
  hw/arm/aspeed: Move aspeed_load_vbootrom to common SoC code
  hw/arm/aspeed_ast27x0-fc: Drop dead return checks
  hw/arm/aspeed_ast27x0-fc: Make sub-init functions return bool with
    errp
  hw/arm/aspeed_ast27x0-fc: Map FMC0 flash contents into CA35 boot ROM
  hw/arm/aspeed_ast27x0-fc: Add VBOOTROM support

 include/hw/arm/aspeed_soc.h |   8 +++
 hw/arm/aspeed.c             | 105 ++----------------------------------
 hw/arm/aspeed_ast27x0-fc.c  |  96 +++++++++++++++++----------------
 hw/arm/aspeed_soc_common.c  |  96 +++++++++++++++++++++++++++++++++
 4 files changed, 159 insertions(+), 146 deletions(-)

-- 
2.43.0


