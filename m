Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74C0F33A72
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9dj-0003xL-WC; Thu, 05 Mar 2026 09:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9di-0003uQ-AO
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:22 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9dg-0001mk-Ms
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:22 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ae3a2f6007so38794635ad.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 06:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772720719; x=1773325519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9E8rIVeqctfa15bpIWUAXH63OIyPCVMKEx9yQ3jDexs=;
 b=Udt6f5M2w64NeHx8V5KQPfCPyTnLce4X/pcjhG2WC1beN9VTgRWj0GdlxqO3YutPkH
 FDY6Aweei8gTWv51T3f8JCFZapvlyYORkbd19a1OdZDRgjV/AGUuxbf5Quu92Qt10lNA
 PwejGJIekK+Q0xQMnelp5pPlScaPUE27CLk6UtcifpBmv+rI2F8PQd3XOFSsDq1Mihwx
 PTdrmoGbdCBPFfzjGOOYURKI8pV3h1Kd9VNsbQhlxkEWwwIisCXmkHYs5wj0PE7CTlCe
 GLbWP3ov5oNnJB7wQ+0cAJjxLMKVAK/s5w1haxaZikbKwpPZJ27xaSm1BMX1biB+dvEU
 aovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772720719; x=1773325519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9E8rIVeqctfa15bpIWUAXH63OIyPCVMKEx9yQ3jDexs=;
 b=ABS96Mnst71Sc7kU4QejTPgmowapXiosqZ2B3f+Z28QKgma8sWjCNRIaMGxL8Rj8Nq
 q7QyYVG3EHHgAvdR/a1DDAcvKP7qQCGnEIMlVXm6OHwk1uJswO4gsg8FwNCA8Vm1rEvJ
 /LCMidlICHJjo25gXYjgmTos8kL+Pv8qGUFNOiif1W16TWRCPKYtrVYxQc73qc4+aTE/
 QyMebNWp2IlnPwconE8+RPu/K2F2SoBTgZeHfbpmCGVYSCj3rotzTlyRIl/94ADlizY4
 gQB5ebfuHOxDfSR+4C0pLSYxSGj0/hN1is/GS7EJbTeZA5A6YW3M0WpXFE7X/X4JRhax
 S4EQ==
X-Gm-Message-State: AOJu0YyCg9DFjVpqBH/B1YdRSoUzM0JhkAjOBwGumhmghvVhCKB1zoVC
 l8jJzmoOPIiM+M9rhm3uEqEqWC1viAKQnqSHwLnepsmvXEI20O8gnBzJoP7j22Zw1LN9OQ==
X-Gm-Gg: ATEYQzwJXMxTeD7x5MYZ7jMqZQhieP+FA4vFVbhGPIy7/zekm8+mS3TuW1E0w+oYNgC
 3Esrxqpyd6tATs39fbXC0M327yKJx1TIl5Dts6f3WNsVYslAlGINt88fLndmNj4sGxEIemVcPKz
 HURWHMSf9/l0PEzAEUArt9D/hSwQhzx43W047Rgci3Bx50lsv1IY1Ko9QvStIZUIrOfm/FV6VDA
 fwknVMOXQmkgBsF5zEJMQ+lfp2PAxF30EAGpv456V78ojxrON3Jm3NAA4BNJOmnGyKOWp7HLORd
 yhuIzvBgEqCX+9iqRKAGDKDWV6DUJRGslgEDqsgU8EKEPgibLaUVn84EUbC9oG+NYuwZCHgnP6k
 azT4QE2DE0+hLaO+mDWoA/DI/wDTnYZemikPXGGQQGlx4ZG0v+S2NU2rQn9f4YXRG8ckDagcjSI
 tCQb6A2NzGnf+Qh1XF/GeO6bHOcLalYfb9q6+NadRxAz6qVou+HQuXp2l4PNBBRXoP03eGZdJNa
 OGP+A==
X-Received: by 2002:a17:902:d58e:b0:2a7:757b:35a1 with SMTP id
 d9443c01a7336-2ae6ab1f396mr70614405ad.38.1772720718769; 
 Thu, 05 Mar 2026 06:25:18 -0800 (PST)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49:0:1:b277]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae4650000dsm140204835ad.54.2026.03.05.06.25.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Mar 2026 06:25:18 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V5 03/13] iothread: tracking iothread users with holder name
Date: Thu,  5 Mar 2026 22:24:49 +0800
Message-ID: <20260305142459.52559-4-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260305142459.52559-1-zhangckid@gmail.com>
References: <20260305142459.52559-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62b.google.com
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
 include/system/iothread.h |  3 ++-
 iothread.c                | 28 ++++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index 21a76bd70d..595abeefbe 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -47,7 +47,8 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
-AioContext *iothread_get_aio_context(IOThread *iothread);
+AioContext *iothread_get_aio_context(IOThread *iothread, const char *holder);
+void iothread_put_aio_context(IOThread *iothread, const char *holder);
 GMainContext *iothread_get_g_main_context(IOThread *iothread);
 
 /*
diff --git a/iothread.c b/iothread.c
index 80a8cf4b32..da98fbb9ad 100644
--- a/iothread.c
+++ b/iothread.c
@@ -172,7 +172,8 @@ static void iothread_init_gcontext(IOThread *iothread, const char *thread_name)
     g_autofree char *name = g_strdup_printf("%s aio-context", thread_name);
 
     iothread->worker_context = g_main_context_new();
-    source = aio_get_g_source(iothread_get_aio_context(iothread));
+    /* No need setup itself as the init holder */
+    source = aio_get_g_source(iothread_get_aio_context(iothread, NULL));
     g_source_set_name(source, name);
     g_source_attach(source, iothread->worker_context);
     g_source_unref(source);
@@ -362,11 +363,34 @@ char *iothread_get_id(IOThread *iothread)
     return g_strdup(object_get_canonical_path_component(OBJECT(iothread)));
 }
 
-AioContext *iothread_get_aio_context(IOThread *iothread)
+AioContext *iothread_get_aio_context(IOThread *iothread, const char *holder)
 {
+    /*
+     * In some cases, iothread user need the ctx to clearup other resource.
+     * When holder is empty, back to the legacy way.
+     */
+    if (holder) {
+        /*
+         * This guarantees that the IOThread and its AioContext remain alive
+         * as long as there is a holder.
+         */
+        object_ref(OBJECT(iothread));
+
+        /* Add holder device path to the list */
+        iothread_ref(iothread, holder);
+    }
+
     return iothread->ctx;
 }
 
+void iothread_put_aio_context(IOThread *iothread, const char *holder)
+{
+    object_unref(OBJECT(iothread));
+
+    /* Delete holder device path from the list */
+    iothread_unref(iothread, holder);
+}
+
 static int query_one_iothread(Object *object, void *opaque)
 {
     IOThreadInfoList ***tail = opaque;
-- 
2.49.0


