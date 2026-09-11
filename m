Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42227C88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4yAU-0006J1-F7; Fri, 11 Sep 2026 06:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yAS-0006Io-9Y
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:07:36 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yAQ-0007FV-DG
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:07:36 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccc02279so712751a91.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 03:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789121253; x=1789726053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oeURIEcCI8TbII/h58ISje3mK5oO8wJcPqe347GxoX0=;
 b=JSHJbAD2Yep9Z94o9jvxYdKpZQ7k1aZ7qkMmxBquu/tJG6xyrCuqzeC2BcLPokFJZh
 A0KNhSwpPLhsyogkbTCRu1GinzAgjmg8AzTKngJbBFcT/7MgR7W/50v1NmcU5qRvLzNd
 vBCjAMpcDBjS9EbnDsUXQwOZR3r6RwPEoYZjPo+SOFzPDAmIy6ky1duG5F7TkjviUuOF
 avpj9c0YJ8Ag8OKtGfVDtDjlM4evXY6fOnjgYnIdmXnjM57j34iDHa/LXFLpv/5ibssy
 K6jnDwJGBZpxkYljX9wl08+O8C1N9xwR/zg5k/MG7wsKfFexNFGlCFsHNyeETvKa+A/V
 T6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789121253; x=1789726053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oeURIEcCI8TbII/h58ISje3mK5oO8wJcPqe347GxoX0=;
 b=hugq0YeEuw2MctDU3SyUU8eDsB9ROYlLxpMpD/GQX9R2Vuh3gOW6k4GfcWxsOC4pkj
 4RdLkVNVf0cYayqDAOmRPXD55iP6r1og1vxuubbkt2dnLDj8dwhn9oSiGXXnRyeuwWrO
 cwMoIC4uGPVh9yiCrhrN5CwQIq6bnfbYz8J+C3LkiQ9u7xNz8wuOQzM1ArdXdKljNbMv
 V+O1sYEI//s08XZTAev3mCImfHjfxStWPQjyy/Cfy/NslS0+kxJGM56Cfo+xwdyZzSZ2
 nP/tIzBCh62Nh3+IloWkPFwTxay1Dqt8RiwqfkO5pUw8/+jZLnmxtW07NZoIUr2jmdBH
 f+nQ==
X-Gm-Message-State: AFuF++mO3bJZv82vfxbSluoodBKUvxyfK6y8xDBbV6VzNl2TV8ZxFPfF
 MkKCJHNegn3tZWrC3dB8hE+c05cg1cvwfFfVx0onCiQZtc/42Bk8WzsUrD58yDi6GZM=
X-Gm-Gg: AYBFou3owU+5IsPdMzWphI8dccaf6hOvZhhPSQITRhP3lObQ8NlNRPcKaTyxPZgzWb7
 0MO/ST3cR9QtviQeqdiJS7jSzHv3UREOGOlIFOHPYZ5NJGeKbzkIMGfx8S7C0UKHIjV/dJy8rK4
 /MGUUzgVe6nMM9HHBH+80/yD3PfG3Yg4n/89yHztSD9RbIRAyRLDCmiFPZxdcKjd3bSZErz9tIR
 QeF43SCIpXqwUg+Wsdcd4N4T0K8/wJ/HI59Va7HlND3xLJmniIrT8lVbMfPr8CVORkXg7dLw/sC
 WgSK55Hoty79Sxh5QhruN44EV15mJiTrgW51Cf7uINWSGuT4KIBmptKQG/3lc3s7m07TSLfYluf
 9zIDRRMfLFdPdsp0vG48rXpwUE6IMFCcQSU7cI0zc+TQABt7hyPvuprLAvA/ZcQtAq9ynwi7+J+
 yE/slFt2WyeXr+mf8dVNq4bnPZEvrwIgcL0Oo+WQODsIFap/d/mc46yxW31RhWv04IMSq2/SSyQ
 6GhyCblOlFzdJxKbWolJAQyInU=
X-Received: by 2002:a17:90b:1c88:b0:39d:83d0:41b2 with SMTP id
 98e67ed59e1d1-39d9c230cccmr5294822a91.15.1789121252752; 
 Fri, 11 Sep 2026 03:07:32 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d951d6b08sm4514800a91.8.2026.09.11.03.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:07:32 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V16 03/13] block/export: track IOThread references
Date: Fri, 11 Sep 2026 18:06:59 +0800
Message-ID: <20260911100709.726366-4-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911100709.726366-1-zhangckid@gmail.com>
References: <20260911100709.726366-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=zhangckid@gmail.com; helo=mail-pj2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Track the IOThreads used by a block export and identify the holder
with the unique BlockExportOptions id.

Acquire holder-aware references during export creation and release
them on error or export deletion.  Support both single- and
multi-iothread exports.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 block/export/export.c  | 62 ++++++++++++++++++++++++++++++++++++------
 include/block/export.h |  5 ++++
 2 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/block/export/export.c b/block/export/export.c
index b733f269f3..0e019545ef 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -15,7 +15,6 @@
 
 #include "block/block.h"
 #include "system/block-backend.h"
-#include "system/iothread.h"
 #include "block/export.h"
 #include "block/fuse.h"
 #include "block/nbd.h"
@@ -72,6 +71,32 @@ static const BlockExportDriver *blk_exp_find_driver(BlockExportType type)
     return NULL;
 }
 
+static void init_iothreads(const char *holder_id, IOThread **iothreads,
+                           size_t num_iothreads, AioContext **aio_ctxs)
+{
+    const IOThreadHolder holder = {
+        .type = IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
+        .u.block_export.export_id = (char *)holder_id,
+    };
+
+    for (size_t i = 0; i < num_iothreads; i++) {
+        aio_ctxs[i] = iothread_ref_and_get_aio_context(iothreads[i], &holder);
+    }
+}
+
+static void cleanup_iothreads(const char *holder_id, IOThread **iothreads,
+                              size_t num_iothreads)
+{
+    const IOThreadHolder holder = {
+        .type = IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
+        .u.block_export.export_id = (char *)holder_id,
+    };
+
+    for (size_t i = 0; i < num_iothreads; i++) {
+        iothread_unref_and_put_aio_context(iothreads[i], &holder);
+    }
+}
+
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
 {
     bool fixed_iothread = export->has_fixed_iothread && export->fixed_iothread;
@@ -85,6 +110,8 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     AioContext *ctx;
     AioContext **multithread_ctxs = NULL;
     size_t multithread_count = 0;
+    g_autofree IOThread **local_iothreads = NULL;
+    size_t iothread_count = 0;
     uint64_t perm;
     int ret;
 
@@ -139,7 +166,10 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
             goto fail;
         }
 
-        new_ctx = iothread_get_aio_context(iothread);
+        local_iothreads = g_new0(IOThread *, 1);
+        local_iothreads[0] = iothread;
+        init_iothreads(export->id, local_iothreads, 1, &new_ctx);
+        iothread_count = 1;
 
         /* Ignore errors with fixed-iothread=false */
         set_context_errp = fixed_iothread ? errp : NULL;
@@ -163,8 +193,10 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
             return NULL;
         }
 
+        local_iothreads = g_new0(IOThread *, multithread_count);
         multithread_ctxs = g_new(AioContext *, multithread_count);
         i = 0;
+
         for (strList *e = iothread_list; e; e = e->next) {
             IOThread *iothread = iothread_by_id(e->value);
 
@@ -172,9 +204,12 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
                 error_setg(errp, "iothread \"%s\" not found", e->value);
                 goto fail;
             }
-            multithread_ctxs[i++] = iothread_get_aio_context(iothread);
+            local_iothreads[i++] = iothread;
         }
         assert(i == multithread_count);
+        init_iothreads(export->id, local_iothreads, multithread_count,
+                       multithread_ctxs);
+        iothread_count = multithread_count;
     }
 
     bdrv_graph_rdlock_main_loop();
@@ -225,12 +260,14 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     assert(drv->instance_size >= sizeof(BlockExport));
     exp = g_malloc0(drv->instance_size);
     *exp = (BlockExport) {
-        .drv        = drv,
-        .refcount   = 1,
-        .user_owned = true,
-        .id         = g_strdup(export->id),
-        .ctx        = ctx,
-        .blk        = blk,
+        .drv                  = drv,
+        .refcount             = 1,
+        .user_owned           = true,
+        .id                   = g_strdup(export->id),
+        .ctx                  = ctx,
+        .blk                  = blk,
+        .iothreads            = g_steal_pointer(&local_iothreads),
+        .iothread_count       = iothread_count,
     };
 
     ret = drv->create(exp, export, multithread_ctxs, multithread_count, errp);
@@ -250,8 +287,12 @@ fail:
         blk_unref(blk);
     }
     if (exp) {
+        cleanup_iothreads(exp->id, exp->iothreads, exp->iothread_count);
+        g_free(exp->iothreads);
         g_free(exp->id);
         g_free(exp);
+    } else {
+        cleanup_iothreads(export->id, local_iothreads, iothread_count);
     }
     g_free(multithread_ctxs);
     return NULL;
@@ -273,6 +314,9 @@ static void blk_exp_delete_bh(void *opaque)
     exp->drv->delete(exp);
     blk_set_dev_ops(exp->blk, NULL, NULL);
     blk_unref(exp->blk);
+
+    cleanup_iothreads(exp->id, exp->iothreads, exp->iothread_count);
+    g_free(exp->iothreads);
     qapi_event_send_block_export_deleted(exp->id);
     g_free(exp->id);
     g_free(exp);
diff --git a/include/block/export.h b/include/block/export.h
index ca45da928c..ce8e4eb604 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -16,6 +16,7 @@
 
 #include "qapi/qapi-types-block-export.h"
 #include "qemu/queue.h"
+#include "system/iothread.h"
 
 typedef struct BlockExport BlockExport;
 
@@ -89,6 +90,10 @@ struct BlockExport {
 
     /* List entry for block_exports */
     QLIST_ENTRY(BlockExport) next;
+
+    /* The IOThreads utilized by this specific block export */
+    IOThread **iothreads;
+    size_t iothread_count;
 };
 
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
-- 
2.43.0


