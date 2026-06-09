Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBD6CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWtCD-0002B8-Og; Tue, 09 Jun 2026 05:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wWtCC-000281-Pc
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:56:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wWtCA-0005f6-4t
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:56:32 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Axp3jv4idqjjUSAA--.23775S3;
 Tue, 09 Jun 2026 17:54:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxSMHg4idqJrGgAA--.28412S16;
 Tue, 09 Jun 2026 17:54:54 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 14/14] target/loongarch: Add new structure CPUSysState
Date: Tue,  9 Jun 2026 17:28:24 +0800
Message-Id: <20260609092824.227250-15-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260609092824.227250-1-gaosong@loongson.cn>
References: <20260609092824.227250-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxSMHg4idqJrGgAA--.28412S16
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

From: Bibo Mao <maobibo@loongson.cn>

New structure CPUSysState is added here, now it only contains CSR
registers, in future TLB and timer can be moved to this structure also.

It is only code movement, no function change.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20260605083938.175658-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c     |   4 +-
 target/loongarch/cpu.h     |  35 +++++------
 target/loongarch/csr.h     |   8 ++-
 target/loongarch/machine.c | 118 +++++++++++++++++++------------------
 4 files changed, 85 insertions(+), 80 deletions(-)

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
diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
index 6e17275546..c2b6b882bc 100644
--- a/target/loongarch/csr.h
+++ b/target/loongarch/csr.h
@@ -8,8 +8,10 @@
 
 #include "cpu-csr.h"
 
-#define CSR_OFFSET(id)                  offsetof(CPULoongArchState, id)
-#define CPU_CSR_OFFSET(id, vm_level)    CSR_OFFSET(id)
+#define CSR_OFFSET(id)                  offsetof(CPUSysState, id)
+#define CPU_CSR_OFFSET(id, vm_level)                                     \
+                    (offsetof(CPULoongArchState, sys_states[vm_level])   \
+                             + CSR_OFFSET(id))
 
 typedef void (*GenCSRFunc)(void);
 enum {
@@ -32,6 +34,6 @@ CSRInfo *get_csr(unsigned int csr_num);
 bool set_csr_flag(unsigned int csr_num, int flag);
 static inline unsigned int get_csr_offset(const CSRInfo *csr, int vm_level)
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
-- 
2.54.0


