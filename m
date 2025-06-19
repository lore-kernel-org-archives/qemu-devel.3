Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB304C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 06:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS8xn-0002Tj-Lb; Thu, 19 Jun 2025 02:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uS8xk-0002Sk-P9; Thu, 19 Jun 2025 02:41:28 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uS8xg-0001s1-F6; Thu, 19 Jun 2025 02:41:28 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 19 Jun
 2025 14:41:15 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 19 Jun 2025 14:41:15 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [RFC v5 0/4] Add QEMU model for ASPEED OTP memory and integrate with
 SoCs
Date: Thu, 19 Jun 2025 14:41:09 +0800
Message-ID: <20250619064115.4182202-1-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

This patch series introduces a QEMU model for the ASPEED OTP (One-Time
Programmable) memory, along with its integration into the Secure Boot
Controller (SBC) and supported SoCs (AST2600, AST1030).

The OTP model emulates a simple fuse array used for secure boot or
device configuration, with support for both file-backed content and
internal fallback buffers. It exposes an AddressSpace to support
transaction-based access from controllers like the SBC.

This series includes:
  - OTP memory device implementation
  - SBC integration with command decoding (READ/PROG)
  - Machine property wiring (via "otpmem" alias)
  - A functional test suite covering various initialization paths

**[RFC notice]**
This is an RFC submission. While the OTP model itself is mostly
complete, this version is primarily intended to gather feedback on the
device initialization flow-specifically how the OTP instance is created,
connected, and exposed via machine properties. Any comment on QOM 
integration style, late binding via notifier, and fallback behavior are
welcome.

In particular, I am seeking input on:
  - Whether the current notifier-based connection from SBC to OTP is
    appropriate, or if there is a preferred QOM idiom for linking
    peripheral devices post-realize.
  - The use of "optmem" as a drive alias and machine parameter handling.

A more finalized version with any requested changes, documentation,
and test refinements will follow after review.

Example usage:
```bash
qemu-system-arm -machine ast2600-evb,otpmem=otpmem-drive \
  -blockdev driver=file,filename=otpmem.img,node-name=otpmem \
  -device aspeed.otpmem,drive=otpmem,id=otpmem-drive \
  ...
```

Any feedback or suggestions are appreciated!

Thanks,
Kane

---

ChangeLog
---------
v5:
- Switched to notifier-based late binding between SBC and OTP
- Exposed 'otpmem' as a machine parameter using QOM alias mechanism
- Added fallback support when no backend is provided
- Introduced functional test suite covering multiple init configurations
- Submitted as [RFC] to gather feedback on QOM integration approach

v4:
- Replaces blockdev backend with memory-mapped AddressSpace access
- Switches from `-drive` CLI option to `otpmem` machine parameter
- Restructures the OTP device under the SBC in the QOM tree

v3:
- Minor fixes and refinements on top of v2 content

v2:
- Separated the OTP memory into a standalone QEMU device (`aspeed.otpmem`)
- Replaced ad-hoc file handling with standard `-drive` backend integration
- Linked OTP to SBC via QOM property for cleaner abstraction
- Improved memory bounds checking and irreversible programming logic

v1:
- Embedded OTP logic in the SBC model and created the backing file internally.

---

Kane-Chen-AS (4):
  hw/misc/aspeed_otp: Add ASPEED OTP memory device model
  hw/misc/aspeed_sbc: Connect ASPEED OTP memory device to SBC
  hw/arm: Integrate ASPEED OTP memory support into AST10x0 and AST2600
    SoCs
  tests/functional: Add integration tests for ASPEED OTP memory model

 hw/arm/aspeed.c                        |  20 +++
 hw/arm/aspeed_ast10x0.c                |   2 +-
 hw/arm/aspeed_ast2600.c                |   2 +-
 hw/misc/aspeed_otpmem.c                | 117 ++++++++++++++++
 hw/misc/aspeed_sbc.c                   | 179 +++++++++++++++++++++++++
 hw/misc/meson.build                    |   1 +
 hw/misc/trace-events                   |   7 +
 include/hw/misc/aspeed_otpmem.h        |  35 +++++
 include/hw/misc/aspeed_sbc.h           |   8 ++
 tests/functional/meson.build           |   1 +
 tests/functional/test_aspeed_otpmem.py |  82 +++++++++++
 11 files changed, 452 insertions(+), 2 deletions(-)
 create mode 100644 hw/misc/aspeed_otpmem.c
 create mode 100644 include/hw/misc/aspeed_otpmem.h
 create mode 100644 tests/functional/test_aspeed_otpmem.py

-- 
2.43.0


