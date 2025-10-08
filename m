Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8CBCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6NmX-0004wE-KL; Wed, 08 Oct 2025 02:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6NmT-0004q1-GW
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6NmR-0004Yc-Mc
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759905367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fcj2smrNauxxGVU8euLwnSzw63zkZlk4ZxNct1+YYZ8=;
 b=OTZl0wcZKuKcAalyrSc7y+RzvOhD6rUy6wpTYp2HWbykbzIH7Ssm04MThbU0NX22s6s8I1
 2REfUybH2i/b9pvl4nEc32z6a6MFvQImIODWtighMCLFHVQ5pT+rsbekIy26odYlUgeFPf
 pezhnLYTK706OVIuCgxI2v2xXDkM6nA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-m89xkYmPPamJacV1icL4cw-1; Wed, 08 Oct 2025 02:36:05 -0400
X-MC-Unique: m89xkYmPPamJacV1icL4cw-1
X-Mimecast-MFC-AGG-ID: m89xkYmPPamJacV1icL4cw_1759905364
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6341958f08fso6377796a12.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759905364; x=1760510164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fcj2smrNauxxGVU8euLwnSzw63zkZlk4ZxNct1+YYZ8=;
 b=nQrxnihH6qGoq9NWRLvEnhDLTwytqgbVquiGP2kWa0AYoGUyTJJ45zr6gd+DfHo8IC
 JHtqRNXQ6CKHe7NWA8+YpTW9aAVRrn4kBmyguCIRDR9M9bwwS72bYUVpL+O917wgZgol
 UYiEmzakKl6UJs7dFeHC24dYyMJOjZqqlliMLqRzzg3Z+FtezsS5kgsHAWh2Q1xnvVFU
 ALqYjxpLyBYJzdyEYRpWuZCXStVN8+Mf1N2OICEsH2+AtSmwPIPzf9dlZswzsEkbfgi+
 17ldlINJgsi8/WgWqC1y+xUOW3rOpQcjnUYLZ7qLgb4iXI4ZOxG5OnrCEqvn0CRkFn4B
 jzvg==
X-Gm-Message-State: AOJu0Yy5IKr8q/GzmevMKjqU7JDQxA5tvy6YQx5BhnPy9FRwuYGHRHcj
 BUrXkEzKceIoteuEnXYkSX2DAt9/J8BqK3t0sju7qiAGh8V1VcaxQBGjBPoUS3NUIqpC9CWy1ro
 z9dzh9kvSXuajCpSjlOTXlwLSYFPFhBfgLJkZuyrw8fpKbRKndVcjljuBcd2W2Jyv6p7TcyUr1o
 3sNpA18VPbE2s84U9CkPIeBhQvGgykW1LGhxY70OZB
X-Gm-Gg: ASbGncvdpijiMN8IBEgVZcGyY44UKrBsaFnpxbbYHoOIpMTrmMVi2qgByvJmMncL/+V
 3OiRAWEBtv7vORwHX7w4a3zgx2JcD0WAd6PPwCt/WVpTHFCY18qrxXAjfzRFaXMhYIze3gbKG+K
 v+r1lEmgLyRWoGxfA6we4xM4F195pVVt+XBhUO0E1WZA6k+OdE/5xq4qzpR5aE1wu1aDz58s22y
 uuaMHJkz9US6C5ppxRv5rS7bXkNl25i+bSEntlosDgb1Q2KtPReBq5tzZuM0MuWUCFXDmZ8zUfD
 BZ5WuswzM3/K5JTF4mrawp0VNNfnAuICsGjx8QkYfCkxalCAFWakE+yrMlkS/Su9vH3ELWHZv2M
 Ej3WxPDyjHnPrKRssKkJJSsx7dJwd+kalZzczAuJ+AnP8OJcC
X-Received: by 2002:a05:6402:4306:b0:634:bf56:d6b0 with SMTP id
 4fb4d7f45d1cf-639d5b8c37emr1974484a12.11.1759905363750; 
 Tue, 07 Oct 2025 23:36:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN3u+4Ujkv/oyn5jP1rqOZdTc3NkAZ3pmVDmykCkdzEwbDDVAql7fOLdlBVeroUcRmM7kMWg==
X-Received: by 2002:a05:6402:4306:b0:634:bf56:d6b0 with SMTP id
 4fb4d7f45d1cf-639d5b8c37emr1974467a12.11.1759905363258; 
 Tue, 07 Oct 2025 23:36:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63781c46688sm13966935a12.22.2025.10.07.23.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 23:36:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 5/6] tracetool: complete typing annotations
Date: Wed,  8 Oct 2025 08:35:44 +0200
Message-ID: <20251008063546.376603-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008063546.376603-1-pbonzini@redhat.com>
References: <20251008063546.376603-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add more annotations so that "mypy --strict".  These have to be done
manually due to limitations of RightTyper.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/tracetool/__init__.py         | 30 +++++++++++++--------------
 scripts/tracetool/backend/__init__.py |  2 +-
 scripts/tracetool/format/log_stap.py  |  2 +-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 62895261a0d..c9509b327f4 100644
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
index 645e78ece06..84bab3f42a0 100644
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
index d7ad0bb6a72..914e4674ffe 100644
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
2.51.0


