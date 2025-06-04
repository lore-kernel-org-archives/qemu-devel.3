Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5294C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 18:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMsMK-0002Qb-8n; Wed, 04 Jun 2025 13:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsM9-0002HS-JI
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsM3-0000Qp-VA
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749059794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hpBOemLw89s1YEvMfiiEo6gzsUEg6nnjFmlfZjhCRuU=;
 b=QrqVKYIPUeYAPeGQSugV9+iWmZPsBIwuzmKGsWNMw/SnlLSVP4lPORA2njnz2OEqhEq0dr
 1Cckg/1aooLuU8bNm/6z45XSPAuNi/UAKHkROAGNlyID1pYs5S6EpekW2do37qpSJshWcl
 8U9HzFGqORaOiZ/L4lq0jSja5WET1wI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-1fHvybZyPCKGmXjeaeyI1g-1; Wed,
 04 Jun 2025 13:56:31 -0400
X-MC-Unique: 1fHvybZyPCKGmXjeaeyI1g-1
X-Mimecast-MFC-AGG-ID: 1fHvybZyPCKGmXjeaeyI1g_1749059790
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A84B91800357; Wed,  4 Jun 2025 17:56:30 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.34.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2FE6218003FD; Wed,  4 Jun 2025 17:56:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 06/24] block: mark change_aio_ctx() callback and instances as
 GRAPH_RDLOCK(_PTR)
Date: Wed,  4 Jun 2025 19:55:55 +0200
Message-ID: <20250604175613.344113-7-kwolf@redhat.com>
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

This is a small step in preparation to mark bdrv_drained_begin() as
GRAPH_UNLOCKED. More concretely, it is in preparation to move the
drain out of bdrv_change_aio_context() and marking that function as
GRAPH_RDLOCK.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250530151125.955508-7-f.ebner@proxmox.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h | 6 +++---
 block.c                          | 7 ++++---
 block/block-backend.c            | 6 +++---
 blockjob.c                       | 6 +++---
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 2982dd3118..37466c7841 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -983,9 +983,9 @@ struct BdrvChildClass {
                            bool backing_mask_protocol,
                            Error **errp);
 
-    bool (*change_aio_ctx)(BdrvChild *child, AioContext *ctx,
-                           GHashTable *visited, Transaction *tran,
-                           Error **errp);
+    bool GRAPH_RDLOCK_PTR (*change_aio_ctx)(BdrvChild *child, AioContext *ctx,
+                                            GHashTable *visited,
+                                            Transaction *tran, Error **errp);
 
     /*
      * I/O API functions. These functions are thread-safe.
diff --git a/block.c b/block.c
index 7207978e53..01144c895e 100644
--- a/block.c
+++ b/block.c
@@ -1226,9 +1226,10 @@ static int bdrv_child_cb_inactivate(BdrvChild *child)
     return 0;
 }
 
-static bool bdrv_child_cb_change_aio_ctx(BdrvChild *child, AioContext *ctx,
-                                         GHashTable *visited, Transaction *tran,
-                                         Error **errp)
+static bool GRAPH_RDLOCK
+bdrv_child_cb_change_aio_ctx(BdrvChild *child, AioContext *ctx,
+                             GHashTable *visited, Transaction *tran,
+                             Error **errp)
 {
     BlockDriverState *bs = child->opaque;
     return bdrv_change_aio_context(bs, ctx, visited, tran, errp);
diff --git a/block/block-backend.c b/block/block-backend.c
index a402db13f2..6a6949edeb 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -136,9 +136,9 @@ static void blk_root_drained_end(BdrvChild *child);
 static void blk_root_change_media(BdrvChild *child, bool load);
 static void blk_root_resize(BdrvChild *child);
 
-static bool blk_root_change_aio_ctx(BdrvChild *child, AioContext *ctx,
-                                    GHashTable *visited, Transaction *tran,
-                                    Error **errp);
+static bool GRAPH_RDLOCK
+blk_root_change_aio_ctx(BdrvChild *child, AioContext *ctx, GHashTable *visited,
+                        Transaction *tran, Error **errp);
 
 static char *blk_root_get_parent_desc(BdrvChild *child)
 {
diff --git a/blockjob.c b/blockjob.c
index 32007f31a9..34185d7715 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -144,9 +144,9 @@ static TransactionActionDrv change_child_job_context = {
     .clean = g_free,
 };
 
-static bool child_job_change_aio_ctx(BdrvChild *c, AioContext *ctx,
-                                     GHashTable *visited, Transaction *tran,
-                                     Error **errp)
+static bool GRAPH_RDLOCK
+child_job_change_aio_ctx(BdrvChild *c, AioContext *ctx, GHashTable *visited,
+                         Transaction *tran, Error **errp)
 {
     BlockJob *job = c->opaque;
     BdrvStateChildJobContext *s;
-- 
2.49.0


