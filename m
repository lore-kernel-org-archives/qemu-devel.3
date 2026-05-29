Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5031CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4qI-0003Jy-66; Fri, 29 May 2026 17:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4qH-0003Jq-1T
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:09 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4qF-0002rN-6j
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-842264dde84so108301b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780090446; x=1780695246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2I8RSgxtS6zilF0lFLp60gipvFmJj5Si+EneANHl4s=;
 b=YUaCAqVk5ioJVxtKX+FjcdkhzPnD2wjoUvcjQzrSL3HeDxkBCy9OmZLTPwZ2FpA8YG
 xCuzdYz8fVZaaBRFrVpO4TGsfd4rFuhkJ2O6x8kQi1XKu60ojirneGrJAREIesFUThiB
 K4AJqxRQ/SzURUZEdhJ7iKIWNj36I2OSh9PHVr2Oh9Y0zbNdpLEwLCtY6xL+YlscZLcX
 G4E0UXWhjGG5wz/8iyVYxAr5cQ7IKg4fLJ495Uj27sr+8j3sfN/Bv/MyurbN6rk9WeR2
 1SCCY3DNS+JJ0lZdVKIm5c29Lbwv602eX7k4/kk85PewSXArdMwkYU/J4B8QLkA7R+Ry
 tSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780090446; x=1780695246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L2I8RSgxtS6zilF0lFLp60gipvFmJj5Si+EneANHl4s=;
 b=Xwc3/QKvfkCt6LECCRvj2AqgNsyI5Lg9ypGrxSISpKCdn0PBXwcqRLa2kJqTG05BqF
 bpz8TozknX9SJ8HcWAKtTj8Smml2cxe+IYRNF77wZ5K1x53NkNCWqb0/YCjuB5IeNE0c
 tthagIXo5cBNS3h2VficMLEmTc7zoDaDDM34Sn4AymyGJXdWR1HO9abo4/GmoAsDFB9x
 PNDU8MKthMcOzC1D5dQoEXzAdlmxz5sup7QCyOyC7lCfjzpy2H5YqIGgWqNUE+9kdlx8
 WgnuhBAjXnBeWgyEkhPGxDtwZ0eWG9UMogzvAffru8EF28jaQxfxkQ31svPJtDHdJI0G
 eVNQ==
X-Gm-Message-State: AOJu0Yw2veHRkOdPCc14q1YGw23/hfP0I98YMCXGflLU5P3+qQkR7M+h
 o919yAS81ZFZsqCSgi9frssjt89FffulFD4U0eCv4ab9CCp4lOA/LAsa8Bk2omHrjus=
X-Gm-Gg: Acq92OGGr9asCo4vmRHP7Cpi9PVd1C57basGK8p32opH0XjjCpSwXRHZire59SbpyeB
 tcOjHzSb6+gqAh+sWfeXJp5pgrFMyuX22fP77D+F8cz3Mmoep3cwnpbjIwSoWGuGNeSxMgUG3S5
 PkEUJjrKtw61ySyfZKmb5lJIhlOe2FdqbW9/+NpMzzrPq8fNV2bC2u+Gvmn68tNP6DUKlo/kn/a
 rj6WDstHPYkG1kmUUNsAE2qvgfGA24n0229yg2DGtF3SG+UqrWcRVmCFHtOtI63N+EAiPpQ+PC2
 jJ0gEX+DiWOzDec5hKwU4hzsxzfN2Pxhf8xqPFKEvIwtaSi4saAS39Oi1Jt+Y1ckYpE/VmG/pLC
 c2O1INfbEv+JJUEngXTUH4suPgOcrhZuWThKbVo+pJ7i4IoW7qw8UA8lCZRYG0lvzB6q4CXE233
 J531q5UvlQNMWEWPgBS3X3ywfdwN7S4R5SQem7CFTFU/xwKLQZtdOuqmrb7/8FNkc=
X-Received: by 2002:a05:6a00:2d8f:b0:835:3f9c:c681 with SMTP id
 d2e1a72fcca58-84210d462c3mr4150507b3a.34.1780090445786; 
 Fri, 29 May 2026 14:34:05 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214affe29sm2779564b3a.3.2026.05.29.14.34.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 14:34:05 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V8 05/15] block/export: track IOThread reference in BlockExport
Date: Sat, 30 May 2026 05:33:11 +0800
Message-ID: <20260529213321.96271-6-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260529213321.96271-1-zhangckid@gmail.com>
References: <20260529213321.96271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x434.google.com
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

Users currently lack visibility into which block exports
are utilizing specific IOThreads. This patch integrates IOThread
referencing into the BlockExport lifecycle.

- Add iothreads array and holder_name to BlockExport struct.
- Use iothread_ref_and_get_aio_context during export creation.
- Implement proper cleanup in blk_exp_add fail path and blk_exp_delete_bh.
- Support both single and multi-iothread export configurations.

This ensures IOThread 'holders' status correctly reflects active block
exports for better debugging and resource tracking.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 block/export/export.c  | 63 ++++++++++++++++++++++++++++++++++++------
 include/block/export.h |  6 ++++
 2 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/block/export/export.c b/block/export/export.c
index b733f269f3..b6c07f69b5 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -15,7 +15,6 @@
 
 #include "block/block.h"
 #include "system/block-backend.h"
-#include "system/iothread.h"
 #include "block/export.h"
 #include "block/fuse.h"
 #include "block/nbd.h"
@@ -85,6 +84,8 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     AioContext *ctx;
     AioContext **multithread_ctxs = NULL;
     size_t multithread_count = 0;
+    g_autofree IOThread **local_iothreads = NULL;
+    const char *holder_name = NULL;
     uint64_t perm;
     int ret;
 
@@ -139,7 +140,16 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
             goto fail;
         }
 
-        new_ctx = iothread_get_aio_context(iothread);
+        holder_name = bdrv_get_node_name(bs);
+        IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_BLOCK_NODE,
+            .u.block_node.node_name = (char *)holder_name,
+        };
+
+        new_ctx = iothread_ref_and_get_aio_context(iothread, &holder);
+        multithread_count = 1;
+        local_iothreads = g_new0(IOThread *, 1);
+        local_iothreads[0] = iothread;
 
         /* Ignore errors with fixed-iothread=false */
         set_context_errp = fixed_iothread ? errp : NULL;
@@ -163,8 +173,15 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
             return NULL;
         }
 
+        local_iothreads = g_new0(IOThread *, multithread_count);
         multithread_ctxs = g_new(AioContext *, multithread_count);
         i = 0;
+        holder_name = bdrv_get_node_name(bs);
+        IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_BLOCK_NODE,
+            .u.block_node.node_name = (char *)holder_name,
+        };
+
         for (strList *e = iothread_list; e; e = e->next) {
             IOThread *iothread = iothread_by_id(e->value);
 
@@ -172,7 +189,9 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
                 error_setg(errp, "iothread \"%s\" not found", e->value);
                 goto fail;
             }
-            multithread_ctxs[i++] = iothread_get_aio_context(iothread);
+            local_iothreads[i] = iothread;
+            multithread_ctxs[i++] = iothread_ref_and_get_aio_context(iothread,
+                                                                     &holder);
         }
         assert(i == multithread_count);
     }
@@ -225,12 +244,15 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
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
+        .iothread_count       = multithread_count,
+        .iothread_holder_name = g_strdup(holder_name),
     };
 
     ret = drv->create(exp, export, multithread_ctxs, multithread_count, errp);
@@ -253,6 +275,18 @@ fail:
         g_free(exp->id);
         g_free(exp);
     }
+    if (local_iothreads) {
+        IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_BLOCK_NODE,
+            .u.block_node.node_name = (char *)holder_name,
+        };
+
+        for (size_t j = 0; j < multithread_count; j++) {
+            if (local_iothreads[j]) {
+                iothread_put_aio_context(local_iothreads[j], &holder);
+            }
+        }
+    }
     g_free(multithread_ctxs);
     return NULL;
 }
@@ -269,6 +303,17 @@ static void blk_exp_delete_bh(void *opaque)
     BlockExport *exp = opaque;
 
     assert(exp->refcount == 0);
+    if (exp->iothreads) {
+        IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_BLOCK_NODE,
+            .u.block_node.node_name = (char *)exp->iothread_holder_name,
+        };
+
+        for (size_t i = 0; i < exp->iothread_count; i++) {
+            iothread_put_aio_context(exp->iothreads[i], &holder);
+        }
+        g_free(exp->iothreads);
+    }
     QLIST_REMOVE(exp, next);
     exp->drv->delete(exp);
     blk_set_dev_ops(exp->blk, NULL, NULL);
diff --git a/include/block/export.h b/include/block/export.h
index ca45da928c..2bb98aae31 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -16,6 +16,7 @@
 
 #include "qapi/qapi-types-block-export.h"
 #include "qemu/queue.h"
+#include "system/iothread.h"
 
 typedef struct BlockExport BlockExport;
 
@@ -89,6 +90,11 @@ struct BlockExport {
 
     /* List entry for block_exports */
     QLIST_ENTRY(BlockExport) next;
+
+    /* The iothreads list for block_exports */
+    IOThread **iothreads;
+    size_t iothread_count;
+    char *iothread_holder_name;
 };
 
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
-- 
2.49.0


