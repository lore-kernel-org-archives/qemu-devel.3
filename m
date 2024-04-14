Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3E3C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2024 13:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvzZ5-0007n3-GQ; Sun, 14 Apr 2024 09:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rvzYz-0007jg-Se; Sun, 14 Apr 2024 09:06:31 -0400
Received: from zproxy1.enst.fr ([2001:660:330f:2::dc])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rvzYv-0007Ej-VX; Sun, 14 Apr 2024 09:06:29 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id B0B47C0597;
 Sun, 14 Apr 2024 15:06:16 +0200 (CEST)
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id ht2dkR9raFeQ; Sun, 14 Apr 2024 15:06:16 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id D7CAAC056E;
 Sun, 14 Apr 2024 15:06:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy1.enst.fr D7CAAC056E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1713099975;
 bh=cNpqKFER9jnWsH0Q2W3tpKRu4gLrO31N/REsoiWp5yo=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=L4BFC17c/zHs+epqzVanuOmFSax9nG4btZiUPbGeIO7OPru3F2ZWeo+K7EGMMEft/
 Kb9aOuUR9EU06+dvKqkcOw4LACnoJnCO02g95cNUj4tXE66fb/D/FnLx68HcyUaTHT
 6NpmNhPx38khcSm2Kq9n0eRzRZ/RnVvae8fAw+Zs=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id 56-Zgkwo8eKL; Sun, 14 Apr 2024 15:06:15 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy1.enst.fr (Postfix) with ESMTPSA id ACA13C0544;
 Sun, 14 Apr 2024 15:06:14 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Samuel Tardieu <sam@rfc1149.net>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v4 0/5] Add device DM163 (led driver,
 matrix colors shield & display)
Date: Sun, 14 Apr 2024 15:05:43 +0200
Message-ID: <20240414130604.182059-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::dc;
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

This device implements the IM120417002 colors shield v1.1 for Arduino
(which relies on the DM163 8x3-channel led driving logic) and features
a simple display of an 8x8 RGB matrix. This color shield can be plugged
on the Arduino board (or the B-L475E-IOT01A board) to drive an 8x8
RGB led matrix. This RGB led matrix takes advantage of retinal persistanc=
e
to seemingly display different colors in each row.

Hello,

I have been very busy this last month, sorry for the delay.
In a later version, I will add a more thorough test like suggested by
Thomas Huth (thank you for the examples, I will look into it).

Following the response of Peter Maydell about the SYSCFG export at
STM32L4x5 level, I'm thinking of moving the STM32L4x5 GPIO output
splitters from the Bl475e machine to the STM32L4x5 SOC code.

In the current code, the GPIO output splitters are created in the
Bl475e machine and the machine has to wire some of these splitted
outputs to SYSCFG inputs. SYSCFG inputs are exported at SOC level
to facilitate this.

By moving the splitters inside the STM32L4x5 SOC, the SOC could
export GPIO I/O instead of SYSCFG I/O which would be closer to
the hardware, and the Bl475e machine would directly connect the
DM163 to GPIO outputs.

Changes from v3 (review of the 1st commit by Peter Maydell) :
- dm163.c : instead of redrawing the entire console each frame,
only redraw the rows that changed using a new variable `redraw`
- reset all the fields in `dm163_reset_hold`
- correcting typos : persistance -> persistence
- b-l475e-iot01a.rst : correcting typo

Changes from v2 : Corrected typo in the Based-on message id

Changes from v1 :
- moving the DM163 from the SoC to the B-L475E-IOT01A machine
(changing config files and tests accordingly)
- restricting DM163 test to ARM & DM163 availability
- using `object_class_by_name()` to check for DM163 presence at run-time
- exporting SYSCFG inputs to the SoC (and adapting tests accordingly)

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

In=C3=A8s Varhol (5):
  hw/display : Add device DM163
  hw/arm : Pass STM32L4x5 SYSCFG gpios to STM32L4x5 SoC
  hw/arm : Create Bl475eMachineState
  hw/arm : Connect DM163 to B-L475E-IOT01A
  tests/qtest : Add testcase for DM163

 docs/system/arm/b-l475e-iot01a.rst  |   3 +-
 include/hw/display/dm163.h          |  58 +++++
 hw/arm/b-l475e-iot01a.c             | 103 +++++++--
 hw/arm/stm32l4x5_soc.c              |   6 +-
 hw/display/dm163.c                  | 333 ++++++++++++++++++++++++++++
 tests/qtest/dm163-test.c            | 192 ++++++++++++++++
 tests/qtest/stm32l4x5_gpio-test.c   |  12 +-
 tests/qtest/stm32l4x5_syscfg-test.c |  16 +-
 hw/arm/Kconfig                      |   1 +
 hw/display/Kconfig                  |   3 +
 hw/display/meson.build              |   1 +
 hw/display/trace-events             |  14 ++
 tests/qtest/meson.build             |   5 +
 13 files changed, 717 insertions(+), 30 deletions(-)
 create mode 100644 include/hw/display/dm163.h
 create mode 100644 hw/display/dm163.c
 create mode 100644 tests/qtest/dm163-test.c

--=20
2.43.2


