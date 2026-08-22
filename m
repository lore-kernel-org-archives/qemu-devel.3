Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85BEC5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 21:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxtM3-0003eD-8N; Sat, 22 Aug 2026 17:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtM2-0003dn-2l
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:18 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtM0-0000fY-HS
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:17 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cbb8b54fcf8so2212009a12.0
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 14:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787434455; x=1788039255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rMyDEXSasPWxbd315x54YJsjP/j+H9a0KUGXEiE3g1w=;
 b=gjiyU80uHwDLI5S0D5wOfIyKhYrhpNID1z4nPjgkv4dvVncAoNJwcXjnvUevwm56US
 6otBcd9SIka+9SZ+jigR+9E9t0b0FOgbY4fGTzhxc5Rw2/URTVz8zZ40Q5ObwEIO/zMt
 J5chKfg9TjX2nRH6MWPbrKKzPy/XLi4Xg1gODrnSUX94QTx1B8Xm4n0XIYhjYJ/eUNk4
 f889FJ3QgWR8KOl81icjRpao1i0/PjFYS1UCAE+QBNIzieBij9zWOkYt3jW/m6tqH6fp
 x/YuhaVj1YujfLth5JbZCsekXKwEajxQSC/TruJ5z+wlX4287tMUnWcRjEcz3/0NuyFU
 8ZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787434455; x=1788039255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rMyDEXSasPWxbd315x54YJsjP/j+H9a0KUGXEiE3g1w=;
 b=C8hTRm0bdJj0vBqFEifI0y9Al0SpVJZVK0wUrHODfhIRckuvxncAk4CqJ1SJloPTzR
 O4FFEjF8DKHLrGLY6kUkzV4wIi7KnllD1W0E8q8s98Dvao30HBCC9kFxFOu9imIcd4Am
 PZKJSmdItdEfdPeJyosUv3pi6LGFzjqHZPxD93O2mLpQDQ5dylCIxxzUFN7I9UgZa1KI
 u9oHyKGAOOV2/2mJYX3gYU0CAtE83RpbRK/I91bP8EOdId6zy8jG3z+fvCe+4lA/+d1K
 Yxa90DG9+3IPDiLKgp+sA5H7GkigooruFfBm9A1qN77Q2RGQhrRYKSJnPo+XLqE7vRo/
 6Cfg==
X-Gm-Message-State: AFuF++m+li+CVSu86WV4uHu562R4Rb/1PqGnkjjRNpCkI9E63/CDyUoQ
 531Mge9Zbi7qHw8HfIpwIj73W0Qq65dUzPDGRxZ5lSKdGZrsDxeH2cUvX7KNzykOsEWyGNUN
X-Gm-Gg: AR+sD10qjZnvK2zdlLIONIaUY8nB218TUpRBmJohmckDFV2fnkVA5Zi4hzdBpQR3lV5
 CHV6tXSCopXink9HnZB6l2SnRtY+DlnOWPSPjrjR0KLKdfl16QZeZEWJIwhkHXAt+ijPAK6ozag
 i7d8Q03TpA1SHcUpQR4D9TUQRbfaw51vKKLmg/QEymW8ytqwKJ1duKcCLyukZ+XmkM6WLGRQsz/
 wUZPL2X05e9No/0u8RkWN9LegxQqaWp7PgrXOiVUYuwfMNcHG6ZbS4sWp5U8/EBTcDJdW4yBsw+
 DbR7p04Dl8glf7kQ/5XbptEoDvRdJlbHoxffVNC6ih0UNpkFNX1TPmnoOsBlAsPtl+acPSc/Oly
 k6375ubGG15+Xh+W7VlULvBLh3433pozcBtmDFOiDkCdmwnzS2E1kysgd4x4wf4YkbmXmLYW2ph
 9+uQbvUIMfi6DX/o5yD1bfc9OKV3mgIbETiPkN1tBvPuiUfKevlUBJ1OSo1cWZoKkHq3llVYZ0J
 hMINYeXuw==
X-Received: by 2002:a05:6300:6d8c:10b0:3cd:4fa5:1b88 with SMTP id
 adf61e73a8af0-3cd4fa51bcbmr8515340637.0.1787434455095; 
 Sat, 22 Aug 2026 14:34:15 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f909c6c9sm11633181eec.6.2026.08.22.14.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 14:34:14 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V13 03/15] iothread: track users with holder name
Date: Sun, 23 Aug 2026 05:33:26 +0800
Message-ID: <20260822213343.661939-4-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822213343.661939-1-zhangckid@gmail.com>
References: <20260822213343.661939-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.55.0


