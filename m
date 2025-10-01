Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA65CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yoL-0001g4-TQ; Wed, 01 Oct 2025 11:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3yoD-0001cZ-NR
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:32:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3yni-0005tc-T8
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759332682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1NFPRZMGKA5GojK2Eiqgk5lbbAa5XUzJpyJEOYxBKkU=;
 b=WL+MK7f5oJWDTFwFdmqccaKS/PsSN/A+9m3NzJnk9TtJPOpd0p7bwCGMns4XmXhAtimACQ
 KwfFln0kEM/9SszWe5lCWhb8ixZJhAI56wI5gMSGDs91j2z7Mj92+mdTWbOD75/wtrlMHo
 tEKu/xRHOSivjgDYApLGCPH+2yvjUoo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-utd9tpf9P5CccIbo7YdTQQ-1; Wed,
 01 Oct 2025 11:31:19 -0400
X-MC-Unique: utd9tpf9P5CccIbo7YdTQQ-1
X-Mimecast-MFC-AGG-ID: utd9tpf9P5CccIbo7YdTQQ_1759332676
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4D54180057B; Wed,  1 Oct 2025 15:31:16 +0000 (UTC)
Received: from localhost (unknown [10.2.16.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88D501955F1A; Wed,  1 Oct 2025 15:31:15 +0000 (UTC)
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
Subject: [PULL 06/16] tracetool: add CHECK_TRACE_EVENT_GET_STATE
Date: Wed,  1 Oct 2025 11:30:49 -0400
Message-ID: <20251001153059.194991-7-stefanha@redhat.com>
In-Reply-To: <20251001153059.194991-1-stefanha@redhat.com>
References: <20251001153059.194991-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add a new attribute CHECK_TRACE_EVENT_GET_STATE to the backends.
When present and True, the code generated by the generate function
is wrapped in a conditional that checks whether the event is enabled;
this removes the need for repeating the same conditional in multiple
backends.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250929154938.594389-7-pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool/backend/__init__.py | 39 ++++++++++++++++++---------
 scripts/tracetool/format/h.py         | 11 +++++---
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index bf91e443e9..9109a783c7 100644
--- a/scripts/tracetool/backend/__init__.py
+++ b/scripts/tracetool/backend/__init__.py
@@ -19,11 +19,15 @@
 Backend attributes
 ------------------
 
-========= ====================================================================
-Attribute Description
-========= ====================================================================
-PUBLIC    If exists and is set to 'True', the backend is considered "public".
-========= ====================================================================
+=========================== ====================================================
+Attribute                   Description
+=========================== ====================================================
+PUBLIC                      If exists and is set to 'True', the backend is
+                            considered "public".
+CHECK_TRACE_EVENT_GET_STATE If exists and is set to 'True', the backend-specific
+                            code inside the tracepoint is emitted within an
+                            ``if trace_event_get_state()`` conditional.
+=========================== ====================================================
 
 
 Backend functions
@@ -101,22 +105,33 @@ class Wrapper:
     def __init__(self, backends, format):
         self._backends = [backend.replace("-", "_") for backend in backends]
         self._format = format.replace("-", "_")
+        self.check_trace_event_get_state = False
         for backend in self._backends:
             assert exists(backend)
         assert tracetool.format.exists(self._format)
+        for backend in self.backend_modules():
+            check_trace_event_get_state = getattr(backend, "CHECK_TRACE_EVENT_GET_STATE", False)
+            self.check_trace_event_get_state = self.check_trace_event_get_state or check_trace_event_get_state
 
-    def _run_function(self, name, *args, **kwargs):
+    def backend_modules(self):
         for backend in self._backends:
-            func = tracetool.try_import("tracetool.backend." + backend,
-                                        name % self._format, None)[1]
-            if func is not None:
-                func(*args, **kwargs)
+             module = tracetool.try_import("tracetool.backend." + backend)[1]
+             if module is not None:
+                 yield module
+
+    def _run_function(self, name, *args, check_trace_event_get_state=None, **kwargs):
+        for backend in self.backend_modules():
+            func = getattr(backend, name % self._format, None)
+            if func is not None and \
+                (check_trace_event_get_state is None or
+                 check_trace_event_get_state == getattr(backend, 'CHECK_TRACE_EVENT_GET_STATE', False)):
+                    func(*args, **kwargs)
 
     def generate_begin(self, events, group):
         self._run_function("generate_%s_begin", events, group)
 
-    def generate(self, event, group):
-        self._run_function("generate_%s", event, group)
+    def generate(self, event, group, check_trace_event_get_state=None):
+        self._run_function("generate_%s", event, group, check_trace_event_get_state=check_trace_event_get_state)
 
     def generate_backend_dstate(self, event, group):
         self._run_function("generate_%s_backend_dstate", event, group)
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index be7f32e67b..dd58713a15 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -55,7 +55,6 @@ def generate(events, backend, group):
 
         out('    false)')
 
-        # tracer without checks
         out('',
             'static inline void %(api)s(%(args)s)',
             '{',
@@ -63,11 +62,17 @@ def generate(events, backend, group):
             args=e.args)
 
         if "disable" not in e.properties:
-            backend.generate(e, group)
+            backend.generate(e, group, check_trace_event_get_state=False)
 
+            if backend.check_trace_event_get_state:
+                event_id = 'TRACE_' + e.name.upper()
+                cond = "trace_event_get_state(%s)" % event_id
+                out('    if (%(cond)s) {',
+                        cond=cond)
+                backend.generate(e, group, check_trace_event_get_state=True)
+                out('    }')
         out('}')
 
-
     backend.generate_end(events, group)
 
     out('#endif /* TRACE_%s_GENERATED_TRACERS_H */' % group.upper())
-- 
2.51.0


