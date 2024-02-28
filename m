Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102DDC54E51
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCGB-00063S-GC; Wed, 28 Feb 2024 00:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCG9-00062k-4R
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:13:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCG4-0006WH-Uh
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=o3qhdxDc0d3ksjtSkq+XYmFK/Oy1Jae1/0UB18XPaA0=;
 b=dqPhUbBFbYVKg68FLn59xQvRT8hAZRZz0CQFw/RqMbUfBwyFLfGVO6B/NaC/JPisA1XQjV
 nxk0Wo4BW/i/rC62F1oUkygixqXmz1hM+aDVJ3uQTtk7PytdqCMlYs6h/WjSzJpRovhv75
 8ChLtk1HfIbRo4aVcau30j7JXjIJ9/g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-pA110dNRN-qIb09LamHL8Q-1; Wed, 28 Feb 2024 00:13:26 -0500
X-MC-Unique: pA110dNRN-qIb09LamHL8Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0B37185A788;
 Wed, 28 Feb 2024 05:13:25 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C82701C14B2E;
 Wed, 28 Feb 2024 05:13:17 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 00/25] Migration next patches
Date: Wed, 28 Feb 2024 13:12:50 +0800
Message-ID: <20240228051315.400759-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

From: Peter Xu <peterx@redhat.com>

The following changes since commit 158a054c4d1a40179f5e83cd7e1cfe65de457b92:

  Merge tag 'pull-target-arm-20240227-1' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-02-27 15:34:41 +0000)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-next-pull-request

for you to fetch changes up to 9425ef3f990a42b98329d5059362f40714e70442:

  migration: Use migrate_has_error() in close_return_path_on_source() (2024-02-28 11:31:28 +0800)

----------------------------------------------------------------
Migration pull request

- Fabiano's fixed-ram patches (1-5 only)
- Peter's cleanups on multifd tls IOC referencing
- Steve's cpr patches for vfio (migration patches only)
- Fabiano's fix on mbps stats racing with COMPLETE state
- Fabiano's fix on return path thread hang

----------------------------------------------------------------

Cédric Le Goater (1):
  migration: Use migrate_has_error() in close_return_path_on_source()

Fabiano Rosas (7):
  docs/devel/migration.rst: Document the file transport
  tests/qtest/migration: Rename fd_proto test
  tests/qtest/migration: Add a fd + file test
  migration/multifd: Remove p->quit from recv side
  migration/multifd: Release recv sem_sync earlier
  migration: Fix qmp_query_migrate mbps value
  migration: Join the return path thread before releasing to_dst_file

Peter Xu (5):
  migration/multifd: Cleanup TLS iochannel referencing
  migration/multifd: Drop registered_yank
  migration/multifd: Make multifd_channel_connect() return void
  migration/multifd: Cleanup outgoing_args in state destroy
  migration/multifd: Drop unnecessary helper to destroy IOC

Steve Sistare (12):
  notify: pass error to notifier with return
  migration: remove error from notifier data
  migration: convert to NotifierWithReturn
  migration: MigrationEvent for notifiers
  migration: remove postcopy_after_devices
  migration: MigrationNotifyFunc
  migration: per-mode notifiers
  migration: refactor migrate_fd_connect failures
  migration: notifier error checking
  migration: stop vm for cpr
  migration: update cpr-reboot description
  migration: options incompatible with cpr

 docs/devel/migration/main.rst  |   4 +
 qapi/migration.json            |  37 ++++---
 include/hw/vfio/vfio-common.h  |   2 +-
 include/hw/virtio/virtio-net.h |   2 +-
 include/migration/misc.h       |  47 +++++++-
 include/qemu/notify.h          |   8 +-
 migration/migration.h          |   4 -
 migration/multifd.h            |   2 -
 migration/postcopy-ram.h       |   1 -
 migration/socket.h             |   3 +-
 hw/net/virtio-net.c            |  13 ++-
 hw/vfio/migration.c            |  13 +--
 hw/virtio/vhost-user.c         |  10 +-
 hw/virtio/virtio-balloon.c     |   3 +-
 migration/migration.c          | 196 +++++++++++++++++++++------------
 migration/multifd.c            | 111 ++++++++++---------
 migration/postcopy-ram.c       |   3 +-
 migration/ram.c                |   3 +-
 migration/socket.c             |  19 ++--
 net/vhost-vdpa.c               |  14 +--
 tests/qtest/migration-test.c   |  46 +++++++-
 ui/spice-core.c                |  17 ++-
 util/notify.c                  |   5 +-
 hw/vfio/trace-events           |   2 +-
 24 files changed, 354 insertions(+), 211 deletions(-)

-- 
2.43.0


