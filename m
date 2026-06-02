Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B801BCD6E56
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 03:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUFNF-0005nf-Qy; Mon, 01 Jun 2026 23:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wUFNE-0005nW-6M
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 23:01:00 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wUFNA-0002Kz-QV
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 23:00:59 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxFelcRx5qrpUPAA--.37477S3;
 Tue, 02 Jun 2026 11:00:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCx_8JaRx5q8NqYAA--.27121S3;
 Tue, 02 Jun 2026 11:00:43 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v2 13/13] target/loongarch: Add new structure CPUSysState
Date: Tue,  2 Jun 2026 11:00:29 +0800
Message-Id: <20260602030029.1476299-14-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260602030029.1476299-1-maobibo@loongson.cn>
References: <20260602030029.1476299-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx_8JaRx5q8NqYAA--.27121S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

New structure CPUSysState is added here, it contains CSR registers
now, in future TLB and timer can be moved to this structure also.

It is only code movement, no function change.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c                        |   4 +-
 target/loongarch/cpu.h                        |  35 +++---
 target/loongarch/csr.c                        |   4 +-
 target/loongarch/csr.h                        |   2 +-
 target/loongarch/machine.c                    | 118 +++++++++---------
 .../tcg/insn_trans/trans_extra.c.inc          |   4 +-
 6 files changed, 86 insertions(+), 81 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index a8e51d977c..fb03424ffa 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -282,7 +282,7 @@ static void loongarch_la464_initfn(Object *obj)
     uint32_t data = 0, field;
     int i;
 
-    set_sys_state(env, env);
+    set_sys_state(env, &env->sys_states[0]);
     for (i = 0; i < 21; i++) {
         env->cpucfg[i] = 0x0;
     }
@@ -412,7 +412,7 @@ static void loongarch_la132_initfn(Object *obj)
     uint32_t data = 0;
     int i;
 
-    set_sys_state(env, env);
+    set_sys_state(env, &env->sys_states[0]);
     for (i = 0; i < 21; i++) {
         env->cpucfg[i] = 0x0;
     }
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 906470f59b..ad30c73167 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -317,23 +317,7 @@ typedef struct  LoongArchBT {
 #define CPU_VENDOR_LOONGSON   "Loongson"
 #define CPU_MODEL_3A5000      "3A5000"
 #define CPU_MODEL_1C101       "1C101"
-struct CPUArchState;
-typedef struct CPUArchState CPUSysState;
-
-typedef struct CPUArchState {
-    uint64_t gpr[32];
-    uint64_t pc;
-
-    fpr_t fpr[32];
-    bool cf[8];
-    uint32_t fcsr0;
-    lbt_t  lbt;
-
-    uint32_t cpucfg[21];
-    uint32_t pv_features;
-    uint64_t vendor_id;
-    uint64_t cpu_id;
-
+typedef struct CPUSysState {
     /* LoongArch CSRs */
     uint64_t CSR_CRMD;
     uint64_t CSR_PRMD;
@@ -395,6 +379,23 @@ typedef struct CPUArchState {
     uint64_t CSR_MSGIS[N_MSGIS];
     uint64_t CSR_MSGIR;
     uint64_t CSR_MSGIE;
+} CPUSysState;
+
+typedef struct CPUArchState {
+    uint64_t gpr[32];
+    uint64_t pc;
+
+    fpr_t fpr[32];
+    bool cf[8];
+    uint32_t fcsr0;
+    lbt_t  lbt;
+
+    uint32_t cpucfg[21];
+    uint32_t pv_features;
+    uint64_t vendor_id;
+    uint64_t cpu_id;
+    CPUSysState sys_states[1];
+
     struct {
         uint64_t guest_addr;
     } stealtime;
diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index d759be316b..9678948c45 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -9,14 +9,14 @@
 #define CSR_OFF_FUNCS(NAME, FL, RD, WR)                    \
     [LOONGARCH_CSR_##NAME] = {                             \
         .name   = (stringify(NAME)),                       \
-        .offset = offsetof(CPULoongArchState, CSR_##NAME), \
+        .offset = offsetof(CPUSysState, CSR_##NAME),       \
         .flags = FL, .readfn = RD, .writefn = WR           \
     }
 
 #define CSR_OFF_ARRAY(NAME, N)                                \
     [LOONGARCH_CSR_##NAME(N)] = {                             \
         .name   = (stringify(NAME##N)),                       \
-        .offset = offsetof(CPULoongArchState, CSR_##NAME[N]), \
+        .offset = offsetof(CPUSysState, CSR_##NAME[N]),       \
         .flags = CSRFL_BASIC, .readfn = NULL, .writefn = NULL           \
     }
 
diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
index ed7c603a0b..ef71cdf30f 100644
--- a/target/loongarch/csr.h
+++ b/target/loongarch/csr.h
@@ -29,6 +29,6 @@ CSRInfo *get_csr(unsigned int csr_num);
 bool set_csr_flag(unsigned int csr_num, int flag);
 static inline int get_csr_offset(const CSRInfo *csr, int vm_level)
 {
-    return csr->offset;
+    return csr->offset + offsetof(CPULoongArchState, sys_states[vm_level]);
 }
 #endif /* TARGET_LOONGARCH_CSR_H */
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 4db53fec26..931a5ca5ba 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -58,9 +58,9 @@ static const VMStateDescription vmstate_msgint = {
     .minimum_version_id = 1,
     .needed = msgint_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT64_ARRAY(env.CSR_MSGIS, LoongArchCPU, N_MSGIS),
-        VMSTATE_UINT64(env.CSR_MSGIR, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MSGIE, LoongArchCPU),
+        VMSTATE_UINT64_ARRAY(env.sys_states[0].CSR_MSGIS, LoongArchCPU, N_MSGIS),
+        VMSTATE_UINT64(env.sys_states[0].CSR_MSGIR, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_MSGIE, LoongArchCPU),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -167,8 +167,10 @@ static const VMStateDescription vmstate_pmu = {
     .needed = pmu_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.perf_event_num, LoongArchCPU),
-        VMSTATE_UINT64_ARRAY(env.CSR_PERFCTRL, LoongArchCPU, MAX_PERF_EVENTS),
-        VMSTATE_UINT64_ARRAY(env.CSR_PERFCNTR, LoongArchCPU, MAX_PERF_EVENTS),
+        VMSTATE_UINT64_ARRAY(env.sys_states[0].CSR_PERFCTRL, LoongArchCPU,\
+                             MAX_PERF_EVENTS),
+        VMSTATE_UINT64_ARRAY(env.sys_states[0].CSR_PERFCNTR, LoongArchCPU, \
+                             MAX_PERF_EVENTS),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -215,61 +217,61 @@ const VMStateDescription vmstate_loongarch_cpu = {
         VMSTATE_UINT64(env.pc, LoongArchCPU),
 
         /* Remaining CSRs */
-        VMSTATE_UINT64(env.CSR_CRMD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRMD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_EUEN, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MISC, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ECFG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ESTAT, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_BADV, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_BADI, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_EENTRY, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBIDX, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBEHI, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBELO0, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBELO1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_ASID, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PGDL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PGDH, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PGD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PWCL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PWCH, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_STLBPS, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_RVACFG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRCFG1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRCFG2, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_PRCFG3, LoongArchCPU),
-        VMSTATE_UINT64_ARRAY(env.CSR_SAVE, LoongArchCPU, 16),
-        VMSTATE_UINT64(env.CSR_TID, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TCFG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TVAL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_CNTC, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TICLR, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_LLBCTL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_IMPCTL1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_IMPCTL2, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRENTRY, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRBADV, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRSAVE, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRELO0, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRELO1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBREHI, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_TLBRPRMD, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRCTL, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRINFO1, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRINFO2, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRENTRY, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_MERRSAVE, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_CTAG, LoongArchCPU),
-        VMSTATE_UINT64_ARRAY(env.CSR_DMW, LoongArchCPU, 4),
+        VMSTATE_UINT64(env.sys_states[0].CSR_CRMD, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_PRMD, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_EUEN, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_MISC, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_ECFG, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_ESTAT, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_ERA, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_BADV, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_BADI, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_EENTRY, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_TLBIDX, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_TLBEHI, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_TLBELO0, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_TLBELO1, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_ASID, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_PGDL, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_PGDH, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_PGD, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_PWCL, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_PWCH, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_STLBPS, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_RVACFG, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_PRCFG1, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_PRCFG2, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_PRCFG3, LoongArchCPU),
+        VMSTATE_UINT64_ARRAY(env.sys_states[0].CSR_SAVE, LoongArchCPU, 16),
+        VMSTATE_UINT64(env.sys_states[0].CSR_TID, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_TCFG, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_TVAL, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_CNTC, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_TICLR, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_LLBCTL, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_IMPCTL1, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_IMPCTL2, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_TLBRENTRY, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_TLBRBADV, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_TLBRERA, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_TLBRSAVE, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_TLBRELO0, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_TLBRELO1, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_TLBREHI, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_TLBRPRMD, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_MERRCTL, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_MERRINFO1, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_MERRINFO2, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_MERRENTRY, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_MERRERA, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_MERRSAVE, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_CTAG, LoongArchCPU),
+        VMSTATE_UINT64_ARRAY(env.sys_states[0].CSR_DMW, LoongArchCPU, 4),
 
         /* Debug CSRs */
-        VMSTATE_UINT64(env.CSR_DBG, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_DERA, LoongArchCPU),
-        VMSTATE_UINT64(env.CSR_DSAVE, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_DBG, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_DERA, LoongArchCPU),
+        VMSTATE_UINT64(env.sys_states[0].CSR_DSAVE, LoongArchCPU),
 
         VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
         /* PV steal time */
diff --git a/target/loongarch/tcg/insn_trans/trans_extra.c.inc b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
index 298a80cff5..838ac7e6b4 100644
--- a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
@@ -46,13 +46,15 @@ static bool gen_rdtime(DisasContext *ctx, arg_rr *a,
 {
     TCGv dst1 = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv dst2 = gpr_dst(ctx, a->rj, EXT_NONE);
+    tcg_target_long offset;
 
     translator_io_start(&ctx->base);
     gen_helper_rdtime_d(dst1, tcg_env);
     if (word) {
         tcg_gen_sextract_tl(dst1, dst1, high ? 32 : 0, 32);
     }
-    tcg_gen_ld_i64(dst2, tcg_env, offsetof(CPULoongArchState, CSR_TID));
+    offset = offsetof(CPUSysState, CSR_TID) + offsetof(CPULoongArchState, sys_states[0]);
+    tcg_gen_ld_i64(dst2, tcg_env, offset);
 
     return true;
 }
-- 
2.39.3


