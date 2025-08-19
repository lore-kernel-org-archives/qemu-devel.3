Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C0FCA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 20:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoSvw-00047K-In; Tue, 19 Aug 2025 16:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoSvu-00046Z-Ow
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:27:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoSvt-0006T0-5C
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755635268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BXu5lN1E+5tzwo8qodDlWec0scY5oqa/D81vjz0gKO8=;
 b=VpWnnUMXXvTDmpFaTHZUgLCUnKbs9KinBl333R753t937KH4qX1QInGRb3tJq+Alu7Z9mc
 Vh2AOU00N/TSb64LBoYtBLx4T9onlQg3OqjhBndEBB/c4SXF+LKCWj7SVb8MKCbc6S4G77
 Zi8cs1zMCu9WQap4wynzGiSOBPT80WA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-LMdAHSS7MrCY2JREtS6jBg-1; Tue,
 19 Aug 2025 16:27:45 -0400
X-MC-Unique: LMdAHSS7MrCY2JREtS6jBg-1
X-Mimecast-MFC-AGG-ID: LMdAHSS7MrCY2JREtS6jBg_1755635263
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C809F195608E; Tue, 19 Aug 2025 20:27:43 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.237])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C32619560B0; Tue, 19 Aug 2025 20:27:39 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, devel@lists.libvirt.org,
 Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 06/12] util: add API to fetch the current thread name
Date: Tue, 19 Aug 2025 21:27:02 +0100
Message-ID: <20250819202708.1185594-7-berrange@redhat.com>
In-Reply-To: <20250819202708.1185594-1-berrange@redhat.com>
References: <20250819202708.1185594-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
local to avoid memory allocation on POSIX platforms, at the
cost of having to store an allocated string pointer on Windows.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/thread.h    |  1 +
 meson.build              | 21 +++++++++++++++++
 util/qemu-thread-posix.c | 25 +++++++++++++++++++-
 util/qemu-thread-win32.c | 50 ++++++++++++++++++++++++++++++++++++----
 4 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 96eee82679..0366cb743d 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -216,6 +216,7 @@ void qemu_thread_get_self(QemuThread *thread);
 bool qemu_thread_is_self(QemuThread *thread);
 G_NORETURN void qemu_thread_exit(void *retval);
 uint64_t qemu_thread_get_id(void);
+const char *qemu_thread_get_name(void);
 
 struct Notifier;
 /**
diff --git a/meson.build b/meson.build
index 50c774a195..ebdcb5d65d 100644
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
index f240a93632..282802bc39 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -18,7 +18,7 @@
 #include "qemu/tsan.h"
 #include "qemu/bitmap.h"
 
-#ifdef CONFIG_PTHREAD_SET_NAME_NP
+#if defined(CONFIG_PTHREAD_SET_NAME_NP) || defined(CONFIG_PTHREAD_GET_NAME_NP)
 #include <pthread_np.h>
 #endif
 
@@ -543,3 +543,26 @@ uint64_t qemu_thread_get_id(void)
     return (uint64_t)pthread_self();
 #endif
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
+# if defined(CONFIG_PTHREAD_GETNAME_NP)
+    rv = pthread_getname_np(pthread_self(), namebuf, sizeof(namebuf));
+# elif defined(CONFIG_PTHREAD_GET_NAME_NP)
+    rv = pthread_get_name_np(pthread_self(), namebuf, sizeof(namebuf));
+# else
+    rv = -1;
+# endif
+    if (rv != 0) {
+        strncpy(namebuf, "unnamed", sizeof(namebuf) - 1);
+        namebuf[sizeof(namebuf) - 1] = '\0';
+    }
+    return namebuf;
+}
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index f6956717b2..c31a8a6bc8 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -19,10 +19,13 @@
 
 typedef HRESULT (WINAPI *pSetThreadDescription) (HANDLE hThread,
                                                  PCWSTR lpThreadDescription);
+typedef HRESULT (WINAPI *pGetThreadDescription) (HANDLE hThread,
+                                                 PWSTR *lpThreadDescription);
 static pSetThreadDescription SetThreadDescriptionFunc;
+static pGetThreadDescription GetThreadDescriptionFunc;
 static HMODULE kernel32_module;
 
-static bool load_set_thread_description(void)
+static bool load_thread_description(void)
 {
     static gsize _init_once = 0;
 
@@ -32,14 +35,17 @@ static bool load_set_thread_description(void)
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
@@ -320,7 +326,7 @@ static void set_thread_description(HANDLE h, const char *name)
 {
     g_autofree wchar_t *namew = NULL;
 
-    if (!load_set_thread_description()) {
+    if (!load_thread_description()) {
         return;
     }
 
@@ -417,3 +423,39 @@ uint64_t qemu_thread_get_id(void)
 {
     return (uint64_t)GetCurrentThreadId();
 }
+
+static __thread char *namebuf;
+
+const char *qemu_thread_get_name(void)
+{
+    HRESULT hr;
+    wchar_t *namew = NULL;
+    g_autofree char *name = NULL;
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
+    g_free(namebuf);
+    namebuf = g_utf16_to_utf8(namew, -1, NULL, NULL, NULL);
+    if (!namebuf) {
+        goto error;
+    }
+
+ cleanup:
+    if (namew) {
+        LocalFree(namew);
+    }
+    return namebuf;
+
+ error:
+    if (!namebuf) {
+        namebuf = g_strdup("unnamed");
+    }
+    goto cleanup;
+}
-- 
2.50.1


