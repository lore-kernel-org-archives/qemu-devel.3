Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A43CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 09:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1iXz-0000ta-0G; Thu, 25 Sep 2025 05:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iXo-0000sv-EW
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iXV-0001U4-Ic
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758793519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WQs/xm4O7fINJK018PI4dm/6m98OdARg7ntB2NQYAdM=;
 b=WDLXwhKEYXrl8+DNp3RKVdK2ChqNkjnqSLjho3evWniYbg9GARvewxiRLF64/XuLyfvb4A
 2bukKwTAc2lGX1ga2GJeK/rK0aqj5GvfFAna/xoxG76EM4ErKHkbISyUroL0syvTer55/2
 xsSppTt8OR1NZzX6nDowS1lBUw+37zA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-NHEtfazLNDuaWqlNIapDEw-1; Thu,
 25 Sep 2025 05:45:15 -0400
X-MC-Unique: NHEtfazLNDuaWqlNIapDEw-1
X-Mimecast-MFC-AGG-ID: NHEtfazLNDuaWqlNIapDEw_1758793514
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C400619560AB; Thu, 25 Sep 2025 09:45:13 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D363B30002D0; Thu, 25 Sep 2025 09:45:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 04/23] util: expose qemu_thread_set_name
Date: Thu, 25 Sep 2025 10:44:22 +0100
Message-ID: <20250925094441.1651372-5-berrange@redhat.com>
In-Reply-To: <20250925094441.1651372-1-berrange@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The ability to set the thread name needs to be used in a number
of places, so expose the current impls as public methods.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
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
2.50.1


