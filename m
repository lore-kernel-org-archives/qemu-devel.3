Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793D0C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwlQr-0005Tx-Sl; Wed, 19 Aug 2026 14:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwlQp-0005Sq-Sg
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:54:35 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwlQn-0007N6-VK
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:54:35 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so914143f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 11:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787165672; x=1787770472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QSVy3FFPhYcWcnpEB/VkVTt644g8l6UF1uwbsqMi7cs=;
 b=JVN4+sIs9YZVpok5QiPx4qHUTVmvLfwyyNTbS7/MoeG4JcuztLaSPz4m3zV+U6Ywjh
 ENOjIzlFvF57NXZWdkaIryt7O74JcVD0soZePkyosRCtbmq1iNNRO/A/SG5XY8Gm/1yd
 Qs8Ehp4iunBZw9xO78hSKnm8arK+0E6N5ucIXDs5iqmH7cgFXIIPYHiPl5lSLTDeBEmT
 OpMaQHfUMt0TCeVJYL4grUk5smEeIFnvPKUDGMNswZeRK6MvSZz4jUn0qdNXZducgH/S
 Q4evGg6bZRYNMvb1q6/QRX8MS/MJLXZH5jweEEmNVp+v+wNr6SDoo95nepE1vWwlwgqm
 Z9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787165672; x=1787770472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QSVy3FFPhYcWcnpEB/VkVTt644g8l6UF1uwbsqMi7cs=;
 b=Q+sdurgh3DcYqqArWYM8sunOwhRojDza/TDS6OPyI/m1/mVlbK+Eqj8xvAy1ueCsX/
 7FIW2mIFto3Um9/Wq4VgISZxr/KoZtglnweqMP1Fo3gEqC5LrwNvWE2pTpmB/mVz+pH0
 rhf+xpKICg1kcZ6UNp/yl9a8Y9BHpm5AAuKbqGf0UfNGYZtw8MyE+zMBaZTYY9pyYAEy
 989MzCANayqQ0Hcrh8ysMkR4L33+EN5C474E7jrk9joHrb+3DvZcH5TjnCMAPjRXhOMT
 HLpki474o0i7+l+b4hDNP84DgAI0gHAA/fjZIwYlKQH5X517nkCuivgDn3Tzequpe6Nf
 sX5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RozDr8XCppks8F7Y58QaH0AOSUMz9VneLhq3vbeo8fktSvtZIIAkfWOIzsE2+sx+MzuBTBeIYMkCdrX@nongnu.org
X-Gm-Message-State: AFuF++meyspE1ES1BgvDS5cK0QOW2Ukeo+EslDBkAjsyiSDwhwDsL6oZ
 YUE4gm9zgQgEhU2BAy2iFav3V+u68q3Exu35ZBcZa/RblVOcEetSIhohFS/USrkUAGk=
X-Gm-Gg: AR+sD11qVeHaiLu+ykg6LdZnrauagfscCL3HezwTKOvpyNlptlZTLgcV+p0GKdp6ZaD
 cz+xrbivzYqRSzd+94Lfar5Zo0A4LvmpyQvBBeEKEAMAu0jkTd1qsvR1dcKia5i+BIinmCfC4C+
 27vXKC+j6AhYH2JGdnDFAmpytKCsbaqU9J2LtQdX0ftVwF2hNb6YJo8N2Ne5uVX7/wwUyLeYZz2
 gBeqdsypfL2thCT1OzGK2Res1vpcb7tOJ1FH7n+zPpS59W/mzqDMpwd7UU6rblBD3BfWUBZPTjK
 ggDj5PGws2zNLSfsgyELrY9kkSs0G8U0T5H0yQZtkOaUYhESrZQKwZ4IuFnIp50WU11Tthqb+Y5
 tCwuuNtLvb2JXRblh27UvzGjbOSbcGcVUGKRO2lTEfS+OGon3a5MHg5r0pTzOHp6lkhsnnTaQDd
 B1f1q+6ax/a1zz1P6KnifRpBCn7r4eW+L33z7B/yb+qySbkNFcve9kZP+2SRC93epWbTHrnGAH/
 OXT9QoMTw5jpNCdA3xUeP7PQvt3qshZXAITj2cUgmgiAqhURjCoQkJlSQ21sKC02Y4B2A==
X-Received: by 2002:a5d:5f8c:0:b0:47f:93e4:5389 with SMTP id
 ffacd0b85a97d-482b1fecd3fmr13852768f8f.20.1787165672070; 
 Wed, 19 Aug 2026 11:54:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b145c9d7sm7995048f8f.15.2026.08.19.11.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 11:54:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH 0/5] arm: Remove the 'musicpal' machine
Date: Wed, 19 Aug 2026 19:54:25 +0100
Message-ID: <20260819185430.3467629-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The 'musicpal' machine emulates the Freecom MusicPal, which was an
"internet radio" released in the mid-2000s.  The stock system used a
2.6.16 Linux kernel, but as far as I'm aware, support for the
hardware was never upstreamed to the mainline kernel.

There are a number of reasons for deprecating this board:
 * The hardware is now solidly obsolete
 * It was never supported in mainline Linux
 * The SoC is a Marvell one with no public datasheet
 * The only QEMU changes to it have been the usual tree wide
   updates and refactoring work
 * We have no test image for it that we can distribute
 * The only bug report we've ever had about it has been one of
   the usual "bug found by static analysis" kind (#4135)

But in fact we can just drop it immediately, because in commit
59754f85ed35 ("target/arm: Do memory type alignment check when
translation disabled") in 2024 we broke the boot of the standard
firmware image for this board.  (The image's u-boot does a LDRH to an
unaligned address, which is UNPREDICTABLE; we used to let it through,
but that commit makes it take a Data Abort, so the image crashes
before it boots the kernel.) Since nobody complained, we can deduce
that nobody's actually using this machine.

This patchset first fixes up a couple of places (notably the
pflash_cfi02 tests) that were using or referring to the musicpal
board; then it removes the board, followed by the devices used only by
that board.

Strictly speaking it's possible that somebody is using this machine
with some other image that doesn't have the same "does an unaligned
LDRH" problem the stock firmware image does; but it seems unlikely
to me. We can take the standard "deprecate for two releases, then
drop" route if people prefer that.

I do also have a patch which reverts the "take a Data Abort on
unaligned access" change for v5 and v6-with-SCTLR.U=0 CPUs, which I'll
post separately.

thanks
-- PMM

Peter Maydell (5):
  tests/qtest/pflash-cfi02-test: Don't use musicpal machine for testing
  hw/arm: Remove spurious WM8750 dependency from Realview Kconfig
  hw/arm: Remove the 'musicpal' machine
  hw: Remove Marvell 88W8618 devices
  hw/audio: Remove wm8750 I2C audio device

 MAINTAINERS                             |   10 -
 configs/devices/arm-softmmu/default.mak |    1 -
 docs/about/removed-features.rst         |   10 +
 docs/system/arm/musicpal.rst            |   19 -
 docs/system/target-arm.rst              |    1 -
 hw/arm/Kconfig                          |   16 -
 hw/arm/meson.build                      |    1 -
 hw/arm/musicpal.c                       | 1388 -----------------------
 hw/audio/Kconfig                        |    4 -
 hw/audio/marvell_88w8618.c              |  315 -----
 hw/audio/meson.build                    |    2 -
 hw/audio/wm8750.c                       |  738 ------------
 hw/net/meson.build                      |    1 -
 hw/net/mv88w8618_eth.c                  |  403 -------
 include/hw/audio/wm8750.h               |   30 -
 include/hw/net/mv88w8618_eth.h          |   13 -
 tests/qtest/meson.build                 |    6 +-
 tests/qtest/pflash-cfi02-test.c         |   38 +-
 18 files changed, 36 insertions(+), 2960 deletions(-)
 delete mode 100644 docs/system/arm/musicpal.rst
 delete mode 100644 hw/arm/musicpal.c
 delete mode 100644 hw/audio/marvell_88w8618.c
 delete mode 100644 hw/audio/wm8750.c
 delete mode 100644 hw/net/mv88w8618_eth.c
 delete mode 100644 include/hw/audio/wm8750.h
 delete mode 100644 include/hw/net/mv88w8618_eth.h

-- 
2.43.0


