Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32550C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 05:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfMC-0006rG-NK; Fri, 17 Jan 2025 00:57:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfMA-0006gN-7x
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:22 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfM5-00061P-S3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:57:21 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21634338cfdso42895615ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093436; x=1737698236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8VJ7D3zub02eoHPK3DPtlRofa9oAREoPFuS3/6V3jc=;
 b=U1b0HZ3GGgS7sPyjOLMLk4qzzNYe9HrShwM5vWRECdbVbPwGQ72GbdR0GfTkSiPvX+
 6dlt9/UHKwpdKzFefkNt9sQpiG2tym9RMriRWIYbT2gy5Ipa0fjPntfL2kRdQ71lu34a
 TSdOvireMiRPJEEv5RCNSr81RDn1cWRaeZG87e3Zi678VKDWxMEsuoNFMbdGJh7mAftc
 gkTyiW/rZus1Rh1kwWmzsNIazRovyVXnXopVkjjS46m55jXFL1bKkcZVkrhWBH+Cw+u5
 RfnsDx8ffVp0Gltgp+aCSgRxvBzxSmqUrlmvV2fs8mOecJeMAZvEgLbxjbxrxIqQlU86
 hQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093436; x=1737698236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U8VJ7D3zub02eoHPK3DPtlRofa9oAREoPFuS3/6V3jc=;
 b=d7uATSKhu2YKwLUgP1GfBOzCv13ecBK3xS8WScJoqbvJ1HqRurfNkI1vzVUaie3sTL
 asiaArYbsbIHtSfKRRd6bFD5+Jsbe535PGdbePDDuHgde+sYXulDWWbbnOKVpe5h0tFn
 HkieDCXVMCcVWa86/KXxFSlPMm/saNQpAliQF3CzNOwtLdB4FqoxNAPEJ7ErPVzVHGVS
 +NO7GAWkj3V1+cTTteQ1p57RWyLV7LtK+I875MOcGkQBogGBRry1mKjvh9OqbWgkpatI
 pucifmoppIE2OkMTAfH0NcNKl42eGlJWGE0rD/8XRww6DvthZp9yQayIddUSCMgxVmzK
 951g==
X-Gm-Message-State: AOJu0YxpM8aZU1Iuqza3wM26/ln9Rq9GA2jLx2Q/+j8blR/bKcEvzoBj
 jLUEGgMSFg0BOrump52eE02Gup6T1fzufMDfy0mmPnE1fNun3HuLIjWEfw==
X-Gm-Gg: ASbGncsbP3FyE2Xs9tt/ppiKkRPdK9AZj9Qk1b6fdHXkdC/tK/mJVB6+ZXLXGFQ9QEo
 qHAwzz7HoSB5SUjWamGgEPRl3jwVX9Dws+M21OAlX/OSdwIxQXAJhmUbQXke9eDwJLhQCzk43Gy
 zq7yiMh3dDwpSXlo9WuCnvdGSammvpPMvweDGD48QddK632X8TUBmwXMFPbv2ZIfxndYTaCqYqN
 fIi6Hlzgll6W/HGLKCBPnhL/djQQgM+q4upcPVTPILjzHYKC6nHAsoGr7wjNNNLvlZpMtduuso3
 rBEL4tZcAod/NNIM/qnSxRb9mJ21PC/asdCORzD9oyuuqItKIVeOO54weOf6
X-Google-Smtp-Source: AGHT+IEOmik2qiNQdbMAYUPofMbecKREhi247xFW9fS+hrKObaZxOkFygMiB8iNG3zvMOeDPunaYFg==
X-Received: by 2002:a17:903:32cf:b0:216:5af7:5a8e with SMTP id
 d9443c01a7336-21c355ec9c0mr22119495ad.26.1737093436345; 
 Thu, 16 Jan 2025 21:57:16 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:57:15 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 22/50] target/riscv: Handle Smrnmi interrupt and exception
Date: Fri, 17 Jan 2025 15:55:24 +1000
Message-ID: <20250117055552.108376-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Tommy Wu <tommy.wu@sifive.com>

Because the RNMI interrupt trap handler address is implementation defined.
We add the 'rnmi-interrupt-vector' and 'rnmi-exception-vector' as the property
of the harts. It’s very easy for users to set the address based on their
expectation. This patch also adds the functionality to handle the RNMI signals.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250106054336.1878291-4-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/riscv_hart.h |  4 ++
 target/riscv/cpu.h            |  3 ++
 target/riscv/cpu_bits.h       | 12 +++++
 hw/riscv/riscv_hart.c         | 41 ++++++++++++++++
 target/riscv/cpu.c            | 11 +++++
 target/riscv/cpu_helper.c     | 88 ++++++++++++++++++++++++++++++++---
 6 files changed, 152 insertions(+), 7 deletions(-)

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
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5eaf9da1f7..08215efb09 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -487,6 +487,8 @@ struct CPUArchState {
     target_ulong mncause; /* mncause without bit XLEN-1 set to 1 */
     target_ulong mnstatus;
     target_ulong rnmip;
+    uint64_t rnmi_irqvec;
+    uint64_t rnmi_excpvec;
 };
 
 /*
@@ -585,6 +587,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
 uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
                               uint64_t value);
+void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
 void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
 void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index ba6fc546c4..32525f00d6 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -650,6 +650,12 @@ typedef enum {
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
@@ -704,6 +710,9 @@ typedef enum RISCVException {
 /* -1 is due to bit zero of hgeip and hgeie being ROZ. */
 #define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS - 1)
 
+/* RNMI causes */
+#define RNMI_MAX                           16
+
 /* mip masks */
 #define MIP_USIP                           (1 << IRQ_U_SOFT)
 #define MIP_SSIP                           (1 << IRQ_S_SOFT)
@@ -889,6 +898,9 @@ typedef enum RISCVException {
 #define MHPMEVENT_IDX_MASK                 0xFFFFF
 #define MHPMEVENT_SSCOF_RESVD              16
 
+/* RISC-V-specific interrupt pending bits. */
+#define CPU_INTERRUPT_RNMI                 CPU_INTERRUPT_TGT_EXT_0
+
 /* JVT CSR bits */
 #define JVT_MODE                           0x3F
 #define JVT_BASE                           (~0x3F)
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
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 66193cd2f6..eb06d06628 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1412,6 +1412,11 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
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
@@ -1435,6 +1440,8 @@ static void riscv_cpu_init(Object *obj)
 #ifndef CONFIG_USER_ONLY
     qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
                       IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
+    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
+                            "riscv.cpu.rnmi", RNMI_MAX);
 #endif /* CONFIG_USER_ONLY */
 
     general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);
@@ -2793,6 +2800,10 @@ static const Property riscv_cpu_properties[] = {
 
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
+    DEFINE_PROP_UINT64("rnmi-interrupt-vector", RISCVCPU, env.rnmi_irqvec,
+                       DEFAULT_RNMI_IRQVEC),
+    DEFINE_PROP_UINT64("rnmi-exception-vector", RISCVCPU, env.rnmi_excpvec,
+                       DEFAULT_RNMI_EXCPVEC),
 #endif
 
     DEFINE_PROP_BOOL("short-isa-string", RISCVCPU, cfg.short_isa_string, false),
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2e307e4ea5..4c70db6def 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -554,6 +554,18 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
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
@@ -616,7 +628,9 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
 
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    if (interrupt_request & CPU_INTERRUPT_HARD) {
+    uint32_t mask = CPU_INTERRUPT_HARD | CPU_INTERRUPT_RNMI;
+
+    if (interrupt_request & mask) {
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
         int interruptno = riscv_cpu_local_irq_pending(env);
@@ -748,6 +762,30 @@ void riscv_cpu_set_geilen(CPURISCVState *env, target_ulong geilen)
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
@@ -1897,6 +1935,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     bool write_gva = false;
     bool always_storeamo = (env->excp_uw2 & RISCV_UW2_ALWAYS_STORE_AMO);
     uint64_t s;
+    int mode;
 
     /*
      * cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
@@ -1914,7 +1953,24 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
@@ -2008,8 +2064,10 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
@@ -2064,6 +2122,14 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
@@ -2091,14 +2157,22 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
2.47.1


