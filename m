Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA44FC5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 08:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKZ2r-0003Iq-Pl; Thu, 29 May 2025 04:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uKZ2e-0003Dn-NF
 for qemu-devel@nongnu.org; Thu, 29 May 2025 04:55:13 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oleg.tolmatcev@gmail.com>)
 id 1uKZ2c-00072X-Lh
 for qemu-devel@nongnu.org; Thu, 29 May 2025 04:55:12 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso5664745e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 01:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748508908; x=1749113708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rpC/2DaqbuN5RXYQ9HcuVt41U31Bt68ZIBDUrL5JL3A=;
 b=ADBXWopQLYBrv0ehd7OMOlP3czpH1zc9+N3RboOvenSZ1Jgesvpm6KDap7I6HFsl9t
 Nr/7C0KcHjGTpcD3010zj6Ch/WSffIqwLqz3AkfcrwFVbpiv3fD1B3lMHKW3XbH+UWAz
 W4xPirzvprq85aICq8IT+iwVOE6dggpibiD6G/Sq6htM3aQN9B+6D5wM6WGru/CwYSq/
 6PwoiWw7LadyY8eDBWU1jJ/F5cUNG+spPQ7yBOjw4KJ9Pp8r8/2uXAQrXqaS44D1+2/2
 54j4oe4HSgAfb6AocP3Z/mYRCAWTr/ZI/3tPPg/6d1zfijI9eknWVeUdkJu+/NSCS/T0
 /OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748508908; x=1749113708;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rpC/2DaqbuN5RXYQ9HcuVt41U31Bt68ZIBDUrL5JL3A=;
 b=r8Omtj28gkizbMQQ9o/M7d4Do+SZGBvq5/skVV97Es68U5wNx9zQ8Mv0oaSPPP+E7+
 WkGYepH2G9CKiovLz3LX9WuLLro59ijbE89JCUh0jGSNzttmw/HSFzGR/M7+kJxuO5cc
 09IFqJxrujabU0CBZhc7+TEsP/dNU6rovPlqlxa+GSm762ogvH5Ftjl4PV/X7BAAtQPW
 59DV4RsEefxbsao4Wjf+BFHZ47T5cM5L9czpgdGuYELvg+u27XmHYORCScsVBBikqsRp
 fxoWr+v6CuuUvLQpr23EeN7LpF+Pw0RHM6mVFiYzlIRla30Du785dpMZnb+t7rFwpkYg
 /HiA==
X-Gm-Message-State: AOJu0Yx7O0zCRdLBdv+8Gw0IyuhGebp6MLhyL9JpBtC0qNhu+aaPfPA0
 HKuxmgI/N9iuB7/PMLDU1w5+d0swFjLddB+jhoKTChNIl6KtU9pcUVKrz466ag==
X-Gm-Gg: ASbGncsub3WWKQjIzJ67pclKBpP2/K4NwN+GJHTdBjAalaZO8ISVRfwZUXipbVBHbJH
 CMFbuY0r916HDifmo/x5iLMKrIjcu4kE/RkeFo+wd8o2Ltwory6GwcgcKHpWpfi22/9+wed876o
 9YMNXZY4PTuDw5p1uNDcK4C/O7bYdk7nAE+9fLKy44csvQWhief8DgYuBNT6T/9AOGTzosGJ5eq
 4US7kBOmyJbYCwSenIjFA/n8zBCaN0O94wt7MVt2BVPJVXbraes2oH0Hv3DEhhAwBMAsZKSqOB+
 8hJLj01PvOcRApd4erXsl9JwhP4yKEkilZuoFg55qclk6/a8IBQQx1EiNGEXwzl8GVj5mnCbZ2A
 lKIxEuQ4dpviHDdzZMKeHAe7tzUi4Mivlq6uQGMSqXtriJN1mneZBRXga3F1z7MfK
X-Google-Smtp-Source: AGHT+IHL0EU6upFYWvAs9IuW5OPhtw9YmryOgh7zacYuJ+lxkW3qonrJG0p100RVL2RHkJJ14PeVng==
X-Received: by 2002:a05:600c:2309:b0:450:d019:263 with SMTP id
 5b1f17b1804b1-450d01904bcmr10449315e9.18.1748508907524; 
 Thu, 29 May 2025 01:55:07 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ed8f1f0c009d8d182aff56d606.dip0.t-ipconnect.de.
 [2003:ed:8f1f:c00:9d8d:182a:ff56:d606])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450cfc15cb8sm13800775e9.19.2025.05.29.01.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 01:55:07 -0700 (PDT)
From: oltolm <oleg.tolmatcev@gmail.com>
To: qemu-devel@nongnu.org
Cc: oltolm <oleg.tolmatcev@gmail.com>
Subject: [PATCH v2] meson: fix Windows build
Date: Thu, 29 May 2025 10:54:38 +0200
Message-ID: <20250529085437.1479-2-oleg.tolmatcev@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=oleg.tolmatcev@gmail.com; helo=mail-wm1-x336.google.com
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
like ´cat´ and ´true´ with calls to ´python´. I wrapped calls to
´os.path.relpath´ in try-except because it can fail when the two paths
are on different drives. I made sure to convert the Windows paths to
Unix paths to prevent warnings in generated files.

Signed-off-by: oltolm <oleg.tolmatcev@gmail.com>
---
 contrib/plugins/meson.build         | 2 +-
 scripts/tracetool/backend/ftrace.py | 9 ++++++++-
 scripts/tracetool/backend/log.py    | 9 ++++++++-
 scripts/tracetool/backend/syslog.py | 9 ++++++++-
 tests/functional/meson.build        | 4 +---
 tests/include/meson.build           | 2 +-
 tests/tcg/plugins/meson.build       | 2 +-
 trace/meson.build                   | 5 +++--
 8 files changed, 31 insertions(+), 11 deletions(-)

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
index 3df454935..ebce0154c 100644
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
 
+cat = [ python, '-c', 'import fileinput;[print(line) for line in fileinput.input()]', '@INPUT@' ]
 trace_events_all = custom_target('trace-events-all',
                                  output: 'trace-events-all',
                                  input: trace_events_files,
-                                 command: [ 'cat', '@INPUT@' ],
+                                 command: [ cat ],
                                  capture: true,
                                  install: get_option('trace_backends') != [ 'nop' ],
                                  install_dir: qemu_datadir)
-- 
2.49.0.windows.1


