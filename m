Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A46BE9E311
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 15:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqC6l-0006VF-NV; Wed, 11 Feb 2026 10:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqC6j-0006Qj-IK
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:26:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqC6g-0005s3-7z
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:26:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770823581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U4ooj0qoTlbTdZFthN2E2JErDMdhjQ9nsu3y5uVtROg=;
 b=UnJtGZJqdqN6iqugxXJkUgFczO9VE0a1OWlD9OfpfLI8FUOcfj/ckRamUpta21KmBEhsNn
 sTUSA7GTI/c/C5HaerSL6tvQomNOz+mG2YBOilEfSXvMroivD3A+rSIBdlMlQdbUGqtWX2
 mxkYHGTd3hpC1kuYC5IUh8FNuZ1VBGY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-1secoa4ANraGNLIINQv5Dg-1; Wed,
 11 Feb 2026 10:26:16 -0500
X-MC-Unique: 1secoa4ANraGNLIINQv5Dg-1
X-Mimecast-MFC-AGG-ID: 1secoa4ANraGNLIINQv5Dg_1770823573
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8294B180025F; Wed, 11 Feb 2026 15:26:13 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.45.227.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6DD2A30001A8; Wed, 11 Feb 2026 15:26:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 10/27] util: add API to fetch the current thread name
Date: Wed, 11 Feb 2026 15:24:51 +0000
Message-ID: <20260211152508.732487-11-berrange@redhat.com>
In-Reply-To: <20260211152508.732487-1-berrange@redhat.com>
References: <20260211152508.732487-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This will be used to include the thread name in error reports
in a later patch. It returns a const string stored in a thread
local to avoid memory allocation when it is called repeatedly
in a single thread. The thread name should be set at the very
start of the thread execution, which is the case when using
qemu_thread_create.

This uses the official thread APIs for fetching thread names,
so that it captures  names of threads spawned by code in 3rd
party libraries, not merely QEMU spawned thrads.

This also addresses the gap from the previous patch for setting
the name of the main thread. A constructor is used to initialize
the 'namebuf' thread-local in the main thread only.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/thread.h    |  1 +
 meson.build              | 21 ++++++++++++++++
 util/qemu-thread-posix.c | 53 +++++++++++++++++++++++++++++++++++++++-
 util/qemu-thread-win32.c | 49 ++++++++++++++++++++++++++++++++++---
 4 files changed, 119 insertions(+), 5 deletions(-)

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
index 9ad16d1998..710aa2ed83 100644
--- a/meson.build
+++ b/meson.build
@@ -2845,6 +2845,27 @@ config_host_data.set('CONFIG_PTHREAD_SET_NAME_NP', cc.links(osdep_prefix + '''
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
index b1c127dbe3..2b180d99ae 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -18,10 +18,41 @@
 #include "qemu/tsan.h"
 #include "qemu/bitmap.h"
 
-#ifdef CONFIG_PTHREAD_SET_NAME_NP
+#if defined(CONFIG_PTHREAD_SET_NAME_NP) || defined(CONFIG_PTHREAD_GET_NAME_NP)
 #include <pthread_np.h>
 #endif
 
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
+static void __attribute__((__constructor__(QEMU_CONSTRUCTOR_EARLY)))
+qemu_thread_init(void)
+{
+    /*
+     * Initialize the main thread name. We must not use
+     * qemu_thread_setname(), since on some platforms (at least Linux)
+     * this can change the process name that is reported by tools like
+     * 'ps'.
+     *
+     * This workaround suffices to ensure QEMU log/error messages
+     * get the main thread name, but at the cost of external tools
+     * like GDB not seeing it.
+     *
+     * NB using a constructor instead of static initializing namebuf,
+     * to ensure it only initializes the thread-local in the main
+     * thread
+     */
+    g_strlcpy(namebuf, "main", sizeof(namebuf));
+}
+
 static void error_exit(int err, const char *msg)
 {
     fprintf(stderr, "qemu: %s: %s\n", msg, strerror(err));
@@ -526,3 +557,23 @@ void *qemu_thread_join(QemuThread *thread)
     }
     return ret;
 }
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
index c330d924af..272afc3385 100644
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
2.53.0


