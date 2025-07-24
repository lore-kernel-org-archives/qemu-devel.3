Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC2DC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 20:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf2p7-00057S-L9; Thu, 24 Jul 2025 16:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uf2p4-00055B-5l
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:45:51 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uf2p1-0007Mh-P1
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:45:49 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b39011e5f8eso1389094a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 13:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753389938; x=1753994738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHM/wlC23GB8B+z+ofUSGekwvcloMeBSPT2vdT511OU=;
 b=RILjVQYMk2jF5K+yCHYJGEVYZv0MOm+aSEZUoDcy8LzJ+qIB1vd7+YIrJ7xBnDHN5Z
 gv6i+EC4f1urCOcErZFisHEkSKPaUrTFyD6vJUgvw7HQjPqVQq2hg8yjUSiFHNFuktxT
 BSvQoAqeLSs/GmcsalonJvgII7qbZEuXJojGQfdGOno0P6woIXhTNRG4IfQ3V2wrcX9s
 HQQE7ZccV0J945d6rocAezbAYAzAXED/1k1l+xtqR5gOCdGrkDDQjoM/l085Q35GXulJ
 x9In+D915YN5cqWTdvSdnQMnwYkIdXz3m0OYCd5Cj3PftXhr9qf/SVCxXhwK4DeOMfvC
 R2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753389938; x=1753994738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHM/wlC23GB8B+z+ofUSGekwvcloMeBSPT2vdT511OU=;
 b=I3saPdJSXXESmdoAAJKeyS7HKaq5ksgkafrpBYc0yofcDCFV29EvKpNllB1kzAR0nV
 UE6gTYMYNOvUANeo5U8w2HnzLItaUxjiao6luNUg0XXqJSP04L39Uv8/JweGn1FrtBhh
 I5cpsSFV7wKS3k0ddSOa/v7wTMP0TF5IMNylCk2So5wMMzPqiLY6I4O0LHj9q3IRww7L
 RHy4gT8V6RPD1E38Xs2kP0GtcL/rezmdyjxA6VlL6yTrvJ8CDUZNfeZpIRTWgYP5v5E7
 cRWZucqWYa0YViBkn/HIR57hRRsA9NizrsBEt+zA3OIoVxA1htmZGlPLG34l2ksRKvyr
 ETIw==
X-Gm-Message-State: AOJu0YzeQ4Vah8uH4Ozkol2j87ULJkuCCYO/iYqi7Jb+16R9FO2OeAWl
 zJZ9lKooHMavsya1gR8zu75LNPSKZQ6vCIgTbjx1IR9Dh759pQcqzgDHgbfRkhJ/nHpZ+oESe0a
 DsH8Z
X-Gm-Gg: ASbGnctZtbfQond5CYPQaYX5N9cL2Dkr3qaTHBvhNUGvkBw9bCMXCx+cXIyrKhyO5oD
 X5kjrL7oe+9igUyv+vIuTHImDWTc0wZhy29hLjaShywlGVisk8cEiTID3niMvQGZ7rvsbYRMWBg
 dTc3XWelIj72L+IsDgX7SN5QGXSM4ZaYy60CxwnMAaqEl9IciFb6542ZeVYOhc5P+oGCURpVLF8
 wnuxuvydDYTkwo+Xs0Hw5FjDrWJbReKVlLU9UvXvpKwGRPs6otFVZb/ZvLbyuYs8+HQM+ehrmM6
 a2szk29QR7BZH4TwAHy9zwxHqyA1Pr9naL2qqQusAKVaprCEayE45ibHTeEv0GKHY9AISOOOm4H
 P5JJF39eYqmHsHsmAhE15FQ==
X-Google-Smtp-Source: AGHT+IFTGNYN9W6ytkrwjutxatYSjx/LNt2mL0x8ES5EXH/Dzj2ZCkfgrvlpiEOPLEz15JSIhLNxcQ==
X-Received: by 2002:a17:90b:3b4c:b0:313:352f:6620 with SMTP id
 98e67ed59e1d1-31e5079f78bmr10091706a91.4.1753389937719; 
 Thu, 24 Jul 2025 13:45:37 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662f6be0sm2008849a91.35.2025.07.24.13.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 13:45:37 -0700 (PDT)
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
Subject: [PATCH v4 3/7] contrib/plugins/uftrace: add trace-privilege-level
 option
Date: Thu, 24 Jul 2025 13:45:22 -0700
Message-ID: <20250724204527.3175839-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724204527.3175839-1-pierrick.bouvier@linaro.org>
References: <20250724204527.3175839-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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


