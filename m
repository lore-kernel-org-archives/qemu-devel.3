Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97585606CB3C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmvw-00039Q-LI; Fri, 13 Nov 2026 03:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmve-0002yj-4W
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:38 -0500
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvb-0007TK-Re
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:37 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 56F86850;
 Fri, 13 Nov 2026 14:16:34 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 17/26] target/loongarch: add LVZ to invtlb 0xa-0xe
Date: Fri, 13 Nov 2026 16:45:32 +0800
Message-ID: <dcd59b915b0c191d6b1c3737907e45cf7bbec65a.1794558695.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794558695.git.prcups@krgm.moe>
References: <cover.1794558695.git.prcups@krgm.moe>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.47.186.116; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use vm_level to determine whether operation is for guest under host.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 .../tcg/insn_trans/trans_privileged.c.inc     | 34 ++++++++++++++
 target/loongarch/tcg/tlb_helper.c             | 46 +++++++++++++++----
 2 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index db637249f1..5575bba9e1 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -322,6 +322,10 @@ static bool trans_invtlb(DisasContext *ctx, arg_invtlb *a)
         return false;
     }
 
+    if (!avail_LVZ(ctx) && a->imm > 0x6) {
+        return false;
+    }
+
     switch (a->imm) {
     case 0x0:
     case 0x1:
@@ -346,6 +350,36 @@ static bool trans_invtlb(DisasContext *ctx, arg_invtlb *a)
         gen_helper_invtlb_page_asid_or_g(tcg_env, rj, rk,
                                          tcg_constant_i32(0));
         break;
+    case 0x9:
+    case 0x10:
+    case 0x11:
+    case 0x12:
+    case 0x13:
+    case 0x14:
+    case 0x15:
+    case 0x16:
+        //TODO: refine 0x9-0x16
+        gen_helper_invtlb_all(tcg_env, rj, tcg_constant_i32(0),
+                              tcg_constant_i32(0));
+        break;
+    case 0xa:
+        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(1),
+                                tcg_constant_i32(1));
+        break;
+    case 0xb:
+        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(0),
+                                tcg_constant_i32(1));
+        break;
+    case 0xc:
+        gen_helper_invtlb_all_asid(tcg_env, rj, tcg_constant_i32(1));
+        break;
+    case 0xd:
+        gen_helper_invtlb_page_asid(tcg_env, rj, rk, tcg_constant_i32(1));
+        break;
+    case 0xe:
+        gen_helper_invtlb_page_asid_or_g(tcg_env, rj, rk,
+                                         tcg_constant_i32(1));
+        break;
     default:
         return false;
     }
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 4bf9dacd0c..1248b44a46 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -602,11 +602,17 @@ void HELPER(tlbflush)(CPULoongArchState *env)
 void HELPER(invtlb_all)(CPULoongArchState *env, target_ulong info, uint32_t op,
                        uint32_t vm_level)
 {
-    uint16_t gid = get_gid(env, env_vm_level(env));
+    uint16_t gid = vm_level ? (info & 0xff) : get_gid(env, env_vm_level(env));
+
+    if (vm_level && env_vm_level(env) == VM_LEVEL1) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+
+    vm_level |= env_vm_level(env) == VM_LEVEL1;
 
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
         LoongArchTLB *tlb = &env->tlb[i];
-        if ((op == 0 && env_vm_level(env) == 0) || tlb_entry_matches_gid(tlb, gid))
+        if ((op == 0 && vm_level == 0) || tlb_entry_matches_gid(tlb, gid))
             tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
     }
     tlb_flush(env_cpu(env));
@@ -615,7 +621,13 @@ void HELPER(invtlb_all)(CPULoongArchState *env, target_ulong info, uint32_t op,
 void HELPER(invtlb_all_g)(CPULoongArchState *env, target_ulong info, uint32_t g,
                          uint32_t vm_level)
 {
-    uint16_t gid = get_gid(env, env_vm_level(env));
+    uint16_t gid = vm_level ? (info & 0xff) : get_gid(env, env_vm_level(env));
+
+    if (vm_level && env_vm_level(env) == VM_LEVEL1) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+
+    vm_level |= env_vm_level(env) == VM_LEVEL1;
 
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
         LoongArchTLB *tlb = &env->tlb[i];
@@ -632,7 +644,12 @@ void HELPER(invtlb_all_asid)(CPULoongArchState *env, target_ulong info,
                             uint32_t vm_level)
 {
     uint16_t asid = info & R_CSR_ASID_ASID_MASK;
-    uint16_t gid = get_gid(env, env_vm_level(env));
+    uint16_t gid = vm_level ? ((info >> 16) & 0xff) : get_gid(env, env_vm_level(env));
+
+    if (vm_level) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+    vm_level |= env_vm_level(env);
 
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
         LoongArchTLB *tlb = &env->tlb[i];
@@ -651,14 +668,19 @@ void HELPER(invtlb_page_asid)(CPULoongArchState *env, target_ulong info,
 {
 
     uint16_t asid = info & R_CSR_ASID_ASID_MASK;
-    uint16_t gid = get_gid(env, env_vm_level(env));
+    uint16_t gid = vm_level ? ((info >> 16) & 0xff) : get_gid(env, env_vm_level(env));
     const LoongArchTLB *tlb;
     tlb_match func;
 
+    if (vm_level && env_vm_level(env)) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+    vm_level |= env_vm_level(env);
+
     func = tlb_match_asid;
-    tlb = loongarch_tlb_search_cb(env, addr, asid, func, env_vm_level(env), gid);
+    tlb = loongarch_tlb_search_cb(env, addr, asid, func, vm_level, gid);
     if (tlb) {
-        invalidate_tlb(env, tlb - env->tlb, env_vm_level(env));
+        invalidate_tlb(env, tlb - env->tlb, vm_level);
     }
 }
 
@@ -666,15 +688,19 @@ void HELPER(invtlb_page_asid_or_g)(CPULoongArchState *env, target_ulong info,
                                   target_ulong addr, uint32_t vm_level)
 {
     uint16_t asid = info & R_CSR_ASID_ASID_MASK;
-    uint16_t gid = get_gid(env, env_vm_level(env));
+    uint16_t gid = vm_level ? ((info >> 16) & 0xff) : get_gid(env, env_vm_level(env));
     const LoongArchTLB *tlb;
     tlb_match func;
 
     func = tlb_match_any;
+    if (vm_level) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+    vm_level |= env_vm_level(env);
     tlb = loongarch_tlb_search_cb(env, addr, asid, func,
-                                  env_vm_level(env), gid);
+                                  vm_level, gid);
     if (tlb) {
-        invalidate_tlb(env, tlb - env->tlb, env_vm_level(env));
+        invalidate_tlb(env, tlb - env->tlb, vm_level);
     }
 }
 
-- 
2.56.0


