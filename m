Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B9CCA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQrY-0004pc-PH; Fri, 22 Aug 2025 08:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrU-0004p0-NN
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrS-0002PQ-62
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755865632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ezw6poP6EwT3xiTZZdGt7/8xcnpH4DkcNhY/uPr1oxc=;
 b=UfORFCORuhFXinND9L9l4CRQ19/tJM9h8k9CHP0aNt6X9PVD57DiTVwrgsBvcfhpZ8jGrM
 LHOmeFNY2Pn7GXiZwIK0M//825A7ZxprJJihA6ur2hy/bS7aPLc7c2V86utS+j1FYiUBfE
 e5zDCnY232yJp6xw591HHcSTX6zbXEo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-9YdAeCBqM2WK1JK9fSa30g-1; Fri, 22 Aug 2025 08:27:10 -0400
X-MC-Unique: 9YdAeCBqM2WK1JK9fSa30g-1
X-Mimecast-MFC-AGG-ID: 9YdAeCBqM2WK1JK9fSa30g_1755865629
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45a1b0bd6a9so10663875e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 05:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755865628; x=1756470428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ezw6poP6EwT3xiTZZdGt7/8xcnpH4DkcNhY/uPr1oxc=;
 b=hULCuuRMb7ewctFm6Ff4KPZlu195n7Z3UFH8YuJ653Ym5YMlgtOgCH/X9k5cvQnZto
 spDOZnwAXrC9Egy7kI6TdKKiePcpbyWheHMHvCZ1t1a5vxfnv7xeA0BbzaG/LKZ2n6Uf
 6kf4ndktT01JOZr4+WgwaPF4H8UVbVit4pBOjEafIxUrdLApEuAMrudX/WLwCMJShf0Q
 NMEFR6GtCC2aHCD0sHDO/7INFI1ZPKEuNIhMXC7wuTgPxW6Ycn21WUfuN0x+ykXtibhl
 mAm6YTE0zT0/Xkx/Pgsby57h3bubKmpvv1fAurUQwBQTkZAl5CAtjKDL3ilnpueKonWr
 BL4w==
X-Gm-Message-State: AOJu0YzFTry+PFyCaatVFqCR854PD/o6uLE+Ke+IaFmwdXurFXhlSSFn
 QjbVw9yrHsiwe0/EUEsJ61uxxuiszciwpP+/iwZUX7s1r3mmxO1nxUaYEvZWoMAXkYTW8nHTfN8
 tJjEnO6rDjaLraauw3YafNWyRFOnRoBWVFpTHJlH8YUL5iUCAwkrBsQgeNkEBkEUDQ8W4lWqJhY
 WpHYM8JdeCu7QJRDpcnb4m7l4xLuFA9tQ2J2JUqAIv
X-Gm-Gg: ASbGncvtRdczAPlof/LF/SDtVFTE5SGx/vy5RvL27JykDMb7NeI0aJt+WHy/hfWZj28
 zNzAWPs7OtrAPr8idVWbE38F3zlIZLsxJCgHSkycWUWzg5HBkeNPQv91VkQifsVkd/o6VUqPP9h
 TwzIDUtW22ejigH9OmwfBcog6hz2k5MPH1nVhnaVfJXOfANVVaY++I8JxVaSyYsmenQMUxm3Iil
 RhvfVBbr0rPSKirNteIiUQ8d7yM07VQ8zaBMAQHVHZQHB4pqNlzHvTfzvT7s2N8/8D0lKCzC3BS
 4CgJLswhtuYAGII6sOkGaeS5FN5KXLgbLiH/AqyWrFSRvLXHSxuHVdKL5SfPuNVMpfDZ+B7d/aF
 MMKjaCyG5cFTeLgDgeBxF/PXJE2DA5iX5J7msCz4cWw==
X-Received: by 2002:a05:600c:1c87:b0:456:173c:8a53 with SMTP id
 5b1f17b1804b1-45b5179cdd5mr19509245e9.2.1755865628020; 
 Fri, 22 Aug 2025 05:27:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV+54LzJpzwiBDs+4j+CTQdQ3igqP641t7NzVQPwCCEU8J+IOpaxS9gpqYIIgrpPh0cAWfSA==
X-Received: by 2002:a05:600c:1c87:b0:456:173c:8a53 with SMTP id
 5b1f17b1804b1-45b5179cdd5mr19509005e9.2.1755865627351; 
 Fri, 22 Aug 2025 05:27:07 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b5096fb01sm24583025e9.1.2025.08.22.05.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 05:27:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tanishdesai37@gmail.com, stefanha@redhat.com, berrange@redhat.com,
 mads@ynddal.dk
Subject: [PATCH 04/14] tracetool: add CHECK_TRACE_EVENT_GET_STATE
Date: Fri, 22 Aug 2025 14:26:45 +0200
Message-ID: <20250822122655.1353197-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822122655.1353197-1-pbonzini@redhat.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a new attribute CHECK_TRACE_EVENT_GET_STATE to the backends.
When present and True, the code generated by the generate function
is wrapped in a conditional that checks whether the event is enabled;
this removes the need for repeating the same conditional in multiple
backends.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/tracetool/backend/__init__.py | 39 ++++++++++++++++++---------
 scripts/tracetool/format/h.py         | 11 +++++---
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index 7bfcc86cc53..273c8bbba3b 100644
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
index b42a8268a81..20cbacfe843 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -60,7 +60,6 @@ def generate(events, backend, group):
 
         out('    false)')
 
-        # tracer without checks
         out('',
             'static inline void %(api)s(%(args)s)',
             '{',
@@ -68,11 +67,17 @@ def generate(events, backend, group):
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
2.50.1


