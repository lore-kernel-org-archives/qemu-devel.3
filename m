Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573F0C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5n-0005yZ-Ry; Wed, 24 Apr 2024 19:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5i-0005v4-89
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:54 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5e-0003UE-Kl
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:53 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2a614b0391dso372881a91.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001509; x=1714606309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pp0+YXVT5Ke/IjF6zfAube67/o8HFdzfuGERssKOo+k=;
 b=zK9oWMuEfKM8XOvGyfIxpMlLgMZ97++8n5780qBW6WfCUSHGMsCmIn/I/saiZ80lRq
 QBiUNZcwLwI/gNcKG7s22WbK17YOpBgrvSnkcmpCtVljIRAkpHgG1uMzu7/I/8jQ8pe8
 9poA+D+1J42ZRslsDQ/VSncUXMCqVMGZBaxlYVJgClKfIV/XTP0r3H9GsgSk/moxuQD3
 z9YpiPgv6YfofQwhplqy92NpeNWeiecKigrJuR2IOTrCy/JbGkfoMMBc6mkSCxoLe91M
 O7+DSGqXS8zTTFp0kqZsSEv4D3AzrqOHBJSPUc0SVLN5gpaHq9o+i1VDjWaOqlUuwVnf
 Pp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001509; x=1714606309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pp0+YXVT5Ke/IjF6zfAube67/o8HFdzfuGERssKOo+k=;
 b=NWcpN/DCoNObTwjDYGobbePTkWxpHKMQERAxcKLzNI7h81vAEBqxBXbW2gY9uSkzhg
 8fScshG9/CfVZIfERCx7QvpNm9H+i8rcwpCs/SnW5PkXnI2cCzZUcytA9D/T902N872B
 48Bi6Zvlz4VzIECe3XYfQR1KgjmCkeKDoVCmnApnu7Uvdnxd3iIQqKTyueJ7okPk3Sj9
 Yv7ktUXxuFtbEMttWH5bEvhTyS1VEa/G6egzq5KMGG/QWgn998eSwEvLbaGOG7E1BRMH
 WCnXlhy4KyOOTyZ8h/o/819adhSnQW3+bF377eIa2/EfNw/EQqYbBBe30stTTcvgEfQj
 KdQA==
X-Gm-Message-State: AOJu0YyL5I5pstNdG1TL0yKodoYXDvFNIPUJPjSMtvDRw9PuR6DLj2C/
 05aR1Hzm4x18os4UGdai5CQhQEXp+4qvHJYqGF2bhQ853Nr87FWAxqK2BhofW4GfQ+Seelxg21k
 r
X-Google-Smtp-Source: AGHT+IFXIjpV5ddsKc3PAg9aso6KvKk+WbxQkDz9rYmGYZfY6nhFgSFuYwvtg7yMxwue3PKBtEFytg==
X-Received: by 2002:a17:90b:3506:b0:2a7:e71:eb72 with SMTP id
 ls6-20020a17090b350600b002a70e71eb72mr4117027pjb.0.1714001508870; 
 Wed, 24 Apr 2024 16:31:48 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 18/33] disas: Split disas.c
Date: Wed, 24 Apr 2024 16:31:16 -0700
Message-Id: <20240424233131.988727-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The routines in disas-common.c are also used from disas-mon.c.
Otherwise the rest of disassembly is only used from tcg.
While we're at it, put host and target code into separate files.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/disas-internal.h |   4 +
 include/disas/disas.h  |   4 +
 disas/disas-common.c   | 117 ++++++++++++++
 disas/disas-host.c     | 129 ++++++++++++++++
 disas/disas-target.c   |  84 ++++++++++
 disas/disas.c          | 337 -----------------------------------------
 disas/objdump.c        |  37 +++++
 disas/meson.build      |   8 +-
 8 files changed, 381 insertions(+), 339 deletions(-)
 create mode 100644 disas/disas-common.c
 create mode 100644 disas/disas-host.c
 create mode 100644 disas/disas-target.c
 delete mode 100644 disas/disas.c
 create mode 100644 disas/objdump.c

diff --git a/disas/disas-internal.h b/disas/disas-internal.h
index 84a01f126f..ed32e704cc 100644
--- a/disas/disas-internal.h
+++ b/disas/disas-internal.h
@@ -14,8 +14,12 @@ typedef struct CPUDebug {
     CPUState *cpu;
 } CPUDebug;
 
+void disas_initialize_debug(CPUDebug *s);
 void disas_initialize_debug_target(CPUDebug *s, CPUState *cpu);
 int disas_gstring_printf(FILE *stream, const char *fmt, ...)
     G_GNUC_PRINTF(2, 3);
 
+int print_insn_od_host(bfd_vma pc, disassemble_info *info);
+int print_insn_od_target(bfd_vma pc, disassemble_info *info);
+
 #endif
diff --git a/include/disas/disas.h b/include/disas/disas.h
index 176775eff7..54a5e68443 100644
--- a/include/disas/disas.h
+++ b/include/disas/disas.h
@@ -2,13 +2,17 @@
 #define QEMU_DISAS_H
 
 /* Disassemble this for me please... (debugging). */
+#ifdef CONFIG_TCG
 void disas(FILE *out, const void *code, size_t size);
 void target_disas(FILE *out, CPUState *cpu, uint64_t code, size_t size);
+#endif
 
 void monitor_disas(Monitor *mon, CPUState *cpu, uint64_t pc,
                    int nb_insn, bool is_physical);
 
+#ifdef CONFIG_PLUGIN
 char *plugin_disas(CPUState *cpu, uint64_t addr, size_t size);
+#endif
 
 /* Look up symbol for debugging purpose.  Returns "" if unknown. */
 const char *lookup_symbol(uint64_t orig_addr);
diff --git a/disas/disas-common.c b/disas/disas-common.c
new file mode 100644
index 0000000000..e4118a381f
--- /dev/null
+++ b/disas/disas-common.c
@@ -0,0 +1,117 @@
+/*
+ * Common routines for disassembly.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "disas/disas.h"
+#include "disas/capstone.h"
+#include "hw/core/cpu.h"
+#include "exec/memory.h"
+#include "disas-internal.h"
+
+
+/* Filled in by elfload.c.  Simplistic, but will do for now. */
+struct syminfo *syminfos = NULL;
+
+/*
+ * Get LENGTH bytes from info's buffer, at target address memaddr.
+ * Transfer them to myaddr.
+ */
+static int target_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
+                              struct disassemble_info *info)
+{
+    CPUDebug *s = container_of(info, CPUDebug, info);
+    int r = cpu_memory_rw_debug(s->cpu, memaddr, myaddr, length, 0);
+    return r ? EIO : 0;
+}
+
+/*
+ * Print an error message.  We can assume that this is in response to
+ * an error return from {host,target}_read_memory.
+ */
+static void perror_memory(int status, bfd_vma memaddr,
+                          struct disassemble_info *info)
+{
+    if (status != EIO) {
+        /* Can't happen.  */
+        info->fprintf_func(info->stream, "Unknown error %d\n", status);
+    } else {
+        /* Address between memaddr and memaddr + len was out of bounds.  */
+        info->fprintf_func(info->stream,
+                           "Address 0x%" PRIx64 " is out of bounds.\n",
+                           memaddr);
+    }
+}
+
+/* Print address in hex. */
+static void print_address(bfd_vma addr, struct disassemble_info *info)
+{
+    info->fprintf_func(info->stream, "0x%" PRIx64, addr);
+}
+
+/* Stub prevents some fruitless earching in optabs disassemblers. */
+static int symbol_at_address(bfd_vma addr, struct disassemble_info *info)
+{
+    return 1;
+}
+
+void disas_initialize_debug(CPUDebug *s)
+{
+    memset(s, 0, sizeof(*s));
+    s->info.arch = bfd_arch_unknown;
+    s->info.cap_arch = -1;
+    s->info.cap_insn_unit = 4;
+    s->info.cap_insn_split = 4;
+    s->info.memory_error_func = perror_memory;
+    s->info.symbol_at_address_func = symbol_at_address;
+}
+
+void disas_initialize_debug_target(CPUDebug *s, CPUState *cpu)
+{
+    disas_initialize_debug(s);
+
+    s->cpu = cpu;
+    s->info.read_memory_func = target_read_memory;
+    s->info.print_address_func = print_address;
+    if (target_words_bigendian()) {
+        s->info.endian = BFD_ENDIAN_BIG;
+    } else {
+        s->info.endian =  BFD_ENDIAN_LITTLE;
+    }
+
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    if (cc->disas_set_info) {
+        cc->disas_set_info(cpu, &s->info);
+    }
+}
+
+int disas_gstring_printf(FILE *stream, const char *fmt, ...)
+{
+    /* We abuse the FILE parameter to pass a GString. */
+    GString *s = (GString *)stream;
+    int initial_len = s->len;
+    va_list va;
+
+    va_start(va, fmt);
+    g_string_append_vprintf(s, fmt, va);
+    va_end(va);
+
+    return s->len - initial_len;
+}
+
+/* Look up symbol for debugging purpose.  Returns "" if unknown. */
+const char *lookup_symbol(uint64_t orig_addr)
+{
+    const char *symbol = "";
+    struct syminfo *s;
+
+    for (s = syminfos; s; s = s->next) {
+        symbol = s->lookup_symbol(s, orig_addr);
+        if (symbol[0] != '\0') {
+            break;
+        }
+    }
+
+    return symbol;
+}
diff --git a/disas/disas-host.c b/disas/disas-host.c
new file mode 100644
index 0000000000..8146fafe80
--- /dev/null
+++ b/disas/disas-host.c
@@ -0,0 +1,129 @@
+/*
+ * Routines for host instruction disassembly.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "disas/disas.h"
+#include "disas/capstone.h"
+#include "disas-internal.h"
+
+
+/*
+ * Get LENGTH bytes from info's buffer, at host address memaddr.
+ * Transfer them to myaddr.
+ */
+static int host_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
+                            struct disassemble_info *info)
+{
+    if (memaddr < info->buffer_vma
+        || memaddr + length > info->buffer_vma + info->buffer_length) {
+        /* Out of bounds.  Use EIO because GDB uses it.  */
+        return EIO;
+    }
+    memcpy (myaddr, info->buffer + (memaddr - info->buffer_vma), length);
+    return 0;
+}
+
+/* Print address in hex, truncated to the width of a host virtual address. */
+static void host_print_address(bfd_vma addr, struct disassemble_info *info)
+{
+    info->fprintf_func(info->stream, "0x%" PRIxPTR, (uintptr_t)addr);
+}
+
+static void initialize_debug_host(CPUDebug *s)
+{
+    disas_initialize_debug(s);
+
+    s->info.read_memory_func = host_read_memory;
+    s->info.print_address_func = host_print_address;
+#if HOST_BIG_ENDIAN
+    s->info.endian = BFD_ENDIAN_BIG;
+#else
+    s->info.endian = BFD_ENDIAN_LITTLE;
+#endif
+#if defined(CONFIG_TCG_INTERPRETER)
+    s->info.print_insn = print_insn_tci;
+#elif defined(__i386__)
+    s->info.mach = bfd_mach_i386_i386;
+    s->info.cap_arch = CS_ARCH_X86;
+    s->info.cap_mode = CS_MODE_32;
+    s->info.cap_insn_unit = 1;
+    s->info.cap_insn_split = 8;
+#elif defined(__x86_64__)
+    s->info.mach = bfd_mach_x86_64;
+    s->info.cap_arch = CS_ARCH_X86;
+    s->info.cap_mode = CS_MODE_64;
+    s->info.cap_insn_unit = 1;
+    s->info.cap_insn_split = 8;
+#elif defined(_ARCH_PPC)
+    s->info.cap_arch = CS_ARCH_PPC;
+# ifdef _ARCH_PPC64
+    s->info.cap_mode = CS_MODE_64;
+# endif
+#elif defined(__riscv)
+#if defined(_ILP32) || (__riscv_xlen == 32)
+    s->info.print_insn = print_insn_riscv32;
+#elif defined(_LP64)
+    s->info.print_insn = print_insn_riscv64;
+#else
+#error unsupported RISC-V ABI
+#endif
+#elif defined(__aarch64__)
+    s->info.cap_arch = CS_ARCH_ARM64;
+#elif defined(__alpha__)
+    s->info.print_insn = print_insn_alpha;
+#elif defined(__sparc__)
+    s->info.print_insn = print_insn_sparc;
+    s->info.mach = bfd_mach_sparc_v9b;
+#elif defined(__arm__)
+    /* TCG only generates code for arm mode.  */
+    s->info.cap_arch = CS_ARCH_ARM;
+#elif defined(__MIPSEB__)
+    s->info.print_insn = print_insn_big_mips;
+#elif defined(__MIPSEL__)
+    s->info.print_insn = print_insn_little_mips;
+#elif defined(__m68k__)
+    s->info.print_insn = print_insn_m68k;
+#elif defined(__s390__)
+    s->info.cap_arch = CS_ARCH_SYSZ;
+    s->info.cap_insn_unit = 2;
+    s->info.cap_insn_split = 6;
+#elif defined(__hppa__)
+    s->info.print_insn = print_insn_hppa;
+#elif defined(__loongarch__)
+    s->info.print_insn = print_insn_loongarch;
+#endif
+}
+
+/* Disassemble this for me please... (debugging). */
+void disas(FILE *out, const void *code, size_t size)
+{
+    uintptr_t pc;
+    int count;
+    CPUDebug s;
+
+    initialize_debug_host(&s);
+    s.info.fprintf_func = fprintf;
+    s.info.stream = out;
+    s.info.buffer = code;
+    s.info.buffer_vma = (uintptr_t)code;
+    s.info.buffer_length = size;
+    s.info.show_opcodes = true;
+
+    if (s.info.cap_arch >= 0 && cap_disas_host(&s.info, code, size)) {
+        return;
+    }
+
+    if (s.info.print_insn == NULL) {
+        s.info.print_insn = print_insn_od_host;
+    }
+    for (pc = (uintptr_t)code; size > 0; pc += count, size -= count) {
+        fprintf(out, "0x%08" PRIxPTR ":  ", pc);
+        count = s.info.print_insn(pc, &s.info);
+        fprintf(out, "\n");
+        if (count < 0) {
+            break;
+        }
+    }
+}
diff --git a/disas/disas-target.c b/disas/disas-target.c
new file mode 100644
index 0000000000..82313b2a67
--- /dev/null
+++ b/disas/disas-target.c
@@ -0,0 +1,84 @@
+/*
+ * Routines for target instruction disassembly.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "disas/disas.h"
+#include "disas/capstone.h"
+#include "disas-internal.h"
+
+
+void target_disas(FILE *out, CPUState *cpu, uint64_t code, size_t size)
+{
+    uint64_t pc;
+    int count;
+    CPUDebug s;
+
+    disas_initialize_debug_target(&s, cpu);
+    s.info.fprintf_func = fprintf;
+    s.info.stream = out;
+    s.info.buffer_vma = code;
+    s.info.buffer_length = size;
+    s.info.show_opcodes = true;
+
+    if (s.info.cap_arch >= 0 && cap_disas_target(&s.info, code, size)) {
+        return;
+    }
+
+    if (s.info.print_insn == NULL) {
+        s.info.print_insn = print_insn_od_target;
+    }
+
+    for (pc = code; size > 0; pc += count, size -= count) {
+        fprintf(out, "0x%08" PRIx64 ":  ", pc);
+        count = s.info.print_insn(pc, &s.info);
+        fprintf(out, "\n");
+        if (count < 0) {
+            break;
+        }
+        if (size < count) {
+            fprintf(out,
+                    "Disassembler disagrees with translator over instruction "
+                    "decoding\n"
+                    "Please report this to qemu-devel@nongnu.org\n");
+            break;
+        }
+    }
+}
+
+#ifdef CONFIG_PLUGIN
+static void plugin_print_address(bfd_vma addr, struct disassemble_info *info)
+{
+    /* does nothing */
+}
+
+/*
+ * We should only be dissembling one instruction at a time here. If
+ * there is left over it usually indicates the front end has read more
+ * bytes than it needed.
+ */
+char *plugin_disas(CPUState *cpu, uint64_t addr, size_t size)
+{
+    CPUDebug s;
+    GString *ds = g_string_new(NULL);
+
+    disas_initialize_debug_target(&s, cpu);
+    s.info.fprintf_func = disas_gstring_printf;
+    s.info.stream = (FILE *)ds;  /* abuse this slot */
+    s.info.buffer_vma = addr;
+    s.info.buffer_length = size;
+    s.info.print_address_func = plugin_print_address;
+
+    if (s.info.cap_arch >= 0 && cap_disas_plugin(&s.info, addr, size)) {
+        ; /* done */
+    } else if (s.info.print_insn) {
+        s.info.print_insn(addr, &s.info);
+    } else {
+        ; /* cannot disassemble -- return empty string */
+    }
+
+    /* Return the buffer, freeing the GString container.  */
+    return g_string_free(ds, false);
+}
+#endif /* CONFIG_PLUGIN */
diff --git a/disas/disas.c b/disas/disas.c
deleted file mode 100644
index 7e3b0bb46c..0000000000
--- a/disas/disas.c
+++ /dev/null
@@ -1,337 +0,0 @@
-/* General "disassemble this chunk" code.  Used for debugging. */
-#include "qemu/osdep.h"
-#include "disas/disas-internal.h"
-#include "elf.h"
-#include "qemu/qemu-print.h"
-#include "disas/disas.h"
-#include "disas/capstone.h"
-#include "hw/core/cpu.h"
-#include "exec/memory.h"
-
-/* Filled in by elfload.c.  Simplistic, but will do for now. */
-struct syminfo *syminfos = NULL;
-
-/*
- * Get LENGTH bytes from info's buffer, at host address memaddr.
- * Transfer them to myaddr.
- */
-static int host_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
-                            struct disassemble_info *info)
-{
-    if (memaddr < info->buffer_vma
-        || memaddr + length > info->buffer_vma + info->buffer_length) {
-        /* Out of bounds.  Use EIO because GDB uses it.  */
-        return EIO;
-    }
-    memcpy (myaddr, info->buffer + (memaddr - info->buffer_vma), length);
-    return 0;
-}
-
-/*
- * Get LENGTH bytes from info's buffer, at target address memaddr.
- * Transfer them to myaddr.
- */
-static int target_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
-                              struct disassemble_info *info)
-{
-    CPUDebug *s = container_of(info, CPUDebug, info);
-    int r = cpu_memory_rw_debug(s->cpu, memaddr, myaddr, length, 0);
-    return r ? EIO : 0;
-}
-
-/*
- * Print an error message.  We can assume that this is in response to
- * an error return from {host,target}_read_memory.
- */
-static void perror_memory(int status, bfd_vma memaddr,
-                          struct disassemble_info *info)
-{
-    if (status != EIO) {
-        /* Can't happen.  */
-        info->fprintf_func(info->stream, "Unknown error %d\n", status);
-    } else {
-        /* Address between memaddr and memaddr + len was out of bounds.  */
-        info->fprintf_func(info->stream,
-                           "Address 0x%" PRIx64 " is out of bounds.\n",
-                           memaddr);
-    }
-}
-
-/* Print address in hex. */
-static void print_address(bfd_vma addr, struct disassemble_info *info)
-{
-    info->fprintf_func(info->stream, "0x%" PRIx64, addr);
-}
-
-/* Print address in hex, truncated to the width of a host virtual address. */
-static void host_print_address(bfd_vma addr, struct disassemble_info *info)
-{
-    print_address((uintptr_t)addr, info);
-}
-
-/* Stub prevents some fruitless earching in optabs disassemblers. */
-static int symbol_at_address(bfd_vma addr, struct disassemble_info *info)
-{
-    return 1;
-}
-
-static int print_insn_objdump(bfd_vma pc, disassemble_info *info,
-                              const char *prefix)
-{
-    int i, n = info->buffer_length;
-    g_autofree uint8_t *buf = g_malloc(n);
-
-    if (info->read_memory_func(pc, buf, n, info) == 0) {
-        for (i = 0; i < n; ++i) {
-            if (i % 32 == 0) {
-                info->fprintf_func(info->stream, "\n%s: ", prefix);
-            }
-            info->fprintf_func(info->stream, "%02x", buf[i]);
-        }
-    } else {
-        info->fprintf_func(info->stream, "unable to read memory");
-    }
-    return n;
-}
-
-static int print_insn_od_host(bfd_vma pc, disassemble_info *info)
-{
-    return print_insn_objdump(pc, info, "OBJD-H");
-}
-
-static int print_insn_od_target(bfd_vma pc, disassemble_info *info)
-{
-    return print_insn_objdump(pc, info, "OBJD-T");
-}
-
-static void initialize_debug(CPUDebug *s)
-{
-    memset(s, 0, sizeof(*s));
-    s->info.arch = bfd_arch_unknown;
-    s->info.cap_arch = -1;
-    s->info.cap_insn_unit = 4;
-    s->info.cap_insn_split = 4;
-    s->info.memory_error_func = perror_memory;
-    s->info.symbol_at_address_func = symbol_at_address;
-}
-
-void disas_initialize_debug_target(CPUDebug *s, CPUState *cpu)
-{
-    initialize_debug(s);
-
-    s->cpu = cpu;
-    s->info.read_memory_func = target_read_memory;
-    s->info.print_address_func = print_address;
-    if (target_words_bigendian()) {
-        s->info.endian = BFD_ENDIAN_BIG;
-    } else {
-        s->info.endian =  BFD_ENDIAN_LITTLE;
-    }
-
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-    if (cc->disas_set_info) {
-        cc->disas_set_info(cpu, &s->info);
-    }
-}
-
-static void initialize_debug_host(CPUDebug *s)
-{
-    initialize_debug(s);
-
-    s->info.read_memory_func = host_read_memory;
-    s->info.print_address_func = host_print_address;
-#if HOST_BIG_ENDIAN
-    s->info.endian = BFD_ENDIAN_BIG;
-#else
-    s->info.endian = BFD_ENDIAN_LITTLE;
-#endif
-#if defined(CONFIG_TCG_INTERPRETER)
-    s->info.print_insn = print_insn_tci;
-#elif defined(__i386__)
-    s->info.mach = bfd_mach_i386_i386;
-    s->info.cap_arch = CS_ARCH_X86;
-    s->info.cap_mode = CS_MODE_32;
-    s->info.cap_insn_unit = 1;
-    s->info.cap_insn_split = 8;
-#elif defined(__x86_64__)
-    s->info.mach = bfd_mach_x86_64;
-    s->info.cap_arch = CS_ARCH_X86;
-    s->info.cap_mode = CS_MODE_64;
-    s->info.cap_insn_unit = 1;
-    s->info.cap_insn_split = 8;
-#elif defined(_ARCH_PPC)
-    s->info.cap_arch = CS_ARCH_PPC;
-# ifdef _ARCH_PPC64
-    s->info.cap_mode = CS_MODE_64;
-# endif
-#elif defined(__riscv)
-#if defined(_ILP32) || (__riscv_xlen == 32)
-    s->info.print_insn = print_insn_riscv32;
-#elif defined(_LP64)
-    s->info.print_insn = print_insn_riscv64;
-#else
-#error unsupported RISC-V ABI
-#endif
-#elif defined(__aarch64__)
-    s->info.cap_arch = CS_ARCH_ARM64;
-#elif defined(__alpha__)
-    s->info.print_insn = print_insn_alpha;
-#elif defined(__sparc__)
-    s->info.print_insn = print_insn_sparc;
-    s->info.mach = bfd_mach_sparc_v9b;
-#elif defined(__arm__)
-    /* TCG only generates code for arm mode.  */
-    s->info.cap_arch = CS_ARCH_ARM;
-#elif defined(__MIPSEB__)
-    s->info.print_insn = print_insn_big_mips;
-#elif defined(__MIPSEL__)
-    s->info.print_insn = print_insn_little_mips;
-#elif defined(__m68k__)
-    s->info.print_insn = print_insn_m68k;
-#elif defined(__s390__)
-    s->info.cap_arch = CS_ARCH_SYSZ;
-    s->info.cap_insn_unit = 2;
-    s->info.cap_insn_split = 6;
-#elif defined(__hppa__)
-    s->info.print_insn = print_insn_hppa;
-#elif defined(__loongarch__)
-    s->info.print_insn = print_insn_loongarch;
-#endif
-}
-
-/* Disassemble this for me please... (debugging).  */
-void target_disas(FILE *out, CPUState *cpu, uint64_t code, size_t size)
-{
-    uint64_t pc;
-    int count;
-    CPUDebug s;
-
-    disas_initialize_debug_target(&s, cpu);
-    s.info.fprintf_func = fprintf;
-    s.info.stream = out;
-    s.info.buffer_vma = code;
-    s.info.buffer_length = size;
-    s.info.show_opcodes = true;
-
-    if (s.info.cap_arch >= 0 && cap_disas_target(&s.info, code, size)) {
-        return;
-    }
-
-    if (s.info.print_insn == NULL) {
-        s.info.print_insn = print_insn_od_target;
-    }
-
-    for (pc = code; size > 0; pc += count, size -= count) {
-        fprintf(out, "0x%08" PRIx64 ":  ", pc);
-        count = s.info.print_insn(pc, &s.info);
-        fprintf(out, "\n");
-        if (count < 0) {
-            break;
-        }
-        if (size < count) {
-            fprintf(out,
-                    "Disassembler disagrees with translator over instruction "
-                    "decoding\n"
-                    "Please report this to qemu-devel@nongnu.org\n");
-            break;
-        }
-    }
-}
-
-int disas_gstring_printf(FILE *stream, const char *fmt, ...)
-{
-    /* We abuse the FILE parameter to pass a GString. */
-    GString *s = (GString *)stream;
-    int initial_len = s->len;
-    va_list va;
-
-    va_start(va, fmt);
-    g_string_append_vprintf(s, fmt, va);
-    va_end(va);
-
-    return s->len - initial_len;
-}
-
-static void plugin_print_address(bfd_vma addr, struct disassemble_info *info)
-{
-    /* does nothing */
-}
-
-
-/*
- * We should only be dissembling one instruction at a time here. If
- * there is left over it usually indicates the front end has read more
- * bytes than it needed.
- */
-char *plugin_disas(CPUState *cpu, uint64_t addr, size_t size)
-{
-    CPUDebug s;
-    GString *ds = g_string_new(NULL);
-
-    disas_initialize_debug_target(&s, cpu);
-    s.info.fprintf_func = disas_gstring_printf;
-    s.info.stream = (FILE *)ds;  /* abuse this slot */
-    s.info.buffer_vma = addr;
-    s.info.buffer_length = size;
-    s.info.print_address_func = plugin_print_address;
-
-    if (s.info.cap_arch >= 0 && cap_disas_plugin(&s.info, addr, size)) {
-        ; /* done */
-    } else if (s.info.print_insn) {
-        s.info.print_insn(addr, &s.info);
-    } else {
-        ; /* cannot disassemble -- return empty string */
-    }
-
-    /* Return the buffer, freeing the GString container.  */
-    return g_string_free(ds, false);
-}
-
-/* Disassemble this for me please... (debugging). */
-void disas(FILE *out, const void *code, size_t size)
-{
-    uintptr_t pc;
-    int count;
-    CPUDebug s;
-
-    initialize_debug_host(&s);
-    s.info.fprintf_func = fprintf;
-    s.info.stream = out;
-    s.info.buffer = code;
-    s.info.buffer_vma = (uintptr_t)code;
-    s.info.buffer_length = size;
-    s.info.show_opcodes = true;
-
-    if (s.info.cap_arch >= 0 && cap_disas_host(&s.info, code, size)) {
-        return;
-    }
-
-    if (s.info.print_insn == NULL) {
-        s.info.print_insn = print_insn_od_host;
-    }
-    for (pc = (uintptr_t)code; size > 0; pc += count, size -= count) {
-        fprintf(out, "0x%08" PRIxPTR ":  ", pc);
-        count = s.info.print_insn(pc, &s.info);
-        fprintf(out, "\n");
-        if (count < 0) {
-            break;
-        }
-    }
-
-}
-
-/* Look up symbol for debugging purpose.  Returns "" if unknown. */
-const char *lookup_symbol(uint64_t orig_addr)
-{
-    const char *symbol = "";
-    struct syminfo *s;
-
-    for (s = syminfos; s; s = s->next) {
-        symbol = s->lookup_symbol(s, orig_addr);
-        if (symbol[0] != '\0') {
-            break;
-        }
-    }
-
-    return symbol;
-}
diff --git a/disas/objdump.c b/disas/objdump.c
new file mode 100644
index 0000000000..9859f23419
--- /dev/null
+++ b/disas/objdump.c
@@ -0,0 +1,37 @@
+/*
+ * Dump disassembly as text, for processing by scripts/disas-objdump.pl.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "disas-internal.h"
+
+
+static int print_insn_objdump(bfd_vma pc, disassemble_info *info,
+                              const char *prefix)
+{
+    int i, n = info->buffer_length;
+    g_autofree uint8_t *buf = g_malloc(n);
+
+    if (info->read_memory_func(pc, buf, n, info) == 0) {
+        for (i = 0; i < n; ++i) {
+            if (i % 32 == 0) {
+                info->fprintf_func(info->stream, "\n%s: ", prefix);
+            }
+            info->fprintf_func(info->stream, "%02x", buf[i]);
+        }
+    } else {
+        info->fprintf_func(info->stream, "unable to read memory");
+    }
+    return n;
+}
+
+int print_insn_od_host(bfd_vma pc, disassemble_info *info)
+{
+    return print_insn_objdump(pc, info, "OBJD-H");
+}
+
+int print_insn_od_target(bfd_vma pc, disassemble_info *info)
+{
+    return print_insn_objdump(pc, info, "OBJD-T");
+}
diff --git a/disas/meson.build b/disas/meson.build
index 5c8073beb3..20d6aef9a7 100644
--- a/disas/meson.build
+++ b/disas/meson.build
@@ -14,7 +14,11 @@ common_ss.add(when: 'CONFIG_SH4_DIS', if_true: files('sh4.c'))
 common_ss.add(when: 'CONFIG_SPARC_DIS', if_true: files('sparc.c'))
 common_ss.add(when: 'CONFIG_XTENSA_DIS', if_true: files('xtensa.c'))
 common_ss.add(when: capstone, if_true: [files('capstone.c'), capstone])
-common_ss.add(files('disas.c'))
-
+common_ss.add(when: 'CONFIG_TCG', if_true: files(
+    'disas-host.c',
+    'disas-target.c',
+    'objdump.c'
+))
+common_ss.add(files('disas-common.c'))
 system_ss.add(files('disas-mon.c'))
 specific_ss.add(capstone)
-- 
2.34.1


