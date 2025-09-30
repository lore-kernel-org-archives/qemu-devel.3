Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99A8CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 20:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3hEr-0000Pj-IJ; Tue, 30 Sep 2025 16:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3hEq-0000PU-Ds
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:46:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3hEf-0004Am-C1
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759265163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YEKV8SOceCi8315UWrvm8kMs40DvpLQA0Xl6Ue4LHEg=;
 b=bzz99DPugpUyrPNMhbYytMRe3x516DUtq5uHmHrA9amQ6/gzzNilx2M1rBE8wvKOXLHcC+
 ZZYZ/U/s2NSKu8bU0nOgx2+cSamVETny+P8PjPikKu5tp8LqAKUmJPPNkRFW56SEmOCqgV
 K1UHd5FrLP0CMoi7pmHfCZ48SmnQi+s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-GQX3OFUJOZeDQ7q4VSa3Aw-1; Tue,
 30 Sep 2025 16:46:02 -0400
X-MC-Unique: GQX3OFUJOZeDQ7q4VSa3Aw-1
X-Mimecast-MFC-AGG-ID: GQX3OFUJOZeDQ7q4VSa3Aw_1759265161
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CAD6195609E; Tue, 30 Sep 2025 20:46:01 +0000 (UTC)
Received: from localhost (unknown [10.2.16.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E31061800282; Tue, 30 Sep 2025 20:45:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, <qemu-block@nongnu.org>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/4] block: add BdrvChildClass->propagate_attach/detach()
 callbacks
Date: Tue, 30 Sep 2025 16:45:52 -0400
Message-ID: <20250930204555.162133-2-stefanha@redhat.com>
In-Reply-To: <20250930204555.162133-1-stefanha@redhat.com>
References: <20250930204555.162133-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

bdrv_replace_child_noperm() is the heart of block graph changes. It is
called when a node is inserted, removed, or replaced. These changes
happen without notifying parents in the graph, so it is currently not
possible to monitor changes.

Add BdrvChildClass callbacks to propagate attach/detach operations to
the roots of the graph. The next commit will introduce a BlockBackend
API for monitoring changes using this mechanism.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block_int-common.h | 11 +++++++
 block.c                          | 56 +++++++++++++++++++++++++-------
 2 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 034c0634c8..0368a3191c 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -963,6 +963,17 @@ struct BdrvChildClass {
     void GRAPH_RDLOCK_PTR (*activate)(BdrvChild *child, Error **errp);
     int GRAPH_RDLOCK_PTR (*inactivate)(BdrvChild *child);
 
+    /*
+     * Optional callbacks when a descendant (child, grandchild, etc) attaches
+     * or detaches a BlockDriverState. Allows monitoring changes to the graph.
+     *
+     * Called after ->attach() and before ->detach().
+     */
+    void GRAPH_WRLOCK_PTR (*propagate_attach)(BdrvChild *self,
+                                              BdrvChild *descendant);
+    void GRAPH_WRLOCK_PTR (*propagate_detach)(BdrvChild *self,
+                                              BdrvChild *descendant);
+
     void GRAPH_WRLOCK_PTR (*attach)(BdrvChild *child);
     void GRAPH_WRLOCK_PTR (*detach)(BdrvChild *child);
 
diff --git a/block.c b/block.c
index 8848e9a7ed..e1480dda04 100644
--- a/block.c
+++ b/block.c
@@ -1497,6 +1497,32 @@ static void GRAPH_WRLOCK bdrv_child_cb_detach(BdrvChild *child)
     }
 }
 
+static void GRAPH_WRLOCK
+bdrv_child_cb_propagate_attach(BdrvChild *self, BdrvChild *descendant)
+{
+    BlockDriverState *bs = self->opaque;
+    BdrvChild *c;
+
+    QLIST_FOREACH(c, &bs->parents, next_parent) {
+        if (c->klass->propagate_attach) {
+            c->klass->propagate_attach(c, descendant);
+        }
+    }
+}
+
+static void GRAPH_WRLOCK
+bdrv_child_cb_propagate_detach(BdrvChild *self, BdrvChild *descendant)
+{
+    BlockDriverState *bs = self->opaque;
+    BdrvChild *c;
+
+    QLIST_FOREACH(c, &bs->parents, next_parent) {
+        if (c->klass->propagate_detach) {
+            c->klass->propagate_detach(c, descendant);
+        }
+    }
+}
+
 static int bdrv_child_cb_update_filename(BdrvChild *c, BlockDriverState *base,
                                          const char *filename,
                                          bool backing_mask_protocol,
@@ -1519,17 +1545,19 @@ AioContext *child_of_bds_get_parent_aio_context(BdrvChild *c)
 }
 
 const BdrvChildClass child_of_bds = {
-    .parent_is_bds   = true,
-    .get_parent_desc = bdrv_child_get_parent_desc,
-    .inherit_options = bdrv_inherited_options,
-    .drained_begin   = bdrv_child_cb_drained_begin,
-    .drained_poll    = bdrv_child_cb_drained_poll,
-    .drained_end     = bdrv_child_cb_drained_end,
-    .attach          = bdrv_child_cb_attach,
-    .detach          = bdrv_child_cb_detach,
-    .inactivate      = bdrv_child_cb_inactivate,
-    .change_aio_ctx  = bdrv_child_cb_change_aio_ctx,
-    .update_filename = bdrv_child_cb_update_filename,
+    .parent_is_bds          = true,
+    .get_parent_desc        = bdrv_child_get_parent_desc,
+    .inherit_options        = bdrv_inherited_options,
+    .drained_begin          = bdrv_child_cb_drained_begin,
+    .drained_poll           = bdrv_child_cb_drained_poll,
+    .drained_end            = bdrv_child_cb_drained_end,
+    .attach                 = bdrv_child_cb_attach,
+    .detach                 = bdrv_child_cb_detach,
+    .propagate_attach       = bdrv_child_cb_propagate_attach,
+    .propagate_detach       = bdrv_child_cb_propagate_detach,
+    .inactivate             = bdrv_child_cb_inactivate,
+    .change_aio_ctx         = bdrv_child_cb_change_aio_ctx,
+    .update_filename        = bdrv_child_cb_update_filename,
     .get_parent_aio_context = child_of_bds_get_parent_aio_context,
 };
 
@@ -2967,6 +2995,9 @@ bdrv_replace_child_noperm(BdrvChild *child, BlockDriverState *new_bs)
     }
 
     if (old_bs) {
+        if (child->klass->propagate_detach) {
+            child->klass->propagate_detach(child, child);
+        }
         if (child->klass->detach) {
             child->klass->detach(child);
         }
@@ -2980,6 +3011,9 @@ bdrv_replace_child_noperm(BdrvChild *child, BlockDriverState *new_bs)
         if (child->klass->attach) {
             child->klass->attach(child);
         }
+        if (child->klass->propagate_attach) {
+            child->klass->propagate_attach(child, child);
+        }
     }
 
     /*
-- 
2.51.0


