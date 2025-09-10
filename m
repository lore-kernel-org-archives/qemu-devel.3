Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B26CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 18:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwPBR-0007yX-73; Wed, 10 Sep 2025 14:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwPBQ-0007yL-A3
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:04:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwPBO-0004il-Ax
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757527477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ksiCewlUMa6gkJLmmfbF1PaSCeQGDxUBMFxmtS2Pb7A=;
 b=YVhArrZwAMZcH+yrDZ/zOy8CaGvgQhskJ3O/O4xSXJ5MXVEnOS7yyglEyLD+YbOMZACZbc
 2UmTCK1kD5MaO/r85jfqt8ktNEUtD7R0YHq6iW3YMPhSDD0rmujth8qDvg+V+zEWW+YmzS
 Gp7XZuySWsNs0OV5//cSLJ/r2rg8cKw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-grssG7fkO92Pr_7tNBOgbQ-1; Wed,
 10 Sep 2025 14:04:35 -0400
X-MC-Unique: grssG7fkO92Pr_7tNBOgbQ-1
X-Mimecast-MFC-AGG-ID: grssG7fkO92Pr_7tNBOgbQ_1757527473
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 901001800452; Wed, 10 Sep 2025 18:04:33 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8EE9D1800446; Wed, 10 Sep 2025 18:04:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 07/20] util: add API to fetch the current thread name
Date: Wed, 10 Sep 2025 19:03:44 +0100
Message-ID: <20250910180357.320297-8-berrange@redhat.com>
In-Reply-To: <20250910180357.320297-1-berrange@redhat.com>
References: <20250910180357.320297-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
in a single thread. This makes the assumption that the thread
name is set at the very start of the thread, which is the case
when using qemu_thread_create.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/thread.h    |  1 +
 meson.build              | 21 +++++++++++++++++
 util/qemu-thread-posix.c | 28 ++++++++++++++++++++++-
 util/qemu-thread-win32.c | 49 ++++++++++++++++++++++++++++++++++++----
 4 files changed, 94 insertions(+), 5 deletions(-)

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
index fa6186db33..6aa673f4b2 100644
--- a/meson.build
+++ b/meson.build
@@ -2920,6 +2920,27 @@ config_host_data.set('CONFIG_PTHREAD_SET_NAME_NP', cc.links(osdep_prefix + '''
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
index 275445ed94..fbb94ca97b 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -18,7 +18,7 @@
 #include "qemu/tsan.h"
 #include "qemu/bitmap.h"
 
-#ifdef CONFIG_PTHREAD_SET_NAME_NP
+#if defined(CONFIG_PTHREAD_SET_NAME_NP) || defined(CONFIG_PTHREAD_GET_NAME_NP)
 #include <pthread_np.h>
 #endif
 
@@ -532,3 +532,29 @@ void *qemu_thread_join(QemuThread *thread)
     }
     return ret;
 }
+
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
+        strlcpy(namebuf, "unnamed", G_N_ELEMENTS(namebuf));
+    }
+    return namebuf;
+}
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 7a734a7a09..e3789c20d1 100644
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
+    return !!(SetThreadDescriptionFunc && GetThreadDescriptionFunc);
 }
 
 static void error_exit(int err, const char *msg)
@@ -326,7 +332,7 @@ void qemu_thread_set_name(const char *name)
 {
     g_autofree wchar_t *namew = NULL;
 
-    if (!load_set_thread_description()) {
+    if (!load_thread_description()) {
         return;
     }
 
@@ -412,3 +418,38 @@ bool qemu_thread_is_self(QemuThread *thread)
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
+    strlcpy(namebuf, "unnamed", G_N_ELEMENTS(namebuf));
+    return namebuf;
+}
-- 
2.50.1


