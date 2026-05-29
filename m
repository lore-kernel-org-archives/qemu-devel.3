Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5629CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT4qC-0003J9-A3; Fri, 29 May 2026 17:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4qA-0003Im-Ae
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:02 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wT4q8-0002oT-GT
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:34:02 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-84229481d44so60010b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780090439; x=1780695239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lSVN7N0tEjZKy75a4H0lIBwRWq1dCfq0ezm3QlZHeNQ=;
 b=GT5SsdAAb/CvoZEm63yE4FRHWI0XHDZNxzvz452eHoHAjvprAAqXWtJ3nQoLLrZlNf
 hoizac+DZg/VfGva6nkdCC1+Otbh0Lja86yeJsNgNFPeOlPZziEgxpQKrGqpg0MgXId6
 AL+P61a+kkOgVDEeebd/8MVadhF/eR+b+5bo4eFugcjQhrYbwhsfjTQGEAjW6mQ0Oixd
 Sg7ZTAWZRfguIJYp2KQK5BPgDtLiuYwVQrPj2C7Mj8xOvcQZkToJpF8uILC2B8hK/Cur
 rl3Bs+khvd2P0i72yQEaOmKF9rmWD4Yc6avlwayLAPrDe70DZGFr947UNj1FKPqnptN4
 PJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780090439; x=1780695239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lSVN7N0tEjZKy75a4H0lIBwRWq1dCfq0ezm3QlZHeNQ=;
 b=iI+A6RrWjnA8yUa5+9eEs9qT0E/rpEM5Hb+I5erIgLUvBe9IBmqYjVrPXzCwftjAMS
 qnTwLjopmTW4+GmsHv6e9iNAieIT0sFF3m5lQQ0wsTEjFBwwphNGZDdpSTPdbuM+pG7v
 Fd2Pbf+sVFpRHiwQSJQt4ONRoqW4IqL8sMd0ulgIq+7TfPb0ZcFpPMvAC3WI72qH3Q41
 NunLfvcNNpzcgePaUJ6YCHQrC7Ajmzby67C9293gm4sNzTlBf4G5+a1Uf/HreKI1239u
 wfAhRzvk0b7ovw5vCMF4Os59UkN25ow538M5I2PyZ9HPOMuTtJlZ7RdSb/RVY/RTqSIK
 0ewA==
X-Gm-Message-State: AOJu0YxOa8WsRFd3epSTRTSt8K5gAiQeRKo+Y0rV/x9QWQGy4fSGtM5l
 5jnp85jdyaMYCGBvGdlIzo2WLgXKP9Rf6wZ+fwjYhOI+9+PR0KKlA+8PN+EwIaIagiw=
X-Gm-Gg: Acq92OFgLyRYikzO1hNk9lSPuCkXWrelzE0k6SqVAhzmI316CEnGB9H2dFoL5teeFED
 wv4fjZyd3xoXO/PJkAf89gFUfMgBMgqrWj5Z6rhckbDOd2dEZWVVbvThHRBUrVFkGoHxgCwlkZY
 0DpAB/G/TWHfQiUJJScdn8iIMyCvPzU20WpU1F7lnLBHO1dl65hmei4zVHDmG8xkkju9Lssh9tk
 L1ppjdap2vj2eQ6CG7WuE9MHbIBCxK9RstL77wKqezlvbxXVbcke6ZA+xYCGVxiJ343wWFYxUIC
 cQwFvGxBowbDrrIrhRfyEqnXL+rabJ66uOtdbTsdqYq3hDA8buOKiZKIGj6yOZK/LEvkOf7J41M
 wmc8XKGi40mqlnbP3tOdHMczq5OSNLsjXPHjcrHj6VItL9qoDZrfQ8Kvv1VQmvIOGIO4AGCQER3
 az17GvG9e80eCRIrYd+yxW1bN16Bjq9KSYrdsZiclDDU2X1Faf8J11+4nCk0n+RAA=
X-Received: by 2002:a05:6a00:3904:b0:82f:de7:d29 with SMTP id
 d2e1a72fcca58-842256d563fmr1234542b3a.31.1780090438981; 
 Fri, 29 May 2026 14:33:58 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214affe29sm2779564b3a.3.2026.05.29.14.33.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 14:33:58 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V8 03/15] iothread: tracking iothread users with holder name
Date: Sat, 30 May 2026 05:33:09 +0800
Message-ID: <20260529213321.96271-4-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260529213321.96271-1-zhangckid@gmail.com>
References: <20260529213321.96271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x432.google.com
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

Introduce iothread_get_aio_context() (In this patch named
"iothread_ref_and_get_aio_context" for build, will change the name
in the last patch) with a 'holder' argument and its
counterpart iothread_put_aio_context().

Previously, users of an IOThread's AioContext did not explicitly
record their identity, making it difficult to debug which devices or
subsystems were pinning an IOThread.

This patch enhances the reference counting mechanism by:
1. Automatically incrementing the object reference count when a context
   is retrieved.
2. Tracking holders using iothread_ref() and iothread_unref().

In iothread_instance_finalize(), we now retrieve the source name from
the GMainContext to correctly unref the initial internal holder.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h |  4 ++++
 iothread.c                | 31 +++++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index b9207ad829..b483bbfab3 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -18,6 +18,7 @@
 #include "qemu/thread.h"
 #include "qom/object.h"
 #include "system/event-loop-base.h"
+#include "qapi/qapi-types-misc.h"
 
 #define TYPE_IOTHREAD "iothread"
 
@@ -70,6 +71,9 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
 AioContext *iothread_get_aio_context(IOThread *iothread);
+AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
+                                             const IOThreadHolder *holder);
+void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder);
 GMainContext *iothread_get_g_main_context(IOThread *iothread);
 
 /*
diff --git a/iothread.c b/iothread.c
index 3301b8d495..528002c34a 100644
--- a/iothread.c
+++ b/iothread.c
@@ -55,6 +55,12 @@ static void iothread_ref(IOThread *iothread, const IOThreadHolder *holder)
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
@@ -109,6 +115,8 @@ static void iothread_unref(IOThread *iothread, const IOThreadHolder *holder)
     IOThreadHolder *h = (IOThreadHolder *)link->data;
     qapi_free_IOThreadHolder(h);
     iothread->holders = g_list_delete_link(iothread->holders, link);
+
+    object_unref(OBJECT(iothread));
 }
 
 static void *iothread_run(void *opaque)
@@ -223,7 +231,7 @@ static void iothread_init_gcontext(IOThread *iothread, const char *thread_name)
     g_autofree char *name = g_strdup_printf("%s aio-context", thread_name);
 
     iothread->worker_context = g_main_context_new();
-    source = aio_get_g_source(iothread_get_aio_context(iothread));
+    source = aio_get_g_source(iothread->ctx);
     g_source_set_name(source, name);
     g_source_attach(source, iothread->worker_context);
     g_source_unref(source);
@@ -442,17 +450,24 @@ char *iothread_get_id(IOThread *iothread)
 
 AioContext *iothread_get_aio_context(IOThread *iothread)
 {
-    /* Remove in next patch for build */
-    IOThreadHolder holder = {
-        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
-        .u.qom_object.qom_path = (char *)"tmp_path",
-    };
-    iothread_ref(iothread, &holder);
-    iothread_unref(iothread, &holder);
+    return iothread->ctx;
+}
+
+AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
+                                             const IOThreadHolder *holder)
+{
+    /* Add IOThreadHolder to the list */
+    iothread_ref(iothread, holder);
 
     return iothread->ctx;
 }
 
+void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder)
+{
+    /* Delete IOThreadHolder from the list */
+    iothread_unref(iothread, holder);
+}
+
 static int query_one_iothread(Object *object, void *opaque)
 {
     IOThreadInfoList ***tail = opaque;
-- 
2.49.0


