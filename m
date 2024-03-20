Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9923C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 06:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmpmN-0002d3-2g; Wed, 20 Mar 2024 02:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmpm5-0002Jx-7i
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmpm3-0001kg-9L
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 02:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710917406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EbyEaqH/Q6jol6d+7ysEWUO7dF3IYwtK68P6MptWg5A=;
 b=RC2Hej50hEVxz4sbNX8KWRtRvfIJvKxjvU7W+Sopg4kqLVsorHQHS/LvTqWKQqNOEU9j0P
 z8BmNIRVaWygS+2QoqgjCuTtEHYVVok6UB+175wCeolntPjNBG/3xuL6tnpWA9HGvv+F93
 HCWjgqFXTWWw3xxN7V5ioQ2oUdlbA20=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-f0dbUoOcOB6YQjgzEdQy9Q-1; Wed,
 20 Mar 2024 02:49:25 -0400
X-MC-Unique: f0dbUoOcOB6YQjgzEdQy9Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 038AC1C068CB;
 Wed, 20 Mar 2024 06:49:25 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 071E71C060A4;
 Wed, 20 Mar 2024 06:49:22 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-9.1 v5 00/14] migration: Improve error reporting
Date: Wed, 20 Mar 2024 07:48:56 +0100
Message-ID: <20240320064911.545001-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


Patchset is organized as follow :

* [1-4] are prerequisite changes in other components related to the
  migration save_setup() handler. They make sure a failure is not
  returned without setting an error.
  
  s390/stattrib: Add Error** argument to set_migrationmode() handler
  vfio: Always report an error in vfio_save_setup()
  migration: Always report an error in block_save_setup()
  migration: Always report an error in ram_save_setup()
  migration: Add Error** argument to vmstate_save()

* [5-14] are the core changes in migration and memory components to
  propagate an error reported in a save_setup() handler.

  migration: Add Error** argument to qemu_savevm_state_setup()
  migration: Add Error** argument to .save_setup() handler
  migration: Add Error** argument to .load_setup() handler
  memory: Add Error** argument to .log_global_start() handler
  migration: Introduce ram_bitmaps_destroy()
  memory: Add Error** argument to the global_dirty_log routines
  migration: Add Error** argument to ram_state_init()
  migration: Add Error** argument to xbzrle_init()
  migration: Modify ram_init_bitmaps() to report dirty tracking errors

The VFIO changes depend on the above. They are simpler and have been
reviewed already. I kept them for another series.

Thanks,

C.

Changes in v5:
 
 - Rebased on 2e128776dc56 ("migration: Skip only empty block devices")
 - Removed Fabiano's R-b because of changes 
 - Handled qemu_savevm_state_setup() failures after waiting for
   virtio-net-failover devices to unplug.
 - Removed memory_global_dirty_log_rollback()
 - Introduced memory_global_dirty_log_do_start() to call
   .log_global_start() handlers and do the rollback in case of error.
 - Kept modification of the global_dirty_tracking flag within
   memory_global_dirty_log_start()  
 - Added an assert on error of a .log_global_start() handler in
   listener_add_address_space()
 - Removed Yong Huang's R-b
 - Introduced ram_bitmaps_destroy()
 - Added Error** argument to ram_state_init() and xbzrle_init()
 - Made use of ram_bitmaps_destroy() in ram_init_bitmaps() to cleanup
   allocated bitmaps
 - Took into account changes of ram_state_init() and xbzrle_init() to
   propagate the error.
 - Reduced series to migration. VFIO can come later. 

Changes in v4:

 - Fixed frenchism futur to future
 - Fixed typo in set_migrationmode() handler
 - Added error_free() in hmp_migrationmode()
 - Fixed state name printed out in error returned by vfio_save_setup()
 - Fixed test on error returned by qemu_file_get_error()
 - Added an error when bdrv_nb_sectors() returns a negative value 
 - Dropped log_global_stop() and log_global_sync() changes
 - Dropped MEMORY_LISTENER_CALL_LOG_GLOBAL
 - Modified memory_global_dirty_log_start() to loop on the list of
   listeners and handle errors directly.
 - Introduced memory_global_dirty_log_rollback() to revert operations
   previously done

Changes in v3:

 - New changes to make sure an error is always set in case of failure.
   This is the reason behind the 5/6 extra patches. (Markus)
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

Cédric Le Goater (14):
  s390/stattrib: Add Error** argument to set_migrationmode() handler
  vfio: Always report an error in vfio_save_setup()
  migration: Always report an error in block_save_setup()
  migration: Always report an error in ram_save_setup()
  migration: Add Error** argument to vmstate_save()
  migration: Add Error** argument to qemu_savevm_state_setup()
  migration: Add Error** argument to .save_setup() handler
  migration: Add Error** argument to .load_setup() handler
  memory: Add Error** argument to .log_global_start() handler
  migration: Introduce ram_bitmaps_destroy()
  memory: Add Error** argument to the global_dirty_log routines
  migration: Add Error** argument to ram_state_init()
  migration: Add Error** argument to xbzrle_init()
  migration: Modify ram_init_bitmaps() to report dirty tracking errors

 include/exec/memory.h                 |  10 ++-
 include/hw/s390x/storage-attributes.h |   2 +-
 include/migration/register.h          |   6 +-
 migration/savevm.h                    |   2 +-
 hw/i386/xen/xen-hvm.c                 |   5 +-
 hw/ppc/spapr.c                        |   2 +-
 hw/s390x/s390-stattrib-kvm.c          |  12 ++-
 hw/s390x/s390-stattrib.c              |  15 ++--
 hw/vfio/common.c                      |   4 +-
 hw/vfio/migration.c                   |  29 +++++--
 hw/virtio/vhost.c                     |   3 +-
 migration/block-dirty-bitmap.c        |   4 +-
 migration/block.c                     |  17 +++--
 migration/dirtyrate.c                 |  13 +++-
 migration/migration.c                 |  33 +++++++-
 migration/ram.c                       | 106 +++++++++++++++++---------
 migration/savevm.c                    |  57 ++++++++------
 system/memory.c                       |  40 +++++++++-
 18 files changed, 261 insertions(+), 99 deletions(-)

-- 
2.44.0


