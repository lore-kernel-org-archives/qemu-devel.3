Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5D1C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggiI-0006zs-QT; Mon, 06 Jul 2026 06:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggi7-0006xC-Ld
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggi5-0003EV-M4
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:37:59 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-493c83474ddso26354035e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334275; x=1783939075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Uuv/Xq1+VXgJvtaRfjzAEoh8NWvGfR0T7UoX7olQwLs=;
 b=KQzqjkbFQBmgjLtMVNnMAUXJRpu+wtdh86yEbNn9CSIDe35ycqSvudBErZw9pRrJy0
 xyheE7DwJxzPuQM4PpzoEUtbICDUhZ7ItOdQJJ3bM3IuZgyRos7jiR2eSM96Mda3Xvdm
 QLPAUSHUeXWPNyWiHsPLRzlZ61qloR3DUE07qbxoUjHi+W4BlII5IA2bC4H2d/rIItu/
 Yi2Em9QrL9Bq0LBBkD6639DCTO9otfdyXLDOYQgwH6D8N1mQI/3RWdWOwTTPuvwQpdN/
 0Cd3tVeGCXJ03CTmW+5UkBrNgEmb4LSyo7Yq5MHEjGd8O3ouY98/1SELeFNeZ+VRE41K
 oLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334275; x=1783939075;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uuv/Xq1+VXgJvtaRfjzAEoh8NWvGfR0T7UoX7olQwLs=;
 b=JectXZf1sjNsQAYmJZ1BKopq2VjTchXPyzdV+0kLVQ9L6D3oT7Bp1JlSjGEZFjWrUI
 OfK4ryhcZYShHsYvwzojMhKk/56B7gHJ5FbSUPYesSDlxWatG4EvZ8KvfOx+TG1T5/2c
 FxTaH4tWhluzg5v0uzJ0nWTK/MvloF4O+lArGiF3PB0mWvBmKoEComHwtwwG6FdirIFR
 GIXQM/mHE7hEFYu2gZTDa4ASm34dy2py4rd2IcXdC4A6N1k4K5ESUy6lXOEYYtHjmqms
 M9YkHPIJFCGtQr3C5JzBGgxfm0kQEO7OUH7ZCImkCHqBzMAxnPGUpxmR1Szev0GAKGD2
 pLzw==
X-Gm-Message-State: AOJu0Yw4ofwm6Twu/dHWq8cn6yg8Ov+ywHV8kGyAeSgWeLuOHlu1Pi7+
 oyaAZtNCr0HATwak1EOJ2Na7G7phC/OmzhysAypqHVCxpbgEtqIRPgBrvOysaoaPF9hmN3fKRJo
 I/TPBz8VyM+VK
X-Gm-Gg: AfdE7clmBht1UitDkNuMKb+2yamQV3RLAaz9u/MUYZ2qTx0YChEVVrFt600kWN0pgr9
 uzkt5vWHocqL7SU2ytb6QzN/L5tCTqQ/62eipRLf6ayUsW5i44kCTzVTO268ivOVda2nYebJWCh
 HuRlqJGNd4NAhIsdRe6gTN70EhueX9vrC8IcWPgG7poPGxsGJzIUqlPT+ZL1G7d5dmHwoUy4zjd
 8K/1uOdBHB37DaZsyUfKqtsiAoI2ANRDSvE3ueHEDBcYOQ3UPLtAaExIKl8R1ut5GUhZJtRKHti
 xInh2ugopIx7KBou9/ebWHYdg0kfWIq43EkpzkCMzzZIR3I3vOa5TSh7BeoT7j0F3+yQ80iZLK0
 a1OD09gn+zmEZAfztTYGN5K1Gw/c739wN5obXaoz65h9LlocfX6j0aRNLAD2SN2C1FzsvW75k/t
 jFAxQjt7X4eqWrLs6CmDoisGTIP2/5iMlanTUTD2Sdh46hM9Es5zmhE8nPeFootaqBtDDYkHHUK
 rOoKFlLPvJ9B5zDwqpvcw==
X-Received: by 2002:a05:600c:6792:b0:493:b4cf:d37f with SMTP id
 5b1f17b1804b1-493d11d7dd2mr109868445e9.16.1783334274725; 
 Mon, 06 Jul 2026 03:37:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.37.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:37:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/49] target-arm queue
Date: Mon,  6 Jul 2026 11:37:03 +0100
Message-ID: <20260706103752.320511-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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

Hi; here's hopefully the last pullreq for arm before softfreeze.
There's a mix here of bug fixes of various kinds plus support
for emulation of a few new CPU features.

thanks
-- PMM


The following changes since commit 4ee536fac748b70e6f3d8568ddd20cfbaa9cf7bf:

  Merge tag 'firmware-20260704-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-07-05 08:42:47 +0200)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260706

for you to fetch changes up to 3455eac92d3e4b70bc222d98268f092efd4f1934:

  target/arm: Define fields for NSACR (2026-07-06 11:32:01 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/net/fsl_etsec: validate FCB offsets in process_tx_fcb()
 * hw/arm/smmuv3-accel: Fix veventq read returning true on EAGAIN/EINTR
 * target/arm: Only evaluate SCR_EL3.PIEN if ARM_FEATURE_EL3 is present
 * hw/arm: use cortex-a9 mpcore base for CBAR on npcm7xx machines
 * docs/specs/fw_cfg: Document all architecture register layouts
 * hw/nvram/fw_cfg: Simplify functions so board models don't have
   the opportunity to create non-standard fw_cfg register layouts
 * hw/misc: use tracepoints rather than DPRINTF in imx ccm models
 * hw/arm: add support for shim loading
 * docs/system/arm: Document Zynq Buildroot boot
 * target/arm: Report correct syndrome to AArch32 EL2 for trapped
   Neon/VFP insns
 * target/arm: implement WFET to not be a NOP
 * target/arm: Emulate FEAT_SME_MOP4
 * target/arm: Emulate FEAT_FPRCVT
 * target/arm: Emulate FEAT_SSVE_FEXPA

----------------------------------------------------------------
Alex Bennée (7):
      hw/arm: use cortex-a9 mpcore base for CBAR on npcm7xx machines
      tests/functional: update anacapa-bmc image
      target/arm: do not clear halting reason in has_work helper
      target/arm: ensure we create the wxft_timer for all modes
      target/arm: implements SEV/SEVL for all modes
      target/arm: enable WFE sleeping for A-profile
      target/arm: implement WFET

Bin Meng (1):
      docs/system/arm: Document Zynq Buildroot boot

Feifan Qian (1):
      hw/net/fsl_etsec: validate FCB offsets in process_tx_fcb()

Gerd Hoffmann (3):
      hw/nvram: add load_image_to_fw_cfg_file()
      hw/i386: switch shim loading to load_image_to_fw_cfg_file
      hw/arm: add support for shim loading

Jason Wright (1):
      target/arm/hvf: seed NO_RAW ID registers from isar.idregs[] on vCPU init

Jim MacArthur (6):
      target/arm/tcg: Implement new instructions for FPRCVT
      target/arm/tcg: Allow vector FP conversions with FPRCVT
      target/arm/tcg/cpu64.c: Add FEAT_FPRCVT to cpu_max
      linux-user/aarch64/elfload.c: Add FPRCVT
      docs/system/arm: Add FEAT_FPRCVT to A-profile support
      tests/tcg/arm: Tests for new FPRCVT instructions

Oliver Upton (1):
      target/arm: Only evaluate SCR_EL3.PIEN if ARM_FEATURE_EL3 is present

Peter Maydell (10):
      docs/specs/fw_cfg: Document all architecture register layouts
      hw/nvram/fw_cfg: Enforce standard layout for fw_cfg_init_mem_dma()
      hw/nvram/fw_cfg: Enforce standard layout for x86 fw_cfg I/O ports
      hw/nvram/fw_cfg: Remove support for I/O port fw_cfg without DMA
      hw/nvram/fw_cfg: Document fw_cfg_init_mem_nodma()
      hw/misc/imx31_ccm: Replace DPRINTF with trace events
      target/arm: Separate out Neon from VFP access checks
      target/arm: Separate syndrome functions for A32 and A64
      target/arm: Report correct syndrome to AArch32 EL2 for trapped Neon/VFP insns
      target/arm: Define fields for NSACR

Richard Henderson (16):
      target/arm: Implement and enable FEAT_SSVE_FEXPA for -cpu max
      target/arm: Implement FMOP4 (non-widening) for float32
      target/arm: Implement FMOP4 (non-widening) for float16
      target/arm: Implement FMOP4 (non-widening) for float64
      target/arm: Implement BFMOP4 (non-widening)
      target/arm: Implement BFMOP4 (widening)
      target/arm: Implement FMOP4 (widening, 2-way fp16 to fp32)
      target/arm: Implement FMOP4 (widening, 4-way fp8 to fp32)
      target/arm: Implement FMOP4A (widening, 2-way, FP8 to FP16)
      target/arm: Implement SMOP4[AS] (2-way)
      target/arm: Implement SMOP4[AS] (4-way)
      target/arm: Implement SUMOP4[AS]
      target/arm: Implement UMOP4[AS] (2-way)
      target/arm: Implement UMOP4[AS] (4-way)
      target/arm: Implement USMOP4[AS]
      target/arm: Enable FEAT_SME_MOP4 for -cpu max

Shameer Kolothum (1):
      hw/arm/smmuv3-accel: Fix veventq read returning true on EAGAIN/EINTR

jack wang (2):
      hw/misc/imx_ccm: Replace DPRINTF with trace events
      hw/misc/imx25_ccm: Replace DPRINTF with trace events

 docs/specs/fw_cfg.rst                       |  28 +-
 docs/system/arm/emulation.rst               |   3 +
 docs/system/arm/xlnx-zynq.rst               |  54 +++-
 hw/arm/boot.c                               |   6 +
 hw/arm/npcm7xx.c                            |   2 +-
 hw/arm/smmuv3-accel-stubs.c                 |   6 +-
 hw/arm/smmuv3-accel.c                       |  30 ++-
 hw/arm/smmuv3-accel.h                       |   4 +-
 hw/arm/tegra241-cmdqv.c                     |  11 +-
 hw/arm/virt.c                               |   2 +-
 hw/i386/fw_cfg.c                            |   3 +-
 hw/i386/microvm.c                           |   3 +-
 hw/i386/pc.c                                |   3 +-
 hw/i386/x86-common.c                        |  15 +-
 hw/loongarch/fw_cfg.c                       |   3 +-
 hw/misc/imx25_ccm.c                         |  32 +--
 hw/misc/imx31_ccm.c                         |  33 +--
 hw/misc/imx_ccm.c                           |  18 +-
 hw/misc/trace-events                        |  23 ++
 hw/net/fsl_etsec/rings.c                    |  27 +-
 hw/nvram/fw_cfg.c                           |  44 +++-
 hw/riscv/virt.c                             |   3 +-
 include/hw/arm/boot.h                       |   1 +
 include/hw/core/sysemu-cpu-ops.h            |   3 +
 include/hw/nvram/fw_cfg.h                   |  73 +++++-
 linux-user/aarch64/elfload.c                |   3 +
 target/arm/cpu-features.h                   |  45 ++++
 target/arm/cpu.c                            |  25 +-
 target/arm/cpu.h                            |   2 +-
 target/arm/helper.c                         |  10 +-
 target/arm/hvf/hvf.c                        |  10 +-
 target/arm/hvf/sysreg.c.inc                 |   2 +-
 target/arm/internals.h                      |   8 +
 target/arm/ptw.c                            |   9 +-
 target/arm/syndrome.h                       |  28 +-
 target/arm/tcg/a32.decode                   |   5 +-
 target/arm/tcg/a64.decode                   |  20 +-
 target/arm/tcg/cpu64.c                      |   3 +
 target/arm/tcg/fp8_helper.c                 |  32 +++
 target/arm/tcg/helper-defs.h                |   3 +-
 target/arm/tcg/helper-fp8-defs.h            |   3 +
 target/arm/tcg/helper-sme-defs.h            |  49 ++++
 target/arm/tcg/op_helper.c                  | 258 ++++++++++++++++--
 target/arm/tcg/sme.decode                   |  45 ++++
 target/arm/tcg/sme_helper.c                 | 390 ++++++++++++++++++++++++++++
 target/arm/tcg/t16.decode                   |   4 +-
 target/arm/tcg/t32.decode                   |   4 +-
 target/arm/tcg/translate-a32.h              |   1 +
 target/arm/tcg/translate-a64.c              | 139 +++++++---
 target/arm/tcg/translate-neon.c             |  74 +++---
 target/arm/tcg/translate-sme.c              | 130 ++++++++++
 target/arm/tcg/translate-sve.c              |  21 +-
 target/arm/tcg/translate-vfp.c              |  60 +++--
 target/arm/tcg/translate.c                  |  34 +--
 target/arm/tcg/translate.h                  |  23 ++
 target/arm/tcg/vec_internal.h               |   8 +
 tests/functional/arm/test_aspeed_anacapa.py |   4 +-
 tests/tcg/aarch64/Makefile.target           |  14 +-
 tests/tcg/arm/fcvt.c                        |   7 +
 59 files changed, 1576 insertions(+), 327 deletions(-)

