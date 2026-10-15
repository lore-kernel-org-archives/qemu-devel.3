Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507A2CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJX5-0003j2-4a; Thu, 15 Oct 2026 07:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJX0-0003UZ-Rt
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWz-00048k-4D
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZKmmbraeh9Kl20GcdX853uFGdOFcVe3/sO8XnVPYP0=;
 b=JzTKTAx8ceRLieoWQwB2vrj4d/FEdSpIZBLys4ckNh6kiRvXIIi6I/mc1z2pep3zt68SdU
 p/Cd3DqYD1X/Lg9j8LJxO5nzLStZWhRcgUMlBUQ78EROK6UczbAcjmaBfC5JSiAu/tWQwT
 LW0JY+llItSXsdx63kpZgSqg98AcXQw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-QxZJN_W6NJGyubl20goTyA-1; Thu,
 15 Oct 2026 11:21:51 +0000
X-MC-Unique: QxZJN_W6NJGyubl20goTyA-1
X-Mimecast-MFC-AGG-ID: QxZJN_W6NJGyubl20goTyA_1792063310
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFDC819560AA; Thu, 15 Oct 2026 11:21:49 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88FEC1800257; Thu, 15 Oct 2026 11:21:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 15/21] util: capture warnings and errors in the data recorder
Date: Thu, 15 Oct 2026 12:20:38 +0100
Message-ID: <20261015112044.1999748-16-berrange@redhat.com>
In-Reply-To: <20261015112044.1999748-1-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Any messages triggered at runtime for warn_report and error_report
are potentially interesting, so should be captured for the data
recorder. The most common expected scenario is use of any deprecated
features which are liable to trigger warn_report.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 MAINTAINERS          |  1 +
 stubs/meson.build    |  1 +
 stubs/monitor-puts.c |  9 +++++++++
 util/error-report.c  | 43 ++++++++++++++++++++++++-------------------
 4 files changed, 35 insertions(+), 19 deletions(-)
 create mode 100644 stubs/monitor-puts.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 54265d987cb..3a7cd827e66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3566,6 +3566,7 @@ F: include/monitor/hmp-completion.h
 F: tests/qtest/test-hmp.c
 F: include/qemu/qemu-print.h
 F: util/qemu-print.c
+F: stubs/monitor-puts.c
 
 Network device backends
 M: Jason Wang <jasowangio@gmail.com>
diff --git a/stubs/meson.build b/stubs/meson.build
index 29b6644b254..52c733e32a9 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -9,6 +9,7 @@ stub_ss.add(files('is-daemonized.c'))
 stub_ss.add(files('monitor-core.c'))
 stub_ss.add(files('monitor-cur.c'))
 stub_ss.add(files('monitor-hmp.c'))
+stub_ss.add(files('monitor-puts.c'))
 stub_ss.add(files('qapi-event-emit.c'))
 stub_ss.add(files('replay-mode.c'))
 stub_ss.add(files('trace-control.c'))
diff --git a/stubs/monitor-puts.c b/stubs/monitor-puts.c
new file mode 100644
index 00000000000..bb9b726dd5e
--- /dev/null
+++ b/stubs/monitor-puts.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "monitor/monitor.h"
+
+int monitor_puts(Monitor *mon, const char *str)
+{
+    g_assert_not_reached();
+}
diff --git a/util/error-report.c b/util/error-report.c
index 8932beebfb9..251d8b7d16e 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "monitor/hmp.h"
 #include "qemu/error-report.h"
+#include "qemu/tldr.h"
 
 /*
  * @report_type is the type of message: error, warning or
@@ -32,28 +33,32 @@ const char *error_guest_name;
 /*
  * Print to the @hmp monitor, else to stderr.
  */
-static int G_GNUC_PRINTF(2, 0)
-error_vprintf_hmp(MonitorHMP *hmp, const char *fmt, va_list ap)
+static int G_GNUC_PRINTF(3, 0)
+error_vprintf_hmp(MonitorHMP *hmp, bool tldr, const char *fmt, va_list ap)
 {
+    g_autofree char *str = g_strdup_vprintf(fmt, ap);
+    if (qtldr_msg_enabled(QTLDR_MSG_BUCKET_TYPE_ERROR) && tldr) {
+        qtldr_msg_record(QTLDR_MSG_BUCKET_TYPE_ERROR, str);
+    }
 #ifdef CONFIG_HMP
     if (hmp) {
-        return monitor_hmp_vprintf(hmp, fmt, ap);
+        return monitor_puts(MONITOR(hmp), str);
     }
 #endif
-    return vfprintf(stderr, fmt, ap);
+    return fwrite(str, 1, strlen(str), stderr);
 }
 
 /*
  * Print to the @hmp monitor, else to stderr.
  */
-static int G_GNUC_PRINTF(2, 3)
-error_printf_hmp(MonitorHMP *hmp, const char *fmt, ...)
+static int G_GNUC_PRINTF(3, 4)
+error_printf_hmp(MonitorHMP *hmp, bool tldr, const char *fmt, ...)
 {
     va_list ap;
     int ret;
 
     va_start(ap, fmt);
-    ret = error_vprintf_hmp(hmp, fmt, ap);
+    ret = error_vprintf_hmp(hmp, tldr, fmt, ap);
     va_end(ap);
     return ret;
 }
@@ -63,7 +68,7 @@ error_printf_hmp(MonitorHMP *hmp, const char *fmt, ...)
  */
 int error_vprintf(const char *fmt, va_list ap)
 {
-    return error_vprintf_hmp(monitor_cur_hmp(), fmt, ap);
+    return error_vprintf_hmp(monitor_cur_hmp(), true, fmt, ap);
 }
 
 /*
@@ -75,7 +80,7 @@ int error_printf(const char *fmt, ...)
     int ret;
 
     va_start(ap, fmt);
-    ret = error_vprintf_hmp(monitor_cur_hmp(), fmt, ap);
+    ret = error_vprintf_hmp(monitor_cur_hmp(), true, fmt, ap);
     va_end(ap);
     return ret;
 }
@@ -193,20 +198,20 @@ static void print_loc(MonitorHMP *hmp)
     case LOC_CMDLINE:
         argp = cur_loc->ptr;
         for (i = 0; i < cur_loc->num; i++) {
-            error_printf_hmp(hmp, "%s%s", sep, argp[i]);
+            error_printf_hmp(hmp, false, "%s%s", sep, argp[i]);
             sep = " ";
         }
-        error_printf_hmp(hmp, ": ");
+        error_printf_hmp(hmp, false, ": ");
         break;
     case LOC_FILE:
-        error_printf_hmp(hmp, "%s:", (const char *)cur_loc->ptr);
+        error_printf_hmp(hmp, false, "%s:", (const char *)cur_loc->ptr);
         if (cur_loc->num) {
-            error_printf_hmp(hmp, "%d:", cur_loc->num);
+            error_printf_hmp(hmp, false, "%d:", cur_loc->num);
         }
-        error_printf_hmp(hmp, " ");
+        error_printf_hmp(hmp, false, " ");
         break;
     default:
-        error_printf_hmp(hmp, "%s", sep);
+        error_printf_hmp(hmp, false, "%s", sep);
     }
 }
 
@@ -251,15 +256,15 @@ static void vreport(report_type type, const char *fmt, va_list ap)
     case REPORT_TYPE_ERROR:
         break;
     case REPORT_TYPE_WARNING:
-        error_printf_hmp(hmp, "warning: ");
+        error_printf_hmp(hmp, false, "warning: ");
         break;
     case REPORT_TYPE_INFO:
-        error_printf_hmp(hmp, "info: ");
+        error_printf_hmp(hmp, false, "info: ");
         break;
     }
 
-    error_vprintf_hmp(hmp, fmt, ap);
-    error_printf_hmp(hmp, "\n");
+    error_vprintf_hmp(hmp, true, fmt, ap);
+    error_printf_hmp(hmp, false, "\n");
 
     if (!hmp) {
         qemu_funlockfile(stderr);
-- 
2.56.0


