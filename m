Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3376EE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPRe-0008Tm-8L; Wed, 11 Dec 2024 11:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRc-0008SP-TB
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:12 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRa-0007ZM-J8
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:12 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361a50e337so11076665e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934009; x=1734538809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=iyuNGqtPMNpkJD7hox7H695EjSntUvN4R/R5om7QWzM=;
 b=cc1fTl+mo6cLjOHQUZo89VRxiZ85Slhc8jK8gVp4CtoKFLYYNs8LVh/Y/Q9m7KytcO
 LgAhkG5rNgtb5daHJAsBcq4rFKhEAoIQcdYcmcE6/hW/6aGoT21/IBRXI+HF3+9w9NE8
 ywG9VimGysv/7po6Ij62U9SOy6k2mnOhbOhGGyAauhord3fuYOMQKb605J6ewij4gwbF
 VuX+1vVALpEJTy2+kXeUmjj83zcN1EITLboDMUOToDYBM2jGLlyPXdgmYKspJqhB1LLe
 IcJ/flluykvgb3g0QTGpTOR4cD17KgBl1yz2PBZWJLW+79OAHJp/e1W0stdNiWQvVDz/
 yDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934009; x=1734538809;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iyuNGqtPMNpkJD7hox7H695EjSntUvN4R/R5om7QWzM=;
 b=QInCBwR/AOy0LujVzE/AHmFXvS5ztINCxba3+CbpVM9uuHtmmvjIs9bqOg1i7RC2EB
 2PeY8gkDXTvamxxHyTSx2709V5fu1WpI0NT0mGfAIssQYnuNZljONVWPKcsNc+WNuBu9
 TXVPjZwCuam9kodDwGlJZJiLLLtPWOH3a7uWyzHW7+NWYuv4popwympaDWACjmyADdDh
 JwKLyvyeZMyaLqF4ule0PLyxRqEcl9pVHvoQyV0RRvTXgoEATrTQ4CcG2oGWZzmmqYp6
 bxfaNk1Y5jJ6BPjAhcLM/3amFkoCXSt5R0myp4IOzTutaHTETcs/QU5HaolOEOq3bcbo
 CPPw==
X-Gm-Message-State: AOJu0Yw84KGsKP1uUOcONipq4kGFQ7FEIJbXvEBQRC/GZWk7ed473Obd
 IT3ow0M58LCjNgYATgYb57N2fNp+P6MO7wUu92dUOygdwiRXhqvFjA3XSuq9c9KBHAOaKu63J5J
 Y
X-Gm-Gg: ASbGncvI71CLYGh9h/hqLOjYw5+tQioRHZJjNR2tFjPmd8F70ch64ynqENBnG5iMZ5W
 9lR3KWm27zVnXEkMhW0OBK64+m1KtZAqBCcPETurMVprm5oMIPFsLcBLvMoENDyfwEUpTHAzHgO
 xSFJAIJHlbY179otzYOptWvYfhK+79eXEj23qrzdM67zwB+QmZJhYlyQu+jMBe5nbEd11JnrdKm
 jy22eF0IzOPA5yriAiytHAIVNnheAk6HRhFc1LMm6yMlhIS0bYWQidbIXn7
X-Google-Smtp-Source: AGHT+IFTZ2EmfdI0B6PO9OrnEEFnBrukjXIwE2PuMpiueW0SaQ5B9uQYzXvL+RWZyJB8gakPa8rKCg==
X-Received: by 2002:a05:600c:a011:b0:434:eb73:b0c0 with SMTP id
 5b1f17b1804b1-4361c38d930mr25033855e9.5.1733934008649; 
 Wed, 11 Dec 2024 08:20:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/72] target-arm queue
Date: Wed, 11 Dec 2024 16:18:52 +0000
Message-Id: <20241211162004.2795499-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

First arm pullreq of the cycle; this is mostly my softfloat NaN
handling series. (Lots more in my to-review queue, but I don't
like pullreqs growing too close to a hundred patches at a time :-))

thanks
-- PMM

The following changes since commit 97f2796a3736ed37a1b85dc1c76a6c45b829dd17:

  Open 10.0 development tree (2024-12-10 17:41:17 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20241211

for you to fetch changes up to 1abe28d519239eea5cf9620bb13149423e5665f8:

  MAINTAINERS: Add correct email address for Vikram Garhwal (2024-12-11 15:31:09 +0000)

----------------------------------------------------------------
target-arm queue:
 * hw/net/lan9118: Extract PHY model, reuse with imx_fec, fix bugs
 * fpu: Make muladd NaN handling runtime-selected, not compile-time
 * fpu: Make default NaN pattern runtime-selected, not compile-time
 * fpu: Minor NaN-related cleanups
 * MAINTAINERS: email address updates

----------------------------------------------------------------
Bernhard Beschow (5):
      hw/net/lan9118: Extract lan9118_phy
      hw/net/lan9118_phy: Reuse in imx_fec and consolidate implementations
      hw/net/lan9118_phy: Fix off-by-one error in MII_ANLPAR register
      hw/net/lan9118_phy: Reuse MII constants
      hw/net/lan9118_phy: Add missing 100 mbps full duplex advertisement

Leif Lindholm (1):
      MAINTAINERS: update email address for Leif Lindholm

Peter Maydell (54):
      fpu: handle raising Invalid for infzero in pick_nan_muladd
      fpu: Check for default_nan_mode before calling pickNaNMulAdd
      softfloat: Allow runtime choice of inf * 0 + NaN result
      tests/fp: Explicitly set inf-zero-nan rule
      target/arm: Set FloatInfZeroNaNRule explicitly
      target/s390: Set FloatInfZeroNaNRule explicitly
      target/ppc: Set FloatInfZeroNaNRule explicitly
      target/mips: Set FloatInfZeroNaNRule explicitly
      target/sparc: Set FloatInfZeroNaNRule explicitly
      target/xtensa: Set FloatInfZeroNaNRule explicitly
      target/x86: Set FloatInfZeroNaNRule explicitly
      target/loongarch: Set FloatInfZeroNaNRule explicitly
      target/hppa: Set FloatInfZeroNaNRule explicitly
      softfloat: Pass have_snan to pickNaNMulAdd
      softfloat: Allow runtime choice of NaN propagation for muladd
      tests/fp: Explicitly set 3-NaN propagation rule
      target/arm: Set Float3NaNPropRule explicitly
      target/loongarch: Set Float3NaNPropRule explicitly
      target/ppc: Set Float3NaNPropRule explicitly
      target/s390x: Set Float3NaNPropRule explicitly
      target/sparc: Set Float3NaNPropRule explicitly
      target/mips: Set Float3NaNPropRule explicitly
      target/xtensa: Set Float3NaNPropRule explicitly
      target/i386: Set Float3NaNPropRule explicitly
      target/hppa: Set Float3NaNPropRule explicitly
      fpu: Remove use_first_nan field from float_status
      target/m68k: Don't pass NULL float_status to floatx80_default_nan()
      softfloat: Create floatx80 default NaN from parts64_default_nan
      target/loongarch: Use normal float_status in fclass_s and fclass_d helpers
      target/m68k: In frem helper, initialize local float_status from env->fp_status
      target/m68k: Init local float_status from env fp_status in gdb get/set reg
      target/sparc: Initialize local scratch float_status from env->fp_status
      target/ppc: Use env->fp_status in helper_compute_fprf functions
      fpu: Allow runtime choice of default NaN value
      tests/fp: Set default NaN pattern explicitly
      target/microblaze: Set default NaN pattern explicitly
      target/i386: Set default NaN pattern explicitly
      target/hppa: Set default NaN pattern explicitly
      target/alpha: Set default NaN pattern explicitly
      target/arm: Set default NaN pattern explicitly
      target/loongarch: Set default NaN pattern explicitly
      target/m68k: Set default NaN pattern explicitly
      target/mips: Set default NaN pattern explicitly
      target/openrisc: Set default NaN pattern explicitly
      target/ppc: Set default NaN pattern explicitly
      target/sh4: Set default NaN pattern explicitly
      target/rx: Set default NaN pattern explicitly
      target/s390x: Set default NaN pattern explicitly
      target/sparc: Set default NaN pattern explicitly
      target/xtensa: Set default NaN pattern explicitly
      target/hexagon: Set default NaN pattern explicitly
      target/riscv: Set default NaN pattern explicitly
      target/tricore: Set default NaN pattern explicitly
      fpu: Remove default handling for dnan_pattern

Richard Henderson (11):
      target/arm: Copy entire float_status in is_ebf
      softfloat: Inline pickNaNMulAdd
      softfloat: Use goto for default nan case in pick_nan_muladd
      softfloat: Remove which from parts_pick_nan_muladd
      softfloat: Pad array size in pick_nan_muladd
      softfloat: Move propagateFloatx80NaN to softfloat.c
      softfloat: Use parts_pick_nan in propagateFloatx80NaN
      softfloat: Inline pickNaN
      softfloat: Share code between parts_pick_nan cases
      softfloat: Sink frac_cmp in parts_pick_nan until needed
      softfloat: Replace WHICH with RET in parts_pick_nan

Vikram Garhwal (1):
      MAINTAINERS: Add correct email address for Vikram Garhwal

 MAINTAINERS                       |   4 +-
 include/fpu/softfloat-helpers.h   |  38 +++-
 include/fpu/softfloat-types.h     |  89 +++++++-
 include/hw/net/imx_fec.h          |   9 +-
 include/hw/net/lan9118_phy.h      |  37 ++++
 include/hw/net/mii.h              |   6 +
 target/mips/fpu_helper.h          |  20 ++
 target/sparc/helper.h             |   4 +-
 fpu/softfloat.c                   |  19 ++
 hw/net/imx_fec.c                  | 146 ++------------
 hw/net/lan9118.c                  | 137 ++-----------
 hw/net/lan9118_phy.c              | 222 ++++++++++++++++++++
 linux-user/arm/nwfpe/fpa11.c      |   5 +
 target/alpha/cpu.c                |   2 +
 target/arm/cpu.c                  |  10 +
 target/arm/tcg/vec_helper.c       |  20 +-
 target/hexagon/cpu.c              |   2 +
 target/hppa/fpu_helper.c          |  12 ++
 target/i386/tcg/fpu_helper.c      |  12 ++
 target/loongarch/tcg/fpu_helper.c |  14 +-
 target/m68k/cpu.c                 |  14 +-
 target/m68k/fpu_helper.c          |   6 +-
 target/m68k/helper.c              |   6 +-
 target/microblaze/cpu.c           |   2 +
 target/mips/msa.c                 |  10 +
 target/openrisc/cpu.c             |   2 +
 target/ppc/cpu_init.c             |  19 ++
 target/ppc/fpu_helper.c           |   3 +-
 target/riscv/cpu.c                |   2 +
 target/rx/cpu.c                   |   2 +
 target/s390x/cpu.c                |   5 +
 target/sh4/cpu.c                  |   2 +
 target/sparc/cpu.c                |   6 +
 target/sparc/fop_helper.c         |   8 +-
 target/sparc/translate.c          |   4 +-
 target/tricore/helper.c           |   2 +
 target/xtensa/cpu.c               |   4 +
 target/xtensa/fpu_helper.c        |   3 +-
 tests/fp/fp-bench.c               |   7 +
 tests/fp/fp-test-log2.c           |   1 +
 tests/fp/fp-test.c                |   7 +
 fpu/softfloat-parts.c.inc         | 152 +++++++++++---
 fpu/softfloat-specialize.c.inc    | 412 ++------------------------------------
 .mailmap                          |   5 +-
 hw/net/Kconfig                    |   5 +
 hw/net/meson.build                |   1 +
 hw/net/trace-events               |  10 +-
 47 files changed, 778 insertions(+), 730 deletions(-)
 create mode 100644 include/hw/net/lan9118_phy.h
 create mode 100644 hw/net/lan9118_phy.c

