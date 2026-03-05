Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32BCF47CA4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCov-0003BG-Ko; Thu, 05 Mar 2026 12:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyCos-0002zV-Ib
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:49:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyCoq-0002E5-JE
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772732944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1+F62Z+jo8aUeeblvFOAAWBUvtJw9R2WjE6THheHCI=;
 b=LYFVbBidk3Qr+a631bkuLFwJWp3cRVcHu9tCBZxq7wmImThhJNjINa3MyAKAGIEnpZWFmE
 wJvveYa77CICnvyzHCF1Ra5UHaotMdGwiNZ7lVku2wDs667cY+RYqepgMmgWB6HHd65PgN
 Mpb8VGfc5SCRq5b9xcumurXaZAH/uos=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-u9c1lUATPnCapdn_Qm9gwQ-1; Thu,
 05 Mar 2026 12:48:43 -0500
X-MC-Unique: u9c1lUATPnCapdn_Qm9gwQ-1
X-Mimecast-MFC-AGG-ID: u9c1lUATPnCapdn_Qm9gwQ_1772732922
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D39171956066; Thu,  5 Mar 2026 17:48:41 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.44.34.61])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1FC531956095; Thu,  5 Mar 2026 17:48:36 +0000 (UTC)
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
Subject: [PULL 09/27] system: unconditionally enable thread naming
Date: Thu,  5 Mar 2026 17:47:25 +0000
Message-ID: <20260305174743.3084606-10-berrange@redhat.com>
In-Reply-To: <20260305174743.3084606-1-berrange@redhat.com>
References: <20260305174743.3084606-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When thread naming was introduced years ago, it was disabled by
default and put behind a command line flag:

  commit 8f480de0c91a18d550721f8d9af969ebfbda0793
  Author: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Date:   Thu Jan 30 10:20:31 2014 +0000

    Add 'debug-threads' suboption to --name

This was done based on a concern that something might depend
on the historical thread naming. Thread names, however, were
never promised to be part of QEMU's public API. The defaults
will vary across platforms, so no assumptions should ever be
made about naming.

An opt-in behaviour is also unfortunately incompatible with
RCU which creates its thread from an constructor function
which is run before command line args are parsed. Thus the
RCU thread lacks any name.

libvirt has unconditionally enabled debug-threads=yes on all
VMs it creates for 10 years. Interestingly this DID expose a
bug in libvirt, as it parsed /proc/$PID/stat and could not
cope with a space in the thread name. This was a latent
pre-existing bug in libvirt though, and not a part of QEMU's
API.

Having thread names always available, will allow thread names
to be included in error reports and log messags QEMU prints
by default, which will improve ability to triage QEMU bugs.

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/about/deprecated.rst |  7 +++++++
 include/qemu/thread.h     |  1 -
 system/vl.c               | 12 +++++++-----
 util/qemu-thread-posix.c  | 18 +-----------------
 util/qemu-thread-win32.c  | 27 ++++++---------------------
 5 files changed, 21 insertions(+), 44 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index d0ce914d85..576f82a256 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -54,6 +54,13 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
 However, short-form booleans are deprecated and full explicit ``arg_name=on``
 form is preferred.
 
+``debug-threads`` option for ``-name`` (since 11.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``debug-threads`` option of the ``-name`` argument is now
+ignored. Thread naming is unconditionally enabled for all platforms
+where it is supported.
+
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index f0302ed01f..3a286bb3ef 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -215,7 +215,6 @@ void *qemu_thread_join(QemuThread *thread);
 void qemu_thread_get_self(QemuThread *thread);
 bool qemu_thread_is_self(QemuThread *thread);
 G_NORETURN void qemu_thread_exit(void *retval);
-void qemu_thread_naming(bool enable);
 
 struct Notifier;
 /**
diff --git a/system/vl.c b/system/vl.c
index 3e341142a0..38d7b849e0 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -403,9 +403,8 @@ static QemuOptsList qemu_name_opts = {
         }, {
             .name = "debug-threads",
             .type = QEMU_OPT_BOOL,
-            .help = "When enabled, name the individual threads; defaults off.\n"
-                    "NOTE: The thread names are for debugging and not a\n"
-                    "stable API.",
+            .help = "Enable thread names"
+                    "(deprecated, always enabled where supported)",
         },
         { /* End of list */ }
     },
@@ -554,9 +553,12 @@ static int parse_name(void *opaque, QemuOpts *opts, Error **errp)
 {
     const char *proc_name;
 
-    if (qemu_opt_get(opts, "debug-threads")) {
-        qemu_thread_naming(qemu_opt_get_bool(opts, "debug-threads", false));
+    if (qemu_opt_get(opts, "debug-threads") &&
+        !qemu_opt_get_bool(opts, "debug-threads", false)) {
+        fprintf(stderr, "Ignoring deprecated 'debug-threads=no' option, " \
+                "thread naming is unconditionally enabled\n");
     }
+
     qemu_name = qemu_opt_get(opts, "guest");
 
     proc_name = qemu_opt_get(opts, "process");
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index ba725444ba..7c985b5d38 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -22,22 +22,6 @@
 #include <pthread_np.h>
 #endif
 
-static bool name_threads;
-
-void qemu_thread_naming(bool enable)
-{
-    name_threads = enable;
-
-#if !defined CONFIG_PTHREAD_SETNAME_NP_W_TID && \
-    !defined CONFIG_PTHREAD_SETNAME_NP_WO_TID && \
-    !defined CONFIG_PTHREAD_SET_NAME_NP
-    /* This is a debugging option, not fatal */
-    if (enable) {
-        fprintf(stderr, "qemu: thread naming not supported on this host\n");
-    }
-#endif
-}
-
 static void error_exit(int err, const char *msg)
 {
     fprintf(stderr, "qemu: %s: %s\n", msg, strerror(err));
@@ -361,7 +345,7 @@ static void *qemu_thread_start(void *args)
     /* Attempt to set the threads name; note that this is for debug, so
      * we're not going to fail if we can't set it.
      */
-    if (name_threads && qemu_thread_args->name) {
+    if (qemu_thread_args->name) {
 # if defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
         pthread_setname_np(pthread_self(), qemu_thread_args->name);
 # elif defined(CONFIG_PTHREAD_SETNAME_NP_WO_TID)
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index ca2e0b512e..9595a5b090 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -17,8 +17,6 @@
 #include "qemu-thread-common.h"
 #include <process.h>
 
-static bool name_threads;
-
 typedef HRESULT (WINAPI *pSetThreadDescription) (HANDLE hThread,
                                                  PCWSTR lpThreadDescription);
 static pSetThreadDescription SetThreadDescriptionFunc;
@@ -44,16 +42,6 @@ static bool load_set_thread_description(void)
     return !!SetThreadDescriptionFunc;
 }
 
-void qemu_thread_naming(bool enable)
-{
-    name_threads = enable;
-
-    if (enable && !load_set_thread_description()) {
-        fprintf(stderr, "qemu: thread naming not supported on this host\n");
-        name_threads = false;
-    }
-}
-
 static void error_exit(int err, const char *msg)
 {
     char *pstr;
@@ -328,23 +316,20 @@ void *qemu_thread_join(QemuThread *thread)
     return ret;
 }
 
-static bool set_thread_description(HANDLE h, const char *name)
+static void set_thread_description(HANDLE h, const char *name)
 {
-    HRESULT hr;
     g_autofree wchar_t *namew = NULL;
 
     if (!load_set_thread_description()) {
-        return false;
+        return;
     }
 
     namew = g_utf8_to_utf16(name, -1, NULL, NULL, NULL);
     if (!namew) {
-        return false;
+        return;
     }
 
-    hr = SetThreadDescriptionFunc(h, namew);
-
-    return SUCCEEDED(hr);
+    SetThreadDescriptionFunc(h, namew);
 }
 
 void qemu_thread_create(QemuThread *thread, const char *name,
@@ -370,8 +355,8 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     if (!hThread) {
         error_exit(GetLastError(), __func__);
     }
-    if (name_threads && name && !set_thread_description(hThread, name)) {
-        fprintf(stderr, "qemu: failed to set thread description: %s\n", name);
+    if (name) {
+        set_thread_description(hThread, name);
     }
     CloseHandle(hThread);
 
-- 
2.53.0


