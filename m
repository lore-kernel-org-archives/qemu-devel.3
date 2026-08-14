Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9994BC5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 17:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuw1e-0004Db-Qa; Fri, 14 Aug 2026 13:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw1d-0004DN-9Y
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:49:01 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw1b-0007ns-IS
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:49:01 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c9cf07d2df6so812996a12.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786729738; x=1787334538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Phai//kpp45A7NPkk7aXSkHD9wHcvucdwAW3CMNiK1o=;
 b=hzVYfbh8Moq/bHPLhBt20lbe3tRf7WQhwMwy7NB00CF7FlMN9NxLT2ov2dbCnc6Y/E
 onDsb0Ihd+DDiaYUVtbX2peRIGAo7D4y7mAECJH27Lu3NLvdIxfTg2qXbtCd95zLjvQx
 XrE3XYjNI+A0coTdx2jLM+lUFrO4dYd6cxKcpxC6B2JYbsfY63xe+1rbvLVM+PeOzUPp
 uB1knpOtciTSwcI2gYybw60NtPKVhyd/vYEylqwr5GyZjpdP9so0eC6dg5NVMXzdpuid
 513WokQuCkmYX4gPZb/hRHtP+ON+eaIKTVoZM33w0nJ91NKXTLlbJFTDyI0YYOF6Wbyg
 wXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786729738; x=1787334538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Phai//kpp45A7NPkk7aXSkHD9wHcvucdwAW3CMNiK1o=;
 b=QjOLZoYi1E+BJen8m2sbo5E9rlaCR/GbAeQCqNH8tSORV4PlWoRlv4yYltIBI972zF
 BtF2AJ92IzZ8rzwMwEGtSULaGto3AwK0DKnZXG6SJoZl9ZeoyD8voUWRppFT5qt18eoh
 aGo74K68i/zFVYsUuA4oX+5hv1Ongnm+I+kfCxwa75KWDRf0jFuv45jIxnH/2hb+FX39
 9/GMCc2yhCvNdhRPteM6biaky2Qg+fwHQVYIPRPSZn7GQSWeEEkY9Nu+ZMDSE9LjUzX/
 Q+S3B5sZEFIcQsHm22+U/84qhAt0VBj0/OYeXkM+FMGlwD3jubTpO4dY8Isd36lPAZaM
 hNRA==
X-Gm-Message-State: AOJu0YyC0FVRyLCgvHQS9ePyOWD+8Z8z+X/iHLnFSDAa3gi6o6Kb5JA8
 7Iri8WWbe3hG9c+H0+Qkgj5AbvJCKXg2gqJxjMLuVmwMOGun5gEag4fVWQpH/Pej9r3jZg==
X-Gm-Gg: AR+sD10YpLER7VNepmtS9c44Ili1fQeN95gGveYU9erb9vRX3rBq7bDxL7zUxoLzM0j
 EFV3F/SjrdCtvZSUD7QGw/r+hlIktC978hFsaIBHPL/T9nceo2zrhgUq2MJRrXR1XNTFRVrORKf
 A5Ki3bjVHdBSsatsvNNVdG2qaZk4C3ajABX8eiTY8cX+K4CR1/wcOlwREeav12tNgQHs7AH+FVL
 rQGSHKTqP0N+kvE6kowW/Z55Q1lY9UC6JzFEcxmPBDlaAThxBUY0kyi3ZRWW/II+3ZmwsB14Wpn
 3Oi+DjBGyS4egKuvmNUZRS5vmC6eNO8lsootMBhGiax8WhkHtaiLMhrN9RCqQ6R6IeboKDjZOQo
 sYH6eJDOXPxFpNDPmZTwXeN4n40W9obPZ6sNSwYa0qhxUH4JNHGC3ArJ/Ug96ZapMMM1AHRroZu
 2QCkdIkixE5D6H2s9y1tVQLS1gG9085axAllQ4YAuA6v9T/LKJvvyEk36XnkHqUGh5hXJbBgdUK
 NCA0P8b
X-Received: by 2002:a05:6a21:a98:b0:3bf:83f3:b810 with SMTP id
 adf61e73a8af0-3cc71d7ca3dmr9747176637.29.1786729738122; 
 Fri, 14 Aug 2026 10:48:58 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320e9df03f9sm6708081eec.19.2026.08.14.10.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 10:48:57 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V12 05/15] block/export: track IOThread references
Date: Sat, 15 Aug 2026 01:48:19 +0800
Message-ID: <20260814174830.1691540-6-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814174830.1691540-1-zhangckid@gmail.com>
References: <20260814174830.1691540-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 block/export/export.c  | 79 +++++++++++++++++++++++++++++++++++++-----
 include/block/export.h |  6 ++++
 2 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/block/export/export.c b/block/export/export.c
index b733f269f3..09136cda34 100644
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
+    char *holder_id = NULL;
     uint64_t perm;
     int ret;
 
@@ -139,7 +140,16 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
             goto fail;
         }
 
-        new_ctx = iothread_get_aio_context(iothread);
+        holder_id = export->id;
+        const IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
+            .u.block_export.export_id = holder_id,
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
+        holder_id = export->id;
+        const IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
+            .u.block_export.export_id = holder_id,
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
+        .iothread_holder_id   = g_strdup(holder_id),
     };
 
     ret = drv->create(exp, export, multithread_ctxs, multithread_count, errp);
@@ -250,8 +272,33 @@ fail:
         blk_unref(blk);
     }
     if (exp) {
+        if (exp->iothreads) {
+            const IOThreadHolder holder = {
+                .type = IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
+                .u.block_export.export_id = exp->iothread_holder_id,
+            };
+            for (size_t j = 0; j < exp->iothread_count; j++) {
+                if (exp->iothreads[j]) {
+                    iothread_unref_and_put_aio_context(exp->iothreads[j],
+                                                       &holder);
+                }
+            }
+            g_free(exp->iothreads);
+        }
+        g_free(exp->iothread_holder_id);
         g_free(exp->id);
         g_free(exp);
+    } else if (local_iothreads) {
+        const IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
+            .u.block_export.export_id = holder_id,
+        };
+
+        for (size_t j = 0; j < multithread_count; j++) {
+            if (local_iothreads[j]) {
+                iothread_unref_and_put_aio_context(local_iothreads[j], &holder);
+            }
+        }
     }
     g_free(multithread_ctxs);
     return NULL;
@@ -273,6 +320,20 @@ static void blk_exp_delete_bh(void *opaque)
     exp->drv->delete(exp);
     blk_set_dev_ops(exp->blk, NULL, NULL);
     blk_unref(exp->blk);
+
+    if (exp->iothreads) {
+        const IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
+            .u.block_export.export_id = exp->iothread_holder_id,
+        };
+
+        for (size_t i = 0; i < exp->iothread_count; i++) {
+            iothread_unref_and_put_aio_context(exp->iothreads[i], &holder);
+        }
+        g_free(exp->iothreads);
+    }
+
+    g_free(exp->iothread_holder_id);
     qapi_event_send_block_export_deleted(exp->id);
     g_free(exp->id);
     g_free(exp);
diff --git a/include/block/export.h b/include/block/export.h
index ca45da928c..a093dea0b6 100644
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
+    /* The IOThreads utilized by this specific block export */
+    IOThread **iothreads;
+    size_t iothread_count;
+    char *iothread_holder_id;
 };
 
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
-- 
2.54.0


