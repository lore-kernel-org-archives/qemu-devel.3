Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078DFC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJXH-0002TY-OB; Tue, 06 May 2025 10:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJUz-0001Ra-0X
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:31 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJUw-000241-Nv
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:20 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso38990115e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542537; x=1747147337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9nQmafy0cBVOcXj+qB9tBteRoMcbXJMypLGSoI0OVW0=;
 b=nH2hTEubiKrtW7JBzswmrcnhv7s8vO2Hy/h7XGD9a9rlYrMWs9hu0HbEVT2AVezq3J
 R4dCW/2dpoWmdVQKaIYuWDBPrYegUOA3QoN2ol7IA33O9+aCoT7oRBUXUNeKkbHazhv2
 +WiPnXqbEr0rFuwp6C2YMsMw7Q4GIfB4T6caqkFW6tg8V/A8aSofjc5laJ/0BXyOCcBT
 2mZiHH9xuEYcaus40niou3gDDX1kWwWg8ln8LcRACaxZ5eBJOlyr4W71nu0Q7KHAhuKy
 ke/i9i+rCn3BP7S57DmCnTW7CqaTDU1f4yG2f+GJ/5a1NgG9VaTHtz2PL6gXeP5fxJLN
 Y1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542537; x=1747147337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9nQmafy0cBVOcXj+qB9tBteRoMcbXJMypLGSoI0OVW0=;
 b=XutbyARueYhM1kzEJFucRsm63FheUsQosdPS3fpTeU7PEXD4i3NDnDA2qlwJigknhB
 Qb2c3prSbETHbBaGgAlpkU4EZPqTJSnZ7NohVxS5TJkPMdzKlZYcr6YIqDCcCnmvlfXR
 ig27Fsq6RNgRhVomBUojOvQbXN5icMaVG0fDSbHUBsqq2UkIxjKF7Z/bVsdDxR+4K1Iy
 YuDHK5IkAnOzfeazqNLJsivDB/aKlf5xOwjPPuUME66jdUZl/x/M2m3s03B6nPU93tuh
 Q9hfdcUQXuYe6Eb3zShAHGJ6hf5v/NuyQctpwrcM49XiZpdqF2MFzUNr/8GCFOCSaGK6
 J4oQ==
X-Gm-Message-State: AOJu0Yz1qjA+G88LfTlMlmSrvHLqI1x4FD3HJ6PyBBl50e857x69aZY9
 He8e8yJoZRwEQQ9q7/dVZ0ExK/KG9CmydH00mimmIgGED3JuglpkqDQPpkQjc10+BuuOaXNIpYO
 3
X-Gm-Gg: ASbGncuGrsek8MzgNDH/fkNwmzRJTApwXPPbfkAeNYcWmld43Z9gIRxSfxPLi/+s5Ll
 5IT5W/CAMhJfACEzqrJockZAvDPZcTrH1rLeQPRY20csg1rO+ErqzMkNacfX1xiepaNk++iBDMJ
 TdagZxVYk+X7pYYKkHoxpzayO//bCKeIvKI4M8Eobhvty0x8UYRR2KqP/pzwDUy8nJWhFC5ZHzf
 nrkC2U326MtGEoE3e8BmfmjjFuhUiSMDQHRcuivQIJas7G+NN6qLFaRfu1Hg/jLojaFEh9GhbWC
 cvB40Qi37+rR8C8sINBSXiyLQhWaQGyDS1TihF842jZQrqs=
X-Google-Smtp-Source: AGHT+IEIWgQlwlXMxShFppIYLiMISWsYujC2bwCrQtvafl5gApxtOVwLaZJh+ho/mEKWS7D59bQdHQ==
X-Received: by 2002:a05:600c:4ed0:b0:43c:fe90:1279 with SMTP id
 5b1f17b1804b1-441bbf33f67mr137636475e9.21.1746542536695; 
 Tue, 06 May 2025 07:42:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/32] target-arm queue
Date: Tue,  6 May 2025 15:41:42 +0100
Message-ID: <20250506144214.1221450-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Now I'm back from holiday, here's a target-arm pullreq :-)

thanks
-- PMM

The following changes since commit a9e0c9c0f14e19d23443ac24c8080b4708d2eab8:

  Merge tag 'pull-9p-20250505' of https://github.com/cschoenebeck/qemu into staging (2025-05-05 11:26:59 -0400)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20250506

for you to fetch changes up to 607e1208b53ac713a76d158f4abc4cd2e8870051:

  hw/arm/virt: Remove deprecated virt-4.0 machine (2025-05-06 15:02:35 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/npcm8xx_boards: Correct valid_cpu_types setting of NPCM8XX SoC
 * arm/hvf: fix crashes when using gdbstub
 * target/arm/ptw: fix arm_cpu_get_phys_page_attrs_debug
 * hw/arm/virt: Remove deprecated old versions of 'virt' machine
 * tests/functional: Add test for imx8mp-evk board with USDHC coverage
 * hw/arm: Attach PSPI module to NPCM8XX SoC
 * target/arm: Don't assert() for ISB/SB inside IT block
 * docs: Don't define duplicate label in qemu-block-drivers.rst.inc
 * target/arm/kvm: Drop support for kernels without KVM_ARM_PREFERRED_TARGET
 * hw/pci-host/designware: Fix viewport configuration
 * hw/gpio/imx_gpio: Fix interpretation of GDIR polarity

----------------------------------------------------------------
Bernhard Beschow (4):
      tests/functional: Add test for imx8mp-evk board with USDHC coverage
      hw/pci-host/designware: Remove unused include
      hw/pci-host/designware: Fix viewport configuration
      hw/gpio/imx_gpio: Fix interpretation of GDIR polarity

Mads Ynddal (2):
      hvf: avoid repeatedly setting trap debug for each cpu
      hvf: only update sysreg from owning thread

Peter Maydell (3):
      target/arm: Don't assert() for ISB/SB inside IT block
      docs: Don't define duplicate label in qemu-block-drivers.rst.inc
      target/arm/kvm: Drop support for kernels without KVM_ARM_PREFERRED_TARGET

Philippe Mathieu-Daudé (17):
      hw/arm/virt: Remove deprecated virt-2.6 machine
      hw/arm/virt: Remove VirtMachineClass::no_pmu field
      hw/arm/virt: Remove VirtMachineClass::disallow_affinity_adjustment
      hw/arm/virt: Remove deprecated virt-2.7 machine
      hw/arm/virt: Remove VirtMachineClass::no_its field
      hw/arm/virt: Remove deprecated virt-2.8 machine
      hw/arm/virt: Remove VirtMachineClass::claim_edge_triggered_timers field
      hw/arm/virt: Remove deprecated virt-2.9 machine
      hw/arm/virt: Remove deprecated virt-2.10 machine
      hw/arm/virt: Remove deprecated virt-2.11 machine
      hw/arm/virt: Remove VirtMachineClass::smbios_old_sys_ver field
      hw/arm/virt: Remove deprecated virt-2.12 machine
      hw/arm/virt: Remove VirtMachineClass::no_highmem_ecam field
      hw/arm/virt: Update comment about Multiprocessor Affinity Register
      hw/arm/virt: Remove deprecated virt-3.0 machine
      hw/arm/virt: Remove deprecated virt-3.1 machine
      hw/arm/virt: Remove deprecated virt-4.0 machine

Pierrick Bouvier (4):
      target/arm/ptw: extract arm_mmu_idx_to_security_space
      target/arm/ptw: get current security_space for current mmu_idx
      target/arm/ptw: extract arm_cpu_get_phys_page
      target/arm/ptw: fix arm_cpu_get_phys_page_attrs_debug

Tim Lee (2):
      hw/arm/npcm8xx_boards: Correct valid_cpu_types setting of NPCM8XX SoC
      hw/arm: Attach PSPI module to NPCM8XX SoC

 MAINTAINERS                                 |   1 +
 docs/devel/codebase.rst                     |   2 +-
 docs/system/qemu-block-drivers.rst.inc      |   2 -
 include/hw/arm/npcm8xx.h                    |   2 +
 include/hw/arm/virt.h                       |   6 --
 target/arm/kvm_arm.h                        |   7 +-
 accel/hvf/hvf-all.c                         |   7 +-
 hw/arm/npcm8xx.c                            |  11 +-
 hw/arm/npcm8xx_boards.c                     |   2 +-
 hw/arm/virt-acpi-build.c                    |  10 +-
 hw/arm/virt.c                               | 153 ++++------------------------
 hw/gpio/imx_gpio.c                          |   2 +-
 hw/pci-host/designware.c                    |   5 +-
 target/arm/arm-qmp-cmds.c                   |   2 +-
 target/arm/hvf/hvf.c                        |  27 ++---
 target/arm/kvm.c                            |  55 ++--------
 target/arm/ptw.c                            |  71 +++++++++----
 target/arm/tcg/translate.c                  |   3 +-
 tests/functional/meson.build                |   2 +
 tests/functional/test_aarch64_imx8mp_evk.py |  67 ++++++++++++
 20 files changed, 188 insertions(+), 249 deletions(-)
 create mode 100755 tests/functional/test_aarch64_imx8mp_evk.py

