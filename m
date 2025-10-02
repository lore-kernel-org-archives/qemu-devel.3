Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07F1CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 11:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4HQL-0005mM-GC; Thu, 02 Oct 2025 07:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HQC-0005jo-RW
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:24:30 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HPq-0005r6-70
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:24:27 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-71d6051afbfso10388517b3.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1759404239; x=1760009039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkrzsHqSedSFGDe43Xmu0/Lp3le2mRyCIp/9USiOLRw=;
 b=H6mCJ1sKK47fHKQTmD9kH+GElYHoYFbQpERGVmpexrJhDIqHCfbadbKk78oSegsYws
 7SMgGa6o5GmeF+c6LtZQiVLOc0mONnmTtAT1hpMKoFvXOOOeUyFUtX/46cbZaQ80GuhA
 XNm5DEHyWGeM7pVAep/MZ2NX36tfmBnw57oilqatDUSIGbTIByZJKQz2sYmskxBG8Pks
 /TUndUit5kYSQUPumA9gAw+l88r8h1Ky51zcCg6W3mjjqTbjhVehB5i1vlxDgDDmuonu
 h2i5KfGAvSnSi4Kn41UgTzNKX6p11nWAHpFialLmZYivAElnlo4WAY1plovMGXUg0T6W
 POLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759404239; x=1760009039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jkrzsHqSedSFGDe43Xmu0/Lp3le2mRyCIp/9USiOLRw=;
 b=DhMf2KWx0sE/s9teDw7J4U9Rtr2NXbrqbiONEj8GWHgszi1cpGOtxuAxHRRgvMyRk6
 ssuNwhWz0oYsozZhgUsGg85OfSyBtYl7v58EyVJ500XfYlt8mze74pyDg2bp3tWiqcw/
 cPEFjOKyMduT4OacUHjrhtxPaa4fpDylP+dUSFNw/moAXk5VtFDOoP/Kt/TiOmL8R6T/
 ZAPTRC7Yru8pqpYKzD5/KvgIgZY1RSRuyPWpVSieXV14CSHWtADkrVa8fr1i98iI8QZ/
 zuEIX//7NVAGRlKbKEU/65cMxsZFzfE5vfahk0zCJysoyTMFOkKhC5vQqbvs424ohQyF
 Ar4A==
X-Gm-Message-State: AOJu0YxJRT+lwxkxMp9tNZcVCWXvInUlWcfBcmwOc1sBQjFUh/qatTwF
 HpuwfammtNO2d0ns+JPWXmn7io9p9cRVv0T3WfVCJA9YYIbB/FFQF3C+qtk9cj+jhlteuDxVUZG
 3EPs0lvI=
X-Gm-Gg: ASbGncuyvESbXbARHOrMs1bZFMXqF56kC5M1muNvJUBM1oq/tjDjif86cuLbwGio0eW
 m1dpATJGXz/pP3gH1HY3mMYOlgcPzq3cbEwfLxbbhaOr2oUQ+k02KJvQfhMb9DoLzaw6IsEsfM6
 NwXTVBfdxXnal5tOcDZ+AsAMI1hMkoQz1ENTgzaTva5j03+WvdqVuSvGF91Z6zFaBzRGxs8s/Tu
 Xi6yOfk9Jb7wK0GpiC1r60qFyhnMSvFcGDxuEUz8/sEJ8Scd2Jd+dEAuS4+3symDZMpkuuELdC6
 HNTJC0gYpS3a8zkBWkObfePXUVyWn72mCo9CUU/pfGD1yHSdPvoWiYGuaIytNjM30weAfx2zkLW
 nJsPopjwFd1D2Jy8mA7b8hpg0deYSN2ryQf70IeRC8oPjCEbYc1BlgLZk6z0GX1P3uaJGUjfpvU
 I=
X-Google-Smtp-Source: AGHT+IFejQPi10xYTNmguWXiLRC6XW9cW93m05WeqhDtTQgMh+7tzLbXhkj8QfxDW/fLf4O/p1hM4A==
X-Received: by 2002:a05:690c:a0c7:b0:74c:8a3:a39b with SMTP id
 00721157ae682-77f6f2a3acemr74087117b3.2.1759404239193; 
 Thu, 02 Oct 2025 04:23:59 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:b174:a9af:8146:7deb:fbf3])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-77f81c068f6sm7331627b3.5.2025.10.02.04.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 04:23:58 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 07/17] target/riscv: add initial trace instrumentation
Date: Thu,  2 Oct 2025 08:23:25 -0300
Message-ID: <20251002112335.2374517-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
References: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index d0ab445637..9d85c6ef55 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -513,6 +513,8 @@ struct CPUArchState {
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
index 6fc06c71f5..75348480e6 100644
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
@@ -1325,6 +1328,11 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
 {
+    TCGLabel *skip = gen_new_label();
+
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_trace_running, 0, skip);
+    gen_helper_trace_insn(tcg_env, tcg_constant_i64(db->pc_first));
+    gen_set_label(skip);
 }
 
 static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
@@ -1449,4 +1457,6 @@ void riscv_translate_init(void)
                              "load_res");
     load_val = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_val),
                              "load_val");
+    cpu_trace_running = tcg_global_mem_new(tcg_env,
+                offsetof(CPURISCVState, trace_running), "trace_running");
 }
-- 
2.51.0


