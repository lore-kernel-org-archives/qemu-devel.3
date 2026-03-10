Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290F1FD4F05
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzvX-0003ja-7Z; Tue, 10 Mar 2026 12:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvK-0003RF-QB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvI-0000wx-KV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773160026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wUgR0eHSb5Bru32ma7pgv8Axs3ei32fA63n6ycrzGsE=;
 b=fYR/R26pBL/jM3d7IZUXnihZKUoEuoLmYOFMA9ZQJHzAbQTtsNwQ6ANpyL60PgJMgYL7gX
 ZkcqXDUQUdrOg9+74CK5y8JQnfR4kgJ5lIKv+qqfN0EOhXjVhN+quJe+FUC2ARh3mYzcB3
 P5HRypH8Mp4K+cD/7taKxXDqraFG0Fo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-GQMmBT7EMxemIdtkivbjAw-1; Tue,
 10 Mar 2026 12:27:03 -0400
X-MC-Unique: GQMmBT7EMxemIdtkivbjAw-1
X-Mimecast-MFC-AGG-ID: GQMmBT7EMxemIdtkivbjAw_1773160023
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04D791955F44; Tue, 10 Mar 2026 16:27:03 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE7E019560A6; Tue, 10 Mar 2026 16:27:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 20/28] block/export: Add multi-threading interface
Date: Tue, 10 Mar 2026 17:26:14 +0100
Message-ID: <20260310162622.333137-21-kwolf@redhat.com>
In-Reply-To: <20260310162622.333137-1-kwolf@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

Make BlockExportType.iothread an alternate between a single-thread
variant 'str' and a multi-threading variant '[str]'.

In contrast to the single-thread setting, the multi-threading setting
will not change the BDS's context (and so is incompatible with the
fixed-iothread setting), but instead just pass a list to the export
driver, with which it can do whatever it wants.

Currently no export driver supports multi-threading, so they all return
an error when receiving such a list.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260309150856.26800-21-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-export.json               | 36 ++++++++++++++++++---
 include/block/export.h               | 12 +++++--
 block/export/export.c                | 48 +++++++++++++++++++++++++---
 block/export/fuse.c                  |  7 ++++
 block/export/vduse-blk.c             |  7 ++++
 block/export/vhost-user-blk-server.c |  8 +++++
 nbd/server.c                         |  6 ++++
 7 files changed, 113 insertions(+), 11 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 076954ef1ac..160cd2e3ca0 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -363,14 +363,16 @@
 #     to the export before completion is signalled.  (since: 5.2;
 #     default: false)
 #
-# @iothread: The name of the iothread object where the export will
-#     run.  The default is to use the thread currently associated with
-#     the block node.  (since: 5.2)
+# @iothread: The name(s) of one or more iothread object(s) where the
+#     export will run.  The default is to use the thread currently
+#     associated with the block node.  (since: 5.2; multi-threading
+#     since 10.1)
 #
 # @fixed-iothread: True prevents the block node from being moved to
 #     another thread while the export is active.  If true and
 #     @iothread is given, export creation fails if the block node
-#     cannot be moved to the iothread.  The default is false.
+#     cannot be moved to the iothread.  Must not be true when giving
+#     multiple iothreads for @iothread.  The default is false.
 #     (since: 5.2)
 #
 # @allow-inactive: If true, the export allows the exported node to be
@@ -387,7 +389,7 @@
   'base': { 'type': 'BlockExportType',
             'id': 'str',
             '*fixed-iothread': 'bool',
-            '*iothread': 'str',
+            '*iothread': 'BlockExportIothreads',
             'node-name': 'str',
             '*writable': 'bool',
             '*writethrough': 'bool',
@@ -403,6 +405,30 @@
                      'if': 'CONFIG_VDUSE_BLK_EXPORT' }
    } }
 
+##
+# @BlockExportIothreads:
+#
+# Specify a single or multiple I/O threads in which to run a block
+# export's I/O.
+#
+# @single: Run the export's I/O in the given single I/O thread.
+#
+# @multi: Use multi-threading across the given set of I/O threads,
+#     which must not be empty.  Note: Passing a single I/O thread via
+#     this variant is still treated as multi-threading, which is
+#     different from using the @single variant.  In particular, even
+#     if there only is a single I/O thread in the set, export types
+#     that do not support multi-threading will generally reject this
+#     variant, and BlockExportOptions.fixed-iothread is always
+#     incompatible with it.
+#
+# Since: 10.1
+##
+{ 'alternate': 'BlockExportIothreads',
+  'data': {
+      'single': 'str',
+      'multi': ['str'] } }
+
 ##
 # @block-export-add:
 #
diff --git a/include/block/export.h b/include/block/export.h
index 4bd9531d4d9..ca45da928c7 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -32,8 +32,16 @@ typedef struct BlockExportDriver {
     /* True if the export type supports running on an inactive node */
     bool supports_inactive;
 
-    /* Creates and starts a new block export */
-    int (*create)(BlockExport *, BlockExportOptions *, Error **);
+    /*
+     * Creates and starts a new block export.
+     *
+     * If the user passed a set of I/O threads for multi-threading, @multithread
+     * is a list of the @multithread_count corresponding contexts (freed by the
+     * caller).  Note that @exp->ctx has no relation to that list.
+     */
+    int (*create)(BlockExport *exp, BlockExportOptions *opts,
+                  AioContext *const *multithread, size_t multithread_count,
+                  Error **errp);
 
     /*
      * Frees a removed block export. This function is only called after all
diff --git a/block/export/export.c b/block/export/export.c
index f3bbf11070d..b733f269f3e 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -76,16 +76,26 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
 {
     bool fixed_iothread = export->has_fixed_iothread && export->fixed_iothread;
     bool allow_inactive = export->has_allow_inactive && export->allow_inactive;
+    bool multithread = export->iothread &&
+        export->iothread->type == QTYPE_QLIST;
     const BlockExportDriver *drv;
     BlockExport *exp = NULL;
     BlockDriverState *bs;
     BlockBackend *blk = NULL;
     AioContext *ctx;
+    AioContext **multithread_ctxs = NULL;
+    size_t multithread_count = 0;
     uint64_t perm;
     int ret;
 
     GLOBAL_STATE_CODE();
 
+    if (fixed_iothread && multithread) {
+        error_setg(errp,
+                   "Cannot use fixed-iothread for a multi-threaded export");
+        return NULL;
+    }
+
     if (!id_wellformed(export->id)) {
         error_setg(errp, "Invalid block export id");
         return NULL;
@@ -116,14 +126,16 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
 
     ctx = bdrv_get_aio_context(bs);
 
-    if (export->iothread) {
+    /* Move the BDS to the target I/O thread, if it is a single one */
+    if (export->iothread && !multithread) {
+        const char *iothread_id = export->iothread->u.single;
         IOThread *iothread;
         AioContext *new_ctx;
         Error **set_context_errp;
 
-        iothread = iothread_by_id(export->iothread);
+        iothread = iothread_by_id(iothread_id);
         if (!iothread) {
-            error_setg(errp, "iothread \"%s\" not found", export->iothread);
+            error_setg(errp, "iothread \"%s\" not found", iothread_id);
             goto fail;
         }
 
@@ -137,6 +149,32 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
         } else if (fixed_iothread) {
             goto fail;
         }
+    } else if (multithread) {
+        strList *iothread_list = export->iothread->u.multi;
+        size_t i;
+
+        multithread_count = 0;
+        for (strList *e = iothread_list; e; e = e->next) {
+            multithread_count++;
+        }
+
+        if (multithread_count == 0) {
+            error_setg(errp, "The set of I/O threads must not be empty");
+            return NULL;
+        }
+
+        multithread_ctxs = g_new(AioContext *, multithread_count);
+        i = 0;
+        for (strList *e = iothread_list; e; e = e->next) {
+            IOThread *iothread = iothread_by_id(e->value);
+
+            if (!iothread) {
+                error_setg(errp, "iothread \"%s\" not found", e->value);
+                goto fail;
+            }
+            multithread_ctxs[i++] = iothread_get_aio_context(iothread);
+        }
+        assert(i == multithread_count);
     }
 
     bdrv_graph_rdlock_main_loop();
@@ -195,7 +233,7 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
         .blk        = blk,
     };
 
-    ret = drv->create(exp, export, errp);
+    ret = drv->create(exp, export, multithread_ctxs, multithread_count, errp);
     if (ret < 0) {
         goto fail;
     }
@@ -203,6 +241,7 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     assert(exp->blk != NULL);
 
     QLIST_INSERT_HEAD(&block_exports, exp, next);
+    g_free(multithread_ctxs);
     return exp;
 
 fail:
@@ -214,6 +253,7 @@ fail:
         g_free(exp->id);
         g_free(exp);
     }
+    g_free(multithread_ctxs);
     return NULL;
 }
 
diff --git a/block/export/fuse.c b/block/export/fuse.c
index 7c072409d83..1c794118393 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -259,6 +259,8 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
 
 static int fuse_export_create(BlockExport *blk_exp,
                               BlockExportOptions *blk_exp_args,
+                              AioContext *const *multithread,
+                              size_t mt_count,
                               Error **errp)
 {
     ERRP_GUARD(); /* ensure clean-up even with error_fatal */
@@ -268,6 +270,11 @@ static int fuse_export_create(BlockExport *blk_exp,
 
     assert(blk_exp_args->type == BLOCK_EXPORT_TYPE_FUSE);
 
+    if (multithread) {
+        error_setg(errp, "FUSE export does not support multi-threading");
+        return -EINVAL;
+    }
+
     /* For growable and writable exports, take the RESIZE permission */
     if (args->growable || blk_exp_args->writable) {
         uint64_t blk_perm, blk_shared_perm;
diff --git a/block/export/vduse-blk.c b/block/export/vduse-blk.c
index 8af13b7f0bf..10dc673c566 100644
--- a/block/export/vduse-blk.c
+++ b/block/export/vduse-blk.c
@@ -267,6 +267,7 @@ static const BlockDevOps vduse_block_ops = {
 };
 
 static int vduse_blk_exp_create(BlockExport *exp, BlockExportOptions *opts,
+                                AioContext *const *multithread, size_t mt_count,
                                 Error **errp)
 {
     VduseBlkExport *vblk_exp = container_of(exp, VduseBlkExport, export);
@@ -302,6 +303,12 @@ static int vduse_blk_exp_create(BlockExport *exp, BlockExportOptions *opts,
             return -EINVAL;
         }
     }
+
+    if (multithread) {
+        error_setg(errp, "vduse-blk export does not support multi-threading");
+        return -EINVAL;
+    }
+
     vblk_exp->num_queues = num_queues;
     vblk_exp->handler.blk = exp->blk;
     vblk_exp->handler.serial = g_strdup(vblk_opts->serial ?: "");
diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index a4d54e824f2..e89422bb85a 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -316,6 +316,7 @@ static const BlockDevOps vu_blk_dev_ops = {
 };
 
 static int vu_blk_exp_create(BlockExport *exp, BlockExportOptions *opts,
+                             AioContext *const *multithread, size_t mt_count,
                              Error **errp)
 {
     VuBlkExport *vexp = container_of(exp, VuBlkExport, export);
@@ -341,6 +342,13 @@ static int vu_blk_exp_create(BlockExport *exp, BlockExportOptions *opts,
         error_setg(errp, "num-queues must be greater than 0");
         return -EINVAL;
     }
+
+    if (multithread) {
+        error_setg(errp,
+                   "vhost-user-blk export does not support multi-threading");
+        return -EINVAL;
+    }
+
     vexp->handler.blk = exp->blk;
     vexp->handler.serial = g_strdup("vhost_user_blk");
     vexp->handler.logical_block_size = logical_block_size;
diff --git a/nbd/server.c b/nbd/server.c
index acec0487a8b..620097c58ca 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1795,6 +1795,7 @@ static const BlockDevOps nbd_block_ops = {
 };
 
 static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
+                             AioContext *const *multithread, size_t mt_count,
                              Error **errp)
 {
     NBDExport *exp = container_of(blk_exp, NBDExport, common);
@@ -1831,6 +1832,11 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
         return -EEXIST;
     }
 
+    if (multithread) {
+        error_setg(errp, "NBD export does not support multi-threading");
+        return -EINVAL;
+    }
+
     size = blk_getlength(blk);
     if (size < 0) {
         error_setg_errno(errp, -size,
-- 
2.53.0


