Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EC3CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 02:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTsRf-0007Hu-Oz; Sun, 31 May 2026 22:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wTsRd-0007HW-BX; Sun, 31 May 2026 22:32:01 -0400
Received: from mail.aspeedtech.com ([211.20.114.72]
 helo=twmbx01.aspeedtech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven_lee@aspeedtech.com>)
 id 1wTsRa-0004V7-Lg; Sun, 31 May 2026 22:32:01 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Jun
 2026 10:31:49 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Jun 2026 10:31:49 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <longzl2@lenovo.com>,
 <yunlin.tang@aspeedtech.com>, <steven_lee@aspeedtech.com>
Subject: [PATCH 0/6] aspeed: Add AST1040 Caliptra mailbox support
Date: Mon, 1 Jun 2026 10:31:41 +0800
Message-ID: <20260601023149.2309299-1-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=steven_lee@aspeedtech.com; helo=twmbx01.aspeedtech.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Steven Lee <steven_lee@aspeedtech.com>
From:  Steven Lee via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series adds AST1040 Caliptra MCI mailbox support for the
ast1040-evb machine.

AST1040 firmware accesses Caliptra through an MCI page aperture. This
series adds an AST1040 SCU model with the CPTRA page-select registers, a
mailbox frontend that exposes the Caliptra SRAM and CSR windows, and an
optional external chardev peer so a Caliptra simulator can service
EXECUTE requests.

The SoC wiring maps the mailbox SRAM, CSR window and 4 KiB remap
aperture. The EVB machine also gets a cptra-peer option for linking the
external peer after the machine is initialized.

The external peer backend is intended for co-simulation with an external
Caliptra model. The current bring-up backend used for manual testing is
caliptra-server:

  https://github.com/stevenlee7189/caliptra-server/blob/main-2.x/README.md

That README includes the server command line, the matching QEMU command
line, and the guest-side MFWV smoke test sequence used to validate the
MCI aperture, LOCK/CMD/DLEN/EXECUTE flow, and FirmwareVersion response.
The qtest added by this series does not depend on that repository; it
uses a socket-backed test peer to validate the QEMU-side protocol and
mailbox flow.

Patch layout:
- patches 1-2 add the AST1040 SCU model and mailbox frontend
- patch 3 adds the external chardev peer backend
- patch 4 wires the mailbox into the AST1040 SoC and EVB machine
- patches 5-6 add qtest coverage and documentation

The qtest covers mailbox lock, execute and completion flow through a
socket-backed peer, and verifies that SCU CPTRA_PAGE_REG0 remaps the MCI
aperture between CSR and SRAM pages.

Validation:
- scripts/checkpatch.pl --branch origin/master..HEAD
- qtest coverage for the AST1040 mailbox execute path with a
  socket-backed external peer
- manual co-simulation bring-up with caliptra-server through
  cptra-mbox-peer-extern

Steven Lee (6):
  hw/misc/aspeed_scu: Add AST1040 SCU model
  hw/misc: Add ASPEED Caliptra mailbox frontend
  hw/misc: Add external Caliptra mailbox peer
  hw/arm/aspeed_ast1040: Wire Caliptra mailbox
  tests/qtest: Add ASPEED Caliptra mailbox test
  docs/system/arm: Document AST1040 Caliptra mailbox

 MAINTAINERS                          |   1 +
 docs/system/arm/aspeed.rst           |  32 +++
 include/hw/arm/aspeed_soc.h          |  11 +
 include/hw/misc/aspeed_cptra_mbox.h  | 133 ++++++++++
 include/hw/misc/aspeed_scu.h         |  10 +
 hw/arm/aspeed_ast1040.c              |  60 ++++-
 hw/arm/aspeed_ast1040_evb.c          |  74 +++++-
 hw/misc/aspeed_cptra_mbox.c          | 380 +++++++++++++++++++++++++++
 hw/misc/aspeed_scu.c                 | 251 ++++++++++++++++++
 hw/misc/cptra_mbox_peer_extern.c     | 318 ++++++++++++++++++++++
 tests/qtest/aspeed_cptra_mbox-test.c | 223 ++++++++++++++++
 hw/misc/meson.build                  |   2 +
 hw/misc/trace-events                 |   6 +
 tests/qtest/meson.build              |   3 +-
 14 files changed, 1498 insertions(+), 6 deletions(-)
 create mode 100644 include/hw/misc/aspeed_cptra_mbox.h
 create mode 100644 hw/misc/aspeed_cptra_mbox.c
 create mode 100644 hw/misc/cptra_mbox_peer_extern.c
 create mode 100644 tests/qtest/aspeed_cptra_mbox-test.c

-- 
2.43.0

