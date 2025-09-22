Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0464ECAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0d5E-0005OS-SK; Mon, 22 Sep 2025 05:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0d4r-0004yO-BM
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:43:21 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0d4k-0001z1-2e
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:43:21 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45dd505a1dfso28895605e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 02:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758534191; x=1759138991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RYNYIu8+be0QQyu0ldhaTLfitOR3vF9PsleMTTGuEfw=;
 b=QlUR6aWrxBIamxUjH9CfoX2boQLIvSjBIykw/foq2nF918GMOOQNMKRWG8x9M7E+8m
 EmD1pe29f8CxTQvJkL2XDy1xjVSqiKBzxh7jFBJ12IHcnb8IAWzzmI5W/E+5sGISlJY6
 1wD7sVSJ7wQp/MAwAElJchM2OK/MZPxvucONxBEiS/jk+r0CCPipMvEq/f4SN2Q8MCde
 m6IHLxJhYvFJ1nI6q0+vNgkQ4bcroAH4NU/zvPUbKLH1MBTKm6H6f4mCBEHEID9oti/x
 PN4/WlYfWL01DJTxhkdJFswGr5dtPDq1I7WMze7ZyuTH+ACX3cPwdYV7/wAhmWS4r1db
 3uxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758534191; x=1759138991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RYNYIu8+be0QQyu0ldhaTLfitOR3vF9PsleMTTGuEfw=;
 b=dMrz1NmEj13KGQWC27emidxZntIqOqmB/wGTyFfMmlOEfDvkIoesxJnedZy+uwuK8G
 LDJWdjybEbhXd1RquihXmCw4CtkBQONKSW3MpNDi5G6fEsDjhuHHcSuCvHncwHlfLGFT
 2hfpGnr3i4GLNVG0w86mnVApQ4mWGPKQbe6GdANJjMGHgWSkA66njg39PcO41nttdaOJ
 aplJqOTuu8VBjJloAxRZbbuL+hxYj1f1LX9rlK7yXW4fDCQxiquBvjLrMhJHESDQViyM
 BfR/wEowPaMdvSENLObe0jiI6/boJjiMkV+L1XcD7+38bQWybCbTio0VyxvuiMODehbD
 IohA==
X-Gm-Message-State: AOJu0YxPEJPW4m88teBR6TJri4Llh3Tgch5ojSLXtrIBPvFKP9mHPnGZ
 H51FLMQX+ThG02egLa3eHkR2t/L5xRs1eR+fnATKrsMxVUlgD5bRPshGUVBhPfZ0tT4=
X-Gm-Gg: ASbGncsjjhR4Z1mdkAJmRUxpMwqoQAKTWSa+LG+Y30M3CCsIypjK0p6wB2jJWQVOlms
 O1ZHKpQbrVhB8lA14SOsr/XbxrF5gCrRhz+bQvEC/i1RkB8Ji+GIQTH7jYxZwkD6LvdbWWBCDqN
 p1iDp5Y/Ufniz1xJeb3IcFetpv2YyyC9cY0rJwU9jFb1xqfZ6BW/4coCKspj5tHJ1J+mRXjAXQq
 7rGxNbTE35W7vfc3hVakbV3EqZPH/ufnpZfmpLJyy3hkjdswhotQoSbauTjWYPboljybnHg14MF
 ttLcgyS+vIQ6o65M9jwXCPHA88NxU/jZEZPKU55dMGEIgdovCO8Im1Fd0VIC8kuVSd8gKLNS/go
 Ffwm+syTNetKGW+SynObYhN4=
X-Google-Smtp-Source: AGHT+IExuMgweMVP/T0fvHwaQ5QkiR/+Ix4PHNwiAEGgURlJdab8SAdPCwyJqTNcH210HOl/5/+8Yg==
X-Received: by 2002:a05:600c:4748:b0:456:1b6f:c888 with SMTP id
 5b1f17b1804b1-467f2242a87mr118994405e9.23.1758534190744; 
 Mon, 22 Sep 2025 02:43:10 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f88de2d075sm7646723f8f.35.2025.09.22.02.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:43:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8B9625FA42;
 Mon, 22 Sep 2025 10:37:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 21/25] contrib/plugins/uftrace: implement privilege level
 tracing
Date: Mon, 22 Sep 2025 10:37:06 +0100
Message-ID: <20250922093711.2768983-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922093711.2768983-1-alex.bennee@linaro.org>
References: <20250922093711.2768983-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We add new option trace-privilege-level=bool, which will create a
separate trace for each privilege level.
This allows to follow changes of privilege during execution.

We implement aarch64 operations to track current privilege level
accordingly.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250902075042.223990-6-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/uftrace.c | 190 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 182 insertions(+), 8 deletions(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index b9dcd531987..10abad0673c 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -46,19 +46,40 @@ typedef struct {
     void (*init)(Cpu *cpu);
     void (*end)(Cpu *cpu);
     uint64_t (*get_frame_pointer)(Cpu *cpu);
+    uint8_t (*get_privilege_level)(Cpu *cpu);
+    uint8_t (*num_privilege_levels)(void);
+    const char *(*get_privilege_level_name)(uint8_t pl);
     bool (*does_insn_modify_frame_pointer)(const char *disas);
 } CpuOps;
 
 typedef struct Cpu {
     Trace *trace;
     Callstack *cs;
+    uint8_t privilege_level;
+    GArray *traces; /* Trace *traces [] */
     GByteArray *buf;
     CpuOps ops;
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
+    AARCH64_PRIVILEGE_LEVEL_MAX,
+} Aarch64PrivilegeLevel;
+
 typedef struct {
     struct qemu_plugin_register *reg_fp;
+    struct qemu_plugin_register *reg_cpsr;
+    struct qemu_plugin_register *reg_scr_el3;
 } Aarch64Cpu;
 
 typedef struct {
@@ -74,6 +95,7 @@ typedef enum {
 } UftraceRecordType;
 
 static struct qemu_plugin_scoreboard *score;
+static bool trace_privilege_level;
 static CpuOps arch_ops;
 
 static uint64_t gettime_ns(void)
@@ -251,6 +273,16 @@ static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
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
@@ -308,6 +340,68 @@ static struct qemu_plugin_register *plugin_find_register(const char *name)
     return NULL;
 }
 
+static uint8_t aarch64_num_privilege_levels(void)
+{
+    return AARCH64_PRIVILEGE_LEVEL_MAX;
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
@@ -324,6 +418,10 @@ static void aarch64_init(Cpu *cpu_)
                         "available. Please use an AArch64 cpu (or -cpu max).\n");
         g_abort();
     }
+    cpu->reg_cpsr = plugin_find_register("cpsr");
+    g_assert(cpu->reg_cpsr);
+    cpu->reg_scr_el3 = plugin_find_register("SCR_EL3");
+    /* scr_el3 is optional */
 }
 
 static void aarch64_end(Cpu *cpu)
@@ -345,9 +443,34 @@ static CpuOps aarch64_ops = {
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
+    uint64_t timestamp = gettime_ns();
+
+    trace_exit_stack(cpu->trace, cpu->cs, timestamp);
+    callstack_clear(cpu->cs);
+
+    cpu->privilege_level = new_pl;
+    cpu->trace = g_array_index(cpu->traces, Trace*, new_pl);
+
+    cpu_unwind_stack(cpu, cpu->ops.get_frame_pointer(cpu), pc);
+    trace_enter_stack(cpu->trace, cpu->cs, timestamp);
+}
+
 static void track_callstack(unsigned int cpu_index, void *udata)
 {
     uint64_t pc = (uintptr_t) udata;
@@ -400,6 +523,13 @@ static void track_callstack(unsigned int cpu_index, void *udata)
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
     size_t n_insns = qemu_plugin_tb_n_insns(tb);
+    uintptr_t tb_pc = qemu_plugin_tb_vaddr(tb);
+
+    if (trace_privilege_level) {
+        qemu_plugin_register_vcpu_tb_exec_cb(tb, track_privilege_change,
+                                             QEMU_PLUGIN_CB_R_REGS,
+                                             (void *) tb_pc);
+    }
 
     /*
      * Callbacks and inline instrumentation are inserted before an instruction.
@@ -433,18 +563,36 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
 
     cpu->ops.init(cpu);
     cpu->buf = g_byte_array_new();
+    cpu->traces = g_array_new(0, 0, sizeof(Trace *));
 
     g_assert(vcpu_index < UINT32_MAX / TRACE_ID_SCALE);
-    /* trace_id is: cpu_number * TRACE_ID_SCALE */
+    g_assert(cpu->ops.num_privilege_levels() < TRACE_ID_SCALE);
+    /* trace_id is: cpu_number * TRACE_ID_SCALE + privilege_level */
     uint32_t trace_id = (vcpu_index + 1) * TRACE_ID_SCALE;
 
-    g_autoptr(GString) trace_name = g_string_new(NULL);
-    g_string_append_printf(trace_name, "cpu%u", vcpu_index);
-    cpu->trace = trace_new(trace_id, trace_name);
-    /* create/truncate trace file */
-    trace_flush(cpu->trace, false);
+    if (trace_privilege_level) {
+        for (uint8_t pl = 0; pl < cpu->ops.num_privilege_levels(); ++pl) {
+            g_autoptr(GString) trace_name = g_string_new(NULL);
+            g_string_append_printf(trace_name, "cpu%u %s", vcpu_index,
+                                   cpu->ops.get_privilege_level_name(pl));
+            Trace *t = trace_new(trace_id + pl, trace_name);
+            g_array_append_val(cpu->traces, t);
+        }
+    } else {
+        g_autoptr(GString) trace_name = g_string_new(NULL);
+        g_string_append_printf(trace_name, "cpu%u", vcpu_index);
+        Trace *t = trace_new(trace_id, trace_name);
+        g_array_append_val(cpu->traces, t);
+    }
+
+    for (size_t i = 0; i < cpu->traces->len; ++i) {
+        /* create/truncate trace files */
+        Trace *t = g_array_index(cpu->traces, Trace*, i);
+        trace_flush(t, false);
+    }
 
     cpu->cs = callstack_new();
+    cpu->trace = g_array_index(cpu->traces, Trace*, cpu->privilege_level);
 }
 
 static void vcpu_end(unsigned int vcpu_index)
@@ -452,7 +600,12 @@ static void vcpu_end(unsigned int vcpu_index)
     Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
     g_byte_array_free(cpu->buf, true);
 
-    trace_free(cpu->trace);
+    for (size_t i = 0; i < cpu->traces->len; ++i) {
+        Trace *t = g_array_index(cpu->traces, Trace*, i);
+        trace_free(t);
+    }
+
+    g_array_free(cpu->traces, true);
     callstack_free(cpu->cs);
     memset(cpu, 0, sizeof(Cpu));
 }
@@ -461,7 +614,13 @@ static void at_exit(qemu_plugin_id_t id, void *data)
 {
     for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
         Cpu *cpu = qemu_plugin_scoreboard_find(score, i);
-        trace_flush(cpu->trace, true);
+        for (size_t j = 0; j < cpu->traces->len; ++j) {
+            Trace *t = g_array_index(cpu->traces, Trace*, j);
+            trace_flush(t, true);
+        }
+    }
+
+    for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
         vcpu_end(i);
     }
 
@@ -472,6 +631,21 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv)
 {
+    for (int i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "trace-privilege-level") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
+                                        &trace_privilege_level)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
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
2.47.3


