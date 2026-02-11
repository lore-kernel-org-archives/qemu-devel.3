Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC7EE9E311
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 15:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqC7o-000875-Vj; Wed, 11 Feb 2026 10:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqC7O-000716-Ne
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:27:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqC7N-00063X-1E
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770823624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8FwGsc+U4X0RJkMPuDd8AeKnsrsM8ODFDWU/OsmlDA=;
 b=JRu+rPjgMn6bxBxgb1YhtGjTRsfJ2q0K5RmTDu7+MJ3uXYp6lbGZaltYMDCQbCAoKloujc
 vIoo6vd9erkmdreUiv1dBaKJvdcH6BjBWfWLfCgq8Q0bS1yDVYXVjwWKkGaFi+hqIBWpog
 CSxRtyTCm/xbvm4KwwbnEniupmrZX4w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-DCbKbnZdM9yzo4sA-KOGZg-1; Wed,
 11 Feb 2026 10:27:01 -0500
X-MC-Unique: DCbKbnZdM9yzo4sA-KOGZg-1
X-Mimecast-MFC-AGG-ID: DCbKbnZdM9yzo4sA-KOGZg_1770823619
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79B871955E7E; Wed, 11 Feb 2026 15:26:59 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.45.227.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 30A9F30002D8; Wed, 11 Feb 2026 15:26:53 +0000 (UTC)
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
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v6 18/27] monitor: move error_vprintf back to error-report.c
Date: Wed, 11 Feb 2026 15:24:59 +0000
Message-ID: <20260211152508.732487-19-berrange@redhat.com>
In-Reply-To: <20260211152508.732487-1-berrange@redhat.com>
References: <20260211152508.732487-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

The current unit tests rely on monitor.o not being linked, such
that the monitor stubs get linked instead. Since error_vprintf
is in monitor.o this allows a stub error_vprintf impl to be used
that calls g_test_message.

This takes a different approach, with error_vprintf moving
back to error-report.c such that it is always linked into the
tests. The monitor_vprintf() stub is then changed to use
g_test_message if QTEST_SILENT_ERRORS is set, otherwise it will
return -1 and trigger error_vprintf to call vfprintf.

The end result is functionally equivalent for the purposes of
the unit tests.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/monitor.c    | 18 ------------------
 stubs/error-printf.c | 18 ------------------
 stubs/meson.build    |  1 -
 stubs/monitor-core.c | 14 +++++++++++++-
 util/error-report.c  | 18 ++++++++++++++++++
 5 files changed, 31 insertions(+), 38 deletions(-)
 delete mode 100644 stubs/error-printf.c

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 64c552a047..6dc5a7016d 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -268,24 +268,6 @@ void monitor_printc(Monitor *mon, int c)
     monitor_printf(mon, "'");
 }
 
-/*
- * Print to the current human monitor if we have one, else to stderr.
- */
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
index 8a07059500..354bf97d74 100644
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
index 1b17c11de1..f3aa24ec22 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -29,6 +29,24 @@ bool message_with_timestamp;
 bool error_with_guestname;
 const char *error_guest_name;
 
+/*
+ * Print to the current human monitor if we have one, else to stderr.
+ */
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
2.53.0


