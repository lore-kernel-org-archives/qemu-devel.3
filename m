Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C9ACEACE8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfuI-0005IG-Pt; Tue, 01 Oct 2024 12:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuG-0005Ha-MP
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:24 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuE-0005zs-EZ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:24 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37ce18b042fso2313955f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800760; x=1728405560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=H3ZF4yerCxyh9jwwjaDxTUa61zbod0JocRuJ9PSQH8w=;
 b=eTN+NvjaykJrLKKJn0ep/rroHkH8AMYfwrgLYOCT7OM3pp10GsQoPXqXyxfgtUHhu6
 uezIBA3w+fs5EWQDNzZj7ZvC8nRfjRl2upvbqv3DtycLxmkipZJhChyeUoW7MtfjvPOG
 tru3AgUHDxKKdC8g0iUzdunzUDVC6eXKbQmuY2X7B+e3qvxL671vo2JaLUw/lfohYQ8p
 /UJK3a9Vnx/Rhzm6jk0nKBhW1hNsiqPY3SrZTz9VRNv4rkuDGvjWpP5RfUHq9d8Oi+7I
 gaUoCOWxYkjmnGfkRGcCCFQdwijOAacXXVXamdbpm4qJWD9X4G41VSjafMABcIGB0Su1
 BJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800760; x=1728405560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H3ZF4yerCxyh9jwwjaDxTUa61zbod0JocRuJ9PSQH8w=;
 b=K0ieHXNnB/VmuytkuNAK0bENrQ8MXs+QoBdOHYXShhUxwhRDG/XxAhd6SkxqT/uI7Z
 +FJYre8+jZU1KD6luyhyzu1rxRZMvNJMWgpddtXy7dOBu7YoA99EwHAPLIsdySwEPjct
 IjV2FmqWEGZj/bWd8XKR5xVc7SSTPOOypejg7LRRc2L7bM3Z14czTC0YsmdLV8an8ORM
 RQ9XKt6NpKPIy0DX8105Dy+0A5/0IiYE9nw5RgugcOo7GWNTJJAlpNpwUUvZKhJbMrjU
 kZ+3ptl7DzeZ4VsHObBZP4Bo8R8xlg6+/FN4wdgY41KmSILQ10jkOb5FWi20cd2BcJq1
 0Jyw==
X-Gm-Message-State: AOJu0YzCfBO8nGtMYC+uMkNDjuaBDZDNAe6ReYib6P6YKem/ybTNTvTa
 1YAaSCYqK/FCOswIGBwigmcSrxlQG3hSj1X5hDLy1+mS2o28Zczz3X2CzYnvt+/xGnwvVKwEjrE
 A
X-Google-Smtp-Source: AGHT+IGjYYIqaWr/iDlbWrc1Pmm5/rP0Tnp4rxEOcqL5vhHOZwRTA9BhW6xbS3s/eohYpylognxVxQ==
X-Received: by 2002:adf:ffc2:0:b0:37c:cc96:d1cd with SMTP id
 ffacd0b85a97d-37cfb9d3364mr151688f8f.34.1727800760194; 
 Tue, 01 Oct 2024 09:39:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/54] target-arm queue
Date: Tue,  1 Oct 2024 17:38:24 +0100
Message-Id: <20241001163918.1275441-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

This pullreq has a few miscellaneous fixes, plus the
non-controversial (and largely reviewed) parts of my
series removing deprecated arm boards. (The rest of that
series I will send out a v2 for once this lands.)

-- PMM

The following changes since commit 718780d20470c66a3a36d036b29148d5809dc855:

  Merge tag 'pull-nvme-20241001' of https://gitlab.com/birkelund/qemu into staging (2024-10-01 11:34:07 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20241001

for you to fetch changes up to be025ce676d0f8fd094d17b34e87305a1c8fb595:

  hw: Remove omap2 specific defines and enums (2024-10-01 16:08:02 +0100)

----------------------------------------------------------------
target-arm queue:
 * MAINTAINERS: Update STM32L4x5 and B-L475E-IOT01A maintainers
 * hw/arm/xlnx: Connect secondary CGEM IRQs
 * m25p80: Add SFDP table for mt35xu01g flash
 * target/arm: Avoid target_ulong for physical address lookups
 * hw/ssi/xilinx_spips: Fix flash erase assert in dual parallel configuration
 * hw: fix memory leak in IRQState allocation
 * hw/sd/sdcard: Fix handling of disabled boot partitions
 * arm: Remove deprecated board models

----------------------------------------------------------------
Ard Biesheuvel (1):
      target/arm: Avoid target_ulong for physical address lookups

Inès Varhol (1):
      MAINTAINERS: Update STM32L4x5 and B-L475E-IOT01A maintainers

Jan Luebbe (1):
      hw/sd/sdcard: Fix handling of disabled boot partitions

Kinsey Moore (1):
      hw/arm/xlnx: Connect secondary CGEM IRQs

Matheus Tavares Bernardino (1):
      hw: fix memory leak in IRQState allocation

Peter Maydell (47):
      hw/arm: Remove deprecated akita, borzoi, spitz, terrier, tosa boards
      hw/input: Drop ADS7846 device
      hw/display: Remove tc6393xb device
      hw/arm/KConfig: Replace ZAURUS with ZAURUS_SCOOP
      hw/arm: Remove 'cheetah' machine
      hw/arm: Remove 'connex' and 'verdex' machines
      hw/arm: Remove 'mainstone' machine
      hw/misc: Remove MAINSTONE_FPGA device
      hw/arm: Remove 'z2' machine
      hw/arm: Remove STRONGARM->PXA2XX dependency
      hw/timer/pxa2xx_timer: Remove use of pxa.h header
      hw/arm: Remove pxa2xx.c
      hw/sd: Remove pxa2xx_mmci.c
      hw/input: Remove pxa2xx_keypad
      hw/display: Remove pxa2xx_lcd.c
      hw/dma: Remove pxa2xx_dma
      hw/pcmcia: Remove pxa2xx pcmcia device
      hw/arm: Remove pxa2xx_gpio
      hw/arm: Remove pxa2xx_pic
      hw/timer: Remove pxa27x-timer
      hw/arm: Remove 'n800' and 'n810' machines
      hw/misc: Remove cbus
      hw/display: Remove Blizzard display device
      hw/input: Remove tsc2005 touchscreen controller
      hw/input: Remove tsc210x device
      hw/rtc: Remove twl92230 device
      hw/input: Remove lm832x device
      hw/block: Remove OneNAND device
      hw/usb: Remove tusb6010 USB controller
      hw/usb: Remove MUSB USB host controller
      docs: Document removal of old Arm boards
      hw/arm: Remove omap2.c
      hw/gpio: Remove TYPE_OMAP2_GPIO
      hw/char: Remove omap2_uart
      hw/intc: Remove omap2-intc device
      hw/sd: Remove omap2_mmc device
      hw/misc: Remove omap_sdrc device
      hw/misc: Remove omap_gpmc
      hw/timer: Remove omap_gptimer
      hw/timer: Remove omap_synctimer
      hw/ssi: Remove omap_mcspi
      hw/misc: Remove omap_tap device
      hw/display: Remove omap_dss
      hw/misc: Remove omap_l4 device
      hw/misc/omap_clk: Remove OMAP2-specifics
      hw/dma: Remove omap_dma4 device
      hw: Remove omap2 specific defines and enums

Shiva sagar Myana (2):
      m25p80: Add SFDP table for mt35xu01g flash
      hw/ssi/xilinx_spips: Fix flash erase assert in dual parallel configuration

 MAINTAINERS                             |   99 +-
 docs/about/deprecated.rst               |   15 -
 docs/about/removed-features.rst         |   14 +
 docs/system/arm/gumstix.rst             |   21 -
 docs/system/arm/mainstone.rst           |   25 -
 docs/system/arm/nseries.rst             |   33 -
 docs/system/arm/palm.rst                |   23 -
 docs/system/arm/xscale.rst              |   35 -
 docs/system/target-arm.rst              |    5 -
 configs/devices/arm-softmmu/default.mak |    7 -
 hw/block/m25p80_sfdp.h                  |    1 +
 include/hw/arm/omap.h                   |  350 +---
 include/hw/arm/pxa.h                    |  197 ---
 include/hw/arm/xlnx-versal.h            |    1 +
 include/hw/arm/xlnx-zynqmp.h            |    1 +
 include/hw/block/flash.h                |    3 -
 include/hw/display/blizzard.h           |   21 -
 include/hw/display/tc6393xb.h           |   21 -
 include/hw/input/lm832x.h               |   28 -
 include/hw/input/tsc2xxx.h              |   41 -
 include/hw/misc/cbus.h                  |   31 -
 include/hw/usb/hcd-musb.h               |   49 -
 target/arm/internals.h                  |    4 +-
 hw/arm/gumstix.c                        |  141 --
 hw/arm/mainstone.c                      |  175 --
 hw/arm/nseries.c                        | 1473 -----------------
 hw/arm/omap2.c                          | 2715 -------------------------------
 hw/arm/palm.c                           |  324 ----
 hw/arm/pxa2xx.c                         | 2393 ---------------------------
 hw/arm/pxa2xx_gpio.c                    |  365 -----
 hw/arm/pxa2xx_pic.c                     |  359 ----
 hw/arm/spitz.c                          | 1284 ---------------
 hw/arm/tosa.c                           |  327 ----
 hw/arm/xlnx-versal.c                    |   12 +-
 hw/arm/xlnx-zynqmp.c                    |   11 +-
 hw/arm/z2.c                             |  355 ----
 hw/block/m25p80.c                       |    3 +-
 hw/block/m25p80_sfdp.c                  |   37 +
 hw/block/onenand.c                      |  872 ----------
 hw/char/omap_uart.c                     |  113 --
 hw/core/irq.c                           |   19 +-
 hw/display/blizzard.c                   | 1026 ------------
 hw/display/omap_dss.c                   | 1093 -------------
 hw/display/pxa2xx_lcd.c                 | 1451 -----------------
 hw/display/tc6393xb.c                   |  568 -------
 hw/dma/omap_dma.c                       |  451 +----
 hw/dma/pxa2xx_dma.c                     |  591 -------
 hw/gpio/omap_gpio.c                     |  557 -------
 hw/input/ads7846.c                      |  186 ---
 hw/input/lm832x.c                       |  528 ------
 hw/input/pxa2xx_keypad.c                |  331 ----
 hw/input/tsc2005.c                      |  571 -------
 hw/input/tsc210x.c                      | 1241 --------------
 hw/intc/omap_intc.c                     |  276 ----
 hw/misc/cbus.c                          |  619 -------
 hw/misc/mst_fpga.c                      |  269 ---
 hw/misc/omap_clk.c                      |  527 +-----
 hw/misc/omap_gpmc.c                     |  898 ----------
 hw/misc/omap_l4.c                       |  162 --
 hw/misc/omap_sdrc.c                     |  167 --
 hw/misc/omap_tap.c                      |  117 --
 hw/pcmcia/pxa2xx.c                      |  248 ---
 hw/rtc/twl92230.c                       |  882 ----------
 hw/sd/omap_mmc.c                        |   63 -
 hw/sd/pxa2xx_mmci.c                     |  594 -------
 hw/sd/sd.c                              |    7 -
 hw/ssi/omap_spi.c                       |  380 -----
 hw/ssi/xilinx_spips.c                   |    4 +-
 hw/timer/omap_gptimer.c                 |  512 ------
 hw/timer/omap_synctimer.c               |  110 --
 hw/timer/pxa2xx_timer.c                 |   25 -
 hw/usb/hcd-musb.c                       | 1553 ------------------
 hw/usb/tusb6010.c                       |  850 ----------
 target/arm/ptw.c                        |   16 +-
 tests/qtest/libqos/arm-n800-machine.c   |   92 --
 hw/arm/Kconfig                          |   89 +-
 hw/arm/meson.build                      |    9 -
 hw/block/Kconfig                        |    3 -
 hw/block/meson.build                    |    1 -
 hw/display/Kconfig                      |    3 -
 hw/display/meson.build                  |    4 -
 hw/dma/meson.build                      |    1 -
 hw/gpio/Kconfig                         |    3 +
 hw/gpio/meson.build                     |    2 +-
 hw/input/Kconfig                        |   13 -
 hw/input/meson.build                    |    5 -
 hw/input/trace-events                   |    3 -
 hw/misc/meson.build                     |    6 -
 hw/pcmcia/meson.build                   |    1 -
 hw/rtc/Kconfig                          |    4 -
 hw/rtc/meson.build                      |    1 -
 hw/sd/meson.build                       |    1 -
 hw/sd/trace-events                      |    4 -
 hw/ssi/meson.build                      |    1 -
 hw/timer/Kconfig                        |    3 +
 hw/timer/meson.build                    |    4 +-
 hw/usb/Kconfig                          |    8 -
 hw/usb/meson.build                      |    2 -
 tests/avocado/machine_arm_n8x0.py       |   49 -
 tests/qtest/libqos/meson.build          |    1 -
 100 files changed, 146 insertions(+), 29043 deletions(-)
 delete mode 100644 docs/system/arm/gumstix.rst
 delete mode 100644 docs/system/arm/mainstone.rst
 delete mode 100644 docs/system/arm/nseries.rst
 delete mode 100644 docs/system/arm/palm.rst
 delete mode 100644 docs/system/arm/xscale.rst
 delete mode 100644 include/hw/arm/pxa.h
 delete mode 100644 include/hw/display/blizzard.h
 delete mode 100644 include/hw/display/tc6393xb.h
 delete mode 100644 include/hw/input/lm832x.h
 delete mode 100644 include/hw/input/tsc2xxx.h
 delete mode 100644 include/hw/misc/cbus.h
 delete mode 100644 include/hw/usb/hcd-musb.h
 delete mode 100644 hw/arm/gumstix.c
 delete mode 100644 hw/arm/mainstone.c
 delete mode 100644 hw/arm/nseries.c
 delete mode 100644 hw/arm/omap2.c
 delete mode 100644 hw/arm/palm.c
 delete mode 100644 hw/arm/pxa2xx.c
 delete mode 100644 hw/arm/pxa2xx_gpio.c
 delete mode 100644 hw/arm/pxa2xx_pic.c
 delete mode 100644 hw/arm/spitz.c
 delete mode 100644 hw/arm/tosa.c
 delete mode 100644 hw/arm/z2.c
 delete mode 100644 hw/block/onenand.c
 delete mode 100644 hw/display/blizzard.c
 delete mode 100644 hw/display/omap_dss.c
 delete mode 100644 hw/display/pxa2xx_lcd.c
 delete mode 100644 hw/display/tc6393xb.c
 delete mode 100644 hw/dma/pxa2xx_dma.c
 delete mode 100644 hw/input/ads7846.c
 delete mode 100644 hw/input/lm832x.c
 delete mode 100644 hw/input/pxa2xx_keypad.c
 delete mode 100644 hw/input/tsc2005.c
 delete mode 100644 hw/input/tsc210x.c
 delete mode 100644 hw/misc/cbus.c
 delete mode 100644 hw/misc/mst_fpga.c
 delete mode 100644 hw/misc/omap_gpmc.c
 delete mode 100644 hw/misc/omap_l4.c
 delete mode 100644 hw/misc/omap_sdrc.c
 delete mode 100644 hw/misc/omap_tap.c
 delete mode 100644 hw/pcmcia/pxa2xx.c
 delete mode 100644 hw/rtc/twl92230.c
 delete mode 100644 hw/sd/pxa2xx_mmci.c
 delete mode 100644 hw/ssi/omap_spi.c
 delete mode 100644 hw/timer/omap_gptimer.c
 delete mode 100644 hw/timer/omap_synctimer.c
 delete mode 100644 hw/usb/hcd-musb.c
 delete mode 100644 hw/usb/tusb6010.c
 delete mode 100644 tests/qtest/libqos/arm-n800-machine.c
 delete mode 100755 tests/avocado/machine_arm_n8x0.py

