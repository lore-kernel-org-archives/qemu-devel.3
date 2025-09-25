Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE3CCAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 09:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1iYy-0001Xn-IP; Thu, 25 Sep 2025 05:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iYe-0001LL-NZ
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:46:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iYH-0001gg-3C
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758793570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7NCvE3YA5VgWxx+9mzBYupMJGGpqZizO+jRicuvJQE=;
 b=LkTa64TL7qMKK2CpQonFI6dYcSozI6aXQJXqNfjK450YhZ7WHWEJFNnb/sfJBpGFNCTSuY
 bI/jQVAUDZF9Hyap4NU8lekC46d0/zHTEseM+rOOkUMS/XXMQ4z+9n9pB0xFcOGzlCVBy6
 gmkU2LK9B35kL21eH7ZuLsv+5sNfHmQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-k3uQ7FnPPoO1ftCINJkTBw-1; Thu,
 25 Sep 2025 05:46:06 -0400
X-MC-Unique: k3uQ7FnPPoO1ftCINJkTBw-1
X-Mimecast-MFC-AGG-ID: k3uQ7FnPPoO1ftCINJkTBw_1758793565
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62A8A18002CD; Thu, 25 Sep 2025 09:46:05 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 82E7D300021A; Thu, 25 Sep 2025 09:46:00 +0000 (UTC)
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
Subject: [PATCH v4 13/23] monitor: move error_vprintf back to error-report.c
Date: Thu, 25 Sep 2025 10:44:31 +0100
Message-ID: <20250925094441.1651372-14-berrange@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The current unit tests rely on monitor.o not being linked, such
that the monitor stubs get linked instead. Since error_vprintf
is in monitor.o this allows a stub error_vprintf impl to be used
that calls g_test_message.

This takes a different approach, with error_vprintf moving
back to error-report.c such that it is always linked into the
tests. The monitor_vprintf() stub is then changed to use
g_test_message if QTEST_SLENT_ERROS is set, otherwise it will
return -1 and trigger error_vprintf to call vfprintf.

The end result is functionally equivalent for the purposes of
the unit tests.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/monitor.c    | 15 ---------------
 stubs/error-printf.c | 18 ------------------
 stubs/meson.build    |  1 -
 stubs/monitor-core.c | 14 +++++++++++++-
 util/error-report.c  | 15 +++++++++++++++
 5 files changed, 28 insertions(+), 35 deletions(-)
 delete mode 100644 stubs/error-printf.c

diff --git a/monitor/monitor.c b/monitor/monitor.c
index c00f4aac5a..e1e5dbfcbe 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -268,21 +268,6 @@ void monitor_printc(Monitor *mon, int c)
     monitor_printf(mon, "'");
 }
 
-int error_vprintf(const char *fmt, va_list ap)
-{
-    Monitor *cur_mon = monitor_cur();
-    /*
-     * This will return -1 if 'cur_mon' is NULL, or is QMP.
-     * IOW this will only print if in HMP, otherwise we
-     * fallback to stderr for QMP / no-monitor scenarios.
-     */
-    int ret = monitor_vprintf(cur_mon, fmt, ap);
-    if (ret == -1) {
-        ret = vfprintf(stderr, fmt, ap);
-    }
-    return ret;
-}
-
 static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     /* Limit guest-triggerable events to 1 per second */
     [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
diff --git a/stubs/error-printf.c b/stubs/error-printf.c
deleted file mode 100644
index 1afa0f62ca..0000000000
--- a/stubs/error-printf.c
+++ /dev/null
@@ -1,18 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu/error-report.h"
-#include "monitor/monitor.h"
-
-int error_vprintf(const char *fmt, va_list ap)
-{
-    int ret;
-
-    if (g_test_initialized() && !g_test_subprocess() &&
-        getenv("QTEST_SILENT_ERRORS")) {
-        char *msg = g_strdup_vprintf(fmt, ap);
-        g_test_message("%s", msg);
-        ret = strlen(msg);
-        g_free(msg);
-        return ret;
-    }
-    return vfprintf(stderr, fmt, ap);
-}
diff --git a/stubs/meson.build b/stubs/meson.build
index cef046e685..f58371f685 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -3,7 +3,6 @@
 # below, so that it is clear who needs the stubbed functionality.
 
 stub_ss.add(files('cpu-get-clock.c'))
-stub_ss.add(files('error-printf.c'))
 stub_ss.add(files('fdset.c'))
 stub_ss.add(files('iothread-lock.c'))
 stub_ss.add(files('is-daemonized.c'))
diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
index 1894cdfe1f..a7c32297c9 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -18,5 +18,17 @@ void qapi_event_emit(QAPIEvent event, QDict *qdict)
 
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
 {
-    abort();
+    /*
+     * Pretend 'g_test_message' is our monitor console to
+     * stop the caller sending messages to stderr
+     */
+    if (g_test_initialized() && !g_test_subprocess() &&
+        getenv("QTEST_SILENT_ERRORS")) {
+        char *msg = g_strdup_vprintf(fmt, ap);
+        g_test_message("%s", msg);
+        size_t ret = strlen(msg);
+        g_free(msg);
+        return ret;
+    }
+    return -1;
 }
diff --git a/util/error-report.c b/util/error-report.c
index 1b17c11de1..b262ad01cb 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -29,6 +29,21 @@ bool message_with_timestamp;
 bool error_with_guestname;
 const char *error_guest_name;
 
+int error_vprintf(const char *fmt, va_list ap)
+{
+    Monitor *cur_mon = monitor_cur();
+    /*
+     * This will return -1 if 'cur_mon' is NULL, or is QMP.
+     * IOW this will only print if in HMP, otherwise we
+     * fallback to stderr for QMP / no-monitor scenarios.
+     */
+    int ret = monitor_vprintf(cur_mon, fmt, ap);
+    if (ret == -1) {
+        ret = vfprintf(stderr, fmt, ap);
+    }
+    return ret;
+}
+
 int error_printf(const char *fmt, ...)
 {
     va_list ap;
-- 
2.50.1


