Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F54C10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 20:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rziwr-0004J2-ET; Wed, 24 Apr 2024 16:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rziwJ-0003sp-Ct; Wed, 24 Apr 2024 16:10:00 -0400
Received: from zproxy3.enst.fr ([137.194.2.222])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rziw7-00010n-Q6; Wed, 24 Apr 2024 16:09:54 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 22D4FA07A4;
 Wed, 24 Apr 2024 22:09:38 +0200 (CEST)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id RIPrlfySDkIi; Wed, 24 Apr 2024 22:09:37 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 01D7FA07A3;
 Wed, 24 Apr 2024 22:09:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr 01D7FA07A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1713989377;
 bh=6FHgBZPyfb5RWYr02woys+s5PBCLH/D+EvcMKSccLm8=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=3yt/3KJ/zE8qwvKUXYfqaFiu15zjXCIe5zvae9Q0BOxG2jW6vBW+OX/+Pca/u6FV9
 w1S0BgpWNR5urVPCRp6od0cEcWTKGMPLZr5K2be4HBuDxPiqbULYCHJuyuud4IxR1l
 +FxVrtN2yRAXPtAttAI7I2szdTuE0X1KcVUutcDo=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id l-sewHOAit4c; Wed, 24 Apr 2024 22:09:36 +0200 (CEST)
Received: from inesv-Inspiron-3501.. (unknown
 [IPv6:2a02:1808:204:e56c:df60:5720:79e:c1dd])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id A8E05A0770;
 Wed, 24 Apr 2024 22:09:35 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Samuel Tardieu <sam@rfc1149.net>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v6 0/5] Add device DM163 (led driver,
 matrix colors shield & display)
Date: Wed, 24 Apr 2024 22:06:50 +0200
Message-ID: <20240424200929.240921-1-ines.varhol@telecom-paris.fr>
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

Thank you for the reviews.

Changes from v5 (1st commit) :
- use `extract16` and `deposit32` in `dm163_propagate_outputs` for
more clarity
- similarly, use `extract64` and `deposit32` in `dm163_bank(0|1)`

Changes from v4 :
dm163
- redefine `DM163_NUM_LEDS` for clarity
- change definition of `COLOR_BUFFER_SIZE`
- rename `age_of_row` to `row_persistance_delay`
- remove unnecessary QOM cast macro in GPIO handlers
- remove unnecessary inline of `dm163_bank0` and `dm163_bank1`
- replace occurrences of number 8 by the right define macro
- use unsigned type to print GPIO input `new_stateq`
STM32L4x5 qtests
- add comment to explain GPIO forwarding to SoC
B-L475E-IOT01A
- correct formatting
- use unsigned for gpio pins' indices
DM163 qtest
- use an enum for dm163 inputs
- inline ['dm163-test'] in meson.build (I don't plan on adding qtests)
OTHER
- update copyrights to 2023-2024

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
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

In=C3=A8s Varhol (5):
  hw/display : Add device DM163
  hw/arm : Pass STM32L4x5 SYSCFG gpios to STM32L4x5 SoC
  hw/arm : Create Bl475eMachineState
  hw/arm : Connect DM163 to B-L475E-IOT01A
  tests/qtest : Add testcase for DM163

 docs/system/arm/b-l475e-iot01a.rst  |   3 +-
 include/hw/display/dm163.h          |  59 +++++
 hw/arm/b-l475e-iot01a.c             | 105 +++++++--
 hw/arm/stm32l4x5_soc.c              |   6 +-
 hw/display/dm163.c                  | 349 ++++++++++++++++++++++++++++
 tests/qtest/dm163-test.c            | 194 ++++++++++++++++
 tests/qtest/stm32l4x5_gpio-test.c   |  13 +-
 tests/qtest/stm32l4x5_syscfg-test.c |  17 +-
 hw/arm/Kconfig                      |   1 +
 hw/display/Kconfig                  |   3 +
 hw/display/meson.build              |   1 +
 hw/display/trace-events             |  14 ++
 tests/qtest/meson.build             |   2 +
 13 files changed, 736 insertions(+), 31 deletions(-)
 create mode 100644 include/hw/display/dm163.h
 create mode 100644 hw/display/dm163.c
 create mode 100644 tests/qtest/dm163-test.c

--=20
2.43.2


