Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172FB606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWTgH-0004JQ-OQ; Thu, 26 Nov 2026 02:14:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xWTg9-000497-2O
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:14:03 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xWTg3-0003Dt-Uh
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 02:13:59 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8DxUNEi3Adr+CojAA--.34689S3;
 Thu, 26 Nov 2026 15:13:38 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAx3c4c3AdrvX03AA--.44576S5;
 Thu, 26 Nov 2026 15:13:37 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 15/18] target/loongarch: Add fine-grained write masks for
 CSRs
Date: Thu, 26 Nov 2026 15:14:37 +0800
Message-ID: <20261126071440.3293877-16-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126071440.3293877-1-maobibo@loongson.cn>
References: <20261126071440.3293877-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx3c4c3AdrvX03AA--.44576S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3XF1rAr1Dtw1DJF48KryDJwc_yoWxGry8pr
 4a9ry8GrW8trZ3Cwn3Xw4Yvw1Yqw4xGa12vay3G3sxtrWYqrW8Xr4vv342yFWrX3WrXr1S
 vF1FyrWIgF10qagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
 kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce set_csr_wrmask() and clear_csr_wrmask() to adjust the
per-CSR write mask at initialization time. This allows describing
CSRs whose writable bits are not a single contiguous range: a
read-only bit between writable bits can be cleared from the mask,
and writable bits for newly emulated features can be added without
touching the default mask of the whole register.

Signed-off-by: Bibo Mao <maobibo@loongson.cn
---
 target/loongarch/cpu-csr.h                    |  3 ++
 target/loongarch/cpu.c                        | 14 +++++++
 target/loongarch/csr.c                        | 26 +++++++++++++
 target/loongarch/csr.h                        |  2 +
 .../tcg/insn_trans/trans_privileged.c.inc     | 38 +++++++++++++++++++
 5 files changed, 83 insertions(+)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index c99997d790..73fedef81f 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -218,6 +218,7 @@ CSR_WRMASK(TLBRENTRY, 12, 36)
 CSR_WRMASK(TLBRBADV, 0, 64)
 #define LOONGARCH_CSR_TLBRERA        0x8a /* TLB refill ERA */
 FIELD(CSR_TLBRERA, ISTLBR, 0, 1)
+FIELD(CSR_TLBRERA, RSV, 1, 1)
 FIELD(CSR_TLBRERA, PC, 2, 62)
 CSR_WRMASK(TLBRERA, 0, 64)
 #define LOONGARCH_CSR_TLBRSAVE       0x8b /* KScratch for TLB refill */
@@ -228,12 +229,14 @@ CSR_WRMASK(TLBRELO0, 0, 64)
 CSR_WRMASK(TLBRELO1, 0, 64)
 #define LOONGARCH_CSR_TLBREHI        0x8e /* TLB refill entryhi */
 FIELD(CSR_TLBREHI, PS, 0, 6)
+FIELD(CSR_TLBREHI, RSV, 6, 7)
 FIELD(CSR_TLBREHI_32, VPPN, 13, 19)
 FIELD(CSR_TLBREHI_64, VPPN, 13, 35)
 CSR_WRMASK(TLBREHI, 0, 48)
 #define LOONGARCH_CSR_TLBRPRMD       0x8f /* TLB refill mode info */
 FIELD(CSR_TLBRPRMD, PPLV, 0, 2)
 FIELD(CSR_TLBRPRMD, PIE, 2, 1)
+FIELD(CSR_TLBRPRMD, RSV, 3, 1)
 FIELD(CSR_TLBRPRMD, PWE, 4, 1)
 CSR_WRMASK(TLBRPRMD, 0, 5)
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 020eb88f49..f6de077a2b 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -139,6 +139,7 @@ static void loongarch_la464_init_csr(DeviceState *dev)
     CPULoongArchState *env = &cpu->env;
     CPUSysState *sys = env_sys(env);
     int i, num;
+    uint64_t romask;
 
     if (!initialized) {
         initialized = true;
@@ -153,6 +154,19 @@ static void loongarch_la464_init_csr(DeviceState *dev)
             set_csr_flag(LOONGARCH_CSR_PERFCTRL(i), CSRFL_UNUSED);
             set_csr_flag(LOONGARCH_CSR_PERFCNTR(i), CSRFL_UNUSED);
         }
+
+        if (tcg_enabled()) {
+            if (FIELD_EX32(env->cpucfg[2], CPUCFG2, HPTW)) {
+                set_csr_wrmask(LOONGARCH_CSR_PWCH, R_CSR_PWCH_HPTW_EN_MASK);
+            } else {
+                /* Bit P and W is hardware bit with PTE entry */
+                romask = R_TLBENTRY_P_MASK | R_TLBENTRY_W_MASK;
+                clear_csr_wrmask(LOONGARCH_CSR_TLBELO0, romask);
+                clear_csr_wrmask(LOONGARCH_CSR_TLBELO1, romask);
+                clear_csr_wrmask(LOONGARCH_CSR_TLBRELO0, romask);
+                clear_csr_wrmask(LOONGARCH_CSR_TLBRELO1, romask);
+            }
+        }
     }
 #endif
 }
diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
index 3e7e2ed971..78db13a268 100644
--- a/target/loongarch/csr.c
+++ b/target/loongarch/csr.c
@@ -157,3 +157,29 @@ bool set_csr_flag(unsigned int csr_num, int flag)
     csr->flags |= flag;
     return true;
 }
+
+bool clear_csr_wrmask(unsigned int csr_num, uint64_t wrmask)
+{
+    CSRInfo *csr;
+
+    csr = get_csr(csr_num);
+    if (!csr) {
+        return false;
+    }
+
+    csr->wrmask &= ~wrmask;
+    return true;
+}
+
+bool set_csr_wrmask(unsigned int csr_num, uint64_t wrmask)
+{
+    CSRInfo *csr;
+
+    csr = get_csr(csr_num);
+    if (!csr) {
+        return false;
+    }
+
+    csr->wrmask |= wrmask;
+    return true;
+}
diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
index 33b091a549..7d2f53f21c 100644
--- a/target/loongarch/csr.h
+++ b/target/loongarch/csr.h
@@ -34,6 +34,8 @@ typedef struct {
 
 CSRInfo *get_csr(unsigned int csr_num);
 bool set_csr_flag(unsigned int csr_num, int flag);
+bool clear_csr_wrmask(unsigned int csr_num, uint64_t wrmask);
+bool set_csr_wrmask(unsigned int csr_num, uint64_t wrmask);
 static inline unsigned int get_csr_offset(const CSRInfo *csr, int vm_level)
 {
     return csr->offset + offsetof(CPULoongArchState, sys_states[vm_level]);
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index f90792347a..e3bd68ce36 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -69,6 +69,43 @@ static bool set_csr_trans_func(unsigned int csr_num, GenCSRRead readfn,
     return true;
 }
 
+static void init_csr_wrmask(void)
+{
+    int i;
+    uint64_t romask;
+
+    romask = R_CSR_MISC_RSV_MASK | R_CSR_MISC_RSV1_MASK;
+    clear_csr_wrmask(LOONGARCH_CSR_MISC, romask);
+
+    romask = R_CSR_ECFG_RSV_MASK;
+    clear_csr_wrmask(LOONGARCH_CSR_ECFG, romask);
+
+    /* 2048 TLB entries */
+    romask = MAKE_64BIT_MASK(12, 12) | BIT_ULL(30);
+    clear_csr_wrmask(LOONGARCH_CSR_TLBIDX, romask);
+
+    /* BIT P and W in pte entry is not handled here */
+    romask = MAKE_64BIT_MASK(9, 5) | MAKE_64BIT_MASK(48, 13);
+    clear_csr_wrmask(LOONGARCH_CSR_TLBELO0, romask);
+    clear_csr_wrmask(LOONGARCH_CSR_TLBELO1, romask);
+    clear_csr_wrmask(LOONGARCH_CSR_TLBRELO0, romask);
+    clear_csr_wrmask(LOONGARCH_CSR_TLBRELO1, romask);
+
+    romask = R_CSR_TLBRERA_RSV_MASK;
+    clear_csr_wrmask(LOONGARCH_CSR_TLBRERA, romask);
+
+    romask = R_CSR_TLBREHI_RSV_MASK;
+    clear_csr_wrmask(LOONGARCH_CSR_TLBREHI, romask);
+
+    romask = R_CSR_TLBRPRMD_RSV_MASK;
+    clear_csr_wrmask(LOONGARCH_CSR_TLBRPRMD, romask);
+
+    romask = MAKE_64BIT_MASK(10, 6);
+    for (i = 0; i < MAX_PERF_EVENTS; i++) {
+        clear_csr_wrmask(LOONGARCH_CSR_PERFCTRL(i), romask);
+    }
+}
+
 #define SET_CSR_FUNC(NAME, read, write)                 \
         set_csr_trans_func(LOONGARCH_CSR_##NAME, read, write)
 
@@ -84,6 +121,7 @@ void loongarch_csr_translate_init(void)
     SET_CSR_FUNC(TVAL,  gen_helper_csrrd_tval, NULL);
     SET_CSR_FUNC(TICLR, NULL, gen_helper_csrwr_ticlr);
     SET_CSR_FUNC(MSGIR, gen_helper_csrrd_msgir, NULL);
+    init_csr_wrmask();
 }
 #undef SET_CSR_FUNC
 
-- 
2.54.0


