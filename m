Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C8DC48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvav-0000B4-LV; Fri, 02 Feb 2024 10:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvat-00008T-QJ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:43 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvaq-0004Qq-DP
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:43 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5113abf9b05so385068e87.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888198; x=1707492998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nyszzEhuahgyNW96/tt7/fAnBeDr9kv+QhzqcFGnfCE=;
 b=x33JFiqn2sz7bU7i9dtzJXGj3LsyK8aAL5Fna3kpWW4hoIda+zdFEhwfprbJdKQHbP
 6KNS4SsxQxPAzeBdd7p99m81S+M+WgVNES/NBNLxk0G+0OmQwGmBbYCqZ6j29uq0JE1a
 fBYGv/Tq280KieQyn025Xzbd3wvk9j7EtjM25fr3l7qn9OJb8w/guDwjdPAGr9050uaK
 z0+E8FjyaEdqLIxFLoaqWy5HHf/PHzjDKUx+VmcZT30lVFVGNc4QBkPH4bCc/jspAll7
 E4JMG5jsCRIXtWxvYpMtvINbD6ZxofF1YJ/XGUcV9Sr2qeiC23LyuEKlvW2S8U6hAclw
 Thrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888198; x=1707492998;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nyszzEhuahgyNW96/tt7/fAnBeDr9kv+QhzqcFGnfCE=;
 b=le3UrYEKhx7Q4vj8Gb5pymLb1JjT3LTo/tALf81UOk5At7veITLfdp9toJJVokXl/v
 FGlEdc7DGuugAqFL5OahphOWkj568nC7akPd4ShUCupHYQKwTmQJiq//ce2HtUGXM2b5
 YR6/xJsK1otpuLrtKSevZO73w5zGG2f0o9eZZGtWokLE+tYOZVJM4rRAyuDp1DbeI/JR
 fHNAqfTrOvj5gJfxlQ4ZSnW+l79N1imr/Vc2xrpLhON7+V6cWY/wrVo1Fyk6KPNC3mpb
 gr3OZ4lu4yZeFIggss04DqbNP7aVG2+6da/yutNYP+mK24FpkfrbBOLQBS3mgascqmLt
 T2kQ==
X-Gm-Message-State: AOJu0Yxi28ipwr4vjyuovQAqA1cuk/dRwJ6EokxCh2OQy/EOSxwsdh1l
 x+Q9Dn1Fx8PZbA+tFwN9Roz1SXUg3mc1MrpWhdJnKiVcAMcHc0kVdxdCgZMHLC45fFHDnIe6kzY
 n
X-Google-Smtp-Source: AGHT+IGRJw7EdO6ON+Sc0ZEiuWdaxCCRRff4ZtEEh5ZsHEAEk+a2izlbSMizZMbVXstg/2mNa8aSZA==
X-Received: by 2002:a19:5504:0:b0:511:3e8d:f57e with SMTP id
 n4-20020a195504000000b005113e8df57emr90567lfe.11.1706888198342; 
 Fri, 02 Feb 2024 07:36:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/36] target-arm queue
Date: Fri,  2 Feb 2024 15:36:01 +0000
Message-Id: <20240202153637.3710444-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

The following changes since commit c3709fde5955d13f6d4f86ab46ef3cc2288ca65e:

  Merge tag 'pull-aspeed-20240201' of https://github.com/legoater/qemu into staging (2024-02-01 14:42:11 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240202

for you to fetch changes up to f09c2b7ba9908714a3e2f1decd989462536cf731:

  hw/arm: Connect SPI Controller to BCM2835 (2024-02-02 13:51:59 +0000)

----------------------------------------------------------------
target/arm: fix exception syndrome for AArch32 bkpt insn
pci, vmbus, adb, s390x/css-bridge: Switch buses to 3-phase reset
system/vl.c: Fix handling of '-serial none -serial something'
target/arm: Add ID_AA64ZFR0_EL1.B16B16 to the exposed-to-userspace set
tests/qtest/xlnx-versal-trng-test.c: Drop use of variable length array
target/arm: Reinstate "vfp" property on AArch32 CPUs
doc/sphinx/hxtool.py: add optional label argument to SRST directive
hw/arm: Check for CPU types in machine_run_board_init() for various boards
pci-host: designware: Limit value range of iATU viewport register
hw/arm: Convert some DPRINTF macros to trace events and guest errors
hw/arm: NPCM7XX SoC: Add GMAC ethernet controller devices
hw/arm: Implement BCM2835 SPI Controller

----------------------------------------------------------------
David Woodhouse (1):
      doc/sphinx/hxtool.py: add optional label argument to SRST directive

Guenter Roeck (1):
      pci-host: designware: Limit value range of iATU viewport register

Hao Wu (2):
      hw/net: Add NPCMXXX GMAC device
      hw/arm: Add GMAC devices to NPCM7XX SoC

Jan Klötzke (1):
      target/arm: fix exception syndrome for AArch32 bkpt insn

Manos Pitsidianakis (6):
      hw/arm/strongarm.c: convert DPRINTF to trace events and guest errors
      hw/arm/z2: convert DPRINTF to trace events and guest errors
      hw/arm/xen_arm.c: convert DPRINTF to trace events and error/warn reports
      hw/xen/xen-mapcache.c: convert DPRINTF to tracepoints
      hw/xen/xen-hvm-common.c: convert DPRINTF to tracepoints
      hw/xen: convert stderr prints to error/warn reports

Nabih Estefan Diaz (4):
      tests/qtest: Creating qtest for GMAC Module
      hw/net: GMAC Rx Implementation
      hw/net: GMAC Tx Implementation
      tests/qtest: Adding PCS Module test to GMAC Qtest

Peter Maydell (10):
      pci: Switch bus reset to 3-phase-reset
      vmbus: Switch bus reset to 3-phase-reset
      adb: Switch bus reset to 3-phase-reset
      hw/s390x/css-bridge: switch virtual-css bus to 3-phase-reset
      hw/core: Remove transitional infrastructure from BusClass
      system/vl.c: Fix handling of '-serial none -serial something'
      qemu-options.hx: Improve -serial option documentation
      target/arm: Add ID_AA64ZFR0_EL1.B16B16 to the exposed-to-userspace set
      tests/qtest/xlnx-versal-trng-test.c: Drop use of variable length array
      target/arm: Reinstate "vfp" property on AArch32 CPUs

Philippe Mathieu-Daudé (9):
      hw/arm/exynos: Add missing QOM parent for CPU cores
      hw/arm/exynos: Check for CPU types in machine_run_board_init()
      hw/arm/highbank: Add missing QOM parent for CPU cores
      hw/arm/highbank: Check for CPU types in machine_run_board_init()
      hw/arm/msf2: Simplify setting MachineClass::valid_cpu_types[]
      hw/arm/musca: Simplify setting MachineClass::valid_cpu_types[]
      hw/arm/npcm7xx_boards: Simplify setting MachineClass::valid_cpu_types[]
      hw/arm/vexpress: Check for CPU types in machine_run_board_init()
      hw/arm/zynq: Check for CPU types in machine_run_board_init()

Rayhan Faizel (2):
      hw/ssi: Implement BCM2835 SPI Controller
      hw/arm: Connect SPI Controller to BCM2835

 docs/devel/docs.rst                  |  12 +-
 docs/sphinx/hxtool.py                |  16 +
 docs/system/arm/raspi.rst            |   2 +-
 docs/system/i386/xen.rst             |   3 +-
 include/hw/arm/bcm2835_peripherals.h |   3 +-
 include/hw/arm/msf2-soc.h            |   3 -
 include/hw/arm/npcm7xx.h             |   2 +
 include/hw/net/npcm_gmac.h           | 343 +++++++++++++
 include/hw/qdev-core.h               |   2 -
 include/hw/ssi/bcm2835_spi.h         |  81 +++
 target/arm/syndrome.h                |   8 +
 hw/arm/bcm2835_peripherals.c         |  17 +-
 hw/arm/exynos4210.c                  |   1 +
 hw/arm/exynos4_boards.c              |   8 +
 hw/arm/highbank.c                    |  11 +
 hw/arm/msf2-soc.c                    |   3 +-
 hw/arm/msf2-som.c                    |   4 -
 hw/arm/musca.c                       |   1 -
 hw/arm/npcm7xx.c                     |  37 +-
 hw/arm/npcm7xx_boards.c              |   1 -
 hw/arm/strongarm.c                   |  82 +--
 hw/arm/vexpress.c                    |  12 +-
 hw/arm/xen_arm.c                     |  23 +-
 hw/arm/xilinx_zynq.c                 |   6 +-
 hw/arm/z2.c                          |  27 +-
 hw/core/bus.c                        |  67 ---
 hw/hyperv/vmbus.c                    |   7 +-
 hw/input/adb.c                       |   7 +-
 hw/net/npcm_gmac.c                   | 942 +++++++++++++++++++++++++++++++++++
 hw/pci-host/designware.c             |   2 +
 hw/pci/pci.c                         |  10 +-
 hw/s390x/css-bridge.c                |   5 +-
 hw/ssi/bcm2835_spi.c                 | 288 +++++++++++
 hw/xen/xen-hvm-common.c              |  47 +-
 hw/xen/xen-mapcache.c                |  59 +--
 system/vl.c                          |  22 +-
 target/arm/cpu.c                     |   4 +
 target/arm/helper.c                  |  19 +
 tests/qtest/npcm_gmac-test.c         | 344 +++++++++++++
 tests/qtest/xlnx-versal-trng-test.c  |  19 +-
 tests/tcg/aarch64/sysregs.c          |   2 +-
 hw/arm/Kconfig                       |   1 +
 hw/arm/trace-events                  |  15 +
 hw/net/meson.build                   |   2 +-
 hw/net/trace-events                  |  19 +
 hw/ssi/Kconfig                       |   4 +
 hw/ssi/meson.build                   |   1 +
 hw/xen/trace-events                  |  21 +-
 qemu-options.hx                      |  16 +-
 tests/qtest/meson.build              |   1 +
 50 files changed, 2388 insertions(+), 244 deletions(-)
 create mode 100644 include/hw/net/npcm_gmac.h
 create mode 100644 include/hw/ssi/bcm2835_spi.h
 create mode 100644 hw/net/npcm_gmac.c
 create mode 100644 hw/ssi/bcm2835_spi.c
 create mode 100644 tests/qtest/npcm_gmac-test.c

