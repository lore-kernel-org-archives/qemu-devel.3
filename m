Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF4AC88E63
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 19:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5qD1-0005MM-Aq; Sun, 13 Sep 2026 15:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1x5oqL-00014j-8H; Sun, 13 Sep 2026 14:22:22 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1x5oqE-0003bc-1w; Sun, 13 Sep 2026 14:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=wc5lQlvp8CNVHVe7111Dz46QS8I5PO6Y8V1dN6cMXUs=; b=p34VGaQdx0bFJPXNyVwodNsepJ
 CRLgA3aze7g6c0bgbuVVCkTmZIpsXAxvEAFfRJurFzz0vUv2ztYI5rZ5xympO1wADR8HYzN69ey2W
 ZoJn207o3xX0+FPxGswR8YmwXP8IDJipaR4VVhccXH77+jFxS7+NG+ly/ijLeb5NskSyDEQa5eTTI
 SnNJCMC55OAtZwvM7ukaJeV/U7b9xeV9ukDnPEkDkMeSpUrcvSDwZAwKoUit4T2a4HTegD+g3DRxE
 ieXHxpowDlcCVQT52nhufdICtEC3ZpVcEThvMUhzyI+YaEUIm6n2L1mY1xXbQThhi/00xsmsA/0Xi
 kjsNoYXw==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1x5oq5-000LWi-1x; Sun, 13 Sep 2026 20:22:05 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1x5oq5-000PM1-0n; Sun, 13 Sep 2026 20:22:05 +0200
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Date: Sun, 13 Sep 2026 20:21:05 +0200
Subject: [PATCH 1/2] target/rx: add RXv2 and RXv3 CPU support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-umar-rx-series-v1-1-5a5841a5d1e9@sayyadumar.com>
References: <20260913-umar-rx-series-v1-0-5a5841a5d1e9@sayyadumar.com>
In-Reply-To: <20260913-umar-rx-series-v1-0-5a5841a5d1e9@sayyadumar.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789323724; l=120104;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=w9y5rQ8CBRgGIz+2n80n3UwCJuUyZ+cD9JKA/YKB6OE=;
 b=1UoCwOZqTFt9ekKGIPKNL8/dOx+m6suJEJ4DF06OkDvL0OMdaRzKRrHxLw4ugoI5WL759xiUn
 E3syv2qA+FNAC92FmDfzoyYVOQNAffPC7Qerv6RkbCsstZ2rbCkEtSN
X-Developer-Key: i=contact@sayyadumar.com; a=ed25519;
 pk=CsAjTLRCB7+pnzmj8902JER4gL8CTzNQFxlMZTl4wDk=
X-Virus-Scanned: Clear (ClamAV 1.4.3/28122/Sun Sep 13 08:26:25 2026)
Received-SPF: pass client-ip=85.10.213.182;
 envelope-from=contact@sayyadumar.com; helo=www675.your-server.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 13 Sep 2026 15:49:41 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add RX65N (RXv2) and RX72M (RXv3) CPU model definitions and select
the appropriate ISA revision for each model. Initialize the
architectural state and translator support required by the newer
cores.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
 target/rx/cpu-param.h  |    3 +
 target/rx/cpu-qom.h    |    2 +
 target/rx/cpu.c        |   57 ++-
 target/rx/cpu.h        |  124 +++++
 target/rx/disas.c      |  383 ++++++++++++++-
 target/rx/gdbstub.c    |   44 +-
 target/rx/helper.c     |   56 +--
 target/rx/helper.h     |   22 +
 target/rx/insns.decode |  125 ++++-
 target/rx/meson.build  |    6 +-
 target/rx/op_helper.c  |  357 ++++++++++++++
 target/rx/translate.c  | 1225 ++++++++++++++++++++++++++++++++++++++----------
 12 files changed, 2093 insertions(+), 311 deletions(-)

diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index 3806f41b2f..84934f3bca 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -21,6 +21,9 @@
 
 #define TARGET_PAGE_BITS 12
 
+#define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#define TARGET_INSN_START_EXTRA_WORDS 0
+
 #endif
diff --git a/target/rx/cpu-qom.h b/target/rx/cpu-qom.h
index ac2e5785ef..a0b5f35015 100644
--- a/target/rx/cpu-qom.h
+++ b/target/rx/cpu-qom.h
@@ -24,6 +24,8 @@
 #define TYPE_RX_CPU "rx-cpu"
 
 #define TYPE_RX62N_CPU RX_CPU_TYPE_NAME("rx62n")
+#define TYPE_RX65N_CPU RX_CPU_TYPE_NAME("rx65n")
+#define TYPE_RX72M_CPU RX_CPU_TYPE_NAME("rx72m")
 
 OBJECT_DECLARE_CPU_TYPE(RXCPU, RXCPUClass, RX_CPU)
 
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 9b8473d71c..b7b6e69c72 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -99,11 +99,14 @@ static void rx_cpu_reset_hold(Object *obj, ResetType type)
     resetvec = rom_ptr(0xfffffffc, 4);
     if (resetvec) {
         /* In the case of kernel, it is ignored because it is not set. */
-        env->pc = ldl_le_p(resetvec);
+        env->pc = ldl_p(resetvec);
     }
     rx_cpu_unpack_psw(env, 0, 1);
     env->regs[0] = env->isp = env->usp = 0;
+    env->extb = 0xffffff80;
     env->fpsw = 0;
+    /* DECNT comes out of reset with EHM set; the rest of DPSW is zero. */
+    env->dcr[RX_DCR_DECNT] = RX_DECNT_RESET;
     set_flush_to_zero(1, &env->fp_status);
     set_flush_inputs_to_zero(1, &env->fp_status);
     /*
@@ -123,6 +126,17 @@ static void rx_cpu_reset_hold(Object *obj, ResetType type)
      * be the correct setting.
      */
     set_float_ftz_detection(float_ftz_before_rounding, &env->fp_status);
+
+    /*
+     * The DPFPU keeps its own softfloat state: DPSW carries a separate
+     * rounding mode (DRM) and denormal setting (DDN) from the FPSW. The
+     * NaN and denormal conventions match the single-precision unit.
+     */
+    set_flush_to_zero(1, &env->dp_status);
+    set_flush_inputs_to_zero(1, &env->dp_status);
+    set_float_2nan_prop_rule(float_2nan_prop_x87, &env->dp_status);
+    set_float_default_nan_pattern(0b01000000, &env->dp_status);
+    set_float_ftz_detection(float_ftz_before_rounding, &env->dp_status);
 }
 
 static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
@@ -256,6 +270,32 @@ static void rx_cpu_class_init(ObjectClass *klass, const void *data)
 
     cc->gdb_core_xml_file = "rx-core.xml";
     cc->tcg_ops = &rx_tcg_ops;
+
+    /*
+     * Base of the hierarchy: the abstract type is never instantiated, so
+     * this only provides a conservative default for models that forget to
+     * declare their revision.
+     */
+    rcc->isa_version = RX_ISA_V1;
+}
+
+static void rx62n_cpu_class_init(ObjectClass *klass, const void *data)
+{
+    RX_CPU_CLASS(klass)->isa_version = RX_ISA_V1;
+}
+
+static void rx65n_cpu_class_init(ObjectClass *klass, const void *data)
+{
+    RX_CPU_CLASS(klass)->isa_version = RX_ISA_V2;
+}
+
+static void rx72m_cpu_class_init(ObjectClass *klass, const void *data)
+{
+    RXCPUClass *rcc = RX_CPU_CLASS(klass);
+
+    rcc->isa_version = RX_ISA_V3;
+    /* RX72M provides 16 save register banks, selected by bank numbers 0-15. */
+    rcc->num_save_banks = 16;
 }
 
 static const TypeInfo rx_cpu_info = {
@@ -272,12 +312,27 @@ static const TypeInfo rx_cpu_info = {
 static const TypeInfo rx62n_rx_cpu_info = {
     .name = TYPE_RX62N_CPU,
     .parent = TYPE_RX_CPU,
+    .class_init = rx62n_cpu_class_init,
+};
+
+static const TypeInfo rx65n_rx_cpu_info = {
+    .name = TYPE_RX65N_CPU,
+    .parent = TYPE_RX_CPU,
+    .class_init = rx65n_cpu_class_init,
+};
+
+static const TypeInfo rx72m_rx_cpu_info = {
+    .name = TYPE_RX72M_CPU,
+    .parent = TYPE_RX_CPU,
+    .class_init = rx72m_cpu_class_init,
 };
 
 static void rx_cpu_register_types(void)
 {
     type_register_static(&rx_cpu_info);
     type_register_static(&rx62n_rx_cpu_info);
+    type_register_static(&rx65n_rx_cpu_info);
+    type_register_static(&rx72m_rx_cpu_info);
 }
 
 type_init(rx_cpu_register_types)
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 64ba48a732..cbffcf9c0a 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -24,6 +24,7 @@
 #include "cpu-qom.h"
 
 #include "exec/cpu-common.h"
+#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 
@@ -67,10 +68,112 @@ FIELD(FPSW, FX, 30, 1)
 FIELD(FPSW, FLAGS, 26, 4)
 FIELD(FPSW, FS, 31, 1)
 
+/* DPSW define. The DPFPU status word mirrors the FPSW layout exactly. */
+REG32(DPSW, 0)
+FIELD(DPSW, DRM, 0, 2)
+FIELD(DPSW, DCV, 2, 1)
+FIELD(DPSW, DCO, 3, 1)
+FIELD(DPSW, DCZ, 4, 1)
+FIELD(DPSW, DCU, 5, 1)
+FIELD(DPSW, DCX, 6, 1)
+FIELD(DPSW, DCE, 7, 1)
+FIELD(DPSW, CAUSE, 2, 6)
+FIELD(DPSW, DDN, 8, 1)
+FIELD(DPSW, DEV, 10, 1)
+FIELD(DPSW, DEO, 11, 1)
+FIELD(DPSW, DEZ, 12, 1)
+FIELD(DPSW, DEU, 13, 1)
+FIELD(DPSW, DEX, 14, 1)
+FIELD(DPSW, ENABLE, 10, 5)
+FIELD(DPSW, DFV, 26, 1)
+FIELD(DPSW, DFO, 27, 1)
+FIELD(DPSW, DFZ, 28, 1)
+FIELD(DPSW, DFU, 29, 1)
+FIELD(DPSW, DFX, 30, 1)
+/* DFS is the OR of DFV, DFO, DFZ and DFU only; DFX is not included. */
+FIELD(DPSW, FLAGS, 26, 4)
+FIELD(DPSW, DFS, 31, 1)
+
+/*
+ * Writable bits of DPSW: DRM, the DC* causes, DDN, the DE* enables and the
+ * DF* flags. The reserved bits and the read-only DFS summary are masked out.
+ */
+#define RX_DPSW_WRITE_MASK 0x7c007dff
+/* The DC* cause bits, which MVTDC can only clear, never set. */
+#define RX_DPSW_CAUSE_MASK 0x000000fc
+
+/* DECNT define: DP exception information preservation. */
+REG32(DECNT, 0)
+FIELD(DECNT, EHM, 0, 1)
+FIELD(DECNT, EHS, 16, 1)
+#define RX_DECNT_RESET 0x00000001   /* EHM = 1 out of reset */
+
+/* DCMR holds only the RES bit; everything else reads as 0. */
+#define RX_DCMR_WRITE_MASK 0x00000001
+
 enum {
     NUM_REGS = 16,
+    /* RXv3 DPFPU: DR0-DR15 are dedicated 64-bit registers, not GPR pairs. */
+    NUM_DREGS = 16,
+    /* RXv3 DPFPU control registers: DPSW, DCMR, DECNT, DEPC. */
+    NUM_DCREGS = 4,
+    /*
+     * RXv3 register bank save function. The banks are internal CPU state
+     * reachable only through the SAVE and RSTR instructions, so no memory
+     * layout is involved. How many banks exist is implementation defined,
+     * so the per-model count lives in RXCPUClass::num_save_banks and this
+     * is only the storage ceiling. RX72M/RX72N/RX72T provide 16, selected
+     * by bank numbers 0-15.
+     */
+    RX_MAX_SAVE_BANKS = 16,
+};
+
+/* RXv3 DPFPU control register numbers (MVFDC/MVTDC/DPUSHM.L/DPOPM.L). */
+enum {
+    RX_DCR_DPSW  = 0,
+    RX_DCR_DCMR  = 1,
+    RX_DCR_DECNT = 2,
+    RX_DCR_DEPC  = 3,
 };
 
+/*
+ * DCMR.RES, bit 0, holds the result of the last DCMP; MVFDR copies it into
+ * the PSW Z flag.
+ */
+#define RX_DCMR_RES_BIT 0
+
+/*
+ * DCMP condition field. The four documented mnemonics (un, eq, lt, le) are
+ * a three bit mask of the relations that make DCMR.RES true, which is why
+ * le == lt | eq == 6.
+ */
+#define RX_DCMP_UN  1
+#define RX_DCMP_EQ  2
+#define RX_DCMP_LT  4
+
+/*
+ * Instruction set architecture revision implemented by a CPU model.
+ * Later revisions are supersets of earlier ones, so instruction gating is a
+ * simple >= comparison.
+ */
+typedef enum RXISAVersion {
+    RX_ISA_V1 = 1,
+    RX_ISA_V2 = 2,
+    RX_ISA_V3 = 3,
+} RXISAVersion;
+
+/*
+ * One save register bank, written by SAVE and read back by RSTR. A bank
+ * holds R1-R15 (R0/SP is excluded), the USP, the FPSW and the accumulators.
+ * QEMU models a single accumulator, so only ACC0 is covered here.
+ */
+typedef struct RXSaveBank {
+    uint32_t regs[NUM_REGS];    /* [0] unused: R0 is not banked */
+    uint32_t usp;
+    uint32_t fpsw;
+    uint64_t acc;
+} RXSaveBank;
+
 typedef struct CPUArchState {
     /* CPU registers */
     uint32_t regs[NUM_REGS];    /* general registers */
@@ -88,9 +191,19 @@ typedef struct CPUArchState {
     uint32_t usp;               /* vector base register */
     uint32_t pc;                /* program counter */
     uint32_t intb;              /* interrupt vector */
+    uint32_t extb;              /* exception vector table base */
     uint32_t fintv;
     uint32_t fpsw;
     uint64_t acc;
+    uint64_t acc1;
+    uint32_t acc_guard[2]; /* Sign-extended 8-bit RXv2 guard fields. */
+
+    /* RXv3 double-precision FPU (DPFPU) */
+    uint64_t dr[NUM_DREGS];     /* DR0-DR15 */
+    uint32_t dcr[NUM_DCREGS];   /* DPSW, DCMR, DECNT, DEPC */
+
+    /* RXv3 register bank save function (SAVE/RSTR) */
+    RXSaveBank bank[RX_MAX_SAVE_BANKS];
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
@@ -102,6 +215,7 @@ typedef struct CPUArchState {
     uint32_t ack_irq;           /* execute irq */
     uint32_t ack_ipl;           /* execute ipl */
     float_status fp_status;
+    float_status dp_status;
     qemu_irq ack;               /* Interrupt acknowledge */
 } CPURXState;
 
@@ -129,6 +243,16 @@ struct RXCPUClass {
 
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
+
+    /* Instruction set revision this model implements. */
+    RXISAVersion isa_version;
+
+    /*
+     * Number of save register banks reachable by SAVE/RSTR, or 0 on models
+     * without the register bank save function. Must not exceed
+     * RX_MAX_SAVE_BANKS.
+     */
+    uint32_t num_save_banks;
 };
 
 #define CPU_RESOLVING_TYPE TYPE_RX_CPU
diff --git a/target/rx/disas.c b/target/rx/disas.c
index 0eb2ee6f45..0ac48b019e 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -19,7 +19,6 @@
 #include "qemu/osdep.h"
 #include "disas/dis-asm.h"
 #include "qemu/bitops.h"
-#include "monitor/hmp.h"
 #include "cpu.h"
 
 typedef struct DisasContext {
@@ -133,6 +132,10 @@ static const char cond[][4] = {
     "eq", "ne", "c", "nc", "gtu", "leu", "pz", "n",
     "ge", "lt", "gt", "le", "o", "no", "ra", "f"
 };
+static const char dcmp_cond[8][3] = {
+    "", "un", "eq", "", "lt", "", "le", ""
+};
+
 static const char psw[] = {
     'c', 'z', 's', 'o', 0, 0, 0, 0,
     'i', 'u', 0, 0, 0, 0, 0, 0,
@@ -174,7 +177,7 @@ static void prt_ldmi(DisasContext *ctx, const char *insn,
                      int ld, int mi, int rs, int rd)
 {
     static const char sizes[][4] = {".b", ".w", ".l", ".uw", ".ub"};
-    char dsp[8];
+    char dsp[12];
 
     if (ld < 3) {
         rx_index_addr(ctx, dsp, ld, mi);
@@ -375,7 +378,7 @@ static bool trans_PUSH_r(DisasContext *ctx, arg_PUSH_r *a)
 /* push dsp[rs] */
 static bool trans_PUSH_m(DisasContext *ctx, arg_PUSH_m *a)
 {
-    char dsp[8];
+    char dsp[12];
 
     rx_index_addr(ctx, dsp, a->ld, a->sz);
     prt("push\t%s[r%d]", dsp, a->rs);
@@ -554,7 +557,7 @@ static bool trans_ADC_rr(DisasContext *ctx, arg_ADC_rr *a)
 /* adc dsp[rs], rd */
 static bool trans_ADC_mr(DisasContext *ctx, arg_ADC_mr *a)
 {
-    char dsp[8];
+    char dsp[12];
 
     rx_index_addr(ctx, dsp, a->ld, 2);
     prt("adc\t%s[r%d], r%d", dsp, a->rs, a->rd);
@@ -1074,6 +1077,42 @@ static bool trans_MVTACLO(DisasContext *ctx, arg_MVTACLO *a)
     return true;
 }
 
+static bool trans_MVTACHI_A1(DisasContext *ctx, arg_MVTACHI_A1 *a)
+{
+    prt("mvtachi\tr%d, a%d", a->r, 1);
+    return true;
+}
+
+static bool trans_MVTACLO_A1(DisasContext *ctx, arg_MVTACLO_A1 *a)
+{
+    prt("mvtaclo\tr%d, a%d", a->r, 1);
+    return true;
+}
+
+static bool trans_MVTACGU(DisasContext *ctx, arg_MVTACGU *a)
+{
+    prt("mvtacgu\tr%d, a%d", a->r, a->a);
+    return true;
+}
+
+static bool trans_MVFACHI_A1(DisasContext *ctx, arg_MVFACHI_A1 *a)
+{
+    prt("mvfachi\t#0, a%d, r%d", 1, a->r);
+    return true;
+}
+
+static bool trans_MVFACLO(DisasContext *ctx, arg_MVFACLO *a)
+{
+    prt("mvfaclo\t#0, a%d, r%d", a->a, a->r);
+    return true;
+}
+
+static bool trans_MVFACGU(DisasContext *ctx, arg_MVFACGU *a)
+{
+    prt("mvfacgu\t#0, a%d, r%d", a->a, a->r);
+    return true;
+}
+
 /* racw #imm */
 static bool trans_RACW(DisasContext *ctx, arg_RACW *a)
 {
@@ -1148,6 +1187,14 @@ static bool trans_FTOI(DisasContext *ctx, arg_FTOI *a)
     return true;
 }
 
+/* ftou dsp[rs], rd */
+/* ftou rs, rd */
+static bool trans_FTOU(DisasContext *ctx, arg_FTOU *a)
+{
+    prt_ldmi(ctx, "ftou", a->ld, RX_IM_LONG, a->rs, a->rd);
+    return true;
+}
+
 /* fmul #imm, rd */
 static bool trans_FMUL_ir(DisasContext *ctx, arg_FMUL_ir *a)
 {
@@ -1194,9 +1241,329 @@ static bool trans_ITOF(DisasContext *ctx, arg_ITOF *a)
     return true;
 }
 
+/* utof dsp[rs], rd */
+static bool trans_UTOF(DisasContext *ctx, arg_UTOF *a)
+{
+    prt_ldmi(ctx, "utof", a->ld, a->mi, a->rs, a->rd);
+    return true;
+}
+
+/* RXv2 DPFPU disassembly */
+static bool trans_DADD(DisasContext *ctx, arg_DADD *a)
+{
+    prt("dadd\tdr%d, dr%d, dr%d", a->drs1, a->drs2, a->drd);
+    return true;
+}
+
+static bool trans_DSUB(DisasContext *ctx, arg_DSUB *a)
+{
+    prt("dsub\tdr%d, dr%d, dr%d", a->drs1, a->drs2, a->drd);
+    return true;
+}
+
+static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
+{
+    prt("dmul\tdr%d, dr%d, dr%d", a->drs1, a->drs2, a->drd);
+    return true;
+}
+
+static bool trans_DDIV(DisasContext *ctx, arg_DDIV *a)
+{
+    prt("ddiv\tdr%d, dr%d, dr%d", a->drs1, a->drs2, a->drd);
+    return true;
+}
+
+static bool trans_DCMP(DisasContext *ctx, arg_DCMP *a)
+{
+    prt("dcmp%s\tdr%d, dr%d", dcmp_cond[a->cd & 7], a->drs1, a->drs2);
+    return true;
+}
+
+static bool trans_DMOV(DisasContext *ctx, arg_DMOV *a)
+{
+    prt("dmov\tdr%d, dr%d", a->drs, a->drd);
+    return true;
+}
+
+static bool trans_DABS(DisasContext *ctx, arg_DABS *a)
+{
+    prt("dabs\tdr%d, dr%d", a->drs, a->drd);
+    return true;
+}
+
+static bool trans_DNEG(DisasContext *ctx, arg_DNEG *a)
+{
+    prt("dneg\tdr%d, dr%d", a->drs, a->drd);
+    return true;
+}
+
+static bool trans_DSQRT(DisasContext *ctx, arg_DSQRT *a)
+{
+    prt("dsqrt\tdr%d, dr%d", a->drs, a->drd);
+    return true;
+}
+
+static bool trans_DROUND(DisasContext *ctx, arg_DROUND *a)
+{
+    prt("dround\tdr%d, dr%d", a->drs, a->drd);
+    return true;
+}
+
+static bool trans_DTOI(DisasContext *ctx, arg_DTOI *a)
+{
+    prt("dtoi\tdr%d, dr%d", a->drs, a->drd);
+    return true;
+}
+
+static bool trans_DTOU(DisasContext *ctx, arg_DTOU *a)
+{
+    prt("dtou\tdr%d, dr%d", a->drs, a->drd);
+    return true;
+}
+
+static bool trans_DTOF(DisasContext *ctx, arg_DTOF *a)
+{
+    prt("dtof\tdr%d, dr%d", a->drs, a->drd);
+    return true;
+}
+
+static bool trans_ITOD(DisasContext *ctx, arg_ITOD *a)
+{
+    prt("itod\tr%d, dr%d", a->rs, a->drd);
+    return true;
+}
+
+static bool trans_UTOD(DisasContext *ctx, arg_UTOD *a)
+{
+    prt("utod\tr%d, dr%d", a->rs, a->drd);
+    return true;
+}
+
+static bool trans_FTOD(DisasContext *ctx, arg_FTOD *a)
+{
+    prt("ftod\tr%d, dr%d", a->rs, a->drd);
+    return true;
+}
+
+static bool trans_DPUSHM(DisasContext *ctx, arg_DPUSHM *a)
+{
+    prt("dpushm.d\tdr%d-dr%d", a->drd, a->drd + a->rnum);
+    return true;
+}
+
+static bool trans_DPOPM(DisasContext *ctx, arg_DPOPM *a)
+{
+    prt("dpopm.d\tdr%d-dr%d", a->drd, a->drd + a->rnum);
+    return true;
+}
+
+/* RXv3 disassembly: remaining DPFPU, bit field and register bank ops */
+static const char dcrname[][6] = { "dpsw", "dcmr", "decnt", "depc" };
+
+static bool trans_DPUSHM_l(DisasContext *ctx, arg_DPUSHM_l *a)
+{
+    prt("dpushm.l\t%s-%s", dcrname[a->dcrd & 3],
+        dcrname[(a->dcrd + a->rnum) & 3]);
+    return true;
+}
+
+static bool trans_DPOPM_l(DisasContext *ctx, arg_DPOPM_l *a)
+{
+    prt("dpopm.l\t%s-%s", dcrname[a->dcrd & 3],
+        dcrname[(a->dcrd + a->rnum) & 3]);
+    return true;
+}
+
+static bool trans_DMOV_rdrl(DisasContext *ctx, arg_DMOV_rdrl *a)
+{
+    prt("dmov.l\tr%d, drl%d", a->rs, a->drd);
+    return true;
+}
+
+static bool trans_DMOV_rdrh(DisasContext *ctx, arg_DMOV_rdrh *a)
+{
+    prt("dmov.l\tr%d, drh%d", a->rs, a->drd);
+    return true;
+}
+
+static bool trans_DMOVD_rdrh(DisasContext *ctx, arg_DMOVD_rdrh *a)
+{
+    prt("dmov.d\tr%d, drh%d", a->rs, a->drd);
+    return true;
+}
+
+static bool trans_DMOV_drlr(DisasContext *ctx, arg_DMOV_drlr *a)
+{
+    prt("dmov.l\tdrl%d, r%d", a->drs, a->rd);
+    return true;
+}
+
+static bool trans_DMOV_drhr(DisasContext *ctx, arg_DMOV_drhr *a)
+{
+    prt("dmov.l\tdrh%d, r%d", a->drs, a->rd);
+    return true;
+}
+
+static bool trans_DMOVL_irl(DisasContext *ctx, arg_DMOVL_irl *a)
+{
+    uint32_t imm = li(ctx, 0);
+
+    prt("dmov.l\t#0x%08x, drl%d", imm, a->drd);
+    return true;
+}
+
+static bool trans_DMOVL_irh(DisasContext *ctx, arg_DMOVL_irh *a)
+{
+    uint32_t imm = li(ctx, 0);
+
+    prt("dmov.l\t#0x%08x, drh%d", imm, a->drd);
+    return true;
+}
+
+static bool trans_DMOVD_irh(DisasContext *ctx, arg_DMOVD_irh *a)
+{
+    uint32_t imm = li(ctx, 0);
+
+    prt("dmov.d\t#0x%08x, drh%d", imm, a->drd);
+    return true;
+}
+
+/* Fetch n more instruction bytes into the dump buffer and return them. */
+static uint32_t disas_fetch(DisasContext *ctx, int n)
+{
+    uint32_t addr = ctx->addr;
+    uintptr_t len = ctx->len;
+    uint32_t val = 0;
+    int i;
+
+    g_assert(len + n <= ARRAY_SIZE(ctx->bytes));
+    ctx->addr += n;
+    ctx->len += n;
+    ctx->dis->read_memory_func(addr, ctx->bytes + len, n, ctx->dis);
+    for (i = n - 1; i >= 0; i--) {
+        val = (val << 8) | ctx->bytes[len + i];
+    }
+    return val;
+}
+
+/*
+ * DMOV.D displacements are scaled by 4 (see the note in translate.c), which
+ * rx_index_addr() cannot express, so decode them here.
+ */
+static void dmov_index_addr(DisasContext *ctx, char out[12], int ld)
+{
+    if (ld == 0) {
+        out[0] = '\0';
+        return;
+    }
+    snprintf(out, 12, "%u", disas_fetch(ctx, ld) << 2);
+}
+
+/* The DR operand of the DMOV.D memory forms sits in a trailing post-byte. */
+static int dmov_postbyte(DisasContext *ctx)
+{
+    return disas_fetch(ctx, 1) >> 4;
+}
+
+static bool trans_DMOV_mst(DisasContext *ctx, arg_DMOV_mst *a)
+{
+    char dsp[12];
+    int dr;
+
+    dmov_index_addr(ctx, dsp, a->ld);
+    dr = dmov_postbyte(ctx);
+    prt("dmov.d\tdr%d, %s[r%d]", dr, dsp, a->rd);
+    return true;
+}
+
+static bool trans_DMOV_mld(DisasContext *ctx, arg_DMOV_mld *a)
+{
+    char dsp[12];
+    int dr;
+
+    dmov_index_addr(ctx, dsp, a->ld);
+    dr = dmov_postbyte(ctx);
+    prt("dmov.d\t%s[r%d], dr%d", dsp, a->rs, dr);
+    return true;
+}
+
+static bool trans_MVFDC(DisasContext *ctx, arg_MVFDC *a)
+{
+    prt("mvfdc\t%s, r%d", dcrname[a->dcrs & 3], a->rd);
+    return true;
+}
+
+static bool trans_MVTDC(DisasContext *ctx, arg_MVTDC *a)
+{
+    prt("mvtdc\tr%d, %s", a->rs, dcrname[a->dcrd & 3]);
+    return true;
+}
+
+static bool trans_MVFDR(DisasContext *ctx, arg_MVFDR *a)
+{
+    prt("mvfdr");
+    return true;
+}
+
+static void prt_bfmov(DisasContext *ctx, const char *name, int rs, int rd)
+{
+    unsigned bf = disas_fetch(ctx, 2);
+    unsigned dlsb = (bf >> 5) & 0x1f;
+    unsigned msb = (bf >> 10) & 0x1f;
+    int delta = bf & 0x1f;
+
+    if (delta >= 0x10) {
+        delta -= 0x20;
+    }
+    prt("%s\t#%d, #%d, #%d, r%d, r%d", name,
+        (int)dlsb - delta, dlsb, (int)msb - (int)dlsb, rs, rd);
+}
+
+static bool trans_BFMOV(DisasContext *ctx, arg_BFMOV *a)
+{
+    prt_bfmov(ctx, "bfmov", a->rs, a->rd);
+    return true;
+}
+
+static bool trans_BFMOVZ(DisasContext *ctx, arg_BFMOVZ *a)
+{
+    prt_bfmov(ctx, "bfmovz", a->rs, a->rd);
+    return true;
+}
+
+static bool trans_SAVE_r(DisasContext *ctx, arg_SAVE_r *a)
+{
+    prt("save\tr%d", a->rs);
+    return true;
+}
+
+static bool trans_SAVE_i(DisasContext *ctx, arg_SAVE_i *a)
+{
+    prt("save\t#%d", a->imm);
+    return true;
+}
+
+static bool trans_RSTR_r(DisasContext *ctx, arg_RSTR_r *a)
+{
+    prt("rstr\tr%d", a->rs);
+    return true;
+}
+
+static bool trans_RSTR_i(DisasContext *ctx, arg_RSTR_i *a)
+{
+    prt("rstr\t#%d", a->imm);
+    return true;
+}
+
+static bool trans_XOR_rrr(DisasContext *ctx, arg_XOR_rrr *a)
+{
+    prt("xor\tr%d, r%d, r%d", a->rs, a->rs2, a->rd);
+    return true;
+}
+
 #define BOP_IM(name, reg)                                       \
     do {                                                        \
-        char dsp[8];                                            \
+        char dsp[12];                                            \
         rx_index_addr(ctx, dsp, a->ld, RX_MEMORY_BYTE);         \
         prt("b%s\t#%d, %s[r%d]", #name, a->imm, dsp, reg);      \
         return true;                                            \
@@ -1204,7 +1571,7 @@ static bool trans_ITOF(DisasContext *ctx, arg_ITOF *a)
 
 #define BOP_RM(name)                                            \
     do {                                                        \
-        char dsp[8];                                            \
+        char dsp[12];                                            \
         rx_index_addr(ctx, dsp, a->ld, RX_MEMORY_BYTE);         \
         prt("b%s\tr%d, %s[r%d]", #name, a->rd, dsp, a->rs);     \
         return true;                                            \
@@ -1317,7 +1684,7 @@ static bool trans_BNOT_ir(DisasContext *ctx, arg_BNOT_ir *a)
 /* bmcond #imm, dsp[rd] */
 static bool trans_BMCnd_im(DisasContext *ctx, arg_BMCnd_im *a)
 {
-    char dsp[8];
+    char dsp[12];
 
     rx_index_addr(ctx, dsp, a->ld, RX_MEMORY_BYTE);
     prt("bm%s\t#%d, %s[r%d]", cond[a->cd], a->imm, dsp, a->rd);
@@ -1413,7 +1780,7 @@ static bool trans_WAIT(DisasContext *ctx, arg_WAIT *a)
 static bool trans_SCCnd(DisasContext *ctx, arg_SCCnd *a)
 {
     if (a->ld < 3) {
-        char dsp[8];
+        char dsp[12];
         rx_index_addr(ctx, dsp, a->sz, a->ld);
         prt("sc%s.%c\t%s[r%d]", cond[a->cd], size[a->sz], dsp, a->rd);
     } else {
diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c
index 8be5141f5b..f222bf003b 100644
--- a/target/rx/gdbstub.c
+++ b/target/rx/gdbstub.c
@@ -25,25 +25,25 @@ int rx_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
     switch (n) {
     case 0 ... 15:
-        return gdb_get_reg32(mem_buf, env->regs[n]);
+        return gdb_get_regl(mem_buf, env->regs[n]);
     case 16:
-        return gdb_get_reg32(mem_buf, (env->psw_u) ? env->regs[0] : env->usp);
+        return gdb_get_regl(mem_buf, (env->psw_u) ? env->regs[0] : env->usp);
     case 17:
-        return gdb_get_reg32(mem_buf, (!env->psw_u) ? env->regs[0] : env->isp);
+        return gdb_get_regl(mem_buf, (!env->psw_u) ? env->regs[0] : env->isp);
     case 18:
-        return gdb_get_reg32(mem_buf, rx_cpu_pack_psw(env));
+        return gdb_get_regl(mem_buf, rx_cpu_pack_psw(env));
     case 19:
-        return gdb_get_reg32(mem_buf, env->pc);
+        return gdb_get_regl(mem_buf, env->pc);
     case 20:
-        return gdb_get_reg32(mem_buf, env->intb);
+        return gdb_get_regl(mem_buf, env->intb);
     case 21:
-        return gdb_get_reg32(mem_buf, env->bpsw);
+        return gdb_get_regl(mem_buf, env->bpsw);
     case 22:
-        return gdb_get_reg32(mem_buf, env->bpc);
+        return gdb_get_regl(mem_buf, env->bpc);
     case 23:
-        return gdb_get_reg32(mem_buf, env->fintv);
+        return gdb_get_regl(mem_buf, env->fintv);
     case 24:
-        return gdb_get_reg32(mem_buf, env->fpsw);
+        return gdb_get_regl(mem_buf, env->fpsw);
     case 25:
         return 0;
     }
@@ -56,7 +56,7 @@ int rx_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     uint32_t psw;
     switch (n) {
     case 0 ... 15:
-        env->regs[n] = ldl_le_p(mem_buf);
+        env->regs[n] = ldl_p(mem_buf);
         if (n == 0) {
             if (env->psw_u) {
                 env->usp = env->regs[0];
@@ -66,38 +66,38 @@ int rx_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         }
         break;
     case 16:
-        env->usp = ldl_le_p(mem_buf);
+        env->usp = ldl_p(mem_buf);
         if (env->psw_u) {
-            env->regs[0] = ldl_le_p(mem_buf);
+            env->regs[0] = ldl_p(mem_buf);
         }
         break;
     case 17:
-        env->isp = ldl_le_p(mem_buf);
+        env->isp = ldl_p(mem_buf);
         if (!env->psw_u) {
-            env->regs[0] = ldl_le_p(mem_buf);
+            env->regs[0] = ldl_p(mem_buf);
         }
         break;
     case 18:
-        psw = ldl_le_p(mem_buf);
+        psw = ldl_p(mem_buf);
         rx_cpu_unpack_psw(env, psw, 1);
         break;
     case 19:
-        env->pc = ldl_le_p(mem_buf);
+        env->pc = ldl_p(mem_buf);
         break;
     case 20:
-        env->intb = ldl_le_p(mem_buf);
+        env->intb = ldl_p(mem_buf);
         break;
     case 21:
-        env->bpsw = ldl_le_p(mem_buf);
+        env->bpsw = ldl_p(mem_buf);
         break;
     case 22:
-        env->bpc = ldl_le_p(mem_buf);
+        env->bpc = ldl_p(mem_buf);
         break;
     case 23:
-        env->fintv = ldl_le_p(mem_buf);
+        env->fintv = ldl_p(mem_buf);
         break;
     case 24:
-        env->fpsw = ldl_le_p(mem_buf);
+        env->fpsw = ldl_p(mem_buf);
         break;
     case 25:
         return 8;
diff --git a/target/rx/helper.c b/target/rx/helper.c
index 0f99279bba..2482b9fdd6 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -22,7 +22,6 @@
 #include "exec/log.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "hw/core/irq.h"
-#include "qemu/plugin.h"
 
 void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
 {
@@ -41,11 +40,13 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
     env->psw_c = FIELD_EX32(psw, PSW, C);
 }
 
+#define INT_FLAGS (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR)
 void rx_cpu_do_interrupt(CPUState *cs)
 {
     CPURXState *env = cpu_env(cs);
+    bool fir = cpu_test_interrupt(cs, CPU_INTERRUPT_FIR);
+    bool hard = cpu_test_interrupt(cs, CPU_INTERRUPT_HARD);
     uint32_t save_psw;
-    uint64_t last_pc = env->pc;
 
     env->in_sleep = 0;
 
@@ -57,26 +58,27 @@ void rx_cpu_do_interrupt(CPUState *cs)
     save_psw = rx_cpu_pack_psw(env);
     env->psw_pm = env->psw_i = env->psw_u = 0;
 
-    if (cpu_test_interrupt(cs, CPU_INTERRUPT_FIR)) {
-        env->bpc = env->pc;
-        env->bpsw = save_psw;
-        env->pc = env->fintv;
-        env->psw_ipl = 15;
-        cpu_reset_interrupt(cs, CPU_INTERRUPT_FIR);
-        qemu_set_irq(env->ack, env->ack_irq);
-        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
-        qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
-    } else if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
-        env->isp -= 4;
-        cpu_stl_le_data(env, env->isp, save_psw);
-        env->isp -= 4;
-        cpu_stl_le_data(env, env->isp, env->pc);
-        env->pc = cpu_ldl_le_data(env, env->intb + env->ack_irq * 4);
-        env->psw_ipl = env->ack_ipl;
-        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-        qemu_set_irq(env->ack, env->ack_irq);
-        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
-        qemu_log_mask(CPU_LOG_INT, "interrupt 0x%02x raised\n", env->ack_irq);
+    if (fir || hard) {
+        if (fir) {
+            env->bpc = env->pc;
+            env->bpsw = save_psw;
+            env->pc = env->fintv;
+            env->psw_ipl = 15;
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_FIR);
+            qemu_set_irq(env->ack, env->ack_irq);
+            qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
+        } else {
+            env->isp -= 4;
+            cpu_stl_le_data(env, env->isp, save_psw);
+            env->isp -= 4;
+            cpu_stl_le_data(env, env->isp, env->pc);
+            env->pc = cpu_ldl_le_data(env, env->intb + env->ack_irq * 4);
+            env->psw_ipl = env->ack_ipl;
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+            qemu_set_irq(env->ack, env->ack_irq);
+            qemu_log_mask(CPU_LOG_INT,
+                          "interrupt 0x%02x raised\n", env->ack_irq);
+        }
     } else {
         uint32_t vec = cs->exception_index;
         const char *expname = "unknown exception";
@@ -87,18 +89,10 @@ void rx_cpu_do_interrupt(CPUState *cs)
         cpu_stl_le_data(env, env->isp, env->pc);
 
         if (vec < 0x100) {
-            env->pc = cpu_ldl_le_data(env, 0xffffff80 + vec * 4);
+            env->pc = cpu_ldl_le_data(env, env->extb + vec * 4);
         } else {
             env->pc = cpu_ldl_le_data(env, env->intb + (vec & 0xff) * 4);
         }
-
-        if (vec == 30) {
-            /* Non-maskable interrupt */
-            qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
-        } else {
-            qemu_plugin_vcpu_exception_cb(cs, last_pc);
-        }
-
         switch (vec) {
         case 20:
             expname = "privilege violation";
diff --git a/target/rx/helper.h b/target/rx/helper.h
index 8cc38b0cb7..92bd9b9ed3 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -10,8 +10,30 @@ DEF_HELPER_3(fmul, f32, env, f32, f32)
 DEF_HELPER_3(fdiv, f32, env, f32, f32)
 DEF_HELPER_3(fcmp, void, env, f32, f32)
 DEF_HELPER_2(ftoi, i32, env, f32)
+DEF_HELPER_2(ftou, i32, env, f32)
 DEF_HELPER_2(round, i32, env, f32)
 DEF_HELPER_2(itof, f32, env, i32)
+DEF_HELPER_2(utof, f32, env, i32)
+/* RXv3 double-precision FPU (DPFPU) helpers */
+DEF_HELPER_3(dadd, f64, env, f64, f64)
+DEF_HELPER_3(dsub, f64, env, f64, f64)
+DEF_HELPER_3(dmul, f64, env, f64, f64)
+DEF_HELPER_3(ddiv, f64, env, f64, f64)
+DEF_HELPER_4(dcmp, void, env, i32, f64, f64)
+DEF_HELPER_2(dabs, f64, env, f64)
+DEF_HELPER_2(dneg, f64, env, f64)
+DEF_HELPER_2(dsqrt, f64, env, f64)
+DEF_HELPER_2(dround, f64, env, f64)
+DEF_HELPER_2(dtoi, i32, env, f64)
+DEF_HELPER_2(dtou, i32, env, f64)
+DEF_HELPER_2(dtof, f32, env, f64)
+DEF_HELPER_2(itod, f64, env, i32)
+DEF_HELPER_2(utod, f64, env, i32)
+DEF_HELPER_2(ftod, f64, env, f32)
+DEF_HELPER_3(mvtdc, void, env, i32, i32)
+/* RXv3 register bank save function */
+DEF_HELPER_2(save, void, env, i32)
+DEF_HELPER_2(rstr, void, env, i32)
 DEF_HELPER_2(set_fpsw, void, env, i32)
 DEF_HELPER_2(racw, void, env, i32)
 DEF_HELPER_2(set_psw_rte, void, env, i32)
diff --git a/target/rx/insns.decode b/target/rx/insns.decode
index ca9334b37a..2dd908d6b2 100644
--- a/target/rx/insns.decode
+++ b/target/rx/insns.decode
@@ -29,6 +29,26 @@
 &mi		rs ld mi imm
 &mr		rs ld mi rs2
 &mcnd		ld sz rd cd
+# RXv3 DPFPU argument types
+&drr		drd drs
+&drrr		drd drs1 drs2
+&dcmpd		drs1 drs2 cd
+&idr		rs drd
+&dppm		drd rnum
+# RXv3 DPFPU: GPR/control-register/memory/immediate transfers
+&rdrh		rd drs
+&drhr		drd rs
+&rdcr		rd dcrs
+&dcrr		dcrd rs
+&dcppm		dcrd rnum
+&dmovi		drd imm
+&dmovst		rd ld
+&dmovld		rs ld
+# RXv3 bit field move
+&bfm		rd rs
+# RXv3 register bank save/restore
+&svr		rs
+&svi		imm
 ########
 %b1_bdsp	24:3 !function=bdsp_s
 
@@ -285,6 +305,10 @@ FSUB_mr		1111 1100 1000 00.. .... ....		@b3_rd_ld_ul
 # FTOI dsp[rs], rd
 FTOI		1111 1100 1001 01.. .... ....		@b3_rd_ld_ul
 
+# FTOU rs, rd  (RXv2)
+# FTOU dsp[rs], rd  (RXv2)
+FTOU		1111 1100 1010 01.. .... ....		@b3_rd_ld_ul
+
 # INT #uimm8
 INT		0111 0101 0110 0000 imm:8
 
@@ -294,6 +318,11 @@ ITOF		1111 1100 0100 01.. .... ....		@b3_rd_ld_ub
 # ITOF dsp[rs], rd
 ITOF		0000 0110 ..10 00.. 0001 0001 .... ....	@b4_rd_ldmi
 
+# UTOF rs, rd  (RXv2)
+UTOF		1111 1100 0101 01.. .... ....		@b3_rd_ld_ub
+# UTOF dsp[rs], rd  (RXv2)
+UTOF		0000 0110 ..10 00.. 0001 0101 .... ....	@b4_rd_ldmi
+
 # JMP rs
 JMP		0111 1111 0000 rs:4			&jreg
 # JSR rs
@@ -347,7 +376,15 @@ MOV_ir		1111 1011 rd:4 .. 10			imm=%b2_li_2
 # MOV.<bwl> #imm, [rd]
 MOV_im		1111 1000 rd:4 .. sz:2			dsp=0 imm=%b2_li_2
 # MOV.<bwl> #imm, dsp8[rd]
-MOV_im		1111 1001 rd:4 .. sz:2 dsp:8		imm=%b3_li_10
+# The RXv3 DMOV immediate forms reuse this opcode with rd=0 and li/sz=0011,
+# an encoding MOV.<bwl> never produces (sz=3 is not a valid transfer size),
+# so they have to be matched ahead of it.
+{
+  DMOVL_irl	1111 1001 0000 0011 drd:4 0000		&dmovi imm=0
+  DMOVL_irh	1111 1001 0000 0011 drd:4 0010		&dmovi imm=0
+  DMOVD_irh	1111 1001 0000 0011 drd:4 0011		&dmovi imm=0
+  MOV_im	1111 1001 rd:4 .. sz:2 dsp:8		imm=%b3_li_10
+}
 # MOV.<bwl> #imm, dsp16[rd]
 MOV_im		1111 1010 rd:4 .. sz:2 .... .... .... .... \
 		imm=%b4_li_18 dsp=%b4_dsp_16
@@ -619,3 +656,89 @@ XOR_ir		1111 1101 0111 ..00 1101 ....		@b3_rd_li
 XOR_mr		1111 1100 0011 01.. .... ....		@b3_rd_ld_ub
 # XOR dsp[rs], rd
 XOR_mr		0000 0110 ..10 00.. 0000 1101 .... ....	@b4_rd_ldmi
+
+########
+# RXv2 DPFPU instructions
+# All 4-byte register-to-register ops use prefix 0x76 0x90
+#
+# Binary ops: 0111 0110 1001 0000 drs2:4 op:4 drd:4 drs1:4
+# Result: DRdrd = DRdrs1 op DRdrs2
+DADD		0111 0110 1001 0000 drs2:4 0000 drd:4 drs1:4	&drrr
+DSUB		0111 0110 1001 0000 drs2:4 0001 drd:4 drs1:4	&drrr
+DMUL		0111 0110 1001 0000 drs2:4 0010 drd:4 drs1:4	&drrr
+DDIV		0111 0110 1001 0000 drs2:4 0101 drd:4 drs1:4	&drrr
+DCMP		0111 0110 1001 0000 drs2:4 1000 cd:4  drs1:4	&dcmpd
+
+# Unary ops group A (1100): DMOV, DABS, DNEG
+DMOV		0111 0110 1001 0000 drs:4 1100 drd:4 0000	&drr
+DABS		0111 0110 1001 0000 drs:4 1100 drd:4 0001	&drr
+DNEG		0111 0110 1001 0000 drs:4 1100 drd:4 0010	&drr
+
+# Unary ops group B (1101): DSQRT, DROUND; DR-to-GPR conversions
+DSQRT		0111 0110 1001 0000 drs:4 1101 drd:4 0000	&drr
+DROUND		0111 0110 1001 0000 drs:4 1101 drd:4 1101	&drr
+# DTOI/DTOU/DTOF convert within the DPFPU: the result lands in a DR register
+# and is moved out to a GPR with DMOV.L DRLn, Rd.
+DTOI		0111 0110 1001 0000 drs:4 1101 drd:4 1000	&drr
+DTOU		0111 0110 1001 0000 drs:4 1101 drd:4 1001	&drr
+DTOF		0111 0110 1001 0000 drs:4 1101 drd:4 1100	&drr
+
+# GPR/float-to-DR conversions using 0xFD 0x77 prefix
+# Note: 0xFD 0x77 with byte2 in 0x00-0x0F is MVTC_i (li=01); no conflict with 0x8x
+ITOD		1111 1101 0111 0111 1000 rs:4 drd:4 1001	&idr
+FTOD		1111 1101 0111 0111 1000 rs:4 drd:4 1010	&idr
+UTOD		1111 1101 0111 0111 1000 rs:4 drd:4 1101	&idr
+
+# DPUSHM.D/DPOPM.D: push/pop range of DR registers (3-byte: 0x75 prefix)
+DPUSHM		0111 0101 1011 0000 drd:4 rnum:4		&dppm
+DPOPM		0111 0101 1011 1000 drd:4 rnum:4		&dppm
+# DPUSHM.L/DPOPM.L: same, for the DPFPU control registers
+DPUSHM_l	0111 0101 1010 0000 dcrd:4 rnum:4		&dcppm
+DPOPM_l		0111 0101 1010 1000 dcrd:4 rnum:4		&dcppm
+
+########
+# RXv3: remaining DPFPU transfers
+#
+# GPR -> DR half (0xFD 0x77 prefix): byte3 low nibble is the source GPR,
+# byte4 high nibble the destination DR.
+DMOV_rdrl	1111 1101 0111 0111 1000 rs:4 drd:4 0000	&drhr
+DMOV_rdrh	1111 1101 0111 0111 1000 rs:4 drd:4 0010	&drhr
+DMOVD_rdrh	1111 1101 0111 0111 1000 rs:4 drd:4 0011	&drhr
+# DR half -> GPR (0xFD 0x75 prefix): byte3 low nibble is the destination GPR.
+DMOV_drlr	1111 1101 0111 0101 1000 rd:4 drs:4 0000	&rdrh
+DMOV_drhr	1111 1101 0111 0101 1000 rd:4 drs:4 0010	&rdrh
+
+# DPFPU control register transfers
+MVFDC		1111 1101 0111 0101 1000 rd:4 dcrs:4 0100	&rdcr
+MVTDC		1111 1101 0111 0111 1000 rs:4 dcrd:4 0100	&dcrr
+MVFDR		0111 0101 1001 0000 0001 1011
+
+# DMOV.D DRs, dsp[Rd] / DMOV.D dsp[Rs], DRd.
+# The DR register is supplied by a trailing post-byte that follows the
+# displacement, so it is read during translation rather than by decodetree.
+DMOV_mst	1111 1100 0111 10 ld:2 rd:4 1000		&dmovst
+DMOV_mld	1111 1100 1100 10 ld:2 rs:4 1000		&dmovld
+
+########
+# RXv3: bit field move. The 16-bit field descriptor follows the opcode.
+BFMOVZ		1111 1100 0101 1010 rs:4 rd:4			&bfm
+BFMOV		1111 1100 0101 1110 rs:4 rd:4			&bfm
+
+########
+# RXv3: register bank save and restore
+SAVE_r		1111 1101 0111 0110 1100 rs:4 0000 0000		&svr
+RSTR_r		1111 1101 0111 0110 1101 rs:4 0000 0000		&svr
+SAVE_i		1111 1101 0111 0110 1110 0000 imm:8		&svi
+RSTR_i		1111 1101 0111 0110 1111 0000 imm:8		&svi
+
+########
+# RXv3: three-operand XOR
+XOR_rrr		1111 1111 0110 .... .... ....		@b3_rd_rs_rs2
+
+# RXv2 accumulator context save/restore (unshifted reads).
+MVTACHI_A1 1111 1101 0001 0111 1000 r:4
+MVTACLO_A1 1111 1101 0001 0111 1001 r:4
+MVTACGU 1111 1101 0001 0111 a:1 011 r:4
+MVFACHI_A1 1111 1101 0001 1111 1000 r:4
+MVFACLO 1111 1101 0001 1111 a:1 001 r:4
+MVFACGU 1111 1101 0001 1111 a:1 011 r:4
diff --git a/target/rx/meson.build b/target/rx/meson.build
index d80ced11e2..d196737ce3 100644
--- a/target/rx/meson.build
+++ b/target/rx/meson.build
@@ -9,10 +9,8 @@ rx_ss.add(files(
   'op_helper.c',
   'helper.c',
   'cpu.c',
+  'gdbstub.c',
   'disas.c'))
 
-rx_common_system_ss = ss.source_set()
-rx_common_system_ss.add(files('gdbstub.c'))
-
 target_arch += {'rx': rx_ss}
-target_common_system_arch += {'rx': rx_common_system_ss}
+target_system_arch += {'rx': ss.source_set()}
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 36df7d377e..534ae6f83b 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
@@ -120,6 +121,65 @@ static void update_fpsw(CPURXState *env, float32 ret, uintptr_t retaddr)
     }
 }
 
+/*
+ * RXv3 register bank save function. SAVE copies R1-R15, the USP, the FPSW
+ * and the accumulator into the selected save register bank; RSTR copies them
+ * back. R0 is deliberately excluded: the stack pointer is not banked.
+ *
+ * The banks are internal CPU state that only these two instructions can
+ * reach, so there is no memory layout to model. How many banks a part
+ * provides is implementation defined and comes from the CPU model.
+ */
+static RXSaveBank *rx_save_bank(CPURXState *env, uint32_t bank,
+                                const char *insn)
+{
+    uint32_t n = RX_CPU_GET_CLASS(env_cpu(env))->num_save_banks;
+
+    if (bank >= n) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "rx: %s with out of range bank %u (this CPU has %u)\n",
+                      insn, bank, n);
+        return NULL;
+    }
+    return &env->bank[bank];
+}
+
+void helper_save(CPURXState *env, uint32_t bank)
+{
+    RXSaveBank *b = rx_save_bank(env, bank, "save");
+    int i;
+
+    if (!b) {
+        return;
+    }
+    for (i = 1; i < NUM_REGS; i++) {
+        b->regs[i] = env->regs[i];
+    }
+    b->usp = env->psw_u ? env->regs[0] : env->usp;
+    b->fpsw = env->fpsw;
+    b->acc = env->acc;
+}
+
+void helper_rstr(CPURXState *env, uint32_t bank)
+{
+    RXSaveBank *b = rx_save_bank(env, bank, "rstr");
+    int i;
+
+    if (!b) {
+        return;
+    }
+    for (i = 1; i < NUM_REGS; i++) {
+        env->regs[i] = b->regs[i];
+    }
+    if (env->psw_u) {
+        env->regs[0] = b->usp;
+    } else {
+        env->usp = b->usp;
+    }
+    env->fpsw = b->fpsw;
+    env->acc = b->acc;
+}
+
 void helper_set_fpsw(CPURXState *env, uint32_t val)
 {
     static const int roundmode[] = {
@@ -152,6 +212,287 @@ FLOATOP(fsub, float32_sub)
 FLOATOP(fmul, float32_mul)
 FLOATOP(fdiv, float32_div)
 
+/*
+ * RXv3 double-precision FPU helpers.
+ *
+ * The DPFPU has its own status word: "The single-precision floating-point
+ * status word (FPSW) is neither referred to nor updated in double-precision
+ * floating-point arithmetic operations." DPSW carries its own rounding mode
+ * (DRM) and denormal handling (DDN), so double precision runs on a separate
+ * softfloat state rather than sharing fp_status. The PSW is not touched
+ * either; DCMP records its answer in DCMR and MVFDR moves it to PSW.Z.
+ */
+#define SET_DPSW(b)                                                     \
+    do {                                                                \
+        dpsw = FIELD_DP32(dpsw, DPSW, DC ## b, 1);                      \
+        if (!FIELD_EX32(dpsw, DPSW, DE ## b)) {                         \
+            dpsw = FIELD_DP32(dpsw, DPSW, DF ## b, 1);                  \
+        }                                                               \
+    } while (0)
+
+/* Apply DPSW's rounding mode and clear the sticky softfloat flags. */
+static void dp_begin(CPURXState *env)
+{
+    static const int roundmode[] = {
+        float_round_nearest_even,
+        float_round_to_zero,
+        float_round_up,
+        float_round_down,
+    };
+    uint32_t dpsw = env->dcr[RX_DCR_DPSW];
+
+    set_float_rounding_mode(roundmode[FIELD_EX32(dpsw, DPSW, DRM)],
+                            &env->dp_status);
+    set_float_exception_flags(0, &env->dp_status);
+}
+
+/*
+ * Record the outcome of a DP arithmetic instruction in DPSW. Every such
+ * instruction except DABS and DNEG recomputes the DC* cause bits, so they
+ * are cleared first; the DF* flags accumulate and are only set while the
+ * matching DE* enable is clear.
+ */
+static void update_dpsw(CPURXState *env)
+{
+    uint32_t decnt = env->dcr[RX_DCR_DECNT];
+    uint32_t dpsw = env->dcr[RX_DCR_DPSW];
+    int xcpt = get_float_exception_flags(&env->dp_status);
+    int cause, enable;
+
+    /* DPSW and DEPC stop updating while exception info is preserved. */
+    if (FIELD_EX32(decnt, DECNT, EHM) && FIELD_EX32(decnt, DECNT, EHS)) {
+        return;
+    }
+
+    dpsw = FIELD_DP32(dpsw, DPSW, CAUSE, 0);
+
+    if (xcpt & float_flag_invalid) {
+        SET_DPSW(V);
+    }
+    if (xcpt & float_flag_divbyzero) {
+        SET_DPSW(Z);
+    }
+    if (xcpt & float_flag_overflow) {
+        SET_DPSW(O);
+    }
+    if (xcpt & float_flag_underflow) {
+        SET_DPSW(U);
+    }
+    if (xcpt & float_flag_inexact) {
+        SET_DPSW(X);
+    }
+    /*
+     * A denormal the DPFPU cannot handle is an unimplemented processing
+     * exception, which is reported only while DDN says denormals are to be
+     * treated as denormals.
+     */
+    if ((xcpt & (float_flag_input_denormal_flushed
+                 | float_flag_output_denormal_flushed))
+        && !FIELD_EX32(dpsw, DPSW, DDN)) {
+        dpsw = FIELD_DP32(dpsw, DPSW, DCE, 1);
+    }
+
+    dpsw = FIELD_DP32(dpsw, DPSW, DFS,
+                      FIELD_EX32(dpsw, DPSW, FLAGS) != 0);
+    env->dcr[RX_DCR_DPSW] = dpsw;
+
+    /*
+     * An enabled DP exception is delivered as an interrupt request to the
+     * interrupt controller rather than as a CPU exception, and suppresses
+     * the write to the destination register. Neither is modelled: the cause
+     * and flag bits above are correct, but the interrupt is not raised and
+     * the destination is written regardless.
+     */
+    cause = FIELD_EX32(dpsw, DPSW, CAUSE);
+    enable = FIELD_EX32(dpsw, DPSW, ENABLE);
+    if (cause & enable) {
+        qemu_log_mask(LOG_UNIMP,
+                      "rx: enabled DPFPU exception (DPSW=0x%08x) does not "
+                      "raise an interrupt\n", dpsw);
+    }
+}
+
+#define FLOATOP64(op, func)                                             \
+    float64 helper_##op(CPURXState *env, float64 t0, float64 t1)        \
+    {                                                                   \
+        float64 ret;                                                    \
+        dp_begin(env);                                                  \
+        ret = func(t0, t1, &env->dp_status);                            \
+        update_dpsw(env);                                               \
+        return ret;                                                     \
+    }
+
+FLOATOP64(dadd, float64_add)
+FLOATOP64(dsub, float64_sub)
+FLOATOP64(dmul, float64_mul)
+FLOATOP64(ddiv, float64_div)
+
+/*
+ * dcmp<cm> src, src2 -- compare src2 against src as directed by cm and
+ * record the answer in DCMR.RES.
+ *
+ * Mind the operand order: the manual defines every relation as src2 REL
+ * src, so LT is true when the *second* operand is the smaller one. src is
+ * the first encoded register (drs1) and src2 the second (drs2).
+ *
+ * The PSW is left alone -- C, Z, S and O are all listed as unchanged --
+ * which is why MVFDR exists to move DCMR.RES into PSW.Z.
+ *
+ * The condition field is a mask of the relations that make RES true, which
+ * is why LE (6) is LT (4) | EQ (2); it agrees with the manual on all four
+ * documented conditions. UN is defined as isNaN(src) || isNaN(src2), which
+ * is exactly what an unordered comparison reports. The comparison is quiet
+ * because testing for unordered is one of the conditions on offer.
+ */
+void helper_dcmp(CPURXState *env, uint32_t cm, float64 src, float64 src2)
+{
+    int st;
+    bool res = false;
+
+    dp_begin(env);
+    st = float64_compare_quiet(src2, src, &env->dp_status);
+
+    if ((cm & RX_DCMP_UN) && st == float_relation_unordered) {
+        res = true;
+    }
+    if ((cm & RX_DCMP_EQ) && st == float_relation_equal) {
+        res = true;
+    }
+    if ((cm & RX_DCMP_LT) && st == float_relation_less) {
+        res = true;
+    }
+    env->dcr[RX_DCR_DCMR] = deposit32(env->dcr[RX_DCR_DCMR],
+                                      RX_DCMR_RES_BIT, 1, res);
+    update_dpsw(env);
+}
+
+/*
+ * DABS and DNEG only change the sign bit. They cannot raise an exception,
+ * and are the two DP arithmetic instructions that leave the DC* cause bits
+ * as they were rather than recomputing them.
+ */
+float64 helper_dabs(CPURXState *env, float64 t0)
+{
+    return float64_abs(t0);
+}
+
+float64 helper_dneg(CPURXState *env, float64 t0)
+{
+    return float64_chs(t0);
+}
+
+float64 helper_dsqrt(CPURXState *env, float64 t0)
+{
+    float64 ret;
+
+    dp_begin(env);
+    ret = float64_sqrt(t0, &env->dp_status);
+    update_dpsw(env);
+    return ret;
+}
+
+float64 helper_dround(CPURXState *env, float64 t0)
+{
+    float64 ret;
+
+    dp_begin(env);
+    ret = float64_round_to_int(t0, &env->dp_status);
+    update_dpsw(env);
+    return ret;
+}
+
+uint32_t helper_dtoi(CPURXState *env, float64 t0)
+{
+    uint32_t ret;
+
+    dp_begin(env);
+    ret = float64_to_int32_round_to_zero(t0, &env->dp_status);
+    update_dpsw(env);
+    return ret;
+}
+
+uint32_t helper_dtou(CPURXState *env, float64 t0)
+{
+    uint32_t ret;
+
+    dp_begin(env);
+    ret = float64_to_uint32_round_to_zero(t0, &env->dp_status);
+    update_dpsw(env);
+    return ret;
+}
+
+/* dtof narrows to single precision but is a DPFPU instruction: DPSW. */
+float32 helper_dtof(CPURXState *env, float64 t0)
+{
+    float32 ret;
+
+    dp_begin(env);
+    ret = float64_to_float32(t0, &env->dp_status);
+    update_dpsw(env);
+    return ret;
+}
+
+float64 helper_itod(CPURXState *env, uint32_t t0)
+{
+    float64 ret;
+
+    dp_begin(env);
+    ret = int32_to_float64((int32_t)t0, &env->dp_status);
+    update_dpsw(env);
+    return ret;
+}
+
+float64 helper_utod(CPURXState *env, uint32_t t0)
+{
+    float64 ret;
+
+    dp_begin(env);
+    ret = uint32_to_float64(t0, &env->dp_status);
+    update_dpsw(env);
+    return ret;
+}
+
+float64 helper_ftod(CPURXState *env, float32 t0)
+{
+    float64 ret;
+
+    dp_begin(env);
+    ret = float32_to_float64(t0, &env->dp_status);
+    update_dpsw(env);
+    return ret;
+}
+
+/*
+ * mvtdc rs, DCRd. Not a plain register write: the DC* cause bits in DPSW
+ * clear on a written 0 and keep their value on a written 1, DFS is a
+ * read-only summary, DCMR holds only RES, and DEPC is read-only.
+ */
+void helper_mvtdc(CPURXState *env, uint32_t reg, uint32_t val)
+{
+    uint32_t old, dpsw;
+
+    switch (reg) {
+    case RX_DCR_DPSW:
+        old = env->dcr[RX_DCR_DPSW];
+        dpsw = val & RX_DPSW_WRITE_MASK;
+        dpsw = (dpsw & ~RX_DPSW_CAUSE_MASK)
+             | (old & val & RX_DPSW_CAUSE_MASK);
+        dpsw = FIELD_DP32(dpsw, DPSW, DFS,
+                          FIELD_EX32(dpsw, DPSW, FLAGS) != 0);
+        env->dcr[RX_DCR_DPSW] = dpsw;
+        break;
+    case RX_DCR_DCMR:
+        env->dcr[RX_DCR_DCMR] = val & RX_DCMR_WRITE_MASK;
+        break;
+    case RX_DCR_DECNT:
+        env->dcr[RX_DCR_DECNT] = val & (R_DECNT_EHM_MASK | R_DECNT_EHS_MASK);
+        break;
+    default:
+        /* DEPC is read-only. */
+        break;
+    }
+}
+
 void helper_fcmp(CPURXState *env, float32 t0, float32 t1)
 {
     int st;
@@ -180,6 +521,14 @@ uint32_t helper_ftoi(CPURXState *env, float32 t0)
     return ret;
 }
 
+uint32_t helper_ftou(CPURXState *env, float32 t0)
+{
+    uint32_t ret;
+    ret = float32_to_uint32_round_to_zero(t0, &env->fp_status);
+    update_fpsw(env, ret, GETPC());
+    return ret;
+}
+
 uint32_t helper_round(CPURXState *env, float32 t0)
 {
     uint32_t ret;
@@ -196,6 +545,14 @@ float32 helper_itof(CPURXState *env, uint32_t t0)
     return ret;
 }
 
+float32 helper_utof(CPURXState *env, uint32_t t0)
+{
+    float32 ret;
+    ret = uint32_to_float32(t0, &env->fp_status);
+    update_fpsw(env, ret, GETPC());
+    return ret;
+}
+
 /* string operations */
 void helper_scmpu(CPURXState *env)
 {
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 132d495710..0958bdcf50 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -37,11 +37,23 @@ typedef struct DisasContext {
     CPURXState *env;
     uint32_t pc;
     uint32_t tb_flags;
+    RXISAVersion isa_version;
 } DisasContext;
 
+/*
+ * Instructions introduced after RXv1 are only valid on CPU models that
+ * implement the corresponding revision. Returning false from a trans_
+ * handler makes decode() fail, which raises an illegal instruction
+ * exception exactly as an unknown encoding would.
+ */
+static bool require_isa(DisasContext *ctx, RXISAVersion version)
+{
+    return ctx->isa_version >= version;
+}
+
 typedef struct DisasCompare {
-    TCGv_i32 value;
-    TCGv_i32 temp;
+    TCGv value;
+    TCGv temp;
     TCGCond cond;
 } DisasCompare;
 
@@ -49,7 +61,7 @@ const char *rx_crname(uint8_t cr)
 {
     static const char *cr_names[] = {
         "psw", "pc", "usp", "fpsw", "", "", "", "",
-        "bpsw", "bpc", "isp", "fintv", "intb", "", "", ""
+        "bpsw", "bpc", "isp", "fintv", "intb", "extb", "", ""
     };
     if (cr >= ARRAY_SIZE(cr_names)) {
         return "illegal";
@@ -63,20 +75,18 @@ const char *rx_crname(uint8_t cr)
 #define DISAS_EXIT    DISAS_TARGET_2
 
 /* global register indexes */
-static TCGv_i32 cpu_regs[16];
-static TCGv_i32 cpu_psw_o, cpu_psw_s, cpu_psw_z, cpu_psw_c;
-static TCGv_i32 cpu_psw_i, cpu_psw_pm, cpu_psw_u, cpu_psw_ipl;
-static TCGv_i32 cpu_usp, cpu_fpsw, cpu_bpsw, cpu_bpc, cpu_isp;
-static TCGv_i32 cpu_fintv, cpu_intb, cpu_pc;
+static TCGv cpu_regs[16];
+static TCGv cpu_psw_o, cpu_psw_s, cpu_psw_z, cpu_psw_c;
+static TCGv cpu_psw_i, cpu_psw_pm, cpu_psw_u, cpu_psw_ipl;
+static TCGv cpu_usp, cpu_fpsw, cpu_bpsw, cpu_bpc, cpu_isp;
+static TCGv cpu_fintv, cpu_intb, cpu_extb, cpu_pc;
 static TCGv_i64 cpu_acc;
+/* RXv3 DPFPU state */
+static TCGv_i64 cpu_dregs[NUM_DREGS];
+static TCGv cpu_dcregs[NUM_DCREGS];
 
 #define cpu_sp cpu_regs[0]
 
-static inline MemOp mo_endian(DisasContext *dc)
-{
-    return MO_LE;
-}
-
 /* decoder helper */
 static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
                                   int i, int n)
@@ -90,9 +100,8 @@ static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
 
 static uint32_t li(DisasContext *ctx, int sz)
 {
-    vaddr addr;
+    target_ulong addr;
     uint32_t tmp;
-    MemOp endian = mo_endian(ctx);
     CPURXState *env = ctx->env;
     addr = ctx->base.pc_next;
 
@@ -102,16 +111,16 @@ static uint32_t li(DisasContext *ctx, int sz)
         return (int8_t)translator_ldub(env, &ctx->base, addr);
     case 2:
         ctx->base.pc_next += 2;
-        return (int16_t) translator_lduw_end(env, &ctx->base, addr, endian);
+        return (int16_t)translator_lduw_end(env, &ctx->base, addr, MO_LE);
     case 3:
         ctx->base.pc_next += 3;
         tmp = (int8_t)translator_ldub(env, &ctx->base, addr + 2);
         tmp <<= 16;
-        tmp |= translator_lduw_end(env, &ctx->base, addr, endian);
+        tmp |= translator_lduw_end(env, &ctx->base, addr, MO_LE);
         return tmp;
     case 0:
         ctx->base.pc_next += 4;
-        return translator_ldl_end(env, &ctx->base, addr, endian);
+        return translator_ldl_end(env, &ctx->base, addr, MO_LE);
     default:
         g_assert_not_reached();
     }
@@ -151,14 +160,23 @@ void rx_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                      i, env->regs[i], i + 1, env->regs[i + 1],
                      i + 2, env->regs[i + 2], i + 3, env->regs[i + 3]);
     }
+    if (RX_CPU_GET_CLASS(cs)->isa_version >= RX_ISA_V3) {
+        for (i = 0; i < NUM_DREGS; i += 2) {
+            qemu_fprintf(f, "dr%d=0x%016" PRIx64 " dr%d=0x%016" PRIx64 "\n",
+                         i, env->dr[i], i + 1, env->dr[i + 1]);
+        }
+        qemu_fprintf(f, "dpsw=0x%08x dcmr=0x%08x decnt=0x%08x depc=0x%08x\n",
+                     env->dcr[RX_DCR_DPSW], env->dcr[RX_DCR_DCMR],
+                     env->dcr[RX_DCR_DECNT], env->dcr[RX_DCR_DEPC]);
+    }
 }
 
-static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx, vaddr dest)
+static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
 {
     if (translator_use_goto_tb(&dc->base, dest)) {
-        tcg_gen_goto_tb(tb_slot_idx);
+        tcg_gen_goto_tb(n);
         tcg_gen_movi_i32(cpu_pc, dest);
-        tcg_gen_exit_tb(dc->base.tb, tb_slot_idx);
+        tcg_gen_exit_tb(dc->base.tb, n);
     } else {
         tcg_gen_movi_i32(cpu_pc, dest);
         tcg_gen_lookup_and_goto_ptr();
@@ -167,34 +185,34 @@ static void gen_goto_tb(DisasContext *dc, unsigned tb_slot_idx, vaddr dest)
 }
 
 /* generic load wrapper */
-static void rx_gen_ld(DisasContext *ctx, MemOp size, TCGv_i32 reg, TCGv_i32 mem)
+static inline void rx_gen_ld(unsigned int size, TCGv reg, TCGv mem)
 {
-    tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_SIGN | mo_endian(ctx));
+    tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_SIGN | MO_LE);
 }
 
 /* unsigned load wrapper */
-static void rx_gen_ldu(DisasContext *ctx, MemOp size, TCGv_i32 reg, TCGv_i32 mem)
+static inline void rx_gen_ldu(unsigned int size, TCGv reg, TCGv mem)
 {
-    tcg_gen_qemu_ld_i32(reg, mem, 0, size | mo_endian(ctx));
+    tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_LE);
 }
 
 /* generic store wrapper */
-static void rx_gen_st(DisasContext *ctx, MemOp size, TCGv_i32 reg, TCGv_i32 mem)
+static inline void rx_gen_st(unsigned int size, TCGv reg, TCGv mem)
 {
-    tcg_gen_qemu_st_i32(reg, mem, 0, size | mo_endian(ctx));
+    tcg_gen_qemu_st_i32(reg, mem, 0, size | MO_LE);
 }
 
 /* [ri, rb] */
-static void rx_gen_regindex(DisasContext *ctx, TCGv_i32 mem,
-                            int size, int ri, int rb)
+static inline void rx_gen_regindex(DisasContext *ctx, TCGv mem,
+                                   int size, int ri, int rb)
 {
     tcg_gen_shli_i32(mem, cpu_regs[ri], size);
     tcg_gen_add_i32(mem, mem, cpu_regs[rb]);
 }
 
 /* dsp[reg] */
-static TCGv_i32 rx_index_addr(DisasContext *ctx, TCGv_i32 mem,
-                              int ld, int size, int reg)
+static inline TCGv rx_index_addr(DisasContext *ctx, TCGv mem,
+                                 int ld, int size, int reg)
 {
     uint32_t dsp;
 
@@ -208,7 +226,7 @@ static TCGv_i32 rx_index_addr(DisasContext *ctx, TCGv_i32 mem,
         return mem;
     case 2:
         dsp = translator_lduw_end(ctx->env, &ctx->base, ctx->base.pc_next,
-                                  mo_endian(ctx)) << size;
+                                  MO_LE) << size;
         tcg_gen_addi_i32(mem, cpu_regs[reg], dsp);
         ctx->base.pc_next += 2;
         return mem;
@@ -225,15 +243,15 @@ static inline MemOp mi_to_mop(unsigned mi)
 }
 
 /* load source operand */
-static TCGv_i32 rx_load_source(DisasContext *ctx, TCGv_i32 mem,
-                               int ld, int mi, int rs)
+static inline TCGv rx_load_source(DisasContext *ctx, TCGv mem,
+                                  int ld, int mi, int rs)
 {
-    TCGv_i32 addr;
+    TCGv addr;
     MemOp mop;
     if (ld < 3) {
         mop = mi_to_mop(mi);
         addr = rx_index_addr(ctx, mem, ld, mop & MO_SIZE, rs);
-        tcg_gen_qemu_ld_i32(mem, addr, 0, mop | mo_endian(ctx));
+        tcg_gen_qemu_ld_i32(mem, addr, 0, mop | MO_LE);
         return mem;
     } else {
         return cpu_regs[rs];
@@ -322,7 +340,7 @@ static void psw_cond(DisasCompare *dc, uint32_t cond)
     }
 }
 
-static void move_from_cr(DisasContext *ctx, TCGv_i32 ret, int cr, uint32_t pc)
+static void move_from_cr(DisasContext *ctx, TCGv ret, int cr, uint32_t pc)
 {
     switch (cr) {
     case 0:     /* PSW */
@@ -360,6 +378,9 @@ static void move_from_cr(DisasContext *ctx, TCGv_i32 ret, int cr, uint32_t pc)
     case 12:    /* INTB */
         tcg_gen_mov_i32(ret, cpu_intb);
         break;
+    case 13:    /* EXTB */
+        tcg_gen_mov_i32(ret, cpu_extb);
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "Unimplement control register %d", cr);
         /* Unimplement registers return 0 */
@@ -368,7 +389,7 @@ static void move_from_cr(DisasContext *ctx, TCGv_i32 ret, int cr, uint32_t pc)
     }
 }
 
-static void move_to_cr(DisasContext *ctx, TCGv_i32 val, int cr)
+static void move_to_cr(DisasContext *ctx, TCGv val, int cr)
 {
     if (cr >= 8 && !is_privileged(ctx, 0)) {
         /* Some control registers can only be written in privileged mode. */
@@ -414,6 +435,9 @@ static void move_to_cr(DisasContext *ctx, TCGv_i32 val, int cr)
     case 12:    /* INTB */
         tcg_gen_mov_i32(cpu_intb, val);
         break;
+    case 13:    /* EXTB */
+        tcg_gen_mov_i32(cpu_extb, val);
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Unimplement control register %d", cr);
@@ -421,35 +445,35 @@ static void move_to_cr(DisasContext *ctx, TCGv_i32 val, int cr)
     }
 }
 
-static void push(DisasContext *ctx, TCGv_i32 val)
+static void push(TCGv val)
 {
     tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
-    rx_gen_st(ctx, MO_32, val, cpu_sp);
+    rx_gen_st(MO_32, val, cpu_sp);
 }
 
-static void pop(DisasContext *ctx, TCGv_i32 ret)
+static void pop(TCGv ret)
 {
-    rx_gen_ld(ctx, MO_32, ret, cpu_sp);
+    rx_gen_ld(MO_32, ret, cpu_sp);
     tcg_gen_addi_i32(cpu_sp, cpu_sp, 4);
 }
 
 /* mov.<bwl> rs,dsp5[rd] */
 static bool trans_MOV_rm(DisasContext *ctx, arg_MOV_rm *a)
 {
-    TCGv_i32 mem;
-    mem = tcg_temp_new_i32();
+    TCGv mem;
+    mem = tcg_temp_new();
     tcg_gen_addi_i32(mem, cpu_regs[a->rd], a->dsp << a->sz);
-    rx_gen_st(ctx, a->sz, cpu_regs[a->rs], mem);
+    rx_gen_st(a->sz, cpu_regs[a->rs], mem);
     return true;
 }
 
 /* mov.<bwl> dsp5[rs],rd */
 static bool trans_MOV_mr(DisasContext *ctx, arg_MOV_mr *a)
 {
-    TCGv_i32 mem;
-    mem = tcg_temp_new_i32();
+    TCGv mem;
+    mem = tcg_temp_new();
     tcg_gen_addi_i32(mem, cpu_regs[a->rs], a->dsp << a->sz);
-    rx_gen_ld(ctx, a->sz, cpu_regs[a->rd], mem);
+    rx_gen_ld(a->sz, cpu_regs[a->rd], mem);
     return true;
 }
 
@@ -466,31 +490,31 @@ static bool trans_MOV_ir(DisasContext *ctx, arg_MOV_ir *a)
 /* mov.<bwl> #imm, dsp[rd] */
 static bool trans_MOV_im(DisasContext *ctx, arg_MOV_im *a)
 {
-    TCGv_i32 imm, mem;
+    TCGv imm, mem;
     imm = tcg_constant_i32(a->imm);
-    mem = tcg_temp_new_i32();
+    mem = tcg_temp_new();
     tcg_gen_addi_i32(mem, cpu_regs[a->rd], a->dsp << a->sz);
-    rx_gen_st(ctx, a->sz, imm, mem);
+    rx_gen_st(a->sz, imm, mem);
     return true;
 }
 
 /* mov.<bwl> [ri,rb],rd */
 static bool trans_MOV_ar(DisasContext *ctx, arg_MOV_ar *a)
 {
-    TCGv_i32 mem;
-    mem = tcg_temp_new_i32();
+    TCGv mem;
+    mem = tcg_temp_new();
     rx_gen_regindex(ctx, mem, a->sz, a->ri, a->rb);
-    rx_gen_ld(ctx, a->sz, cpu_regs[a->rd], mem);
+    rx_gen_ld(a->sz, cpu_regs[a->rd], mem);
     return true;
 }
 
 /* mov.<bwl> rd,[ri,rb] */
 static bool trans_MOV_ra(DisasContext *ctx, arg_MOV_ra *a)
 {
-    TCGv_i32 mem;
-    mem = tcg_temp_new_i32();
+    TCGv mem;
+    mem = tcg_temp_new();
     rx_gen_regindex(ctx, mem, a->sz, a->ri, a->rb);
-    rx_gen_st(ctx, a->sz, cpu_regs[a->rs], mem);
+    rx_gen_st(a->sz, cpu_regs[a->rs], mem);
     return true;
 }
 
@@ -500,7 +524,7 @@ static bool trans_MOV_ra(DisasContext *ctx, arg_MOV_ra *a)
 /* mov.<bwl> rs,rd */
 static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
 {
-    TCGv_i32 tmp, mem, addr;
+    TCGv tmp, mem, addr;
 
     if (a->lds == 3 && a->ldd == 3) {
         /* mov.<bwl> rs,rd */
@@ -508,22 +532,22 @@ static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
         return true;
     }
 
-    mem = tcg_temp_new_i32();
+    mem = tcg_temp_new();
     if (a->lds == 3) {
         /* mov.<bwl> rs,dsp[rd] */
         addr = rx_index_addr(ctx, mem, a->ldd, a->sz, a->rs);
-        rx_gen_st(ctx, a->sz, cpu_regs[a->rd], addr);
+        rx_gen_st(a->sz, cpu_regs[a->rd], addr);
     } else if (a->ldd == 3) {
         /* mov.<bwl> dsp[rs],rd */
         addr = rx_index_addr(ctx, mem, a->lds, a->sz, a->rs);
-        rx_gen_ld(ctx, a->sz, cpu_regs[a->rd], addr);
+        rx_gen_ld(a->sz, cpu_regs[a->rd], addr);
     } else {
         /* mov.<bwl> dsp[rs],dsp[rd] */
-        tmp = tcg_temp_new_i32();
+        tmp = tcg_temp_new();
         addr = rx_index_addr(ctx, mem, a->lds, a->sz, a->rs);
-        rx_gen_ld(ctx, a->sz, tmp, addr);
+        rx_gen_ld(a->sz, tmp, addr);
         addr = rx_index_addr(ctx, mem, a->ldd, a->sz, a->rd);
-        rx_gen_st(ctx, a->sz, tmp, addr);
+        rx_gen_st(a->sz, tmp, addr);
     }
     return true;
 }
@@ -532,13 +556,13 @@ static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
 /* mov.<bwl> rs,[-rd] */
 static bool trans_MOV_rp(DisasContext *ctx, arg_MOV_rp *a)
 {
-    TCGv_i32 val;
-    val = tcg_temp_new_i32();
+    TCGv val;
+    val = tcg_temp_new();
     tcg_gen_mov_i32(val, cpu_regs[a->rs]);
     if (a->ad == 1) {
         tcg_gen_subi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
     }
-    rx_gen_st(ctx, a->sz, val, cpu_regs[a->rd]);
+    rx_gen_st(a->sz, val, cpu_regs[a->rd]);
     if (a->ad == 0) {
         tcg_gen_addi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
     }
@@ -549,12 +573,12 @@ static bool trans_MOV_rp(DisasContext *ctx, arg_MOV_rp *a)
 /* mov.<bwl> [-rd],rs */
 static bool trans_MOV_pr(DisasContext *ctx, arg_MOV_pr *a)
 {
-    TCGv_i32 val;
-    val = tcg_temp_new_i32();
+    TCGv val;
+    val = tcg_temp_new();
     if (a->ad == 1) {
         tcg_gen_subi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
     }
-    rx_gen_ld(ctx, a->sz, val, cpu_regs[a->rd]);
+    rx_gen_ld(a->sz, val, cpu_regs[a->rd]);
     if (a->ad == 0) {
         tcg_gen_addi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
     }
@@ -566,10 +590,10 @@ static bool trans_MOV_pr(DisasContext *ctx, arg_MOV_pr *a)
 /* movu.<bw> dsp[rs],rd */
 static bool trans_MOVU_mr(DisasContext *ctx, arg_MOVU_mr *a)
 {
-    TCGv_i32 mem;
-    mem = tcg_temp_new_i32();
+    TCGv mem;
+    mem = tcg_temp_new();
     tcg_gen_addi_i32(mem, cpu_regs[a->rs], a->dsp << a->sz);
-    rx_gen_ldu(ctx, a->sz, cpu_regs[a->rd], mem);
+    rx_gen_ldu(a->sz, cpu_regs[a->rd], mem);
     return true;
 }
 
@@ -583,10 +607,10 @@ static bool trans_MOVU_rr(DisasContext *ctx, arg_MOVU_rr *a)
 /* movu.<bw> [ri,rb],rd */
 static bool trans_MOVU_ar(DisasContext *ctx, arg_MOVU_ar *a)
 {
-    TCGv_i32 mem;
-    mem = tcg_temp_new_i32();
+    TCGv mem;
+    mem = tcg_temp_new();
     rx_gen_regindex(ctx, mem, a->sz, a->ri, a->rb);
-    rx_gen_ldu(ctx, a->sz, cpu_regs[a->rd], mem);
+    rx_gen_ldu(a->sz, cpu_regs[a->rd], mem);
     return true;
 }
 
@@ -594,12 +618,12 @@ static bool trans_MOVU_ar(DisasContext *ctx, arg_MOVU_ar *a)
 /* mov.<bw> [-rd],rs */
 static bool trans_MOVU_pr(DisasContext *ctx, arg_MOVU_pr *a)
 {
-    TCGv_i32 val;
-    val = tcg_temp_new_i32();
+    TCGv val;
+    val = tcg_temp_new();
     if (a->ad == 1) {
         tcg_gen_subi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
     }
-    rx_gen_ldu(ctx, a->sz, val, cpu_regs[a->rd]);
+    rx_gen_ldu(a->sz, val, cpu_regs[a->rd]);
     if (a->ad == 0) {
         tcg_gen_addi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
     }
@@ -624,9 +648,9 @@ static bool trans_POP(DisasContext *ctx, arg_POP *a)
 /* popc cr */
 static bool trans_POPC(DisasContext *ctx, arg_POPC *a)
 {
-    TCGv_i32 val;
-    val = tcg_temp_new_i32();
-    pop(ctx, val);
+    TCGv val;
+    val = tcg_temp_new();
+    pop(val);
     move_to_cr(ctx, val, a->cr);
     return true;
 }
@@ -641,7 +665,7 @@ static bool trans_POPM(DisasContext *ctx, arg_POPM *a)
     }
     r = a->rd;
     while (r <= a->rd2 && r < 16) {
-        pop(ctx, cpu_regs[r++]);
+        pop(cpu_regs[r++]);
     }
     return true;
 }
@@ -650,34 +674,34 @@ static bool trans_POPM(DisasContext *ctx, arg_POPM *a)
 /* push.<bwl> rs */
 static bool trans_PUSH_r(DisasContext *ctx, arg_PUSH_r *a)
 {
-    TCGv_i32 val;
-    val = tcg_temp_new_i32();
+    TCGv val;
+    val = tcg_temp_new();
     tcg_gen_mov_i32(val, cpu_regs[a->rs]);
     tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
-    rx_gen_st(ctx, a->sz, val, cpu_sp);
+    rx_gen_st(a->sz, val, cpu_sp);
     return true;
 }
 
 /* push.<bwl> dsp[rs] */
 static bool trans_PUSH_m(DisasContext *ctx, arg_PUSH_m *a)
 {
-    TCGv_i32 mem, val, addr;
-    mem = tcg_temp_new_i32();
-    val = tcg_temp_new_i32();
+    TCGv mem, val, addr;
+    mem = tcg_temp_new();
+    val = tcg_temp_new();
     addr = rx_index_addr(ctx, mem, a->ld, a->sz, a->rs);
-    rx_gen_ld(ctx, a->sz, val, addr);
+    rx_gen_ld(a->sz, val, addr);
     tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
-    rx_gen_st(ctx, a->sz, val, cpu_sp);
+    rx_gen_st(a->sz, val, cpu_sp);
     return true;
 }
 
 /* pushc rx */
 static bool trans_PUSHC(DisasContext *ctx, arg_PUSHC *a)
 {
-    TCGv_i32 val;
-    val = tcg_temp_new_i32();
+    TCGv val;
+    val = tcg_temp_new();
     move_from_cr(ctx, val, a->cr, ctx->pc);
-    push(ctx, val);
+    push(val);
     return true;
 }
 
@@ -692,7 +716,7 @@ static bool trans_PUSHM(DisasContext *ctx, arg_PUSHM *a)
     }
     r = a->rs2;
     while (r >= a->rs && r >= 0) {
-        push(ctx, cpu_regs[r--]);
+        push(cpu_regs[r--]);
     }
     return true;
 }
@@ -700,8 +724,8 @@ static bool trans_PUSHM(DisasContext *ctx, arg_PUSHM *a)
 /* xchg rs,rd */
 static bool trans_XCHG_rr(DisasContext *ctx, arg_XCHG_rr *a)
 {
-    TCGv_i32 tmp;
-    tmp = tcg_temp_new_i32();
+    TCGv tmp;
+    tmp = tcg_temp_new();
     tcg_gen_mov_i32(tmp, cpu_regs[a->rs]);
     tcg_gen_mov_i32(cpu_regs[a->rs], cpu_regs[a->rd]);
     tcg_gen_mov_i32(cpu_regs[a->rd], tmp);
@@ -711,8 +735,8 @@ static bool trans_XCHG_rr(DisasContext *ctx, arg_XCHG_rr *a)
 /* xchg dsp[rs].<mi>,rd */
 static bool trans_XCHG_mr(DisasContext *ctx, arg_XCHG_mr *a)
 {
-    TCGv_i32 mem, addr;
-    mem = tcg_temp_new_i32();
+    TCGv mem, addr;
+    mem = tcg_temp_new();
     switch (a->mi) {
     case 0: /* dsp[rs].b */
     case 1: /* dsp[rs].w */
@@ -731,10 +755,10 @@ static bool trans_XCHG_mr(DisasContext *ctx, arg_XCHG_mr *a)
     return true;
 }
 
-static void stcond(TCGCond cond, int rd, int imm)
+static inline void stcond(TCGCond cond, int rd, int imm)
 {
-    TCGv_i32 z;
-    TCGv_i32 _imm;
+    TCGv z;
+    TCGv _imm;
     z = tcg_constant_i32(0);
     _imm = tcg_constant_i32(imm);
     tcg_gen_movcond_i32(cond, cpu_regs[rd], cpu_psw_z, z,
@@ -744,6 +768,9 @@ static void stcond(TCGCond cond, int rd, int imm)
 /* stz #imm,rd */
 static bool trans_STZ(DisasContext *ctx, arg_STZ *a)
 {
+    if (!require_isa(ctx, RX_ISA_V2)) {
+        return false;
+    }
     stcond(TCG_COND_EQ, a->rd, a->imm);
     return true;
 }
@@ -751,6 +778,9 @@ static bool trans_STZ(DisasContext *ctx, arg_STZ *a)
 /* stnz #imm,rd */
 static bool trans_STNZ(DisasContext *ctx, arg_STNZ *a)
 {
+    if (!require_isa(ctx, RX_ISA_V2)) {
+        return false;
+    }
     stcond(TCG_COND_NE, a->rd, a->imm);
     return true;
 }
@@ -760,15 +790,15 @@ static bool trans_STNZ(DisasContext *ctx, arg_STNZ *a)
 static bool trans_SCCnd(DisasContext *ctx, arg_SCCnd *a)
 {
     DisasCompare dc;
-    TCGv_i32 val, mem, addr;
-    dc.temp = tcg_temp_new_i32();
+    TCGv val, mem, addr;
+    dc.temp = tcg_temp_new();
     psw_cond(&dc, a->cd);
     if (a->ld < 3) {
-        val = tcg_temp_new_i32();
-        mem = tcg_temp_new_i32();
+        val = tcg_temp_new();
+        mem = tcg_temp_new();
         tcg_gen_setcondi_i32(dc.cond, val, dc.value, 0);
         addr = rx_index_addr(ctx, mem, a->sz, a->ld, a->rd);
-        rx_gen_st(ctx, a->sz, val, addr);
+        rx_gen_st(a->sz, val, addr);
     } else {
         tcg_gen_setcondi_i32(dc.cond, cpu_regs[a->rd], dc.value, 0);
     }
@@ -779,7 +809,7 @@ static bool trans_SCCnd(DisasContext *ctx, arg_SCCnd *a)
 static bool trans_RTSD_i(DisasContext *ctx, arg_RTSD_i *a)
 {
     tcg_gen_addi_i32(cpu_sp, cpu_sp, a->imm  << 2);
-    pop(ctx, cpu_pc);
+    pop(cpu_pc);
     ctx->base.is_jmp = DISAS_JUMP;
     return true;
 }
@@ -799,42 +829,42 @@ static bool trans_RTSD_irr(DisasContext *ctx, arg_RTSD_irr *a)
     tcg_gen_addi_i32(cpu_sp, cpu_sp, adj << 2);
     dst = a->rd;
     while (dst <= a->rd2 && dst < 16) {
-        pop(ctx, cpu_regs[dst++]);
+        pop(cpu_regs[dst++]);
     }
-    pop(ctx, cpu_pc);
+    pop(cpu_pc);
     ctx->base.is_jmp = DISAS_JUMP;
     return true;
 }
 
-typedef void (*op2fn)(TCGv_i32 ret, TCGv_i32 arg1);
-typedef void (*op3fn)(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
+typedef void (*op2fn)(TCGv ret, TCGv arg1);
+typedef void (*op3fn)(TCGv ret, TCGv arg1, TCGv arg2);
 
-static void rx_gen_op_rr(op2fn opr, int dst, int src)
+static inline void rx_gen_op_rr(op2fn opr, int dst, int src)
 {
     opr(cpu_regs[dst], cpu_regs[src]);
 }
 
-static void rx_gen_op_rrr(op3fn opr, int dst, int src, int src2)
+static inline void rx_gen_op_rrr(op3fn opr, int dst, int src, int src2)
 {
     opr(cpu_regs[dst], cpu_regs[src], cpu_regs[src2]);
 }
 
-static void rx_gen_op_irr(op3fn opr, int dst, int src, uint32_t src2)
+static inline void rx_gen_op_irr(op3fn opr, int dst, int src, uint32_t src2)
 {
-    TCGv_i32 imm = tcg_constant_i32(src2);
+    TCGv imm = tcg_constant_i32(src2);
     opr(cpu_regs[dst], cpu_regs[src], imm);
 }
 
-static void rx_gen_op_mr(op3fn opr, DisasContext *ctx,
-                         int dst, int src, int ld, int mi)
+static inline void rx_gen_op_mr(op3fn opr, DisasContext *ctx,
+                                int dst, int src, int ld, int mi)
 {
-    TCGv_i32 val, mem;
-    mem = tcg_temp_new_i32();
+    TCGv val, mem;
+    mem = tcg_temp_new();
     val = rx_load_source(ctx, mem, ld, mi, src);
     opr(cpu_regs[dst], cpu_regs[dst], val);
 }
 
-static void rx_and(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+static void rx_and(TCGv ret, TCGv arg1, TCGv arg2)
 {
     tcg_gen_and_i32(cpu_psw_s, arg1, arg2);
     tcg_gen_mov_i32(cpu_psw_z, cpu_psw_s);
@@ -864,7 +894,7 @@ static bool trans_AND_rrr(DisasContext *ctx, arg_AND_rrr *a)
     return true;
 }
 
-static void rx_or(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+static void rx_or(TCGv ret, TCGv arg1, TCGv arg2)
 {
     tcg_gen_or_i32(cpu_psw_s, arg1, arg2);
     tcg_gen_mov_i32(cpu_psw_z, cpu_psw_s);
@@ -894,7 +924,7 @@ static bool trans_OR_rrr(DisasContext *ctx, arg_OR_rrr *a)
     return true;
 }
 
-static void rx_xor(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+static void rx_xor(TCGv ret, TCGv arg1, TCGv arg2)
 {
     tcg_gen_xor_i32(cpu_psw_s, arg1, arg2);
     tcg_gen_mov_i32(cpu_psw_z, cpu_psw_s);
@@ -916,7 +946,7 @@ static bool trans_XOR_mr(DisasContext *ctx, arg_XOR_mr *a)
     return true;
 }
 
-static void rx_tst(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+static void rx_tst(TCGv ret, TCGv arg1, TCGv arg2)
 {
     tcg_gen_and_i32(cpu_psw_s, arg1, arg2);
     tcg_gen_mov_i32(cpu_psw_z, cpu_psw_s);
@@ -937,7 +967,7 @@ static bool trans_TST_mr(DisasContext *ctx, arg_TST_mr *a)
     return true;
 }
 
-static void rx_not(TCGv_i32 ret, TCGv_i32 arg1)
+static void rx_not(TCGv ret, TCGv arg1)
 {
     tcg_gen_not_i32(ret, arg1);
     tcg_gen_mov_i32(cpu_psw_z, ret);
@@ -952,7 +982,7 @@ static bool trans_NOT_rr(DisasContext *ctx, arg_NOT_rr *a)
     return true;
 }
 
-static void rx_neg(TCGv_i32 ret, TCGv_i32 arg1)
+static void rx_neg(TCGv ret, TCGv arg1)
 {
     tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_o, arg1, 0x80000000);
     tcg_gen_neg_i32(ret, arg1);
@@ -971,9 +1001,9 @@ static bool trans_NEG_rr(DisasContext *ctx, arg_NEG_rr *a)
 }
 
 /* ret = arg1 + arg2 + psw_c */
-static void rx_adc(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+static void rx_adc(TCGv ret, TCGv arg1, TCGv arg2)
 {
-    TCGv_i32 z = tcg_constant_i32(0);
+    TCGv z = tcg_constant_i32(0);
     tcg_gen_add2_i32(cpu_psw_s, cpu_psw_c, arg1, z, cpu_psw_c, z);
     tcg_gen_add2_i32(cpu_psw_s, cpu_psw_c, cpu_psw_s, cpu_psw_c, arg2, z);
     tcg_gen_xor_i32(cpu_psw_o, cpu_psw_s, arg1);
@@ -1009,9 +1039,9 @@ static bool trans_ADC_mr(DisasContext *ctx, arg_ADC_mr *a)
 }
 
 /* ret = arg1 + arg2 */
-static void rx_add(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+static void rx_add(TCGv ret, TCGv arg1, TCGv arg2)
 {
-    TCGv_i32 z = tcg_constant_i32(0);
+    TCGv z = tcg_constant_i32(0);
     tcg_gen_add2_i32(cpu_psw_s, cpu_psw_c, arg1, z, arg2, z);
     tcg_gen_xor_i32(cpu_psw_o, cpu_psw_s, arg1);
     tcg_gen_xor_i32(cpu_psw_z, arg1, arg2);
@@ -1044,7 +1074,7 @@ static bool trans_ADD_rrr(DisasContext *ctx, arg_ADD_rrr *a)
 }
 
 /* ret = arg1 - arg2 */
-static void rx_sub(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+static void rx_sub(TCGv ret, TCGv arg1, TCGv arg2)
 {
     tcg_gen_sub_i32(cpu_psw_s, arg1, arg2);
     tcg_gen_setcond_i32(TCG_COND_GEU, cpu_psw_c, arg1, arg2);
@@ -1058,17 +1088,17 @@ static void rx_sub(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
     }
 }
 
-static void rx_cmp(TCGv_i32 dummy, TCGv_i32 arg1, TCGv_i32 arg2)
+static void rx_cmp(TCGv dummy, TCGv arg1, TCGv arg2)
 {
     rx_sub(NULL, arg1, arg2);
 }
 
 /* ret = arg1 - arg2 - !psw_c */
 /* -> ret = arg1 + ~arg2 + psw_c */
-static void rx_sbb(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+static void rx_sbb(TCGv ret, TCGv arg1, TCGv arg2)
 {
-    TCGv_i32 temp;
-    temp = tcg_temp_new_i32();
+    TCGv temp;
+    temp = tcg_temp_new();
     tcg_gen_not_i32(temp, arg2);
     rx_adc(ret, arg1, temp);
 }
@@ -1194,7 +1224,7 @@ static bool trans_MUL_rrr(DisasContext *ctx, arg_MUL_rrr *a)
 /* emul #imm, rd */
 static bool trans_EMUL_ir(DisasContext *ctx, arg_EMUL_ir *a)
 {
-    TCGv_i32 imm = tcg_constant_i32(a->imm);
+    TCGv imm = tcg_constant_i32(a->imm);
     if (a->rd > 14) {
         qemu_log_mask(LOG_GUEST_ERROR, "rd too large %d", a->rd);
     }
@@ -1207,11 +1237,11 @@ static bool trans_EMUL_ir(DisasContext *ctx, arg_EMUL_ir *a)
 /* emul dsp[rs], rd */
 static bool trans_EMUL_mr(DisasContext *ctx, arg_EMUL_mr *a)
 {
-    TCGv_i32 val, mem;
+    TCGv val, mem;
     if (a->rd > 14) {
         qemu_log_mask(LOG_GUEST_ERROR, "rd too large %d", a->rd);
     }
-    mem = tcg_temp_new_i32();
+    mem = tcg_temp_new();
     val = rx_load_source(ctx, mem, a->ld, a->mi, a->rs);
     tcg_gen_muls2_i32(cpu_regs[a->rd], cpu_regs[(a->rd + 1) & 15],
                       cpu_regs[a->rd], val);
@@ -1221,7 +1251,7 @@ static bool trans_EMUL_mr(DisasContext *ctx, arg_EMUL_mr *a)
 /* emulu #imm, rd */
 static bool trans_EMULU_ir(DisasContext *ctx, arg_EMULU_ir *a)
 {
-    TCGv_i32 imm = tcg_constant_i32(a->imm);
+    TCGv imm = tcg_constant_i32(a->imm);
     if (a->rd > 14) {
         qemu_log_mask(LOG_GUEST_ERROR, "rd too large %d", a->rd);
     }
@@ -1234,23 +1264,23 @@ static bool trans_EMULU_ir(DisasContext *ctx, arg_EMULU_ir *a)
 /* emulu dsp[rs], rd */
 static bool trans_EMULU_mr(DisasContext *ctx, arg_EMULU_mr *a)
 {
-    TCGv_i32 val, mem;
+    TCGv val, mem;
     if (a->rd > 14) {
         qemu_log_mask(LOG_GUEST_ERROR, "rd too large %d", a->rd);
     }
-    mem = tcg_temp_new_i32();
+    mem = tcg_temp_new();
     val = rx_load_source(ctx, mem, a->ld, a->mi, a->rs);
     tcg_gen_mulu2_i32(cpu_regs[a->rd], cpu_regs[(a->rd + 1) & 15],
                       cpu_regs[a->rd], val);
     return true;
 }
 
-static void rx_div(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+static void rx_div(TCGv ret, TCGv arg1, TCGv arg2)
 {
     gen_helper_div(ret, tcg_env, arg1, arg2);
 }
 
-static void rx_divu(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+static void rx_divu(TCGv ret, TCGv arg1, TCGv arg2)
 {
     gen_helper_divu(ret, tcg_env, arg1, arg2);
 }
@@ -1290,8 +1320,8 @@ static bool trans_DIVU_mr(DisasContext *ctx, arg_DIVU_mr *a)
 /* shll #imm:5, rs2, rd */
 static bool trans_SHLL_irr(DisasContext *ctx, arg_SHLL_irr *a)
 {
-    TCGv_i32 tmp;
-    tmp = tcg_temp_new_i32();
+    TCGv tmp;
+    tmp = tcg_temp_new();
     if (a->imm) {
         tcg_gen_sari_i32(cpu_psw_c, cpu_regs[a->rs2], 32 - a->imm);
         tcg_gen_shli_i32(cpu_regs[a->rd], cpu_regs[a->rs2], a->imm);
@@ -1313,14 +1343,14 @@ static bool trans_SHLL_irr(DisasContext *ctx, arg_SHLL_irr *a)
 static bool trans_SHLL_rr(DisasContext *ctx, arg_SHLL_rr *a)
 {
     TCGLabel *noshift, *done;
-    TCGv_i32 count, tmp;
+    TCGv count, tmp;
 
     noshift = gen_new_label();
     done = gen_new_label();
     /* if (cpu_regs[a->rs]) { */
     tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_regs[a->rs], 0, noshift);
-    count = tcg_temp_new_i32();
-    tmp = tcg_temp_new_i32();
+    count = tcg_temp_new();
+    tmp = tcg_temp_new();
     tcg_gen_andi_i32(tmp, cpu_regs[a->rs], 31);
     tcg_gen_sub_i32(count, tcg_constant_i32(32), tmp);
     tcg_gen_sar_i32(cpu_psw_c, cpu_regs[a->rd], count);
@@ -1341,10 +1371,10 @@ static bool trans_SHLL_rr(DisasContext *ctx, arg_SHLL_rr *a)
     return true;
 }
 
-static void shiftr_imm(uint32_t rd, uint32_t rs, uint32_t imm,
-                       unsigned int alith)
+static inline void shiftr_imm(uint32_t rd, uint32_t rs, uint32_t imm,
+                              unsigned int alith)
 {
-    static void (* const gen_sXri[])(TCGv_i32 ret, TCGv_i32 arg1, int arg2) = {
+    static void (* const gen_sXri[])(TCGv ret, TCGv arg1, int arg2) = {
         tcg_gen_shri_i32, tcg_gen_sari_i32,
     };
     tcg_debug_assert(alith < 2);
@@ -1361,21 +1391,20 @@ static void shiftr_imm(uint32_t rd, uint32_t rs, uint32_t imm,
     tcg_gen_mov_i32(cpu_psw_s, cpu_regs[rd]);
 }
 
-static void shiftr_reg(uint32_t rd, uint32_t rs, unsigned int alith)
+static inline void shiftr_reg(uint32_t rd, uint32_t rs, unsigned int alith)
 {
     TCGLabel *noshift, *done;
-    TCGv_i32 count;
-    static void (* const gen_sXri[])(TCGv_i32 ret, TCGv_i32 arg1, int arg2) = {
+    TCGv count;
+    static void (* const gen_sXri[])(TCGv ret, TCGv arg1, int arg2) = {
         tcg_gen_shri_i32, tcg_gen_sari_i32,
     };
-    static void (* const gen_sXr[])(TCGv_i32 ret,
-                                    TCGv_i32 arg1, TCGv_i32 arg2) = {
+    static void (* const gen_sXr[])(TCGv ret, TCGv arg1, TCGv arg2) = {
         tcg_gen_shr_i32, tcg_gen_sar_i32,
     };
     tcg_debug_assert(alith < 2);
     noshift = gen_new_label();
     done = gen_new_label();
-    count = tcg_temp_new_i32();
+    count = tcg_temp_new();
     /* if (cpu_regs[rs]) { */
     tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_regs[rs], 0, noshift);
     tcg_gen_andi_i32(count, cpu_regs[rs], 31);
@@ -1427,8 +1456,8 @@ static bool trans_SHLR_rr(DisasContext *ctx, arg_SHLR_rr *a)
 /* rolc rd */
 static bool trans_ROLC(DisasContext *ctx, arg_ROLC *a)
 {
-    TCGv_i32 tmp;
-    tmp = tcg_temp_new_i32();
+    TCGv tmp;
+    tmp = tcg_temp_new();
     tcg_gen_shri_i32(tmp, cpu_regs[a->rd], 31);
     tcg_gen_shli_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1);
     tcg_gen_or_i32(cpu_regs[a->rd], cpu_regs[a->rd], cpu_psw_c);
@@ -1441,8 +1470,8 @@ static bool trans_ROLC(DisasContext *ctx, arg_ROLC *a)
 /* rorc rd */
 static bool trans_RORC(DisasContext *ctx, arg_RORC *a)
 {
-    TCGv_i32 tmp;
-    tmp = tcg_temp_new_i32();
+    TCGv tmp;
+    tmp = tcg_temp_new();
     tcg_gen_andi_i32(tmp, cpu_regs[a->rd], 0x00000001);
     tcg_gen_shri_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1);
     tcg_gen_shli_i32(cpu_psw_c, cpu_psw_c, 31);
@@ -1455,7 +1484,7 @@ static bool trans_RORC(DisasContext *ctx, arg_RORC *a)
 
 enum {ROTR = 0, ROTL = 1};
 enum {ROT_IMM = 0, ROT_REG = 1};
-static void rx_rot(int ir, int dir, int rd, int src)
+static inline void rx_rot(int ir, int dir, int rd, int src)
 {
     switch (dir) {
     case ROTL:
@@ -1517,8 +1546,8 @@ static bool trans_REVL(DisasContext *ctx, arg_REVL *a)
 /* revw rs, rd */
 static bool trans_REVW(DisasContext *ctx, arg_REVW *a)
 {
-    TCGv_i32 tmp;
-    tmp = tcg_temp_new_i32();
+    TCGv tmp;
+    tmp = tcg_temp_new();
     tcg_gen_andi_i32(tmp, cpu_regs[a->rs], 0x00ff00ff);
     tcg_gen_shli_i32(tmp, tmp, 8);
     tcg_gen_shri_i32(cpu_regs[a->rd], cpu_regs[a->rs], 8);
@@ -1535,7 +1564,7 @@ static void rx_bcnd_main(DisasContext *ctx, int cd, int dst)
 
     switch (cd) {
     case 0 ... 13:
-        dc.temp = tcg_temp_new_i32();
+        dc.temp = tcg_temp_new();
         psw_cond(&dc, cd);
         t = gen_new_label();
         done = gen_new_label();
@@ -1590,10 +1619,10 @@ static bool trans_BRA_l(DisasContext *ctx, arg_BRA_l *a)
     return true;
 }
 
-static void rx_save_pc(DisasContext *ctx)
+static inline void rx_save_pc(DisasContext *ctx)
 {
-    TCGv_i32 pc = tcg_constant_i32(ctx->base.pc_next);
-    push(ctx, pc);
+    TCGv pc = tcg_constant_i32(ctx->base.pc_next);
+    push(pc);
 }
 
 /* jmp rs */
@@ -1634,7 +1663,7 @@ static bool trans_BSR_l(DisasContext *ctx, arg_BSR_l *a)
 /* rts */
 static bool trans_RTS(DisasContext *ctx, arg_RTS *a)
 {
-    pop(ctx, cpu_pc);
+    pop(cpu_pc);
     ctx->base.is_jmp = DISAS_JUMP;
     return true;
 }
@@ -1675,7 +1704,7 @@ static bool trans_SMOVB(DisasContext *ctx, arg_SMOVB *a)
 
 #define STRING(op)                              \
     do {                                        \
-        TCGv_i32 size = tcg_constant_i32(a->sz);    \
+        TCGv size = tcg_constant_i32(a->sz);    \
         gen_helper_##op(tcg_env, size);         \
     } while (0)
 
@@ -1803,10 +1832,80 @@ static bool trans_MVTACLO(DisasContext *ctx, arg_MVTACLO *a)
     return true;
 }
 
+/* RXv2 accumulator moves used by interrupt context save/restore. */
+static bool rx_acc_move(DisasContext *ctx, int reg, int acc,
+                        int part, bool write)
+{
+    TCGv_i64 value;
+    int offset;
+
+    if (!require_isa(ctx, RX_ISA_V2)) {
+        return false;
+    }
+    if (part == 2) {
+        offset = offsetof(CPURXState, acc_guard) + acc * sizeof(uint32_t);
+        if (write) {
+            TCGv_i32 guard = tcg_temp_new_i32();
+            tcg_gen_ext8s_i32(guard, cpu_regs[reg]);
+            tcg_gen_st_i32(guard, tcg_env, offset);
+        } else {
+            tcg_gen_ld_i32(cpu_regs[reg], tcg_env, offset);
+        }
+        return true;
+    }
+    value = acc ? tcg_temp_new_i64() : cpu_acc;
+    if (acc) {
+        tcg_gen_ld_i64(value, tcg_env, offsetof(CPURXState, acc1));
+    }
+    if (write) {
+        TCGv_i64 src = tcg_temp_new_i64();
+        tcg_gen_extu_i32_i64(src, cpu_regs[reg]);
+        tcg_gen_deposit_i64(value, value, src, part * 32, 32);
+        if (acc) {
+            tcg_gen_st_i64(value, tcg_env, offsetof(CPURXState, acc1));
+        }
+    } else if (part) {
+        tcg_gen_extrh_i64_i32(cpu_regs[reg], value);
+    } else {
+        tcg_gen_extrl_i64_i32(cpu_regs[reg], value);
+    }
+    return true;
+}
+
+static bool trans_MVTACHI_A1(DisasContext *ctx, arg_MVTACHI_A1 *a)
+{
+    return rx_acc_move(ctx, a->r, 1, 1, true);
+}
+
+static bool trans_MVTACLO_A1(DisasContext *ctx, arg_MVTACLO_A1 *a)
+{
+    return rx_acc_move(ctx, a->r, 1, 0, true);
+}
+
+static bool trans_MVTACGU(DisasContext *ctx, arg_MVTACGU *a)
+{
+    return rx_acc_move(ctx, a->r, a->a, 2, true);
+}
+
+static bool trans_MVFACHI_A1(DisasContext *ctx, arg_MVFACHI_A1 *a)
+{
+    return rx_acc_move(ctx, a->r, 1, 1, false);
+}
+
+static bool trans_MVFACLO(DisasContext *ctx, arg_MVFACLO *a)
+{
+    return rx_acc_move(ctx, a->r, a->a, 0, false);
+}
+
+static bool trans_MVFACGU(DisasContext *ctx, arg_MVFACGU *a)
+{
+    return rx_acc_move(ctx, a->r, a->a, 2, false);
+}
+
 /* racw #imm */
 static bool trans_RACW(DisasContext *ctx, arg_RACW *a)
 {
-    TCGv_i32 imm = tcg_constant_i32(a->imm + 1);
+    TCGv imm = tcg_constant_i32(a->imm + 1);
     gen_helper_racw(tcg_env, imm);
     return true;
 }
@@ -1814,8 +1913,8 @@ static bool trans_RACW(DisasContext *ctx, arg_RACW *a)
 /* sat rd */
 static bool trans_SAT(DisasContext *ctx, arg_SAT *a)
 {
-    TCGv_i32 tmp, z;
-    tmp = tcg_temp_new_i32();
+    TCGv tmp, z;
+    tmp = tcg_temp_new();
     z = tcg_constant_i32(0);
     /* S == 1 -> 0xffffffff / S == 0 -> 0x00000000 */
     tcg_gen_sari_i32(tmp, cpu_psw_s, 31);
@@ -1838,7 +1937,7 @@ static bool trans_SATR(DisasContext *ctx, arg_SATR *a)
     static bool cat3(trans_, name, _ir)(DisasContext *ctx,              \
                                         cat3(arg_, name, _ir) * a)      \
     {                                                                   \
-        TCGv_i32 imm = tcg_constant_i32(li(ctx, 0));                    \
+        TCGv imm = tcg_constant_i32(li(ctx, 0));                        \
         gen_helper_##op(cpu_regs[a->rd], tcg_env,                       \
                         cpu_regs[a->rd], imm);                          \
         return true;                                                    \
@@ -1846,19 +1945,22 @@ static bool trans_SATR(DisasContext *ctx, arg_SATR *a)
     static bool cat3(trans_, name, _mr)(DisasContext *ctx,              \
                                         cat3(arg_, name, _mr) * a)      \
     {                                                                   \
-        TCGv_i32 val, mem;                                              \
-        mem = tcg_temp_new_i32();                                       \
+        TCGv val, mem;                                                  \
+        mem = tcg_temp_new();                                           \
         val = rx_load_source(ctx, mem, a->ld, MO_32, a->rs);            \
         gen_helper_##op(cpu_regs[a->rd], tcg_env,                       \
                         cpu_regs[a->rd], val);                          \
         return true;                                                    \
     }
 
-#define FCONVOP(name, op)                                       \
+#define FCONVOP(name, op, isa)                                  \
     static bool trans_##name(DisasContext *ctx, arg_##name * a) \
     {                                                           \
-        TCGv_i32 val, mem;                                      \
-        mem = tcg_temp_new_i32();                               \
+        TCGv val, mem;                                          \
+        if (!require_isa(ctx, isa)) {                           \
+            return false;                                       \
+        }                                                       \
+        mem = tcg_temp_new();                                   \
         val = rx_load_source(ctx, mem, a->ld, MO_32, a->rs);    \
         gen_helper_##op(cpu_regs[a->rd], tcg_env, val);         \
         return true;                                            \
@@ -1872,7 +1974,7 @@ FOP(FDIV, fdiv)
 /* fcmp #imm, rd */
 static bool trans_FCMP_ir(DisasContext *ctx, arg_FCMP_ir * a)
 {
-    TCGv_i32 imm = tcg_constant_i32(li(ctx, 0));
+    TCGv imm = tcg_constant_i32(li(ctx, 0));
     gen_helper_fcmp(tcg_env, cpu_regs[a->rd], imm);
     return true;
 }
@@ -1881,84 +1983,702 @@ static bool trans_FCMP_ir(DisasContext *ctx, arg_FCMP_ir * a)
 /* fcmp rs, rd */
 static bool trans_FCMP_mr(DisasContext *ctx, arg_FCMP_mr *a)
 {
-    TCGv_i32 val, mem;
-    mem = tcg_temp_new_i32();
+    TCGv val, mem;
+    mem = tcg_temp_new();
     val = rx_load_source(ctx, mem, a->ld, MO_32, a->rs);
     gen_helper_fcmp(tcg_env, cpu_regs[a->rd], val);
     return true;
 }
 
-FCONVOP(FTOI, ftoi)
-FCONVOP(ROUND, round)
+FCONVOP(FTOI, ftoi, RX_ISA_V1)
+FCONVOP(FTOU, ftou, RX_ISA_V2)
+FCONVOP(ROUND, round, RX_ISA_V1)
 
 /* itof rs, rd */
 /* itof dsp[rs], rd */
 static bool trans_ITOF(DisasContext *ctx, arg_ITOF * a)
 {
-    TCGv_i32 val, mem;
-    mem = tcg_temp_new_i32();
+    TCGv val, mem;
+    mem = tcg_temp_new();
     val = rx_load_source(ctx, mem, a->ld, a->mi, a->rs);
     gen_helper_itof(cpu_regs[a->rd], tcg_env, val);
     return true;
 }
 
-static void rx_bsetm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
+/* utof dsp[rs], rd  (RXv2) */
+static bool trans_UTOF(DisasContext *ctx, arg_UTOF * a)
+{
+    TCGv val, mem;
+    if (!require_isa(ctx, RX_ISA_V2)) {
+        return false;
+    }
+    mem = tcg_temp_new();
+    val = rx_load_source(ctx, mem, a->ld, a->mi, a->rs);
+    gen_helper_utof(cpu_regs[a->rd], tcg_env, val);
+    return true;
+}
+
+/*
+ * RXv3 DPFPU register access. DR0-DR15 are dedicated 64-bit registers,
+ * architecturally distinct from the general purpose registers; DRHn and
+ * DRLn name the high and low 32-bit halves of DRn.
+ */
+static TCGv_i64 dr_read(int n)
+{
+    return cpu_dregs[n];
+}
+
+static void dr_write(int n, TCGv_i64 val)
+{
+    tcg_gen_mov_i64(cpu_dregs[n], val);
+}
+
+/* Write val into the high or low 32-bit half of DRn, preserving the other. */
+static void drh_write(int n, TCGv val)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(t, val);
+    tcg_gen_deposit_i64(cpu_dregs[n], cpu_dregs[n], t, 32, 32);
+}
+
+static void drl_write(int n, TCGv val)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(t, val);
+    tcg_gen_deposit_i64(cpu_dregs[n], cpu_dregs[n], t, 0, 32);
+}
+
+/* dadd DRdrs1, DRdrd, DRdrs2  (DRdrd = DRdrs1 + DRdrs2) */
+static bool trans_DADD(DisasContext *ctx, arg_DADD *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 s1 = dr_read(a->drs1);
+    TCGv_i64 s2 = dr_read(a->drs2);
+    TCGv_i64 d  = tcg_temp_new_i64();
+    gen_helper_dadd(d, tcg_env, s1, s2);
+    dr_write(a->drd, d);
+    return true;
+}
+
+static bool trans_DSUB(DisasContext *ctx, arg_DSUB *a)
 {
-    TCGv_i32 val;
-    val = tcg_temp_new_i32();
-    rx_gen_ld(ctx, MO_8, val, mem);
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 s1 = dr_read(a->drs1);
+    TCGv_i64 s2 = dr_read(a->drs2);
+    TCGv_i64 d  = tcg_temp_new_i64();
+    gen_helper_dsub(d, tcg_env, s1, s2);
+    dr_write(a->drd, d);
+    return true;
+}
+
+static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 s1 = dr_read(a->drs1);
+    TCGv_i64 s2 = dr_read(a->drs2);
+    TCGv_i64 d  = tcg_temp_new_i64();
+    gen_helper_dmul(d, tcg_env, s1, s2);
+    dr_write(a->drd, d);
+    return true;
+}
+
+static bool trans_DDIV(DisasContext *ctx, arg_DDIV *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 s1 = dr_read(a->drs1);
+    TCGv_i64 s2 = dr_read(a->drs2);
+    TCGv_i64 d  = tcg_temp_new_i64();
+    gen_helper_ddiv(d, tcg_env, s1, s2);
+    dr_write(a->drd, d);
+    return true;
+}
+
+static bool trans_DCMP(DisasContext *ctx, arg_DCMP *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    gen_helper_dcmp(tcg_env, tcg_constant_i32(a->cd),
+                    cpu_dregs[a->drs1], cpu_dregs[a->drs2]);
+    return true;
+}
+
+static bool trans_DMOV(DisasContext *ctx, arg_DMOV *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 s = dr_read(a->drs);
+    dr_write(a->drd, s);
+    return true;
+}
+
+static bool trans_DABS(DisasContext *ctx, arg_DABS *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 s = dr_read(a->drs);
+    TCGv_i64 d = tcg_temp_new_i64();
+    gen_helper_dabs(d, tcg_env, s);
+    dr_write(a->drd, d);
+    return true;
+}
+
+static bool trans_DNEG(DisasContext *ctx, arg_DNEG *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 s = dr_read(a->drs);
+    TCGv_i64 d = tcg_temp_new_i64();
+    gen_helper_dneg(d, tcg_env, s);
+    dr_write(a->drd, d);
+    return true;
+}
+
+static bool trans_DSQRT(DisasContext *ctx, arg_DSQRT *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 s = dr_read(a->drs);
+    TCGv_i64 d = tcg_temp_new_i64();
+    gen_helper_dsqrt(d, tcg_env, s);
+    dr_write(a->drd, d);
+    return true;
+}
+
+static bool trans_DROUND(DisasContext *ctx, arg_DROUND *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 s = dr_read(a->drs);
+    TCGv_i64 d = tcg_temp_new_i64();
+    gen_helper_dround(d, tcg_env, s);
+    dr_write(a->drd, d);
+    return true;
+}
+
+/*
+ * dtoi / dtou / dtof convert within the DPFPU: the 32-bit result is written
+ * to the low half of the destination DR register, from where DMOV.L moves it
+ * out to a GPR. The high half is cleared.
+ */
+static void dr_write_low32(int n, TCGv val)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(t, val);
+    tcg_gen_mov_i64(cpu_dregs[n], t);
+}
+
+/* dtoi DRdrs, DRdrd -- convert double to signed int32 */
+static bool trans_DTOI(DisasContext *ctx, arg_DTOI *a)
+{
+    TCGv res;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    res = tcg_temp_new();
+    gen_helper_dtoi(res, tcg_env, dr_read(a->drs));
+    dr_write_low32(a->drd, res);
+    return true;
+}
+
+/* dtou DRdrs, DRdrd -- convert double to unsigned int32 */
+static bool trans_DTOU(DisasContext *ctx, arg_DTOU *a)
+{
+    TCGv res;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    res = tcg_temp_new();
+    gen_helper_dtou(res, tcg_env, dr_read(a->drs));
+    dr_write_low32(a->drd, res);
+    return true;
+}
+
+/* dtof DRdrs, DRdrd -- convert double to float32 */
+static bool trans_DTOF(DisasContext *ctx, arg_DTOF *a)
+{
+    TCGv res;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    res = tcg_temp_new();
+    gen_helper_dtof(res, tcg_env, dr_read(a->drs));
+    dr_write_low32(a->drd, res);
+    return true;
+}
+
+/* itod rs, DRdrd -- convert signed int32 to double */
+static bool trans_ITOD(DisasContext *ctx, arg_ITOD *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 d = tcg_temp_new_i64();
+    gen_helper_itod(d, tcg_env, cpu_regs[a->rs]);
+    dr_write(a->drd, d);
+    return true;
+}
+
+/* utod rs, DRdrd -- convert unsigned int32 to double */
+static bool trans_UTOD(DisasContext *ctx, arg_UTOD *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 d = tcg_temp_new_i64();
+    gen_helper_utod(d, tcg_env, cpu_regs[a->rs]);
+    dr_write(a->drd, d);
+    return true;
+}
+
+/* ftod rs, DRdrd -- convert float32 to double */
+static bool trans_FTOD(DisasContext *ctx, arg_FTOD *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    TCGv_i64 d = tcg_temp_new_i64();
+    gen_helper_ftod(d, tcg_env, cpu_regs[a->rs]);
+    dr_write(a->drd, d);
+    return true;
+}
+
+/*
+ * dpushm.d DRn-DRm / dpopm.d DRn-DRm.
+ * The encoded rnum field holds (last - first), so the range covers
+ * rnum + 1 registers. Pushes run from the highest register down so that
+ * the lowest-numbered register ends up at the lowest address.
+ */
+static bool trans_DPUSHM(DisasContext *ctx, arg_DPUSHM *a)
+{
+    int i;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    for (i = a->drd + a->rnum; i >= a->drd; i--) {
+        TCGv_i32 hi = tcg_temp_new_i32();
+        TCGv_i32 lo = tcg_temp_new_i32();
+        tcg_gen_extr_i64_i32(lo, hi, cpu_dregs[i & (NUM_DREGS - 1)]);
+        tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
+        rx_gen_st(MO_32, hi, cpu_sp);
+        tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
+        rx_gen_st(MO_32, lo, cpu_sp);
+    }
+    return true;
+}
+
+static bool trans_DPOPM(DisasContext *ctx, arg_DPOPM *a)
+{
+    int i;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    for (i = a->drd; i <= a->drd + a->rnum; i++) {
+        TCGv_i64 dr = tcg_temp_new_i64();
+        TCGv_i32 hi = tcg_temp_new_i32();
+        TCGv_i32 lo = tcg_temp_new_i32();
+        rx_gen_ld(MO_32, lo, cpu_sp);
+        tcg_gen_addi_i32(cpu_sp, cpu_sp, 4);
+        rx_gen_ld(MO_32, hi, cpu_sp);
+        tcg_gen_addi_i32(cpu_sp, cpu_sp, 4);
+        tcg_gen_concat_i32_i64(dr, lo, hi);
+        tcg_gen_mov_i64(cpu_dregs[i & (NUM_DREGS - 1)], dr);
+    }
+    return true;
+}
+
+/* dpushm.l DCRn-DCRm / dpopm.l DCRn-DCRm (DPFPU control registers) */
+static bool trans_DPUSHM_l(DisasContext *ctx, arg_DPUSHM_l *a)
+{
+    int i;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    for (i = a->dcrd + a->rnum; i >= a->dcrd; i--) {
+        tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
+        rx_gen_st(MO_32, cpu_dcregs[i & (NUM_DCREGS - 1)], cpu_sp);
+    }
+    return true;
+}
+
+static bool trans_DPOPM_l(DisasContext *ctx, arg_DPOPM_l *a)
+{
+    int i;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    for (i = a->dcrd; i <= a->dcrd + a->rnum; i++) {
+        rx_gen_ld(MO_32, cpu_dcregs[i & (NUM_DCREGS - 1)], cpu_sp);
+        tcg_gen_addi_i32(cpu_sp, cpu_sp, 4);
+    }
+    return true;
+}
+
+/* dmov.l rs, DRLd  -- write the low half of DRd, preserving the high half */
+static bool trans_DMOV_rdrl(DisasContext *ctx, arg_DMOV_rdrl *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    drl_write(a->drd, cpu_regs[a->rs]);
+    return true;
+}
+
+/* dmov.l rs, DRHd -- write the high half of DRd, preserving the low half */
+static bool trans_DMOV_rdrh(DisasContext *ctx, arg_DMOV_rdrh *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    drh_write(a->drd, cpu_regs[a->rs]);
+    return true;
+}
+
+/*
+ * dmov.d rs, DRHd -- write the high half of DRd and clear the low half.
+ * This is the single-instruction way to materialise a double whose low
+ * word is zero, which covers the common literals (1.0, 0.5, 2.0, ...).
+ */
+static bool trans_DMOVD_rdrh(DisasContext *ctx, arg_DMOVD_rdrh *a)
+{
+    TCGv_i64 t;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    t = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(t, cpu_regs[a->rs]);
+    tcg_gen_shli_i64(cpu_dregs[a->drd], t, 32);
+    return true;
+}
+
+/* dmov.l DRLs, rd */
+static bool trans_DMOV_drlr(DisasContext *ctx, arg_DMOV_drlr *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    tcg_gen_extrl_i64_i32(cpu_regs[a->rd], cpu_dregs[a->drs]);
+    return true;
+}
+
+/* dmov.l DRHs, rd */
+static bool trans_DMOV_drhr(DisasContext *ctx, arg_DMOV_drhr *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    tcg_gen_extrh_i64_i32(cpu_regs[a->rd], cpu_dregs[a->drs]);
+    return true;
+}
+
+/* dmov.l #imm32, DRLd */
+static bool trans_DMOVL_irl(DisasContext *ctx, arg_DMOVL_irl *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    drl_write(a->drd, tcg_constant_i32(li(ctx, 0)));
+    return true;
+}
+
+/* dmov.l #imm32, DRHd */
+static bool trans_DMOVL_irh(DisasContext *ctx, arg_DMOVL_irh *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    drh_write(a->drd, tcg_constant_i32(li(ctx, 0)));
+    return true;
+}
+
+/* dmov.d #imm32, DRHd -- set the high half, clear the low half */
+static bool trans_DMOVD_irh(DisasContext *ctx, arg_DMOVD_irh *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    tcg_gen_movi_i64(cpu_dregs[a->drd], (uint64_t)li(ctx, 0) << 32);
+    return true;
+}
+
+/*
+ * The DMOV.D memory forms name their DR operand in a post-byte that follows
+ * the displacement, so it can only be read once rx_index_addr() has consumed
+ * the displacement bytes.
+ *
+ * Per the RXv3 ISA manual the .D displacement is scaled by 4, not by the
+ * 8-byte transfer size: dsp:8 reaches 1020 (255 * 4) and dsp:16 reaches
+ * 262140 (65535 * 4). Note that binutils gas disagrees, scaling by 8 and
+ * requiring 8-byte alignment; the manual is taken as authoritative here.
+ */
+#define DMOV_DSP_SHIFT 2
+static int dmov_postbyte_dr(DisasContext *ctx)
+{
+    uint8_t b = translator_ldub(ctx->env, &ctx->base, ctx->base.pc_next);
+    ctx->base.pc_next += 1;
+    return b >> 4;
+}
+
+/* dmov.d DRs, dsp[rd] */
+static bool trans_DMOV_mst(DisasContext *ctx, arg_DMOV_mst *a)
+{
+    TCGv mem, addr;
+    int drs;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    mem = tcg_temp_new();
+    addr = rx_index_addr(ctx, mem, a->ld, DMOV_DSP_SHIFT, a->rd);
+    drs = dmov_postbyte_dr(ctx);
+    tcg_gen_qemu_st_i64(cpu_dregs[drs], addr, 0, MO_LEUQ);
+    return true;
+}
+
+/* dmov.d dsp[rs], DRd */
+static bool trans_DMOV_mld(DisasContext *ctx, arg_DMOV_mld *a)
+{
+    TCGv mem, addr;
+    int drd;
+
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    mem = tcg_temp_new();
+    addr = rx_index_addr(ctx, mem, a->ld, DMOV_DSP_SHIFT, a->rs);
+    drd = dmov_postbyte_dr(ctx);
+    tcg_gen_qemu_ld_i64(cpu_dregs[drd], addr, 0, MO_LEUQ);
+    return true;
+}
+
+/* mvfdc DCRs, rd */
+static bool trans_MVFDC(DisasContext *ctx, arg_MVFDC *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    tcg_gen_mov_i32(cpu_regs[a->rd], cpu_dcregs[a->dcrs]);
+    return true;
+}
+
+/* mvtdc rs, DCRd -- see helper_mvtdc for the per-register write rules */
+static bool trans_MVTDC(DisasContext *ctx, arg_MVTDC *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    gen_helper_mvtdc(tcg_env, tcg_constant_i32(a->dcrd), cpu_regs[a->rs]);
+    return true;
+}
+
+/*
+ * mvfdr -- Z = DCMR.RES. Moves the result of the last DCMP into the PSW Z
+ * flag so it can be branched on; no other flag and no DPSW bit changes.
+ *
+ * psw_z holds the inverse of the architectural Z flag (Z is set when psw_z
+ * reads zero), so the RES bit is inverted on the way in.
+ */
+static bool trans_MVFDR(DisasContext *ctx, arg_MVFDR *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    tcg_gen_extract_i32(cpu_psw_z, cpu_dcregs[RX_DCR_DCMR],
+                        RX_DCMR_RES_BIT, 1);
+    tcg_gen_xori_i32(cpu_psw_z, cpu_psw_z, 1);
+    return true;
+}
+
+/*
+ * bfmov / bfmovz. The 16-bit field descriptor that follows the opcode packs
+ *   bits  4:0  (dlsb - slsb), as a signed 5-bit value
+ *   bits  9:5  dlsb
+ *   bits 14:10 dlsb + width
+ * BFMOV leaves the bits outside the destination field untouched; BFMOVZ
+ * clears them.
+ */
+static bool bfmov_common(DisasContext *ctx, int rd, int rs, bool zero)
+{
+    unsigned bf, dlsb, msb, width;
+    int delta, slsb;
+    TCGv tmp;
+
+    bf = translator_lduw_end(ctx->env, &ctx->base, ctx->base.pc_next, MO_LE);
+    ctx->base.pc_next += 2;
+
+    dlsb = (bf >> 5) & 0x1f;
+    msb = (bf >> 10) & 0x1f;
+    delta = bf & 0x1f;
+    if (delta >= 0x10) {
+        delta -= 0x20;
+    }
+    slsb = dlsb - delta;
+
+    if (msb <= dlsb || slsb < 0 || slsb > 31) {
+        /* Empty or out-of-range field: architecturally undefined. */
+        return false;
+    }
+    width = msb - dlsb;
+    if (slsb + width > 32) {
+        width = 32 - slsb;
+    }
+
+    tmp = tcg_temp_new();
+    tcg_gen_extract_i32(tmp, cpu_regs[rs], slsb, width);
+    if (zero) {
+        tcg_gen_shli_i32(cpu_regs[rd], tmp, dlsb);
+    } else {
+        tcg_gen_deposit_i32(cpu_regs[rd], cpu_regs[rd], tmp, dlsb, width);
+    }
+    return true;
+}
+
+static bool trans_BFMOV(DisasContext *ctx, arg_BFMOV *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    return bfmov_common(ctx, a->rd, a->rs, false);
+}
+
+static bool trans_BFMOVZ(DisasContext *ctx, arg_BFMOVZ *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    return bfmov_common(ctx, a->rd, a->rs, true);
+}
+
+/*
+ * save / rstr -- the RXv3 register bank save function. A bank holds R1-R15,
+ * the USP, the FPSW and the accumulator; the banks are internal CPU state
+ * that nothing but these two instructions can reach, so no memory traffic
+ * is involved.
+ */
+static bool trans_SAVE_i(DisasContext *ctx, arg_SAVE_i *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    gen_helper_save(tcg_env, tcg_constant_i32(a->imm));
+    return true;
+}
+
+static bool trans_SAVE_r(DisasContext *ctx, arg_SAVE_r *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    gen_helper_save(tcg_env, cpu_regs[a->rs]);
+    return true;
+}
+
+static bool trans_RSTR_i(DisasContext *ctx, arg_RSTR_i *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    gen_helper_rstr(tcg_env, tcg_constant_i32(a->imm));
+    return true;
+}
+
+static bool trans_RSTR_r(DisasContext *ctx, arg_RSTR_r *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    gen_helper_rstr(tcg_env, cpu_regs[a->rs]);
+    return true;
+}
+
+/* xor rs, rs2, rd */
+static bool trans_XOR_rrr(DisasContext *ctx, arg_XOR_rrr *a)
+{
+    if (!require_isa(ctx, RX_ISA_V3)) {
+        return false;
+    }
+    rx_gen_op_rrr(rx_xor, a->rd, a->rs, a->rs2);
+    return true;
+}
+
+static void rx_bsetm(TCGv mem, TCGv mask)
+{
+    TCGv val;
+    val = tcg_temp_new();
+    rx_gen_ld(MO_8, val, mem);
     tcg_gen_or_i32(val, val, mask);
-    rx_gen_st(ctx, MO_8, val, mem);
+    rx_gen_st(MO_8, val, mem);
 }
 
-static void rx_bclrm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
+static void rx_bclrm(TCGv mem, TCGv mask)
 {
-    TCGv_i32 val;
-    val = tcg_temp_new_i32();
-    rx_gen_ld(ctx, MO_8, val, mem);
+    TCGv val;
+    val = tcg_temp_new();
+    rx_gen_ld(MO_8, val, mem);
     tcg_gen_andc_i32(val, val, mask);
-    rx_gen_st(ctx, MO_8, val, mem);
+    rx_gen_st(MO_8, val, mem);
 }
 
-static void rx_btstm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
+static void rx_btstm(TCGv mem, TCGv mask)
 {
-    TCGv_i32 val;
-    val = tcg_temp_new_i32();
-    rx_gen_ld(ctx, MO_8, val, mem);
+    TCGv val;
+    val = tcg_temp_new();
+    rx_gen_ld(MO_8, val, mem);
     tcg_gen_and_i32(val, val, mask);
     tcg_gen_setcondi_i32(TCG_COND_NE, cpu_psw_c, val, 0);
     tcg_gen_mov_i32(cpu_psw_z, cpu_psw_c);
 }
 
-static void rx_bnotm(DisasContext *ctx, TCGv_i32 mem, TCGv_i32 mask)
+static void rx_bnotm(TCGv mem, TCGv mask)
 {
-    TCGv_i32 val;
-    val = tcg_temp_new_i32();
-    rx_gen_ld(ctx, MO_8, val, mem);
+    TCGv val;
+    val = tcg_temp_new();
+    rx_gen_ld(MO_8, val, mem);
     tcg_gen_xor_i32(val, val, mask);
-    rx_gen_st(ctx, MO_8, val, mem);
+    rx_gen_st(MO_8, val, mem);
 }
 
-static void rx_bsetr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
+static void rx_bsetr(TCGv reg, TCGv mask)
 {
     tcg_gen_or_i32(reg, reg, mask);
 }
 
-static void rx_bclrr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
+static void rx_bclrr(TCGv reg, TCGv mask)
 {
     tcg_gen_andc_i32(reg, reg, mask);
 }
 
-static void rx_btstr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
+static inline void rx_btstr(TCGv reg, TCGv mask)
 {
-    TCGv_i32 t0;
-    t0 = tcg_temp_new_i32();
+    TCGv t0;
+    t0 = tcg_temp_new();
     tcg_gen_and_i32(t0, reg, mask);
     tcg_gen_setcondi_i32(TCG_COND_NE, cpu_psw_c, t0, 0);
     tcg_gen_mov_i32(cpu_psw_z, cpu_psw_c);
 }
 
-static void rx_bnotr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
+static inline void rx_bnotr(TCGv reg, TCGv mask)
 {
     tcg_gen_xor_i32(reg, reg, mask);
 }
@@ -1967,43 +2687,43 @@ static void rx_bnotr(DisasContext *ctx, TCGv_i32 reg, TCGv_i32 mask)
     static bool cat3(trans_, name, _im)(DisasContext *ctx,              \
                                         cat3(arg_, name, _im) * a)      \
     {                                                                   \
-        TCGv_i32 mask, mem, addr;                                       \
-        mem = tcg_temp_new_i32();                                       \
+        TCGv mask, mem, addr;                                           \
+        mem = tcg_temp_new();                                           \
         mask = tcg_constant_i32(1 << a->imm);                           \
         addr = rx_index_addr(ctx, mem, a->ld, MO_8, a->rs);             \
-        cat3(rx_, op, m)(ctx, addr, mask);                              \
+        cat3(rx_, op, m)(addr, mask);                                   \
         return true;                                                    \
     }                                                                   \
     static bool cat3(trans_, name, _ir)(DisasContext *ctx,              \
                                         cat3(arg_, name, _ir) * a)      \
     {                                                                   \
-        TCGv_i32 mask;                                                  \
+        TCGv mask;                                                      \
         mask = tcg_constant_i32(1 << a->imm);                           \
-        cat3(rx_, op, r)(ctx, cpu_regs[a->rd], mask);                   \
+        cat3(rx_, op, r)(cpu_regs[a->rd], mask);                        \
         return true;                                                    \
     }                                                                   \
     static bool cat3(trans_, name, _rr)(DisasContext *ctx,              \
                                         cat3(arg_, name, _rr) * a)      \
     {                                                                   \
-        TCGv_i32 mask, b;                                               \
-        mask = tcg_temp_new_i32();                                      \
-        b = tcg_temp_new_i32();                                         \
+        TCGv mask, b;                                                   \
+        mask = tcg_temp_new();                                          \
+        b = tcg_temp_new();                                             \
         tcg_gen_andi_i32(b, cpu_regs[a->rs], 31);                       \
         tcg_gen_shl_i32(mask, tcg_constant_i32(1), b);                  \
-        cat3(rx_, op, r)(ctx, cpu_regs[a->rd], mask);                   \
+        cat3(rx_, op, r)(cpu_regs[a->rd], mask);                        \
         return true;                                                    \
     }                                                                   \
     static bool cat3(trans_, name, _rm)(DisasContext *ctx,              \
                                         cat3(arg_, name, _rm) * a)      \
     {                                                                   \
-        TCGv_i32 mask, mem, addr, b;                                    \
-        mask = tcg_temp_new_i32();                                      \
-        b = tcg_temp_new_i32();                                         \
+        TCGv mask, mem, addr, b;                                        \
+        mask = tcg_temp_new();                                          \
+        b = tcg_temp_new();                                             \
         tcg_gen_andi_i32(b, cpu_regs[a->rd], 7);                        \
         tcg_gen_shl_i32(mask, tcg_constant_i32(1), b);                  \
-        mem = tcg_temp_new_i32();                                       \
+        mem = tcg_temp_new();                                           \
         addr = rx_index_addr(ctx, mem, a->ld, MO_8, a->rs);             \
-        cat3(rx_, op, m)(ctx, addr, mask);                              \
+        cat3(rx_, op, m)(addr, mask);                                   \
         return true;                                                    \
     }
 
@@ -2012,12 +2732,12 @@ BITOP(BCLR, bclr)
 BITOP(BTST, btst)
 BITOP(BNOT, bnot)
 
-static void bmcnd_op(TCGv_i32 val, TCGCond cond, int pos)
+static inline void bmcnd_op(TCGv val, TCGCond cond, int pos)
 {
-    TCGv_i32 bit;
+    TCGv bit;
     DisasCompare dc;
-    dc.temp = tcg_temp_new_i32();
-    bit = tcg_temp_new_i32();
+    dc.temp = tcg_temp_new();
+    bit = tcg_temp_new();
     psw_cond(&dc, cond);
     tcg_gen_andi_i32(val, val, ~(1 << pos));
     tcg_gen_setcondi_i32(dc.cond, bit, dc.value, 0);
@@ -2027,13 +2747,13 @@ static void bmcnd_op(TCGv_i32 val, TCGCond cond, int pos)
 /* bmcnd #imm, dsp[rd] */
 static bool trans_BMCnd_im(DisasContext *ctx, arg_BMCnd_im *a)
 {
-    TCGv_i32 val, mem, addr;
-    val = tcg_temp_new_i32();
-    mem = tcg_temp_new_i32();
+    TCGv val, mem, addr;
+    val = tcg_temp_new();
+    mem = tcg_temp_new();
     addr = rx_index_addr(ctx, mem, a->ld, MO_8, a->rd);
-    rx_gen_ld(ctx, MO_8, val, addr);
+    rx_gen_ld(MO_8, val, addr);
     bmcnd_op(val, a->cd, a->imm);
-    rx_gen_st(ctx, MO_8, val, addr);
+    rx_gen_st(MO_8, val, addr);
     return true;
 }
 
@@ -2053,7 +2773,7 @@ enum {
     PSW_U = 9,
 };
 
-static void clrsetpsw(DisasContext *ctx, int cb, int val)
+static inline void clrsetpsw(DisasContext *ctx, int cb, int val)
 {
     if (cb < 8) {
         switch (cb) {
@@ -2121,7 +2841,7 @@ static bool trans_MVTIPL(DisasContext *ctx, arg_MVTIPL *a)
 /* mvtc #imm, rd */
 static bool trans_MVTC_i(DisasContext *ctx, arg_MVTC_i *a)
 {
-    TCGv_i32 imm;
+    TCGv imm;
 
     imm = tcg_constant_i32(a->imm);
     move_to_cr(ctx, imm, a->cr);
@@ -2145,9 +2865,9 @@ static bool trans_MVFC(DisasContext *ctx, arg_MVFC *a)
 /* rtfi */
 static bool trans_RTFI(DisasContext *ctx, arg_RTFI *a)
 {
-    TCGv_i32 psw;
+    TCGv psw;
     if (is_privileged(ctx, 1)) {
-        psw = tcg_temp_new_i32();
+        psw = tcg_temp_new();
         tcg_gen_mov_i32(cpu_pc, cpu_bpc);
         tcg_gen_mov_i32(psw, cpu_bpsw);
         gen_helper_set_psw_rte(tcg_env, psw);
@@ -2159,11 +2879,11 @@ static bool trans_RTFI(DisasContext *ctx, arg_RTFI *a)
 /* rte */
 static bool trans_RTE(DisasContext *ctx, arg_RTE *a)
 {
-    TCGv_i32 psw;
+    TCGv psw;
     if (is_privileged(ctx, 1)) {
-        psw = tcg_temp_new_i32();
-        pop(ctx, cpu_pc);
-        pop(ctx, psw);
+        psw = tcg_temp_new();
+        pop(cpu_pc);
+        pop(psw);
         gen_helper_set_psw_rte(tcg_env, psw);
         ctx->base.is_jmp = DISAS_EXIT;
     }
@@ -2182,7 +2902,7 @@ static bool trans_BRK(DisasContext *ctx, arg_BRK *a)
 /* int #imm */
 static bool trans_INT(DisasContext *ctx, arg_INT *a)
 {
-    TCGv_i32 vec;
+    TCGv vec;
 
     tcg_debug_assert(a->imm < 0x100);
     vec = tcg_constant_i32(a->imm);
@@ -2207,6 +2927,7 @@ static void rx_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     ctx->env = cpu_env(cs);
     ctx->tb_flags = ctx->base.tb->flags;
+    ctx->isa_version = RX_CPU_GET_CLASS(cs)->isa_version;
 }
 
 static void rx_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
@@ -2271,7 +2992,7 @@ void rx_translate_code(CPUState *cs, TranslationBlock *tb,
     DisasContext dc;
 
     translator_loop(cs, tb, max_insns, pc, host_pc, &rx_tr_ops, &dc.base,
-                    TCG_TYPE_VA);
+                    TCG_TYPE_I32);
 }
 
 #define ALLOC_REGISTER(sym, name) \
@@ -2307,6 +3028,22 @@ void rx_translate_init(void)
     ALLOC_REGISTER(isp, "ISP");
     ALLOC_REGISTER(fintv, "FINTV");
     ALLOC_REGISTER(intb, "INTB");
+    ALLOC_REGISTER(extb, "EXTB");
     cpu_acc = tcg_global_mem_new_i64(tcg_env,
                                      offsetof(CPURXState, acc), "ACC");
+
+    for (i = 0; i < NUM_DREGS; i++) {
+        g_autofree char *name = g_strdup_printf("DR%d", i);
+        cpu_dregs[i] = tcg_global_mem_new_i64(tcg_env,
+                                              offsetof(CPURXState, dr[i]),
+                                              name);
+    }
+    for (i = 0; i < NUM_DCREGS; i++) {
+        static const char * const dcrnames[NUM_DCREGS] = {
+            "DPSW", "DCMR", "DECNT", "DEPC"
+        };
+        cpu_dcregs[i] = tcg_global_mem_new_i32(tcg_env,
+                                               offsetof(CPURXState, dcr[i]),
+                                               dcrnames[i]);
+    }
 }

-- 
2.53.0


