Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB52DC4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 14:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3cVY-0005yQ-Jd; Sun, 05 May 2024 10:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s3cVK-0005st-Jd; Sun, 05 May 2024 10:06:14 -0400
Received: from zproxy3.enst.fr ([2001:660:330f:2::de])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s3cVH-00085r-6o; Sun, 05 May 2024 10:06:14 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 020B2A06D1;
 Sun,  5 May 2024 16:06:05 +0200 (CEST)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id p6NQmIDLIzPa; Sun,  5 May 2024 16:06:03 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id A9015A071D;
 Sun,  5 May 2024 16:06:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr A9015A071D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1714917963;
 bh=qAlE5QPI66dGYCPvqGr4KsCiDSq01Cb/lt17ihnR+Rc=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=kmExyrL/nonr5Ys+EV+9oXa3r4MronKQq2s9u+G6joc/RJcXj82zSNLtPK7rYRbfB
 h/uk9CWQvsPbO8kTbXKMZrmBWQ9cSaLU8rv8VuKubIcJayf2ncOLWB0NCfiE5/bB2B
 MDxrN82ErCNBcFy3PtF1OFNr4jYuKcPaNAd1iuTs=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id cg-__zWAGrqB; Sun,  5 May 2024 16:06:03 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id 95F55A06B6;
 Sun,  5 May 2024 16:06:02 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/4] Check clock connection between STM32L4x5 RCC and
 peripherals
Date: Sun,  5 May 2024 16:05:02 +0200
Message-ID: <20240505140556.373711-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::de;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy3.enst.fr
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

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

In=C3=A8s Varhol (4):
  hw/misc: Create STM32L4x5 SYSCFG clock
  hw/gpio: Handle clock migration in STM32L4x5 gpios
  hw/char: Add QOM property for STM32L4x5 USART clock frequency
  tests/qtest: Check STM32L4x5 clock connections

 include/hw/misc/stm32l4x5_syscfg.h  |  1 +
 hw/arm/stm32l4x5_soc.c              |  2 ++
 hw/char/stm32l4x5_usart.c           | 12 ++++++++
 hw/gpio/stm32l4x5_gpio.c            |  2 ++
 hw/misc/stm32l4x5_syscfg.c          | 26 ++++++++++++++++
 tests/qtest/stm32l4x5_gpio-test.c   | 39 +++++++++++++++++++++++
 tests/qtest/stm32l4x5_syscfg-test.c | 38 +++++++++++++++++++++--
 tests/qtest/stm32l4x5_usart-test.c  | 48 +++++++++++++++++++++++++++++
 8 files changed, 166 insertions(+), 2 deletions(-)

--=20
2.43.2


