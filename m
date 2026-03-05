Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E343F47CA3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCoj-0002oH-67; Thu, 05 Mar 2026 12:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyCoh-0002jO-FD
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:48:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyCof-0002DA-N4
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772732933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZUN9qo2kVOayeNkrm7meCbsEZa6wbphY9wEaykh81U=;
 b=MtxY6XNTe9PVdL1gqUBkn4Q/BLujyeRD0mB5KLQs2Wp9YuALttxIXuI/xPwMlSMQ7EdZt/
 YxSsfw0TIBLrQAXBLfKhPl5I8BX1HDPNQzf0eWghBZEJqkPzAC6B/knsA9xy56OD5W/JK6
 f5o2qp31QqDN487Z7e9XZdTAJZD7JWo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-8KqWhRszMEStDeHUcTeqQg-1; Thu,
 05 Mar 2026 12:48:49 -0500
X-MC-Unique: 8KqWhRszMEStDeHUcTeqQg-1
X-Mimecast-MFC-AGG-ID: 8KqWhRszMEStDeHUcTeqQg_1772732927
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4648B1800345; Thu,  5 Mar 2026 17:48:47 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.44.34.61])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51EF81956095; Thu,  5 Mar 2026 17:48:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, qemu-rust@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PULL 10/27] util: fix race setting thread name on Win32
Date: Thu,  5 Mar 2026 17:47:26 +0000
Message-ID: <20260305174743.3084606-11-berrange@redhat.com>
In-Reply-To: <20260305174743.3084606-1-berrange@redhat.com>
References: <20260305174743.3084606-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The call to set the thread name on Win32 platforms is done by the parent
thread, after _beginthreadex() returns. At this point the new child
thread is potentially already executing its start method. To ensure the
thread name is guaranteed to be set before any "interesting" code starts
executing, it must be done in the start method of the child thread itself.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/qemu-thread-win32.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 9595a5b090..255c88571f 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -22,6 +22,8 @@ typedef HRESULT (WINAPI *pSetThreadDescription) (HANDLE hThread,
 static pSetThreadDescription SetThreadDescriptionFunc;
 static HMODULE kernel32_module;
 
+static void set_thread_description(const char *name);
+
 static bool load_set_thread_description(void)
 {
     static gsize _init_once = 0;
@@ -225,6 +227,7 @@ struct QemuThreadData {
     void             *arg;
     short             mode;
     NotifierList      exit;
+    char             *name; /* Freed in win32_start_routine */
 
     /* Only used for joinable threads. */
     bool              exited;
@@ -266,6 +269,10 @@ static unsigned __stdcall win32_start_routine(void *arg)
     void *(*start_routine)(void *) = data->start_routine;
     void *thread_arg = data->arg;
 
+    if (data->name) {
+        set_thread_description(data->name);
+        g_clear_pointer(&data->name, g_free);
+    }
     qemu_thread_data = data;
     qemu_thread_exit(start_routine(thread_arg));
     abort();
@@ -316,7 +323,7 @@ void *qemu_thread_join(QemuThread *thread)
     return ret;
 }
 
-static void set_thread_description(HANDLE h, const char *name)
+static void set_thread_description(const char *name)
 {
     g_autofree wchar_t *namew = NULL;
 
@@ -329,7 +336,7 @@ static void set_thread_description(HANDLE h, const char *name)
         return;
     }
 
-    SetThreadDescriptionFunc(h, namew);
+    SetThreadDescriptionFunc(GetCurrentThread(), namew);
 }
 
 void qemu_thread_create(QemuThread *thread, const char *name,
@@ -344,6 +351,7 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     data->arg = arg;
     data->mode = mode;
     data->exited = false;
+    data->name = g_strdup(name);
     notifier_list_init(&data->exit);
 
     if (data->mode != QEMU_THREAD_DETACHED) {
@@ -355,9 +363,6 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     if (!hThread) {
         error_exit(GetLastError(), __func__);
     }
-    if (name) {
-        set_thread_description(hThread, name);
-    }
     CloseHandle(hThread);
 
     thread->data = data;
-- 
2.53.0


