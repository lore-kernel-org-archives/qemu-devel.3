Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804CECAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yoK-0001fR-6I; Wed, 01 Oct 2025 11:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3yoG-0001dt-Ba
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:32:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3ynl-0005u6-1c
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759332684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VPqiOvAL1ZqVcLZg53Oo1r6qh4JvIXNEXaSJH8nxaiY=;
 b=gIHcmh7zM4SkLER8Mp14MaCbdXsHQ8a8aEA6VujQSr5P0jYXPntK0CvLVRT9dBx47ayKXf
 4kh/8vbYKlFsb7y2Gf722Xc4wD/DJqLSg7ObN7aLQUD6mM+MjAeV+yA0fX1nx7kLZmO7pn
 eAZJ21/3Q7vWpAIHEjPge4u42o8LlaU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-WzUI-aWKPv2CR8OqjT3PBA-1; Wed,
 01 Oct 2025 11:31:22 -0400
X-MC-Unique: WzUI-aWKPv2CR8OqjT3PBA-1
X-Mimecast-MFC-AGG-ID: WzUI-aWKPv2CR8OqjT3PBA_1759332678
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C0D71800350; Wed,  1 Oct 2025 15:31:18 +0000 (UTC)
Received: from localhost (unknown [10.2.16.112])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB22D180047F; Wed,  1 Oct 2025 15:31:17 +0000 (UTC)
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
 Tanish Desai <tanishdesai37@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 07/16] tracetool/backend: remove redundant trace event checks
Date: Wed,  1 Oct 2025 11:30:50 -0400
Message-ID: <20251001153059.194991-8-stefanha@redhat.com>
In-Reply-To: <20251001153059.194991-1-stefanha@redhat.com>
References: <20251001153059.194991-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Tanish Desai <tanishdesai37@gmail.com>

Use CHECK_TRACE_EVENT_GET_STATE in log, syslog, dtrace and simple
backend, so that the "if (trace_event_get_state)" is created from common
code and unified when multiple backends are active.

When a single backend is active there is no code change (except
for the log backend, as shown in tests/tracetool/log.h), but the
code in the backends is simpler.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250929154938.594389-8-pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/tracetool/log.h               | 16 ++++++++++------
 scripts/tracetool/backend/ftrace.py |  6 ++----
 scripts/tracetool/backend/log.py    | 10 ++++------
 scripts/tracetool/backend/simple.py |  8 ++------
 scripts/tracetool/backend/syslog.py |  8 ++------
 5 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/tests/tracetool/log.h b/tests/tracetool/log.h
index edcc7f9d47..c7795871f8 100644
--- a/tests/tracetool/log.h
+++ b/tests/tracetool/log.h
@@ -21,10 +21,12 @@ extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
 
 static inline void trace_test_blah(void *context, const char *filename)
 {
-    if (trace_event_get_state(TRACE_TEST_BLAH) && qemu_loglevel_mask(LOG_TRACE)) {
+    if (trace_event_get_state(TRACE_TEST_BLAH)) {
+        if (qemu_loglevel_mask(LOG_TRACE)) {
 #line 4 "trace-events"
-        qemu_log("test_blah " "Blah context=%p filename=%s" "\n", context, filename);
-#line 28 "log.h"
+            qemu_log("test_blah " "Blah context=%p filename=%s" "\n", context, filename);
+#line 29 "log.h"
+        }
     }
 }
 
@@ -34,10 +36,12 @@ static inline void trace_test_blah(void *context, const char *filename)
 
 static inline void trace_test_wibble(void *context, int value)
 {
-    if (trace_event_get_state(TRACE_TEST_WIBBLE) && qemu_loglevel_mask(LOG_TRACE)) {
+    if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
+        if (qemu_loglevel_mask(LOG_TRACE)) {
 #line 5 "trace-events"
-        qemu_log("test_wibble " "Wibble context=%p value=%d" "\n", context, value);
-#line 41 "log.h"
+            qemu_log("test_wibble " "Wibble context=%p value=%d" "\n", context, value);
+#line 44 "log.h"
+        }
     }
 }
 #endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index 8c0ce3f23a..7ddd5d11a6 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -16,6 +16,7 @@
 
 
 PUBLIC = True
+CHECK_TRACE_EVENT_GET_STATE = True
 
 
 def generate_h_begin(events, group):
@@ -28,14 +29,11 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    out('    if (trace_event_get_state(%(event_id)s)) {',
-        '#line %(event_lineno)d "%(event_filename)s"',
+    out('#line %(event_lineno)d "%(event_filename)s"',
         '        ftrace_write("%(name)s " %(fmt)s "\\n" %(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
-        '    }',
         name=event.name,
         args=event.args,
-        event_id="TRACE_" + event.name.upper(),
         event_lineno=event.lineno,
         event_filename=event.filename,
         fmt=event.fmt.rstrip("\n"),
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index faacec4610..d01d234289 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -16,6 +16,7 @@
 
 
 PUBLIC = True
+CHECK_TRACE_EVENT_GET_STATE = True
 
 
 def generate_h_begin(events, group):
@@ -28,14 +29,11 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
-
-    out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
+    out('        if (qemu_loglevel_mask(LOG_TRACE)) {',
         '#line %(event_lineno)d "%(event_filename)s"',
-        '        qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
+        '            qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
-        '    }',
-        cond=cond,
+        '        }',
         event_lineno=event.lineno,
         event_filename=event.filename,
         name=event.name,
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index 97e40495ee..b5a6b7205a 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -16,6 +16,7 @@
 
 
 PUBLIC = True
+CHECK_TRACE_EVENT_GET_STATE = True
 
 
 def is_string(arg):
@@ -36,13 +37,8 @@ def generate_h_begin(events, group):
 
 
 def generate_h(event, group):
-    event_id = 'TRACE_' + event.name.upper()
-    cond = "trace_event_get_state(%s)" % event_id
-    out('    if (%(cond)s) {',
-        '        _simple_%(api)s(%(args)s);',
-        '    }',
+    out('        _simple_%(api)s(%(args)s);',
         api=event.api(),
-        cond=cond,
         args=", ".join(event.args.names()))
 
 
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 78ee67136b..177414d56a 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -16,6 +16,7 @@
 
 
 PUBLIC = True
+CHECK_TRACE_EVENT_GET_STATE = True
 
 
 def generate_h_begin(events, group):
@@ -28,14 +29,9 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
-
-    out('    if (%(cond)s) {',
-        '#line %(event_lineno)d "%(event_filename)s"',
+    out('#line %(event_lineno)d "%(event_filename)s"',
         '        syslog(LOG_INFO, "%(name)s " %(fmt)s %(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
-        '    }',
-        cond=cond,
         event_lineno=event.lineno,
         event_filename=event.filename,
         name=event.name,
-- 
2.51.0


