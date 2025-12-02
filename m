Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D71FD116F1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 01:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQEwd-0001KA-6n; Mon, 01 Dec 2025 20:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQEwW-0001Io-UY
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 20:12:38 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQEwT-0007BD-Sl
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 20:12:36 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3ec46e3c65bso4085031fac.0
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 17:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764637952; x=1765242752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WynUtuuokXUbONodInAeO6RSF32Dk2kzzljIHwelHoQ=;
 b=kpy4At+Rt5Pov3Om0v7m9x3V9ORDLda2C80gTtQEymORILaKmuJVAA+ceRH3bMoRG5
 b1vbAYO7nOCkwFqUJkQ2o07j49tX136rTqYnSLdX0Oa4yjQNNIcwKVr9IBjuvZAdhWR7
 u+N5UT8amGZkAJDz5zFnRhIRlfu7v5JRey9uVysuFfUXjPgwqmgxtkvWoZzclwsP5jQp
 ar4bn/6+Oa2BRCLr+3hHmD/X1dQdPtSG8SRn040xqVf4AC0PoQP/ocynpZilqLceyBsa
 V3BML9avokPWt6UY6Ax+e1feEkr8p08anvpn+EtQvwbk/D90GaoX45lVfZHIzdkQIXuZ
 /IyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764637952; x=1765242752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WynUtuuokXUbONodInAeO6RSF32Dk2kzzljIHwelHoQ=;
 b=HNlnmjq01ZJkTXjg7imx0FqVw/tMJkc6ClaufXL99EFhVvP2n+KK37C148sVjXTDpC
 c4BzZiAJDqVRmaeyQ2/MW1rsJ5EfIzCkQxAOCfsDm4CJ+vENoOe6O2/9WVnTFPIGAjAz
 AjBOHheHzJXxlnc/jOORr9fEStkuLCeaznnShvOFl+vXWMl89EWD2lsdCn3QhqgHD0Jr
 2midkJXzsQuUC25HZKMsWuGDwSzCW0rvKUqxRGmjKEXJ/Cu80K6pImE+ohFLxmIewO63
 I869y8e80oxFcylIGKSuq7ovcxQvaXFn3evAbw3WhsXsQbZDuaHIRxcinxN2UDtbVc0Q
 A7vA==
X-Gm-Message-State: AOJu0YwlwClZM1VHcQON87TlWPk3wr5QoU4e3Kpwq+O3XdJYOkIYzpvl
 wD1PFfoY0pGnD7X8u9YYbc82wRTjMRxbVUqhmzqxXZbmCw03swzxox+8mzsrLYBVsCLyFzFm29a
 GR1b3alg=
X-Gm-Gg: ASbGncsGYxvRRJETDTrZwqUGcO2fs5K6C/czf36ktqTwwyZqOUaW9oNzoqwFDR03y9O
 u4/VsL5JaSHjh67KineAyXDE4H048YY5r1YL3nfKuYnKT0ZrGPU7ZEpRs2/hebqb3yBovEQVG9C
 4WNq4bGb5h6ydi2ZhfjD1xBNv27EUMxRGGO+TxeQp9sPvJWB5/bOh6WGV33efX1lb8oq6IBm8j+
 GPGEvEeAJY6BrG56u6wKQCoU6ksvP2GA5+SNFqn3uapx3i4Es/VwDa1hp+x3VcFa5S4AgmPeQq1
 K8+i00GQaYddJehv1Ik/NnRBi9nlTw0p3idLoAmJKtAZLfvxWC1t+TdD6Swlkl7NLTzJifmmfr6
 wj4quqkr58NqHa6P2WcRXRW/Aay8f9B/b9658vHdNMrXjYLoi/Ngijv1o74SptUbFTfaAOf+EUa
 869hwDOyBJ7Z86tOo=
X-Google-Smtp-Source: AGHT+IEHvcOVwZSq8a3wP5n6jBlUOfaPtVVDst6g94gnzAwbqA7CC9ziDcM6vgal7YTYFIGzkJZgDQ==
X-Received: by 2002:a05:6871:2edd:b0:3dd:6bdb:e741 with SMTP id
 586e51a60fabf-3ecbe52a500mr19744817fac.26.1764637952428; 
 Mon, 01 Dec 2025 17:12:32 -0800 (PST)
Received: from stoup.. ([201.144.25.11]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd05bc9asm6458709fac.22.2025.12.01.17.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 17:12:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	peter.maydell@linaro.org
Subject: [PATCH 2/2] tcg: Zero extend 32-bit addresses for TCI
Date: Mon,  1 Dec 2025 17:12:27 -0800
Message-ID: <20251202011228.503007-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202011228.503007-1-richard.henderson@linaro.org>
References: <20251202011228.503007-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fixes: 24e46e6c9d9 ("accel/tcg: Widen tcg-ldst.h addresses to uint64_t")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-ldst.c | 222 ++++++++++++++++++++++------------------------
 1 file changed, 107 insertions(+), 115 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 67c15fd4d0..8e2adef688 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -135,54 +135,53 @@ static void tcg_gen_req_mo(TCGBar type)
     }
 }
 
-/* Only required for loads, where value might overlap addr. */
-static TCGv_i64 plugin_maybe_preserve_addr(TCGTemp *addr)
+static TCGTemp *maybe_extend_or_copy_addr(TCGTemp *addr,
+                                          TCGTemp *data, bool force)
 {
-#ifdef CONFIG_PLUGIN
+    bool do_ext = tcg_ctx->addr_type == TCG_TYPE_I32;
+
+#ifdef CONFIG_TCG_INTERPRETER
+    force = true;
+#elif defined(CONFIG_PLUGIN)
     if (tcg_ctx->plugin_insn != NULL) {
-        /* Save a copy of the vaddr for use after a load.  */
-        TCGv_i64 temp = tcg_temp_ebb_new_i64();
-        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-            tcg_gen_extu_i32_i64(temp, temp_tcgv_i32(addr));
-        } else {
+        if (!do_ext && data == addr) {
+            /* Save a copy of the vaddr for use after a load.  */
+            TCGv_i64 temp = tcg_temp_ebb_new_i64();
             tcg_gen_mov_i64(temp, temp_tcgv_i64(addr));
+            return tcgv_i64_temp(temp);
         }
-        return temp;
+        force = true;
     }
 #endif
-    return NULL;
+    if (force && do_ext) {
+        TCGv_i64 temp = tcg_temp_ebb_new_i64();
+        tcg_gen_extu_i32_i64(temp, temp_tcgv_i32(addr));
+        return tcgv_i64_temp(temp);
+    }
+    return addr;
+}
+
+static void maybe_free_addr(TCGTemp *addr, TCGTemp *ext_addr)
+{
+    if (addr != ext_addr) {
+        tcg_temp_free_internal(ext_addr);
+    }
 }
 
 #ifdef CONFIG_PLUGIN
 static void
-plugin_gen_mem_callbacks(TCGv_i64 copy_addr, TCGTemp *orig_addr, MemOpIdx oi,
+plugin_gen_mem_callbacks(TCGTemp *ext_addr, MemOpIdx oi,
                          enum qemu_plugin_mem_rw rw)
 {
     if (tcg_ctx->plugin_insn != NULL) {
         qemu_plugin_meminfo_t info = make_plugin_meminfo(oi, rw);
-
-        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-            if (!copy_addr) {
-                copy_addr = tcg_temp_ebb_new_i64();
-                tcg_gen_extu_i32_i64(copy_addr, temp_tcgv_i32(orig_addr));
-            }
-            tcg_gen_plugin_mem_cb(copy_addr, info);
-            tcg_temp_free_i64(copy_addr);
-        } else {
-            if (copy_addr) {
-                tcg_gen_plugin_mem_cb(copy_addr, info);
-                tcg_temp_free_i64(copy_addr);
-            } else {
-                tcg_gen_plugin_mem_cb(temp_tcgv_i64(orig_addr), info);
-            }
-        }
+        tcg_gen_plugin_mem_cb(temp_tcgv_i64(ext_addr), info);
     }
 }
 #endif
 
 static void
-plugin_gen_mem_callbacks_i32(TCGv_i32 val,
-                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
+plugin_gen_mem_callbacks_i32(TCGv_i32 val, TCGTemp *ext_addr,
                              MemOpIdx oi, enum qemu_plugin_mem_rw rw)
 {
 #ifdef CONFIG_PLUGIN
@@ -190,14 +189,13 @@ plugin_gen_mem_callbacks_i32(TCGv_i32 val,
         tcg_gen_st_i32(val, tcg_env,
                        offsetof(CPUState, neg.plugin_mem_value_low) -
                        sizeof(CPUState) + (HOST_BIG_ENDIAN * 4));
-        plugin_gen_mem_callbacks(copy_addr, orig_addr, oi, rw);
+        plugin_gen_mem_callbacks(ext_addr, oi, rw);
     }
 #endif
 }
 
 static void
-plugin_gen_mem_callbacks_i64(TCGv_i64 val,
-                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
+plugin_gen_mem_callbacks_i64(TCGv_i64 val, TCGTemp *ext_addr,
                              MemOpIdx oi, enum qemu_plugin_mem_rw rw)
 {
 #ifdef CONFIG_PLUGIN
@@ -205,15 +203,14 @@ plugin_gen_mem_callbacks_i64(TCGv_i64 val,
         tcg_gen_st_i64(val, tcg_env,
                        offsetof(CPUState, neg.plugin_mem_value_low) -
                        sizeof(CPUState));
-        plugin_gen_mem_callbacks(copy_addr, orig_addr, oi, rw);
+        plugin_gen_mem_callbacks(ext_addr, oi, rw);
     }
 #endif
 }
 
 static void
-plugin_gen_mem_callbacks_i128(TCGv_i128 val,
-                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
-                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
+plugin_gen_mem_callbacks_i128(TCGv_i128 val, TCGTemp *ext_addr,
+                              MemOpIdx oi, enum qemu_plugin_mem_rw rw)
 {
 #ifdef CONFIG_PLUGIN
     if (tcg_ctx->plugin_insn != NULL) {
@@ -223,7 +220,7 @@ plugin_gen_mem_callbacks_i128(TCGv_i128 val,
         tcg_gen_st_i64(TCGV128_HIGH(val), tcg_env,
                        offsetof(CPUState, neg.plugin_mem_value_high) -
                        sizeof(CPUState));
-        plugin_gen_mem_callbacks(copy_addr, orig_addr, oi, rw);
+        plugin_gen_mem_callbacks(ext_addr, oi, rw);
     }
 #endif
 }
@@ -233,7 +230,7 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
 {
     MemOp orig_memop;
     MemOpIdx orig_oi, oi;
-    TCGv_i64 copy_addr;
+    TCGTemp *ext_addr;
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     orig_memop = memop = tcg_canonicalize_memop(memop, 0, 0);
@@ -248,10 +245,10 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
         oi = make_memop_idx(memop, idx);
     }
 
-    copy_addr = plugin_maybe_preserve_addr(addr);
-    gen_ldst1(INDEX_op_qemu_ld, TCG_TYPE_I32, tcgv_i32_temp(val), addr, oi);
-    plugin_gen_mem_callbacks_i32(val, copy_addr, addr, orig_oi,
-                                 QEMU_PLUGIN_MEM_R);
+    ext_addr = maybe_extend_or_copy_addr(addr, tcgv_i32_temp(val), false);
+    gen_ldst1(INDEX_op_qemu_ld, TCG_TYPE_I32, tcgv_i32_temp(val), ext_addr, oi);
+    plugin_gen_mem_callbacks_i32(val, ext_addr, orig_oi, QEMU_PLUGIN_MEM_R);
+    maybe_free_addr(addr, ext_addr);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         switch (orig_memop & MO_SIZE) {
@@ -282,6 +279,7 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
 {
     TCGv_i32 swap = NULL;
     MemOpIdx orig_oi, oi;
+    TCGTemp *ext_addr;
 
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 0, 1);
@@ -304,8 +302,10 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
         oi = make_memop_idx(memop, idx);
     }
 
-    gen_ldst1(INDEX_op_qemu_st, TCG_TYPE_I32, tcgv_i32_temp(val), addr, oi);
-    plugin_gen_mem_callbacks_i32(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    ext_addr = maybe_extend_or_copy_addr(addr, NULL, false);
+    gen_ldst1(INDEX_op_qemu_st, TCG_TYPE_I32, tcgv_i32_temp(val), ext_addr, oi);
+    plugin_gen_mem_callbacks_i32(val, ext_addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    maybe_free_addr(addr, ext_addr);
 
     if (swap) {
         tcg_temp_free_i32(swap);
@@ -325,7 +325,7 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
 {
     MemOp orig_memop;
     MemOpIdx orig_oi, oi;
-    TCGv_i64 copy_addr;
+    TCGTemp *ext_addr;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_ld_i32_int(TCGV_LOW(val), addr, idx, memop);
@@ -350,10 +350,10 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
         oi = make_memop_idx(memop, idx);
     }
 
-    copy_addr = plugin_maybe_preserve_addr(addr);
-    gen_ld_i64(val, addr, oi);
-    plugin_gen_mem_callbacks_i64(val, copy_addr, addr, orig_oi,
-                                 QEMU_PLUGIN_MEM_R);
+    ext_addr = maybe_extend_or_copy_addr(addr, tcgv_i64_temp(val), false);
+    gen_ld_i64(val, ext_addr, oi);
+    plugin_gen_mem_callbacks_i64(val, ext_addr, orig_oi, QEMU_PLUGIN_MEM_R);
+    maybe_free_addr(addr, ext_addr);
 
     if ((orig_memop ^ memop) & MO_BSWAP) {
         int flags = (orig_memop & MO_SIGN
@@ -388,6 +388,7 @@ static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
 {
     TCGv_i64 swap = NULL;
     MemOpIdx orig_oi, oi;
+    TCGTemp *ext_addr;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_st_i32_int(TCGV_LOW(val), addr, idx, memop);
@@ -418,8 +419,10 @@ static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
         oi = make_memop_idx(memop, idx);
     }
 
-    gen_st_i64(val, addr, oi);
-    plugin_gen_mem_callbacks_i64(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    ext_addr = maybe_extend_or_copy_addr(addr, NULL, false);
+    gen_st_i64(val, ext_addr, oi);
+    plugin_gen_mem_callbacks_i64(val, ext_addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    maybe_free_addr(addr, ext_addr);
 
     if (swap) {
         tcg_temp_free_i64(swap);
@@ -508,28 +511,11 @@ static void canonicalize_memop_i128_as_i64(MemOp ret[2], MemOp orig)
     ret[1] = mop_2;
 }
 
-static TCGv_i64 maybe_extend_addr64(TCGTemp *addr)
-{
-    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-        TCGv_i64 a64 = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(a64, temp_tcgv_i32(addr));
-        return a64;
-    }
-    return temp_tcgv_i64(addr);
-}
-
-static void maybe_free_addr64(TCGv_i64 a64)
-{
-    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-        tcg_temp_free_i64(a64);
-    }
-}
-
 static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
                                      TCGArg idx, MemOp memop)
 {
     MemOpIdx orig_oi;
-    TCGv_i64 ext_addr = NULL;
+    TCGTemp *ext_addr;
 
     check_max_alignment(memop_alignment_bits(memop));
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
@@ -540,6 +526,7 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
         memop |= MO_ATOM_NONE;
     }
     orig_oi = make_memop_idx(memop, idx);
+    ext_addr = maybe_extend_or_copy_addr(addr, NULL, false);
 
     /* TODO: For now, force 32-bit hosts to use the helper. */
     if (TCG_TARGET_HAS_qemu_ldst_i128 && TCG_TARGET_REG_BITS == 64) {
@@ -558,7 +545,7 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
         }
 
         gen_ldst2(INDEX_op_qemu_ld2, TCG_TYPE_I128, tcgv_i64_temp(lo),
-                  tcgv_i64_temp(hi), addr, oi);
+                  tcgv_i64_temp(hi), ext_addr, oi);
 
         if (need_bswap) {
             tcg_gen_bswap64_i64(lo, lo);
@@ -566,7 +553,7 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
         }
     } else if (use_two_i64_for_i128(memop)) {
         MemOp mop[2];
-        TCGTemp *addr_p8;
+        TCGTemp *addr_p8, *ext_addr_p8;
         TCGv_i64 x, y;
         bool need_bswap;
 
@@ -586,7 +573,7 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
             y = TCGV128_LOW(val);
         }
 
-        gen_ld_i64(x, addr, make_memop_idx(mop[0], idx));
+        gen_ld_i64(x, ext_addr, make_memop_idx(mop[0], idx));
 
         if (need_bswap) {
             tcg_gen_bswap64_i64(x, x);
@@ -601,25 +588,25 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
             tcg_gen_addi_i64(t, temp_tcgv_i64(addr), 8);
             addr_p8 = tcgv_i64_temp(t);
         }
+        ext_addr_p8 = maybe_extend_or_copy_addr(addr_p8, NULL, false);
 
         gen_ld_i64(y, addr_p8, make_memop_idx(mop[1], idx));
+        maybe_free_addr(addr_p8, ext_addr_p8);
         tcg_temp_free_internal(addr_p8);
 
         if (need_bswap) {
             tcg_gen_bswap64_i64(y, y);
         }
     } else {
-        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-            ext_addr = tcg_temp_ebb_new_i64();
-            tcg_gen_extu_i32_i64(ext_addr, temp_tcgv_i32(addr));
-            addr = tcgv_i64_temp(ext_addr);
+        if (ext_addr == addr) {
+            ext_addr = maybe_extend_or_copy_addr(addr, NULL, true);
         }
-        gen_helper_ld_i128(val, tcg_env, temp_tcgv_i64(addr),
+        gen_helper_ld_i128(val, tcg_env, temp_tcgv_i64(ext_addr),
                            tcg_constant_i32(orig_oi));
     }
 
-    plugin_gen_mem_callbacks_i128(val, ext_addr, addr, orig_oi,
-                                  QEMU_PLUGIN_MEM_R);
+    plugin_gen_mem_callbacks_i128(val, ext_addr, orig_oi, QEMU_PLUGIN_MEM_R);
+    maybe_free_addr(addr, ext_addr);
 }
 
 void tcg_gen_qemu_ld_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
@@ -635,7 +622,7 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
                                      TCGArg idx, MemOp memop)
 {
     MemOpIdx orig_oi;
-    TCGv_i64 ext_addr = NULL;
+    TCGTemp *ext_addr;
 
     check_max_alignment(memop_alignment_bits(memop));
     tcg_gen_req_mo(TCG_MO_ST_LD | TCG_MO_ST_ST);
@@ -646,6 +633,7 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
         memop |= MO_ATOM_NONE;
     }
     orig_oi = make_memop_idx(memop, idx);
+    ext_addr = maybe_extend_or_copy_addr(addr, NULL, false);
 
     /* TODO: For now, force 32-bit hosts to use the helper. */
 
@@ -667,7 +655,7 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
         }
 
         gen_ldst2(INDEX_op_qemu_st2, TCG_TYPE_I128,
-                  tcgv_i64_temp(lo), tcgv_i64_temp(hi), addr, oi);
+                  tcgv_i64_temp(lo), tcgv_i64_temp(hi), ext_addr, oi);
 
         if (need_bswap) {
             tcg_temp_free_i64(lo);
@@ -675,7 +663,7 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
         }
     } else if (use_two_i64_for_i128(memop)) {
         MemOp mop[2];
-        TCGTemp *addr_p8;
+        TCGTemp *addr_p8, *ext_addr_p8;
         TCGv_i64 x, y, b = NULL;
 
         canonicalize_memop_i128_as_i64(mop, memop);
@@ -705,27 +693,27 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
             tcg_gen_addi_i64(t, temp_tcgv_i64(addr), 8);
             addr_p8 = tcgv_i64_temp(t);
         }
+        ext_addr_p8 = maybe_extend_or_copy_addr(addr_p8, NULL, false);
 
         if (b) {
             tcg_gen_bswap64_i64(b, y);
-            gen_st_i64(b, addr_p8, make_memop_idx(mop[1], idx));
+            gen_st_i64(b, ext_addr_p8, make_memop_idx(mop[1], idx));
             tcg_temp_free_i64(b);
         } else {
-            gen_st_i64(y, addr_p8, make_memop_idx(mop[1], idx));
+            gen_st_i64(y, ext_addr_p8, make_memop_idx(mop[1], idx));
         }
+        maybe_free_addr(addr_p8, ext_addr_p8);
         tcg_temp_free_internal(addr_p8);
     } else {
-        if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-            ext_addr = tcg_temp_ebb_new_i64();
-            tcg_gen_extu_i32_i64(ext_addr, temp_tcgv_i32(addr));
-            addr = tcgv_i64_temp(ext_addr);
+        if (ext_addr == addr) {
+            ext_addr = maybe_extend_or_copy_addr(addr, NULL, true);
         }
-        gen_helper_st_i128(tcg_env, temp_tcgv_i64(addr), val,
+        gen_helper_st_i128(tcg_env, temp_tcgv_i64(ext_addr), val,
                            tcg_constant_i32(orig_oi));
     }
 
-    plugin_gen_mem_callbacks_i128(val, ext_addr, addr, orig_oi,
-                                  QEMU_PLUGIN_MEM_W);
+    plugin_gen_mem_callbacks_i128(val, ext_addr, orig_oi, QEMU_PLUGIN_MEM_W);
+    maybe_free_addr(addr, ext_addr);
 }
 
 void tcg_gen_qemu_st_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
@@ -864,7 +852,7 @@ static void tcg_gen_atomic_cmpxchg_i32_int(TCGv_i32 retv, TCGTemp *addr,
                                            TCGArg idx, MemOp memop)
 {
     gen_atomic_cx_i32 gen;
-    TCGv_i64 a64;
+    TCGTemp *ext_addr;
     MemOpIdx oi;
 
     if (!(tcg_ctx->gen_tb->cflags & CF_PARALLEL)) {
@@ -877,9 +865,10 @@ static void tcg_gen_atomic_cmpxchg_i32_int(TCGv_i32 retv, TCGTemp *addr,
     tcg_debug_assert(gen != NULL);
 
     oi = make_memop_idx(memop & ~MO_SIGN, idx);
-    a64 = maybe_extend_addr64(addr);
-    gen(retv, tcg_env, a64, cmpv, newv, tcg_constant_i32(oi));
-    maybe_free_addr64(a64);
+    ext_addr = maybe_extend_or_copy_addr(addr, NULL, true);
+    gen(retv, tcg_env, temp_tcgv_i64(ext_addr),
+        cmpv, newv, tcg_constant_i32(oi));
+    maybe_free_addr(addr, ext_addr);
 
     if (memop & MO_SIGN) {
         tcg_gen_ext_i32(retv, retv, memop);
@@ -957,9 +946,10 @@ static void tcg_gen_atomic_cmpxchg_i64_int(TCGv_i64 retv, TCGTemp *addr,
         gen = table_cmpxchg[memop & (MO_SIZE | MO_BSWAP)];
         if (gen) {
             MemOpIdx oi = make_memop_idx(memop, idx);
-            TCGv_i64 a64 = maybe_extend_addr64(addr);
-            gen(retv, tcg_env, a64, cmpv, newv, tcg_constant_i32(oi));
-            maybe_free_addr64(a64);
+            TCGTemp *ext_addr = maybe_extend_or_copy_addr(addr, NULL, true);
+            gen(retv, tcg_env, temp_tcgv_i64(ext_addr),
+                cmpv, newv, tcg_constant_i32(oi));
+            maybe_free_addr(addr, ext_addr);
             return;
         }
 
@@ -1019,11 +1009,11 @@ static void tcg_gen_nonatomic_cmpxchg_i128_int(TCGv_i128 retv, TCGTemp *addr,
     if (TCG_TARGET_REG_BITS == 32) {
         /* Inline expansion below is simply too large for 32-bit hosts. */
         MemOpIdx oi = make_memop_idx(memop, idx);
-        TCGv_i64 a64 = maybe_extend_addr64(addr);
+        TCGTemp *ext_addr = maybe_extend_or_copy_addr(addr, NULL, true);
 
-        gen_helper_nonatomic_cmpxchgo(retv, tcg_env, a64, cmpv, newv,
-                                      tcg_constant_i32(oi));
-        maybe_free_addr64(a64);
+        gen_helper_nonatomic_cmpxchgo(retv, tcg_env, temp_tcgv_i64(ext_addr),
+                                      cmpv, newv, tcg_constant_i32(oi));
+        maybe_free_addr(addr, ext_addr);
     } else {
         TCGv_i128 oldv = tcg_temp_ebb_new_i128();
         TCGv_i128 tmpv = tcg_temp_ebb_new_i128();
@@ -1079,9 +1069,10 @@ static void tcg_gen_atomic_cmpxchg_i128_int(TCGv_i128 retv, TCGTemp *addr,
     gen = table_cmpxchg[memop & (MO_SIZE | MO_BSWAP)];
     if (gen) {
         MemOpIdx oi = make_memop_idx(memop, idx);
-        TCGv_i64 a64 = maybe_extend_addr64(addr);
-        gen(retv, tcg_env, a64, cmpv, newv, tcg_constant_i32(oi));
-        maybe_free_addr64(a64);
+        TCGTemp *ext_addr = maybe_extend_or_copy_addr(addr, NULL, true);
+        gen(retv, tcg_env, temp_tcgv_i64(ext_addr),
+            cmpv, newv, tcg_constant_i32(oi));
+        maybe_free_addr(addr, ext_addr);
         return;
     }
 
@@ -1129,7 +1120,7 @@ static void do_atomic_op_i32(TCGv_i32 ret, TCGTemp *addr, TCGv_i32 val,
                              TCGArg idx, MemOp memop, void * const table[])
 {
     gen_atomic_op_i32 gen;
-    TCGv_i64 a64;
+    TCGTemp *ext_addr;
     MemOpIdx oi;
 
     memop = tcg_canonicalize_memop(memop, 0, 0);
@@ -1138,9 +1129,9 @@ static void do_atomic_op_i32(TCGv_i32 ret, TCGTemp *addr, TCGv_i32 val,
     tcg_debug_assert(gen != NULL);
 
     oi = make_memop_idx(memop & ~MO_SIGN, idx);
-    a64 = maybe_extend_addr64(addr);
-    gen(ret, tcg_env, a64, val, tcg_constant_i32(oi));
-    maybe_free_addr64(a64);
+    ext_addr = maybe_extend_or_copy_addr(addr, NULL, true);
+    gen(ret, tcg_env, temp_tcgv_i64(ext_addr), val, tcg_constant_i32(oi));
+    maybe_free_addr(addr, ext_addr);
 
     if (memop & MO_SIGN) {
         tcg_gen_ext_i32(ret, ret, memop);
@@ -1176,9 +1167,10 @@ static void do_atomic_op_i64(TCGv_i64 ret, TCGTemp *addr, TCGv_i64 val,
 
         if (gen) {
             MemOpIdx oi = make_memop_idx(memop & ~MO_SIGN, idx);
-            TCGv_i64 a64 = maybe_extend_addr64(addr);
-            gen(ret, tcg_env, a64, val, tcg_constant_i32(oi));
-            maybe_free_addr64(a64);
+            TCGTemp *ext_addr = maybe_extend_or_copy_addr(addr, NULL, true);
+            gen(ret, tcg_env, temp_tcgv_i64(ext_addr),
+                val, tcg_constant_i32(oi));
+            maybe_free_addr(addr, ext_addr);
             return;
         }
 
@@ -1227,9 +1219,9 @@ static void do_atomic_op_i128(TCGv_i128 ret, TCGTemp *addr, TCGv_i128 val,
 
     if (gen) {
         MemOpIdx oi = make_memop_idx(memop & ~MO_SIGN, idx);
-        TCGv_i64 a64 = maybe_extend_addr64(addr);
-        gen(ret, tcg_env, a64, val, tcg_constant_i32(oi));
-        maybe_free_addr64(a64);
+        TCGTemp *ext_addr = maybe_extend_or_copy_addr(addr, NULL, true);
+        gen(ret, tcg_env, temp_tcgv_i64(ext_addr), val, tcg_constant_i32(oi));
+        maybe_free_addr(addr, ext_addr);
         return;
     }
 
-- 
2.43.0


