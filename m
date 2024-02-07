Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53970C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXi48-0006fv-Bx; Wed, 07 Feb 2024 08:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi40-0006eZ-AO
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:09 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org>)
 id 1rXi3y-0008Np-5h
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:34:08 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TVLg771jYz4wxZ;
 Thu,  8 Feb 2024 00:33:55 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TVLg56Khvz4wc6;
 Thu,  8 Feb 2024 00:33:53 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 00/14] migration: Improve error reporting
Date: Wed,  7 Feb 2024 14:33:33 +0100
Message-ID: <20240207133347.1115903-1-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=zwZg=JQ=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
to cleanup the error reporting ​in the early save_setup sequence. This
is what the following changes propose, by adding an Error argument to
various handlers and propagating it to the core migration subsystem.

The last patches try to address a related issue found on VMs with MLX5
VF assigned devices. These are one of those adapters with the HW
limitation described above. If dirty tracking setup fails and
return-path is in use, the return-path thread does not terminate,
leaving the source and destination VMs waiting for an event to occur.

The last patch is still an RFC because the correct fix is not obvious
and implies reworking the QEMUFile software construct, built on top of
the QEMU I/O channel.
 
Thanks,

C.

[1] https://lore.kernel.org/qemu-devel/20240201184853.890471-1-clg@redhat.com/

Cédric Le Goater (14):
  migration: Add Error** argument to .save_setup() handler
  migration: Add Error** argument to .load_setup() handler
  memory: Add Error** argument to .log_global*() handlers
  migration: Modify ram_init_bitmaps() to report dirty tracking errors
  vfio: Add Error** argument to .set_dirty_page_tracking() handler
  vfio: Add Error** argument to vfio_devices_dma_logging_start()
  vfio: Add Error** argument to vfio_devices_dma_logging_stop()
  vfio: Use new Error** argument in vfio_save_setup()
  vfio: Add Error** argument to .vfio_save_config() handler
  vfio: Also trace event failures in vfio_save_complete_precopy()
  vfio: Extend vfio_set_migration_error() with Error* argument
  migration: Report error when shutdown fails
  migration: Use migrate_has_error() in close_return_path_on_source()
  migration: Fix return-path thread exit

 include/exec/memory.h                 | 12 ++--
 include/hw/vfio/vfio-common.h         |  2 +-
 include/hw/vfio/vfio-container-base.h |  4 +-
 include/migration/register.h          |  4 +-
 hw/i386/xen/xen-hvm.c                 |  8 +--
 hw/ppc/spapr.c                        |  2 +-
 hw/s390x/s390-stattrib.c              |  2 +-
 hw/vfio/common.c                      | 96 ++++++++++++++++-----------
 hw/vfio/container-base.c              |  4 +-
 hw/vfio/container.c                   |  6 +-
 hw/vfio/migration.c                   | 87 +++++++++++++++---------
 hw/vfio/pci.c                         |  5 +-
 hw/virtio/vhost.c                     |  4 +-
 migration/block-dirty-bitmap.c        |  2 +-
 migration/block.c                     |  2 +-
 migration/dirtyrate.c                 | 24 +++++--
 migration/migration.c                 | 16 ++---
 migration/qemu-file.c                 |  5 +-
 migration/ram.c                       | 40 ++++++++---
 migration/savevm.c                    | 14 ++--
 system/memory.c                       | 37 +++++++----
 21 files changed, 236 insertions(+), 140 deletions(-)

-- 
2.43.0


