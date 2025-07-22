Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17470C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 04:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ue52p-0005lj-TP; Tue, 22 Jul 2025 00:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ue52U-0005Zo-EX
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 00:55:44 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ue52S-0004GT-55
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 00:55:42 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-311d5fdf1f0so4028457a91.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 21:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753160139; x=1753764939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHM/wlC23GB8B+z+ofUSGekwvcloMeBSPT2vdT511OU=;
 b=w8awkK1HOb1nVBJEj7jjU9P782pHv5ApcwV1dpGiELrjGU2giE1a5NEQIMLXnWpf8K
 KkGTALkYr1rdMThv611M7oEIUAMnIOi5vhSt/amNWHZwKCzdB88u9tymB2eCJK9JXEqW
 n7v2EIPrHoOnl9/j9d27YTZHsYZOKRfnfy/m+Ew4ykpMRaQi9XWVJS3cKbKouh6JSrdl
 O68pNlRoTPPyN9H3dyJ0Mpe/SvM4A+KyiF5RMraQYt62sUCqzG7xkRylzUqJ92BZ5ZUP
 Yreyv7Gtkmbl9MDHERyCgZOpfPn41w1jFjwOZp9STlG3msxw/dFxuiOzA01m1ZSj1ilJ
 21wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753160139; x=1753764939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHM/wlC23GB8B+z+ofUSGekwvcloMeBSPT2vdT511OU=;
 b=isvwmiW1V7912qjAPNDk3SarNcRzFqHSSiV1EZzN7f/kEfRA2dq7AAa6QAw2P+ChT8
 lxSfpwXYEA+QC8ABcpFik6Z2OquHPwwM5Hh0C+qBLSkVrjAqFCDx5XD9qUcGoMk0PqZ2
 h0IFsVKJqxFNxKNRxBI100k7raaswxsG7CEyZCndP25jc2JnklsypTyYk5nG+LRuFhMj
 9g+pJV85ZA3naeXfLuQskauY5bF3TSbCv1jPT6ChVHqjqkFGdGublgMbz1wMdpLF1Wm9
 UCAIQ4KV2otGX1alTTCLT442zHIVzkwXUCVbf+esWP5jwwFLQmFzAJdSdfb+OJyrLBpx
 7piQ==
X-Gm-Message-State: AOJu0YxrmR02jAgkm3sxXS3BMdbR0ogD4mbn9TtTLZWuyxm2e9rRrAcy
 n0l6E2WnWird0NtIzd0xHaMquQsbpW14cvSmPSjMvco9FksRQqd3I+IGqmPg0Lp8giRKWgoMPuC
 oB8Pt
X-Gm-Gg: ASbGnct93uTMZg1eF5AfPMJNC0lyYOtakpveg6mAVATBmw2O6jRZ9wujjZ+WtC/QEOm
 Ld/SSL8tlQiFzfKV0kotFMvD8Thn6gO0hNCVskAgzKSHNEKrELDx6k9ZdCxM41M18QVNnXEIZ5E
 6jJArP5zoDEnaoyEGdXCvc03iBkhDfFi+AoTRjRZTnqyCoum4y4pwcUJYLOYgIX5o0fwe7qUUl2
 05X5wyYfC+WO+Wd3p+TwyvzJg6Ny55ymGipN7T3lIsSxzIFTyLr/FTcpbhpuNJVJ2Xw/k7nIPL1
 Muafn6bLY8RNLoeDwUaHLf8dIu/6KruySrgm/8eYiRApVgTloTkV2dLrm/Kk35b9fD/Wy+C90vh
 +qKbxN+lHGQ2fgRjdu1SBCA==
X-Google-Smtp-Source: AGHT+IFBedV0jz1lXe1F0JRu05rpCZUvGki7lhdk7wY8AuXRpiHuRzT0hjyghXWwYYJ5gXh75W+4rw==
X-Received: by 2002:a17:90b:5385:b0:311:c939:c851 with SMTP id
 98e67ed59e1d1-31c9f3c3635mr31775456a91.4.1753160138627; 
 Mon, 21 Jul 2025 21:55:38 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31cc3e5b038sm7065311a91.10.2025.07.21.21.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 21:55:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/6] contrib/plugins/uftrace: add trace-privilege-level
 option
Date: Mon, 21 Jul 2025 21:55:24 -0700
Message-ID: <20250722045527.1164751-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722045527.1164751-1-pierrick.bouvier@linaro.org>
References: <20250722045527.1164751-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

usage: trace-privilege-level=[on|off]

This option generates different traces (represented as different
processes in uftrace), allowing to follow privilege level changes.

For aarch64, we track current EL and Security State.

As well, we make sure that sampling works correctly with this option. If
user requests sampling and privilege-level tracing, we perform an
accurate callstack tracking (slower), and only sample the information we
present.

This gives accurate backtraces on all privilege switches, while keeping
the trace sampled if needed.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 182 +++++++++++++++++++++++++++++++++++---
 1 file changed, 171 insertions(+), 11 deletions(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index a626030b7da..bd4219db693 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -39,6 +39,9 @@ typedef struct {
     void (*init)(Cpu *cpu);
     void (*end)(Cpu *cpu);
     uint64_t (*get_frame_pointer)(Cpu *cpu);
+    uint8_t (*get_privilege_level)(Cpu *cpu);
+    uint8_t (*num_privilege_levels)(void);
+    const char *(*get_privilege_level_name)(uint8_t pl);
     bool (*does_insn_modify_frame_pointer)(const char *disas);
 } CpuOps;
 
@@ -49,6 +52,7 @@ typedef struct Cpu {
     callstack *sample_cs;
     trace *trace;
     callstack *cs;
+    uint8_t privilege_level;
     GArray *callstacks; /* callstack *callstacks[] */
     GArray *traces; /* trace *traces [] */
     GByteArray *buf;
@@ -56,8 +60,23 @@ typedef struct Cpu {
     void *arch;
 } Cpu;
 
+typedef enum {
+    AARCH64_EL0_SECURE,
+    AARCH64_EL0_NONSECURE,
+    AARCH64_EL0_REALM,
+    AARCH64_EL1_SECURE,
+    AARCH64_EL1_NONSECURE,
+    AARCH64_EL1_REALM,
+    AARCH64_EL2_SECURE,
+    AARCH64_EL2_NONSECURE,
+    AARCH64_EL2_REALM,
+    AARCH64_EL3,
+} Aarch64PrivilegeLevel;
+
 typedef struct {
     struct qemu_plugin_register *reg_fp;
+    struct qemu_plugin_register *reg_cpsr;
+    struct qemu_plugin_register *reg_scr_el3;
 } Aarch64Cpu;
 
 typedef struct {
@@ -74,6 +93,7 @@ enum uftrace_record_type {
 
 static struct qemu_plugin_scoreboard *score;
 static uint64_t trace_sample;
+static bool trace_privilege_level;
 static CpuOps arch_ops;
 
 static void uftrace_write_map(bool system_emulation)
@@ -358,6 +378,16 @@ static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
     return *((uint64_t *) buf->data);
 }
 
+static uint32_t cpu_read_register32(Cpu *cpu, struct qemu_plugin_register *reg)
+{
+    GByteArray *buf = cpu->buf;
+    g_byte_array_set_size(buf, 0);
+    size_t sz = qemu_plugin_read_register(reg, buf);
+    g_assert(sz == 4);
+    g_assert(buf->len == 4);
+    return *((uint32_t *) buf->data);
+}
+
 static uint64_t cpu_read_memory64(Cpu *cpu, uint64_t addr)
 {
     g_assert(addr);
@@ -427,6 +457,68 @@ static uint64_t cpu_get_timestamp(const Cpu *cpu)
     return cpu->insn_count;
 }
 
+static uint8_t aarch64_num_privilege_levels(void)
+{
+    return AARCH64_EL3 + 1;
+}
+
+static const char *aarch64_get_privilege_level_name(uint8_t pl)
+{
+    switch (pl) {
+    case AARCH64_EL0_SECURE: return "S-EL0";
+    case AARCH64_EL0_NONSECURE: return "NS-EL0";
+    case AARCH64_EL0_REALM: return "R-EL0";
+    case AARCH64_EL1_SECURE: return "S-EL1";
+    case AARCH64_EL1_NONSECURE: return "NS-EL1";
+    case AARCH64_EL1_REALM: return "R-EL1";
+    case AARCH64_EL2_SECURE: return "S-EL2";
+    case AARCH64_EL2_NONSECURE: return "NS-EL2";
+    case AARCH64_EL2_REALM: return "R-EL2";
+    case AARCH64_EL3: return "EL3";
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint8_t aarch64_get_privilege_level(Cpu *cpu_)
+{
+    Aarch64Cpu *cpu = cpu_->arch;
+    /*
+     * QEMU gdbstub does not provide access to CurrentEL,
+     * so we use CPSR instead.
+     */
+    uint8_t el = cpu_read_register32(cpu_, cpu->reg_cpsr) >> 2 & 0b11;
+
+    if (el == 3) {
+        return AARCH64_EL3;
+    }
+
+    uint8_t ss = AARCH64_EL0_SECURE;
+    if (!cpu->reg_scr_el3) {
+        ss = AARCH64_EL0_NONSECURE;
+    }
+    uint64_t scr_el3 = cpu_read_register64(cpu_, cpu->reg_scr_el3);
+    uint64_t ns = (scr_el3 >> 0) & 0b1;
+    uint64_t nse = (scr_el3 >> 62) & 0b1;
+    switch (nse << 1 | ns) {
+    case 0b00:
+        ss = AARCH64_EL0_SECURE;
+        break;
+    case 0b01:
+        ss = AARCH64_EL0_NONSECURE;
+        break;
+    case 0b11:
+        ss = AARCH64_EL0_REALM;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    const uint8_t num_ss = 3;
+    Aarch64PrivilegeLevel pl = el * num_ss + ss;
+    return pl;
+}
+
 static uint64_t aarch64_get_frame_pointer(Cpu *cpu_)
 {
     Aarch64Cpu *cpu = cpu_->arch;
@@ -443,6 +535,10 @@ static void aarch64_init(Cpu *cpu_)
         reg = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
         if (!strcmp(reg->name, "x29")) {
             cpu->reg_fp = reg->handle;
+        } else if (!strcmp(reg->name, "cpsr")) {
+            cpu->reg_cpsr = reg->handle;
+        } else if (!strcmp(reg->name, "SCR_EL3")) {
+            cpu->reg_scr_el3 = reg->handle;
         }
     }
     if (!cpu->reg_fp) {
@@ -450,6 +546,8 @@ static void aarch64_init(Cpu *cpu_)
                         "available. Please use an AArch64 cpu (or -cpu max).\n");
         g_abort();
     }
+    g_assert(cpu->reg_cpsr);
+    /* scr_el3 is optional */
 }
 
 static void aarch64_end(Cpu *cpu)
@@ -471,9 +569,43 @@ static CpuOps aarch64_ops = {
     .init = aarch64_init,
     .end = aarch64_end,
     .get_frame_pointer = aarch64_get_frame_pointer,
+    .get_privilege_level = aarch64_get_privilege_level,
+    .num_privilege_levels = aarch64_num_privilege_levels,
+    .get_privilege_level_name = aarch64_get_privilege_level_name,
     .does_insn_modify_frame_pointer = aarch64_does_insn_modify_frame_pointer,
 };
 
+static void track_privilege_change(unsigned int cpu_index, void *udata)
+{
+    Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
+    uint8_t new_pl = cpu->ops.get_privilege_level(cpu);
+
+    if (new_pl == cpu->privilege_level) {
+        return;
+    }
+
+    uint64_t pc = (uintptr_t) udata;
+    uint64_t timestamp = cpu_get_timestamp(cpu);
+
+    if (trace_sample) {
+        cpu_trace_last_sample(cpu, timestamp);
+    }
+
+    trace_exit_stack(cpu->trace, cpu->cs, timestamp);
+    callstack_clear(cpu->cs);
+
+    cpu->privilege_level = new_pl;
+    cpu->cs = g_array_index(cpu->callstacks, callstack*, new_pl);
+    cpu->trace = g_array_index(cpu->traces, trace*, new_pl);
+
+    cpu_unwind_stack(cpu, cpu->ops.get_frame_pointer(cpu), pc);
+    trace_enter_stack(cpu->trace, cpu->cs, timestamp);
+
+    if (trace_sample) {
+        cpu_set_new_sample(cpu, timestamp);
+    }
+}
+
 static void track_callstack(unsigned int cpu_index, void *udata)
 {
     uint64_t pc = (uintptr_t) udata;
@@ -568,7 +700,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     qemu_plugin_u64 sample_insn_count = qemu_plugin_scoreboard_u64_in_struct(
                                             score, Cpu, sample_insn_count);
 
-    if (trace_sample) {
+    if (trace_sample && !trace_privilege_level) {
         /* We can do a light instrumentation, per tb only */
         qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
             tb, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, n_insns);
@@ -581,6 +713,12 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         return;
     }
 
+    if (trace_privilege_level) {
+        qemu_plugin_register_vcpu_tb_exec_cb(tb, track_privilege_change,
+                                             QEMU_PLUGIN_CB_R_REGS,
+                                             (void *) tb_pc);
+    }
+
     /*
      * We now instrument all instructions following one that might have updated
      * the frame pointer. We always instrument first instruction in block, as
@@ -623,17 +761,33 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
     g_assert(vcpu_index < 1000);
     uint32_t trace_id = 1000 * 1000 + vcpu_index * 1000;
 
-    g_autoptr(GString) trace_name = g_string_new(NULL);
-    g_string_append_printf(trace_name, "cpu%u", vcpu_index);
-    trace *t = trace_new(trace_id, trace_name);
-    g_array_append_val(cpu->traces, t);
-    callstack *cs = callstack_new();
-    g_array_append_val(cpu->callstacks, cs);
-    /* create/truncate trace file */
-    trace_flush(t, false);
+    if (trace_privilege_level) {
+        for (uint8_t pl = 0; pl < cpu->ops.num_privilege_levels(); ++pl) {
+            g_autoptr(GString) trace_name = g_string_new(NULL);
+            g_string_append_printf(trace_name, "cpu%u %s", vcpu_index,
+                                   cpu->ops.get_privilege_level_name(pl));
+            trace *t = trace_new(trace_id + pl, trace_name);
+            g_array_append_val(cpu->traces, t);
+            callstack *cs = callstack_new();
+            g_array_append_val(cpu->callstacks, cs);
+        }
+    } else {
+        g_autoptr(GString) trace_name = g_string_new(NULL);
+        g_string_append_printf(trace_name, "cpu%u", vcpu_index);
+        trace *t = trace_new(trace_id, trace_name);
+        g_array_append_val(cpu->traces, t);
+        callstack *cs = callstack_new();
+        g_array_append_val(cpu->callstacks, cs);
+    }
 
-    cpu->cs = cs;
-    cpu->trace = t;
+    for (size_t i = 0; i < cpu->traces->len; ++i) {
+        /* create/truncate trace files */
+        trace *t = g_array_index(cpu->traces, trace*, i);
+        trace_flush(t, false);
+    }
+
+    cpu->cs = g_array_index(cpu->callstacks, callstack*, cpu->privilege_level);
+    cpu->trace = g_array_index(cpu->traces, trace*, cpu->privilege_level);
 }
 
 static void vcpu_end(unsigned int vcpu_index)
@@ -706,6 +860,12 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 return -1;
             }
             trace_sample = value;
+        } else if (g_strcmp0(tokens[0], "trace-privilege-level") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
+                                        &trace_privilege_level)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
-- 
2.47.2


