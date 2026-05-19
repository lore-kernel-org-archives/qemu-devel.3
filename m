Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739BFCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNrj-0008DO-BR; Tue, 19 May 2026 13:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNrO-00088r-Dh
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNrK-0004KV-5H
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779210237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bLQ5ZwtzDEpEqGCjen6mnUTp57q/yeGQzUBReZKdzMs=;
 b=Pp1aJ2S4WTRy5GacNtfelN1klTO/RBxo3UOqZRnyzQCvPRHKXKvda9ObQ+1+VsZ9MQgQ3A
 egFxQJGiR4xmjfrvqxOCkEwtY5Wt3X9knYUhbSFWZI2zrMiiAbncfrYQXckAos2zrsSxVm
 t3nlc/bzJkd4+p59BoYs9ELMS+yuC+Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-H-lDc5n0O7KpFEmWkVJ0wg-1; Tue,
 19 May 2026 13:03:54 -0400
X-MC-Unique: H-lDc5n0O7KpFEmWkVJ0wg-1
X-Mimecast-MFC-AGG-ID: H-lDc5n0O7KpFEmWkVJ0wg_1779210233
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4344619560AD; Tue, 19 May 2026 17:03:53 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.49.113])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D40991681; Tue, 19 May 2026 17:03:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 13/18] commit: Drain nodes across all of bdrv_commit()
Date: Tue, 19 May 2026 19:03:12 +0200
Message-ID: <20260519170317.345032-14-kwolf@redhat.com>
In-Reply-To: <20260519170317.345032-1-kwolf@redhat.com>
References: <20260519170317.345032-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The whole implementation of bdrv_commit() is only correct if no new
writes come in while it's running: It has only a single loop checking
the allocation status for each block and finally calls bdrv_make_empty()
without checking if that throws away any new changes.

We already have to drain while taking the graph write lock. Just extend
the drained section to all of bdrv_commit() to make sure that we don't
get any inconsistencies.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260427170520.101242-2-kwolf@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Tested-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/commit.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 0d9e1a16d7a..c5e3ef03a21 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -518,6 +518,7 @@ int bdrv_commit(BlockDriverState *bs)
     if (!drv)
         return -ENOMEDIUM;
 
+    bdrv_drain_all_begin();
     bdrv_graph_rdlock_main_loop();
 
     backing_file_bs = bdrv_cow_bs(bs);
@@ -549,6 +550,10 @@ int bdrv_commit(BlockDriverState *bs)
                   BLK_PERM_ALL);
     backing = blk_new(ctx, BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
 
+    /* We drained all nodes, but still make requests through BlockBackends */
+    blk_set_disable_request_queuing(src, true);
+    blk_set_disable_request_queuing(backing, true);
+
     ret = blk_insert_bs(src, bs, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
@@ -565,7 +570,7 @@ int bdrv_commit(BlockDriverState *bs)
 
     bdrv_graph_rdunlock_main_loop();
 
-    bdrv_graph_wrlock_drained();
+    bdrv_graph_wrlock();
     bdrv_set_backing_hd(commit_top_bs, backing_file_bs, &error_abort);
     bdrv_set_backing_hd(bs, commit_top_bs, &error_abort);
     bdrv_graph_wrunlock();
@@ -647,7 +652,7 @@ ro_cleanup:
     blk_unref(backing);
 
     bdrv_graph_rdunlock_main_loop();
-    bdrv_graph_wrlock_drained();
+    bdrv_graph_wrlock();
     if (bdrv_cow_bs(bs) != backing_file_bs) {
         bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
     }
@@ -663,6 +668,7 @@ ro_cleanup:
 
 out:
     bdrv_graph_rdunlock_main_loop();
+    bdrv_drain_all_end();
 
     return ret;
 }
-- 
2.54.0


