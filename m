Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35C1EA7940
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniMd-0003PA-0D; Wed, 04 Feb 2026 14:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniMa-0003Oy-IZ
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:16:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniMX-0003Dl-VW
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770232588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4R6mWTkV8KtAF/Uo52nTNjvxJFjzh1oC43L+CX1mTfo=;
 b=Wvo4Qs4h7gJZ69ZHlvLMRGGXCRBq0qdRXgh4hJHGwKybl9TqN/fCkavbZLuzyNj6BRsZDC
 yy2LLgAmAZzPEW7wKIa+dgX/42dq8jmTEAfGNeFRG2GmSMBzdAGXFKdHvP/BAsw55zLxyj
 Iu1n1dw1yPt5Hw4oxsIAwKX72xftDho=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-nmhT2D7RMi2Z3Cguil3GPQ-1; Wed, 04 Feb 2026 14:16:27 -0500
X-MC-Unique: nmhT2D7RMi2Z3Cguil3GPQ-1
X-Mimecast-MFC-AGG-ID: nmhT2D7RMi2Z3Cguil3GPQ_1770232585
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47edf8ba319so2100825e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770232584; x=1770837384; darn=nongnu.org;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4R6mWTkV8KtAF/Uo52nTNjvxJFjzh1oC43L+CX1mTfo=;
 b=HDcUVn6lDTNSAFrzIG2oxBul9p+wdXP6Iqry2O4LeZWMOL6UwxSMlIN0BpdRZaRxlx
 bguSfH47SBJqhCkYwBOQ7vgKNgAE/4WHJ/d5wNb8qaqBePdptexUAwh0nKEpmNpthPjZ
 8TqmUgCeVQbNT125Y8nV2jSHt0vunzghaEP2Sg9i5E1HTsRMGlFcUXSQqh9a9GcbJmkZ
 2Oh0PiBqvS5VeO89rPtfFa0ZPVtv3OvX/nnX0Zn7eCai1DrE+xtuxVkseE+kngNGiQww
 ZgRPz+JjHLKryG7TgZBKatL/kQd5QNXLurI04CG/bEMeKfxWkmMg9KTXV3OSlvyqrjX7
 PCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770232584; x=1770837384;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4R6mWTkV8KtAF/Uo52nTNjvxJFjzh1oC43L+CX1mTfo=;
 b=MaAgKiKsdXKAKTnGBDjHS6Rb3tnswZi+39dc9l58dJpvPJvCb36vsBYTRikCWX3TzZ
 aeyHbW2TCYWTcsU0nxwqxdwT/h76VTL164hCNp80YO92sWuh/t+fwgTKupiXzuscnhZs
 jhMoIsDLDS534OJvwZqmXHjM+Hw3osJgXiw3d4tqjeBcUzBzhIV0X8f3vDzibF5Cw17S
 DIoWW/sAG1rZupuIUQFqgq0iYfG5pA40fA9EDoyrnyPTEq7GJwbNqakaSHGjCD8+tch6
 Gp+BDbbKvivfp5mFoK2RSrL3quSZNo453QaQJeGPINqBNvUBSR1PcKefhLa2bC1HdAgh
 SO5A==
X-Gm-Message-State: AOJu0Yx3AJiztHa1LtgL9MYfER2fk3oDZJLAZ7+zs1IACjY9gGgqID1V
 Ld1JFXpgBTmOxq2HJSY2sTvm7bPaoDUSHDXce/E41/OYjolNoLWIkOM6WLoOn2Whmgy+L0M+ZGe
 FSUArHMPx9kQkNU0h05tF3qE+MaPEJbm7d2hcCTxZRYIdLWboTJow8xpPKHHGUzjeSFagpcDMC/
 bJi3sYd2ID3etjavBkps4O7NIfGVJDYAGrYA==
X-Gm-Gg: AZuq6aKQeR5UgiuGk7cRWuGjjIN1bKxiL45nYB3aZK+EQdGJRRHoHNSPnQjliR/ltwe
 VA99PvHZl8cIEoUOFXIHMr1IiR25iuR8fcSdgdySFcJrFnfVu/ogCQE5NHPSLPjsZFTRtyLRFOs
 p1XZPpmzNNI6HQq/HQKgpW71INlat5ru12JkBr9CKVRkLMR1RoaQAr3AAGhVLDPbuP431OeTNO7
 6XuEPyfADwyH2k80ClIAylHkVUz0RxWFEllJn8qplPlhw1A3SyMLDBT0OTbBCBqcmr7ETXcnWXo
 PP9lVpg2DDxdVptjW1SAOqYGzzwG4yQO80txmje85CIQzKcptXhVrdKykepuFyBunkqL+BQyxY6
 WGpX7DOGgEwFJY1RL2dEDkyrwhwRzOy0/HA==
X-Received: by 2002:a05:600c:800f:b0:477:af8d:203a with SMTP id
 5b1f17b1804b1-4830e9709b4mr51255205e9.27.1770232584277; 
 Wed, 04 Feb 2026 11:16:24 -0800 (PST)
X-Received: by 2002:a05:600c:800f:b0:477:af8d:203a with SMTP id
 5b1f17b1804b1-4830e9709b4mr51254775e9.27.1770232583743; 
 Wed, 04 Feb 2026 11:16:23 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805faf7sm8287425f8f.30.2026.02.04.11.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:16:23 -0800 (PST)
Date: Wed, 4 Feb 2026 14:16:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/51] virtio,pci,pc: features, fixes
Message-ID: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit b377abc220fc53e9cab2aac3c73fc20be6d85eea:

  Merge tag 'hw-misc-20260202' of https://github.com/philmd/qemu into staging (2026-02-03 07:52:04 +1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 1ef708ee4b765b9eac097192d54b69a603589f9b:

  hw/cxl: Take into account how many media operations are requested for param check (2026-02-04 07:42:50 -0500)

----------------------------------------------------------------
virtio,pci,pc: features, fixes

cxl:
    Additional RAS features support.
    Back-Invalidate support
    PCIe Flit mode support
    Misc fixes
intel_iommu:
    SVM support
vhost:
    support for indirect descriptors in shadow virtqueue
vhost-user:
    vhost-user-spi support
    vhost-user-blk inflight migration support
    vhost-user-blk inflight migration support
acpi:
    update VIOT maintainer
    WDAT watchdog support

misc fixes in pci, vhost, virtio, acpi
cleanups in acpi/ghes

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (1):
      pci/shpc: Do not unparent in instance_finalize()

Alexandr Moshkov (5):
      vhost-user.rst: specify vhost-user back-end action on GET_VRING_BASE
      vhost-user: introduce protocol feature for skip drain on GET_VRING_BASE
      vmstate: introduce VMSTATE_VBUFFER_UINT64
      vhost: add vmstate for inflight region with inner buffer
      vhost-user-blk: support inter-host inflight migration

Clément Mathieu--Drif (7):
      intel_iommu: Add an IOMMU index for pre-translated addresses
      intel_iommu: Support memory operations with pre-translated addresses
      pcie: Add a function to check if pasid privileged mode is enabled
      pci: Block ATS requests when privileged mode is disabled
      intel_iommu: Handle insufficient permissions during translation requests
      intel_iommu: Minimal handling of privileged ATS request
      intel_iommu: Add a CLI option to enable SVM

Daniil Tatianin (1):
      virtio/vhost: don't consider non-MAP_SHARED regions public

Davidlohr Bueso (1):
      hw/cxl: Add support for Maintenance command and Post Package Repair (PPR)

Dorinda Bassey (1):
      virtio-dmabuf: Ensure UUID persistence for hash table insertion

Eugenio Pérez (1):
      vhost: accept indirect descriptors in shadow virtqueue

Gavin Shan (5):
      acpi/ghes: Automate data block cleanup in acpi_ghes_memory_errors()
      acpi/ghes: Abort in acpi_ghes_memory_errors() if necessary
      target/arm/kvm: Exit on error from acpi_ghes_memory_errors()
      acpi/ghes: Bail early on error from get_ghes_source_offsets()
      acpi/ghes: Use error_fatal in acpi_ghes_memory_errors()

Haixu Cui (2):
      standard-headers: Update virtio_spi.h from Linux v6.18-rc3
      virtio-spi: Add vhost-user-spi device support

Honglei Huang (2):
      virtio-gpu: fix error handling in virgl_cmd_resource_create_blob
      virtio-gpu: use consistent error checking for virtio_gpu_create_mapping_iov

Igor Mammedov (6):
      x86: q35: ich9: add 'wdat' property
      acpi: add API to build WDAT instructions
      x86: q35: generate WDAT ACPI table
      tests: x86: q35: acpi: add WDAT table test case
      tests: acpi: update expected WDAT blob
      q35: Fix migration of SMRAM state

Jean-Philippe Brucker (1):
      MAINTAINERS: Update VIOT maintainer

Joelle van Dyne (1):
      virtio-gpu-virgl: correct parent for blob memory region

Jonathan Cameron (2):
      hw/cxl: Check for overflow on santize media as both base and offset 64bit.
      hw/cxl: Take into account how many media operations are requested for param check

Kevin Wolf (2):
      virtio: Fix crash when sriov-pf is set for non-PCI-Express device
      pcie_sriov: Fix PCI_SRIOV_* accesses in pcie_sriov_pf_exit()

Li Chen (1):
      virtio-pmem: ignore empty queue notifications

Michael S. Tsirkin (1):
      vhost-user: ancilliary -> ancillary

Philippe Mathieu-Daudé (1):
      hw/pci-host: Set DEVICE_CATEGORY_BRIDGE once in parent class_init()

Shiju Jose (7):
      hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature attributes in cmd_features_set_feature()
      hw/cxl: Add emulation for memory sparing control feature
      qapi: cxl: Refactor CXL event injection for common commands arguments
      hw/cxl/events: Update for rev3.2 common event record format
      hw/cxl/events: Updates for rev3.2 general media event record
      hw/cxl/events: Updates for rev3.2 DRAM event record
      hw/cxl/events: Updates for rev3.2 memory module event record

Wafer Xie (1):
      vdpa: fix vhost-vdpa suspended state not be shared

zhenwei pi (2):
      hw/virtio/virtio-crypto: verify asym request size
      cryptodev-builtin: Limit the maximum size

 MAINTAINERS                                 |   8 +-
 backends/cryptodev-builtin.c                |   9 +-
 docs/interop/vhost-user.rst                 |  60 +--
 docs/system/devices/virtio/vhost-user.rst   |   3 +
 hw/acpi/aml-build.c                         |  14 +
 hw/acpi/ghes-stub.c                         |   6 +-
 hw/acpi/ghes.c                              |  45 +--
 hw/acpi/ich9.c                              |   5 +
 hw/acpi/meson.build                         |   3 +-
 hw/acpi/wdat-ich9.c                         |  85 ++++
 hw/acpi/wdat-stub.c                         |  16 +
 hw/block/vhost-user-blk.c                   |  27 ++
 hw/cxl/cxl-events.c                         |   3 +-
 hw/cxl/cxl-mailbox-utils.c                  | 580 +++++++++++++++++++++++++++-
 hw/display/virtio-dmabuf.c                  |   6 +-
 hw/display/virtio-gpu-virgl.c               |   8 +-
 hw/display/virtio-gpu.c                     |   4 +-
 hw/i386/acpi-build.c                        |  13 +
 hw/i386/intel_iommu.c                       | 204 +++++++---
 hw/i386/intel_iommu_internal.h              |  14 +-
 hw/isa/lpc_ich9.c                           |   1 +
 hw/mem/cxl_type3.c                          | 330 +++++++++++++++-
 hw/mem/cxl_type3_stubs.c                    |  41 +-
 hw/pci-host/articia.c                       |   1 -
 hw/pci-host/aspeed_pcie.c                   |   1 -
 hw/pci-host/designware.c                    |   3 -
 hw/pci-host/gpex.c                          |   2 -
 hw/pci-host/grackle.c                       |   1 -
 hw/pci-host/gt64120.c                       |   1 -
 hw/pci-host/mv64361.c                       |   1 -
 hw/pci-host/pnv_phb.c                       |   1 -
 hw/pci-host/ppce500.c                       |   1 -
 hw/pci-host/q35.c                           |  28 +-
 hw/pci-host/raven.c                         |   1 -
 hw/pci-host/remote.c                        |   1 -
 hw/pci-host/sabre.c                         |   1 -
 hw/pci-host/uninorth.c                      |   4 -
 hw/pci-host/xilinx-pcie.c                   |   2 -
 hw/pci/pci.c                                |   4 +
 hw/pci/pci_host.c                           |   1 +
 hw/pci/pcie.c                               |  21 +-
 hw/pci/pcie_sriov.c                         |   9 +-
 hw/pci/shpc.c                               |   1 -
 hw/virtio/Kconfig                           |   5 +
 hw/virtio/meson.build                       |   3 +
 hw/virtio/vhost-shadow-virtqueue.c          |   1 +
 hw/virtio/vhost-user-spi-pci.c              |  69 ++++
 hw/virtio/vhost-user-spi.c                  |  65 ++++
 hw/virtio/vhost-user.c                      |   7 +
 hw/virtio/vhost-vdpa.c                      |   6 +-
 hw/virtio/vhost.c                           |  66 +++-
 hw/virtio/virtio-crypto.c                   |   7 +
 hw/virtio/virtio-pci.c                      |  20 +-
 hw/virtio/virtio-pmem.c                     |   1 -
 hw/virtio/virtio.c                          |   4 +-
 include/hw/acpi/ghes.h                      |   6 +-
 include/hw/acpi/ich9.h                      |   1 +
 include/hw/acpi/wdat.h                      | 121 ++++++
 include/hw/cxl/cxl_device.h                 | 152 +++++++-
 include/hw/cxl/cxl_events.h                 |  85 +++-
 include/hw/i386/intel_iommu.h               |   1 +
 include/hw/pci/pcie.h                       |   1 +
 include/hw/virtio/vhost-user-blk.h          |   1 +
 include/hw/virtio/vhost-user-spi.h          |  25 ++
 include/hw/virtio/vhost-user.h              |   2 +
 include/hw/virtio/vhost-vdpa.h              |   8 +-
 include/hw/virtio/vhost.h                   |   6 +
 include/migration/vmstate.h                 |  10 +
 include/standard-headers/linux/virtio_spi.h | 181 +++++++++
 qapi/cxl.json                               | 186 ++++++---
 target/arm/kvm.c                            |  10 +-
 tests/data/acpi/x86/q35/WDAT.wdat           | Bin 0 -> 308 bytes
 tests/qtest/bios-tables-test.c              |  13 +
 tests/qtest/q35-test.c                      |   6 -
 74 files changed, 2342 insertions(+), 297 deletions(-)
 create mode 100644 hw/acpi/wdat-ich9.c
 create mode 100644 hw/acpi/wdat-stub.c
 create mode 100644 hw/virtio/vhost-user-spi-pci.c
 create mode 100644 hw/virtio/vhost-user-spi.c
 create mode 100644 include/hw/acpi/wdat.h
 create mode 100644 include/hw/virtio/vhost-user-spi.h
 create mode 100644 include/standard-headers/linux/virtio_spi.h
 create mode 100644 tests/data/acpi/x86/q35/WDAT.wdat


