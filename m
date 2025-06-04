Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10293C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 17:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMsMP-0002Vg-5R; Wed, 04 Jun 2025 13:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsM9-0002HT-J6
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsM3-0000Rn-U7
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749059801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FnJpx3hRFEtB4K7jN5OTsYYruyCSn2oaUnCHJa+wlI=;
 b=QmRWXJlyH7fI64jvZ/ub71uD1prc9QE624bJYfUGau1VzbW3BTjc8maEU73n3hrPTCDCm/
 4kSYyTisgoY378r1D1p/WkGfFmQ9FEIGpwPIVP/WV3+FuH/eXZAJ+0XfY37CKyo9ajf6W3
 Nj8HDYGnRZ39EgWm3Y/Y81N23NWLhDI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-h6fCX4CpO-ONcz60HiLEsg-1; Wed,
 04 Jun 2025 13:56:40 -0400
X-MC-Unique: h6fCX4CpO-ONcz60HiLEsg-1
X-Mimecast-MFC-AGG-ID: h6fCX4CpO-ONcz60HiLEsg_1749059799
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F6D719560B7; Wed,  4 Jun 2025 17:56:39 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.34.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38A9218002A5; Wed,  4 Jun 2025 17:56:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 11/24] block: move drain outside of
 bdrv_set_backing_hd_drained()
Date: Wed,  4 Jun 2025 19:56:00 +0200
Message-ID: <20250604175613.344113-12-kwolf@redhat.com>
In-Reply-To: <20250604175613.344113-1-kwolf@redhat.com>
References: <20250604175613.344113-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is part of resolving the deadlock mentioned in commit "block:
move draining out of bdrv_change_aio_context() and mark GRAPH_RDLOCK".

The function bdrv_set_backing_hd_drained() holds the graph lock, so it
is not allowed to drain. It is called by:
1. bdrv_set_backing_hd(), where a drained section is introduced,
   replacing the previously present bs-specific drains.
2. stream_prepare(), where a drained section is introduced replacing
   the previously present bs-specific drains.

The drain_bs variable in bdrv_set_backing_hd_drained() is now
superfluous and thus dropped.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-12-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c        | 16 +++-------------
 block/stream.c |  6 ++----
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/block.c b/block.c
index 46eb2fe449..e53a88e1b6 100644
--- a/block.c
+++ b/block.c
@@ -3562,8 +3562,7 @@ out:
  * Both @bs and @backing_hd can move to a different AioContext in this
  * function.
  *
- * If a backing child is already present (i.e. we're detaching a node), that
- * child node must be drained.
+ * All block nodes must be drained.
  */
 int bdrv_set_backing_hd_drained(BlockDriverState *bs,
                                 BlockDriverState *backing_hd,
@@ -3578,7 +3577,6 @@ int bdrv_set_backing_hd_drained(BlockDriverState *bs,
         assert(bs->backing->bs->quiesce_counter > 0);
     }
 
-    bdrv_drain_all_begin();
     ret = bdrv_set_file_or_backing_noperm(bs, backing_hd, true, tran, errp);
     if (ret < 0) {
         goto out;
@@ -3587,28 +3585,20 @@ int bdrv_set_backing_hd_drained(BlockDriverState *bs,
     ret = bdrv_refresh_perms(bs, tran, errp);
 out:
     tran_finalize(tran, ret);
-    bdrv_drain_all_end();
     return ret;
 }
 
 int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
                         Error **errp)
 {
-    BlockDriverState *drain_bs;
     int ret;
     GLOBAL_STATE_CODE();
 
-    bdrv_graph_rdlock_main_loop();
-    drain_bs = bs->backing ? bs->backing->bs : bs;
-    bdrv_graph_rdunlock_main_loop();
-
-    bdrv_ref(drain_bs);
-    bdrv_drained_begin(drain_bs);
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     ret = bdrv_set_backing_hd_drained(bs, backing_hd, errp);
     bdrv_graph_wrunlock();
-    bdrv_drained_end(drain_bs);
-    bdrv_unref(drain_bs);
+    bdrv_drain_all_end();
 
     return ret;
 }
diff --git a/block/stream.c b/block/stream.c
index 999d9e56d4..6ba49cffd3 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -80,11 +80,10 @@ static int stream_prepare(Job *job)
      * may end up working with the wrong base node (or it might even have gone
      * away by the time we want to use it).
      */
-    bdrv_drained_begin(unfiltered_bs);
     if (unfiltered_bs_cow) {
         bdrv_ref(unfiltered_bs_cow);
-        bdrv_drained_begin(unfiltered_bs_cow);
     }
+    bdrv_drain_all_begin();
 
     bdrv_graph_rdlock_main_loop();
     base = bdrv_filter_or_cow_bs(s->above_base);
@@ -123,11 +122,10 @@ static int stream_prepare(Job *job)
     }
 
 out:
+    bdrv_drain_all_end();
     if (unfiltered_bs_cow) {
-        bdrv_drained_end(unfiltered_bs_cow);
         bdrv_unref(unfiltered_bs_cow);
     }
-    bdrv_drained_end(unfiltered_bs);
     return ret;
 }
 
-- 
2.49.0


