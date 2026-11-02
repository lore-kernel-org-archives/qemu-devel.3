Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A074606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dP2bgzQm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNxJM-0003nd-Jm; Mon, 02 Nov 2026 14:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xNxHl-0001w9-8n
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 14:01:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xNxHf-0008DC-Ij
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 14:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793646089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sNaYu08RePiA3/TOJj7oi5LlAFNAX4bokf8QMENnVcY=;
 b=dP2bgzQmj8iF9VsTpqt6XFPtKrLCmtv3UafsXMrNaQ416UGl4fEMMvN5Op/8NWmWNE7Sf/
 IPeeKcGGiyaWvDCgAhaBZAFwk9Zw/OoYtkMfE/M/AMCJTLe8o0/OlnOpT8KRdC4Zwk+vTk
 JSByF3JVVRzBBLcGS17qgrDjbqx070s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-bDpS0_1SNbuIVeQYkiMFXQ-1; Mon,
 02 Nov 2026 14:01:25 -0500
X-MC-Unique: bDpS0_1SNbuIVeQYkiMFXQ-1
X-Mimecast-MFC-AGG-ID: bDpS0_1SNbuIVeQYkiMFXQ_1793646084
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FBC3180134F; Mon,  2 Nov 2026 19:01:24 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC01B1800444; Mon,  2 Nov 2026 19:01:23 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Helge Deller <deller@gmx.de>, xen-devel@lists.xenproject.org,
 Anthony PERARD <anthony@xenproject.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 11/25] trace: don't emit TraceEvent structs when 'nop' backend
 is used
Date: Mon,  2 Nov 2026 13:58:17 -0500
Message-ID: <20261102185831.1880189-12-stefanha@redhat.com>
In-Reply-To: <20261102185831.1880189-1-stefanha@redhat.com>
References: <20261102185831.1880189-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel P. Berrangé <berrange@redhat.com>

The 'nop' backend is a short-hand for no trace probe usage
at all. The emitted functions become a no-op, and as such
there is no need to emit the TraceEvent structs, nor the
DSTATE variables they reference.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20261102142844.3464712-12-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/tracetool/nop.h         |  6 +--
 tests/tracetool/nop.c         | 29 ---------------
 scripts/tracetool/format/c.py | 69 ++++++++++++++++++-----------------
 scripts/tracetool/format/h.py | 14 ++++---
 4 files changed, 46 insertions(+), 72 deletions(-)

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
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index de1c154a881..5f6669c917c 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -29,41 +29,42 @@ def generate(events, backend, group):
         '#include "%s"' % header,
         '')
 
-    for e in events:
-        out('uint8_t %s;' % e.api(e.QEMU_DSTATE))
+    if len(list(backend.backend_modules())):
+        for e in events:
+            out('uint8_t %s;' % e.api(e.QEMU_DSTATE))
 
-    for e in events:
-        out('TraceEvent %(event)s = {',
-            '#ifdef CONFIG_TRACE_SIMPLE',
-            '    .id = 0,',
-            '#endif',
-            '    .name = \"%(name)s\",',
-            '    .sstate = %(sstate)s,',
-            '    .dstate = &%(dstate)s',
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
+            '')
 
-    out('TraceEvent *%(group)s_trace_events[] = {',
-        group = group.lower())
+        out('static void trace_%(group)s_register_events(void)',
+            '{',
+            '    trace_event_register_group(%(group)s_trace_events);',
+            '}',
+            'trace_init(trace_%(group)s_register_events)',
+            group = group.lower())
 
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
+    if len(list(backend.backend_modules())):
+        for e in events:
+            out('extern TraceEvent %(event)s;',
+                event = e.api(e.QEMU_EVENT))
 
-    for e in events:
-        out('extern uint8_t %s;' % e.api(e.QEMU_DSTATE))
+        for e in events:
+            out('extern uint8_t %s;' % e.api(e.QEMU_DSTATE))
+    else:
+        for e in events:
+            out('#define %s 0' % e.api(e.QEMU_DSTATE))
 
     # static state
     for e in events:
-- 
2.56.0


