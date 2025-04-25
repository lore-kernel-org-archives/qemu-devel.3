Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D966EC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8EiE-0002hw-By; Fri, 25 Apr 2025 04:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ei9-0002gn-U1
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8Ei6-0003AA-Gt
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sgm3hN8CPcZYOnubr0ezLc6scsHZe862J6vWnHPZcdE=;
 b=aP6x6hsy5sItJCw+mcdazQWjXH4YDhZxTPBB08EYoXkiZUoYWsV0ifra+foE8y7FMwF1v/
 lFDN4uxzlWjYKj+EUmCfM5cSWPzYYq3AQdUCEivgtLPqvRds3FFPdCcelg1vJn/iU/p5Id
 b3NfYUG72ZTzarwozlSBHvjXH5SsL9M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-bi9IDfisOAiAdnLW_WWk3g-1; Fri,
 25 Apr 2025 04:46:54 -0400
X-MC-Unique: bi9IDfisOAiAdnLW_WWk3g-1
X-Mimecast-MFC-AGG-ID: bi9IDfisOAiAdnLW_WWk3g_1745570813
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 910EE19560AF
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:46:52 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB1C230001A2; Fri, 25 Apr 2025 08:46:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/50] vfio queue
Date: Fri, 25 Apr 2025 10:45:53 +0200
Message-ID: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 019fbfa4bcd2d3a835c241295e22ab2b5b56129b:

  Merge tag 'pull-misc-2025-04-24' of https://repo.or.cz/qemu/armbru into staging (2025-04-24 13:44:57 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20250425

for you to fetch changes up to a9d270f6b85bab40d388fe5244f02d145759cc08:

  vfio: refactor out vfio_pci_config_setup() (2025-04-25 09:01:38 +0200)

----------------------------------------------------------------
vfio queue:

* Updated IGD passthrough documentation
* Fixed L2 crash on pseries machines
* Reorganized code and renamed services
* Moved HostIOMMUDevice realize after device attachement to help
  adding support for nested IOMMU
* Fixed CPR registration with IOMMUFD backend
* Refactored vfio-pci code to prepare ground for vfio-user

----------------------------------------------------------------
Amit Machhiwal (2):
      vfio/spapr: Enhance error handling in vfio_spapr_create_window()
      vfio/spapr: Fix L2 crash with PCI device passthrough and memory > 128G

Cédric Le Goater (39):
      vfio: Open code vfio_migration_set_error()
      vfio: Move vfio_mig_active() into migration.c
      vfio: Rename vfio_reset_bytes_transferred()
      vfio: Introduce a new header file for external migration services
      vfio: Make vfio_un/block_multiple_devices_migration() static
      vfio: Make vfio_viommu_preset() static
      vfio: Introduce a new header file for internal migration services
      vfio: Move vfio_device_state_is_running/precopy() into migration.c
      vfio: Introduce a new header file for VFIOdisplay declarations
      vfio: Move VFIOHostDMAWindow definition into spapr.c
      vfio: Introduce a new header file for VFIOIOMMUFD declarations
      vfio: Introduce new files for VFIORegion definitions and declarations
      vfio: Introduce a new header file for VFIOcontainer declarations
      vfio: Make vfio_group_list static
      vfio: Move VFIOAddressSpace helpers into container-base.c
      vfio: Move Host IOMMU type declarations into their respective files
      vfio: Introduce a new header file for helper services
      vfio: Move vfio_get_info_dma_avail() into helpers.c
      vfio: Move vfio_kvm_device_add/del_fd() to helpers.c
      vfio: Move vfio_get_device_info() to helpers.c
      vfio: Introduce a new file for VFIODevice definitions
      vfio: Introduce new files for CPR definitions and declarations
      vfio: Move vfio_kvm_device_fd() into helpers.c
      vfio: Move vfio_device_list into device.c
      vfio: Move vfio_de/attach_device() into device.c
      vfio: Move vfio_reset_handler() into device.c
      vfio: Move dirty tracking related services into container-base.c
      vfio: Make vfio_devices_query_dirty_bitmap() static
      vfio: Make vfio_container_query_dirty_bitmap() static
      vfio: Rename vfio_devices_all_dirty_tracking_started()
      vfio: Rename vfio_devices_all_device_dirty_tracking()
      vfio: Rename vfio_get_dirty_bitmap()
      vfio: Introduce new files for VFIO MemoryListener
      vfio: Rename RAM discard related services
      vfio: Introduce vfio_listener_un/register() routines
      vfio: Rename vfio-common.h to vfio-device.h
      vfio: Rename VFIODevice related services
      vfio: Rename VFIOContainer related services
      MAINTAINERS: Add a maintainer for util/vfio-helpers.c

John Levon (2):
      vfio: refactor out vfio_interrupt_setup()
      vfio: refactor out vfio_pci_config_setup()

Tomita Moeko (1):
      vfio/igd: Update IGD passthrough documentation

Zhenzhong Duan (6):
      vfio/iommufd: Make a separate call to get IOMMU capabilities
      vfio/iommufd: Move realize() after attachment
      vfio/container: Move realize() after attachment
      vfio: Cleanup host IOMMU device creation
      vfio: Remove hiod_typename property
      vfio: Register/unregister container for CPR only once for each container

 MAINTAINERS                           |   1 +
 docs/igd-assign.txt                   | 265 +++++++++----
 hw/vfio/migration-multifd.h           |   2 +-
 hw/vfio/pci.h                         |   4 +-
 hw/vfio/vfio-cpr.h                    |  15 +
 hw/vfio/vfio-display.h                |  42 ++
 hw/vfio/vfio-helpers.h                |  35 ++
 hw/vfio/vfio-iommufd.h                |  34 ++
 hw/vfio/vfio-listener.h               |  15 +
 hw/vfio/vfio-migration-internal.h     |  74 ++++
 include/hw/s390x/vfio-ccw.h           |   2 +-
 include/hw/vfio/vfio-common.h         | 346 -----------------
 include/hw/vfio/vfio-container-base.h |  15 +-
 include/hw/vfio/vfio-container.h      |  36 ++
 include/hw/vfio/vfio-device.h         | 150 ++++++++
 include/hw/vfio/vfio-migration.h      |  16 +
 include/hw/vfio/vfio-platform.h       |   4 +-
 include/hw/vfio/vfio-region.h         |  47 +++
 backends/iommufd.c                    |   2 +-
 hw/core/sysbus-fdt.c                  |   1 +
 hw/ppc/spapr_pci_vfio.c               |   6 +-
 hw/s390x/s390-pci-vfio.c              |   3 +-
 hw/vfio/ap.c                          |  14 +-
 hw/vfio/ccw.c                         |  30 +-
 hw/vfio/container-base.c              | 192 +++++++++-
 hw/vfio/container.c                   | 144 +++----
 hw/vfio/cpr.c                         |   3 +-
 hw/vfio/device.c                      | 400 +++++++++++++++++++
 hw/vfio/display.c                     |  10 +-
 hw/vfio/helpers.c                     | 702 ++++------------------------------
 hw/vfio/igd.c                         |  10 +-
 hw/vfio/iommufd.c                     |  55 +--
 hw/vfio/{common.c => listener.c}      | 510 +++---------------------
 hw/vfio/migration-multifd.c           |   7 +-
 hw/vfio/migration.c                   | 108 +++++-
 hw/vfio/pci.c                         | 283 +++++++-------
 hw/vfio/platform.c                    |  15 +-
 hw/vfio/region.c                      | 395 +++++++++++++++++++
 hw/vfio/spapr.c                       |  79 ++--
 migration/target.c                    |   8 +-
 hw/vfio/meson.build                   |  10 +-
 hw/vfio/trace-events                  |  36 +-
 42 files changed, 2290 insertions(+), 1836 deletions(-)
 create mode 100644 hw/vfio/vfio-cpr.h
 create mode 100644 hw/vfio/vfio-display.h
 create mode 100644 hw/vfio/vfio-helpers.h
 create mode 100644 hw/vfio/vfio-iommufd.h
 create mode 100644 hw/vfio/vfio-listener.h
 create mode 100644 hw/vfio/vfio-migration-internal.h
 delete mode 100644 include/hw/vfio/vfio-common.h
 create mode 100644 include/hw/vfio/vfio-container.h
 create mode 100644 include/hw/vfio/vfio-device.h
 create mode 100644 include/hw/vfio/vfio-migration.h
 create mode 100644 include/hw/vfio/vfio-region.h
 create mode 100644 hw/vfio/device.c
 rename hw/vfio/{common.c => listener.c} (74%)
 create mode 100644 hw/vfio/region.c


