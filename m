Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CFEC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCnyc-0000dc-Fu; Wed, 07 May 2025 19:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnya-0000dN-CF
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:14:56 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyX-00079O-RP
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:14:56 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22e70a9c6bdso7291415ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746659692; x=1747264492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PktLga2mkUHG38EkDlv7DyiIOAqfi9auOds2cIP2UXM=;
 b=tQIFC7r7Q322xg7WlAAr2akaCKHIk7K1u0MfAapmNwtR69yVotd+mBNFf3DWo8aDZx
 1mobB97LLChTk4d/vrfXzUQsL/k5yYAXbCYPCxmpl3mJ3bN9X0xD6EKbkIrpQ4mZ7pZm
 qJY7OjuchLFhncz2pTDRX/22hWe4PDbAoWhzWTj4aCW1hF7632j+K1djC12zWhRwhc7b
 oF0RSybgQocFHYZrjhmmYbDza2bI06GUcYQpi5Gva04UjWMJQheTPaKkhj4019AcpgwQ
 jfwXsbK2b7JzyL11MdQ2j+jmqvbQxnVZyOAZn77ujtrW+H90HoFXU72pC/3Vrfw1fe4i
 CcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746659692; x=1747264492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PktLga2mkUHG38EkDlv7DyiIOAqfi9auOds2cIP2UXM=;
 b=QF+Sf2qYKRSW/cLfgWU6EHe+Qm9DUkhb+Ou6mbqTLi1tiuEizn5rC5IxCoh4wo3mwH
 BxJyx+gYW7GVMSQyss6V1eSvxMbTllHQ7POvpddrhkhPp4uM9RL7xQ28QrKHBpr7ItsU
 M/nbnkoqlOAYdkj3HkguLR2rfsJHF3bd6xfyi2vdKHLm8hPbl8hVtDsq0MXcM27a0nOQ
 1OzEwcnaHMNtVxIGHv+ph6AVyZaL9iHw5aBIijI4yBQBPrf+cczOBsxqtBKXEHlAl6JO
 RoGtqOmBRBnHnik+9OMDJRtQJmQSOAUAUqXK2t7fUHnqkySHEn7UZaGS1qCLsHvkQ4Dk
 +yRw==
X-Gm-Message-State: AOJu0Yy/WYoG9rctlV+LZmcJr6G3HQYNLv4JzIEqmF4lEkf8DGjSC9S+
 DO4dW9fpOZNOmLg9/rnyBFrAxu09RPCLyfraPwAXRVnAKHP2rbsjmcvmusbtfWPDaes5EMF57+m
 iZxBeQg==
X-Gm-Gg: ASbGncsFRtZhY3O0KEX3T9teN9LbBLCtgIyaxDuxtdThZUwPUjHUwGueORf45IAR+Eg
 pDNl/KUR/QTu3BcZE35/jWasDIFWPhf3CxOV+g1l7fb4q3uImSd5noL2OZIlZBvIOiah4MKbBCE
 ddzBhoZe6JLe41/6WFyi9aE9opCi2zuxnNucDACzZTdrMNew9vvbhuHQ2JtPWhwOFlcPFP3kB/E
 91E5gMX/b+QL2HAPyJXL2OFdbp9zENCmVIkrMWxhF/h/JMljlIBFi7luvZ3vy4f/sG7cJv0y9av
 AUHxNVLmbXfyiGFUosUwv9ncjH0ddugmlHRJg7GN
X-Google-Smtp-Source: AGHT+IEYIeEDhp8V7qD9TO56tZJBxadveSsBiexmBU2hNY6yPnAqNoa94hV5/uKtuVi7FNHcMxcWtQ==
X-Received: by 2002:a17:903:188:b0:223:65a9:ab86 with SMTP id
 d9443c01a7336-22e5ea5514cmr84187935ad.12.1746659692156; 
 Wed, 07 May 2025 16:14:52 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e421a7dafsm40103205ad.69.2025.05.07.16.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:14:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, alex.bennee@linaro.org,
 stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, philmd@linaro.org,
 berrange@redhat.com, thuth@redhat.com, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 01/13] qapi: introduce 'runtime_if' for QAPI json
Date: Wed,  7 May 2025 16:14:31 -0700
Message-ID: <20250507231442.879619-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

This new entry can be used in QAPI json to specify a runtime conditional
to expose any entry, similar to existing 'if', that applies at compile
time, thanks to ifdef. The element is always defined in C, but not
exposed through the schema and visit functions, thus being hidden for a
QMP consumer.

QAPISchemaIfCond is extended to parse this information. A first version
was tried duplicating this, but this proved to be much more boilerplate
than needed to pass information through all function calls.

'if' and 'runtime_if' can be combined elegantly on a single item,
allowing to restrict an element to be present based on compile time
defines, and runtime checks at the same time.

Note: This commit only adds parsing of runtime_if, and does not hide
anything yet.

For review:

- I don't really like "runtime_if" name.
  What would make sense, IMHO, is to rename existing 'if' to 'ifdef',
  and reuse 'if' for 'runtime_if'. Since it requires invasive changes, I
  would prefer to get agreement before wasting time in case you prefer
  any other naming convention. Let me know what you'd like.

- As mentioned in second paragraph, I think our best implementation
  would be to extend existing QAPISchemaIfCond, as it's really
  complicated to extend all call sites if we have another new object.

- No tests/doc added at this time, as I prefer to wait that we decide
  about naming and proposed approach first.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 scripts/qapi/common.py | 16 +++++++++++-
 scripts/qapi/expr.py   |  9 ++++---
 scripts/qapi/gen.py    | 56 +++++++++++++++++++++++++++++++++++++++++-
 scripts/qapi/schema.py | 44 ++++++++++++++++++++++++---------
 4 files changed, 107 insertions(+), 18 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d7c8aa3365c..0e8e2abeb58 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -229,6 +229,8 @@ def gen_infix(operator: str, operands: Sequence[Any]) -> str:
 def cgen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:
     return gen_ifcond(ifcond, 'defined(%s)', '!%s', ' && ', ' || ')
 
+def cgen_runtime_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:
+    return gen_ifcond(ifcond, '%s', '!%s', ' && ', ' || ')
 
 def docgen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:
     # TODO Doc generated for conditions needs polish
@@ -242,7 +244,6 @@ def gen_if(cond: str) -> str:
 #if %(cond)s
 ''', cond=cond)
 
-
 def gen_endif(cond: str) -> str:
     if not cond:
         return ''
@@ -250,6 +251,19 @@ def gen_endif(cond: str) -> str:
 #endif /* %(cond)s */
 ''', cond=cond)
 
+def gen_runtime_if(cond: str) -> str:
+    if not cond:
+        return ''
+    return mcgen('''
+if (%(cond)s) {
+''', cond=cond)
+
+def gen_runtime_endif(cond: str) -> str:
+    if not cond:
+        return ''
+    return mcgen('''
+} /* (%(cond)s) */
+''', cond=cond)
 
 def must_match(pattern: str, string: str) -> Match[str]:
     match = re.match(pattern, string)
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index cae0a083591..5ae26395964 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -392,7 +392,8 @@ def check_type_implicit(value: Optional[object],
                          permit_underscore=permissive)
         if c_name(key, False) == 'u' or c_name(key, False).startswith('has_'):
             raise QAPISemError(info, "%s uses reserved name" % key_source)
-        check_keys(arg, info, key_source, ['type'], ['if', 'features'])
+        check_keys(arg, info, key_source, ['type'], ['if', 'features',
+                                                     'runtime_if'])
         check_if(arg, info, key_source)
         check_features(arg.get('features'), info)
         check_type_name_or_array(arg['type'], info, key_source)
@@ -642,7 +643,7 @@ def check_exprs(exprs: List[QAPIExpression]) -> List[QAPIExpression]:
         elif meta == 'union':
             check_keys(expr, info, meta,
                        ['union', 'base', 'discriminator', 'data'],
-                       ['if', 'features'])
+                       ['if', 'runtime_if', 'features'])
             normalize_members(expr.get('base'))
             normalize_members(expr['data'])
             check_union(expr)
@@ -659,8 +660,8 @@ def check_exprs(exprs: List[QAPIExpression]) -> List[QAPIExpression]:
         elif meta == 'command':
             check_keys(expr, info, meta,
                        ['command'],
-                       ['data', 'returns', 'boxed', 'if', 'features',
-                        'gen', 'success-response', 'allow-oob',
+                       ['data', 'returns', 'boxed', 'if', 'runtime_if',
+                        'features', 'gen', 'success-response', 'allow-oob',
                         'allow-preconfig', 'coroutine'])
             normalize_members(expr.get('data'))
             check_command(expr)
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index d3c56d45c89..5082eb331f4 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -109,6 +109,37 @@ def _wrap_ifcond(ifcond: QAPISchemaIfCond, before: str, after: str) -> str:
     return out
 
 
+def _wrap_runtime_ifcond(ifcond: QAPISchemaIfCond, before: str, after: str) -> str:
+    if before == after:
+        return after   # suppress empty #if ... #endif
+
+    assert after.startswith(before)
+    out = before
+    added = after[len(before):]
+    if added[0] == '\n':
+        out += '\n'
+        added = added[1:]
+    out += ifcond.gen_runtime_if()
+    out += added
+    out += ifcond.gen_runtime_endif()
+    return out
+
+
+def _wrap_runtime_ifcond(ifcond: QAPISchemaIfCond, before: str, after: str) -> str:
+    if before == after:
+        return after   # suppress empty #if ... #endif
+
+    assert after.startswith(before)
+    out = before
+    added = after[len(before):]
+    if added[0] == '\n':
+        out += '\n'
+        added = added[1:]
+    out += ifcond.gen_runtime_if()
+    out += added
+    out += ifcond.gen_runtime_endif()
+    return out
+
 def build_params(arg_type: Optional[QAPISchemaObjectType],
                  boxed: bool,
                  extra: Optional[str] = None) -> str:
@@ -137,12 +168,17 @@ class QAPIGenCCode(QAPIGen):
     def __init__(self, fname: str):
         super().__init__(fname)
         self._start_if: Optional[Tuple[QAPISchemaIfCond, str, str]] = None
+        self._start_runtime_if: Optional[Tuple[QAPISchemaIfCond, str, str]] = None
 
     def start_if(self, ifcond: QAPISchemaIfCond) -> None:
         assert self._start_if is None
         self._start_if = (ifcond, self._body, self._preamble)
 
-    def end_if(self) -> None:
+    def start_runtime_if(self, ifcond: QAPISchemaIfCond) -> None:
+        assert self._start_runtime_if is None
+        self._start_runtime_if = (ifcond, self._body, self._preamble)
+
+    def end_if(self, runtime: bool = False) -> None:
         assert self._start_if is not None
         self._body = _wrap_ifcond(self._start_if[0],
                                   self._start_if[1], self._body)
@@ -150,8 +186,18 @@ def end_if(self) -> None:
                                       self._start_if[2], self._preamble)
         self._start_if = None
 
+    def end_runtime_if(self, runtime: bool = False) -> None:
+        assert self._start_runtime_if is not None
+        self._body = _wrap_runtime_ifcond(self._start_runtime_if[0],
+                                          self._start_runtime_if[1], self._body)
+        self._preamble = _wrap_runtime_ifcond(self._start_runtime_if[0],
+                                              self._start_runtime_if[2],
+                                              self._preamble)
+        self._start_runtime_if = None
+
     def get_content(self) -> str:
         assert self._start_if is None
+        assert self._start_runtime_if is None
         return super().get_content()
 
 
@@ -231,6 +277,14 @@ def ifcontext(ifcond: QAPISchemaIfCond, *args: QAPIGenCCode) -> Iterator[None]:
     for arg in args:
         arg.end_if()
 
+@contextmanager
+def runtime_ifcontext(ifcond: QAPISchemaIfCond,
+                      *args: QAPIGenCCode) -> Iterator[None]:
+    for arg in args:
+        arg.start_runtime_if(ifcond)
+    yield
+    for arg in args:
+        arg.end_runtime_if()
 
 class QAPISchemaMonolithicCVisitor(QAPISchemaVisitor):
     def __init__(self,
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index cbe3b5aa91e..533d0dfe088 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -36,9 +36,12 @@
     POINTER_SUFFIX,
     c_name,
     cgen_ifcond,
+    cgen_runtime_ifcond,
     docgen_ifcond,
-    gen_endif,
     gen_if,
+    gen_endif,
+    gen_runtime_if,
+    gen_runtime_endif,
 )
 from .error import QAPIError, QAPISemError, QAPISourceError
 from .expr import check_exprs
@@ -50,8 +53,10 @@ class QAPISchemaIfCond:
     def __init__(
         self,
         ifcond: Optional[Union[str, Dict[str, object]]] = None,
+        runtime_ifcond: Optional[Union[str, Dict[str, object]]] = None,
     ) -> None:
         self.ifcond = ifcond
+        self.runtime_ifcond = runtime_ifcond
 
     def _cgen(self) -> str:
         return cgen_ifcond(self.ifcond)
@@ -65,8 +70,17 @@ def gen_endif(self) -> str:
     def docgen(self) -> str:
         return docgen_ifcond(self.ifcond)
 
+    def _cgen_runtime(self) -> str:
+        return cgen_runtime_ifcond(self.runtime_ifcond)
+
+    def gen_runtime_if(self) -> str:
+        return gen_runtime_if(self._cgen_runtime())
+
+    def gen_runtime_endif(self) -> str:
+        return gen_runtime_endif(self._cgen_runtime())
+
     def is_present(self) -> bool:
-        return bool(self.ifcond)
+        return bool(self.ifcond) or bool(self.runtime_ifcond)
 
 
 class QAPISchemaEntity:
@@ -1281,13 +1295,15 @@ def _make_features(
                 self._feature_dict[feat.name] = feat
 
         return [QAPISchemaFeature(f['name'], info,
-                                  QAPISchemaIfCond(f.get('if')))
+                                  QAPISchemaIfCond(f.get('if'),
+                                                   f.get('runtime_if')))
                 for f in features]
 
     def _make_enum_member(
         self,
         name: str,
         ifcond: Optional[Union[str, Dict[str, Any]]],
+        runtime_ifcond: Optional[Union[str, Dict[str, Any]]],
         features: Optional[List[Dict[str, Any]]],
         info: Optional[QAPISourceInfo],
     ) -> QAPISchemaEnumMember:
@@ -1299,6 +1315,7 @@ def _make_enum_members(
         self, values: List[Dict[str, Any]], info: Optional[QAPISourceInfo]
     ) -> List[QAPISchemaEnumMember]:
         return [self._make_enum_member(v['name'], v.get('if'),
+                                       v.get('runtime_if'),
                                        v.get('features'), info)
                 for v in values]
 
@@ -1338,7 +1355,7 @@ def _def_enum_type(self, expr: QAPIExpression) -> None:
         name = expr['enum']
         data = expr['data']
         prefix = expr.get('prefix')
-        ifcond = QAPISchemaIfCond(expr.get('if'))
+        ifcond = QAPISchemaIfCond(expr.get('if'), expr.get('runtime_if'))
         info = expr.info
         features = self._make_features(expr.get('features'), info)
         self._def_definition(QAPISchemaEnumType(
@@ -1369,7 +1386,8 @@ def _make_members(
         info: QAPISourceInfo,
     ) -> List[QAPISchemaObjectTypeMember]:
         return [self._make_member(key, value['type'],
-                                  QAPISchemaIfCond(value.get('if')),
+                                  QAPISchemaIfCond(value.get('if'),
+                                                   value.get('runtime_if')),
                                   value.get('features'), info)
                 for (key, value) in data.items()]
 
@@ -1378,7 +1396,7 @@ def _def_struct_type(self, expr: QAPIExpression) -> None:
         base = expr.get('base')
         data = expr['data']
         info = expr.info
-        ifcond = QAPISchemaIfCond(expr.get('if'))
+        ifcond = QAPISchemaIfCond(expr.get('if'), expr.get('runtime_if'))
         features = self._make_features(expr.get('features'), info)
         self._def_definition(QAPISchemaObjectType(
             name, info, expr.doc, ifcond, features, base,
@@ -1404,7 +1422,7 @@ def _def_union_type(self, expr: QAPIExpression) -> None:
         data = expr['data']
         assert isinstance(data, dict)
         info = expr.info
-        ifcond = QAPISchemaIfCond(expr.get('if'))
+        ifcond = QAPISchemaIfCond(expr.get('if'), expr.get('runtime_if'))
         features = self._make_features(expr.get('features'), info)
         if isinstance(base, dict):
             base = self._make_implicit_object_type(
@@ -1412,7 +1430,8 @@ def _def_union_type(self, expr: QAPIExpression) -> None:
                 'base', self._make_members(base, info))
         variants = [
             self._make_variant(key, value['type'],
-                               QAPISchemaIfCond(value.get('if')),
+                               QAPISchemaIfCond(value.get('if'),
+                                                value.get('runtime_if')),
                                info)
             for (key, value) in data.items()]
         members: List[QAPISchemaObjectTypeMember] = []
@@ -1426,12 +1445,13 @@ def _def_alternate_type(self, expr: QAPIExpression) -> None:
         name = expr['alternate']
         data = expr['data']
         assert isinstance(data, dict)
-        ifcond = QAPISchemaIfCond(expr.get('if'))
+        ifcond = QAPISchemaIfCond(expr.get('if'), expr.get('runtime_if'))
         info = expr.info
         features = self._make_features(expr.get('features'), info)
         variants = [
             self._make_variant(key, value['type'],
-                               QAPISchemaIfCond(value.get('if')),
+                               QAPISchemaIfCond(value.get('if'),
+                                                value.get('runtime_if')),
                                info)
             for (key, value) in data.items()]
         tag_member = QAPISchemaObjectTypeMember('type', info, 'QType', False)
@@ -1450,7 +1470,7 @@ def _def_command(self, expr: QAPIExpression) -> None:
         allow_oob = expr.get('allow-oob', False)
         allow_preconfig = expr.get('allow-preconfig', False)
         coroutine = expr.get('coroutine', False)
-        ifcond = QAPISchemaIfCond(expr.get('if'))
+        ifcond = QAPISchemaIfCond(expr.get('if'), expr.get('runtime_if'))
         info = expr.info
         features = self._make_features(expr.get('features'), info)
         if isinstance(data, dict):
@@ -1469,7 +1489,7 @@ def _def_event(self, expr: QAPIExpression) -> None:
         name = expr['event']
         data = expr.get('data')
         boxed = expr.get('boxed', False)
-        ifcond = QAPISchemaIfCond(expr.get('if'))
+        ifcond = QAPISchemaIfCond(expr.get('if'), expr.get('runtime_if'))
         info = expr.info
         features = self._make_features(expr.get('features'), info)
         if isinstance(data, dict):
-- 
2.47.2


