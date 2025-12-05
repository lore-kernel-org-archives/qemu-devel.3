Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCFED3398B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYXc-00047R-4i; Fri, 05 Dec 2025 11:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRYXZ-00046a-L7
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:20:17 -0500
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRYXX-0001YD-IZ
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:20:17 -0500
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-8823d5127daso21518916d6.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764951614; x=1765556414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BdIlsi0gJEHOseBXWtnQc3B3kgBfFxOYQ86yS2xgzgU=;
 b=bV907L/s4hMCAY++IXTo3PUEKZ05OYyqqY5FRQKZ/W+kCa5cNwdlDcB7r9Kfu/eHEx
 ZmQil7DsfsogmUb1mEYLPTO77vtlHD3G00aWtRVWL5lelP4L03Tli8gZf/2jxZuILJp7
 dfnCxyYaS3egrV3JvQKuBncmi0wGH2NjzTUwHfrmTGrIWUv0Z2P2lvUegOCMmt5ZBO/G
 bUFlsz3xZBglBmX1acamNmAwYTDC1FFDqYp17Zb5C7b8uAmNiW8QT9NUkMsWn06ngjnw
 eJFhyVxw7evuJllX8uV2aAJdQoGzU1nja0X2DKs/mjynTIFRGACHjDxgJwd1oFv/Jww6
 UZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764951614; x=1765556414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BdIlsi0gJEHOseBXWtnQc3B3kgBfFxOYQ86yS2xgzgU=;
 b=eArPbFy+0hN2qhsP3itodMtD6F777Nqivqk80nfitJl9QLOoEIafajCbf1IwCI5Oxu
 YKD63RUih4eoKCpI83444VLyXQ1is3nq/8h4If7l+BdlrZsAFzobnUng5ZpTYJmgVrus
 EwQf69RdWrNfZAFrdApE9vQdlsX+y2u4qGjxAo+Cvm9KVfK/Wfan8SXObmTDA2j2zzMp
 ovt0o2KRCIJoKo48LIOWwanUdHxeLyXTDXj6oCOpKWEeWCQCrxzPpBtdzU+lTATZJKyW
 Vz0iB30N/h1DDlJi94bwcSblnw9Tucifph3y/dfrl8A33nMO1d+hrrZKK4W51nq3o5Bf
 Y0Fw==
X-Gm-Message-State: AOJu0YwHMAB6kLbvIJQr+ntnvCU68N0P8F+rxO6gW1+dN8TY4Yj50H72
 8DiIphFG1eknm2TDHN9FeXvKWti4eDD+jdncecvM3BkXRBhudyr0uyjBWpTgtZI42h13t3jyI8i
 929D2Qo0=
X-Gm-Gg: ASbGncszbf+oum7SwuT92AF5X2/5LiK1il04c1RKM1eA09HzLRETVUWFnGY8bNgfoY2
 T1RMoHAgwidXIgfv41QZPa9MJ3JQYNVwHaV8OKVsQHSZpX8oKLs2obkVmGQRtyZiaLiA9iI6pA6
 Nz5wZLNie4mvo4Dx4yZXs4C3lHQ9/B0IvX2p9/fumNW54eRPKOcVfF0Rr9OaNzPdDQxQtkBy0RQ
 PiFQ8ZTg1WU2FQ8O96HTcSKu2Kek+0l6Cn3YeLWX/b5TF78pF5zRENxwcSdIV3ql1Jom6Gx9iCk
 YotGFl7maC1eaOtOueiblg2fJJufyalONKVZMXNY+zJJ/PSNFKbuHuBGWwky7CJK9mHdbamrEQQ
 iEAYtUENVH7iPHzpcC2NlcOqrtX/G/ZWUHKqBF23JDIoK5ZpObDso49TAcMPUFqJbkXUl2YakBV
 sKoTp/1nsPFINbei3/hjB8EOp+pKORbF2QZhVjVwuuFR7UD9hkFaexwuShnYA/OO0q+QY=
X-Google-Smtp-Source: AGHT+IGDM8KUNczLZpi9eSvyGLWG5hV58NoR7868Y4VTA193WQGmrNo2EBJi8tMY8oTo7RaV5I7lbQ==
X-Received: by 2002:a05:6214:4343:b0:880:d580:de2d with SMTP id
 6a1803df08f44-888194a69e1mr147888376d6.21.1764951614442; 
 Fri, 05 Dec 2025 08:20:14 -0800 (PST)
Received: from stoup.. ([172.56.17.137]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88830bfc22dsm21591636d6.43.2025.12.05.08.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:20:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 1/6] tcg: Zero extend 32-bit addresses for TCI
Date: Fri,  5 Dec 2025 10:20:02 -0600
Message-ID: <20251205162007.26405-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205162007.26405-1-richard.henderson@linaro.org>
References: <20251205162007.26405-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2c.google.com
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

Cc: qemu-stable@nongnu.org
Fixes: 24e46e6c9d9 ("accel/tcg: Widen tcg-ldst.h addresses to uint64_t")
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


