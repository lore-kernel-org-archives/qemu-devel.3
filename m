Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB615C36010
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 07:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLYA-0007nP-QJ; Wed, 26 Mar 2025 03:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLY9-0007nF-3E
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:51:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLY6-000671-2r
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742975499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yVG1tRDo92AlmXYkBZ7WNlAQfMpwFkqNtCT27hj7e7Q=;
 b=gPYIduSFvzszxwj1qHPg8CZVQyDpS/rUCfiIQgvKT6e36cujz5mmZoKhcM8exyxwpuoy6R
 CZqy66D359oZExd2SCVxo4tRpdVOTotPggXv5l8L9qSS4BqOGkLQ52utQvpYjabqgKVyfz
 mSO1Ty3Y+hzhjHtj41qhNThPWpZ/Ncs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-YrVgvjPNOuKGDymCd9d1_Q-1; Wed,
 26 Mar 2025 03:51:37 -0400
X-MC-Unique: YrVgvjPNOuKGDymCd9d1_Q-1
X-Mimecast-MFC-AGG-ID: YrVgvjPNOuKGDymCd9d1_Q_1742975496
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B5851801A1A; Wed, 26 Mar 2025 07:51:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.180])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3EE3119560AB; Wed, 26 Mar 2025 07:51:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 v2 00/37] vfio: Spring cleanup
Date: Wed, 26 Mar 2025 08:50:45 +0100
Message-ID: <20250326075122.1299361-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
                 ...
  QEMU 10.0 :  16607 total

Organization is weak, naming inconsistent, the vfio-common.h header
file and common.c are quite messy. It's time to address the technical
debt before adding new features.

This proposal reorganizes some of the VFIO files to isolate features,
introduces new files and renames services to better reflect the
namespace they belong to. This is code reshuffling and there are no
intentional functional changes. If more could be done, please propose !
Timing seems right.


I have taken care to preserve all existing copyright notices in the
file headers. I have added one on behalf of my current employer for
newly created files. However, original authors may wish to include
their own notices as well. If so, please respond to the patch, and I
will update the patch in the next spin or before applying.

Here is a (short) list requiring your attention :
  
  * include/hw/vfio/vfio-migration.h
  * hw/vfio/vfio-migration-internal.h
    Kirti Wankhede and Avihai Horon, NVIDIA
  
  * hw/vfio/vfio-iommufd.h
    Joao Martins and Yi Liu, Oracle and Intel
  
  * include/hw/vfio/vfio-region.h
  * hw/vfio/region.c
    Eric Auger, may be we could reduce the list ? 
  
  * hw/vfio/vfio-cpr.h
    Steve Sistare, Oracle

I think the remaining new files are correctly covered but I am human,
so please review and let me know.

I hope we can merge this when the QEMU 10.1 cycle starts and then
address the two large series waiting : live update and vfio-user.


What next in terms of cleanups :

 - container.c is quite messy
 - the pci* files need some love too (add vfio- prefix ?)
 - improve overall documentation, structs and routines documentation
   too would be great
 - isolate all the low level routines (kvm ioctls) into helpers.c
   to improve build ?
 - improve build to reduce the number of files built per target 
 - continue the never ending quest of adding 'Error **' parameters,
   Look for migration_file_set_error, in MemoryListener handlers :
      vfio_listener_region_add
      vfio_listener_log_global_stop
      vfio_listener_log_sync
   and in callback routines for IOMMU notifiers :
      vfio_iommu_map_notify
      vfio_iommu_map_dirty_notify
   memory_region_iommu_replay() would be a start.
 - remove vfio-platform (start of QEMU 10.2 cycle ~ September 2025)


Thanks,

C. 


Changes in v2:

 - Dropped vfio_migration_set_error()
   https://lore.kernel.org/qemu-devel/20250324123315.637827-1-clg@redhat.com/
 - Dropped R-b trailers on patches which were modified too much 
   (context changes are ok) 
 - Improved commit logs of patches adding new files
 - Fixed top comment in header files
 - Used a 'vfio_migration_' prefix instead of 'vfio_mig_'
 - Made vfio_migration_add_bytes_transferred() internal
 - Added extra patch for vfio_device_state_is_running/precopy() 
 - Moved vfio_reset_handler() in device.c 
 - Moved "dirty tracking" related services into container-base.c and
   improved naming   
 - Introduced listener.* files instead of dirty-tracking.*
 - Introduced vfio_listener_un/register() routines


Cédric Le Goater (37):
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

 hw/vfio/migration-multifd.h           |   2 +-
 hw/vfio/pci.h                         |   3 +-
 hw/vfio/vfio-cpr.h                    |  15 +
 hw/vfio/vfio-display.h                |  42 ++
 hw/vfio/vfio-helpers.h                |  35 ++
 hw/vfio/vfio-iommufd.h                |  34 ++
 hw/vfio/vfio-listener.h               |  15 +
 hw/vfio/vfio-migration-internal.h     |  74 +++
 include/hw/s390x/vfio-ccw.h           |   2 +-
 include/hw/vfio/vfio-common.h         | 346 -------------
 include/hw/vfio/vfio-container-base.h |  12 +-
 include/hw/vfio/vfio-container.h      |  36 ++
 include/hw/vfio/vfio-device.h         | 149 ++++++
 include/hw/vfio/vfio-migration.h      |  16 +
 include/hw/vfio/vfio-platform.h       |   4 +-
 include/hw/vfio/vfio-region.h         |  47 ++
 backends/iommufd.c                    |   2 +-
 hw/core/sysbus-fdt.c                  |   1 +
 hw/ppc/spapr_pci_vfio.c               |   6 +-
 hw/s390x/s390-pci-vfio.c              |   3 +-
 hw/vfio/ap.c                          |  10 +-
 hw/vfio/ccw.c                         |  20 +-
 hw/vfio/container-base.c              | 192 ++++++-
 hw/vfio/container.c                   | 123 ++---
 hw/vfio/cpr.c                         |   3 +-
 hw/vfio/device.c                      | 405 +++++++++++++++
 hw/vfio/display.c                     |   4 +-
 hw/vfio/helpers.c                     | 702 +++-----------------------
 hw/vfio/igd.c                         |   8 +-
 hw/vfio/iommufd.c                     |  24 +-
 hw/vfio/{common.c => listener.c}      | 455 +----------------
 hw/vfio/migration-multifd.c           |   8 +-
 hw/vfio/migration.c                   | 111 +++-
 hw/vfio/pci-quirks.c                  |   1 +
 hw/vfio/pci.c                         |  51 +-
 hw/vfio/platform.c                    |  11 +-
 hw/vfio/region.c                      | 395 +++++++++++++++
 hw/vfio/spapr.c                       |  10 +-
 migration/target.c                    |   8 +-
 hw/vfio/meson.build                   |  10 +-
 hw/vfio/trace-events                  |  36 +-
 41 files changed, 1854 insertions(+), 1577 deletions(-)
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
 rename hw/vfio/{common.c => listener.c} (76%)
 create mode 100644 hw/vfio/region.c

-- 
2.49.0


