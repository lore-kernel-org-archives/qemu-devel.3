Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F341CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yoJ-0001ek-Ir; Wed, 01 Oct 2025 11:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3yo9-0001bl-C0
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:32:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3yni-0005t0-En
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759332680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Ncp7kRBTgfzSNkIaSIwFpMsSRlZh4u1D08dEz4tlJs=;
 b=GDl9ATwf6T2sIMl69YY6w0N8ZDkMhl89y09Pnv++B7ZrmudMp55Kn6mUPu7z14RXFt8qnd
 LL3vsIRHhj3JHrVH4Xs8ZVVOgQp+OPRP2gXxi6M+5A1YOMx+3GHTl+SJACifJ/pQ/lux/a
 9u0R7BRD4rcoSR3uGgV6bjDQxHopIkA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-bKnSZ7X4OnGkUlaV4EG5KA-1; Wed,
 01 Oct 2025 11:31:16 -0400
X-MC-Unique: bKnSZ7X4OnGkUlaV4EG5KA-1
X-Mimecast-MFC-AGG-ID: bKnSZ7X4OnGkUlaV4EG5KA_1759332674
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BCFF1800294; Wed,  1 Oct 2025 15:31:14 +0000 (UTC)
Received: from localhost (unknown [10.2.16.112])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5828180047F; Wed,  1 Oct 2025 15:31:13 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bandan Das <bsd@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-rust@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Cleber Rosa <crosa@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Michael Roth <michael.roth@amd.com>, Mads Ynddal <mads@ynddal.dk>,
 Alexandre Iooss <erdnaxe@crans.org>, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 05/16] trace/ftrace: move snprintf+write from tracepoints to
 ftrace.c
Date: Wed,  1 Oct 2025 11:30:48 -0400
Message-ID: <20251001153059.194991-6-stefanha@redhat.com>
In-Reply-To: <20251001153059.194991-1-stefanha@redhat.com>
References: <20251001153059.194991-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

This simplifies the Python code and reduces the size of the tracepoints.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250929154938.594389-6-pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/tracetool/ftrace.h            | 28 ++++++----------------------
 trace/ftrace.h                      |  1 +
 trace/ftrace.c                      | 15 +++++++++++++++
 scripts/tracetool/backend/ftrace.py | 12 ++----------
 4 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/tests/tracetool/ftrace.h b/tests/tracetool/ftrace.h
index fe22ea0f09..1dfe423941 100644
--- a/tests/tracetool/ftrace.h
+++ b/tests/tracetool/ftrace.h
@@ -21,18 +21,10 @@ extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
 
 static inline void trace_test_blah(void *context, const char *filename)
 {
-    {
-        char ftrace_buf[MAX_TRACE_STRLEN];
-        int unused __attribute__ ((unused));
-        int trlen;
-        if (trace_event_get_state(TRACE_TEST_BLAH)) {
+    if (trace_event_get_state(TRACE_TEST_BLAH)) {
 #line 4 "trace-events"
-            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,
-                             "test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
-#line 33 "ftrace.h"
-            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
-            unused = write(trace_marker_fd, ftrace_buf, trlen);
-        }
+        ftrace_write("test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
+#line 28 "ftrace.h"
     }
 }
 
@@ -42,18 +34,10 @@ static inline void trace_test_blah(void *context, const char *filename)
 
 static inline void trace_test_wibble(void *context, int value)
 {
-    {
-        char ftrace_buf[MAX_TRACE_STRLEN];
-        int unused __attribute__ ((unused));
-        int trlen;
-        if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
+    if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
 #line 5 "trace-events"
-            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,
-                             "test_wibble " "Wibble context=%p value=%d" "\n" , context, value);
-#line 54 "ftrace.h"
-            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
-            unused = write(trace_marker_fd, ftrace_buf, trlen);
-        }
+        ftrace_write("test_wibble " "Wibble context=%p value=%d" "\n" , context, value);
+#line 41 "ftrace.h"
     }
 }
 #endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/trace/ftrace.h b/trace/ftrace.h
index cb5e35d217..16c122816d 100644
--- a/trace/ftrace.h
+++ b/trace/ftrace.h
@@ -8,5 +8,6 @@
 extern int trace_marker_fd;
 
 bool ftrace_init(void);
+G_GNUC_PRINTF(1, 2) void ftrace_write(const char *fmt, ...);
 
 #endif /* TRACE_FTRACE_H */
diff --git a/trace/ftrace.c b/trace/ftrace.c
index 9749543d9b..6875faedb9 100644
--- a/trace/ftrace.c
+++ b/trace/ftrace.c
@@ -38,6 +38,21 @@ static int find_mount(char *mount_point, const char *fstype)
     return ret;
 }
 
+void ftrace_write(const char *fmt, ...)
+{
+    char ftrace_buf[MAX_TRACE_STRLEN];
+    int unused __attribute__ ((unused));
+    int trlen;
+    va_list ap;
+
+    va_start(ap, fmt);
+    trlen = vsnprintf(ftrace_buf, MAX_TRACE_STRLEN, fmt, ap);
+    va_end(ap);
+
+    trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
+    unused = write(trace_marker_fd, ftrace_buf, trlen);
+}
+
 bool ftrace_init(void)
 {
     char mount_point[PATH_MAX];
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index a14aafcee6..8c0ce3f23a 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -28,18 +28,10 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    out('    {',
-        '        char ftrace_buf[MAX_TRACE_STRLEN];',
-        '        int unused __attribute__ ((unused));',
-        '        int trlen;',
-        '        if (trace_event_get_state(%(event_id)s)) {',
+    out('    if (trace_event_get_state(%(event_id)s)) {',
         '#line %(event_lineno)d "%(event_filename)s"',
-        '            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
-        '                             "%(name)s " %(fmt)s "\\n" %(argnames)s);',
+        '        ftrace_write("%(name)s " %(fmt)s "\\n" %(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
-        '            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);',
-        '            unused = write(trace_marker_fd, ftrace_buf, trlen);',
-        '        }',
         '    }',
         name=event.name,
         args=event.args,
-- 
2.51.0


