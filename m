Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95121C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Rq-0004H2-VF; Wed, 15 May 2024 03:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rm-0004C9-FL
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:10 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rh-0001bS-6b
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:08 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2e3fa13f018so80395531fa.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759582; x=1716364382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3reNa+vlMnQNIk6cvUIcWGKHdlW1nVEiDXshCrKVtM=;
 b=tZ9UboHwJO4FQLP0s4nziJAxOQlCbiv7ukwxKmNtRuvnpkatZRIu+BkFWjeEKb3n0T
 oUDpS+9ovY8r7RUifrLDK1uORS3AdVbNaP69Kr39QDyq5HeK5FMgvY4uWeAWx2N3Hr4b
 FZ9QYqR3EcO0Y/leEStzvRIVX/LiBuQfe4ilrvGE6B9yn5KidufWbt/7ooUuxPv+UL/j
 Z3kikX3ub2qKABPRFZDtafUbR0j5WqFWDnAbFi7etP3OPrz7ZhDNj8FsxxgjRUSrbWfq
 WF0phOwONTXATDZl83CXdK9WzJhZ7dEp14ttQ1TxEb0lXmRw0QRDQ47tIMuKaU3D5BBM
 RDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759582; x=1716364382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W3reNa+vlMnQNIk6cvUIcWGKHdlW1nVEiDXshCrKVtM=;
 b=QEQPlxt0UhPliD1LXPqb4rAXJ5DBXPK7wiyiuKRWmF870dvHRrz2Wojs9ULUD1gqIJ
 5R/dnnF2H5kfQS53nECWtjiu54jTCnWjGksKSPbfNjCFAko2UoyvdPk8A5s2XMpd2Rkf
 e7DgCntmT4WK22azLTQ0l1CIeYAqzohV4Dx0HeqJ6mS77rkPQZoBXva6TGTYFHsQfzRE
 XPk6NbWc2+cE7EOxevVaEP2ZY81Vo3iXVPVMDeYNK99in+6e1jbWzTSgmE+8sciM+xJX
 kbL5F2Igb0uPGJtfbW5qaQof/7s8ts7wGnnh4J2I02APzv4ZJ1u33bRtTzk7QDuw41hm
 kbsQ==
X-Gm-Message-State: AOJu0YwFQFT7UadMA9jAbekHtThVXldcE9X+eBGkGYWY+PHroNOd1ufG
 CrTi/fRQOTzVrCSgm9q/RLXw+sMv/SvJugabVTJO/2QvXFVWJK8nsrLuWSQUZxshxjwsIqPb0cF
 Govw=
X-Google-Smtp-Source: AGHT+IH3ln/HSbye1S/1Fd4fkYo9PBmrIukRCVpuTIM0ukAxVhiqcYxVGkuTfAIeb06vN3Vr0Hvmvw==
X-Received: by 2002:a2e:701:0:b0:2e5:374b:bf00 with SMTP id
 38308e7fff4ca-2e5374bbf6fmr80675201fa.33.1715759581822; 
 Wed, 15 May 2024 00:53:01 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:53:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/34] disas: Use translator_st to get disassembly data
Date: Wed, 15 May 2024 09:52:32 +0200
Message-Id: <20240515075247.68024-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 31c39ab63c..411ce2b47e 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -79,7 +79,7 @@ typedef enum DisasJumpType {
  *
  * Architecture-agnostic disassembly context.
  */
-typedef struct DisasContextBase {
+struct DisasContextBase {
     TranslationBlock *tb;
     vaddr pc_first;
     vaddr pc_next;
@@ -103,7 +103,7 @@ typedef struct DisasContextBase {
     int record_start;
     int record_len;
     uint8_t record[32];
-} DisasContextBase;
+};
 
 /**
  * TranslatorOps:
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index b47e7179e2..9d222dc376 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -42,6 +42,7 @@ typedef struct CPUPluginState CPUPluginState;
 typedef struct CPUState CPUState;
 typedef struct DeviceState DeviceState;
 typedef struct DirtyBitmapSnapshot DirtyBitmapSnapshot;
+typedef struct DisasContextBase DisasContextBase;
 typedef struct DisplayChangeListener DisplayChangeListener;
 typedef struct DriveInfo DriveInfo;
 typedef struct DumpState DumpState;
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index ccd22dcd95..00322c6fd9 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -231,7 +231,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
             if (!ops->disas_log ||
                 !ops->disas_log(db, cpu, logfile)) {
                 fprintf(logfile, "IN: %s\n", lookup_symbol(db->pc_first));
-                target_disas(logfile, cpu, db->pc_first, db->tb->size);
+                target_disas(logfile, cpu, db);
             }
             fprintf(logfile, "\n");
             qemu_log_unlock(logfile);
diff --git a/disas/disas-common.c b/disas/disas-common.c
index ce9f82b711..de61f6d8a1 100644
--- a/disas/disas-common.c
+++ b/disas/disas-common.c
@@ -8,25 +8,12 @@
 #include "disas/capstone.h"
 #include "hw/core/cpu.h"
 #include "exec/tswap.h"
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
@@ -73,7 +60,6 @@ void disas_initialize_debug_target(CPUDebug *s, CPUState *cpu)
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
index 02014d4c6e..b04c5e1928 100644
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


