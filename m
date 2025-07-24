Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E269C87FC5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 20:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf2p9-00059s-PA; Thu, 24 Jul 2025 16:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uf2p5-00055j-M5
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:45:51 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uf2p2-0007MY-1Y
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:45:51 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b3bcb168fd5so1426021a12.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 13:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753389937; x=1753994737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aM+LEv7qMdQSxk6AvcKBeuN8XSEE2/g7YYBoLvBkt14=;
 b=MlU2HOTSxYQLjY+b/JfeBqMAWS7fupKfU0PkwVAkdbAZQcl4pwVt+OyZJuQKd0/RWK
 DChoB75+2dIJSfFOtf9bhNVayJ4OU++QS4znJiWyDgfYsWcM0Dybw4OJ21PwvTfjWtIZ
 1aGs9xPJknVdRWvhmSV186WUEVngM1LNwtm/VPNb8KxbVOVfqvDsPggrfQD7bVXj0VHn
 N90pGC1m16HnbGCxqTH5ysgrQqIq72KgugX1Tx2MBNxURHTRkTCPJf3smqssPe4aXHUr
 5x5UCN7Q7xKqNopz/79CK6RGu3DHpZZH2dm5/rBJ6+FHPRi0ZFMb7ICHcDjKEmHI+HCY
 /fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753389937; x=1753994737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aM+LEv7qMdQSxk6AvcKBeuN8XSEE2/g7YYBoLvBkt14=;
 b=F9DJM+4IdzMt7jjSNW0bLiC+FxVNtS45pH9tDAMNvs6vQmpuGiiAuqvShWcAnAr62j
 b9s/uvCiOojRtBQO/mdqql7+mcmXmoYjSgz/jktdKgz4DsfS14IpGA4Z94CPS8xka9rY
 TBWI2LJwdHH/29N9Jo0dqfTXtd1PS+UV4EVR+dgl4hju+FN/8Ikhk8rZTu5VR3KO7uoB
 h9fLye786llXXDjhWrfgJ8aauf/M8rlZ69yK668LpKv69lPF4U/c24fK5dylNeSdS7zQ
 zMERL7olrDhldpY3AB+hbVvEznOAdGHyELayGP5ICAxJgZmB73zg+2oj2FHvFlMKl8xC
 z8AA==
X-Gm-Message-State: AOJu0YwBSxHkjfey+Ts8t0AWriQAK+J5i8jVYwwdQQj6PWl8shAeDrXA
 f2c4++FJ4M96D/EhhSUIne5gN3FwM6NztK3etduNryGMHDl1l6TvymW1NfO0BfnKAs282slPHTA
 YeDTY
X-Gm-Gg: ASbGnctDbdvrfZwZyVzaZ7x657+b1trgxYBEF/a6p0mtQhmxE2JZztd6IcjkB96Af92
 nI1P2aBL84hu8/qjkqy83wOZRI7bKYmSR7PfhpNqJOr2rOOUcig+o9VMenSf8iX7tacGZ3CUuVl
 fEosogkw6SGGZzpp+WRABZ9HMTkON/2zXhek/DEglX4n9lJ4Qe8pdlN5DO0wA3WuvBBkg/oYP/X
 9ZTrEu3CpB9k40ePRWgZCMe7JqBdFjaF211MB8rmnogQs9FEl23mp45lvE95kdMdDtgxkmIRXFu
 hnAHs8UZtWWVhZDDCa1uSti8dvSNGe6k+deyKXDf0CHkIwzoBHt29k81gw+Yq7l/rWTDxWXcKHB
 apQyJoouXI6pITZKam9VN+A==
X-Google-Smtp-Source: AGHT+IFwlU2lTF2PjWKRraQv0HeO2Ytpz3zDW5Sv6Z4ZWyDPa84YGOmd19ZvcJ28wSgdO9aiz3e3CQ==
X-Received: by 2002:a17:903:1b28:b0:235:f70:fd37 with SMTP id
 d9443c01a7336-23f9814b043mr115832965ad.19.1753389936771; 
 Thu, 24 Jul 2025 13:45:36 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662f6be0sm2008849a91.35.2025.07.24.13.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 13:45:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, rowan Hart <rowanbhart@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 2/7] contrib/plugins/uftrace: add trace-sample option
Date: Thu, 24 Jul 2025 13:45:21 -0700
Message-ID: <20250724204527.3175839-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724204527.3175839-1-pierrick.bouvier@linaro.org>
References: <20250724204527.3175839-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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
index 4ca6d3fd68d..a626030b7da 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -44,6 +44,9 @@ typedef struct {
 
 typedef struct Cpu {
     uint64_t insn_count;
+    uint64_t sample_insn_count;
+    uint64_t sample_timestamp;
+    callstack *sample_cs;
     trace *trace;
     callstack *cs;
     GArray *callstacks; /* callstack *callstacks[] */
@@ -70,6 +73,7 @@ enum uftrace_record_type {
 };
 
 static struct qemu_plugin_scoreboard *score;
+static uint64_t trace_sample;
 static CpuOps arch_ops;
 
 static void uftrace_write_map(bool system_emulation)
@@ -199,6 +203,13 @@ static callstack *callstack_new(void)
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
@@ -391,6 +402,26 @@ static void cpu_unwind_stack(Cpu *cpu, uint64_t frame_pointer, uint64_t pc)
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
@@ -451,6 +482,13 @@ static void track_callstack(unsigned int cpu_index, void *udata)
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
@@ -459,7 +497,9 @@ static void track_callstack(unsigned int cpu_index, void *udata)
          */
         callstack_push(cs, (callstack_entry){.frame_pointer = fp,
                                                .pc = pc});
-        trace_enter_function(t, timestamp, pc, callstack_depth(cs));
+        if (trace_change) {
+            trace_enter_function(t, timestamp, pc, callstack_depth(cs));
+        }
         return;
     }
 
@@ -473,7 +513,9 @@ static void track_callstack(unsigned int cpu_index, void *udata)
     if (fp == caller.frame_pointer) {
         /* return */
         callstack_entry e = callstack_pop(cs);
-        trace_exit_function(t, timestamp, e.pc, callstack_depth(cs));
+        if (trace_change) {
+            trace_exit_function(t, timestamp, e.pc, callstack_depth(cs));
+        }
         return;
     }
 
@@ -482,27 +524,65 @@ static void track_callstack(unsigned int cpu_index, void *udata)
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
@@ -511,6 +591,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
         qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
                 insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
+        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+                insn, QEMU_PLUGIN_INLINE_ADD_U64, sample_insn_count, 1);
 
         if (instrument_insn) {
             uintptr_t pc = qemu_plugin_insn_vaddr(insn);
@@ -536,6 +618,7 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
     cpu->buf = g_byte_array_new();
     cpu->callstacks = g_array_new(0, 0, sizeof(callstack *));
     cpu->traces = g_array_new(0, 0, sizeof(trace *));
+    cpu->sample_timestamp = cpu_get_timestamp(cpu);
 
     g_assert(vcpu_index < 1000);
     uint32_t trace_id = 1000 * 1000 + vcpu_index * 1000;
@@ -613,6 +696,22 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
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


