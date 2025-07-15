Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1038C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublRY-0007L4-MY; Tue, 15 Jul 2025 15:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxB-00048I-Iq
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkx9-0001On-Jb
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rEObCe5SI4WFqr30JFWEG6IuI2pn5Gii5i/TnHZnrbo=;
 b=idsRIJjOH8S4xL4/SO3fO8qUz1aG5Mqrt9tRxFTClw2MOjsC4gsvK6rPU1iTPoamPrEhzX
 dwzg/3D4MKMDu38/ZjP9+dKoCOz5WU5g9TEq3w70lXkTj/XPoTUVrcrZt++u3nhMwlcDQv
 5j5v4hnbLDRNx8Uh6nKCmmjyavhiQeg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-b-OykTV4Pu6dBMbrr8-RaQ-1; Tue,
 15 Jul 2025 15:04:32 -0400
X-MC-Unique: b-OykTV4Pu6dBMbrr8-RaQ-1
X-Mimecast-MFC-AGG-ID: b-OykTV4Pu6dBMbrr8-RaQ_1752606270
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4C51195608E; Tue, 15 Jul 2025 19:04:30 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 254D2197702B; Tue, 15 Jul 2025 19:04:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 25/57] block: mark bdrv_open_child_common() and its callers
 GRAPH_UNLOCKED
Date: Tue, 15 Jul 2025 21:02:58 +0200
Message-ID: <20250715190330.378764-26-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The function bdrv_open_child_common() calls
bdrv_graph_wrlock_drained(), which must be called with the graph
unlocked. Mark it and its two callers bdrv_open_file_child() and
bdrv_open_child() as GRAPH_UNLOCKED. This requires temporarily
unlocking in vmdk_parse_extents() and making the locked section
shorter in vmdk_open().

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-48-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h |  9 +++++----
 block.c                            | 13 ++++++-------
 block/vmdk.c                       |  6 ++++--
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index e7c9acd2ba..62da83c616 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -81,7 +81,7 @@ bdrv_insert_node(BlockDriverState *bs, QDict *node_options, int flags,
                  Error **errp);
 int bdrv_drop_filter(BlockDriverState *bs, Error **errp);
 
-BdrvChild * no_coroutine_fn
+BdrvChild * no_coroutine_fn GRAPH_UNLOCKED
 bdrv_open_child(const char *filename, QDict *options, const char *bdref_key,
                 BlockDriverState *parent, const BdrvChildClass *child_class,
                 BdrvChildRole child_role, bool allow_none, Error **errp);
@@ -91,9 +91,10 @@ bdrv_co_open_child(const char *filename, QDict *options, const char *bdref_key,
                 BlockDriverState *parent, const BdrvChildClass *child_class,
                 BdrvChildRole child_role, bool allow_none, Error **errp);
 
-int bdrv_open_file_child(const char *filename,
-                         QDict *options, const char *bdref_key,
-                         BlockDriverState *parent, Error **errp);
+int GRAPH_UNLOCKED
+bdrv_open_file_child(const char *filename, QDict *options,
+                     const char *bdref_key, BlockDriverState *parent,
+                     Error **errp);
 
 BlockDriverState * no_coroutine_fn
 bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp);
diff --git a/block.c b/block.c
index 8d3dd5a8e3..8848e9a7ed 100644
--- a/block.c
+++ b/block.c
@@ -3766,13 +3766,12 @@ done:
     return bs;
 }
 
-static BdrvChild *bdrv_open_child_common(const char *filename,
-                                         QDict *options, const char *bdref_key,
-                                         BlockDriverState *parent,
-                                         const BdrvChildClass *child_class,
-                                         BdrvChildRole child_role,
-                                         bool allow_none, bool parse_filename,
-                                         Error **errp)
+static BdrvChild * GRAPH_UNLOCKED
+bdrv_open_child_common(const char *filename, QDict *options,
+                       const char *bdref_key, BlockDriverState *parent,
+                       const BdrvChildClass *child_class,
+                       BdrvChildRole child_role, bool allow_none,
+                       bool parse_filename, Error **errp)
 {
     BlockDriverState *bs;
     BdrvChild *child;
diff --git a/block/vmdk.c b/block/vmdk.c
index 04986c8d55..7b98debc2b 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1229,9 +1229,11 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
             extent_role |= BDRV_CHILD_METADATA;
         }
 
+        bdrv_graph_rdunlock_main_loop();
         extent_file = bdrv_open_child(extent_path, options, extent_opt_prefix,
                                       bs, &child_of_bds, extent_role, false,
                                       &local_err);
+        bdrv_graph_rdlock_main_loop();
         g_free(extent_path);
         if (!extent_file) {
             error_propagate(errp, local_err);
@@ -1352,13 +1354,13 @@ static int vmdk_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVVmdkState *s = bs->opaque;
     uint32_t magic;
 
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
-
     ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
     if (ret < 0) {
         return ret;
     }
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     buf = vmdk_read_desc(bs->file, 0, errp);
     if (!buf) {
         return -EINVAL;
-- 
2.50.1


