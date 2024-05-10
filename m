Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB499C25B5F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 13:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Q7m-0005bh-Gc; Fri, 10 May 2024 09:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s5Q7Y-0005VJ-IA; Fri, 10 May 2024 09:17:10 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s5Q7T-0002AO-RN; Fri, 10 May 2024 09:17:06 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 506C3473F7;
 Fri, 10 May 2024 15:16:52 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com
Subject: [PATCH v3 0/5] mirror: allow specifying working bitmap
Date: Fri, 10 May 2024 15:16:42 +0200
Message-Id: <20240510131647.1256467-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Changes from v2 (discussion here [2]):
* Cluster size caveats only apply to non-COW diff image, adapt the
  cluster size check and documentation accordingly.
* In the IO test, use backing files (rather than stand-alone diff
  images) in combination with copy-mode=write-blocking and larger
  cluster size for target images, to have a more realistic use-case
  and show that COW prevents ending up with cluster with partial data
  upon unaligned writes.
* Create a separate patch for replacing is_none_mode with sync_mode in
  MirrorBlockJobx struct.
* Disallow using read-only bitmap (cannot be used as working bitmap).
* Require that bitmap is enabled at the start of the job.
* Avoid IO test script potentially waiting on non-existent job when
  blockdev-mirror QMP command fails.
* Fix pylint issues in IO test.
* Rename IO test from sync-bitmap-mirror to mirror-bitmap.

Changes from RFC/v1 (discussion here [0]):
* Add patch to split BackupSyncMode and MirrorSyncMode.
* Drop bitmap-mode parameter and use passed-in bitmap as the working
  bitmap instead. Users can get the desired behaviors by
  using the block-dirty-bitmap-clear and block-dirty-bitmap-merge
  calls (see commit message in patch 2/4 for how exactly).
* Add patch to check whether target image's cluster size is at most
  mirror job's granularity. Optional, it's an extra safety check
  that's useful when the target is a "diff" image that does not have
  previously synced data.

Use cases:
* Possibility to resume a failed mirror later.
* Possibility to only mirror deltas to a previously mirrored volume.
* Possibility to (efficiently) mirror an drive that was previously
  mirrored via some external mechanism (e.g. ZFS replication).

We are using the last one in production without any issues since about
4 years now. In particular, like mentioned in [1]:

> - create bitmap(s)
> - (incrementally) replicate storage volume(s) out of band (using ZFS)
> - incrementally drive mirror as part of a live migration of VM
> - drop bitmap(s)


Now, the IO test added in patch 4/5 actually contains yet another use
case, namely doing incremental mirrors to qcow2 "diff" images, that
only contain the delta and can be rebased later. I had to adapt the IO
test, because its output expected the mirror bitmap to still be dirty,
but nowadays the mirror is apparently already done when the bitmaps
are queried. So I thought, I'll just use 'write-blocking' mode to
avoid any potential timing issues.

Initially, the qcow2 diff image targets were stand-alone and that
suffers from an issue when 'write-blocking' mode is used. If a write
is not aligned to the granularity of the mirror target, then rebasing
the diff image onto a backing image will not yield the desired result,
because the full cluster is considered to be allocated and will "hide"
some part of the base/backing image. The failure can be seen by either
using 'write-blocking' mode in the IO test or setting the (bitmap)
granularity to 32 KiB rather than the current 64 KiB.

The test thus uses a more realistic approach where the qcow2 targets
have backing images and a check is added in patch 5/5 for the cluster
size for non-COW targets. However, with e.g. NBD, the cluster size
cannot be queried and prohibiting all bitmap mirrors to NBD targets
just to prevent the highly specific edge case seems not worth it, so
the limitation is rather documented and the check ignores cases where
querying the target image's cluster size returns -ENOTSUP.


[0]: https://lore.kernel.org/qemu-devel/b91dba34-7969-4d51-ba40-96a91038cc54@yandex-team.ru/T/#m4ae27dc8ca1fb053e0a32cc4ffa2cfab6646805c
[1]: https://lore.kernel.org/qemu-devel/1599127031.9uxdp5h9o2.astroid@nora.none/
[2]: https://lore.kernel.org/qemu-devel/20240307134711.709816-1-f.ebner@proxmox.com/


Fabian Grünbichler (1):
  iotests: add test for bitmap mirror

Fiona Ebner (3):
  qapi/block-core: avoid the re-use of MirrorSyncMode for backup
  block/mirror: replace is_none_mode with sync_mode in MirrorBlockJob
    struct
  blockdev: mirror: check for target's cluster size when using bitmap

John Snow (1):
  mirror: allow specifying working bitmap

 block/backup.c                             |   18 +-
 block/mirror.c                             |  101 +-
 block/monitor/block-hmp-cmds.c             |    2 +-
 block/replication.c                        |    2 +-
 blockdev.c                                 |  127 +-
 include/block/block_int-global-state.h     |    7 +-
 qapi/block-core.json                       |   64 +-
 tests/qemu-iotests/tests/mirror-bitmap     |  603 ++++
 tests/qemu-iotests/tests/mirror-bitmap.out | 3198 ++++++++++++++++++++
 tests/unit/test-block-iothread.c           |    2 +-
 10 files changed, 4055 insertions(+), 69 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/mirror-bitmap
 create mode 100644 tests/qemu-iotests/tests/mirror-bitmap.out

-- 
2.39.2



