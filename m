Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4B9CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 18:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6CXH-0005yA-DI; Tue, 07 Oct 2025 14:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6CWc-0005i4-U0
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 14:35:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6CWZ-0002dn-8f
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 14:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759862097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S5jrEUwy0EJFOIS/WkiXiOdV2GbJ0vVIS71974BPMO4=;
 b=OQKDe+fES4ETQtfvfQjOJ37t3Isc5KPcqtGVwPlYla9COYFXWFWpzeZho7x5qtzvpDNA9O
 0Gagq8Nkzxzs+tU5v0K2rstTMSzayQdqn1RQpT2Wyo4VX1Jn8ONljBoeExV9XJcHIf3F+C
 Odm9OKC9grPmC1l+FEyMW01BLZ++QEk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-cGa3z8MZMO6wSBDr6FUhlQ-1; Tue,
 07 Oct 2025 14:34:54 -0400
X-MC-Unique: cGa3z8MZMO6wSBDr6FUhlQ-1
X-Mimecast-MFC-AGG-ID: cGa3z8MZMO6wSBDr6FUhlQ_1759862093
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38A3E19560AF; Tue,  7 Oct 2025 18:34:53 +0000 (UTC)
Received: from localhost (unknown [10.2.16.87])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 93D811800446; Tue,  7 Oct 2025 18:34:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 1/5] block: add BdrvChildClass->propagate_attach/detach()
 callbacks
Date: Tue,  7 Oct 2025 14:34:43 -0400
Message-ID: <20251007183447.93120-2-stefanha@redhat.com>
In-Reply-To: <20251007183447.93120-1-stefanha@redhat.com>
References: <20251007183447.93120-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Eric Blake <eblake@redhat.com>
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


