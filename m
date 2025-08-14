Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F349CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 07:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umSW4-0006x4-IS; Thu, 14 Aug 2025 03:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1umSVx-0006vE-5K
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 03:36:45 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1umSVt-0004Tp-8V
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 03:36:44 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Axx2n7kZ1oEqs_AQ--.20858S3;
 Thu, 14 Aug 2025 15:36:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxM+T4kZ1oM9xKAA--.22944S10;
 Thu, 14 Aug 2025 15:36:26 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 8/9] target/loongarch: Update matched ptw bit A/D with PTW
 supported
Date: Thu, 14 Aug 2025 15:36:23 +0800
Message-Id: <20250814073624.430928-9-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250814073624.430928-1-maobibo@loongson.cn>
References: <20250814073624.430928-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxM+T4kZ1oM9xKAA--.22944S10
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

With hardware PTE supported, bit A will be set if there is read access
or instruction fetch, and bit D will be set with write access.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu-mmu.h    | 26 ++++++++++++++++++++
 target/loongarch/cpu_helper.c | 45 +++++++++++++++++++++++++++++++----
 2 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index 2e63324abe..cb596dd57a 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -61,6 +61,32 @@ static inline bool pte_write(CPULoongArchState *env, uint64_t entry)
     return !!writable;
 }
 
+/*
+ * The folloing functions should be called with PTW enable checked
+ * With hardware PTW enabled
+ *   Bit D will be set by hardware with write access
+ *   Bit A will be set by hardware with read/intruction fetch access
+ */
+static inline uint64_t pte_mkaccess(uint64_t entry)
+{
+    return FIELD_DP64(entry, TLBENTRY, V, 1);
+}
+
+static inline uint64_t pte_mkdirty(uint64_t entry)
+{
+    return FIELD_DP64(entry, TLBENTRY, D, 1);
+}
+
+static inline bool pte_access(uint64_t entry)
+{
+    return !!FIELD_EX64(entry, TLBENTRY, V);
+}
+
+static inline bool pte_dirty(uint64_t entry)
+{
+    return !!FIELD_EX64(entry, TLBENTRY, D);
+}
+
 bool check_ps(CPULoongArchState *ent, uint8_t ps);
 TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
                            MMUAccessType access_type, int mmu_idx);
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 79c994255f..7b0bac3dc9 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -111,11 +111,12 @@ TLBRet loongarch_page_table_walker(CPULoongArchState *env,
                                    int access_type, int mmu_idx)
 {
     CPUState *cs = env_cpu(env);
-    target_ulong index, phys;
+    target_ulong index, phys = 0;
     uint64_t dir_base, dir_width;
-    uint64_t base;
+    uint64_t base, pte;
     int level;
     vaddr address;
+    TLBRet ret;
 
     address = context->addr;
     if ((address >> 63) & 0x1) {
@@ -145,6 +146,7 @@ TLBRet loongarch_page_table_walker(CPULoongArchState *env,
     /* pte */
     if (FIELD_EX64(base, TLBENTRY, HUGE)) {
         /* Huge Page. base is pte */
+        pte = base;
         base = FIELD_DP64(base, TLBENTRY, LEVEL, 0);
         base = FIELD_DP64(base, TLBENTRY, HUGE, 0);
         if (FIELD_EX64(base, TLBENTRY, HGLOBAL)) {
@@ -156,12 +158,13 @@ TLBRet loongarch_page_table_walker(CPULoongArchState *env,
         context->pte_buddy[0] = base;
         context->pte_buddy[1] = base + BIT_ULL(dir_base);
         base += (BIT_ULL(dir_base) & address);
+        index = 0;
     } else {
         /* Normal Page. base points to pte */
         get_dir_base_width(env, &dir_base, &dir_width, 0);
         index = (address >> dir_base) & ((1 << dir_width) - 1);
         phys = base | index << 3;
-        base = ldq_phys(cs->as, phys);
+        base = pte = ldq_phys(cs->as, phys);
         if (cpu_has_ptw(env)) {
             index &= 1;
             context->pte_buddy[index] = base;
@@ -172,7 +175,41 @@ TLBRet loongarch_page_table_walker(CPULoongArchState *env,
 
     context->ps = dir_base;
     context->pte = base;
-    return loongarch_check_pte(env, context, access_type, mmu_idx);
+    ret = loongarch_check_pte(env, context, access_type, mmu_idx);
+
+    /*
+     * Update bit A/D with hardware PTW supported
+     *
+     * Fixme: need atomic compchxg operation with pte update, other vCPUs may
+     * update pte at the same time.
+     */
+    if (ret == TLBRET_MATCH && cpu_has_ptw(env)) {
+        if (access_type == MMU_DATA_STORE && pte_dirty(base)) {
+            return ret;
+        }
+
+        if (access_type != MMU_DATA_STORE && pte_access(base)) {
+            return ret;
+        }
+
+        base = pte_mkaccess(pte);
+        context->pte_buddy[index] = pte_mkaccess(context->pte_buddy[index]);
+        if (access_type == MMU_DATA_STORE) {
+            base = pte_mkdirty(base);
+            context->pte_buddy[index] = pte_mkdirty(context->pte_buddy[index]);
+        }
+        stq_phys(cs->as, phys, base);
+
+        /* Bit A/D need be updated with both Even/Odd page with huge pte */
+        if (FIELD_EX64(base, TLBENTRY, HUGE)) {
+            context->pte_buddy[1] = pte_mkaccess(context->pte_buddy[1]);
+            if (access_type == MMU_DATA_STORE) {
+                context->pte_buddy[1] = pte_mkdirty(context->pte_buddy[1]);
+            }
+        }
+    }
+
+    return ret;
 }
 
 static TLBRet loongarch_map_address(CPULoongArchState *env,
-- 
2.39.3


