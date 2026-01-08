Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13ED7D1D482
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdtQp-00041N-0d; Thu, 08 Jan 2026 12:04:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtQk-0003v7-SE
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:04:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtQi-0006sl-Un
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767891852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BrKAlIwhHS96rT72QvsgWREA7RZadYiubuuKFJpTdE=;
 b=MyrxZGNpbVw/4CQv5PElrtuOuBnGIIVw37KJqJ8funFZcu5abk5m9ZDVtKdHQFFoD6WWJJ
 CXJ+d79M6NmELTUlA8zIIaA73ov9GF/9OTGrD8QfgvWdsEU82uK84baJcylpMDno4+rNhD
 QZa5cLjJu93TPXxvKT7FqbIgM5+OQKc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-6gxIFJt6NU2xuroQmxNQFA-1; Thu,
 08 Jan 2026 12:04:09 -0500
X-MC-Unique: 6gxIFJt6NU2xuroQmxNQFA-1
X-Mimecast-MFC-AGG-ID: 6gxIFJt6NU2xuroQmxNQFA_1767891847
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89C66195609E; Thu,  8 Jan 2026 17:04:07 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.44])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 64E5E19560A2; Thu,  8 Jan 2026 17:04:03 +0000 (UTC)
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
Subject: [PATCH v5 05/24] util: expose qemu_thread_set_name
Date: Thu,  8 Jan 2026 17:03:19 +0000
Message-ID: <20260108170338.2693853-6-berrange@redhat.com>
In-Reply-To: <20260108170338.2693853-1-berrange@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The ability to set the thread name needs to be used in a number
of places, so expose the current impls as public methods.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/thread.h    |  1 +
 util/qemu-thread-posix.c | 26 ++++++++++++++++----------
 util/qemu-thread-win32.c | 13 ++++++++-----
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 3a286bb3ef..27b888ab0a 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -215,6 +215,7 @@ void *qemu_thread_join(QemuThread *thread);
 void qemu_thread_get_self(QemuThread *thread);
 bool qemu_thread_is_self(QemuThread *thread);
 G_NORETURN void qemu_thread_exit(void *retval);
+void qemu_thread_set_name(const char *name);
 
 struct Notifier;
 /**
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 7c985b5d38..b1c127dbe3 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -329,6 +329,21 @@ static void qemu_thread_atexit_notify(void *arg)
     notifier_list_notify(&thread_exit, NULL);
 }
 
+void qemu_thread_set_name(const char *name)
+{
+    /*
+     * Attempt to set the threads name; note that this is for debug, so
+     * we're not going to fail if we can't set it.
+     */
+# if defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
+    pthread_setname_np(pthread_self(), name);
+# elif defined(CONFIG_PTHREAD_SETNAME_NP_WO_TID)
+    pthread_setname_np(name);
+# elif defined(CONFIG_PTHREAD_SET_NAME_NP)
+    pthread_set_name_np(pthread_self(), name);
+# endif
+}
+
 typedef struct {
     void *(*start_routine)(void *);
     void *arg;
@@ -342,17 +357,8 @@ static void *qemu_thread_start(void *args)
     void *arg = qemu_thread_args->arg;
     void *r;
 
-    /* Attempt to set the threads name; note that this is for debug, so
-     * we're not going to fail if we can't set it.
-     */
     if (qemu_thread_args->name) {
-# if defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
-        pthread_setname_np(pthread_self(), qemu_thread_args->name);
-# elif defined(CONFIG_PTHREAD_SETNAME_NP_WO_TID)
-        pthread_setname_np(qemu_thread_args->name);
-# elif defined(CONFIG_PTHREAD_SET_NAME_NP)
-        pthread_set_name_np(pthread_self(), qemu_thread_args->name);
-# endif
+        qemu_thread_set_name(qemu_thread_args->name);
     }
     QEMU_TSAN_ANNOTATE_THREAD_NAME(qemu_thread_args->name);
     g_free(qemu_thread_args->name);
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 9595a5b090..4d2d663a9a 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -225,6 +225,7 @@ struct QemuThreadData {
     void             *arg;
     short             mode;
     NotifierList      exit;
+    char             *name;
 
     /* Only used for joinable threads. */
     bool              exited;
@@ -266,6 +267,10 @@ static unsigned __stdcall win32_start_routine(void *arg)
     void *(*start_routine)(void *) = data->start_routine;
     void *thread_arg = data->arg;
 
+    if (data->name) {
+        qemu_thread_set_name(data->name);
+        g_clear_pointer(&data->name, g_free);
+    }
     qemu_thread_data = data;
     qemu_thread_exit(start_routine(thread_arg));
     abort();
@@ -316,7 +321,7 @@ void *qemu_thread_join(QemuThread *thread)
     return ret;
 }
 
-static void set_thread_description(HANDLE h, const char *name)
+void qemu_thread_set_name(const char *name)
 {
     g_autofree wchar_t *namew = NULL;
 
@@ -329,7 +334,7 @@ static void set_thread_description(HANDLE h, const char *name)
         return;
     }
 
-    SetThreadDescriptionFunc(h, namew);
+    SetThreadDescriptionFunc(GetCurrentThread(), namew);
 }
 
 void qemu_thread_create(QemuThread *thread, const char *name,
@@ -344,6 +349,7 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     data->arg = arg;
     data->mode = mode;
     data->exited = false;
+    data->name = g_strdup(name);
     notifier_list_init(&data->exit);
 
     if (data->mode != QEMU_THREAD_DETACHED) {
@@ -355,9 +361,6 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     if (!hThread) {
         error_exit(GetLastError(), __func__);
     }
-    if (name) {
-        set_thread_description(hThread, name);
-    }
     CloseHandle(hThread);
 
     thread->data = data;
-- 
2.52.0


