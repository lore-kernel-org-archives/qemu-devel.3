Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0081D185EF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpnW-0007xl-8c; Thu, 08 Jan 2026 08:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpnT-0007qX-8X
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpnQ-00083D-3y
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767877883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RLf8C04HThWu7hxDLSyEOaJNCSCBlM6N9D2NQTVosRM=;
 b=CQiZBmxzEhwnYMyVhVyY47HoD9Y6lQD45G+uMjTjCyz9Z06XIQw2tJYoJ+hLh/jfi8YqBp
 fdKFi0mdhHL5mCUAoAf0i6Ezx8PIpE7C46dtjqc20Bha+a0aTQ5nJqMyv5rMIlZxsNcX48
 Wj7agLnWVMtHgwVpjoN+YH0PFueomKY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-W-SwEtCLOIq8zOGfPCYsfw-1; Thu, 08 Jan 2026 08:11:22 -0500
X-MC-Unique: W-SwEtCLOIq8zOGfPCYsfw-1
X-Mimecast-MFC-AGG-ID: W-SwEtCLOIq8zOGfPCYsfw_1767877881
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43102ac1da8so2261449f8f.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767877880; x=1768482680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLf8C04HThWu7hxDLSyEOaJNCSCBlM6N9D2NQTVosRM=;
 b=MBhgK77p1YL7u68zoCxSkuAuCPFVdBlNWck80MQzA0wXIxEPjjIGFo6JAAOKpFedm9
 w80owy87G3X7MzpwK2bicXqKWQ903nKhK7r2WW+/vAKFuQ9YWoXaDS6TW2rtfcIABvZ7
 XoutCTh8DkkMyhuHZxw4UpcR4+4CfBsHsEevG2Jl3fEffZRZgR3itX9MMX73g1Kd0+K4
 uH/iWALlwR2BHtOat9dP8a3PrLJ9RR6bqUmtVcwPckxQgxgmKOiHumDqEqG9045rdQwM
 +RMmT1ZgPhUYwtOLnEaBWGQNporhPcgVgrBEORgufnM9ita7n7qTE9AfJBC9A4AQQbvs
 PAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767877880; x=1768482680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RLf8C04HThWu7hxDLSyEOaJNCSCBlM6N9D2NQTVosRM=;
 b=GUzkDiNgEUUWj/ogn9GiOcBqYELHFBdLP5D98l1/bbFf7mc342lQTnR4GbLTPsJ8Fc
 Fy38TWZ2plvOrElsBwtabN7wsyFyDXJ5YHw37HFi7ZUDDWSxLWhtQF8hhY2tMmKxsFhT
 8N7Cv0ZMzSBzjYZ7nxgtJrGIgZU9oQpmjyd+NeH/E9FU40MknxcFaxYzZ4gwXO9Df98i
 eZ0ax0f+Fhwbue9tzwJNYtZPMsNpR26MkY+rnRWwMkVnkZZ1wedMLz+v3np03bxM4BpA
 TNKaC0YokAsinSpziBVpH0SE2JMTxqg0ZfH2cZywIHULCWZbzkTlU+fPigS4MBzFL1jN
 SwkA==
X-Gm-Message-State: AOJu0Yy7KGyWNS+DjgaGIWsdO92lGePgDD39gqfDG4R+A8m0Pc3nypRH
 w4mV+NvNL+y8TzydmTiJXQ1/ZzqwkCwb/QEnWN/kEiI6pjrteVqo7E6chZ+gZJB6JAiA3rwOnYc
 cgah2tykmS8PLEw+T0EHTzTHaFNgOb6JyrgF0vUKzRXoC7NqmZMad1YsrEq0PSD7N7gUk36WPow
 v6F/JWzUI9s7jgErZaOU1wTX8dAXMdp+eUILUTa3qu
X-Gm-Gg: AY/fxX5vY/1ePPvUzMOaqQWMelIWGeAO3d9LE/4lH/QREzsG9WVbjynL2xSMJ+KqzIv
 BQBemb8H4kHrlUpm/6rvqdCGiIbc3QFqAhyVgZ1/qS6GfZmyHO9lPV+o0FdhSIW14DP7l21yYLl
 x0qsmijSSsDAAfTLS22VAI8qlEUD1XTyFuQCj9WL9/1yaO/zH0fC++EaJlWk0TXDHKdrBlt6Z/f
 gCErObXZ2pll2MCXOfmhDhS/ybskCkH9nMvxOtKqJfXgW+i1JCOIOG0b0i6ZKxYfsiQ1OFl205S
 bKQTqc2lTeXSgIpsD/MCuyqtoWwtXYOvp+l1cdSLhvWjCYhrwDVYrkEvzmTGGkwYDhEo5D4UohD
 bgp7a7nARrrF4sX/MO7J4xXl09MkyweE+6FhrE2nkuaek73xzGqDpXJZHTdkTO5fw8/6fOM0YHQ
 DAIPTCx9VWcMgXqA==
X-Received: by 2002:a05:6000:2908:b0:431:a38:c2f7 with SMTP id
 ffacd0b85a97d-432c37a7d86mr7165471f8f.59.1767877879852; 
 Thu, 08 Jan 2026 05:11:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIBPHXJGQY+rvLsf+AbhuQcxem2L+UpS2wdfb1SS+pCtTPKnI+J60VkjZFNDBpeX7UKeSWpA==
X-Received: by 2002:a05:6000:2908:b0:431:a38:c2f7 with SMTP id
 ffacd0b85a97d-432c37a7d86mr7165423f8f.59.1767877879040; 
 Thu, 08 Jan 2026 05:11:19 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee870sm16251504f8f.36.2026.01.08.05.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:11:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org
Subject: [PATCH v2 12/16] scripts/qapi: generate high-level Rust bindings
Date: Thu,  8 Jan 2026 14:10:39 +0100
Message-ID: <20260108131043.490084-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108131043.490084-1-pbonzini@redhat.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Generate high-level native Rust declarations for the QAPI types.

- char* is mapped to String, scalars to there corresponding Rust types

- enums use #[repr(u32)] and can be transmuted to their C counterparts

- has_foo/foo members are mapped to Option<T>

- lists are represented as Vec<T>

- structures map fields 1:1 to Rust

- alternate are represented as Rust enum, each variant being a 1-element
  tuple

- unions are represented in a similar way as in C: a struct S with a "u"
  member (since S may have extra 'base' fields). The discriminant
  isn't a member of S, since Rust enum already include it, but it can be
  recovered with "mystruct.u.into()"

Anything that includes a recursive struct puts it in a Box.  Lists are
not considered recursive, because Vec breaks the recursion (it's possible
to construct an object containing an empty Vec of its own type).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20210907121943.3498701-21-marcandre.lureau@redhat.com
[Paolo: rewrite conversion of schema types to Rust types]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build              |   4 +-
 scripts/qapi/backend.py  |  25 +++
 scripts/qapi/common.py   |  43 +++++
 scripts/qapi/rs.py       |  61 +++++++
 scripts/qapi/rs_types.py | 373 +++++++++++++++++++++++++++++++++++++++
 scripts/qapi/schema.py   |  59 +++++--
 6 files changed, 546 insertions(+), 19 deletions(-)
 create mode 100644 scripts/qapi/rs.py
 create mode 100644 scripts/qapi/rs_types.py

diff --git a/meson.build b/meson.build
index db87358d62d..4228792f0f6 100644
--- a/meson.build
+++ b/meson.build
@@ -3540,11 +3540,13 @@ qapi_gen_depends = [ meson.current_source_dir() / 'scripts/qapi/__init__.py',
                      meson.current_source_dir() / 'scripts/qapi/introspect.py',
                      meson.current_source_dir() / 'scripts/qapi/main.py',
                      meson.current_source_dir() / 'scripts/qapi/parser.py',
+                     meson.current_source_dir() / 'scripts/qapi/rs_types.py',
                      meson.current_source_dir() / 'scripts/qapi/schema.py',
                      meson.current_source_dir() / 'scripts/qapi/source.py',
                      meson.current_source_dir() / 'scripts/qapi/types.py',
                      meson.current_source_dir() / 'scripts/qapi/visit.py',
-                     meson.current_source_dir() / 'scripts/qapi-gen.py'
+                     meson.current_source_dir() / 'scripts/qapi-gen.py',
+                     meson.current_source_dir() / 'scripts/qapi/rs.py',
 ]
 
 tracetool = [
diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
index 49ae6ecdd33..8023acce0d6 100644
--- a/scripts/qapi/backend.py
+++ b/scripts/qapi/backend.py
@@ -7,6 +7,7 @@
 from .events import gen_events
 from .features import gen_features
 from .introspect import gen_introspect
+from .rs_types import gen_rs_types
 from .schema import QAPISchema
 from .types import gen_types
 from .visit import gen_visit
@@ -63,3 +64,27 @@ def generate(self,
         gen_commands(schema, output_dir, prefix, gen_tracing)
         gen_events(schema, output_dir, prefix)
         gen_introspect(schema, output_dir, prefix, unmask)
+
+
+class QAPIRsBackend(QAPIBackend):
+    # pylint: disable=too-few-public-methods
+
+    def generate(self,
+                 schema: QAPISchema,
+                 output_dir: str,
+                 prefix: str,
+                 unmask: bool,
+                 builtins: bool,
+                 gen_tracing: bool) -> None:
+        """
+        Generate Rust code for the given schema into the target directory.
+
+        :param schema_file: The primary QAPI schema file.
+        :param output_dir: The output directory to store generated code.
+        :param prefix: Optional C-code prefix for symbol names.
+        :param unmask: Expose non-ABI names through introspection?
+        :param builtins: Generate code for built-in types?
+
+        :raise QAPIError: On failures.
+        """
+        gen_rs_types(schema, output_dir, prefix)
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index c75396a01b5..e9261a3411e 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -64,6 +64,13 @@ def camel_to_upper(value: str) -> str:
     return ret.upper()
 
 
+def camel_to_lower(value: str) -> str:
+    """
+    Converts CamelCase to camel_case.
+    """
+    return camel_to_upper(value).lower()
+
+
 def c_enum_const(type_name: str,
                  const_name: str,
                  prefix: Optional[str] = None) -> str:
@@ -129,6 +136,42 @@ def c_name(name: str, protect: bool = True) -> str:
     return name
 
 
+def rs_name(name: str) -> str:
+    """
+    Map @name to a valid, possibly raw Rust identifier.
+    """
+    name = re.sub(r'[^A-Za-z0-9_]', '_', name)
+    if name[0].isnumeric():
+        name = '_' + name
+    # based from the list:
+    # https://doc.rust-lang.org/reference/keywords.html
+    if name in ('Self', 'abstract', 'as', 'async',
+                'await', 'become', 'box', 'break',
+                'const', 'continue', 'crate', 'do',
+                'dyn', 'else', 'enum', 'extern',
+                'false', 'final', 'fn', 'for',
+                'if', 'impl', 'in', 'let',
+                'loop', 'macro', 'match', 'mod',
+                'move', 'mut', 'override', 'priv',
+                'pub', 'ref', 'return', 'self',
+                'static', 'struct', 'super', 'trait',
+                'true', 'try', 'type', 'typeof',
+                'union', 'unsafe', 'unsized', 'use',
+                'virtual', 'where', 'while', 'yield'):
+        name = 'r#' + name
+    # avoid some clashes with the standard library
+    if name in ('String',):
+        name = 'Qapi' + name
+
+    return name
+
+
+def to_camel_case(value: str) -> str:
+    return ''.join('_' + word if word[0].isdigit()
+                   else word[:1].upper() + word[1:]
+                   for word in filter(None, re.split("[-_]+", value)))
+
+
 class Indentation:
     """
     Indentation level management.
diff --git a/scripts/qapi/rs.py b/scripts/qapi/rs.py
new file mode 100644
index 00000000000..2cf0c0e07f1
--- /dev/null
+++ b/scripts/qapi/rs.py
@@ -0,0 +1,61 @@
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+"""
+QAPI Rust generator
+"""
+
+import os
+import re
+import subprocess
+import sys
+
+from .common import mcgen as mcgen_common
+from .gen import QAPIGen
+from .schema import QAPISchemaVisitor
+
+
+def mcgen(s: str, **kwds: object) -> str:
+    s = mcgen_common(s, **kwds)
+    return re.sub(r'(?: *\n)+', '\n', s)
+
+
+class QAPIGenRs(QAPIGen):
+    def __init__(self, fname: str, blurb: str, pydoc: str):
+        super().__init__(fname)
+        self._blurb = blurb
+        self._copyright = '\n//! '.join(re.findall(r'^Copyright .*', pydoc,
+                                                   re.MULTILINE))
+
+    def _top(self) -> str:
+        return mcgen('''
+// @generated by qapi-gen, DO NOT EDIT
+
+//!
+//! Schema-defined QAPI types
+//!
+//! %(copyright)s
+//!
+//! This work is licensed under the terms of the GNU LGPL, version 2.1 or
+//! later. See the COPYING.LIB file in the top-level directory.
+
+''',
+                     tool=os.path.basename(sys.argv[0]),
+                     blurb=self._blurb, copyright=self._copyright)
+
+
+class QAPISchemaRsVisitor(QAPISchemaVisitor):
+
+    def __init__(self, prefix: str, what: str,
+                 blurb: str, pydoc: str):
+        super().__init__()
+        self._prefix = prefix
+        self._what = what
+        self._gen = QAPIGenRs(self._prefix + self._what + '.rs', blurb, pydoc)
+
+    def write(self, output_dir: str) -> None:
+        self._gen.write(output_dir)
+
+        try:
+            subprocess.check_call(['rustfmt', self._gen.fname], cwd=output_dir)
+        except FileNotFoundError:
+            pass
diff --git a/scripts/qapi/rs_types.py b/scripts/qapi/rs_types.py
new file mode 100644
index 00000000000..64702eb54ae
--- /dev/null
+++ b/scripts/qapi/rs_types.py
@@ -0,0 +1,373 @@
+# This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+"""
+QAPI Rust types generator
+
+Copyright (c) 2025 Red Hat, Inc.
+
+This work is licensed under the terms of the GNU GPL, version 2.
+See the COPYING file in the top-level directory.
+"""
+
+from typing import List, Optional, Set
+
+from .common import (
+    camel_to_lower,
+    camel_to_upper,
+    rs_name,
+    to_camel_case,
+)
+from .rs import QAPISchemaRsVisitor, mcgen
+from .schema import (
+    QAPISchema,
+    QAPISchemaAlternateType,
+    QAPISchemaEnumMember,
+    QAPISchemaFeature,
+    QAPISchemaIfCond,
+    QAPISchemaObjectType,
+    QAPISchemaObjectTypeMember,
+    QAPISchemaType,
+    QAPISchemaVariants,
+)
+from .source import QAPISourceInfo
+
+
+objects_seen = set()
+
+
+def gen_rs_variants_to_tag(name: str,
+                           ifcond: QAPISchemaIfCond,
+                           variants: QAPISchemaVariants) -> str:
+    ret = mcgen('''
+
+%(cfg)s
+impl From<&%(rs_name)sVariant> for %(tag)s {
+    fn from(e: &%(rs_name)sVariant) -> Self {
+        match e {
+''',
+                cfg=ifcond.rsgen(),
+                rs_name=rs_name(name),
+                tag=variants.tag_member.type.rs_type())
+
+    for var in variants.variants:
+        type_name = var.type.name
+        tag_name = var.name
+        patt = '(_)'
+        if type_name == 'q_empty':
+            patt = ''
+        ret += mcgen('''
+            %(cfg)s
+            %(rs_name)sVariant::%(var_name)s%(patt)s => Self::%(tag_name)s,
+''',
+                     cfg=var.ifcond.rsgen(),
+                     rs_name=rs_name(name),
+                     tag_name=rs_name(camel_to_upper(tag_name)),
+                     var_name=rs_name(to_camel_case(tag_name)),
+                     patt=patt)
+
+    ret += mcgen('''
+        }
+    }
+}
+''')
+    return ret
+
+
+def gen_rs_variants(name: str,
+                    ifcond: QAPISchemaIfCond,
+                    variants: QAPISchemaVariants) -> str:
+    ret = mcgen('''
+
+%(cfg)s
+#[derive(Clone, Debug, PartialEq)]
+pub enum %(rs_name)sVariant {
+''',
+                cfg=ifcond.rsgen(),
+                rs_name=rs_name(name))
+
+    for var in variants.variants:
+        type_name = var.type.name
+        var_name = rs_name(to_camel_case(var.name))
+        if type_name == 'q_empty':
+            ret += mcgen('''
+    %(cfg)s
+    %(var_name)s,
+''',
+                         cfg=var.ifcond.rsgen(),
+                         var_name=var_name)
+        else:
+            ret += mcgen('''
+    %(cfg)s
+    %(var_name)s(%(rs_type)s),
+''',
+                         cfg=var.ifcond.rsgen(),
+                         var_name=var_name,
+                         rs_type=var.type.rs_type())
+
+    ret += mcgen('''
+}
+''')
+
+    ret += gen_rs_variants_to_tag(name, ifcond, variants)
+
+    return ret
+
+
+def gen_rs_members(members: List[QAPISchemaObjectTypeMember],
+                   exclude: Optional[List[str]] = None) -> List[str]:
+    exclude = exclude or []
+    return [f"{m.ifcond.rsgen()} {rs_name(camel_to_lower(m.name))}"
+            for m in members if m.name not in exclude]
+
+
+def has_recursive_type(memb: QAPISchemaType,
+                       name: str,
+                       visited: Set[str]) -> bool:
+    # pylint: disable=too-many-return-statements
+    if name == memb.name:
+        return True
+    if memb.name in visited:
+        return False
+    visited.add(memb.name)
+    if isinstance(memb, QAPISchemaObjectType):
+        if memb.base and has_recursive_type(memb.base, name, visited):
+            return True
+        if memb.branches and \
+                any(has_recursive_type(m.type, name, visited)
+                    for m in memb.branches.variants):
+            return True
+        if any(has_recursive_type(m.type, name, visited)
+               for m in memb.members):
+            return True
+        return any(has_recursive_type(m.type, name, visited)
+                   for m in memb.local_members)
+    if isinstance(memb, QAPISchemaAlternateType):
+        return any(has_recursive_type(m.type, name, visited)
+                   for m in memb.alternatives.variants)
+    return False
+
+
+def gen_struct_members(members: List[QAPISchemaObjectTypeMember],
+                       name: str) -> str:
+    ret = ''
+    for memb in members:
+        typ = memb.type.rs_type()
+        if has_recursive_type(memb.type, name, set()):
+            typ = 'Box<%s>' % typ
+        if memb.optional:
+            typ = 'Option<%s>' % typ
+        ret += mcgen('''
+    %(cfg)s
+    pub %(rs_name)s: %(rs_type)s,
+''',
+                     cfg=memb.ifcond.rsgen(),
+                     rs_type=typ,
+                     rs_name=rs_name(camel_to_lower(memb.name)))
+    return ret
+
+
+def gen_rs_object(name: str,
+                  ifcond: QAPISchemaIfCond,
+                  base: Optional[QAPISchemaObjectType],
+                  members: List[QAPISchemaObjectTypeMember],
+                  variants: Optional[QAPISchemaVariants]) -> str:
+    if name in objects_seen:
+        return ''
+
+    if variants:
+        members = [m for m in members
+                   if m.name != variants.tag_member.name]
+
+    ret = ''
+    objects_seen.add(name)
+
+    if variants:
+        ret += gen_rs_variants(name, ifcond, variants)
+
+    ret += mcgen('''
+
+%(cfg)s
+#[derive(Clone, Debug, PartialEq)]
+pub struct %(rs_name)s {
+''',
+                 cfg=ifcond.rsgen(),
+                 rs_name=rs_name(name))
+
+    if base:
+        if not base.is_implicit():
+            ret += mcgen('''
+    // Members inherited:
+''',
+                         c_name=base.c_name())
+        base_members = base.members
+        if variants:
+            base_members = [m for m in base.members
+                            if m.name != variants.tag_member.name]
+        ret += gen_struct_members(base_members, name)
+        if not base.is_implicit():
+            ret += mcgen('''
+    // Own members:
+''')
+
+    ret += gen_struct_members(members, name)
+
+    if variants:
+        ret += mcgen('''
+    pub u: %(rs_type)sVariant,
+''', rs_type=rs_name(name))
+    ret += mcgen('''
+}
+''')
+    return ret
+
+
+def gen_rs_enum(name: str,
+                ifcond: QAPISchemaIfCond,
+                members: List[QAPISchemaEnumMember]) -> str:
+    ret = mcgen('''
+
+%(cfg)s
+#[derive(Copy, Clone, Debug, PartialEq)]
+''',
+                cfg=ifcond.rsgen())
+
+    if members:
+        ret += '''#[repr(u32)]
+#[derive(common::TryInto)]
+'''
+    ret += mcgen('''
+pub enum %(rs_name)s {
+''',
+                 rs_name=rs_name(name))
+
+    for member in members:
+        ret += mcgen('''
+    %(cfg)s
+    %(c_enum)s,
+''',
+                     cfg=member.ifcond.rsgen(),
+                     c_enum=rs_name(camel_to_upper(member.name)))
+    ret += '''}
+
+'''
+
+    # pick the first, since that's what malloc0 does
+    if members:
+        default = rs_name(camel_to_upper(members[0].name))
+        ret += mcgen('''
+%(cfg)s
+impl Default for %(rs_name)s {
+    #[inline]
+    fn default() -> %(rs_name)s {
+        Self::%(default)s
+    }
+}
+''',
+                     cfg=ifcond.rsgen(),
+                     rs_name=rs_name(name),
+                     default=default)
+    return ret
+
+
+def gen_rs_alternate(name: str,
+                     ifcond: QAPISchemaIfCond,
+                     variants: QAPISchemaVariants) -> str:
+    if name in objects_seen:
+        return ''
+
+    ret = ''
+    objects_seen.add(name)
+
+    ret += mcgen('''
+%(cfg)s
+#[derive(Clone, Debug, PartialEq)]
+pub enum %(rs_name)s {
+''',
+                 cfg=ifcond.rsgen(),
+                 rs_name=rs_name(name))
+
+    for var in variants.variants:
+        if var.type.name == 'q_empty':
+            continue
+        typ = var.type.rs_type()
+        if has_recursive_type(var.type, name, set()):
+            typ = 'Box<%s>' % typ
+        ret += mcgen('''
+        %(cfg)s
+        %(mem_name)s(%(rs_type)s),
+''',
+                     cfg=var.ifcond.rsgen(),
+                     rs_type=typ,
+                     mem_name=rs_name(to_camel_case(var.name)))
+
+    ret += mcgen('''
+}
+''')
+    return ret
+
+
+class QAPISchemaGenRsTypeVisitor(QAPISchemaRsVisitor):
+    _schema: Optional[QAPISchema]
+
+    def __init__(self, prefix: str) -> None:
+        super().__init__(prefix, 'qapi-types',
+                         'Schema-defined QAPI types', __doc__)
+
+    def visit_begin(self, schema: QAPISchema) -> None:
+        self._schema = schema
+        objects_seen.add(schema.the_empty_object_type.name)
+
+        self._gen.preamble_add(
+            mcgen('''
+#![allow(unexpected_cfgs)]
+#![allow(non_camel_case_types)]
+#![allow(clippy::empty_structs_with_brackets)]
+#![allow(clippy::large_enum_variant)]
+#![allow(clippy::pub_underscore_fields)]
+
+// Because QAPI structs can contain float, for simplicity we never
+// derive Eq.  Clippy however would complain for those structs
+// that *could* be Eq too.
+#![allow(clippy::derive_partial_eq_without_eq)]
+
+use util::qobject::QObject;
+'''))
+
+    def visit_object_type(self,
+                          name: str,
+                          info: Optional[QAPISourceInfo],
+                          ifcond: QAPISchemaIfCond,
+                          features: List[QAPISchemaFeature],
+                          base: Optional[QAPISchemaObjectType],
+                          members: List[QAPISchemaObjectTypeMember],
+                          branches: Optional[QAPISchemaVariants]) -> None:
+        assert self._schema is not None
+        if self._schema.is_predefined(name) or name.startswith('q_'):
+            return
+        self._gen.add(gen_rs_object(name, ifcond, base, members, branches))
+
+    def visit_enum_type(self,
+                        name: str,
+                        info: Optional[QAPISourceInfo],
+                        ifcond: QAPISchemaIfCond,
+                        features: List[QAPISchemaFeature],
+                        members: List[QAPISchemaEnumMember],
+                        prefix: Optional[str]) -> None:
+        assert self._schema is not None
+        if self._schema.is_predefined(name):
+            return
+        self._gen.add(gen_rs_enum(name, ifcond, members))
+
+    def visit_alternate_type(self,
+                             name: str,
+                             info: Optional[QAPISourceInfo],
+                             ifcond: QAPISchemaIfCond,
+                             features: List[QAPISchemaFeature],
+                             alternatives: QAPISchemaVariants) -> None:
+        self._gen.add(gen_rs_alternate(name, ifcond, alternatives))
+
+
+def gen_rs_types(schema: QAPISchema, output_dir: str, prefix: str) -> None:
+    vis = QAPISchemaGenRsTypeVisitor(prefix)
+    schema.visit(vis)
+    vis.write(output_dir)
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 15f5d97418f..a65b25141fa 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -37,6 +37,7 @@
     docgen_ifcond,
     gen_endif,
     gen_if,
+    rs_name,
     rsgen_ifcond,
 )
 from .error import QAPIError, QAPISemError, QAPISourceError
@@ -341,6 +342,11 @@ def c_param_type(self) -> str:
     def c_unboxed_type(self) -> str:
         return self.c_type()
 
+    # Return the Rust type for common use
+    @abstractmethod
+    def rs_type(self) -> str:
+        pass
+
     @abstractmethod
     def json_type(self) -> str:
         pass
@@ -382,11 +388,12 @@ def describe(self) -> str:
 class QAPISchemaBuiltinType(QAPISchemaType):
     meta = 'built-in'
 
-    def __init__(self, name: str, json_type: str, c_type: str):
+    def __init__(self, name: str, json_type: str, rs_type: str, c_type: str):
         super().__init__(name, None, None)
         assert json_type in ('string', 'number', 'int', 'boolean', 'null',
                              'value')
         self._json_type_name = json_type
+        self._rs_type_name = rs_type
         self._c_type_name = c_type
 
     def c_name(self) -> str:
@@ -406,6 +413,9 @@ def json_type(self) -> str:
     def doc_type(self) -> str:
         return self.json_type()
 
+    def rs_type(self) -> str:
+        return self._rs_type_name
+
     def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_builtin_type(self.name, self.info, self.json_type())
@@ -449,6 +459,9 @@ def is_implicit(self) -> bool:
     def c_type(self) -> str:
         return c_name(self.name)
 
+    def rs_type(self) -> str:
+        return rs_name(self.name)
+
     def member_names(self) -> List[str]:
         return [m.name for m in self.members]
 
@@ -498,6 +511,9 @@ def is_implicit(self) -> bool:
     def c_type(self) -> str:
         return c_name(self.name) + POINTER_SUFFIX
 
+    def rs_type(self) -> str:
+        return 'Vec<%s>' % self.element_type.rs_type()
+
     def json_type(self) -> str:
         return 'array'
 
@@ -630,6 +646,9 @@ def c_type(self) -> str:
     def c_unboxed_type(self) -> str:
         return c_name(self.name)
 
+    def rs_type(self) -> str:
+        return rs_name(self.name)
+
     def json_type(self) -> str:
         return 'object'
 
@@ -711,6 +730,9 @@ def c_type(self) -> str:
     def json_type(self) -> str:
         return 'value'
 
+    def rs_type(self) -> str:
+        return rs_name(self.name)
+
     def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_alternate_type(
@@ -1234,9 +1256,10 @@ def _def_include(self, expr: QAPIExpression) -> None:
             QAPISchemaInclude(self._make_module(include), expr.info))
 
     def _def_builtin_type(
-        self, name: str, json_type: str, c_type: str
+        self, name: str, json_type: str, rs_type: str, c_type: str
     ) -> None:
-        self._def_definition(QAPISchemaBuiltinType(name, json_type, c_type))
+        builtin = QAPISchemaBuiltinType(name, json_type, rs_type, c_type)
+        self._def_definition(builtin)
         # Instantiating only the arrays that are actually used would
         # be nice, but we can't as long as their generated code
         # (qapi-builtin-types.[ch]) may be shared by some other
@@ -1255,21 +1278,21 @@ def is_predefined(self, name: str) -> bool:
         return False
 
     def _def_predefineds(self) -> None:
-        for t in [('str',    'string',  'char' + POINTER_SUFFIX),
-                  ('number', 'number',  'double'),
-                  ('int',    'int',     'int64_t'),
-                  ('int8',   'int',     'int8_t'),
-                  ('int16',  'int',     'int16_t'),
-                  ('int32',  'int',     'int32_t'),
-                  ('int64',  'int',     'int64_t'),
-                  ('uint8',  'int',     'uint8_t'),
-                  ('uint16', 'int',     'uint16_t'),
-                  ('uint32', 'int',     'uint32_t'),
-                  ('uint64', 'int',     'uint64_t'),
-                  ('size',   'int',     'uint64_t'),
-                  ('bool',   'boolean', 'bool'),
-                  ('any',    'value',   'QObject' + POINTER_SUFFIX),
-                  ('null',   'null',    'QNull' + POINTER_SUFFIX)]:
+        for t in [('str',    'string',  'String',  'char' + POINTER_SUFFIX),
+                  ('number', 'number',  'f64',     'double'),
+                  ('int',    'int',     'i64',     'int64_t'),
+                  ('int8',   'int',     'i8',      'int8_t'),
+                  ('int16',  'int',     'i16',     'int16_t'),
+                  ('int32',  'int',     'i32',     'int32_t'),
+                  ('int64',  'int',     'i64',     'int64_t'),
+                  ('uint8',  'int',     'u8',      'uint8_t'),
+                  ('uint16', 'int',     'u16',     'uint16_t'),
+                  ('uint32', 'int',     'u32',     'uint32_t'),
+                  ('uint64', 'int',     'u64',     'uint64_t'),
+                  ('size',   'int',     'u64',     'uint64_t'),
+                  ('bool',   'boolean', 'bool',    'bool'),
+                  ('any',    'value',   'QObject', 'QObject' + POINTER_SUFFIX),
+                  ('null',   'null',    '()',      'QNull' + POINTER_SUFFIX)]:
             self._def_builtin_type(*t)
         self.the_empty_object_type = QAPISchemaObjectType(
             'q_empty', None, None, None, None, None, [], None)
-- 
2.52.0


