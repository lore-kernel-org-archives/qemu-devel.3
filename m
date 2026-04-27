Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F285BFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLNq-0007oz-73; Mon, 27 Apr 2026 08:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNH-0007kh-Mi
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:49 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNF-0005Ma-AY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:43 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so73658655e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294060; x=1777898860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4HJfZKY0Si1oliAKDNf9PjybD4rhGOV3GQjAdmihalU=;
 b=MTe0lmJHeyqOZL4Jgk+IjI7u96qXNBdokhbStVTRYY93yfun6Gb33XVhmTPYKFVQhE
 4h+VWaxxzl3BQIpLKBT+IPLEvggVtzlCO1GO6INORGCBIGcAAV4v8icx6RGSgKgrn2bB
 KKhhbrwhuOTfPrfYxOYrauEJFbzeSaxT3jCjf6MkjYaNiwRE40Wz1cGUfU4g+sA8lkL8
 pb3N7V4f3R/1ZFi50h/40Uj2dl+A1X90L5NG2iPGg/LrmcjOaGBJ+MCUeVs6dsg8sWA1
 AodriCUW6ZmvH82mmTJwXzDROM1a/8LazKw5fCxJIL++/8FDIVbSAHCf53O4AdlZ1dPh
 Bunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294060; x=1777898860;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4HJfZKY0Si1oliAKDNf9PjybD4rhGOV3GQjAdmihalU=;
 b=iUMdhCdsepyakyqPgDMkJp7wDmpLLWodt+8UN4W6W2XDnnSlTX1AzZRSh5fjGJDA6V
 Bvq8zi1pXI4dqv8rLho5wBBJz/Jfx3oXkHPjxBGLvLlusY0MdcWZLR/gOztCU1Jrnunp
 WHDrJB//5aZltdyDkf7mToLEZfBT5C2oBCYrOMpsYymPLmv/BKEFacqRP25F3b6xMdM9
 azDUfryTnaCisjpB6/yoJ0wENIHtFIDlVXzbXHaBd3n3KSXZKTKBMtuk287NSpB3ZG8q
 jlbDzCbAuhhlhNQaYJDPy8vs0bCY1UkTAW5qmZRQccvQb9CbMD/mHKd3RhCqAJugDiJo
 YNEQ==
X-Gm-Message-State: AOJu0Yyb9ZBUwtwHSgNquQwjaAs+jww9Frul41GNZPmw8T9rEM71jZnp
 f5Wx2WC50WDG1gqdIdDoPJ1Fl2FxwYndzlui4JFcjs3iHajxBs4T7uEQ5AWofXPBiHpPA6AHFG+
 WJyti
X-Gm-Gg: AeBDieslmNbNQIOlepB1pesN5mAzI5EK9PPwINRyStMmCz8iGWzTCHlMzBKcAiRolqx
 UDKnMeHoryF3KcNFJp4fT5gmglYsTprXuga8ePNnGHYBPiCLefDGbwgg17IHYPWeDBa85C7yWsh
 OnjDwqnUxIdcWbMLd0tM9c13/9NfLbqBSrUc1MfDBcEHCt03kiNbzmhClUnFxPvZrNZt5NK7Bad
 kVtpJcNUUVrfGiiZMvsWrE/un+jmeSdV+a1omChHz9YsWTWP933BtRFG1JBBOUk5GZXAg12FGy+
 hXECbr6b6ytmKKwiWCB3+7fKMk6h5oskdwfK4yqWaPUQH3WpcE2ruXg4dUXoq33FmAW403zQ55K
 bAAlE0kPTv4D/nDlYjkFAR78SLi+Eo2V2ALPpk4uv4inn/ZaXYiBwvJqum4v4VNJba/8Hvlh4CT
 HNJ856t+mZqX9jzzDTVIFF16rcfZKdMFTWCnViooSkvSZBpuq+GtGE+EWShB1h1NzpDSweOgL0R
 KTgCIHCTwPI5XV8ZeyYConbZuxFuyEQD9kfBo4D8A==
X-Received: by 2002:a05:600c:548a:b0:48a:75b9:b0bc with SMTP id
 5b1f17b1804b1-48a75b9b0c5mr15118835e9.29.1777294059389; 
 Mon, 27 Apr 2026 05:47:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/63] target-arm queue
Date: Mon, 27 Apr 2026 13:46:34 +0100
Message-ID: <20260427124738.966578-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi; here's another arm pullreq; main parts here are the
new i.MX 8MM EVK board, and a lot of refactoring.

thanks
-- PMM

The following changes since commit aa15257174da180c6a8a9d58f87319cfe61c5520:

  Merge tag 'pbouvier/pr/plugins-20260424' of https://gitlab.com/p-b-o/qemu into staging (2026-04-25 10:22:04 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260427

for you to fetch changes up to 4575da5ecb7a27544aa6da1f78e700e8100ceaea:

  target/arm: report register in WFIT syndromes (2026-04-27 11:46:34 +0100)

----------------------------------------------------------------
target-arm queue:
docs/system: add FEAT_AA32 and FEAT_AA64 to emulation list
hw/arm: Add the i.MX 8MM EVK(Evaluation Kit) board
target/arm: Build M-profile helper code once only
hw/arm: Remove hw_error() for the unimplemented CM_LMBUSCNT register
hw: Move ARM_SYSCTL_GPIO definitions to arm sysctl specific header
target/arm: Allow 'aarch64=off' to be set for TCG CPUs
target/arm: Allow some sysregs to not have to be an exact match for migration
hw/arm/raspi4b: NOP all DTB nodes when removing unimplemented devices
hw/arm/fsl-imx6ul: Implement LCDIF display device
target/arm: Refactor syndrome value code to use registerfields
target/arm: Report the register in WFxT syndromes

----------------------------------------------------------------
Alex Bennée (24):
      docs/system: add FEAT_AA32 and FEAT_AA64 to emulation list
      target/arm: migrate basic syndrome helpers to registerfields
      target/arm: migrate system/cp trap syndromes to registerfields
      target/arm: migrate FP/SIMD trap syndromes to registerfields
      target/arm: migrate eret trap syndromes to registerfields
      target/arm: migrate SME trap syndromes to registerfields
      target/arm: migrate PAC trap syndromes to registerfields
      target/arm: migrate BTI trap syndromes to registerfields
      target/arm: migrate BXJ trap syndromes to registerfields
      target/arm: migrate Granule Protection traps to registerfields
      target/arm: migrate fault syndromes to registerfields
      target/arm: migrate debug syndromes to registerfields
      target/arm: migrate wfx syndromes to registerfields
      target/arm: migrate gcs syndromes to registerfields
      target/arm: migrate memory op syndromes to registerfields
      target/arm: migrate check_hcr_el2_trap to use syndrome helper
      target/arm: use syndrome helpers in arm_cpu_do_interrupt_aarch32_hyp
      target/arm: use syndrome helpers to set SAME_EL EC bit
      target/arm: make whpx use syndrome helpers for decode
      target/arm: make hvf use syndrome helpers for decode
      target/arm: use syndrome helpers in merge_syn_data_abort
      target/arm: use syndrome helpers to query VNCR bit
      target/arm: remove old syndrome defines
      target/arm: report register in WFIT syndromes

Eric Auger (7):
      target/arm/cpu: Introduce the infrastructure for cpreg migration tolerances
      target/arm/machine: Handle ToleranceNotOnBothEnds migration tolerances
      target/arm/machine: Handle ToleranceOnlySrcTestValue migration tolerance
      target/arm/cpu64: Mitigate migration failures due to spurious TCR_EL1, PIRE0_EL1 and PIR_EL1
      target/arm/cpu64: Define cpreg migration tolerance for KVM_REG_ARM_VENDOR_HYP_BMAP_2
      target/arm/helper: Define cpreg migration tolerance for DGBDTR_EL0
      Revert "target/arm: Reinstate bogus AArch32 DBGDTRTX register for migration compat"

Gaurav Sharma (15):
      hw/arm: Add the i.MX 8MM EVK(Evaluation Kit) board
      hw/misc/imx8mp_analog: Add property to analog device
      hw/arm/fsl-imx8mm: Add Analog device IP to iMX8MM SOC
      hw/arm/fsl-imx8mm: Add Clock Control Module IP to iMX8MM
      hw/arm/fsl-imx8mm: Implemented support for SNVS
      hw/arm/fsl-imx8mm: Adding support for USDHC storage controllers
      hw/arm/fsl-imx8mm: Add PCIe support
      hw/arm/fsl-imx8mm: Add GPIO controllers
      hw/arm/fsl-imx8mm: Adding support for I2C emulation
      hw/arm/fsl-imx8mm: Adding support for SPI controller
      hw/arm/fsl-imx8mm: Adding support for Watchdog Timers
      hw/arm/fsl-imx8mm: Adding support for General Purpose Timers
      hw/arm/fsl-imx8mm: Adding support for ENET ethernet controller
      hw/arm/fsl-imx8mm: Adding support for USB controller
      hw/arm/fsl-imx8mm: Adding functional testing of iMX8MM emulation

Osama Abdelkader (1):
      hw/arm/raspi4b: NOP all DTB nodes when removing unimplemented devices

Peter Maydell (4):
      hw: Move ARM_SYSCTL_GPIO definitions to arm sysctl specific header
      target/arm: Clear AArch64 ID regs from ARMISARegisters if AArch64 disabled
      target/arm: Allow 'aarch64=off' to be set for TCG CPUs
      tests/functional/aarch64: Add basic test of TCG aarch64=off

Philippe Mathieu-Daudé (9):
      target/arm: Ignore endianness when setting MTE tags
      target/arm: Explode MO_TExx -> MO_TE | MO_xx
      target/arm: Hoist MO_TE into mve_advance_vpt()
      target/arm: Hoist MO_TE into MVE DO_VSTR() macro
      target/arm: Introduce mo_endian() helper
      target/arm: Replace MO_TE -> mo_endian() for MVE helpers
      target/arm: Compile mve_helper.c once
      target/arm: Replace MO_TE -> mo_endian() for Cortex-M helpers
      target/arm: Compile m_helper.c once

Thomas Huth (1):
      hw/arm: Remove hw_error() for the unimplemented CM_LMBUSCNT register

Yucai Liu (2):
      hw/display: Add i.MX6UL LCDIF device model
      hw/arm/fsl-imx6ul: Wire in the LCDIF device model

 MAINTAINERS                                       |  16 +-
 docs/system/arm/cpu-features.rst                  |  10 +-
 docs/system/arm/emulation.rst                     |   2 +
 docs/system/arm/{imx8mp-evk.rst => imx8m.rst}     |  49 +-
 docs/system/target-arm.rst                        |   2 +-
 hw/arm/Kconfig                                    |  25 +
 hw/arm/fsl-imx6ul.c                               |  12 +-
 hw/arm/fsl-imx8mm.c                               | 704 ++++++++++++++++++++++
 hw/arm/imx8mm-evk.c                               | 130 ++++
 hw/arm/integratorcp.c                             |   3 -
 hw/arm/meson.build                                |   2 +
 hw/arm/raspi4b.c                                  |  10 +-
 hw/arm/realview.c                                 |   2 +-
 hw/arm/vexpress.c                                 |   2 +-
 hw/arm/virt.c                                     |   1 -
 hw/display/Kconfig                                |   4 +
 hw/display/imx6ul_lcdif.c                         | 453 ++++++++++++++
 hw/display/meson.build                            |   1 +
 hw/misc/arm_sysctl.c                              |   2 +-
 hw/misc/imx8mp_analog.c                           |  12 +-
 hw/timer/imx_gpt.c                                |  26 +
 hw/vmapple/vmapple.c                              |   1 -
 include/hw/arm/fsl-imx6ul.h                       |   4 +-
 include/hw/arm/fsl-imx8mm.h                       | 242 ++++++++
 include/hw/arm/primecell.h                        |  12 -
 include/hw/display/imx6ul_lcdif.h                 |  37 ++
 include/hw/misc/arm_sysctl.h                      |  16 +
 include/hw/misc/imx8mp_analog.h                   |   3 +
 include/hw/timer/imx_gpt.h                        |   2 +
 target/arm/cpu-features.h                         |   5 +
 target/arm/cpu.c                                  | 153 ++++-
 target/arm/cpu.h                                  |   4 +-
 target/arm/cpu64.c                                |  39 ++
 target/arm/debug_helper.c                         |  29 -
 target/arm/helper.c                               |  27 +-
 target/arm/hvf/hvf.c                              |  14 +-
 target/arm/internals.h                            |  60 ++
 target/arm/machine.c                              |  33 +-
 target/arm/syndrome.h                             | 595 ++++++++++++++----
 target/arm/tcg/debug.c                            |   2 +-
 target/arm/tcg/helper-a64.c                       |   2 +-
 target/arm/tcg/helper-defs.h                      |   2 +-
 target/arm/tcg/m_helper.c                         |   8 +-
 target/arm/tcg/meson.build                        |   6 +-
 target/arm/tcg/mve_helper.c                       | 102 ++--
 target/arm/tcg/op_helper.c                        |   7 +-
 target/arm/tcg/tlb_helper.c                       |   6 +-
 target/arm/tcg/translate-a64.c                    |   2 +-
 target/arm/tcg/vfp_helper.c                       |   5 +-
 target/arm/trace-events                           |   2 +
 target/arm/whpx/whpx-all.c                        |  13 +-
 tests/functional/aarch64/meson.build              |   3 +
 tests/functional/aarch64/test_imx8mm_evk.py       |  69 +++
 tests/functional/aarch64/test_virt_aarch64_off.py |  37 ++
 tests/qtest/arm-cpu-features.c                    |   8 +-
 55 files changed, 2743 insertions(+), 275 deletions(-)
 rename docs/system/arm/{imx8mp-evk.rst => imx8m.rst} (58%)
 create mode 100644 hw/arm/fsl-imx8mm.c
 create mode 100644 hw/arm/imx8mm-evk.c
 create mode 100644 hw/display/imx6ul_lcdif.c
 create mode 100644 include/hw/arm/fsl-imx8mm.h
 delete mode 100644 include/hw/arm/primecell.h
 create mode 100644 include/hw/display/imx6ul_lcdif.h
 create mode 100644 include/hw/misc/arm_sysctl.h
 create mode 100755 tests/functional/aarch64/test_imx8mm_evk.py
 create mode 100755 tests/functional/aarch64/test_virt_aarch64_off.py

