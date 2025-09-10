Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46598CAC58D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 18:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwPCY-0000MR-IN; Wed, 10 Sep 2025 14:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwPC4-0008PE-36
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:05:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uwPBu-0004wt-H6
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757527508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CdBgoYxIvUWgwyeZLw6CowPy0PcFEK/INVG0xv0t5KE=;
 b=FV8LdrWQk8iyRulrFNhqmsWRuE4lHYTZeRMJg4+kmdbKisFZrck5v+uVkPeVUuxDJ7E9Gd
 q5Zpnxvo2boQTcaWWVtlwQO6PCRFTzzaRGEBxT+fxUq9DwwYKkGxdnQudvqzyydo9Yx2Rg
 zEu/NJwOkVYfLBV4GM0djxDXcXQzR5g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-MZPVpweVMH20HsRhSFIDOg-1; Wed,
 10 Sep 2025 14:05:04 -0400
X-MC-Unique: MZPVpweVMH20HsRhSFIDOg-1
X-Mimecast-MFC-AGG-ID: MZPVpweVMH20HsRhSFIDOg_1757527503
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15230180034F; Wed, 10 Sep 2025 18:05:03 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.57])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E08E1800446; Wed, 10 Sep 2025 18:04:59 +0000 (UTC)
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
Subject: [PATCH v3 14/20] util: fix interleaving of error & trace output
Date: Wed, 10 Sep 2025 19:03:51 +0100
Message-ID: <20250910180357.320297-15-berrange@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The monitor_cur_hmp() function will acquire/release mutex locks, which
will trigger trace probes, which can in turn trigger qemu_log() calls.
vreport() calls monitor_cur() multiple times through its execution
both directly and indirectly via error_vprintf().

The result is that the prefix information printed by vreport() gets
interleaved with qemu_log() output, when run outside the context of
an HMP command dispatcher. This can be seen with:

 $ qemu-system-x86_64
     -msg timestamp=on,guest-name=on
     -display none
     -object tls-creds-x509,id=f,dir=fish
     -name fish
     -d trace:qemu_mutex*
   2025-09-10T16:30:42.514374Z qemu_mutex_unlock released mutex 0x560b0339b4c0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
   2025-09-10T16:30:42.514400Z qemu_mutex_lock waiting on mutex 0x560b033983e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
   2025-09-10T16:30:42.514402Z qemu_mutex_locked taken mutex 0x560b033983e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
   2025-09-10T16:30:42.514404Z qemu_mutex_unlock released mutex 0x560b033983e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
   2025-09-10T16:30:42.516716Z qemu_mutex_lock waiting on mutex 0x560b03398560 (../monitor/monitor.c:91)
   2025-09-10T16:30:42.516723Z qemu_mutex_locked taken mutex 0x560b03398560 (../monitor/monitor.c:91)
   2025-09-10T16:30:42.516726Z qemu_mutex_unlock released mutex 0x560b03398560 (../monitor/monitor.c:96)
   2025-09-10T16:30:42.516728Z qemu_mutex_lock waiting on mutex 0x560b03398560 (../monitor/monitor.c:91)
   2025-09-10T16:31:04.842057Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
   2025-09-10T16:31:04.842058Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
   2025-09-10T16:31:04.842055Z 2025-09-10T16:31:04.842060Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
   2025-09-10T16:31:04.842061Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
   2025-09-10T16:31:04.842062Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
   2025-09-10T16:31:04.842064Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
   2025-09-10T16:31:04.842065Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
   2025-09-10T16:31:04.842066Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
   fish 2025-09-10T16:31:04.842068Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
   2025-09-10T16:31:04.842069Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
   2025-09-10T16:31:04.842070Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
   2025-09-10T16:31:04.842072Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
   2025-09-10T16:31:04.842097Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
   2025-09-10T16:31:04.842099Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
   qemu-system-x86_64:2025-09-10T16:31:04.842100Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
   2025-09-10T16:31:04.842102Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
   2025-09-10T16:31:04.842103Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
    2025-09-10T16:31:04.842105Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
   2025-09-10T16:31:04.842106Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
   2025-09-10T16:31:04.842107Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)
   Unable to access credentials fish/ca-cert.pem: No such file or directory2025-09-10T16:31:04.842109Z qemu_mutex_lock waiting on mutex 0x564f5e401560 (../monitor/monitor.c:91)
   2025-09-10T16:31:04.842110Z qemu_mutex_locked taken mutex 0x564f5e401560 (../monitor/monitor.c:91)
   2025-09-10T16:31:04.842111Z qemu_mutex_unlock released mutex 0x564f5e401560 (../monitor/monitor.c:96)

To avoid this interleaving (as well as reduce the huge number of
mutex lock/unlock calls) we need to ensure that monitor_cur_hmp() is
only called once at the start of vreport(), and if no HMP is present,
no further monitor APIs can be called.

This implies error_[v]printf() cannot be called from vreport().

Instead a decision about whether output will go to monitor_[v]printf()
or fprintf() must be made upfront, and then those functions called
directly.

 $ qemu-system-x86_64
     -msg timestamp=on,guest-name=on
     -display none
     -object tls-creds-x509,id=f,dir=fish
     -name fish
     -d trace:qemu_mutex*
   2025-09-10T16:31:22.701691Z qemu_mutex_unlock released mutex 0x5626fd3b84c0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
   2025-09-10T16:31:22.701728Z qemu_mutex_lock waiting on mutex 0x5626fd3b53e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
   2025-09-10T16:31:22.701730Z qemu_mutex_locked taken mutex 0x5626fd3b53e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
   2025-09-10T16:31:22.701732Z qemu_mutex_unlock released mutex 0x5626fd3b53e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
   2025-09-10T16:31:22.703989Z qemu_mutex_lock waiting on mutex 0x5626fd3b5560 (../monitor/monitor.c:91)
   2025-09-10T16:31:22.703996Z qemu_mutex_locked taken mutex 0x5626fd3b5560 (../monitor/monitor.c:91)
   2025-09-10T16:31:22.703999Z qemu_mutex_unlock released mutex 0x5626fd3b5560 (../monitor/monitor.c:96)
   2025-09-10T16:31:22.704000Z fish qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory

This change requires adding a stub for monitor_printf() since that
is now called directly by vreport(), where monitor_vprintf() was
only needed previously.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 stubs/monitor-core.c           |  5 +++
 tests/unit/test-util-sockets.c |  1 +
 util/error-report.c            | 60 ++++++++++++++++++++++++----------
 3 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
index 1e0b11ec29..70b1f7a994 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -30,3 +30,8 @@ int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
 {
     abort();
 }
+
+int monitor_printf(Monitor *mon, const char *fmt, ...)
+{
+    abort();
+}
diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index d40813c682..53733163dd 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -76,6 +76,7 @@ Monitor *monitor_cur_hmp(void) { return cur_mon; }
 bool monitor_cur_is_qmp(void) { return false; }
 Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort(); }
+int monitor_printf(Monitor *mon, const char *fmt, ...) { abort(); }
 
 #ifndef _WIN32
 static void test_socket_fd_pass_name_good(void)
diff --git a/util/error-report.c b/util/error-report.c
index c0fcf388de..6c887047e3 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -29,6 +29,9 @@ bool message_with_timestamp;
 bool error_with_guestname;
 const char *error_guest_name;
 
+typedef void (*error_print_func)(void *opaque, const char *fmt, ...);
+typedef void (*error_print_vfunc)(void *opaque, const char *fmt, va_list ap);
+
 /*
  * Print to current monitor if we have one, else to stderr.
  */
@@ -151,34 +154,34 @@ void loc_set_file(const char *fname, int lno)
 /*
  * Print current location to current monitor if we have one, else to stderr.
  */
-static void print_loc(void)
+static void print_loc(bool cur, error_print_func print_func, void *print_opaque)
 {
     const char *sep = "";
     int i;
     const char *const *argp;
 
-    if (!monitor_cur_hmp() && g_get_prgname()) {
-        error_printf("%s:", g_get_prgname());
+    if (!cur && g_get_prgname()) {
+        print_func(print_opaque, "%s:", g_get_prgname());
         sep = " ";
     }
     switch (cur_loc->kind) {
     case LOC_CMDLINE:
         argp = cur_loc->ptr;
         for (i = 0; i < cur_loc->num; i++) {
-            error_printf("%s%s", sep, argp[i]);
+            print_func(print_opaque, "%s%s", sep, argp[i]);
             sep = " ";
         }
-        error_printf(": ");
+        print_func(print_opaque, ": ");
         break;
     case LOC_FILE:
-        error_printf("%s:", (const char *)cur_loc->ptr);
+        print_func(print_opaque, "%s:", (const char *)cur_loc->ptr);
         if (cur_loc->num) {
-            error_printf("%d:", cur_loc->num);
+            print_func(print_opaque, "%d:", cur_loc->num);
         }
-        error_printf(" ");
+        print_func(print_opaque, " ");
         break;
     default:
-        error_printf("%s", sep);
+        print_func(print_opaque, "%s", sep);
     }
 }
 
@@ -199,34 +202,55 @@ real_time_iso8601(void)
 G_GNUC_PRINTF(2, 0)
 static void vreport(report_type type, const char *fmt, va_list ap)
 {
+    /*
+     * Calling monitor_cur_hmp() will acquire/release mutexes,
+     * which triggers trace probes, which can trigger
+     * qemu_log calls, which would interleave with output
+     * from this. Hence cache the monitor handle upfront
+     * so any tracing appears before we start outputting.
+     */
+    Monitor *cur = monitor_cur_hmp();
+    error_print_func print_func;
+    error_print_vfunc print_vfunc;
+    void *print_opaque;
     gchar *timestr;
 
-    if (message_with_timestamp && !monitor_cur_hmp()) {
+    if (cur) {
+        print_func = (error_print_func)monitor_printf;
+        print_vfunc = (error_print_vfunc)monitor_vprintf;
+        print_opaque = cur;
+    } else {
+        print_func = (error_print_func)fprintf;
+        print_vfunc = (error_print_vfunc)vfprintf;
+        print_opaque = stderr;
+    }
+
+    if (message_with_timestamp && !cur) {
         timestr = real_time_iso8601();
-        error_printf("%s ", timestr);
+        print_func(print_opaque, "%s ", timestr);
         g_free(timestr);
     }
 
     /* Only prepend guest name if -msg guest-name and -name guest=... are set */
-    if (error_with_guestname && error_guest_name && !monitor_cur_hmp()) {
-        error_printf("%s ", error_guest_name);
+    if (error_with_guestname && error_guest_name && !cur) {
+        print_func(print_opaque, "%s ", error_guest_name);
     }
 
-    print_loc();
+    print_loc(!!cur, print_func, print_opaque);
 
     switch (type) {
     case REPORT_TYPE_ERROR:
         break;
     case REPORT_TYPE_WARNING:
-        error_printf("warning: ");
+        print_func(print_opaque, "warning: ");
         break;
     case REPORT_TYPE_INFO:
-        error_printf("info: ");
+        print_func(print_opaque, "info: ");
         break;
     }
 
-    error_vprintf(fmt, ap);
-    error_printf("\n");
+    print_vfunc(print_opaque, fmt, ap);
+    print_func(print_opaque, "\n");
 }
 
 /*
-- 
2.50.1


