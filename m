Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CDFD6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUaE-0008QJ-Mj; Thu, 29 Jan 2026 11:09:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaB-0008Q6-FU
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:24 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUa9-0006Sr-6H
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:23 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4358fb60802so717429f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702959; x=1770307759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=70QiH5LNvGrYzYQCRcyOnyTaR27zdflGq4/lYfVhjIo=;
 b=pb7ijeJrwdibaWp5rN6SwcmZVUthXOTDOLRWfkFtIbXH4vgo2vJYBL5YFBL6K2yoHT
 O7Np/mvxl0rNK4oUnXElkx1OQyfZidOxrDCY0XFs1YE8IBciQd0GNf6xtGOwNMiwxH4r
 wCBu3Tlrup7dFh7eLc/tnRXTYp+8zSIacbZEkm/b0SUd0v6y7BZNlTuvhK4U76tFa3/A
 aCncibGWWbM72ec9VuYzFIoiRdvKocLQ0do5hYwu5F9iohuSmnRsgLfhbYri7RAB6nMF
 dHcriO8erePPlhpQFN5k9TFbqIuJMofTGQKZTfW8VUPvlw+L7+dIp2wKfme2W2OpUe1+
 A80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702959; x=1770307759;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=70QiH5LNvGrYzYQCRcyOnyTaR27zdflGq4/lYfVhjIo=;
 b=X8srzHL04Mv/2D2E8ZLcfiFQ6YWBR3cN+3rK7Qj7ijVL6o0Y4InBgvMeHjdEX1g7Dy
 SsyA8PVOB9jmB7+JCBuArjhEgCHTmjBPX9bA6bYlZiu0weqnHiamkbsgsJDbNo+qro8E
 Rw2pupUvYs/+h0cd5BM6N4MEYRCl2djdcIBueUwa7TEsC/F8XBt2HeGUpn7Z+lX+Rxfo
 5pKiSFu7SNnq/oPza+r8hsAnRIAgI6/f7+6MzfAXZGLGHQVspbqHVudTK4DbXbpWANAw
 18G4pZkmaML8KbkM6GK6/BhuaffHjL1EkM75oCW1c9LaK2DyBw3gm7BR56wU5V5oEV+k
 ON7w==
X-Gm-Message-State: AOJu0YywhTvxJCn50/Tx1KVunOsv6wk3bypkUGYZu1fJo2/ML8uy9frD
 YNV1rEsmKwcaVW4bdOmWtyPXvqU4K0OfQTkICKnuSEMmhHK23x4LEpgXsPf81N7UW/+Clr70D9f
 sPkvAGYI=
X-Gm-Gg: AZuq6aJuSwMAFMvWfrn700VlRu8duzhCVO2dyhtXLWk+zQJ/94vxmCLaZpHjY7ya8/W
 xo0WVAI1zQc7AZeW1nmlZqzcGNWotmXSbzsDbAAEnFDXMsWtJapKcZabKgYwPsC8PFk/iq8TGrX
 NBa0mriNj6DMmB1ThxdL083pSB6PYNroZydvbcsSy23t+4bEH8Vt8/sx7Cbpk3r8OhtUHcTq3fV
 tiU7DlfgGNvFPc6IHr6VaLhntSTyjRiHvNPEJX1RCL1+prbXue9jKY+PWQujei60TyPsz/9gdDm
 9yzVc9cT0CGcITeMUCU+IXJ9MLbQQKdyNofAkpt1Sch1dE+DLLczbmdKKhSLgXImbvb9j8dthJ8
 MJ/7ewYER4588Ko4nrY02Dei4tRu44TEV94UIk7znrgM5v/o2t1FfeajS0ldtJ75Q9+tdEP4mDM
 iLlel0kevUcpceDNhWWVWQJ08279xIPw==
X-Received: by 2002:a05:6000:288b:b0:435:b674:c9b1 with SMTP id
 ffacd0b85a97d-435ea09cd57mr5569205f8f.11.1769702959109; 
 Thu, 29 Jan 2026 08:09:19 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/43] target-arm queue
Date: Thu, 29 Jan 2026 16:08:34 +0000
Message-ID: <20260129160917.1415092-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Hi; the bulk of this arm pullreq is Shameer's SMMUv3 acceleration
series; there are a few other minor items in here also.

thanks
-- PMM

The following changes since commit 65fb9de4888f9bf32bc4f60c880da3dff04c4fd9:

  Merge tag 'pr-build_fix-20260128' of https://gitlab.com/pbo-linaro/qemu into staging (2026-01-29 13:29:33 +1100)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260129

for you to fetch changes up to 5252c077467a5570bf3b6b6278d206c46f51f9b8:

  arm: add DCZID_EL0 to idregs array (2026-01-29 13:45:39 +0000)

----------------------------------------------------------------
target-arm queue:
 * Support SMMUv3 acceleration
 * A few other minor cleanups and fixes

----------------------------------------------------------------
Alex Bennée (2):
      MAINTAINERS: add emulation.rst to ARM TCG CPUs
      docs/system: update FEAT_BBML[12] references

Cornelia Huck (2):
      arm: add {get,set}_dczid_bs helpers
      arm: add DCZID_EL0 to idregs array

Eric Auger (2):
      hw/pci-host/gpex: Allow to generate preserve boot config DSM #5
      hw/arm/virt-acpi-build: Add IORT RMR regions to handle MSI nested binding

Nicolin Chen (4):
      backends/iommufd: Introduce iommufd_backend_alloc_viommu
      backends/iommufd: Introduce iommufd_backend_alloc_vdev
      hw/arm/smmuv3-accel: Add set/unset_iommu_device callback
      hw/arm/smmuv3-accel: Add nested vSTE install/uninstall support

Philippe Mathieu-Daudé (2):
      target/arm/hvf: Move hvf_sysreg_[read, write]_cp() functions around
      target/arm/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0

Shameer Kolothum (31):
      hw/arm/smmu-common: Factor out common helper functions and export
      hw/arm/smmu-common: Make iommu ops part of SMMUState
      hw/arm/smmuv3-accel: Introduce smmuv3 accel device
      hw/arm/smmuv3-accel: Initialize shared system address space
      hw/pci/pci: Move pci_init_bus_master() after adding device to bus
      hw/pci/pci: Add optional supports_address_space() callback
      hw/pci-bridge/pci_expander_bridge: Move TYPE_PXB_PCIE_DEV to header
      hw/arm/smmuv3-accel: Restrict accelerated SMMUv3 to vfio-pci endpoints with iommufd
      hw/arm/smmuv3: Implement get_viommu_cap() callback
      hw/arm/smmuv3: propagate smmuv3_cmdq_consume() errors to caller
      hw/arm/smmuv3-accel: Install SMMUv3 GBPA based hwpt
      hw/pci/pci: Introduce a callback to retrieve the MSI doorbell GPA directly
      hw/arm/smmuv3-accel: Implement get_msi_direct_gpa callback
      hw/arm/virt: Set msi-gpa property
      hw/arm/smmuv3-accel: Add support to issue invalidation cmd to host
      hw/arm/smmuv3: Initialize ID registers early during realize()
      hw/arm/smmuv3-accel: Get host SMMUv3 hw info and validate
      hw/arm/virt: Set PCI preserve_config for accel SMMUv3
      tests/qtest/bios-tables-test: Prepare for IORT revison upgrade
      tests/qtest/bios-tables-test: Update IORT blobs after revision upgrade
      hw/arm/smmuv3: Block migration when accel is enabled
      hw/arm/smmuv3: Add accel property for SMMUv3 device
      hw/arm/smmuv3-accel: Add a property to specify RIL support
      hw/arm/smmuv3-accel: Add support for ATS
      hw/arm/smmuv3-accel: Add property to specify OAS bits
      backends/iommufd: Retrieve PASID width from iommufd_backend_get_device_info()
      backends/iommufd: Add get_pasid_info() callback
      hw/pci: Add helper to insert PCIe extended capability at a fixed offset
      hw/pci: Factor out common PASID capability initialization
      hw/vfio/pci: Synthesize PASID capability for vfio-pci devices
      hw/arm/smmuv3-accel: Make SubstreamID support configurable

 MAINTAINERS                                     |   1 +
 backends/iommufd.c                              |  76 ++-
 backends/trace-events                           |   2 +
 docs/system/arm/emulation.rst                   |   3 +-
 hw/arm/Kconfig                                  |   5 +
 hw/arm/meson.build                              |   3 +-
 hw/arm/smmu-common.c                            |  51 +-
 hw/arm/smmuv3-accel.c                           | 768 ++++++++++++++++++++++++
 hw/arm/smmuv3-accel.h                           |  88 +++
 hw/arm/smmuv3-internal.h                        |   1 +
 hw/arm/smmuv3.c                                 | 227 +++++--
 hw/arm/trace-events                             |   6 +
 hw/arm/virt-acpi-build.c                        | 131 +++-
 hw/arm/virt.c                                   |  39 +-
 hw/pci-bridge/pci_expander_bridge.c             |   1 -
 hw/pci-host/gpex-acpi.c                         |  29 +-
 hw/pci/pci.c                                    |  43 +-
 hw/pci/pcie.c                                   |  88 ++-
 hw/vfio/iommufd.c                               |   6 +-
 hw/vfio/pci.c                                   |  75 +++
 hw/vfio/pci.h                                   |   1 +
 hw/vfio/trace-events                            |   1 +
 include/hw/arm/smmu-common.h                    |   7 +
 include/hw/arm/smmuv3-common.h                  |  27 +-
 include/hw/arm/smmuv3.h                         |  10 +
 include/hw/arm/virt.h                           |   1 +
 include/hw/core/iommu.h                         |   1 +
 include/hw/pci-host/gpex.h                      |   1 +
 include/hw/pci/pci.h                            |  36 ++
 include/hw/pci/pci_bridge.h                     |   1 +
 include/hw/pci/pcie.h                           |   4 +
 include/system/host_iommu_device.h              |  20 +
 include/system/iommufd.h                        |  29 +-
 target/arm/cpu-sysregs.h.inc                    |   1 +
 target/arm/cpu.c                                |   2 +-
 target/arm/cpu.h                                |  14 +-
 target/arm/cpu64.c                              |   4 +-
 target/arm/helper.c                             |   5 +-
 target/arm/hvf/hvf.c                            | 167 +++---
 target/arm/kvm.c                                |  18 +-
 target/arm/tcg/cpu64.c                          |  22 +-
 target/arm/tcg/helper-a64.c                     |   2 +-
 target/arm/tcg/mte_helper.c                     |   4 +-
 target/arm/tcg/translate-a64.c                  |   2 +-
 target/arm/tcg/translate.h                      |   2 +-
 tests/data/acpi/aarch64/virt/IORT               | Bin 128 -> 128 bytes
 tests/data/acpi/aarch64/virt/IORT.its_off       | Bin 172 -> 172 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | Bin 364 -> 364 bytes
 tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 276 bytes
 49 files changed, 1829 insertions(+), 196 deletions(-)
 create mode 100644 hw/arm/smmuv3-accel.c
 create mode 100644 hw/arm/smmuv3-accel.h

