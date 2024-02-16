Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE27BC48BEB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 10:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ravsV-0008M0-4t; Fri, 16 Feb 2024 05:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ravsS-0008J0-Te; Fri, 16 Feb 2024 05:55:32 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1ravsP-0007cJ-Oi; Fri, 16 Feb 2024 05:55:32 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 63B4F4855C;
 Fri, 16 Feb 2024 11:55:19 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com
Subject: [RFC 0/4] mirror: implement incremental and bitmap modes
Date: Fri, 16 Feb 2024 11:55:09 +0100
Message-Id: <20240216105513.309901-1-f.ebner@proxmox.com>
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

Previous discussion from when this was sent upstream [0] (it's been a
while). I rebased the patches and re-ordered and squashed like
suggested back then [1].

This implements two new mirror modes:

- bitmap mirror mode with always/on-success/never bitmap sync mode
- incremental mirror mode as sugar for bitmap + on-success

Use cases:
* Possibility to resume a failed mirror later.
* Possibility to only mirror deltas to a previously mirrored volume.
* Possibility to (efficiently) mirror an drive that was previously
  mirrored via some external mechanism (e.g. ZFS replication).

We are using the last one in production without any issues since about
4 years now. In particular, like mentioned in [2]:

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

The question is how to deal with these edge cases? Some possibilities
that would make sense to me:

For 'background' mode:
* prohibit if target's cluster size is larger than the bitmap
  granularity
* document the limitation

For 'write-blocking' mode:
* disallow in combination with bitmap mode (would not be happy about
  it, because I'd like to use this without diff images)
* for writes that are not aligned to the target's cluster size, read
  the relevant/missing parts from the source image to be able to write
  whole target clusters (seems rather complex)
* document the limitation


[0]: https://lore.kernel.org/qemu-devel/20200218100740.2228521-1-f.gruenbichler@proxmox.com/
[1]: https://lore.kernel.org/qemu-devel/d35a76de-78d5-af56-0b34-f7bd2bbd3733@redhat.com/
[2]: https://lore.kernel.org/qemu-devel/1599127031.9uxdp5h9o2.astroid@nora.none/


Fabian Grünbichler (2):
  mirror: move some checks to qmp
  iotests: add test for bitmap mirror

John Snow (2):
  drive-mirror: add support for sync=bitmap mode=never
  drive-mirror: add support for conditional and always bitmap sync modes

 block/mirror.c                                |   94 +-
 blockdev.c                                    |   70 +-
 include/block/block_int-global-state.h        |    4 +-
 qapi/block-core.json                          |   25 +-
 tests/qemu-iotests/tests/bitmap-sync-mirror   |  550 ++++
 .../qemu-iotests/tests/bitmap-sync-mirror.out | 2810 +++++++++++++++++
 tests/unit/test-block-iothread.c              |    4 +-
 7 files changed, 3527 insertions(+), 30 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/bitmap-sync-mirror
 create mode 100644 tests/qemu-iotests/tests/bitmap-sync-mirror.out

-- 
2.39.2



