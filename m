Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60108CA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0wQ-0004rd-IB; Thu, 08 Oct 2026 23:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xF0vk-0004fS-IT
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:06:07 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xF0vg-0005m1-Jq
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:54 -0400
Received: from yuno-loong (unknown
 [IPv6:2409:8900:2684:b82:443b:7baf:6228:2a79])
 by krgm.moe (Postfix) with ESMTPSA id 1C49AE002;
 Fri, 09 Oct 2026 08:35:49 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v5 15/23] target/loongarch: add LVZ to invtlb
Date: Fri,  9 Oct 2026 11:05:11 +0800
Message-ID: <e864669d1a8d97f6d70677ef43ce925eef7ed4a8.1791514848.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791514848.git.prcups@krgm.moe>
References: <cover.1791514848.git.prcups@krgm.moe>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add op 0x9, 0xa-0xf to instruction invtlb to support vm level 1.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 .../tcg/insn_trans/trans_privileged.c.inc     | 34 +++++++++++++
 target/loongarch/tcg/tlb_helper.c             | 51 ++++++++++++++++---
 2 files changed, 77 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 493ed7f24b..00e8f61e42 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -328,6 +328,10 @@ static bool trans_invtlb(DisasContext *ctx, arg_invtlb *a)
         return false;
     }
 
+    if (!avail_LVZ(ctx) && a->imm > 0x6) {
+        return false;
+    }
+
     switch (a->imm) {
     case 0x0:
     case 0x1:
@@ -352,6 +356,36 @@ static bool trans_invtlb(DisasContext *ctx, arg_invtlb *a)
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
index 60c7193283..c02b7c2472 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -599,9 +599,18 @@ void helper_tlbflush(CPULoongArchState *env, uint32_t vm_level)
 void helper_invtlb_all(CPULoongArchState *env, target_ulong info, uint32_t op,
                        uint32_t to_guest)
 {
+    uint16_t gid = to_guest ? (info & 0xff) : get_tgid(env);
+
+    if (to_guest && env_vm_level(env) == VM_LEVEL1) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+
+    to_guest |= env_vm_level(env) == VM_LEVEL1;
+
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
-        env->tlb[i].tlb_misc = FIELD_DP64(env->tlb[i].tlb_misc,
-                                          TLB_MISC, E, 0);
+        LoongArchTLB *tlb = &env->tlb[i];
+        if ((op == 0 && to_guest == 0) || tlb_entry_matches_gid(tlb, gid))
+            tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
     }
     tlb_flush(env_cpu(env));
 }
@@ -609,11 +618,19 @@ void helper_invtlb_all(CPULoongArchState *env, target_ulong info, uint32_t op,
 void helper_invtlb_all_g(CPULoongArchState *env, target_ulong info, uint32_t g,
                          uint32_t to_guest)
 {
+    uint16_t gid = to_guest ? (info & 0xff) : get_tgid(env);
+
+    if (to_guest && env_vm_level(env) == VM_LEVEL1) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+
+    to_guest |= env_vm_level(env) == VM_LEVEL1;
+
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
         LoongArchTLB *tlb = &env->tlb[i];
         uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
 
-        if (tlb_g == g) {
+        if (tlb_g == g && tlb_entry_matches_gid(tlb, gid)) {
             tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
         }
     }
@@ -624,13 +641,19 @@ void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info,
                             uint32_t to_guest)
 {
     uint16_t asid = info & R_CSR_ASID_ASID_MASK;
+    uint16_t gid = to_guest ? ((info >> 16) & 0xff) : get_tgid(env);
+
+    if (to_guest) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+    to_guest |= env_vm_level(env);
 
     for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
         LoongArchTLB *tlb = &env->tlb[i];
         uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
         uint16_t tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
 
-        if (!tlb_g && (tlb_asid == asid)) {
+        if (!tlb_g && tlb_asid == asid && tlb_entry_matches_gid(tlb, gid)) {
             tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
         }
     }
@@ -640,12 +663,19 @@ void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info,
 void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
                              target_ulong addr, uint32_t to_guest)
 {
-    int asid = info & 0x3ff;
+
+    uint16_t asid = info & R_CSR_ASID_ASID_MASK;
+    uint16_t gid = to_guest ? ((info >> 16) & 0xff) : get_tgid(env);
     const LoongArchTLB *tlb;
     tlb_match func;
 
+    if (to_guest && env_vm_level(env)) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+    to_guest |= env_vm_level(env);
+
     func = tlb_match_asid;
-    tlb = loongarch_tlb_search_cb(env, addr, asid, func, to_guest, 0);
+    tlb = loongarch_tlb_search_cb(env, addr, asid, func, to_guest, gid);
     if (tlb) {
         invalidate_tlb(env, tlb - env->tlb, to_guest);
     }
@@ -654,13 +684,18 @@ void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
 void helper_invtlb_page_asid_or_g(CPULoongArchState *env, target_ulong info,
                                   target_ulong addr, uint32_t to_guest)
 {
-    int asid = info & 0x3ff;
+    uint16_t asid = info & R_CSR_ASID_ASID_MASK;
+    uint16_t gid = to_guest ? ((info >> 16) & 0xff) : get_tgid(env);
     const LoongArchTLB *tlb;
     tlb_match func;
 
     func = tlb_match_any;
+    if (to_guest) {
+        do_raise_exception(env, EXCCODE_IPE, GETPC());
+    }
+    to_guest |= env_vm_level(env);
     tlb = loongarch_tlb_search_cb(env, addr, asid, func,
-                                  to_guest, 0);
+                                  to_guest, gid);
     if (tlb) {
         invalidate_tlb(env, tlb - env->tlb, to_guest);
     }
-- 
2.55.0


