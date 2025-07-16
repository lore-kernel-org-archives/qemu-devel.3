Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98191C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 05:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubuma-0006wU-L0; Wed, 16 Jul 2025 01:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubumY-0006qB-8S
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 01:34:18 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubumV-0007rP-HA
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 01:34:17 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso8029556b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 22:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752644054; x=1753248854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oa5OA8K99UsScs6d3Jua3/OD+RHq2I0UwUyhgSBoPz4=;
 b=jnh+AfN1ytMvxt5XLl9haHFk53WZSiE6VdhGVunMtAlNcINdF4pvj655dQeoDnBoL+
 bib8mu8pnrqMxjBkaHjPAVNadIu2qJaBgGZiFtY/WIk+xRMP07miyIdCmzyQL34wyxfc
 eFvoY5o48BUD+IB2qat3MPyggsgEXrN6k+zL83hF1x+B+ef/fzTVlwDwbTiA5DXLOH6X
 H+VzjPyKeDvPojStBw0+WGlL9DEWN/XRZdFtgCGBs4gTj6Oz50RS56/1mmQ/w52D1mit
 GmsnBtix9UnPsRvvCF6Cv8rDiFBDDBFw8WKQcWRR31/S/wtE6Gz6IjFHMgVOCZXfyJs+
 s3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752644054; x=1753248854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oa5OA8K99UsScs6d3Jua3/OD+RHq2I0UwUyhgSBoPz4=;
 b=Ij2ZP/kgZRZYnjzKIDthd5BcutxaPPGy6ctjMup/eeFE8RpRYPZug0hlGFlQQ2ItTG
 klB5acg7fak0JUZJ0qk/4sHZpCd8bY8QQP1WsvnFBxiFYNZVc8PsUqDwiZXasmqxdgIO
 FCiKDNYNyv2jJP32Bid78ztWlCeCjnPr7k5K+hqOilKgiW2d5x1OncaW/nRHBkQYD2o6
 wzfkNmRobIOPVrN+vFlJ+AihVZuj5JPKqT4En3lT+cn1siaC2Xnjye0Zq+GqMdTy1tDU
 ByxwuYh05v5dWH2qYlY2iSbYybYMBUeHJtLbysmmSzn3a6Tmp2TqyEviRnFb1kWQJNnp
 DCkw==
X-Gm-Message-State: AOJu0YwRTM8T4oO75EXvoXqky10iRugZJkRthUOhDA15zjU3q/vZvZDy
 MilmJ+zMpQ53yQh3SMRDlulDy3LhMlJgyYDgYwA90yzQqLNZ3NFcSRg6Ab+ShFZ+3mD8HfcpRqU
 o4G0N
X-Gm-Gg: ASbGnct1CvFKL9KuHM9GDKmeAC/ziZwoFdrjQo5nP950Ec+J3yMwRZQVDBzSaCY7awH
 1hR92aCGg9hbh91l+PILQtZo5NyWxnnwpR51HvM2RxOLB1zprlmReL2EquCKzkoWfK4h7apFhyH
 56DQ98PJxQ2POrQt3nL4sbaidi/5Cl/2N2e0Qsihqxw3qQvxwRR8ODlj1BXriSI5kaWZx0TZKkx
 sgnc1M9pR8bFmzC5lZNQGxGFpAld4QLCnGp3/TCEGCVRhUxhDh+y/paJ0qRVecCA+55aZN8XDtI
 bxwMKLF3gJKPdY9EVb0YtswLrHBFlDaSdKy+Q4N0+BxEXfnKlMbIfgG9dK4B34pGHBbUflcEbSt
 +rE/wWsNX2cdyv3zKWJtX2A==
X-Google-Smtp-Source: AGHT+IGAcuaY0tnljFtZ9vtOnA31Jx84t4R382N3QJFjtPQc+NmryXej0pRbK7bEyL8kQNB34xafcQ==
X-Received: by 2002:a05:6a20:938c:b0:215:ead1:b867 with SMTP id
 adf61e73a8af0-23811345d42mr2211252637.14.1752644054160; 
 Tue, 15 Jul 2025 22:34:14 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9e06aa6sm13790162b3a.62.2025.07.15.22.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 22:34:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/6] contrib/plugins/uftrace: add trace-sample option
Date: Tue, 15 Jul 2025 22:34:03 -0700
Message-ID: <20250716053407.2814736-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716053407.2814736-1-pierrick.bouvier@linaro.org>
References: <20250716053407.2814736-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

usage: trace-sample=N

Allow to use sampling (every N instructions) for tracking the stack.
We implement a fast mode, where instrumentation is only per tb, and
simply dump current stack, and unwind new one, instead of tracking every
frame pointer change.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 111 +++++++++++++++++++++++++++++++++++---
 1 file changed, 105 insertions(+), 6 deletions(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 1f52e8e0f4e..bd3df10a218 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -43,6 +43,9 @@ typedef struct {
 
 typedef struct Cpu {
     uint64_t insn_count;
+    uint64_t sample_insn_count;
+    uint64_t sample_timestamp;
+    callstack *sample_cs;
     trace *trace;
     callstack *cs;
     GArray *callstacks; /* callstack *callstacks[] */
@@ -69,6 +72,7 @@ enum uftrace_record_type {
 };
 
 static struct qemu_plugin_scoreboard *score;
+static uint64_t trace_sample;
 static CpuOps arch_ops;
 
 static void uftrace_write_map(bool system_emulation)
@@ -190,6 +194,13 @@ static callstack *callstack_new(void)
     return cs;
 }
 
+static callstack *callstack_clone(const callstack *cs)
+{
+    callstack *clone = g_malloc0(sizeof(callstack));
+    clone->s = g_array_copy(cs->s);
+    return clone;
+}
+
 static void callstack_free(callstack *cs)
 {
     g_array_free(cs->s, true);
@@ -382,6 +393,26 @@ static void cpu_unwind_stack(Cpu *cpu, uint64_t frame_pointer, uint64_t pc)
     }
 }
 
+static void cpu_trace_last_sample(Cpu *cpu, uint64_t timestamp)
+{
+    if (!cpu->sample_cs) {
+        return;
+    }
+    uint64_t elapsed = timestamp - cpu->sample_timestamp;
+    uint64_t middle_timestamp = cpu->sample_timestamp + (elapsed / 2);
+    trace_exit_stack(cpu->trace, cpu->sample_cs, middle_timestamp);
+    callstack_free(cpu->sample_cs);
+    cpu->sample_cs = NULL;
+    trace_enter_stack(cpu->trace, cpu->cs, middle_timestamp);
+}
+
+static void cpu_set_new_sample(Cpu *cpu, uint64_t timestamp)
+{
+    cpu->sample_insn_count = 0;
+    cpu->sample_cs = callstack_clone(cpu->cs);
+    cpu->sample_timestamp = timestamp;
+}
+
 static uint64_t cpu_get_timestamp(const Cpu *cpu)
 {
     return cpu->insn_count;
@@ -442,6 +473,13 @@ static void track_callstack(unsigned int cpu_index, void *udata)
     callstack *cs = cpu->cs;
     trace *t = cpu->trace;
 
+    if (trace_sample && cpu->sample_insn_count >= trace_sample) {
+        cpu_trace_last_sample(cpu, timestamp);
+        cpu_set_new_sample(cpu, timestamp);
+    }
+
+    bool trace_change = !trace_sample;
+
     uint64_t fp = cpu->ops.get_frame_pointer(cpu);
     if (!fp && callstack_empty(cs)) {
         /*
@@ -450,7 +488,9 @@ static void track_callstack(unsigned int cpu_index, void *udata)
          */
         callstack_push(cs, (callstack_entry){.frame_pointer = fp,
                                                .pc = pc});
-        trace_enter_function(t, timestamp, pc, callstack_depth(cs));
+        if (trace_change) {
+            trace_enter_function(t, timestamp, pc, callstack_depth(cs));
+        }
         return;
     }
 
@@ -464,7 +504,9 @@ static void track_callstack(unsigned int cpu_index, void *udata)
     if (fp == caller.frame_pointer) {
         /* return */
         callstack_entry e = callstack_pop(cs);
-        trace_exit_function(t, timestamp, e.pc, callstack_depth(cs));
+        if (trace_change) {
+            trace_exit_function(t, timestamp, e.pc, callstack_depth(cs));
+        }
         return;
     }
 
@@ -473,27 +515,65 @@ static void track_callstack(unsigned int cpu_index, void *udata)
         /* call */
         callstack_push(cs, (callstack_entry){.frame_pointer = fp,
                 .pc = pc});
-        trace_enter_function(t, timestamp, pc, callstack_depth(cs));
+        if (trace_change) {
+            trace_enter_function(t, timestamp, pc, callstack_depth(cs));
+        }
         return;
     }
 
     /* discontinuity, exit current stack and unwind new one */
-    trace_exit_stack(t, cs, timestamp);
+    if (trace_change) {
+        trace_exit_stack(t, cs, timestamp);
+    }
     callstack_clear(cs);
 
     cpu_unwind_stack(cpu, fp, pc);
-    trace_enter_stack(t, cs, timestamp);
+    if (trace_change) {
+        trace_enter_stack(t, cs, timestamp);
+    }
+}
+
+static void sample_callstack(unsigned int cpu_index, void *udata)
+{
+    uint64_t pc = (uintptr_t) udata;
+    Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
+    uint64_t timestamp = cpu_get_timestamp(cpu);
+
+    trace_exit_stack(cpu->trace, cpu->cs, timestamp);
+    callstack_clear(cpu->cs);
+
+    cpu_unwind_stack(cpu, cpu->ops.get_frame_pointer(cpu), pc);
+    trace_enter_stack(cpu->trace, cpu->cs, timestamp);
+
+    /* reset counter */
+    cpu->sample_insn_count = 0;
 }
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
     size_t n_insns = qemu_plugin_tb_n_insns(tb);
+    uintptr_t tb_pc = qemu_plugin_tb_vaddr(tb);
 
     qemu_plugin_u64 insn_count = qemu_plugin_scoreboard_u64_in_struct(
                                       score, Cpu, insn_count);
+    qemu_plugin_u64 sample_insn_count = qemu_plugin_scoreboard_u64_in_struct(
+                                            score, Cpu, sample_insn_count);
+
+    if (trace_sample) {
+        /* We can do a light instrumentation, per tb only */
+        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+            tb, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, n_insns);
+        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+            tb, QEMU_PLUGIN_INLINE_ADD_U64, sample_insn_count, n_insns);
+        qemu_plugin_register_vcpu_tb_exec_cond_cb(
+            tb, sample_callstack, QEMU_PLUGIN_CB_R_REGS,
+            QEMU_PLUGIN_COND_GE, sample_insn_count, trace_sample,
+            (void *) tb_pc);
+        return;
+    }
 
     /*
-     * We instrument all instructions following one that might have updated
+     * We now instrument all instructions following one that might have updated
      * the frame pointer. We always instrument first instruction in block, as
      * last executed instruction, in previous tb, may have modified it.
      */
@@ -502,6 +582,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
         qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
                 insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
+        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+                insn, QEMU_PLUGIN_INLINE_ADD_U64, sample_insn_count, 1);
 
         if (instrument_insn) {
             uintptr_t pc = qemu_plugin_insn_vaddr(insn);
@@ -527,6 +609,7 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
     cpu->buf = g_byte_array_new();
     cpu->callstacks = g_array_new(0, 0, sizeof(callstack *));
     cpu->traces = g_array_new(0, 0, sizeof(trace *));
+    cpu->sample_timestamp = cpu_get_timestamp(cpu);
 
     g_assert(vcpu_index < 1000);
     uint32_t trace_id = 1000 * 1000 + vcpu_index * 1000;
@@ -596,6 +679,22 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv)
 {
+    for (int i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "trace-sample") == 0) {
+            gint64 value = g_ascii_strtoll(tokens[1], NULL, 10);
+            if (value <= 0) {
+                fprintf(stderr, "bad trace-sample value: %s\n", tokens[1]);
+                return -1;
+            }
+            trace_sample = value;
+        } else {
+            fprintf(stderr, "option parsing failed: %s\n", opt);
+            return -1;
+        }
+    }
+
     if (!strcmp(info->target_name, "aarch64")) {
         arch_ops = aarch64_ops;
     } else {
-- 
2.47.2


