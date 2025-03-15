Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E3DC28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKy3-0008Gu-Rq; Sat, 15 Mar 2025 02:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKvA-0003jo-Sy; Sat, 15 Mar 2025 02:22:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKv8-0003tI-ML; Sat, 15 Mar 2025 02:22:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 38ADDFF9FE;
 Sat, 15 Mar 2025 09:17:08 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 100E31CAC67;
 Sat, 15 Mar 2025 09:18:02 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A34C555913; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Denis Rastyogin <gerben@altlinux.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 50/51] block: Zero block driver state before reopening
Date: Sat, 15 Mar 2025 09:17:56 +0300
Message-Id: <20250315061801.622606-50-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Kevin Wolf <kwolf@redhat.com>

Block drivers assume in their .bdrv_open() implementation that their
state in bs->opaque has been zeroed; it is initially allocated with
g_malloc0() in bdrv_open_driver().

bdrv_snapshot_goto() needs to make sure that it is zeroed again before
calling drv->bdrv_open() to avoid that block drivers use stale values.

One symptom of this bug is VMDK running into a double free when the user
tries to apply an internal snapshot like 'qemu-img snapshot -a test
test.vmdk'. This should be a graceful error because VMDK doesn't support
internal snapshots.

==25507== Invalid free() / delete / delete[] / realloc()
==25507==    at 0x484B347: realloc (vg_replace_malloc.c:1801)
==25507==    by 0x54B592A: g_realloc (gmem.c:171)
==25507==    by 0x1B221D: vmdk_add_extent (../block/vmdk.c:570)
==25507==    by 0x1B1084: vmdk_open_sparse (../block/vmdk.c:1059)
==25507==    by 0x1AF3D8: vmdk_open (../block/vmdk.c:1371)
==25507==    by 0x1A2AE0: bdrv_snapshot_goto (../block/snapshot.c:299)
==25507==    by 0x205C77: img_snapshot (../qemu-img.c:3500)
==25507==    by 0x58FA087: (below main) (libc_start_call_main.h:58)
==25507==  Address 0x832f3e0 is 0 bytes inside a block of size 272 free'd
==25507==    at 0x4846B83: free (vg_replace_malloc.c:989)
==25507==    by 0x54AEAC4: g_free (gmem.c:208)
==25507==    by 0x1AF629: vmdk_close (../block/vmdk.c:2889)
==25507==    by 0x1A2A9C: bdrv_snapshot_goto (../block/snapshot.c:290)
==25507==    by 0x205C77: img_snapshot (../qemu-img.c:3500)
==25507==    by 0x58FA087: (below main) (libc_start_call_main.h:58)

This error was discovered by fuzzing qemu-img.

Cc: qemu-stable@nongnu.org
Closes: https://gitlab.com/qemu-project/qemu/-/issues/2853
Closes: https://gitlab.com/qemu-project/qemu/-/issues/2851
Reported-by: Denis Rastyogin <gerben@altlinux.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250310104858.28221-1-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit b75c5f9879166b86ed7c48b772fdcd0693e8a9a3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/snapshot.c b/block/snapshot.c
index 8fd1756777..357c1469ab 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -296,6 +296,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
         bdrv_graph_wrunlock();
 
         ret = bdrv_snapshot_goto(fallback_bs, snapshot_id, errp);
+        memset(bs->opaque, 0, drv->instance_size);
         open_ret = drv->bdrv_open(bs, options, bs->open_flags, &local_err);
         qobject_unref(options);
         if (open_ret < 0) {
-- 
2.39.5


