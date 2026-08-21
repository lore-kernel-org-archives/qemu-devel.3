Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CB2C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMzr-0005vd-1n; Fri, 21 Aug 2026 07:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxMzp-0005vS-VU
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:13 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxMzn-0007Br-QY
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:13 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so758994f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310070; x=1787914870; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=x8kATNGhECSYOUpmrX42nNQ669XnIcT8QV3ke0Ntl80=;
 b=IVY4daX2kffxO6A3xLNPdQSw5+XdeVvs+mi6L05VWMYDoDI1cjTRuf4mMlD3jxlum7
 H1b3kxgQtdweoj3rlahlOKrKpHuuZg/8BSGcm2Tbba/5uQRiZqQOo15LiL0oKcdlWbSy
 ETri6UZXSNWrGsBk0DX2Y8ZRT16YkfprUN3cESK/HTUv+5FbwhKA9NWOVLmji4lr56Ny
 xmq6P5vnIesYLeYPkOPUHba6YoeE2ne+s2gc6BgUTpQsqJfmyWxlGpx7FNxWbeqzOld0
 9X3RJN2Vv1CW4PjK7vu+z5d6IcI+CegAg1m28eE2f1UQwXgcblj6SxO7i4c5EOYtEcqc
 vzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310070; x=1787914870;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x8kATNGhECSYOUpmrX42nNQ669XnIcT8QV3ke0Ntl80=;
 b=YKc7qIrz5AUPiPY8vx7D2nBuTLIztVQjVY0w6vQ495zDmQlyYT0Thh0GXQdxaUzd5+
 PaNd/6A/sIeAGbhc3DZr4cG7/BiIWaPxCdCM4++QkUtwCMInLQntns6aO0b6T82OqDqx
 hao53V8hzAX+djKjOFiTBIFVHMPtQTTtKO+0wMKwg/XrKfttO0TGuT64lhjntX4h02wB
 HNf9NP4rF0vAxw6aHgLT2526h35XhhlxhgCglflj3H6FTSgeeC3kOcQ6hdxz0n9ZbKBC
 kANTi1zHmROmebtZjZWCMCph53XPco9I61L9kK0vR8QVVEb/Jkq6Iujjr5wptwLEvPv2
 41iQ==
X-Gm-Message-State: AOJu0YyQxHW4yXuqFyAyfoKcOnBLB+bjtojkS7cDBI/lJPL+87BOebOa
 V0lCLFY5TWUQv+QBJhiS+VGh0a3U89Ef0tBESMUiEgTAyPosOD+ERWXMj0qSuR9I7MKcNo/dDz1
 73PJm
X-Gm-Gg: AR+sD12Rg9mNOrrrYHBofxOhzjvQHs0G2/iYM8vHNeigsP6sAoxjOKyUwWzEHWFHTT6
 G+zgj1KGIlZCexbzuIP0VR5FyuR427/vcC+vB8mR8KdADcalyzEXxqR1uosiCFdvxwHjf5/K4s1
 TxTDJeRlq3GOgQ4SJorVgpV9+zEetpDilSovFPZlcXIzYJtqz4UgzyynQbZYmU8zJLmLLFOTVVq
 sPyW4kbnmEmmbuERsq/OD8YSHuqprV1pJd+Kxqea7JLEh7nzkoVISBAyw7eQb8c2tYOiTjXtfTY
 FZB9oYSlUhK9Ed20IrTC7MyFCOLLJWUblmUmB92Aj/EHNLzV6xGYFrYXHPoSr8IuPPIju6n7yWi
 RjIivS+6sxIM8jM5lcxFJfMjUAT5Vh4K+leRgGzeB8CBa3AIIKBhPhN//78tTigBJdBkBWZ9ank
 1zx4lbJOjUO+Vnx0AZSiJMDaY8i7h0hgMdhsoxC35BkGv30zy2oCVou/Ym+MYW/tBG/z4cZdnEq
 0l9FA/QtGvqUc3XOVRKZQHJpSGNcBj3c+cYjHuY8ty+kKEHTeP79E56id1SfocaiMivzw==
X-Received: by 2002:a05:600c:8b0f:b0:496:c379:b2a1 with SMTP id
 5b1f17b1804b1-499b82e8e92mr87709465e9.2.1787310069900; 
 Fri, 21 Aug 2026 04:01:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.01.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:01:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/43] target-arm queue
Date: Fri, 21 Aug 2026 12:00:18 +0100
Message-ID: <20260821110101.3971391-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Hi; here's a target-arm pullreq. Most of this is refactoring/cleanup
work; there are also a few bugfixes.

thanks
-- PMM

The following changes since commit f57fc2f7ce667b6527582862e69d526edd3ee0e2:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-08-20 16:01:59 -0700)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260821

for you to fetch changes up to 37c0a0059db0dd6f35945196ddb17684c458886a:

  hw/arm: xilinx_zynq: Store boot info in the machine state (2026-08-21 10:28:10 +0100)

----------------------------------------------------------------
target-arm queue:
 * target/arm: Restrict arm_do_plugin_vcpu_discon_cb() to TCG
 * hw/intc: Fix kconfig handling for gicv3 when TCG disabled
 * target/arm: CPU refactoring to prepare for max-v8 and max-v9
 * hw/misc/iotkit-secctl.c: fix AHB secure read
 * target/arm: Fix SVE2 WHILEWR/WHILERW zero diff boundary case
 * hw/arm/ax3000-soc: fix heap overflow from missing class_size
 * target/arm: Implement AArch32 "disable Neon" and "disable
   VFP D16-D31 insns" CPACR/HCPTR/NSACR trap bits
 * hw/arm: put arm_boot_info structs into machine state struct

----------------------------------------------------------------
Bin Meng (20):
      hw/arm: aspeed: Store boot info in the machine state
      hw/arm: aspeed_ast27x0-fc: Store boot info in the machine state
      hw/arm: bananapi_m2u: Store boot info in the machine state
      hw/arm: collie: Store boot info in the machine state
      hw/arm: cubieboard: Store boot info in the machine state
      hw/arm: exynos4_boards: Store boot info in the board state
      hw/arm: imx25_pdk: Store boot info in the board state
      hw/arm: imx8mm-evk: Store boot info in the machine state
      hw/arm: integratorcp: Store boot info in the machine state
      hw/arm: kzm: Store boot info in the board state
      hw/arm: mcimx7d-sabre: Store boot info in the machine state
      hw/arm: musicpal: Store boot info in the machine state
      hw/arm: npcm7xx: Store boot info in the machine state
      hw/arm: npcm8xx: Store boot info in the machine state
      hw/arm: omap_sx1: Store boot info in the machine state
      hw/arm: orangepi: Store boot info in the machine state
      hw/arm: realview: Store boot info in the machine state
      hw/arm: sabrelite: Store boot info in the machine state
      hw/arm: versatilepb: Store boot info in the machine state
      hw/arm: xilinx_zynq: Store boot info in the machine state

Doug Cook (1):
      hw/arm/ax3000-soc: fix heap overflow from missing class_size

Peter Maydell (8):
      target/arm: Handle NSACR.NSASEDIS in CPACR accesses
      target/arm: Handle NSACR.NSASEDIS in HCPTR accesses
      target/arm: Update confusing comment in cpacr_write()
      target/arm: Add new feature ARM_FEATURE_NEON_TRAPS
      target/arm: Implement CPACR.ASEDIS and HCPTR.TASE
      target/arm: Pull VFP dregs checks out into a function
      target/arm: Implement CPACR.D32DIS
      target/arm: Pull Neon dregs checks out into a function

Philippe Mathieu-Daudé (2):
      target/arm: Restrict arm_do_plugin_vcpu_discon_cb() to TCG
      hw/intc/arm_gicv3: Have GIC kconfig select GICv3 for HVF and WHPX

Richard Henderson (11):
      hw/intc: Fix arm kvm gicv3 selection
      target/arm: Tidy cpu_max_initfn
      target/arm: Pass ARMCPU to aarch64_aa32_a57_init
      target/arm: Pass aarch64_enabled to aarch64_aa32_a57_init
      target/arm: Sink aarch64_aa32_a57_init into aarch64_max_tcg_initfn
      target/arm: Split out aarch32_max_tcg_init
      target/arm: Move aa32_max_features to tcg/cpu32.c
      target/arm: Annotate arch revisions in aarch64_max_tcg_initfn
      tcg: Export tcg_gen_ussub_i{32,64,tl}
      target/arm: Fix SVE2 WHILEWR/WHILERW zero diff boundary case
      tests/tcg/aarch64: Add regression test for whilewr/whilerw

Simon Xu (1):
      hw/misc/iotkit-secctl.c: fix AHB secure read

 hw/arm/aspeed.c                   |  17 +-
 hw/arm/aspeed_ast27x0-fc.c        |  13 +-
 hw/arm/ax3000-soc.c               |   1 +
 hw/arm/bananapi_m2u.c             |  21 ++-
 hw/arm/collie.c                   |  12 +-
 hw/arm/cubieboard.c               |  21 ++-
 hw/arm/exynos4_boards.c           |  26 ++--
 hw/arm/imx25_pdk.c                |  11 +-
 hw/arm/imx8mm-evk.c               |  29 ++--
 hw/arm/integratorcp.c             |  22 ++-
 hw/arm/kzm.c                      |  12 +-
 hw/arm/mcimx7d-sabre.c            |  28 ++--
 hw/arm/musicpal.c                 |  21 ++-
 hw/arm/npcm7xx.c                  |  26 ++--
 hw/arm/npcm7xx_boards.c           |  10 +-
 hw/arm/npcm8xx.c                  |  26 ++--
 hw/arm/npcm8xx_boards.c           |   2 +-
 hw/arm/omap_sx1.c                 |  19 ++-
 hw/arm/orangepi.c                 |  22 ++-
 hw/arm/realview.c                 |  27 ++--
 hw/arm/sabrelite.c                |  22 ++-
 hw/arm/versatilepb.c              |  16 +-
 hw/arm/xilinx_zynq.c              |  17 +-
 hw/intc/Kconfig                   |   2 +-
 hw/intc/meson.build               |   2 +-
 hw/misc/iotkit-secctl.c           |   2 +-
 include/hw/arm/aspeed.h           |   2 +
 include/hw/arm/npcm7xx.h          |  10 +-
 include/hw/arm/npcm8xx.h          |  10 +-
 include/hw/arm/xilinx_zynq.h      |   2 +
 include/tcg/tcg-op-common.h       |   2 +
 include/tcg/tcg-op.h              |   2 +
 target/arm/cpu-max.c              | 132 ++--------------
 target/arm/cpu.h                  |  17 ++
 target/arm/cpu64.c                |   3 +-
 target/arm/helper.c               |  97 ++++++++++--
 target/arm/internals.h            |   3 +-
 target/arm/tcg/cpu32.c            | 121 +++++++++++++++
 target/arm/tcg/cpu64.c            | 315 +++++++++++++++++++++-----------------
 target/arm/tcg/hflags.c           | 102 ++++++++++++
 target/arm/tcg/translate-neon.c   | 118 ++++++--------
 target/arm/tcg/translate-sve.c    |  38 +++--
 target/arm/tcg/translate-vfp.c    |  83 ++++++----
 target/arm/tcg/translate.c        |   8 +
 target/arm/tcg/translate.h        |   3 +
 tcg/tcg-op-gvec.c                 |  14 --
 tcg/tcg-op.c                      |  20 +++
 tests/tcg/aarch64/Makefile.target |   5 +-
 tests/tcg/aarch64/sve-while-ptr.c |  28 ++++
 49 files changed, 970 insertions(+), 592 deletions(-)
 create mode 100644 tests/tcg/aarch64/sve-while-ptr.c

