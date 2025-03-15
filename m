Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC75C28B2F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 07:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttMDO-0000hC-0e; Sat, 15 Mar 2025 03:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttMD5-0008PP-M4; Sat, 15 Mar 2025 03:45:32 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttMD3-00056L-Oc; Sat, 15 Mar 2025 03:45:31 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 032AAFFB12;
 Sat, 15 Mar 2025 10:41:56 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E5F531CACDC;
 Sat, 15 Mar 2025 10:42:49 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A00AD55A10; Sat, 15 Mar 2025 10:42:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stu Grossman <stu.grossman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.10 30/42] target/arm: Correct LDRD atomicity and fault
 behaviour
Date: Sat, 15 Mar 2025 10:42:32 +0300
Message-Id: <20250315074249.634718-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.10-20250315104136@cover.tls.msk.ru>
References: <qemu-stable-8.2.10-20250315104136@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Peter Maydell <peter.maydell@linaro.org>

Our LDRD implementation is wrong in two respects:

 * if the address is 4-aligned and the load crosses a page boundary
   and the second load faults and the first load was to the
   base register (as in cases like "ldrd r2, r3, [r2]", then we
   must not update the base register before taking the fault
 * if the address is 8-aligned the access must be a 64-bit
   single-copy atomic access, not two 32-bit accesses

Rewrite the handling of the loads in LDRD to use a single
tcg_gen_qemu_ld_i64() and split the result into the destination
registers. This allows us to get the atomicity requirements
right, and also implicitly means that we won't update the
base register too early for the page-crossing case.

Note that because we no longer increment 'addr' by 4 in the course of
performing the LDRD we must change the adjustment value we pass to
op_addr_ri_post() and op_addr_rr_post(): it no longer needs to
subtract 4 to get the correct value to use if doing base register
writeback.

STRD has the same problem with not getting the atomicity right;
we will deal with that in the following commit.

Cc: qemu-stable@nongnu.org
Reported-by: Stu Grossman <stu.grossman@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250227142746.1698904-2-peter.maydell@linaro.org
(cherry picked from commit cde3247651dc998da5dc1005148302a90d72f21f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index e555e885a1..08ae9484de 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6588,10 +6588,49 @@ static bool op_store_rr(DisasContext *s, arg_ldst_rr *a,
     return true;
 }
 
-static bool trans_LDRD_rr(DisasContext *s, arg_ldst_rr *a)
+static void do_ldrd_load(DisasContext *s, TCGv_i32 addr, int rt, int rt2)
 {
+    /*
+     * LDRD is required to be an atomic 64-bit access if the
+     * address is 8-aligned, two atomic 32-bit accesses if
+     * it's only 4-aligned, and to give an alignment fault
+     * if it's not 4-aligned. This is MO_ALIGN_4 | MO_ATOM_SUBALIGN.
+     * Rt is always the word from the lower address, and Rt2 the
+     * data from the higher address, regardless of endianness.
+     * So (like gen_load_exclusive) we avoid gen_aa32_ld_i64()
+     * so we don't get its SCTLR_B check, and instead do a 64-bit access
+     * using MO_BE if appropriate and then split the two halves.
+     *
+     * For M-profile, and for A-profile before LPAE, the 64-bit
+     * atomicity is not required. We could model that using
+     * the looser MO_ATOM_IFALIGN_PAIR, but providing a higher
+     * level of atomicity than required is harmless (we would not
+     * currently generate better code for IFALIGN_PAIR here).
+     *
+     * This also gives us the correct behaviour of not updating
+     * rt if the load of rt2 faults; this is required for cases
+     * like "ldrd r2, r3, [r2]" where rt is also the base register.
+     */
     int mem_idx = get_mem_index(s);
-    TCGv_i32 addr, tmp;
+    MemOp opc = MO_64 | MO_ALIGN_4 | MO_ATOM_SUBALIGN | s->be_data;
+    TCGv taddr = gen_aa32_addr(s, addr, opc);
+    TCGv_i64 t64 = tcg_temp_new_i64();
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    TCGv_i32 tmp2 = tcg_temp_new_i32();
+
+    tcg_gen_qemu_ld_i64(t64, taddr, mem_idx, opc);
+    if (s->be_data == MO_BE) {
+        tcg_gen_extr_i64_i32(tmp2, tmp, t64);
+    } else {
+        tcg_gen_extr_i64_i32(tmp, tmp2, t64);
+    }
+    store_reg(s, rt, tmp);
+    store_reg(s, rt2, tmp2);
+}
+
+static bool trans_LDRD_rr(DisasContext *s, arg_ldst_rr *a)
+{
+    TCGv_i32 addr;
 
     if (!ENABLE_ARCH_5TE) {
         return false;
@@ -6602,18 +6641,10 @@ static bool trans_LDRD_rr(DisasContext *s, arg_ldst_rr *a)
     }
     addr = op_addr_rr_pre(s, a);
 
-    tmp = tcg_temp_new_i32();
-    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
-    store_reg(s, a->rt, tmp);
-
-    tcg_gen_addi_i32(addr, addr, 4);
-
-    tmp = tcg_temp_new_i32();
-    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
-    store_reg(s, a->rt + 1, tmp);
+    do_ldrd_load(s, addr, a->rt, a->rt + 1);
 
     /* LDRD w/ base writeback is undefined if the registers overlap.  */
-    op_addr_rr_post(s, a, addr, -4);
+    op_addr_rr_post(s, a, addr, 0);
     return true;
 }
 
@@ -6737,23 +6768,14 @@ static bool op_store_ri(DisasContext *s, arg_ldst_ri *a,
 
 static bool op_ldrd_ri(DisasContext *s, arg_ldst_ri *a, int rt2)
 {
-    int mem_idx = get_mem_index(s);
-    TCGv_i32 addr, tmp;
+    TCGv_i32 addr;
 
     addr = op_addr_ri_pre(s, a);
 
-    tmp = tcg_temp_new_i32();
-    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
-    store_reg(s, a->rt, tmp);
-
-    tcg_gen_addi_i32(addr, addr, 4);
-
-    tmp = tcg_temp_new_i32();
-    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
-    store_reg(s, rt2, tmp);
+    do_ldrd_load(s, addr, a->rt, rt2);
 
     /* LDRD w/ base writeback is undefined if the registers overlap.  */
-    op_addr_ri_post(s, a, addr, -4);
+    op_addr_ri_post(s, a, addr, 0);
     return true;
 }
 
-- 
2.39.5


