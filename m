Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF82C54ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 21:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIZld-00039R-So; Fri, 23 May 2025 17:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uIYX6-0000Rq-S6
 for qemu-devel@nongnu.org; Fri, 23 May 2025 15:58:20 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uIYX4-0004dH-SW
 for qemu-devel@nongnu.org; Fri, 23 May 2025 15:58:20 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so1155905e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748030296; x=1748635096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ia2WHDop01rK2x1nkhViQl1qCX14HvxZCYr3J4AU4Rg=;
 b=hriBhFHE4HcCyyrjB3LIgcJ7GQyEflA5h8ZP0pJfyHBW4IR5kPPwpes3k/qNsxL0Bl
 D6EkMLhRvznRaYIw/dZV4QmgpWLT3toyaM9PRVHrQYvq3jAl6qT2Gg7xguMcfqmW+rHN
 ywfl61soCFJJPAO0TE3sS5N7ewojRRJ30VqpryWTLwhWSVqdhPjt6aNLrtGCpRpiSmcp
 2LTot1Z4ga2tG3ATC2dGJuojMu6V08OwOtnvL7YKOjm3i9sF5LmVSnkh8g697w8MJQXc
 JkldZIM0jt96J1BnoeTQuuWC/kifyNQZLjFmA2p8QFjOaDdKMxe9KQNM6xDDE5IfEM1E
 z52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748030296; x=1748635096;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ia2WHDop01rK2x1nkhViQl1qCX14HvxZCYr3J4AU4Rg=;
 b=egUopb8RHvm4Ae7UV5UiivsQlDSi0LV3Am/zqOYoGPKGWVHdgnJp995RxnXRE8/I99
 N2Ojbfpd6CHHL3U3MSnVaQelilCFHa70wl1cRmCGGlWxrB+pZdo/av/PQaD85t5gzKhm
 A1SRNakLpi80ZbTVZSWjdBB5avsPfesFXqnV3HOnfmEOmlpMZBjbINkVJ6xm8WMgMkm5
 BBi8N6aNkKXD/yNeMmmRGdv82r/VPkKej/LMD81LLFh9kbcvsl0YHze1B7Aavz3ZdPp+
 6GIxUc4AJidlZwLhygVdJTc/LBGARAd56NwFsbv9N3y42KvUMC05Yv9xN/J94R+XzHR2
 5zeA==
X-Gm-Message-State: AOJu0YyHH394M/rvfrsHOtFMuYZ0fQQBDEirus6DC+JD1P+++SbpMrbH
 oAm/exkDM16xq1xVfR1ZGqVjWvzxL4r8ZkLq4pgJKAZeM18I0QQWgI4EINkXsg==
X-Gm-Gg: ASbGnctZb4WhY4Czzp5PBYCs6JRYFJPByRuNTyZy95v+Zi+vYJDfThQFwfQ4tvgyf6E
 vWp88FqdOGCZwX1xSdxI/qqjKHkbr+icj9BIQAMDkFS+gNKCh69CpoLbT1Gj6VzLfUEgCcLuSLf
 JRQx00hFfLm0NIE+iioiFfqWrVHDqy6/yJYX8zbG5Tv66zoKKurTYR5KpHZMHbTNHs/gNtla1dY
 LsNV5cQPZfgnVXZlq4m62n7q3TaX6f0MS/2UjOX90FP/Hz1ITsGZR6XzS7LtKqdTmD0qSzMaDnN
 TUUFNiK1+VEi493Z4szy+acSMDisL8vaSuKbh63TFXXZEIGhYkdonnCASkpm6BEkwjfMzd58Eu5
 SgkRZmH2Rt6GjprBjRUsVliEMZi6JBCzIrXzNsdYK9kbGq0L2u5NMpyIDmvjCrplfZA==
X-Google-Smtp-Source: AGHT+IH4UTbTtWW3oVJhHioUKkktTMYQyX1X4gO+UUFxHXZaitvLhPzRFZvnRQ6R6FhW5OP5weLCtQ==
X-Received: by 2002:a05:600c:1e25:b0:442:e03b:58a9 with SMTP id
 5b1f17b1804b1-44c92a54a9cmr3028855e9.25.1748030296216; 
 Fri, 23 May 2025 12:58:16 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ed8f20950034b27836af94765a.dip0.t-ipconnect.de.
 [2003:ed:8f20:9500:34b2:7836:af94:765a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f7bae847sm147949145e9.36.2025.05.23.12.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 12:58:15 -0700 (PDT)
From: oltolm <oleg.tolmatcev@gmail.com>
To: qemu-devel@nongnu.org
Cc: oltolm <oleg.tolmatcev@gmail.com>
Subject: [PATCH] meson: fix Windows build
Date: Fri, 23 May 2025 21:57:04 +0200
Message-ID: <20250523195703.168-2-oleg.tolmatcev@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=oleg.tolmatcev@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 23 May 2025 17:17:24 -0400
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

The build failed when run on Windows. I replaced calls to Unix programs
like `cat` and `true` with calls to `python`. I wrapped calls to
`os.path.relpath` in try-except because it can fail when the two paths
are on different drives. I made sure to convert the Windows paths to
Unix paths to prevent warnings in generated files.

Signed-off-by: oltolm <oleg.tolmatcev@gmail.com>
---
 contrib/plugins/meson.build         | 2 +-
 scripts/tracetool/backend/ftrace.py | 9 ++++++++-
 scripts/tracetool/backend/log.py    | 9 ++++++++-
 scripts/tracetool/backend/syslog.py | 9 ++++++++-
 tests/functional/meson.build        | 2 +-
 tests/include/meson.build           | 2 +-
 tests/tcg/plugins/meson.build       | 2 +-
 trace/meson.build                   | 4 ++--
 8 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index fa8a426c8..1876bc784 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -24,7 +24,7 @@ endif
 if t.length() > 0
   alias_target('contrib-plugins', t)
 else
-  run_target('contrib-plugins', command: find_program('true'))
+  run_target('contrib-plugins', command: [python, '-c', ''])
 endif
 
 plugin_modules += t
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index baed2ae61..81a5f93b3 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -13,6 +13,7 @@
 
 
 import os.path
+from pathlib import PurePath
 
 from tracetool import out
 
@@ -30,6 +31,12 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
+    try:
+        event_filename = os.path.relpath(event.filename)
+    except ValueError:
+        event_filename = event.filename
+    event_filename = PurePath(event_filename).as_posix()
+
     out('    {',
         '        char ftrace_buf[MAX_TRACE_STRLEN];',
         '        int unused __attribute__ ((unused));',
@@ -47,7 +54,7 @@ def generate_h(event, group):
         args=event.args,
         event_id="TRACE_" + event.name.upper(),
         event_lineno=event.lineno,
-        event_filename=os.path.relpath(event.filename),
+        event_filename=event_filename,
         fmt=event.fmt.rstrip("\n"),
         argnames=argnames)
 
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index de27b7e62..241fbbbd0 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -13,6 +13,7 @@
 
 
 import os.path
+from pathlib import PurePath
 
 from tracetool import out
 
@@ -37,6 +38,12 @@ def generate_h(event, group):
     else:
         cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
 
+    try:
+        event_filename = os.path.relpath(event.filename)
+    except ValueError:
+        event_filename = event.filename
+    event_filename = PurePath(event_filename).as_posix()
+
     out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
         '        if (message_with_timestamp) {',
         '            struct timeval _now;',
@@ -55,7 +62,7 @@ def generate_h(event, group):
         '    }',
         cond=cond,
         event_lineno=event.lineno,
-        event_filename=os.path.relpath(event.filename),
+        event_filename=event_filename,
         name=event.name,
         fmt=event.fmt.rstrip("\n"),
         argnames=argnames)
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 012970f6c..2e010e7c9 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -13,6 +13,7 @@
 
 
 import os.path
+from pathlib import PurePath
 
 from tracetool import out
 
@@ -36,6 +37,12 @@ def generate_h(event, group):
     else:
         cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
 
+    try:
+        event_filename = os.path.relpath(event.filename)
+    except ValueError:
+        event_filename = event.filename
+    event_filename = PurePath(event_filename).as_posix()
+
     out('    if (%(cond)s) {',
         '#line %(event_lineno)d "%(event_filename)s"',
         '        syslog(LOG_INFO, "%(name)s " %(fmt)s %(argnames)s);',
@@ -43,7 +50,7 @@ def generate_h(event, group):
         '    }',
         cond=cond,
         event_lineno=event.lineno,
-        event_filename=os.path.relpath(event.filename),
+        event_filename=event_filename,
         name=event.name,
         fmt=event.fmt.rstrip("\n"),
         argnames=argnames)
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 52b4706cf..2e3bd4057 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -413,4 +413,4 @@ endforeach
 
 run_target('precache-functional',
            depends: precache_all,
-           command: ['true'])
+           command: [python, '-c', ''])
diff --git a/tests/include/meson.build b/tests/include/meson.build
index 9abba308f..8e8d1ec4e 100644
--- a/tests/include/meson.build
+++ b/tests/include/meson.build
@@ -13,4 +13,4 @@ test_qapi_outputs_extra = [
 test_qapi_files_extra = custom_target('QAPI test (include)',
                                       output: test_qapi_outputs_extra,
                                       input: test_qapi_files,
-                                      command: 'true')
+                                      command: [python, '-c', ''])
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index 41f02f2c7..029342282 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -17,7 +17,7 @@ endif
 if t.length() > 0
   alias_target('test-plugins', t)
 else
-  run_target('test-plugins', command: find_program('true'))
+  run_target('test-plugins', command: [python, '-c', ''])
 endif
 
 plugin_modules += t
diff --git a/trace/meson.build b/trace/meson.build
index 3df454935..3a318713c 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -4,7 +4,7 @@ trace_events_files = []
 foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
   if item in qapi_trace_events
     trace_events_file = item
-    group_name = item.full_path().split('/')[-1].underscorify()
+    group_name = fs.name(item).underscorify()
   else
     trace_events_file = meson.project_source_root() / item / 'trace-events'
     group_name = item == '.' ? 'root' : item.underscorify()
@@ -60,7 +60,7 @@ endforeach
 trace_events_all = custom_target('trace-events-all',
                                  output: 'trace-events-all',
                                  input: trace_events_files,
-                                 command: [ 'cat', '@INPUT@' ],
+                                 command: [ python, '-c', 'import fileinput;[print(line) for line in fileinput.input()]', '@INPUT@' ],
                                  capture: true,
                                  install: get_option('trace_backends') != [ 'nop' ],
                                  install_dir: qemu_datadir)
-- 
2.49.0.windows.1


