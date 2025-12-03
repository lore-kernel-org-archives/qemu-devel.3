Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25475D15DAF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 16:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQpVV-0004As-Li; Wed, 03 Dec 2025 11:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQpVT-00049V-SC
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 11:15:08 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQpVR-0006Wz-4j
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 11:15:07 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3ec4d494383so4723235fac.3
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 08:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764778503; x=1765383303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vDaHa3OjhmYLeTh/hRa4mPVA7rpjuvIfRbEKdqaUiNo=;
 b=Mqf9Z7mgYo7EFOXmYyhYel95YyS6RZMvu86U2UDpMUtvNpT9bN3YH6zLOoxHdrtRXx
 QNalSE6S6h+kP9vMTNQVt0pTUXHfHCtRxBZxXug9gXQ/80ZtWqgiGwydADTpm2ioSX4+
 q6atvADzcHZg86N2odIt3VBmB/efjwjp4PupnQTZ/Od1sro3azpUyodSZKC/zxj4ejfg
 XoYZviKT7gREyiB08MBIiwwjSfEsH0cVu3mQZfgDbHKknY7gZygk0KBihz2PV8TV61Nw
 VOurlinuGF7A7ZJgoqR3CGMq3djp4z8UMSTSlGfleFbHkYopOvduWUSP2RODrn2QtBOX
 23uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764778503; x=1765383303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vDaHa3OjhmYLeTh/hRa4mPVA7rpjuvIfRbEKdqaUiNo=;
 b=QvQ8G7DzN+5X41SktK+BsSik436AePJjnsY+zG0b7GYiE3eb9pNJeFDt54a6WaiJw3
 7MVGtxCgggzZ1qWf5UHeK2OrnfMM3vH1EfIk0AHqN/mFiJcbU0vB/aM8sc1e5/cHSwOU
 IS89EegvU0CdQBAa0H/5M6iIJq4is1xIno8txhn5i1uFpfpOKtQ6hBUiP0XcZsykf0GD
 hXmEXGKcseNAmfNQXUaJ457m6/VMDhIiX90fBaJs0IWJ7G7H7LuJnfUQ96j32FZ4W/OY
 4JCiQxIRTZqRqJqffqXFv4VFpM5xK1XigECUXoicdngKJCDFX1BAyfequFWOSwwLsFzt
 2UNg==
X-Gm-Message-State: AOJu0Yw2O5Picq1CFjwW1cHYVh03eu/r6UbzFSnfrTwx0axwkfc906Jo
 I2asmvQAsJVqOqhDx2ThBsWY0RhhcfbQBN2VVhKShV8+xbjXTyn9JuzkhDf7W59GuWxii2kEsGD
 As+ogiLI=
X-Gm-Gg: ASbGncvjXGXJiHgwSohWDASvpbeekeWRcF+KKnv4w0QBValSOwbaHDrlin0WcmcvU44
 Th45kUMmCnJYOi9JWQDAL5LILWfQQKmtQ1n/Hfh9DqErIe2/GllQxLens7frKwwFoHXfUycfNfi
 wb4/xNQsUJ4A4DBlHWcDGbr7dInjOHn47HcVRJyBjBc5lzTsUP+zP4aaZxchZRUZIBBUHOSlPiF
 gDq5tvgaB1UHqpiEOdvlSdlHNLWw5gInYvSvSKy/hIIPKUXUlgTVbPfhRQOYaB38dCVHWoegk86
 pfFv2ekzrxT1o4ofLmyTTFxVAUgWkPKLnNP3EHEgntxOTd3PBicds+itFXJmlArbLH0BvATVSsq
 j4P96o6/kXtgx6eE/GHdvdxc1U3o7mgnJgXHI7NXxdlLAQrAEEsBc7K1yk6IspCNbKQ9flWlU5a
 ZWwdV1hKMmPgqgYdT22g==
X-Google-Smtp-Source: AGHT+IHtTxrzzQMKGtRHsbYNIoVYSUWSI9H5NR0WsdNnyHrp5J+1LWug8X2UT6aAqeebXNmIL3D2qw==
X-Received: by 2002:a05:6871:450b:b0:3d2:c44b:4d13 with SMTP id
 586e51a60fabf-3f169349771mr1734306fac.32.1764778502849; 
 Wed, 03 Dec 2025 08:15:02 -0800 (PST)
Received: from stoup.. ([187.210.107.189]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dca40d4dsm10141625fac.9.2025.12.03.08.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 08:15:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH v3 1/6] tcg: Zero extend 32-bit addresses for TCI
Date: Wed,  3 Dec 2025 08:14:54 -0800
Message-ID: <20251203161500.501084-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203161500.501084-1-richard.henderson@linaro.org>
References: <20251203161500.501084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For native code generation, zero-extending 32-bit addresses for
the slow path helpers happens in tcg_out_{ld,st}_helper_args,
but there isn't really a slow path for TCI, so that didn't happen.

Make the extension for TCI explicit in the opcode stream,
much like we already do for plugins and atomic helpers.

Cc: qemu-stable@nongnu.org
Fixes: 24e46e6c9d9 ("accel/tcg: Widen tcg-ldst.h addresses to uint64_t")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-ldst.c | 72 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 61 insertions(+), 11 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 67c15fd4d0..1c0b06dbc7 100644
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
2.43.0


