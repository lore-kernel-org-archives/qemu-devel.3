Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C661C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 17:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMsMB-0002HA-R7; Wed, 04 Jun 2025 13:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsM3-0002F7-S8
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsLr-0000Ob-Ir
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749059782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1+42R0fwZd0uyyLMFv62NJ2eF8im/SSHNJwAFVJ8PXY=;
 b=Lt8VKr9e/zrRYjRqJV8DoNqMjeWddVSauzaKnSa0tRwKj9NUp/9L15tHVQL0GOCycEY5HU
 E/WUEB3swpwViZalwPisxgxpQH0P4orsbHOsCZ1F3iNnW2ZytooC0jhN2y4x/pX7RHw4ZN
 +rLwIlaoYfy/SyS/cgSicdkEUxXzQ60=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-XYQVEgDuPDqBhmNBOKDoiQ-1; Wed,
 04 Jun 2025 13:56:21 -0400
X-MC-Unique: XYQVEgDuPDqBhmNBOKDoiQ-1
X-Mimecast-MFC-AGG-ID: XYQVEgDuPDqBhmNBOKDoiQ_1749059780
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFC691956094; Wed,  4 Jun 2025 17:56:19 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.34.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 698CE18002A5; Wed,  4 Jun 2025 17:56:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 00/24] Block layer patches
Date: Wed,  4 Jun 2025 19:55:49 +0200
Message-ID: <20250604175613.344113-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit 09be8a511a2e278b45729d7b065d30c68dd699d0:

  Merge tag 'pull-qapi-2025-06-03' of https://repo.or.cz/qemu/armbru into staging (2025-06-03 09:19:26 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to eef2dd03f948a512499775043bdc0c5c88d8a2dd:

  hw/core/qdev-properties-system: Add missing return in set_drive_helper() (2025-06-04 18:16:34 +0200)

----------------------------------------------------------------
Block layer patches

- Deadlock fixes: Do not drain while holding the graph lock
- qdev-properties-system: Fix assertion failure in set_drive_helper()
- iotests: fix 240

----------------------------------------------------------------
Andrey Drobyshev (1):
      iotests/graph-changes-while-io: add test case with removal of lower snapshot

Fiona Ebner (22):
      block: remove outdated comments about AioContext locking
      block: move drain outside of read-locked bdrv_reopen_queue_child()
      block/snapshot: move drain outside of read-locked bdrv_snapshot_delete()
      block: move drain outside of read-locked bdrv_inactivate_recurse()
      block: mark bdrv_parent_change_aio_context() GRAPH_RDLOCK
      block: mark change_aio_ctx() callback and instances as GRAPH_RDLOCK(_PTR)
      block: mark bdrv_child_change_aio_context() GRAPH_RDLOCK
      block: move drain outside of bdrv_change_aio_context() and mark GRAPH_RDLOCK
      block: move drain outside of bdrv_try_change_aio_context()
      block: move drain outside of bdrv_attach_child_common(_abort)()
      block: move drain outside of bdrv_set_backing_hd_drained()
      block: move drain outside of bdrv_root_attach_child()
      block: move drain outside of bdrv_attach_child()
      block: move drain outside of quorum_add_child()
      block: move drain outside of bdrv_root_unref_child()
      block: move drain outside of quorum_del_child()
      blockdev: drain while unlocked in internal_snapshot_action()
      blockdev: drain while unlocked in external_snapshot_action()
      block: mark bdrv_drained_begin() and friends as GRAPH_UNLOCKED
      iotests/graph-changes-while-io: remove image file after test
      block/io: remove duplicate GLOBAL_STATE_CODE() in bdrv_do_drained_end()
      hw/core/qdev-properties-system: Add missing return in set_drive_helper()

Stefan Hajnoczi (1):
      iotests: fix 240

 include/block/block-global-state.h                 |  19 +-
 include/block/block-io.h                           |   2 +-
 include/block/block_int-common.h                   |  32 ++-
 include/block/blockjob.h                           |   2 +
 block.c                                            | 235 ++++++++++++++-------
 block/backup.c                                     |   2 +
 block/blklogwrites.c                               |   4 +
 block/blkverify.c                                  |   2 +
 block/block-backend.c                              |  10 +-
 block/commit.c                                     |   4 +
 block/io.c                                         |   1 -
 block/mirror.c                                     |   5 +
 block/qcow2.c                                      |   4 +
 block/quorum.c                                     |   4 +
 block/replication.c                                |   7 +
 block/snapshot.c                                   |  28 ++-
 block/stream.c                                     |  10 +-
 block/vmdk.c                                       |  10 +
 blockdev.c                                         |  78 +++++--
 blockjob.c                                         |  12 +-
 hw/core/qdev-properties-system.c                   |   1 +
 qemu-img.c                                         |   2 +
 tests/unit/test-bdrv-drain.c                       |  24 ++-
 tests/unit/test-bdrv-graph-mod.c                   |  10 +
 tests/qemu-iotests/240                             |   2 -
 tests/qemu-iotests/240.out                         |   4 +-
 tests/qemu-iotests/tests/graph-changes-while-io    | 102 ++++++++-
 .../qemu-iotests/tests/graph-changes-while-io.out  |   4 +-
 28 files changed, 475 insertions(+), 145 deletions(-)


