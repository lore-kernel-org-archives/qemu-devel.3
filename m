Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB668CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmA-0008DS-CD; Tue, 26 May 2026 10:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsm8-0008CP-65
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:28:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsm6-0001CA-75
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:28:55 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49050ff7cbdso30551925e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805732; x=1780410532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wppMXjFVpebaRzAvfo8mnVAkaHSFewWVkK99AgKEJmE=;
 b=jxU7YHvZ9ATN5UA4XKJN1dYUVI0UKDOiKGEw7RQvI4bwFkz1fsKcMfRKqXerGPX67k
 o5pBSjRWIZTsM/9L5Iq31HOeaTRjRYaUjGBO9D0KhGiPTi2+V3JyqoeED53rJT9+x1p1
 wnQ2JuovbbTSfh36zCy+u2HER/JbrVMHYKI6IGPqNoZEG0jL8eEQgTmMLHwJQ0HEy8bV
 4gnhPjHIxGcFbw7/V1KXtTQYhkV7XJCotYDLvaX+aLC69ZfWZ4zDjeOnVRAJUyxChDhJ
 e6pTE7WrJZDoMi2KpgDIj4krCOTCuNMEaw9Csl+7y+SvBJXA6jVlVH03bEvvCzNbIFTR
 9G+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805732; x=1780410532;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wppMXjFVpebaRzAvfo8mnVAkaHSFewWVkK99AgKEJmE=;
 b=PEwreZ5GA0dRtUjzYpNcfoNXPE/FQt9RdlkMH7JEdZuuptnmRwGYb/HVFo8v9dtr2y
 V4hd17X/Ef5Iuu2jA5HpcditgfrVwv2ZRTXA8HGHwqaV91oxos9pDX8tPWGN1no41oi+
 pkNRwRsK/nyRDZxRgYJyHQsstIJNpmjneM/nFJNg255xtIPG3S//tVYlUzo/mDZsjDOL
 D8+TT4HMJIxs2D0Quf1wqXAYaZ1vJCkEl4+VlBAipfugPv4MOFHDej0USC3JFB5m/qXw
 jvv0s8Uh5ev5HuS61KCLwsP2R4JyYwttbyp5KvRODQSZdiIauqC7REzWtnPU56EH33Uv
 C0+w==
X-Gm-Message-State: AOJu0Yz9KX0m7PoTAccEODyK1NYFA4hPUdg07RMBWIA/xYviy7wdTda4
 JXD1zbb4HNvXdUVfjQUSvqXiMAGdni7D+S/2MQrdVL72mkKzAsYaHCE7dv/sEn+SiLUgPIuuKBW
 OtM/Q
X-Gm-Gg: Acq92OGYdUkaP0q5Gy+MjyIVf6/oA/FKOOkkNrUKZuk2UPmzR2/G45NOFomHQfDHX4D
 S8XpLWmHqchJ/eD4idXmmYfQaxM+ZUZRPeO6YdSTjy+NQ9b32tQ9wG5cFcM7EPEeJ7GslGUOLPU
 unXjkhmbVzlds2lrKpT+W+xGOGS69vvN+HraHA1ZMlZMQFvt39Iw4DiDm3UI1RkezYp+OF9v6Kv
 HwkdIH0hfqbfLxMr9b35bKbrUsGciGrWmgjG67QQBuH/8MqIKZeaKr3J0nfxQ2VHnFsTXMMRi2E
 0H5vUyiSr5eFNFj6aa5foEW+MNkBMGecafgDbtTzDm066P1jBPkwL8B44G0XHJwd1wH3ufOLzaz
 3sG0JBqwSrCzaGaqBoGPRC/TDOgf5EBLYx7MzYq+dIFkPFHowggdd9wavaC3zcPit96WriqKObU
 9oHBOFAVc8+l+BTOKKLSH8hii15m/YcK3T5G6e5Czlc1UdzJMCHeNn83UCbDyI/8R53m5oryUFy
 AjHECzq6SzMfv4spJQ6W1+NCzbkD38=
X-Received: by 2002:a05:600c:5288:b0:490:50e8:45c3 with SMTP id
 5b1f17b1804b1-49050e846f9mr248779865e9.0.1779805732116; 
 Tue, 26 May 2026 07:28:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.28.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:28:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/54] target-arm queue
Date: Tue, 26 May 2026 15:27:56 +0100
Message-ID: <20260526142850.2326589-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi; here's another arm pullreq. This one has in it some
bugfix/cleanup/refactoring bits and pieces from me, and the
first third of Richard's FP8 emulation work.

thanks
-- PMM

The following changes since commit cbf877d67a812be17a9ce404a589e1bdf722c1f6:

  Merge tag 'pbouvier/pr/docs-20260522' of https://gitlab.com/p-b-o/qemu into staging (2026-05-24 07:45:19 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260526

for you to fetch changes up to 1574211d1fd2052e90ede8865901c48fb391b132:

  target/arm: Move vectors_overlap to vec_internal.h (2026-05-26 11:41:00 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/timer/mss_timer: Remove dead code in timer_write()
 * OMAP: Remove various pieces of dead code
 * target/arm: Set debug in attrs in translate_for_debug()
 * target/arm/ptw: Flip sense of get_phys_addr_* return values
 * tests/functional/aarch64: Bump up timeout on vbsa
 * target/arm: Fix minor FEAT_AFP corner case bugs
 * target/arm: Implement FEAT_FAMINMAX
 * target/arm: Implement FEAT_FPMR
 * target/arm: Some initial patches towards other FP8 features

----------------------------------------------------------------
Peter Maydell (31):
      hw/timer/mss_timer: Remove dead code in timer_write()
      hw/arm/omap: Remove omap_mpu_model remnants
      hw/arm/omap: Remove unused omap_mpuio functions
      hw/arm/omap: Remove stray unused prototype
      hw/arm/omap: Remove unused omap1_dma_irq_map[] entries
      hw/arm/omap: Delete unused #defines
      hw/arm/omap: Remove unused wakeup irq
      hw/dma/omap_dma: Remove support for dma_3_0 and dma_3_2
      hw/dma/omap_dma: Fold omap_dma_sys_read() and omap_dma_sys_write() into callers
      hw/dma/omap_dma: Remove omap_3_1_compatible_disable flag
      hw/dma/omap_dma: Remove 3.1 mapping handling
      hw/dma/omap_dma: Drop model argument to omap_dma_init()
      target/arm: Set debug in attrs in translate_for_debug()
      target/arm/ptw: Flip sense of get_phys_addr_disabled return value
      target/arm/ptw: Flip sense of get_phys_addr_lpae return value
      target/arm/ptw: Flip sense of get_phys_addr_v6 return value
      target/arm/ptw: Flip sense of get_phys_addr_v5 return value
      target/arm/ptw: Flip sense of get_phys_addr_psmav5 return value
      target/arm/ptw: Flip sense of get_phys_addr_pmsav7 return value
      target/arm/ptw: Flip sense of get_phys_addr_pmsav8 return value
      target/arm/ptw: Flip sense of pmsav8_mpu_lookup return value
      target/arm/ptw: Flip sense of get_phys_addr_twostage return value
      target/arm/ptw: Flip sense of get_phys_addr_nogpc return value
      target/arm/ptw: Flip sense of get_phys_addr_gpc return value
      target/arm/ptw: Flip sense of arm_cpu_get_phys_addr return value
      target/arm/ptw: Flip sense of get_phys_addr_for_at return value
      target/arm/ptw: Flip sense of get_phys_addr return value
      tests/functional/aarch64: Bump up timeout on vbsa
      target/arm: SVE2 FMAXP, FMINP must honour AH=1
      target/arm: Use FPST_A64_F16 for SVE FCVTLT_hs
      target/arm: Set correct fp flags for FLOGB when FPCR.AH = 1

Pierrick Bouvier (1):
      tests/functional/aarch64/rme: update images to support FEAT_FP8

Richard Henderson (22):
      target/arm: Implement ID_AA64ISAR3
      target/arm: Implement FEAT_FAMINMAX for AdvSIMD
      target/arm: Implement FEAT_FAMINMAX for SME
      target/arm: Implement FEAT_FAMINMAX for SVE
      target/arm: Enable FEAT_FAMINMAX for -cpu max
      target/arm: Update SCR bits for Arm ARM M.a.a
      target/arm: Update HCRX bits for Arm ARM M.a.a
      target/arm: Introduce FPMR
      target/arm: Update SCTLR bits for FEAT_FPMR
      target/arm: Enable EnFPM bits for FEAT_FPMR
      target/arm: Clear FPMR on ResetSVEState
      target/arm: Add FPMR_EL to TBFLAGS
      target/arm: Trap direct acceses to FPMR
      target/arm: Dump FPMR when present
      linux-user/aarch64: Implement FPMR signal frames
      target/arm: Enable FEAT_FPMR for -cpu max
      target/arm: Implement ID_AA64FPFR0
      target/arm: Add isar_feature_aa64_f8cvt
      target/arm: Implement FSCALE for AdvSIMD
      target/arm: Implement FSCALE for SME
      target/arm: Split vector-type.h from cpu.h
      target/arm: Move vectors_overlap to vec_internal.h

 docs/system/arm/emulation.rst                |   2 +
 hw/arm/omap1.c                               |  84 +---
 hw/dma/omap_dma.c                            | 584 +++------------------------
 hw/gpio/omap_gpio.c                          |   6 -
 hw/misc/omap_clk.c                           |   9 +-
 hw/timer/mss-timer.c                         |  13 +-
 include/hw/arm/omap.h                        | 252 +-----------
 linux-user/aarch64/elfload.c                 |   2 +
 linux-user/aarch64/signal.c                  |  44 +-
 target/arm/cpregs.h                          |   5 +
 target/arm/cpu-features.h                    |  54 +++
 target/arm/cpu-sysregs.h.inc                 |   2 +
 target/arm/cpu.c                             |  11 +-
 target/arm/cpu.h                             |  52 +--
 target/arm/helper.c                          |  43 +-
 target/arm/internals.h                       |  17 +-
 target/arm/machine.c                         |  20 +
 target/arm/ptw.c                             |  83 ++--
 target/arm/tcg/a64.decode                    |   8 +
 target/arm/tcg/cpregs-at.c                   |  12 +-
 target/arm/tcg/cpu64.c                       |   8 +
 target/arm/tcg/helper-a64-defs.h             |  11 +
 target/arm/tcg/helper-sve-defs.h             |  28 ++
 target/arm/tcg/hflags.c                      |  42 ++
 target/arm/tcg/m_helper.c                    |   8 +-
 target/arm/tcg/sme.decode                    |  11 +
 target/arm/tcg/sme_helper.c                  |   6 -
 target/arm/tcg/sve.decode                    |   2 +
 target/arm/tcg/sve_helper.c                  |  25 +-
 target/arm/tcg/tlb_helper.c                  |   6 +-
 target/arm/tcg/translate-a64.c               |  26 ++
 target/arm/tcg/translate-sme.c               |  38 +-
 target/arm/tcg/translate-sve.c               |  26 +-
 target/arm/tcg/translate.h                   |  14 +
 target/arm/tcg/vec_helper64.c                |  42 ++
 target/arm/tcg/vec_internal.h                |  21 +
 target/arm/vector-type.h                     |  44 ++
 tests/functional/aarch64/meson.build         |   1 +
 tests/functional/aarch64/test_rme_sbsaref.py |   7 +-
 tests/functional/aarch64/test_rme_virt.py    |   7 +-
 40 files changed, 678 insertions(+), 998 deletions(-)
 create mode 100644 target/arm/vector-type.h

