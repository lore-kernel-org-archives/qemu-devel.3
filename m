Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D59ACA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCIT3-0000zz-Ov; Thu, 01 Oct 2026 11:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCIT0-0000zS-SE
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 11:13:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCISv-0000xM-Ul
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 11:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790867577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/916oowHlZcH6J7SgN/42og/2yE/p4n/hLGiHY3t/no=;
 b=KeApjuIAPOdFv+/9M4aCpG/yzExhd8uzL/Oex+JgJ+jONWaIDANlS1SULLRqnyjSPjkwpo
 5hcQ45W79Y/e+20+7L3WqhhXsvsJ+42KHUS7UGZC86iqH3mYt0OBHHF9isoNWhWrYoMbos
 aHZzWWg9dRD5knJV1MfgLHlCDuMXm2Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-z5AL3rAzMMqwa1PemJ9XTA-1; Thu,
 01 Oct 2026 11:12:55 -0400
X-MC-Unique: z5AL3rAzMMqwa1PemJ9XTA-1
X-Mimecast-MFC-AGG-ID: z5AL3rAzMMqwa1PemJ9XTA_1790867575
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7FDC1954B34
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2026 15:12:54 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0A1611956045; Thu,  1 Oct 2026 15:12:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 19/20] trace: remove parsing of "disable" event property
Date: Thu,  1 Oct 2026 16:12:27 +0100
Message-ID: <20261001151228.3373747-20-berrange@redhat.com>
In-Reply-To: <20261001151228.3373747-1-berrange@redhat.com>
References: <20261001151228.3373747-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Finish the removal of the "disable" event property by removing code
that parses properties and the backend code generators.

This "fixes" a bug in the UST backends which looked for a property
called "disabled" instead of "disable".

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/tracetool/__init__.py                | 27 +++++---------------
 scripts/tracetool/backend/dtrace.py          |  2 --
 scripts/tracetool/format/c.py                |  9 +++----
 scripts/tracetool/format/d.py                |  3 ---
 scripts/tracetool/format/h.py                | 20 +++++++--------
 scripts/tracetool/format/log_stap.py         |  3 ---
 scripts/tracetool/format/rs.py               | 26 +++++++++----------
 scripts/tracetool/format/simpletrace_stap.py |  3 ---
 scripts/tracetool/format/stap.py             |  3 ---
 scripts/tracetool/format/ust_events_c.py     |  3 ---
 scripts/tracetool/format/ust_events_h.py     |  3 ---
 11 files changed, 30 insertions(+), 72 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 6ed7cdd6ce4..bdbb06b5205 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -362,8 +362,6 @@ class Event(object):
         The event name.
     fmt : str
         The event format string.
-    properties : set(str)
-        Properties of the event.
     args : Arguments
         The event arguments.
     lineno : int
@@ -373,23 +371,18 @@ class Event(object):
 
     """
 
-    _CRE = re.compile(r"((?P<props>[\w\s]+)\s+)?"
-                      r"(?P<name>\w+)"
+    _CRE = re.compile(r"(?P<name>\w+)"
                       r"\((?P<args>[^)]*)\)"
                       r"\s*"
                       r"(?P<fmt>\".+)?"
                       r"\s*")
 
-    _VALID_PROPS = set(["disable"])
-
-    def __init__(self, name, props, fmt, args, lineno, filename):
+    def __init__(self, name, fmt, args, lineno, filename):
         """
         Parameters
         ----------
         name : string
             Event name.
-        props : list of str
-            Property names.
         fmt : str
             Event printing format string.
         args : Arguments
@@ -401,7 +394,6 @@ def __init__(self, name, props, fmt, args, lineno, filename):
 
         """
         self.name = name
-        self.properties = props
         self.fmt = fmt
         self.args = args
         self.lineno = int(lineno)
@@ -411,11 +403,6 @@ def __init__(self, name, props, fmt, args, lineno, filename):
             raise ValueError("Event '%s' has more than maximum permitted "
                              "argument count" % name)
 
-        unknown_props = set(self.properties) - self._VALID_PROPS
-        if len(unknown_props) > 0:
-            raise ValueError("Unknown properties: %s"
-                             % ", ".join(unknown_props))
-
 
     @staticmethod
     def build(line_str, lineno, filename):
@@ -435,7 +422,6 @@ def build(line_str, lineno, filename):
         groups = m.groupdict('')
 
         name = groups["name"]
-        props = groups["props"].split()
         fmt = groups["fmt"]
         if fmt.find("%m") != -1:
             raise ValueError("Event format '%m' is forbidden, pass the error "
@@ -448,14 +434,13 @@ def build(line_str, lineno, filename):
 
         args = Arguments.build(groups["args"])
 
-        return Event(name, props, fmt, args, lineno, posix_relpath(filename))
+        return Event(name, fmt, args, lineno, posix_relpath(filename))
 
     def __repr__(self):
         """Evaluable string representation for this object."""
-        return "Event('%s %s(%s) %s')" % (" ".join(self.properties),
-                                          self.name,
-                                          self.args,
-                                          self.fmt)
+        return "Event('%s(%s) %s')" % (self.name,
+                                       self.args,
+                                       self.fmt)
     # Star matching on PRI is dangerous as one might have multiple
     # arguments with that format, hence the non-greedy version of it.
     _FMT = re.compile(r"(%[\d\.]*\w+|%.*?PRI\S+)")
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
index f0b58cc1585..6bce25c8d2d 100644
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -79,8 +79,6 @@ def generate_rs_begin(events, group):
     # These are the Rust declarations of the .probes section semaphores
     # generated by dtrace(1) in its .o file output.
     for e in events:
-        if 'disable' in e.properties:
-            continue
         out('    #[allow(dead_code)]',
             f'    static qemu_{e.name}_semaphore: UnsafeCell<u16>;')
     out('}',
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index 9f06894623e..3754c7e06fd 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -16,9 +16,6 @@
 
 
 def generate(events, backend, group):
-    active_events = [e for e in events
-                     if "disable" not in e.properties]
-
     header = "trace-" + group + ".h"
 
     out('/* This file is autogenerated by tracetool, do not edit. */',
@@ -62,7 +59,7 @@ def generate(events, backend, group):
             'trace_init(trace_%(group)s_register_events)',
             group = group.lower())
 
-        backend.generate_begin(active_events, group)
-        for event in active_events:
+        backend.generate_begin(events, group)
+        for event in events:
             backend.generate(event, group)
-        backend.generate_end(active_events, group)
+        backend.generate_end(events, group)
diff --git a/scripts/tracetool/format/d.py b/scripts/tracetool/format/d.py
index e9e33dfe30a..df7780cb0af 100644
--- a/scripts/tracetool/format/d.py
+++ b/scripts/tracetool/format/d.py
@@ -30,9 +30,6 @@
 
 
 def generate(events, backend, group):
-    events = [e for e in events
-              if "disable" not in e.properties]
-
     # SystemTap's dtrace(1) warns about empty "provider qemu {}" but is happy
     # with an empty file.  Avoid the warning.
     # But dtrace on macOS can't deal with empty files.
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index 3ca92ba5fbe..af1482f6238 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -46,8 +46,7 @@ def generate(events, backend, group):
             '#define %(api)s() ( \\',
             api=e.api(e.QEMU_BACKEND_DSTATE))
 
-        if "disable" not in e.properties:
-            backend.generate_backend_dstate(e, group)
+        backend.generate_backend_dstate(e, group)
 
         out('    false)')
 
@@ -57,16 +56,15 @@ def generate(events, backend, group):
             api=e.api(),
             args=e.args)
 
-        if "disable" not in e.properties:
-            backend.generate(e, group, check_trace_event_get_state=False)
+        backend.generate(e, group, check_trace_event_get_state=False)
 
-            if backend.check_trace_event_get_state:
-                event_id = 'TRACE_' + e.name.upper()
-                cond = "trace_event_get_state(%s)" % event_id
-                out('    if (%(cond)s) {',
-                        cond=cond)
-                backend.generate(e, group, check_trace_event_get_state=True)
-                out('    }')
+        if backend.check_trace_event_get_state:
+            event_id = 'TRACE_' + e.name.upper()
+            cond = "trace_event_get_state(%s)" % event_id
+            out('    if (%(cond)s) {',
+                cond=cond)
+            backend.generate(e, group, check_trace_event_get_state=True)
+            out('    }')
         out('}')
 
     backend.generate_end(events, group)
diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/format/log_stap.py
index 259303a189d..3fa6c2dd3f2 100644
--- a/scripts/tracetool/format/log_stap.py
+++ b/scripts/tracetool/format/log_stap.py
@@ -90,9 +90,6 @@ def generate(events, backend, group):
         '')
 
     for event_id, e in enumerate(events):
-        if 'disable' in e.properties:
-            continue
-
         out('probe %(probeprefix)s.log.%(name)s = %(probeprefix)s.%(name)s ?',
             '{',
             probeprefix=probeprefix(),
diff --git a/scripts/tracetool/format/rs.py b/scripts/tracetool/format/rs.py
index 1fddcee1ad2..97d89a981da 100644
--- a/scripts/tracetool/format/rs.py
+++ b/scripts/tracetool/format/rs.py
@@ -52,11 +52,10 @@ def generate(events, backend, group):
             '{',
             api=e.api(e.QEMU_RUST_DSTATE))
 
-        if "disable" not in e.properties:
-            backend.generate_backend_dstate(e, group)
-            if backend.check_trace_event_get_state:
-                out('    trace_event_state_is_enabled(unsafe { _%(event_id)s_DSTATE}) ||',
-                    event_id = 'TRACE_' + e.name.upper())
+        backend.generate_backend_dstate(e, group)
+        if backend.check_trace_event_get_state:
+            out('    trace_event_state_is_enabled(unsafe { _%(event_id)s_DSTATE}) ||',
+                event_id = 'TRACE_' + e.name.upper())
 
         out('    false',
             '}',
@@ -68,15 +67,14 @@ def generate(events, backend, group):
             api=e.api(e.QEMU_TRACE),
             args=e.args.rust_decl())
 
-        if "disable" not in e.properties:
-            backend.generate(e, group, check_trace_event_get_state=False)
-            if backend.check_trace_event_get_state:
-                event_id = 'TRACE_' + e.name.upper()
-                out('    if trace_event_state_is_enabled(unsafe { _%(event_id)s_DSTATE}) {',
-                    event_id = event_id,
-                    api=e.api())
-                backend.generate(e, group, check_trace_event_get_state=True)
-                out('    }')
+        backend.generate(e, group, check_trace_event_get_state=False)
+        if backend.check_trace_event_get_state:
+            event_id = 'TRACE_' + e.name.upper()
+            out('    if trace_event_state_is_enabled(unsafe { _%(event_id)s_DSTATE}) {',
+                event_id = event_id,
+                api=e.api())
+            backend.generate(e, group, check_trace_event_get_state=True)
+            out('    }')
         out('}',
             '')
 
diff --git a/scripts/tracetool/format/simpletrace_stap.py b/scripts/tracetool/format/simpletrace_stap.py
index c7bde97a855..393d85319c7 100644
--- a/scripts/tracetool/format/simpletrace_stap.py
+++ b/scripts/tracetool/format/simpletrace_stap.py
@@ -24,9 +24,6 @@ def generate(events, backend, group):
         '')
 
     for event_id, e in enumerate(events):
-        if 'disable' in e.properties:
-            continue
-
         out('probe %(probeprefix)s.simpletrace.%(name)s = %(probeprefix)s.%(name)s ?',
             '{',
             probeprefix=probeprefix(),
diff --git a/scripts/tracetool/format/stap.py b/scripts/tracetool/format/stap.py
index 285c9203ba7..e3d16b72d34 100644
--- a/scripts/tracetool/format/stap.py
+++ b/scripts/tracetool/format/stap.py
@@ -34,9 +34,6 @@ def stap_escape(identifier):
 
 
 def generate(events, backend, group):
-    events = [e for e in events
-              if "disable" not in e.properties]
-
     out('/* This file is autogenerated by tracetool, do not edit. */',
         '/* SPDX-License-Identifier: GPL-2.0-or-later */',
         '')
diff --git a/scripts/tracetool/format/ust_events_c.py b/scripts/tracetool/format/ust_events_c.py
index 074226bfd37..93f88a03e90 100644
--- a/scripts/tracetool/format/ust_events_c.py
+++ b/scripts/tracetool/format/ust_events_c.py
@@ -16,9 +16,6 @@
 
 
 def generate(events, backend, group):
-    events = [e for e in events
-              if "disabled" not in e.properties]
-
     out('/* This file is autogenerated by tracetool, do not edit. */',
         '/* SPDX-License-Identifier: GPL-2.0-or-later */',
         '',
diff --git a/scripts/tracetool/format/ust_events_h.py b/scripts/tracetool/format/ust_events_h.py
index 76c883bc5c0..441e6a41933 100644
--- a/scripts/tracetool/format/ust_events_h.py
+++ b/scripts/tracetool/format/ust_events_h.py
@@ -16,9 +16,6 @@
 
 
 def generate(events, backend, group):
-    events = [e for e in events
-              if "disabled" not in e.properties]
-
     if group == "all":
         include = "trace-ust-all.h"
     else:
-- 
2.55.0


