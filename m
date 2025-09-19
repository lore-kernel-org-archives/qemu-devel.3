Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74BACAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZG1-0001hR-Q6; Fri, 19 Sep 2025 07:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzZG0-0001g0-HR
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzZFx-00018f-1j
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758281180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nXiQoLVud16zJS++9JVhoT2jq7OgO1shPqm/dnBddzo=;
 b=X7sXpdY/IKplHi+55y72QbyFQC5zmEuh36o9kyRpvp2aUglgjOynzbQQg5i4zlwrOolXkZ
 Br6kMILdHW2w0RfVCR5/2Kd+kPilQuptGvLi2U7PUR0E9HQKRk4o0UaqJgtkfZmLvX9SMK
 K7ehxHHeyHxR0un+PXba4hTf193nYiQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-XEb4jdPNOAC-0HHgDJ9uSw-1; Fri,
 19 Sep 2025 07:26:15 -0400
X-MC-Unique: XEb4jdPNOAC-0HHgDJ9uSw-1
X-Mimecast-MFC-AGG-ID: XEb4jdPNOAC-0HHgDJ9uSw_1758281174
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5765118002C0; Fri, 19 Sep 2025 11:26:14 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5C1F30002C5; Fri, 19 Sep 2025 11:26:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 07/16] tracetool/backend: remove redundant trace event checks
Date: Fri, 19 Sep 2025 13:25:27 +0200
Message-ID: <20250919112536.141782-8-pbonzini@redhat.com>
In-Reply-To: <20250919112536.141782-1-pbonzini@redhat.com>
References: <20250919112536.141782-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 tests/tracetool/log.h               | 16 ++++++++++------
 scripts/tracetool/backend/ftrace.py |  6 ++----
 scripts/tracetool/backend/log.py    | 10 ++++------
 scripts/tracetool/backend/simple.py |  8 ++------
 scripts/tracetool/backend/syslog.py |  8 ++------
 5 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/tests/tracetool/log.h b/tests/tracetool/log.h
index edcc7f9d47c..c7795871f85 100644
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
index 8c0ce3f23a0..7ddd5d11a66 100644
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
index faacec46105..d01d234289f 100644
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
index 97e40495ee9..b5a6b7205a3 100644
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
index 78ee67136b8..177414d56a6 100644
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



