Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D090CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSNV-0003ZM-5a; Wed, 10 Apr 2024 03:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSNS-0003SN-8d; Wed, 10 Apr 2024 03:28:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSNQ-0004uS-Bm; Wed, 10 Apr 2024 03:28:13 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8EF655D6A8;
 Wed, 10 Apr 2024 10:25:06 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2719FB02E8;
 Wed, 10 Apr 2024 10:23:08 +0300 (MSK)
Received: (nullmailer pid 4191817 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 56/87] block-backend: fix edge case in bdrv_next()
 where BDS associated to BB changes
Date: Wed, 10 Apr 2024 10:22:29 +0300
Message-Id: <20240410072303.4191455-56-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Fiona Ebner <f.ebner@proxmox.com>

The old_bs variable in bdrv_next() is currently determined by looking
at the old block backend. However, if the block graph changes before
the next bdrv_next() call, it might be that the associated BDS is not
the same that was referenced previously. In that case, the wrong BDS
is unreferenced, leading to an assertion failure later:

> bdrv_unref: Assertion `bs->refcnt > 0' failed.

In particular, this can happen in the context of bdrv_flush_all(),
when polling for bdrv_co_flush() in the generated co-wrapper leads to
a graph change (for example with a stream block job [0]).

A racy reproducer:

> #!/bin/bash
> rm -f /tmp/backing.qcow2
> rm -f /tmp/top.qcow2
> ./qemu-img create /tmp/backing.qcow2 -f qcow2 64M
> ./qemu-io -c "write -P42 0x0 0x1" /tmp/backing.qcow2
> ./qemu-img create /tmp/top.qcow2 -f qcow2 64M -b /tmp/backing.qcow2 -F qcow2
> ./qemu-system-x86_64 --qmp stdio \
> --blockdev qcow2,node-name=node0,file.driver=file,file.filename=/tmp/top.qcow2 \
> <<EOF
> {"execute": "qmp_capabilities"}
> {"execute": "block-stream", "arguments": { "job-id": "stream0", "device": "node0" } }
> {"execute": "quit"}
> EOF

[0]:

> #0  bdrv_replace_child_tran (child=..., new_bs=..., tran=...)
> #1  bdrv_replace_node_noperm (from=..., to=..., auto_skip=..., tran=..., errp=...)
> #2  bdrv_replace_node_common (from=..., to=..., auto_skip=..., detach_subchain=..., errp=...)
> #3  bdrv_drop_filter (bs=..., errp=...)
> #4  bdrv_cor_filter_drop (cor_filter_bs=...)
> #5  stream_prepare (job=...)
> #6  job_prepare_locked (job=...)
> #7  job_txn_apply_locked (fn=..., job=...)
> #8  job_do_finalize_locked (job=...)
> #9  job_exit (opaque=...)
> #10 aio_bh_poll (ctx=...)
> #11 aio_poll (ctx=..., blocking=...)
> #12 bdrv_poll_co (s=...)
> #13 bdrv_flush (bs=...)
> #14 bdrv_flush_all ()
> #15 do_vm_stop (state=..., send_stop=...)
> #16 vm_shutdown ()

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20240322095009.346989-3-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit f6d38c9f6dae6fce99dcaf6ca16a1fe5b5e19c4c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/block-backend.c b/block/block-backend.c
index ec21148806..4a419f75fb 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -613,14 +613,14 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it)
     /* Must be called from the main loop */
     assert(qemu_get_current_aio_context() == qemu_get_aio_context());
 
+    old_bs = it->bs;
+
     /* First, return all root nodes of BlockBackends. In order to avoid
      * returning a BDS twice when multiple BBs refer to it, we only return it
      * if the BB is the first one in the parent list of the BDS. */
     if (it->phase == BDRV_NEXT_BACKEND_ROOTS) {
         BlockBackend *old_blk = it->blk;
 
-        old_bs = old_blk ? blk_bs(old_blk) : NULL;
-
         do {
             it->blk = blk_all_next(it->blk);
             bs = it->blk ? blk_bs(it->blk) : NULL;
@@ -634,11 +634,10 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it)
         if (bs) {
             bdrv_ref(bs);
             bdrv_unref(old_bs);
+            it->bs = bs;
             return bs;
         }
         it->phase = BDRV_NEXT_MONITOR_OWNED;
-    } else {
-        old_bs = it->bs;
     }
 
     /* Then return the monitor-owned BDSes without a BB attached. Ignore all
-- 
2.39.2


