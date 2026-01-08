Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EA2D1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdtR5-0004bD-FM; Thu, 08 Jan 2026 12:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtQx-0004P8-Lg
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:04:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtQv-0006vb-Uq
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767891865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lE1EdAR5TOYWlHIJcWjnUVb3ph2s51JydubRi351Nx4=;
 b=Y29n4eaiwq11dfOk41qgaN6JXQz3OUSrR2vbZ2XdADLd9nkyUrMFs+jiafC6GBmnl91JPN
 DyLWj4UxQjRYi7sD5BZFR2tVi0gn1lJJw66KJjFwan3qjTmchE/gZ8BfEZ4wPJ0V3tPKRf
 V4zFohk7dJnTGvFKYXXSkfJ62dGuPsU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-ETS0T5apO0-jlD89AKwWpw-1; Thu,
 08 Jan 2026 12:04:22 -0500
X-MC-Unique: ETS0T5apO0-jlD89AKwWpw-1
X-Mimecast-MFC-AGG-ID: ETS0T5apO0-jlD89AKwWpw_1767891861
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 269E519560A1; Thu,  8 Jan 2026 17:04:21 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.44])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C6CE419560B4; Thu,  8 Jan 2026 17:04:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 08/24] util: add API to fetch the current thread name
Date: Thu,  8 Jan 2026 17:03:22 +0000
Message-ID: <20260108170338.2693853-9-berrange@redhat.com>
In-Reply-To: <20260108170338.2693853-1-berrange@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This will be used to include the thread name in error reports
in a later patch. It returns a const string stored in a thread
local to avoid memory allocation when it is called repeatedly
in a single thread. The thread name should be set at the very
start of the thread execution, which is the case when using
qemu_thread_create.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/thread.h    |  1 +
 meson.build              | 21 +++++++++++++++++
 util/qemu-thread-posix.c | 33 ++++++++++++++++++++++++++-
 util/qemu-thread-win32.c | 49 ++++++++++++++++++++++++++++++++++++----
 4 files changed, 99 insertions(+), 5 deletions(-)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 27b888ab0a..98cc5c41ac 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -216,6 +216,7 @@ void qemu_thread_get_self(QemuThread *thread);
 bool qemu_thread_is_self(QemuThread *thread);
 G_NORETURN void qemu_thread_exit(void *retval);
 void qemu_thread_set_name(const char *name);
+const char *qemu_thread_get_name(void);
 
 struct Notifier;
 /**
diff --git a/meson.build b/meson.build
index db87358d62..eb27aca329 100644
--- a/meson.build
+++ b/meson.build
@@ -2874,6 +2874,27 @@ config_host_data.set('CONFIG_PTHREAD_SET_NAME_NP', cc.links(osdep_prefix + '''
     pthread_set_name_np(thread, "QEMU");
     return 0;
   }''', dependencies: threads))
+
+config_host_data.set('CONFIG_PTHREAD_GETNAME_NP', cc.links(osdep_prefix + '''
+  #include <pthread.h>
+
+  int main(void)
+  {
+    char buf[16];
+    pthread_getname_np(pthread_self(), buf, sizeof(buf));
+    return 0;
+  }''', dependencies: threads))
+config_host_data.set('CONFIG_PTHREAD_GET_NAME_NP', cc.links(osdep_prefix + '''
+  #include <pthread.h>
+  #include <pthread_np.h>
+
+  int main(void)
+  {
+    char buf[16];
+    pthread_get_name_np(pthread_self(), buf, sizeof(buf));
+    return 0;
+  }''', dependencies: threads))
+
 config_host_data.set('CONFIG_PTHREAD_CONDATTR_SETCLOCK', cc.links(osdep_prefix + '''
   #include <pthread.h>
 
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index afeac9ecad..47156b60ce 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -18,7 +18,7 @@
 #include "qemu/tsan.h"
 #include "qemu/bitmap.h"
 
-#ifdef CONFIG_PTHREAD_SET_NAME_NP
+#if defined(CONFIG_PTHREAD_SET_NAME_NP) || defined(CONFIG_PTHREAD_GET_NAME_NP)
 #include <pthread_np.h>
 #endif
 
@@ -532,3 +532,34 @@ void *qemu_thread_join(QemuThread *thread)
     }
     return ret;
 }
+
+/*
+ * This is not defined on Linux, but the man page indicates
+ * the buffer must be at least 16 bytes, including the NUL
+ * terminator
+ */
+#ifndef PTHREAD_MAX_NAMELEN_NP
+#define PTHREAD_MAX_NAMELEN_NP 16
+#endif
+
+static __thread char namebuf[PTHREAD_MAX_NAMELEN_NP];
+
+const char *qemu_thread_get_name(void)
+{
+    int rv;
+    if (namebuf[0] != '\0') {
+        return namebuf;
+    }
+
+# if defined(CONFIG_PTHREAD_GETNAME_NP)
+    rv = pthread_getname_np(pthread_self(), namebuf, sizeof(namebuf));
+# elif defined(CONFIG_PTHREAD_GET_NAME_NP)
+    rv = pthread_get_name_np(pthread_self(), namebuf, sizeof(namebuf));
+# else
+    rv = -1;
+# endif
+    if (rv != 0) {
+        g_strlcpy(namebuf, "unnamed", G_N_ELEMENTS(namebuf));
+    }
+    return namebuf;
+}
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 8ca6429ad3..082a38c7d5 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -19,7 +19,10 @@
 
 typedef HRESULT (WINAPI *pSetThreadDescription) (HANDLE hThread,
                                                  PCWSTR lpThreadDescription);
+typedef HRESULT (WINAPI *pGetThreadDescription) (HANDLE hThread,
+                                                 PWSTR *lpThreadDescription);
 static pSetThreadDescription SetThreadDescriptionFunc;
+static pGetThreadDescription GetThreadDescriptionFunc;
 static HMODULE kernel32_module;
 
 static void __attribute__((__constructor__(QEMU_CONSTRUCTOR_EARLY)))
@@ -28,7 +31,7 @@ qemu_thread_init(void)
     qemu_thread_set_name("main");
 }
 
-static bool load_set_thread_description(void)
+static bool load_thread_description(void)
 {
     static gsize _init_once = 0;
 
@@ -38,14 +41,17 @@ static bool load_set_thread_description(void)
             SetThreadDescriptionFunc =
                 (pSetThreadDescription)GetProcAddress(kernel32_module,
                                                       "SetThreadDescription");
-            if (!SetThreadDescriptionFunc) {
+            GetThreadDescriptionFunc =
+                (pGetThreadDescription)GetProcAddress(kernel32_module,
+                                                      "GetThreadDescription");
+            if (!SetThreadDescriptionFunc || !GetThreadDescriptionFunc) {
                 FreeLibrary(kernel32_module);
             }
         }
         g_once_init_leave(&_init_once, 1);
     }
 
-    return !!SetThreadDescriptionFunc;
+    return (SetThreadDescriptionFunc && GetThreadDescriptionFunc);
 }
 
 static void error_exit(int err, const char *msg)
@@ -331,7 +337,7 @@ void qemu_thread_set_name(const char *name)
 {
     g_autofree wchar_t *namew = NULL;
 
-    if (!load_set_thread_description()) {
+    if (!load_thread_description()) {
         return;
     }
 
@@ -415,3 +421,38 @@ bool qemu_thread_is_self(QemuThread *thread)
 {
     return GetCurrentThreadId() == thread->tid;
 }
+
+static __thread char namebuf[64];
+
+const char *qemu_thread_get_name(void)
+{
+    HRESULT hr;
+    wchar_t *namew = NULL;
+    g_autofree char *name = NULL;
+
+    if (namebuf[0] != '\0') {
+        return namebuf;
+    }
+
+    if (!load_thread_description()) {
+        goto error;
+    }
+
+    hr = GetThreadDescriptionFunc(GetCurrentThread(), &namew);
+    if (!SUCCEEDED(hr)) {
+        goto error;
+    }
+
+    name = g_utf16_to_utf8(namew, -1, NULL, NULL, NULL);
+    LocalFree(namew);
+    if (!name) {
+        goto error;
+    }
+
+    g_strlcpy(namebuf, name, G_N_ELEMENTS(namebuf));
+    return namebuf;
+
+ error:
+    g_strlcpy(namebuf, "unnamed", G_N_ELEMENTS(namebuf));
+    return namebuf;
+}
-- 
2.52.0


