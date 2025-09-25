Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C35CCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 09:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1iZN-00027u-CY; Thu, 25 Sep 2025 05:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iZH-00020P-7F
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:47:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iYr-0001oE-5s
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758793605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FDsHnPrAoFbGd/P2xepGIRR9aZ5c2NPZs/ZC5HlKXtI=;
 b=PxPTQbHznqdWPonjy17DYw9KHC4eoDrv89ZJCuIofTP4A9LtwJtWz6DvasgSDR1GJnMxK2
 H/7zoyHIHSWr4Fa8V6FsbPjMcVumqgFF7BrzLH3yTrvnRtc5RdZvzh2Di2feOX9MucE9ew
 uj9EMBYWxW2VLsq/C0kjPjrF0M5pfME=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-vl-18jdPOOyHrLUMS0_e3Q-1; Thu,
 25 Sep 2025 05:46:41 -0400
X-MC-Unique: vl-18jdPOOyHrLUMS0_e3Q-1
X-Mimecast-MFC-AGG-ID: vl-18jdPOOyHrLUMS0_e3Q_1758793600
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FAB81955DB8; Thu, 25 Sep 2025 09:46:40 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 133BC300021A; Thu, 25 Sep 2025 09:46:34 +0000 (UTC)
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
Subject: [PATCH v4 19/23] util: convert error-report & log to message API for
 timestamp
Date: Thu, 25 Sep 2025 10:44:37 +0100
Message-ID: <20250925094441.1651372-20-berrange@redhat.com>
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

Both the error-report and log APIs can optional emit a timestamp
as a prefix on messages, with the '-msg timestamp=on' command
line flag is set.

Convert them to the new message API for formatting the context
prefix, guaranteeing they will have matching behaviour going
forward.

There is no change in output format for either logs or errors
with this conversion. There is a slight impact on logging code
in that recording the timestamp is now potentially delayed by
the need to acquire the logging mutex.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/error-report.h    |  1 -
 system/vl.c                    |  7 ++++++-
 tests/unit/test-error-report.c |  3 ++-
 util/error-report.c            | 18 ++----------------
 util/log.c                     | 21 ++++-----------------
 5 files changed, 14 insertions(+), 36 deletions(-)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 3ae2357fda..c8000778ec 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -70,7 +70,6 @@ void error_init(const char *argv0);
                               fmt, ##__VA_ARGS__);      \
     })
 
-extern bool message_with_timestamp;
 extern bool error_with_guestname;
 extern const char *error_guest_name;
 
diff --git a/system/vl.c b/system/vl.c
index e0884c1bb9..12bfdb3431 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -26,6 +26,7 @@
 #include "qemu/help-texts.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
+#include "qemu/message.h"
 #include "qemu/module.h"
 #include "qemu/target-info.h"
 #include "exec/cpu-common.h"
@@ -814,8 +815,12 @@ static void realtime_init(void)
 
 static void configure_msg(QemuOpts *opts)
 {
-    message_with_timestamp = qemu_opt_get_bool(opts, "timestamp", false);
+    int flags = 0;
+    if (qemu_opt_get_bool(opts, "timestamp", false)) {
+        flags |= QMESSAGE_FORMAT_TIMESTAMP;
+    }
     error_with_guestname = qemu_opt_get_bool(opts, "guest-name", false);
+    qmessage_set_format(flags);
 }
 
 
diff --git a/tests/unit/test-error-report.c b/tests/unit/test-error-report.c
index 54319c86c9..78f8b57660 100644
--- a/tests/unit/test-error-report.c
+++ b/tests/unit/test-error-report.c
@@ -13,6 +13,7 @@
 
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qemu/message.h"
 
 static void
 test_error_report_simple(void)
@@ -90,7 +91,7 @@ static void
 test_error_report_timestamp(void)
 {
     if (g_test_subprocess()) {
-        message_with_timestamp = true;
+        qmessage_set_format(QMESSAGE_FORMAT_TIMESTAMP);
         warn_report("warn");
         error_report("err");
         return;
diff --git a/util/error-report.c b/util/error-report.c
index b6aa20dbae..c1146ba553 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
+#include "qemu/message.h"
 
 /*
  * @report_type is the type of message: error, warning or
@@ -24,8 +25,6 @@ typedef enum {
     REPORT_TYPE_INFO,
 } report_type;
 
-/* Prepend timestamp to messages */
-bool message_with_timestamp;
 bool error_with_guestname;
 const char *error_guest_name;
 
@@ -204,13 +203,6 @@ static void print_loc(Monitor *cur)
     }
 }
 
-static char *
-real_time_iso8601(void)
-{
-    g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
-    return g_date_time_format_iso8601(dt);
-}
-
 /*
  * Print a message to current monitor if we have one, else to stderr.
  * @report_type is the type of message: error, warning or informational.
@@ -222,18 +214,12 @@ G_GNUC_PRINTF(2, 0)
 static void vreport(report_type type, const char *fmt, va_list ap)
 {
     Monitor *cur = NULL;
-    gchar *timestr;
 
     if (monitor_cur_is_hmp()) {
         cur = monitor_cur();
     } else {
         flockfile(stderr);
-    }
-
-    if (message_with_timestamp && !cur) {
-        timestr = real_time_iso8601();
-        error_printf_mon(NULL, "%s ", timestr);
-        g_free(timestr);
+        qmessage_context_print(stderr);
     }
 
     /* Only prepend guest name if -msg guest-name and -name guest=... are set */
diff --git a/util/log.c b/util/log.c
index 2642a55c59..baa33ad8f1 100644
--- a/util/log.c
+++ b/util/log.c
@@ -22,6 +22,7 @@
 #include "qemu/range.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qemu/message.h"
 #include "qemu/cutils.h"
 #include "trace/control.h"
 #include "qemu/thread.h"
@@ -151,26 +152,12 @@ static __thread bool incomplete;
 
 void qemu_log(const char *fmt, ...)
 {
-    FILE *f;
-    g_autofree const char *timestr = NULL;
-
-    /*
-     * Prepare the timestamp *outside* the logging
-     * lock so it better reflects when the message
-     * was emitted if we are delayed acquiring the
-     * mutex
-     */
-    if (message_with_timestamp && !incomplete) {
-        g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
-        timestr = g_date_time_format_iso8601(dt);
-    }
-
-    f = qemu_log_trylock();
+    FILE *f = qemu_log_trylock();
     if (f) {
         va_list ap;
 
-        if (timestr) {
-            fprintf(f, "%s ", timestr);
+        if (!incomplete) {
+            qmessage_context_print(f);
         }
 
         va_start(ap, fmt);
-- 
2.50.1


