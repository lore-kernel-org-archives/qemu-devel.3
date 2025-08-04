Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4AFC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 11:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uitG3-0003HJ-Nw; Mon, 04 Aug 2025 07:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uitFN-0002Fl-9L
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 07:20:54 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uitFL-00058G-DQ
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 07:20:52 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2401b855980so31287205ad.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754306449; x=1754911249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u6hpqzqw2R3IWoM3JpxAXcbvoBCfXv2FXspd/x3eVDg=;
 b=mPrI89L95X0fH4kUuC11/udntf+tL3M6QcHg+QXNpa4cyMd+ipx0jKJMbcjIq8Du/o
 d0XzAMtywcylu9aannXyoWLMnNg+EaQIIiMqyzFmo7Sk9yqrWfVjUu9lYwnib07LC6Rz
 qhhiAyilqH2SdlNCzCZ3fwy/qvjxvc7nTHWVKBBU8+fLY99jo1dFZ9X0DGbWd1P8Dh1+
 p7pOB2OziKU1+rpP6jrNECP3o+izZSD3AXb9sIme6SOKkDu/azJjwu4mY/grFoz0Wu4t
 41+2vgsVqiQZNHGgoKo4Kq8oEYn4nbAuPdUR6L6vToVmFixbxd6tzyGVCA8+Qcti7lgG
 5t+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754306449; x=1754911249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u6hpqzqw2R3IWoM3JpxAXcbvoBCfXv2FXspd/x3eVDg=;
 b=XfYD9VMHdz4tPFwwe+8DvuPR/tO2ZGyzQepm++q2u/1ghEZ9xFeqNBx6IDYPRQN+P/
 5KMotPJwWBtOQj/8rRuHCR0R2RYTaDO/4Z6NxYd5PAgN957MRQHq4ALrQWV5FwYNwpVu
 uAmyR2lIawUIzvAKAFK3MOKSqaCz5r2d6Sx5nOaeyICxLIUIGWg0JtgTlCwa9AZr1hBB
 YEsXlmCTnOAeRWmK0xeFbx3Tos1ZFxIZFFw5JrKaPXyLfxfAzj0bfISu1//ADSHg20bZ
 mNGtn1Gx2nlwDKMHz80yG5//nCg3KhhlkuFPnY7ORAL5x6HfzCdTblaAH5QnqhopRb5e
 kXnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmUU+ETvz/gCgTS17mOpdsJtk++WNvRtU3ySeio1s4kO9bgOpnRPj7I7qlEnMbV1vYJkSl/BGwPOc1@nongnu.org
X-Gm-Message-State: AOJu0YzkAa2npruFSVx/vmUth3OxLn3jzZftsADCPOiYdvSgnLobJ/+x
 mLu+U/AZ92yDklqnV+wPNGWo6/HXjcFYYpzh79Q+NzMQtIySqOcF2/rlsByq4zgzacw=
X-Gm-Gg: ASbGncu2A7j7VIelLVj1EoURv5b0V/yWdHtf/ZxnHaH+zRkxlcMsvjYIhFLHMS4gPjE
 W2iVK5ogKkjGJ0podEpCZtUbp8MZdgq9BcDhFuefumSFJNC9Ac88enyPQY9sdqEwC1Ts5+ZND2P
 g8MyFbgGP3bfJ/i4O1SRSQSJIHYCB79Q2dDR/k4O4ERy0XyTrb84bRqTzbbQbXQ8OGl8oiONLgY
 2RJpyDwGfR3a1zAnRZ8r1PaDCR4AELJfYWxFNtysYUh1Bisb7d77ALOvc3QkTOAC0dqev20+Qri
 DCzmx0icZsihJwkalG4Ge6jw05RcgZx6jMsdIbZuFYZoK6+BZYUCfI0sFJOV2aGMkf7FcWwU+an
 mfcTMnO86NOGv0xcT0SKAkHQJYDRm39t8MfXC3unfD0qrmr+aXQ7r
X-Google-Smtp-Source: AGHT+IFsJDVhhKz+l+fxdZDS4K+ZEwfhITxRdag0uHJMI2ZyiLG1ka/R69HNKHA3kuK65x8YXiBUag==
X-Received: by 2002:a17:902:c409:b0:234:cf24:3be8 with SMTP id
 d9443c01a7336-24247004a29mr121506175ad.28.1754306448766; 
 Mon, 04 Aug 2025 04:20:48 -0700 (PDT)
Received: from localhost.localdomain ([106.215.159.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e83esm106901675ad.49.2025.08.04.04.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 04:20:48 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: tanishdesai37@gmail.com,
	qemu-devel@nongnu.org,
	pbonzini@redhat.com
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 1/2] tracetool: add CHECK_TRACE_EVENT_GET_STATE
Date: Mon,  4 Aug 2025 11:20:38 +0000
Message-Id: <20250804112039.16377-2-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804112039.16377-1-tanishdesai37@gmail.com>
References: <20250804112039.16377-1-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 7bfcc86cc5..3c900f01e9 100644
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
+    def generate(self, event, group, check_trace_event_get_state=False):
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


