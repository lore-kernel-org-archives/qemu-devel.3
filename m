Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67125C5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 12:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKzBa-00020j-Rn; Fri, 30 May 2025 08:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBV-000204-Bl
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:05 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBP-0001cY-RW
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:02 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso13367105e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 05:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748609397; x=1749214197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=iDO/Sk/FrFvktM+vX34n7V0ace0NdUC/wDYRVqTbEPk=;
 b=QybOJeDM0nMTp3P5YeIPIWvIo4ysR+cMgNIk0YexMM/ITV1RmRfYE2poaPaGm2LC5Q
 B17j4dVc98nq076spzB094snIQ1WhnKSeZbhHZoBqfjdkAuAJuLRIjLCRxZm35l8xRWq
 QiZ4fJJuyDk17ACtV5Ey1EkE5cVG2C2bbOKTP8c5YxYbxuPmdZrgB7vpv+Uf6jUR55z/
 tBIocMsKCh03uIbijoJRpXqjUOA3NMIfRolI4SlMxIkM+Yvh5RqaJX3o/ZxHnJ6/Kjfq
 EEBPFmOfElathTYDFdnoDkQIkVYbzkbpZzbsmO5JkL/pJ5srE2p6ARbBdt7s2dH5y6tl
 VJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748609397; x=1749214197;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iDO/Sk/FrFvktM+vX34n7V0ace0NdUC/wDYRVqTbEPk=;
 b=EdlZdWKr8bsM6//UM/eU4v8HsAPhUWkReDFQ6U4Wn555o7ZwCIM8SbdcMZMR54fZz+
 MaOOBUMx3+9Dj1iYVyAWaRefR9gxz46N3btaVATRoup1E8M8RVsigf/0DrDu/UY9iaaA
 2IU+C7SvkJ5Mbymgh3/AjzI0WB1++umWnA7hOVxpmpw4eW03NV+tGuJOk/shI0Z5QLc1
 svfy19IJaIsGgKskj0AkOpKRHHSyjElGjH2KTs79En9iLpRiqu41p1s3rQkZLfcUYuxU
 yLa6peHvAE/8kOua6Vl4ghpz5Ksy0Is8H/9+q8Pf5+M4ghWQOM8COqC90HFaD7wAIVnV
 DaLw==
X-Gm-Message-State: AOJu0Yyaj2jh2vhJI5hU+o0RvmngPLYCgEohcKZ9AfvTFjl/lv0BMR/1
 kf0lha2URjpctr30+MaCkIys9QEwDCYJ8RB/k25QkA3KH7LJptFheI1Hzi59IX8kKfWCngArfzG
 8Oyry
X-Gm-Gg: ASbGncvwNv+m5YVAKJY8MU5E/6UeCjF5FpBeWbLl3FctNcCjl6HFV8eQPx8NUXWk7p7
 j7q86XF16ve8LYx4ItKyipzxccNYMZpQ/89RaWhoZsUrDY0zVrVy2E5q9ebfhiTsZrOsCbe2OCq
 fo3l+RUkI0hoj5jUxMicjMC6M7uV5miPTwwQtoGuVOH1ibpOek6CpY3fj8c24d0xmLktXHRVxJm
 IuaFbF5UAs7rUGDG3lLOErPUFw7ChtmK8jaY38L6IJqug7uReatYyh5V3S5835eF6wIuKA8CKrT
 0A2FnBQWXxT90cNYF6utQ++OV/yZhHoN3feFbg9scZkCzxJeCr+qDDcVNw==
X-Google-Smtp-Source: AGHT+IHHxJ8Wd01aMcAXOTTDK9gkiZQMkgpo/BEr9FrqJ8VOJ2NsSHsd1/AbS/T/N1rcP0E9YTz+wg==
X-Received: by 2002:a05:600c:a087:b0:442:f44f:65b with SMTP id
 5b1f17b1804b1-450d6561627mr28462475e9.32.1748609396683; 
 Fri, 30 May 2025 05:49:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb7dafsm17235195e9.25.2025.05.30.05.49.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 05:49:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/15] target-arm queue
Date: Fri, 30 May 2025 13:49:37 +0100
Message-ID: <20250530124953.383687-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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


Hi; here's a target-arm pull; mostly refactoring and other small stuff.

thanks
-- PMM

The following changes since commit d2e9b78162e31b1eaf20f3a4f563da82da56908d:

  Merge tag 'pull-qapi-2025-05-28' of https://repo.or.cz/qemu/armbru into staging (2025-05-29 08:36:01 -0400)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20250530-2

for you to fetch changes up to e86c1f967a323165d13bcadfad4b92d0d34cdb08:

  hw/block: Drop unused nand.c (2025-05-29 17:45:13 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/arm: Add GMAC devices to NPCM8XX SoC
 * hw/arm: Add missing psci_conduit to NPCM8XX SoC boot info
 * docs/interop: convert text files to restructuredText
 * target/arm: Some minor refactorings
 * tests/functional: Add a test for the Stellaris arm machines
 * hw/block: Drop unused nand.c

----------------------------------------------------------------
Guenter Roeck (1):
      hw/arm: Add missing psci_conduit to NPCM8XX SoC boot info

Hao Wu (1):
      hw/arm: Add GMAC devices to NPCM8XX SoC

Nabih Estefan (1):
      tests/qtest: Migrate GMAC test from 7xx to 8xx

Peter Maydell (1):
      hw/block: Drop unused nand.c

Philippe Mathieu-Daudé (9):
      target/arm/tcg-stubs: compile file once (system)
      target/arm/hvf_arm: Avoid using poisoned CONFIG_HVF definition
      target/arm: Only link with zlib when TCG is enabled
      target/arm/cpregs: Include missing 'target/arm/cpu.h' header
      hw/arm/boot: Include missing 'system/memory.h' header
      target/arm/cpu-features: Include missing 'cpu.h' header
      target/arm/qmp: Include missing 'cpu.h' header
      target/arm/kvm: Include missing 'cpu-qom.h' header
      target/arm/hvf: Include missing 'cpu-qom.h' header

Souleymane Conte (1):
      docs/interop: convert text files to restructuredText

Thomas Huth (1):
      tests/functional: Add a test for the Stellaris arm machines

 MAINTAINERS                            |   4 +-
 docs/interop/bitmaps.rst               |   2 +-
 docs/interop/index.rst                 |   1 +
 docs/interop/{qcow2.txt => qcow2.rst}  | 187 +++++---
 docs/qcow2-cache.txt                   |   2 +-
 include/hw/arm/npcm8xx.h               |   5 +-
 include/hw/block/flash.h               |  18 -
 target/arm/cpregs.h                    |   1 +
 target/arm/cpu-features.h              |   1 +
 target/arm/hvf_arm.h                   |  18 +-
 target/arm/kvm_arm.h                   |   1 +
 hw/arm/boot.c                          |   1 +
 hw/arm/npcm8xx.c                       |  55 ++-
 hw/block/nand.c                        | 835 ---------------------------------
 target/arm/arm-qmp-cmds.c              |   1 +
 target/arm/hvf-stub.c                  |  20 +
 tests/qtest/npcm_gmac-test.c           |  85 +++-
 hw/arm/Kconfig                         |   1 -
 hw/block/Kconfig                       |   3 -
 hw/block/meson.build                   |   1 -
 target/arm/meson.build                 |   4 +-
 target/arm/tcg/meson.build             |   2 +
 tests/functional/meson.build           |   1 +
 tests/functional/test_arm_stellaris.py |  48 ++
 tests/qtest/meson.build                |   6 +-
 25 files changed, 334 insertions(+), 969 deletions(-)
 rename docs/interop/{qcow2.txt => qcow2.rst} (89%)
 delete mode 100644 hw/block/nand.c
 create mode 100644 target/arm/hvf-stub.c
 create mode 100755 tests/functional/test_arm_stellaris.py

