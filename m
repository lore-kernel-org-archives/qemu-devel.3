Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9ED4D1D482
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdtSA-0007eU-D1; Thu, 08 Jan 2026 12:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtRp-000744-U1
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:05:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdtRn-0007Jk-WD
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767891919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ElITesBvHnG91wf0vvcybRYKpDNgQUJ4lsL5N7CJHH0=;
 b=GACrKmPCvz8N44b0xUX2L/b0TVoREk1OUKogBuFak2mOtd/f+Z1j9s3QY/Q/0cwvg1fp0x
 AZW86nGKds6hoyTra4nQ+OS2xmfHvcHy1W1QGCQRu9Mv7D4BSdOq6b48H1Jqe/jWwU7G0c
 BTESy9w5C7nE5c1Obq7ToJ/U8e8ZB74=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-LLlUw6JCMDyPq9HoMtxQAQ-1; Thu,
 08 Jan 2026 12:05:15 -0500
X-MC-Unique: LLlUw6JCMDyPq9HoMtxQAQ-1
X-Mimecast-MFC-AGG-ID: LLlUw6JCMDyPq9HoMtxQAQ_1767891914
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21CF71954B21; Thu,  8 Jan 2026 17:05:14 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.44])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B08D19560A2; Thu,  8 Jan 2026 17:05:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 20/24] util: convert error-report & log to message API for
 timestamp
Date: Thu,  8 Jan 2026 17:03:34 +0000
Message-ID: <20260108170338.2693853-21-berrange@redhat.com>
In-Reply-To: <20260108170338.2693853-1-berrange@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
 util/log.c                     |  8 +++-----
 5 files changed, 13 insertions(+), 24 deletions(-)

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
index 60bdd58548..75e2fd310d 100644
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
@@ -818,8 +819,12 @@ static void realtime_init(void)
 
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
index a8532fc58f..9c63019694 100644
--- a/tests/unit/test-error-report.c
+++ b/tests/unit/test-error-report.c
@@ -12,6 +12,7 @@
 
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qemu/message.h"
 
 static void
 test_error_report_simple(void)
@@ -89,7 +90,7 @@ static void
 test_error_report_timestamp(void)
 {
     if (g_test_subprocess()) {
-        message_with_timestamp = true;
+        qmessage_set_format(QMESSAGE_FORMAT_TIMESTAMP);
         warn_report("warn");
         error_report("err");
         return;
diff --git a/util/error-report.c b/util/error-report.c
index 46ea9ededa..0c39857fc5 100644
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
         qemu_flockfile(stderr);
-    }
-
-    if (message_with_timestamp && !cur) {
-        timestr = real_time_iso8601();
-        fprintf(stderr, "%s ", timestr);
-        g_free(timestr);
+        qmessage_context_print(stderr);
     }
 
     /* Only prepend guest name if -msg guest-name and -name guest=... are set */
diff --git a/util/log.c b/util/log.c
index 2ce7286f31..3b94c6541b 100644
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
@@ -147,11 +148,8 @@ FILE *qemu_log_trylock(void)
 FILE *qemu_log_trylock_context(void)
 {
     FILE *f = qemu_log_trylock();
-    if (log_depth == 1 && message_with_timestamp) {
-        g_autofree const char *timestr = NULL;
-        g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
-        timestr = g_date_time_format_iso8601(dt);
-        fprintf(f, "%s ", timestr);
+    if (log_depth == 1) {
+        qmessage_context_print(f);
     }
     return f;
 }
-- 
2.52.0


