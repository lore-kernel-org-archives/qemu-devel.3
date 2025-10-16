Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13B5CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MNW-0007O2-C0; Thu, 16 Oct 2025 07:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMa-000758-Il; Thu, 16 Oct 2025 07:41:44 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMP-0003T3-CQ; Thu, 16 Oct 2025 07:41:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 0BFE2C01A9;
 Thu, 16 Oct 2025 14:41:23 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-X3rf4sm5; Thu, 16 Oct 2025 14:41:22 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614882;
 bh=t4zXcSf2BhXU+c47jP6580nHThJN9fa0GjiNC2ZNp5U=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=e8pgsomefb04lAuFscr/+KiZSXIg3XCGsVLmhcXShDVZfJv6WF2HeGOM2l867Oqhs
 r59L8zyY4BbdaHWz6IND2X1TRX0kSvmfjKlPpUhBryVgAWarT/25v4QP4qt/E2VGjh
 ExnMXItzFQqjBcxK4EiG9oEz+g05D3T4pKvLYNms=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: raphael@enfabrica.net,
	pbonzini@redhat.com,
	farosas@suse.de
Cc: mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, jasowang@redhat.com
Subject: [PATCH v2 00/25] vhost-user-blk: live-backend local migration
Date: Thu, 16 Oct 2025 14:40:37 +0300
Message-ID: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Hi all!

v2: extremely simplified API: instead of 

- separate capability for migrating chardevs
- separate capability for migrating vhost-user-blk
- "support-local-migration" and "local-incoming" chardev options
- "local-incoming" option for vhost-user-blke

instead of all of this, v2 API is only one capability to
enable the whole feature.

Still, final look of this capability is not clear yet, the
discussion is in context of
"[PATCH v8 00/19] virtio-net: live-TAP local migration", here:
https://lore.kernel.org/qemu-devel/29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru/

This series comes with temporary API in commit
"RFC qapi: add local-vhost-user-blk migration capability"

v2 is based on:
[PATCH v4 0/7] chardev: postpone connect
  (which in turn is based on [PATCH 0/2] remove deprecated 'reconnect' options)
[PATCH v3 00/23] vhost refactoring and fixes
and one commit from v8 of live-tap series:
[PATCH v8 14/19] migration: introduce .pre_incoming() vmsd handler

Based-on: <20250924133309.334631-1-vsementsov@yandex-team.ru>
Based-on: <20251015212051.1156334-1-vsementsov@yandex-team.ru>
Based-on: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
Based-on: <20251015132136.1083972-15-vsementsov@yandex-team.ru>

The code is also may be found in my gitlab account, tag
up-vhost-user-blk-fd-migration-v2 :
https://gitlab.com/vsementsov/qemu/-/tree/up-vhost-user-blk-fd-migration-v2

-

Local migration of vhost-user-blk requires non-trivial actions
from management layer, it should provide a new connection for new
QEMU process and handle disk operation movement from one connection
to another.

Such switching, including reinitialization of vhost-user connection,
draining disk requests, etc, adds significant value to local migration
downtime.

This all leads to an idea: why not to just pass all we need from
old QEMU process to the new one (including open file descriptors),
and don't touch the backend at all? This way, the vhost user backend
server will not even know, that QEMU process is changed, as live
vhost-user connection is migrated.

So this series realize the idea. No requests are done to backend
during migration, instead all backend-related state and all related
file descriptors (vhost-user connection, guest/host notifiers,
inflight region) are passed to new process. Of course, migration
should go through unix socket.

Why not CPR-transfer?

1. In the new mode of local migration we need to pass not only
file descriptors, but additional parts of backend-related state,
which we don't want (or even can't) reinitialize in target process.
And it's a lot simpler to add new fields to common migration stream.
And why not to pass fds in the same stream?

2. No benefit of vhost-user connection fd passed to target in early
stage before device creation: we can't use it together with source
QEMU process anyway. So, we need a moment, when source qemu stops using
the fd, and target start doing it. And native place for this moment is
usual save/load of the device in migration process. And yes, we have to
deeply update initialization/starting of the device to not reinitialize
the backend, but just continue to work with it in a new QEMU process.

3. So, if we can't actually use fd, passed early before device creation,
no reason to care about:
- non-working QMP connection on target until "migrate" command on source
- additional migration channel
- implementing code to pass additional non-fd fields together with fds in CPR

However, the series doesn't conflict with CPR-transfer, as it's actually
a usual migration with some additional capabilities. The only
requirement is that main migration channel should be a unix socket.

Vladimir Sementsov-Ogievskiy (25):
  vhost: store busyloop_timeout into struct vhost_dev
  vhost: reorder logic in vhost_dev_init()
  vhost: rework vhost_virtqueue_init()
  vhost: add connect parameter to vhost_dev_init()
  vhost: split vhost_dev_connect() out of vhost_dev_init()
  vhost-user: support connect api
  vhost-user-blk: vhost_user_blk_connect() move connected check to
    caller
  vhost-user-blk: vhost_user_blk_connect(): call vhost_dev_connect()
  vhost-user-blk: rename vhost_user_blk_connect to vhost_user_blk_init
  vhost-user-blk: split vhost_user_blk_init()
  vhost-user-blk: move initial reconnect loop to separate function
  vhost-user-blk: move first vhost_user_blk_init() to _realize()
  vhost-user-blk: postpone connect to pre-incoming
  virtio: introduce .skip_vhost_migration_log() handler
  migration: introduce vmstate_event_notifier
  chardev: add .chr_get_client() handler
  vhost: add inflight region backend-transfer vmstate
  chardev: introduce backend-transfer vmstate for chardev
  vhost: support backend-transfer migration
  vhost-user: add vmstate
  virtio: support vhost backend migration
  virtio: support .needed for virtio vmsd
  RFC qapi: add local-vhost-user-blk migration capability
  vhost-user-blk: support vhost backend migration
  tests/functional: add test_x86_64_vhost_user_blk_fd_migration.py

 backends/cryptodev-vhost.c                    |   2 +-
 backends/vhost-user.c                         |   2 +-
 chardev/char-backend-transfer.c               |  52 +++
 chardev/char-socket.c                         |   7 +
 chardev/char.c                                |   6 +
 chardev/meson.build                           |   1 +
 hw/block/trace-events                         |   2 +
 hw/block/vhost-user-blk.c                     | 255 +++++++++++----
 hw/net/vhost_net.c                            |   2 +-
 hw/scsi/vhost-scsi.c                          |   2 +-
 hw/scsi/vhost-user-scsi.c                     |   2 +-
 hw/virtio/vdpa-dev.c                          |   3 +-
 hw/virtio/vhost-user-base.c                   |   2 +-
 hw/virtio/vhost-user-fs.c                     |   2 +-
 hw/virtio/vhost-user-scmi.c                   |   2 +-
 hw/virtio/vhost-user-vsock.c                  |   2 +-
 hw/virtio/vhost-user.c                        | 127 +++++++-
 hw/virtio/vhost-vsock.c                       |   2 +-
 hw/virtio/vhost.c                             | 266 +++++++++++----
 hw/virtio/virtio-bus.c                        |   2 +-
 hw/virtio/virtio.c                            |  77 ++++-
 include/chardev/char-backend-transfer.h       |  17 +
 include/chardev/char.h                        |   4 +
 include/hw/virtio/vhost-backend.h             |   2 +
 include/hw/virtio/vhost-user-blk.h            |   2 +
 include/hw/virtio/vhost-user.h                |   4 +
 include/hw/virtio/vhost.h                     |  19 +-
 include/hw/virtio/virtio.h                    |   4 +
 include/migration/vmstate.h                   |   7 +
 migration/meson.build                         |   1 +
 migration/options.c                           |   7 +
 migration/options.h                           |   1 +
 migration/vmstate-event-notifier.c            |  54 +++
 qapi/migration.json                           |  11 +-
 ...test_x86_64_vhost_user_blk_fd_migration.py | 307 ++++++++++++++++++
 35 files changed, 1115 insertions(+), 143 deletions(-)
 create mode 100644 chardev/char-backend-transfer.c
 create mode 100644 include/chardev/char-backend-transfer.h
 create mode 100644 migration/vmstate-event-notifier.c
 create mode 100644 tests/functional/test_x86_64_vhost_user_blk_fd_migration.py

-- 
2.48.1


