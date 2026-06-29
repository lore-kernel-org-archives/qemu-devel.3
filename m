Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131A3C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAfn-00070L-G0; Mon, 29 Jun 2026 08:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfF-0006p2-Ug
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:40 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfD-0007Dj-T7
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:00:37 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4720d22c94aso1280206f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734434; x=1783339234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=L4+oUxHgxKB40cj4ad5076sQjVD+HN+2kPtnRtKd2fM=;
 b=FnPsqaAX+i86kYyucODiBEwVUos3wGcuxydGQ5MOIGPTC3QOfhxrk5a6X6XJgAXkxK
 UYNoU0HokBhXCUEjo8yDCuPNUYX1WqrPLma0nQIt6NA2kS4oW/YXDeS5oMO7kSJY7uil
 2E50DxHjOw9Iv/40708Xom3vBWqhS36lcuv705xWPCqs39ac+4MVfbIKyS6M0KDGJMsP
 VD/xwsUF9qqnVOZkYzo/3mh+WoV4S7PrZPhhe6VEcyzaOy0meM/e/Ui5zpP98EcMeSp9
 6AhxVGrQtNMllutez53yHTboQW43WSCQhnz4d+UfiVx1PBK3LP9ytnDE8k6eHF5vyEFo
 ILpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734434; x=1783339234;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L4+oUxHgxKB40cj4ad5076sQjVD+HN+2kPtnRtKd2fM=;
 b=aNUEjE3lIXXmvsBUa25ganqWbi5nL5sAj7FaNyRr7DrghQlvmQ0cRSEN++Ry6U6t5b
 ZJvvdHXXPIZx9xBG90u3UEx6W2DiUuYDyKV3utpzyYuEn5XSyZwjF+xHtmpzRyJl1cSw
 cx6Vwh2TrjaGnX/FGMsXSLQOLvg7OuhSr3zJxNQoakD4CTuOKUZgkDNgRomh4Y/0eF0f
 2TRjmXsC1cefsDpBtVnZcd447WHYfJ87oeMbYNKq+P8cHamHdENNKzNYwh5gGuG0+fvh
 cgcPvWCoPrcRPnhw1MI99nfkDb+AdIZkHPx/8L+oKDoeoHJQ2xcyE6U6VEfooSgV0lEp
 dS3w==
X-Gm-Message-State: AOJu0YxaN+UXKGiRXwvvCckoTb9Oce1BeNrKKWHljqdWS43Ncwqh27Kk
 TfT2Ah/0MvuO6qNg0TFAIBk3cQgUw1kZvOPq25TSWooh+ybsTRD26Vj/R9whRq2vVgaqVq7P/Xo
 xpVBJ
X-Gm-Gg: AfdE7ckIU9mJWD7oZ8utS5/ZpWVvWSxcEUuYpnL95U/IkiCP/1my2vOpir3i3xpizBD
 o7cLcRHauBeoxuSGcI3oTcUnu4LlCOVstYmOdQnRHMaQ2MYND3p+xCef/KgTN9syyCmQ9I0x3xb
 tXkT+YUGK+VfFOnZfXo9ucyevk3zkeIeZYdEQZXlfYv8WgnJVShHpqfVSFBLkqYEO2HCD7nKxLj
 kKDuEjerJC4h4YkqXv+RUuZ1y+gPd2WFjXaeHItNOgc9MjOiHnWh0W/JCsC8FVfhqDQuTonY1bk
 Y/N1d//igKmWvWz60qz4+YH6gnTdH3MQGlnKNlmn8H+5yo/pXs20uzVx8YB/YPYbMI1jiNOA6Fk
 N1THAF43xL5j1+bkjxlf7prX98mjs9DklnIHa2iMsY750NlypA5YM7ciGPc3YM3KyUymTG6VMZM
 UaFdABXYmNnEVkkf2eHvwIppjw+YTMw6ut1lIVWajhJv7iZhes1bsKaTzDaJHX0o8JMeJv2Us+o
 RAch+6x9BY9LROzYV4AmZ35YA/6zt6E
X-Received: by 2002:a05:6000:2884:b0:44a:be4:d0e4 with SMTP id
 ffacd0b85a97d-46dc0e05339mr25866945f8f.25.1782734434112; 
 Mon, 29 Jun 2026 05:00:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/54] target-arm queue
Date: Mon, 29 Jun 2026 12:59:38 +0100
Message-ID: <20260629120032.1645265-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Hi; this pullreq has more work from RTH towards emulation of SME2p2,
support for FlexCAN emulation on sabrelite, RME GPC3, and a scatter
of other more minor changes.

thanks
-- PMM
 
The following changes since commit 20553466cc47af6a8c95f665b601fce3c852e503:

  Merge tag 'pbouvier/pr/docs-20260626' of https://gitlab.com/p-b-o/qemu into staging (2026-06-27 23:28:35 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260629

for you to fetch changes up to 94e3ad78004787b0dea9625544fb45d8cf037147:

  docs/system/arm/virt: Document accelerated SMMUv3 and Tegra241 CMDQV (2026-06-29 11:06:02 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/timer/imx_epit: Replace DPRINTF with trace events
target/arm: Enable SCTLR_EL1.EnFPM for user-only
target/arm: Implement FEAT_SME_F8F32
target/arm: Implement FEAT_SSVE_AES
target/arm: Implement FEAT_SME_F8F16
target/arm: GICv5: Fix some minor bugs
target/arm: Add GPC3 granule bypass windows
target/arm: Fix some minor timer related bugs
hw/arm/sabrelite: Add FlexCAN emulation
docs/system: add FEAT_ECV_POFF to the emulation list
docs/system/arm/virt: Document accelerated SMMUv3 and Tegra241 CMDQV

----------------------------------------------------------------
Alex Bennée (6):
      target/arm: split evaluation of CNTHCTL timer IRQ masks
      target/arm: trigger timer recalculation when toggling CNTHCTL:ECV
      target/arm: trigger timer recalc on SCR:ECVEN change
      target/arm: gate check on scr_el3 behind ARM_FEATURE_EL3 check
      target/arm: trigger timer recalc on HCR:(E2H|TGE) changes
      docs/system: add FEAT_ECV_POFF to the emulation list

Jim MacArthur (6):
      target/arm/tcg/cpu64.c: Extra test for GPC3.
      target/arm: Setup new registers for GPC3
      target/arm/ptw.c: Add Granule Bypass Windows
      target/arm/cpu-features.h: x-rme now means GPC3
      tests/tcg/aarch64/system: Alternative boot object for exception logging
      tests/tcg/aarch64/system/gpc-test.c: Basic test for granule protection check

Matyáš Bobek (7):
      hw/arm/sabrelite: Open code DEFINE_MACHINE_ARM
      hw/arm/sabrelite: Introduce class SabreliteMachineState
      hw/misc/imx6_ccm: Add PLL3 and CAN clock
      hw/net/can/flexcan: NXP FlexCAN core emulation
      hw/arm: Plug FlexCAN into FSL_IMX6 and Sabrelite
      tests: Add qtests for FlexCAN
      docs/arm/sabrelite: Mention FlexCAN support

Peter Maydell (5):
      arm/gicv5: Add URL to GICv5 specification
      target/arm: GICv5 cpuif: Recalculate IRQ/FIQ on ICC_PCR_EL1 write
      target/arm: GICv5 cpuif: Tag ICC_PPI_PRIORITYR<n> regs as ARM_CP_NO_RAW
      target/arm: GICv5 cpuif: Remove ICC_HAPR_EL1
      hw/intc/gicv5: Define and use GICV5_PENDING_IRQ_NONE

Richard Henderson (28):
      target/arm: Enable SCTLR_EL1.EnFPM for user-only
      target/arm: Implement EXPAND
      target/arm: Generalize sve_compact_[sd]
      target/arm: Implement COMPACT for byte/halfword
      target/arm: Implement FIRSTP, LASTP
      target/arm: Rename isar_feature_aa64_sve_aes
      target/arm: Implement FEAT_SSVE_AES
      target/arm: Use expand_pred_N for helper_sve_not_zpz_N
      target/arm: Move tile_vslice_{index, offset} to vec_internal.h
      target/arm: Implement FMOPA (widening, 4-way fp8 to fp32)
      target/arm: Implement FMLALL (multiple and single vector)
      target/arm: Implement FMLALL (multiple vector)
      target/arm: Implement FMLALL (multiple and indexed vector)
      target/arm: Implement FDOT (multiple and single vector)
      target/arm: Implement FDOT (multiple vector)
      target/arm: Implement FDOT (multiple and indexed vector)
      target/arm: Implement FVDOTB, FVDOTT
      target/arm: Enable FEAT_SME_F8F32 for -cpu max
      target/arm: Enable FADD/FSUB (half-precision) with FEAT_SME_F8F16
      target/arm: Rename SME FMLAL/FMLSL patterns
      target/arm: Implement FMLAL (multiple, multiple and single, FP8 to FP16)
      target/arm: Implement FMLAL (multiple and indexed, FP8 to FP16)
      target/arm: Implement FDOT (multiple, multiple and single, FP8 to FP16)
      target/arm: Implement FDOT (multiple and indexed, FP8 to FP16)
      target/arm: Implement FMOPA (widening, 2-way, FP8 to FP16)
      target/arm: Rename FVDOT pattern
      target/arm: Implement FVDOT (FP8 to FP16)
      target/arm: Enable FEAT_SME_F8F16 for -cpu max

Shameer Kolothum (1):
      docs/system/arm/virt: Document accelerated SMMUv3 and Tegra241 CMDQV

jack wang (1):
      hw/timer/imx_epit: Replace DPRINTF with trace events

 MAINTAINERS                               |    9 +
 bsd-user/aarch64/target_arch_elf.h        |    2 +-
 docs/system/arm/emulation.rst             |    4 +
 docs/system/arm/sabrelite.rst             |    1 +
 docs/system/arm/virt.rst                  |   26 +
 docs/system/devices/can.rst               |   24 +
 hw/arm/Kconfig                            |    1 +
 hw/arm/fsl-imx6.c                         |   29 +
 hw/arm/sabrelite.c                        |   68 +-
 hw/intc/arm_gicv5.c                       |   11 +-
 hw/misc/imx6_ccm.c                        |   24 +
 hw/misc/trace-events                      |    2 +
 hw/net/Kconfig                            |    5 +
 hw/net/can/flexcan.c                      | 1396 +++++++++++++++++++++++++++++
 hw/net/can/flexcan_regs.h                 |  197 ++++
 hw/net/can/meson.build                    |    1 +
 hw/net/can/trace-events                   |   18 +
 hw/timer/imx_epit.c                       |   25 +-
 hw/timer/trace-events                     |    6 +
 include/hw/arm/fsl-imx6.h                 |    6 +
 include/hw/intc/arm_gicv5_types.h         |    4 +
 include/hw/misc/imx6_ccm.h                |    4 +
 include/hw/misc/imx_ccm.h                 |    1 +
 include/hw/net/flexcan.h                  |  145 +++
 linux-user/aarch64/elfload.c              |    5 +-
 target/arm/cpu-features.h                 |   28 +-
 target/arm/cpu.c                          |    4 +
 target/arm/cpu.h                          |    7 +
 target/arm/helper.c                       |   52 +-
 target/arm/ptw.c                          |   77 ++
 target/arm/tcg/cpu64.c                    |    7 +-
 target/arm/tcg/fp8_helper.c               |  116 +++
 target/arm/tcg/gicv5-cpuif.c              |   29 +-
 target/arm/tcg/helper-fp8-defs.h          |    6 +
 target/arm/tcg/helper-sve-defs.h          |   10 +
 target/arm/tcg/sme.decode                 |   95 +-
 target/arm/tcg/sme_helper.c               |   33 -
 target/arm/tcg/sve.decode                 |    6 +-
 target/arm/tcg/sve_helper.c               |  150 +++-
 target/arm/tcg/translate-sme.c            |  148 ++-
 target/arm/tcg/translate-sve.c            |  105 ++-
 target/arm/tcg/vec_internal.h             |   31 +
 tests/qtest/flexcan-test.c                |  421 +++++++++
 tests/qtest/meson.build                   |    1 +
 tests/tcg/aarch64/Makefile.softmmu-target |   22 +-
 tests/tcg/aarch64/system/boot.S           |   65 ++
 tests/tcg/aarch64/system/boot.h           |   14 +
 tests/tcg/aarch64/system/gpc-test.c       |  165 ++++
 48 files changed, 3430 insertions(+), 176 deletions(-)
 create mode 100644 hw/net/can/flexcan.c
 create mode 100644 hw/net/can/flexcan_regs.h
 create mode 100644 include/hw/net/flexcan.h
 create mode 100644 tests/qtest/flexcan-test.c
 create mode 100644 tests/tcg/aarch64/system/boot.h
 create mode 100644 tests/tcg/aarch64/system/gpc-test.c

