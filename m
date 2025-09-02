Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCE9CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 07:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utLnR-00077s-LU; Tue, 02 Sep 2025 03:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnH-00074W-C4
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:08 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnC-0001v3-78
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:06 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-77238a3101fso1891644b3a.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 00:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756799461; x=1757404261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=er0+oHSby1SsX9Z+9EWvUqCthwUwJ7qhNzavtkJi6RU=;
 b=nHGEVe6Ev5DTBIPbOab80sT+VKvGzksH7C6eGnAtixhLP43vjfN1db2OWpCLAd/N71
 4cvZzL4XnREfDt7P4BObLIDZ/toVzUcVgwvhHw9lEAg+MWkgacuRgjL09vOcLQEYgYOv
 yxnwHQUHifmCuTiKWwKXBcrB/mvFexxiCUuQq1kMprH16u/7dLw3SiaoAZdzBfRJMc5M
 tlmr+3OP0oHcGLYnTQYfCqNM7BdXNctQiTY5qZWp/55/C53+ahHqsrkiJ67C+L4QsGfe
 igDoseX/+urePUQh+9WcpLiCEc9eSarEtdHUeOySDHWb0tZsO2wktY6WIz/9IJX9OH7d
 nooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756799461; x=1757404261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=er0+oHSby1SsX9Z+9EWvUqCthwUwJ7qhNzavtkJi6RU=;
 b=TXySyBUkXwJgvYNg1epwUqKqDlQAfKiBa9FQQ+MoaIfO2PpdRZbpxv6Cs7GzCTufye
 +xF+TlZ9zkN7YVJ1/A3c+qtw+YFdsKwN6QUkfX9eHFPc2ES5GDwQQy9D/Ci2cPRoMVUA
 EOViHayUBgc1Tp0yInt1nVik4rlAnxvB8Ibvwv5lIPx3nKXABVhVQOyQitRol7IdYU0R
 IKaUfQuS+G8yIZbGpO8/fDBsNYp/6hh3bRYQg5bgKqOUxf619F4qpeTY0+7sQIBx/iP6
 VwIH2qT5r6cyYRfyIc17UDZssfob9zhzI3TZABDnmDh7sXinp5gEGqRafMV+y+Q75wLk
 G1qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtesT3EcIRCxLj8mfl9w97u3/tU4Ih9LThhUhp3kwkujZ+M9Y8g7ULZRKx5kp3th7aZJ5RYUeJvXot@nongnu.org
X-Gm-Message-State: AOJu0YysGoIMSQgzBSvnWPyTKhxAcHsV7x2+DdhEdlDZJc1tZ55fqdQx
 zxoUArPsbUwYoYvx4ACZdzJalnusXrHGwzbLkCjHHoVVr1t0CPOBjfeFCYiJn0Nb/Ug=
X-Gm-Gg: ASbGncsiEpEW98a7mj/tOInhAsIeFq1naC0VqhM+TttKYgXrtOjQ30jWo/9bk4o3pjV
 rv8Ht7zogHggThSl00lkKuMkuHMn41G5pM4GF8q4E7Zg/kZcGv7RQNI48z4StPQ5OlL0bHnymW0
 9TiTQFhUM7xg1Lrd1iSQl/1JXGqVN3s4b2o6QxNDqJKW13jVozhwICwXqRrZyrbDzMLZEaWQa/c
 YupoU9nYwoM4tf6mVpxSrx6v4AMZM72K3zRHBzHsAjRbCEjFiKf5Y7s56xUb6WUwi85CJh02eLk
 JE5CPZ/76uNuu/gx5vKbF/ZsWFSNU6rz/jY/rXARJ6lsjB8mUOgA4Ub6jLKhfr76gPg5h5jBYNa
 MRyUYaUzU/Ajv6IOjf/xtmGfI6YAA324coHgWx356ARvOMlzmTCSR3g==
X-Google-Smtp-Source: AGHT+IHgS9VCui+a/c3yg/ET5SeXynWWo0EUdVnnfbFCHb8qyBQT7KJ//VkI1pSnMzMToyQosv482w==
X-Received: by 2002:a05:6300:210d:b0:243:a7e0:5113 with SMTP id
 adf61e73a8af0-243d6f39371mr14868436637.51.1756799460732; 
 Tue, 02 Sep 2025 00:51:00 -0700 (PDT)
Received: from pc.taild8403c.ts.net ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7723d79fcfesm9642766b3a.16.2025.09.02.00.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 00:51:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: pierrick.bouvier@linaro.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v7 5/9] contrib/plugins/uftrace: implement privilege level
 tracing
Date: Tue,  2 Sep 2025 00:50:38 -0700
Message-ID: <20250902075042.223990-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
References: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

We add new option trace-privilege-level=bool, which will create a
separate trace for each privilege level.
This allows to follow changes of privilege during execution.

We implement aarch64 operations to track current privilege level
accordingly.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
2.47.2


