Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52973E9E311
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 15:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqC6P-0004t8-FX; Wed, 11 Feb 2026 10:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqC6M-0004qp-Nb
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:26:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqC6L-0005nJ-3l
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770823560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eCtbl4tBYedLw5VjumdC/3noLHo9zL17FOSsYm0GecI=;
 b=IgBBWFhxkPGVepW3ZqIX72AkxIyT4yjKWTL7Wuc9YMqaZBoimJK+bpjFR0P62TlejCjQZv
 Jzi4ajSI3Pnwaxr1IV0RQaqkrXWGNAx5RGmEEotNlA8P7WqBexqvtZu0dtWk1Kb3J4wFlU
 Amf7sYmlX7WMiRO5iBlOWfZN27pgJP4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-d9x-ZiElN9Oad3NURlkNtA-1; Wed,
 11 Feb 2026 10:25:58 -0500
X-MC-Unique: d9x-ZiElN9Oad3NURlkNtA-1
X-Mimecast-MFC-AGG-ID: d9x-ZiElN9Oad3NURlkNtA_1770823557
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 099A91955F28; Wed, 11 Feb 2026 15:25:57 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.45.227.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D510C30002D8; Wed, 11 Feb 2026 15:25:51 +0000 (UTC)
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
Subject: [PATCH v6 07/27] util: expose qemu_thread_set_name
Date: Wed, 11 Feb 2026 15:24:48 +0000
Message-ID: <20260211152508.732487-8-berrange@redhat.com>
In-Reply-To: <20260211152508.732487-1-berrange@redhat.com>
References: <20260211152508.732487-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

The ability to set the thread name needs to be used in a number
of places, so expose the current impls as public methods.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/thread.h    |  1 +
 util/qemu-thread-posix.c | 26 ++++++++++++++++----------
 util/qemu-thread-win32.c |  6 ++----
 3 files changed, 19 insertions(+), 14 deletions(-)

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
index 255c88571f..31ec305a73 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -22,8 +22,6 @@ typedef HRESULT (WINAPI *pSetThreadDescription) (HANDLE hThread,
 static pSetThreadDescription SetThreadDescriptionFunc;
 static HMODULE kernel32_module;
 
-static void set_thread_description(const char *name);
-
 static bool load_set_thread_description(void)
 {
     static gsize _init_once = 0;
@@ -270,7 +268,7 @@ static unsigned __stdcall win32_start_routine(void *arg)
     void *thread_arg = data->arg;
 
     if (data->name) {
-        set_thread_description(data->name);
+        qemu_thread_set_name(data->name);
         g_clear_pointer(&data->name, g_free);
     }
     qemu_thread_data = data;
@@ -323,7 +321,7 @@ void *qemu_thread_join(QemuThread *thread)
     return ret;
 }
 
-static void set_thread_description(const char *name)
+void qemu_thread_set_name(const char *name)
 {
     g_autofree wchar_t *namew = NULL;
 
-- 
2.53.0


