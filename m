Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764DCCD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7Q-0000k3-Vl; Fri, 15 May 2026 06:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq78-0000bl-EA
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:49:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq75-00018a-V4
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:49:54 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso79897125e9.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842190; x=1779446990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=aywh+8eWAZV8dVW/RYgh9Q/ZBZROUSaciqxOFRFzbXs=;
 b=McsHVS5dHP+Qf3CJQuUo3wZpl7Jkb5iJh4Y1aGzRapcXxJdD63Jb0knQox1mFEtbGF
 4Lscig0YH7j4PCg9Ek+Bfn0SqIpQz4UJqo1en1zwuN4O+zwpU3Qxt4bCp/UbDZ8xJ4j3
 2xcqD2T/vPLjFfyBelo9lJkKDfCzM8R5tDBie/e2UNqDSN8GovqQA9nOpkeQhzvmdIMO
 08yObbriEXtKvMNA0L2hDJIFWXobm5Y/yOFMCTk/eqgnmzVPUBBvYfoLkv2oR9UJwgXH
 na53esyTFjo3LZM5GKtNUnSF1fV//m8N0jaH9rWxu6P2U0N/cLwSt8vvEXH/pMlEDmFE
 Zsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842190; x=1779446990;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aywh+8eWAZV8dVW/RYgh9Q/ZBZROUSaciqxOFRFzbXs=;
 b=TGDK5LYauFwLj0Gq1rzvP657daQ4xxcI941GUjKZcmLw5MDJB1yFzFCmk8uqTe3Ymw
 YrOlFlb2GhVfAteLSGZm1EIjFW0x6230jHVsIzy604ZYEufa6MuSBCPwXmSH6XzZcmF6
 xopurjsUNdGApLKMv2rsT+uWy6XkyCbf9ZQV9iE/ufYd9adybLU5op+b9HGFZ/Se4YIT
 KTOhTvXwTAypaxjAug1lDKf3mJPFz/f5cSroEJF9Qv4VyvLwAX6NQSV1TuAwB3fijr2G
 xTrGuheFDs14Sq1zrevoX8iqhzhH3FiwO9fUg2FyYKDz57V6P6domi1iQH3eEJdd49bB
 ke7w==
X-Gm-Message-State: AOJu0YyK6njegmf/10VbP+TFH0WUsHDr2uKzoi7O3IJ0c3eAPGn5aRjB
 jR4izzRK3ceaxRvhEctWZM3/gXH7AYSQGBuSwx1OeKBRHvoRvCDLO2Aj48Vh0r8zse70ya/GB4S
 1DcWW
X-Gm-Gg: Acq92OFA/mWMNdF0rrdOrXRB+t/HO+wurxuCGihKJdPr39VfEEEL3HhDM8mB24RoPl2
 kWcowdM2HkVOeo0htFJMs7/X9MVx59laPeFDMTnh33qTVrkrQLuVSpO+qslalLP9FGnuCUKUTPC
 eKh9bpewGAVwgS9WVz/FSe58rf+CVwxoGtu743EUJ3RCB0nMMix75q2FYZu5fgswdoioouCo6TY
 PNkxKG17fXof/hTPwnOgeMLzeQGnnSuLqXtRU2LUP/sejZIHNKTin3nOT6H4Mp6RRPcxC06kAfk
 Sk6+2DqGLZMTwHK1fdStkqj73lifdsyfucPoTa1JhNDh78T6O2vW+qMUYKx0bLvc7ig3x1SBtcA
 5NW1Rb6m4Nb1Fr71DxIrSKMH70mceEk1Q2leffGkxQkRpAMfZs7z//KY2TuJEZHPQkvMNX7yPqZ
 hiPB7DnzORCCBrstxwZ00EAcsm1jL+2Iw2wX/88JwkTFp9CDnyFVFGkwTX41z+Mx1MkDDx0VYIE
 90M+9KwcvAlNGdXmBsJKa530rDyOJJs27eDwYTR7Q==
X-Received: by 2002:a05:600c:c0db:b0:48e:8499:4be0 with SMTP id
 5b1f17b1804b1-48fe60ee481mr35371715e9.15.1778842187120; 
 Fri, 15 May 2026 03:49:47 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.49.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:49:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/23] target-arm queue
Date: Fri, 15 May 2026 11:49:22 +0100
Message-ID: <20260515104945.4145203-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi; here's an arm pullreq. This is pretty much all bugfixes;
it includes a few items not strictly arm-specific which I've
put in here since I was rolling the pullreq anyway.

thanks
-- PMM

The following changes since commit edcc429e9e41a8e0e415dcdab6aa52ad17ef8889:

  Merge tag 'pbouvier/pr/docs-20260513' of https://gitlab.com/p-b-o/qemu into staging (2026-05-14 10:18:06 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260515

for you to fetch changes up to a86024eb2df56f7664cef16ec8e9a50a1dc3dd2f:

  target/arm/hvf: Fix WFI halting to stop idle vCPU spinning (2026-05-15 09:55:25 +0100)

----------------------------------------------------------------
target-arm queue:
 * docs: Document TIMEOUT_MULTIPLIER for raising test timeouts
 * meson.build: Add -fzero-init-padding-bits=all
 * hw/remote/machine.c: Mark x-remote machine as OK for AArch64 and AArch32
 * tests/functional: Fix tests to not fail on a KVM-only aarch64 build
 * target/arm: Rename Aarch64-specific methods
 * target/arm: Extract IDAU interface to its own unit
 * target/arm/hvf: Stop pre-allocating cpreg_vmstate arrays
 * target/arm/hvf: Fix WFI halting to stop idle vCPU spinning
 * GICv5: Fix minor bugs spotted by Coverity
 * hw/arm: Build ARM/HVF GICv3 stub once
 * hw/arm: fsl-imx8mm: Don't call qdev_get_machine in init
 * hw/misc/bcm2835_control.c: Don't assert on local timer zero reload value
 * hw/display/exynos4210_fimd: Assume display surface is 32bpp
 * hw/display/exynos4210_fimd: Use LOG_GUEST_ERROR instead of hw_error()
 * hw/arm/integratorcp: Use LOG_UNIMP rather than hw_error()
 * tests/functional/qemu_test/asset.py: Don't use setxattr when it doesn't exist

----------------------------------------------------------------
Peter Maydell (17):
      docs: Document TIMEOUT_MULTIPLIER for raising test timeouts
      target/arm: GICv5 cpuif: Fix overflow in left shift
      target/arm: GICv5 cpuif: Don't set HPPIV bit in GICv5PendingIrq::intid
      hw/intc/arm_gicv5: Avoid NULL dereference in trace line
      hw/intc/arm_gicv5: Add missing early return in gicv5_set_handling()
      meson.build: Add -fzero-init-padding-bits=all
      hw/misc/bcm2835_control.c: Don't assert on local timer zero reload value
      hw/arm/integratorcp: Use LOG_UNIMP rather than hw_error()
      hw/display/exynos4210_fimd: Use LOG_GUEST_ERROR instead of hw_error()
      hw/display/exynos4210_fimd: Assume display surface is 32bpp
      hw/remote/machine.c: Mark x-remote machine as OK for AArch64 and AArch32
      tests/functional/test_virt_vbsa: Skip UEFI test if virtualization not supported
      tests/functional/test_kvm.py: Use -cpu max, not cortex-a72
      tests/functional/test_kvm.py: Skip if virtualization not supported
      tests/functional/test_hotplug_pci.py: Require TCG
      tests/functional/test_tuxrun: Restrict to TCG
      tests/functional/qemu_test/asset.py: Don't use setxattr when it doesn't exist

Philippe Mathieu-Daudé (3):
      hw/arm: Build ARM/HVF GICv3 stub once
      target/arm: Rename Aarch64-specific methods
      target/arm: Extract IDAU interface to its own unit

Scott J. Goldman (2):
      target/arm/hvf: Stop pre-allocating cpreg_vmstate arrays
      target/arm/hvf: Fix WFI halting to stop idle vCPU spinning

Vineet Agarwal (1):
      hw/arm: fsl-imx8mm: Don't call qdev_get_machine in init

 docs/devel/testing/main.rst                  |  18 ++++
 hw/arm/armv7m.c                              |   2 +-
 hw/arm/fsl-imx8mm.c                          |  15 +--
 hw/arm/integratorcp.c                        |  16 ++-
 hw/display/exynos4210_fimd.c                 |  69 ++-----------
 hw/intc/arm_gicv5.c                          |   3 +-
 hw/intc/bcm2836_control.c                    |  15 ++-
 hw/intc/meson.build                          |   2 +-
 hw/remote/machine.c                          |   3 +
 include/hw/arm/armv7m.h                      |   2 +-
 include/hw/intc/arm_gicv5_types.h            |   2 +
 include/hw/misc/tz-msc.h                     |   2 +-
 include/system/hvf_int.h                     |   1 +
 meson.build                                  |   6 ++
 target/arm/cpu.c                             |  10 +-
 target/arm/cpu32-stubs.c                     |   8 +-
 target/arm/cpu64.c                           |  12 +--
 target/arm/hvf/hvf.c                         | 147 +++++++++++++++++++++++++--
 target/arm/internals.h                       |   8 +-
 target/arm/ptw.c                             |   2 +-
 target/arm/tcg/cpu32.c                       |   8 --
 target/arm/tcg/gicv5-cpuif.c                 |  26 ++---
 target/arm/tcg/idau.c                        |  20 ++++
 target/arm/{ => tcg}/idau.h                  |   0
 target/arm/tcg/meson.build                   |   1 +
 tests/functional/aarch64/test_hotplug_pci.py |   1 +
 tests/functional/aarch64/test_kvm.py         |  12 ++-
 tests/functional/aarch64/test_tuxrun.py      |   2 +
 tests/functional/aarch64/test_virt_vbsa.py   |  10 +-
 tests/functional/qemu_test/asset.py          |  13 ++-
 30 files changed, 298 insertions(+), 138 deletions(-)
 create mode 100644 target/arm/tcg/idau.c
 rename target/arm/{ => tcg}/idau.h (100%)

