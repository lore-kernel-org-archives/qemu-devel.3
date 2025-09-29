Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29E9CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G8x-0000ve-6F; Mon, 29 Sep 2025 11:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8d-0000mC-Uq
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8P-0000KL-4a
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759160990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BPzxrddqtL0TItlI5LLtoSQbI5T1+Lsx8CSDc/Du130=;
 b=hCdBHFNEWyLG7WQZ34XaR60YortL1P5j0MpMoQGdIbBZBbva0Qzuo54rNcK9NxXdpp0fcx
 aBAoX7BoY4I6WCV0iZ+By+9ybQ3hXeUZ121dmdAnf7ILV2Y6XsrvW1iA0hoWHrsv/06Qeh
 k7R9tTAlbM1btbmhlpg/RQ64iH4IW7I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-gJEM3_k7NMmgKflsDV5PYQ-1; Mon, 29 Sep 2025 11:49:48 -0400
X-MC-Unique: gJEM3_k7NMmgKflsDV5PYQ-1
X-Mimecast-MFC-AGG-ID: gJEM3_k7NMmgKflsDV5PYQ_1759160987
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-634bff4ccc6so3805188a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759160986; x=1759765786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BPzxrddqtL0TItlI5LLtoSQbI5T1+Lsx8CSDc/Du130=;
 b=N8Md/c/LStfGtaVPEnfGK1ffdQAl2qo1PvxX7cFWwnErhRnUSn5xJjiCACpWMxTe6N
 0jpePAEh25fW3IWViwJq2ttAjaXq/xV3Aez/VOTWRJA+2PEGtUXxXMcyWggVu85yo7aZ
 P+1iyGEgBYGhiSfo+Crdi27t/ihfHZ6WUHXfMcaIUI+z8hN+dhFcbj0YyGxQaOqya1ta
 z3HY+ne3FLMzvYZjohG6QWZSquFaoD/6zmontIjXCXAnjSVG/GdOSHLqc/9hkvdKWJM2
 VaAT3oXQCULCTSvo62aMle8Aw/8xcWm8SPIXm6fqH59XSh3TBCzL8lmYxATAhcZ6tmXD
 VMoA==
X-Gm-Message-State: AOJu0Yz833i+6iKYQK3f9XJvh7RYJblhAuj7hzZtzc1uef5M5pp7jOVf
 lvv6PoqtACHScN2FOqX7L4BGminAz1Hd+D/ejdpB/bFbra8b1ld9iSM1iAjw3dX2KwIZT1qjdDQ
 YZRIi4aVN148Y6vQGuWgP+Qp6eCA69JTqUXrwINpKkW6aV7e7hDZDmu2j54u9ocnaFmDfj3fZHK
 zuYN7CelArb7RGqww5E5s5kfQRWqVtrmpQ4UdxZNRE
X-Gm-Gg: ASbGncuJGrINZgZMJ8PJb5cNHmL8/rhEfGgUjmAu8MNvU/uAAsgYIdXYZoSoDqkvI6i
 DdCdR19L2ymv8pUJXFqtPZjjA4huFYE5Y2jSYYVo834zUVH4dB4n9wgRJEo+pwq9wPgOrwVPNXH
 u1G5Wgi+toTLf27uEH7q7hhPPMFu4JWsd1AnL4Abts8iyB/hL8LIsTzWN6m5XzS4uOF2qEQ/bKo
 aLDO/3jyDNrWAet35Dqsnm3XtDpXgQ/veps1xztPc2gsfd1NjbVL2MFtA/NnYiRUacvUmoktr9i
 d3fHVjy8zElI1n5Tu3KeVr85ZT2vfNxU9k+piYy8MKpCogWU/srju4PtyZZhUjaDfXZIwy+XfnV
 xVhGiDZ38+inLq3paeDjpjepyfbmhEQmGFZNJ/jND6yFGGQ==
X-Received: by 2002:a17:907:6093:b0:ae1:a6a0:f2fe with SMTP id
 a640c23a62f3a-b34bad28537mr1913857966b.36.1759160985558; 
 Mon, 29 Sep 2025 08:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG21EHXJbWMybWv0lsGwuZFID3E8aCqbDC3DKgYJf6kzYsdtFqtEWU8jK5Bb3ncnCzjZgj+nw==
X-Received: by 2002:a17:907:6093:b0:ae1:a6a0:f2fe with SMTP id
 a640c23a62f3a-b34bad28537mr1913855166b.36.1759160985043; 
 Mon, 29 Sep 2025 08:49:45 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3545a983ffsm953498566b.94.2025.09.29.08.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:49:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: [PATCH 02/16] tracetool: remove dead code
Date: Mon, 29 Sep 2025 17:49:24 +0200
Message-ID: <20250929154938.594389-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929154938.594389-1-pbonzini@redhat.com>
References: <20250929154938.594389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Remove a bunch of dead code from tracetool.

In particular, there are no tcg-exec events anymore and the sub-event
functionality was only used for it.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/tracetool/__init__.py                | 45 +++-----------------
 scripts/tracetool/format/h.py                |  5 ---
 scripts/tracetool/format/log_stap.py         |  2 -
 scripts/tracetool/format/simpletrace_stap.py |  2 -
 4 files changed, 6 insertions(+), 48 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 1d5238a0843..4ef1dc1fca3 100644
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
index b42a8268a81..bd9e0ca7f23 100644
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
index 710d62bffe4..5b1bbe907ff 100644
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
index 72971133bf0..ac39a492d96 100644
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


