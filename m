Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B69BC5475B
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 14:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgmVJ-0000b2-59; Sun, 03 Mar 2024 09:07:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rgmVH-0000an-PU; Sun, 03 Mar 2024 09:07:47 -0500
Received: from zproxy3.enst.fr ([2001:660:330f:2::de])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rgmV7-0003XH-KH; Sun, 03 Mar 2024 09:07:47 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 907D9A0583;
 Sun,  3 Mar 2024 15:07:31 +0100 (CET)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id rxJOamnvNq2N; Sun,  3 Mar 2024 15:07:30 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id A8546A0640;
 Sun,  3 Mar 2024 15:07:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr A8546A0640
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1709474850;
 bh=EJH7V7xh50L/PFhx3+GMtyin5xC7Jbjm7Btp4gL7ysc=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=nv86PZTtSwgI1zDT/S6+s1SCKipfoXbWyeRvp2ownNdThwUWDkkNfA3LJP6zNdHWm
 IfNj4MaYJeuy/mCD2EN+uURkYVlNjjE1yPNqGORIlNnUjP6uO1wJ9FJN7K+C8lA3hp
 NZjbMKizh7wVNZivE2CvQGR3BxMrdG2F1zIgEMZI=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id dvHArPIKiFw0; Sun,  3 Mar 2024 15:07:30 +0100 (CET)
Received: from AM-Inspiron-3585.. (cust-west-par-46-193-4-103.cust.wifirst.net
 [46.193.4.103])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id 2A63BA0583;
 Sun,  3 Mar 2024 15:07:30 +0100 (CET)
From: Arnaud Minier <arnaud.minier@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 0/8] Add device STM32L4x5 RCC
Date: Sun,  3 Mar 2024 15:06:35 +0100
Message-Id: <20240303140643.81957-1-arnaud.minier@telecom-paris.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::de;
 envelope-from=arnaud.minier@telecom-paris.fr; helo=zproxy3.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch adds the STM32L4x5 RCC (Reset and Clock Control) device and is=
 part
of a series implementing the STM32L4x5 with a few peripherals.

Due to the high number of lines, I tried to split the patch into several =
independent commits.
Each commit compiles on its own but I had to add temporary workarounds in=
 intermediary commits to allow them to compile even if some functions are=
 not used. However, they have been removed once the functions were used. =
Tell me if this is ok or if I should remove them.

Also, the tests are not very exhaustive for the moment. I have not found =
a way to test the clocks' frequency from the qtests, which limits severel=
y the exhaustiveness of the tests.

Thanks to Philippe Mathieu-Daud=C3=A9 and Luc Michel for guiding me towar=
d the hw/misc/bcm2835_cprman.c implementation and answering my questions =
about clock emulation in qemu !

Changes from v1 to v2:
- Removed a mention in the tests
- Added an early return to prevent a clang compilation error in rcc_updat=
e_pllsaixcfgr()

Changes from v2 to v3:
- Changed the timeout method used in the tests
- Added a real value for ICSR register
- Replaced some TODOs with correct error handling
- Added a commit that implements correct write protections for the CR reg=
ister

Changes from v3 to v4:
- Rebased on top of current master
- Implemented reset functions for the multiplexers and the PLLs
- Added explanatory messages to every commit
- Addded logs for unimplemented registers
- Completed the VMState for the multiplexers and the PLLs

Changes from v4 to v5:
- Abort when trying to set an out-of-bound pll vco multiplier

Changes from v5 to v6:
- Handle three phases reset for ClockMuxes and PLLs
- Use FIELD_EX32 macro instead of a custom one
- Remove useless "" from trace functions
- Remove waiting functions in tests
- Added access sizes for the RCC
- Use clock_update() instead of clock_update_hz() where appropriate

Arnaud Minier (8):
  hw/misc/stm32l4x5_rcc: Implement STM32L4x5_RCC skeleton
  hw/misc/stm32l4x5_rcc: Add an internal clock multiplexer object
  hw/misc/stm32l4x5_rcc: Add an internal PLL Clock object
  hw/misc/stm32l4x5_rcc: Initialize PLLs and clock multiplexers
  hw/misc/stm32l4x5_rcc: Handle Register Updates
  hw/misc/stm32l4x5_rcc: Add write protections to CR register
  hw/arm/stm32l4x5_soc.c: Use the RCC Sysclk
  tests/qtest/stm32l4x5_rcc-test.c: Add tests for the STM32L4x5_RCC

 MAINTAINERS                               |    5 +-
 docs/system/arm/b-l475e-iot01a.rst        |    2 +-
 hw/arm/Kconfig                            |    1 +
 hw/arm/b-l475e-iot01a.c                   |   10 +-
 hw/arm/stm32l4x5_soc.c                    |   45 +-
 hw/misc/Kconfig                           |    3 +
 hw/misc/meson.build                       |    1 +
 hw/misc/stm32l4x5_rcc.c                   | 1457 +++++++++++++++++++++
 hw/misc/trace-events                      |   14 +
 include/hw/arm/stm32l4x5_soc.h            |    5 +-
 include/hw/misc/stm32l4x5_rcc.h           |  239 ++++
 include/hw/misc/stm32l4x5_rcc_internals.h | 1042 +++++++++++++++
 tests/qtest/meson.build                   |    3 +-
 tests/qtest/stm32l4x5_rcc-test.c          |  189 +++
 14 files changed, 2971 insertions(+), 45 deletions(-)
 create mode 100644 hw/misc/stm32l4x5_rcc.c
 create mode 100644 include/hw/misc/stm32l4x5_rcc.h
 create mode 100644 include/hw/misc/stm32l4x5_rcc_internals.h
 create mode 100644 tests/qtest/stm32l4x5_rcc-test.c

--=20
2.34.1


