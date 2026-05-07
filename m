Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB239CD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPd-00068t-5E; Wed, 06 May 2026 22:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPb-00067y-DL
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:27 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPZ-0007cY-6P
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:27 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso227759a34.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120663; x=1778725463;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1AyHrG1z3G32na6dyOgtlv711QpW0FiC+Jb7qPaauGQ=;
 b=z2ma2ZzDB5pV+YviV0CwraKSpuxMVx7vJ3F2rKoqH0WjaxmcEiYoSSl9x1Ijy68ydq
 eNVB3OJ05lTmQHesJIuVkkV/lqlhJamZCIfkTj/N+Sdex0g8H6oE8X+wE4G5yIvozHiZ
 UhatL5LpVVPruX5SVsZDOWSZSNepdQf/6hjecv8YXGWkUsPoXwuQm6iD9uIi0IO7FOUx
 luu1smt8tqJZjG71RB/sr/IL+m8DXNHo3Kf5IYp7DQH7CCti6jp3Os1sVy/GIgb7mI8w
 Z4GeDeIAOj+ncWPLuHjgG/QO4uNXBVLuKpxNz56mxbmV3pyDSLOfSwBG5SQy/OaiFKQ+
 IAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120663; x=1778725463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1AyHrG1z3G32na6dyOgtlv711QpW0FiC+Jb7qPaauGQ=;
 b=gnreWHjCNe5ucxW1tfrMhTsWYk1DFkaXujtBc/g+iHBKlLrwpGlmk0yjmqt5QS34My
 MV0YFF0QkD0jaqC7m9MsIr8qceXHo6u5MEKKg64AAjtTo7CAsfIldMo0VmUFKMumY3Kj
 nmfipGll2kNDSvnl098zKvjDfhD3P19umWaZzIX2yFJs1B/xolN/mcTPnqeuts3+6Fl5
 0OI7mmMXHk8ySYj2N2JHIWLhaIuFIEBC+NQUy4OlgQ+wnIi/0x/JrxMhTGpmc3rZBkat
 bl1pIfmmhVkhP/YNI4ZKAIMIp83CtkJBFmVFrH2hdxl2gP6j5FXbEVG32XBvpE22CXkk
 C57A==
X-Gm-Message-State: AOJu0Yw0TVa4GdgmSzG3+UZvjxlOttPqwAOfn+44LVVwlGifrFYeBXN3
 Q7clAJ+QwC1ZqTsoOkw7pzl6mCOjUqosmhT6ApqlQpRcjcW8nwIqin8ftTupJeaPXh62egzBzp5
 CXL0DLUk=
X-Gm-Gg: AeBDietYZoJhnS/+aWVl3rmoCyxtKIODN5LywdKkZ3znFc8bquaiwx3YtxouysLFmah
 VHuQGtwS4e1Z90q5OwlQFKzOh6zY085E8PJT23VmYJXTH8MVUq1SY3YbXNQ1XH8JN1RJZ6qsKWS
 aUMsDy1uB2OgkND3F+fr9DUANBIBPjq0hWzPlLUbg0VhYZ6KexANScFqKEqLoNNmnodfyHjSlcW
 7qUr/KToAPaReJF79L1ZBqHNkr1icXQL6DUNnC3c4YFgL5dyjLW0wz0lfCDfD/DKIN0QqWPLt1u
 v1p64H1LJpDRwEXPYp5dTBAvwN+1/lcb9Wi40l8KEugQEWGkmdglEK/cogteA/tDeCNpXbqctnV
 lwe/HDLHG06Jui0UE4lgHumY2DYlt9s9mbgzO8LP6ZJ8ZBcYr4+WBai7k95AOVX69+JJZiXhDhq
 N1Nvx3AxRDZAKmq1WFYZ6ZFGDdNKF1Mxc=
X-Received: by 2002:a05:6820:f013:b0:694:8b4d:5f8f with SMTP id
 006d021491bc7-69998d6a576mr3177919eaf.57.1778120663202; 
 Wed, 06 May 2026 19:24:23 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:22 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 06/25] bsd-user: Copy linux-user/thunk.c to bsd-user
Date: Wed,  6 May 2026 20:22:00 -0600
Message-ID: <20260507022219.44171-7-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32d;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

bsd-user's blitz branch has used this file verbatim for a while. Copy it
verbatim, but update to the new QEMU standards.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/meson.build |   1 +
 bsd-user/thunk.c     | 470 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 471 insertions(+)
 create mode 100644 bsd-user/thunk.c

diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 00428fc2f8..9cc5c6c459 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -17,6 +17,7 @@ bsd_user_ss.add(files(
   'plugin-api.c',
   'signal.c',
   'strace.c',
+  'thunk.c',
   'uaccess.c',
 ))
 
diff --git a/bsd-user/thunk.c b/bsd-user/thunk.c
new file mode 100644
index 0000000000..3c89ae3ab8
--- /dev/null
+++ b/bsd-user/thunk.c
@@ -0,0 +1,470 @@
+/*
+ * Generic thunking code to convert data between host and target CPU
+ *
+ * Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+
+#include "qemu.h"
+#include "user/thunk.h"
+
+//#define DEBUG
+
+static unsigned int max_struct_entries;
+StructEntry *struct_entries;
+
+static const argtype *thunk_type_next_ptr(const argtype *type_ptr);
+
+static inline const argtype *thunk_type_next(const argtype *type_ptr)
+{
+    int type;
+
+    type = *type_ptr++;
+    switch(type) {
+    case TYPE_CHAR:
+    case TYPE_SHORT:
+    case TYPE_INT:
+    case TYPE_LONGLONG:
+    case TYPE_ULONGLONG:
+    case TYPE_LONG:
+    case TYPE_ULONG:
+    case TYPE_PTRVOID:
+    case TYPE_OLDDEVT:
+        return type_ptr;
+    case TYPE_PTR:
+        return thunk_type_next_ptr(type_ptr);
+    case TYPE_ARRAY:
+        return thunk_type_next_ptr(type_ptr + 1);
+    case TYPE_STRUCT:
+        return type_ptr + 1;
+    default:
+        return NULL;
+    }
+}
+
+static const argtype *thunk_type_next_ptr(const argtype *type_ptr)
+{
+    return thunk_type_next(type_ptr);
+}
+
+void thunk_register_struct(int id, const char *name, const argtype *types)
+{
+    const argtype *type_ptr;
+    StructEntry *se;
+    int nb_fields, offset, max_align, align, size, i, j;
+
+    assert(id < max_struct_entries);
+
+    /* first we count the number of fields */
+    type_ptr = types;
+    nb_fields = 0;
+    while (*type_ptr != TYPE_NULL) {
+        type_ptr = thunk_type_next(type_ptr);
+        nb_fields++;
+    }
+    assert(nb_fields > 0);
+    se = struct_entries + id;
+    se->field_types = types;
+    se->nb_fields = nb_fields;
+    se->name = name;
+#ifdef DEBUG
+    printf("struct %s: id=%d nb_fields=%d\n",
+           se->name, id, se->nb_fields);
+#endif
+    /* now we can alloc the data */
+
+    for (i = 0; i < ARRAY_SIZE(se->field_offsets); i++) {
+        offset = 0;
+        max_align = 1;
+        se->field_offsets[i] = g_new(int, nb_fields);
+        type_ptr = se->field_types;
+        for(j = 0;j < nb_fields; j++) {
+            size = thunk_type_size(type_ptr, i);
+            align = thunk_type_align(type_ptr, i);
+            offset = (offset + align - 1) & ~(align - 1);
+            se->field_offsets[i][j] = offset;
+            offset += size;
+            if (align > max_align)
+                max_align = align;
+            type_ptr = thunk_type_next(type_ptr);
+        }
+        offset = (offset + max_align - 1) & ~(max_align - 1);
+        se->size[i] = offset;
+        se->align[i] = max_align;
+#ifdef DEBUG
+        printf("%s: size=%d align=%d\n",
+               i == THUNK_HOST ? "host" : "target", offset, max_align);
+#endif
+    }
+}
+
+void thunk_register_struct_direct(int id, const char *name,
+                                  const StructEntry *se1)
+{
+    StructEntry *se;
+
+    assert(id < max_struct_entries);
+    se = struct_entries + id;
+    *se = *se1;
+    se->name = name;
+}
+
+
+/* now we can define the main conversion functions */
+const argtype *thunk_convert(void *dst, const void *src,
+                             const argtype *type_ptr, int to_host)
+{
+    int type;
+
+    type = *type_ptr++;
+    switch(type) {
+    case TYPE_CHAR:
+        *(uint8_t *)dst = *(uint8_t *)src;
+        break;
+    case TYPE_SHORT:
+        *(uint16_t *)dst = tswap16(*(uint16_t *)src);
+        break;
+    case TYPE_INT:
+        *(uint32_t *)dst = tswap32(*(uint32_t *)src);
+        break;
+    case TYPE_LONGLONG:
+    case TYPE_ULONGLONG:
+        *(uint64_t *)dst = tswap64(*(uint64_t *)src);
+        break;
+#if HOST_LONG_BITS == 32 && TARGET_ABI_BITS == 32
+    case TYPE_LONG:
+    case TYPE_ULONG:
+    case TYPE_PTRVOID:
+        *(uint32_t *)dst = tswap32(*(uint32_t *)src);
+        break;
+#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 32
+    case TYPE_LONG:
+    case TYPE_ULONG:
+    case TYPE_PTRVOID:
+        if (to_host) {
+            if (type == TYPE_LONG) {
+                /* sign extension */
+                *(uint64_t *)dst = (int32_t)tswap32(*(uint32_t *)src);
+            } else {
+                *(uint64_t *)dst = tswap32(*(uint32_t *)src);
+            }
+        } else {
+            *(uint32_t *)dst = tswap32(*(uint64_t *)src & 0xffffffff);
+        }
+        break;
+#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
+    case TYPE_LONG:
+    case TYPE_ULONG:
+    case TYPE_PTRVOID:
+        *(uint64_t *)dst = tswap64(*(uint64_t *)src);
+        break;
+#elif HOST_LONG_BITS == 32 && TARGET_ABI_BITS == 64
+    case TYPE_LONG:
+    case TYPE_ULONG:
+    case TYPE_PTRVOID:
+        if (to_host) {
+            *(uint32_t *)dst = tswap64(*(uint64_t *)src);
+        } else {
+            if (type == TYPE_LONG) {
+                /* sign extension */
+                *(uint64_t *)dst = tswap64(*(int32_t *)src);
+            } else {
+                *(uint64_t *)dst = tswap64(*(uint32_t *)src);
+            }
+        }
+        break;
+#else
+#warning unsupported conversion
+#endif
+    case TYPE_OLDDEVT:
+    {
+        uint64_t val = 0;
+        switch (thunk_type_size(type_ptr - 1, !to_host)) {
+        case 2:
+            val = *(uint16_t *)src;
+            break;
+        case 4:
+            val = *(uint32_t *)src;
+            break;
+        case 8:
+            val = *(uint64_t *)src;
+            break;
+        }
+        switch (thunk_type_size(type_ptr - 1, to_host)) {
+        case 2:
+            *(uint16_t *)dst = tswap16(val);
+            break;
+        case 4:
+            *(uint32_t *)dst = tswap32(val);
+            break;
+        case 8:
+            *(uint64_t *)dst = tswap64(val);
+            break;
+        }
+        break;
+    }
+    case TYPE_ARRAY:
+        {
+            int array_length, i, dst_size, src_size;
+            const uint8_t *s;
+            uint8_t  *d;
+
+            array_length = *type_ptr++;
+            dst_size = thunk_type_size(type_ptr, to_host);
+            src_size = thunk_type_size(type_ptr, 1 - to_host);
+            d = dst;
+            s = src;
+            for(i = 0;i < array_length; i++) {
+                thunk_convert(d, s, type_ptr, to_host);
+                d += dst_size;
+                s += src_size;
+            }
+            type_ptr = thunk_type_next(type_ptr);
+        }
+        break;
+    case TYPE_STRUCT:
+        {
+            int i;
+            const StructEntry *se;
+            const uint8_t *s;
+            uint8_t  *d;
+            const argtype *field_types;
+            const int *dst_offsets, *src_offsets;
+
+            assert(*type_ptr < max_struct_entries);
+            se = struct_entries + *type_ptr++;
+            if (se->convert[0] != NULL) {
+                /* specific conversion is needed */
+                (*se->convert[to_host])(dst, src);
+            } else {
+                /* standard struct conversion */
+                field_types = se->field_types;
+                dst_offsets = se->field_offsets[to_host];
+                src_offsets = se->field_offsets[1 - to_host];
+                d = dst;
+                s = src;
+                for(i = 0;i < se->nb_fields; i++) {
+                    field_types = thunk_convert(d + dst_offsets[i],
+                                                s + src_offsets[i],
+                                                field_types, to_host);
+                }
+            }
+        }
+        break;
+    default:
+        fprintf(stderr, "Invalid type 0x%x\n", type);
+        break;
+    }
+    return type_ptr;
+}
+
+const argtype *thunk_print(void *arg, const argtype *type_ptr)
+{
+    int type;
+
+    type = *type_ptr++;
+
+    switch (type) {
+    case TYPE_CHAR:
+        qemu_log("%c", *(uint8_t *)arg);
+        break;
+    case TYPE_SHORT:
+        qemu_log("%" PRId16, tswap16(*(uint16_t *)arg));
+        break;
+    case TYPE_INT:
+        qemu_log("%" PRId32, tswap32(*(uint32_t *)arg));
+        break;
+    case TYPE_LONGLONG:
+        qemu_log("%" PRId64, tswap64(*(uint64_t *)arg));
+        break;
+    case TYPE_ULONGLONG:
+        qemu_log("%" PRIu64, tswap64(*(uint64_t *)arg));
+        break;
+#if HOST_LONG_BITS == 32 && TARGET_ABI_BITS == 32
+    case TYPE_PTRVOID:
+        qemu_log("0x%" PRIx32, tswap32(*(uint32_t *)arg));
+        break;
+    case TYPE_LONG:
+        qemu_log("%" PRId32, tswap32(*(uint32_t *)arg));
+        break;
+    case TYPE_ULONG:
+        qemu_log("%" PRIu32, tswap32(*(uint32_t *)arg));
+        break;
+#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 32
+    case TYPE_PTRVOID:
+        qemu_log("0x%" PRIx32, tswap32(*(uint64_t *)arg & 0xffffffff));
+        break;
+    case TYPE_LONG:
+        qemu_log("%" PRId32, tswap32(*(uint64_t *)arg & 0xffffffff));
+        break;
+    case TYPE_ULONG:
+        qemu_log("%" PRIu32, tswap32(*(uint64_t *)arg & 0xffffffff));
+        break;
+#elif HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
+    case TYPE_PTRVOID:
+        qemu_log("0x%" PRIx64, tswap64(*(uint64_t *)arg));
+        break;
+    case TYPE_LONG:
+        qemu_log("%" PRId64, tswap64(*(uint64_t *)arg));
+        break;
+    case TYPE_ULONG:
+        qemu_log("%" PRIu64, tswap64(*(uint64_t *)arg));
+        break;
+#else
+    case TYPE_PTRVOID:
+        qemu_log("0x%" PRIx64, tswap64(*(uint64_t *)arg));
+        break;
+    case TYPE_LONG:
+        qemu_log("%" PRId64, tswap64(*(uint64_t *)arg));
+        break;
+    case TYPE_ULONG:
+        qemu_log("%" PRIu64, tswap64(*(uint64_t *)arg));
+        break;
+#endif
+    case TYPE_OLDDEVT:
+    {
+        uint64_t val = 0;
+        switch (thunk_type_size(type_ptr - 1, 1)) {
+        case 2:
+            val = *(uint16_t *)arg;
+            break;
+        case 4:
+            val = *(uint32_t *)arg;
+            break;
+        case 8:
+            val = *(uint64_t *)arg;
+            break;
+        }
+        switch (thunk_type_size(type_ptr - 1, 0)) {
+        case 2:
+            qemu_log("%" PRIu16, tswap16(val));
+            break;
+        case 4:
+            qemu_log("%" PRIu32, tswap32(val));
+            break;
+        case 8:
+            qemu_log("%" PRIu64, tswap64(val));
+            break;
+        }
+    }
+    break;
+    case TYPE_ARRAY:
+        {
+            int i, array_length, arg_size;
+            uint8_t *a;
+            int is_string = 0;
+
+            array_length = *type_ptr++;
+            arg_size = thunk_type_size(type_ptr, 0);
+            a = arg;
+
+            if (*type_ptr == TYPE_CHAR) {
+                qemu_log("\"");
+                is_string = 1;
+            } else {
+                qemu_log("[");
+            }
+
+            for (i = 0; i < array_length; i++) {
+                if (i > 0 && !is_string) {
+                    qemu_log(",");
+                }
+                thunk_print(a, type_ptr);
+                a += arg_size;
+            }
+
+            if (is_string) {
+                qemu_log("\"");
+            } else {
+                qemu_log("]");
+            }
+
+            type_ptr = thunk_type_next(type_ptr);
+        }
+        break;
+    case TYPE_STRUCT:
+        {
+            int i;
+            const StructEntry *se;
+            uint8_t  *a;
+            const argtype *field_types;
+            const int *arg_offsets;
+
+            se = struct_entries + *type_ptr++;
+
+            if (se->print != NULL) {
+                se->print(arg);
+            } else {
+                a = arg;
+
+                field_types = se->field_types;
+                arg_offsets = se->field_offsets[0];
+
+                qemu_log("{");
+                for (i = 0; i < se->nb_fields; i++) {
+                    if (i > 0) {
+                        qemu_log(",");
+                    }
+                    field_types = thunk_print(a + arg_offsets[i], field_types);
+                }
+                qemu_log("}");
+            }
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return type_ptr;
+}
+
+/* from em86 */
+
+/* Utility function: Table-driven functions to translate bitmasks
+ * between host and target formats
+ */
+unsigned int target_to_host_bitmask_len(unsigned int target_mask,
+                                        const bitmask_transtbl *tbl,
+                                        size_t len)
+{
+    unsigned int host_mask = 0;
+
+    for (size_t i = 0; i < len; ++i) {
+        if ((target_mask & tbl[i].target_mask) == tbl[i].target_bits) {
+            host_mask |= tbl[i].host_bits;
+        }
+    }
+    return host_mask;
+}
+
+unsigned int host_to_target_bitmask_len(unsigned int host_mask,
+                                        const bitmask_transtbl *tbl,
+                                        size_t len)
+{
+    unsigned int target_mask = 0;
+
+    for (size_t i = 0; i < len; ++i) {
+        if ((host_mask & tbl[i].host_mask) == tbl[i].host_bits) {
+            target_mask |= tbl[i].target_bits;
+        }
+    }
+    return target_mask;
+}
+
+int thunk_type_size_array(const argtype *type_ptr, int is_host)
+{
+    return thunk_type_size(type_ptr, is_host);
+}
+
+int thunk_type_align_array(const argtype *type_ptr, int is_host)
+{
+    return thunk_type_align(type_ptr, is_host);
+}
+
+void thunk_init(unsigned int max_structs)
+{
+    max_struct_entries = max_structs;
+    struct_entries = g_new0(StructEntry, max_structs);
+}
-- 
2.52.0


