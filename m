Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E65C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 17:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tslwh-0001K0-OD; Thu, 13 Mar 2025 13:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tslwf-0001Jb-Kn
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:02:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tslwd-0003k9-Lm
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741885324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pvjzLSMMtiGOJt4YLly29fcSeXok9AJyIiaWb4zwMuQ=;
 b=YYRZ2G7/vGivw2XAhc88zNxWyIbyZ0Ni1OmcXnw8bl5H4fvjQ3tRt4/wweTtXzQDSFcbFJ
 NSjWloede8jPVDN/VGfd8B/h2axelalpK4HlijvUjMJk2iXQMjXsF5QAbRCzpUP6X9OFZC
 XZMKvNh5pQYtKRec9DmVb1pnAoiB+gc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-GhhJMd8MNLShyTf5ISdsig-1; Thu,
 13 Mar 2025 13:02:03 -0400
X-MC-Unique: GhhJMd8MNLShyTf5ISdsig-1
X-Mimecast-MFC-AGG-ID: GhhJMd8MNLShyTf5ISdsig_1741885322
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD2961828ABD; Thu, 13 Mar 2025 17:01:44 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.225.21])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 21C521828A93; Thu, 13 Mar 2025 17:01:42 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL v2 00/23] Block layer patches
Date: Thu, 13 Mar 2025 18:01:35 +0100
Message-ID: <20250313170135.81463-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit 825b96dbcee23d134b691fc75618b59c5f53da32:

  Merge tag 'migration-20250310-pull-request' of https://gitlab.com/farosas/qemu into staging (2025-03-11 09:32:07 +0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to df957115c46845e2c0ccc29ac0a75eb9700a9a0d:

  scripts/qcow2-to-stdout.py: Add script to write qcow2 images to stdout (2025-03-13 17:57:23 +0100)

----------------------------------------------------------------
Block layer patches

- virtio-scsi: add iothread-vq-mapping parameter
- Improve writethrough performance
- Fix missing zero init in bdrv_snapshot_goto()
- Added scripts/qcow2-to-stdout.py
- Code cleanup and iotests fixes

----------------------------------------------------------------
Alberto Garcia (1):
      scripts/qcow2-to-stdout.py: Add script to write qcow2 images to stdout

Kevin Wolf (8):
      block: Remove unused blk_op_is_blocked()
      block: Zero block driver state before reopening
      file-posix: Support FUA writes
      block/io: Ignore FUA with cache.no-flush=on
      aio: Create AioPolledEvent
      aio-posix: Factor out adjust_polling_time()
      aio-posix: Separate AioPolledEvent per AioHandler
      aio-posix: Adjust polling time also for new handlers

Stefan Hajnoczi (13):
      scsi-disk: drop unused SCSIDiskState->bh field
      dma: use current AioContext for dma_blk_io()
      scsi: track per-SCSIRequest AioContext
      scsi: introduce requests_lock
      virtio-scsi: introduce event and ctrl virtqueue locks
      virtio-scsi: protect events_dropped field
      virtio-scsi: perform TMFs in appropriate AioContexts
      virtio-blk: extract cleanup_iothread_vq_mapping() function
      virtio-blk: tidy up iothread_vq_mapping functions
      virtio: extract iothread-vq-mapping.h API
      virtio-scsi: add iothread-vq-mapping parameter
      virtio-scsi: handle ctrl virtqueue in main loop
      virtio-scsi: only expose cmd vqs via iothread-vq-mapping

Thomas Huth (1):
      iotests: Limit qsd-migrate to working formats

 include/block/aio.h                         |   5 +-
 include/block/raw-aio.h                     |  19 +-
 include/hw/scsi/scsi.h                      |   8 +-
 include/hw/virtio/iothread-vq-mapping.h     |  45 +++
 include/hw/virtio/virtio-scsi.h             |  15 +-
 include/system/block-backend-global-state.h |   1 -
 include/system/dma.h                        |   3 +-
 util/aio-posix.h                            |   1 +
 block/block-backend.c                       |  12 -
 block/file-posix.c                          |  29 +-
 block/io.c                                  |   4 +
 block/io_uring.c                            |  25 +-
 block/linux-aio.c                           |  25 +-
 block/snapshot.c                            |   1 +
 hw/block/virtio-blk.c                       | 132 +-------
 hw/ide/core.c                               |   3 +-
 hw/ide/macio.c                              |   3 +-
 hw/scsi/scsi-bus.c                          | 121 +++++--
 hw/scsi/scsi-disk.c                         |  24 +-
 hw/scsi/virtio-scsi-dataplane.c             | 103 ++++--
 hw/scsi/virtio-scsi.c                       | 502 ++++++++++++++++------------
 hw/virtio/iothread-vq-mapping.c             | 131 ++++++++
 system/dma-helpers.c                        |   8 +-
 util/aio-posix.c                            | 114 ++++---
 util/async.c                                |   1 -
 scripts/qcow2-to-stdout.py                  | 449 +++++++++++++++++++++++++
 hw/virtio/meson.build                       |   1 +
 meson.build                                 |   8 +
 tests/qemu-iotests/051.pc.out               |   2 +-
 tests/qemu-iotests/tests/qsd-migrate        |   2 +-
 30 files changed, 1286 insertions(+), 511 deletions(-)
 create mode 100644 include/hw/virtio/iothread-vq-mapping.h
 create mode 100644 hw/virtio/iothread-vq-mapping.c
 create mode 100755 scripts/qcow2-to-stdout.py


