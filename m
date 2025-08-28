Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C461CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uratx-0003E9-7S; Thu, 28 Aug 2025 07:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uratq-0003Bf-Bm
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:39 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uratn-0005Yh-IK
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:38 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45b7d497ab9so1632095e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380872; x=1756985672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vdgS+bBzmdmcMxq7nyqo2hsgXBl1TGBb/VN1PtoM/tU=;
 b=SB/89+5ulHWcbxH1+Ti0i25I2e2Ra+VKu/B4vl2aEwHHFUT6UHd048kHp8nEdMkUcS
 O9ZRunJ0ks4+KbwF3tP1Dnt6b8HzQYPY06xe8TI/4PSTD6l6ykCwxf9esGVNPhuXdGC9
 UtkNt3kLTtFtBBAtWVimcYS5e5VOPPCeE3zEe/xSFgOfjAdIUeC9a1bCf17KEAvU7CmT
 InoBpqnvukleEcTH6V9eWuHMTQeeM68/ZYozmPuaTaiMr/ajBpOBd6NPqSSneZsAyxIa
 z16xcn76BSD58xGQ6k7VO0DSFcregikfzcJJN5AtijQZiRA5Z12FDo9kd7mGvcIuxwWy
 GYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380872; x=1756985672;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vdgS+bBzmdmcMxq7nyqo2hsgXBl1TGBb/VN1PtoM/tU=;
 b=Ct8Ozg7+2H1I0jisUV4RTce7578DV2WrRXT6mOYuM1KkGmPsgLGH9EXE3stt9aOG/c
 WaLHqjmi52NNXfU5Zs+pHB7Btq26SYNnSxpH/ct15q7Dn6i1F4kQwYNnMWT9Q8VdkVGl
 zkD42wZTgrDoNTRtYlW3+iizphcE/i0RvTrGbgtZrKy4meB8CrJOX/cp6qRIJFVymUZU
 y9O+JnbQxCsY1PcP4DM6BCQ3bfQAn9x9KUkCmFOBXNRX1unwqr47NBLO0GHSVLNa1Sqo
 KVLy/TkxSG63x6YaysAn8j+7Oh3F9GqMH+jksEoDVTGuINt92tJfyWpR7lC86MANj2Ke
 lN0A==
X-Gm-Message-State: AOJu0YzolTGe6bf8c7/8y1SAND98LNq9+TmFPhUFxUcMAkjV1TUOTX7Z
 F8k9JXCbjb3+YRMo4BZR5Gxik20sSvhs4ngrrot0c1orVBp4r2w4onPw5YntpJHtqTvCFtTzoUC
 2YikQ
X-Gm-Gg: ASbGncvuf31Hs7fA9+yTHZAknHAbLaGAQiYpS1Avpe5WzGNQpdIqxtIS1essoV6fI6c
 v09DSLgvsznIB2orN16y+U4HEd/IumI6B6evRfB5vaT2lYvsqWKBxTc1+06UKDifbxYwSTjgu0q
 9XTe8hx4eiWJp+HSC04+bCBR5qqwY/euw1eslqx+RCAFaZ6RkBLT4eluhx2R3Tatw9xX8AXsEod
 mQ2rfaoHIdFaStzLaa8CZ/tH2rUDoBtk4q+tu9hf3QS6RRu8BZlXsqkqwJeDqpgV2AuxBxH1EOY
 NwRZ5U3JrLv+2BbA1MwSM+lUs8+qudlIAIU7Q2aYCo/LhoawY04YMBoF3Jm7vsQF5jCj05AWI9m
 mzu+p/ZDUPEN/4HJTSuthyZuGcGwE
X-Google-Smtp-Source: AGHT+IFQycRXlNe9sDzFeadV7E/MRXX3dC1YEDmNPVNY2v8Zp6uc6l3LkdZiPrnNOBNmvKV6SsaM8w==
X-Received: by 2002:a05:600c:1c09:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-45b68a59459mr76439595e9.20.1756380872390; 
 Thu, 28 Aug 2025 04:34:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/32] target-arm queue
Date: Thu, 28 Aug 2025 12:33:57 +0100
Message-ID: <20250828113430.3214314-1-peter.maydell@linaro.org>
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

Hi; here's the first target-arm pull for 10.2. Other than
Arm stuff I have included my update of kernel-doc to the new
upstream Python implementation.

thanks
-- PMM

The following changes since commit ca18b336e12c8433177a3cd639c5bf757952adaa:

  Merge tag 'pull-lu-20250828' of https://gitlab.com/rth7680/qemu into staging (2025-08-28 09:24:36 +1000)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20250828

for you to fetch changes up to fd0b04e944df2e308a95ce9933ca4c04b3875a11:

  hw/arm/stm32f205_soc: Don't leak TYPE_OR_IRQ objects (2025-08-28 10:26:25 +0100)

----------------------------------------------------------------
target-arm queue:
 * Implement FEAT_SCTLR2
 * Implement FEAT_TCR2
 * Implement FEAT_CSSC
 * Implement FEAT_LSE128
 * Clean up of register field definitions
 * Trap PMCR when MDCR_EL2.TPMCR is set
 * tests/functional: update aarch64 RME test images
 * hw/intc/arm_gicv3_kvm: preserve pending interrupts during cpr
 * hw/arm: add static NVDIMMs in device tree
 * hw/arm/stm32f205_soc: Don't leak TYPE_OR_IRQ objects
 * scripts/kernel-doc: Avoid new Perl precedence warning
 * scripts/kernel-doc: Update to kernel's new Python implementation

----------------------------------------------------------------
Gustavo Romero (3):
      target/arm: Clean up of register field definitions
      target/arm: Implement FEAT_SCTLR2 and enable with -cpu max
      target/arm: Implement FEAT_TCR2 and enable with -cpu max

Manos Pitsidianakis (1):
      hw/arm: add static NVDIMMs in device tree

Peter Maydell (12):
      target/arm: Implement CTZ, CNT, ABS
      scripts/kernel-doc: Avoid new Perl precedence warning
      docs/sphinx/kerneldoc.py: Handle new LINENO syntax
      tests/qtest/libqtest.h: Remove stray space from doc comment
      scripts: Import Python kerneldoc from Linux kernel
      scripts/kernel-doc: strip QEMU_ from function definitions
      scripts/kernel-doc: tweak for QEMU coding standards
      scripts/kerneldoc: Switch to the Python kernel-doc script
      scripts/kernel-doc: Delete the old Perl kernel-doc script
      MAINTAINERS: Put kernel-doc under the "docs build machinery" section
      target/arm: Correct condition of aa64_atomics feature function
      hw/arm/stm32f205_soc: Don't leak TYPE_OR_IRQ objects

Pierrick Bouvier (2):
      tests/functional/test_aarch64_device_passthrough: update image
      tests/functional/test_aarch64_rme: update image

Richard Henderson (12):
      target/arm: Add feature predicate for FEAT_CSSC
      target/arm: Implement MIN/MAX (immediate)
      target/arm: Implement MIN/MAX (register)
      target/arm: Split out gen_wrap2_i32 helper
      target/arm: Enable FEAT_CSSC for -cpu max
      qemu/atomic: Finish renaming atomic128-cas.h headers
      qemu/atomic: Add atomic16 primitives for xchg, fetch_and, fetch_or
      accel/tcg: Add cpu_atomic_*_mmu for 16-byte xchg, fetch_and, fetch_or
      tcg: Add tcg_gen_atomic_{xchg,fetch_and,fetch_or}_i128
      target/arm: Rename isar_feature_aa64_atomics
      target/arm: Implement FEAT_LSE128
      target/arm: Enable FEAT_LSE128 for -cpu max

Smail AIDER (1):
      target/arm: Trap PMCR when MDCR_EL2.TPMCR is set

Steve Sistare (1):
      hw/intc/arm_gicv3_kvm: preserve pending interrupts during cpr

 MAINTAINERS                                        |    3 +
 docs/conf.py                                       |    4 +-
 docs/sphinx/kerneldoc.py                           |    7 +-
 docs/system/arm/emulation.rst                      |    4 +
 accel/tcg/atomic_template.h                        |   80 +-
 accel/tcg/tcg-runtime.h                            |   12 +
 host/include/aarch64/host/atomic128-cas.h          |   45 -
 include/accel/tcg/cpu-ldst-common.h                |   13 +-
 include/hw/arm/stm32f205_soc.h                     |    2 +-
 include/hw/intc/arm_gicv3_common.h                 |    3 +
 include/tcg/tcg-op-common.h                        |    7 +
 include/tcg/tcg-op.h                               |    3 +
 target/arm/cpu-features.h                          |   24 +-
 target/arm/cpu.h                                   |   17 +
 target/arm/internals.h                             |   28 +-
 tests/qtest/libqtest.h                             |    2 +-
 host/include/aarch64/host/atomic128-cas.h.inc      |  102 +
 host/include/generic/host/atomic128-cas.h.inc      |   96 +
 target/arm/tcg/a64.decode                          |   26 +
 hw/arm/boot.c                                      |   42 +
 hw/arm/stm32f205_soc.c                             |   10 +-
 hw/arm/virt.c                                      |    8 +-
 hw/intc/arm_gicv3_kvm.c                            |   15 +
 linux-user/aarch64/elfload.c                       |    4 +-
 target/arm/cpregs-pmu.c                            |   34 +-
 target/arm/cpu.c                                   |    6 +
 target/arm/helper.c                                |  168 +-
 target/arm/ptw.c                                   |    8 +-
 target/arm/tcg/cpu64.c                             |    9 +-
 target/arm/tcg/translate-a64.c                     |  195 +-
 tcg/tcg-op-ldst.c                                  |   97 +-
 accel/tcg/atomic_common.c.inc                      |    9 +
 .editorconfig                                      |    2 +-
 scripts/kernel-doc                                 | 2442 --------------------
 scripts/kernel-doc.py                              |  325 +++
 scripts/lib/kdoc/kdoc_files.py                     |  291 +++
 scripts/lib/kdoc/kdoc_item.py                      |   42 +
 scripts/lib/kdoc/kdoc_output.py                    |  749 ++++++
 scripts/lib/kdoc/kdoc_parser.py                    | 1670 +++++++++++++
 scripts/lib/kdoc/kdoc_re.py                        |  270 +++
 .../functional/aarch64/test_device_passthrough.py  |   27 +-
 tests/functional/aarch64/test_rme_sbsaref.py       |   64 +-
 tests/functional/aarch64/test_rme_virt.py          |   85 +-
 43 files changed, 4388 insertions(+), 2662 deletions(-)
 delete mode 100644 host/include/aarch64/host/atomic128-cas.h
 create mode 100644 host/include/aarch64/host/atomic128-cas.h.inc
 delete mode 100755 scripts/kernel-doc
 create mode 100755 scripts/kernel-doc.py
 create mode 100644 scripts/lib/kdoc/kdoc_files.py
 create mode 100644 scripts/lib/kdoc/kdoc_item.py
 create mode 100644 scripts/lib/kdoc/kdoc_output.py
 create mode 100644 scripts/lib/kdoc/kdoc_parser.py
 create mode 100644 scripts/lib/kdoc/kdoc_re.py

