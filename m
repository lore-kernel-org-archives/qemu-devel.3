Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D01CE8FDA7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 16:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZB2O-0001rS-Pm; Fri, 26 Dec 2025 11:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vZB2N-0001rJ-Hy
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 11:51:35 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vZB2L-0007yx-Fn
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 11:51:35 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-7a9c64dfa8aso5596890b3a.3
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 08:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766767892; x=1767372692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JxhImQV11HMYjuE+qy74enVr07jxwOYuOChJiMcvBEM=;
 b=i8OhbgdnpgwAP1e9MgMQu/O2sbxbZahNMJuZMoZImRLKDdz/DzCUfem3XBSbynV+Id
 KoEaDeIn5rUr85tuXB5xlYKn1cu5heaQpBD+gmP0K+ndVqkGoxsEJeVYJFNxFuoEe31+
 XWfnDNe1wVqQAoStgHyu6mgwhVxN+HypDf27qzIF2+StxU7pF5TdO1MT6XX+eGSJeY9R
 5giYUkY3bhpavSXkAz3ugWSuCPw1paZ/4LrmcXxh6CTxtMgKIba8HO3jgL58qPbXLHoQ
 K5tUaVcsaH7tx99dQdwli+ZMq5c8G62dPamGVyoEEptzHxV99sKIsbdW4Aff8h1761vz
 1mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766767892; x=1767372692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JxhImQV11HMYjuE+qy74enVr07jxwOYuOChJiMcvBEM=;
 b=wsjsaIXkrYQedapC2PK6GugwzwUB08BslwgTZVVx+bkzgdr77dXTOgVJh2N4YUci0a
 S4UCB3kSbUQTZLMp7qYcXyv71Kd9xVCeYGJBXHqoarHMOz+uogQadhOoeWDs7oP0+uCN
 /J6Ja4WyMIMib7em0npPb+Ehh7qPgx3Ga6sq8OYk9TuwDidur/euhX5skz9w75XxUti+
 qPtAkSnRxEyUC7Rl+mndIxzoHyVzJgiuVFv1C8EUSGCZuMpO94YKnsomveUPzSt37afP
 jdEOtKLYqh3IK1hAIpSKV/L9Zsj3rwlVngbwb4kccvhBK78a/bTJRz4yxEbPwFt3HtiJ
 EfLw==
X-Gm-Message-State: AOJu0Yw4MJNag+z2JLdZ4vVfqeXRK7xDTGL/J2UTIXG2pERVDp1QPZW7
 A6zVtpS7741oMn1umkcVwoLiE81sTLpUyBZTIpo2F/Iun5kcXKu2H7YU
X-Gm-Gg: AY/fxX48ZkqoTUMbk1YDx0J255F7vmarzdsbUAIqOcneDfM0wDffU2ZBCIGJyKJaglf
 HgcEQFf8KFPEvWbF4TwGwvlFcwW4CRC+cZ6ksQ8dLH313BeZc/DqWgs+lt0aj5G6dyoL9RhUDWC
 jB1MuC/1gwa1kmtHrELRIZR/BOGIJVPgtVAOWhTX1KgP/0Uv5ug8s8CiwdoyhBIyy0RrxLqwqLf
 fOnnqk8CPNf8wo4mQkpbSTqOVjTWClTotTUI9U4HXFLlolEsQaoUHuTLbutP7mLdZp48VFxi2RO
 rs2WuXrenqrPLNA7vAczoA3WYRQsyXcpe8qWydBT52HDogZ4Dotaxx9fydfXRHUXXdZNdNjoD2N
 Z8xsQ3/j+L0UbFp+Hog6xXnN9id53Rv+E8qX/NVeUAh/qeAkOkMmk7Wzpu8cYon3HnPn8LbflzW
 MoHB1rhbbUMV5kpBXlnmSm4nlQNru8nw==
X-Google-Smtp-Source: AGHT+IFh19ljuQiICjP5f21ppKyf9enTw7/2sjAxeD4J81s0Gfz36yk49CAPOTpk5SThyW3qojZ2lw==
X-Received: by 2002:a05:6a00:742a:b0:7ff:ecbb:1c28 with SMTP id
 d2e1a72fcca58-7ffecbb1f34mr15432047b3a.16.1766767891954; 
 Fri, 26 Dec 2025 08:51:31 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([114.88.97.170])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f300sm22522225b3a.54.2025.12.26.08.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 08:51:31 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: richard.henderson@linaro.org,
	pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, hust-os-kernel-patches@googlegroups.com,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v1 1/3] tcg: add tcg_gen_print helper
Date: Sat, 27 Dec 2025 00:51:19 +0800
Message-ID: <351d52eddf751569872ac1cac9d0d62c6d3c54da.1766767299.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1766767299.git.chao.liu.zevorn@gmail.com>
References: <cover.1766767299.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x443.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Add tcg_gen_print() so translators can dump formatted state without
hand writing helpers. The helper builds a typed descriptor for up to
four arguments and emits a runtime call that prints via qemu_printf().

Example:

```
    tcg_gen_print("const value = 0x%lx\n"
                  TCG_PRINT_ARG_I64, tcg_constant_i64(0xdead),
                  TCG_PRINT_ARG_END);
```

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 accel/tcg/tcg-runtime.c     | 187 ++++++++++++++++++++++++++++++++++++
 accel/tcg/tcg-runtime.h     |   1 +
 include/tcg/tcg-op-common.h |   2 +
 include/tcg/tcg-print.h     |  45 +++++++++
 tcg/tcg-op.c                |  89 +++++++++++++++++
 5 files changed, 324 insertions(+)
 create mode 100644 include/tcg/tcg-print.h

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index fa7ed9739c..e75c1d5702 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -23,9 +23,11 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
+#include "qemu/qemu-print.h"
 #include "exec/cpu-common.h"
 #include "exec/helper-proto-common.h"
 #include "accel/tcg/getpc.h"
+#include "tcg/tcg-print.h"
 
 #define HELPER_H  "accel/tcg/tcg-runtime.h"
 #include "exec/helper-info.c.inc"
@@ -148,3 +150,188 @@ void HELPER(exit_atomic)(CPUArchState *env)
 {
     cpu_loop_exit_atomic(env_cpu(env), GETPC());
 }
+
+static void tcg_print_skip_format(const char **pfmt)
+{
+    const char *p = *pfmt;
+
+    while (*p) {
+        char c = *p;
+
+        if (c == 'l' || c == 'h' || c == 'z' || c == 't' ||
+            c == 'j' || c == '*') {
+            p++;
+            continue;
+        }
+        if (strchr("diuoxXp", c) || c == '%') {
+            p++;
+            break;
+        }
+        p++;
+    }
+    *pfmt = p;
+}
+
+static bool tcg_print_emit_arg(GString *out, const char **pfmt,
+                               TCGPrintArgType type, uint64_t value)
+{
+    const char *p = *pfmt;
+    char prefix[32];
+    size_t prelen = 0;
+
+    if (*p == '\0') {
+        tcg_print_skip_format(pfmt);
+        return false;
+    }
+
+    prefix[prelen++] = '%';
+    while (*p) {
+        char c = *p;
+
+        if (c == '*') {
+            tcg_print_skip_format(pfmt);
+            return false;
+        }
+        if (c == 'l' || c == 'h' || c == 'z' || c == 't' || c == 'j') {
+            p++;
+            continue;
+        }
+        if (strchr("diuoxXp", c)) {
+            char fmtbuf[64];
+            size_t len;
+
+            if (prelen >= sizeof(fmtbuf)) {
+                tcg_print_skip_format(pfmt);
+                return false;
+            }
+            memcpy(fmtbuf, prefix, prelen);
+            len = prelen;
+            if (c != 'p' &&
+                (type == TCG_PRINT_ARG_I64 ||
+                (type == TCG_PRINT_ARG_PTR &&
+                 sizeof(uintptr_t) == 8))) {
+                if (len + 2 >= sizeof(fmtbuf)) {
+                    tcg_print_skip_format(pfmt);
+                    return false;
+                }
+                fmtbuf[len++] = 'l';
+                fmtbuf[len++] = 'l';
+            }
+            if (len + 1 >= sizeof(fmtbuf)) {
+                tcg_print_skip_format(pfmt);
+                return false;
+            }
+            fmtbuf[len++] = c;
+            fmtbuf[len] = '\0';
+
+            char tmp[128];
+            bool ok = true;
+
+            switch (c) {
+            case 'd':
+            case 'i':
+                if (type == TCG_PRINT_ARG_I64 ||
+                    (type == TCG_PRINT_ARG_PTR &&
+                     sizeof(uintptr_t) == 8)) {
+                    g_snprintf(tmp, sizeof(tmp), fmtbuf,
+                               (long long)(int64_t)value);
+                } else if (type == TCG_PRINT_ARG_I32 ||
+                           (type == TCG_PRINT_ARG_PTR &&
+                            sizeof(uintptr_t) == 4)) {
+                    g_snprintf(tmp, sizeof(tmp), fmtbuf,
+                               (int)(int32_t)value);
+                } else {
+                    ok = false;
+                }
+                break;
+            case 'u':
+            case 'o':
+            case 'x':
+            case 'X':
+                if (type == TCG_PRINT_ARG_I64 ||
+                    (type == TCG_PRINT_ARG_PTR &&
+                     sizeof(uintptr_t) == 8)) {
+                    g_snprintf(tmp, sizeof(tmp), fmtbuf,
+                               (unsigned long long)value);
+                } else if (type == TCG_PRINT_ARG_I32 ||
+                           (type == TCG_PRINT_ARG_PTR &&
+                            sizeof(uintptr_t) == 4)) {
+                    g_snprintf(tmp, sizeof(tmp), fmtbuf,
+                               (unsigned int)(uint32_t)value);
+                } else {
+                    ok = false;
+                }
+                break;
+            case 'p':
+                g_snprintf(tmp, sizeof(tmp), fmtbuf,
+                           (void *)(uintptr_t)value);
+                break;
+            default:
+                ok = false;
+                break;
+            }
+
+            if (!ok) {
+                tcg_print_skip_format(pfmt);
+                return false;
+            }
+            g_string_append(out, tmp);
+            *pfmt = p + 1;
+            return true;
+        }
+        if (prelen + 1 >= sizeof(prefix)) {
+            tcg_print_skip_format(pfmt);
+            return false;
+        }
+        prefix[prelen++] = c;
+        p++;
+    }
+    tcg_print_skip_format(pfmt);
+    return false;
+}
+
+void HELPER(tcg_print)(void *fmt_ptr, uint32_t desc,
+                       uint64_t v0, uint64_t v1,
+                       uint64_t v2, uint64_t v3,
+                       uint64_t v4)
+{
+    const char *fmt = fmt_ptr;
+    uint64_t values[TCG_PRINT_MAX_ARGS] = { v0, v1, v2, v3, v4 };
+    TCGPrintArgType types[TCG_PRINT_MAX_ARGS];
+    GString *msg = g_string_new(NULL);
+    unsigned count = tcg_print_desc_count(desc);
+    unsigned i;
+    unsigned arg_index = 0;
+
+    g_assert(count <= TCG_PRINT_MAX_ARGS);
+
+    for (i = 0; i < count && i < TCG_PRINT_MAX_ARGS; i++) {
+        types[i] = tcg_print_desc_type(desc, i);
+    }
+
+    while (*fmt) {
+        if (*fmt != '%') {
+            g_string_append_c(msg, *fmt++);
+            continue;
+        }
+        fmt++;
+        if (*fmt == '%') {
+            g_string_append_c(msg, '%');
+            fmt++;
+            continue;
+        }
+        if (arg_index >= count) {
+            tcg_print_skip_format(&fmt);
+            g_string_append(msg, "<missing>");
+            continue;
+        }
+        if (!tcg_print_emit_arg(msg, &fmt, types[arg_index],
+                                 values[arg_index])) {
+            g_string_append(msg, "<fmt?>");
+        }
+        arg_index++;
+    }
+
+    qemu_printf("%s", msg->str);
+    g_string_free(msg, TRUE);
+}
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 8436599b9f..6b1f0c0b13 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -27,6 +27,7 @@ DEF_HELPER_FLAGS_1(ctpop_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, cptr, env)
 
 DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
+DEF_HELPER_FLAGS_7(tcg_print, 0, void, ptr, i32, i64, i64, i64, i64, i64)
 
 #ifndef IN_HELPER_PROTO
 /*
diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f752ef440b..858137cf41 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -9,6 +9,7 @@
 #define TCG_TCG_OP_COMMON_H
 
 #include "tcg/tcg.h"
+#include "tcg/tcg-print.h"
 #include "exec/helper-proto-common.h"
 #include "exec/helper-gen-common.h"
 
@@ -77,6 +78,7 @@ void tcg_gen_lookup_and_goto_ptr(void);
 
 void tcg_gen_plugin_cb(unsigned from);
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
+void tcg_gen_print(const char *fmt, ...);
 
 /* 32 bit ops */
 
diff --git a/include/tcg/tcg-print.h b/include/tcg/tcg-print.h
new file mode 100644
index 0000000000..40a2dd9d40
--- /dev/null
+++ b/include/tcg/tcg-print.h
@@ -0,0 +1,45 @@
+/*
+ * Shared definitions for the TCG printf-style helper.
+ *
+ * Copyright (c) 2025 Chao Liu <chao.liu.zevorn@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef TCG_TCG_PRINT_H
+#define TCG_TCG_PRINT_H
+
+#define TCG_PRINT_MAX_ARGS 5
+
+typedef enum TCGPrintArgType {
+    TCG_PRINT_ARG_END = 0,
+    TCG_PRINT_ARG_I32 = 1,
+    TCG_PRINT_ARG_I64 = 2,
+    TCG_PRINT_ARG_PTR = 3,
+} TCGPrintArgType;
+
+#define TCG_PRINT_DESC_COUNT_MASK 0xF
+#define TCG_PRINT_DESC_SHIFT 4
+#define TCG_PRINT_DESC_BITS_PER_ARG 3
+#define TCG_PRINT_DESC_TYPE_MASK ((1u << TCG_PRINT_DESC_BITS_PER_ARG) - 1)
+
+static inline unsigned tcg_print_desc_count(uint32_t desc)
+{
+    return desc & TCG_PRINT_DESC_COUNT_MASK;
+}
+
+static inline unsigned tcg_print_desc_type(uint32_t desc, unsigned index)
+{
+    return (desc >> (TCG_PRINT_DESC_SHIFT +
+                     index * TCG_PRINT_DESC_BITS_PER_ARG))
+        & TCG_PRINT_DESC_TYPE_MASK;
+}
+
+static inline uint32_t tcg_print_desc_add_type(uint32_t desc, unsigned index,
+                                               TCGPrintArgType type)
+{
+    return desc | ((uint32_t)type & TCG_PRINT_DESC_TYPE_MASK)
+        << (TCG_PRINT_DESC_SHIFT + index * TCG_PRINT_DESC_BITS_PER_ARG);
+}
+
+#endif /* TCG_TCG_PRINT_H */
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ab7b409be6..44d50c84da 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -323,6 +323,95 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     tcg_gen_op2(INDEX_op_plugin_mem_cb, 0, tcgv_i64_arg(addr), meminfo);
 }
 
+void tcg_gen_print(const char *fmt, ...)
+{
+    TCGTemp *temps[TCG_PRINT_MAX_ARGS];
+    TCGPrintArgType kinds[TCG_PRINT_MAX_ARGS];
+    TCGv_i64 values[TCG_PRINT_MAX_ARGS];
+    TCGv_i64 to_free[TCG_PRINT_MAX_ARGS];
+    int free_count = 0;
+    int count = 0;
+    va_list ap;
+    uint32_t desc;
+    TCGv_ptr fmt_ptr;
+    TCGv_i32 desc_arg;
+    TCGv_i64 zero;
+    int i;
+
+    QEMU_BUILD_BUG_ON(TCG_PRINT_MAX_ARGS != 5);
+
+    va_start(ap, fmt);
+    for (;;) {
+        int kind = va_arg(ap, int);
+
+        if (kind == TCG_PRINT_ARG_END) {
+            break;
+        }
+        g_assert(count < TCG_PRINT_MAX_ARGS);
+
+        switch (kind) {
+        case TCG_PRINT_ARG_I32:
+            temps[count] = tcgv_i32_temp(va_arg(ap, TCGv_i32));
+            break;
+        case TCG_PRINT_ARG_I64:
+            temps[count] = tcgv_i64_temp(va_arg(ap, TCGv_i64));
+            break;
+        case TCG_PRINT_ARG_PTR:
+            temps[count] = tcgv_ptr_temp(va_arg(ap, TCGv_ptr));
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        kinds[count++] = kind;
+    }
+    va_end(ap);
+
+    desc = count;
+    for (i = 0; i < count; i++) {
+        desc = tcg_print_desc_add_type(desc, i, kinds[i]);
+    }
+
+    fmt_ptr = tcg_constant_ptr(fmt);
+    desc_arg = tcg_constant_i32(desc);
+    zero = tcg_constant_i64(0);
+
+    for (i = 0; i < count; i++) {
+        switch (kinds[i]) {
+        case TCG_PRINT_ARG_I32:
+            values[i] = tcg_temp_ebb_new_i64();
+            tcg_gen_extu_i32_i64(values[i], temp_tcgv_i32(temps[i]));
+            to_free[free_count++] = values[i];
+            break;
+        case TCG_PRINT_ARG_I64:
+            values[i] = temp_tcgv_i64(temps[i]);
+            break;
+        case TCG_PRINT_ARG_PTR:
+#if UINTPTR_MAX == UINT32_MAX
+            values[i] = tcg_temp_ebb_new_i64();
+            tcg_gen_extu_i32_i64(values[i],
+                                 (TCGv_i32)temp_tcgv_ptr(temps[i]));
+            to_free[free_count++] = values[i];
+#else
+            values[i] = temp_tcgv_i64(temps[i]);
+#endif
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+    for (; i < TCG_PRINT_MAX_ARGS; i++) {
+        values[i] = zero;
+    }
+
+    gen_helper_tcg_print(fmt_ptr, desc_arg,
+                         values[0], values[1], values[2], values[3],
+                         values[4]);
+
+    for (i = 0; i < free_count; i++) {
+        tcg_temp_free_i64(to_free[i]);
+    }
+}
+
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
-- 
2.52.0


