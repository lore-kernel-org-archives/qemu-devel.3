Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6A3C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3SzQ-0005gs-Lx; Mon, 07 Sep 2026 02:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3SzP-0005gS-4U
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:37:59 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3SzN-00068A-9q
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:37:58 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2d9004f39d3so39436035ad.2
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 23:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788763075; x=1789367875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pz3DcON57YEbbfHibWzK/oVMwkZxaS7iLzoMd5bKkPw=;
 b=I8oMiyZEBFmHeuVJXcL6fKI0XCokEnolvP+/VR4X5QJIJcoOwipjHJn26yTVYZIIds
 uhDIW2C8M96/mbD7uIAdPDbq/pEFLM2q6VzxnSSC6pDMWcnSwObSX+98VuIpj+1aJbLt
 +23P+8LP7CROgEB+wcbkUAKQBZzk7dRUC4N2+5yWDKAE4A3PJxyUyMI8BFwK90xZPTmx
 ETvvllhlZxMfBpzNSmcb39+yTU9tMvyU/UlzJ+ttr5cZK4d9Xenuw7bDt2BtxXs0rU1P
 KGNHXnEbFoAXdLsRrlJvv3tYzoyt4u54H6am3QJt3nyUf5VKBSkKIPPz+dRWm0zqtSLC
 9EuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788763075; x=1789367875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pz3DcON57YEbbfHibWzK/oVMwkZxaS7iLzoMd5bKkPw=;
 b=meP5e1XyKOvhEEpvHWW5sqNHb4rthGPHJ+h7orj46izGYHzblr8foPQcxlOvuMIkmE
 CJgAszljlFbl16iKt3KiaD65jxjjzFuTftv7rnRRTxEybyHxSqhB2KBD7TjzZwmf8RNn
 xn1l6rLW1kL1+NQzpr1gSTTtmVlg93rY1zTNAtCAaYilONU0opuvsi+XLgfznflStojs
 USQq2NPDfkXnPgy9GDbQoQlBYk55cN8dzl48pQjao14fKk4PiEIXWBsFgcvDYSrnqeEW
 7wWOU7YdSf77/d+Ryt/26KGCYVJ+MkrMTtiqKoZbbCUWhJuqUhEjv6ffMVv4//YQ3aaI
 VYYQ==
X-Gm-Message-State: AFuF++nI8gnZuQONUNSXRjZTiqyiRC8sDF7L/qt4V5SVdYeCoJjvB2xZ
 WL/c6flySwTeVV+p5azE2WswAd2xmDbmbrpCBNLyckOCPgE4ND1BtT1OT+u08LvBJ2FU0g==
X-Gm-Gg: AYBFou23kKMNQV5Il+lNZC9VT7UuT0791MysfoqbZjYV6fTfOUDlPFLg57rk4p6Vz7Z
 6o+ubNuiFeotg1jHsZMFxa+c1/JnAn0YDaMcqx+BdX1F4DEsHNG01zGXQWZpe2LzCUDHhvsm0ms
 jW6mW7nSYebtQ0jtv1Ox7/Cq5Ytm6ko3cQkoxXeMYPl1nFLT7R1sWTvDFRo9qIMdHxqbDzIgCQJ
 EPU8jv1mrad84yJXHd6AqBeD/7g1AtdSkPnNqZLczK7xY7szmxh2yuP7y6xzkiClP40J271AddG
 C22GFvVwH98z8udVK7K1dOjk5x7y7VYTJsKBo4OvEEYFmSmvTXm1yUtFo3yLpJB8jefijLD1dbO
 OOFupmqHrlz1gF5v6mbGI3mJ2nojZMveU8ix9y6uo+eVqLK5jeE1LhHLoMyzKuSfZqPD1+w3KmQ
 1xYTYYVvHNrwHux9Qjnnj0n2j0snKsZD7+N2QJNGSWq5u/a1+QMPaSHtns/38Zeb3prI1nyn90f
 A7r2v5qthPsG7H7NRXI0BkjQhQ=
X-Received: by 2002:a17:902:c40f:b0:2d7:107c:917b with SMTP id
 d9443c01a7336-2db1212ee51mr291909715ad.0.1788763075408; 
 Sun, 06 Sep 2026 23:37:55 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f06fsm38502555ad.54.2026.09.06.23.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:37:54 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V15 03/14] iothread: add holder-aware AioContext accessors
Date: Mon,  7 Sep 2026 14:37:14 +0800
Message-ID: <20260907063725.626685-4-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907063725.626685-1-zhangckid@gmail.com>
References: <20260907063725.626685-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x635.google.com
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
index 66dfde626e..58dace351c 100644
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


