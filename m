Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D05ACD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsglH-00064b-Qg; Fri, 05 Apr 2024 06:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglF-00062o-Bv
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:29 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglD-0004mT-FK
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:29 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ecf9898408so794574b3a.1
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312726; x=1712917526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BSWmY5g0BLOjDo6Xjv7CB1e+gl5EQ0oR0a5drHt964Q=;
 b=GifGIhqnx9Nx8glcn0CrFMCXiKfr9hTJyJRtRzguVbq2/rtL3lO7WM/dCI3Tv/lMPH
 3Hw0ehkvqUrTaqDf9lPz7T2IIoXIJaAR+ZtdtQqq02x6aD7H/x1jbHhTCGwOV4KeMzhP
 XfN6xI8vTkQUcZa/8yVN0XJU9vgII05hYB4mUkUjwYljeFATrq4Sww6oyHQhgPWiCYLB
 d026ySu3zLfD8n6CEm02xI5RrG2UPf7Vl+JreUDr5MVN+Myjsy6ZN9Kisp0WuZgmuMdv
 2YlIcxO9oBO/z6/Mrxi8LnMj6Tb7H+ym4KtwPaAD5a07ViQ2yhwup9NyC8ffn/0t0HUo
 6Yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312726; x=1712917526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BSWmY5g0BLOjDo6Xjv7CB1e+gl5EQ0oR0a5drHt964Q=;
 b=s4vUM79Ng9hB6fYMT0ICa6G4+hw7O4aI2GdTKsyaxrNwUzntdb7+UtFXmqClLTCscK
 AweUC6ldoEZr5TEplBgD0IEdIggzoG39Up/VOS7R0luqZspgbIwzefc1tTEAZ8p9Z9hU
 B4aljDUrIr573vnGYuPc9b5VJwZxsjf5XkqYvIngbWQZsfmzGMZl6uALflHPwt2WU43S
 5Q9MFgk3tj2W1IFGalAVR+K2am1AVoMjTzsPNoafMu0rBIHFQygYQcJzo3HAgftVVd/c
 tu/ast6oLtpEyqMHoboVZZS/lbi48CFCsyxm1aq/Upa8xCk4tIR8NuDeD4DutQ+KiXeQ
 8+WQ==
X-Gm-Message-State: AOJu0YywoKu0rt9N2f5MhXMtdlsDrDBgBXdnH34CpF2NnTA+hkxch9y1
 ///u9OVAbz3MtE4rqD1+5mg36JN2NbblJmvhZ/3cmdC3Snd327yUsldeRAOoDkuQm3xWjbNJZNt
 t
X-Google-Smtp-Source: AGHT+IEH/MUO9xGrbe0Mor764rK0S5anHUAITXxzx1MM4CuVtE/OCrDD1sud+ov/GbLBB7Ohh0lSiQ==
X-Received: by 2002:a05:6a20:7488:b0:1a5:69db:d92b with SMTP id
 p8-20020a056a20748800b001a569dbd92bmr2980850pzd.14.1712312726136; 
 Fri, 05 Apr 2024 03:25:26 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/32] disas: Use translator_st to get disassembly data
Date: Fri,  5 Apr 2024 00:24:46 -1000
Message-Id: <20240405102459.462551-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Read from already translated pages, or saved mmio data.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/disas.h     |  5 +++--
 include/exec/translator.h |  4 ++--
 include/qemu/typedefs.h   |  1 +
 accel/tcg/translator.c    |  2 +-
 disas/disas-common.c      | 14 --------------
 disas/disas-mon.c         | 15 +++++++++++++++
 disas/disas-target.c      | 19 +++++++++++++++++--
 plugins/api.c             |  4 ++--
 8 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/include/disas/disas.h b/include/disas/disas.h
index 54a5e68443..c702b1effc 100644
--- a/include/disas/disas.h
+++ b/include/disas/disas.h
@@ -4,14 +4,15 @@
 /* Disassemble this for me please... (debugging). */
 #ifdef CONFIG_TCG
 void disas(FILE *out, const void *code, size_t size);
-void target_disas(FILE *out, CPUState *cpu, uint64_t code, size_t size);
+void target_disas(FILE *out, CPUState *cpu, const DisasContextBase *db);
 #endif
 
 void monitor_disas(Monitor *mon, CPUState *cpu, uint64_t pc,
                    int nb_insn, bool is_physical);
 
 #ifdef CONFIG_PLUGIN
-char *plugin_disas(CPUState *cpu, uint64_t addr, size_t size);
+char *plugin_disas(CPUState *cpu, const DisasContextBase *db,
+                   uint64_t addr, size_t size);
 #endif
 
 /* Look up symbol for debugging purpose.  Returns "" if unknown. */
diff --git a/include/exec/translator.h b/include/exec/translator.h
index 6ebe69d25c..777dee0ce2 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -78,7 +78,7 @@ typedef enum DisasJumpType {
  *
  * Architecture-agnostic disassembly context.
  */
-typedef struct DisasContextBase {
+struct DisasContextBase {
     TranslationBlock *tb;
     vaddr pc_first;
     vaddr pc_next;
@@ -102,7 +102,7 @@ typedef struct DisasContextBase {
     int record_start;
     int record_len;
     uint8_t record[32];
-} DisasContextBase;
+};
 
 /**
  * TranslatorOps:
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 50c277cf0b..0b3cf3f3ec 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -50,6 +50,7 @@ typedef struct CPUTLBEntryFull CPUTLBEntryFull;
 typedef struct DeviceListener DeviceListener;
 typedef struct DeviceState DeviceState;
 typedef struct DirtyBitmapSnapshot DirtyBitmapSnapshot;
+typedef struct DisasContextBase DisasContextBase;
 typedef struct DisplayChangeListener DisplayChangeListener;
 typedef struct DriveInfo DriveInfo;
 typedef struct DumpState DumpState;
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 712e0d5c7e..4c1dc57890 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -227,7 +227,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
             if (!ops->disas_log ||
                 !ops->disas_log(db, cpu, logfile)) {
                 fprintf(logfile, "IN: %s\n", lookup_symbol(db->pc_first));
-                target_disas(logfile, cpu, db->pc_first, db->tb->size);
+                target_disas(logfile, cpu, db);
             }
             fprintf(logfile, "\n");
             qemu_log_unlock(logfile);
diff --git a/disas/disas-common.c b/disas/disas-common.c
index e4118a381f..e4118e996b 100644
--- a/disas/disas-common.c
+++ b/disas/disas-common.c
@@ -7,25 +7,12 @@
 #include "disas/disas.h"
 #include "disas/capstone.h"
 #include "hw/core/cpu.h"
-#include "exec/memory.h"
 #include "disas-internal.h"
 
 
 /* Filled in by elfload.c.  Simplistic, but will do for now. */
 struct syminfo *syminfos = NULL;
 
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
 /*
  * Print an error message.  We can assume that this is in response to
  * an error return from {host,target}_read_memory.
@@ -72,7 +59,6 @@ void disas_initialize_debug_target(CPUDebug *s, CPUState *cpu)
     disas_initialize_debug(s);
 
     s->cpu = cpu;
-    s->info.read_memory_func = target_read_memory;
     s->info.print_address_func = print_address;
     if (target_words_bigendian()) {
         s->info.endian = BFD_ENDIAN_BIG;
diff --git a/disas/disas-mon.c b/disas/disas-mon.c
index 5d6d9aa02d..37bf16ac79 100644
--- a/disas/disas-mon.c
+++ b/disas/disas-mon.c
@@ -11,6 +11,19 @@
 #include "hw/core/cpu.h"
 #include "monitor/monitor.h"
 
+/*
+ * Get LENGTH bytes from info's buffer, at target address memaddr.
+ * Transfer them to myaddr.
+ */
+static int
+virtual_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
+                    struct disassemble_info *info)
+{
+    CPUDebug *s = container_of(info, CPUDebug, info);
+    int r = cpu_memory_rw_debug(s->cpu, memaddr, myaddr, length, 0);
+    return r ? EIO : 0;
+}
+
 static int
 physical_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
                      struct disassemble_info *info)
@@ -38,6 +51,8 @@ void monitor_disas(Monitor *mon, CPUState *cpu, uint64_t pc,
 
     if (is_physical) {
         s.info.read_memory_func = physical_read_memory;
+    } else {
+        s.info.read_memory_func = virtual_read_memory;
     }
     s.info.buffer_vma = pc;
 
diff --git a/disas/disas-target.c b/disas/disas-target.c
index 82313b2a67..48f3a365dc 100644
--- a/disas/disas-target.c
+++ b/disas/disas-target.c
@@ -6,16 +6,28 @@
 #include "qemu/osdep.h"
 #include "disas/disas.h"
 #include "disas/capstone.h"
+#include "exec/translator.h"
 #include "disas-internal.h"
 
 
-void target_disas(FILE *out, CPUState *cpu, uint64_t code, size_t size)
+static int translator_read_memory(bfd_vma memaddr, bfd_byte *myaddr,
+                                  int length, struct disassemble_info *info)
 {
+    const DisasContextBase *db = info->application_data;
+    return translator_st(db, myaddr, memaddr, length) ? 0 : EIO;
+}
+
+void target_disas(FILE *out, CPUState *cpu, const struct DisasContextBase *db)
+{
+    uint64_t code = db->pc_first;
+    size_t size = translator_st_len(db);
     uint64_t pc;
     int count;
     CPUDebug s;
 
     disas_initialize_debug_target(&s, cpu);
+    s.info.read_memory_func = translator_read_memory;
+    s.info.application_data = (void *)db;
     s.info.fprintf_func = fprintf;
     s.info.stream = out;
     s.info.buffer_vma = code;
@@ -58,12 +70,15 @@ static void plugin_print_address(bfd_vma addr, struct disassemble_info *info)
  * there is left over it usually indicates the front end has read more
  * bytes than it needed.
  */
-char *plugin_disas(CPUState *cpu, uint64_t addr, size_t size)
+char *plugin_disas(CPUState *cpu, const DisasContextBase *db,
+                   uint64_t addr, size_t size)
 {
     CPUDebug s;
     GString *ds = g_string_new(NULL);
 
     disas_initialize_debug_target(&s, cpu);
+    s.info.read_memory_func = translator_read_memory;
+    s.info.application_data = (void *)db;
     s.info.fprintf_func = disas_gstring_printf;
     s.info.stream = (FILE *)ds;  /* abuse this slot */
     s.info.buffer_vma = addr;
diff --git a/plugins/api.c b/plugins/api.c
index 36ab47cdae..c084f335dd 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -271,8 +271,8 @@ void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
 
 char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn)
 {
-    CPUState *cpu = current_cpu;
-    return plugin_disas(cpu, insn->vaddr, insn->len);
+    return plugin_disas(tcg_ctx->cpu, tcg_ctx->plugin_db,
+                        insn->vaddr, insn->len);
 }
 
 const char *qemu_plugin_insn_symbol(const struct qemu_plugin_insn *insn)
-- 
2.34.1


