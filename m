Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766D4C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7sl-0003xF-Lc; Wed, 12 Aug 2026 08:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7sj-0003x4-NK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7sh-0008So-9g
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:29 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49978908b35so6608815e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786536985; x=1787141785; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=V0bbyYI9pNSObc+GLm2EhO/Goae+/oIbeAu+5FlcN3s=;
 b=yfpP6O3P8JainwovplKl6NXQT2pqDQtktgnfa9Dh544cwGUVdjWC+/fEdaRcebZYHT
 WR2b7w1A4iYbY9VwcR8fSTr3eYmuxNb/rbS3U9pMKys4NfqIFUDTUaXlvsV04/qlpgR0
 xCtNdoqmhnOfShcP29E7zJfb4hie0DL13AxZr0EG97aE804qDYBp3H86u3Zj/WwAU1Wc
 hIZczRGu4y9tJaBk8N0YUhPVZlje/4a0lTlytnOi85xz0CKwRJ7KVu7tN9Z0XuYnmEFk
 EaoR/J0Ibs7SIo9qB7v1kBakrX6THyymCrESgzPY/87hQq0AZnKHFAdWZomsUuicLZkx
 SphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536985; x=1787141785;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V0bbyYI9pNSObc+GLm2EhO/Goae+/oIbeAu+5FlcN3s=;
 b=l5AYLnrUQKvpncz8tVoNCi+48ibxZLmoyG7D1603gKyiHo45mGW32ikV1mpulhHXxh
 FAD42ZdF34kf5b9c+hKa0d+aLy7dFCTaqR70VBSbYT7DBGN+pLBu8wKEloy9ikx8TtzC
 fpaPvkFK+Z9D3ksbk2h3+PRFucEO1kKFNIQRed03zhI3RcmIg8ViSG8WDEdHie09AoEf
 IO1GkPq7+tiJRixWeyKSagTwza7fj+7bCaBkmX7CZWqM/nMADxj8R5QPmBUO5EJQ+d8Y
 /N3PnTmSrKPJ2O/+ah8mLsut/aM/uePPyzc55o1pj53lvDKTUqzO7HWOm4tEO49Bg88d
 4u+A==
X-Gm-Message-State: AOJu0YzDPsYkGV1TlYJ4Lu0iFLUuVRBm3o0HNWJchy5xzuS+i4z/FBII
 ZjcQMjKo9BgdslS3uYS0NO2upxgNJU+YKAljLD8zj/noEPR2SOyauyjuuRkkB6i8mIQyNdgJCto
 EwTxt
X-Gm-Gg: AR+sD11fwam0Yz6Kv2cd/7MgKM+qyHN5I6cv1AI5ZbCdskzdsDQ/Lg0HygoenVoPIRZ
 KlSOsZHbhcYpfVpqEVUbz1eNqRp6zIiJeJkQGz8Nr84yAODTufAVtP9BwBghfvtFFQ1Ta7/N6Ks
 peEiPXSfVwX33Hoq1DpUuDQO+xEVtLcj+qqVyQI4/waogrPZTkmLE1jKyTRl0lqYgIIqqd7RhOc
 q/fU1SOHvfja//+YYNPnf6VsHfZH9O0Gc8vtkK9mwyT4hc+FYcDt4ePqf0LWq7gMcGhSKiB0QJ0
 /c1uN2CeBWEfU6sTnaBmFdXW0C21brvv0Yzo5Xnx9yk1A8SZU3FoQqbToyWSziTdWi1plAvC8DS
 cmi+e/cvDn3v9vFZ7SfrZqGV99jh7fLrS3UMNoTtJq1tjA8amNbKiCAr4Y4NwSl5CU3AYPA+2aS
 hmDZeYt/STXCI7JmZsPcvk0lfhWAKgIlJkMsf9OVIzlR7QmUx29Lmu2kb3g+V91QjjcNBYuH6EM
 8VejlHyRwgDhX44oXeD7aKJ0HOuUlIzDHm1MQQU+nPc2tIkzgpN3Ruc04qbJd0NA7vFow==
X-Received: by 2002:a05:600c:8209:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-4997c12b341mr71416595e9.10.1786536985315; 
 Wed, 12 Aug 2026 05:16:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/26] target-arm queue
Date: Wed, 12 Aug 2026 13:15:56 +0100
Message-ID: <20260812121622.649730-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi; here's the first arm pullreq for 11.2; contains one new
board model, emulation of another SME feature, and various
bugfixes.

thanks
-- PMM

The following changes since commit e8d693e12af9cbb89d724baadfcc08559669e279:

  tests/qtest: Do not use versioned pc-q35-5.2 machine anymore (2026-08-11 16:12:34 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260812

for you to fetch changes up to 49aecf39008ebeb86127b5055cefa17d68370b20:

  tests/functional/aarch64: add raspi4b full-RAM regression test (2026-08-12 11:41:56 +0100)

----------------------------------------------------------------
target-arm queue:
 * Implement emulation of FEAT_SME_TMOP
 * New board model: Axiado EVK SCM3003
 * Fix various minor bugs in mps3-an547 model
 * hw/i2c/bcm2835_i2c: Correct iomem size
 * hw/misc/bcm2835_powermgt: implement a real watchdog timer
 * hw/arm/raspi4b: fix guest never seeing more than ~1 GiB of RAM

----------------------------------------------------------------
Kuan-Jui Chiu (8):
      hw/arm: Add Axiado SoC AX3000
      hw/misc: Add AX3000 clock control
      hw/arm: ax3000-soc: Enable Ax3000 clock control
      hw/sd: Add Axiado SD host controller with eMMC PHY
      hw/arm: ax3000-soc: Enable Axiado SD host controller
      hw/arm: Add Axiado EVK SCM3003
      hw/gpio: Add Cadence GPIO controller
      hw/arm: ax3000-soc: Enable Cadence GPIO controllers

Marcelo Manzo (3):
      hw/misc/bcm2835_powermgt: implement a real watchdog timer
      hw/arm/raspi4b: fix guest never seeing more than ~1 GiB of RAM
      tests/functional/aarch64: add raspi4b full-RAM regression test

Richard Henderson (10):
      target/arm: Implement FTMOPA (non-widening, FP32)
      target/arm: Implement FTMOPA (non-widening, FP16)
      target/arm: Implement BFTMOPA (non-widening)
      target/arm: Implement BFTMOPA (widening)
      target/arm: Implement FTMOPA (widening, 2-way, FP16 to FP32)
      target/arm: Implement FTMOPA (widening, 2-way, FP8 to FP16)
      target/arm: Implement FTMOPA (widening, 4-way, FP8 to FP32)
      target/arm: Implement [SU]TMOPA (2-way)
      target/arm: Implement {S,SU,US,U}TMOPA (4-way)
      target/arm: Enable FEAT_SME_TMOP for -cpu max

Simon Xu (4):
      hw/arm/armsse.c: fix SSE-300 s32kwatchdog address
      hw/arm/armsse.c: fix SSE-300 PPU addresses
      hw/arm/mps2-tz.c: fix AN547 APB PPC EXP0 MPC ports
      hw/arm/mps2-tz.c: add AN547 AHB PPC EXP1 DMA ports

botszhuang (1):
      hw/i2c/bcm2835_i2c: Correct iomem size

 MAINTAINERS                             |   9 +
 docs/system/arm/emulation.rst           |   1 +
 hw/arm/Kconfig                          |  15 ++
 hw/arm/armsse.c                         |   8 +-
 hw/arm/ax3000-boards.c                  |  56 ++++++
 hw/arm/ax3000-evk.c                     |  27 +++
 hw/arm/ax3000-soc.c                     | 242 ++++++++++++++++++++++++++
 hw/arm/meson.build                      |   6 +
 hw/arm/mps2-tz.c                        |  21 +++
 hw/arm/raspi4b.c                        |   2 +-
 hw/gpio/Kconfig                         |   3 +
 hw/gpio/cadence_gpio.c                  | 292 ++++++++++++++++++++++++++++++++
 hw/gpio/meson.build                     |   1 +
 hw/gpio/trace-events                    |   5 +
 hw/i2c/bcm2835_i2c.c                    |   2 +-
 hw/misc/Kconfig                         |   3 +
 hw/misc/axiado_clk.c                    |  79 +++++++++
 hw/misc/bcm2835_powermgt.c              |  53 ++++--
 hw/misc/meson.build                     |   3 +
 hw/sd/Kconfig                           |   4 +
 hw/sd/axiado_sdhci.c                    | 119 +++++++++++++
 hw/sd/meson.build                       |   1 +
 include/hw/arm/ax3000-boards.h          |  28 +++
 include/hw/arm/ax3000-soc.h             |  98 +++++++++++
 include/hw/gpio/cadence_gpio.h          |  53 ++++++
 include/hw/misc/axiado_clk.h            |  26 +++
 include/hw/misc/bcm2835_powermgt.h      |   2 +
 include/hw/sd/axiado_sdhci.h            |  21 +++
 linux-user/aarch64/elfload.c            |   1 +
 target/arm/cpu-features.h               |  25 +++
 target/arm/tcg/cpu64.c                  |   3 +-
 target/arm/tcg/fp8_helper.c             |  50 ++++++
 target/arm/tcg/helper-fp8-defs.h        |   3 +
 target/arm/tcg/helper-sme-defs.h        |  15 ++
 target/arm/tcg/sme.decode               |  28 +++
 target/arm/tcg/sme_helper.c             | 191 +++++++++++++++++++++
 target/arm/tcg/translate-sme.c          |  79 +++++++++
 target/arm/tcg/vec_internal.h           |   7 +
 tests/functional/aarch64/test_raspi4.py |  17 ++
 39 files changed, 1579 insertions(+), 20 deletions(-)
 create mode 100644 hw/arm/ax3000-boards.c
 create mode 100644 hw/arm/ax3000-evk.c
 create mode 100644 hw/arm/ax3000-soc.c
 create mode 100644 hw/gpio/cadence_gpio.c
 create mode 100644 hw/misc/axiado_clk.c
 create mode 100644 hw/sd/axiado_sdhci.c
 create mode 100644 include/hw/arm/ax3000-boards.h
 create mode 100644 include/hw/arm/ax3000-soc.h
 create mode 100644 include/hw/gpio/cadence_gpio.h
 create mode 100644 include/hw/misc/axiado_clk.h
 create mode 100644 include/hw/sd/axiado_sdhci.h

