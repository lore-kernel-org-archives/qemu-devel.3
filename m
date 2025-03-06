Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1823DC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqBzm-0006ax-8A; Thu, 06 Mar 2025 09:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqBzh-0006YR-BW
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:14:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqBzf-0001XF-1f
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=51Vxp4cLg6rX+21ublcglJvnsD8pgMemaINeZelXah8=;
 b=FrljEYASLFHxWa/FOehFmJv+Fbn0fm7OR47kq/npZ71kvuyTxM/XLcuUjiKCSTwk9iSlha
 SlaXrQ+clWnIetmlhx7b8mgw0z8h9a7sqTbdSbYIejEHT5wdEd1nSFsv6dynwPmDAAYll3
 cFltk+dvIxVxBlHheyl2mBgO7NEaXVo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-kYipSPlYPLGNQohwyxLrEQ-1; Thu,
 06 Mar 2025 09:14:25 -0500
X-MC-Unique: kYipSPlYPLGNQohwyxLrEQ-1
X-Mimecast-MFC-AGG-ID: kYipSPlYPLGNQohwyxLrEQ_1741270465
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0996D19560B8
 for <qemu-devel@nongnu.org>; Thu,  6 Mar 2025 14:14:25 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F351618001D3; Thu,  6 Mar 2025 14:14:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/42] vfio queue
Date: Thu,  6 Mar 2025 15:13:36 +0100
Message-ID: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit e8a01102936286e012ed0f00bd7f3b7474d415c9:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2025-03-05 21:58:23 +0800)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20250306

for you to fetch changes up to 59a67e70950bcc2002d3a8d22a17743e0f70da96:

  hw/core/machine: Add compat for x-migration-multifd-transfer VFIO property (2025-03-06 06:47:34 +0100)

----------------------------------------------------------------
vfio queue:

* Added property documentation
* Added Minor fixes
* Implemented basic PCI PM capability backing
* Promoted new IGD maintainer
* Deprecated vfio-plaform
* Extended VFIO migration with multifd support

----------------------------------------------------------------
Alex Williamson (5):
      hw/pci: Basic support for PCI power management
      pci: Use PCI PM capability initializer
      vfio/pci: Delete local pm_cap
      pcie, virtio: Remove redundant pm_cap
      hw/vfio/pci: Re-order pre-reset

Cédric Le Goater (2):
      vfio: Add property documentation
      vfio/ccw: Replace warn_once_pfch() with warn_report_once()

Eric Auger (1):
      vfio-platform: Deprecate all forms of vfio-platform devices

Maciej S. Szmigiero (32):
      migration: Clarify that {load, save}_cleanup handlers can run without setup
      thread-pool: Remove thread_pool_submit() function
      thread-pool: Rename AIO pool functions to *_aio() and data types to *Aio
      thread-pool: Implement generic (non-AIO) pool support
      migration: Add MIG_CMD_SWITCHOVER_START and its load handler
      migration: Add qemu_loadvm_load_state_buffer() and its handler
      migration: Always take BQL for migration_incoming_state_destroy()
      error: define g_autoptr() cleanup function for the Error type
      migration: Add thread pool of optional load threads
      migration/multifd: Split packet into header and RAM data
      migration/multifd: Device state transfer support - receive side
      migration/multifd: Make multifd_send() thread safe
      migration/multifd: Add an explicit MultiFDSendData destructor
      migration/multifd: Device state transfer support - send side
      migration/multifd: Add multifd_device_state_supported()
      migration: Add save_live_complete_precopy_thread handler
      vfio/migration: Add load_device_config_state_start trace event
      vfio/migration: Convert bytes_transferred counter to atomic
      vfio/migration: Add vfio_add_bytes_transferred()
      vfio/migration: Move migration channel flags to vfio-common.h header file
      vfio/migration: Multifd device state transfer support - basic types
      vfio/migration: Multifd device state transfer - add support checking function
      vfio/migration: Multifd setup/cleanup functions and associated VFIOMultifd
      vfio/migration: Setup and cleanup multifd transfer in these general methods
      vfio/migration: Multifd device state transfer support - received buffers queuing
      vfio/migration: Multifd device state transfer support - load thread
      migration/qemu-file: Define g_autoptr() cleanup function for QEMUFile
      vfio/migration: Multifd device state transfer support - config loading support
      vfio/migration: Multifd device state transfer support - send side
      vfio/migration: Add x-migration-multifd-transfer VFIO property
      vfio/migration: Make x-migration-multifd-transfer VFIO property mutable
      hw/core/machine: Add compat for x-migration-multifd-transfer VFIO property

Peter Xu (1):
      migration/multifd: Make MultiFDSendData a struct

Tomita Moeko (1):
      MAINTAINERS: Add myself as vfio-igd maintainer

 MAINTAINERS                        |   9 +-
 docs/about/deprecated.rst          |  25 ++
 docs/devel/migration/vfio.rst      |  45 ++-
 hw/vfio/migration-multifd.h        |  34 ++
 hw/vfio/pci.h                      |   1 -
 include/block/aio.h                |   8 +-
 include/block/thread-pool.h        |  62 +++-
 include/hw/pci/pci.h               |   3 +
 include/hw/pci/pci_device.h        |   3 +
 include/hw/pci/pcie.h              |   2 -
 include/hw/vfio/vfio-common.h      |  31 ++
 include/migration/client-options.h |   4 +
 include/migration/misc.h           |  25 ++
 include/migration/register.h       |  52 ++-
 include/qapi/error.h               |   2 +
 include/qemu/typedefs.h            |   5 +
 migration/migration.h              |   7 +
 migration/multifd.h                |  74 +++-
 migration/qemu-file.h              |   2 +
 migration/savevm.h                 |   6 +-
 hw/core/machine.c                  |   2 +
 hw/net/e1000e.c                    |   3 +-
 hw/net/eepro100.c                  |   4 +-
 hw/net/igb.c                       |   3 +-
 hw/nvme/ctrl.c                     |   3 +-
 hw/pci-bridge/pcie_pci_bridge.c    |   3 +-
 hw/pci/pci.c                       |  93 ++++-
 hw/vfio/amd-xgbe.c                 |   2 +
 hw/vfio/ap.c                       |   9 +
 hw/vfio/calxeda-xgmac.c            |   2 +
 hw/vfio/ccw.c                      |  27 +-
 hw/vfio/migration-multifd.c        | 679 +++++++++++++++++++++++++++++++++++++
 hw/vfio/migration.c                | 106 ++++--
 hw/vfio/pci.c                      | 180 +++++++++-
 hw/vfio/platform.c                 |  25 ++
 hw/virtio/virtio-pci.c             |  11 +-
 migration/colo.c                   |   3 +
 migration/migration-hmp-cmds.c     |   2 +
 migration/migration.c              |  17 +-
 migration/multifd-device-state.c   | 212 ++++++++++++
 migration/multifd-nocomp.c         |  30 +-
 migration/multifd.c                | 248 +++++++++++---
 migration/options.c                |   9 +
 migration/savevm.c                 | 201 ++++++++++-
 tests/unit/test-thread-pool.c      |   6 +-
 util/async.c                       |   6 +-
 util/thread-pool.c                 | 184 ++++++++--
 hw/pci/trace-events                |   2 +
 hw/vfio/meson.build                |   1 +
 hw/vfio/trace-events               |  13 +-
 migration/meson.build              |   1 +
 migration/trace-events             |   1 +
 scripts/analyze-migration.py       |  11 +
 util/trace-events                  |   6 +-
 54 files changed, 2296 insertions(+), 209 deletions(-)
 create mode 100644 hw/vfio/migration-multifd.h
 create mode 100644 hw/vfio/migration-multifd.c
 create mode 100644 migration/multifd-device-state.c


