Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C08CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6NmO-0004oi-Et; Wed, 08 Oct 2025 02:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6NmH-0004oI-Ob
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:35:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6NmE-0004QF-B6
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759905353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4T2wVt1MaX0El9HubPfFve5RHxPz4UaINM26iRvcqW8=;
 b=INnkzaANBSesTpMwZ39uhLmEK0W+UXgHuXMq8iNI9ffmcQA27Go0xGLcbB6LSQYlaT1eGu
 o8O7h06aI3jOdZLSGZ3/TpHcHL3dkTgjP0xvrVfTGiuMjSjImkMWtLzIksqOhREIJXGvoa
 bp8Ivr2b0s64PICo25sdGWvVGTqHiQ4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-9H5cuMFZPA-QkQh97cd_yg-1; Wed, 08 Oct 2025 02:35:51 -0400
X-MC-Unique: 9H5cuMFZPA-QkQh97cd_yg-1
X-Mimecast-MFC-AGG-ID: 9H5cuMFZPA-QkQh97cd_yg_1759905350
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b504dd6dbf1so78234466b.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759905349; x=1760510149;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4T2wVt1MaX0El9HubPfFve5RHxPz4UaINM26iRvcqW8=;
 b=oLX274GKSaG8MsNdfuGCT8ly8fZNEPDkWkuBw3mvr3gRSVHRzwtbA8sVEES4TopOmO
 2VSG1GBkPIjMEM/Uf+MsP8mG19Xde9rxBi9Gxw4W5PSjlRIyXfCROVSK6Ms6EYAskgev
 gZL12uwMTmf4m3yo1hE6V1bxltKaH+nx6Z5Fe3xJ4urfON2gDn5jKU+a4Xzb0p7Kt/IG
 BUlx84Rw5DwAFUIALtY1KqMRFPmsb+hJhZQfgd0IKslR0loo7f7TixbIirb6ruEZycLC
 q5EcSyGzOBkP29wwtIy9n6wIwOgaYpN7leVQhJfro8EEb7MhfiZ88x+4R5ZxuQyPGF9K
 Iq+w==
X-Gm-Message-State: AOJu0Ywr4mHJeCXIRSr6h/0bEL2s9c7Te0BWY/irbE7b0+r6dycmqJ68
 NcKKl5+8eC0YUAB+6R2yAcGYvQxj7eftdcjyKIABP3Zwy06c3hsQBH2myHiZkNgBV9WmPedBGBm
 ZDLjBG1J2zp255P2mj0obBUYuKDJHShLMjA5Shp4mMylJAXxACuztIoSZv2dpzbtUARCEvPA5+K
 BrPX5QEqTym8FkAfqoiIi3eeLRLhrvoKwtMUI5OymA
X-Gm-Gg: ASbGnctVzZlhsqi9hMvsdTWBNsTw/KJ3TsHaO8ZZgWfo6HLo6Gb9zdqLZIySgPe/m1F
 l36Mwu3VyLVq1yyOw4QrU1nryGQY8ns0/kCBIhHQhqzm8lotXmitQYDqd5fiGfK6GR70Arj6TW2
 XaJANgLu3V1ngFu94kdEEuYMlXo0kWhvjOWSlK6vBgZhZfeyDEXfKa2EgAL9lf8Hsa/NlMxBmdG
 p/28VotlWuMw6V9JJ9w96aIKhsY9Y9exDtPjzrWNc0Vxbs1d5nZDAA94xUJcDVTj9kyBkXbvl0N
 EX+YqrBareZFWF3YxnTwJaWCT7uTg9Mz3GtmOyFfSgATjNmxrjihfHse+vPw0sbhQa2IG4ZS9HN
 VQIcwOjHlAJDlwNkUhDuB/sN/urNdxk+CSwcv3EkRgSv6G9eC
X-Received: by 2002:a17:906:c113:b0:b29:e717:f0b0 with SMTP id
 a640c23a62f3a-b50ac4d3497mr244428066b.59.1759905349324; 
 Tue, 07 Oct 2025 23:35:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCJeb+ltzAfvULNedxzAhdgF9CHbDRsEJ4EGM2EWPSqjUyV1p25AbAcnfnqq4zeMiR+tc2pA==
X-Received: by 2002:a17:906:c113:b0:b29:e717:f0b0 with SMTP id
 a640c23a62f3a-b50ac4d3497mr244422466b.59.1759905348252; 
 Tue, 07 Oct 2025 23:35:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b4c7396b863sm857453166b.65.2025.10.07.23.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 23:35:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 0/6] tracetool: add mypy --strict checking [AI discussion
 ahead!]
Date: Wed,  8 Oct 2025 08:35:39 +0200
Message-ID: <20251008063546.376603-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
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

[People in Cc are a mix of Python people, tracing people, and people
 who followed the recent AI discussions. - Paolo]

This series adds type annotations to tracetool. While useful on its own, 
it also served as an experiment in whether AI tools could be useful and
appropriate for mechanical code transformations that may not involve
copyrightable expression.

In this version, the types were added mostly with the RightTyper tool
(https://github.com/RightTyper/RightTyper), which uses profiling to detect
the types of arguments and return types at run time.  However, because
adding type annotations is such a narrow and verifiable task, I also developed
a parallel version using an LLM, to provide some data on topics such as:

- how much choice/creativity is there in writing type annotations?
  Is it closer to writing functional code or to refactoring?

- how does AI output for such mechanical transformations compare to other
  automated tools, whose output is known not to be copyrightable? 

- what is the kind of time saving that the tool can provide?

- how effective is an LLM for this task?  Is the required human help a
  pain to provide, or can the human keep the fun part for itself?

While the version submitted here does not use any LLM-generated content
in compliance with QEMU's policy, the first version was developed using
an LLM tool (Claude Code) with a very simple prompt:
    
      Add type annotations to tracetool.py and all .py files in
      tracetool/*.py.  Use new-style annotations, for example list[str]
      instead of typing.List[str].  When done, use mypy to find any
      issues.

The results were surprisingly good for such a simple-minded test, and
while there were some issues they turned out to be mostly due to dead
code that confused the LLM.  Thus, I removed the dead code (this is
already in qemu.git) and then did the actual experiment, running
both the RightTyper script (which is detailed in patch 4) and the LLM
in separate branches.  The remaining errors from the LLM were also
reasonably easy to fix, so I did that manually:

      tracetool/__init__.py:239: error: Need type annotation for "_args" (hint: "_args: list[<type>] = ...")  [var-annotated]
      tracetool/__init__.py:272: error: Argument 1 to "Arguments" has incompatible type "list[tuple[str, str]]"; expected "list[tuple[str, str] | Arguments]"  [arg-type]
      tracetool/__init__.py:579: error: Incompatible types in assignment (expression has type "str | None", variable has type "None")  [assignment]
      tracetool/__init__.py:580: error: Incompatible types in assignment (expression has type "str | None", variable has type "None")  [assignment]

After reviewing the changes, I followed up with another prompt for mechanical
changes:

      Change "backend: Any" to "backend: Wrapper" in all tracetool/format/ files

Honestly, I could have done this part in less time without any help; I
was just curious to see if the LLM would also remove the unused import.
Not only it didn't; this prompt didn't even touch most of the files so
I did the change, ran isort and called it a day.

Comparing the results from RightTyper and AI, both tools benefit from human
help: the dead code removal which I mentioned, the small cleanups in patch 1,
the final manual fixes for the remaining (mostly trivial) errors.  But at
least in this case, AI is a winner:

- it left basically no unannotated code: fixing the above errors was enough
  to pass "mypy --strict", unlike RightTyper which needed a little more work
  due to its profiling-based nature and a few other limitations (see patch 5).

- most importantly, trying various other tools that didn't work, as well as
  figuring out how to use RightTyper, took a couple hours more.  Surprising
  as it was, I could not find any static type inferencing tool for Python;
  neither pytype nor pyre worked for me.  This is also why I think this
  is not apples to oranges, but a fair comparison between AI-based and
  regular tooling.

I want to highlight "in this case".  I had other experiments where the
LLM's output was all but awful, and I wasted time debugging code that
I should have thrown away immediately!

After the diffstat, you can find a diff from this series to the version
based on Claude Code.  It's impossible to be 100% objective but,
besides being functionally equivalent, I don't think either would be
identifiable as written by an LLM, by a person, by a tool+human combo,
or even by a good type inferencing tool (if it existed).

Based on this experience, my answer to the copyrightability question is
that, for this kind of narrow request, the output of AI can be treated as
the output of an imperfect tool, rather than as creative content potentially
tainted by the training material.  Of course this is one data point and
is intended as an experiment rather than a policy recommendation.

Paolo



Paolo Bonzini (6):
  tracetool: rename variable with conflicting types
  tracetool: apply isort and add check
  tracetool: "import annotations"
  tracetool: add type annotations
  tracetool: complete typing annotations
  tracetool: add typing checks to "make -C python check"

 python/tests/tracetool-isort.sh              |  4 +
 python/tests/tracetool-mypy.sh               |  5 ++
 scripts/tracetool.py                         | 12 +--
 scripts/tracetool/__init__.py                | 84 ++++++++++----------
 scripts/tracetool/backend/__init__.py        | 21 ++---
 scripts/tracetool/backend/dtrace.py          | 19 ++---
 scripts/tracetool/backend/ftrace.py          | 13 +--
 scripts/tracetool/backend/log.py             | 13 +--
 scripts/tracetool/backend/simple.py          | 19 ++---
 scripts/tracetool/backend/syslog.py          | 13 +--
 scripts/tracetool/backend/ust.py             | 11 +--
 scripts/tracetool/format/__init__.py         |  9 ++-
 scripts/tracetool/format/c.py                |  7 +-
 scripts/tracetool/format/d.py                |  7 +-
 scripts/tracetool/format/h.py                |  7 +-
 scripts/tracetool/format/log_stap.py         | 12 +--
 scripts/tracetool/format/rs.py               |  7 +-
 scripts/tracetool/format/simpletrace_stap.py |  7 +-
 scripts/tracetool/format/stap.py             | 10 ++-
 scripts/tracetool/format/ust_events_c.py     |  7 +-
 scripts/tracetool/format/ust_events_h.py     |  7 +-
 21 files changed, 173 insertions(+), 121 deletions(-)
 create mode 100755 python/tests/tracetool-isort.sh
 create mode 100755 python/tests/tracetool-mypy.sh
-- 
2.51.0


diff --git a/scripts/tracetool.py b/scripts/tracetool.py
index 13c5583fa21..06c40aa71e7 100755
--- a/scripts/tracetool.py
+++ b/scripts/tracetool.py
@@ -16,7 +16,6 @@
 
 import getopt
 import sys
-from typing import NoReturn
 
 import tracetool.backend
 import tracetool.format
@@ -24,7 +24,7 @@
 
 _SCRIPT = ""
 
-def error_opt(msg: str | None = None) -> NoReturn:
+def error_opt(msg: str | None = None) -> None:
     if msg is not None:
         error_write("Error: " + msg + "\n")
 
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 58b7a289425..c9509b327f4 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -17,9 +17,8 @@
 import os
 import re
 import sys
-from io import TextIOWrapper
 from pathlib import PurePath
-from typing import Any, Iterator, Sequence
+from typing import Any, Iterator, Sequence, TextIO
 
 import tracetool.backend
 import tracetool.format
@@ -50,7 +50,7 @@ def error(*lines: str) -> None:
     'MAX': 'j',
 }
 
-def expand_format_string(c_fmt: str, prefix: str="") -> str:
+def expand_format_string(c_fmt: str, prefix: str = "") -> str:
     def pri_macro_to_fmt(pri_macro: str) -> str:
         assert pri_macro.startswith("PRI")
         fmt_type = pri_macro[3]  # 'd', 'i', 'u', or 'x'
@@ -469,13 +469,13 @@ def formats(self) -> list[str]:
     QEMU_BACKEND_DSTATE      = "TRACE_%(NAME)s_BACKEND_DSTATE"
     QEMU_EVENT               = "_TRACE_%(NAME)s_EVENT"
 
-    def api(self, fmt: str|None=None) -> str:
+    def api(self, fmt: str | None = None) -> str:
         if fmt is None:
             fmt = Event.QEMU_TRACE
         return fmt % {"name": self.name, "NAME": self.name.upper()}
 
 
-def read_events(fobj: TextIOWrapper, fname: str) -> list[Event]:
+def read_events(fobj: TextIO, fname: str) -> list[Event]:
     """Generate the output for the given (format, backends) pair.
 
     Parameters
@@ -514,7 +514,7 @@ class TracetoolError (Exception):
     pass
 
 
-def try_import(mod_name: str, attr_name: str | None=None, attr_default: Any=None) -> tuple[bool, Any]:
+def try_import(mod_name: str, attr_name: str | None = None, attr_default: Any = None) -> tuple[bool, Any]:
     """Try to import a module and get an attribute from it.
 
     Parameters
@@ -541,7 +541,7 @@ def try_import(mod_name: str, attr_name: str | None=None, attr_default: Any=None
 
 
 def generate(events: list[Event], group: str, format: str, backends: list[str],
-             binary: str|None=None, probe_prefix: str|None=None) -> None:
+             binary: str | None = None, probe_prefix: str | None = None) -> None:
     """Generate the output for the given (format, backends) pair.
 
     Parameters
@@ -581,7 +581,7 @@ def generate(events: list[Event], group: str, format: str, backends: list[str],
 
     tracetool.format.generate(events, format, backend, group)
 
-def posix_relpath(path: str, start: str|None=None) -> str:
+def posix_relpath(path: str, start: str | None = None) -> str:
     try:
         path = os.path.relpath(path, start)
     except ValueError:
diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index 84bab3f42a0..37654a133ce 100644
--- a/scripts/tracetool/backend/__init__.py
+++ b/scripts/tracetool/backend/__init__.py
@@ -122,7 +122,7 @@ def backend_modules(self) -> Iterator[Any]:
              if module is not None:
                  yield module
 
-    def _run_function(self, name: str, *args: Any, check_trace_event_get_state: bool | None=None, **kwargs: Any) -> None:
+    def _run_function(self, name: str, *args: Any, check_trace_event_get_state: bool | None = None, **kwargs: Any) -> None:
         for backend in self.backend_modules():
             func = getattr(backend, name % self._format, None)
             if func is not None and \
@@ -133,7 +133,7 @@ def _run_function(self, name: str, *args: Any, check_trace_event_get_state: bool
     def generate_begin(self, events: list[tracetool.Event], group: str) -> None:
         self._run_function("generate_%s_begin", events, group)
 
-    def generate(self, event: tracetool.Event, group: str, check_trace_event_get_state: bool | None=None) -> None:
+    def generate(self, event: tracetool.Event, group: str, check_trace_event_get_state: bool | None = None) -> None:
         self._run_function("generate_%s", event, group, check_trace_event_get_state=check_trace_event_get_state)
 
     def generate_backend_dstate(self, event: tracetool.Event, group: str) -> None:
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
index d9f4b8f09c8..e54847e96b6 100644
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -19,7 +19,7 @@
 PUBLIC = True
 
 
-PROBEPREFIX: str|None = None
+PROBEPREFIX: str | None = None
 
 def probeprefix() -> str:
     if PROBEPREFIX is None:
@@ -27,7 +29,7 @@ def probeprefix() -> str:
     return PROBEPREFIX
 
 
-BINARY: str|None = None
+BINARY: str | None = None
 
 def binary() -> str:
     if BINARY is None:
diff --git a/scripts/tracetool/format/__init__.py b/scripts/tracetool/format/__init__.py
index c287e93ed30..d4fc452b4ee 100644
--- a/scripts/tracetool/format/__init__.py
+++ b/scripts/tracetool/format/__init__.py
@@ -40,7 +40,7 @@
 import os
 
 import tracetool
-from tracetool.backend import Wrapper
+import tracetool.backend
 
 
 def get_list() -> list[tuple[str, str]]:
@@ -76,7 +76,7 @@ def exists(name: str) -> bool:
     return tracetool.try_import("tracetool.format." + name)[0]
 
 
-def generate(events: list[tracetool.Event], format: str, backend: Wrapper, group: str) -> None:
+def generate(events: list[tracetool.Event], format: str, backend: tracetool.backend.Wrapper, group: str) -> None:
     if not exists(format):
         raise ValueError("unknown format: %s" % format)
     format = format.replace("-", "_")
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index e8848c51051..2e02365444d 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -14,11 +14,11 @@
 __email__      = "stefanha@redhat.com"
 
 
+import tracetool.backend
 from tracetool import Event, out
-from tracetool.backend import Wrapper
 
 
-def generate(events: list[Event], backend: Wrapper, group: str) -> None:
+def generate(events: list[Event], backend: tracetool.backend.Wrapper, group: str) -> None:
     active_events = [e for e in events
                      if "disable" not in e.properties]
 
diff --git a/scripts/tracetool/format/d.py b/scripts/tracetool/format/d.py
index 2abf8bc24ba..bc9bc57e0b3 100644
--- a/scripts/tracetool/format/d.py
+++ b/scripts/tracetool/format/d.py
@@ -16,8 +16,8 @@
 
 from sys import platform
 
+import tracetool.backend
 from tracetool import Event, out
-from tracetool.backend import Wrapper
 
 # Reserved keywords from
 # https://wikis.oracle.com/display/DTrace/Types,+Operators+and+Expressions
@@ -32,7 +32,7 @@
 )
 
 
-def generate(events: list[Event], backend: Wrapper, group: str) -> None:
+def generate(events: list[Event], backend: tracetool.backend.Wrapper, group: str) -> None:
     events = [e for e in events
               if "disable" not in e.properties]
 
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index 2324234dd24..6d2d5cb4a9a 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -14,11 +14,11 @@
 __email__      = "stefanha@redhat.com"
 
 
+import tracetool.backend
 from tracetool import Event, out
-from tracetool.backend import Wrapper
 
 
-def generate(events: list[Event], backend: Wrapper, group: str) -> None:
+def generate(events: list[Event], backend: tracetool.backend.Wrapper, group: str) -> None:
     header = "trace/control.h"
 
     out('/* This file is autogenerated by tracetool, do not edit. */',
diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/format/log_stap.py
index 914e4674ffe..4223e2d9e2d 100644
--- a/scripts/tracetool/format/log_stap.py
+++ b/scripts/tracetool/format/log_stap.py
@@ -15,8 +15,8 @@
 
 import re
 
+import tracetool.backend
 from tracetool import Event, out
-from tracetool.backend import Wrapper
 from tracetool.backend.dtrace import binary, probeprefix
 from tracetool.backend.simple import is_string
 from tracetool.format.stap import stap_escape
@@ -86,7 +86,7 @@ def c_fmt_to_stap(fmt: str) -> str:
     fmt = re.sub(r"%(\d*)(l+|z)(x|u|d)", r"%\1\3", "".join(bits))
     return fmt
 
-def generate(events: list[Event], backend: Wrapper, group: str) -> None:
+def generate(events: list[Event], backend: tracetool.backend.Wrapper, group: str) -> None:
     out('/* This file is autogenerated by tracetool, do not edit. */',
         '/* SPDX-License-Identifier: GPL-2.0-or-later */',
         '')
diff --git a/scripts/tracetool/format/rs.py b/scripts/tracetool/format/rs.py
index 27a4025e3d6..08129d2d426 100644
--- a/scripts/tracetool/format/rs.py
+++ b/scripts/tracetool/format/rs.py
@@ -14,11 +14,11 @@
 __email__      = "stefanha@redhat.com"
 
 
+import tracetool.backend
 from tracetool import Event, out
-from tracetool.backend import Wrapper
 
 
-def generate(events: list[Event], backend: Wrapper, group: str) -> None:
+def generate(events: list[Event], backend: tracetool.backend.Wrapper, group: str) -> None:
     out('// SPDX-License-Identifier: GPL-2.0-or-later',
         '// This file is @generated by tracetool, do not edit.',
         '',
diff --git a/scripts/tracetool/format/simpletrace_stap.py b/scripts/tracetool/format/simpletrace_stap.py
index c76cf426853..b42bd3d6f02 100644
--- a/scripts/tracetool/format/simpletrace_stap.py
+++ b/scripts/tracetool/format/simpletrace_stap.py
@@ -14,14 +14,14 @@
 __email__      = "stefanha@redhat.com"
 
 
+import tracetool.backend
 from tracetool import Event, out
-from tracetool.backend import Wrapper
 from tracetool.backend.dtrace import probeprefix
 from tracetool.backend.simple import is_string
 from tracetool.format.stap import stap_escape
 
 
-def generate(events: list[Event], backend: Wrapper, group: str) -> None:
+def generate(events: list[Event], backend: tracetool.backend.Wrapper, group: str) -> None:
     out('/* This file is autogenerated by tracetool, do not edit. */',
         '/* SPDX-License-Identifier: GPL-2.0-or-later */',
         '')
diff --git a/scripts/tracetool/format/stap.py b/scripts/tracetool/format/stap.py
index af98f3c44a3..2c15c75f7c2 100644
--- a/scripts/tracetool/format/stap.py
+++ b/scripts/tracetool/format/stap.py
@@ -14,8 +14,8 @@
 __email__      = "stefanha@redhat.com"
 
 
+import tracetool.backend
 from tracetool import Event, out
-from tracetool.backend import Wrapper
 from tracetool.backend.dtrace import binary, probeprefix
 
 # Technically 'self' is not used by systemtap yet, but
@@ -35,7 +35,7 @@ def stap_escape(identifier: str) -> str:
     return identifier
 
 
-def generate(events: list[Event], backend: Wrapper, group: str) -> None:
+def generate(events: list[Event], backend: tracetool.backend.Wrapper, group: str) -> None:
     events = [e for e in events
               if "disable" not in e.properties]
 
diff --git a/scripts/tracetool/format/ust_events_c.py b/scripts/tracetool/format/ust_events_c.py
index 2c8256ed7a8..634dd9a7115 100644
--- a/scripts/tracetool/format/ust_events_c.py
+++ b/scripts/tracetool/format/ust_events_c.py
@@ -14,11 +14,11 @@
 __email__      = "stefanha@redhat.com"
 
 
+import tracetool.backend
 from tracetool import Event, out
-from tracetool.backend import Wrapper
 
 
-def generate(events: list[Event], backend: Wrapper, group: str) -> None:
+def generate(events: list[Event], backend: tracetool.backend.Wrapper, group: str) -> None:
     events = [e for e in events
               if "disabled" not in e.properties]
 
diff --git a/scripts/tracetool/format/ust_events_h.py b/scripts/tracetool/format/ust_events_h.py
index f0ffcae6941..098c28c7e7a 100644
--- a/scripts/tracetool/format/ust_events_h.py
+++ b/scripts/tracetool/format/ust_events_h.py
@@ -14,11 +14,11 @@
 __email__      = "stefanha@redhat.com"
 
 
+import tracetool.backend
 from tracetool import Event, out
-from tracetool.backend import Wrapper
 
 
-def generate(events: list[Event], backend: Wrapper, group: str) -> None:
+def generate(events: list[Event], backend: tracetool.backend.Wrapper, group: str) -> None:
     events = [e for e in events
               if "disabled" not in e.properties]
 


