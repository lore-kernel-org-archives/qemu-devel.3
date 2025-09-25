Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AB4CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 09:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1iZG-0001wV-Jt; Thu, 25 Sep 2025 05:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iYt-0001WE-Qt
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iYZ-0001kx-Fs
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758793587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7PgG9dCiPetJ2cgwCkBjjUAEVTES+WQEQc0OK6526QM=;
 b=c74gZrtrZBVJe206gGUX5qL4B3vjsARtakUdwcq4uxXwLKD8yxvgoWNNB3TNEsPX6tadJe
 UMB0EUhfoOMMDsPrnPYqQylIuKYFDn9lW1kQM/XZ8QcRrcoguJ9hXDPYMsrQopkfVFCxBf
 bxFUeHrHNjylQLIgHKa3LaRP8yOpiic=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-Cop-hN-HMNmu7CLBKcBHwQ-1; Thu,
 25 Sep 2025 05:46:24 -0400
X-MC-Unique: Cop-hN-HMNmu7CLBKcBHwQ-1
X-Mimecast-MFC-AGG-ID: Cop-hN-HMNmu7CLBKcBHwQ_1758793582
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B01F919560AF; Thu, 25 Sep 2025 09:46:22 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 740FD30002D0; Thu, 25 Sep 2025 09:46:17 +0000 (UTC)
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
Subject: [PATCH v4 16/23] util: fix interleaving of error & trace output
Date: Thu, 25 Sep 2025 10:44:34 +0100
Message-ID: <20250925094441.1651372-17-berrange@redhat.com>
In-Reply-To: <20250925094441.1651372-1-berrange@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

The monitor_cur_hmp() function will acquire/release mutex locks, which
will trigger trace probes, which can in turn trigger qemu_log() calls.
vreport() calls monitor_cur() multiple times through its execution
both directly and indirectly via error_vprintf().

The result is that the prefix information printed by vreport() gets
interleaved with qemu_log() output, when run outside the context of
an HMP command dispatcher. This can be seen with:

 $ qemu-system-x86_64 \
     -msg timestamp=on,guest-name=on \
     -display none \
     -object tls-creds-x509,id=f,dir=fish \
     -name fish \
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
mutex lock/unlock calls) we need to ensure that monitor_cur_is_hmp()
is only called once at the start of vreport(), and if no HMP is
present, no further monitor APIs can be called.

This implies error_[v]printf() cannot be called from vreport(),
instead we must introduce error_[v]printf_mon() which accept a
pre-acquired Monitor object.

 $ qemu-system-x86_64 \
     -msg timestamp=on,guest-name=on \
     -display none \
     -object tls-creds-x509,id=f,dir=fish \
     -name fish \
     -d trace:qemu_mutex*
   2025-09-10T16:31:22.701691Z qemu_mutex_unlock released mutex 0x5626fd3b84c0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
   2025-09-10T16:31:22.701728Z qemu_mutex_lock waiting on mutex 0x5626fd3b53e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
   2025-09-10T16:31:22.701730Z qemu_mutex_locked taken mutex 0x5626fd3b53e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
   2025-09-10T16:31:22.701732Z qemu_mutex_unlock released mutex 0x5626fd3b53e0 (/var/home/berrange/src/virt/qemu/include/qemu/lockable.h:56)
   2025-09-10T16:31:22.703989Z qemu_mutex_lock waiting on mutex 0x5626fd3b5560 (../monitor/monitor.c:91)
   2025-09-10T16:31:22.703996Z qemu_mutex_locked taken mutex 0x5626fd3b5560 (../monitor/monitor.c:91)
   2025-09-10T16:31:22.703999Z qemu_mutex_unlock released mutex 0x5626fd3b5560 (../monitor/monitor.c:96)
   2025-09-10T16:31:22.704000Z fish qemu-system-x86_64: Unable to access credentials fish/ca-cert.pem: No such file or directory

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/error-report.c | 67 +++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 21 deletions(-)

diff --git a/util/error-report.c b/util/error-report.c
index 872158ad90..222c40d0d1 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -29,9 +29,12 @@ bool message_with_timestamp;
 bool error_with_guestname;
 const char *error_guest_name;
 
-int error_vprintf(const char *fmt, va_list ap)
+/*
+ * Print to current monitor if we have one, else to stderr.
+ */
+static int G_GNUC_PRINTF(2, 0)
+error_vprintf_mon(Monitor *cur_mon, const char *fmt, va_list ap)
 {
-    Monitor *cur_mon = monitor_cur();
     /*
      * This will return -1 if 'cur_mon' is NULL, or is QMP.
      * IOW this will only print if in HMP, otherwise we
@@ -44,13 +47,30 @@ int error_vprintf(const char *fmt, va_list ap)
     return ret;
 }
 
+static int G_GNUC_PRINTF(2, 3)
+error_printf_mon(Monitor *cur_mon, const char *fmt, ...)
+{
+    va_list ap;
+    int ret;
+
+    va_start(ap, fmt);
+    ret = error_vprintf_mon(cur_mon, fmt, ap);
+    va_end(ap);
+    return ret;
+}
+
+int error_vprintf(const char *fmt, va_list ap)
+{
+    return error_vprintf_mon(monitor_cur(), fmt, ap);
+}
+
 int error_printf(const char *fmt, ...)
 {
     va_list ap;
     int ret;
 
     va_start(ap, fmt);
-    ret = error_vprintf(fmt, ap);
+    ret = error_vprintf_mon(monitor_cur(), fmt, ap);
     va_end(ap);
     return ret;
 }
@@ -153,34 +173,34 @@ void loc_set_file(const char *fname, int lno)
 /*
  * Print current location to current monitor if we have one, else to stderr.
  */
-static void print_loc(void)
+static void print_loc(Monitor *cur)
 {
     const char *sep = "";
     int i;
     const char *const *argp;
 
-    if (!monitor_cur_is_hmp() && g_get_prgname()) {
-        error_printf("%s:", g_get_prgname());
+    if (!cur && g_get_prgname()) {
+        error_printf_mon(NULL, "%s:", g_get_prgname());
         sep = " ";
     }
     switch (cur_loc->kind) {
     case LOC_CMDLINE:
         argp = cur_loc->ptr;
         for (i = 0; i < cur_loc->num; i++) {
-            error_printf("%s%s", sep, argp[i]);
+            error_printf_mon(cur, "%s%s", sep, argp[i]);
             sep = " ";
         }
-        error_printf(": ");
+        error_printf_mon(cur, ": ");
         break;
     case LOC_FILE:
-        error_printf("%s:", (const char *)cur_loc->ptr);
+        error_printf_mon(cur, "%s:", (const char *)cur_loc->ptr);
         if (cur_loc->num) {
-            error_printf("%d:", cur_loc->num);
+            error_printf_mon(cur, "%d:", cur_loc->num);
         }
-        error_printf(" ");
+        error_printf_mon(cur, " ");
         break;
     default:
-        error_printf("%s", sep);
+        error_printf_mon(cur, "%s", sep);
     }
 }
 
@@ -201,34 +221,39 @@ real_time_iso8601(void)
 G_GNUC_PRINTF(2, 0)
 static void vreport(report_type type, const char *fmt, va_list ap)
 {
+    Monitor *cur = NULL;
     gchar *timestr;
 
-    if (message_with_timestamp && !monitor_cur_is_hmp()) {
+    if (monitor_cur_is_hmp()) {
+        cur = monitor_cur();
+    }
+
+    if (message_with_timestamp && !cur) {
         timestr = real_time_iso8601();
-        error_printf("%s ", timestr);
+        error_printf_mon(NULL, "%s ", timestr);
         g_free(timestr);
     }
 
     /* Only prepend guest name if -msg guest-name and -name guest=... are set */
-    if (error_with_guestname && error_guest_name && !monitor_cur_is_hmp()) {
-        error_printf("%s ", error_guest_name);
+    if (error_with_guestname && error_guest_name && !cur) {
+        error_printf_mon(NULL, "%s ", error_guest_name);
     }
 
-    print_loc();
+    print_loc(cur);
 
     switch (type) {
     case REPORT_TYPE_ERROR:
         break;
     case REPORT_TYPE_WARNING:
-        error_printf("warning: ");
+        error_printf_mon(cur, "warning: ");
         break;
     case REPORT_TYPE_INFO:
-        error_printf("info: ");
+        error_printf_mon(cur, "info: ");
         break;
     }
 
-    error_vprintf(fmt, ap);
-    error_printf("\n");
+    error_vprintf_mon(cur, fmt, ap);
+    error_printf_mon(cur, "\n");
 }
 
 /*
-- 
2.50.1


