Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFDAD116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhoU-0004r0-HA; Wed, 03 Dec 2025 03:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhoT-0004nK-7w; Wed, 03 Dec 2025 03:02:13 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQhoR-00076g-BH; Wed, 03 Dec 2025 03:02:12 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0826217077A;
 Wed, 03 Dec 2025 10:59:24 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C67F532B4A1;
 Wed, 03 Dec 2025 10:59:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Hanna Czenczek <hreitz@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 109/116] block-backend: Fix race when resuming queued
 requests
Date: Wed,  3 Dec 2025 10:59:29 +0300
Message-ID: <20251203075939.2366131-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251203105830@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Kevin Wolf <kwolf@redhat.com>

When new requests arrive at a BlockBackend that is currently drained,
these requests are queued until the drain section ends.

There is a race window between blk_root_drained_end() waking up a queued
request in an iothread from the main thread and blk_wait_while_drained()
actually being woken up in the iothread and calling blk_inc_in_flight().
If the BlockBackend is drained again during this window, drain won't
wait for this request and it will sneak in when the BlockBackend is
already supposed to be quiesced. This causes assertion failures in
bdrv_drain_all_begin() and can have other unintended consequences.

Fix this by increasing the in_flight counter immediately when scheduling
the request to be resumed so that the next drain will wait for it to
complete.

Cc: qemu-stable@nongnu.org
Reported-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20251119172720.135424-1-kwolf@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Tested-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 8eeaa706ba73251063cb80d87ae838d2d5b08e9a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/block-backend.c b/block/block-backend.c
index a402db13f2..50ccf3663f 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1318,9 +1318,9 @@ static void coroutine_fn blk_wait_while_drained(BlockBackend *blk)
          * section.
          */
         qemu_mutex_lock(&blk->queued_requests_lock);
+        /* blk_root_drained_end() has the corresponding blk_inc_in_flight() */
         blk_dec_in_flight(blk);
         qemu_co_queue_wait(&blk->queued_requests, &blk->queued_requests_lock);
-        blk_inc_in_flight(blk);
         qemu_mutex_unlock(&blk->queued_requests_lock);
     }
 }
@@ -2767,9 +2767,11 @@ static void blk_root_drained_end(BdrvChild *child)
             blk->dev_ops->drained_end(blk->dev_opaque);
         }
         qemu_mutex_lock(&blk->queued_requests_lock);
-        while (qemu_co_enter_next(&blk->queued_requests,
-                                  &blk->queued_requests_lock)) {
+        while (!qemu_co_queue_empty(&blk->queued_requests)) {
             /* Resume all queued requests */
+            blk_inc_in_flight(blk);
+            qemu_co_enter_next(&blk->queued_requests,
+                               &blk->queued_requests_lock);
         }
         qemu_mutex_unlock(&blk->queued_requests_lock);
     }
-- 
2.47.3


