Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09053E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 05:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUfuA-0003jd-4C; Mon, 06 Jan 2025 00:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tUfu6-0003iu-RZ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 00:43:55 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tUfu4-0004If-Bq
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 00:43:54 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2163dc5155fso194934435ad.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2025 21:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1736142230; x=1736747030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DntsfFBjwCA5RYsDFTsuywnSc4lKU2VsGQNjqTvtrY0=;
 b=HHEMZWdiOsi9J0J+9Jo2fuWPPP+EnLbzPfK8ITb/gRxnARvxpLtkrg6hyq6PDXBC8l
 hfZzha2Lds/Bngm3sPl4wT5yE6ReLmQTndgSYqSluyn7W3xkiBdQDB7k5xH1yzwS9n1Z
 mWA1FimT4wuODoHn3lY4xKbm8KzzgRt5mCu0HutbBjHbuk0TEObQLGm6zYVcsm4X8jUm
 64F2rt7h100IbNL9yX1JEOwnoqXJZaUY5jQWorW3uOr21al3G5DoxLzus5ZXfLUoVssW
 LVpL0g9hHyKVSeD2qhjBYbnnxhsgVz7SlD5y0+iqSgfUSH9zlGrQP4VF10mQi6tV2GCZ
 7EGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736142230; x=1736747030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DntsfFBjwCA5RYsDFTsuywnSc4lKU2VsGQNjqTvtrY0=;
 b=pWX398eVoyz2HrvL3mKeanLtjAhpVA/JdqwUcJL3X7JHpmolTFBGk8dpStoQn29XGq
 JIa3BOi4gQlQ2x5Kf3IPLPr5jkuf9TUpDVo3xtTTM+wYTsbNcrmQv6sPKP0T5vDqCAKG
 XHy684Bp0Q2vdOH9v711qMOii8m4ouG/fRMmzDKb67dK5CMJ4yAYqLpdMK43recZYxul
 rIhp2NJ9p7lzsUh22qEMaXQ1c0a8w4Hztru3bqDdOEXHEYkuUZWQd8SYTVVQjHiLDtKh
 U3Z6d/g/ObYggZfp9nFYmug2zmjIDnBzazzoqJPD+ItUQF+04moJ0qOUEkq2B3Vy+tZB
 yWBw==
X-Gm-Message-State: AOJu0YyHoV+qhQ4aY1WZTkkcwwUBT6QwpZlQS7ZcIwL9PYBdGBMu7m5e
 37CsX/kNSKUh3ZWoYvYnWJlI7aVBtrmCFOF/WkTH5Zm08QwmxJqDUyClCUMAhgApqDQ9TvQjpAW
 S9BFMZEdC8ihIL+8wiXKPh20h3D1Rr9hKI8qOBQq2ejq6ccf6PB/18W0RO3OWQ5/Fe2aRquRDoY
 gVvtCkdVD21eQrJ9X4770/IX5q5XzoynX0zgW8IBrdGA==
X-Gm-Gg: ASbGnctGtBuY9EvtT7OZrwidp0MgWCjR8Rbl144EUtgG9FX3Qp5iqKXyzEv6BueaSHQ
 J/HnksSWh4L8DEWpZhKiixb5t1DnrChl6Qxj5OeJhR0lNr6CRMVeK2+MY9xsxEN0gfR8UDRVN8t
 AiXE2m6X6Rnc7F0vhe9d0MBhGZRf4u95r6O5mcWjCtkDCu8nRkyN2g+7SiiZlbUUEZZZDQVECoD
 D0qrMPTB566rHBSnsKvj8AAOkv01d27B44jnDs/+GubNA08u2HSk0QntBnPrB5dk98+E9wb4rmJ
 YhgNohVgckU=
X-Google-Smtp-Source: AGHT+IFXh5lAPkoTO7Q8rwrJebnYfNjWOTFXozz2ra+By2e3gSJpjGiUQzswqXXxEgTzdWyw3IodPw==
X-Received: by 2002:a17:902:d48a:b0:215:b8b6:d2ea with SMTP id
 d9443c01a7336-219e6ea1cc6mr748732875ad.15.1736142229963; 
 Sun, 05 Jan 2025 21:43:49 -0800 (PST)
Received: from fchang-1826.internal.sifive.com ([210.176.154.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eac6sm285722215ad.80.2025.01.05.21.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2025 21:43:49 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v12 3/6] target/riscv: Handle Smrnmi interrupt and exception
Date: Mon,  6 Jan 2025 13:43:33 +0800
Message-Id: <20250106054336.1878291-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106054336.1878291-1-frank.chang@sifive.com>
References: <20250106054336.1878291-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x634.google.com
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

From: Tommy Wu <tommy.wu@sifive.com>

Because the RNMI interrupt trap handler address is implementation defined.
We add the 'rnmi-interrupt-vector' and 'rnmi-exception-vector' as the property
of the harts. It’s very easy for users to set the address based on their
expectation. This patch also adds the functionality to handle the RNMI signals.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/riscv_hart.c         | 41 ++++++++++++++++
 include/hw/riscv/riscv_hart.h |  4 ++
 target/riscv/cpu.c            | 11 +++++
 target/riscv/cpu.h            |  3 ++
 target/riscv/cpu_bits.h       | 12 +++++
 target/riscv/cpu_helper.c     | 88 ++++++++++++++++++++++++++++++++---
 6 files changed, 152 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index bc9ffdd2d4..62b7c44350 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -26,6 +26,7 @@
 #include "target/riscv/cpu.h"
 #include "hw/qdev-properties.h"
 #include "hw/riscv/riscv_hart.h"
+#include "qemu/error-report.h"
 
 static const Property riscv_harts_props[] = {
     DEFINE_PROP_UINT32("num-harts", RISCVHartArrayState, num_harts, 1),
@@ -33,6 +34,23 @@ static const Property riscv_harts_props[] = {
     DEFINE_PROP_STRING("cpu-type", RISCVHartArrayState, cpu_type),
     DEFINE_PROP_UINT64("resetvec", RISCVHartArrayState, resetvec,
                        DEFAULT_RSTVEC),
+
+    /*
+     * Smrnmi implementation-defined interrupt and exception trap handlers.
+     *
+     * When an RNMI interrupt is detected, the hart then enters M-mode and
+     * jumps to the address defined by "rnmi-interrupt-vector".
+     *
+     * When the hart encounters an exception while executing in M-mode with
+     * the mnstatus.NMIE bit clear, the hart then jumps to the address
+     * defined by "rnmi-exception-vector".
+     */
+    DEFINE_PROP_ARRAY("rnmi-interrupt-vector", RISCVHartArrayState,
+                      num_rnmi_irqvec, rnmi_irqvec, qdev_prop_uint64,
+                      uint64_t),
+    DEFINE_PROP_ARRAY("rnmi-exception-vector", RISCVHartArrayState,
+                      num_rnmi_excpvec, rnmi_excpvec, qdev_prop_uint64,
+                      uint64_t),
 };
 
 static void riscv_harts_cpu_reset(void *opaque)
@@ -46,6 +64,29 @@ static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
 {
     object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx], cpu_type);
     qdev_prop_set_uint64(DEVICE(&s->harts[idx]), "resetvec", s->resetvec);
+
+    if (s->harts[idx].cfg.ext_smrnmi) {
+        if (idx < s->num_rnmi_irqvec) {
+            qdev_prop_set_uint64(DEVICE(&s->harts[idx]),
+                                 "rnmi-interrupt-vector", s->rnmi_irqvec[idx]);
+        }
+
+        if (idx < s->num_rnmi_excpvec) {
+            qdev_prop_set_uint64(DEVICE(&s->harts[idx]),
+                                 "rnmi-exception-vector", s->rnmi_excpvec[idx]);
+        }
+    } else {
+        if (s->num_rnmi_irqvec > 0) {
+            warn_report_once("rnmi-interrupt-vector property is ignored "
+                             "because Smrnmi extension is not enabled.");
+        }
+
+        if (s->num_rnmi_excpvec > 0) {
+            warn_report_once("rnmi-exception-vector property is ignored "
+                             "because Smrnmi extension is not enabled.");
+        }
+    }
+
     s->harts[idx].env.mhartid = s->hartid_base + idx;
     qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
     return qdev_realize(DEVICE(&s->harts[idx]), NULL, errp);
diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
index 912b4a2682..a6ed73a195 100644
--- a/include/hw/riscv/riscv_hart.h
+++ b/include/hw/riscv/riscv_hart.h
@@ -38,6 +38,10 @@ struct RISCVHartArrayState {
     uint32_t hartid_base;
     char *cpu_type;
     uint64_t resetvec;
+    uint32_t num_rnmi_irqvec;
+    uint64_t *rnmi_irqvec;
+    uint32_t num_rnmi_excpvec;
+    uint64_t *rnmi_excpvec;
     RISCVCPU *harts;
 };
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2ae9a8a895..29d530ad85 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1419,6 +1419,11 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
         g_assert_not_reached();
     }
 }
+
+static void riscv_cpu_set_nmi(void *opaque, int irq, int level)
+{
+    riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level);
+}
 #endif /* CONFIG_USER_ONLY */
 
 static bool riscv_cpu_is_dynamic(Object *cpu_obj)
@@ -1442,6 +1447,8 @@ static void riscv_cpu_init(Object *obj)
 #ifndef CONFIG_USER_ONLY
     qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
                       IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
+    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
+                            "riscv.cpu.rnmi", RNMI_MAX);
 #endif /* CONFIG_USER_ONLY */
 
     general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);
@@ -2798,6 +2805,10 @@ static const Property riscv_cpu_properties[] = {
 
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
+    DEFINE_PROP_UINT64("rnmi-interrupt-vector", RISCVCPU, env.rnmi_irqvec,
+                       DEFAULT_RNMI_IRQVEC),
+    DEFINE_PROP_UINT64("rnmi-exception-vector", RISCVCPU, env.rnmi_excpvec,
+                       DEFAULT_RNMI_EXCPVEC),
 #endif
 
     DEFINE_PROP_BOOL("short-isa-string", RISCVCPU, cfg.short_isa_string, false),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0079c640f7..2c4f12e1e1 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -493,6 +493,8 @@ struct CPUArchState {
     target_ulong mncause; /* mncause without bit XLEN-1 set to 1 */
     target_ulong mnstatus;
     target_ulong rnmip;
+    uint64_t rnmi_irqvec;
+    uint64_t rnmi_excpvec;
 };
 
 /*
@@ -591,6 +593,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
 uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
                               uint64_t value);
+void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
 void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
 void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 9e9637263d..17787fd693 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -680,6 +680,12 @@ typedef enum {
 /* Default Reset Vector address */
 #define DEFAULT_RSTVEC      0x1000
 
+/* Default RNMI Interrupt Vector address */
+#define DEFAULT_RNMI_IRQVEC     0x0
+
+/* Default RNMI Exception Vector address */
+#define DEFAULT_RNMI_EXCPVEC    0x0
+
 /* Exception causes */
 typedef enum RISCVException {
     RISCV_EXCP_NONE = -1, /* sentinel value */
@@ -734,6 +740,9 @@ typedef enum RISCVException {
 /* -1 is due to bit zero of hgeip and hgeie being ROZ. */
 #define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS - 1)
 
+/* RNMI causes */
+#define RNMI_MAX                           16
+
 /* mip masks */
 #define MIP_USIP                           (1 << IRQ_U_SOFT)
 #define MIP_SSIP                           (1 << IRQ_S_SOFT)
@@ -972,6 +981,9 @@ typedef enum RISCVException {
 #define MHPMEVENT_IDX_MASK                 0xFFFFF
 #define MHPMEVENT_SSCOF_RESVD              16
 
+/* RISC-V-specific interrupt pending bits. */
+#define CPU_INTERRUPT_RNMI                 CPU_INTERRUPT_TGT_EXT_0
+
 /* JVT CSR bits */
 #define JVT_MODE                           0x3F
 #define JVT_BASE                           (~0x3F)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f62b21e182..e90b85f2cd 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -505,6 +505,18 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
     uint64_t vsbits, irq_delegated;
     int virq;
 
+    /* Priority: RNMI > Other interrupt. */
+    if (riscv_cpu_cfg(env)->ext_smrnmi) {
+        /* If mnstatus.NMIE == 0, all interrupts are disabled. */
+        if (!get_field(env->mnstatus, MNSTATUS_NMIE)) {
+            return RISCV_EXCP_NONE;
+        }
+
+        if (env->rnmip) {
+            return ctz64(env->rnmip); /* since non-zero */
+        }
+    }
+
     /* Determine interrupt enable state of all privilege modes */
     if (env->virt_enabled) {
         mie = 1;
@@ -567,7 +579,9 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    if (interrupt_request & CPU_INTERRUPT_HARD) {
+    uint32_t mask = CPU_INTERRUPT_HARD | CPU_INTERRUPT_RNMI;
+
+    if (interrupt_request & mask) {
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
         int interruptno = riscv_cpu_local_irq_pending(env);
@@ -699,6 +713,30 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen)
     env->geilen = geilen;
 }
 
+void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level)
+{
+    CPURISCVState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+    bool release_lock = false;
+
+    if (!bql_locked()) {
+        release_lock = true;
+        bql_lock();
+    }
+
+    if (level) {
+        env->rnmip |= 1 << irq;
+        cpu_interrupt(cs, CPU_INTERRUPT_RNMI);
+    } else {
+        env->rnmip &= ~(1 << irq);
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_RNMI);
+    }
+
+    if (release_lock) {
+        bql_unlock();
+    }
+}
+
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
 {
     CPURISCVState *env = &cpu->env;
@@ -1849,6 +1887,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     bool write_gva = false;
     bool always_storeamo = (env->excp_uw2 & RISCV_UW2_ALWAYS_STORE_AMO);
     uint64_t s;
+    int mode;
 
     /*
      * cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
@@ -1866,7 +1905,24 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     target_ulong htval = 0;
     target_ulong mtval2 = 0;
     int sxlen = 0;
-    int mxlen = 0;
+    int mxlen = 16 << riscv_cpu_mxl(env);
+    bool nnmi_excep = false;
+
+    if (cpu->cfg.ext_smrnmi && env->rnmip && async) {
+        env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, false);
+        env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPV,
+                                  env->virt_enabled);
+        env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPP,
+                                  env->priv);
+        env->mncause = cause | ((target_ulong)1U << (mxlen - 1));
+        env->mnepc = env->pc;
+        env->pc = env->rnmi_irqvec;
+
+        /* Trapping to M mode, virt is disabled */
+        riscv_cpu_set_mode(env, PRV_M, false);
+
+        return;
+    }
 
     if (!async) {
         /* set tval to badaddr for traps with address information */
@@ -1960,8 +2016,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                   __func__, env->mhartid, async, cause, env->pc, tval,
                   riscv_cpu_get_trap_name(cause, async));
 
-    if (env->priv <= PRV_S && cause < 64 &&
-        (((deleg >> cause) & 1) || s_injected || vs_injected)) {
+    mode = env->priv <= PRV_S && cause < 64 &&
+        (((deleg >> cause) & 1) || s_injected || vs_injected) ? PRV_S : PRV_M;
+
+    if (mode == PRV_S) {
         /* handle the trap in S-mode */
         /* save elp status */
         if (cpu_get_fcfien(env)) {
@@ -2016,6 +2074,14 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                   ((async && (env->stvec & 3) == 1) ? cause * 4 : 0);
         riscv_cpu_set_mode(env, PRV_S, virt);
     } else {
+        /*
+         * If the hart encounters an exception while executing in M-mode
+         * with the mnstatus.NMIE bit clear, the exception is an RNMI exception.
+         */
+        nnmi_excep = cpu->cfg.ext_smrnmi &&
+                     !get_field(env->mnstatus, MNSTATUS_NMIE) &&
+                     !async;
+
         /* handle the trap in M-mode */
         /* save elp status */
         if (cpu_get_fcfien(env)) {
@@ -2043,14 +2109,22 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         s = set_field(s, MSTATUS_MPP, env->priv);
         s = set_field(s, MSTATUS_MIE, 0);
         env->mstatus = s;
-        mxlen = 16 << riscv_cpu_mxl(env);
         env->mcause = cause | ((target_ulong)async << (mxlen - 1));
         env->mepc = env->pc;
         env->mtval = tval;
         env->mtval2 = mtval2;
         env->mtinst = tinst;
-        env->pc = (env->mtvec >> 2 << 2) +
-                  ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
+
+        /*
+         * For RNMI exception, program counter is set to the RNMI exception
+         * trap handler address.
+         */
+        if (nnmi_excep) {
+            env->pc = env->rnmi_excpvec;
+        } else {
+            env->pc = (env->mtvec >> 2 << 2) +
+                      ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
+        }
         riscv_cpu_set_mode(env, PRV_M, virt);
     }
 
-- 
2.34.1


