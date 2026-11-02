Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9F2606A90A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KGFve16X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNt2C-0007tI-FI; Mon, 02 Nov 2026 09:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNt24-0007q1-Gk
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:29:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNt20-00078n-R5
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793629743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52FBCEGOSIF52Yt3Fxj2P82A8OnRPXEvnjHC2AfX3ws=;
 b=KGFve16XkGCZp3v2lN8AJ6Fs4fZK6QgBLRXrVyou4W+/wF57XsgXCacjosSys8SAvr96OZ
 aPDW1s/LWr1kTwBDgbZglE6Ss+F3b6XETzJXBlnrUSpyHtwD2Epm9HwXQnH64+7PA8tPxp
 BSDft5e0IM/wyLD3DbOOwncHM0Wu8oo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-dpoDFXDAO0qLIoaK4ZpCzw-1; Mon,
 02 Nov 2026 09:29:02 -0500
X-MC-Unique: dpoDFXDAO0qLIoaK4ZpCzw-1
X-Mimecast-MFC-AGG-ID: dpoDFXDAO0qLIoaK4ZpCzw_1793629741
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30A4E1800771
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 14:29:01 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E72EA180057F; Mon,  2 Nov 2026 14:28:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v4 09/25] trace: change "DSTATE" variables from uint16_t to
 uint8_t
Date: Mon,  2 Nov 2026 14:28:28 +0000
Message-ID: <20261102142844.3464712-10-berrange@redhat.com>
In-Reply-To: <20261102142844.3464712-1-berrange@redhat.com>
References: <20261102142844.3464712-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Previously these variables had two distinct semantics. For
most probes DSTATE was treated as a simple boolean, while
for vcpu probes it was treated as a bitmask of vCPU indexes.

With vcpu probes removed, it is now exclusively a boolean
and thus using uint16_t is a waste of memory.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/tracetool/format/c.py  | 2 +-
 scripts/tracetool/format/h.py  | 2 +-
 scripts/tracetool/format/rs.py | 4 ++--
 tests/tracetool/dtrace.c       | 4 ++--
 tests/tracetool/dtrace.h       | 4 ++--
 tests/tracetool/dtrace.rs      | 6 +++---
 tests/tracetool/ftrace.c       | 4 ++--
 tests/tracetool/ftrace.h       | 4 ++--
 tests/tracetool/ftrace.rs      | 6 +++---
 tests/tracetool/log.c          | 4 ++--
 tests/tracetool/log.h          | 4 ++--
 tests/tracetool/log.rs         | 6 +++---
 tests/tracetool/simple.c       | 4 ++--
 tests/tracetool/simple.h       | 4 ++--
 tests/tracetool/simple.rs      | 6 +++---
 tests/tracetool/syslog.c       | 4 ++--
 tests/tracetool/syslog.h       | 4 ++--
 tests/tracetool/syslog.rs      | 6 +++---
 tests/tracetool/ust.c          | 4 ++--
 tests/tracetool/ust.h          | 4 ++--
 trace/event-internal.h         | 2 +-
 21 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index abe738ac423..de1c154a881 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -30,7 +30,7 @@ def generate(events, backend, group):
         '')
 
     for e in events:
-        out('uint16_t %s;' % e.api(e.QEMU_DSTATE))
+        out('uint8_t %s;' % e.api(e.QEMU_DSTATE))
 
     for e in events:
         out('TraceEvent %(event)s = {',
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index dd58713a158..4dc1ad7eb15 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -32,7 +32,7 @@ def generate(events, backend, group):
             event = e.api(e.QEMU_EVENT))
 
     for e in events:
-        out('extern uint16_t %s;' % e.api(e.QEMU_DSTATE))
+        out('extern uint8_t %s;' % e.api(e.QEMU_DSTATE))
 
     # static state
     for e in events:
diff --git a/scripts/tracetool/format/rs.py b/scripts/tracetool/format/rs.py
index 7d9af7edfee..1fddcee1ad2 100644
--- a/scripts/tracetool/format/rs.py
+++ b/scripts/tracetool/format/rs.py
@@ -26,7 +26,7 @@ def generate(events, backend, group):
         '',
         '#[allow(dead_code)]',
         '#[inline(always)]',
-        'fn trace_event_state_is_enabled(dstate: u16) -> bool {',
+        'fn trace_event_state_is_enabled(dstate: u8) -> bool {',
         '    (unsafe { trace_events_enabled_count }) != 0 && dstate != 0',
         '}',
         '',
@@ -39,7 +39,7 @@ def generate(events, backend, group):
 
     for e in events:
         out('    #[allow(dead_code)]',
-            '    static mut %s: u16;' % e.api(e.QEMU_DSTATE))
+            '    static mut %s: u8;' % e.api(e.QEMU_DSTATE))
     out('}',
         '')
 
diff --git a/tests/tracetool/dtrace.c b/tests/tracetool/dtrace.c
index 05a93918240..f83d06252ea 100644
--- a/tests/tracetool/dtrace.c
+++ b/tests/tracetool/dtrace.c
@@ -5,8 +5,8 @@
 #include "qemu/module.h"
 #include "trace-testsuite.h"
 
-uint16_t _TRACE_TEST_BLAH_DSTATE;
-uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+uint8_t _TRACE_TEST_BLAH_DSTATE;
+uint8_t _TRACE_TEST_WIBBLE_DSTATE;
 TraceEvent _TRACE_TEST_BLAH_EVENT = {
 #ifdef CONFIG_TRACE_SIMPLE
     .id = 0,
diff --git a/tests/tracetool/dtrace.h b/tests/tracetool/dtrace.h
index c8931a8d7b3..0b5b47089e8 100644
--- a/tests/tracetool/dtrace.h
+++ b/tests/tracetool/dtrace.h
@@ -8,8 +8,8 @@
 
 extern TraceEvent _TRACE_TEST_BLAH_EVENT;
 extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
-extern uint16_t _TRACE_TEST_BLAH_DSTATE;
-extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+extern uint8_t _TRACE_TEST_BLAH_DSTATE;
+extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
 #define TRACE_TEST_BLAH_ENABLED 1
 #define TRACE_TEST_WIBBLE_ENABLED 1
 #ifndef SDT_USE_VARIADIC
diff --git a/tests/tracetool/dtrace.rs b/tests/tracetool/dtrace.rs
index 3490fcb271a..07398f4731b 100644
--- a/tests/tracetool/dtrace.rs
+++ b/tests/tracetool/dtrace.rs
@@ -8,7 +8,7 @@
 
 #[allow(dead_code)]
 #[inline(always)]
-fn trace_event_state_is_enabled(dstate: u16) -> bool {
+fn trace_event_state_is_enabled(dstate: u8) -> bool {
     (unsafe { trace_events_enabled_count }) != 0 && dstate != 0
 }
 
@@ -18,9 +18,9 @@ fn trace_event_state_is_enabled(dstate: u16) -> bool {
 }
 extern "C" {
     #[allow(dead_code)]
-    static mut _TRACE_TEST_BLAH_DSTATE: u16;
+    static mut _TRACE_TEST_BLAH_DSTATE: u8;
     #[allow(dead_code)]
-    static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
+    static mut _TRACE_TEST_WIBBLE_DSTATE: u8;
 }
 
 use std::cell::UnsafeCell;
diff --git a/tests/tracetool/ftrace.c b/tests/tracetool/ftrace.c
index 05a93918240..f83d06252ea 100644
--- a/tests/tracetool/ftrace.c
+++ b/tests/tracetool/ftrace.c
@@ -5,8 +5,8 @@
 #include "qemu/module.h"
 #include "trace-testsuite.h"
 
-uint16_t _TRACE_TEST_BLAH_DSTATE;
-uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+uint8_t _TRACE_TEST_BLAH_DSTATE;
+uint8_t _TRACE_TEST_WIBBLE_DSTATE;
 TraceEvent _TRACE_TEST_BLAH_EVENT = {
 #ifdef CONFIG_TRACE_SIMPLE
     .id = 0,
diff --git a/tests/tracetool/ftrace.h b/tests/tracetool/ftrace.h
index 1dfe4239413..b34eef17d10 100644
--- a/tests/tracetool/ftrace.h
+++ b/tests/tracetool/ftrace.h
@@ -8,8 +8,8 @@
 
 extern TraceEvent _TRACE_TEST_BLAH_EVENT;
 extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
-extern uint16_t _TRACE_TEST_BLAH_DSTATE;
-extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+extern uint8_t _TRACE_TEST_BLAH_DSTATE;
+extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
 #define TRACE_TEST_BLAH_ENABLED 1
 #define TRACE_TEST_WIBBLE_ENABLED 1
 #include "trace/ftrace.h"
diff --git a/tests/tracetool/ftrace.rs b/tests/tracetool/ftrace.rs
index 34f66004902..ff0bcde4b8b 100644
--- a/tests/tracetool/ftrace.rs
+++ b/tests/tracetool/ftrace.rs
@@ -8,7 +8,7 @@
 
 #[allow(dead_code)]
 #[inline(always)]
-fn trace_event_state_is_enabled(dstate: u16) -> bool {
+fn trace_event_state_is_enabled(dstate: u8) -> bool {
     (unsafe { trace_events_enabled_count }) != 0 && dstate != 0
 }
 
@@ -18,9 +18,9 @@ fn trace_event_state_is_enabled(dstate: u16) -> bool {
 }
 extern "C" {
     #[allow(dead_code)]
-    static mut _TRACE_TEST_BLAH_DSTATE: u16;
+    static mut _TRACE_TEST_BLAH_DSTATE: u8;
     #[allow(dead_code)]
-    static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
+    static mut _TRACE_TEST_WIBBLE_DSTATE: u8;
 }
 
 #[inline(always)]
diff --git a/tests/tracetool/log.c b/tests/tracetool/log.c
index 05a93918240..f83d06252ea 100644
--- a/tests/tracetool/log.c
+++ b/tests/tracetool/log.c
@@ -5,8 +5,8 @@
 #include "qemu/module.h"
 #include "trace-testsuite.h"
 
-uint16_t _TRACE_TEST_BLAH_DSTATE;
-uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+uint8_t _TRACE_TEST_BLAH_DSTATE;
+uint8_t _TRACE_TEST_WIBBLE_DSTATE;
 TraceEvent _TRACE_TEST_BLAH_EVENT = {
 #ifdef CONFIG_TRACE_SIMPLE
     .id = 0,
diff --git a/tests/tracetool/log.h b/tests/tracetool/log.h
index c7795871f85..ff510d54908 100644
--- a/tests/tracetool/log.h
+++ b/tests/tracetool/log.h
@@ -8,8 +8,8 @@
 
 extern TraceEvent _TRACE_TEST_BLAH_EVENT;
 extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
-extern uint16_t _TRACE_TEST_BLAH_DSTATE;
-extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+extern uint8_t _TRACE_TEST_BLAH_DSTATE;
+extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
 #define TRACE_TEST_BLAH_ENABLED 1
 #define TRACE_TEST_WIBBLE_ENABLED 1
 #include "qemu/log-for-trace.h"
diff --git a/tests/tracetool/log.rs b/tests/tracetool/log.rs
index 770758611d1..0f052bb2c9c 100644
--- a/tests/tracetool/log.rs
+++ b/tests/tracetool/log.rs
@@ -8,7 +8,7 @@
 
 #[allow(dead_code)]
 #[inline(always)]
-fn trace_event_state_is_enabled(dstate: u16) -> bool {
+fn trace_event_state_is_enabled(dstate: u8) -> bool {
     (unsafe { trace_events_enabled_count }) != 0 && dstate != 0
 }
 
@@ -18,9 +18,9 @@ fn trace_event_state_is_enabled(dstate: u16) -> bool {
 }
 extern "C" {
     #[allow(dead_code)]
-    static mut _TRACE_TEST_BLAH_DSTATE: u16;
+    static mut _TRACE_TEST_BLAH_DSTATE: u8;
     #[allow(dead_code)]
-    static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
+    static mut _TRACE_TEST_WIBBLE_DSTATE: u8;
 }
 
 #[inline(always)]
diff --git a/tests/tracetool/simple.c b/tests/tracetool/simple.c
index 490d6f379a5..820ddb575b0 100644
--- a/tests/tracetool/simple.c
+++ b/tests/tracetool/simple.c
@@ -5,8 +5,8 @@
 #include "qemu/module.h"
 #include "trace-testsuite.h"
 
-uint16_t _TRACE_TEST_BLAH_DSTATE;
-uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+uint8_t _TRACE_TEST_BLAH_DSTATE;
+uint8_t _TRACE_TEST_WIBBLE_DSTATE;
 TraceEvent _TRACE_TEST_BLAH_EVENT = {
 #ifdef CONFIG_TRACE_SIMPLE
     .id = 0,
diff --git a/tests/tracetool/simple.h b/tests/tracetool/simple.h
index ec6fcb22c3c..735cb21d911 100644
--- a/tests/tracetool/simple.h
+++ b/tests/tracetool/simple.h
@@ -8,8 +8,8 @@
 
 extern TraceEvent _TRACE_TEST_BLAH_EVENT;
 extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
-extern uint16_t _TRACE_TEST_BLAH_DSTATE;
-extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+extern uint8_t _TRACE_TEST_BLAH_DSTATE;
+extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
 #define TRACE_TEST_BLAH_ENABLED 1
 #define TRACE_TEST_WIBBLE_ENABLED 1
 void _simple_trace_test_blah(void *context, const char *filename);
diff --git a/tests/tracetool/simple.rs b/tests/tracetool/simple.rs
index 92f896ef178..976feddde5b 100644
--- a/tests/tracetool/simple.rs
+++ b/tests/tracetool/simple.rs
@@ -8,7 +8,7 @@
 
 #[allow(dead_code)]
 #[inline(always)]
-fn trace_event_state_is_enabled(dstate: u16) -> bool {
+fn trace_event_state_is_enabled(dstate: u8) -> bool {
     (unsafe { trace_events_enabled_count }) != 0 && dstate != 0
 }
 
@@ -18,9 +18,9 @@ fn trace_event_state_is_enabled(dstate: u16) -> bool {
 }
 extern "C" {
     #[allow(dead_code)]
-    static mut _TRACE_TEST_BLAH_DSTATE: u16;
+    static mut _TRACE_TEST_BLAH_DSTATE: u8;
     #[allow(dead_code)]
-    static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
+    static mut _TRACE_TEST_WIBBLE_DSTATE: u8;
 }
 
 #[inline(always)]
diff --git a/tests/tracetool/syslog.c b/tests/tracetool/syslog.c
index 05a93918240..f83d06252ea 100644
--- a/tests/tracetool/syslog.c
+++ b/tests/tracetool/syslog.c
@@ -5,8 +5,8 @@
 #include "qemu/module.h"
 #include "trace-testsuite.h"
 
-uint16_t _TRACE_TEST_BLAH_DSTATE;
-uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+uint8_t _TRACE_TEST_BLAH_DSTATE;
+uint8_t _TRACE_TEST_WIBBLE_DSTATE;
 TraceEvent _TRACE_TEST_BLAH_EVENT = {
 #ifdef CONFIG_TRACE_SIMPLE
     .id = 0,
diff --git a/tests/tracetool/syslog.h b/tests/tracetool/syslog.h
index ed4305554c1..4203b8b37dc 100644
--- a/tests/tracetool/syslog.h
+++ b/tests/tracetool/syslog.h
@@ -8,8 +8,8 @@
 
 extern TraceEvent _TRACE_TEST_BLAH_EVENT;
 extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
-extern uint16_t _TRACE_TEST_BLAH_DSTATE;
-extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+extern uint8_t _TRACE_TEST_BLAH_DSTATE;
+extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
 #define TRACE_TEST_BLAH_ENABLED 1
 #define TRACE_TEST_WIBBLE_ENABLED 1
 #include <syslog.h>
diff --git a/tests/tracetool/syslog.rs b/tests/tracetool/syslog.rs
index 378d03d34b2..9688dac84a5 100644
--- a/tests/tracetool/syslog.rs
+++ b/tests/tracetool/syslog.rs
@@ -8,7 +8,7 @@
 
 #[allow(dead_code)]
 #[inline(always)]
-fn trace_event_state_is_enabled(dstate: u16) -> bool {
+fn trace_event_state_is_enabled(dstate: u8) -> bool {
     (unsafe { trace_events_enabled_count }) != 0 && dstate != 0
 }
 
@@ -18,9 +18,9 @@ fn trace_event_state_is_enabled(dstate: u16) -> bool {
 }
 extern "C" {
     #[allow(dead_code)]
-    static mut _TRACE_TEST_BLAH_DSTATE: u16;
+    static mut _TRACE_TEST_BLAH_DSTATE: u8;
     #[allow(dead_code)]
-    static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
+    static mut _TRACE_TEST_WIBBLE_DSTATE: u8;
 }
 
 #[inline(always)]
diff --git a/tests/tracetool/ust.c b/tests/tracetool/ust.c
index 05a93918240..f83d06252ea 100644
--- a/tests/tracetool/ust.c
+++ b/tests/tracetool/ust.c
@@ -5,8 +5,8 @@
 #include "qemu/module.h"
 #include "trace-testsuite.h"
 
-uint16_t _TRACE_TEST_BLAH_DSTATE;
-uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+uint8_t _TRACE_TEST_BLAH_DSTATE;
+uint8_t _TRACE_TEST_WIBBLE_DSTATE;
 TraceEvent _TRACE_TEST_BLAH_EVENT = {
 #ifdef CONFIG_TRACE_SIMPLE
     .id = 0,
diff --git a/tests/tracetool/ust.h b/tests/tracetool/ust.h
index b7acd0c39b1..079b2c74491 100644
--- a/tests/tracetool/ust.h
+++ b/tests/tracetool/ust.h
@@ -8,8 +8,8 @@
 
 extern TraceEvent _TRACE_TEST_BLAH_EVENT;
 extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
-extern uint16_t _TRACE_TEST_BLAH_DSTATE;
-extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+extern uint8_t _TRACE_TEST_BLAH_DSTATE;
+extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
 #define TRACE_TEST_BLAH_ENABLED 1
 #define TRACE_TEST_WIBBLE_ENABLED 1
 #include <lttng/tracepoint.h>
diff --git a/trace/event-internal.h b/trace/event-internal.h
index ecf2caabd03..ad1578aa2c5 100644
--- a/trace/event-internal.h
+++ b/trace/event-internal.h
@@ -25,7 +25,7 @@ typedef struct TraceEvent {
 #endif
     const char * name;
     const bool sstate;
-    uint16_t *dstate;
+    uint8_t *dstate;
 } TraceEvent;
 
 #endif /* TRACE__EVENT_INTERNAL_H */
-- 
2.56.0


