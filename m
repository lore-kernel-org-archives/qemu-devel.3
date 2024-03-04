Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0315FC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 12:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7RS-00086t-P8; Mon, 04 Mar 2024 07:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7RJ-000838-Jz
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:29:06 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7RH-0004RV-F1
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:29:05 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TpJ041c13z4wcg;
 Mon,  4 Mar 2024 23:28:52 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpJ01100bz4wcK;
 Mon,  4 Mar 2024 23:28:48 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 00/26] migration: Improve error reporting
Date: Mon,  4 Mar 2024 13:28:18 +0100
Message-ID: <20240304122844.1888308-1-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=mkh8=KK=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The motivation behind these changes is to improve error reporting to
the upper management layer (libvirt) with a more detailed error, this
to let it decide, depending on the reported error, whether to try
migration again later. It would be useful in cases where migration
fails due to lack of HW resources on the host. For instance, some
adapters can only initiate a limited number of simultaneous dirty
tracking requests and this imposes a limit on the the number of VMs
that can be migrated simultaneously.

We are not quite ready for such a mechanism but what we can do first is
to cleanup the error reporting in the early save_setup sequence. This
is what the following changes propose, by adding an Error** argument to
various handlers and propagating it to the core migration subsystem.
 
Thanks,

C.

Changes in v3:

 - New changes to make sure an error is always set in case of failure.
   This is the reason behing the 5/6 extra patches. (Markus)
 - Documentation fixup (Peter + Avihai)
 - Set migration state to MIGRATION_STATUS_FAILED always
 - Fixed error handling in bg_migration_thread() (Peter)
 - Fixed return value of vfio_listener_log_global_start/stop(). 
   Went unnoticed because value is not tested. (Peter)
 - Add ERRP_GUARD() when error_prepend is used 
 - Use error_setg_errno() when possible
    
Changes in v2:

- Removed v1 patches addressing the return-path thread termination as
  they are now superseded by :  
  https://lore.kernel.org/qemu-devel/20240226203122.22894-1-farosas@suse.de/
- Documentation updates of handlers
- Removed call to PRECOPY_NOTIFY_SETUP notifiers in case of errors
- Modified routines taking an Error** argument to return a bool when
  possible and made adjustments in callers.
- new MEMORY_LISTENER_CALL_LOG_GLOBAL macro for .log_global*()
  handlers
- Handled SETUP state when migration terminates
- Modified memory_get_xlat_addr() to take an Error** argument
- Various refinements on error handling

Cédric Le Goater (26):
  s390/stattrib: Add Error** argument to set_migrationmode() handler
  vfio: Always report an error in vfio_save_setup()
  migration: Always report an error in block_save_setup()
  migration: Always report an error in ram_save_setup()
  migration: Add Error** argument to vmstate_save()
  migration: Report error when shutdown fails
  migration: Remove SaveStateHandler and LoadStateHandler typedefs
  migration: Add documentation for SaveVMHandlers
  migration: Do not call PRECOPY_NOTIFY_SETUP notifiers in case of error
  migration: Move cleanup after after error reporting in
    qemu_savevm_state_setup()
  migration: Add Error** argument to qemu_savevm_state_setup()
  migration: Add Error** argument to .save_setup() handler
  migration: Add Error** argument to .load_setup() handler
  memory: Add Error** argument to .log_global*() handlers
  memory: Add Error** argument to the global_dirty_log routines
  migration: Modify ram_init_bitmaps() to report dirty tracking errors
  vfio: Add Error** argument to .set_dirty_page_tracking() handler
  vfio: Add Error** argument to vfio_devices_dma_logging_start()
  vfio: Add Error** argument to vfio_devices_dma_logging_stop()
  vfio: Use new Error** argument in vfio_save_setup()
  vfio: Add Error** argument to .vfio_save_config() handler
  vfio: Reverse test on vfio_get_dirty_bitmap()
  memory: Add Error** argument to memory_get_xlat_addr()
  vfio: Add Error** argument to .get_dirty_bitmap() handler
  vfio: Also trace event failures in vfio_save_complete_precopy()
  vfio: Extend vfio_set_migration_error() with Error* argument

 include/exec/memory.h                 |  40 +++-
 include/hw/s390x/storage-attributes.h |   2 +-
 include/hw/vfio/vfio-common.h         |  29 ++-
 include/hw/vfio/vfio-container-base.h |  35 +++-
 include/migration/register.h          | 273 +++++++++++++++++++++++---
 include/qemu/typedefs.h               |   2 -
 migration/savevm.h                    |   2 +-
 hw/i386/xen/xen-hvm.c                 |  10 +-
 hw/ppc/spapr.c                        |   2 +-
 hw/s390x/s390-stattrib-kvm.c          |  12 +-
 hw/s390x/s390-stattrib.c              |  14 +-
 hw/vfio/common.c                      | 162 +++++++++------
 hw/vfio/container-base.c              |   9 +-
 hw/vfio/container.c                   |  19 +-
 hw/vfio/migration.c                   |  99 ++++++----
 hw/vfio/pci.c                         |   5 +-
 hw/virtio/vhost-vdpa.c                |   5 +-
 hw/virtio/vhost.c                     |   6 +-
 migration/block-dirty-bitmap.c        |   4 +-
 migration/block.c                     |  15 +-
 migration/dirtyrate.c                 |  21 +-
 migration/migration.c                 |  27 ++-
 migration/qemu-file.c                 |   5 +-
 migration/ram.c                       |  58 ++++--
 migration/savevm.c                    |  59 +++---
 system/memory.c                       |  95 +++++++--
 system/physmem.c                      |   5 +-
 27 files changed, 772 insertions(+), 243 deletions(-)

-- 
2.44.0


