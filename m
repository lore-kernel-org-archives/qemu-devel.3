Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDA8C021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzJd-00009C-VP; Tue, 25 Feb 2025 13:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzIz-0008Am-M8
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:19 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzIx-0002BG-4F
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:17 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38f265c6cb0so2964521f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506713; x=1741111513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=EC8IF2fsP3QA1UeWRpuXQQkqxhpY7selzaVRXFP1UlM=;
 b=c1d5SaWXalQ6Yyj8vsOcaRALTHNNLj6Ged2qPqz982BVVHYnmitSIhT6nwPaBfFvhn
 f9x5my6R115RfmPThi9yLCcdx2UkWf5aS72N1l0FWPPDLHJzE3zg3kT+UKX/u+oHVpoC
 LZsAYrRhz8FchjJPLuOKtOEmPvA5HXEMK5d1xaVWwnsyHYRGIqeVDY2i8w/Ax816tFhx
 y+oxgt4ch7nwt9gn9QdoKtNdPvM9vIAiSX9d5xSDgQw6NJ2TbCd8CqgSV+V1QupnLFcY
 lnXrt7Qx24V8tMIFXYJ1IJ3XIIu041NJrduJa29fp6ySgb3bUCon9cJj3k94nnVbG1Mv
 7ZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506713; x=1741111513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EC8IF2fsP3QA1UeWRpuXQQkqxhpY7selzaVRXFP1UlM=;
 b=HEnoXTcWmTOZSJ27JqH9pvsItCwFM+4VKa1qEGb3OycTFVIFCi8Ny2Q7+HaafDtJ7e
 ZucSQnzEQROZnWQZiNQJZDPnvByldPon22BIdU/eYXo+C1fZLq2EuSgOsyE3waclVmyA
 hUScQokWlzXyH8vkvmP9O5E3V8Ba2StKprpVc4vZl2OIk7j2W12A671MTmnuJYvRRegQ
 f7UoBkyNADG6vtPkfys5tAB38fvp16p2dt/XOrnCgiQZ05spJt0IHxsxyA+JYf0SqmQ+
 7lW4XM79f/qrhqN3ziHGRf7YuLTzMWHMwJIsyRNIY3DgPwvJie5HmCOz+jH4Um/BHVuP
 WyRw==
X-Gm-Message-State: AOJu0YxskqPFPnziCJFrlVHq49G5wxFBs1+7Egwmqtc2nJWvr1R4GAsY
 N6C1DyL6on8X4Fs9qNr5F0DfQC9ekKH47NtChjqei1w1qfQQliTeXoq/IE/AV4qWqYgYPdJzv6Y
 9
X-Gm-Gg: ASbGncvX8AMDpzBPUaJ0aNHMp2Uy75Z2+3ombBjGdqElG4kRot0sZCNtN7H+KtqLsSb
 cChnaZhXk7vu9Ypckt6ZIR4iMGaOswOvDhK27X8x9bzpaQrMoi9aW2OI9gGT99JNs7isQpkUiVJ
 i3hF2i7Q6wwmoiOcU6UaizCcFY6chvVeXis9d0a2HWzSB4LpJdh7SGHCogKO5Ez7+IWZ74277jS
 skv1Lu6YQMEQu3eCP+dKaVbbarSkHzRKTs4JV1l027iq+Jgb2ft4f0735ykgmhMv90tIy4Saqnr
 L/xTkP0R6qOvFhS8+RoF2E+KHRbpzr5S
X-Google-Smtp-Source: AGHT+IGglvkixLE8mpZOsC7xmEJBTzQ1UDVOYNQ/QArMIZlNLpkh3nUKxw3Jxl2oxLt3zDyVlmkNWQ==
X-Received: by 2002:a5d:6d8f:0:b0:38f:5833:43ca with SMTP id
 ffacd0b85a97d-38f70772bb5mr15791121f8f.9.1740506712843; 
 Tue, 25 Feb 2025 10:05:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/43] target-arm queue
Date: Tue, 25 Feb 2025 18:04:26 +0000
Message-ID: <20250225180510.1318207-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Hi; here's another Arm pullreq: the big thing in here is
Bernhard's imx8mp-evk board model; there's also various cleanup
type patches from me, as well as some bugfixes.

thanks
-- PMM

The following changes since commit b69801dd6b1eb4d107f7c2f643adf0a4e3ec9124:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2025-02-22 05:06:39 +0800)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20250225

for you to fetch changes up to 1aaf3478684ff1cd02d1b36c32a00bfac9a5dbd5:

  hw/arm/fsl-imx8mp: Add on-chip RAM (2025-02-25 17:24:00 +0000)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/smmuv3: Fill u.f_cd_fetch.addr for SMMU_EVT_F_CD_FETCH
 * hw/arm/virt: Support larger highmem MMIO regions
 * machine: Centralize -machine dumpdtb option handling and report
   attempt to dump nonexistent DTB as an error
 * fpu: remove target ifdefs and build it only once
 * target/arm: Refactor to move TCG-only vfp_helper code into tcg/
 * target/arm/hvf: Disable SME feature
 * target/arm/hvf: sign extend the data for a load operation when SSE=1
 * hw/misc/npcm_clk: fix buffer-overflow
 * hw/arm: Add i.MX 8M Plus EVK board ("imx8mp-evk")

----------------------------------------------------------------
Bernhard Beschow (16):
      hw/usb/hcd-dwc3: Align global registers size with Linux
      hw/pci-host/designware: Prevent device attachment on internal PCIe root bus
      hw/gpio/pca955*: Move Kconfig switches next to implementations
      hw/arm: Add i.MX 8M Plus EVK board
      hw/arm/fsl-imx8mp: Implement clock tree
      hw/arm/fsl-imx8mp: Add SNVS
      hw/arm/fsl-imx8mp: Add USDHC storage controllers
      hw/arm/fsl-imx8mp: Add PCIe support
      hw/arm/fsl-imx8mp: Add GPIO controllers
      hw/arm/fsl-imx8mp: Add I2C controllers
      hw/arm/fsl-imx8mp: Add SPI controllers
      hw/arm/fsl-imx8mp: Add watchdog support
      hw/arm/fsl-imx8mp: Implement general purpose timers
      hw/arm/fsl-imx8mp: Add Ethernet controller
      hw/arm/fsl-imx8mp: Add USB support
      hw/arm/fsl-imx8mp: Add on-chip RAM

Joelle van Dyne (2):
      target/arm/hvf: Disable SME feature
      target/arm/hvf: sign extend the data for a load operation when SSE=1

Matthew R. Ochs (1):
      hw/arm/virt: Support larger highmem MMIO regions

Nicolin Chen (1):
      hw/arm/smmuv3: Fill u.f_cd_fetch.addr for SMMU_EVT_F_CD_FETCH

Peter Maydell (22):
      monitor/hmp-cmds.c: Clean up hmp_dumpdtb printf
      hw/openrisc: Support monitor dumpdtb command
      hw/mips/boston: Check for error return from boston_fdt_filter()
      hw/mips/boston: Support dumpdtb monitor commands
      hw: Centralize handling of -machine dumpdtb option
      hw/core/machine.c: Make -machine dumpdtb=file.dtb with no DTB an error
      fpu: Make targets specify floatx80 default Inf at runtime
      target/m68k: Avoid using floatx80_infinity global const
      target/i386: Avoid using floatx80_infinity global const
      fpu: Pass float_status to floatx80_is_infinity()
      fpu: Make targets specify whether floatx80 Inf can have Int bit clear
      fpu: Pass float_status to floatx80_invalid_encoding()
      fpu: Make floatx80 invalid encoding settable at runtime
      fpu: Move m68k_denormal fmt flag into floatx80_behaviour
      fpu: Always decide no_signaling_nans() at runtime
      fpu: Always decide snan_bit_is_one() at runtime
      fpu: Don't compile-time disable hardfloat for PPC targets
      fpu: Build only once
      target/arm: Move TCG-only VFP code into tcg/ subdir
      target/arm: Move FPSCR get/set helpers to tcg/vfp_helper.c
      target/arm: Move softfloat specific FPCR/FPSR handling to tcg/
      target/arm: Rename vfp_helper.c to vfp_fpscr.c

Pierrick Bouvier (1):
      hw/misc/npcm_clk: fix buffer-overflow

 MAINTAINERS                         |  13 +
 docs/system/arm/imx8mp-evk.rst      |  70 ++++
 docs/system/arm/virt.rst            |   4 +
 docs/system/target-arm.rst          |   1 +
 include/fpu/softfloat-helpers.h     |  12 +
 include/fpu/softfloat-types.h       |  51 +++
 include/fpu/softfloat.h             |  91 ++---
 include/hw/arm/fsl-imx8mp.h         | 284 ++++++++++++++
 include/hw/loader-fit.h             |  21 +-
 include/hw/misc/imx8mp_analog.h     |  81 ++++
 include/hw/misc/imx8mp_ccm.h        |  30 ++
 include/hw/openrisc/boot.h          |   3 +-
 include/hw/pci-host/designware.h    |   7 +
 include/hw/pci-host/fsl_imx8m_phy.h |  28 ++
 include/hw/timer/imx_gpt.h          |   1 +
 include/hw/usb/hcd-dwc3.h           |   2 +-
 include/system/device_tree.h        |   2 -
 target/arm/internals.h              |   9 +
 fpu/softfloat.c                     |  23 +-
 hw/arm/boot.c                       |   2 -
 hw/arm/fsl-imx8mp.c                 | 714 ++++++++++++++++++++++++++++++++++++
 hw/arm/imx8mp-evk.c                 |  74 ++++
 hw/arm/smmuv3.c                     |   2 +-
 hw/arm/virt.c                       |  52 ++-
 hw/core/loader-fit.c                |  38 +-
 hw/core/machine.c                   |  23 ++
 hw/loongarch/virt-fdt-build.c       |   1 -
 hw/mips/boston.c                    |  16 +-
 hw/misc/imx8mp_analog.c             | 160 ++++++++
 hw/misc/imx8mp_ccm.c                | 175 +++++++++
 hw/misc/npcm_clk.c                  |   5 +-
 hw/openrisc/boot.c                  |   8 +-
 hw/openrisc/openrisc_sim.c          |   2 +-
 hw/openrisc/virt.c                  |   2 +-
 hw/pci-host/designware.c            |  18 +-
 hw/pci-host/fsl_imx8m_phy.c         |  98 +++++
 hw/ppc/e500.c                       |   1 -
 hw/ppc/pegasos2.c                   |   1 -
 hw/ppc/pnv.c                        |   1 -
 hw/ppc/spapr.c                      |   1 -
 hw/riscv/boot.c                     |   2 -
 hw/timer/imx_gpt.c                  |  25 ++
 hw/usb/hcd-dwc3.c                   |   5 +
 monitor/hmp-cmds.c                  |   2 +-
 system/device_tree-stub.c           |   5 +-
 system/device_tree.c                |  22 +-
 target/arm/hvf/hvf.c                |  16 +
 target/arm/tcg-stubs.c              |  22 ++
 target/arm/{ => tcg}/vfp_helper.c   | 189 +---------
 target/arm/vfp_fpscr.c              | 155 ++++++++
 target/hppa/fpu_helper.c            |   1 +
 target/i386/tcg/fpu_helper.c        |  51 +--
 target/m68k/cpu.c                   |  35 ++
 target/m68k/fpu_helper.c            |   2 +-
 target/m68k/softfloat.c             |  47 +--
 target/sh4/cpu.c                    |   1 +
 fpu/softfloat-parts.c.inc           |  27 +-
 fpu/softfloat-specialize.c.inc      |  29 +-
 fpu/meson.build                     |   2 +-
 hw/arm/Kconfig                      |  24 ++
 hw/arm/meson.build                  |   2 +
 hw/gpio/Kconfig                     |   8 +
 hw/misc/Kconfig                     |  14 +-
 hw/misc/meson.build                 |   2 +
 hw/pci-host/Kconfig                 |   3 +
 hw/pci-host/meson.build             |   1 +
 target/arm/meson.build              |   2 +-
 target/arm/tcg/meson.build          |   1 +
 68 files changed, 2439 insertions(+), 383 deletions(-)
 create mode 100644 docs/system/arm/imx8mp-evk.rst
 create mode 100644 include/hw/arm/fsl-imx8mp.h
 create mode 100644 include/hw/misc/imx8mp_analog.h
 create mode 100644 include/hw/misc/imx8mp_ccm.h
 create mode 100644 include/hw/pci-host/fsl_imx8m_phy.h
 create mode 100644 hw/arm/fsl-imx8mp.c
 create mode 100644 hw/arm/imx8mp-evk.c
 create mode 100644 hw/misc/imx8mp_analog.c
 create mode 100644 hw/misc/imx8mp_ccm.c
 create mode 100644 hw/pci-host/fsl_imx8m_phy.c
 rename target/arm/{ => tcg}/vfp_helper.c (90%)
 create mode 100644 target/arm/vfp_fpscr.c

