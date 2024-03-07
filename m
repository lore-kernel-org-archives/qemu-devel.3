Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B02EC54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 13:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riE9M-0000zr-HG; Thu, 07 Mar 2024 08:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1riE62-0005zi-El; Thu, 07 Mar 2024 08:47:44 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1riE5z-000880-Gx; Thu, 07 Mar 2024 08:47:42 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 882F64888C;
 Thu,  7 Mar 2024 14:47:16 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com
Subject: [PATCH v2 0/4] mirror: allow specifying working bitmap
Date: Thu,  7 Mar 2024 14:47:07 +0100
Message-Id: <20240307134711.709816-1-f.ebner@proxmox.com>
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


Now, the IO test added in patch 4/4 actually contains yet another use
case, namely doing incremental mirrors to stand-alone qcow2 "diff"
images, that only contain the delta and can be rebased later. I had to
adapt the IO test, because its output expected the mirror bitmap to
still be dirty, but nowadays the mirror is apparently already done
when the bitmaps are queried. So I thought, I'll just use
'write-blocking' mode to avoid any potential timing issues.

But this exposed an issue with the diff image approach. If a write is
not aligned to the granularity of the mirror target, then rebasing the
diff image onto a backing image will not yield the desired result,
because the full cluster is considered to be allocated and will "hide"
some part of the base/backing image. The failure can be seen by either
using 'write-blocking' mode in the IO test or setting the (bitmap)
granularity to 32 KiB rather than the current 64 KiB.

For the latter case, patch 4/4 adds a check. For the former, the
limitation is documented (I'd expect this to be a niche use case in
practice).

[0]: https://lore.kernel.org/qemu-devel/b91dba34-7969-4d51-ba40-96a91038cc54@yandex-team.ru/T/#m4ae27dc8ca1fb053e0a32cc4ffa2cfab6646805c
[1]: https://lore.kernel.org/qemu-devel/1599127031.9uxdp5h9o2.astroid@nora.none/


Fabian Grünbichler (1):
  iotests: add test for bitmap mirror

Fiona Ebner (2):
  qapi/block-core: avoid the re-use of MirrorSyncMode for backup
  blockdev: mirror: check for target's cluster size when using bitmap

John Snow (1):
  mirror: allow specifying working bitmap

 block/backup.c                                |   18 +-
 block/mirror.c                                |  102 +-
 block/monitor/block-hmp-cmds.c                |    2 +-
 block/replication.c                           |    2 +-
 blockdev.c                                    |   84 +-
 include/block/block_int-global-state.h        |    7 +-
 qapi/block-core.json                          |   64 +-
 tests/qemu-iotests/tests/bitmap-sync-mirror   |  571 ++++
 .../qemu-iotests/tests/bitmap-sync-mirror.out | 2946 +++++++++++++++++
 tests/unit/test-block-iothread.c              |    2 +-
 10 files changed, 3729 insertions(+), 69 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/bitmap-sync-mirror
 create mode 100644 tests/qemu-iotests/tests/bitmap-sync-mirror.out

-- 
2.39.2



