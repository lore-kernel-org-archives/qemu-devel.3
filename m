Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68A0C87FDA
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 15:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujg6O-0001ml-NC; Wed, 06 Aug 2025 11:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1ujfiH-0005M6-IF
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:06:01 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1ujfiD-0005RN-F1
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:05:56 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-23fd3fe0d81so64164105ad.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 08:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754492749; x=1755097549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6NIs1jMaPBhEaSqifkwMh7U+LYw/bwdl3yqQB207oeQ=;
 b=PpJD98st4qzrWWunbL1Gbi0k9Krsrnumxdq5IeqnG8aBkqdcSCRGkWZHlpT2X/Sk5p
 olCxcNya1WR2qT5ifjCMLNfmtlClMWI+pRlU499B+Zebjy3Lez7AFddHK9ktJrgOTecv
 I9Iw9kk1LTEiwV3bb5YZdWrSDXx8af41pTPRqqJC4SuXaUOMNZleqcQE9+nR2rF+fV8d
 YmcAsANE5vPha+MUW4BYQH4WDhy2GCoJ6qAIO79cxHJxCDQjZpRLeal6KEx242VLZY0s
 pkAb6+rvnU2huUZYnGbcxRAyLGF9k/MqoCHBBeoAt5vlGrBrA36dUGoH4uhKPYBeBBfd
 6vqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754492749; x=1755097549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6NIs1jMaPBhEaSqifkwMh7U+LYw/bwdl3yqQB207oeQ=;
 b=v7FkpzjOyjgtdy0luAzrcswm8nc+lEMe9tutRpyLnVFQPHNLOrLyq4rrLkTw+KE+Dj
 4o9ocCFY28/+QEUI6zREZFXDaHGU3xkeYIhJX1WdpAXqe3vFSsiunt0PyXbnHoQ5Y8V+
 0/igtOx85D6Ifrmx2AkcqNOqgx8yhBEtoUSnpSbAZtIxJ7ekZbANMu10mEDBWdJxUtCN
 5+WbPFyJrga4VMOMu/PHXcGm9JZQ4nBzosc6ehBkHUowKBkBs7k0nvBVhwFAdYAbhY5U
 MJR7Ki3+1y3VZkEFrXxMx8NzBtsJpchs+WRk/XYorOyf4WHoqCnM0PAfCbzPaReF8n/q
 0KDA==
X-Gm-Message-State: AOJu0YwHU+3VluZebV122nlWFV6Ep12aAxm6IX3Rm/dzX7VuQHaBH8Zj
 xLfufbBSGdJmtqENs61bLqdxB+hjfpaMZ/G9hegBffLhmdV4mUiEvkGGYa+lK7v+n64=
X-Gm-Gg: ASbGncs9MbhN5hlqtPViQWeSnVxjx3Eks4sJDhbTupbLvX7VHUA1r84OnjwuqySaOP3
 1vTa9aM7+CDwdxetI+ilaeY7TEw1E1hOIr7msjwCRrtXTXHy9lk977zhG4NTtg0d3wSSFXife1m
 eL7VgFcAaj0KJah8R6vZs89IqaTganoAibhZ4vTpI54lzYVqtpL1Gu6eWLyV5KzWkYOB0MY6igk
 eHV4JkWigkdMFqqeT9t9guEr0fKiKoeLdfcXpq5VXTz34UY7BOE0NZhIbM+ySVnK/t9qvTW7nv1
 pT7sLs9rjvcawMYV5IRln3RzQi+B5Qflx9ubvPuv362Kww4/38gO40IvFSuX7WWFtIy2JkX31I9
 EC/xQ7RZEL3Q08d1luZUwfx/Y
X-Google-Smtp-Source: AGHT+IGfxJqzUAs/DDK862zoTh9mKFqhJksg7V1cDihFmLbwMKtj80T3KKlzEa2fueSlF185bVNv7Q==
X-Received: by 2002:a17:903:ac6:b0:240:7f7d:2b57 with SMTP id
 d9443c01a7336-2429f4ae04fmr32362415ad.28.1754492748770; 
 Wed, 06 Aug 2025 08:05:48 -0700 (PDT)
Received: from ubuntu.. ([106.215.156.228]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d21dsm160107365ad.139.2025.08.06.08.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 08:05:48 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org,
	pbonzini@redhat.com,
	tanishdesai37@gmail.com
Cc: Mads Ynddal <mads@ynddal.dk>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 1/2] tracetool: add CHECK_TRACE_EVENT_GET_STATE
Date: Wed,  6 Aug 2025 15:05:38 +0000
Message-Id: <20250806150539.2871-2-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806150539.2871-1-tanishdesai37@gmail.com>
References: <20250806150539.2871-1-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

New attributed added in backends
CHECK_TRACE_EVENT_GET_STATE which when
present and is True wraps the code generated
by generate function in check_trace_event_get_state
check else it is outside the conditional block.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
---
 scripts/tracetool/__init__.py         |  1 -
 scripts/tracetool/backend/__init__.py | 26 ++++++++++++++++-------
 scripts/tracetool/format/h.py         | 30 ++++++++++-----------------
 3 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 2ae2e562d6..d0a02c45d7 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -332,7 +332,6 @@ def formats(self):
         return self._FMT.findall(self.fmt)
 
     QEMU_TRACE               = "trace_%(name)s"
-    QEMU_TRACE_NOCHECK       = "_nocheck__" + QEMU_TRACE
     QEMU_TRACE_TCG           = QEMU_TRACE + "_tcg"
     QEMU_DSTATE              = "_TRACE_%(NAME)s_DSTATE"
     QEMU_BACKEND_DSTATE      = "TRACE_%(NAME)s_BACKEND_DSTATE"
diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index 7bfcc86cc5..4194719e52 100644
--- a/scripts/tracetool/backend/__init__.py
+++ b/scripts/tracetool/backend/__init__.py
@@ -23,6 +23,8 @@
 Attribute Description
 ========= ====================================================================
 PUBLIC    If exists and is set to 'True', the backend is considered "public".
+CHECK_TRACE_EVENT_GET_STATE    If exists and is set to 'True', generate function
+emits code inside check_trace_event_get_state check.
 ========= ====================================================================
 
 
@@ -101,22 +103,32 @@ class Wrapper:
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
+            func = getattr(backend,name%self._format,None)
+            if func is not None and (check_trace_event_get_state is None or
+                    check_trace_event_get_state == getattr(backend, 'CHECK_TRACE_EVENT_GET_STATE', False)):
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
index ea126b07ea..0ceb49eef5 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -59,33 +59,25 @@ def generate(events, backend, group):
 
         out('    false)')
 
-        # tracer without checks
         out('',
             'static inline void %(api)s(%(args)s)',
             '{',
-            api=e.api(e.QEMU_TRACE_NOCHECK),
+            api=e.api(),
             args=e.args)
 
         if "disable" not in e.properties:
-            backend.generate(e, group)
-
+            backend.generate(e, group, check_trace_event_get_state=False)
+
+        if backend.check_trace_event_get_state:
+            if "disable" not in e.properties:
+                event_id = 'TRACE_' + e.name.upper()
+                cond = "trace_event_get_state(%s)" % event_id
+                out('    if (%(cond)s) {',
+                        cond=cond)
+                backend.generate(e, group, check_trace_event_get_state=True)
+                out('    }')
         out('}')
 
-        cond = "true"
-
-        out('',
-            'static inline void %(api)s(%(args)s)',
-            '{',
-            '    if (%(cond)s) {',
-            '        %(api_nocheck)s(%(names)s);',
-            '    }',
-            '}',
-            api=e.api(),
-            api_nocheck=e.api(e.QEMU_TRACE_NOCHECK),
-            args=e.args,
-            names=", ".join(e.args.names()),
-            cond=cond)
-
     backend.generate_end(events, group)
 
     out('#endif /* TRACE_%s_GENERATED_TRACERS_H */' % group.upper())
-- 
2.34.1


