Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C868C61DB8
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 09:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNq8S-0007d2-G3; Sat, 07 Jun 2025 05:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uNq8Q-0007cr-SI
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 05:46:42 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uNq8O-0003aZ-SR
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 05:46:42 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a503d9ef59so2276689f8f.3
 for <qemu-devel@nongnu.org>; Sat, 07 Jun 2025 02:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749289599; x=1749894399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LUnXx/ajmTJtQkrVFW5sqKdVezzY+m64/jJds2NIGQI=;
 b=aD2LCJrZSctqIUWn5tusH1SzQyNc3pIFS0qEep0K1BayCxrgW5sHhXX9dLnJp5rmwT
 4OLL7BPzAIMDlzJKA+xhLg7Zy3Gs6K+iL3X8FKgS+NV4eAN+VOZJUco1OKeYGksufrNS
 vYPngHYnUcTBdJ4S4aKY+6guR6UwnSmrjJFFWST3TVh1aqvBegjF+93Slk0fn0G2qqJ9
 s9VcPGCu48+N2QuWbkPBDZfoXT7pYWziVye9fSytB6dLGc9HJUidOS1NPEg+w/N8DeZJ
 xwKyrYgmHC/Uwp1woD4q2INIcpM3vO+4s3DrvSpsJJoGK3AEeEvckG3yKwCR7LMQCldv
 fn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749289599; x=1749894399;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LUnXx/ajmTJtQkrVFW5sqKdVezzY+m64/jJds2NIGQI=;
 b=orW+0zwWZ5cnPRwBfyaFbEAH2GUVynVG8G+2kUzi9PfOKXT6hSDHKCnHWo5KoobV1r
 Oj2N0n+FHNEokbkVBhOOA2PcfW5Vk0OodhBFKcpWoHXvg0Dok39qUJPxqcBRhwaVtAyk
 7g2bbU5uOWMIsmYBleaxx4Sf5ESZY33I/8U6sNBiCe97wzHLUIXCnsJ6a8yXVpiJAb4T
 sCaXC+aDcRxttrPzHWkiThG8PhRf/hRNxDW4xePjP6qlluiCzplJe1X60e2ABAGEMpg7
 LLCG0TfLoDhVFJqF/55yuLfroODLckuXlqTlA62qbHXvsEz6vArLc/fWfAdv0ww3AjHW
 chuQ==
X-Gm-Message-State: AOJu0YxcTFFrp/FWLu1Xc5DEPRS8v4LWIfx+kKOV5ecPoVrU+oeOwyBx
 xNKfesp/7AWgKXrOthDgC4IjImw+a1FWhB6WVHFsm5OM7kCy3It0R1UFy2NwlaBb
X-Gm-Gg: ASbGncsL9gsBG6hj3YBR+Jli9zCn6csgLyWzdSsMri++NFtIOZdmpeJkESXs/gAMHf6
 pHQ7csQyA/QSEnClNCl26ZAb4wbM6FoaBiAqfH2lRsIBL14nDm2LaouyX2D5ey3DsurQh5vy3gB
 N9jp7h8pRR4s/RA7pjP2/WXlVmPID/8zmxi3oRHQoorr83jueMdhOQtzMjNi6jNs+ZYTjnjDZjO
 D2KNTa85l3MZeCHqX/srmjP4iLyNpaif9oxPQqgpYKCe6RXpsCtrjwRaUyqKc7JloOlkxh8aHB3
 un6mgrHrQVYFKeNQeJzA72LOtdbZuB5x431Dm3Jk0jcjj5BfMgzsSmGJxOZV5toJEDntCILortL
 RAVrYeZflPkPQckfsMPDyb/hKvqKquDMwUtLxWeA9UEQ5HSRHBiqtf3a9koJXUwgtyQ==
X-Google-Smtp-Source: AGHT+IEXvMjVsVdEZA5lr96Dqre+VWk2tg22vksOtuz9osRa4ONSCgsOb2P8Zm4uMeM38b1YSiJQ2A==
X-Received: by 2002:a05:6000:430a:b0:3a4:fcc3:4a14 with SMTP id
 ffacd0b85a97d-3a531cb0becmr5392930f8f.34.1749289598652; 
 Sat, 07 Jun 2025 02:46:38 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ed8f27ef0059faba2d1d7fd59a.dip0.t-ipconnect.de.
 [2003:ed:8f27:ef00:59fa:ba2d:1d7f:d59a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4521375b5e1sm52487225e9.37.2025.06.07.02.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 02:46:38 -0700 (PDT)
From: oltolm <oleg.tolmatcev@gmail.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 oltolm <oleg.tolmatcev@gmail.com>
Subject: [PATCH RESEND v3] meson: fix Windows build
Date: Sat,  7 Jun 2025 11:45:04 +0200
Message-ID: <20250607094503.1307-2-oleg.tolmatcev@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=oleg.tolmatcev@gmail.com; helo=mail-wr1-x433.google.com
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

Sorry, I forgot to cc the maintainers.

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


