Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19751CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yo1-0001Xf-8A; Wed, 01 Oct 2025 11:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3ynx-0001VH-Hf
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3ynd-0005rT-19
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759332675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BImpza+zTQUaq5TVPM2gVTY8spNlP5wjp8DIFyDjaZY=;
 b=VWQaCveEH9xvC3hYnzhHB3f20kyfHV+/09Rtny1WurpQt/TxaWryIgwpotyuiWErHttKYj
 5OqQOA84Tac+Q6hGLbQqOESdvGpJmZ0EaP0DomgwByBeeH6bjiaCGPQWvWVOT822z+rf/b
 yr1NbyutmoDBjkHZVVd4fnSxQJfRRR0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-LScm2MscOHy7eO18JMI8Rw-1; Wed,
 01 Oct 2025 11:31:11 -0400
X-MC-Unique: LScm2MscOHy7eO18JMI8Rw-1
X-Mimecast-MFC-AGG-ID: LScm2MscOHy7eO18JMI8Rw_1759332668
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 211131800289; Wed,  1 Oct 2025 15:31:08 +0000 (UTC)
Received: from localhost (unknown [10.2.16.112])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D9D4195608E; Wed,  1 Oct 2025 15:31:06 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bandan Das <bsd@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-rust@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Cleber Rosa <crosa@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Michael Roth <michael.roth@amd.com>, Mads Ynddal <mads@ynddal.dk>,
 Alexandre Iooss <erdnaxe@crans.org>, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 02/16] tracetool: remove dead code
Date: Wed,  1 Oct 2025 11:30:45 -0400
Message-ID: <20251001153059.194991-3-stefanha@redhat.com>
In-Reply-To: <20251001153059.194991-1-stefanha@redhat.com>
References: <20251001153059.194991-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Remove a bunch of dead code from tracetool.

In particular, there are no tcg-exec events anymore and the sub-event
functionality was only used for it.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20250929154938.594389-3-pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool/__init__.py                | 45 +++-----------------
 scripts/tracetool/format/h.py                |  5 ---
 scripts/tracetool/format/log_stap.py         |  2 -
 scripts/tracetool/format/simpletrace_stap.py |  2 -
 4 files changed, 6 insertions(+), 48 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 1d5238a084..4ef1dc1fca 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -15,7 +15,6 @@
 import os
 import re
 import sys
-import weakref
 from pathlib import PurePath
 
 import tracetool.backend
@@ -122,10 +121,6 @@ def __init__(self, args):
             else:
                 self._args.append(arg)
 
-    def copy(self):
-        """Create a new copy."""
-        return Arguments(list(self._args))
-
     @staticmethod
     def build(arg_str):
         """Build and Arguments instance from an argument string.
@@ -222,13 +217,12 @@ class Event(object):
                       r"(?P<name>\w+)"
                       r"\((?P<args>[^)]*)\)"
                       r"\s*"
-                      r"(?:(?:(?P<fmt_trans>\".+),)?\s*(?P<fmt>\".+))?"
+                      r"(?P<fmt>\".+)?"
                       r"\s*")
 
     _VALID_PROPS = set(["disable"])
 
-    def __init__(self, name, props, fmt, args, lineno, filename, orig=None,
-                 event_trans=None, event_exec=None):
+    def __init__(self, name, props, fmt, args, lineno, filename):
         """
         Parameters
         ----------
@@ -236,20 +230,14 @@ def __init__(self, name, props, fmt, args, lineno, filename, orig=None,
             Event name.
         props : list of str
             Property names.
-        fmt : str, list of str
-            Event printing format string(s).
+        fmt : str
+            Event printing format string.
         args : Arguments
             Event arguments.
         lineno : int
             The line number in the input file.
         filename : str
             The path to the input file.
-        orig : Event or None
-            Original Event before transformation/generation.
-        event_trans : Event or None
-            Generated translation-time event ("tcg" property).
-        event_exec : Event or None
-            Generated execution-time event ("tcg" property).
 
         """
         self.name = name
@@ -258,29 +246,16 @@ def __init__(self, name, props, fmt, args, lineno, filename, orig=None,
         self.args = args
         self.lineno = int(lineno)
         self.filename = str(filename)
-        self.event_trans = event_trans
-        self.event_exec = event_exec
 
         if len(args) > 10:
             raise ValueError("Event '%s' has more than maximum permitted "
                              "argument count" % name)
 
-        if orig is None:
-            self.original = weakref.ref(self)
-        else:
-            self.original = orig
-
         unknown_props = set(self.properties) - self._VALID_PROPS
         if len(unknown_props) > 0:
             raise ValueError("Unknown properties: %s"
                              % ", ".join(unknown_props))
-        assert isinstance(self.fmt, str) or len(self.fmt) == 2
 
-    def copy(self):
-        """Create a new copy."""
-        return Event(self.name, list(self.properties), self.fmt,
-                     self.args.copy(), self.lineno, self.filename,
-                     self, self.event_trans, self.event_exec)
 
     @staticmethod
     def build(line_str, lineno, filename):
@@ -302,8 +277,7 @@ def build(line_str, lineno, filename):
         name = groups["name"]
         props = groups["props"].split()
         fmt = groups["fmt"]
-        fmt_trans = groups["fmt_trans"]
-        if fmt.find("%m") != -1 or fmt_trans.find("%m") != -1:
+        if fmt.find("%m") != -1:
             raise ValueError("Event format '%m' is forbidden, pass the error "
                              "as an explicit trace argument")
         if fmt.endswith(r'\n"'):
@@ -312,29 +286,22 @@ def build(line_str, lineno, filename):
         if '\\n' in fmt:
             raise ValueError("Event format must not use new line character")
 
-        if len(fmt_trans) > 0:
-            fmt = [fmt_trans, fmt]
         args = Arguments.build(groups["args"])
 
         return Event(name, props, fmt, args, lineno, posix_relpath(filename))
 
     def __repr__(self):
         """Evaluable string representation for this object."""
-        if isinstance(self.fmt, str):
-            fmt = self.fmt
-        else:
-            fmt = "%s, %s" % (self.fmt[0], self.fmt[1])
         return "Event('%s %s(%s) %s')" % (" ".join(self.properties),
                                           self.name,
                                           self.args,
-                                          fmt)
+                                          self.fmt)
     # Star matching on PRI is dangerous as one might have multiple
     # arguments with that format, hence the non-greedy version of it.
     _FMT = re.compile(r"(%[\d\.]*\w+|%.*?PRI\S+)")
 
     def formats(self):
         """List conversion specifiers in the argument print format string."""
-        assert not isinstance(self.fmt, list)
         return self._FMT.findall(self.fmt)
 
     QEMU_TRACE               = "trace_%(name)s"
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index b42a8268a8..bd9e0ca7f2 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -40,11 +40,6 @@ def generate(events, backend, group):
             enabled = 0
         else:
             enabled = 1
-        if "tcg-exec" in e.properties:
-            # a single define for the two "sub-events"
-            out('#define TRACE_%(name)s_ENABLED %(enabled)d',
-                name=e.original.name.upper(),
-                enabled=enabled)
         out('#define TRACE_%s_ENABLED %d' % (e.name.upper(), enabled))
 
     backend.generate_begin(events, group)
diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/format/log_stap.py
index 710d62bffe..5b1bbe907f 100644
--- a/scripts/tracetool/format/log_stap.py
+++ b/scripts/tracetool/format/log_stap.py
@@ -18,8 +18,6 @@
 from tracetool.backend.simple import is_string
 from tracetool.format.stap import stap_escape
 
-def global_var_name(name):
-    return probeprefix().replace(".", "_") + "_" + name
 
 STATE_SKIP = 0
 STATE_LITERAL = 1
diff --git a/scripts/tracetool/format/simpletrace_stap.py b/scripts/tracetool/format/simpletrace_stap.py
index 72971133bf..ac39a492d9 100644
--- a/scripts/tracetool/format/simpletrace_stap.py
+++ b/scripts/tracetool/format/simpletrace_stap.py
@@ -17,8 +17,6 @@
 from tracetool.backend.simple import is_string
 from tracetool.format.stap import stap_escape
 
-def global_var_name(name):
-    return probeprefix().replace(".", "_") + "_" + name
 
 def generate(events, backend, group):
     out('/* This file is autogenerated by tracetool, do not edit. */',
-- 
2.51.0


