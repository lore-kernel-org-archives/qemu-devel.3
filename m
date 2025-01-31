Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9A4C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 09:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdngN-00045x-SA; Fri, 31 Jan 2025 04:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tdngL-000401-RU
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:51:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tdngJ-0002nG-Uk
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738317082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cP1kplkz6TyaABI+9aCePeeE4QsDrwjvH+C2S/FBxCA=;
 b=Xqd1Qwkb3hrdb575qMf7wep551v+xrd9pZXcoCNts1pc5iA2b11JxwXChHcALVO6xMfIqW
 Ez5i+fltCzuDZm3/2i97AqjXeEMhY73Q9OYl0fwmxBlhRGqI1kqm7st+oR5zXrv2r2STw+
 SzahPOThOmfzf6XGzszuWTky4W7zha8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-3qgcPhubMliFCxvlslLaQg-1; Fri,
 31 Jan 2025 04:51:20 -0500
X-MC-Unique: 3qgcPhubMliFCxvlslLaQg-1
X-Mimecast-MFC-AGG-ID: 3qgcPhubMliFCxvlslLaQg
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74AA719560AF; Fri, 31 Jan 2025 09:51:19 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E27E61800975; Fri, 31 Jan 2025 09:51:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org
Subject: [PATCH v2 11/15] block/export: Add option to allow export of inactive
 nodes
Date: Fri, 31 Jan 2025 10:50:47 +0100
Message-ID: <20250131095051.49708-2-kwolf@redhat.com>
In-Reply-To: <20250130171240.286878-1-kwolf@redhat.com>
References: <20250130171240.286878-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Add an option in BlockExportOptions to allow creating an export on an
inactive node without activating the node. This mode needs to be
explicitly supported by the export type (so that it doesn't perform any
operations that are forbidden for inactive nodes), so this patch alone
doesn't allow this option to be successfully used yet.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-export.json             | 10 +++++++++-
 include/block/block-global-state.h |  3 +++
 include/block/export.h             |  3 +++
 block.c                            |  4 ++++
 block/export/export.c              | 31 ++++++++++++++++++++----------
 5 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index ce33fe378d..117b05d13c 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -372,6 +372,13 @@
 #     cannot be moved to the iothread.  The default is false.
 #     (since: 5.2)
 #
+# @allow-inactive: If true, the export allows the exported node to be inactive.
+#     If it is created for an inactive block node, the node remains inactive. If
+#     the export type doesn't support running on an inactive node, an error is
+#     returned. If false, inactive block nodes are automatically activated before
+#     creating the export and trying to inactivate them later fails.
+#     (since: 10.0; default: false)
+#
 # Since: 4.2
 ##
 { 'union': 'BlockExportOptions',
@@ -381,7 +388,8 @@
             '*iothread': 'str',
             'node-name': 'str',
             '*writable': 'bool',
-            '*writethrough': 'bool' },
+            '*writethrough': 'bool',
+            '*allow-inactive': 'bool' },
   'discriminator': 'type',
   'data': {
       'nbd': 'BlockExportOptionsNbd',
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 22ec21117d..9be34b3c99 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -175,6 +175,9 @@ BlockDriverState * GRAPH_RDLOCK
 check_to_replace_node(BlockDriverState *parent_bs, const char *node_name,
                       Error **errp);
 
+
+bool GRAPH_RDLOCK bdrv_is_inactive(BlockDriverState *bs);
+
 int no_coroutine_fn GRAPH_RDLOCK
 bdrv_activate(BlockDriverState *bs, Error **errp);
 
diff --git a/include/block/export.h b/include/block/export.h
index f2fe0f8078..4bd9531d4d 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -29,6 +29,9 @@ typedef struct BlockExportDriver {
      */
     size_t instance_size;
 
+    /* True if the export type supports running on an inactive node */
+    bool supports_inactive;
+
     /* Creates and starts a new block export */
     int (*create)(BlockExport *, BlockExportOptions *, Error **);
 
diff --git a/block.c b/block.c
index 61e131e71f..7eeb8d076e 100644
--- a/block.c
+++ b/block.c
@@ -6845,6 +6845,10 @@ void bdrv_init_with_whitelist(void)
     bdrv_init();
 }
 
+bool bdrv_is_inactive(BlockDriverState *bs) {
+    return bs->open_flags & BDRV_O_INACTIVE;
+}
+
 int bdrv_activate(BlockDriverState *bs, Error **errp)
 {
     BdrvChild *child, *parent;
diff --git a/block/export/export.c b/block/export/export.c
index bac42b8608..f3bbf11070 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -75,6 +75,7 @@ static const BlockExportDriver *blk_exp_find_driver(BlockExportType type)
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
 {
     bool fixed_iothread = export->has_fixed_iothread && export->fixed_iothread;
+    bool allow_inactive = export->has_allow_inactive && export->allow_inactive;
     const BlockExportDriver *drv;
     BlockExport *exp = NULL;
     BlockDriverState *bs;
@@ -138,17 +139,24 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
         }
     }
 
-    /*
-     * Block exports are used for non-shared storage migration. Make sure
-     * that BDRV_O_INACTIVE is cleared and the image is ready for write
-     * access since the export could be available before migration handover.
-     * ctx was acquired in the caller.
-     */
     bdrv_graph_rdlock_main_loop();
-    ret = bdrv_activate(bs, errp);
-    if (ret < 0) {
-        bdrv_graph_rdunlock_main_loop();
-        goto fail;
+    if (allow_inactive) {
+        if (!drv->supports_inactive) {
+            error_setg(errp, "Export type does not support inactive exports");
+            bdrv_graph_rdunlock_main_loop();
+            goto fail;
+        }
+    } else {
+        /*
+         * Block exports are used for non-shared storage migration. Make sure
+         * that BDRV_O_INACTIVE is cleared and the image is ready for write
+         * access since the export could be available before migration handover.
+         */
+        ret = bdrv_activate(bs, errp);
+        if (ret < 0) {
+            bdrv_graph_rdunlock_main_loop();
+            goto fail;
+        }
     }
     bdrv_graph_rdunlock_main_loop();
 
@@ -162,6 +170,9 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     if (!fixed_iothread) {
         blk_set_allow_aio_context_change(blk, true);
     }
+    if (allow_inactive) {
+        blk_set_force_allow_inactivate(blk);
+    }
 
     ret = blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
-- 
2.48.1


