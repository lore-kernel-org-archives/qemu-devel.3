Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E02E6072664
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mqxe8DEJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOhRj-0007ES-Bu; Wed, 04 Nov 2026 15:18:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xOhRb-00075s-C6
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 15:18:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xOhRY-0006Cq-SG
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 15:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793823528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iBUiZ9J/MXAwZUcV5uBewFxgpdyM35rzQHUpr8XDSZ8=;
 b=Mqxe8DEJJIvYJ8BSWCx9d5NKPudxY3VDddMhm5yGt5jeGZiY1r1gRGVR4hAkOllMTvESS4
 DRRcOWEqXFNasTJp+pbvE4vm/rSiaf3wXPtrrGy9gcdmnJGHoSEyXcNiRlnTgIRx4QLUvp
 gA4gZITuN5MIYRINCUOFdy/tdEI/P7E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-U_0NOw0JMTG5B1fJWdDKJg-1; Wed,
 04 Nov 2026 15:18:44 -0500
X-MC-Unique: U_0NOw0JMTG5B1fJWdDKJg-1
X-Mimecast-MFC-AGG-ID: U_0NOw0JMTG5B1fJWdDKJg_1793823523
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 087B91955EA9; Wed,  4 Nov 2026 20:18:43 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC81218004FC; Wed,  4 Nov 2026 20:18:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-ppc@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL v2 24/25] trace: remove parsing of "disable" event property
Date: Wed,  4 Nov 2026 15:18:00 -0500
Message-ID: <20261104201802.11556-25-stefanha@redhat.com>
In-Reply-To: <20261104201802.11556-1-stefanha@redhat.com>
References: <20261104201802.11556-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel P. Berrangé <berrange@redhat.com>

Finish the removal of the "disable" event property by removing code
that parses properties and the backend code generators.

This "fixes" a bug in the UST backends which looked for a property
called "disabled" instead of "disable".

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20261102142844.3464712-25-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/devel/tracing.rst                       | 27 +++---------------
 scripts/tracetool/__init__.py                | 27 ++++--------------
 scripts/tracetool/backend/dtrace.py          |  2 --
 scripts/tracetool/format/c.py                |  9 ++----
 scripts/tracetool/format/d.py                |  3 --
 scripts/tracetool/format/h.py                | 30 +++++++++-----------
 scripts/tracetool/format/log_stap.py         |  3 --
 scripts/tracetool/format/rs.py               | 26 ++++++++---------
 scripts/tracetool/format/simpletrace_stap.py |  3 --
 scripts/tracetool/format/stap.py             |  3 --
 scripts/tracetool/format/ust_events_c.py     |  3 --
 scripts/tracetool/format/ust_events_h.py     |  3 --
 12 files changed, 39 insertions(+), 100 deletions(-)

diff --git a/docs/devel/tracing.rst b/docs/devel/tracing.rst
index f4557ee20e4..4bc344f0331 100644
--- a/docs/devel/tracing.rst
+++ b/docs/devel/tracing.rst
@@ -230,9 +230,6 @@ The "nop" backend generates empty trace event functions so that the compiler
 can optimize out trace events completely.  This imposes no performance
 penalty.
 
-Note that regardless of the selected trace backend, events with the "disable"
-property will be generated with the "nop" backend.
-
 Log
 ---
 
@@ -366,30 +363,14 @@ To facilitate simple usage of systemtap where there merely needs to be printf
 logging of certain probes, a helper script "qemu-trace-stap" is provided.
 Consult its manual page for guidance on its usage.
 
-Trace event properties
+Trace event conditions
 ======================
 
-Each event in the "trace-events-all" file can be prefixed with a space-separated
-list of zero or more of the following event properties.
-
-"disable"
----------
-
-If a specific trace event is going to be invoked a huge number of times, this
-might have a noticeable performance impact even when the event is
-programmatically disabled.
-
-In this case you should declare such event with the "disable" property. This
-will effectively disable the event at compile time (by using the "nop" backend),
-thus having no performance impact at all on regular builds (i.e., unless you
-edit the "trace-events-all" file).
-
-In addition, there might be cases where relatively complex computations must be
+There might be cases where relatively complex computations must be
 performed to generate values that are only used as arguments for a trace
 function. In these cases you can use 'trace_event_get_state_backends()' to
-guard such computations, so they are skipped if the event has been either
-compile-time disabled or run-time disabled. If the event is compile-time
-disabled, this check will have no performance impact.
+guard such computations, so they are skipped if the event is not currently
+enabled:
 
 ::
 
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
index 544bbc0ba93..f719fe09397 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -46,14 +46,13 @@ def generate(events, backend, group):
             '#define %(api)s() ( \\',
             api=e.api(e.QEMU_BACKEND_DSTATE))
 
-        if "disable" not in e.properties:
-            backend.generate_backend_dstate(e, group, check_trace_event_get_state=False)
+        backend.generate_backend_dstate(e, group, check_trace_event_get_state=False)
 
-            if backend.check_trace_event_get_state:
-                event_id = 'TRACE_' + e.name.upper()
-                out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
-                    event_id=event_id)
-                backend.generate_backend_dstate(e, group, check_trace_event_get_state=True)
+        if backend.check_trace_event_get_state:
+            event_id = 'TRACE_' + e.name.upper()
+            out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
+                event_id=event_id)
+            backend.generate_backend_dstate(e, group, check_trace_event_get_state=True)
 
         out('    false)')
 
@@ -63,16 +62,15 @@ def generate(events, backend, group):
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
2.56.0


