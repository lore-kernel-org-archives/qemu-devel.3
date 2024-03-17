Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425DDC54E67
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 10:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlnw1-0001iX-EU; Sun, 17 Mar 2024 06:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rlnvw-0001hE-Eh; Sun, 17 Mar 2024 06:40:05 -0400
Received: from zproxy3.enst.fr ([137.194.2.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rlnvu-00010j-K9; Sun, 17 Mar 2024 06:40:04 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 84252A0827;
 Sun, 17 Mar 2024 11:39:57 +0100 (CET)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id 1cSBO9789QeT; Sun, 17 Mar 2024 11:39:56 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id A9C8BA06DC;
 Sun, 17 Mar 2024 11:39:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr A9C8BA06DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1710671996;
 bh=PVbg4h2Ep7KjtMlth6qeiK//rO7MmAT3DS1YLuriplw=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=AKT3uRCD2TkYrwCJsoOk9py+KA03cDk127mCQxmTTivknR7VavuapdbZOcHvOGqk2
 HvGkiB88ZEXe5/yPgAGG+kllUkPcHBIU1oWMt6u0vRMFoHWR/Cy17i5345BuZJnKtS
 Ht5oHMjLyWix8nGHQCyjOOXnqZtAP2pYe2x0zmHY=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id 8n8FeNZ7K_-Z; Sun, 17 Mar 2024 11:39:56 +0100 (CET)
Received: from AM-Inspiron-3585.. (cust-west-par-46-193-4-103.cust.wifirst.net
 [46.193.4.103])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id F1C09A077D;
 Sun, 17 Mar 2024 11:39:55 +0100 (CET)
From: Arnaud Minier <arnaud.minier@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>
Subject: [PATCH 0/7] hw/char: Implement the STM32L4x5 USART, UART and LPUART
Date: Sun, 17 Mar 2024 11:39:11 +0100
Message-Id: <20240317103918.44375-1-arnaud.minier@telecom-paris.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.222;
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

This patch adds the STM32L4x5 USART (Universal Synchronous/Asynchronous R=
eceiver/Transmitter)
device and is part of a series implementing the STM32L4x5 with a few peri=
pherals.

It implements the necessary functionalities to receive/send characters ov=
er the serial port, which
are useful to communicate with the program currently running.

Arnaud Minier (7):
  hw/misc/stm32l4x5_rcc: Propagate period when enabling a clock
  hw/char: Implement STM32L4x5 USART skeleton
  hw/char/stm32l4x5_usart: Add USART, UART, LPUART types
  hw/char/stm32l4x5_usart: Enable serial read and write
  hw/char/stm32l4x5_usart: Add options for serial parameters setting
  hw/arm: Add the USART to the stm32l4x5 SoC
  tests/qtest: Add tests for the STM32L4x5 USART

 MAINTAINERS                        |   1 +
 docs/system/arm/b-l475e-iot01a.rst |   2 +-
 hw/arm/Kconfig                     |   1 +
 hw/arm/stm32l4x5_soc.c             |  88 ++++-
 hw/char/Kconfig                    |   3 +
 hw/char/meson.build                |   1 +
 hw/char/stm32l4x5_usart.c          | 597 +++++++++++++++++++++++++++++
 hw/char/trace-events               |  11 +
 hw/misc/stm32l4x5_rcc.c            |   7 +-
 include/hw/arm/stm32l4x5_soc.h     |  13 +
 include/hw/char/stm32l4x5_usart.h  |  66 ++++
 tests/qtest/meson.build            |   3 +-
 tests/qtest/stm32l4x5_usart-test.c | 399 +++++++++++++++++++
 13 files changed, 1182 insertions(+), 10 deletions(-)
 create mode 100644 hw/char/stm32l4x5_usart.c
 create mode 100644 include/hw/char/stm32l4x5_usart.h
 create mode 100644 tests/qtest/stm32l4x5_usart-test.c

--=20
2.34.1


