Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78081C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp7GT-0004BD-WA; Tue, 26 Mar 2024 09:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rp7GR-00049J-IC
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:54:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rp7GP-0001Ob-U6
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711461293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GGFmnCZBV71cdeNB8RS4f6ngdrPmRvsBOxFBjUsklWM=;
 b=IoaUcp3xEMGTy1YszAgi0I13UNwLsVp8c3MBXLrA8eqGtDq/HqoVquvIxjHo1MIwifZzzH
 pzADhZkGlLQo9PTW1eN1n8TdnyoNLfouEs9UOR/sAyVPNl8TyFJ9M2D9jA4OUn1PP3c18W
 5dYKI/SCIbDVs8xLux25Dj2vVpIrxRQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-ls-2rlfyPbS-Xuy0FiEcQw-1; Tue, 26 Mar 2024 09:54:51 -0400
X-MC-Unique: ls-2rlfyPbS-Xuy0FiEcQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C0688B5AE9;
 Tue, 26 Mar 2024 13:54:51 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5CA61121312;
 Tue, 26 Mar 2024 13:54:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 4/6] block-backend: fix edge case in bdrv_next() where BDS
 associated to BB changes
Date: Tue, 26 Mar 2024 14:54:38 +0100
Message-ID: <20240326135440.421609-5-kwolf@redhat.com>
In-Reply-To: <20240326135440.421609-1-kwolf@redhat.com>
References: <20240326135440.421609-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 block/block-backend.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 9c4de79e6b..28af1eb17a 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -599,14 +599,14 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it)
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
@@ -620,11 +620,10 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it)
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
2.44.0


