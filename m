Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB22CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 16:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umEfq-0002rg-Eq; Wed, 13 Aug 2025 12:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfC-0002cj-7c; Wed, 13 Aug 2025 12:49:23 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEf3-0007ma-0C; Wed, 13 Aug 2025 12:49:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 398A9813CF;
 Wed, 13 Aug 2025 19:49:01 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:167::1:21])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wmOQI00FoSw0-bsvDasKb; Wed, 13 Aug 2025 19:49:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755103740;
 bh=R5aEk4K5Dlf2nLIbyFzdVKHA8Y58yFAjgBG1mOfCeyo=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=XXf8THL/AmDt+8nypZYfipII9y9Krq8PGdiA607e1KgT0YXDj0e2t3k1BoVdmNG0g
 /X2hTjXnonhvuqm9njOfiZfPu/2BY8cTKJkt4yZSSVwnFokpPeiMIYj84bS9EHZnk+
 IFu5ViaG1x4ilLMNtK0nkmi5EOz2iGqhSzFVLp5g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, vsementsov@yandex-team.ru
Subject: [PATCH 00/33] vhost-user-blk: live-backend local migration
Date: Wed, 13 Aug 2025 19:48:21 +0300
Message-ID: <20250813164856.950363-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all!

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

The most of the series are refactoring patches. The core feature is
spread between 24, 28-31 patches.

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

Vladimir Sementsov-Ogievskiy (33):
  vhost: introduce vhost_ops->vhost_set_vring_enable_supported method
  vhost: drop backend_features field
  vhost-user: introduce vhost_user_has_prot() helper
  vhost: move protocol_features to vhost_user
  vhost-user-gpu: drop code duplication
  vhost: make vhost_dev.features private
  virtio: move common part of _set_guest_notifier to generic code
  virtio: drop *_set_guest_notifier_fd_handler() helpers
  vhost-user: keep QIOChannelSocket for backend channel
  vhost: vhost_virtqueue_start(): fix failure path
  vhost: make vhost_memory_unmap() null-safe
  vhost: simplify calls to vhost_memory_unmap()
  vhost: move vrings mapping to the top of vhost_virtqueue_start()
  vhost: vhost_virtqueue_start(): drop extra local variables
  vhost: final refactoring of vhost vrings map/unmap
  vhost: simplify vhost_dev_init() error-path
  vhost: move busyloop timeout initialization to vhost_virtqueue_init()
  vhost: introduce check_memslots() helper
  vhost: vhost_dev_init(): drop extra features variable
  hw/virtio/virtio-bus: refactor virtio_bus_set_host_notifier()
  vhost-user: make trace events more readable
  vhost-user-blk: add some useful trace-points
  vhost: add some useful trace-points
  chardev-add: support local migration
  virtio: introduce .skip_vhost_migration_log() handler
  io/channel-socket: introduce qio_channel_socket_keep_nonblock()
  migration/socket: keep fds non-block
  vhost: introduce backend migration
  vhost-user: support backend migration
  virtio: support vhost backend migration
  vhost-user-blk: support vhost backend migration
  test/functional: exec_command_and_wait_for_pattern: add vm arg
  tests/functional: add test_x86_64_vhost_user_blk_fd_migration.py

 backends/cryptodev-vhost.c                    |   1 -
 chardev/char-socket.c                         | 101 +++-
 hw/block/trace-events                         |  10 +
 hw/block/vhost-user-blk.c                     | 201 ++++++--
 hw/display/vhost-user-gpu.c                   |  11 +-
 hw/net/vhost_net.c                            |  27 +-
 hw/scsi/vhost-scsi.c                          |   1 -
 hw/scsi/vhost-user-scsi.c                     |   1 -
 hw/virtio/trace-events                        |  12 +-
 hw/virtio/vdpa-dev.c                          |   3 +-
 hw/virtio/vhost-user-base.c                   |   8 +-
 hw/virtio/vhost-user.c                        | 326 +++++++++---
 hw/virtio/vhost.c                             | 474 ++++++++++++------
 hw/virtio/virtio-bus.c                        |  20 +-
 hw/virtio/virtio-hmp-cmds.c                   |   2 -
 hw/virtio/virtio-mmio.c                       |  41 +-
 hw/virtio/virtio-pci.c                        |  34 +-
 hw/virtio/virtio-qmp.c                        |  10 +-
 hw/virtio/virtio.c                            | 120 ++++-
 include/chardev/char-socket.h                 |   3 +
 include/hw/virtio/vhost-backend.h             |  10 +
 include/hw/virtio/vhost-user-blk.h            |   2 +
 include/hw/virtio/vhost.h                     |  42 +-
 include/hw/virtio/virtio-pci.h                |   3 -
 include/hw/virtio/virtio.h                    |  11 +-
 include/io/channel-socket.h                   |   3 +
 io/channel-socket.c                           |  16 +-
 migration/options.c                           |  14 +
 migration/options.h                           |   2 +
 migration/socket.c                            |   1 +
 net/vhost-vdpa.c                              |   7 +-
 qapi/char.json                                |  16 +-
 qapi/migration.json                           |  19 +-
 qapi/virtio.json                              |   3 -
 stubs/meson.build                             |   1 +
 stubs/qemu_file.c                             |  15 +
 stubs/vmstate.c                               |   6 +
 tests/functional/qemu_test/cmd.py             |   7 +-
 ...test_x86_64_vhost_user_blk_fd_migration.py | 279 +++++++++++
 tests/qtest/meson.build                       |   2 +-
 tests/unit/meson.build                        |   4 +-
 41 files changed, 1420 insertions(+), 449 deletions(-)
 create mode 100644 stubs/qemu_file.c
 create mode 100644 tests/functional/test_x86_64_vhost_user_blk_fd_migration.py

-- 
2.48.1


