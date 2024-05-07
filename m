Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2E8C25B5F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 19:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Q20-0008Ga-5X; Tue, 07 May 2024 14:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s4Q1w-0008BT-6c; Tue, 07 May 2024 14:59:12 -0400
Received: from zproxy1.enst.fr ([137.194.2.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s4Q1t-0006A2-LS; Tue, 07 May 2024 14:59:11 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 9DF11C0588;
 Tue,  7 May 2024 20:59:03 +0200 (CEST)
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id HLNQxTVh1GQ0; Tue,  7 May 2024 20:59:03 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 2791FC0D05;
 Tue,  7 May 2024 20:59:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy1.enst.fr 2791FC0D05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1715108343;
 bh=J8aP9fhelT/d154OZawuXtJOGh0PzL+Rwts8IZYUaWs=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=Du7CRNCD+JsBuyVjSp0l/83p2Mx4vg1fqR+eBSkYn/TPGmLtrLB1CLE6seojq7wBx
 0b1KZqxbmXONnTRYqarIi0gKAaGbm6ykY4Ge8Th4kZs8HHfaN/HA1v1pIs9UKfoAPm
 dHCEKGkzskYBkrNsDZsl554YlXGHVyR6F6wGr50w=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id hibf2R4nwdOi; Tue,  7 May 2024 20:59:03 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy1.enst.fr (Postfix) with ESMTPSA id DC0DEC0588;
 Tue,  7 May 2024 20:59:00 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/4] Check clock connection between STM32L4x5 RCC and
 peripherals
Date: Tue,  7 May 2024 20:55:37 +0200
Message-ID: <20240507185854.34572-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.220;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy1.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Among implemented STM32L4x5 devices, USART, GPIO and SYSCFG
have a clock source, but none has a corresponding test in QEMU.

This patch makes sure that all 3 devices create a clock,
have a QOM property to access the clock frequency,
and adds QTests checking that clock enable in RCC has the
expected results.

Philippe Mathieu-Daud=C3=A9 suggested the following :
".. We could add the clock properties
directly in qdev_init_clock_in(). Seems useful for the QTest
framework."

However Peter Maydell pointed out the following :
"...Mostly "frequency" properties on devices are for the case
where they *don't* have a Clock input and instead have
ad-hoc legacy handling where the board/SoC that creates the
device sets an integer property to define the input frequency
because it doesn't model the clock tree with Clock objects."

You both agree on the fact that replicating the code in the
different devices is a bad idea, what should be the
alternative?

Thank you for the reviews.

Changes from v1:
- upgrading `VMStateDescription` to version 2 to account for
`VMSTATE_CLOCK()`
- QTests : consolidating `get_clock_freq_hz()` in a header
and making appropriate changes in stm32l4x5q_*-test.c

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

In=C3=A8s Varhol (4):
  hw/misc: Create STM32L4x5 SYSCFG clock
  hw/gpio: Handle clock migration in STM32L4x5 gpios
  hw/char: Add QOM property for STM32L4x5 USART clock frequency
  tests/qtest: Check STM32L4x5 clock connections

 include/hw/misc/stm32l4x5_syscfg.h  |  1 +
 tests/qtest/stm32l4x5.h             | 40 +++++++++++++++++++++++++++++
 hw/arm/stm32l4x5_soc.c              |  2 ++
 hw/char/stm32l4x5_usart.c           | 16 ++++++++++--
 hw/gpio/stm32l4x5_gpio.c            |  6 +++--
 hw/misc/stm32l4x5_syscfg.c          | 30 ++++++++++++++++++++--
 tests/qtest/stm32l4x5_gpio-test.c   | 23 +++++++++++++++++
 tests/qtest/stm32l4x5_syscfg-test.c | 19 ++++++++++++--
 tests/qtest/stm32l4x5_usart-test.c  | 26 +++++++++++++++++++
 9 files changed, 155 insertions(+), 8 deletions(-)
 create mode 100644 tests/qtest/stm32l4x5.h

--=20
2.43.2


