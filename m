Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1417C3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 09:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIOkv-0005DI-7C; Fri, 23 May 2025 05:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uIOks-0005Cf-QF; Fri, 23 May 2025 05:31:54 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1uIOkq-0005Md-Du; Fri, 23 May 2025 05:31:54 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 23 May
 2025 17:31:44 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 23 May 2025 17:31:44 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <longzl2@lenovo.com>,
 <yunlin.tang@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [PATCH v5 0/6] hw/arm/aspeed_ast2700-fc: Fix null pointer dereference
Date: Fri, 23 May 2025 17:31:37 +0800
Message-ID: <20250523093144.991408-1-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=steven_lee@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Steven Lee <steven_lee@aspeedtech.com>
From:  Steven Lee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Clang's sanitizer reports a runtime error when booting with
'-net nic -net user', due to a null pointer being passed
to memory_region_find(), which subsequently triggers a crash in
flatview_lookup().

Root cause:
- Missing NIC configuration in the CA35 initialization.

Fix:
- Reduce ca35 ram size from 2GiB to 1GiB to align with ast2700a1-evb,
  where the ram-container is defined as 1GiB in its class.
- Add nic configuration in ast2700fc's ca35 init function.


v2:
- Split the CA35 memory mapping into a separate patch.
- Added a new patch to fix BMC memory mapping in the fby35 machine,
  which had a similar issue (unmapped system_memory).
- Removed Change-Id tag from commit messages

v3:
- Fixed issue with incorrectly inheriting TYPE_ASPEED_MACHINE.
- Rewrote the commit message for "Map BMC memory into system memory".
- Added more details to the commit message for "Fix unimplemented region
  overlap with VBootROM".

v4:
- Split the first patch "Fix null pointer dereference" into two patches.
- Remove the patch "hw/arm/aspeed_ast27x0: Fix unimplemented
  region overlap with vbootrom".

v5:
- Rewrote the commit message for the first patch to:
    "hw/arm/aspeed_ast2700-fc: Add network support".

Steven Lee (6):
  hw/arm/aspeed_ast2700-fc: Add network support
  hw/arm/aspeed_ast2700-fc: Reduce ca35 ram size to align with ast2700a1
  hw/arm/aspeed_ast27x0: Fix unimplemented region overlap with vbootrom
  hw/arm/aspeed_ast27x0-fc: Map ca35 memory into system memory
  hw/arm/fby35: Map BMC memory into system memory
  docs: Remove ast2700fc from Aspeed family boards

 docs/system/arm/aspeed.rst |  2 +-
 hw/arm/aspeed_ast27x0-fc.c | 10 +++++++++-
 hw/arm/aspeed_ast27x0.c    |  4 ++--
 hw/arm/fby35.c             |  1 +
 4 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.43.0


