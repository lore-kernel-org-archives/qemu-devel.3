Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FF9112583E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LBk-0001B7-VS; Wed, 11 Mar 2026 11:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L8l-0003Pa-KX; Wed, 11 Mar 2026 11:06:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L8j-0004nn-B4; Wed, 11 Mar 2026 11:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241306; bh=EvXZ/BWz1i2r9aDeNNCZTHrXhtgOfDxjw5qN58btyc8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oNDNaxIFya/qgZGx2yPQ91x/1/cvzkaumJjaJxSHc5Tkjq6zviFf2QtSw0dmBCgn6
 PNuvVtV7/aL85Lv1S4kF1ULyDOlV62Ao6mv6EOE8USYI2/LYPQ0bDWsJvuq1TDQErr
 tK27NthUzIvMHT1fp7Sm8TGkPc1Ax1WLSGk/0cfdsp+zYctiTpQNjNfQH1OdH/lpv1
 OWiqn5YEGpOUXveuV99hZVzl2YboeY/2WNdxBafJf3SbPHlcBNCePfnLEy51VYYqym
 v1sPOLXXctk9yhNn2RyX9tdm3TLlApyBtjClIi7sYvBgLyRXhXw6GCJHsL0EzqDm+g
 6YAQ9IWTg9dYQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6FFB0191E69;
 Wed, 11 Mar 2026 18:01:46 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5BEC937C2BB;
 Wed, 11 Mar 2026 18:02:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, rail5 <andrew@rail5.org>,
 Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.9 43/44] target/loongarch: Preserve PTE permission bits
 in LDPTE
Date: Wed, 11 Mar 2026 18:02:15 +0300
Message-ID: <20260311150221.1084186-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
References: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: rail5 <andrew@rail5.org>

The LDPTE helper loads a page table entry (or huge page entry) from guest
memory and currently applies the PALEN mask to the whole 64-bit value.

That mask is intended to constrain the physical address bits, but masking
the full entry also clears upper permission bits in the PTE, including NX
(bit 62). As a result, LoongArch TCG can incorrectly allow instruction
fetches from NX mappings when translation is driven through software
page-walk.

Fix this by masking only the PPN/address field with PALEN while preserving
permission bits, and by clearing any non-architectural (software) bits
using a hardware PTE mask. LDDIR is unchanged since it returns the base
address of the next page table level.

Reported at: https://gitlab.com/qemu-project/qemu/-/issues/3319

Fixes: 56599a705f2 ("target/loongarch: Introduce loongarch_palen_mask()")
Cc: qemu-stable@nongnu.org
Signed-off-by: rail5 (Andrew S. Rightenburg) <andrew@rail5.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
(cherry picked from commit 2d877bc02a3b94998cbdd784d194c173d308a98a)
(Mjt: backport to 10.0.x which lacks v10.2.0-1568-g56599a705f
 "target/loongarch: Introduce loongarch_palen_mask()")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 364db7fab8..84b86da308 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -554,6 +554,17 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
 
 #ifdef CONFIG_TCG
     env->fcsr0_mask = FCSR0_M1 | FCSR0_M2 | FCSR0_M3;
+
+    if (is_la64(env)) {
+        env->hw_pte_mask = MAKE_64BIT_MASK(0, 9) |
+                           R_TLBENTRY_64_PPN_MASK |
+                           R_TLBENTRY_64_NR_MASK |
+                           R_TLBENTRY_64_NX_MASK |
+                           R_TLBENTRY_64_RPLV_MASK;
+    } else {
+        env->hw_pte_mask = MAKE_64BIT_MASK(0, 9) |
+                           R_TLBENTRY_32_PPN_MASK;
+    }
 #endif
     env->fcsr0 = 0x0;
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ab76a0b451..a9bd969b85 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -378,6 +378,7 @@ typedef struct CPUArchState {
     uint32_t fcsr0_mask;
     uint64_t lladdr; /* LL virtual address compared against SC */
     uint64_t llval;
+    uint64_t hw_pte_mask; /* Mask of architecturally-defined (hardware) PTE bits. */
 #endif
 #ifndef CONFIG_USER_ONLY
 #ifdef CONFIG_TCG
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 70d1b5cf99..e71faa6ce8 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -539,6 +539,20 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     cpu_loop_exit_restore(cs, retaddr);
 }
 
+static inline uint64_t loongarch_sanitize_hw_pte(CPULoongArchState *env,
+                                                 uint64_t pte)
+{
+    uint64_t ppn_mask = is_la64(env) ? R_TLBENTRY_64_PPN_MASK : R_TLBENTRY_32_PPN_MASK;
+
+    /*
+     * Keep only architecturally-defined PTE bits. Guests may use some
+     * otherwise-unused bits for software purposes.
+     */
+    pte &= env->hw_pte_mask;
+
+    return (pte & ~ppn_mask) | ((pte & ppn_mask) & TARGET_PHYS_MASK);
+}
+
 target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
                           target_ulong level, uint32_t mem_idx)
 {
@@ -579,6 +593,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
 {
     CPUState *cs = env_cpu(env);
     target_ulong phys, tmp0, ptindex, ptoffset0, ptoffset1, ps, badv;
+    uint64_t pte_raw;
     uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
     uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
     uint64_t dir_base, dir_width;
@@ -590,7 +605,6 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
      * and the other is the huge page entry,
      * whose bit 6 should be 1.
      */
-    base = base & TARGET_PHYS_MASK;
     if (FIELD_EX64(base, TLBENTRY, HUGE)) {
         /*
          * Gets the huge page level and Gets huge page size.
@@ -614,19 +628,22 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
          * when loaded into the tlb,
          * so the tlb page size needs to be divided by 2.
          */
-        tmp0 = base;
+        tmp0 = loongarch_sanitize_hw_pte(env, base);
         if (odd) {
             tmp0 += MAKE_64BIT_MASK(ps, 1);
         }
     } else {
         badv = env->CSR_TLBRBADV;
 
+        base = base & TARGET_PHYS_MASK;
+
         ptindex = (badv >> ptbase) & ((1 << ptwidth) - 1);
         ptindex = ptindex & ~0x1;   /* clear bit 0 */
         ptoffset0 = ptindex << 3;
         ptoffset1 = (ptindex + 1) << 3;
         phys = base | (odd ? ptoffset1 : ptoffset0);
-        tmp0 = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
+        pte_raw = ldq_le_phys(cs->as, phys);
+        tmp0 = loongarch_sanitize_hw_pte(env, pte_raw);
         ps = ptbase;
     }
 
-- 
2.47.3


