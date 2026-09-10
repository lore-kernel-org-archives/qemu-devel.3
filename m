Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A95C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4lYA-0006hG-0X; Thu, 10 Sep 2026 16:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lFH-0000Vp-2L
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lF1-0007EE-0h
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j+cHmbUic8dewEU9q7Cy4DLRacC77f3qS44/2PhMSfE=;
 b=ABSIfb5elew3Rnnnhku1lJe2JfT6LphdSBIROHV4U352LQ2F6MHrcIFO1HarwBmWW4WSyG
 tkB4wASOGWj+TbF/nbi/efqmGt7AIZLtBKNFTBXGz2WZeGSgnAoCwSYlNPZmG1ENgi+Y7a
 EJcp99uoMEF09ZxW1jSAD0Uvd3u+03U=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-fBkCfon_MAmIijSKfEKOng-1; Thu, 10 Sep 2026 16:11:22 -0400
X-MC-Unique: fBkCfon_MAmIijSKfEKOng-1
X-Mimecast-MFC-AGG-ID: fBkCfon_MAmIijSKfEKOng_1789071082
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5c82c2e9761so90952e0c.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071082; x=1789675882; darn=nongnu.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j+cHmbUic8dewEU9q7Cy4DLRacC77f3qS44/2PhMSfE=;
 b=mhUczmpm/luq5+lF7+JNYZIAEjgbawLLCaW9Mt+y94oGZZScxG57l779kvhv9h4aWu
 FlAJpW3BschD/3uCyxvnb7rStAaUKAIvhLmyZmKX2RXiJRUeE5RzFb1QRg+VMfRc1Uy0
 vxQ+JR9bAsS/ip7hwWz1ICoxKOeOSIvggOW2AhHCbg7A6Ot9Tu2uR1vefuSLcxZ2/Aek
 AsGRN5ebnGQme46K4Y6QcABOCsnsKIr4tgdNjCUBHIxKJkGRzzkcmx8HPGGpns4NNuqj
 GItHEepIXpmJ2GOgtOveimvzUhdfm3rQOkS/6vyN8qB5vr2viE70XxLygRvPztr9Z+j7
 6/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071082; x=1789675882;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j+cHmbUic8dewEU9q7Cy4DLRacC77f3qS44/2PhMSfE=;
 b=XkAhpPOghYxZNlAbAusTh17AUxY9ZBmB7wA6rXNiOmIiW9OSTJMDSXQJrqaxHAXeUs
 qzrCbJdb0QDN9Had9Ip5rfORpV96Ah+G1ErBa8xeeZgCVRJjoMS0CLYwrkc9SuFgsy4+
 C5qEKSty4iqa3WrXhZMsx5uctbkV4Djy0fJxf2Mrg0kVFm+O1cUAFz81v4P1fvI++rCt
 g0HkV0Ns9+KqhZDO6y/6VYYbgy4/EXwlKNEqfsI9jiZ0nX/U4IYR6PflQcapVoD+sCHZ
 n2mxyOnXVygYvL9kqBpm1ftiOoApZ9BfLd23dsfK/3/MNFxR1HWr4vQEiGXLYOA1ZfTc
 ZHSQ==
X-Gm-Message-State: AFuF++lPsMEIdg8Jiu4vYEsU7dRsAAtfwNeMME5zbndsePucu96OJwHk
 2EwNDlAZ2TteoyHc++NL0/dOZHbks134v3M3r1rCS/YCacGt3SZeqJ/dnr3ApWvxxuvGNgpzpeu
 vy7QvrDSasFJBaqqEbtiMOcirzs4aXAzvl2KVwm7ISNoEjulxdvunXgl3YIUl4PZ+GeLLXRu9ZW
 FWN8KhW4yULNMv6oDS0ODQRqxTY3PS4aVaGw==
X-Gm-Gg: AYBFou1iJbIPvl5ZWHqSm884NM/y61xIwk6JqZuxbkklpKI+RHiQDhV3SS1Cz6AO1MM
 h2ESBpf/LPCKXE/ftcrfunNF3jinRk0ftJKw9Sa/k981xmpcul6gd34m/wsYgxHllEKs039i/Ac
 hJFhejTZVWCtpRhSMLB3TYZmZl2HnJtM3uHbDPZRxFzYCSKRQXwS4pB08b/pbkb5sX5ScEV4gBf
 MherS0bLopM3i66nsLd+n+hjxhuuWf/3pV5ggWp731zburttcfhwFF+RwForjSAvszFKJzHM0Dz
 81XpX3cvE8tetcc5dZDTd3JNuuzIfq8sRTg3eUDFlNdIK+A0fJWnnI6GsqB8jYH+ywQF35R1quL
 RlT4dnOUsVvQR2r1LLfsoi4s=
X-Received: by 2002:a05:6122:1785:b0:5bd:c27a:dafd with SMTP id
 71dfb90a1353d-5c846283be4mr1901403e0c.3.1789071081618; 
 Thu, 10 Sep 2026 13:11:21 -0700 (PDT)
X-Received: by 2002:a05:6122:1785:b0:5bd:c27a:dafd with SMTP id
 71dfb90a1353d-5c846283be4mr1901323e0c.3.1789071080863; 
 Thu, 10 Sep 2026 13:11:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c8470ae511sm501610e0c.5.2026.09.10.13.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:11:20 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:11:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/90] pci, vhost, virtio, iommu, apci: features, fixes
Message-ID: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 1df256f5968e9f7c3c4533a1383b071c044a36d6:

  Merge tag 'qom-qapi-pr-pr-v1' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-09-08 18:35:31 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 99c75c61d61251d98e0b93dd199edbb10a990205:

  MAINTAINERS: add Junjie Cao as CXL reviewer (2026-09-10 10:55:03 -0400)

----------------------------------------------------------------
pci, vhost, virtio, iommu, apci: features, fixes

migration/cpr now supports vhost-vsock devices
new vhost-user-media device
virtio-net now supports live-TAP local migration
vhost-user-gpu now supports blob resources and shared memory
cxl now supports CFMW restrictions and per-window options
intel_iommu now supports concurrent page fault handling with PRI
pci now batches memory transactions around mapping updates
vhost-user-blk now allows toggling inflight-migration at runtime
virtio-rtc now supports smeared UTC clock type
intel_iommu now exposes SMPWC when SVM is enabled
new reviewer for CXL patches

Fixes, cleanups all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Albert Esteve (4):
      linux-headers: add VIRTIO_ID_MEDIA
      hw/display: add vhost-user-media device
      hw/display/vhost-user-media: add shared memory region BAR
      linux-headers: Update to Linux v7.3-rc1

Alexandr Moshkov (6):
      vhost-user: add skip_drain param to do_vhost_virtqueue_stop
      vhost-user: add GET_VRING_BASE_SKIP_DRAIN message
      vhost-user: use skip_drain with GET_VRING_BASE_SKIP_DRAIN message
      vhost-user-blk: make inflight-migration prop mutable on running vm
      vhost-user-blk: move inflight_needed higher
      vhost-user-blk: use GET_VRING_BASE_SKIP_DRAIN when inflight-migration is on

Alyssa Ross (1):
      vhost-user.rst: fix typo

Andrey Drobyshev (10):
      vhost-vsock: block CPR migration modes
      vhost: add vhost_reset_owner op
      vhost-vsock: don't reset connections during CPR
      vhost-vsock: fix FD leak in realize()
      vhost-vsock: preserve vhost FD during CPR
      vhost: factor out vhost_dev_init_backend()
      vhost: make vhost_dev_cleanup() safe on a partially initialized device
      vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
      vhost: add vhost_dev_is_initialized() helper
      vhost-vsock: hand off device ownership across CPR

Bin Guo (2):
      libvhost-user: accept the postcopy client base ack in vu_add_mem_reg()
      libvhost-user: return the backend mapping address for added regions

Clément MATHIEU--DRIF (4):
      intel_iommu: Support concurrent page fault handling with PRI
      intel_iommu: Only set dirty bit when PTE exposes write permission
      intel_iommu: Always write all the flags passed to vtd_set_flag_in_pte
      intel_iommu: Expose SMPWC when SVM is enabled

Davidlohr Bueso (5):
      tests/bios-tables-test: Exclude CEDT.cxl for the CFMW restriction change
      hw/cxl: Drop Back-Invalidate from default CFMW window restrictions
      tests/acpi/cxl: Update CEDT.cxl for the default CFMW restrictions
      hw/cxl: Add configurable CXL Fixed Memory Window restriction flags
      tests/qtest/cxl: Add CXL Fixed Memory Window restriction flag tests

Denis V. Lunev (2):
      pci: batch BAR remapping into one memory transaction
      pci: load a device's config inside one memory transaction

Dorinda Bassey (1):
      vhost: Fix SHMEM_MAP transaction ordering and resulting deadlock

Feifan Qian (1):
      vhost-user: Reject SHMEM_MAP when no KVM memory slot is left

GuoHan Zhao (1):
      virtio-crypto: clean up every data queue

Hanna Czenczek (6):
      hw/virtio-blk: Account discard operations
      hw/virtio-blk: Complete zone-append cookies
      hw/nvme: Fix block accounting in nvme_copy()
      hw/nvme: Fix block accounting for compare
      hw/ide: Have ide_dma_cb() complete accounting
      hw/scsi-disk: Fix accounting for IGNORE, ret > 0

Jia Jia (2):
      virtio: reduce code duplication for split ring
      hw/virtio: reject inverted virtio-iommu IOVA ranges

Junjie Cao (3):
      hw/cxl: Fix guest-triggerable QEMU exit on reserved interleave ways
      hw/cxl: fix the CDAT DOE overlapping the Flex Bus DVSEC when sn= is set
      MAINTAINERS: add Junjie Cao as CXL reviewer

Kuan-Wei Chiu (1):
      virtio-rtc: Report smeared UTC clock type

Laurent Vivier (2):
      hw/net/virtio-net: check packet size before VLAN tag access in receive_filter()
      hw/net/virtio-net: strip trailing padding when caching RSC segment

Marc-André Lureau (1):
      vhost-user-gpu: validate command buffer size in submit_3d

Matej Hrica (2):
      vhost-user-gpu: Add shared memory region support
      vhost-user-gpu: Forward RESOURCE_BLOB and CONTEXT_INIT flags

Michael S. Tsirkin (7):
      virtio: fix exit(1) on DMA mapping failure during migration restore
      virtio: fix config_len DoS in migration restore path
      virtio-pci: reject Q_ENABLE write on already-enabled queue
      meson: disable "maybe uninitilized" errors with -Og
      virtio-balloon: fix free-page BH teardown on unrealize
      net/tap-solaris: Fix resource leaks on error paths
      virtio-net: validate IHL in virtio_net_rsc_extract_unit4 before use

Philippe Mathieu-Daudé (4):
      hw/acpi: Make AcpiGedState const in build_ged_aml()
      hw/hotplug: Mark various HotplugHandlerClass variables as const
      hw/hotplug: Reduce some HotplugHandler variables scope
      hw/hotplug: Constify HotplugHandler

Sairaj Kodilkar (7):
      amd_iommu: Return empty efr for stub call
      tests/acpi: x86: Allow IVRS acpi table changes
      amd_iommu: acpi-build: update PA, GVA and VA size macros
      acpi_build: Use IOMMU pci device to build IOMMU DeviceID
      acpi_build: Build IVRS feature report using extended feature register
      amd_iommu: acpi-build: Remove unsupported PPR and HE feature
      tests/acpi: x86: update golden masters for IVRS

Stefan Hajnoczi (1):
      virtio-scsi: set dataplane_started to false upon failure

Vladimir Sementsov-Ogievskiy (16):
      net/tap: rework tap_parse_script
      net/tap: improve script/downscript options documentation
      net/tap: deprecate "no" as special value for script/downscript
      net/tap: move vhost-net open() calls to tap_parse_vhost_fds()
      net/tap: move vhost initialization to tap_setup_vhost()
      net/tap: use container_of instead of DO_UPCAST
      net/tap: QOMify tap backend
      net/tap: add TYPE_VMSTATE_IF interface
      qapi: add local migration parameter
      migration/fd: fix fd leak when fd is not valid for migration
      migration/fd: add errp parameter to migration_fd_valid()
      migration: check that transfer is UNIX socket when "local" set
      virtio-net: support local migration of backend
      net/tap: disable read polling for stopped VM
      net/tap: support local migration with virtio-net
      tests/functional: add test_tap_migration

Xiong Weimin (1):
      hw/virtio: Propagate vhost_virtqueue_mask errors

 MAINTAINERS                                   |   7 +
 docs/about/deprecated.rst                     |  18 +
 docs/interop/vhost-user.rst                   |  44 ++-
 docs/system/devices/cxl.rst                   |  25 +-
 docs/system/i386/microvm.rst                  |   4 +-
 docs/system/i386/xenpvh.rst                   |   2 +-
 docs/system/ppc/ppce500.rst                   |   4 +-
 docs/system/riscv/microchip-icicle-kit.rst    |   2 +-
 docs/system/riscv/sifive_u.rst                |   2 +-
 meson.build                                   |   4 +
 qapi/machine.json                             |  28 ++
 qapi/migration.json                           |  21 +-
 qapi/net.json                                 |  45 ++-
 hw/i386/amd_iommu.h                           |  27 +-
 hw/i386/intel_iommu_internal.h                |   1 +
 hw/s390x/ccw-device.h                         |   2 +-
 include/hw/acpi/cpu.h                         |   4 +-
 include/hw/acpi/cpu_hotplug.h                 |   2 +-
 include/hw/acpi/generic_event_device.h        |   3 +-
 include/hw/acpi/ich9.h                        |  10 +-
 include/hw/acpi/memory_hotplug.h              |   4 +-
 include/hw/acpi/pcihp.h                       |   8 +-
 include/hw/core/boards.h                      |   4 +-
 include/hw/core/hotplug.h                     |  13 +-
 include/hw/core/qdev.h                        |  14 +-
 include/hw/cxl/cxl.h                          |  12 +
 include/hw/i386/microvm.h                     |   4 +-
 include/hw/i386/x86.h                         |  10 +-
 include/hw/mem/nvdimm.h                       |   2 +-
 include/hw/pci/pci_bridge.h                   |   6 +-
 include/hw/pci/pcie.h                         |   8 +-
 include/hw/pci/shpc.h                         |   6 +-
 include/hw/ppc/spapr_nvdimm.h                 |   2 +-
 include/hw/virtio/vhost-backend.h             |   2 +
 include/hw/virtio/vhost-user-media.h          |  46 +++
 include/hw/virtio/vhost-user.h                |   2 +-
 include/hw/virtio/vhost-vsock.h               |   4 +
 include/hw/virtio/vhost.h                     |  65 +++-
 include/hw/virtio/virtio-balloon.h            |   1 +
 include/hw/virtio/virtio-net.h                |   1 +
 include/hw/virtio/virtio.h                    |   2 +-
 include/migration/misc.h                      |   2 +
 include/migration/vmstate.h                   |   2 +
 include/net/net.h                             |   9 +
 include/net/tap.h                             |   2 +
 include/standard-headers/linux/ethtool.h      |   6 +
 include/standard-headers/linux/virtio_ids.h   |   1 +
 linux-headers/linux/iommufd.h                 |  45 ++-
 linux-headers/linux/userfaultfd.h             |  54 ++-
 linux-headers/linux/vduse.h                   |  28 ++
 linux-headers/linux/vfio.h                    |  21 ++
 linux-headers/linux/vfio_zdev.h               |   2 +
 backends/cryptodev-vhost.c                    |   2 +-
 backends/vhost-user.c                         |   2 +-
 contrib/vhost-user-gpu/virgl.c                |  12 +-
 hw/acpi/acpi-cpu-hotplug-stub.c               |   4 +-
 hw/acpi/acpi-mem-hotplug-stub.c               |   4 +-
 hw/acpi/acpi-nvdimm-stub.c                    |   2 +-
 hw/acpi/acpi-pci-hotplug-stub.c               |   8 +-
 hw/acpi/cpu.c                                 |   6 +-
 hw/acpi/cxl.c                                 |   2 +-
 hw/acpi/generic_event_device.c                |  13 +-
 hw/acpi/ich9.c                                |  10 +-
 hw/acpi/memory_hotplug.c                      |   7 +-
 hw/acpi/nvdimm.c                              |   2 +-
 hw/acpi/pcihp.c                               |  11 +-
 hw/acpi/piix4.c                               |  12 +-
 hw/arm/virt.c                                 |  23 +-
 hw/block/vhost-user-blk.c                     |  60 +++-
 hw/block/virtio-blk.c                         |  38 ++-
 hw/char/virtio-serial-bus.c                   |   6 +-
 hw/core/hotplug.c                             |  16 +-
 hw/core/qdev-hotplug.c                        |  10 +-
 hw/core/qdev.c                                |   2 +-
 hw/cxl/cxl-host.c                             |  48 ++-
 hw/display/vhost-user-gpu.c                   |  17 +
 hw/display/vhost-user-media-pci.c             | 115 +++++++
 hw/display/vhost-user-media.c                 | 388 ++++++++++++++++++++++
 hw/i386/acpi-build.c                          |  65 ++--
 hw/i386/amd_iommu-stub.c                      |   2 +-
 hw/i386/amd_iommu.c                           |   2 +-
 hw/i386/intel_iommu.c                         | 118 ++++---
 hw/i386/intel_iommu_accel.c                   |   6 +
 hw/i386/microvm.c                             |  12 +-
 hw/i386/pc.c                                  |  28 +-
 hw/i386/x86-common.c                          |   8 +-
 hw/ide/core.c                                 |   3 +-
 hw/intc/loongarch_dintc.c                     |   8 +-
 hw/intc/loongarch_extioi_common.c             |   4 +-
 hw/intc/loongarch_ipi.c                       |   4 +-
 hw/loongarch/virt.c                           |  44 +--
 hw/mem/cxl_type3.c                            |   6 +-
 hw/net/vhost_net.c                            |   9 +-
 hw/net/virtio-net.c                           | 131 +++++++-
 hw/nvme/ctrl.c                                |  78 +++--
 hw/pci-bridge/pci_bridge_dev.c                |   6 +-
 hw/pci/pci.c                                  |   8 +
 hw/pci/pcie.c                                 |  10 +-
 hw/pci/pcie_port.c                            |   2 +-
 hw/pci/shpc.c                                 |  11 +-
 hw/ppc/e500plat.c                             |   4 +-
 hw/ppc/spapr.c                                |  48 +--
 hw/ppc/spapr_nvdimm.c                         |   2 +-
 hw/ppc/spapr_pci.c                            |  12 +-
 hw/remote/machine.c                           |   2 +-
 hw/riscv/virt.c                               |   6 +-
 hw/s390x/css-bridge.c                         |   2 +-
 hw/s390x/s390-pci-bus.c                       |  12 +-
 hw/s390x/s390-virtio-ccw.c                    |  16 +-
 hw/s390x/virtio-ccw-md.c                      |  10 +-
 hw/s390x/virtio-ccw.c                         |   2 +-
 hw/scsi/scsi-disk.c                           |   7 +
 hw/scsi/vhost-scsi-common.c                   |   2 +-
 hw/scsi/virtio-scsi-dataplane.c               |   2 +-
 hw/scsi/virtio-scsi.c                         |  10 +-
 hw/scsi/vmw_pvscsi.c                          |   4 +-
 hw/virtio/vdpa-dev.c                          |   2 +-
 hw/virtio/vhost-kernel.c                      |   6 +
 hw/virtio/vhost-user-base.c                   |   2 +-
 hw/virtio/vhost-user-fs.c                     |   2 +-
 hw/virtio/vhost-user-scmi.c                   |   2 +-
 hw/virtio/vhost-user.c                        |  83 +++--
 hw/virtio/vhost-vsock-common.c                |   2 +-
 hw/virtio/vhost-vsock.c                       | 220 +++++++++++-
 hw/virtio/vhost.c                             | 111 +++++--
 hw/virtio/virtio-balloon.c                    |  19 +-
 hw/virtio/virtio-crypto.c                     |   5 +-
 hw/virtio/virtio-iommu.c                      |  17 +-
 hw/virtio/virtio-md-pci.c                     |  10 +-
 hw/virtio/virtio-pci.c                        |   7 +
 hw/virtio/virtio-rtc.c                        |   3 +-
 hw/virtio/virtio.c                            |  85 ++---
 hw/xen/xen-bus.c                              |   2 +-
 migration/fd.c                                |  28 +-
 migration/migration.c                         |  13 +
 migration/options.c                           |  18 +-
 net/net.c                                     |  14 +-
 net/tap-solaris.c                             |  69 ++--
 net/tap.c                                     | 448 ++++++++++++++++++++-----
 stubs/hotplug-stubs.c                         |   6 +-
 subprojects/libvhost-user/libvhost-user.c     |  34 +-
 system/qdev-monitor.c                         |   4 +-
 tests/qtest/cxl-test.c                        |  95 ++++++
 hw/display/Kconfig                            |   5 +
 hw/display/meson.build                        |   3 +
 qemu-options.hx                               |  13 +-
 tests/data/acpi/x86/q35/CEDT.cxl              | Bin 184 -> 184 bytes
 tests/data/acpi/x86/q35/IVRS.ivrs             | Bin 176 -> 176 bytes
 tests/functional/x86_64/meson.build           |   1 +
 tests/functional/x86_64/test_tap_migration.py | 461 ++++++++++++++++++++++++++
 150 files changed, 3245 insertions(+), 714 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user-media.h
 create mode 100644 hw/display/vhost-user-media-pci.c
 create mode 100644 hw/display/vhost-user-media.c
 create mode 100755 tests/functional/x86_64/test_tap_migration.py


