Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37794C021A0
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS6Q-0007hK-M4; Sat, 15 Feb 2025 19:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS68-0007bw-JT
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:26 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS62-0006G6-RC
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:22 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-221050f3f00so14804275ad.2
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664077; x=1740268877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q42Wl93XZQ8l+eIAXYd7qQ+kbojGHP8GopxWhwXIvfQ=;
 b=dC3vslhNOBdMTcq8at+zO/bIdOh6pgJr0dWWyuNcWKy+u1KJuFUg8Nxtlxg+N0Ma9u
 o73bGlfVlD56L+iAAmTnMlcL60u4y08wX3jbnXAlVX12YW7DlJMx83hCw4JGPpM1CeTN
 Bv66ytkWim+XB1oaEctzJaoKXNbBM2bmJt+O7x8Qjza2UOKoO3BIVKFsq2C6wMjLH89d
 CnV1/vxYzv195g3XUb6LggXoAyqepTUj7z/bBeqCDDarOEipxFR00MAxGK3EhYVUPTwS
 MWhD0/7gR+Pk+bdk5LUCeMuyBn+PXX2Xe/TNBcol+0hx9dlz80uSDILFOKkOfwgGoyOR
 N1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664077; x=1740268877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q42Wl93XZQ8l+eIAXYd7qQ+kbojGHP8GopxWhwXIvfQ=;
 b=LrAcHe6K0fj/8Qccr51pttfAFRyzyOO/Z6g47ld7sVpX8x/Hr+cmTTC8yTEroGFwym
 lE0pv5zFasUBOZGlLzM/0tVMdOCG8jDLLV4lNSKkosYS1VtfVTYANPZyjHzLtiRanOP9
 7br6GAadOmKGsd/iCtR9vpptuGB9udSerkE7n70mNwEGiswpIy9N/6Cgyh/Pk8zpd7aj
 mjH+2cWNLL8cVrSXVYqOyT+yoKViiFXFoCy7xuTFueWCQ6g8LJgsuutn6aPiEBuvX9ny
 LS5jxxOwhs1wiWW3SHM9xK5/76JRfwOlOXKNUad1cgrXqqolf3TflMZtmBB1esNJTsyV
 MsQw==
X-Gm-Message-State: AOJu0YxAkIeq148+peBJ8yyCIb+FjCC9iCL/fgkQZAB1DswD0OSu4oua
 WXMEaGWAZfLNajkFN/haQatjydqT2dN2Rpbsq8l4TP2kCl8arnX861J7qTFebUx6F/YktoKlaIY
 l
X-Gm-Gg: ASbGncs9oP6HNBWZYC151fv5em0TLWUnFQnJ8QCDRxcPjMtiWldBPePKfSW3gYZScUq
 b1Y0lAvIyNTXqfu7q017ekqjbszHH7kIc/ZGjyrpo/B7jqRgligUO1gC/vXJWEtkNGcDtwprBH8
 l95+42+79pZvzq2JTIcPeyaMm+3SFME6ZsKgcXYD/dPy2NUOqVzkh7t7AB2o1AXN3pcaz+JZm1w
 0jEJO1ATvR4+2LIHCD5xPkjK0/OOrunNNg7X2DpP+3h+NXhGT/UTNjlPWi3WcIY5PZoBnuWJTsF
 wFQA9F6L2Vh9QZK7qKdhqhVx9VN3SEoSDBWh3HPGDVWg/SE=
X-Google-Smtp-Source: AGHT+IHWQphBWbT9bSEEzs5PSEMORaD73w+ps5V9fSqmnXi21yhoYvD85vbuyqhrCHR2J+jicri/pg==
X-Received: by 2002:a17:902:e80b:b0:21f:5cd8:c67 with SMTP id
 d9443c01a7336-2210405f4c8mr70089995ad.31.1739664077232; 
 Sat, 15 Feb 2025 16:01:17 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/24] tcg/ppc: Drop addrhi from prepare_host_addr
Date: Sat, 15 Feb 2025 16:00:52 -0800
Message-ID: <20250216000109.2606518-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

The guest address will now always fit in one register.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 75 ++++++++++++----------------------------
 1 file changed, 23 insertions(+), 52 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 801cb6f3cb..74b93f4b57 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2438,8 +2438,7 @@ bool tcg_target_has_memory_bswap(MemOp memop)
  * is required and fill in @h with the host address for the fast path.
  */
 static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
-                                           TCGReg addrlo, TCGReg addrhi,
-                                           MemOpIdx oi, bool is_ld)
+                                           TCGReg addr, MemOpIdx oi, bool is_ld)
 {
     TCGType addr_type = s->addr_type;
     TCGLabelQemuLdst *ldst = NULL;
@@ -2474,8 +2473,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addrlo;
-        ldst->addrhi_reg = addrhi;
+        ldst->addrlo_reg = addr;
 
         /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_AREG0, mask_off);
@@ -2483,10 +2481,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
         /* Extract the page index, shifted into place for tlb index.  */
         if (TCG_TARGET_REG_BITS == 32) {
-            tcg_out_shri32(s, TCG_REG_R0, addrlo,
+            tcg_out_shri32(s, TCG_REG_R0, addr,
                            s->page_bits - CPU_TLB_ENTRY_BITS);
         } else {
-            tcg_out_shri64(s, TCG_REG_R0, addrlo,
+            tcg_out_shri64(s, TCG_REG_R0, addr,
                            s->page_bits - CPU_TLB_ENTRY_BITS);
         }
         tcg_out32(s, AND | SAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_R0));
@@ -2534,10 +2532,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             if (a_bits < s_bits) {
                 a_bits = s_bits;
             }
-            tcg_out_rlw(s, RLWINM, TCG_REG_R0, addrlo, 0,
+            tcg_out_rlw(s, RLWINM, TCG_REG_R0, addr, 0,
                         (32 - a_bits) & 31, 31 - s->page_bits);
         } else {
-            TCGReg t = addrlo;
+            TCGReg t = addr;
 
             /*
              * If the access is unaligned, we need to make sure we fail if we
@@ -2566,30 +2564,8 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             }
         }
 
-        if (TCG_TARGET_REG_BITS == 32 && addr_type != TCG_TYPE_I32) {
-            /* Low part comparison into cr7. */
-            tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP2,
-                        0, 7, TCG_TYPE_I32);
-
-            /* Load the high part TLB comparator into TMP2.  */
-            tcg_out_ld(s, TCG_TYPE_I32, TCG_REG_TMP2, TCG_REG_TMP1,
-                       cmp_off + 4 * !HOST_BIG_ENDIAN);
-
-            /* Load addend, deferred for this case. */
-            tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1,
-                       offsetof(CPUTLBEntry, addend));
-
-            /* High part comparison into cr6. */
-            tcg_out_cmp(s, TCG_COND_EQ, addrhi, TCG_REG_TMP2,
-                        0, 6, TCG_TYPE_I32);
-
-            /* Combine comparisons into cr0. */
-            tcg_out32(s, CRAND | BT(0, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
-        } else {
-            /* Full comparison into cr0. */
-            tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP2,
-                        0, 0, addr_type);
-        }
+        /* Full comparison into cr0. */
+        tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP2, 0, 0, addr_type);
 
         /* Load a pointer into the current opcode w/conditional branch-link. */
         ldst->label_ptr[0] = s->code_ptr;
@@ -2601,12 +2577,11 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             ldst = new_ldst_label(s);
             ldst->is_ld = is_ld;
             ldst->oi = oi;
-            ldst->addrlo_reg = addrlo;
-            ldst->addrhi_reg = addrhi;
+            ldst->addrlo_reg = addr;
 
             /* We are expecting a_bits to max out at 7, much lower than ANDI. */
             tcg_debug_assert(a_bits < 16);
-            tcg_out32(s, ANDI | SAI(addrlo, TCG_REG_R0, (1 << a_bits) - 1));
+            tcg_out32(s, ANDI | SAI(addr, TCG_REG_R0, (1 << a_bits) - 1));
 
             ldst->label_ptr[0] = s->code_ptr;
             tcg_out32(s, BC | BI(0, CR_EQ) | BO_COND_FALSE | LK);
@@ -2617,24 +2592,23 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
     if (TCG_TARGET_REG_BITS == 64 && addr_type == TCG_TYPE_I32) {
         /* Zero-extend the guest address for use in the host address. */
-        tcg_out_ext32u(s, TCG_REG_TMP2, addrlo);
+        tcg_out_ext32u(s, TCG_REG_TMP2, addr);
         h->index = TCG_REG_TMP2;
     } else {
-        h->index = addrlo;
+        h->index = addr;
     }
 
     return ldst;
 }
 
 static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
-                            TCGReg addrlo, TCGReg addrhi,
-                            MemOpIdx oi, TCGType data_type)
+                            TCGReg addr, MemOpIdx oi, TCGType data_type)
 {
     MemOp opc = get_memop(oi);
     TCGLabelQemuLdst *ldst;
     HostAddress h;
 
-    ldst = prepare_host_addr(s, &h, addrlo, addrhi, oi, true);
+    ldst = prepare_host_addr(s, &h, addr, oi, true);
 
     if (TCG_TARGET_REG_BITS == 32 && (opc & MO_SIZE) == MO_64) {
         if (opc & MO_BSWAP) {
@@ -2678,14 +2652,13 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
 }
 
 static void tcg_out_qemu_st(TCGContext *s, TCGReg datalo, TCGReg datahi,
-                            TCGReg addrlo, TCGReg addrhi,
-                            MemOpIdx oi, TCGType data_type)
+                            TCGReg addr, MemOpIdx oi, TCGType data_type)
 {
     MemOp opc = get_memop(oi);
     TCGLabelQemuLdst *ldst;
     HostAddress h;
 
-    ldst = prepare_host_addr(s, &h, addrlo, addrhi, oi, false);
+    ldst = prepare_host_addr(s, &h, addr, oi, false);
 
     if (TCG_TARGET_REG_BITS == 32 && (opc & MO_SIZE) == MO_64) {
         if (opc & MO_BSWAP) {
@@ -2729,7 +2702,7 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
     uint32_t insn;
     TCGReg index;
 
-    ldst = prepare_host_addr(s, &h, addr_reg, -1, oi, is_ld);
+    ldst = prepare_host_addr(s, &h, addr_reg, oi, is_ld);
 
     /* Compose the final address, as LQ/STQ have no indexing. */
     index = h.index;
@@ -3309,14 +3282,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_qemu_ld_i32:
-        tcg_out_qemu_ld(s, args[0], -1, args[1], -1, args[2], TCG_TYPE_I32);
+        tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
         break;
     case INDEX_op_qemu_ld_i64:
         if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_ld(s, args[0], -1, args[1], -1,
-                            args[2], TCG_TYPE_I64);
+            tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I64);
         } else {
-            tcg_out_qemu_ld(s, args[0], args[1], args[2], -1,
+            tcg_out_qemu_ld(s, args[0], args[1], args[2],
                             args[3], TCG_TYPE_I64);
         }
         break;
@@ -3326,14 +3298,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_qemu_st_i32:
-        tcg_out_qemu_st(s, args[0], -1, args[1], -1, args[2], TCG_TYPE_I32);
+        tcg_out_qemu_st(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
         break;
     case INDEX_op_qemu_st_i64:
         if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_st(s, args[0], -1, args[1], -1,
-                            args[2], TCG_TYPE_I64);
+            tcg_out_qemu_st(s, args[0], -1, args[1], args[2], TCG_TYPE_I64);
         } else {
-            tcg_out_qemu_st(s, args[0], args[1], args[2], -1,
+            tcg_out_qemu_st(s, args[0], args[1], args[2],
                             args[3], TCG_TYPE_I64);
         }
         break;
-- 
2.43.0


