Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AEACFC286
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ewU-0006cr-2u; Tue, 15 Oct 2024 06:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewQ-0006bx-SI
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:14 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewO-0005vL-Jq
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:14 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43120f65540so27801055e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988690; x=1729593490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=56gfOPSxojYIiBagh7NZc3ktyw+EQGQzQTB4Afry5yw=;
 b=K0m6EmJ63g5UhRrevAHPhW31Dc3TFvgYL+LP8oqhpGQrvboOuG+/06o//utSBtOQEQ
 JUpfSvw3y/swgXTphFKFLhKTe0CnpH/HPwf1kfOLRQDW5H5qEFN4hGZjDoOsF94SC98C
 XjtIDJE3DfqNVCnY0Rredax6oBEUS0lIfvKL8iGzMUIAbd52aHMnAWDOsRrhGh1KykEC
 I97zfdrYQlD7yIM7KN/xevMqJMSwKFTKfYSWM/yMoATjyb4y9x8TGKQ+uEbfh4JUTmJ4
 hqFlmythaRUtVkj4ZR/vvmHz5+0Rjz6TbeNkXCNu0YQ7RDCtW8wmkXkh+F6qnaPY82tT
 uj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988690; x=1729593490;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=56gfOPSxojYIiBagh7NZc3ktyw+EQGQzQTB4Afry5yw=;
 b=heTYMcqXvqmZbTq8jmvpgE8no6Gj96xud/ybLu6iyWfElKVf0FV9soRPtEHtCp8zmU
 kRRc8X8MBmpZl24EqIzmUXY40m65chE57WM5HU+VB7r2fxbw33xThnjcnLANImmlYD5F
 wBvl/HBq05iTRVg+imYV71ct7/BoOiqHCMpz1Ylb7AvceTgF3Yw+/ojtHCwFxqegKQj8
 sDPI3JuNU8XokdzRlQURTU2TDxPywZRTY65N4VHOfvC56PuWhBATjxR0BsadOYBoWzVr
 n3wGMKALIkxUmY23Wqu5crSZp+XiWz1E7lcz8OTLrhqNEhntgXm7tgKQucKLGZ+cENAQ
 emcQ==
X-Gm-Message-State: AOJu0Yz7ZaeoA+Gqpcw/IY66jgexP2RtWNK/bzdyKMHeSnN8wYuzWutX
 kQOJeQg190qgbK6sSDPIig4QabHtm4dgc+qxlpqj0mzgGwl7/EWsBpJqEv5PA0K8trl6qqlJ8km
 j
X-Google-Smtp-Source: AGHT+IFSylU02wP+q1+lEpBwG37gZ54QFTHZA7WHMKuyodPgOwC+D43lkZmlM7xCJxvoSFweJzzD2A==
X-Received: by 2002:a05:600c:3acd:b0:426:6379:3b4f with SMTP id
 5b1f17b1804b1-43125619c33mr85274715e9.31.1728988689703; 
 Tue, 15 Oct 2024 03:38:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/28] target-arm queue
Date: Tue, 15 Oct 2024 11:37:40 +0100
Message-Id: <20241015103808.133024-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

The following changes since commit 35152940b78e478b97051a799cb6275ced03192e:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2024-10-14 17:05:25 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20241015

for you to fetch changes up to 9bb9833fd2ef30c5c7306c6f2a15dcc313305ccc:

  hw/arm/xilinx_zynq: Add various missing unimplemented devices (2024-10-15 11:29:47 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/omap1: Remove unused omap_uwire_attach() method
 * stm32f405: Add RCC device to stm32f405 SoC
 * arm/gicv3: add missing casts
 * hw/misc: Create STM32L4x5 SYSCFG clock
 * hw/arm: Add SPI to Allwinner A10
 * hw/intc/omap_intc: Remove now-unnecessary abstract base class
 * hw/char/pl011: Use correct masks for IBRD and FBRD
 * docs/devel: Convert txt files to rST
 * Remove MAX111X, MAX7310, DSCM-1XXXX, pcmcia devices (used only
   by now-removed omap/pxa2xx boards)
 * vl.c: Remove pxa2xx-specific -portrait and -rotate options
 * dma: Fix function names in documentation
 * hw/arm/xilinx_zynq: Add various missing unimplemented devices

----------------------------------------------------------------
Akihiko Odaki (1):
      dma: Fix function names in documentation

Alexandra Diupina (3):
      hw/intc/arm_gicv3: Add cast to match the documentation
      hw/intc/arm_gicv3: Add cast to match the documentation
      hw/intc/arm_gicv3_cpuif: Add cast to match the documentation

Chao Liu (1):
      hw/arm/xilinx_zynq: Add various missing unimplemented devices

Inès Varhol (3):
      hw/misc: Create STM32L4x5 SYSCFG clock
      hw/clock: Expose 'qtest-clock-period' QOM property for QTests
      tests/qtest: Check STM32L4x5 clock connections

Peter Maydell (15):
      hw/intc/omap_intc: Remove now-unnecessary abstract base class
      hw/char/pl011: Use correct masks for IBRD and FBRD
      docs/devel/blkdebug: Convert to rST format
      docs/devel/blkverify: Convert to rST format
      docs/devel/lockcnt: Convert to rST format
      docs/devel/multiple-iothreads: Convert to rST format
      docs/devel/rcu: Convert to rST format
      include: Move QemuLockCnt APIs to their own header
      docs/devel/lockcnt: Include kernel-doc API documentation
      hw/adc: Remove MAX111X device
      hw/gpio: Remove MAX7310 device
      hw/ide: Remove DSCM-1XXXX microdrive device model
      hw: Remove PCMCIA subsystem
      hw/block: Remove ecc
      vl.c: Remove pxa2xx-specific -portrait and -rotate options

Philippe Mathieu-Daudé (1):
      hw/arm/omap1: Remove unused omap_uwire_attach() method

Román Cárdenas Rodríguez (2):
      hw/misc/stm32_rcc: Implement RCC device for STM32F4 SoCs
      hw/arm/stm32f405: Add RCC device to stm32f405 SoC

Strahinja Jankovic (2):
      hw/ssi: Allwinner A10 SPI emulation
      hw/arm: Add SPI to Allwinner A10

 MAINTAINERS                                        |  10 +-
 docs/about/removed-features.rst                    |  23 +
 docs/devel/blkdebug.txt                            | 162 ------
 docs/devel/clocks.rst                              |   6 +
 docs/devel/index-api.rst                           |   1 +
 docs/devel/index-internals.rst                     |   2 +
 docs/devel/{lockcnt.txt => lockcnt.rst}            |  89 +--
 docs/devel/multiple-iothreads.rst                  | 139 +++++
 docs/devel/multiple-iothreads.txt                  | 130 -----
 docs/devel/{rcu.txt => rcu.rst}                    | 172 +++---
 docs/devel/testing/blkdebug.rst                    | 177 ++++++
 .../devel/{blkverify.txt => testing/blkverify.rst} |  30 +-
 docs/devel/testing/index.rst                       |   2 +
 docs/system/arm/cubieboard.rst                     |   1 +
 docs/system/arm/stm32.rst                          |   3 +-
 include/block/aio.h                                |   1 +
 include/hw/adc/max111x.h                           |  56 --
 include/hw/arm/allwinner-a10.h                     |   2 +
 include/hw/arm/omap.h                              |  10 +-
 include/hw/arm/stm32f405_soc.h                     |   2 +
 include/hw/block/flash.h                           |  11 -
 include/hw/core/cpu.h                              |   1 +
 include/hw/misc/stm32_rcc.h                        |  91 +++
 include/hw/misc/stm32l4x5_syscfg.h                 |   1 +
 include/hw/pcmcia.h                                |  66 ---
 include/hw/ssi/allwinner-a10-spi.h                 |  57 ++
 include/qemu/lockcnt.h                             | 130 +++++
 include/qemu/thread.h                              | 111 ----
 include/sysemu/dma.h                               |  11 +-
 include/sysemu/sysemu.h                            |   1 -
 tests/qtest/stm32l4x5.h                            |  42 ++
 accel/accel-blocker.c                              |   1 +
 hw/adc/max111x.c                                   | 236 --------
 hw/arm/allwinner-a10.c                             |   8 +
 hw/arm/omap1.c                                     |  29 +-
 hw/arm/stm32f405_soc.c                             |  12 +-
 hw/arm/stm32l4x5_soc.c                             |   2 +
 hw/arm/xilinx_zynq.c                               |  70 +++
 hw/block/ecc.c                                     |  91 ---
 hw/char/pl011.c                                    |   4 +-
 hw/core/clock.c                                    |  16 +
 hw/core/cpu-common.c                               |   1 +
 hw/gpio/max7310.c                                  | 217 -------
 hw/ide/microdrive.c                                | 644 ---------------------
 hw/intc/arm_gicv3_cpuif.c                          |   6 +-
 hw/intc/omap_intc.c                                |  13 +-
 hw/misc/stm32_rcc.c                                | 162 ++++++
 hw/misc/stm32l4x5_syscfg.c                         |  19 +-
 hw/pcmcia/pcmcia.c                                 |  24 -
 hw/ssi/allwinner-a10-spi.c                         | 561 ++++++++++++++++++
 system/globals.c                                   |   1 -
 system/vl.c                                        |  11 -
 tests/qtest/stm32l4x5_gpio-test.c                  |  23 +
 tests/qtest/stm32l4x5_syscfg-test.c                |  20 +-
 tests/qtest/stm32l4x5_usart-test.c                 |  26 +
 ui/input.c                                         |  36 --
 util/aio-posix.c                                   |   1 +
 util/aio-win32.c                                   |   1 +
 util/async.c                                       |   1 +
 util/fdmon-epoll.c                                 |   1 +
 util/lockcnt.c                                     |   1 +
 hw/Kconfig                                         |   1 -
 hw/adc/Kconfig                                     |   3 -
 hw/adc/meson.build                                 |   1 -
 hw/arm/Kconfig                                     |   3 +-
 hw/block/Kconfig                                   |   3 -
 hw/block/meson.build                               |   1 -
 hw/gpio/Kconfig                                    |   4 -
 hw/gpio/meson.build                                |   1 -
 hw/ide/Kconfig                                     |   6 -
 hw/ide/meson.build                                 |   1 -
 hw/meson.build                                     |   1 -
 hw/misc/Kconfig                                    |   4 +-
 hw/misc/meson.build                                |   1 +
 hw/misc/trace-events                               |   6 +
 hw/pcmcia/Kconfig                                  |   2 -
 hw/pcmcia/meson.build                              |   1 -
 hw/ssi/Kconfig                                     |   4 +
 hw/ssi/meson.build                                 |   1 +
 hw/ssi/trace-events                                |  10 +
 qemu-options.hx                                    |  16 -
 81 files changed, 1800 insertions(+), 2048 deletions(-)
 delete mode 100644 docs/devel/blkdebug.txt
 rename docs/devel/{lockcnt.txt => lockcnt.rst} (75%)
 create mode 100644 docs/devel/multiple-iothreads.rst
 delete mode 100644 docs/devel/multiple-iothreads.txt
 rename docs/devel/{rcu.txt => rcu.rst} (73%)
 create mode 100644 docs/devel/testing/blkdebug.rst
 rename docs/devel/{blkverify.txt => testing/blkverify.rst} (77%)
 delete mode 100644 include/hw/adc/max111x.h
 create mode 100644 include/hw/misc/stm32_rcc.h
 delete mode 100644 include/hw/pcmcia.h
 create mode 100644 include/hw/ssi/allwinner-a10-spi.h
 create mode 100644 include/qemu/lockcnt.h
 create mode 100644 tests/qtest/stm32l4x5.h
 delete mode 100644 hw/adc/max111x.c
 delete mode 100644 hw/block/ecc.c
 delete mode 100644 hw/gpio/max7310.c
 delete mode 100644 hw/ide/microdrive.c
 create mode 100644 hw/misc/stm32_rcc.c
 delete mode 100644 hw/pcmcia/pcmcia.c
 create mode 100644 hw/ssi/allwinner-a10-spi.c
 delete mode 100644 hw/pcmcia/Kconfig
 delete mode 100644 hw/pcmcia/meson.build

