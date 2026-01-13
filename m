Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16592D29DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfapU-0005pv-Cv; Tue, 13 Jan 2026 04:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfapS-0005kV-D3
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:36:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfapQ-0003F1-Lr
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fFuRm5S2izZe3P8/ZcEBks40W1UsSlYW602pjN5vODU=;
 b=F6e+5lnThSR/Qdr6WXjcLEldzq63ChiM9tRcY5RINwW4Umn2wVwJZeIcEVlDs6fmVv0KwF
 2rqt9oorUO56eBif8K7lNDX2xGDvOEudAOi7fFmK37FWGzJ0nP6CPy5TrDi0Gfl7cg4ns0
 yKWUHjJGjjDJwiA4BAk2rlNisLTnvL0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-cOdprhB9NrO3y31RLAcG-Q-1; Tue,
 13 Jan 2026 04:36:42 -0500
X-MC-Unique: cOdprhB9NrO3y31RLAcG-Q-1
X-Mimecast-MFC-AGG-ID: cOdprhB9NrO3y31RLAcG-Q_1768297001
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84FBF195609D; Tue, 13 Jan 2026 09:36:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E1B7D30001A2; Tue, 13 Jan 2026 09:36:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/41] vfio queue
Date: Tue, 13 Jan 2026 10:35:56 +0100
Message-ID: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit cf3e71d8fc8ba681266759bb6cb2e45a45983e3e:

  Merge tag 'single-binary-20260112' of https://github.com/philmd/qemu into staging (2026-01-13 11:51:18 +1100)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20260113

for you to fetch changes up to 7a05be8c70bb789c23076b1ca2563ed7d87c6fb8:

  tests/rcutorture: Fix build error (2026-01-13 08:29:59 +0100)

----------------------------------------------------------------
vfio queue:

* Resolves build errors with gcc 16
* Adjusts the Linux headers for s390x and mshv
* Fixes endianness issue in the VFIO helper functions
* Adds support for live migration with vIOMMU when using IOMMU
  dirty tracking
* Implements a migration blocker to prevent failures when VM
  memory is too large
* Corrects an unmap_bitmap failure in the legacy VFIO backend
* Addresses a workaround for an Intel IOMMU errata.
* Implements Intel IOMMU first stage translation for passthrough
  device. Also a prerequisite work for vSVA.
* Updates documentation

----------------------------------------------------------------
Cédric Le Goater (6):
      include/hw/hyperv: Remove unused 'struct mshv_vp_registers' definition
      update-linux-headers: Remove "asm-s390/unistd_32.h"
      ppc/vof: Fix build error
      target/riscv: Fix build errors
      tests/qtest: Fix build error
      tests/rcutorture: Fix build error

Farhan Ali (1):
      util/vfio-helper: Fix endianness in PCI config read/write functions

Joao Martins (1):
      vfio: Add a backend_flag parameter to vfio_container_query_dirty_bitmap()

Philippe Mathieu-Daudé (1):
      hw/vfio/migration: Check base architecture at runtime

Yi Liu (3):
      intel_iommu_accel: Propagate PASID-based iotlb invalidation to host
      intel_iommu: Replay all pasid bindings when either SRTP or TE bit is changed
      intel_iommu: Replay pasid bindings after context cache invalidation

Zhenzhong Duan (29):
      docs/devel: Remove stale comments related to iommufd dirty tracking
      intel_iommu: Rename vtd_ce_get_rid2pasid_entry to vtd_ce_get_pasid_entry
      intel_iommu: Delete RPS capability related supporting code
      intel_iommu: Update terminology to match VTD spec
      hw/pci: Export pci_device_get_iommu_bus_devfn() and return bool
      hw/pci: Introduce pci_device_get_viommu_flags()
      intel_iommu: Implement get_viommu_flags() callback
      intel_iommu: Introduce a new structure VTDHostIOMMUDevice
      vfio/iommufd: Force creating nesting parent HWPT
      intel_iommu_accel: Check for compatibility with IOMMUFD backed device when x-flts=on
      intel_iommu_accel: Fail passthrough device under PCI bridge if x-flts=on
      intel_iommu_accel: Stick to system MR for IOMMUFD backed host device when x-flts=on
      intel_iommu: Add some macros and inline functions
      intel_iommu_accel: Bind/unbind guest page table to host
      intel_iommu: Add migration support with x-flts=on
      intel_iommu: Enable host device when x-flts=on in scalable mode
      docs/devel: Add IOMMUFD nesting documentation
      vfio/iommufd: Add framework code to support getting dirty bitmap before unmap
      vfio/iommufd: Query dirty bitmap before DMA unmap
      vfio/container-legacy: rename vfio_dma_unmap_bitmap() to vfio_legacy_dma_unmap_get_dirty_bitmap()
      vfio/iommufd: Add IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
      intel_iommu: Fix unmap_bitmap failure with legacy VFIO backend
      vfio/listener: Add missing dirty tracking in region_del
      vfio/migration: Add migration blocker if VM memory is too large to cause unmap_bitmap failure
      vfio/migration: Allow live migration with vIOMMU without VFs using device dirty tracking
      hw/pci: Introduce pci_device_get_host_iommu_quirks()
      intel_iommu_accel: Implement get_host_iommu_quirks() callback
      vfio/listener: Bypass readonly region for dirty tracking
      Workaround for ERRATA_772415_SPR17

 MAINTAINERS                      |   2 +
 docs/devel/vfio-iommufd.rst      |  38 ++-
 hw/i386/intel_iommu_accel.h      |  56 ++++
 hw/i386/intel_iommu_internal.h   | 155 +++++++----
 hw/vfio/vfio-helpers.h           |   2 -
 include/hw/core/iommu.h          |  30 ++
 include/hw/hyperv/hvgdk_mini.h   |   7 -
 include/hw/i386/intel_iommu.h    |   6 +-
 include/hw/pci/pci.h             |  55 ++++
 include/hw/vfio/vfio-container.h |   9 +-
 include/hw/vfio/vfio-device.h    |  15 +
 include/system/iommufd.h         |   2 +-
 backends/iommufd.c               |   5 +-
 hw/i386/intel_iommu.c            | 572 +++++++++++++++++++++++----------------
 hw/i386/intel_iommu_accel.c      | 272 +++++++++++++++++++
 hw/pci/pci.c                     |  35 ++-
 hw/ppc/vof.c                     |   5 +-
 hw/vfio-user/container.c         |   5 +-
 hw/vfio/container-legacy.c       |  15 +-
 hw/vfio/container.c              |  20 +-
 hw/vfio/device.c                 |  32 +++
 hw/vfio/helpers.c                |  17 --
 hw/vfio/iommufd.c                |  71 ++++-
 hw/vfio/listener.c               |  70 ++++-
 hw/vfio/migration-multifd.c      |  12 +-
 hw/vfio/migration.c              |  40 ++-
 target/riscv/cpu.c               |   2 +-
 tests/qtest/intel-iommu-test.c   |   4 +-
 tests/qtest/libqtest.c           |   3 +-
 tests/unit/rcutorture.c          |   2 +-
 util/vfio-helpers.c              |  15 +-
 backends/trace-events            |   2 +-
 hw/i386/Kconfig                  |   5 +
 hw/i386/meson.build              |   1 +
 hw/i386/trace-events             |   4 +
 hw/vfio/trace-events             |   3 +-
 scripts/update-linux-headers.sh  |   1 -
 37 files changed, 1207 insertions(+), 383 deletions(-)
 create mode 100644 hw/i386/intel_iommu_accel.h
 create mode 100644 include/hw/core/iommu.h
 create mode 100644 hw/i386/intel_iommu_accel.c


