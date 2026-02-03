Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468BFE83062
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 08:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnC9L-0004XQ-4B; Tue, 03 Feb 2026 03:52:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vnC9I-0004XC-PT; Tue, 03 Feb 2026 03:52:40 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vnC9G-0002qU-Ef; Tue, 03 Feb 2026 03:52:40 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 3 Feb
 2026 16:52:29 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 3 Feb 2026 16:52:29 +0800
To: <komlodi@google.com>, <nabihestefan@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "open list:All
 patches CC here" <qemu-devel@nongnu.org>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v2 00/20] i3c: aspeed: Add I3C support
Date: Tue, 3 Feb 2026 16:52:00 +0800
Message-ID: <20260203085229.1543287-1-jamin_lin@aspeedtech.com>
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

v1:
  The initial patch series was based on work by Joe Komlodi <komlodi@google.com>.

  This series adds I3C bus support to QEMU and adds more functionality to the
  Aspeed I3C controller.

  This implementation is a basic implementation that introduces IBIs
  (including hot-join), CCCs, and SDR data transfer. As-is, it doesn't support
  multi-controller buses or HDR transfers.

  First we add the I3C bus and controller model. With that added we extend
  the functionality of the Aspeed I3C controller so it can do transfers
  and handle IBIs.

  Next, we add a mock I3C target. It's intended to be a very simple target
  just to verify that I3C is working on the guest. Internally, we've used it
  on Linux to verify that i3C devices can be probed and can send/receive data
  and IBIs.
  This target is sort of like an EEPROM, and it can also send IBIs upon
  reception of a user-defined magic number.

  Lastly we add  hotplugging support. The hotplugging doesn't do anything too
  complicated, it just adds the device attempting to hotplug to the bus. It
  is the device's responsibility to hot-join and go through the DAA process
  to participate on the bus.

v2:
  Jamin Lin <jamin_lin@aspeedtech.com> has taken ownership of the I3C patch
  series for upstream submission.

  Changes in this version include:

  1. Added I3C functional tests.
  2. Updated patch 4 to refine register field definitions.
  3. Updated patch 7 to correct read-only register field masks.

Jamin Lin (1):
  tests/functional/arm/test_aspeed_ast2600_sdk: Add i3c functional test

Joe Komlodi (19):
  hw/misc/aspeed_i3c: Move to i3c directory
  hw/i3c: Add bus support
  hw/i3c: Split DesignWare I3C out of Aspeed I3C
  hw/i3c/dw-i3c: Add more register fields
  hw/i3c/aspeed_i3c: Add more register fields
  hw/i3c/dw-i3c: Add more reset values
  hw/i3c/aspeed_i3c: Add register RO field masks
  hw/i3c/dw-i3c: Add register RO field masks
  hw/i3c/dw-i3c: Treat more registers as read-as-zero
  hw/i3c/dw-i3c: Use 32 bits on MMIO writes
  hw/i3c/dw-i3c: Add IRQ MMIO behavior
  hw/i3c/dw-i3c: Add data TX and RX
  hw/i3c/dw-i3c: Add IBI handling
  hw/i3c/dw-i3c: Add ctrl MMIO handling
  hw/i3c/dw-i3c: Add controller resets
  hw/i3c/aspeed: Add I3C bus get function
  hw/i3c: Add Mock target
  hw/arm/aspeed: Build with I3C_DEVICES
  hw/i3c: Add hotplug support

 meson.build                                   |    1 +
 hw/i3c/trace.h                                |    2 +
 include/hw/arm/aspeed_soc.h                   |    2 +-
 include/hw/{misc => i3c}/aspeed_i3c.h         |   22 +-
 include/hw/i3c/dw-i3c.h                       |  201 ++
 include/hw/i3c/i3c.h                          |  277 +++
 include/hw/i3c/mock-i3c-target.h              |   52 +
 hw/i3c/aspeed_i3c.c                           |  261 +++
 hw/i3c/core.c                                 |  669 ++++++
 hw/i3c/dw-i3c.c                               | 1864 +++++++++++++++++
 hw/i3c/mock-i3c-target.c                      |  311 +++
 hw/misc/aspeed_i3c.c                          |  383 ----
 hw/Kconfig                                    |    1 +
 hw/arm/Kconfig                                |    3 +
 hw/i3c/Kconfig                                |   15 +
 hw/i3c/meson.build                            |    6 +
 hw/i3c/trace-events                           |   47 +
 hw/meson.build                                |    1 +
 hw/misc/meson.build                           |    1 -
 hw/misc/trace-events                          |    6 -
 .../functional/arm/test_aspeed_ast2600_sdk.py |   12 +
 21 files changed, 3730 insertions(+), 407 deletions(-)
 create mode 100644 hw/i3c/trace.h
 rename include/hw/{misc => i3c}/aspeed_i3c.h (63%)
 create mode 100644 include/hw/i3c/dw-i3c.h
 create mode 100644 include/hw/i3c/i3c.h
 create mode 100644 include/hw/i3c/mock-i3c-target.h
 create mode 100644 hw/i3c/aspeed_i3c.c
 create mode 100644 hw/i3c/core.c
 create mode 100644 hw/i3c/dw-i3c.c
 create mode 100644 hw/i3c/mock-i3c-target.c
 delete mode 100644 hw/misc/aspeed_i3c.c
 create mode 100644 hw/i3c/Kconfig
 create mode 100644 hw/i3c/meson.build
 create mode 100644 hw/i3c/trace-events

-- 
2.43.0


