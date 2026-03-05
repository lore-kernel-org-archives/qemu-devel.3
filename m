Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2EFF47CA6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCqH-0006jA-Q9; Thu, 05 Mar 2026 12:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyCpr-0005yo-Dw
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:50:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyCpm-0002L9-V2
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJZuudeoh6gQkXCj0qppSeaHkJ9Q/5Q+mEnQLOlYXv0=;
 b=Ll/QjQ49x00duOmTz58eC+yWDM1CuoiF6He4sakEJWOIJJyXwiazDs2SkbBkXk+IcB8yOt
 bHc15V+qeJCMxCH9Mvlhb8NdVilpOqHEWvyFk3URPrqcuDvwpUwQCq39Shjhx6kUG9q/Xr
 WQ8H/slp46xHD3MV9K/75R3maYlTuDs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-S_j6rhEYNEKbsXkp83cXIA-1; Thu,
 05 Mar 2026 12:49:58 -0500
X-MC-Unique: S_j6rhEYNEKbsXkp83cXIA-1
X-Mimecast-MFC-AGG-ID: S_j6rhEYNEKbsXkp83cXIA_1772732996
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A56B8180049D; Thu,  5 Mar 2026 17:49:56 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.44.34.61])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE8B21956095; Thu,  5 Mar 2026 17:49:51 +0000 (UTC)
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
Subject: [PULL 23/27] util: fix interleaving of error & trace output
Date: Thu,  5 Mar 2026 17:47:39 +0000
Message-ID: <20260305174743.3084606-24-berrange@redhat.com>
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

This implies error_[v]printf() cannot be called from vreport().
Instead we must introduce error_[v]printf_mon() which accept a
pre-acquired Monitor object. In some cases, however, fprintf
can be called directly as output will never be directed to the
monitor.

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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/error-report.c | 63 ++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 21 deletions(-)

diff --git a/util/error-report.c b/util/error-report.c
index c7f70bd95b..f666ca4149 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -32,9 +32,9 @@ const char *error_guest_name;
 /*
  * Print to the current human monitor if we have one, else to stderr.
  */
-int error_vprintf(const char *fmt, va_list ap)
+static int G_GNUC_PRINTF(2, 0)
+error_vprintf_mon(Monitor *cur_mon, const char *fmt, va_list ap)
 {
-    Monitor *cur_mon = monitor_cur();
     /*
      * This will return -1 if 'cur_mon' is NULL, or is QMP.
      * IOW this will only print if in HMP, otherwise we
@@ -47,13 +47,33 @@ int error_vprintf(const char *fmt, va_list ap)
     return ret;
 }
 
+/*
+ * Print to the current human monitor if we have one, else to stderr.
+ */
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
@@ -156,34 +176,34 @@ void loc_set_file(const char *fname, int lno)
 /*
  * Print current location to current monitor if we have one, else to stderr.
  */
-static void print_loc(void)
+static void print_loc(Monitor *cur)
 {
     const char *sep = "";
     int i;
     const char *const *argp;
 
-    if (!monitor_cur() && g_get_prgname()) {
-        error_printf("%s:", g_get_prgname());
+    if (!cur && g_get_prgname()) {
+        fprintf(stderr, "%s:", g_get_prgname());
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
 
@@ -203,34 +223,35 @@ char *real_time_iso8601(void)
 G_GNUC_PRINTF(2, 0)
 static void vreport(report_type type, const char *fmt, va_list ap)
 {
+    Monitor *cur = monitor_cur();
     gchar *timestr;
 
-    if (message_with_timestamp && !monitor_cur()) {
+    if (message_with_timestamp && !cur) {
         timestr = real_time_iso8601();
-        error_printf("%s ", timestr);
+        fprintf(stderr, "%s ", timestr);
         g_free(timestr);
     }
 
     /* Only prepend guest name if -msg guest-name and -name guest=... are set */
-    if (error_with_guestname && error_guest_name && !monitor_cur()) {
-        error_printf("%s ", error_guest_name);
+    if (error_with_guestname && error_guest_name && !cur) {
+        fprintf(stderr, "%s ", error_guest_name);
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
2.53.0


