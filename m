Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4E1C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 12:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMmui-00047p-VN; Wed, 04 Jun 2025 08:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uMmu5-0003yM-9P; Wed, 04 Jun 2025 08:07:35 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uMmu0-0002Cc-GO; Wed, 04 Jun 2025 08:07:31 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id CB10844B15;
 Wed,  4 Jun 2025 14:07:22 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it
Subject: [PATCH 0/4] block: fix deadlock when doing blockdev-snapshot of a
 node with compress filter
Date: Wed,  4 Jun 2025 14:07:13 +0200
Message-Id: <20250604120717.458445-1-f.ebner@proxmox.com>
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

Patches 1/4 and 2/4 are tangentially related. See patches 3/4 and 4/4
for the details.

I did not CC the people for the individual block drivers. Let me know
if I should!

Fiona Ebner (4):
  block/graph-lock: fix typo in comment
  block-coroutine-wrapper: mark generated co-wrapper as GRAPH_UNLOCKED
  block: make calling bdrv_refresh_limits() safe while holding graph
    lock
  iotests: add test for snapshot on top of node with compress filter

 block.c                            | 14 ++++++++++----
 block/blkio.c                      |  5 ++---
 block/crypto.c                     |  8 ++++----
 block/file-posix.c                 |  7 +++----
 block/io.c                         |  4 ++--
 block/iscsi.c                      |  7 +++----
 block/mirror.c                     |  5 +++--
 block/monitor/bitmap-qmp-cmds.c    |  2 ++
 block/qcow.c                       |  5 ++---
 block/qcow2.c                      |  5 ++---
 block/qed.c                        |  5 ++---
 block/raw-format.c                 |  7 +++----
 block/rbd.c                        |  5 ++---
 block/vdi.c                        | 11 ++++++-----
 block/vhdx.c                       |  5 ++---
 block/vmdk.c                       |  5 ++---
 block/vpc.c                        |  5 ++---
 hw/nvme/ns.c                       |  2 +-
 include/block/block-io.h           |  9 +++++----
 include/block/block_int-common.h   |  4 ++--
 include/block/dirty-bitmap.h       |  2 +-
 include/block/graph-lock.h         |  2 +-
 qemu-img.c                         |  6 ++++++
 scripts/block-coroutine-wrapper.py |  2 +-
 tests/qemu-iotests/085             | 18 ++++++++++++++++++
 tests/qemu-iotests/085.out         | 21 +++++++++++++++++++++
 26 files changed, 108 insertions(+), 63 deletions(-)

-- 
2.39.5



