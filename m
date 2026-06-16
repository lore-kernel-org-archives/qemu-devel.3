Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DC2CD98EE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAS-0006d0-3H; Tue, 16 Jun 2026 15:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7W-0004T1-Ob
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:06:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7S-0000qN-UH
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:06:45 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso61623635e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636801; x=1782241601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9XCd/6oGMUynW/cw9h9rtP7bvtHhS1rEY/kFixunafQ=;
 b=MzN2EVCD9kGXOUk4qbi/9m5Tbnh4Q36Ttxfdf1jSaFVimU3tfZnIE799Ox173nYg+V
 L/3Q1dnzMcuZj4dSP59o1JWxg3ztXhFzPC4jP2W2rDGzrdn/j19vHu3SD/G7G9OYyFT5
 Mv8O0YJQtXJuvMwWcsdu0g2sdaDJ8GKY1eW0FnJzRwKAzaT2dIzvsxfy2nM5jdxk/iWM
 ZRNXYBguXVPfw0l2nyRvrTIiyIGRpaySa7RnPxEaN59XIsCew+OmTYfegpCPaWEW60DN
 uVc0AhDGSdYcphWGx2oYq16qK1LNWkq+zn7xw5o8T9u5DYzRXQpAgTCTDKpnkh3Vl4Wh
 ywpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636801; x=1782241601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9XCd/6oGMUynW/cw9h9rtP7bvtHhS1rEY/kFixunafQ=;
 b=K0/rORjAEaMLMDJtgpL77UWpb6dqnel1Qi1GsCx0btNaHnc/IvlHNeyhGr2mUqyKmU
 sPe+cUvJeAzn1PuXJcBR8GbPANSC6sQ6qVdcCyhid5LKCLJihZiWpT7eHfb2j6W2XUNn
 S+PisBy7jhW3qKIWnHNGN9OOjVvGNkdXc4Y/Ex0fsWsUkaz8Yu2ZdnxUNu82J+C2oWxc
 f+V1UxgwkAWnN3lMONPneKgRD7+ViFOi26qp6/PQsQLsoLzyGqo1SHDrk+u6aXgE9URU
 iboPlk4qyZNYN+BX+wUQltfhAQLK/KFTr3wes4hLWkEhTC8woVF8+J4uVljSDQV9TX2r
 Pz2Q==
X-Gm-Message-State: AOJu0YzawzQXa0YtXOnTnksR3/irSktnTcXqAOHRWft7abe2ckuCueRg
 LuoF2Ei1dw7K0+J+bxBroo3zIE8fNJuqWXEB7rsqGh0YwDrvQfeEasv2jEkFZ+LO+VcSSU5Go6l
 flrIu
X-Gm-Gg: Acq92OEHmwTDbQGxc03fp07cSlnp0+AAM5Y33Dn0PuOpqAexRqMqSG6iu6CLpor1n+w
 EINqEhXn3W0mGH6F1E1hVSk0N8aCgeHcfzuvD0dOyUcC2OgWGzxoyBVFTqnkyaVPBrJIQUExOml
 MRk5XwEBrwOYOxBknpurV3vq4mWL4pLPn+YQF7a1AWaAjtoadwWLMubduEYiTTIBPtQqwtQyZsA
 ct6iVgC1/Zz8/7GqyCKIToA5rL319fLZ/ApQyj8rQKs93EyAVCRCCZDvxx3YPm/JrfmL0RH83Zi
 iTV4ZDTbhVPQmIDVTeLT3Xvopjp9Q7lGenqpt0SxFsRKIC50LbAY8pijMGgcxmZ2i8skw6PUlGG
 TAclXonDdDlGPRJBOk5hD8cbsrvUdMW01u2gRRekY0HIGk95TEYZzNsz11DX2eftmBEW9CXglZ1
 kH5XkuOOhuenwbPEQAaQtMG58dfLG2nymSGmMa50zoMIE86QggJ8knXbCkITqHxOLS2naHjBVoC
 mmoLVF7ICcw3RHgoU+nXcCUrJfkduOy
X-Received: by 2002:a05:600c:840f:b0:492:1e36:4270 with SMTP id
 5b1f17b1804b1-492333df722mr13170015e9.36.1781636800847; 
 Tue, 16 Jun 2026 12:06:40 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.06.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:06:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/61] target-arm queue
Date: Tue, 16 Jun 2026 20:05:37 +0100
Message-ID: <20260616190639.3462006-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Hi; here's this week's arm pullreq; lots of smmuv3 related work here,
plus some initial work towards emulating FEAT_SVE2p2.

thanks
-- PMM

The following changes since commit 2f28d34ea0aead9830478cd1d3d0dd9d9191d82e:

  Merge tag 'pull-tcg-20260612' of https://gitlab.com/rth7680/qemu into staging (2026-06-13 14:02:34 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260616

for you to fetch changes up to 8de1ba58af636d1844be43b9ea6e34ced302a057:

  target/arm: Implement floating-point log and convert to integer (zeroing) (2026-06-16 16:54:25 +0100)

----------------------------------------------------------------
target-arm queue:
 * Implementation of various insns preparatory to FEAT_SVE2p2
 * hw/arm/smmuv3: Make smmuv3 ATS, RIL, SSIDSIZE, and OAS 'auto' properties work
 * hw/pci/pci: Enforce pci_setup_iommu_per_bus() is called only once per bus
 * hw/arm/virt: Introduce Tegra241 CMDQV support for accelerated SMMUv3
 * target/arm: honour CCR.BFHFNMIGN for probed data BusFaults
 * hw/arm/bcm2838: Route I2C interrupts to GIC

----------------------------------------------------------------
Eric Auger (1):
      hw/pci/pci: Enforce pci_setup_iommu_per_bus() is called only once per bus

Kyle Fox (1):
      target/arm: honour CCR.BFHFNMIGN for probed data BusFaults

Nathan Chen (9):
      hw/arm/smmuv3: Update ATC invalidation check
      hw/arm/smmuv3: Improve accel SMMUv3 usage documentation
      hw/arm/smmuv3-accel: Add helper for resolving auto parameters
      hw/arm/smmuv3-accel: Implement "auto" value for "ats"
      hw/arm/smmuv3-accel: Implement "auto" value for "ril"
      hw/arm/smmuv3-accel: Implement "auto" value for "ssidsize"
      hw/arm/smmuv3-accel: Implement "auto" value for "oas"
      hw/arm/smmuv3: Set default ats, ril, ssidsize, oas to auto
      qemu-options.hx: Support "auto" for accel SMMUv3 properties

Nicholas Righi (1):
      hw/arm/bcm2838: Route I2C interrupts to GIC

Nicolin Chen (15):
      backends/iommufd: Update iommufd_backend_get_device_info
      backends/iommufd: Update iommufd_backend_alloc_viommu to allow user ptr
      backends/iommufd: Introduce iommufd_backend_alloc_hw_queue
      backends/iommufd: Introduce iommufd_backend_viommu_mmap
      hw/arm/tegra241-cmdqv: Implement CMDQV init
      hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU alloc/free
      hw/arm/tegra241-cmdqv: mmap host VINTF Page0 for CMDQV
      hw/arm/tegra241-cmdqv: Emulate CMDQ-V Config region
      hw/arm/tegra241-cmdqv: Emulate VCMDQ register reads
      hw/arm/tegra241-cmdqv: Emulate VCMDQ register writes
      hw/arm/tegra241-cmdqv: Allocate HW VCMDQs once configured
      hw/arm/tegra241-cmdqv: Use mmap'd host VINTF page0 for virtual VINTF page0
      hw/arm/tegra241-cmdqv: Initialize register state on reset
      hw/arm/tegra241-cmdqv: Limit queue size based on backend page size
      hw/arm/virt-acpi: Advertise Tegra241 CMDQV nodes in DSDT

Richard Henderson (18):
      target/arm: Add feature predicates for SVE2.2 and SME2.2
      target/arm: Rename sve unary predicated patterns
      target/arm: Enable zeroing in DO_ZPZ macros in sve_helper.c
      target/arm: Expand DO_ZPZ in translate-sve.c
      target/arm: Implement SVE integer unary operations (predicated, zeroing)
      target/arm: Implement SVE bitwise unary operations (predicated, zeroing)
      target/arm: Implement SVE reverse within elements (zeroing)
      target/arm: Implement SVE reverse doublewords (zeroing)
      target/arm: Implement SVE2 integer unary operations (predicated, zeroing)
      target/arm: Add data argument to do_frint_mode
      target/arm: Implement Floating-point round to integral value (predicated, zeroing)
      target/arm: Implement Floating-point convert (predicated, zeroing)
      target/arm: Implement Floating-point square root (predicated, zeroing)
      target/arm: Implement SCVTF, UCVTF (predicated, zeroing)
      target/arm: Implement FRINT{32,64}{X,Z}
      target/arm: Enable zeroing in DO_FCVT{N, L}T macros in sve_helper.c
      target/arm: Implement SVE floating-point convert (top, predicated, zeroing)
      target/arm: Implement floating-point log and convert to integer (zeroing)

Shameer Kolothum (16):
      system/iommufd: Remove unused viommu pointer from IOMMUFDVeventq
      hw/arm/smmuv3-accel: Introduce CMDQV ops interface
      hw/arm/tegra241-cmdqv: Add Tegra241 CMDQV ops backend stub
      hw/arm/smmuv3-accel: Wire CMDQV ops into accel lifecycle
      hw/arm/virt: Use stored SMMUv3 device list for IORT build
      hw/arm/tegra241-cmdqv: Probe host Tegra241 CMDQV support
      hw/arm/virt: Link SMMUv3 CMDQV resources to platform bus
      hw/arm/tegra241-cmdqv: Route allocated VCMDQ Page0 accesses to the mmap'd host VINTF page0
      memory: Allow RAM device regions to skip IOMMU mapping
      hw/arm/smmuv3-accel: Introduce common helper for veventq read
      hw/arm/tegra241-cmdqv: Read and propagate Tegra241 CMDQV errors
      hw/arm/smmuv3: Add per-device identifier property
      hw/arm/smmuv3-accel: Introduce helper to query CMDQV type
      hw/arm/smmuv3-accel: Enforce viommu association when CMDQV is active
      hw/arm/tegra241-cmdqv: Document the CMDQV design and lifecycle
      hw/arm/smmuv3: Add cmdqv property for SMMUv3 device

 backends/iommufd.c                   |   64 ++
 backends/trace-events                |    4 +-
 hw/arm/Kconfig                       |    5 +
 hw/arm/bcm2835_peripherals.c         |    9 +
 hw/arm/bcm2838.c                     |    4 +
 hw/arm/meson.build                   |    2 +
 hw/arm/smmu-common.c                 |    4 +-
 hw/arm/smmuv3-accel-stubs.c          |   12 +
 hw/arm/smmuv3-accel.c                |  277 +++++++--
 hw/arm/smmuv3-accel.h                |   50 ++
 hw/arm/smmuv3.c                      |   91 +--
 hw/arm/tegra241-cmdqv-stubs.c        |   16 +
 hw/arm/tegra241-cmdqv.c              | 1119 ++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.h              |  384 ++++++++++++
 hw/arm/trace-events                  |   11 +
 hw/arm/virt-acpi-build.c             |  127 ++--
 hw/arm/virt.c                        |   37 ++
 hw/core/machine.c                    |    5 +
 hw/pci/pci.c                         |    9 +-
 hw/vfio/iommufd.c                    |    4 +-
 hw/vfio/listener.c                   |    6 +
 hw/vfio/trace-events                 |    1 +
 include/hw/arm/bcm2835_peripherals.h |    2 +
 include/hw/arm/bcm2838_peripherals.h |    1 +
 include/hw/arm/smmuv3.h              |    6 +
 include/hw/arm/virt.h                |    1 +
 include/hw/pci/pci.h                 |   16 +-
 include/system/iommufd.h             |   17 +-
 include/system/memory.h              |   21 +
 qemu-options.hx                      |   33 +-
 system/memory.c                      |   10 +
 target/arm/cpu-features.h            |   17 +-
 target/arm/tcg/helper-sve-defs.h     |    9 +
 target/arm/tcg/m_helper.c            |   16 +-
 target/arm/tcg/sve.decode            |  261 +++++---
 target/arm/tcg/sve_helper.c          |   30 +-
 target/arm/tcg/tlb_helper.c          |   24 +
 target/arm/tcg/translate-sve.c       |  471 ++++++++++----
 38 files changed, 2861 insertions(+), 315 deletions(-)
 create mode 100644 hw/arm/tegra241-cmdqv-stubs.c
 create mode 100644 hw/arm/tegra241-cmdqv.c
 create mode 100644 hw/arm/tegra241-cmdqv.h

