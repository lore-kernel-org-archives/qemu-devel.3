Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D73C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 22:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPqDU-0006xZ-71; Thu, 12 Jun 2025 18:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uPqDT-0006xC-5b
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 18:16:11 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uPqDP-0003eQ-Vm
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 18:16:10 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a4fea34e07so922427f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 15:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749766565; x=1750371365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gVUqMWdXGopLtTJgsDYEUFW5shw7i3ZthEogkgqiY0Y=;
 b=JsviI3sYNUbD8viKJlrhZ/Wb+hQvItK9NfYaoevqLvPSZUtGxfai1FD4QLoHvr0IFe
 M+E0BM30WT3GaRsnklkf1sR7ANpiNa0IuYI5hd/XLaTgLQ58EhhpHmGdxZKY0VnmDhBj
 v2DI0lxIdKrCcZYPDwqbFabuaxgWXcvMmljQ25PWZt2fQMSXYadw1hS/7vsE4mIEkNCd
 P8+NrEs/k8j+6OUiZ5oZYXtf6mTHVkOd3PSryX/71K3W7nDYG4j7JApAv7Jr/dwzCn1m
 K/PE0y6KyGkwDnjDiCa4diLDmvXdshOPJ461mHHiVFgzSSe9fXGdg1k7lX3xbskAkMPs
 Xnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749766565; x=1750371365;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gVUqMWdXGopLtTJgsDYEUFW5shw7i3ZthEogkgqiY0Y=;
 b=V6bGbYsD5aTjlQ/xjXNjif69dZS+LQ3hfpCq8OoBXHj9DobLv7jQd6r4k3YyJSsth2
 ZTWmCpsHsLYpr63qaI8tz/OA4c6bTcAYpN1814lfZ/a9vDiYtNffV1kPV22UenAyKFEF
 bzgHnYLQRGTyhcRw+dwGCY9orNBJvAcFN85qtX4eIJKXUfCXj5EIzWdc0/Lek6ML92Cw
 Nu2Z89WX7nvVeLiZ2xJEssTgzeo2V+TTO51p6cAyGa/wmoZ2wxVhlpnD2xemh9uzkmQT
 ge28CQBtKSlSXuxkm/fcTDGQD9+BSjIxZL0ecn9jf8m06sks+qe/yp0GLBm9fz0gz2hs
 2uXQ==
X-Gm-Message-State: AOJu0Yxh9gIyOkB7CXtUPGKzkuTR8dnt2g8+ORqt2Cvl+/ZjB6UDVuBu
 SrQ7bg4RHxWI8belfUQwEh5N4UVx8lCLXuyH/YU7oPUXpeeuRWh0Ls47kBCC1iZC
X-Gm-Gg: ASbGncuF8Twm5EzW1BE5RJ6ZRH25GiNH6F4XUYtG32uWZb925jerTP75eEaFu2U3f+Y
 KlzlWXPYjYk7gSCnuGaYOJmbiLegcS9V4b4IcI7lYAlVR3tKozVeNO6HjJMz6g41MAYNIRtG/IW
 dEnBvfRnAsFeqTxwCgUwqrYSVHfQ974qrcUnpFdEmZYAhETUVSnU118l5gCHlyR52FrOb1Gm/bj
 ds1+UH19l5LXW5LWPR/Ta9lRTWxusKCq9m4a2/YDN8KFDkdSIZERf16YZ4JsikWOju7THOOmjFy
 QWSkjQPsqW3r+pu5rFZfIud/BOq/e3huyCZmrQuummRoJG2fEGWCutAF5AKlfmY6TuGwn3hirUy
 ZnFnZYnb/7O7iwEvWpbEfl8Ihe8rL1zQOnuY+IQwAiGUoRSkXLe53Akx/1Q3cV8umT1WcLSuRkQ
 U=
X-Google-Smtp-Source: AGHT+IFfjf8ujDBh7TpBi5CJp/avGNGsVgMElhEdrClDGLQFOLDrd4bcqI2otdH5IkSwSV86EvAuxQ==
X-Received: by 2002:a5d:5f44:0:b0:3a5:26fd:d46f with SMTP id
 ffacd0b85a97d-3a5687571b2mr524602f8f.32.1749766564821; 
 Thu, 12 Jun 2025 15:16:04 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ed8f252b003d090f81614e5ac5.dip0.t-ipconnect.de.
 [2003:ed:8f25:2b00:3d09:f81:614e:5ac5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b08c7csm510431f8f.50.2025.06.12.15.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 15:16:04 -0700 (PDT)
From: oltolm <oleg.tolmatcev@gmail.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 oltolm <oleg.tolmatcev@gmail.com>
Subject: [PATCH v4] meson: fix Windows build
Date: Fri, 13 Jun 2025 00:15:22 +0200
Message-ID: <20250612221521.1109-2-oleg.tolmatcev@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=oleg.tolmatcev@gmail.com; helo=mail-wr1-x434.google.com
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

The build fails on Windows. Replace calls to Unix programs like ´cat´,
´sed´ and ´true´ with calls to ´python´ and wrap calls to
´os.path.relpath´ in try-except because it can fail when the two paths
are on different drives. Make sure to convert the Windows paths to Unix
paths to prevent warnings in generated files.

Signed-off-by: oltolm <oleg.tolmatcev@gmail.com>
---
 contrib/plugins/meson.build         |  2 +-
 plugins/meson.build                 |  2 +-
 scripts/tracetool/__init__.py       | 15 ++++++++++++---
 scripts/tracetool/backend/ftrace.py |  4 +---
 scripts/tracetool/backend/log.py    |  4 +---
 scripts/tracetool/backend/syslog.py |  4 +---
 tests/functional/meson.build        |  2 +-
 tests/include/meson.build           |  2 +-
 tests/tcg/plugins/meson.build       |  2 +-
 trace/meson.build                   |  5 +++--
 10 files changed, 23 insertions(+), 19 deletions(-)

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
index b20edfbab..62c991d87 100644
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
index 557d59ddf..de03a41de 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -414,4 +414,4 @@ endforeach
 
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


