Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80B5C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 17:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMsMH-0002No-6l; Wed, 04 Jun 2025 13:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsM6-0002G4-FI
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsM0-0000P9-3e
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749059785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ATCZEbqWjE7GHz6hGBYJgkhLO0mBKrOEwU9BIg2hDeo=;
 b=E8vF2566IcU6UwslSrKxHoAbaLVwxOigImtYuPZVgFuki9spYAP4jxfGWKTei7blhrs1S8
 gTWi6x2sXFQpQaMyLlaRS9OB128ckIyhbBmhi71YXa64F3xP8jIRfqGEyoXKGMa1k7Wm2l
 JR5+zA5ESXpJjZkq/jyCstr/rfZD1L0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-U56eDMurPgqN2r5JcAavLQ-1; Wed,
 04 Jun 2025 13:56:24 -0400
X-MC-Unique: U56eDMurPgqN2r5JcAavLQ-1
X-Mimecast-MFC-AGG-ID: U56eDMurPgqN2r5JcAavLQ_1749059783
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B68D19560AB; Wed,  4 Jun 2025 17:56:23 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.34.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4470218003FD; Wed,  4 Jun 2025 17:56:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 02/24] block: move drain outside of read-locked
 bdrv_reopen_queue_child()
Date: Wed,  4 Jun 2025 19:55:51 +0200
Message-ID: <20250604175613.344113-3-kwolf@redhat.com>
In-Reply-To: <20250604175613.344113-1-kwolf@redhat.com>
References: <20250604175613.344113-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.

More granular draining is not trivially possible, because
bdrv_reopen_queue_child() can recursively call itself.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250530151125.955508-3-f.ebner@proxmox.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index a5399888ba..3065d5c91e 100644
--- a/block.c
+++ b/block.c
@@ -4358,7 +4358,7 @@ bdrv_recurse_has_child(BlockDriverState *bs, BlockDriverState *child)
  * returns a pointer to bs_queue, which is either the newly allocated
  * bs_queue, or the existing bs_queue being used.
  *
- * bs is drained here and undrained by bdrv_reopen_queue_free().
+ * bs must be drained.
  */
 static BlockReopenQueue * GRAPH_RDLOCK
 bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
@@ -4377,12 +4377,7 @@ bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
 
     GLOBAL_STATE_CODE();
 
-    /*
-     * Strictly speaking, draining is illegal under GRAPH_RDLOCK. We know that
-     * we've been called with bdrv_graph_rdlock_main_loop(), though, so it's ok
-     * in practice.
-     */
-    bdrv_drained_begin(bs);
+    assert(bs->quiesce_counter > 0);
 
     if (bs_queue == NULL) {
         bs_queue = g_new0(BlockReopenQueue, 1);
@@ -4522,6 +4517,12 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
                                     QDict *options, bool keep_old_opts)
 {
     GLOBAL_STATE_CODE();
+
+    if (bs_queue == NULL) {
+        /* Paired with bdrv_drain_all_end() in bdrv_reopen_queue_free(). */
+        bdrv_drain_all_begin();
+    }
+
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     return bdrv_reopen_queue_child(bs_queue, bs, options, NULL, 0, false,
@@ -4534,12 +4535,14 @@ void bdrv_reopen_queue_free(BlockReopenQueue *bs_queue)
     if (bs_queue) {
         BlockReopenQueueEntry *bs_entry, *next;
         QTAILQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
-            bdrv_drained_end(bs_entry->state.bs);
             qobject_unref(bs_entry->state.explicit_options);
             qobject_unref(bs_entry->state.options);
             g_free(bs_entry);
         }
         g_free(bs_queue);
+
+        /* Paired with bdrv_drain_all_begin() in bdrv_reopen_queue(). */
+        bdrv_drain_all_end();
     }
 }
 
-- 
2.49.0


