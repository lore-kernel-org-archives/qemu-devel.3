Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7057DC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rezTL-0005U8-Kf; Tue, 27 Feb 2024 10:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rezTH-0005QV-K6
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:34:19 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rezTC-0005O3-0m
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:34:18 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412af2dca59so4389385e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 07:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709048052; x=1709652852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Gvyj8Te/FcELdnn5Fag+Ftd4/hVG7ZZ/CxKziKlucYc=;
 b=h6aAm8N6xccFPaSif0lSVebqhdOhLMnW3vkZmKkJ9qiYQ+BvSVoeHmMAos78TpcnjD
 lD9w1e1UT6KVHmq7JKu68vwLJiDAleu304A5MP7RgTKDTmZWyC7Zr5xTWnUoWnrgVKhF
 EjspEY0yHa/x6SMl657isqe58Mg41rJUhLu5luUgnxyATtQOY2QV0V1o6SGRCCe66DnX
 /pQJiwvACu59RQHNds0pWH34WSa3/ZdaE3fRbGKeJYyaVqI/mFII9zE7onanJqpXiPsV
 X6K0emqK5q4e8/pcpiiAm2Xv+AUCvJ4maHzZelACrLg8wybyC0+rTy+a4es+httjDu4A
 piFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709048052; x=1709652852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gvyj8Te/FcELdnn5Fag+Ftd4/hVG7ZZ/CxKziKlucYc=;
 b=WiltjOcww20bvDT/eNoG9ETukVkxOGR0EoqMEYqkv38ahg78XsUk4HjIWKfWtFWF3C
 PtFEI5Lh8kjFDwKZ55ZwC94GVxGd5QqrJIGDzgZQJqGyBAlKL6YVqQuczr8kdV4488/k
 afaxD35yYRdTSoWRkNXQ5vXqZQbNvyYyXh3l6NuTLkqv6X6TnVSManFZL2Y7BSWHB/sO
 hMc7gp0QoEQ8TxSc/7RGyw2fxAtlkCMnU+2w1MV2bGr5oToBcn+GowTPIKoBXVMAkpw5
 7gwn1bGGlWD4bAXpRYJhG6UJ5DlWQCTcoYzQpNaDkh/LWMRzz4J5RChNR9FWA5kO8CZp
 ua4g==
X-Gm-Message-State: AOJu0YwSAx4e5c9QZfx+7gSjaAsozGqVY1rOG0Mm+7oL/7LEfhkcIM99
 jDlYrK3f1xIG6o0+MI6U+znDhVTizkG+uIVtDNMexbBcmwJq0nIp83eKDYIT6K/FpyhMR7nPN4Y
 r
X-Google-Smtp-Source: AGHT+IEgb+UFFWwIXvd8DTfCFVW0vvGvmwvFYqNt942jDIx/baG5+AmceGdH5sJOAfvBP8D4ehX2qA==
X-Received: by 2002:a5d:6d85:0:b0:33d:da6e:b7ed with SMTP id
 l5-20020a5d6d85000000b0033dda6eb7edmr5777415wrs.18.1709048051956; 
 Tue, 27 Feb 2024 07:34:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 dq2-20020a0560000cc200b0033b483d1abcsm11655824wrb.53.2024.02.27.07.34.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 07:34:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/36] target-arm queue
Date: Tue, 27 Feb 2024 15:34:10 +0000
Message-Id: <20240227153410.1917221-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Changes v1->v2: dropped all the patches for the bcm2828-mailbox qtest,
which turns out to have portability problems on big-endian hosts and macos.

thanks
-- PMM

The following changes since commit dccbaf0cc0f1744ffd7562a3dc60e4fc99fd9d44:

  Merge tag 'hw-misc-20240227' of https://github.com/philmd/qemu into staging (2024-02-27 10:11:07 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240227-1

for you to fetch changes up to 9c5c959dd748f2972e46a84b8d5f77794f515014:

  docs/system/arm: Add RPi4B to raspi.rst (2024-02-27 15:24:20 +0000)

----------------------------------------------------------------
target-arm queue:
 * Handle atomic updates of page tables entries in MMIO during PTW
 * Advertise Cortex-A53 erratum #843419 fix via REVIDR
 * MAINTAINERS: Cover hw/ide/ahci-allwinner.c with AllWinner A10 machine
 * misc: m48t59: replace qemu_system_reset_request() call with watchdog_perform_action()
 * misc: pxa2xx_timer: replace qemu_system_reset_request() call with watchdog_perform_action()
 * xlnx-versal-ospi: disable reentrancy detection for iomem_dac
 * sbsa-ref: Simplify init since PCIe is always enabled
 * stm32l4x5: Use TYPE_OR_IRQ when connecting STM32L4x5 EXTI fan-in IRQs
 * pl031: Update last RTCLR value on write in case it's read back
 * block: m25p80: Add support of mt35xu02gbba
 * xlnx-versal-virt: Add machine property ospi-flash
 * reset: refactor system reset to be three-phase aware
 * new board model raspi4b

----------------------------------------------------------------
Abhiram Tilak (2):
      misc: m48t59: replace qemu_system_reset_request() call with watchdog_perform_action()
      misc: pxa2xx_timer: replace qemu_system_reset_request() call with watchdog_perform_action()

Ard Biesheuvel (1):
      target/arm: Advertise Cortex-A53 erratum #843419 fix via REVIDR

Inès Varhol (2):
      hw/arm: Use TYPE_OR_IRQ when connecting STM32L4x5 EXTI fan-in IRQs
      tests/qtest: Check that EXTI fan-in irqs are correctly connected

Jessica Clarke (1):
      pl031: Update last RTCLR value on write in case it's read back

Jonathan Cameron (1):
      arm/ptw: Handle atomic updates of page tables entries in MMIO during PTW.

Marcin Juszkiewicz (1):
      hw/arm/sbsa-ref: Simplify init since PCIe is always enabled

Peter Maydell (9):
      system/bootdevice: Don't unregister reset handler in restore_boot_order()
      include/qom/object.h: New OBJECT_DEFINE_SIMPLE_TYPE{, _WITH_INTERFACES} macros
      hw/core: Add documentation and license comments to reset.h
      hw/core: Add ResetContainer which holds objects implementing Resettable
      hw/core/reset: Add qemu_{register, unregister}_resettable()
      hw/core/reset: Implement qemu_register_reset via qemu_register_resettable
      hw/core/machine: Use qemu_register_resettable for sysbus reset
      docs/devel/reset: Update to discuss system reset
      tests/avocado/boot_linux_console.py: Add Rpi4b boot tests

Philippe Mathieu-Daudé (1):
      MAINTAINERS: Cover hw/ide/ahci-allwinner.c with AllWinner A10 machine

Sai Pavan Boddu (3):
      xlnx-versal-ospi: disable reentrancy detection for iomem_dac
      block: m25p80: Add support of mt35xu02gbba
      arm: xlnx-versal-virt: Add machine property ospi-flash

Sergey Kambalin (15):
      hw/arm/bcm2836: Split out common part of BCM283X classes
      hw/arm/bcm2853_peripherals: Split out common part of peripherals
      hw/arm/raspi: Split out raspi machine common part
      hw/arm: Introduce BCM2838 SoC
      hw/arm/bcm2838: Add GIC-400 to BCM2838 SoC
      hw/gpio: Add BCM2838 GPIO stub
      hw/gpio: Implement BCM2838 GPIO functionality
      hw/gpio: Connect SD controller to BCM2838 GPIO
      hw/arm: Add GPIO and SD to BCM2838 periph
      hw/arm: Introduce Raspberry PI 4 machine
      hw/arm/raspi4b: Temporarily disable unimplemented rpi4b devices
      hw/arm: Add memory region for BCM2837 RPiVid ASB
      hw/arm/bcm2838_peripherals: Add clock_isp stub
      hw/misc/bcm2835_property: Add missed BCM2835 properties
      docs/system/arm: Add RPi4B to raspi.rst

 MAINTAINERS                          |  11 +
 docs/devel/qom.rst                   |  34 ++-
 docs/devel/reset.rst                 |  44 +++-
 docs/system/arm/raspi.rst            |  12 +-
 hw/block/m25p80_sfdp.h               |   1 +
 include/hw/arm/bcm2835_peripherals.h |  29 ++-
 include/hw/arm/bcm2836.h             |  27 ++-
 include/hw/arm/bcm2838.h             |  31 +++
 include/hw/arm/bcm2838_peripherals.h |  84 ++++++++
 include/hw/arm/raspberrypi-fw-defs.h |  11 +
 include/hw/arm/raspi_platform.h      |  38 +++-
 include/hw/arm/stm32l4x5_soc.h       |   4 +
 include/hw/core/resetcontainer.h     |  48 +++++
 include/hw/display/bcm2835_fb.h      |   2 +
 include/hw/gpio/bcm2838_gpio.h       |  45 ++++
 include/qom/object.h                 | 114 +++++++---
 include/sysemu/reset.h               | 113 ++++++++++
 hw/arm/bcm2835_peripherals.c         | 215 +++++++++++--------
 hw/arm/bcm2836.c                     | 117 ++++++-----
 hw/arm/bcm2838.c                     | 263 +++++++++++++++++++++++
 hw/arm/bcm2838_peripherals.c         | 224 ++++++++++++++++++++
 hw/arm/raspi.c                       | 130 +++++++-----
 hw/arm/raspi4b.c                     | 132 ++++++++++++
 hw/arm/sbsa-ref.c                    |   5 +-
 hw/arm/stm32l4x5_soc.c               |  80 ++++++-
 hw/arm/xlnx-versal-virt.c            |  44 +++-
 hw/block/m25p80.c                    |   3 +
 hw/block/m25p80_sfdp.c               |  36 ++++
 hw/core/machine.c                    |   7 +-
 hw/core/reset.c                      | 166 ++++++++++++---
 hw/core/resetcontainer.c             |  77 +++++++
 hw/gpio/bcm2838_gpio.c               | 390 +++++++++++++++++++++++++++++++++++
 hw/misc/bcm2835_property.c           |  21 ++
 hw/rtc/m48t59.c                      |   4 +-
 hw/rtc/pl031.c                       |   1 +
 hw/ssi/xlnx-versal-ospi.c            |   6 +
 hw/timer/pxa2xx_timer.c              |   3 +-
 system/bootdevice.c                  |  25 ++-
 target/arm/cpu64.c                   |   2 +-
 target/arm/ptw.c                     |  64 +++++-
 tests/qtest/stm32l4x5_exti-test.c    |  37 ++++
 hw/arm/meson.build                   |   2 +
 hw/arm/trace-events                  |   3 +
 hw/core/meson.build                  |   1 +
 hw/gpio/meson.build                  |   5 +-
 tests/avocado/boot_linux_console.py  |  97 +++++++++
 46 files changed, 2503 insertions(+), 305 deletions(-)
 create mode 100644 include/hw/arm/bcm2838.h
 create mode 100644 include/hw/arm/bcm2838_peripherals.h
 create mode 100644 include/hw/core/resetcontainer.h
 create mode 100644 include/hw/gpio/bcm2838_gpio.h
 create mode 100644 hw/arm/bcm2838.c
 create mode 100644 hw/arm/bcm2838_peripherals.c
 create mode 100644 hw/arm/raspi4b.c
 create mode 100644 hw/core/resetcontainer.c
 create mode 100644 hw/gpio/bcm2838_gpio.c

