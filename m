Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B30CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN3d-0001oD-9f; Sat, 30 Aug 2025 10:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1urpGu-0008LQ-Qj
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 22:55:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1urpGr-00079A-CY
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 22:55:24 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Cx6tGWFrForG4EAA--.8997S3;
 Fri, 29 Aug 2025 10:55:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxbMGMFrFoKstvAA--.33085S8;
 Fri, 29 Aug 2025 10:55:17 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/14] target/loongarch: Use vaddr in get_physical_address()
Date: Fri, 29 Aug 2025 10:54:59 +0800
Message-Id: <20250829025507.2315073-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250829025507.2315073-1-maobibo@loongson.cn>
References: <20250829025507.2315073-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxbMGMFrFoKstvAA--.33085S8
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Replace target_ulong type with vaddr in function get_physical_address()
and the same with its calling functions.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/cpu-mmu.h        |  2 +-
 target/loongarch/cpu_helper.c     |  9 ++++-----
 target/loongarch/tcg/tlb_helper.c | 11 ++++++-----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
index cbe6f37773..dffc12820f 100644
--- a/target/loongarch/cpu-mmu.h
+++ b/target/loongarch/cpu-mmu.h
@@ -21,7 +21,7 @@ typedef enum TLBRet {
 
 bool check_ps(CPULoongArchState *ent, uint8_t ps);
 TLBRet get_physical_address(CPULoongArchState *env, hwaddr *physical,
-                            int *prot, target_ulong address,
+                            int *prot, vaddr address,
                             MMUAccessType access_type, int mmu_idx,
                             int is_debug);
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 17a0735f5c..0c037ef163 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -46,7 +46,7 @@ void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
 
 static TLBRet loongarch_page_table_walker(CPULoongArchState *env,
                                           hwaddr *physical,
-                                          int *prot, target_ulong address)
+                                          int *prot, vaddr address)
 {
     CPUState *cs = env_cpu(env);
     target_ulong index, phys;
@@ -121,7 +121,7 @@ static TLBRet loongarch_page_table_walker(CPULoongArchState *env,
 }
 
 static TLBRet loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
-                                    int *prot, target_ulong address,
+                                    int *prot, vaddr address,
                                     MMUAccessType access_type, int mmu_idx,
                                     int is_debug)
 {
@@ -147,8 +147,7 @@ static TLBRet loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
     return TLBRET_NOMATCH;
 }
 
-static hwaddr dmw_va2pa(CPULoongArchState *env, target_ulong va,
-                        target_ulong dmw)
+static hwaddr dmw_va2pa(CPULoongArchState *env, vaddr va, target_ulong dmw)
 {
     if (is_la64(env)) {
         return va & TARGET_VIRT_MASK;
@@ -160,7 +159,7 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, target_ulong va,
 }
 
 TLBRet get_physical_address(CPULoongArchState *env, hwaddr *physical,
-                            int *prot, target_ulong address,
+                            int *prot, vaddr address,
                             MMUAccessType access_type, int mmu_idx,
                             int is_debug)
 {
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 4a2a565985..3d09f18020 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -29,7 +29,7 @@ bool check_ps(CPULoongArchState *env, uint8_t tlb_ps)
     return BIT_ULL(tlb_ps) & (env->CSR_PRCFG2);
 }
 
-static void raise_mmu_exception(CPULoongArchState *env, target_ulong address,
+static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
                                 MMUAccessType access_type, TLBRet tlb_error)
 {
     CPUState *cs = env_cpu(env);
@@ -198,7 +198,7 @@ static uint32_t get_random_tlb(uint32_t low, uint32_t high)
  * field in tlb entry contains bit[47:13], so need adjust.
  * virt_vpn = vaddr[47:13]
  */
-static bool loongarch_tlb_search(CPULoongArchState *env, target_ulong vaddr,
+static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
                                  int *index)
 {
     LoongArchTLB *tlb;
@@ -649,8 +649,9 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
 }
 
 static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
-                                      int *prot, target_ulong address,
-                                      int access_type, int index, int mmu_idx)
+                                      int *prot, vaddr address,
+                                      int access_type, int index,
+                                      int mmu_idx)
 {
     LoongArchTLB *tlb = &env->tlb[index];
     uint64_t plv = mmu_idx;
@@ -714,7 +715,7 @@ static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
 }
 
 TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env, hwaddr *physical,
-                                   int *prot, target_ulong address,
+                                   int *prot, vaddr address,
                                    MMUAccessType access_type, int mmu_idx)
 {
     int index, match;
-- 
2.43.5


