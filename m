Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF487C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 09:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukJX1-0002tI-Oj; Fri, 08 Aug 2025 05:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukJWy-0002ix-TD
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:36:56 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukJWv-0001zQ-2N
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:36:56 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-617b36cc489so3718610a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 02:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754645809; x=1755250609; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UxeAyzcjMOCKaqJ/IhqAIhc71z5r11kXW4JVMokTh2o=;
 b=kMLTcwCURAxbC+QGXfSyFKkL2zEgGJ2KigUhe4vAT+J3H0tYRaNIOHnsh5F5l7aZhv
 +/C8a7yg6+IjhDlBmmWRaTxrnuRL3mvS8ZPR50QgHUdSP9ruOkgvi3jiAhbxst46pOQV
 Irz2KzCY5k8quc4cnqL4WxpMctOIajuY9314+Yy8a2z/TVMuM00A6zK0JFcb0BEwttLl
 Mqw31oHZETOuAwCUvnRIV2NdPtkOyfXmvp4Qd39b1NSXaIlhR97pJ8ZYjhGBp1rSWC+R
 sLnWN734HhC5fX1x3p8rvNuYrwEKRmMU82d/A7hEcR+Jsbli+2euxtZkouawmW2n3ivs
 PkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754645809; x=1755250609;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UxeAyzcjMOCKaqJ/IhqAIhc71z5r11kXW4JVMokTh2o=;
 b=MOIlBhOLVtr2qYt9pG6tSQVKCDy6+ixICIptm0/oqJcuVDtbDmPHhUd8hsR7CzpT0P
 K5pDlFjmDVrxmQCkEKMfLZS2EJvsqpvyBsPx4TGuAv2IA/qgGzvbu/r4O7oxjb9Fh2kg
 l520nP2FsvtdgJCzoECkuCajX1jlvGyOqeLIH0Phl2m8arhon/xOmgEDlE8Nvsb8Zhae
 Vvz7ml0ITXyy+bVacKgwX5sxA7wkBO0S3P1WJUx4UaAovostvCoB3N9vwOanuFYuHacZ
 U1hyDGKx7dGm692ZoegZV2vwodit8HxXaxnnL0ICp0YwSqpz6VVOAx2FVxqxUIwooHpt
 lPrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUESwlSEOAkx2mtoZYlNJzSORlxq+M0tJ72NcF64U83ser7R4rjCtcwIy6w6Bcm0dn2RozGoQ1wfGlL@nongnu.org
X-Gm-Message-State: AOJu0YzrRiOvLdhTh2R59LL4a47MpHXSuIKxNm/l+H4oKTccZi159QAU
 Hm4CakWjPnMZBC/rJr3zxPVOQ0mdzYyaM8Ml3uTd8xbO0EJ7R5yOWTwcVLcxBsSVn7s=
X-Gm-Gg: ASbGncvzk29Hwxf/5waVXSMM/g/6m63eex/roAx+ym0KC06zN0zcPBLjDM4SWkzxFqq
 05Vo4W+TooUafp+kldsQY63Ar2V4sKg/LiUbhMlm6pGEuq7VyBdqK6XNy0vmNNW+SjTOAsXrPfY
 IFE45v9hnoKxN4OxBawr5ab+v5x9ey4l5sZN37pA/uO/Mxse3S7wWnG80BR/VSaca614Z3hNF/x
 wyYbHVoxdITjIXs+0BW3Q+s00E29varghJ3b5daaEJe2Zn16qT6vZY5c+c5ygzTCBObQd1F3V3g
 tCFIEtW5NYI3IUIWS5jFEoXaDyQrUfm6R8pURPNnB+SgyGK8ojW13+J2V5TwiUMzIk2OYCTKeK5
 snjg4kli8F8emXOmgDMSIN+8i49C6oGWPzlgmxbjBOuhn5ffPB8YWUdAogmMdXFrqqxgP0IBA
X-Google-Smtp-Source: AGHT+IHI2fbFisC5QvJhm8S4m625yb/aw9+Gqzg/9Tooa1tMjE93cEOAycBZyxY1PWuS+KV4CJ1gJA==
X-Received: by 2002:a05:6402:5247:b0:615:97fe:54c6 with SMTP id
 4fb4d7f45d1cf-617e564749bmr1346430a12.31.1754645809043; 
 Fri, 08 Aug 2025 02:36:49 -0700 (PDT)
Received: from meli-email.org (athedsl-4440194.home.otenet.gr.
 [79.129.176.114]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615e1d9c409sm10198216a12.45.2025.08.08.02.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 02:36:48 -0700 (PDT)
Date: Fri, 08 Aug 2025 12:26:54 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 5/9] contrib/plugins/uftrace: implement privilege level
 tracing
User-Agent: meli/0.8.12
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-6-pierrick.bouvier@linaro.org>
In-Reply-To: <20250808020702.410109-6-pierrick.bouvier@linaro.org>
Message-ID: <t0o5db.32mzh34kom9qm@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52c.google.com
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

On Fri, 08 Aug 2025 05:06, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>We add new option trace-privilege-level=bool, which will create a
>separate trace for each privilege level.
>This allows to follow changes of privilege during execution.
>
>We implement aarch64 operations to track current privilege level
>accordingly.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>---
> contrib/plugins/uftrace.c | 189 ++++++++++++++++++++++++++++++++++++--
> 1 file changed, 181 insertions(+), 8 deletions(-)
>
>diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>index 402a242433e..7737626da2f 100644
>--- a/contrib/plugins/uftrace.c
>+++ b/contrib/plugins/uftrace.c
>@@ -44,19 +44,39 @@ typedef struct {
>     void (*init)(Cpu *cpu);
>     void (*end)(Cpu *cpu);
>     uint64_t (*get_frame_pointer)(Cpu *cpu);
>+    uint8_t (*get_privilege_level)(Cpu *cpu);
>+    uint8_t (*num_privilege_levels)(void);
>+    const char *(*get_privilege_level_name)(uint8_t pl);
>     bool (*does_insn_modify_frame_pointer)(const char *disas);
> } CpuOps;
> 
> typedef struct Cpu {
>     Trace *trace;
>     Callstack *cs;
>+    uint8_t privilege_level;
>+    GArray *traces; /* Trace *traces [] */
>     GByteArray *buf;
>     CpuOps ops;
>     void *arch;
> } Cpu;
> 
>+typedef enum {
>+    AARCH64_EL0_SECURE,
>+    AARCH64_EL0_NONSECURE,
>+    AARCH64_EL0_REALM,
>+    AARCH64_EL1_SECURE,
>+    AARCH64_EL1_NONSECURE,
>+    AARCH64_EL1_REALM,
>+    AARCH64_EL2_SECURE,
>+    AARCH64_EL2_NONSECURE,
>+    AARCH64_EL2_REALM,
>+    AARCH64_EL3,
>+} Aarch64PrivilegeLevel;
>+
> typedef struct {
>     struct qemu_plugin_register *reg_fp;
>+    struct qemu_plugin_register *reg_cpsr;
>+    struct qemu_plugin_register *reg_scr_el3;
> } Aarch64Cpu;
> 
> typedef struct {
>@@ -72,6 +92,7 @@ typedef enum {
> } UftraceRecordType;
> 
> static struct qemu_plugin_scoreboard *score;
>+static bool trace_privilege_level;
> static CpuOps arch_ops;
> 
> static uint64_t gettime_ns(void)
>@@ -248,6 +269,16 @@ static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
>     return *((uint64_t *) buf->data);
> }
> 
>+static uint32_t cpu_read_register32(Cpu *cpu, struct qemu_plugin_register *reg)
>+{
>+    GByteArray *buf = cpu->buf;
>+    g_byte_array_set_size(buf, 0);
>+    size_t sz = qemu_plugin_read_register(reg, buf);
>+    g_assert(sz == 4);
>+    g_assert(buf->len == 4);
>+    return *((uint32_t *) buf->data);
>+}
>+
> static uint64_t cpu_read_memory64(Cpu *cpu, uint64_t addr)
> {
>     g_assert(addr);
>@@ -305,6 +336,68 @@ static struct qemu_plugin_register *plugin_find_register(const char *name)
>     return NULL;
> }
> 
>+static uint8_t aarch64_num_privilege_levels(void)
>+{
>+    return AARCH64_EL3 + 1;

Nit: A common idiom is defining an _MAX enum variant that always stays 
on the bottom of the enum definition and equals the max value, thus 
ensuring you always refer to the correct maximum variant. Though I'd be 
surprised if they ever add an EL4 :^)

>+}
>+
>+static const char *aarch64_get_privilege_level_name(uint8_t pl)
>+{
>+    switch (pl) {
>+    case AARCH64_EL0_SECURE: return "S-EL0";
>+    case AARCH64_EL0_NONSECURE: return "NS-EL0";
>+    case AARCH64_EL0_REALM: return "R-EL0";
>+    case AARCH64_EL1_SECURE: return "S-EL1";
>+    case AARCH64_EL1_NONSECURE: return "NS-EL1";
>+    case AARCH64_EL1_REALM: return "R-EL1";
>+    case AARCH64_EL2_SECURE: return "S-EL2";
>+    case AARCH64_EL2_NONSECURE: return "NS-EL2";
>+    case AARCH64_EL2_REALM: return "R-EL2";
>+    case AARCH64_EL3: return "EL3";
>+    default:
>+        g_assert_not_reached();
>+    }
>+}
>+
>+static uint8_t aarch64_get_privilege_level(Cpu *cpu_)
>+{
>+    Aarch64Cpu *cpu = cpu_->arch;
>+    /*
>+     * QEMU gdbstub does not provide access to CurrentEL,

We should fix that... I wanted to do that for a while.

>+     * so we use CPSR instead.
>+     */
>+    uint8_t el = cpu_read_register32(cpu_, cpu->reg_cpsr) >> 2 & 0b11;
>+
>+    if (el == 3) {
>+        return AARCH64_EL3;
>+    }
>+
>+    uint8_t ss = AARCH64_EL0_SECURE;
>+    if (!cpu->reg_scr_el3) {
>+        ss = AARCH64_EL0_NONSECURE;
>+    }
>+    uint64_t scr_el3 = cpu_read_register64(cpu_, cpu->reg_scr_el3);
>+    uint64_t ns = (scr_el3 >> 0) & 0b1;
>+    uint64_t nse = (scr_el3 >> 62) & 0b1;
>+    switch (nse << 1 | ns) {
>+    case 0b00:
>+        ss = AARCH64_EL0_SECURE;
>+        break;
>+    case 0b01:
>+        ss = AARCH64_EL0_NONSECURE;
>+        break;
>+    case 0b11:
>+        ss = AARCH64_EL0_REALM;
>+        break;
>+    default:
>+        g_assert_not_reached();
>+    }
>+
>+    const uint8_t num_ss = 3;
>+    Aarch64PrivilegeLevel pl = el * num_ss + ss;

That's a bit blunt but I understand where you're coming from

>+    return pl;
>+}
>+
> static uint64_t aarch64_get_frame_pointer(Cpu *cpu_)
> {
>     Aarch64Cpu *cpu = cpu_->arch;
>@@ -321,6 +414,10 @@ static void aarch64_init(Cpu *cpu_)
>                         "available. Please use an AArch64 cpu (or -cpu max).\n");
>         g_abort();
>     }
>+    cpu->reg_cpsr = plugin_find_register("cpsr");
>+    g_assert(cpu->reg_cpsr);
>+    cpu->reg_scr_el3 = plugin_find_register("SCR_EL3");
>+    /* scr_el3 is optional */
> }
> 
> static void aarch64_end(Cpu *cpu)
>@@ -342,9 +439,34 @@ static CpuOps aarch64_ops = {
>     .init = aarch64_init,
>     .end = aarch64_end,
>     .get_frame_pointer = aarch64_get_frame_pointer,
>+    .get_privilege_level = aarch64_get_privilege_level,
>+    .num_privilege_levels = aarch64_num_privilege_levels,
>+    .get_privilege_level_name = aarch64_get_privilege_level_name,
>     .does_insn_modify_frame_pointer = aarch64_does_insn_modify_frame_pointer,
> };
> 
>+static void track_privilege_change(unsigned int cpu_index, void *udata)
>+{
>+    Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
>+    uint8_t new_pl = cpu->ops.get_privilege_level(cpu);
>+
>+    if (new_pl == cpu->privilege_level) {
>+        return;
>+    }
>+
>+    uint64_t pc = (uintptr_t) udata;
>+    uint64_t timestamp = gettime_ns();
>+
>+    trace_exit_stack(cpu->trace, cpu->cs, timestamp);
>+    callstack_clear(cpu->cs);
>+
>+    cpu->privilege_level = new_pl;
>+    cpu->trace = g_array_index(cpu->traces, Trace*, new_pl);
>+
>+    cpu_unwind_stack(cpu, cpu->ops.get_frame_pointer(cpu), pc);
>+    trace_enter_stack(cpu->trace, cpu->cs, timestamp);
>+}
>+
> static void track_callstack(unsigned int cpu_index, void *udata)
> {
>     uint64_t pc = (uintptr_t) udata;
>@@ -397,6 +519,13 @@ static void track_callstack(unsigned int cpu_index, void *udata)
> static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> {
>     size_t n_insns = qemu_plugin_tb_n_insns(tb);
>+    uintptr_t tb_pc = qemu_plugin_tb_vaddr(tb);
>+
>+    if (trace_privilege_level) {
>+        qemu_plugin_register_vcpu_tb_exec_cb(tb, track_privilege_change,
>+                                             QEMU_PLUGIN_CB_R_REGS,
>+                                             (void *) tb_pc);
>+    }
> 
>     /*
>      * We instrument all instructions following one that might have updated
>@@ -429,18 +558,36 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
> 
>     cpu->ops.init(cpu);
>     cpu->buf = g_byte_array_new();
>+    cpu->traces = g_array_new(0, 0, sizeof(Trace *));
> 
>     g_assert(vcpu_index < UINT32_MAX / 100);
>-    /* trace_id is: cpu_number * 100 */
>+    g_assert(cpu->ops.num_privilege_levels() < 100);
>+    /* trace_id is: cpu_number * 100 + privilege_level */
>     uint32_t trace_id = (vcpu_index + 1) * 100;
> 
>-    g_autoptr(GString) trace_name = g_string_new(NULL);
>-    g_string_append_printf(trace_name, "cpu%u", vcpu_index);
>-    cpu->trace = trace_new(trace_id, trace_name);
>-    /* create/truncate trace file */
>-    trace_flush(cpu->trace, false);
>+    if (trace_privilege_level) {
>+        for (uint8_t pl = 0; pl < cpu->ops.num_privilege_levels(); ++pl) {
>+            g_autoptr(GString) trace_name = g_string_new(NULL);
>+            g_string_append_printf(trace_name, "cpu%u %s", vcpu_index,
>+                                   cpu->ops.get_privilege_level_name(pl));
>+            Trace *t = trace_new(trace_id + pl, trace_name);
>+            g_array_append_val(cpu->traces, t);
>+        }
>+    } else {
>+        g_autoptr(GString) trace_name = g_string_new(NULL);
>+        g_string_append_printf(trace_name, "cpu%u", vcpu_index);
>+        Trace *t = trace_new(trace_id, trace_name);
>+        g_array_append_val(cpu->traces, t);
>+    }
>+
>+    for (size_t i = 0; i < cpu->traces->len; ++i) {
>+        /* create/truncate trace files */
>+        Trace *t = g_array_index(cpu->traces, Trace*, i);
>+        trace_flush(t, false);
>+    }
> 
>     cpu->cs = callstack_new();
>+    cpu->trace = g_array_index(cpu->traces, Trace*, cpu->privilege_level);
> }
> 
> static void vcpu_end(unsigned int vcpu_index)
>@@ -448,7 +595,12 @@ static void vcpu_end(unsigned int vcpu_index)
>     Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
>     g_byte_array_free(cpu->buf, true);
> 
>-    trace_free(cpu->trace);
>+    for (size_t i = 0; i < cpu->traces->len; ++i) {
>+        Trace *t = g_array_index(cpu->traces, Trace*, i);
>+        trace_free(t);
>+    }
>+
>+    g_array_free(cpu->traces, true);
>     callstack_free(cpu->cs);
>     memset(cpu, 0, sizeof(Cpu));
> }
>@@ -457,7 +609,13 @@ static void at_exit(qemu_plugin_id_t id, void *data)
> {
>     for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
>         Cpu *cpu = qemu_plugin_scoreboard_find(score, i);
>-        trace_flush(cpu->trace, true);
>+        for (size_t j = 0; j < cpu->traces->len; ++j) {
>+            Trace *t = g_array_index(cpu->traces, Trace*, j);
>+            trace_flush(t, true);
>+        }
>+    }
>+
>+    for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
>         vcpu_end(i);
>     }
> 
>@@ -468,6 +626,21 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                            const qemu_info_t *info,
>                                            int argc, char **argv)
> {
>+    for (int i = 0; i < argc; i++) {
>+        char *opt = argv[i];
>+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
>+        if (g_strcmp0(tokens[0], "trace-privilege-level") == 0) {
>+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
>+                                        &trace_privilege_level)) {
>+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
>+                return -1;
>+            }
>+        } else {
>+            fprintf(stderr, "option parsing failed: %s\n", opt);
>+            return -1;
>+        }
>+    }
>+
>     if (!strcmp(info->target_name, "aarch64")) {
>         arch_ops = aarch64_ops;
>     } else {
>-- 
>2.47.2
>

LGTM,

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

