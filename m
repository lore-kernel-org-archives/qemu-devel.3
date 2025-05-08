Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DFFC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1wh-0001vU-Dw; Thu, 08 May 2025 10:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uD1wf-0001ln-33; Thu, 08 May 2025 10:09:53 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uD1wc-0008RL-SJ; Thu, 08 May 2025 10:09:52 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2884A42DAD;
 Thu,  8 May 2025 16:09:41 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru
Subject: [RFC 00/11] do not drain while holding the graph lock
Date: Thu,  8 May 2025 16:09:25 +0200
Message-Id: <20250508140936.3344485-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

This series is an attempt to fix a deadlock issue reported by Andrey
here [0].

bdrv_drained_begin() polls and is not allowed to be called with the
block graph lock held. Mark the function as GRAPH_UNLOCKED.

This does not catch the issue reported by Andrey, because there
is a bdrv_graph_rdunlock_main_loop() before bdrv_drained_begin() in
the function bdrv_change_aio_context(). That unlock is of course
ineffective if the exclusive lock is held, but it seems to prevent TSA
from finding the issue.

Thus the bdrv_drained_begin() call from inside
bdrv_change_aio_context() needs to be moved up the call stack before
acquiring the locks. This required the most changes, patch 09/11.

Granular draining is not trivially possible, because many of the
affected functions can recursively call themselves.

In place where bdrv_drained_begin() calls were removed, assertions
are added, checking the quiesced_counter to ensure that the nodes
already got drained further up in the call stack.

In bdrv_graph_wrlock() there is a comment that it uses
bdrv_drain_all_begin_nopoll() to make sure that constantly arriving
new I/O doesn't cause starvation. The changes from this series are at
odds with that, but there doesn't seem to be any (new) test failures.

[0]: https://lore.kernel.org/qemu-devel/73839c04-7616-407e-b057-80ca69e63f51@virtuozzo.com/

I did not CC the maintainers for blkverify, vmdk, etc. because this is
just an RFC and the changes there are mechanical, for adapting some
callers of block layer functions.

Andrey Drobyshev (1):
  iotests/graph-changes-while-io: add test case with removal of lower
    snapshot

Fiona Ebner (10):
  block: remove outdated comments about AioContext locking
  block: move drain outside of read-locked bdrv_reopen_queue_child()
  block/snapshot: move drain outside of read-locked
    bdrv_snapshot_delete()
  block: drain while unlocked in bdrv_reopen_parse_file_or_backing()
  block: move drain outside of read-locked bdrv_inactivate_recurse()
  blockdev: drain while unlocked in internal_snapshot_action()
  blockdev: drain while unlocked in external_snapshot_action()
  block: mark bdrv_drained_begin() as GRAPH_UNLOCKED
  block: move drain out of bdrv_change_aio_context()
  block/graph-lock: add drain flag to bdrv_graph_wr{,un}lock

 block.c                                       | 170 +++++++++++-------
 block/backup.c                                |   4 +-
 block/blklogwrites.c                          |   8 +-
 block/blkverify.c                             |   4 +-
 block/block-backend.c                         |   8 +-
 block/commit.c                                |  16 +-
 block/graph-lock.c                            |  22 ++-
 block/mirror.c                                |  22 +--
 block/qcow2.c                                 |   4 +-
 block/quorum.c                                |   8 +-
 block/replication.c                           |  14 +-
 block/snapshot.c                              |  22 ++-
 block/stream.c                                |  18 +-
 block/vmdk.c                                  |  20 +--
 blockdev.c                                    |  59 ++++--
 blockjob.c                                    |  12 +-
 include/block/block-global-state.h            |   8 +-
 include/block/block-io.h                      |   3 +-
 include/block/graph-lock.h                    |   8 +-
 qemu-img.c                                    |   2 +
 scripts/block-coroutine-wrapper.py            |   4 +-
 .../qemu-iotests/tests/graph-changes-while-io | 101 ++++++++++-
 .../tests/graph-changes-while-io.out          |   4 +-
 tests/unit/test-bdrv-drain.c                  |  40 ++---
 tests/unit/test-bdrv-graph-mod.c              |  20 +--
 25 files changed, 384 insertions(+), 217 deletions(-)

-- 
2.39.5



