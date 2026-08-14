Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C86C5DF6A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 17:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuw1W-0004CS-OS; Fri, 14 Aug 2026 13:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw1V-0004CE-I8
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:48:53 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw1T-0007kG-St
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:48:53 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-84faf0fa17eso1281766b3a.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 10:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786729730; x=1787334530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dQ/KuX/MBgL7qfTb1BChs18OU2J7uJeBc8kyKIdz7rs=;
 b=Sd6xcLDT5vF+jT0gbYqSvLaqna3wO04UCBeGWxJq8uRXjuCnJT4GmeyRVZFIimUwA7
 UM0YUwvEDZMR50lIsWnvFkCXbwlWDoDP5qcLNZA2deMPUoBqYIlqV43yYwko+ypeZyMG
 Qnpl7W1U+IbFd9ZKXKic+khyojDqPq2pybr6UoU0bQaV2hbszDtk3xR9nSqK7asa/l6i
 CwkQWXLg65rmRxYulyIM+rYEc2tsj9X9Q/hUpVK4sZI/l/vRn0M/j3nRTq/yceiVXEi6
 glLXVjlI3ot8X73VXhXlo+f0JqYsrCdvJCEeuA59k6PGyUrCbyn3zohX2PeTrn066OQv
 3Tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786729730; x=1787334530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dQ/KuX/MBgL7qfTb1BChs18OU2J7uJeBc8kyKIdz7rs=;
 b=c0SYpuVG2dooiDQNiVOBfmmkWAr8PDiU+cfLDOMVPQUSRntgGXDAQNwAy4pBmYODgz
 B1q9yzf+7UAnAbftdYXgm2wOqPu85n6KqlgPQZHqsiirhvURU3/XVUpNmWdXVSAtwEpY
 VdQi46nmojMpbkvYBzU4YXEozIqFLi5gMp4UHOJw9QxKS2WJMHeV3tGGb/EyuTMBpp+g
 vryuHyShEgFXnWzSVEWhKiCHNsSxPTRCV0fVOJI/JAxT0sd8iP2vVd2cbGXfIQ/Qk3Te
 VF857C9iAmFZy1By84G9e63heDMkejnTDgQ3XaiWCg+9NvajwQ40CC6KlRxYqMFEb0He
 IiRQ==
X-Gm-Message-State: AOJu0YysNZltyBvJgMySmjxe6SBHOraHwJynBp0j/TzsdiD1EfgmNbNF
 s4o50zbdf6BC6q00HOV8MuSQ/QwvfY52spn0CHEFnXSrYiO4lm77ivkNQGnDFw==
X-Gm-Gg: AR+sD11sVYGBbn9aiduPCacy6J8ebUZZ9gl+LMMzQhSy1sXm6QSDhnpbJCNxZUAqmTT
 uYkogTsnNWE7D39vjSfBfWlkNyIaH1ffkGMin/uFzj3PZLt3Qhter1tOhMASNFklaMje9+dCV8y
 FAKqLyGrZYLe7+RJUL3WlNd3jL/AgxrhTsk68ohQ8IptB7GyfJz03UXyScPMIw55I1eQYz7YG2Y
 Umqn2wt62UySyXg1q59qjuS5zLzEOuMn3S2T5RT2yY3aJfhIHgq8261kvXxQc542aqucAUaOSe/
 iu7zEtS5jgSEgsjO6q1tXuvVe76Nc5lh8E0KnOSRfj1y4SM0n9Ak4t7MZ6Vwc9v6WpPdsCRtUw9
 atHFr1+8O7fRhNOkqHlwGXIUobmtleP3iS2wH1KZ7C5T3kw0LBDwiw7IyaKNdpZGp6QvGGl3/j4
 TL/j3PQEUyNBeBq31gpigXCLxGhLJw7TwN/vv0kVe59ow+kb6TTx7ANmzzRfq8azWXd8i4Z3B3b
 HinmZfP
X-Received: by 2002:a05:6a20:12c8:b0:3c1:85d:fa2f with SMTP id
 adf61e73a8af0-3cc71eb2723mr7910952637.36.1786729730545; 
 Fri, 14 Aug 2026 10:48:50 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320e9df03f9sm6708081eec.19.2026.08.14.10.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 10:48:49 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V12 03/15] iothread: track users with holder name
Date: Sat, 15 Aug 2026 01:48:17 +0800
Message-ID: <20260814174830.1691540-4-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814174830.1691540-1-zhangckid@gmail.com>
References: <20260814174830.1691540-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x435.google.com
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

Introduce iothread_ref_and_get_aio_context() with a holder argument
and its counterpart iothread_unref_and_put_aio_context().

Previously, users of an IOThread AioContext did not explicitly record
their identity, making it difficult to debug which devices or
subsystems were pinning an IOThread.

Registering a holder takes an IOThread object reference so that the
IOThread and its AioContext stay alive until the matching put
operation. Document the ownership and BQL requirements.

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
index 2a4c92e08b..64be852d1c 100644
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
2.54.0


