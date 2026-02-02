Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C229CE7FDC8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 19:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmzt4-0000GJ-9H; Mon, 02 Feb 2026 14:47:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzsy-0000Dh-UN; Mon, 02 Feb 2026 14:47:03 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzsx-0003DT-1Z; Mon, 02 Feb 2026 14:47:00 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 10009185099;
 Mon, 02 Feb 2026 22:46:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B713635B27B;
 Mon, 02 Feb 2026 22:46:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.8 07/69] tcg: Zero extend 32-bit addresses for TCI
Date: Mon,  2 Feb 2026 22:45:30 +0300
Message-ID: <20260202194638.939438-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
References: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Richard Henderson <richard.henderson@linaro.org>

For native code generation, zero-extending 32-bit addresses for
the slow path helpers happens in tcg_out_{ld,st}_helper_args,
but there isn't really a slow path for TCI, so that didn't happen.

Make the extension for TCI explicit in the opcode stream,
much like we already do for plugins and atomic helpers.

Cc: qemu-stable@nongnu.org
Fixes: 24e46e6c9d9 ("accel/tcg: Widen tcg-ldst.h addresses to uint64_t")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 41706d3e72d651edb03b4a06b02b490bec8a3ddf)
(Mjt: backport to before v10.0.0-521-gaae2456ac0b4 "tcg: Merge INDEX_op_{ld,st}_{i32,i64,i128}")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 73838e2701..a8f35e1970 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -118,6 +118,30 @@ static void tcg_gen_req_mo(TCGBar type)
     }
 }
 
+static TCGTemp *tci_extend_addr(TCGTemp *addr)
+{
+#ifdef CONFIG_TCG_INTERPRETER
+    /*
+     * 64-bit interpreter requires 64-bit addresses.
+     * Compare to the extension performed by tcg_out_{ld,st}_helper_args
+     * for native code generation.
+     */
+    if (TCG_TARGET_REG_BITS == 64 && tcg_ctx->addr_type == TCG_TYPE_I32) {
+        TCGv_i64 temp = tcg_temp_ebb_new_i64();
+        tcg_gen_extu_i32_i64(temp, temp_tcgv_i32(addr));
+        return tcgv_i64_temp(temp);
+    }
+#endif
+    return addr;
+}
+
+static void maybe_free_addr(TCGTemp *addr, TCGTemp *copy)
+{
+    if (addr != copy) {
+        tcg_temp_free_internal(copy);
+    }
+}
+
 /* Only required for loads, where value might overlap addr. */
 static TCGv_i64 plugin_maybe_preserve_addr(TCGTemp *addr)
 {
@@ -217,6 +241,7 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
     MemOp orig_memop;
     MemOpIdx orig_oi, oi;
     TCGv_i64 copy_addr;
+    TCGTemp *addr_new;
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     orig_memop = memop = tcg_canonicalize_memop(memop, 0, 0);
@@ -231,11 +256,13 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
         oi = make_memop_idx(memop, idx);
     }
 
+    addr_new = tci_extend_addr(addr);
     copy_addr = plugin_maybe_preserve_addr(addr);
     gen_ldst(INDEX_op_qemu_ld_i32, TCG_TYPE_I32,
-             tcgv_i32_temp(val), NULL, addr, oi);
+             tcgv_i32_temp(val), NULL, addr_new, oi);
     plugin_gen_mem_callbacks_i32(val, copy_addr, addr, orig_oi,
                                  QEMU_PLUGIN_MEM_R);
+    maybe_free_addr(addr, addr_new);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         switch (orig_memop & MO_SIZE) {
@@ -267,6 +294,7 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
     TCGv_i32 swap = NULL;
     MemOpIdx orig_oi, oi;
     TCGOpcode opc;
+    TCGTemp *addr_new;
 
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 0, 1);
@@ -294,8 +322,10 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
     } else {
         opc = INDEX_op_qemu_st_i32;
     }
-    gen_ldst(opc, TCG_TYPE_I32, tcgv_i32_temp(val), NULL, addr, oi);
+    addr_new = tci_extend_addr(addr);
+    gen_ldst(opc, TCG_TYPE_I32, tcgv_i32_temp(val), NULL, addr_new, oi);
     plugin_gen_mem_callbacks_i32(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    maybe_free_addr(addr, addr_new);
 
     if (swap) {
         tcg_temp_free_i32(swap);
@@ -316,6 +346,7 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
     MemOp orig_memop;
     MemOpIdx orig_oi, oi;
     TCGv_i64 copy_addr;
+    TCGTemp *addr_new;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_ld_i32_int(TCGV_LOW(val), addr, idx, memop);
@@ -340,10 +371,12 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
         oi = make_memop_idx(memop, idx);
     }
 
+    addr_new = tci_extend_addr(addr);
     copy_addr = plugin_maybe_preserve_addr(addr);
-    gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, oi);
+    gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr_new, oi);
     plugin_gen_mem_callbacks_i64(val, copy_addr, addr, orig_oi,
                                  QEMU_PLUGIN_MEM_R);
+    maybe_free_addr(addr, addr_new);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         int flags = (orig_memop & MO_SIGN
@@ -378,6 +411,7 @@ static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
 {
     TCGv_i64 swap = NULL;
     MemOpIdx orig_oi, oi;
+    TCGTemp *addr_new;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_st_i32_int(TCGV_LOW(val), addr, idx, memop);
@@ -408,8 +442,10 @@ static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
         oi = make_memop_idx(memop, idx);
     }
 
-    gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, oi);
+    addr_new = tci_extend_addr(addr);
+    gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr_new, oi);
     plugin_gen_mem_callbacks_i64(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    maybe_free_addr(addr, addr_new);
 
     if (swap) {
         tcg_temp_free_i64(swap);
@@ -520,6 +556,7 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
 {
     MemOpIdx orig_oi;
     TCGv_i64 ext_addr = NULL;
+    TCGTemp *addr_new;
 
     check_max_alignment(memop_alignment_bits(memop));
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
@@ -547,8 +584,10 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
             hi = TCGV128_HIGH(val);
         }
 
+        addr_new = tci_extend_addr(addr);
         gen_ldst(INDEX_op_qemu_ld_i128, TCG_TYPE_I128, tcgv_i64_temp(lo),
-                 tcgv_i64_temp(hi), addr, oi);
+                 tcgv_i64_temp(hi), addr_new, oi);
+        maybe_free_addr(addr, addr_new);
 
         if (need_bswap) {
             tcg_gen_bswap64_i64(lo, lo);
@@ -576,8 +615,10 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
             y = TCGV128_LOW(val);
         }
 
-        gen_ldst_i64(INDEX_op_qemu_ld_i64, x, addr,
+        addr_new = tci_extend_addr(addr);
+        gen_ldst_i64(INDEX_op_qemu_ld_i64, x, addr_new,
                      make_memop_idx(mop[0], idx));
+        maybe_free_addr(addr, addr_new);
 
         if (need_bswap) {
             tcg_gen_bswap64_i64(x, x);
@@ -593,8 +634,10 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
             addr_p8 = tcgv_i64_temp(t);
         }
 
-        gen_ldst_i64(INDEX_op_qemu_ld_i64, y, addr_p8,
+        addr_new = tci_extend_addr(addr_p8);
+        gen_ldst_i64(INDEX_op_qemu_ld_i64, y, addr_new,
                      make_memop_idx(mop[1], idx));
+        maybe_free_addr(addr_p8, addr_new);
         tcg_temp_free_internal(addr_p8);
 
         if (need_bswap) {
@@ -628,6 +671,7 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
 {
     MemOpIdx orig_oi;
     TCGv_i64 ext_addr = NULL;
+    TCGTemp *addr_new;
 
     check_max_alignment(memop_alignment_bits(memop));
     tcg_gen_req_mo(TCG_MO_ST_LD | TCG_MO_ST_ST);
@@ -658,8 +702,10 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
             hi = TCGV128_HIGH(val);
         }
 
+        addr_new = tci_extend_addr(addr);
         gen_ldst(INDEX_op_qemu_st_i128, TCG_TYPE_I128,
-                 tcgv_i64_temp(lo), tcgv_i64_temp(hi), addr, oi);
+                 tcgv_i64_temp(lo), tcgv_i64_temp(hi), addr_new, oi);
+        maybe_free_addr(addr, addr_new);
 
         if (need_bswap) {
             tcg_temp_free_i64(lo);
@@ -686,8 +732,10 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
             x = b;
         }
 
-        gen_ldst_i64(INDEX_op_qemu_st_i64, x, addr,
+        addr_new = tci_extend_addr(addr);
+        gen_ldst_i64(INDEX_op_qemu_st_i64, x, addr_new,
                      make_memop_idx(mop[0], idx));
+        maybe_free_addr(addr, addr_new);
 
         if (tcg_ctx->addr_type == TCG_TYPE_I32) {
             TCGv_i32 t = tcg_temp_ebb_new_i32();
@@ -699,15 +747,17 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
             addr_p8 = tcgv_i64_temp(t);
         }
 
+        addr_new = tci_extend_addr(addr_p8);
         if (b) {
             tcg_gen_bswap64_i64(b, y);
-            gen_ldst_i64(INDEX_op_qemu_st_i64, b, addr_p8,
+            gen_ldst_i64(INDEX_op_qemu_st_i64, b, addr_new,
                          make_memop_idx(mop[1], idx));
             tcg_temp_free_i64(b);
         } else {
-            gen_ldst_i64(INDEX_op_qemu_st_i64, y, addr_p8,
+            gen_ldst_i64(INDEX_op_qemu_st_i64, y, addr_new,
                          make_memop_idx(mop[1], idx));
         }
+        maybe_free_addr(addr_p8, addr_new);
         tcg_temp_free_internal(addr_p8);
     } else {
         if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-- 
2.47.3


