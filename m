Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1B3C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKF6-0007EN-Nz; Tue, 20 May 2025 06:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKEr-0006iN-Bm; Tue, 20 May 2025 06:30:25 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uHKEo-00050i-QM; Tue, 20 May 2025 06:30:24 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6C47B43AAD;
 Tue, 20 May 2025 12:30:17 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v2 00/24] block: do not drain while holding the graph lock
Date: Tue, 20 May 2025 12:29:48 +0200
Message-Id: <20250520103012.424311-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Previous discussion [0].

Changes in v2:
* Split the big patch moving the drain outside of
  bdrv_change_aio_context(), mark functions along the way with graph
  lock annotations.
* In {internal,external}_snapshot_action, check that associated bs did
  not change after drain and re-acquiring the lock.
* Improve error handling using goto where appropriate.
* Add bdrv_graph_wrlock_drained() convenience wrapper rather than
  adding a flag argument.
* Don't use atomics to access bs->quiesce_counter field, add a patch
  to adapt the two existing places that used atomics.
* Re-use 'top' image for graph-changes-while-io test case and rename
  the other image to 'mid'. Remove the image files after the test.
* Use "must be" instead of "needs to be" in documentation, use single
  line comments where possible.
* Remove yet another outdated comment.
* I did not add Kevin's R-b for the patch marking bdrv_drained_begin()
  GRAPH_RDLOCK, as the earlier patches/preconditions changed.

This series is an attempt to fix a deadlock issue reported by Andrey
here [1].

bdrv_drained_begin() polls and is not allowed to be called with the
block graph lock held. Mark the function as GRAPH_UNLOCKED.

This alone does not catch the issue reported by Andrey, because there
is a bdrv_graph_rdunlock_main_loop() before bdrv_drained_begin() in
the function bdrv_change_aio_context(). That unlock is of course
ineffective if the exclusive lock is held, but it prevents TSA from
finding the issue.

Thus the bdrv_drained_begin() call from inside
bdrv_change_aio_context() needs to be moved up the call stack before
acquiring the locks. This is the bulk of the series.

Granular draining is not trivially possible, because many of the
affected functions can recursively call themselves.

In place where bdrv_drained_begin() calls were removed, assertions
are added, checking the quiesced_counter to ensure that the nodes
already got drained further up in the call stack.

NOTE:
there are pre-existing test failures on current master, e.g. '240' for
all formats, '295 296 inactive-node-nbd luks-detached-header' for luks
and 'mirror-sparse' for raw. For me, the failures do not change after
this series.

[0]: https://lore.kernel.org/qemu-devel/20250508140936.3344485-1-f.ebner@proxmox.com/
[1]: https://lore.kernel.org/qemu-devel/73839c04-7616-407e-b057-80ca69e63f51@virtuozzo.com/

Andrey Drobyshev (1):
  iotests/graph-changes-while-io: add test case with removal of lower
    snapshot

Fiona Ebner (23):
  block: remove outdated comments about AioContext locking
  block: move drain outside of read-locked bdrv_reopen_queue_child()
  block/snapshot: move drain outside of read-locked
    bdrv_snapshot_delete()
  block: move drain outside of read-locked bdrv_inactivate_recurse()
  block: mark bdrv_parent_change_aio_context() GRAPH_RDLOCK
  block: mark change_aio_ctx() callback and instances as
    GRAPH_RDLOCK(_PTR)
  block: mark bdrv_child_change_aio_context() GRAPH_RDLOCK
  block: move drain outside of bdrv_change_aio_context() and mark
    GRAPH_RDLOCK
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
  block: mark bdrv_drained_begin() as GRAPH_UNLOCKED
  iotests/graph-changes-while-io: remove image file after test
  block/io: remove duplicate GLOBAL_STATE_CODE() in
    bdrv_do_drained_end()
  block: never use atomics to access bs->quiesce_counter
  block: add bdrv_graph_wrlock_drained() convenience wrapper

 block.c                                       | 156 ++++++++++--------
 block/backup.c                                |   2 +-
 block/blklogwrites.c                          |   4 +-
 block/blkverify.c                             |   2 +-
 block/block-backend.c                         |  10 +-
 block/commit.c                                |   2 +-
 block/graph-lock.c                            |  40 ++++-
 block/io.c                                    |   8 +-
 block/mirror.c                                |   2 +-
 block/qcow2.c                                 |   2 +-
 block/quorum.c                                |   4 +-
 block/replication.c                           |   4 +-
 block/snapshot.c                              |  28 ++--
 block/stream.c                                |   8 +-
 block/vmdk.c                                  |  10 +-
 blockdev.c                                    |  78 +++++++--
 blockjob.c                                    |  10 +-
 include/block/block-global-state.h            |  15 +-
 include/block/block-io.h                      |   2 +-
 include/block/block_int-common.h              |   8 +-
 include/block/graph-lock.h                    |  11 ++
 qemu-img.c                                    |   2 +
 .../qemu-iotests/tests/graph-changes-while-io | 102 +++++++++++-
 .../tests/graph-changes-while-io.out          |   4 +-
 tests/unit/test-bdrv-drain.c                  |  22 +--
 tests/unit/test-bdrv-graph-mod.c              |  10 +-
 26 files changed, 373 insertions(+), 173 deletions(-)

-- 
2.39.5



