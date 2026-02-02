Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7656E7FDDA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn117-0004DF-FL; Mon, 02 Feb 2026 15:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn10l-00042M-6e; Mon, 02 Feb 2026 15:59:09 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn10O-0003ky-Od; Mon, 02 Feb 2026 15:58:57 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C5A7818518E;
 Mon, 02 Feb 2026 23:57:51 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8DCCA35B305;
 Mon, 02 Feb 2026 23:58:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 02/74] tcg: Zero extend 32-bit addresses for TCI
Date: Mon,  2 Feb 2026 23:57:13 +0300
Message-ID: <20260202205833.941615-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
References: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
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
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 548496002d..572b1e84d4 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -135,6 +135,30 @@ static void tcg_gen_req_mo(TCGBar type)
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
@@ -234,6 +258,7 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
     MemOp orig_memop;
     MemOpIdx orig_oi, oi;
     TCGv_i64 copy_addr;
+    TCGTemp *addr_new;
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     orig_memop = memop = tcg_canonicalize_memop(memop, 0, 0);
@@ -248,10 +273,12 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
         oi = make_memop_idx(memop, idx);
     }
 
+    addr_new = tci_extend_addr(addr);
     copy_addr = plugin_maybe_preserve_addr(addr);
-    gen_ldst1(INDEX_op_qemu_ld, TCG_TYPE_I32, tcgv_i32_temp(val), addr, oi);
+    gen_ldst1(INDEX_op_qemu_ld, TCG_TYPE_I32, tcgv_i32_temp(val), addr_new, oi);
     plugin_gen_mem_callbacks_i32(val, copy_addr, addr, orig_oi,
                                  QEMU_PLUGIN_MEM_R);
+    maybe_free_addr(addr, addr_new);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         switch (orig_memop & MO_SIZE) {
@@ -282,6 +309,7 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
 {
     TCGv_i32 swap = NULL;
     MemOpIdx orig_oi, oi;
+    TCGTemp *addr_new;
 
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 0, 1);
@@ -304,8 +332,10 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
         oi = make_memop_idx(memop, idx);
     }
 
-    gen_ldst1(INDEX_op_qemu_st, TCG_TYPE_I32, tcgv_i32_temp(val), addr, oi);
+    addr_new = tci_extend_addr(addr);
+    gen_ldst1(INDEX_op_qemu_st, TCG_TYPE_I32, tcgv_i32_temp(val), addr_new, oi);
     plugin_gen_mem_callbacks_i32(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    maybe_free_addr(addr, addr_new);
 
     if (swap) {
         tcg_temp_free_i32(swap);
@@ -326,6 +356,7 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
     MemOp orig_memop;
     MemOpIdx orig_oi, oi;
     TCGv_i64 copy_addr;
+    TCGTemp *addr_new;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_ld_i32_int(TCGV_LOW(val), addr, idx, memop);
@@ -350,10 +381,12 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
         oi = make_memop_idx(memop, idx);
     }
 
+    addr_new = tci_extend_addr(addr);
     copy_addr = plugin_maybe_preserve_addr(addr);
-    gen_ld_i64(val, addr, oi);
+    gen_ld_i64(val, addr_new, oi);
     plugin_gen_mem_callbacks_i64(val, copy_addr, addr, orig_oi,
                                  QEMU_PLUGIN_MEM_R);
+    maybe_free_addr(addr, addr_new);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         int flags = (orig_memop & MO_SIGN
@@ -388,6 +421,7 @@ static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
 {
     TCGv_i64 swap = NULL;
     MemOpIdx orig_oi, oi;
+    TCGTemp *addr_new;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_st_i32_int(TCGV_LOW(val), addr, idx, memop);
@@ -418,8 +452,10 @@ static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
         oi = make_memop_idx(memop, idx);
     }
 
-    gen_st_i64(val, addr, oi);
+    addr_new = tci_extend_addr(addr);
+    gen_st_i64(val, addr_new, oi);
     plugin_gen_mem_callbacks_i64(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    maybe_free_addr(addr, addr_new);
 
     if (swap) {
         tcg_temp_free_i64(swap);
@@ -530,6 +566,7 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
 {
     MemOpIdx orig_oi;
     TCGv_i64 ext_addr = NULL;
+    TCGTemp *addr_new;
 
     check_max_alignment(memop_alignment_bits(memop));
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
@@ -557,8 +594,10 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
             hi = TCGV128_HIGH(val);
         }
 
+        addr_new = tci_extend_addr(addr);
         gen_ldst2(INDEX_op_qemu_ld2, TCG_TYPE_I128, tcgv_i64_temp(lo),
-                  tcgv_i64_temp(hi), addr, oi);
+                  tcgv_i64_temp(hi), addr_new, oi);
+        maybe_free_addr(addr, addr_new);
 
         if (need_bswap) {
             tcg_gen_bswap64_i64(lo, lo);
@@ -586,7 +625,9 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
             y = TCGV128_LOW(val);
         }
 
-        gen_ld_i64(x, addr, make_memop_idx(mop[0], idx));
+        addr_new = tci_extend_addr(addr);
+        gen_ld_i64(x, addr_new, make_memop_idx(mop[0], idx));
+        maybe_free_addr(addr, addr_new);
 
         if (need_bswap) {
             tcg_gen_bswap64_i64(x, x);
@@ -602,7 +643,9 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
             addr_p8 = tcgv_i64_temp(t);
         }
 
-        gen_ld_i64(y, addr_p8, make_memop_idx(mop[1], idx));
+        addr_new = tci_extend_addr(addr_p8);
+        gen_ld_i64(y, addr_new, make_memop_idx(mop[1], idx));
+        maybe_free_addr(addr_p8, addr_new);
         tcg_temp_free_internal(addr_p8);
 
         if (need_bswap) {
@@ -636,6 +679,7 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
 {
     MemOpIdx orig_oi;
     TCGv_i64 ext_addr = NULL;
+    TCGTemp *addr_new;
 
     check_max_alignment(memop_alignment_bits(memop));
     tcg_gen_req_mo(TCG_MO_ST_LD | TCG_MO_ST_ST);
@@ -666,8 +710,10 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
             hi = TCGV128_HIGH(val);
         }
 
+        addr_new = tci_extend_addr(addr);
         gen_ldst2(INDEX_op_qemu_st2, TCG_TYPE_I128,
-                  tcgv_i64_temp(lo), tcgv_i64_temp(hi), addr, oi);
+                  tcgv_i64_temp(lo), tcgv_i64_temp(hi), addr_new, oi);
+        maybe_free_addr(addr, addr_new);
 
         if (need_bswap) {
             tcg_temp_free_i64(lo);
@@ -694,7 +740,9 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
             x = b;
         }
 
-        gen_st_i64(x, addr, make_memop_idx(mop[0], idx));
+        addr_new = tci_extend_addr(addr);
+        gen_st_i64(x, addr_new, make_memop_idx(mop[0], idx));
+        maybe_free_addr(addr, addr_new);
 
         if (tcg_ctx->addr_type == TCG_TYPE_I32) {
             TCGv_i32 t = tcg_temp_ebb_new_i32();
@@ -706,13 +754,15 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
             addr_p8 = tcgv_i64_temp(t);
         }
 
+        addr_new = tci_extend_addr(addr_p8);
         if (b) {
             tcg_gen_bswap64_i64(b, y);
-            gen_st_i64(b, addr_p8, make_memop_idx(mop[1], idx));
+            gen_st_i64(b, addr_new, make_memop_idx(mop[1], idx));
             tcg_temp_free_i64(b);
         } else {
-            gen_st_i64(y, addr_p8, make_memop_idx(mop[1], idx));
+            gen_st_i64(y, addr_new, make_memop_idx(mop[1], idx));
         }
+        maybe_free_addr(addr_p8, addr_new);
         tcg_temp_free_internal(addr_p8);
     } else {
         if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-- 
2.47.3


