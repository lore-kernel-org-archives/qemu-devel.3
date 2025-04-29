Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA281C3ABAB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 11:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9jDx-0007G9-1S; Tue, 29 Apr 2025 07:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDj-0006wx-Py; Tue, 29 Apr 2025 07:33:52 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u9jDe-0008FT-7Z; Tue, 29 Apr 2025 07:33:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cca4:0:640:432b:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id A3A1C613D9;
 Tue, 29 Apr 2025 14:33:41 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b423::1:3a])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bXTAnY0Fe0U0-EKYKT2em; Tue, 29 Apr 2025 14:33:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1745926421;
 bh=xkLZ1GZTOtbVQt+osR2ziS0pLuj2G7hrkNYOXSXAPIU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Fzp22hLmF6e9sWVdT93i+PxIw/x4FZP033Gw0a+8mTSPxLBvhWZPsoZwZasTxgMnW
 vD2aX0qxYhaxShfEwgxRcCcCdnvaIK34tJrOPmo4/g7jqMnyGIxE03pTWTgJ0RddOo
 8QvA+zuD7INGa8b8Vm+H4Kp9bjaOC1F3w6AndIBE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 qemu-stable@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 3/5] block/reqlist: allow adding overlapping requests
Date: Tue, 29 Apr 2025 14:33:28 +0300
Message-ID: <20250429113335.423535-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429113335.423535-1-vsementsov@yandex-team.ru>
References: <20250429113335.423535-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

Allow overlapping request by removing the assert that made it
impossible. There are only two callers:

1. block_copy_task_create()

It already asserts the very same condition before calling
reqlist_init_req().

2. cbw_snapshot_read_lock()

There is no need to have read requests be non-overlapping in
copy-before-write when used for snapshot-access. In fact, there was no
protection against two callers of cbw_snapshot_read_lock() calling
reqlist_init_req() with overlapping ranges and this could lead to an
assertion failure [1].

In particular, with the reproducer script below [0], two
cbw_co_snapshot_block_status() callers could race, with the second
calling reqlist_init_req() before the first one finishes and removes
its conflicting request.

[0]:

> #!/bin/bash -e
> dd if=/dev/urandom of=/tmp/disk.raw bs=1M count=1024
> ./qemu-img create /tmp/fleecing.raw -f raw 1G
> (
> ./qemu-system-x86_64 --qmp stdio \
> --blockdev raw,node-name=node0,file.driver=file,file.filename=/tmp/disk.raw \
> --blockdev raw,node-name=node1,file.driver=file,file.filename=/tmp/fleecing.raw \
> <<EOF
> {"execute": "qmp_capabilities"}
> {"execute": "blockdev-add", "arguments": { "driver": "copy-before-write", "file": "node0", "target": "node1", "node-name": "node3" } }
> {"execute": "blockdev-add", "arguments": { "driver": "snapshot-access", "file": "node3", "node-name": "snap0" } }
> {"execute": "nbd-server-start", "arguments": {"addr": { "type": "unix", "data": { "path": "/tmp/nbd.socket" } } } }
> {"execute": "block-export-add", "arguments": {"id": "exp0", "node-name": "snap0", "type": "nbd", "name": "exp0"}}
> EOF
> ) &
> sleep 5
> while true; do
> ./qemu-nbd -d /dev/nbd0
> ./qemu-nbd -c /dev/nbd0 nbd:unix:/tmp/nbd.socket:exportname=exp0 -f raw -r
> nbdinfo --map 'nbd+unix:///exp0?socket=/tmp/nbd.socket'
> done

[1]:

> #5  0x000071e5f0088eb2 in __GI___assert_fail (...) at ./assert/assert.c:101
> #6  0x0000615285438017 in reqlist_init_req (...) at ../block/reqlist.c:23
> #7  0x00006152853e2d98 in cbw_snapshot_read_lock (...) at ../block/copy-before-write.c:237
> #8  0x00006152853e3068 in cbw_co_snapshot_block_status (...) at ../block/copy-before-write.c:304
> #9  0x00006152853f4d22 in bdrv_co_snapshot_block_status (...) at ../block/io.c:3726
> #10 0x000061528543a63e in snapshot_access_co_block_status (...) at ../block/snapshot-access.c:48
> #11 0x00006152853f1a0a in bdrv_co_do_block_status (...) at ../block/io.c:2474
> #12 0x00006152853f2016 in bdrv_co_common_block_status_above (...) at ../block/io.c:2652
> #13 0x00006152853f22cf in bdrv_co_block_status_above (...) at ../block/io.c:2732
> #14 0x00006152853d9a86 in blk_co_block_status_above (...) at ../block/block-backend.c:1473
> #15 0x000061528538da6c in blockstatus_to_extents (...) at ../nbd/server.c:2374
> #16 0x000061528538deb1 in nbd_co_send_block_status (...) at ../nbd/server.c:2481
> #17 0x000061528538f424 in nbd_handle_request (...) at ../nbd/server.c:2978
> #18 0x000061528538f906 in nbd_trip (...) at ../nbd/server.c:3121
> #19 0x00006152855a7caf in coroutine_trampoline (...) at ../util/coroutine-ucontext.c:175

Cc: qemu-stable@nongnu.org
Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20240712140716.517911-1-f.ebner@proxmox.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/copy-before-write.c | 3 ++-
 block/reqlist.c           | 2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index e835987e52..81afeff1c7 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -66,7 +66,8 @@ typedef struct BDRVCopyBeforeWriteState {
 
     /*
      * @frozen_read_reqs: current read requests for fleecing user in bs->file
-     * node. These areas must not be rewritten by guest.
+     * node. These areas must not be rewritten by guest. There can be multiple
+     * overlapping read requests.
      */
     BlockReqList frozen_read_reqs;
 
diff --git a/block/reqlist.c b/block/reqlist.c
index 08cb57cfa4..098e807378 100644
--- a/block/reqlist.c
+++ b/block/reqlist.c
@@ -20,8 +20,6 @@
 void reqlist_init_req(BlockReqList *reqs, BlockReq *req, int64_t offset,
                       int64_t bytes)
 {
-    assert(!reqlist_find_conflict(reqs, offset, bytes));
-
     *req = (BlockReq) {
         .offset = offset,
         .bytes = bytes,
-- 
2.34.1


