Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4B2CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImrL-0006p9-H5; Tue, 11 Nov 2025 06:48:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImqq-0005QI-3h
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:47:56 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vImqo-0004SS-3X
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:47:55 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-bb7799edea8so1420329a12.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762861672; x=1763466472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F6peEc+cvY+9s8o6s1hl84CFHAQNCiQ60rb6SsD6LKk=;
 b=KGsGFez3zyF+BFn5RY1Doqxd9WiC63L2FuZQJDxvqfEN+A8YazvFCJoOvPrpeRDReA
 pzxnPphivFajB5WXgR3HI8I7I0ez4fxaO71QzqABlWjjFOAxPGDYKQjA0g1CMSg1NSI1
 dxQAFDU7PHFQQXf9/ClCCkAkbLkXgv6pxY25NJXmge7bT1mT2cfkQcydpQ4majIoZBSd
 PIZw3P6h9tQ7Tt3zzr0T1ffxtO7MpDA/K2+nWuT2qedQuUhVVUJwfKT6SiyI+ewARo+1
 lG8oEpn9rTkkx2YnXSPdfuaNf1WtCdgSjyNoHAyLWHcVJAbjuoCEyxzqLkxN84kmHZN7
 /u7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762861672; x=1763466472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F6peEc+cvY+9s8o6s1hl84CFHAQNCiQ60rb6SsD6LKk=;
 b=B/mLXC98RFQP6XsbFONacX3GBd96v6bjqktrHXtkOnAY8z01Np7WQSyknYoXbDL7RM
 U0ndfduCCMnTNsK0Bs3C1EgVZ35nTpeDVqV3prWVC4cye4NJ2XUzkYbgmaQYsTWX4Bp6
 /hFHaZZrci8BslujH+uFj/SufpLYlrPeTE2Dw7oG9Ffc58usDbzbjzkH4WS5qiiMv30V
 79yMqOksKADF+y9w4HtCh4/UtNEiYgieGA98+dq+7oEgDlLCjhyj0n7Qj4pu03dZrWx5
 EfRIL6PNXikTgVfZroAoJRLpyb5NaBWAZ2hlMKEXgQdspSyhb2YU1qVA5BFKC5lG6Uyo
 QvWg==
X-Gm-Message-State: AOJu0YzENC3ad4wj8s+uTWFtXJ6k3coSNJWsRrDixwociFVVCuO7il6K
 ppUNJSU6aMkFwv/7/Se5KrO2SwG6AcltL7G8mLv3eh/6bI5/rq0nRsD3HIUuT8kIuebq0xMQIKT
 pLKb3cjE=
X-Gm-Gg: ASbGncvJ5Uv4YgtW0/x9yVzgsYGcK+FOoAEAzyDDobvXw6SFHnRDrCl4v6j7Knfsjb1
 XOj2CInGSpses8Qzv+HSGADWL0J67dLG/oB4MGTryTgotmBiTuOTMJCa1vWoX2Q2ZM50svpgLBt
 rM81VAOJbk/cM+rFHWRbW70Pi2Bq66//x/bi6FxCSLA1p/bNpoSzRDLr5sn/jXYgbLTU4Z8PNxC
 nAWaie1wITRwTTBlpioKe+guBo8nkxlC7pUYN4+5JoAADcm5JkUO5xL5k+d5FsuDqQA4zM7dZxI
 VfedFJHkKYH5/BGETYIwpOY6Noi69p8uADc5tw6wSFMX1qj2DCahtSD2WLoxwKz8MxKR95LJocK
 lZ8vgfNoH4YholhUjn8EA3Xr0r36gGQARFPI98q3dLFAgxbahkwG1E+zAV8YjkJsOhhqsBwsIqC
 8Ryif6R4QyE1H68nL05xvaGM36cT4WPCthv3YbBA==
X-Google-Smtp-Source: AGHT+IHWM85KBJdxBlBTt0IYWzDZZHKzXWTt6GLyaw6DcqI4HMB/wG5bkBsS8JWBvBl6Np4r1ubS0w==
X-Received: by 2002:a17:903:38cd:b0:295:fdf2:d01e with SMTP id
 d9443c01a7336-297e53e7d10mr157776765ad.2.1762861672332; 
 Tue, 11 Nov 2025 03:47:52 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651c747d1sm177533125ad.63.2025.11.11.03.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 03:47:51 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 07/17] target/riscv: add initial trace instrumentation
Date: Tue, 11 Nov 2025 08:46:46 -0300
Message-ID: <20251111114656.2285048-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
References: <20251111114656.2285048-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52f.google.com
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

We'll have to instrument some RISC-V translations, as well as the start
of a translation block, communicating with the associated trace encoder
in case we're running a trace session. The trace encoder needs to report
the first insn of the session so we'll start with that.

Unfortunately we've run out of bits in tb_flags, meaning we can't use
riscv_tr_init_disas_context() and riscv_get_tb_cpu_state() to
communicate whether we're running a trace session. One alternative would
be to fold the "trace is running" logic in each trace helper. That would
make all code paths, regardless of even having a trace encoder
associated with the CPU, to check for trace encoder existence.

Another alternative, which is implemented here, is to add an additional
mirror flag 'trace_running' in CPURISCVState and turn it into a TCG
global 'cpu_trace_running'. Each trace helper call is gated via this
global, allowing us to skip calling trace helpers when we're not running
a trace session.

In case we end up increasing the size of tb_flags in the future we
should revisit this code and use tb_flags instead.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/trace-encoder.c    | 17 +++++++++++++++++
 hw/riscv/trace-encoder.h    |  4 ++++
 hw/riscv/trace-events       |  1 +
 target/riscv/cpu.h          |  2 ++
 target/riscv/helper.h       |  4 ++++
 target/riscv/meson.build    |  3 ++-
 target/riscv/trace_helper.c | 36 ++++++++++++++++++++++++++++++++++++
 target/riscv/translate.c    | 10 ++++++++++
 8 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 target/riscv/trace_helper.c

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index d45e45d17e..9701ce43cf 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -150,11 +150,15 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
     uint32_t trTeEnable = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL, ENABLE);
     uint32_t trTeInstTracing = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL,
                                                 INST_TRACING);
+    RISCVCPU *cpu = te->cpu;
+    CPURISCVState *env = &cpu->env;
 
     if (!trTeActive) {
         te->enabled = false;
         te->trace_running = false;
         te->trace_next_insn = false;
+
+        env->trace_running = false;
         return;
     }
 
@@ -170,6 +174,7 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
     }
 
     te->trace_running = trTeInstTracing ? true : false;
+    env->trace_running = te->trace_running;
 }
 
 static RegisterAccessInfo trencoder_regs_info[] = {
@@ -231,6 +236,8 @@ static const MemoryRegionOps trencoder_ops = {
 static void trencoder_reset(DeviceState *dev)
 {
     TraceEncoder *te = TRACE_ENCODER(dev);
+    RISCVCPU *cpu = te->cpu;
+    CPURISCVState *env = &cpu->env;
 
     for (int i = 0; i < ARRAY_SIZE(te->regs_info); i++) {
         register_reset(&te->regs_info[i]);
@@ -239,6 +246,7 @@ static void trencoder_reset(DeviceState *dev)
     te->enabled = false;
     te->trace_running = false;
     te->trace_next_insn = false;
+    env->trace_running = false;
 }
 
 static void trencoder_realize(DeviceState *dev, Error **errp)
@@ -266,6 +274,14 @@ static void trencoder_realize(DeviceState *dev, Error **errp)
     }
 }
 
+void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
+{
+    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+
+    trencoder->first_pc = pc;
+    trace_trencoder_first_trace_insn(pc);
+}
+
 static const Property trencoder_props[] = {
     /*
      * We need a link to the associated CPU to
@@ -294,6 +310,7 @@ static const VMStateDescription vmstate_trencoder = {
         VMSTATE_UINT64(ramsink_ramstart, TraceEncoder),
         VMSTATE_UINT64(ramsink_ramlimit, TraceEncoder),
         VMSTATE_INT32(cpu_id, TraceEncoder),
+        VMSTATE_UINT64(first_pc, TraceEncoder),
         VMSTATE_END_OF_LIST(),
     }
 };
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 001d872514..cf3177aefe 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -27,6 +27,8 @@ struct TraceEncoder {
     MemoryRegion reg_mem;
     uint32_t reg_mem_size;
 
+    uint64_t first_pc;
+
     hwaddr baseaddr;
     hwaddr dest_baseaddr;
     hwaddr ramsink_ramstart;
@@ -43,4 +45,6 @@ struct TraceEncoder {
 
 OBJECT_DECLARE_SIMPLE_TYPE(TraceEncoder, TRACE_ENCODER)
 
+void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc);
+
 #endif
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index 14e333fd9e..dc25377acf 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -28,6 +28,7 @@ riscv_iommu_hpm_evt_write(uint32_t ctr_idx, uint32_t ovf, uint64_t val) "ctr_idx
 # trace-encoder.c
 trencoder_read_error(uint64_t addr) "addr 0x%" PRIx64
 trencoder_write_error(uint64_t addr, uint64_t value) "addr 0x%" PRIx64 " value 0x%" PRIx64
+trencoder_first_trace_insn(uint64_t pc) "pc 0x%" PRIx64
 
 # trace-ram-sink.c
 tr_ramsink_read_error(uint64_t addr) "addr 0x%" PRIx64
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 12251e4d94..16c6c280a8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -514,6 +514,8 @@ struct CPUArchState {
     target_ulong rnmip;
     uint64_t rnmi_irqvec;
     uint64_t rnmi_excpvec;
+
+    bool trace_running;
 };
 
 /*
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index b785456ee0..e80320ad16 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -128,6 +128,10 @@ DEF_HELPER_4(csrrw, tl, env, int, tl, tl)
 DEF_HELPER_2(csrr_i128, tl, env, int)
 DEF_HELPER_4(csrw_i128, void, env, int, tl, tl)
 DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
+
+/* Trace helpers (should be put inside ifdef) */
+DEF_HELPER_2(trace_insn, void, env, i64)
+
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index fdefe88ccd..564e2da5f2 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -26,7 +26,8 @@ riscv_ss.add(files(
   'm128_helper.c',
   'crypto_helper.c',
   'zce_helper.c',
-  'vcrypto_helper.c'
+  'vcrypto_helper.c',
+  'trace_helper.c'
 ))
 
 riscv_system_ss = ss.source_set()
diff --git a/target/riscv/trace_helper.c b/target/riscv/trace_helper.c
new file mode 100644
index 0000000000..ed84e6f79a
--- /dev/null
+++ b/target/riscv/trace_helper.c
@@ -0,0 +1,36 @@
+/*
+ * RISC-V Trace Support TCG helpers
+ *
+ * Copyright (C) 2025 Ventana Micro Systems Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "trace.h"
+#include "exec/helper-proto.h"
+
+#ifndef CONFIG_USER_ONLY
+#include "hw/riscv/trace-encoder.h"
+#endif
+
+#ifndef CONFIG_USER_ONLY
+void helper_trace_insn(CPURISCVState *env, uint64_t pc)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    TraceEncoder *te = TRACE_ENCODER(cpu->trencoder);
+
+    if (te->trace_next_insn) {
+        trencoder_set_first_trace_insn(cpu->trencoder, pc);
+        te->trace_next_insn = false;
+    }
+}
+#else /* #ifndef CONFIG_USER_ONLY */
+void helper_trace_insn(CPURISCVState *env, uint64_t pc)
+{
+    return;
+}
+#endif /* #ifndef CONFIG_USER_ONLY*/
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index e1f4dc5ffd..ff288051e3 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -43,6 +43,9 @@ static TCGv_i64 cpu_fpr[32]; /* assume F and D extensions */
 static TCGv load_res;
 static TCGv load_val;
 
+/* TODO: this should be a tb_flag instead of a global */
+static TCGv cpu_trace_running;
+
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
  * it may require the inputs to be sign- or zero-extended; which will
@@ -1340,6 +1343,11 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
 {
+    TCGLabel *skip = gen_new_label();
+
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_trace_running, 0, skip);
+    gen_helper_trace_insn(tcg_env, tcg_constant_i64(db->pc_first));
+    gen_set_label(skip);
 }
 
 static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
@@ -1464,4 +1472,6 @@ void riscv_translate_init(void)
                              "load_res");
     load_val = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_val),
                              "load_val");
+    cpu_trace_running = tcg_global_mem_new(tcg_env,
+                offsetof(CPURISCVState, trace_running), "trace_running");
 }
-- 
2.51.1


