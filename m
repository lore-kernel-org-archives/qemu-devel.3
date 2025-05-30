Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2A4C5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1Or-0002vg-Jp; Fri, 30 May 2025 11:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1On-0002sh-3u; Fri, 30 May 2025 11:11:57 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1Ok-0002Ff-RK; Fri, 30 May 2025 11:11:56 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8628044A6A;
 Fri, 30 May 2025 17:11:41 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 00/48] block: do not drain while holding the graph lock
Date: Fri, 30 May 2025 17:10:37 +0200
Message-Id: <20250530151125.955508-1-f.ebner@proxmox.com>
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

Previous discussions:
v3: [0]
v2: [1]
v1: [2]

Changes in v4:
* Document requirement to drain all block nodes for affected
  functions.
* Also cover the generated bdrv_co_unref_child().
* Remove now superfluous drain_bs variable in bdrv_set_backing_hd().
* Mark bdrv_graph_wrlock_drained() wrapper as GRAPH_UNLOCKED.
* Unify bdrv_set_backing_hd() with its drained_variant.
* Mark more functions up the call-stack as GRAPH_UNLOCKED. This is
  almost all of the new patches in the latter half of the series, most
  do not require substantial changes, but there are a few where
  something needed to be done. I did not mark functions outside the
  block layer like qemu_cleanup(), save_snapshot(), qmp_xyz(), etc.
  and also not functions that explicitly do a rdunlock_main_loop()
  before calling a function that is GRAPH_UNLOCKED.

There were no changes for patches 01/48-09/48 and 17/48-23/48, endpoints
inclusive. All patches starting from 25/48 are new in v4.

Changes in v3:
* Also add bdrv_drain_all_begin() and bdrv_drain_all() as
  GRAPH_UNLOCKED.
* Extend drained section in bdrv_try_change_aio_context() until after
  the transaction is finalized.
* Also mark definition of static bdrv_change_aio_context() as
  GRAPH_RDLOCK, not only the declaration.
* Add comments for bdrv_{child,parent}_change_aio_context() and
  change_aio_ctx().
* Improve commit messages: typos/language/clarification.

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
here [3].

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
all formats, '295 296 inactive-node-nbd luks-detached-header' for
luks. For me, the failures do not change after this series.
For '240', a patch is already available [4].

[0]: https://lore.kernel.org/qemu-devel/20250526132140.1641377-1-f.ebner@proxmox.com/
[1]: https://lore.kernel.org/qemu-devel/20250520103012.424311-1-f.ebner@proxmox.com/
[2]: https://lore.kernel.org/qemu-devel/20250508140936.3344485-1-f.ebner@proxmox.com/
[3]: https://lore.kernel.org/qemu-devel/73839c04-7616-407e-b057-80ca69e63f51@virtuozzo.com/
[4]: https://lore.kernel.org/qemu-devel/20250529203147.180338-1-stefanha@redhat.com/


Andrey Drobyshev (1):
  iotests/graph-changes-while-io: add test case with removal of lower
    snapshot

Fiona Ebner (47):
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
  block: mark bdrv_drained_begin() and friends as GRAPH_UNLOCKED
  iotests/graph-changes-while-io: remove image file after test
  block/io: remove duplicate GLOBAL_STATE_CODE() in
    bdrv_do_drained_end()
  block: never use atomics to access bs->quiesce_counter
  block: add bdrv_graph_wrlock_drained() convenience wrapper
  block/mirror: switch to bdrv_set_backing_hd_drained() variant
  block/commit: switch to bdrv_set_backing_hd_drained() variant
  block: call bdrv_set_backing_hd() while unlocked in
    bdrv_open_backing_file()
  block: mark bdrv_set_backing_hd() as GRAPH_UNLOCKED
  blockdev: avoid locking and draining multiple times in
    external_snapshot_abort()
  block: drop wrapper for bdrv_set_backing_hd_drained()
  block-backend: mark blk_drain_all() as GRAPH_UNLOCKED
  block/snapshot: mark bdrv_all_delete_snapshot() as GRAPH_UNLOCKED
  block/stream: mark stream_prepare() as GRAPH_UNLOCKED
  block: mark bdrv_reopen_queue() and bdrv_reopen_multiple() as
    GRAPH_UNLOCKED
  block: mark bdrv_inactivate() as GRAPH_RDLOCK and move drain to
    callers
  block: mark bdrv_inactivate_all() as GRAPH_UNLOCKED
  block: mark blk_remove_bs() as GRAPH_UNLOCKED
  block: mark blk_drain() as GRAPH_UNLOCKED
  block-backend: mark blk_io_limits_disable() as GRAPH_UNLOCKED
  block/commit: mark commit_abort() as GRAPH_UNLOCKED
  block: mark bdrv_new() as GRAPH_UNLOCKED
  block: mark bdrv_replace_child_bs() as GRAPH_UNLOCKED
  block: mark bdrv_insert_node() as GRAPH_UNLOCKED
  block: mark bdrv_drop_intermediate() as GRAPH_UNLOCKED
  block: mark bdrv_close_all() as GRAPH_UNLOCKED
  block: mark bdrv_close() as GRAPH_UNLOCKED
  block: mark bdrv_open_child_common() and its callers GRAPH_UNLOCKED
  blockjob: mark block_job_remove_all_bdrv() as GRAPH_UNLOCKED

 block.c                                       | 270 +++++++++++-------
 block/backup.c                                |   2 +-
 block/blklogwrites.c                          |   4 +-
 block/blkverify.c                             |   2 +-
 block/block-backend.c                         |  10 +-
 block/commit.c                                |  30 +-
 block/graph-lock.c                            |  40 ++-
 block/io.c                                    |   8 +-
 block/mirror.c                                |  12 +-
 block/monitor/block-hmp-cmds.c                |  15 +-
 block/qcow2.c                                 |   4 +-
 block/quorum.c                                |   4 +-
 block/replication.c                           |   7 +-
 block/snapshot.c                              |  28 +-
 block/stream.c                                |  23 +-
 block/vmdk.c                                  |  16 +-
 blockdev.c                                    | 174 +++++++----
 blockjob.c                                    |  10 +-
 include/block/block-global-state.h            |  67 +++--
 include/block/block-io.h                      |   2 +-
 include/block/block_int-common.h              |  36 ++-
 include/block/blockjob.h                      |   4 +-
 include/block/graph-lock.h                    |  11 +
 include/block/snapshot.h                      |   6 +-
 include/qemu/job.h                            |   4 +-
 include/system/block-backend-global-state.h   |   8 +-
 qemu-img.c                                    |   2 +
 .../qemu-iotests/tests/graph-changes-while-io | 102 ++++++-
 .../tests/graph-changes-while-io.out          |   4 +-
 tests/unit/test-bdrv-drain.c                  |  34 ++-
 tests/unit/test-bdrv-graph-mod.c              |  10 +-
 31 files changed, 642 insertions(+), 307 deletions(-)

-- 
2.39.5



