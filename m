Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E40C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTez-00045F-CJ; Tue, 18 Mar 2025 05:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTey-00044y-5w
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTew-0001lp-BW
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0ufGTYyJjLgvyropi3XdZ3wbc8zJsamyAbZj5n4txtg=;
 b=TUsRoFkEtM86yByNWrPSaJqiyJsOdVl2ORyHAsY/dH66vEZ2MiHtEfUBDTp9XJUBOIu4vW
 FDyeu16tFMRkbxVcT/1G2+jjPvLlAUHw+hgyIOH/GXkU6tXSVDFWsROvXxc6zD95jb5qfD
 ziGiSM7Ym8oopsx30HfcOERHq6cbzM8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-h_mNPkC0MHSdBT0zSZbevg-1; Tue,
 18 Mar 2025 05:54:50 -0400
X-MC-Unique: h_mNPkC0MHSdBT0zSZbevg-1
X-Mimecast-MFC-AGG-ID: h_mNPkC0MHSdBT0zSZbevg_1742291689
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE165195609F; Tue, 18 Mar 2025 09:54:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1FC8E1828A83; Tue, 18 Mar 2025 09:54:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 00/32] vfio: Spring cleanup
Date: Tue, 18 Mar 2025 10:53:43 +0100
Message-ID: <20250318095415.670319-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello,

Several large extensions were merged in VFIO recently: migration
support with dirty tracking, support for different host IOMMU backend
devices, multifd support, etc. This adds up to the previous
extensions: vfio-platform, AP, CCW. The result is that VFIO is now a
subsystem of over +16,000 lines of code :

  QEMU 2.0  :   3988 total
  QEMU 2.12 :   9336 total
  QEMU 6.2  :  12715 total
  QEMU 8.2  :  13690 total
  QEMU 9.2  :  15680 total
  QEMU 10.0 :  16607 total

Organization is weak, naming inconsistent, the vfio-common.h header
file and common.c are quite messy. It's time to address the technical
debt before adding new features.

This proposal reorganizes some of the VFIO files to isolate features,
introduces new files and renames services to better reflect the
namespace they belong to. This is code reshuffling and there are no
intentional functional changes. If more could be done, please propose !
Timing seems right.

I hope we can merge this when the QEMU 10.1 cycle starts and then
address the two large series waiting : live update and vfio-user.

Thanks,

C. 

Cédric Le Goater (32):
  vfio: Move vfio_mig_active() into migration.c
  vfio: Rename vfio_reset_bytes_transferred()
  vfio: Introduce a new header file for external migration services
  vfio: Make vfio_un/block_multiple_devices_migration() static
  vfio: Make vfio_viommu_preset() static
  vfio: Introduce a new header file for internal migration services
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
  vfio: Introduce new files for dirty tracking definitions and
    declarations
  vfio: Move vfio_set_migration_error() into migration.c
  vfio: Rename vfio-common.h to vfio-device.h
  vfio: Rename VFIODevice related services
  vfio: Make vfio_devices_query_dirty_bitmap() static
  vfio: Rename VFIOContainer related services
  vfio: Rename VFIO dirty tracking services
  vfio: Introduce vfio_dirty_tracking_un/register() routines
  vfio: Rename RAM discard related services

 hw/vfio/cpr.h                          |  15 +
 hw/vfio/dirty-tracking.h               |  19 +
 hw/vfio/display.h                      |  42 ++
 hw/vfio/helpers.h                      |  35 ++
 hw/vfio/iommufd.h                      |  29 +
 hw/vfio/migration-multifd.h            |   2 +-
 hw/vfio/migration.h                    |  73 +++
 hw/vfio/pci.h                          |   3 +-
 include/hw/s390x/vfio-ccw.h            |   2 +-
 include/hw/vfio/vfio-common.h          | 346 ------------
 include/hw/vfio/vfio-container-base.h  |   5 +
 include/hw/vfio/vfio-container.h       |  35 ++
 include/hw/vfio/vfio-device.h          | 148 ++++++
 include/hw/vfio/vfio-migration.h       |  17 +
 include/hw/vfio/vfio-platform.h        |   4 +-
 include/hw/vfio/vfio-region.h          |  47 ++
 backends/iommufd.c                     |   2 +-
 hw/core/sysbus-fdt.c                   |   1 +
 hw/ppc/spapr_pci_vfio.c                |   6 +-
 hw/s390x/s390-pci-vfio.c               |   3 +-
 hw/vfio/ap.c                           |  10 +-
 hw/vfio/ccw.c                          |  20 +-
 hw/vfio/container-base.c               |  69 +++
 hw/vfio/container.c                    | 123 ++---
 hw/vfio/cpr.c                          |   3 +-
 hw/vfio/device.c                       | 371 +++++++++++++
 hw/vfio/{common.c => dirty-tracking.c} | 382 ++------------
 hw/vfio/display.c                      |   4 +-
 hw/vfio/helpers.c                      | 702 +++----------------------
 hw/vfio/igd.c                          |   8 +-
 hw/vfio/iommufd.c                      |  25 +-
 hw/vfio/migration-multifd.c            |   4 +-
 hw/vfio/migration.c                    | 112 +++-
 hw/vfio/pci-quirks.c                   |   1 +
 hw/vfio/pci.c                          |  51 +-
 hw/vfio/platform.c                     |  11 +-
 hw/vfio/region.c                       | 396 ++++++++++++++
 hw/vfio/spapr.c                        |  10 +-
 migration/target.c                     |   4 +-
 hw/vfio/meson.build                    |   8 +-
 hw/vfio/trace-events                   |  36 +-
 41 files changed, 1711 insertions(+), 1473 deletions(-)
 create mode 100644 hw/vfio/cpr.h
 create mode 100644 hw/vfio/dirty-tracking.h
 create mode 100644 hw/vfio/display.h
 create mode 100644 hw/vfio/helpers.h
 create mode 100644 hw/vfio/iommufd.h
 create mode 100644 hw/vfio/migration.h
 delete mode 100644 include/hw/vfio/vfio-common.h
 create mode 100644 include/hw/vfio/vfio-container.h
 create mode 100644 include/hw/vfio/vfio-device.h
 create mode 100644 include/hw/vfio/vfio-migration.h
 create mode 100644 include/hw/vfio/vfio-region.h
 create mode 100644 hw/vfio/device.c
 rename hw/vfio/{common.c => dirty-tracking.c} (81%)
 create mode 100644 hw/vfio/region.c

-- 
2.48.1


