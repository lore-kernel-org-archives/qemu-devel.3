Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1497ACD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuMA-0007Ef-0F; Tue, 12 May 2026 17:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuLm-0004F6-75; Tue, 12 May 2026 17:09:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuLk-000399-5D; Tue, 12 May 2026 17:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619301; bh=lO/xH7F2XwYwmnWfiZMLGCxPffnBX5YPHn1p7EpmG9s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fHq9U2HGSRiSH4it/rDlCi7kKEjqexWNYEZ6lU0EH0O4mrXa7pDhKIC9KC81lILuQ
 lq7ojYLBEtLgaoJC09j8V52BWZ8NE2G7QG/u/CiE8U+gryC8V5vgCOpnp8Osd56YgF
 HWs92Xb08wOk1sezcKtTOz4s1U57GuanhdajiFI0bI+SapE7qV2wiUWKobWrPcnF7L
 OWyMcpkgRTKzh6Qs195ke8KoC+hIQfL0Amzl7w5KUCHp1/cvhUdGAQ3fRaN2oftCyU
 kX9f8hqT8/74fSqLLSw1iBJVFmmCv7CeeWrDqmKTuadczjWwJzKTvtdJwTrx7c0DAf
 vERGlYbDHGDXA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D36AE1AA35D;
 Tue, 12 May 2026 23:55:01 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E00A23ABCCD;
 Tue, 12 May 2026 23:55:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 032/117] tcg: Pass host-endian values to
 plugin_gen_mem_callbacks_*
Date: Tue, 12 May 2026 23:53:34 +0300
Message-ID: <20260512205503.361097-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

If the host does not support swapped-endian loads and stores,
then we emulate those within the tcg expanders with explicit
bswap operations.

However, we were passing values to the plugin interface in
the middle of those bswap operations, which meant that we
would pass values of the wrong endianness to plugins when
running on hosts without swapped-endian loads and stores.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3351
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260325024252.3369186-2-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
(cherry picked from commit 539421a428fd4b8231d9be042143f2d09c719e2a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 7716c3ad7c..c77e394f6c 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -274,9 +274,6 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
     addr_new = tci_extend_addr(addr);
     copy_addr = plugin_maybe_preserve_addr(addr);
     gen_ldst1(INDEX_op_qemu_ld, TCG_TYPE_I32, tcgv_i32_temp(val), addr_new, oi);
-    plugin_gen_mem_callbacks_i32(val, copy_addr, addr, orig_oi,
-                                 QEMU_PLUGIN_MEM_R);
-    maybe_free_addr(addr, addr_new);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         switch (orig_memop & MO_SIZE) {
@@ -292,6 +289,10 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
             g_assert_not_reached();
         }
     }
+
+    plugin_gen_mem_callbacks_i32(val, copy_addr, addr, orig_oi,
+                                 QEMU_PLUGIN_MEM_R);
+    maybe_free_addr(addr, addr_new);
 }
 
 void tcg_gen_qemu_ld_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,
@@ -302,10 +303,10 @@ void tcg_gen_qemu_ld_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,
     tcg_gen_qemu_ld_i32_int(val, addr, idx, memop);
 }
 
-static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
+static void tcg_gen_qemu_st_i32_int(TCGv_i32 orig_val, TCGTemp *addr,
                                     TCGArg idx, MemOp memop)
 {
-    TCGv_i32 swap = NULL;
+    TCGv_i32 val = orig_val;
     MemOpIdx orig_oi, oi;
     TCGTemp *addr_new;
 
@@ -314,29 +315,29 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
     orig_oi = oi = make_memop_idx(memop, idx);
 
     if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
-        swap = tcg_temp_ebb_new_i32();
+        val = tcg_temp_ebb_new_i32();
         switch (memop & MO_SIZE) {
         case MO_16:
-            tcg_gen_bswap16_i32(swap, val, 0);
+            tcg_gen_bswap16_i32(val, orig_val, 0);
             break;
         case MO_32:
-            tcg_gen_bswap32_i32(swap, val);
+            tcg_gen_bswap32_i32(val, orig_val);
             break;
         default:
             g_assert_not_reached();
         }
-        val = swap;
         memop &= ~MO_BSWAP;
         oi = make_memop_idx(memop, idx);
     }
 
     addr_new = tci_extend_addr(addr);
     gen_ldst1(INDEX_op_qemu_st, TCG_TYPE_I32, tcgv_i32_temp(val), addr_new, oi);
-    plugin_gen_mem_callbacks_i32(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    plugin_gen_mem_callbacks_i32(orig_val, NULL, addr, orig_oi,
+                                 QEMU_PLUGIN_MEM_W);
     maybe_free_addr(addr, addr_new);
 
-    if (swap) {
-        tcg_temp_free_i32(swap);
+    if (val != orig_val) {
+        tcg_temp_free_i32(val);
     }
 }
 
@@ -382,9 +383,6 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
     addr_new = tci_extend_addr(addr);
     copy_addr = plugin_maybe_preserve_addr(addr);
     gen_ld_i64(val, addr_new, oi);
-    plugin_gen_mem_callbacks_i64(val, copy_addr, addr, orig_oi,
-                                 QEMU_PLUGIN_MEM_R);
-    maybe_free_addr(addr, addr_new);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         int flags = (orig_memop & MO_SIGN
@@ -404,6 +402,10 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
             g_assert_not_reached();
         }
     }
+
+    plugin_gen_mem_callbacks_i64(val, copy_addr, addr, orig_oi,
+                                 QEMU_PLUGIN_MEM_R);
+    maybe_free_addr(addr, addr_new);
 }
 
 void tcg_gen_qemu_ld_i64_chk(TCGv_i64 val, TCGTemp *addr, TCGArg idx,
@@ -414,10 +416,10 @@ void tcg_gen_qemu_ld_i64_chk(TCGv_i64 val, TCGTemp *addr, TCGArg idx,
     tcg_gen_qemu_ld_i64_int(val, addr, idx, memop);
 }
 
-static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
+static void tcg_gen_qemu_st_i64_int(TCGv_i64 orig_val, TCGTemp *addr,
                                     TCGArg idx, MemOp memop)
 {
-    TCGv_i64 swap = NULL;
+    TCGv_i64 val = orig_val;
     MemOpIdx orig_oi, oi;
     TCGTemp *addr_new;
 
@@ -431,32 +433,32 @@ static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
     orig_oi = oi = make_memop_idx(memop, idx);
 
     if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
-        swap = tcg_temp_ebb_new_i64();
+        val = tcg_temp_ebb_new_i64();
         switch (memop & MO_SIZE) {
         case MO_16:
-            tcg_gen_bswap16_i64(swap, val, 0);
+            tcg_gen_bswap16_i64(val, orig_val, 0);
             break;
         case MO_32:
-            tcg_gen_bswap32_i64(swap, val, 0);
+            tcg_gen_bswap32_i64(val, orig_val, 0);
             break;
         case MO_64:
-            tcg_gen_bswap64_i64(swap, val);
+            tcg_gen_bswap64_i64(val, orig_val);
             break;
         default:
             g_assert_not_reached();
         }
-        val = swap;
         memop &= ~MO_BSWAP;
         oi = make_memop_idx(memop, idx);
     }
 
     addr_new = tci_extend_addr(addr);
     gen_st_i64(val, addr_new, oi);
-    plugin_gen_mem_callbacks_i64(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    plugin_gen_mem_callbacks_i64(orig_val, NULL, addr, orig_oi,
+                                 QEMU_PLUGIN_MEM_W);
     maybe_free_addr(addr, addr_new);
 
-    if (swap) {
-        tcg_temp_free_i64(swap);
+    if (val != orig_val) {
+        tcg_temp_free_i64(val);
     }
 }
 
-- 
2.47.3


