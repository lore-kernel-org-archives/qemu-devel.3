Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92000C021B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9Ip-0006fV-QZ; Thu, 20 Feb 2025 11:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9In-0006eo-Ig
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:29 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Il-00089g-EK
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:29 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-439946a49e1so7618725e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068485; x=1740673285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/ix9M9Uf7tMBPn78g6Olaq1AkEsI02MI9sVn7yq9CE=;
 b=exQyl630IIBWoVWoa7wo56808cFImikVMETDtU7WyEQxvkbGNED2ygYZ1q12j4xMqF
 4yZCBIm31iHb3pDsKv127nnPZ43sGRV/1g9xemmgG16fuBIYxGODHLttiEQ0PkeeF+wo
 NL4d3NtwUfJHUGZEd9FOlYh1TchbGLd8XVDzMDHMFCZ07sb/Wopuf2xWdCb/1jQoVz+R
 Ex+5nafYIwDvhx7PEAJhgBpkrK6QNGW+uOlvrlxs3OdfNSYmjfk1OxmxkHMuVuf4U8xn
 kauOlf3tEhc4voYcfTBKte7g4Rx5uGv7x8Yduj9DAe8HxNT44+S/3LUrOPgEHC0MaxSz
 FyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068485; x=1740673285;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/ix9M9Uf7tMBPn78g6Olaq1AkEsI02MI9sVn7yq9CE=;
 b=YAyBleSIokLRslhkAozmEILrfutI0rELdNvz+3vV4M4Tt4+hCb6wPuPYh9LZWvTLBX
 uUs58Khm3uL4wloF6e2t4qZDolmBXMUXnErCwwj0lFLLnmhW6DoecmMCM63S2AebziBe
 5xdGrNRp51p7HaKG193btxXXtZSiLXPbMOdBoYfAYMhF4rQqY64q2zaaSm1HCn36Y+Uy
 SNVZyEEN13PQzYi43xkw+KGVeVxtpEjUBy9+CSKoUYTO1LT7j13ICXaEbd+sAcIS5QSN
 WGdxroCYcfWTnMyVlf5w99SJtULoBA3iA3emIgTUgkI9iTSzaPsDhFiMKfKVWp1C+9VW
 xtsg==
X-Gm-Message-State: AOJu0YynBZTh6HXaecjA+hJRQwIOefpcvLQTga/TTJjcghPjOLJAbu70
 SusG1Bo86YO2V82nESHfvqVYj0pl4GvTUqdNv5RYLrFwUFu93pjcihSAMGxjTOzSPdk8+Vky27J
 j
X-Gm-Gg: ASbGncvzxq+kAotsOgktVeAai2Lip2cl6Enie2GOklv42eCKODpStJG9UB7oiJwsUj3
 lSdv0XL5xe1vQirYVeKmGMc0gUn/cMFW0/Hu1unfs+p8gnestwKI1r+4qTJG0fHWp7ngC96azqF
 2/EtIEThr9LCuHZPg/ixJxYjZ+w5gIEm/lskIaM7+SZ4oGr+lDTxG7eNidB6G4XhWbLsKzJ9ALZ
 8WTeGVi1mO9Hld9ZmKMmqOdU55yzx4yODgUITCn5FRQXvy0iyIbAyZdzPBz2dkFAFYFlcRMWg0t
 eRovRKCW4z8ESDs55MIyBA==
X-Google-Smtp-Source: AGHT+IEtCpUXpqyhKtN3EyhJxDrEpXvhTsfoi4aIIBUQqvpELfKBpTTowhLF6RfMnrd2fkFVQCp4dw==
X-Received: by 2002:a05:600c:1c90:b0:439:96b2:e8f with SMTP id
 5b1f17b1804b1-43999ddb0f4mr74734205e9.28.1740068485396; 
 Thu, 20 Feb 2025 08:21:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/41] target-arm queue
Date: Thu, 20 Feb 2025 16:20:41 +0000
Message-ID: <20250220162123.626941-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Hi; this pullreq contains a new board model npcm845-evb, plus some
more minor cleanups, refactorings and a few bugfixes.

thanks
-- PMM

The following changes since commit 40efe733e10cc00e4fb4f9f5790a28e744e63c62:

  Merge tag 'pull-tcg-20250215-3' of https://gitlab.com/rth7680/qemu into staging (2025-02-19 08:36:45 +0800)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20250220

for you to fetch changes up to 1c3169179b8242866316108386800379c4e22974:

  docs/system/arm: Add Description for NPCM8XX SoC (2025-02-20 15:22:22 +0000)

----------------------------------------------------------------
target-arm queue:
 * Fix some incorrect syndrome values in various sysreg traps
 * Clean up sysreg trap code to avoid similar future bugs
 * Make boards/SoCs using a9mpcore and a15mpcore objects specify
   number of GIC interrupts explicitly
 * Kconfig: Extract CONFIG_USB_CHIPIDEA from CONFIG_IMX
 * target/arm: Use uint32_t in t32_expandimm_imm()
 * New board model: NPCM845 Evaluation board "npcm845-evb"

----------------------------------------------------------------
Bernhard Beschow (1):
      Kconfig: Extract CONFIG_USB_CHIPIDEA from CONFIG_IMX

Hao Wu (17):
      roms: Update vbootrom to 1287b6e
      pc-bios: Add NPCM8XX vBootrom
      hw/ssi: Make flash size a property in NPCM7XX FIU
      hw/misc: Rename npcm7xx_gcr to npcm_gcr
      hw/misc: Move NPCM7XX GCR to NPCM GCR
      hw/misc: Add nr_regs and cold_reset_values to NPCM GCR
      hw/misc: Add support for NPCM8XX GCR
      hw/misc: Store DRAM size in NPCM8XX GCR Module
      hw/misc: Support 8-bytes memop in NPCM GCR module
      hw/misc: Rename npcm7xx_clk to npcm_clk
      hw/misc: Move NPCM7XX CLK to NPCM CLK
      hw/misc: Add nr_regs and cold_reset_values to NPCM CLK
      hw/misc: Support NPCM8XX CLK Module Registers
      hw/net: Add NPCM8XX PCS Module
      hw/arm: Add NPCM8XX SoC
      hw/arm: Add NPCM845 Evaluation board
      docs/system/arm: Add Description for NPCM8XX SoC

Peter Maydell (14):
      target/arm: Report correct syndrome for UNDEFINED CNTPS_*_EL1 from EL2 and NS EL1
      target/arm: Report correct syndrome for UNDEFINED AT ops with wrong NSE, NS
      target/arm: Report correct syndrome for UNDEFINED S1E2 AT ops at EL3
      target/arm: Report correct syndrome for UNDEFINED LOR sysregs when NS=0
      target/arm: Make CP_ACCESS_TRAPs to AArch32 EL3 be Monitor traps
      hw/intc/arm_gicv3_cpuif: Don't downgrade monitor traps for AArch32 EL3
      target/arm: Honour SDCR.TDCC and SCR.TERR in AArch32 EL3 non-Monitor modes
      hw/intc/arm_gicv3_cpuif(): Remove redundant tests of is_a64()
      target/arm: Support CP_ACCESS_TRAP_EL1 as a CPAccessResult
      target/arm: Use CP_ACCESS_TRAP_EL1 for traps that are always to EL1
      target/arm: Use TRAP_UNCATEGORIZED for XScale CPAR traps
      target/arm: Remove CP_ACCESS_TRAP handling
      target/arm: Rename CP_ACCESS_TRAP_UNCATEGORIZED to CP_ACCESS_UNDEFINED
      target/arm: Correct errors in WFI/WFE trapping

Philippe Mathieu-Daudé (8):
      hw/arm/exynos4210: Replace magic 32 by proper 'GIC_INTERNAL' definition
      hw/arm/exynos4210: Specify explicitly the GIC has 64 external IRQs
      hw/arm/realview: Specify explicitly the GIC has 64 external IRQs
      hw/arm/xilinx_zynq: Replace IRQ_OFFSET -> GIC_INTERNAL
      hw/arm/xilinx_zynq: Specify explicitly the GIC has 64 external IRQs
      hw/arm/vexpress: Specify explicitly the GIC has 64 external IRQs
      hw/arm/highbank: Specify explicitly the GIC has 128 external IRQs
      hw/cpu/arm_mpcore: Remove default values for GIC external IRQs

Stephen Longfield (1):
      target/arm: Use uint32_t in t32_expandimm_imm()

 MAINTAINERS                                   |   1 +
 docs/system/arm/nuvoton.rst                   |  27 +-
 configs/devices/aarch64-softmmu/default.mak   |   1 +
 include/hw/arm/npcm7xx.h                      |   8 +-
 include/hw/arm/npcm8xx.h                      | 127 ++++
 include/hw/misc/{npcm7xx_clk.h => npcm_clk.h} |  47 +-
 include/hw/misc/{npcm7xx_gcr.h => npcm_gcr.h} |  29 +-
 include/hw/net/npcm_pcs.h                     |  42 ++
 include/hw/ssi/npcm7xx_fiu.h                  |   1 +
 target/arm/cpregs.h                           |  15 +-
 target/arm/cpu.h                              |   6 +
 hw/arm/exynos4210.c                           |  10 +-
 hw/arm/highbank.c                             |   8 +-
 hw/arm/npcm7xx.c                              |   6 +
 hw/arm/npcm8xx.c                              | 805 ++++++++++++++++++++++++++
 hw/arm/npcm8xx_boards.c                       | 254 ++++++++
 hw/arm/realview.c                             |  11 +-
 hw/arm/vexpress.c                             |   7 +-
 hw/arm/xilinx_zynq.c                          |  43 +-
 hw/cpu/a15mpcore.c                            |  18 +-
 hw/cpu/a9mpcore.c                             |  18 +-
 hw/intc/arm_gicv3_cpuif.c                     |  15 +-
 hw/misc/npcm7xx_gcr.c                         | 264 ---------
 hw/misc/{npcm7xx_clk.c => npcm_clk.c}         | 235 ++++++--
 hw/misc/npcm_gcr.c                            | 482 +++++++++++++++
 hw/net/npcm_pcs.c                             | 410 +++++++++++++
 hw/ssi/npcm7xx_fiu.c                          |  16 +-
 target/arm/debug_helper.c                     |   5 +-
 target/arm/helper.c                           |  75 ++-
 target/arm/tcg/op_helper.c                    |  71 ++-
 target/arm/tcg/translate.c                    |   2 +-
 hw/arm/Kconfig                                |  19 +-
 hw/arm/meson.build                            |   1 +
 hw/misc/meson.build                           |   4 +-
 hw/misc/trace-events                          |  12 +-
 hw/net/meson.build                            |   1 +
 hw/net/trace-events                           |   4 +-
 hw/usb/Kconfig                                |   4 +
 hw/usb/meson.build                            |   2 +-
 pc-bios/README                                |   8 +-
 pc-bios/meson.build                           |   1 +
 pc-bios/npcm7xx_bootrom.bin                   | Bin 768 -> 768 bytes
 pc-bios/npcm8xx_bootrom.bin                   | Bin 0 -> 608 bytes
 roms/Makefile                                 |   6 +
 roms/vbootrom                                 |   2 +-
 45 files changed, 2626 insertions(+), 497 deletions(-)
 create mode 100644 include/hw/arm/npcm8xx.h
 rename include/hw/misc/{npcm7xx_clk.h => npcm_clk.h} (83%)
 rename include/hw/misc/{npcm7xx_gcr.h => npcm_gcr.h} (76%)
 create mode 100644 include/hw/net/npcm_pcs.h
 create mode 100644 hw/arm/npcm8xx.c
 create mode 100644 hw/arm/npcm8xx_boards.c
 delete mode 100644 hw/misc/npcm7xx_gcr.c
 rename hw/misc/{npcm7xx_clk.c => npcm_clk.c} (82%)
 create mode 100644 hw/misc/npcm_gcr.c
 create mode 100644 hw/net/npcm_pcs.c
 create mode 100644 pc-bios/npcm8xx_bootrom.bin

