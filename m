Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B839C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 21:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhbyE-0004JN-U1; Tue, 05 Mar 2024 16:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rhbyD-0004Io-6q; Tue, 05 Mar 2024 16:05:05 -0500
Received: from zproxy3.enst.fr ([137.194.2.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rhby7-0006f1-Pm; Tue, 05 Mar 2024 16:05:04 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 71F55A071C;
 Tue,  5 Mar 2024 22:04:55 +0100 (CET)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id ClLhn2JtVJh1; Tue,  5 Mar 2024 22:04:54 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id AC98DA06BB;
 Tue,  5 Mar 2024 22:04:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr AC98DA06BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1709672694;
 bh=39E3eNLaepdC//DrMaTEdG6VZWBd6x7zbsKWo9yygs0=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=iZbnQ4RrS086AbKMuZMjTWzBm77pgYV+ku5BRiinl3yndVDVprvX64ctuNkn6FDph
 b+F7gMMD3edAYECZEplom/ox5XMxf/tD5tzNl+WNbASNbrJHAASGhs9UTGxkVu6qIp
 4cF9ykshYLF87Lt+VzEfOMwU0Mw9yQZ7VjC1eGd4=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id ou3GhfQ59Wi2; Tue,  5 Mar 2024 22:04:54 +0100 (CET)
Received: from localhost.localdomain (74.0.125.80.rev.sfr.net [80.125.0.74])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id 172A3A06B5;
 Tue,  5 Mar 2024 22:04:54 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v7 0/3] Add device STM32L4x5 GPIO
Date: Tue,  5 Mar 2024 22:03:09 +0100
Message-ID: <20240305210444.310665-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.222;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy3.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Changes from v6 :
- rebasing on main
- removing QTest `clock_enable()` as it isn't actually a GPIO test

Changes from v5 :
- deduplicating macro constant `GPIO_NUM_PINS` that was defined both
in stm32l4x5_syscfg.h and stm32l4x5_gpio.h
- moving definition of constant `NUM_GPIOS` from syscfg.h to gpio.h
- soc.c : replacing a hardcoded 16 by the correct `GPIO_NUM_PINS`

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

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

In=C3=A8s Varhol (3):
  hw/gpio: Implement STM32L4x5 GPIO
  hw/arm: Connect STM32L4x5 GPIO to STM32L4x5 SoC
  tests/qtest: Add STM32L4x5 GPIO QTest testcase

 MAINTAINERS                        |   1 +
 docs/system/arm/b-l475e-iot01a.rst |   2 +-
 include/hw/arm/stm32l4x5_soc.h     |   2 +
 include/hw/gpio/stm32l4x5_gpio.h   |  71 ++++
 include/hw/misc/stm32l4x5_syscfg.h |   3 +-
 hw/arm/stm32l4x5_soc.c             |  71 +++-
 hw/gpio/stm32l4x5_gpio.c           | 477 +++++++++++++++++++++++++
 hw/misc/stm32l4x5_syscfg.c         |   1 +
 tests/qtest/stm32l4x5_gpio-test.c  | 551 +++++++++++++++++++++++++++++
 hw/arm/Kconfig                     |   3 +-
 hw/gpio/Kconfig                    |   3 +
 hw/gpio/meson.build                |   1 +
 hw/gpio/trace-events               |   6 +
 tests/qtest/meson.build            |   3 +-
 14 files changed, 1175 insertions(+), 20 deletions(-)
 create mode 100644 include/hw/gpio/stm32l4x5_gpio.h
 create mode 100644 hw/gpio/stm32l4x5_gpio.c
 create mode 100644 tests/qtest/stm32l4x5_gpio-test.c

--=20
2.43.2


