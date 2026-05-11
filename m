Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F30ECD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRG8-0000a5-Db; Mon, 11 May 2026 10:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRFz-0000Hp-Dt
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:17 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRFo-00070T-0Q
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:11 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c80291e6237so2956529a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508294; x=1779113094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w8HwQtZrBNwiBM3qiCF4oN8OZWtNeAVstfBNuSX9Enc=;
 b=rW81ejYVRyIM9BbqtA+eHTlxmNNQD7WKN66qg2KXNh0A3OyvX+/rYY+A3qkagySvQt
 eYQbCIUdFAuH57HQWu+2Z6oTcjqUDtcc9Senxl2LY3AMQkoMZQJaLOmQ51vbvUgRU+tG
 yxFBPvE94imwcor91vujiiTkqK58VMCncG2B5MXuBVZuPZIWla4zYIdUN05PDura8ymp
 V2uUHvZejjtJx5PkCRAX2Aa4JJ0LcMEuaSowDvRZV3pl1CTmHKkWpOf8OCt+jCGIlZx/
 riy0rABAZtXC4FN7YauNq54Aoqb9oPoOG7X82m8ro7tA0uoCWUCKg/11h2QQ6F/DmcyN
 uN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508294; x=1779113094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w8HwQtZrBNwiBM3qiCF4oN8OZWtNeAVstfBNuSX9Enc=;
 b=YRr8Df4Nnw1KlLX3Wnbn9q8c5BWy36nq8SKlTy5trY6k1M8zaN7/jiRMI3DqsprMc9
 4Qo2pmM9pNMTNnyjty71c30txqbQwMQG0gFjdoLghOSkpqUIS7e1ffvlHrzs88iiUoWA
 Uk5Sjs8cLSfghyJWNNcSWqcyh9LOgVJkyOn3OoMDwgIQua3zoY9XjrxfN0MzsYzvzcWS
 4DpxttIFJvceEMxmgx1PFZawyfC9iQ5qborhx7jE/rh/TpGcwJX48J9ZzZjO89JOF/5+
 IQicyOeohMhfKDKbEa1Uq6edvMQvLRtBMUV1LuE2YXP7TUKJ5cW8vqSlOm1JI3qzuRUI
 LvoQ==
X-Gm-Message-State: AOJu0YzjY8xGmbHjQsq3LTtw8opDwP9dk8Xs1XJqlAQyPd8aSjUmrGlT
 iVOUQ9RCAJWUhxLpsmtUvL2whZmXImRll3XA3gD8xdANACH3zZ8r2zgL0DgybLSg9D8=
X-Gm-Gg: Acq92OFimxlWRGRwoZyewuCRLAtP2inNUAdaDmfostQY4DmeqlwPjiMMsDLUd2QoSAo
 cd0ExKGYZTry9Mr15aMnuA+V0l3sObtiy8O/MWTnNyQ2y6PXOB3yNbzWiWN/Sb1tK56xGpqZW9w
 P02jQ8ZzBR1RWNeU6Vrux97v40vlP8pwQp9EkuYbzhFcfdlvTBkZbW3QNB2RuUUChntsScPZqBH
 8nBv80NkhL1CjFWjEuefTqR/4ea05nDCbTasKhPp/U4AtL2RLChJ54xODvhLHSqvBXEIUiecivD
 Ze/BB+ojGdmKokbsoCpF0t4thK5oGYZkPyKnfTQr4RxEhGBrjz0gtrvkoXpadu4NnOS5dYZCI98
 2oca8VZZDm+ujJBDEnYcV3PYFfbwN8HMYdKz/y7XYZlewOl5n2L9yOyHntKBo/pmW+VWe8oiLHo
 i44T0hPqvqzxEuJyGAmFc6HHRwhNZMArk2iVMIeAzzYaVqIQ==
X-Received: by 2002:a17:902:e74b:b0:2ba:5f24:caf8 with SMTP id
 d9443c01a7336-2ba7908c80cmr245771615ad.12.1778508293800; 
 Mon, 11 May 2026 07:04:53 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([115.108.63.147])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e90854sm105113435ad.66.2026.05.11.07.04.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 07:04:53 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V7 03/14] iothread: tracking iothread users with holder name
Date: Mon, 11 May 2026 22:04:05 +0800
Message-ID: <20260511140416.28271-4-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260511140416.28271-1-zhangckid@gmail.com>
References: <20260511140416.28271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52d.google.com
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

Introduce iothread_get_aio_context() with a 'holder' argument and its
counterpart iothread_put_aio_context().

Previously, users of an IOThread's AioContext did not explicitly
record their identity, making it difficult to debug which devices or
subsystems were pinning an IOThread.

This patch enhances the reference counting mechanism by:
1. Automatically incrementing the object reference count when a context
   is retrieved.
2. Tracking holders by name using iothread_ref() and iothread_unref().

In iothread_instance_finalize(), we now retrieve the source name from
the GMainContext to correctly unref the initial internal holder.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h |  3 +++
 iothread.c                | 33 +++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index 2871b06edc..313ef61124 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -70,6 +70,9 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
 AioContext *iothread_get_aio_context(IOThread *iothread);
+AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
+                                             const char *holder);
+void iothread_put_aio_context(IOThread *iothread, const char *holder);
 GMainContext *iothread_get_g_main_context(IOThread *iothread);
 
 /*
diff --git a/iothread.c b/iothread.c
index b805e4f97d..5d6f46d286 100644
--- a/iothread.c
+++ b/iothread.c
@@ -44,6 +44,12 @@ static void iothread_ref(IOThread *iothread, const char *holder)
     }
 
     iothread->holders = g_list_prepend(iothread->holders, h);
+
+    /*
+     * This guarantees that the IOThread and its AioContext remain alive
+     * as long as there is a holder.
+     */
+    object_ref(OBJECT(iothread));
 }
 
 static int iothread_holder_compare(gconstpointer a, gconstpointer b)
@@ -83,6 +89,8 @@ static void iothread_unref(IOThread *iothread, const char *holder)
     IoThreadHolder *h = (IoThreadHolder *)link->data;
     qapi_free_IoThreadHolder(h);
     iothread->holders = g_list_delete_link(iothread->holders, link);
+
+    object_unref(OBJECT(iothread));
 }
 
 static void *iothread_run(void *opaque)
@@ -200,7 +208,7 @@ static void iothread_init_gcontext(IOThread *iothread, const char *thread_name)
     g_autofree char *name = g_strdup_printf("%s aio-context", thread_name);
 
     iothread->worker_context = g_main_context_new();
-    source = aio_get_g_source(iothread_get_aio_context(iothread));
+    source = aio_get_g_source(iothread->ctx);
     g_source_set_name(source, name);
     g_source_attach(source, iothread->worker_context);
     g_source_unref(source);
@@ -419,13 +427,30 @@ char *iothread_get_id(IOThread *iothread)
 
 AioContext *iothread_get_aio_context(IOThread *iothread)
 {
-    /* Remove in next patch for build */
-    iothread_ref(iothread, "tmp");
-    iothread_unref(iothread, "tmp");
+    return iothread->ctx;
+}
+
+AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
+                                             const char *holder)
+{
+    /*
+     * In some cases, iothread user need the ctx to clearup other resource.
+     * When holder is empty, back to the legacy way.
+     */
+    if (holder) {
+        /* Add holder device path to the list */
+        iothread_ref(iothread, holder);
+    }
 
     return iothread->ctx;
 }
 
+void iothread_put_aio_context(IOThread *iothread, const char *holder)
+{
+    /* Delete holder device path from the list */
+    iothread_unref(iothread, holder);
+}
+
 static int query_one_iothread(Object *object, void *opaque)
 {
     IOThreadInfoList ***tail = opaque;
-- 
2.49.0


