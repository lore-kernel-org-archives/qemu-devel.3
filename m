Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E64C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafeD-0007uw-Iu; Thu, 15 Feb 2024 12:35:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeB-0007uP-Rn
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:43 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafe9-0003tW-OQ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:43 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-410ca9e851bso9059285e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018540; x=1708623340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=RexkiDntXUclc+ODrTpB8ETswJdghZou3AXsBu6yv+A=;
 b=juKtWhss0E+MPglTS7xfkMH4jaHQ+oINFDIIcZHhzRLcMvKipHKr/djLwNRbnuMzjm
 BYA8iJj28bKX++n8wknZqwgVc5KJai/EE2hpsAj+stp0ecnma8omkyuzw6L4BJT2BXuY
 3IWOLSlujno06TMv9tb43LfOIRA9m444QfYfYvfSP+hg/vozBzX1eMs9qnVPiLhDlFd4
 q8iZJ5ZiFL2p885o6wNsILMzh5Ea5gpeTNuXawbpeyOmwzDi7UoKi1wi5YscS8iDZZ8d
 9mYNsbFYJWFbDb9VeC3Av6cM7MtLRRtDnGGKJ+LJq8tcEg3cs8+Vq1589IwasadV/3SF
 yUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018540; x=1708623340;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RexkiDntXUclc+ODrTpB8ETswJdghZou3AXsBu6yv+A=;
 b=PBim1nJa+0+HQE8yGMe+96dtSG3Hq9TkR1MtlU6Uj4MJkWV4bDmlljtTC+gAu/0lHe
 1hliI9RaNgGqq3teCnBKwrV7EGy7ZMw/+jn2gG8tAI8glBonxOUD5vWc3EBYYhHu8OtD
 gl8xv0RqZB+SGBtw06D5Uk/4ayT/JhRyH4NLZdLlC+2W7MpkcB7D7vfJCnWp1WYpSVOi
 UQgVd+bJkSKQTfwjL+6uVKKLZ4EhPX5wsuVs25DJkclE2ZdRnBU9zvWx/+DN62xV80Oe
 68QBEigG8gTcwiSk9agPb3EF9eeIS7mocLypgmPbg7EDP0YRo6cCb4qecE9Vw4WzNOEf
 qH3A==
X-Gm-Message-State: AOJu0YzCHwZGCr3u3uuO/s/fmI6rEpfLIBxAsnxEX+4Fz0KpuhRxZp6m
 ke53I7smK6pnezHBJ+UapQqBeI6H7gU1jbTpxCq5QqZAkXISW37WMd5R0mLXQzdSPWYUI+h5XKO
 Y
X-Google-Smtp-Source: AGHT+IG3XLhD27PtOby3FDTkllCT7qAJfM1gWyq4jPgQaStNlfmYailMVsFjVG+XCqhhCCfVerBJSA==
X-Received: by 2002:a5d:40d2:0:b0:33b:7353:b632 with SMTP id
 b18-20020a5d40d2000000b0033b7353b632mr1984551wrq.50.1708018539848; 
 Thu, 15 Feb 2024 09:35:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/35] target-arm queue
Date: Thu, 15 Feb 2024 17:35:03 +0000
Message-Id: <20240215173538.2430599-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 5767815218efd3cbfd409505ed824d5f356044ae:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2024-02-14 15:45:52 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240215

for you to fetch changes up to f780e63fe731b058fe52d43653600d8729a1b5f2:

  docs: Add documentation for the mps3-an536 board (2024-02-15 14:32:39 +0000)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/xilinx_zynq: Wire FIQ between CPU <> GIC
 * linux-user/aarch64: Choose SYNC as the preferred MTE mode
 * Fix some errors in SVE/SME handling of MTE tags
 * hw/pci-host/raven.c: Mark raven_io_ops as implementing unaligned accesses
 * hw/block/tc58128: Don't emit deprecation warning under qtest
 * tests/qtest: Fix handling of npcm7xx and GMAC tests
 * hw/arm/virt: Wire up non-secure EL2 virtual timer IRQ
 * tests/qtest/npcm7xx_emc-test: Connect all NICs to a backend
 * Don't assert on vmload/vmsave of M-profile CPUs
 * hw/arm/smmuv3: add support for stage 1 access fault
 * hw/arm/stellaris: QOM cleanups
 * Use new CBAR encoding for all v8 CPUs, not all aarch64 CPUs
 * Improve Cortex_R52 IMPDEF sysreg modelling
 * Allow access to SPSR_hyp from hyp mode
 * New board model mps3-an536 (Cortex-R52)

----------------------------------------------------------------
Luc Michel (1):
      hw/arm/smmuv3: add support for stage 1 access fault

Nabih Estefan (1):
      tests/qtest: Fix GMAC test to run on a machine in upstream QEMU

Peter Maydell (22):
      hw/pci-host/raven.c: Mark raven_io_ops as implementing unaligned accesses
      hw/block/tc58128: Don't emit deprecation warning under qtest
      tests/qtest/meson.build: Don't include qtests_npcm7xx in qtests_aarch64
      tests/qtest/bios-tables-test: Allow changes to virt GTDT
      hw/arm/virt: Wire up non-secure EL2 virtual timer IRQ
      tests/qtest/bios-tables-tests: Update virt golden reference
      hw/arm/npcm7xx: Call qemu_configure_nic_device() for GMAC modules
      tests/qtest/npcm7xx_emc-test: Connect all NICs to a backend
      target/arm: Don't get MDCR_EL2 in pmu_counter_enabled() before checking ARM_FEATURE_PMU
      target/arm: Use new CBAR encoding for all v8 CPUs, not all aarch64 CPUs
      target/arm: The Cortex-R52 has a read-only CBAR
      target/arm: Add Cortex-R52 IMPDEF sysregs
      target/arm: Allow access to SPSR_hyp from hyp mode
      hw/misc/mps2-scc: Fix condition for CFG3 register
      hw/misc/mps2-scc: Factor out which-board conditionals
      hw/misc/mps2-scc: Make changes needed for AN536 FPGA image
      hw/arm/mps3r: Initial skeleton for mps3-an536 board
      hw/arm/mps3r: Add CPUs, GIC, and per-CPU RAM
      hw/arm/mps3r: Add UARTs
      hw/arm/mps3r: Add GPIO, watchdog, dual-timer, I2C devices
      hw/arm/mps3r: Add remaining devices
      docs: Add documentation for the mps3-an536 board

Philippe Mathieu-Daudé (5):
      hw/arm/xilinx_zynq: Wire FIQ between CPU <> GIC
      hw/arm/stellaris: Convert ADC controller to Resettable interface
      hw/arm/stellaris: Convert I2C controller to Resettable interface
      hw/arm/stellaris: Add missing QOM 'machine' parent
      hw/arm/stellaris: Add missing QOM 'SoC' parent

Richard Henderson (6):
      linux-user/aarch64: Choose SYNC as the preferred MTE mode
      target/arm: Fix nregs computation in do_{ld,st}_zpa
      target/arm: Adjust and validate mtedesc sizem1
      target/arm: Split out make_svemte_desc
      target/arm: Handle mte in do_ldrq, do_ldro
      target/arm: Fix SVE/SME gross MTE suppression checks

 MAINTAINERS                             |   3 +-
 docs/system/arm/mps2.rst                |  37 +-
 configs/devices/arm-softmmu/default.mak |   1 +
 hw/arm/smmuv3-internal.h                |   1 +
 include/hw/arm/smmu-common.h            |   1 +
 include/hw/arm/virt.h                   |   2 +
 include/hw/misc/mps2-scc.h              |   1 +
 linux-user/aarch64/target_prctl.h       |  29 +-
 target/arm/internals.h                  |   2 +-
 target/arm/tcg/translate-a64.h          |   2 +
 hw/arm/mps3r.c                          | 640 ++++++++++++++++++++++++++++++++
 hw/arm/npcm7xx.c                        |   1 +
 hw/arm/smmu-common.c                    |  11 +
 hw/arm/smmuv3.c                         |   1 +
 hw/arm/stellaris.c                      |  47 ++-
 hw/arm/virt-acpi-build.c                |  20 +-
 hw/arm/virt.c                           |  60 ++-
 hw/arm/xilinx_zynq.c                    |   2 +
 hw/block/tc58128.c                      |   4 +-
 hw/misc/mps2-scc.c                      | 138 ++++++-
 hw/pci-host/raven.c                     |   1 +
 target/arm/helper.c                     |  14 +-
 target/arm/tcg/cpu32.c                  | 109 ++++++
 target/arm/tcg/op_helper.c              |  43 ++-
 target/arm/tcg/sme_helper.c             |   8 +-
 target/arm/tcg/sve_helper.c             |  12 +-
 target/arm/tcg/translate-sme.c          |  15 +-
 target/arm/tcg/translate-sve.c          |  83 +++--
 target/arm/tcg/translate.c              |  19 +-
 tests/qtest/npcm7xx_emc-test.c          |   5 +-
 tests/qtest/npcm_gmac-test.c            |  84 +----
 hw/arm/Kconfig                          |   5 +
 hw/arm/meson.build                      |   1 +
 tests/data/acpi/virt/FACP               | Bin 276 -> 276 bytes
 tests/data/acpi/virt/GTDT               | Bin 96 -> 104 bytes
 tests/qtest/meson.build                 |   4 +-
 36 files changed, 1184 insertions(+), 222 deletions(-)
 create mode 100644 hw/arm/mps3r.c

