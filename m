Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69685CCF2EE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhucM-0002DL-NS; Mon, 19 Jan 2026 14:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhucF-00028g-JC
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:08:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhucD-0000v9-AA
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:08:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768849720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nYAdUCpNPly738H4K/k4k18nVcwI9iuT+Hc0aUcbLTA=;
 b=EnTKgf2eO6E6LkAl+BPf3mREtAbS6f3nFSl/myKIQcbqqtulI2ahsSxYvCcgMqGskVZV87
 I/KoyCtOgQM151TnbIhWID/Va4XRYcxmjrO8DSrpFtVFJVSVsfFFJSbSGT16tioW4hGYct
 3Vi/lRJw8MlgXCIITDnkBLN2ujmavdo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-cLW-OONFMEaRNOkOkZ7C3A-1; Mon,
 19 Jan 2026 14:08:36 -0500
X-MC-Unique: cLW-OONFMEaRNOkOkZ7C3A-1
X-Mimecast-MFC-AGG-ID: cLW-OONFMEaRNOkOkZ7C3A_1768849715
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E1E01954B17; Mon, 19 Jan 2026 19:08:35 +0000 (UTC)
Received: from localhost (unknown [10.2.16.150])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 979B319560AB; Mon, 19 Jan 2026 19:08:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Richard Henderson <rth@twiddle.net>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 5/8] tracetool: complete typing annotations
Date: Mon, 19 Jan 2026 14:08:20 -0500
Message-ID: <20260119190823.867761-6-stefanha@redhat.com>
In-Reply-To: <20260119190823.867761-1-stefanha@redhat.com>
References: <20260119190823.867761-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Add more annotations so that "mypy --strict".  These have to be done
manually due to limitations of RightTyper.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20251008063546.376603-6-pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool/__init__.py         | 30 +++++++++++++--------------
 scripts/tracetool/backend/__init__.py |  2 +-
 scripts/tracetool/format/log_stap.py  |  2 +-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index f2692de477..e191201819 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -19,17 +19,17 @@
 import sys
 from io import TextIOWrapper
 from pathlib import PurePath
-from typing import Any, Iterator
+from typing import Any, Iterator, Sequence
 
 import tracetool.backend
 import tracetool.format
 
 
-def error_write(*lines) -> None:
+def error_write(*lines: str) -> None:
     """Write a set of error lines."""
     sys.stderr.writelines("\n".join(lines) + "\n")
 
-def error(*lines):
+def error(*lines: str) -> None:
     """Write a set of error lines and exit."""
     error_write(*lines)
     sys.exit(1)
@@ -51,7 +51,7 @@ def error(*lines):
 }
 
 def expand_format_string(c_fmt: str, prefix: str="") -> str:
-    def pri_macro_to_fmt(pri_macro):
+    def pri_macro_to_fmt(pri_macro: str) -> str:
         assert pri_macro.startswith("PRI")
         fmt_type = pri_macro[3]  # 'd', 'i', 'u', or 'x'
         fmt_size = pri_macro[4:]  # '8', '16', '32', '64', 'PTR', 'MAX'
@@ -87,7 +87,7 @@ def out_open(filename: str) -> None:
     out_filename = posix_relpath(filename)
     out_fobj = open(filename, 'wt')
 
-def out(*lines, **kwargs) -> None:
+def out(*lines: str, **kwargs: Any) -> None:
     """Write a set of output lines.
 
     You can use kwargs as a shorthand for mapping variables when formatting all
@@ -229,14 +229,14 @@ def c_type_to_rust(name: str) -> str:
 class Arguments:
     """Event arguments description."""
 
-    def __init__(self, args: list[tuple[str, str]]) -> None:
+    def __init__(self, args: Sequence[tuple[str, str] | Arguments]) -> None:
         """
         Parameters
         ----------
         args :
             List of (type, name) tuples or Arguments objects.
         """
-        self._args = []
+        self._args: list[tuple[str, str]] = []
         for arg in args:
             if isinstance(arg, Arguments):
                 self._args.extend(arg._args)
@@ -271,7 +271,7 @@ def build(arg_str: str) -> Arguments:
             res.append((arg_type, identifier))
         return Arguments(res)
 
-    def __getitem__(self, index):
+    def __getitem__(self, index: int | slice) -> Arguments | tuple[str, str]:
         if isinstance(index, slice):
             return Arguments(self._args[index])
         else:
@@ -287,7 +287,7 @@ def __len__(self) -> int:
 
     def __str__(self) -> str:
         """String suitable for declaring function arguments."""
-        def onearg(t, n):
+        def onearg(t: str, n: str) -> str:
             if t[-1] == '*':
                 return "".join([t, n])
             else:
@@ -298,7 +298,7 @@ def onearg(t, n):
         else:
             return ", ".join([ onearg(t, n) for t,n in self._args ])
 
-    def __repr__(self):
+    def __repr__(self) -> str:
         """Evaluable string representation for this object."""
         return "Arguments(\"%s\")" % str(self)
 
@@ -310,7 +310,7 @@ def types(self) -> list[str]:
         """List of argument types."""
         return [ type_ for type_, _ in self._args ]
 
-    def casted(self):
+    def casted(self) -> list[str]:
         """List of argument names casted to their type."""
         return ["(%s)%s" % (type_, name) for type_, name in self._args]
 
@@ -321,7 +321,7 @@ def rust_decl_extern(self) -> str:
 
     def rust_decl(self) -> str:
         """Return a Rust argument list for a tracepoint function"""
-        def decl_type(type_):
+        def decl_type(type_: str) -> str:
             if type_ == "const char *":
                 return "&std::ffi::CStr"
             return c_type_to_rust(type_)
@@ -331,7 +331,7 @@ def decl_type(type_):
 
     def rust_call_extern(self) -> str:
         """Return a Rust argument list for a call to an extern "C" function"""
-        def rust_cast(name, type_):
+        def rust_cast(name: str, type_: str) -> str:
             if type_ == "const char *":
                 return f"_{name}.as_ptr()"
             return f"_{name}"
@@ -340,7 +340,7 @@ def rust_cast(name, type_):
 
     def rust_call_varargs(self) -> str:
         """Return a Rust argument list for a call to a C varargs function"""
-        def rust_cast(name, type_):
+        def rust_cast(name: str, type_: str) -> str:
             if type_ == "const char *":
                 return f"_{name}.as_ptr()"
 
@@ -449,7 +449,7 @@ def build(line_str: str, lineno: int, filename: str) -> Event:
 
         return Event(name, props, fmt, args, lineno, posix_relpath(filename))
 
-    def __repr__(self):
+    def __repr__(self) -> str:
         """Evaluable string representation for this object."""
         return "Event('%s %s(%s) %s')" % (" ".join(self.properties),
                                           self.name,
diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index 645e78ece0..84bab3f42a 100644
--- a/scripts/tracetool/backend/__init__.py
+++ b/scripts/tracetool/backend/__init__.py
@@ -122,7 +122,7 @@ def backend_modules(self) -> Iterator[Any]:
              if module is not None:
                  yield module
 
-    def _run_function(self, name: str, *args, check_trace_event_get_state: bool | None=None, **kwargs) -> None:
+    def _run_function(self, name: str, *args: Any, check_trace_event_get_state: bool | None=None, **kwargs: Any) -> None:
         for backend in self.backend_modules():
             func = getattr(backend, name % self._format, None)
             if func is not None and \
diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/format/log_stap.py
index d7ad0bb6a7..914e4674ff 100644
--- a/scripts/tracetool/format/log_stap.py
+++ b/scripts/tracetool/format/log_stap.py
@@ -25,7 +25,7 @@
 STATE_LITERAL = 1
 STATE_MACRO = 2
 
-def c_macro_to_format(macro):
+def c_macro_to_format(macro: str) -> str:
     if macro.startswith("PRI"):
         return macro[3]
 
-- 
2.52.0


