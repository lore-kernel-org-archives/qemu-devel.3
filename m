Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6006CAC5A5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZGJ-00020r-CO; Fri, 19 Sep 2025 07:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzZGI-00020U-DX
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzZGF-0001FC-3S
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758281199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0rr5q4tcjTVgZsVN6TIdP7WAcYieibLS5wbWm7OTJfI=;
 b=Bv61+I+fNwY3/BbMx5d2XD7hlnJ31P0rRbm8YsurbVCyVklikBqquXJU5U1W2Dn+TLBe+S
 u/M7G4jgat2KKf562M5cLYIrBSOQ8g/C15OqUSeCHkfnGhCTnhIM7bf18B9OnYzE4FmXbY
 zxAWUTJ85Ogo8vsYUMSUYsCe2fhMV3o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-UhkDVGDJMu6s3-6ysdq3pQ-1; Fri,
 19 Sep 2025 07:26:25 -0400
X-MC-Unique: UhkDVGDJMu6s3-6ysdq3pQ-1
X-Mimecast-MFC-AGG-ID: UhkDVGDJMu6s3-6ysdq3pQ_1758281178
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3D8919560B2; Fri, 19 Sep 2025 11:26:18 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE8C530002C5; Fri, 19 Sep 2025 11:26:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 08/16] tracetool: Add Rust format support
Date: Fri, 19 Sep 2025 13:25:28 +0200
Message-ID: <20250919112536.141782-9-pbonzini@redhat.com>
In-Reply-To: <20250919112536.141782-1-pbonzini@redhat.com>
References: <20250919112536.141782-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Tanish Desai <tanishdesai37@gmail.com>

Generating .rs files makes it possible to support tracing in rust.
This support comprises a new format, and common code that converts
the C expressions in trace-events to Rust.  In particular, types
need to be converted, and PRI macros expanded.

As of this commit no backend generates Rust code, but it is already
possible to use tracetool to generate Rust sources; they are not
functional but they compile and contain tracepoint functions.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
[Move Rust argument conversion from Event to Arguments; string
 support. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/tracetool/__init__.py  | 155 +++++++++++++++++++++++++++++++++
 scripts/tracetool/format/rs.py |  71 +++++++++++++++
 2 files changed, 226 insertions(+)
 create mode 100644 scripts/tracetool/format/rs.py

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index a58d7938658..ea3e83f5adf 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -31,6 +31,49 @@ def error(*lines):
     error_write(*lines)
     sys.exit(1)
 
+FMT_TOKEN = re.compile(r'''(?:
+                       " ( (?: [^"\\] | \\[\\"abfnrt] |            # a string literal
+                               \\x[0-9a-fA-F][0-9a-fA-F]) *? ) "
+                       | ( PRI [duixX] (?:8|16|32|64|PTR|MAX) )    # a PRIxxx macro
+                       | \s+                                       # spaces (ignored)
+                       )''', re.X)
+
+PRI_SIZE_MAP = {
+    '8':  'hh',
+    '16': 'h',
+    '32': '',
+    '64': 'll',
+    'PTR': 't',
+    'MAX': 'j',
+}
+
+def expand_format_string(c_fmt, prefix=""):
+    def pri_macro_to_fmt(pri_macro):
+        assert pri_macro.startswith("PRI")
+        fmt_type = pri_macro[3]  # 'd', 'i', 'u', or 'x'
+        fmt_size = pri_macro[4:]  # '8', '16', '32', '64', 'PTR', 'MAX'
+
+        size = PRI_SIZE_MAP.get(fmt_size, None)
+        if size is None:
+            raise Exception(f"unknown macro {pri_macro}")
+        return size + fmt_type
+
+    result = prefix
+    pos = 0
+    while pos < len(c_fmt):
+        m = FMT_TOKEN.match(c_fmt, pos)
+        if not m:
+            print("No match at position", pos, ":", repr(c_fmt[pos:]), file=sys.stderr)
+            raise Exception("syntax error in trace file")
+        if m[1]:
+            substr = m[1]
+        elif m[2]:
+            substr = pri_macro_to_fmt(m[2])
+        else:
+            substr = ""
+        result += substr
+        pos = m.end()
+    return result
 
 out_lineno = 1
 out_filename = '<none>'
@@ -90,6 +133,49 @@ def out(*lines, **kwargs):
     "ptrdiff_t",
 ]
 
+C_TYPE_KEYWORDS = {"char", "int", "void", "short", "long", "signed", "unsigned"}
+
+C_TO_RUST_TYPE_MAP = {
+    "int": "std::ffi::c_int",
+    "long": "std::ffi::c_long",
+    "long long": "std::ffi::c_longlong",
+    "short": "std::ffi::c_short",
+    "char": "std::ffi::c_char",
+    "bool": "bool",
+    "unsigned": "std::ffi::c_uint",
+    # multiple keywords, keep them sorted
+    "long unsigned": "std::ffi::c_long",
+    "long long unsigned": "std::ffi::c_ulonglong",
+    "short unsigned": "std::ffi::c_ushort",
+    "char unsigned": "u8",
+    "int8_t": "i8",
+    "uint8_t": "u8",
+    "int16_t": "i16",
+    "uint16_t": "u16",
+    "int32_t": "i32",
+    "uint32_t": "u32",
+    "int64_t": "i64",
+    "uint64_t": "u64",
+    "void": "()",
+    "size_t": "usize",
+    "ssize_t": "isize",
+    "uintptr_t": "usize",
+    "ptrdiff_t": "isize",
+}
+
+# Rust requires manual casting of <32-bit types when passing them to
+# variable-argument functions.
+RUST_VARARGS_SMALL_TYPES = {
+    "std::ffi::c_short",
+    "std::ffi::c_ushort",
+    "std::ffi::c_char",
+    "i8",
+    "u8",
+    "i16",
+    "u16",
+    "bool",
+}
+
 def validate_type(name):
     bits = name.split(" ")
     for bit in bits:
@@ -105,6 +191,38 @@ def validate_type(name):
                              "other complex pointer types should be "
                              "declared as 'void *'" % name)
 
+def c_type_to_rust(name):
+    ptr = False
+    const = False
+    name = name.rstrip()
+    if name[-1] == '*':
+        name = name[:-1].rstrip()
+        ptr = True
+        if name[-1] == '*':
+            # pointers to pointers are the same as void*
+            name = "void"
+
+    bits = name.split()
+    if "const" in bits:
+        const = True
+        bits.remove("const")
+    if bits[0] in C_TYPE_KEYWORDS:
+        if "signed" in bits:
+            bits.remove("signed")
+        if len(bits) > 1 and "int" in bits:
+            bits.remove("int")
+        bits.sort()
+        name = ' '.join(bits)
+    else:
+        if len(bits) > 1:
+            raise ValueError("Invalid type '%s'." % name)
+        name = bits[0]
+
+    ty = C_TO_RUST_TYPE_MAP[name.strip()]
+    if ptr:
+        ty = f'*{"const" if const else "mut"} {ty}'
+    return ty
+
 class Arguments:
     """Event arguments description."""
 
@@ -193,6 +311,43 @@ def casted(self):
         """List of argument names casted to their type."""
         return ["(%s)%s" % (type_, name) for type_, name in self._args]
 
+    def rust_decl_extern(self):
+        """Return a Rust argument list for an extern "C" function"""
+        return ", ".join((f"_{name}: {c_type_to_rust(type_)}"
+                          for type_, name in self._args))
+
+    def rust_decl(self):
+        """Return a Rust argument list for a tracepoint function"""
+        def decl_type(type_):
+            if type_ == "const char *":
+                return "&std::ffi::CStr"
+            return c_type_to_rust(type_)
+
+        return ", ".join((f"_{name}: {decl_type(type_)}"
+                          for type_, name in self._args))
+
+    def rust_call_extern(self):
+        """Return a Rust argument list for a call to an extern "C" function"""
+        def rust_cast(name, type_):
+            if type_ == "const char *":
+                return f"_{name}.as_ptr()"
+            return f"_{name}"
+
+        return ", ".join((rust_cast(name, type_) for type_, name in self._args))
+
+    def rust_call_varargs(self):
+        """Return a Rust argument list for a call to a C varargs function"""
+        def rust_cast(name, type_):
+            if type_ == "const char *":
+                return f"_{name}.as_ptr()"
+
+            type_ = c_type_to_rust(type_)
+            if type_ in RUST_VARARGS_SMALL_TYPES:
+                return f"_{name} as std::ffi::c_int"
+            return f"_{name} /* as {type_} */"
+
+        return ", ".join((rust_cast(name, type_) for type_, name in self._args))
+
 
 class Event(object):
     """Event description.
diff --git a/scripts/tracetool/format/rs.py b/scripts/tracetool/format/rs.py
new file mode 100644
index 00000000000..c4ab0e59d85
--- /dev/null
+++ b/scripts/tracetool/format/rs.py
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+"""
+trace-DIR.rs
+"""
+
+__author__     = "Tanish Desai <tanishdesai37@gmail.com>"
+__copyright__  = "Copyright 2025, Tanish Desai <tanishdesai37@gmail.com>"
+__license__    = "GPL version 2 or (at your option) any later version"
+
+__maintainer__ = "Stefan Hajnoczi"
+__email__      = "stefanha@redhat.com"
+
+
+from tracetool import out
+
+
+def generate(events, backend, group):
+    out('// SPDX-License-Identifier: GPL-2.0-or-later',
+        '// This file is @generated by tracetool, do not edit.',
+        '',
+        '#[allow(unused_imports)]',
+        'use std::ffi::c_char;',
+        '#[allow(unused_imports)]',
+        'use util::bindings;',
+        '',
+        '#[inline(always)]',
+        'fn trace_event_get_state_dynamic_by_id(_id: u16) -> bool {',
+        '    unsafe { (trace_events_enabled_count != 0) && (_id != 0) }',
+        '}',
+        '',
+        'extern "C" {',
+        '    static mut trace_events_enabled_count: u32;',
+        '}',)
+
+    out('extern "C" {')
+
+    for e in events:
+        out('    static mut %s: u16;' % e.api(e.QEMU_DSTATE))
+    out('}')
+
+    # static state
+    for e in events:
+        if 'disable' in e.properties:
+            enabled = "false"
+        else:
+            enabled = "true"
+
+    backend.generate_begin(events, group)
+
+    for e in events:
+        out('',
+			'#[inline(always)]',
+            '#[allow(dead_code)]',
+            'pub fn %(api)s(%(args)s)',
+            '{',
+            api=e.api(e.QEMU_TRACE),
+            args=e.args.rust_decl())
+
+        if "disable" not in e.properties:
+            backend.generate(e, group, check_trace_event_get_state=False)
+            if backend.check_trace_event_get_state:
+                event_id = 'TRACE_' + e.name.upper()
+                out('    if trace_event_get_state_dynamic_by_id(unsafe { _%(event_id)s_DSTATE}) {',
+                    event_id = event_id,
+                    api=e.api())
+                backend.generate(e, group, check_trace_event_get_state=True)
+                out('    }')
+        out('}')
+
+    backend.generate_end(events, group)
-- 
2.51.0



