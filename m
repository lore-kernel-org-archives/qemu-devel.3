Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF4AC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 21:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMZ88-00018H-88; Tue, 03 Jun 2025 17:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uMZ86-000183-80
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:25:06 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uMZ83-0003Uk-Og
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:25:05 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so27344035e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 14:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748985902; x=1749590702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RtJpKoIeUHfChWh5OeQlc67ki9Ve3IMlbZERDwbULI0=;
 b=UvMb0PI+T7ea2LoKRJm2HusY9xLJSZKNYfi31ByvZN/qErfXDEUCRaGTlhf3VgUgnl
 vJaRAwZGf1zzBklKy7oOrpemdDovBuuhPUTcysgK7qi4Mg8H/QNINN2Fk8ttFKtabWZq
 Lyc4eJRJArRm/dJ2vsBotxGZMwlxgxlkalwHY3iRpKi7o9e0+9IxACvpqfVCigg+GsKI
 nU8Y50gbBsSI82doyZUun2gXKgh+/izKRyzRZ92T1C4UaHkontq/6NkpkMfwLhYUg8mO
 7OSFDPT7HDMh6sMO+xJLqAQVQJmefvsVQ8VB7gsq+XAl4fsA1/OxS2Efu9A8abmy5v4y
 HsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748985902; x=1749590702;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RtJpKoIeUHfChWh5OeQlc67ki9Ve3IMlbZERDwbULI0=;
 b=UNGGU+2TU6rBQsRiocTTR4HRmISfv4Ekw7DqKgwQ1yNzQpWze5mRYf8FuSkUVCUmEd
 xD1cnUttzwWoFiqCPYG/ANEzJmoLeDQtZom9/m8yfFxssH7BuM3PK5LxsYe7UGfkjJuV
 +vjgFUHeY4bCV2za/NhjWjbqCQAly0/L0bk8hHFekfsEBaUTcE+iRonBNvg9r8enLt/v
 Os1r9dMgKDM4gQ3xAquUt7b7fQM/ZRalUZL3GvQK7Izvr2nP8oBW13wFn/rrzYTiylCd
 1Jg/8YIDAuWqPVibtG908qKRXRmUIVqEkikRfj9+rwVMqcZM7CC5Ez1ZWN/wi93bwfcK
 BNyA==
X-Gm-Message-State: AOJu0YzDAjNiX1h9sa/8j2f7ozbv83h40afPyoOHMZYdaCF7fryzOY2/
 +5Po79O29tZiyce3LDdZ5xEFaTiAwTpWsI4RWrMGtRjPnurga8d7jbZl7qBEqQ==
X-Gm-Gg: ASbGncuY2W+mCQWyKQ9mL4hbSM8Y++XlsDiWrODF5P58UEo+YWlLI/KynDM87+8nTpu
 oo0xSiEijbQEaUY+7t4/el+OzrU3DEyGZ8vGCLH+dlZWWMiX/7IpcSQlrrKEuoAQxh0JBaEjYlf
 e5XPg2mDC1rjyrua2/nQ8vTdRgshk8wKNNg/XLnkt4AnmaswmOxOdvNrknNaDnb6dG5lHhtj6Km
 mIAKcpkwTY+2SoUYP3BvDHP3NAppj90shsuPcKes/YRfbyngr+WVAJm3L7g3FkGcT+Qg9dSYwcj
 ZvC5T+ik/E7Eh4jplOenIKgDi15J6vFWO77DF/tJVzuw3eCvsupmvZaMQAWHx/GRBDPQy7Iu4sx
 9xFIMC2yhYNZDCRLC2m9PN4CxvXqgM8SpT1PMPmvRxMoTYC2592+ixUCNZyCaNmT1
X-Google-Smtp-Source: AGHT+IFTwEdsfLN8LEU55wJQpa2f/vPiRZZJ7AaeWkZuKUjFMswrCYs5/C8qJaMyQRbUpnJV/qQ8UA==
X-Received: by 2002:a05:600c:3b10:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-451f0f50824mr1523045e9.16.1748985901428; 
 Tue, 03 Jun 2025 14:25:01 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ed8f334200a97623113a5c04f9.dip0.t-ipconnect.de.
 [2003:ed:8f33:4200:a976:2311:3a5c:4f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c8f5sm19062705f8f.27.2025.06.03.14.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 14:25:01 -0700 (PDT)
From: oltolm <oleg.tolmatcev@gmail.com>
To: qemu-devel@nongnu.org
Cc: oltolm <oleg.tolmatcev@gmail.com>
Subject: [PATCH v3] meson: fix Windows build
Date: Tue,  3 Jun 2025 23:24:20 +0200
Message-ID: <20250603212419.1911-2-oleg.tolmatcev@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=oleg.tolmatcev@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The build failed when run on Windows. I replaced calls to Unix programs
like ´cat´, ´sed´ and ´true´ with calls to ´python´. I wrapped calls to
´os.path.relpath´ in try-except because it can fail when the two paths
are on different drives. I made sure to convert the Windows paths to
Unix paths to prevent warnings in generated files.

Signed-off-by: oltolm <oleg.tolmatcev@gmail.com>
---
 contrib/plugins/meson.build         |  2 +-
 plugins/meson.build                 |  2 +-
 scripts/tracetool/__init__.py       | 15 ++++++++++++---
 scripts/tracetool/backend/ftrace.py |  4 +---
 scripts/tracetool/backend/log.py    |  4 +---
 scripts/tracetool/backend/syslog.py |  4 +---
 tests/functional/meson.build        |  4 +---
 tests/include/meson.build           |  2 +-
 tests/tcg/plugins/meson.build       |  2 +-
 trace/meson.build                   |  5 +++--
 10 files changed, 23 insertions(+), 21 deletions(-)

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
diff --git a/plugins/meson.build b/plugins/meson.build
index 5383c7b88..cb7472df8 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -33,7 +33,7 @@ if host_os == 'windows'
     input: qemu_plugin_symbols,
     output: 'qemu_plugin_api.def',
     capture: true,
-    command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
+    command: [python, '-c', 'import fileinput, re; print("EXPORTS", end=""); [print(re.sub(r"[{};]", "", line), end="") for line in fileinput.input()]', '@INPUT@'])
 
   # then use dlltool to assemble a delaylib.
   # The delaylib will have an "imaginary" name (qemu.exe), that is used by the
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index bc03238c0..6dfcbf71e 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -12,12 +12,14 @@
 __email__      = "stefanha@redhat.com"
 
 
+import os
 import re
 import sys
 import weakref
+from pathlib import PurePath
 
-import tracetool.format
 import tracetool.backend
+import tracetool.format
 
 
 def error_write(*lines):
@@ -36,7 +38,7 @@ def error(*lines):
 
 def out_open(filename):
     global out_filename, out_fobj
-    out_filename = filename
+    out_filename = posix_relpath(filename)
     out_fobj = open(filename, 'wt')
 
 def out(*lines, **kwargs):
@@ -308,7 +310,7 @@ def build(line_str, lineno, filename):
             fmt = [fmt_trans, fmt]
         args = Arguments.build(groups["args"])
 
-        return Event(name, props, fmt, args, lineno, filename)
+        return Event(name, props, fmt, args, lineno, posix_relpath(filename))
 
     def __repr__(self):
         """Evaluable string representation for this object."""
@@ -447,3 +449,10 @@ def generate(events, group, format, backends,
     tracetool.backend.dtrace.PROBEPREFIX = probe_prefix
 
     tracetool.format.generate(events, format, backend, group)
+
+def posix_relpath(path, start=None):
+    try:
+        path = os.path.relpath(path, start)
+    except ValueError:
+        pass
+    return PurePath(path).as_posix()
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index baed2ae61..5fa30ccc0 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -12,8 +12,6 @@
 __email__      = "stefanha@redhat.com"
 
 
-import os.path
-
 from tracetool import out
 
 
@@ -47,7 +45,7 @@ def generate_h(event, group):
         args=event.args,
         event_id="TRACE_" + event.name.upper(),
         event_lineno=event.lineno,
-        event_filename=os.path.relpath(event.filename),
+        event_filename=event.filename,
         fmt=event.fmt.rstrip("\n"),
         argnames=argnames)
 
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index de27b7e62..17ba1cd90 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -12,8 +12,6 @@
 __email__      = "stefanha@redhat.com"
 
 
-import os.path
-
 from tracetool import out
 
 
@@ -55,7 +53,7 @@ def generate_h(event, group):
         '    }',
         cond=cond,
         event_lineno=event.lineno,
-        event_filename=os.path.relpath(event.filename),
+        event_filename=event.filename,
         name=event.name,
         fmt=event.fmt.rstrip("\n"),
         argnames=argnames)
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 012970f6c..5a3a00fe3 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -12,8 +12,6 @@
 __email__      = "stefanha@redhat.com"
 
 
-import os.path
-
 from tracetool import out
 
 
@@ -43,7 +41,7 @@ def generate_h(event, group):
         '    }',
         cond=cond,
         event_lineno=event.lineno,
-        event_filename=os.path.relpath(event.filename),
+        event_filename=event.filename,
         name=event.name,
         fmt=event.fmt.rstrip("\n"),
         argnames=argnames)
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 52b4706cf..ee222888f 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -411,6 +411,4 @@ foreach speed : ['quick', 'thorough']
   endforeach
 endforeach
 
-run_target('precache-functional',
-           depends: precache_all,
-           command: ['true'])
+alias_target('precache-functional', precache_all)
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
index 3df454935..9c42a57a0 100644
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
@@ -57,10 +57,11 @@ foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
   endif
 endforeach
 
+cat = [ python, '-c', 'import fileinput; [print(line, end="") for line in fileinput.input()]', '@INPUT@' ]
 trace_events_all = custom_target('trace-events-all',
                                  output: 'trace-events-all',
                                  input: trace_events_files,
-                                 command: [ 'cat', '@INPUT@' ],
+                                 command: cat,
                                  capture: true,
                                  install: get_option('trace_backends') != [ 'nop' ],
                                  install_dir: qemu_datadir)
-- 
2.49.0.windows.1


