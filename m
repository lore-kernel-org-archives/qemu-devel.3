Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A26ACA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQre-0004rY-EY; Fri, 22 Aug 2025 08:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrc-0004qz-Rp
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrV-0002Pg-UD
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755865636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZ0GqsB7rEuShiZCOdvD7xOIhTFHs+MwUr0NXVgYiTA=;
 b=BpF4lrwuBx1zU75VrPbnebwA/xL+L3OAmbGjUE/LopISP1l+vv2U0vbGFCVtFX4I6xFFhZ
 65KQDZf51gKJhb1yu3c+sNL8c92tZvOsYf7FYXfJa++1oFP+sQCD7K5MtFDJtJ/8+qgiQ7
 Zl5COXU//AbMsVORKmrdaQRp/m/42eg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353--Fy4e3oRNHe1dg__KpcaWQ-1; Fri, 22 Aug 2025 08:27:14 -0400
X-MC-Unique: -Fy4e3oRNHe1dg__KpcaWQ-1
X-Mimecast-MFC-AGG-ID: -Fy4e3oRNHe1dg__KpcaWQ_1755865634
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45a1b0ccb6cso10960545e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 05:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755865633; x=1756470433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZ0GqsB7rEuShiZCOdvD7xOIhTFHs+MwUr0NXVgYiTA=;
 b=wYF3a9Dq2buLjdAZt3xyP6+ksaGSUqALBo+jYsAC06epxFPu8VfE4PAa0WO/oaL1Di
 4SygTHl7PuQSGkUx9oGPVPZnzLHWeelYEARwt8OIZPb7lTfhjACpaocq/PpvawPcTutr
 ZDPxJqEShT9OaSSzudkQxb4YxUdpHSyBMKLgMLrcAlr5UPFWaLPE2yON+F/qjW5VR3sW
 A90YjG/DhLVwmlEyru7bmHQMw/DNzGc/wZcAGycD9ZYlRuVT9QCtmGeDY1jsH0FvEe0M
 xVJ8c77Ny7tFggle7a2L3/Tg8n9PnT8dr2JkWFEzWG8CzsmEdrQ8dqWqU+xtWI02H4QW
 9xBw==
X-Gm-Message-State: AOJu0YwXnINv8INamQdT+omaTUNfus7DB1KTBGIyklbuxclE1DZ9rmnf
 Ocbkh+qE/TjRO1XZFyvGypIVVvjHI1oQvXedLLc+EBga3wJo2sT0MqB0GkNDQON7wNbJfM0q5nu
 f3I0pTZsW8SNmBAWo9GVlYRPzZB46tfOjJQHPzpyq3uJ20RiwOfIyLeIN+NEeLstxVckvGBTs6A
 x2oiynpAF3JslYl20MXW6Kr/SfVNgn3SsJUyXsJE+i
X-Gm-Gg: ASbGncuYjJsbZl+HFKv68TXIOCy57VewG+Ss2MjnDi85jDJVmjCSwkeD4RNiiWVpvCz
 BlHhbYIpMSTYVKZQnWC3YOlXDr8aK60AfaYyi6i5LpIbhAB163h6K6G8gsZAIhuvvb1iTKj07RR
 l1oVrOYx7LMYr7WI/aB2B116pDRP9U9E1OdfI6/OIu1/0tkIQebRlgIWNqFar0GE8N5huxpbUMY
 gnibyMBMdeKZexlx9bNcu8WfwbC0TQO96jECqwrLfsfs3Zhjdavdy6FeeNMUQk962KwVixZrJGG
 l86GmAKxU2zxBSySzZM1BQd3qvFL344wGjAYmU0wpCgR4Y+FrhY09QI5M/8phi/fKVeTvUikA3Y
 AlfyCTg5NLx45HTW4VFNb0lBVZw/eYfMAmw51KLzwdg==
X-Received: by 2002:a05:600c:198c:b0:456:1a69:94fd with SMTP id
 5b1f17b1804b1-45b51726dfemr23864675e9.0.1755865633177; 
 Fri, 22 Aug 2025 05:27:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4MHdc4iNiigULTPInEOvp7YDcbXX31Cz8aY8YhsgnDyezJyEqtj1movYA48Eefz6V7Gn/Qg==
X-Received: by 2002:a05:600c:198c:b0:456:1a69:94fd with SMTP id
 5b1f17b1804b1-45b51726dfemr23864355e9.0.1755865632632; 
 Fri, 22 Aug 2025 05:27:12 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c3c89cd4d4sm9401148f8f.42.2025.08.22.05.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 05:27:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tanishdesai37@gmail.com, stefanha@redhat.com, berrange@redhat.com,
 mads@ynddal.dk
Subject: [PATCH 06/14] tracetool: Add Rust format support
Date: Fri, 22 Aug 2025 14:26:47 +0200
Message-ID: <20250822122655.1353197-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822122655.1353197-1-pbonzini@redhat.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Tanish Desai <tanishdesai37@gmail.com>

Generating .rs files makes it possible to support tracing in rust.
This support comprises a new format, and common code that converts
the C expressions in trace-events to Rust.  In particular, types
need to be converted, and PRI macros expanded.  Fortunately, all
common platforms have a known mapping of 8/16/32/64-bit integers
to char/short/int/"long long": even if int64_t is equal to long,
it is fine to change the format string from PRIx64's expansion
"%lx" to "%llx".  This makes it possible to have a static mapping
from PRI macros to their expansion.

As of this commit no backend generates Rust code, but it is already
possible to use tracetool to generate Rust sources; they are not
functional but they compile and contain tracepoint functions.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
[Move Rust argument conversion from Event to Arguments; string
 support. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/tracetool/__init__.py  | 156 +++++++++++++++++++++++++++++++++
 scripts/tracetool/format/rs.py |  76 ++++++++++++++++
 2 files changed, 232 insertions(+)
 create mode 100644 scripts/tracetool/format/rs.py

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 1d5238a0843..0b8ec707332 100644
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
@@ -90,6 +133,48 @@ def out(*lines, **kwargs):
     "ptrdiff_t",
 ]
 
+C_TYPE_KEYWORDS = {"int", "short", "long", "unsigned", "char"}
+
+C_TO_RUST_TYPE_MAP = {
+    "int": "std::ffi::c_int",
+    "long": "std::ffi::c_long",
+    "long long": "std::ffi::c_longlong",
+    "short": "std::ffi::c_short",
+    "char": "std::ffi::c_char",
+    "bool": "bool",
+    "unsigned": "std::ffi::c_uint",
+    "unsigned long": "std::ffi::c_long",
+    "unsigned long long": "std::ffi::c_ulonglong",
+    "unsigned short": "std::ffi::c_ushort",
+    "unsigned char": "u8",
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
@@ -105,6 +190,40 @@ def validate_type(name):
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
+    bits = iter(name.split())
+    bit = next(bits)
+    if bit == "const":
+        const = True
+        bit = next(bits)
+
+    if bit in C_TYPE_KEYWORDS:
+        if bit == 'signed':
+            bit = ''
+        rest = list(bits)
+        if rest and rest[-1] == 'int':
+            rest = rest[:-1]
+        name = bit + ' ' + ' '.join(rest)
+    else:
+        if list(bits):
+            raise ValueError("Invalid type '%s'." % name)
+        name = bit
+
+    ty = C_TO_RUST_TYPE_MAP[name.strip()]
+    if ptr:
+        ty = f'*{"const" if const else "mut"} {ty}'
+    return ty
+
 class Arguments:
     """Event arguments description."""
 
@@ -197,6 +316,43 @@ def casted(self):
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
+            return "_{name}"
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
index 00000000000..bc8b2be5971
--- /dev/null
+++ b/scripts/tracetool/format/rs.py
@@ -0,0 +1,76 @@
+# -*- coding: utf-8 -*-
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
+    out('// This file is autogenerated by tracetool, do not edit.',
+        '',
+        '#[allow(unused_imports)]',
+        'use std::ffi::c_char;',
+        '#[allow(unused_imports)]',
+        'use qemu_api::bindings;',
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
+        if "tcg-exec" in e.properties:
+            # a single define for the two "sub-events"
+            out('const _TRACE_%(name)s_ENABLED: bool = %(enabled)s;',
+                name=e.original.name.upper(),
+				enabled=enabled)
+        out('const _TRACE_%s_ENABLED: bool = %s;' % (e.name.upper(), enabled))
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
2.50.1


