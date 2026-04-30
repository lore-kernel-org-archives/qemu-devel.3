Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD632FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINLe-0008Ku-J0; Thu, 30 Apr 2026 05:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLT-00082M-Mg
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLQ-0003AB-V6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777539964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVORDiAtsyF67SvxbxKKHAquX3JZKNCa8iS/ZxVnKeU=;
 b=ivY3ZPGmpIqK+V8H46xTcMz2jOrUDf7gd8QM+MFpdNhJrz2XSdAnyAxTD4qMgOfqKXXHC0
 SOVAJZx++sqPrfRgRidDosw+FsYKGU8vCt7jiO1YH40FE4oW/3byEV4o0a3B1X/qQbnDZ4
 M9z0gxOtGAXV1tRq5wrEHi4Baq3TK04=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-lk1blbmePDOfUZa2tdNuHw-1; Thu, 30 Apr 2026 05:06:02 -0400
X-MC-Unique: lk1blbmePDOfUZa2tdNuHw-1
X-Mimecast-MFC-AGG-ID: lk1blbmePDOfUZa2tdNuHw_1777539961
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43d121c4271so464108f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777539960; x=1778144760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LVORDiAtsyF67SvxbxKKHAquX3JZKNCa8iS/ZxVnKeU=;
 b=i8YQhOYpMXMKA1lpkkv8W8uQTs1wJtoUmvLQGJGPKK35p4YfDEvxQ4sgdlBEn0ys3C
 X2vnk71lPuavk3LuKmhbCjF3oek/C5e5z45AMxz7Dufm33Jqm8afzA2SW1SVQutCAzVR
 arWJG3jsBADtpJ3AcVyt/+rEqOId20onsq2neVG3RNJcui1mCxtjb3Zv0t+7CCBzvkxq
 d7+CkSsu/wbQ+Nf+xxmuDz0jewqmgViwvvrCmXnJjFq0X3uIID96EPV17QONsovdtnNc
 uvGruK31vjfm2TonV+G1qCR0GB/v2nNYKdExzXxkKEAtrAxeNydHGEdzBa1NHFI9k3Xe
 B6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777539960; x=1778144760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LVORDiAtsyF67SvxbxKKHAquX3JZKNCa8iS/ZxVnKeU=;
 b=hDOtdlrl2Nw6SO3ou/H/hWuj9AHURMTesmvncV1hGt9O41wO2fO+oidyEOpPCRCuE8
 Zj9vopdZWRF/HVBs44PSoPfStISV+BMqfcSGljewEY7tKJD1yNFrd9wkM40F9wVDGJPA
 8CkuTW/EWUYn7vV489RGrnOru7p7U0nzX/s2mZddjbhNZ5jFU+XyvuzFuchTw0B56Xvp
 lFROSV6lneAfzx2fr/fQ5S9UvnPnOQ7AXLf/SlVCZoEUiLmlYEzG1ICOz4vJXGITekwE
 BowWNSNua38vtMbb5l5koRyEn/THK60MXl0ziadziXgyu1KvzsZql32MgPEcB1mazTFv
 IuAA==
X-Gm-Message-State: AOJu0Yx3TNzC0JdI8qKqrY2/af+YuEPGFh8F3bABpYAlyhl1jH7H8Giw
 Rl25wZ5d223guiA9/p6+lB+JJ9Mu3QKlI2QKUJI1HiQObp90yzulxZ8BywRJYa+Ran1EW6f0QG4
 kbzQM/++JLeepQUPMV+mk3cGFRZVdOTzbme8Mf2hv8REJ3h+3ZxMIP8wYyaoPw2ztEvbmhpiaEW
 gHBi1Qu2q7gUdw+2s1yTw06ZSRynLhvMfES3yESl4H
X-Gm-Gg: AeBDieuJ7zHHoV3rEp89Y6REW1hnz5/dVSmULzp8uGWej+1oiq5+2UDdcO3aa3rvIhK
 YH8VPTlh2IjZuZ/mzRVx7AfVq3JnwJiCOTCPHf5XfK+mvOqONtz0+hXQgahIFXIfX88C6NG1Mkh
 ZE3LAHQ+WpfaQEkbhWG3MEi9ZqxiBXqwtXrjGWwgatPsiALmtciz8vhnjQBihK9TAF4ljJKOO08
 EP0AcGltr8TADNYbqtFxHNtkrTy2oWkcFTwIxCtmVqk2shIk27G+FjJwNMi2Slqzg9Lzy4+yyIT
 KsR7rfh8IyBm0VtPNJ4xdIThwo9GUu2lSgmLyppY5sbcz39G2O7dkbjfzDeH4kw/Ug9WcVp1+PH
 fvvth0gBGymxHKJ7wluj7H3NkAwAegnX8TyBaLJb78K7xek4N8T7JqMEU+nBxh3udHOfjM5SETH
 IF8oiWebTjuridMiGIv5Urhy87RrJWztNVfMM=
X-Received: by 2002:a5d:588b:0:b0:43f:e7c9:2402 with SMTP id
 ffacd0b85a97d-4493dbdbc78mr3258713f8f.3.1777539959858; 
 Thu, 30 Apr 2026 02:05:59 -0700 (PDT)
X-Received: by 2002:a5d:588b:0:b0:43f:e7c9:2402 with SMTP id
 ffacd0b85a97d-4493dbdbc78mr3258584f8f.3.1777539958650; 
 Thu, 30 Apr 2026 02:05:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7217c56sm11675508f8f.20.2026.04.30.02.05.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:05:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/13] minikconf: add mypy annotations
Date: Thu, 30 Apr 2026 11:05:34 +0200
Message-ID: <20260430090534.841894-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430090534.841894-1-pbonzini@redhat.com>
References: <20260430090534.841894-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/tests/linters.py |   3 +
 scripts/minikconf.py    | 222 ++++++++++++++++++++++------------------
 2 files changed, 124 insertions(+), 101 deletions(-)

diff --git a/python/tests/linters.py b/python/tests/linters.py
index 4ce4e8a9805..82b88aebb20 100644
--- a/python/tests/linters.py
+++ b/python/tests/linters.py
@@ -65,6 +65,9 @@ def test_isort_qapi_sphinx(self):
             ]
         )
 
+    def test_mypy_minikconf(self):
+        check_call([sys.executable, "-m", "mypy", "../scripts/minikconf.py"])
+
     def test_mypy_pkg(self):
         check_call([sys.executable, "-m", "mypy", "-p", "qemu"])
 
diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 7a2fe865484..6d7dbbf2ccd 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -11,35 +11,40 @@
 # or, at your option, any later version.  See the COPYING file in
 # the top-level directory.
 
+from __future__ import annotations
+
 import os
 import random
 import re
 import sys
+import typing as T
 from dataclasses import dataclass
 
 __all__ = [ 'KconfigDataError', 'KconfigParserError',
             'KconfigData', 'KconfigParser' ,
             'defconfig', 'allyesconfig', 'allnoconfig', 'randconfig' ]
 
+Mangler = T.Callable[[bool], bool]
+
 @dataclass
 class IncludeInfo:
     file: str
     line: int
     parent: IncludeInfo | None
 
-    def __iter__(self):
-        inf = self
+    def __iter__(self) -> T.Iterator[str]:
+        inf: IncludeInfo | None = self
         while inf is not None:
             yield "%s:%d" % (inf.file, inf.line)
             inf = inf.parent
 
-    def error_path(self):
+    def error_path(self) -> str:
         res = ""
         for loc in self:
             res = "In file included from %s:\n" % loc + res
         return res
 
-def debug_print(*args):
+def debug_print(*args: object) -> None:
     #print('# ' + (' '.join(str(x) for x in args)))
     pass
 
@@ -54,81 +59,81 @@ def debug_print(*args):
 # -------------------------------------------
 
 class KconfigDataError(Exception):
-    def __init__(self, msg):
+    def __init__(self, msg: str) -> None:
         self.msg = msg
 
-    def __str__(self):
+    def __str__(self) -> str:
         return self.msg
 
-allyesconfig = lambda x: True
-allnoconfig = lambda x: False
-defconfig = lambda x: x
-randconfig = lambda x: random.randint(0, 1) == 1
+allyesconfig: Mangler = lambda x: True
+allnoconfig: Mangler = lambda x: False
+defconfig: Mangler = lambda x: x
+randconfig: Mangler = lambda x: random.randint(0, 1) == 1
 
 class KconfigData:
     class Expr:
-        def __and__(self, rhs):
+        def __and__(self, rhs: KconfigData.Expr) -> KconfigData.Expr:
             return KconfigData.AND(self, rhs)
-        def __or__(self, rhs):
+        def __or__(self, rhs: KconfigData.Expr) -> KconfigData.Expr:
             return KconfigData.OR(self, rhs)
-        def __invert__(self):
+        def __invert__(self) -> KconfigData.Expr:
             return KconfigData.NOT(self)
 
         # Abstract methods
-        def add_edges_to(self, var):
+        def add_edges_to(self, var: KconfigData.Var) -> None:
             pass
-        def evaluate(self):
+        def evaluate(self) -> bool:
             assert False
 
     class AND(Expr):
-        def __init__(self, lhs, rhs):
+        def __init__(self, lhs: KconfigData.Expr, rhs: KconfigData.Expr) -> None:
             self.lhs = lhs
             self.rhs = rhs
-        def __str__(self):
+        def __str__(self) -> str:
             return "(%s && %s)" % (self.lhs, self.rhs)
 
-        def add_edges_to(self, var):
+        def add_edges_to(self, var: KconfigData.Var) -> None:
             self.lhs.add_edges_to(var)
             self.rhs.add_edges_to(var)
-        def evaluate(self):
+        def evaluate(self) -> bool:
             return self.lhs.evaluate() and self.rhs.evaluate()
 
     class OR(Expr):
-        def __init__(self, lhs, rhs):
+        def __init__(self, lhs: KconfigData.Expr, rhs: KconfigData.Expr) -> None:
             self.lhs = lhs
             self.rhs = rhs
-        def __str__(self):
+        def __str__(self) -> str:
             return "(%s || %s)" % (self.lhs, self.rhs)
 
-        def add_edges_to(self, var):
+        def add_edges_to(self, var: KconfigData.Var) -> None:
             self.lhs.add_edges_to(var)
             self.rhs.add_edges_to(var)
-        def evaluate(self):
+        def evaluate(self) -> bool:
             return self.lhs.evaluate() or self.rhs.evaluate()
 
     class NOT(Expr):
-        def __init__(self, lhs):
+        def __init__(self, lhs: KconfigData.Expr) -> None:
             self.lhs = lhs
-        def __str__(self):
+        def __str__(self) -> str:
             return "!%s" % (self.lhs)
 
-        def add_edges_to(self, var):
+        def add_edges_to(self, var: KconfigData.Var) -> None:
             self.lhs.add_edges_to(var)
-        def evaluate(self):
+        def evaluate(self) -> bool:
             return not self.lhs.evaluate()
 
     class Var(Expr):
-        def __init__(self, name):
+        def __init__(self, name: str) -> None:
             self.name = name
-            self.value = None
-            self.outgoing = set()
-            self.clauses_for_var = list()
-        def __str__(self):
+            self.value: bool | None = None
+            self.outgoing: set[KconfigData.Var] = set()
+            self.clauses_for_var: list[KconfigData.Clause] = []
+        def __str__(self) -> str:
             return self.name
 
-        def has_value(self):
+        def has_value(self) -> bool:
             return self.value is not None
-        def set_value(self, val, clause):
+        def set_value(self, val: bool, clause: KconfigData.Clause) -> None:
             self.clauses_for_var.append(clause)
             if self.has_value() and self.value != val:
                 print("The following clauses were found for " + self.name, file=sys.stderr)
@@ -139,7 +144,8 @@ def set_value(self, val, clause):
             self.value = val
 
         # depth first search of the dependency graph
-        def dfs(self, visited, f):
+        def dfs(self, visited: set[KconfigData.Var],
+                f: T.Callable[[KconfigData.Var], None]) -> None:
             if self in visited:
                 return
             visited.add(self)
@@ -147,87 +153,89 @@ def dfs(self, visited, f):
                 v.dfs(visited, f)
             f(self)
 
-        def add_edges_to(self, var):
+        def add_edges_to(self, var: KconfigData.Var) -> None:
             self.outgoing.add(var)
-        def evaluate(self):
+        def evaluate(self) -> bool:
             if not self.has_value():
                 raise KconfigDataError('cycle found including %s' % self)
+            assert self.value is not None
             return self.value
 
     class Clause:
-        def __init__(self, dest):
+        def __init__(self, dest: KconfigData.Var) -> None:
             self.dest = dest
-        def priority(self):
+        def priority(self) -> int:
             return 0
-        def process(self):
+        def process(self) -> None:
             pass
 
     class AssignmentClause(Clause):
-        def __init__(self, dest, value):
+        def __init__(self, dest: KconfigData.Var, value: bool) -> None:
             KconfigData.Clause.__init__(self, dest)
             self.value = value
-        def __str__(self):
+        def __str__(self) -> str:
             return "CONFIG_%s=%s" % (self.dest, 'y' if self.value else 'n')
 
-        def process(self):
+        def process(self) -> None:
             self.dest.set_value(self.value, self)
 
     class DefaultClause(Clause):
-        def __init__(self, dest, value, cond=None):
+        def __init__(self, dest: KconfigData.Var, value: bool,
+                     cond: KconfigData.Expr | None = None) -> None:
             KconfigData.Clause.__init__(self, dest)
             self.value = value
             self.cond = cond
             if self.cond is not None:
                 self.cond.add_edges_to(self.dest)
-        def __str__(self):
+        def __str__(self) -> str:
             value = 'y' if self.value else 'n'
             if self.cond is None:
                 return "config %s default %s" % (self.dest, value)
             else:
                 return "config %s default %s if %s" % (self.dest, value, self.cond)
 
-        def priority(self):
+        def priority(self) -> int:
             # Defaults are processed just before leaving the variable
             return -1
-        def process(self):
+        def process(self) -> None:
             if not self.dest.has_value() and \
                     (self.cond is None or self.cond.evaluate()):
                 self.dest.set_value(self.value, self)
 
     class DependsOnClause(Clause):
-        def __init__(self, dest, expr):
+        def __init__(self, dest: KconfigData.Var, expr: KconfigData.Expr) -> None:
             KconfigData.Clause.__init__(self, dest)
             self.expr = expr
             self.expr.add_edges_to(self.dest)
-        def __str__(self):
+        def __str__(self) -> str:
             return "config %s depends on %s" % (self.dest, self.expr)
 
-        def process(self):
+        def process(self) -> None:
             if not self.expr.evaluate():
                 self.dest.set_value(False, self)
 
     class SelectClause(Clause):
-        def __init__(self, dest, cond):
+        def __init__(self, dest: KconfigData.Var, cond: KconfigData.Expr) -> None:
             KconfigData.Clause.__init__(self, dest)
             self.cond = cond
             self.cond.add_edges_to(self.dest)
-        def __str__(self):
+        def __str__(self) -> str:
             return "select %s if %s" % (self.dest, self.cond)
 
-        def process(self):
+        def process(self) -> None:
             if self.cond.evaluate():
                 self.dest.set_value(True, self)
 
-    def __init__(self, value_mangler=defconfig):
+    def __init__(self, value_mangler: Mangler = defconfig) -> None:
         self.value_mangler = value_mangler
-        self.previously_included = []
-        self.defined_vars = set()
-        self.referenced_vars = dict()
-        self.clauses = list()
+        self.previously_included: list[str] = []
+        self.defined_vars: set[str] = set()
+        self.referenced_vars: dict[str, KconfigData.Var] = {}
+        self.clauses: list[KconfigData.Clause] = []
 
     # semantic analysis -------------
 
-    def check_undefined(self):
+    def check_undefined(self) -> bool:
         undef = False
         for i in self.referenced_vars:
             if i not in self.defined_vars:
@@ -235,7 +243,7 @@ def check_undefined(self):
                 undef = True
         return undef
 
-    def compute_config(self):
+    def compute_config(self) -> dict[str, bool]:
         if self.check_undefined():
             raise KconfigDataError("there were undefined symbols")
 
@@ -248,10 +256,10 @@ def compute_config(self):
             debug_print(source, "->", [str(x) for x in edges.outgoing])
 
         # The reverse of the depth-first order is the topological sort
-        dfo = dict()
-        visited = set()
+        dfo: dict[KconfigData.Var, int] = {}
+        visited: set[KconfigData.Var] = set()
         debug_print("\n")
-        def visit_fn(var):
+        def visit_fn(var: KconfigData.Var) -> None:
             debug_print(var, "has DFS number", len(dfo))
             dfo[var] = len(dfo)
 
@@ -270,7 +278,7 @@ def visit_fn(var):
             clause.process()
 
         debug_print("")
-        values = dict()
+        values: dict[str, bool] = {}
         for name, v in self.referenced_vars.items():
             debug_print("Evaluating", name)
             values[name] = v.evaluate()
@@ -279,39 +287,42 @@ def visit_fn(var):
 
     # semantic actions -------------
 
-    def do_declaration(self, var):
+    def do_declaration(self, var: KconfigData.Var) -> None:
         if var.name in self.defined_vars:
             raise KconfigDataError('variable "%s" defined twice' % var.name)
-
         self.defined_vars.add(var.name)
 
     # var is a string with the variable's name.
-    def do_var(self, var):
+    def do_var(self, var: str) -> KconfigData.Var:
         if var in self.referenced_vars:
             return self.referenced_vars[var]
 
         var_obj = self.referenced_vars[var] = KconfigData.Var(var)
         return var_obj
 
-    def do_assignment(self, var, val):
+    def do_assignment(self, var: KconfigData.Var, val: bool) -> None:
         self.clauses.append(KconfigData.AssignmentClause(var, val))
 
-    def do_cmdline_assignment(self, var, val):
+    def do_cmdline_assignment(self, var: str, val: bool) -> None:
         assert var.startswith("CONFIG_")
         self.do_assignment(self.do_var(var[7:]), val)
 
-    def do_default(self, var, val, cond=None):
+    def do_default(self, var: KconfigData.Var, val: bool,
+                   cond: KconfigData.Expr | None = None) -> None:
         val = self.value_mangler(val)
         self.clauses.append(KconfigData.DefaultClause(var, val, cond))
 
-    def do_depends_on(self, var, expr):
+    def do_depends_on(self, var: KconfigData.Var,
+                      expr: KconfigData.Expr) -> None:
         self.clauses.append(KconfigData.DependsOnClause(var, expr))
 
-    def do_select(self, var, symbol, cond=None):
+    def do_select(self, var: KconfigData.Var, symbol: KconfigData.Var,
+                  cond: KconfigData.Expr | None = None) -> None:
         cond = (cond & var) if cond is not None else var
         self.clauses.append(KconfigData.SelectClause(symbol, cond))
 
-    def do_imply(self, var, symbol, cond=None):
+    def do_imply(self, var: KconfigData.Var, symbol: KconfigData.Var,
+                 cond: KconfigData.Expr | None = None) -> None:
         # "config X imply Y [if COND]" is the same as
         # "config Y default y if X [&& COND]"
         cond = (cond & var) if cond is not None else var
@@ -323,7 +334,7 @@ def do_imply(self, var, symbol, cond=None):
 # -------------------------------------------
 
 # tokens table
-TOKENS = {}
+TOKENS: dict[int, str] = {}
 TOK_NONE = -1
 TOK_LPAREN = 0;   TOKENS[TOK_LPAREN] = '"("'
 TOK_RPAREN = 1;   TOKENS[TOK_RPAREN] = '")"'
@@ -346,7 +357,8 @@ def do_imply(self, var, symbol, cond=None):
 TOK_EOF = 18;     TOKENS[TOK_EOF] = 'end of file'
 
 class KconfigParserError(Exception):
-    def __init__(self, parser, msg, tok=None):
+    def __init__(self, parser: KconfigParser, msg: str,
+                 tok: int | str | None = None) -> None:
         self.loc = parser.location()
         tok = tok if tok is not None else parser.tok
         if tok != TOK_NONE:
@@ -354,33 +366,37 @@ def __init__(self, parser, msg, tok=None):
             msg = '%s before %s' % (msg, location)
         self.msg = msg
 
-    def __str__(self):
+    def __str__(self) -> str:
         return "%s: %s" % (self.loc, self.msg)
 
 class KconfigParser:
 
     @classmethod
-    def parse(cls, fp, data, incl_info=None):
+    def parse(cls, fp: T.TextIO, data: KconfigData, incl_info: IncludeInfo | None = None) -> None:
         cls(fp, data, incl_info).parse_config()
 
-    def __init__(self, fp, data, incl_info):
+    def __init__(self, fp: T.TextIO, data: KconfigData, incl_info: IncludeInfo | None = None):
         self.data = data
         self.incl_info = incl_info
         self.abs_fname = os.path.abspath(fp.name)
         self.fname = fp.name
         self.data.previously_included.append(self.abs_fname)
+
         src = fp.read()
         if src == '' or src[-1] != '\n':
             src += '\n'
         self.src = src
-        self.cursor = 0
-        self.line = 1
-        self.line_pos = 0
+        self.cursor: int = 0
+        self.line: int = 1
+        self.line_pos: int = 0
+        self.pos: int = 0
+        self.tok: int = TOK_NONE
+        self.val: str | None = None
         self.get_token()
 
     # file management -----
 
-    def location(self):
+    def location(self) -> str:
         col = 1
         for ch in self.src[self.line_pos:self.pos]:
             if ch == '\t':
@@ -391,7 +407,7 @@ def location(self):
         incl_chain = inf.error_path() if inf is not None else ""
         return '%s%s:%d:%d' % (incl_chain, self.fname, self.line, col)
 
-    def do_include(self, include):
+    def do_include(self, include: str) -> None:
         incl_abs_fname = os.path.join(os.path.dirname(self.abs_fname),
                                       include)
         # catch inclusion cycle
@@ -419,7 +435,7 @@ def do_include(self, include):
     # recursive descent parser -----
 
     # y_or_n: Y | N
-    def parse_y_or_n(self):
+    def parse_y_or_n(self) -> bool:
         if self.tok == TOK_Y:
             self.get_token()
             return True
@@ -429,7 +445,7 @@ def parse_y_or_n(self):
         raise KconfigParserError(self, 'Expected "y" or "n"')
 
     # var: ID
-    def parse_var(self):
+    def parse_var(self) -> KconfigData.Var:
         if self.tok != TOK_ID:
             raise KconfigParserError(self, 'Expected identifier')
         val = self.val
@@ -438,7 +454,7 @@ def parse_var(self):
         return self.data.do_var(val)
 
     # assignment_var: ID (starting with "CONFIG_")
-    def parse_assignment_var(self):
+    def parse_assignment_var(self) -> KconfigData.Var:
         if self.tok != TOK_ID:
             raise KconfigParserError(self, 'Expected identifier')
         val = self.val
@@ -450,7 +466,7 @@ def parse_assignment_var(self):
         return self.data.do_var(val[7:])
 
     # assignment: var EQUAL y_or_n
-    def parse_assignment(self):
+    def parse_assignment(self) -> None:
         var = self.parse_assignment_var()
         if self.tok != TOK_EQUAL:
             raise KconfigParserError(self, 'Expected "="')
@@ -460,7 +476,7 @@ def parse_assignment(self):
     # primary: NOT primary
     #       | LPAREN expr RPAREN
     #       | var
-    def parse_primary(self):
+    def parse_primary(self) -> KconfigData.Expr:
         if self.tok == TOK_NOT:
             self.get_token()
             val = ~self.parse_primary()
@@ -477,7 +493,7 @@ def parse_primary(self):
         return val
 
     # disj: primary (OR primary)*
-    def parse_disj(self):
+    def parse_disj(self) -> KconfigData.Expr:
         lhs = self.parse_primary()
         while self.tok == TOK_OR:
             self.get_token()
@@ -485,7 +501,7 @@ def parse_disj(self):
         return lhs
 
     # expr: disj (AND disj)*
-    def parse_expr(self):
+    def parse_expr(self) -> KconfigData.Expr:
         lhs = self.parse_disj()
         while self.tok == TOK_AND:
             self.get_token()
@@ -494,7 +510,7 @@ def parse_expr(self):
 
     # condition: IF expr
     #       | empty
-    def parse_condition(self):
+    def parse_condition(self) -> KconfigData.Expr | None:
         if self.tok != TOK_IF:
             return None
         self.get_token()
@@ -504,7 +520,7 @@ def parse_condition(self):
     #       | DEPENDS ON expr
     #       | SELECT var condition
     #       | BOOL
-    def parse_property(self, var):
+    def parse_property(self, var: KconfigData.Var) -> None:
         if self.tok == TOK_DEFAULT:
             self.get_token()
             val = self.parse_y_or_n()
@@ -533,7 +549,7 @@ def parse_property(self, var):
 
     # properties: properties property
     #       | /* empty */
-    def parse_properties(self, var):
+    def parse_properties(self, var: KconfigData.Var) -> None:
         while self.tok == TOK_DEFAULT or self.tok == TOK_DEPENDS or \
               self.tok == TOK_SELECT or self.tok == TOK_BOOL or \
               self.tok == TOK_IMPLY:
@@ -546,7 +562,7 @@ def parse_properties(self, var):
                     + '"default", "depends on", "imply" or "select"')
 
     # declaration: config var properties
-    def parse_declaration(self):
+    def parse_declaration(self) -> None:
         if self.tok == TOK_CONFIG:
             self.get_token()
             var = self.parse_var()
@@ -558,9 +574,10 @@ def parse_declaration(self):
     # clause: SOURCE
     #       | declaration
     #       | assignment
-    def parse_clause(self):
+    def parse_clause(self) -> None:
         if self.tok == TOK_SOURCE:
             val = self.val
+            assert val is not None
             self.get_token()
             self.do_include(val)
         elif self.tok == TOK_CONFIG:
@@ -571,14 +588,15 @@ def parse_clause(self):
             raise KconfigParserError(self, 'expected "source", "config" or identifier')
 
     # config: clause+ EOF
-    def parse_config(self):
+    def parse_config(self) -> KconfigData:
         while self.tok != TOK_EOF:
             self.parse_clause()
         return self.data
 
     # scanner -----
 
-    def get_token(self):
+    def get_token(self) -> None:
+        assert self.src is not None
         while True:
             ch = self.src[self.cursor]
             self.pos = self.cursor
@@ -590,7 +608,8 @@ def get_token(self):
                 self.tok = tok
                 return
 
-    def check_keyword(self, rest):
+    def check_keyword(self, rest: str) -> bool:
+        assert self.src is not None
         if not self.src.startswith(rest, self.cursor):
             return False
         length = len(rest)
@@ -599,7 +618,8 @@ def check_keyword(self, rest):
         self.cursor += length
         return True
 
-    def scan_token(self, ch):
+    def scan_token(self, ch: str) -> int | None:
+        assert self.src is not None
         if ch == '#':
             self.cursor = self.src.find('\n', self.cursor)
             return None
@@ -667,7 +687,7 @@ def scan_token(self, ch):
 
 def main():
     argv = sys.argv
-    mode = defconfig
+    mode: Mangler = defconfig
     if len(sys.argv) > 1:
         if argv[1] == '--defconfig':
             del argv[1]
@@ -691,7 +711,7 @@ def main():
         sys.exit(1)
 
     data = KconfigData(mode)
-    external_vars = set()
+    external_vars: set[str] = set()
     for arg in argv[3:]:
         m = re.match(r'^(CONFIG_[A-Z0-9_]+)=([yn]?)$', arg)
         if m is not None:
-- 
2.54.0


