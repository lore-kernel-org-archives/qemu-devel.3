Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B21C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 09:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbd3g-0005PO-Hd; Wed, 07 Aug 2024 05:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbd3e-0005Os-Vj
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 05:34:15 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbd3c-0000Y8-RS
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 05:34:14 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5b3fff87e6bso1940938a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 02:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723023249; x=1723628049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zRNRhLaRdR9xHIJalWIpxS96jcroaoR0FxmZ5ndovgY=;
 b=pSsgpZDLE6g9ikfNDclW8iHYQcU/WblnplcnLs8tVruTxov1Uj9IyfyRUik6CsguKP
 t0MAf2cSyYaQ0kBVmWIkwJTRev5Z2cQP46fJG68uNzZ44ONAjntAmRB3tvvpVqPaeuXI
 BKQRjgC8/uJWd2cAOgcqY1Ps+PodwK7/g86HKVLmDZin1UANrQYmiQHWu45dZal8M8h8
 VOfPCauhy+ERXfC3UqLWfV+UKIQbztxxrRL4mWxkn3MZL8OWQyTZnIhO+72gq0rDv1Jt
 VlUCPhekHVnx89kM4gmgVnosjf+SHYW/Q+U/kgv5hi0XJ6fWxxwDXcFgO10sbacN2tV1
 4fDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723023249; x=1723628049;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zRNRhLaRdR9xHIJalWIpxS96jcroaoR0FxmZ5ndovgY=;
 b=FeV/TtrocfvPLzLgRJvBH2KTeMMQ9GsQu5F+JMZ51qk+4xWc3XPc8AoAZhjE4/xVL6
 3+Zj9bYpZnr2VsU+FUB5IOtirWHILxTzWT3g5VaDjEeu2TE2MGa4iKQ1A2QlpXPNfDD2
 UmaU+8Io90XtE7q2YP3PYVSroqVuxjJLfk+X2owCBgNzFHUfYmA42UpoM4yvBB69ahUJ
 ibaUb0GA2xOJXANePAvBdvDn7Wd6xy1dHcmrzzahgMKjFrddXjgOqa6HvYCgYWG/xCNX
 TV3CwjsO1JNbBVz4qYqjA9hG6ihPevONp23l7baOsMbUdqh9/U2sr3pwYu8JrnzhtGHy
 Ih1Q==
X-Gm-Message-State: AOJu0YyrnZ184zlNZ68z3jYt+/6Rcp8UbJVFC8JSkyWqQLA1l4WIxyqe
 QUV7dKa+Ua9ixyJg2BJkOuC36Bw4n/5sDDUI9hf553RsVmfcTqs8DfKvP9x+yS8M6D08j27raOh
 l
X-Google-Smtp-Source: AGHT+IGo9pemnwZy8Lp7mASB43K7L73NOb2UycOFP/3Y2TmIEvR6TbgiSpGbGhA43+vaTCVDE4uprw==
X-Received: by 2002:a05:6402:457:b0:59e:686b:1874 with SMTP id
 4fb4d7f45d1cf-5b7f36f5040mr13032880a12.6.1723023249461; 
 Wed, 07 Aug 2024 02:34:09 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b839708c56sm6873934a12.2.2024.08.07.02.34.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 02:34:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] qapi: Generate QAPI files using qapi/ for generated
 header paths
Date: Wed,  7 Aug 2024 11:34:06 +0200
Message-ID: <20240807093406.40360-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

QAPI script generates headers under the qapi/ directory,
so use this prefix in generated header paths, keeping
all QAPI under the qapi/ namespace.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Ideally I'd also remove "CPPFLAGS+=-I qapi" in this patch
but I couldn't figure out where meson adds it...
---
 scripts/qapi/commands.py   | 10 +++++-----
 scripts/qapi/events.py     | 10 +++++-----
 scripts/qapi/gen.py        |  2 +-
 scripts/qapi/introspect.py |  2 +-
 scripts/qapi/types.py      |  4 ++--
 scripts/qapi/visit.py      |  4 ++--
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 79951a841f..07fbd21334 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -323,8 +323,8 @@ def _begin_user_module(self, name: str) -> None:
 #include "qapi/qmp/qdict.h"
 #include "qapi/dealloc-visitor.h"
 #include "qapi/error.h"
-#include "%(visit)s.h"
-#include "%(commands)s.h"
+#include "qapi/%(visit)s.h"
+#include "qapi/%(commands)s.h"
 ''',
                              commands=commands, visit=visit))
 
@@ -338,7 +338,7 @@ def _begin_user_module(self, name: str) -> None:
             # match .underscorify() in trace/meson.build
 
         self._genh.add(mcgen('''
-#include "%(types)s.h"
+#include "qapi/%(types)s.h"
 
 ''',
                              types=types))
@@ -353,8 +353,8 @@ def visit_begin(self, schema: QAPISchema) -> None:
                              c_prefix=c_name(self._prefix, protect=False)))
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
-#include "%(prefix)sqapi-commands.h"
-#include "%(prefix)sqapi-init-commands.h"
+#include "qapi/%(prefix)sqapi-commands.h"
+#include "qapi/%(prefix)sqapi-init-commands.h"
 
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)
 {
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index d1f639981a..f3803c8afe 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -189,9 +189,9 @@ def _begin_user_module(self, name: str) -> None:
         visit = self._module_basename('qapi-visit', name)
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
-#include "%(prefix)sqapi-emit-events.h"
-#include "%(events)s.h"
-#include "%(visit)s.h"
+#include "qapi/%(prefix)sqapi-emit-events.h"
+#include "qapi/%(events)s.h"
+#include "qapi/%(visit)s.h"
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
@@ -201,7 +201,7 @@ def _begin_user_module(self, name: str) -> None:
                              prefix=self._prefix))
         self._genh.add(mcgen('''
 #include "qapi/util.h"
-#include "%(types)s.h"
+#include "qapi/%(types)s.h"
 ''',
                              types=types))
 
@@ -209,7 +209,7 @@ def visit_end(self) -> None:
         self._add_module('./emit', ' * QAPI Events emission')
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
-#include "%(prefix)sqapi-emit-events.h"
+#include "qapi/%(prefix)sqapi-emit-events.h"
 ''',
                                       prefix=self._prefix))
         self._genh.preamble_add(mcgen('''
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 6a8abe0041..d24bd7ba08 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -363,6 +363,6 @@ def visit_include(self, name: str, info: Optional[QAPISourceInfo]) -> None:
         relname = os.path.relpath(self._module_filename(self._what, name),
                                   os.path.dirname(self._genh.fname))
         self._genh.preamble_add(mcgen('''
-#include "%(relname)s.h"
+#include "qapi/%(relname)s.h"
 ''',
                                       relname=relname))
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index ac14b20f30..7b74db11ed 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -182,7 +182,7 @@ def __init__(self, prefix: str, unmask: bool):
         self._name_map: Dict[str, str] = {}
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
-#include "%(prefix)sqapi-introspect.h"
+#include "qapi/%(prefix)sqapi-introspect.h"
 
 ''',
                              prefix=prefix))
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 0dd0b00ada..19c8c9c18c 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -306,8 +306,8 @@ def _begin_user_module(self, name: str) -> None:
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/dealloc-visitor.h"
-#include "%(types)s.h"
-#include "%(visit)s.h"
+#include "qapi/%(types)s.h"
+#include "qapi/%(visit)s.h"
 ''',
                                       types=types, visit=visit))
         self._genh.preamble_add(mcgen('''
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 12f92e429f..06d89504ce 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -359,12 +359,12 @@ def _begin_user_module(self, name: str) -> None:
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "%(visit)s.h"
+#include "qapi/%(visit)s.h"
 ''',
                                       visit=visit))
         self._genh.preamble_add(mcgen('''
 #include "qapi/qapi-builtin-visit.h"
-#include "%(types)s.h"
+#include "qapi/%(types)s.h"
 
 ''',
                                       types=types))
-- 
2.45.2


