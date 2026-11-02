Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669FC606A927
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DJv7pvh6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNt2G-0007uf-Fl; Mon, 02 Nov 2026 09:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNt24-0007q0-AK
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:29:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNt20-00078c-RR
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793629742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TbQdyGh1LiyfzuTPR8+3OvaPIm/ZnewczRhdLqtZjrE=;
 b=DJv7pvh6RvxPjHDxvX1VNtQjAAjWwxd8rYt0zxZr2meji6ceGsKq8GiMMqKIZER+GSQaom
 HaErZDeoxRq23ND82KCrhIglAryCxAiOW8UGnL/TnPOvXkageMEfqRZfzm5onduY56n0uR
 e853HVwXwHXf1fz4Wx57N7SbVKvQLUA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-_VjD149ROsSBD9MAH969Lw-1; Mon,
 02 Nov 2026 09:29:00 -0500
X-MC-Unique: _VjD149ROsSBD9MAH969Lw-1
X-Mimecast-MFC-AGG-ID: _VjD149ROsSBD9MAH969Lw_1793629739
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96EDC194510C
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 14:28:59 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8142C1800480; Mon,  2 Nov 2026 14:28:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v4 08/25] trace: drop 'id' from TraceEvent struct when not
 required
Date: Mon,  2 Nov 2026 14:28:27 +0000
Message-ID: <20261102142844.3464712-9-berrange@redhat.com>
In-Reply-To: <20261102142844.3464712-1-berrange@redhat.com>
References: <20261102142844.3464712-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Only "simpletrace" uses the "id" field from the TraceEvent struct.
Omit it when this backend is not enabled to save memory.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/tracetool/format/c.py | 2 ++
 tests/tracetool/dtrace.c      | 4 ++++
 tests/tracetool/ftrace.c      | 4 ++++
 tests/tracetool/log.c         | 4 ++++
 tests/tracetool/simple.c      | 4 ++++
 tests/tracetool/syslog.c      | 4 ++++
 tests/tracetool/ust.c         | 4 ++++
 trace/control-internal.h      | 2 ++
 trace/control.c               | 4 +++-
 trace/control.h               | 3 ++-
 trace/event-internal.h        | 2 ++
 11 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index 50e03313cbf..abe738ac423 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -34,7 +34,9 @@ def generate(events, backend, group):
 
     for e in events:
         out('TraceEvent %(event)s = {',
+            '#ifdef CONFIG_TRACE_SIMPLE',
             '    .id = 0,',
+            '#endif',
             '    .name = \"%(name)s\",',
             '    .sstate = %(sstate)s,',
             '    .dstate = &%(dstate)s',
diff --git a/tests/tracetool/dtrace.c b/tests/tracetool/dtrace.c
index 9f862fa14d2..05a93918240 100644
--- a/tests/tracetool/dtrace.c
+++ b/tests/tracetool/dtrace.c
@@ -8,13 +8,17 @@
 uint16_t _TRACE_TEST_BLAH_DSTATE;
 uint16_t _TRACE_TEST_WIBBLE_DSTATE;
 TraceEvent _TRACE_TEST_BLAH_EVENT = {
+#ifdef CONFIG_TRACE_SIMPLE
     .id = 0,
+#endif
     .name = "test_blah",
     .sstate = TRACE_TEST_BLAH_ENABLED,
     .dstate = &_TRACE_TEST_BLAH_DSTATE
 };
 TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
+#ifdef CONFIG_TRACE_SIMPLE
     .id = 0,
+#endif
     .name = "test_wibble",
     .sstate = TRACE_TEST_WIBBLE_ENABLED,
     .dstate = &_TRACE_TEST_WIBBLE_DSTATE
diff --git a/tests/tracetool/ftrace.c b/tests/tracetool/ftrace.c
index 9f862fa14d2..05a93918240 100644
--- a/tests/tracetool/ftrace.c
+++ b/tests/tracetool/ftrace.c
@@ -8,13 +8,17 @@
 uint16_t _TRACE_TEST_BLAH_DSTATE;
 uint16_t _TRACE_TEST_WIBBLE_DSTATE;
 TraceEvent _TRACE_TEST_BLAH_EVENT = {
+#ifdef CONFIG_TRACE_SIMPLE
     .id = 0,
+#endif
     .name = "test_blah",
     .sstate = TRACE_TEST_BLAH_ENABLED,
     .dstate = &_TRACE_TEST_BLAH_DSTATE
 };
 TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
+#ifdef CONFIG_TRACE_SIMPLE
     .id = 0,
+#endif
     .name = "test_wibble",
     .sstate = TRACE_TEST_WIBBLE_ENABLED,
     .dstate = &_TRACE_TEST_WIBBLE_DSTATE
diff --git a/tests/tracetool/log.c b/tests/tracetool/log.c
index 9f862fa14d2..05a93918240 100644
--- a/tests/tracetool/log.c
+++ b/tests/tracetool/log.c
@@ -8,13 +8,17 @@
 uint16_t _TRACE_TEST_BLAH_DSTATE;
 uint16_t _TRACE_TEST_WIBBLE_DSTATE;
 TraceEvent _TRACE_TEST_BLAH_EVENT = {
+#ifdef CONFIG_TRACE_SIMPLE
     .id = 0,
+#endif
     .name = "test_blah",
     .sstate = TRACE_TEST_BLAH_ENABLED,
     .dstate = &_TRACE_TEST_BLAH_DSTATE
 };
 TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
+#ifdef CONFIG_TRACE_SIMPLE
     .id = 0,
+#endif
     .name = "test_wibble",
     .sstate = TRACE_TEST_WIBBLE_ENABLED,
     .dstate = &_TRACE_TEST_WIBBLE_DSTATE
diff --git a/tests/tracetool/simple.c b/tests/tracetool/simple.c
index 0484177481c..490d6f379a5 100644
--- a/tests/tracetool/simple.c
+++ b/tests/tracetool/simple.c
@@ -8,13 +8,17 @@
 uint16_t _TRACE_TEST_BLAH_DSTATE;
 uint16_t _TRACE_TEST_WIBBLE_DSTATE;
 TraceEvent _TRACE_TEST_BLAH_EVENT = {
+#ifdef CONFIG_TRACE_SIMPLE
     .id = 0,
+#endif
     .name = "test_blah",
     .sstate = TRACE_TEST_BLAH_ENABLED,
     .dstate = &_TRACE_TEST_BLAH_DSTATE
 };
 TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
+#ifdef CONFIG_TRACE_SIMPLE
     .id = 0,
+#endif
     .name = "test_wibble",
     .sstate = TRACE_TEST_WIBBLE_ENABLED,
     .dstate = &_TRACE_TEST_WIBBLE_DSTATE
diff --git a/tests/tracetool/syslog.c b/tests/tracetool/syslog.c
index 9f862fa14d2..05a93918240 100644
--- a/tests/tracetool/syslog.c
+++ b/tests/tracetool/syslog.c
@@ -8,13 +8,17 @@
 uint16_t _TRACE_TEST_BLAH_DSTATE;
 uint16_t _TRACE_TEST_WIBBLE_DSTATE;
 TraceEvent _TRACE_TEST_BLAH_EVENT = {
+#ifdef CONFIG_TRACE_SIMPLE
     .id = 0,
+#endif
     .name = "test_blah",
     .sstate = TRACE_TEST_BLAH_ENABLED,
     .dstate = &_TRACE_TEST_BLAH_DSTATE
 };
 TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
+#ifdef CONFIG_TRACE_SIMPLE
     .id = 0,
+#endif
     .name = "test_wibble",
     .sstate = TRACE_TEST_WIBBLE_ENABLED,
     .dstate = &_TRACE_TEST_WIBBLE_DSTATE
diff --git a/tests/tracetool/ust.c b/tests/tracetool/ust.c
index 9f862fa14d2..05a93918240 100644
--- a/tests/tracetool/ust.c
+++ b/tests/tracetool/ust.c
@@ -8,13 +8,17 @@
 uint16_t _TRACE_TEST_BLAH_DSTATE;
 uint16_t _TRACE_TEST_WIBBLE_DSTATE;
 TraceEvent _TRACE_TEST_BLAH_EVENT = {
+#ifdef CONFIG_TRACE_SIMPLE
     .id = 0,
+#endif
     .name = "test_blah",
     .sstate = TRACE_TEST_BLAH_ENABLED,
     .dstate = &_TRACE_TEST_BLAH_DSTATE
 };
 TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
+#ifdef CONFIG_TRACE_SIMPLE
     .id = 0,
+#endif
     .name = "test_wibble",
     .sstate = TRACE_TEST_WIBBLE_ENABLED,
     .dstate = &_TRACE_TEST_WIBBLE_DSTATE
diff --git a/trace/control-internal.h b/trace/control-internal.h
index 8d818d359be..f626b047264 100644
--- a/trace/control-internal.h
+++ b/trace/control-internal.h
@@ -19,11 +19,13 @@ static inline bool trace_event_is_pattern(const char *str)
     return strchr(str, '*') != NULL;
 }
 
+#ifdef CONFIG_TRACE_SIMPLE
 static inline uint32_t trace_event_get_id(TraceEvent *ev)
 {
     assert(ev != NULL);
     return ev->id;
 }
+#endif
 
 static inline const char * trace_event_get_name(TraceEvent *ev)
 {
diff --git a/trace/control.c b/trace/control.c
index 6971157cbe7..947b220056a 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -36,8 +36,8 @@ typedef struct TraceEventGroup {
 
 static TraceEventGroup *event_groups;
 static size_t nevent_groups;
-static uint32_t next_id;
 #ifdef CONFIG_TRACE_SIMPLE
+static uint32_t next_id;
 static bool init_trace_on_startup;
 #endif
 static char *trace_opts_file;
@@ -65,10 +65,12 @@ QemuOptsList qemu_trace_opts = {
 
 void trace_event_register_group(TraceEvent **events)
 {
+#ifdef CONFIG_TRACE_SIMPLE
     size_t i;
     for (i = 0; events[i] != NULL; i++) {
         events[i]->id = next_id++;
     }
+#endif
     event_groups = g_renew(TraceEventGroup, event_groups, nevent_groups + 1);
     event_groups[nevent_groups].events = events;
     nevent_groups++;
diff --git a/trace/control.h b/trace/control.h
index 20033fb6669..e77c07a8e68 100644
--- a/trace/control.h
+++ b/trace/control.h
@@ -81,13 +81,14 @@ TraceEvent *trace_event_name(const char *name);
  */
 static bool trace_event_is_pattern(const char *str);
 
-
+#ifdef CONFIG_TRACE_SIMPLE
 /**
  * trace_event_get_id:
  *
  * Get the identifier of an event.
  */
 static uint32_t trace_event_get_id(TraceEvent *ev);
+#endif
 
 /**
  * trace_event_get_name:
diff --git a/trace/event-internal.h b/trace/event-internal.h
index cc095a6ad54..ecf2caabd03 100644
--- a/trace/event-internal.h
+++ b/trace/event-internal.h
@@ -20,7 +20,9 @@
  * Opaque generic description of a tracing event.
  */
 typedef struct TraceEvent {
+#ifdef CONFIG_TRACE_SIMPLE
     uint32_t id;
+#endif
     const char * name;
     const bool sstate;
     uint16_t *dstate;
-- 
2.56.0


