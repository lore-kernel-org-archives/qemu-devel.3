Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62264CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCZws-0003Vw-A6; Fri, 02 Oct 2026 05:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCZwq-0003Sa-JF
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCZwo-0000uv-Id
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790934777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F/5vzHLAuY1lKntem60+2Z7FH4KI38ZA8YD2QRNc65A=;
 b=iyneJeyfGq1Dmt5GzofkmXoPkTOLuLQT0hqhqHWVfg18WMIK0SYnwuUFmyIn/1R5Ubtjc0
 6/t+xEKkwoAbvWNPCdYIcivRVUGBHaA23QIcoTKwbEGjRRLi2agCfbjG5m8h2XzPdZajs+
 fZjG3iCMCjfO31anOtnT+cssTYGBQ9Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-azEM0eZUPgadsVkQdddz6Q-1; Fri,
 02 Oct 2026 05:52:56 -0400
X-MC-Unique: azEM0eZUPgadsVkQdddz6Q-1
X-Mimecast-MFC-AGG-ID: azEM0eZUPgadsVkQdddz6Q_1790934775
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92492193617F; Fri,  2 Oct 2026 09:52:55 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 57A121800348; Fri,  2 Oct 2026 09:52:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 11/20] trace: don't emit TraceEvent structs when 'nop'
 backend is used
Date: Fri,  2 Oct 2026 10:52:23 +0100
Message-ID: <20261002095232.3605567-12-berrange@redhat.com>
In-Reply-To: <20261002095232.3605567-1-berrange@redhat.com>
References: <20261002095232.3605567-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

The 'nop' backend is a short-hand for no trace probe usage
at all. The emitted functions become a no-op, and as such
there is no need to emit the TraceEvent structs, nor the
DSTATE variables they reference.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/tracetool/format/c.py | 75 ++++++++++++++++++-----------------
 scripts/tracetool/format/h.py | 16 +++++---
 tests/tracetool/nop.c         | 29 --------------
 tests/tracetool/nop.h         |  6 +--
 4 files changed, 50 insertions(+), 76 deletions(-)

diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index de1c154a881..5f6669c917c 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -29,41 +29,42 @@ def generate(events, backend, group):
         '#include "%s"' % header,
         '')
 
-    for e in events:
-        out('uint8_t %s;' % e.api(e.QEMU_DSTATE))
-
-    for e in events:
-        out('TraceEvent %(event)s = {',
-            '#ifdef CONFIG_TRACE_SIMPLE',
-            '    .id = 0,',
-            '#endif',
-            '    .name = \"%(name)s\",',
-            '    .sstate = %(sstate)s,',
-            '    .dstate = &%(dstate)s',
+    if len(list(backend.backend_modules())):
+        for e in events:
+            out('uint8_t %s;' % e.api(e.QEMU_DSTATE))
+
+        for e in events:
+            out('TraceEvent %(event)s = {',
+                '#ifdef CONFIG_TRACE_SIMPLE',
+                '    .id = 0,',
+                '#endif',
+                '    .name = \"%(name)s\",',
+                '    .sstate = %(sstate)s,',
+                '    .dstate = &%(dstate)s',
+                '};',
+                event = e.api(e.QEMU_EVENT),
+                name = e.name,
+                sstate = "TRACE_%s_ENABLED" % e.name.upper(),
+                dstate = e.api(e.QEMU_DSTATE))
+
+        out('TraceEvent *%(group)s_trace_events[] = {',
+            group = group.lower())
+
+        for e in events:
+            out('    &%(event)s,', event = e.api(e.QEMU_EVENT))
+
+        out('  NULL,',
             '};',
-            event = e.api(e.QEMU_EVENT),
-            name = e.name,
-            sstate = "TRACE_%s_ENABLED" % e.name.upper(),
-            dstate = e.api(e.QEMU_DSTATE))
-
-    out('TraceEvent *%(group)s_trace_events[] = {',
-        group = group.lower())
-
-    for e in events:
-        out('    &%(event)s,', event = e.api(e.QEMU_EVENT))
-
-    out('  NULL,',
-        '};',
-        '')
-
-    out('static void trace_%(group)s_register_events(void)',
-        '{',
-        '    trace_event_register_group(%(group)s_trace_events);',
-        '}',
-        'trace_init(trace_%(group)s_register_events)',
-        group = group.lower())
-
-    backend.generate_begin(active_events, group)
-    for event in active_events:
-        backend.generate(event, group)
-    backend.generate_end(active_events, group)
+            '')
+
+        out('static void trace_%(group)s_register_events(void)',
+            '{',
+            '    trace_event_register_group(%(group)s_trace_events);',
+            '}',
+            'trace_init(trace_%(group)s_register_events)',
+            group = group.lower())
+
+        backend.generate_begin(active_events, group)
+        for event in active_events:
+            backend.generate(event, group)
+        backend.generate_end(active_events, group)
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index 4dc1ad7eb15..6ffb7256e31 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -27,12 +27,16 @@ def generate(events, backend, group):
         '#include "%s"' % header,
         '')
 
-    for e in events:
-        out('extern TraceEvent %(event)s;',
-            event = e.api(e.QEMU_EVENT))
-
-    for e in events:
-        out('extern uint8_t %s;' % e.api(e.QEMU_DSTATE))
+    if len(list(backend.backend_modules())):
+        for e in events:
+            out('extern TraceEvent %(event)s;',
+                event = e.api(e.QEMU_EVENT))
+
+        for e in events:
+            out('extern uint8_t %s;' % e.api(e.QEMU_DSTATE))
+    else:
+        for e in events:
+            out('#define %s 0' % e.api(e.QEMU_DSTATE))
 
     # static state
     for e in events:
diff --git a/tests/tracetool/nop.c b/tests/tracetool/nop.c
index f83d06252ea..d34cc0ca742 100644
--- a/tests/tracetool/nop.c
+++ b/tests/tracetool/nop.c
@@ -5,32 +5,3 @@
 #include "qemu/module.h"
 #include "trace-testsuite.h"
 
-uint8_t _TRACE_TEST_BLAH_DSTATE;
-uint8_t _TRACE_TEST_WIBBLE_DSTATE;
-TraceEvent _TRACE_TEST_BLAH_EVENT = {
-#ifdef CONFIG_TRACE_SIMPLE
-    .id = 0,
-#endif
-    .name = "test_blah",
-    .sstate = TRACE_TEST_BLAH_ENABLED,
-    .dstate = &_TRACE_TEST_BLAH_DSTATE
-};
-TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
-#ifdef CONFIG_TRACE_SIMPLE
-    .id = 0,
-#endif
-    .name = "test_wibble",
-    .sstate = TRACE_TEST_WIBBLE_ENABLED,
-    .dstate = &_TRACE_TEST_WIBBLE_DSTATE
-};
-TraceEvent *testsuite_trace_events[] = {
-    &_TRACE_TEST_BLAH_EVENT,
-    &_TRACE_TEST_WIBBLE_EVENT,
-  NULL,
-};
-
-static void trace_testsuite_register_events(void)
-{
-    trace_event_register_group(testsuite_trace_events);
-}
-trace_init(trace_testsuite_register_events)
diff --git a/tests/tracetool/nop.h b/tests/tracetool/nop.h
index 443f5e0cf6e..64b6b005684 100644
--- a/tests/tracetool/nop.h
+++ b/tests/tracetool/nop.h
@@ -6,10 +6,8 @@
 
 #include "trace/control.h"
 
-extern TraceEvent _TRACE_TEST_BLAH_EVENT;
-extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
-extern uint8_t _TRACE_TEST_BLAH_DSTATE;
-extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
+#define _TRACE_TEST_BLAH_DSTATE 0
+#define _TRACE_TEST_WIBBLE_DSTATE 0
 #define TRACE_TEST_BLAH_ENABLED 1
 #define TRACE_TEST_WIBBLE_ENABLED 1
 
-- 
2.55.0


