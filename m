Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B95C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6QEf-0003Lk-0o; Tue, 15 Sep 2026 06:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6QER-0003Jo-3s
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:17:43 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6QE7-0002n0-RT
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:17:42 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccc02279so2817716a91.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 03:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789467433; x=1790072233; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ffn71e+pIgrmkpZMSuNM3s3wiDknQ8z6eWqR0ElZS0U=;
 b=q9R2PQ5Zla41P22ehTVqkUKer2kZGhpWjfKgozWcUmsOoh6nCUxvEOYXc/c7cLjYWM
 VWNzVlNVr4EbUVpBSShYgntpNLyGLfro9cfBKdSuCAWhAHsSByPOTIl+YjEZx3wIfS9w
 KXOfRp6tSScV5toK457eBMMTJ/cwFl6sd2nEY91bcVIncfsttnC4rnwm2IXHY8JDfvC9
 vuz4KfgysUm4QIsLvRxtvHW0XWo3gWWtTgfnWRIyhOJojdVzekDFKkr8npZMecx/sRGd
 TmTi5WwVJ0cKeom5puRj4zMdP6TDK7oj7gMhASTlDztoWYHfJs6ExoTii5RKwTlpI5VO
 3WxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789467433; x=1790072233;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ffn71e+pIgrmkpZMSuNM3s3wiDknQ8z6eWqR0ElZS0U=;
 b=QM9kjAcCK+tJ2xAGwY0qpUBHXdl8KtL5peO0p1sK+TuBqRo0ZLzNmepUQeLy4LC9g6
 7bK/nwyogovJwaOnza1M3f9i1a58mVgxvPWBq6WIfKglQpP+Os7ItQ2sVaJxZG1R0t5k
 Cu6qlMZvCOIC68xm6Wyk0gBEIzMZrWQ/RbPrTzCHCT8Iko7zHXnGmk/NrtikMuDQ5tOQ
 b+KRtpWKp17lsSz/Rf6XFJghfY812BfiogWKZQvmKYvyctx1Dsd+GyBLt5Ic0Jwye6rX
 /A2wZGLvOM1YgDwymGhGhDX0pvpPWmnvvHUDP9wOJ4wQtvbpZPyyZS9LknGwHIuXsz+K
 zeYg==
X-Gm-Message-State: AFuF++kvHL97o9REA/ajIy3ZnbMbYwjwHt1pu22C5I1dtsEmIWxKzhUn
 3oaXu18PiW2hESYyJA3baeXQBORY72OyjZbDojiK0SqkOIZHFCB7ardoc06mYu68GTg=
X-Gm-Gg: AYBFou3zAUHe2xVKgmZsK9oe4dHUMxc4kNa/6O1cpbMCjnSohmBpOqBPfd+o3U0i6XH
 6G1IYZaAsfneNTckEYEthKqp5XZAiiC//QVACXXJm6+OcS+Hh2m33jvMz/OA3bXE4+J2n2WQRM5
 swg4WYjIQIT6SkCECkcXAmi2S7E6agN0adqvX7PC8Itm6s1rdhVaVGWmZnZQQ1zJZSX31PTfeiD
 31WPBewV9bGJI+4DljpwnEXj9R17Tn/sDMOEpzADEs1GcYFAk5pjlyBNygqkaov8MrrbuhQ5k+3
 SxLgkRO0UBBlCapr6p/rk5Z8G6TA1YaBFNaA9W0xIHGG8bQF0IxiaWOVZTB2SPXyKGsjj2SI/1v
 SzOFgKEgxV7EhV8uWJS86SFXQl9lm8uv8joJzHr0MaleOYjFDjdnN+fOMtzrHcwVESP1M/eRLEx
 9RUtXYTn8IpZXJjXIU/gL/17WVxAZJi+NNawM2pQ0D2aDt5C89aPzp8McyqCUCwdFPm+GdvvPyz
 CAGR67zq0dWun2xuoEH8wj0h9y+ZrcrFBw9wQ==
X-Received: by 2002:a17:90b:1dc6:b0:39d:84af:a0b3 with SMTP id
 98e67ed59e1d1-39dec09cf6dmr13687164a91.18.1789467432842; 
 Tue, 15 Sep 2026 03:17:12 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdacba6bsm4416868a91.14.2026.09.15.03.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 03:17:12 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V17 02/13] iothread: add holder-aware AioContext accessors
Date: Tue, 15 Sep 2026 18:16:44 +0800
Message-ID: <20260915101655.3216101-3-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915101655.3216101-1-zhangckid@gmail.com>
References: <20260915101655.3216101-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=zhangckid@gmail.com; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce iothread_ref_and_get_aio_context() with a holder argument
and its counterpart iothread_unref_and_put_aio_context().

Previously, users of an IOThread AioContext did not explicitly record
their identity, making it difficult to debug which devices or
subsystems were pinning an IOThread. These new helpers provide the
infrastructure for callers to register their identity. Subsequent
patches convert existing users to the new helpers.

Registering a holder takes an IOThread object reference so that the
IOThread and its AioContext stay alive until the matching put
operation. Document the ownership and BQL requirements.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h | 22 ++++++++++++++++++++++
 iothread.c                | 24 +++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index b8aeb32b0e..f6c5f95dd9 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -67,6 +67,28 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
 AioContext *iothread_get_aio_context(IOThread *iothread);
+
+/*
+ * Register @holder and return @iothread's AioContext.  The holder is copied,
+ * and a reference is taken on @iothread so that both the IOThread and its
+ * AioContext remain alive.
+ *
+ * The caller must eventually call iothread_unref_and_put_aio_context() with an
+ * equivalent holder.  This function is not thread-safe and must be called
+ * under the Big QEMU Lock (BQL).
+ */
+AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
+                                             const IOThreadHolder *holder);
+
+/*
+ * Unregister @holder and release the corresponding reference on @iothread.
+ * Calling this function without a matching
+ * iothread_ref_and_get_aio_context() call is a programming error.
+ *
+ * This function is not thread-safe and must be called under the BQL.
+ */
+void iothread_unref_and_put_aio_context(IOThread *iothread,
+                                        const IOThreadHolder *holder);
 GMainContext *iothread_get_g_main_context(IOThread *iothread);
 
 /*
diff --git a/iothread.c b/iothread.c
index 6b0a7c557a..5a4291a2f0 100644
--- a/iothread.c
+++ b/iothread.c
@@ -33,6 +33,11 @@ void iothread_ref(IOThread *iothread, const IOThreadHolder *holder)
     assert(holder);
 
     QAPI_LIST_PREPEND(iothread->holders, QAPI_CLONE(IOThreadHolder, holder));
+    /*
+     * This guarantees that the IOThread and its AioContext remain alive
+     * as long as there is a holder.
+     */
+    object_ref(OBJECT(iothread));
 }
 
 static int iothread_holder_compare(const IOThreadHolder *holder_a,
@@ -78,6 +83,7 @@ void iothread_unref(IOThread *iothread, const IOThreadHolder *holder)
             *prev = curr->next;
             curr->next = NULL;
             qapi_free_IOThreadHolderList(curr);
+            object_unref(OBJECT(iothread));
             return;
         }
         prev = &curr->next;
@@ -199,7 +205,7 @@ static void iothread_init_gcontext(IOThread *iothread, const char *thread_name)
     g_autofree char *name = g_strdup_printf("%s aio-context", thread_name);
 
     iothread->worker_context = g_main_context_new();
-    source = aio_get_g_source(iothread_get_aio_context(iothread));
+    source = aio_get_g_source(iothread->ctx);
     g_source_set_name(source, name);
     g_source_attach(source, iothread->worker_context);
     g_source_unref(source);
@@ -421,6 +427,22 @@ AioContext *iothread_get_aio_context(IOThread *iothread)
     return iothread->ctx;
 }
 
+AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
+                                             const IOThreadHolder *holder)
+{
+    /* Add IOThreadHolder to the list */
+    iothread_ref(iothread, holder);
+
+    return iothread->ctx;
+}
+
+void iothread_unref_and_put_aio_context(IOThread *iothread,
+                                        const IOThreadHolder *holder)
+{
+    /* Delete IOThreadHolder from the list */
+    iothread_unref(iothread, holder);
+}
+
 static int query_one_iothread(Object *object, void *opaque)
 {
     IOThreadInfoList ***tail = opaque;
-- 
2.43.0


