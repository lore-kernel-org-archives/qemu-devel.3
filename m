Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AE3F459ED
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDQF-0006dl-OW; Fri, 10 Apr 2026 11:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQB-0006YX-UW
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:24 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQA-0002Ce-3y
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:23 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35da2d35eccso1777732a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 08:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775833520; x=1776438320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mPLKHQIKiWNj5QAnc2OyjCMMfWZ4IzzJUVCAIUexiKU=;
 b=S4RVruJFr2YltKKsJ8tuhTFK1lUaKEYB0biUEaMxZbiZrJV/i/7PZXisQgfICSsBeR
 XPJgwL6OcuDRgmmL67KXXLfHMB/d59/p2wbXy9by9Z7eTzBx8Rn7BkuyeDKGkCrxg8hW
 h3NMZNbCZGCp6o914sBH7NBuADyhsfmeK0isbgNZMnI5XQXkcEsgHxvBryjleOVKmNMP
 mCIHuEjNqmBAnHG4kahzkYOaklWurTKTWc4/x/lvW4CmHaL3cdIrwrM7uIrO0RwweAsw
 5ZH+k3BA1GqYmsYIj6QSR9FiyD/zQcfug7mE678bvWcT6GNhjT36QSAWiA0MeOEGxK/U
 K0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775833520; x=1776438320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mPLKHQIKiWNj5QAnc2OyjCMMfWZ4IzzJUVCAIUexiKU=;
 b=W1OjpdfDlJ5yrtqQ3OdOgK5fFSZNnSuL1QirjdiMNILZI0lAqlKjbj5QZWlSOt1hgK
 1fQVcyFY8x5HtSsQp9uIU/Phyvm/zuMDrKfsLakkDCcYa+WV6z/+EiqSRC7Ng5W1+mXV
 Zynnl/4eZ1W9ptO3wYd7PjZ5JZ8b30TGTbY/l2ALgPYSaIlu9uu0Ew+l2En1+n0YPxmZ
 4el2O57yX0m8X8p8EJ+RUA8jEF8AIrxIgSWyoJfhB5ZIN9aZQTH8uu5oCj+vyeb/oSNh
 VZDPK/Yx2DTaa0HgvrdAsOFcxEFEzIx6JsUGVHNasIJM6Phoj6xpaYxFVycV1wxTeZ9P
 nw3Q==
X-Gm-Message-State: AOJu0YyJrV/1c+5lF0IyteyMtzSAZ8sqhwAoH/fRZSOW0mg/cXGJo+kH
 Jv73TF5MzZXp5rhL/FBqyKNyhhpuA+wws0N8x9lvu1bxuk50HQvIfFvWDwJkLa3o
X-Gm-Gg: AeBDietEQO5u6oUkyG570QCU8p8x4fSRllSgVROOHKFp4Nqm32L2sRqAA3Abt3OkEAT
 APsUcRDGTjLMb4xCMaU4w9xQOYqpBv59JM6Xf0EdTu/d1s2Ez9mgKOu15tjJJKxrKNhIYOhJAfm
 eGVvsmqz/0BCTwadfnwPpi+Y2tgiEanSo7XEsmZurmkuUfG0F//Ncq+OuoWrN//WAe1b1F5EBBa
 YOors4s2qz0atZpFACqrs4Y4X/BQi7LwYe1/Th1Brt97NwBDNCKy5HJoWOqigDWY+8JRXKR+B/R
 8q7V5x+cS1ea2mjF6PU14is8+KwYOIxW4AmODsZu4dHfHCfgjflIAJUzl+BagcPzlX7EXDVFQjY
 CkDfCwJRsc6PD2tof6AMv7JZptINJM2s5XojXO+HZkYtCWeS8HDyRZS4+v8S17XijGDFiEneXZN
 ba0zNo+X0+WHoihhir+mCgtJHlmISkxWaNwK15k+44KLnNlHx9KU0YIiEuDjj2Cv0=
X-Received: by 2002:a17:90b:350b:b0:35d:a2d3:5c44 with SMTP id
 98e67ed59e1d1-35e428581f9mr3562718a91.28.1775833519753; 
 Fri, 10 Apr 2026 08:05:19 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4131cfacsm3565785a91.10.2026.04.10.08.05.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 08:05:19 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V6 03/14] iothread: tracking iothread users with holder name
Date: Fri, 10 Apr 2026 23:04:46 +0800
Message-ID: <20260410150457.85190-4-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260410150457.85190-1-zhangckid@gmail.com>
References: <20260410150457.85190-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1030.google.com
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
index 21a76bd70d..dbada8249c 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -48,6 +48,9 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
 AioContext *iothread_get_aio_context(IOThread *iothread);
+AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
+                                             const char *holder);
+void iothread_put_aio_context(IOThread *iothread, const char *holder);
 GMainContext *iothread_get_g_main_context(IOThread *iothread);
 
 /*
diff --git a/iothread.c b/iothread.c
index c43266b191..60a024f770 100644
--- a/iothread.c
+++ b/iothread.c
@@ -52,6 +52,12 @@ static void iothread_ref(IOThread *iothread, const char *holder)
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
@@ -196,7 +204,7 @@ static void iothread_init_gcontext(IOThread *iothread, const char *thread_name)
     g_autofree char *name = g_strdup_printf("%s aio-context", thread_name);
 
     iothread->worker_context = g_main_context_new();
-    source = aio_get_g_source(iothread_get_aio_context(iothread));
+    source = aio_get_g_source(iothread->ctx);
     g_source_set_name(source, name);
     g_source_attach(source, iothread->worker_context);
     g_source_unref(source);
@@ -388,13 +396,30 @@ char *iothread_get_id(IOThread *iothread)
 
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


