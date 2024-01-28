Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B40C47DA9
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 17:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU9K3-0005Gk-PM; Sun, 28 Jan 2024 12:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9J0-0002t2-Qt; Sun, 28 Jan 2024 12:50:57 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9Iy-0000nm-Ss; Sun, 28 Jan 2024 12:50:54 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 520D848108;
 Sun, 28 Jan 2024 20:51:30 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id CB1306D524;
 Sun, 28 Jan 2024 20:50:38 +0300 (MSK)
Received: (nullmailer pid 812416 invoked by uid 1000);
 Sun, 28 Jan 2024 17:50:35 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 59/71] block/io: clear BDRV_BLOCK_RECURSE flag after
 recursing in bdrv_co_block_status
Date: Sun, 28 Jan 2024 20:50:22 +0300
Message-Id: <20240128175035.812352-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Using fleecing backup like in [0] on a qcow2 image (with metadata
preallocation) can lead to the following assertion failure:

> bdrv_co_do_block_status: Assertion `!(ret & BDRV_BLOCK_ZERO)' failed.

In the reproducer [0], it happens because the BDRV_BLOCK_RECURSE flag
will be set by the qcow2 driver, so the caller will recursively check
the file child. Then the BDRV_BLOCK_ZERO set too. Later up the call
chain, in bdrv_co_do_block_status() for the snapshot-access driver,
the assertion failure will happen, because both flags are set.

To fix it, clear the recurse flag after the recursive check was done.

In detail:

> #0  qcow2_co_block_status

Returns 0x45 = BDRV_BLOCK_RECURSE | BDRV_BLOCK_DATA |
BDRV_BLOCK_OFFSET_VALID.

> #1  bdrv_co_do_block_status

Because of the data flag, bdrv_co_do_block_status() will now also set
BDRV_BLOCK_ALLOCATED. Because of the recurse flag,
bdrv_co_do_block_status() for the bdrv_file child will be called,
which returns 0x16 = BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_OFFSET_VALID |
BDRV_BLOCK_ZERO. Now the return value inherits the zero flag.

Returns 0x57 = BDRV_BLOCK_RECURSE | BDRV_BLOCK_DATA |
BDRV_BLOCK_OFFSET_VALID | BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_ZERO.

> #2  bdrv_co_common_block_status_above
> #3  bdrv_co_block_status_above
> #4  bdrv_co_block_status
> #5  cbw_co_snapshot_block_status
> #6  bdrv_co_snapshot_block_status
> #7  snapshot_access_co_block_status
> #8  bdrv_co_do_block_status

Return value is propagated all the way up to here, where the assertion
failure happens, because BDRV_BLOCK_RECURSE and BDRV_BLOCK_ZERO are
both set.

> #9  bdrv_co_common_block_status_above
> #10 bdrv_co_block_status_above
> #11 block_copy_block_status
> #12 block_copy_dirty_clusters
> #13 block_copy_common
> #14 block_copy_async_co_entry
> #15 coroutine_trampoline

[0]:

> #!/bin/bash
> rm /tmp/disk.qcow2
> ./qemu-img create /tmp/disk.qcow2 -o preallocation=metadata -f qcow2 1G
> ./qemu-img create /tmp/fleecing.qcow2 -f qcow2 1G
> ./qemu-img create /tmp/backup.qcow2 -f qcow2 1G
> ./qemu-system-x86_64 --qmp stdio \
> --blockdev qcow2,node-name=node0,file.driver=file,file.filename=/tmp/disk.qcow2 \
> --blockdev qcow2,node-name=node1,file.driver=file,file.filename=/tmp/fleecing.qcow2 \
> --blockdev qcow2,node-name=node2,file.driver=file,file.filename=/tmp/backup.qcow2 \
> <<EOF
> {"execute": "qmp_capabilities"}
> {"execute": "blockdev-add", "arguments": { "driver": "copy-before-write", "file": "node0", "target": "node1", "node-name": "node3" } }
> {"execute": "blockdev-add", "arguments": { "driver": "snapshot-access", "file": "node3", "node-name": "snap0" } }
> {"execute": "blockdev-backup", "arguments": { "device": "snap0", "target": "node1", "sync": "full", "job-id": "backup0" } }
> EOF

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-id: 20240116154839.401030-1-f.ebner@proxmox.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 8a9be7992426c8920d4178e7dca59306a18c7a3a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/io.c b/block/io.c
index 7e62fabbf5..d202987770 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2619,6 +2619,16 @@ bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,
                 ret |= (ret2 & BDRV_BLOCK_ZERO);
             }
         }
+
+        /*
+         * Now that the recursive search was done, clear the flag. Otherwise,
+         * with more complicated block graphs like snapshot-access ->
+         * copy-before-write -> qcow2, where the return value will be propagated
+         * further up to a parent bdrv_co_do_block_status() call, both the
+         * BDRV_BLOCK_RECURSE and BDRV_BLOCK_ZERO flags would be set, which is
+         * not allowed.
+         */
+        ret &= ~BDRV_BLOCK_RECURSE;
     }
 
 out:
-- 
2.39.2


