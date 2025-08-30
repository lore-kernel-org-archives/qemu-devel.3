Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87689CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOxN-0006PR-74; Sat, 30 Aug 2025 13:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1usO86-0001Uo-AB
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 12:08:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1usO83-0004nT-Fj
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 12:08:38 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45b7e69570bso12741145e9.0
 for <qemu-devel@nongnu.org>; Sat, 30 Aug 2025 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756570111; x=1757174911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZJG+EL2FkF86nIqbkYC2ddXBgtdgaQw+zt6Oja+ef1w=;
 b=O2iUsHsORff4Yvih+pYRQsIgu3hCykMo7FrVoaJjPJ7YdwRL88JE1DddQibpoFv9hy
 ceqGSyZ6LztI4S9kdghs/rkhHghWFv+kpUoiYmRkftalghIcx+j6sTcaAOtOZvJOXt6S
 /XUx7JKoA1s8uy0HUGueoQc7g1RZdwoaN4twctALyeqSFAfkDR56rhFpoQl8cJYNfW7h
 Qb4TDExsMpI1SRq9wQ7iZgvQtbzhDsoTIra/8bnjj1mTsDeRY93fjHP4oWDoCob7Kjic
 1VOfcDcjM2Eu6c21JDdkrnapgG/ik2dEpSzDJ1lhocAQ8nrhzpXUaUX0qzMi+4AVXqcZ
 nNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756570111; x=1757174911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZJG+EL2FkF86nIqbkYC2ddXBgtdgaQw+zt6Oja+ef1w=;
 b=NJIddpVpCuoZBD4Is6OzNYVDHnPZSntyGJFkN0qicAdcY0P7Db2APXAnE1MDdh5AgB
 FQ7d2cdrn8ff0o922UVAoafkMb26j5k0Xqajwp/UY7E0S2Pn9/RR82QWHw0q2jUlGDbk
 SUtxDl9+59+uI3pEb3Jx/gsEGMuqHDQ5NC1A+CAbQQ9lKu6QN4CpwjN4sghr7R0x80mH
 p9xG+yOVPV1YI/Ecmy8c+Ku+59/193zZ9xtVaC5GKOjtgtynDyYTBImpMilLgJjaVbVH
 a3WwXotXczT3HK5OTmz8TPS7vSNPJcJsF4VNMH8jN0HovpF4kecdBRxey58xSsI1bNeK
 OjvA==
X-Gm-Message-State: AOJu0YzeqFZvnm93H4VUNSjBIPE7zoC4sd4QC79KmkJ4O5zi8KqtAAtG
 O5m8Kmf3ojCpCYqUVKX0pu2U6+18gSbN2B5GJbxlsrmbB1pXdcZcKWXDGMiU4u6kz1P5sGX21N5
 rMIO+
X-Gm-Gg: ASbGncsSeeH61a+6/JVlsvbIK382k7yP0ljHbJGQkT7Z+nKHH6Fm6skD+dZVHvrFS0p
 u4knbj3kFMDZe5KzCOj1EGy8j8tYgAr30tk9yhqvLrnTYdGNhevRIK2NezEK39/Ysywz7ul4jsV
 UmkKGsNFVCcgX6vm/unTa9Hb+PqCzzMD1e4AtDwAtX9mXZ0UuIO67SVjjrr9RGoOPcimiztJYTm
 djNuqk2kI8Ozve/Y+J25ghOD05lMuoDjevnCr7f1EtaH+45RrQ2tN2azjxUXXulqeeMuSQpo2AC
 rsm0/I060jggqw0vuMSo3wMjKlpNKo3H3gZSB4nElhoLl34ugSwE5iPNTKvNeeoa9W2pqykRY6s
 D2lo9pAbL6rFydn4TFkhq4rt4sQV5NYWo+tBTX1+uMU1prf3JIA==
X-Google-Smtp-Source: AGHT+IGrLqjyA7DO5FU4IeceOeNlJZMIx5Qr2mFtDPtJDzWaOtLYeHkTB0H7hBD1Ycn+lJXamzhMLg==
X-Received: by 2002:a05:600c:1e89:b0:45b:88c6:70a2 with SMTP id
 5b1f17b1804b1-45b88c67360mr4072175e9.1.1756570111550; 
 Sat, 30 Aug 2025 09:08:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6ee66bddsm164634875e9.0.2025.08.30.09.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Aug 2025 09:08:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 00/32] target-arm queue
Date: Sat, 30 Aug 2025 17:08:28 +0100
Message-ID: <20250830160828.3593075-1-peter.maydell@linaro.org>
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

v2: handle bsd-user in the rename of isar_feature_aa64_atomics

-- PMM

The following changes since commit 4791f22a5f5571cb248b1eddff98630545b3fd3e:

  Merge tag 'pull-lu-20250830' of https://gitlab.com/rth7680/qemu into staging (2025-08-30 08:24:48 +1000)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20250830

for you to fetch changes up to 2e27650bddd35477d994a795a3b1cb57c8ed5c76:

  hw/arm/stm32f205_soc: Don't leak TYPE_OR_IRQ objects (2025-08-30 16:38:47 +0100)

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
 bsd-user/aarch64/target_arch_elf.h                 |    2 +-
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
 44 files changed, 4389 insertions(+), 2663 deletions(-)
 delete mode 100644 host/include/aarch64/host/atomic128-cas.h
 create mode 100644 host/include/aarch64/host/atomic128-cas.h.inc
 delete mode 100755 scripts/kernel-doc
 create mode 100755 scripts/kernel-doc.py
 create mode 100644 scripts/lib/kdoc/kdoc_files.py
 create mode 100644 scripts/lib/kdoc/kdoc_item.py
 create mode 100644 scripts/lib/kdoc/kdoc_output.py
 create mode 100644 scripts/lib/kdoc/kdoc_parser.py
 create mode 100644 scripts/lib/kdoc/kdoc_re.py

