Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBC7CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 03:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3RR2-0000wi-C9; Mon, 29 Sep 2025 23:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v3RR0-0000vq-8t
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:53:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v3RQs-0001pb-1P
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 23:53:50 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dx_78+VNtowWsQAA--.34087S3;
 Tue, 30 Sep 2025 11:53:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBxC8E8VNtoak+_AA--.40492S5;
 Tue, 30 Sep 2025 11:53:34 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 03/13] target/loongarch: Add present and write bit with pte
 entry
Date: Tue, 30 Sep 2025 11:53:22 +0800
Message-Id: <20250930035332.2609520-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250930035332.2609520-1-maobibo@loongson.cn>
References: <20250930035332.2609520-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxC8E8VNtoak+_AA--.40492S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With hardware PTW feature enabled, Present bit and Write bit is checked
by hardware, rather Valid bit and Dirty bit. Bit P means that the page is
valid and present, and bit W means that the page is writable.

The original V bit is treated as access bit, hardware sets this bit if
there is a read or write access. Bit D bit is updated by hardware if
there is a write access.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu-csr.h        |  2 ++
 target/loongarch/cpu-mmu.h        | 31 +++++++++++++++++++++++++++++++
 target/loongarch/cpu_helper.c     |  7 ++++---
 target/loongarch/tcg/tlb_helper.c | 16 ++++++++--------
 4 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 0bcb51d3a3..6898947498 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -70,6 +70,8 @@ FIELD(TLBENTRY, PLV, 2, 2)
 FIELD(TLBENTRY, MAT, 4, 2)
 FIELD(TLBENTRY, G, 6, 1)
 FIELD(TLBENTRY, HUGE, 6, 1)
+FIELD(TLBENTRY, P, 7, 1)
+FIELD(TLBENTRY, W, 8, 1)
 FIELD(TLBENTRY, HGLOBAL, 12, 1)
 FIELD(TLBENTRY, LEVEL, 13, 2)
 FIELD(TLBENTRY_32, PPN, 8, 24)
diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 0068d22efc..bc3700f93d 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -27,6 +27,37 @@ typedef struct MMUContext {
     int           prot;
 } MMUContext;
 
+static inline bool cpu_has_ptw(CPULoongArchState *env)
+{
+    return !!FIELD_EX64(env->CSR_PWCH, CSR_PWCH, HPTW_EN);
+}
+
+static inline bool pte_present(CPULoongArchState *env, uint64_t entry)
+{
+    uint8_t present;
+
+    if (cpu_has_ptw(env)) {
+        present = FIELD_EX64(entry, TLBENTRY, P);
+    } else {
+        present = FIELD_EX64(entry, TLBENTRY, V);
+    }
+
+    return !!present;
+}
+
+static inline bool pte_write(CPULoongArchState *env, uint64_t entry)
+{
+    uint8_t writable;
+
+    if (cpu_has_ptw(env)) {
+        writable = FIELD_EX64(entry, TLBENTRY, W);
+    } else {
+        writable = FIELD_EX64(entry, TLBENTRY, D);
+    }
+
+    return !!writable;
+}
+
 bool check_ps(CPULoongArchState *ent, uint8_t ps);
 TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
                            MMUAccessType access_type, int mmu_idx);
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 4a9db3ea4c..05e7fd6f3f 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -49,12 +49,13 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
 {
     uint64_t plv = mmu_idx;
     uint64_t tlb_entry, tlb_ppn;
-    uint8_t tlb_ps, tlb_v, tlb_d, tlb_plv, tlb_nx, tlb_nr, tlb_rplv;
+    uint8_t tlb_ps, tlb_plv, tlb_nx, tlb_nr, tlb_rplv;
+    bool tlb_v, tlb_d;
 
     tlb_entry = context->pte;
     tlb_ps = context->ps;
-    tlb_v = FIELD_EX64(tlb_entry, TLBENTRY, V);
-    tlb_d = FIELD_EX64(tlb_entry, TLBENTRY, D);
+    tlb_v = pte_present(env, tlb_entry);
+    tlb_d = pte_write(env, tlb_entry);
     tlb_plv = FIELD_EX64(tlb_entry, TLBENTRY, PLV);
     if (is_la64(env)) {
         tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_64, PPN);
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 8cfce48a29..b1092d3aff 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -114,10 +114,9 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
     uint8_t tlb_ps;
     LoongArchTLB *tlb = &env->tlb[index];
     int idxmap = BIT(MMU_KERNEL_IDX) | BIT(MMU_USER_IDX);
-    uint8_t tlb_v0 = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, V);
-    uint8_t tlb_v1 = FIELD_EX64(tlb->tlb_entry1, TLBENTRY, V);
     uint64_t tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
     uint8_t tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
+    bool tlb_v;
 
     if (!tlb_e) {
         return;
@@ -130,12 +129,14 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
     addr = (tlb_vppn << R_TLB_MISC_VPPN_SHIFT) & ~mask;
     addr = sextract64(addr, 0, TARGET_VIRT_ADDR_SPACE_BITS);
 
-    if (tlb_v0) {
+    tlb_v = pte_present(env, tlb->tlb_entry0);
+    if (tlb_v) {
         tlb_flush_range_by_mmuidx(env_cpu(env), addr, pagesize,
                                   idxmap, TARGET_LONG_BITS);
     }
 
-    if (tlb_v1) {
+    tlb_v = pte_present(env, tlb->tlb_entry1);
+    if (tlb_v) {
         tlb_flush_range_by_mmuidx(env_cpu(env), addr + pagesize, pagesize,
                                   idxmap, TARGET_LONG_BITS);
     }
@@ -333,8 +334,7 @@ void helper_tlbwr(CPULoongArchState *env)
 {
     int index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
     LoongArchTLB *old, new = {};
-    bool skip_inv = false;
-    uint8_t tlb_v0, tlb_v1;
+    bool skip_inv = false, tlb_v0, tlb_v1;
 
     old = env->tlb + index;
     if (FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, NE)) {
@@ -346,8 +346,8 @@ void helper_tlbwr(CPULoongArchState *env)
     /* Check whether ASID/VPPN is the same */
     if (old->tlb_misc == new.tlb_misc) {
         /* Check whether both even/odd pages is the same or invalid */
-        tlb_v0 = FIELD_EX64(old->tlb_entry0, TLBENTRY, V);
-        tlb_v1 = FIELD_EX64(old->tlb_entry1, TLBENTRY, V);
+        tlb_v0 = pte_present(env, old->tlb_entry0);
+        tlb_v1 = pte_present(env, old->tlb_entry1);
         if ((!tlb_v0 || new.tlb_entry0 == old->tlb_entry0) &&
             (!tlb_v1 || new.tlb_entry1 == old->tlb_entry1)) {
             skip_inv = true;
-- 
2.39.3


