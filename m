Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3786DC5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1Pv-0005Pf-Pi; Fri, 30 May 2025 11:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1Pu-0005Oc-2R; Fri, 30 May 2025 11:13:06 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1Ps-0002Rd-Eu; Fri, 30 May 2025 11:13:05 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A546744983;
 Fri, 30 May 2025 17:11:49 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 47/48] block: mark bdrv_open_child_common() and its callers
 GRAPH_UNLOCKED
Date: Fri, 30 May 2025 17:11:24 +0200
Message-Id: <20250530151125.955508-48-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530151125.955508-1-f.ebner@proxmox.com>
References: <20250530151125.955508-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The function bdrv_open_child_common() calls
bdrv_graph_wrlock_drained(), which must be called with the graph
unlocked. Mark it and its two callers bdrv_open_file_child() and
bdrv_open_child() as GRAPH_UNLOCKED. This requires temporarily
unlocking in vmdk_parse_extents() and making the locked section
shorter in vmdk_open().

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block.c                            | 13 ++++++-------
 block/vmdk.c                       |  6 ++++--
 include/block/block-global-state.h |  9 +++++----
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/block.c b/block.c
index a4b79d70db..132faf10f0 100644
--- a/block.c
+++ b/block.c
@@ -3767,13 +3767,12 @@ done:
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
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index fb3bb6f707..49e54fb4d3 100644
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
-- 
2.39.5



