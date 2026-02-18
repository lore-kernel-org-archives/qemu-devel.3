Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE89E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfi-0004IV-HI; Wed, 18 Feb 2026 08:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfg-0004GX-39
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfX-0005yD-7f
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BO4JPf4lZk0oOeAlnCpzdI34YuiTPFRED7Rq/jcZllk=;
 b=bqb5Hx3IhRcafUfyT61M8QBn3sirdarlWrahIB6toUOa0JEMBZqgESHeC/FeMUnTCJtQz2
 szQnDAxh21CO1J1BnWcJpZnLIuaW/UWRkH2Tcyxe/W1X74v0ZC3oiKOIEwuT3UVab6CaTQ
 8SSKnB7KBNTkh8Kln3xku7k8qlcStWY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-IklIBxe4NWuvxZDpbI83VQ-1; Wed, 18 Feb 2026 08:27:33 -0500
X-MC-Unique: IklIBxe4NWuvxZDpbI83VQ-1
X-Mimecast-MFC-AGG-ID: IklIBxe4NWuvxZDpbI83VQ_1771421252
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-435db9425ebso4763455f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421252; x=1772026052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BO4JPf4lZk0oOeAlnCpzdI34YuiTPFRED7Rq/jcZllk=;
 b=Kz8lGsjc9PryG1QqP2ewJkZSfJS9nK+gdAyqvSO6LOY++aZz89l4woBTv1ajJq1b2k
 Bfx8GkEQWkiUnP1y1ChCzcMqcetCOLwVKvr0XFIR4M5v+2R6TkC6GqhnO7to5szhNuWr
 x6TwBRp61CLKquyncXqk+qal2RqPwmKvLJuTyZNEpTVfkzhPaO4Y/qXRnSHONl8y8Mt8
 BsH8lXOKLVc/QdKJQxtc5aS+kq2hjK4QsL2AyHeH8Jtx3+szDJ8HUIwW3stW87gU6nFr
 eQEBpHdglMZwvGWWdf37pbCFpUS50pVpw3MOm1k2bYUtQZ3LX3Tigc8M2Sge+WkgvCqX
 9zkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421252; x=1772026052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BO4JPf4lZk0oOeAlnCpzdI34YuiTPFRED7Rq/jcZllk=;
 b=vvhXuAuIqbgWnuwxKczhAkDt8U/BE8fC5mdOt81Xm67YLvtieyLOBgTW8WLZf9gWmA
 TpxyVTZydmr53oIs1kqTWs3CAJeDP/mCDJIkNsWKyQTdVgNQ2CtoJGIzaOIC6gbgkDyk
 u7OJPdQ4Z0NLvg5KtS7+FVaI7b+YvyeY2khG2drAO9WLI6hZZn4YGKmaz9WEcg1bipkI
 rrsMn6jcoeCRMNiuB+tVZTz+9uWxoum/k/WcVI0YIKouB8daqfYeLQiO4RMJWPvFBKaO
 54VwXh+4v/VIu79l6I3wuWCTvOnOEcdEU/VUMWuRU1476dQvINGtUuTwm/5P8eAQ2NYU
 rPng==
X-Gm-Message-State: AOJu0YwmMNn9NGJUyQ7CMyStJnVxHf3+rnmVTWkzA1cSWx1OsZ6aXj26
 Mw7MitrB4IuBZTvD1d5BuqeJ2yJl5tM3aGy+IDcXyyp5y9k5gYgkzBPaHk18xfR+Gkm7eJOZksR
 bP22/FyBtLJJUoKHP7E/KmbN/8Ywrxl/o1Uw5JZuBbEpi89vtw7Wzy6bObin3mOIx
X-Gm-Gg: AZuq6aIaiUz3kfolTENLIv0/cMbPOUXkRmoDZCVgtZMicINWnSa5oUTY4tBJ2PPbfKK
 c6/yh2xfEjDyIh/WydebevWukYZeXgN829A1i15DsATrLRS5Lo3u0f2Kv78oO2NGl2kkh9lZwld
 5hMUwofJAbXdo3E46APJ+IrpLObBK3z5v83H1h1+2lysl6AIOVZRQYegOQtqyFOnAz7s44OI7nJ
 iV8JfQcZaounoUWZLDE6x+aACmd+weuJ9/oN8Nrqg/jJxf7WN62jb4FBkHUtJQ1dkxRw5PblC67
 /HMDhPMxHZUmj6xHpINIa801A9lNlPl0CE5alPmEKJJr3y5St/aCtykKwv5lQKwCE09Xgu8FLeb
 WGvBFys1N9ZA6j3xiBvo2v0Hig2C4QKbb47PD+a/1Ri0erw60X+S4csiea9l7bQxlE+AEgUkSCP
 h1Yobq
X-Received: by 2002:a05:6000:2911:b0:437:6b2e:a262 with SMTP id
 ffacd0b85a97d-43958df1428mr3408186f8f.3.1771421251627; 
 Wed, 18 Feb 2026 05:27:31 -0800 (PST)
X-Received: by 2002:a05:6000:2911:b0:437:6b2e:a262 with SMTP id
 ffacd0b85a97d-43958df1428mr3408110f8f.3.1771421250891; 
 Wed, 18 Feb 2026 05:27:30 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abc21dsm43672633f8f.20.2026.02.18.05.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:27:29 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 19/24] block/export: Add multi-threading interface
Date: Wed, 18 Feb 2026 14:26:28 +0100
Message-ID: <20260218132633.29748-20-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 076954ef1a..160cd2e3ca 100644
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
index b60affe86b..aa4f1c0307 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -260,6 +260,8 @@ static const BlockDevOps fuse_export_blk_dev_ops = {
 
 static int fuse_export_create(BlockExport *blk_exp,
                               BlockExportOptions *blk_exp_args,
+                              AioContext *const *multithread,
+                              size_t mt_count,
                               Error **errp)
 {
     ERRP_GUARD(); /* ensure clean-up even with error_fatal */
@@ -269,6 +271,11 @@ static int fuse_export_create(BlockExport *blk_exp,
 
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
index 8af13b7f0b..10dc673c56 100644
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
index a4d54e824f..e89422bb85 100644
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
index acec0487a8..620097c58c 100644
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


