Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47B7D12D78
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQoNc-0007rs-HP; Wed, 03 Dec 2025 10:02:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQoNM-0007qM-GU
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:02:42 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQoNJ-0008WB-SG
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:02:40 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso7554975e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 07:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764774155; x=1765378955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DqUn3oQBbfn0zcKaFRNf4PkmwosSn3c3ey6cFzh81YQ=;
 b=f1UNDZz0vMg0bNEvtM5mu1HkZexTh2LWFYcQt2/sEHu8Po20iMGSBsyR/99KD4gwNN
 iJwgug3PuhB+CeaVHxVgBuV/JVZlKvNelgamqqhSMCzP3pRoPry3F/J+0M+17BFEq7xN
 YgXt+GKMFTkxuJnGC8NOcbzofIXNpFSmvS0HJL1069ZUafxjTXujw+ImEDdT9LDM5HIl
 zyEnNzb0WZc54wSHspv4HnNWzkRvWcd8+6ED/Hq+EUwRs35jV5M4imM42diImgyhJJEg
 vk16372v5bJWMm4bcFVCb9zJf4fgOYlZVv8AAgaCSgb631FFICYcJLizdRTiZEq9jBlu
 5QMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764774155; x=1765378955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DqUn3oQBbfn0zcKaFRNf4PkmwosSn3c3ey6cFzh81YQ=;
 b=FZPhr3WkPCyWvNL7h4q7QmYGd12UjXYFIov1d8wYw7qKjYTef9Onir1yoB+iMNSwRY
 ege41/MMnRzN44/7NwVhB81GK0q9whj+K+vGx/ksjif/cxXodBM6imEXZqX//Kg9tb70
 Ot3/7bemP0tmSx12rpxbzYS9aJOCcYLL7dzhkoxhSZ4BqYnsibu+8xeJHC9wF3wNdCh9
 IBxIGT7Bne1YMBmOIjSWqyEe7AlIverVbTXfzR/Jr6KRYdCPd10baVIQ1SPwz8asvGpj
 sHI9q9StL3lUyNpu1GmnOZoTPX7Fv+Fr8c0Bzzb3k0EKrZZwo9SSLAKa8Wu1aYjawbZf
 9tKg==
X-Gm-Message-State: AOJu0Yzl63/AUfe++Kr9aeYKsR2+iFp6OHpWnKIwFcjV1OVxQOPDXfMB
 ex90tYqiLyL3MZybxeZ8s2g2TVugjc95tvI7TyZKHwwoxfvxeOrW3TK5eUaNz5bIzCfL67a96dJ
 gWc8EHL8=
X-Gm-Gg: ASbGncvpW3wN34+VROAaXOljsiH/IT83AQEEwq8xm0tE0vgangM3hJk3TE5xZLPBUiT
 vyelY/YQ6BqDFqHA+TxKwtjQ2yyDMT3Y95+yzm1brZsGo+kh+JkQ8lsoYBVFTQOHZlfGS2kV3yC
 M/SvDNOhC4wD6/p03DMKIS0W/7JiD0JQzcBkX+8JJbhadw+ZRQthND1ieYqfZlpLNLo7KGkW9HC
 DJH0z8N/aSX8g6L58mmYpdYag9oTyWqFJ5QUBCmvlTxZpKVUL1SAeCFVpS8eDoJ2uAcruH38+xo
 aiZ3Lc/0V4nU3AeRxxPqJAEeuI6eeK7g8q0ZhnU7vKORNxQ8XKj56gEuBAbbiw2KSeQ0sDaJ1+P
 aqoqT/dp9glexoc8q/9Z0AvJDQ4svq2/zik5cHpCGyWmEfkLZRzKS+Xu+vYhEaR2odZJ7vcLn1T
 YqM9ENcFKeN+uKGAAlWimrisKMiAfr5YkC3s2lHn/MtRaB7iyLQmuCxW6qxmjY
X-Google-Smtp-Source: AGHT+IEtE9Kf7NamokZ1zI3/ADVk6bLG+DvJlKN9kvTL19lmM9kRz5TT55FtWobsfYyhx/S39Pq9xw==
X-Received: by 2002:a05:600c:358e:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-4792af3c422mr30977085e9.11.1764774155174; 
 Wed, 03 Dec 2025 07:02:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c3c81sm40085280f8f.3.2025.12.03.07.02.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Dec 2025 07:02:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/3] tcg: Zero extend 32-bit addresses for TCI
Date: Wed,  3 Dec 2025 16:02:12 +0100
Message-ID: <20251203150212.66098-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251203150212.66098-1-philmd@linaro.org>
References: <20251203150212.66098-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

For native code generation, zero-extending 32-bit addresses for
the slow path helpers happens in tcg_out_{ld,st}_helper_args,
but there isn't really a slow path for TCI, so that didn't happen.

Make the extension for TCI explicit in the opcode stream,
much like we already do for plugins and atomic helpers.

Fixes: 24e46e6c9d9 ("accel/tcg: Widen tcg-ldst.h addresses to uint64_t")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251202011228.503007-3-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tcg-op-ldst.c | 212 ++++++++++++++++++++++------------------------
 1 file changed, 102 insertions(+), 110 deletions(-)

diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 50bb6853f6c..8e2adef6886 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -135,71 +135,53 @@ static void tcg_gen_req_mo(TCGBar type)
     }
 }
 
-static TCGv_i64 maybe_extend_addr64(TCGTemp *addr)
+static TCGTemp *maybe_extend_or_copy_addr(TCGTemp *addr,
+                                          TCGTemp *data, bool force)
 {
-    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-        TCGv_i64 a64 = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(a64, temp_tcgv_i32(addr));
-        return a64;
-    }
-    return temp_tcgv_i64(addr);
-}
+    bool do_ext = tcg_ctx->addr_type == TCG_TYPE_I32;
 
-/* Only required for loads, where value might overlap addr. */
-static TCGv_i64 plugin_maybe_preserve_addr(TCGTemp *addr)
-{
-#ifdef CONFIG_PLUGIN
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
 }
 
-static void maybe_free_addr64(TCGv_i64 a64)
+static void maybe_free_addr(TCGTemp *addr, TCGTemp *ext_addr)
 {
-    if (tcg_ctx->addr_type == TCG_TYPE_I32) {
-        tcg_temp_free_i64(a64);
+    if (addr != ext_addr) {
+        tcg_temp_free_internal(ext_addr);
     }
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
@@ -207,14 +189,13 @@ plugin_gen_mem_callbacks_i32(TCGv_i32 val,
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
@@ -222,15 +203,14 @@ plugin_gen_mem_callbacks_i64(TCGv_i64 val,
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
@@ -240,7 +220,7 @@ plugin_gen_mem_callbacks_i128(TCGv_i128 val,
         tcg_gen_st_i64(TCGV128_HIGH(val), tcg_env,
                        offsetof(CPUState, neg.plugin_mem_value_high) -
                        sizeof(CPUState));
-        plugin_gen_mem_callbacks(copy_addr, orig_addr, oi, rw);
+        plugin_gen_mem_callbacks(ext_addr, oi, rw);
     }
 #endif
 }
@@ -250,7 +230,7 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
 {
     MemOp orig_memop;
     MemOpIdx orig_oi, oi;
-    TCGv_i64 copy_addr;
+    TCGTemp *ext_addr;
 
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     orig_memop = memop = tcg_canonicalize_memop(memop, 0, 0);
@@ -265,10 +245,10 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
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
@@ -299,6 +279,7 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
 {
     TCGv_i32 swap = NULL;
     MemOpIdx orig_oi, oi;
+    TCGTemp *ext_addr;
 
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 0, 1);
@@ -321,8 +302,10 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
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
@@ -342,7 +325,7 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
 {
     MemOp orig_memop;
     MemOpIdx orig_oi, oi;
-    TCGv_i64 copy_addr;
+    TCGTemp *ext_addr;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_ld_i32_int(TCGV_LOW(val), addr, idx, memop);
@@ -367,10 +350,10 @@ static void tcg_gen_qemu_ld_i64_int(TCGv_i64 val, TCGTemp *addr,
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
@@ -405,6 +388,7 @@ static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
 {
     TCGv_i64 swap = NULL;
     MemOpIdx orig_oi, oi;
+    TCGTemp *ext_addr;
 
     if (TCG_TARGET_REG_BITS == 32 && (memop & MO_SIZE) < MO_64) {
         tcg_gen_qemu_st_i32_int(TCGV_LOW(val), addr, idx, memop);
@@ -435,8 +419,10 @@ static void tcg_gen_qemu_st_i64_int(TCGv_i64 val, TCGTemp *addr,
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
@@ -529,7 +515,7 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
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
2.51.0


