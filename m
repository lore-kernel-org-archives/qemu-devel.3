Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4E0606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmve-0002yi-5i; Fri, 13 Nov 2026 03:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvc-0002xr-FR
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:36 -0500
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmva-0007QN-J6
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:36 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id F0F677804;
 Fri, 13 Nov 2026 14:16:32 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 16/26] target/loongarch: add LVZ to invtlb 0x0-0x6
Date: Fri, 13 Nov 2026 16:45:31 +0800
Message-ID: <c686a1a0d24b91f39fcf12bd5630f9587f92044c.1794558695.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794558695.git.prcups@krgm.moe>
References: <cover.1794558695.git.prcups@krgm.moe>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a14:640:1:12b5::1 (failed)
Received-SPF: pass client-ip=2a14:640:1:12b5::1; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add guest handling to invtlb 0x0-0x6, vm_level stays ignored.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/tcg/tlb_helper.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 82b4ef4333..4bf9dacd0c 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -602,9 +602,12 @@ void HELPER(tlbflush)(CPULoongArchState *env)
 void HELPER(invtlb_all)(CPULoongArchState *env, target_ulong info, uint32_t op,
                        uint32_t vm_level)
 {
+    uint16_t gid = get_gid(env, env_vm_level(env));
+
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
-        env->tlb[i].tlb_misc = FIELD_DP64(env->tlb[i].tlb_misc,
-                                          TLB_MISC, E, 0);
+        LoongArchTLB *tlb = &env->tlb[i];
+        if ((op == 0 && env_vm_level(env) == 0) || tlb_entry_matches_gid(tlb, gid))
+            tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
     }
     tlb_flush(env_cpu(env));
 }
@@ -612,11 +615,13 @@ void HELPER(invtlb_all)(CPULoongArchState *env, target_ulong info, uint32_t op,
 void HELPER(invtlb_all_g)(CPULoongArchState *env, target_ulong info, uint32_t g,
                          uint32_t vm_level)
 {
+    uint16_t gid = get_gid(env, env_vm_level(env));
+
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
         LoongArchTLB *tlb = &env->tlb[i];
         uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
 
-        if (tlb_g == g) {
+        if (tlb_g == g && tlb_entry_matches_gid(tlb, gid)) {
             tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
         }
     }
@@ -627,13 +632,14 @@ void HELPER(invtlb_all_asid)(CPULoongArchState *env, target_ulong info,
                             uint32_t vm_level)
 {
     uint16_t asid = info & R_CSR_ASID_ASID_MASK;
+    uint16_t gid = get_gid(env, env_vm_level(env));
 
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
         LoongArchTLB *tlb = &env->tlb[i];
         uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
         uint16_t tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
 
-        if (!tlb_g && (tlb_asid == asid)) {
+        if (!tlb_g && tlb_asid == asid && tlb_entry_matches_gid(tlb, gid)) {
             tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
         }
     }
@@ -643,12 +649,14 @@ void HELPER(invtlb_all_asid)(CPULoongArchState *env, target_ulong info,
 void HELPER(invtlb_page_asid)(CPULoongArchState *env, target_ulong info,
                              target_ulong addr, uint32_t vm_level)
 {
-    int asid = info & 0x3ff;
+
+    uint16_t asid = info & R_CSR_ASID_ASID_MASK;
+    uint16_t gid = get_gid(env, env_vm_level(env));
     const LoongArchTLB *tlb;
     tlb_match func;
 
     func = tlb_match_asid;
-    tlb = loongarch_tlb_search_cb(env, addr, asid, func, env_vm_level(env), 0);
+    tlb = loongarch_tlb_search_cb(env, addr, asid, func, env_vm_level(env), gid);
     if (tlb) {
         invalidate_tlb(env, tlb - env->tlb, env_vm_level(env));
     }
@@ -657,13 +665,14 @@ void HELPER(invtlb_page_asid)(CPULoongArchState *env, target_ulong info,
 void HELPER(invtlb_page_asid_or_g)(CPULoongArchState *env, target_ulong info,
                                   target_ulong addr, uint32_t vm_level)
 {
-    int asid = info & 0x3ff;
+    uint16_t asid = info & R_CSR_ASID_ASID_MASK;
+    uint16_t gid = get_gid(env, env_vm_level(env));
     const LoongArchTLB *tlb;
     tlb_match func;
 
     func = tlb_match_any;
     tlb = loongarch_tlb_search_cb(env, addr, asid, func,
-                                  env_vm_level(env), 0);
+                                  env_vm_level(env), gid);
     if (tlb) {
         invalidate_tlb(env, tlb - env->tlb, env_vm_level(env));
     }
-- 
2.56.0


