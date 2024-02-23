Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46E9C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 18:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdaWU-0005be-Jr; Fri, 23 Feb 2024 13:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rdaC4-0007f6-Qc; Fri, 23 Feb 2024 13:22:47 -0500
Received: from zproxy4.enst.fr ([2001:660:330f:2::df])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rdaC1-0002RQ-1I; Fri, 23 Feb 2024 13:22:42 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 4289120759;
 Fri, 23 Feb 2024 19:22:36 +0100 (CET)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id HiEGFlop6uYj; Fri, 23 Feb 2024 19:22:35 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 09D902073A;
 Fri, 23 Feb 2024 19:22:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr 09D902073A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1708712555;
 bh=r4DROEhiYxLGPNrdVokg8xjeEyMCgaMdYHuioHxgv1s=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=Qow+yfDpQnVhtfnCTp/eqVWFbAp6uj6nleZyxDf6A+dnm7eZfb027MQWNinkgF0Wv
 l/UKTErloGlvbAzkk6vOr7TwvrMiUOlxtWYwUS3eXhw3uEw0PYp3JQNhUMGFg8nZw3
 dk2+v/SBoRKrdS2C9ignUBCT1nhBS9tGmk4UPtTA=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id uiM3Biy5p8g9; Fri, 23 Feb 2024 19:22:34 +0100 (CET)
Received: from inesv-Inspiron-3501.lan (unknown
 [IPv6:2001:861:4680:b1b0:946f:f726:4968:ea36])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id 3366420697;
 Fri, 23 Feb 2024 19:22:34 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 0/3] Add device STM32L4x5 GPIO
Date: Fri, 23 Feb 2024 19:22:03 +0100
Message-ID: <20240223182229.293802-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::df;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy4.enst.fr
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

This patch adds a new device STM32L4x5 GPIO device and is part
of a series implementing the STM32L4x5 with a few peripherals.

Changes from v4 :
- gpio.c : use helpers `is_pull_up()`, `is_pull_down()`, `is_output()`
for more clarity
- gpio.c : correct `update_gpio_idr()` in case of open-drain pin
set to 1 in ODR and set to 0 externally
- gpio.c : rename `get_gpio_pins_to_disconnect()` to
`get_gpio_pinmask_to_disconnect()` and associated comments
- gpio.c : correct coding style issues (alignment and declaration)
- soc.c : unite structs `gpio_addr` and `stm32l4x5_gpio_initval`

Changes from v3 :
- replacing occurences of '16' with the correct macro `GPIO_NUM_PINS`
- updating copyright year
- rebasing on latest version of STM32L4x5 RCC

Changes from v2 :
- correct memory leaks caused by re-assigning a `g_autofree`
pointer without freeing it
- gpio-test : test that reset values (and not just initialization
values) are correct, correct `stm32l4x5_gpio_reset()` accordingly
- adding a `clock-freq-hz` object property to test that
enabling GPIO clock in RCC sets the GPIO clocks

Changes from v1 :
- replacing test GPIO register `DISCONNECTED_PINS` with an object
property accessed using `qtest_qmp()` in the qtest (through helpers
`get_disconnected_pins()` and `disconnect_all_pins()`)
- removing GPIO subclasses and storing MODER, OSPEEDR and PUPDR reset
values in properties
- adding a `name` property and using it for more lisible traces
- using `g_strdup_printf()` to facilitate setting irqs in the qtest,
and initializing GPIO children in soc_initfn

Changes from RFC v1 :
- `stm32l4x5-gpio-test.c` : correct typos, make the test generic,
add a test for bitwise writing in register ODR
- `stm32l4x5_soc.c` : connect gpios to their clock, use an
array of GpioState
- `stm32l4x5_gpio.c` : correct comments in `update_gpio_idr()`,
correct `get_gpio_pins_to_disconnect()`, correct `stm32l4x5_gpio_init()`
and initialize the clock, add a realize function
- update MAINAINERS

Based-on: 20240219200908.49551-1-arnaud.minier@telecom-paris.fr
([PATCH v5 0/8] Add device STM32L4x5 RCC)

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

In=C3=A8s Varhol (3):
  hw/gpio: Implement STM32L4x5 GPIO
  hw/arm: Connect STM32L4x5 GPIO to STM32L4x5 SoC
  tests/qtest: Add STM32L4x5 GPIO QTest testcase

 MAINTAINERS                        |   1 +
 docs/system/arm/b-l475e-iot01a.rst |   2 +-
 include/hw/arm/stm32l4x5_soc.h     |   2 +
 include/hw/gpio/stm32l4x5_gpio.h   |  70 ++++
 hw/arm/stm32l4x5_soc.c             |  68 +++-
 hw/gpio/stm32l4x5_gpio.c           | 477 +++++++++++++++++++++++
 tests/qtest/stm32l4x5_gpio-test.c  | 586 +++++++++++++++++++++++++++++
 hw/arm/Kconfig                     |   3 +-
 hw/gpio/Kconfig                    |   3 +
 hw/gpio/meson.build                |   1 +
 hw/gpio/trace-events               |   6 +
 tests/qtest/meson.build            |   3 +-
 12 files changed, 1205 insertions(+), 17 deletions(-)
 create mode 100644 include/hw/gpio/stm32l4x5_gpio.h
 create mode 100644 hw/gpio/stm32l4x5_gpio.c
 create mode 100644 tests/qtest/stm32l4x5_gpio-test.c

--=20
2.43.2


