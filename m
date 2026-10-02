Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2B7CA5FE0
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCZx2-0003hX-RS; Fri, 02 Oct 2026 05:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCZx0-0003cd-Hz
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCZwy-0000za-To
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790934788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X7YbMZC0kR2fPsuHwEbPKqUR/NsfnBQ2wcc8lWRPPNE=;
 b=GNc5c7QK9RBTahH4pGRKj3nivYedKQAO8FvEzzoyeFoXaOyeYscJrweg92AKRc0XElDWdo
 LOBJPZky3WY5gMgXRYDsfwebWh/5FcPo/AWRgdVXk2O0wIQjVJIacFRcx4Vw11ngiIxxLu
 X7+fpbBM3eScjqknUy2fitQevPFdJ1I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-dqZMp0AuPCuPawoIzXE1aQ-1; Fri,
 02 Oct 2026 05:53:04 -0400
X-MC-Unique: dqZMp0AuPCuPawoIzXE1aQ-1
X-Mimecast-MFC-AGG-ID: dqZMp0AuPCuPawoIzXE1aQ_1790934783
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C316D1800EEC; Fri,  2 Oct 2026 09:53:03 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88B8B180049F; Fri,  2 Oct 2026 09:53:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 16/20] trace: include qemu_loglevel_mask(LOG_TRACE) in guard
Date: Fri,  2 Oct 2026 10:52:28 +0100
Message-ID: <20261002095232.3605567-17-berrange@redhat.com>
In-Reply-To: <20261002095232.3605567-1-berrange@redhat.com>
References: <20261002095232.3605567-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If emitting a trace event requires computation for the parameters
passed to the probe, the callers should guard that computation
with trace_event_by_state_backends(), which is a macro expanding
to the a check of the "TRACE_...._DSTATE()" expression. For the
log backend this should include a check for LOG_TRACE being
present in the configured log level.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/tracetool/backend/log.py | 3 ++-
 tests/tracetool/all.h            | 6 ++++--
 tests/tracetool/log.h            | 6 ++++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index 9e3e5046f5f..7834e5b0d40 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -42,7 +42,8 @@ def generate_h(event, group):
 
 
 def generate_h_backend_dstate(event, group):
-    out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
+    out('    (trace_event_get_state_dynamic_by_id(%(event_id)s) && \\\n'
+        '     qemu_loglevel_mask(LOG_TRACE)) || \\',
         event_id="TRACE_" + event.name.upper())
 
 def generate_rs(event, group):
diff --git a/tests/tracetool/all.h b/tests/tracetool/all.h
index 41fa4d0e8a2..a2c2d40388e 100644
--- a/tests/tracetool/all.h
+++ b/tests/tracetool/all.h
@@ -45,7 +45,8 @@ void _simple_trace_test_wibble(void *context, int value);
 #define TRACE_TEST_BLAH_BACKEND_DSTATE() ( \
     QEMU_TEST_BLAH_ENABLED() || \
     trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
-    trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
+    (trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) && \
+     qemu_loglevel_mask(LOG_TRACE)) || \
     trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
     trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
     tracepoint_enabled(qemu, test_blah) || \
@@ -74,7 +75,8 @@ static inline void trace_test_blah(void *context, const char *filename)
 #define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
     QEMU_TEST_WIBBLE_ENABLED() || \
     trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
-    trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
+    (trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) && \
+     qemu_loglevel_mask(LOG_TRACE)) || \
     trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
     trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
     tracepoint_enabled(qemu, test_wibble) || \
diff --git a/tests/tracetool/log.h b/tests/tracetool/log.h
index ff510d54908..fe08277887f 100644
--- a/tests/tracetool/log.h
+++ b/tests/tracetool/log.h
@@ -16,7 +16,8 @@ extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
 
 
 #define TRACE_TEST_BLAH_BACKEND_DSTATE() ( \
-    trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
+    (trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) && \
+     qemu_loglevel_mask(LOG_TRACE)) || \
     false)
 
 static inline void trace_test_blah(void *context, const char *filename)
@@ -31,7 +32,8 @@ static inline void trace_test_blah(void *context, const char *filename)
 }
 
 #define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
-    trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
+    (trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) && \
+     qemu_loglevel_mask(LOG_TRACE)) || \
     false)
 
 static inline void trace_test_wibble(void *context, int value)
-- 
2.55.0


