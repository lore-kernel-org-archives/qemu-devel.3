Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240D9C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 20:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukTus-0002zj-QN; Fri, 08 Aug 2025 16:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukTup-0002xj-Lj
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:42:16 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukTun-0003D6-BW
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 16:42:15 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-23c8f179e1bso35145535ad.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 13:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754685732; x=1755290532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OC+nkp19eW2UdCXP3rejFdZ2iytq7Q0eqZRk2l9Xu90=;
 b=Lfz7BHKjiQ7xgSDgZ4Rs8lM7PkncWRGPJrgUrCLJyn+65Np+T6/65m1ahQWsmtXm1G
 eMV6rPJIJ0EESX+fe0ywfX8KjtW0kTAzSeiKgC8l6tyKJFiAlma1LhR4t2dbd09cG89Q
 XD513qSTuDdG8MxTuYfRhyO8JAlU8EdlZaDcVjuI4iElmMXzXh0m4+sz46H8dFLiKFNz
 BG88DDeZ1ZqvTdItRd2sqete7xKmKF8atsUl0j5o/58N2d7d+4x5CIOGxiUi8QGi23T+
 mnyX6zWyxitB4+yaSHwNdMtVdoKO19q+qQKWdX0AeW6XtYu3VpSs+c4tx0m/oppGV1ta
 u2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754685732; x=1755290532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OC+nkp19eW2UdCXP3rejFdZ2iytq7Q0eqZRk2l9Xu90=;
 b=RRddMHTodvq6lgmlSngsiN+vp8iE6i38dAvEbM6tRSYVI1X/lCTOsLp9Q6LfuoyDrW
 2DKS5/9s2IYxiL7ioqqMXPBYWqfRWHNofztPPs8mqZx2zPOUclrJQIDbZpfk37jJQeip
 036/UGWIQ8OfB834UxYZUce+P3CyDoQBIxGCDjH6+eOtQ+O+3iXis9Un8XbSqdk6q5M7
 3/uWI4gcLc/GhEzrLm4S5RLDP0Yo4jDlA8XxdTwHlqKZOs09c/Vq4uPE3ydo5NOu6rq4
 xv3UG73gdlAPda/e/Cd9/tZXkaBIgGOAM16BMwVLBeZm7AZO4NC2sPrISD28fEo9Jnd+
 XdFg==
X-Gm-Message-State: AOJu0YyvTfC7YYa9LgK3jTj3SRRB5LP9sh5x9PFDOLYUcYVVNgnTpMis
 i/Wdy27j+hcZFdjuiD8np+JECeyHQF9M5+LHvWuXs/56p8w8PexCRC792ublG3GLQ2thoxRGgIK
 OjM1OU9EHQQ==
X-Gm-Gg: ASbGnctRHAi/IcFf94HcKe439HJmbzeMPBtQlHbtHhw0E3EdDjS+pzdn/3TfYoQe8wz
 v3Tk4Z05mav0ClaQgIo/Ru5R8HPkydnoLkmr+6rIe8GvlPbBEQTwhi+qUfX1QGKuA7QQPLYhgiL
 Ld/w7UKL3LMQvALkR3N5ng3lZqyX1URi+IYBo073Dwr14kS5VWJ2WmIS7H6UxBQXe5BzBljJNP1
 MvYP0qoIbgvpROs71UjYzMZ68uC7mdcVk3TAcSJe+GUBbZsRc3KoFDjxnnbl1fmxvaunSKQGCe7
 4vwsqOjUDG2stTdtqdT0x2vVzabfd/R9rW7uzxDRywTXvCfyRdGGzhmhAITv9mMtK+YY0reQnA7
 I8z41HwTJyL0xTXJrWx9beA==
X-Google-Smtp-Source: AGHT+IH+rGpbRZWr8M2Dv8iop1vwOjsJXgnlECovkR9Wn+ZY18yjv39nTE5JJSg5IGEn1sYuDs7fqQ==
X-Received: by 2002:a17:903:3b87:b0:242:9bbc:c775 with SMTP id
 d9443c01a7336-242c2295bd6mr51591725ad.56.1754685731695; 
 Fri, 08 Aug 2025 13:42:11 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899a814sm217789945ad.117.2025.08.08.13.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 13:42:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org,
	pierrick.bouvier@linaro.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 5/9] contrib/plugins/uftrace: implement privilege level
 tracing
Date: Fri,  8 Aug 2025 13:41:52 -0700
Message-ID: <20250808204156.659715-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
References: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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
index 830967c215b..fa95341b8b9 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -44,19 +44,40 @@ typedef struct {
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
@@ -72,6 +93,7 @@ typedef enum {
 } UftraceRecordType;
 
 static struct qemu_plugin_scoreboard *score;
+static bool trace_privilege_level;
 static CpuOps arch_ops;
 
 static uint64_t gettime_ns(void)
@@ -249,6 +271,16 @@ static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
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
@@ -306,6 +338,68 @@ static struct qemu_plugin_register *plugin_find_register(const char *name)
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
@@ -322,6 +416,10 @@ static void aarch64_init(Cpu *cpu_)
                         "available. Please use an AArch64 cpu (or -cpu max).\n");
         g_abort();
     }
+    cpu->reg_cpsr = plugin_find_register("cpsr");
+    g_assert(cpu->reg_cpsr);
+    cpu->reg_scr_el3 = plugin_find_register("SCR_EL3");
+    /* scr_el3 is optional */
 }
 
 static void aarch64_end(Cpu *cpu)
@@ -343,9 +441,34 @@ static CpuOps aarch64_ops = {
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
@@ -398,6 +521,13 @@ static void track_callstack(unsigned int cpu_index, void *udata)
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
@@ -431,18 +561,36 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
 
     cpu->ops.init(cpu);
     cpu->buf = g_byte_array_new();
+    cpu->traces = g_array_new(0, 0, sizeof(Trace *));
 
     g_assert(vcpu_index < UINT32_MAX / 100);
-    /* trace_id is: cpu_number * 100 */
+    g_assert(cpu->ops.num_privilege_levels() < 100);
+    /* trace_id is: cpu_number * 100 + privilege_level */
     uint32_t trace_id = (vcpu_index + 1) * 100;
 
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
@@ -450,7 +598,12 @@ static void vcpu_end(unsigned int vcpu_index)
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
@@ -459,7 +612,13 @@ static void at_exit(qemu_plugin_id_t id, void *data)
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
 
@@ -470,6 +629,21 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
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


