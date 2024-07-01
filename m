Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F65FC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJZ7-0000fy-H8; Mon, 01 Jul 2024 12:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ0-0000a6-Im
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJYy-0005PQ-1X
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:34 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-424acfff613so29037745e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850050; x=1720454850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=kJ+J4fPu+4PLLX6tZwve3g6gm3xWsxK0W9L+bZia37s=;
 b=ElRVyFuwMGZIRCy597mtdjMSrkMK32JUyYnHobYm0IkwStyeNgElndCHMYmubC1Rl2
 jHQZ0zH/uU9jN20YjnKN+qB7r1mzuM2BYQiFn/AowY3APTGx1w9kqAwmg6uK04HP6RMZ
 bebTb/h8OfvaHaTMlR7sgBbK96wDKQ/VVPBliw5YDdQwO2r7npibj3BJiaF0Yp4DP65Q
 MqEIOX3rVqjDkEXXpDGTne41wYm2SsAGRRsbVnSt3XoBRicVN9itonDUUUkXyETd4fNp
 6umUxtHK1mMfsxCBSx9n1DANbWFpF1bZA5DuHmHn/14U9ZRvrkSDqHNicQ9wyuj+VsG+
 yr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850050; x=1720454850;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kJ+J4fPu+4PLLX6tZwve3g6gm3xWsxK0W9L+bZia37s=;
 b=oYeNH2Gk8qDNq+MHzcXVOlu9FEeCkIr6p+zSjTAFdhd7WGLO4xxKtD40po7FgS0iNT
 gl7IUsA3/6ZJX7oyFXGwJ51lfWncPE08RsGG71HNTCPNFz/Ax3z5FRHdYIABFxkU01fv
 FWdAyIADBl1tuEOCbCAKxmVuq6ymTENSJex/02nc/ts5DkYvsFF5h1VRS4JGG21BWS6b
 ro85HOVTZIqVq2fnnfS6pX6oJMhLKX6nIo0yIwSONI2rSiTHsyGprN7Vq9TSo/IbYvh2
 9eVH//N34Q+izxLKKQBKFT22ZADeh8+oK8+ZlxzpN+Ua6q2VBeiD6pPeBehjDtgFFWHy
 G+ww==
X-Gm-Message-State: AOJu0YxTFHGHUE8tRvRJKiuG2d8JdoQv2MziOgkAmTvt4pl393l7ArnL
 TjbG6XQh1IRaF8u4CAk6PHl6eUvhZpsGOZwQbdzFsnKVms5pEC8hhOx3UIC5wg3LnM+WVeuBR6R
 S32k=
X-Google-Smtp-Source: AGHT+IF/mzxkltx45WdscRam8z5KeOEDMJjjGhnNGN5PgOALhvlgY4zNaIDibGBJMB6uC2hvybG6Qw==
X-Received: by 2002:a05:600c:41d2:b0:425:657a:518d with SMTP id
 5b1f17b1804b1-4257a0079a8mr48626785e9.14.1719850050251; 
 Mon, 01 Jul 2024 09:07:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/29] target-arm queue
Date: Mon,  1 Jul 2024 17:07:00 +0100
Message-Id: <20240701160729.1910763-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

The following changes since commit b6d32a06fc0984e537091cba08f2e1ed9f775d74:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2024-06-30 16:12:24 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240701

for you to fetch changes up to 58c782de557beb496bfb4c5ade721bbbd2480c72:

  tests/qtest: Ensure STM32L4x5 EXTI state is correct at the end of QTests (2024-07-01 15:40:54 +0100)

----------------------------------------------------------------
target-arm queue:
 * tests/avocado: update firmware for sbsa-ref and use all cores
 * hw/arm/smmu-common: Replace smmu_iommu_mr with smmu_find_sdev
 * arm: Fix VCMLA Dd, Dn, Dm[idx]
 * arm: Fix SQDMULH (by element) with Q=0
 * arm: Fix FJCVTZS vs flush-to-zero
 * arm: More conversion of A64 AdvSIMD to decodetree
 * arm: Enable FEAT_Debugv8p8 for -cpu max
 * MAINTAINERS: Update family name for Patrick Leis
 * hw/arm/xilinx_zynq: Add boot-mode property
 * docs/system/arm: Add a doc for zynq board
 * hw/misc: In STM32L4x5 EXTI, correct configurable interrupts
 * tests/qtest: fix minor issues in STM32L4x5 tests

----------------------------------------------------------------
Gustavo Romero (3):
      target/arm: Fix indentation
      target/arm: Move initialization of debug ID registers
      target/arm: Enable FEAT_Debugv8p8 for -cpu max

Inès Varhol (3):
      tests/qtest: Fix STM32L4x5 SYSCFG irq line 15 state assumption
      hw/misc: In STM32L4x5 EXTI, correct configurable interrupts
      tests/qtest: Ensure STM32L4x5 EXTI state is correct at the end of QTests

Marcin Juszkiewicz (2):
      tests/avocado: update firmware for sbsa-ref
      tests/avocado: use default amount of cores on sbsa-ref

Nicolin Chen (1):
      hw/arm/smmu-common: Replace smmu_iommu_mr with smmu_find_sdev

Patrick Leis (1):
      MAINTAINERS: Update my family name

Rayhan Faizel (3):
      hw/nvram: Add BCM2835 OTP device
      hw/arm: Connect OTP device to BCM2835
      hw/misc: Implement mailbox properties for customer OTP and device specific private keys

Richard Henderson (13):
      target/arm: Fix VCMLA Dd, Dn, Dm[idx]
      target/arm: Fix SQDMULH (by element) with Q=0
      target/arm: Fix FJCVTZS vs flush-to-zero
      target/arm: Convert SQRDMLAH, SQRDMLSH to decodetree
      target/arm: Convert SDOT, UDOT to decodetree
      target/arm: Convert SUDOT, USDOT to decodetree
      target/arm: Convert BFDOT to decodetree
      target/arm: Convert BFMLALB, BFMLALT to decodetree
      target/arm: Convert BFMMLA, SMMLA, UMMLA, USMMLA to decodetree
      target/arm: Add data argument to do_fp3_vector
      target/arm: Convert FCADD to decodetree
      target/arm: Convert FCMLA to decodetree
      target/arm: Delete dead code from disas_simd_indexed

Sai Pavan Boddu (3):
      hw/misc/zynq_slcr: Add boot-mode property
      hw/arm/xilinx_zynq: Add boot-mode property
      docs/system/arm: Add a doc for zynq board

 MAINTAINERS                              |   3 +-
 docs/system/arm/emulation.rst            |   1 +
 docs/system/arm/xlnx-zynq.rst            |  47 ++
 docs/system/target-arm.rst               |   1 +
 include/hw/arm/bcm2835_peripherals.h     |   3 +-
 include/hw/arm/raspberrypi-fw-defs.h     |   2 +
 include/hw/arm/smmu-common.h             |   4 +-
 include/hw/misc/bcm2835_property.h       |   2 +
 include/hw/misc/stm32l4x5_exti.h         |   2 +
 include/hw/nvram/bcm2835_otp.h           |  68 +++
 target/arm/cpu.h                         |   2 +
 target/arm/helper.h                      |  10 +
 target/arm/tcg/a64.decode                |  43 ++
 hw/arm/bcm2835_peripherals.c             |  15 +-
 hw/arm/smmu-common.c                     |   8 +-
 hw/arm/smmuv3.c                          |  12 +-
 hw/arm/xilinx_zynq.c                     |  31 ++
 hw/misc/bcm2835_property.c               |  87 ++++
 hw/misc/stm32l4x5_exti.c                 |  28 +-
 hw/misc/zynq_slcr.c                      |  22 +-
 hw/nvram/bcm2835_otp.c                   | 187 +++++++
 target/arm/tcg/cpu32.c                   |  35 +-
 target/arm/tcg/cpu64.c                   |   4 +-
 target/arm/tcg/translate-a64.c           | 808 ++++++++++---------------------
 target/arm/tcg/vec_helper.c              | 100 +++-
 target/arm/vfp_helper.c                  |  18 +-
 tests/qtest/stm32l4x5_exti-test.c        |   8 +
 tests/qtest/stm32l4x5_syscfg-test.c      |  16 +-
 tests/tcg/aarch64/test-2375.c            |  21 +
 hw/nvram/meson.build                     |   1 +
 tests/avocado/machine_aarch64_sbsaref.py |  16 +-
 tests/tcg/aarch64/Makefile.target        |   3 +-
 32 files changed, 967 insertions(+), 641 deletions(-)
 create mode 100644 docs/system/arm/xlnx-zynq.rst
 create mode 100644 include/hw/nvram/bcm2835_otp.h
 create mode 100644 hw/nvram/bcm2835_otp.c
 create mode 100644 tests/tcg/aarch64/test-2375.c

