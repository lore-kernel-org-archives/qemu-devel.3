Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD32C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 13:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMoBr-000116-FW; Wed, 04 Jun 2025 09:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoBJ-0007iC-D3
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uMoBH-0004pt-3v
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 09:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749043762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PVYMLToVfSoih+SPkfb8YdRk7R7pSEP/Dbr3lPGMdqE=;
 b=A58jsAbOEQBgxJZSb7SegHzdMtLftR0XKm44Cijs1jA9q/W3JUD1BTXQa9lJUd9vWQ+5iA
 8PGYPk7vlCbioY7NIKyVvMTA4CRKFC/lm9Q6YFqw8tVTDMczybDHcQ/nJ32iSLjym2pSLS
 VIzOqx2FS05hHSXefBVd7NY/vRf0x3U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-KxmFXFtqOj-0MvDNPIN0Gg-1; Wed, 04 Jun 2025 09:29:20 -0400
X-MC-Unique: KxmFXFtqOj-0MvDNPIN0Gg-1
X-Mimecast-MFC-AGG-ID: KxmFXFtqOj-0MvDNPIN0Gg_1749043759
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4fabcafecso2242533f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 06:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749043759; x=1749648559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVYMLToVfSoih+SPkfb8YdRk7R7pSEP/Dbr3lPGMdqE=;
 b=PMTVcHPUPHIH85XLQ5pInhu9ISFUGqkms8gXAbhSuex2P347/4jjjxZrJStVeDXXdz
 tMPnmmUM+oMq6kNJw2HvjJ+bBZl8+QziiCCZc0eEQkUaRx+eWFYGKroMCDocTA3zgcXP
 i2X+Q7R705PRbRBaS2Vd6XfUJ7BXZlIrr4g/KyvDO4ASbgpkaOu9HTE9+qx61QLk48xA
 Whly7GpxHzhHagvqGLBu6Ve8j/W4A7562OHIexYGW0RtZF9sDQ1kHLcq+OrSgVUZWsw2
 H2comZd9JBL/0WPKIOHnojqxF7UelA/6Kk/bMRU9RjufFvmC7s3F/noRLeqvyj0E+XwY
 11RQ==
X-Gm-Message-State: AOJu0YwrdiqTjCd1e4K29DzHBmtrMk7szxVAel2/VCHm0kXUEgUsYIz9
 jqLRAv+G9/2pPUzjdU4xmr2Ejkz7bPSE2jLHT++BNnc1f/1dwQ25BjNZRw0oTHj+76HeN73XQrh
 K/cfWjilYJy/kC/oGV7Jcc8RTOtJq694CCQGlmkICxghhbgi7ocZ977c+
X-Gm-Gg: ASbGncv1eGTD26tHNzlxWsC0Tyu3//dqqw2o019tSbMZo8z13/Dq961GNGvGv0X5VXs
 ZU7+L1+zDO+FjZiQMKF8Hs0/DfVzJNgJvJQcfL14uPYjCfcgM4vfHmHjLgk1sPEXGten11gzPqM
 P4s3b9CsmwHmkzmk6e9KdNPyIQdYiI/daD4rZN8fkYUQnHABw04qUOXHS4Ce1HUJnWeoltRK4/K
 A5hufbQ2KFQTDs4WXKnPC5bddHmtAsnJn9xOMBp0HOkm9sJ9lEeULeV4BJMG2UbaD86Y9HLacI0
 5S19yyXFrxk9fnT+pBecpomXGTFBB3D2EQoWE3VNuEa2ZGljKrlApiPmYltgOiQIdYdw23Y2282
 3+cBk
X-Received: by 2002:a05:6000:200f:b0:3a4:cfbf:5197 with SMTP id
 ffacd0b85a97d-3a51dbcd4bbmr2142210f8f.18.1749043759299; 
 Wed, 04 Jun 2025 06:29:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCeWd44MXHKM62m6CBkiNRoTnlRFd2JRujNfKvAlQwDFYcXG9MWKDRjdYbu0VM9yp5PP0dUg==
X-Received: by 2002:a05:6000:200f:b0:3a4:cfbf:5197 with SMTP id
 ffacd0b85a97d-3a51dbcd4bbmr2142186f8f.18.1749043758767; 
 Wed, 04 Jun 2025 06:29:18 -0700 (PDT)
Received: from localhost
 (p200300cfd700f306503d3c798c1bf214.dip0.t-ipconnect.de.
 [2003:cf:d700:f306:503d:3c79:8c1b:f214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8f188sm201453085e9.3.2025.06.04.06.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 06:29:15 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v2 16/21] block/export: Add multi-threading interface
Date: Wed,  4 Jun 2025 15:28:08 +0200
Message-ID: <20250604132813.359438-17-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604132813.359438-1-hreitz@redhat.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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

Make BlockExportType.iothread an alternate between a single-thread
variant 'str' and a multi-threading variant '[str]'.

In contrast to the single-thread setting, the multi-threading setting
will not change the BDS's context (and so is incompatible with the
fixed-iothread setting), but instead just pass a list to the export
driver, with which it can do whatever it wants.

Currently no export driver supports multi-threading, so they all return
an error when receiving such a list.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 qapi/block-export.json               | 34 +++++++++++++++++---
 include/block/export.h               | 12 +++++--
 block/export/export.c                | 48 +++++++++++++++++++++++++---
 block/export/fuse.c                  |  7 ++++
 block/export/vduse-blk.c             |  7 ++++
 block/export/vhost-user-blk-server.c |  8 +++++
 nbd/server.c                         |  6 ++++
 7 files changed, 111 insertions(+), 11 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index c783e01a53..3ebad4ecef 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -362,14 +362,16 @@
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
 # @allow-inactive: If true, the export allows the exported node to be inactive.
@@ -385,7 +387,7 @@
   'base': { 'type': 'BlockExportType',
             'id': 'str',
             '*fixed-iothread': 'bool',
-            '*iothread': 'str',
+            '*iothread': 'BlockExportIothreads',
             'node-name': 'str',
             '*writable': 'bool',
             '*writethrough': 'bool',
@@ -401,6 +403,28 @@
                      'if': 'CONFIG_VDUSE_BLK_EXPORT' }
    } }
 
+##
+# @BlockExportIothreads:
+#
+# Specify a single or multiple I/O threads in which to run a block export's I/O.
+#
+# @single: Run the export's I/O in the given single I/O thread.
+#
+# @multi: Use multi-threading across the given set of I/O threads, which must
+#     must not be empty.  Note: Passing a single I/O thread via this variant is
+#     still treated as multi-threading, which is different from using the
+#     @single variant.  In particular, even if there only is a single I/O thread
+#     in the set, export types that do not support multi-threading will
+#     generally reject this variant, and BlockExportOptions.fixed-iothread is
+#     always incompatible with it.
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
index 4bd9531d4d..ca45da928c 100644
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
index f3bbf11070..b733f269f3 100644
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
index 75d80da616..44f0b796b3 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -180,6 +180,8 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
 
 static int fuse_export_create(BlockExport *blk_exp,
                               BlockExportOptions *blk_exp_args,
+                              AioContext *const *multithread,
+                              size_t mt_count,
                               Error **errp)
 {
     ERRP_GUARD(); /* ensure clean-up even with error_fatal */
@@ -189,6 +191,11 @@ static int fuse_export_create(BlockExport *blk_exp,
 
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
index bd852e538d..bf70c98dd6 100644
--- a/block/export/vduse-blk.c
+++ b/block/export/vduse-blk.c
@@ -266,6 +266,7 @@ static const BlockDevOps vduse_block_ops = {
 };
 
 static int vduse_blk_exp_create(BlockExport *exp, BlockExportOptions *opts,
+                                AioContext *const *multithread, size_t mt_count,
                                 Error **errp)
 {
     VduseBlkExport *vblk_exp = container_of(exp, VduseBlkExport, export);
@@ -301,6 +302,12 @@ static int vduse_blk_exp_create(BlockExport *exp, BlockExportOptions *opts,
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
index d9d2014d9b..481d4b7441 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -315,6 +315,7 @@ static const BlockDevOps vu_blk_dev_ops = {
 };
 
 static int vu_blk_exp_create(BlockExport *exp, BlockExportOptions *opts,
+                             AioContext *const *multithread, size_t mt_count,
                              Error **errp)
 {
     VuBlkExport *vexp = container_of(exp, VuBlkExport, export);
@@ -340,6 +341,13 @@ static int vu_blk_exp_create(BlockExport *exp, BlockExportOptions *opts,
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
index d242be9811..a1736a5a24 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1793,6 +1793,7 @@ static const BlockDevOps nbd_block_ops = {
 };
 
 static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
+                             AioContext *const *multithread, size_t mt_count,
                              Error **errp)
 {
     NBDExport *exp = container_of(blk_exp, NBDExport, common);
@@ -1829,6 +1830,11 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
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
2.49.0


