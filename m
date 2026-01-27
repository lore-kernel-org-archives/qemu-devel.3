Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23056C88E41
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfOW-0003k1-Cn; Tue, 27 Jan 2026 04:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkfOU-0003hf-4N; Tue, 27 Jan 2026 04:29:54 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkfOR-0004dA-HB; Tue, 27 Jan 2026 04:29:53 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 27 Jan
 2026 17:29:43 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 27 Jan 2026 17:29:43 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v2 00/11] Add SSP/TSP power control and DRAM remap support for
 AST2700
Date: Tue, 27 Jan 2026 17:29:29 +0800
Message-ID: <20260127092943.3731635-1-jamin_lin@aspeedtech.com>
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

This series improves AST2700 platform support by aligning SSP/TSP
power and reset behavior with hardware, and enabling DRAM remapping
required for proper firmware boot flow.

v1:
  1. The changes move DRAM/SDMC initialization earlier to support memory
aliasing, add DRAM aliases for SSP/TSP SDRAM remap, and implement
SSP/TSP reset, power-on, and remap controls via SCU registers.
  2. With these updates, SSP and TSP can be booted via PSP and load their
binaries from DRAM. Functional tests and documentation are updated
accordingly.

v2:
  Fix "make check" failure caused by both AST2700 and AST1700 realizing the same
  TYPE_AST2700_SCU model.

Jamin Lin (11):
  hw/arm/ast27x0: Move DRAM and SDMC initialization earlier to support
    memory aliasing
  hw/arm/ast27x0: Start SSP in powered-off state to match hardware
    behavior
  hw/arm/ast27x0: Start TSP in powered-off state to match hardware
    behavior
  hw/arm/ast27x0: Add DRAM alias for SSP SDRAM remap
  hw/arm/ast27x0: Add DRAM alias for TSP SDRAM remap
  hw/misc/aspeed_scu: Implement SSP reset and power-on control via SCU
    registers
  hw/misc/aspeed_scu: Implement TSP reset and power-on control via SCU
    registers
  hw/misc/aspeed_scu: Add SCU support for SSP SDRAM remap
  hw/misc/aspeed_scu: Add SCU support for TSP SDRAM remap
  tests/functional/aarch64/test_aspeed_ast2700fc: Boot SSP/TSP via PSP
    and load binaries from DRAM
  docs: Add support vbootrom and update Manual boot for ast2700fc

 docs/system/arm/aspeed.rst                    |  37 ++-
 include/hw/misc/aspeed_scu.h                  |   6 +
 hw/arm/aspeed_ast27x0-fc.c                    |   4 +
 hw/arm/aspeed_ast27x0-ssp.c                   |  13 +
 hw/arm/aspeed_ast27x0-tsp.c                   |  10 +
 hw/arm/aspeed_ast27x0.c                       |  46 +--
 hw/misc/aspeed_scu.c                          | 268 +++++++++++++++++-
 .../aarch64/test_aspeed_ast2700fc.py          |  35 ++-
 8 files changed, 378 insertions(+), 41 deletions(-)

-- 
2.43.0


