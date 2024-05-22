Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91242C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9igS-0003FI-Bn; Wed, 22 May 2024 05:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9igP-0003Ev-Qr
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9igM-0001Kd-WB
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SOpwB5ym3LvkjAI8UWd5w1+qL9K/vqjUDgnStmXtsqc=;
 b=WERjA2uoWuyxgLiGB8WsquRxg/87tvjAH9SeBRm+oCkITwvWxfNGDSxcdylBV9SCfIWkGb
 l78O4BNDvSQsumV/4MGHESOaz4XbfmzWY7EYBk7YZMDbe0fW0Lz/zt35dUIdo7uQFwGau4
 kKBd56dBvrylVrCvhNE3BGGT0mwLGag=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-Rrn2BiZIMe6Ua4_ramXw2w-1; Wed,
 22 May 2024 05:54:46 -0400
X-MC-Unique: Rrn2BiZIMe6Ua4_ramXw2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 158543C025C2
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 09:54:46 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 053FC7414;
 Wed, 22 May 2024 09:54:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/47] vfio queue
Date: Wed, 22 May 2024 11:53:55 +0200
Message-ID: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 85ef20f1673feaa083f4acab8cf054df77b0dbed:

  Merge tag 'pull-maintainer-may24-160524-2' of https://gitlab.com/stsquad/qemu into staging (2024-05-16 10:02:56 +0200)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20240522

for you to fetch changes up to b4e1670c494165d4186930d56f692857f4fec89b:

  vfio/igd: Use g_autofree in vfio_probe_igd_bar4_quirk() (2024-05-22 10:04:22 +0200)

----------------------------------------------------------------
vfio queue:

* Improvement of error reporting during migration
* Removed Vendor Specific Capability check on newer machine
* Addition of a VFIO migration QAPI event
* Changed prototype of routines using an error parameter to return bool
* Several cleanups regarding autofree variables

----------------------------------------------------------------
Avihai Horon (4):
      qapi/vfio: Add VFIO migration QAPI event
      vfio/migration: Emit VFIO migration QAPI event
      vfio/migration: Don't emit STOP_COPY VFIO migration QAPI event twice
      vfio/migration: Enhance VFIO migration state tracing

Cédric Le Goater (13):
      vfio: Add Error** argument to .set_dirty_page_tracking() handler
      vfio: Add Error** argument to vfio_devices_dma_logging_start()
      migration: Extend migration_file_set_error() with Error* argument
      vfio/migration: Add an Error** argument to vfio_migration_set_state()
      vfio/migration: Add Error** argument to .vfio_save_config() handler
      vfio: Reverse test on vfio_get_xlat_addr()
      memory: Add Error** argument to memory_get_xlat_addr()
      vfio: Add Error** argument to .get_dirty_bitmap() handler
      vfio: Also trace event failures in vfio_save_complete_precopy()
      vfio/ap: Use g_autofree variable in vfio_ap_register_irq_notifier()
      vfio/ap: Make vfio_ap_register_irq_notifier() return a bool
      vfio/ccw: Use g_autofree variable in vfio_ccw_register_irq_notifier()
      vfio/ccw: Make vfio_ccw_register_irq_notifier() return a bool

Vinayak Kale (1):
      vfio/pci: migration: Skip config space check for Vendor Specific Information in VSC during restore/load

Zhenzhong Duan (29):
      vfio/pci: Use g_autofree in vfio_realize
      vfio/pci: Use g_autofree in iommufd_cdev_get_info_iova_range()
      vfio: Make VFIOIOMMUClass::attach_device() and its wrapper return bool
      vfio: Make VFIOIOMMUClass::setup() return bool
      vfio: Make VFIOIOMMUClass::add_window() and its wrapper return bool
      vfio/container: Make vfio_connect_container() return bool
      vfio/container: Make vfio_set_iommu() return bool
      vfio/container: Make vfio_get_device() return bool
      vfio/iommufd: Make iommufd_cdev_*() return bool
      vfio/cpr: Make vfio_cpr_register_container() return bool
      backends/iommufd: Make iommufd_backend_*() return bool
      vfio/display: Fix error path in call site of ramfb_setup()
      vfio/display: Make vfio_display_*() return bool
      vfio/helpers: Use g_autofree in vfio_set_irq_signaling()
      vfio/helpers: Make vfio_set_irq_signaling() return bool
      vfio/helpers: Make vfio_device_get_name() return bool
      vfio/platform: Make vfio_populate_device() and vfio_base_device_init() return bool
      vfio/ccw: Make vfio_ccw_get_region() return a bool
      vfio/pci: Make vfio_intx_enable_kvm() return a bool
      vfio/pci: Make vfio_pci_relocate_msix() and vfio_msix_early_setup() return a bool
      vfio/pci: Make vfio_populate_device() return a bool
      vfio/pci: Make vfio_intx_enable() return bool
      vfio/pci: Make vfio_populate_vga() return bool
      vfio/pci: Make capability related functions return bool
      vfio/pci: Use g_autofree for vfio_region_info pointer
      vfio/pci-quirks: Make vfio_pci_igd_opregion_init() return bool
      vfio/pci-quirks: Make vfio_add_*_cap() return bool
      vfio: Use g_autofree in all call site of vfio_get_region_info()
      vfio/igd: Use g_autofree in vfio_probe_igd_bar4_quirk()

 MAINTAINERS                           |   1 +
 qapi/qapi-schema.json                 |   1 +
 qapi/vfio.json                        |  67 ++++++++
 hw/vfio/pci.h                         |  13 +-
 include/exec/memory.h                 |  15 +-
 include/hw/vfio/vfio-common.h         |  43 ++++--
 include/hw/vfio/vfio-container-base.h |  55 +++++--
 include/migration/misc.h              |   2 +-
 include/sysemu/iommufd.h              |   6 +-
 backends/iommufd.c                    |  29 ++--
 hw/core/machine.c                     |   1 +
 hw/vfio/ap.c                          |  35 ++---
 hw/vfio/ccw.c                         |  56 +++----
 hw/vfio/common.c                      | 119 +++++++++------
 hw/vfio/container-base.c              |  18 +--
 hw/vfio/container.c                   | 101 ++++++------
 hw/vfio/cpr.c                         |   4 +-
 hw/vfio/display.c                     |  22 ++-
 hw/vfio/helpers.c                     |  36 ++---
 hw/vfio/igd.c                         |  35 ++---
 hw/vfio/iommufd.c                     | 109 ++++++-------
 hw/vfio/migration.c                   | 180 ++++++++++++++++------
 hw/vfio/pci-quirks.c                  |  50 +++---
 hw/vfio/pci.c                         | 280 +++++++++++++++++-----------------
 hw/vfio/platform.c                    |  66 ++++----
 hw/vfio/spapr.c                       |  28 ++--
 hw/virtio/vhost-vdpa.c                |   5 +-
 migration/migration.c                 |   6 +-
 system/memory.c                       |  10 +-
 backends/trace-events                 |   4 +-
 hw/vfio/trace-events                  |   3 +-
 qapi/meson.build                      |   1 +
 32 files changed, 806 insertions(+), 595 deletions(-)
 create mode 100644 qapi/vfio.json


