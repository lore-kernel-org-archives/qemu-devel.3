Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A530F4644C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25PC-000108-UJ; Mon, 16 Mar 2026 06:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PB-0000pd-8L
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:37 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25P9-0003dP-Ck
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:36 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-485392de558so26620035e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773657754; x=1774262554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=WqkMK6wJVsQjjMY99xhzWh6knXs0ZtiR5+rPWH6b2vg=;
 b=Kw11tcGCmxmQpOZUG2qTh7HkKlSnEVMdbt0jHeDz7oi4xFGateUEZErwyOokWK8E1+
 3DQGQ+IKIw4Knl/Nd9OHgN27gLo9wgSlc0npO4VqIkaMGmtoVSEqWpHFetl9VCoCSvVy
 2mhnp4nOCJmZMympvsMAzvNtLBD9gDF0fHogK9D1RWOfFzCLZ3PZxGH1hGyieA0so2qg
 AI8w7zPILfC2bRO3VQwzVZXs+CsKcYi956S80177fJtgqeJT8yQTtfs+XoaWHuHGIxKh
 i0/jRC26cDdiSwzNBDitpmh8M0gvErAPdR4uYesR0TABhCba7vkqys39OmRPijwjPRhR
 yKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657754; x=1774262554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WqkMK6wJVsQjjMY99xhzWh6knXs0ZtiR5+rPWH6b2vg=;
 b=VutVxmcidyWNC8X/6QQNPdozSNmYxuoLjBngtbC/b65Rh7qzVqdNVNwKK6sAqZhKxY
 IyExSHmbbfEc76eaaKF2aelMnOqOs8HKF0MkGPQ7tlkf5a53bbbw5gwGG/CGhWUiQIy7
 A3mST28IoOOhPP5vN+phqQ1gaJf6JnviO7k2BBFOK7pzHdfm0JJw8yzw45mxJI/IEVOv
 xJyHIvbCNomDknuRP3xtKyaCbLuopwYAk1ORs7pCdKBZ92qJ2Biny/WpxDcE2bXlP3aD
 2eOXETLQfNMqeyoWWVd87btVu8Mu5DhER3LCTAwyJDBKCLipJNdQ4ktk7paj1WS78AGJ
 yq+A==
X-Gm-Message-State: AOJu0YyTBsHI9rZKL4prFLUuoYMLCrKc/s6fVAIra+jWmV/NHX234u6N
 2lAWHQ7SmU05dbLi/B5qKorpjgR8KTgvf+dF+tb2X+ojBHeC1GBfstX1UoUNCK+gpAMgeErvM4n
 CQfmn
X-Gm-Gg: ATEYQzxpQeKemmypTGhLukBfARoGe5BoErp4otA+ZQVUfuTNheWeXCW3dDteOYvER2G
 QHPJkBP9Na+6FbdGDf1pjAp7pI3Hhgn74lwb8vdYrrzmN+UJcOL4Lb7/54lL7YA1WumDvDyyZNC
 SbqeAqc5OHx4F24QRVAD3218TnbV7XYqqOzMqC5EytTloE8Rm9aiq7/h6GeGrU+O79M6BGxYD8v
 DdsnkKNVr2wh4lJ3bAAK39wSWLhvW1rZRRq+OYKVGVfNWaIW2aTpHRxffDujEddsPGL4x/9KPNS
 QBhlr3QPh3c3+Wm0v3osP/My1GRFUY82H5Dj7UTEhwCEQUNFlxZC5GP09mDRg3O+kDRcoQMIbQO
 DHqPIBUZ3suYrHGUe3KdgsDXb5rmlzXSgKlkH61Nn9h+OwH4RUI2acp2ecTpTaHEyzeb8HxKUFh
 5azPCFlQWZmQIacFx4AwtfpV0vnfsxWFHqYmYuDST+7MMHaioYiOvfq8U9GfvwvWm4c11DN0pqW
 YhyZpK47fM=
X-Received: by 2002:a05:600c:4e08:b0:485:3eba:ab96 with SMTP id
 5b1f17b1804b1-485566ca967mr201917065e9.3.1773657753644; 
 Mon, 16 Mar 2026 03:42:33 -0700 (PDT)
Received: from lanath.. ([81.2.115.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74266sm85519135e9.17.2026.03.16.03.42.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:42:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/17] target-arm queue
Date: Mon, 16 Mar 2026 10:42:13 +0000
Message-ID: <20260316104230.836962-1-peter.maydell@linaro.org>
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

Some arm changes for rc0, all fairly minor bugfixes.

-- PMM

The following changes since commit fff352b9b6080e580aa1fadd29b4eccf4cb2922a:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-03-12 15:21:06 +0000)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260316

for you to fetch changes up to ed44618b8e6cb394c6b9d3642d9d130b46b8457a:

  tests/qtest/aspeed_gpio-test: Use g_strdup_printf() instead of char arrays (2026-03-13 13:27:57 +0000)

----------------------------------------------------------------
target-arm queue:
 * hw/net/rtl8319: Work around GCC sanitizer / -Wstringop-overflow bug
 * semihosting: Correctly byteswap data when CPU is in big-endian mode
 * hw/dma/pl080: Fix various minor bugs
 * MAINTAINERS: Remove some no-longer active maintainers
 * tests/qtest: Use g_strdup_printf() in various arm tests

----------------------------------------------------------------
Martin Kröning (3):
      include/hw/core: Rename virtio_is_big_endian to internal_is_big_endian
      include/exec: Provide the cpu_internal_tswap() functions
      semihosting/uaccess: Use the cpu_internal_tswap() functions

Peter Maydell (12):
      hw/net/rtl8319: Work around GCC sanitizer / -Wstringop-overflow bug
      hw/dma/pl080: Handle bogus swidth and dwidth in transfers
      MAINTAINERS: Remove Hannes Reinecke
      MAINTAINERS: Remove Cameron Esfahani
      MAINTAINERS: Remove Eduardo Habkost
      MAINTAINERS: Remove Radoslaw Biernacki
      MAINTAINERS: Remove Andrey Smirnov
      MAINTAINERS: Remove Chris Browy
      tests/qtest/ast2700-sgpio-test: Use g_strdup_printf() instead of char arrays
      tests/qtest/arm-cpu-features: Use g_strdup_printf() instead of char arrays
      tests/qtest/ast2700-gpio-test: Use g_strdup_printf() instead of char arrays
      tests/qtest/aspeed_gpio-test: Use g_strdup_printf() instead of char arrays

Tao Ding (2):
      hw/dma/pl080: Update interrupts after pl080_run()
      hw/dma/pl080: Ignore bottom 2 bits of LLI register

 MAINTAINERS                      | 18 ++----------------
 hw/core/cpu-system.c             |  6 +++---
 hw/dma/pl080.c                   | 28 +++++++++++++++++++++++-----
 hw/net/rtl8139.c                 | 23 +++++++++++++++++++++++
 hw/virtio/virtio.c               |  2 +-
 include/exec/tswap.h             | 36 ++++++++++++++++++++++++++++++++++++
 include/hw/core/cpu.h            |  4 ++--
 include/hw/core/sysemu-cpu-ops.h |  6 +++---
 include/semihosting/uaccess.h    |  8 ++++----
 target/arm/cpu.c                 |  4 ++--
 target/ppc/cpu_init.c            |  2 +-
 tests/qtest/arm-cpu-features.c   | 24 +++++++++++++++---------
 tests/qtest/aspeed_gpio-test.c   |  4 ++--
 tests/qtest/ast2700-gpio-test.c  |  3 +--
 tests/qtest/ast2700-sgpio-test.c | 24 ++++++++++++------------
 15 files changed, 130 insertions(+), 62 deletions(-)

