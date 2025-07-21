Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FC4C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 19:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udwHs-0003Ro-KW; Mon, 21 Jul 2025 15:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1udwGr-0002c7-Tq
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 15:34:00 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1udwGp-0003Uf-A3
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 15:33:57 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-235d6de331fso54300135ad.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 12:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753126434; x=1753731234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jcmFbOiVpquKEieZ7mSi2vF0OBN5CJXXV8GbAAyMRJg=;
 b=gd3sR8/4RHi6sITJCkIHYuYoq+LCGuRwpQhCJrmm4ywrgWLNcCQlX9+P9TYBHGhnYj
 Yh8T07TbdrkelGoUSZJrsbjFvIkltCAEe+6zDI2bgQuVUZ/KTd2FHO10sZIXiXz0l1yY
 4CbgKQUHD9nvwI1Xsi4Tslr0vOxc3Kxea/FSX1mLk1GQVHd3FnC8YDesHggzuEJHrRaH
 2b1wsSpsMDZ4EOkIhl2uNwiAfXnu4mkqfZJa7DVOqOw4OJlTm2flxK8VoFN7ztPdXg1w
 Oa69nyAJJByII8DPFN9MUt/Gsq9iPJL+VXJjAAKyCL5Ei4LO+sN7pGoh8HkWeFn498Tb
 +mhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753126434; x=1753731234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jcmFbOiVpquKEieZ7mSi2vF0OBN5CJXXV8GbAAyMRJg=;
 b=TqfneLxLN3wpU4jL9bx70Ve6cY6/4WkK/wG5yUxoHqH5Hjgl9HOZtm+SKeYPnxOr5R
 /qzon596OQumMUbrokXqH/1ga6LKj1ZRAmvAo1buqJGOodTWUPYHWw17oZ5Bv6jIhX1v
 fnnU/NCowZofn26P/jjuRfp3ImW8OYk/lsjqfhNqveS5IaptPkg2KxawvPRh1cQ0yGzr
 fcQ29qvmJ9dXfA55gk+OBReALs2VLxiiEc04mbeIYuAyIACug5MEO7YHXYPED9zd1r4S
 yqyUDrZuHXrQexis6uWf9o1nWW+hGRvTvpzzs584Pic6hbIVQZTQOAaoTnm59wtjdujr
 5ntg==
X-Gm-Message-State: AOJu0Yz1miBscn/Hqc4i/KxFChhvhiZdWsCWGZQU1Ur+oV0JDomI+Lta
 MgLZQeGV2x7tzfKggWKPhdQxYSYAVRUp+mNCJKG2La5yY5DSuTltp696PfsrVqJPrHEAWKXqmaN
 /Sj4Y
X-Gm-Gg: ASbGncsXjczd8JJnc2bIFRzAdAL1+mfyx2AIaUsuKTLCOWMCh06v9d+L0JffR5shyhf
 Lhf8DRlONxdZQu3vDomMhc/bZhDip5G1ZO1h/nPWaSEXL9jLV6uoBU+LzGq4VGSmct+sloOiolz
 /Nyh4xN+Ey8yMc6/XlpgzUlawHh3zNPJUuMH5DIcEKVTvDgYLsF3UlXjHAC+6cpoBXaLjuuYGK5
 MmveCWMWGpa8f3vjgc7URC+CJ6ZOWMQQTzifyARNgowUYsaMuZt8Wq7IGht3GCWYb6ac4PPCXqw
 quGf+Rgmfj+Gat0ghmUJCB35Ef/cYwq7mUN6UAA/yGgtJlD5zeVWjjNtkegqNnybWRvj4ZcfYlj
 64MFVoElObtxE/A0uej+XoQ==
X-Google-Smtp-Source: AGHT+IGFuQUMpIH71NSx6IYTyttEr2Xq5FXAftKCA2WQWFJLdgo+Kc6/DVEYYEjChDjELms6HFR0pg==
X-Received: by 2002:a17:903:1112:b0:235:ec11:f0ee with SMTP id
 d9443c01a7336-23e2569bbe0mr284901465ad.14.1753126433601; 
 Mon, 21 Jul 2025 12:33:53 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e4750sm62238685ad.6.2025.07.21.12.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 12:33:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, rowan Hart <rowanbhart@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v2 3/6] contrib/plugins/uftrace: add trace-privilege-level
 option
Date: Mon, 21 Jul 2025 12:33:37 -0700
Message-ID: <20250721193340.1059019-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250721193340.1059019-1-pierrick.bouvier@linaro.org>
References: <20250721193340.1059019-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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
index 1f3b8aaf828..ff4dcb4e9bf 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -38,6 +38,9 @@ typedef struct {
     void (*init)(Cpu *cpu);
     void (*end)(Cpu *cpu);
     uint64_t (*get_frame_pointer)(Cpu *cpu);
+    uint8_t (*get_privilege_level)(Cpu *cpu);
+    uint8_t (*num_privilege_levels)(void);
+    const char *(*get_privilege_level_name)(uint8_t pl);
     bool (*does_insn_modify_frame_pointer)(const char *disas);
 } CpuOps;
 
@@ -48,6 +51,7 @@ typedef struct Cpu {
     callstack *sample_cs;
     trace *trace;
     callstack *cs;
+    uint8_t privilege_level;
     GArray *callstacks; /* callstack *callstacks[] */
     GArray *traces; /* trace *traces [] */
     GByteArray *buf;
@@ -55,8 +59,23 @@ typedef struct Cpu {
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
@@ -73,6 +92,7 @@ enum uftrace_record_type {
 
 static struct qemu_plugin_scoreboard *score;
 static uint64_t trace_sample;
+static bool trace_privilege_level;
 static CpuOps arch_ops;
 
 static void uftrace_write_map(bool system_emulation)
@@ -357,6 +377,16 @@ static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
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
@@ -426,6 +456,68 @@ static uint64_t cpu_get_timestamp(const Cpu *cpu)
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
@@ -442,6 +534,10 @@ static void aarch64_init(Cpu *cpu_)
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
@@ -449,6 +545,8 @@ static void aarch64_init(Cpu *cpu_)
                         "available. Please use an AArch64 cpu (or -cpu max).\n");
         g_abort();
     }
+    g_assert(cpu->reg_cpsr);
+    /* scr_el3 is optional */
 }
 
 static void aarch64_end(Cpu *cpu)
@@ -470,9 +568,43 @@ static CpuOps aarch64_ops = {
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
@@ -567,7 +699,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     qemu_plugin_u64 sample_insn_count = qemu_plugin_scoreboard_u64_in_struct(
                                             score, Cpu, sample_insn_count);
 
-    if (trace_sample) {
+    if (trace_sample && !trace_privilege_level) {
         /* We can do a light instrumentation, per tb only */
         qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
             tb, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, n_insns);
@@ -580,6 +712,12 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
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
@@ -622,17 +760,33 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
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
@@ -705,6 +859,12 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
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


