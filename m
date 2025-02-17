Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC8CC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pV-00028L-Q4; Mon, 17 Feb 2025 14:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6ov-0001uN-3Q
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:22 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6oq-0008IW-RX
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:20 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22100006bc8so42905185ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820614; x=1740425414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JOcnNG3plMZjN1kwpuxQZOKJY9zyN5PehP6lpfakNCY=;
 b=PAKVWYppPAnYVpdafV0oozKCVXuhgV3uHMtShclX0toGpvqkgVAET05X/TWtFt5JVL
 ym8ZeBsxD9CCntZ45mDB9DJzw/qjllboKIWGAFSvqCQWDLnC6mPYDM4qLln/XyWN6/Ga
 liiEB3Ij92WBa9eCvgfcDTNuEd43BV6TI7MnsnCyYnFFwIQ2EQOC9RG9UOn2MJAYOSiO
 bS7m0ZMdWKaeUWfVS2ijarSx54Vsblx7YSbvij17TBuCZ9G4MpOmVJNBrRZJhfSlEK6L
 w4Iq13POl/l2cHjG9S3hRO7sS4W3YHf41DptUiPIq39tTCPmaBUc19N2/Y+d6XYbnN01
 /GWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820614; x=1740425414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JOcnNG3plMZjN1kwpuxQZOKJY9zyN5PehP6lpfakNCY=;
 b=FTCiGbb9Tw6aFhYALi5rwwZ1S64v3eGevf771n9GIqOqeVIMieHsdAYUaD8oMCwtYP
 IA4CsvzRf7St6dKaNqacK7ZUASQMjtBg5VvkEZKrwkd10jHB6BfWwn27qTX9r/QcgULX
 TBDVEGBMGJZY8EsLERZzALOiiDc2t68Ng5Ii4YPmdlL598AtFUk3JMp9DbA6eee144YR
 pAkyXaL8szGItZf0RPjDCZ3LLpo8TtYfuARgpDOE6zBAOwzOFXCyKRKDwOIQwreHrE8Z
 9B7MTz4gc3dSbrMZrLe1DH5ACCvgJoxc9c6Ll6VnxGdz0r31tkUbavSSsDsTdKsORK0g
 Vtyw==
X-Gm-Message-State: AOJu0YzjrUt7E50oVe9gyAnDadVEjJZJ63Qzz1cD81C1kl3AoW1/Erjm
 f7ZuuIVOqsDxl7MQYib5PDZbA6H8m3EiYDR9CmvYcG6kT79zD7NHNgYma/cygSFHzuFbTREVFa3
 R
X-Gm-Gg: ASbGncsB4saSgLTClaUidxzKQLBBFdkjHoFW6cbDHcUUmSHLayxo8oMdA6CJNR0Riym
 oVyagh0cEna2XyLJ4VHXYDoB4JkLV8K0XwnDsIMIWu/aekVQySg1u0iyLCVsTagxAvItcKseMR+
 287cGzU7ybzdF7bWVAKEkAuMiVZV2ihky4EgsnZjNSAjoyZOWEtN92xbhn6ju8l0YHLe2XmU4tK
 s5/XJLy2YRIdpeq88ngtO38+DxI/idCir2LM9RyWBiVb7klk+XvAEsxSIxnnrl1XV7CXR2Hu6ok
 kvtPeBlLjxtPdU9dl/hAx8/spkJt+JZWmIbcGtB62Ppps98=
X-Google-Smtp-Source: AGHT+IHnq4MyEtaeT4LtGdq+2jz7BYpx9YNswgB5eHnao3YSP+gwrawdnQQxsclcCh63jWVvgBdt6g==
X-Received: by 2002:a05:6a00:1804:b0:727:3cd0:1167 with SMTP id
 d2e1a72fcca58-732619005camr15955806b3a.21.1739820614549; 
 Mon, 17 Feb 2025 11:30:14 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 05/27] tcg/arm: Drop addrhi from prepare_host_addr
Date: Mon, 17 Feb 2025 11:29:46 -0800
Message-ID: <20250217193009.2873875-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

The guest address will now always be TCG_TYPE_I32.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.c.inc | 73 +++++++++++++---------------------------
 1 file changed, 23 insertions(+), 50 deletions(-)

diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 05bb367a39..93a3ccaf66 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -676,14 +676,8 @@ static void tcg_out_ldrd_r(TCGContext *s, ARMCond cond, TCGReg rt,
     tcg_out_memop_r(s, cond, INSN_LDRD_REG, rt, rn, rm, 1, 1, 0);
 }
 
-static void __attribute__((unused))
-tcg_out_ldrd_rwb(TCGContext *s, ARMCond cond, TCGReg rt, TCGReg rn, TCGReg rm)
-{
-    tcg_out_memop_r(s, cond, INSN_LDRD_REG, rt, rn, rm, 1, 1, 1);
-}
-
-static void __attribute__((unused))
-tcg_out_strd_8(TCGContext *s, ARMCond cond, TCGReg rt, TCGReg rn, int imm8)
+static void tcg_out_strd_8(TCGContext *s, ARMCond cond, TCGReg rt,
+                           TCGReg rn, int imm8)
 {
     tcg_out_memop_8(s, cond, INSN_STRD_IMM, rt, rn, imm8, 1, 0);
 }
@@ -1455,8 +1449,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 #define MIN_TLB_MASK_TABLE_OFS  -256
 
 static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
-                                           TCGReg addrlo, TCGReg addrhi,
-                                           MemOpIdx oi, bool is_ld)
+                                           TCGReg addr, MemOpIdx oi, bool is_ld)
 {
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
@@ -1465,14 +1458,14 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     if (tcg_use_softmmu) {
         *h = (HostAddress){
             .cond = COND_AL,
-            .base = addrlo,
+            .base = addr,
             .index = TCG_REG_R1,
             .index_scratch = true,
         };
     } else {
         *h = (HostAddress){
             .cond = COND_AL,
-            .base = addrlo,
+            .base = addr,
             .index = guest_base ? TCG_REG_GUEST_BASE : -1,
             .index_scratch = false,
         };
@@ -1492,8 +1485,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addrlo;
-        ldst->addrhi_reg = addrhi;
+        ldst->addrlo_reg = addr;
 
         /* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {r0,r1}.  */
         QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
@@ -1501,30 +1493,20 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_ldrd_8(s, COND_AL, TCG_REG_R0, TCG_AREG0, fast_off);
 
         /* Extract the tlb index from the address into R0.  */
-        tcg_out_dat_reg(s, COND_AL, ARITH_AND, TCG_REG_R0, TCG_REG_R0, addrlo,
+        tcg_out_dat_reg(s, COND_AL, ARITH_AND, TCG_REG_R0, TCG_REG_R0, addr,
                         SHIFT_IMM_LSR(s->page_bits - CPU_TLB_ENTRY_BITS));
 
         /*
          * Add the tlb_table pointer, creating the CPUTLBEntry address in R1.
-         * Load the tlb comparator into R2/R3 and the fast path addend into R1.
+         * Load the tlb comparator into R2 and the fast path addend into R1.
          */
         QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
         if (cmp_off == 0) {
-            if (s->addr_type == TCG_TYPE_I32) {
-                tcg_out_ld32_rwb(s, COND_AL, TCG_REG_R2,
-                                 TCG_REG_R1, TCG_REG_R0);
-            } else {
-                tcg_out_ldrd_rwb(s, COND_AL, TCG_REG_R2,
-                                 TCG_REG_R1, TCG_REG_R0);
-            }
+            tcg_out_ld32_rwb(s, COND_AL, TCG_REG_R2, TCG_REG_R1, TCG_REG_R0);
         } else {
             tcg_out_dat_reg(s, COND_AL, ARITH_ADD,
                             TCG_REG_R1, TCG_REG_R1, TCG_REG_R0, 0);
-            if (s->addr_type == TCG_TYPE_I32) {
-                tcg_out_ld32_12(s, COND_AL, TCG_REG_R2, TCG_REG_R1, cmp_off);
-            } else {
-                tcg_out_ldrd_8(s, COND_AL, TCG_REG_R2, TCG_REG_R1, cmp_off);
-            }
+            tcg_out_ld32_12(s, COND_AL, TCG_REG_R2, TCG_REG_R1, cmp_off);
         }
 
         /* Load the tlb addend.  */
@@ -1543,11 +1525,11 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
          * This leaves the least significant alignment bits unchanged, and of
          * course must be zero.
          */
-        t_addr = addrlo;
+        t_addr = addr;
         if (a_mask < s_mask) {
             t_addr = TCG_REG_R0;
             tcg_out_dat_imm(s, COND_AL, ARITH_ADD, t_addr,
-                            addrlo, s_mask - a_mask);
+                            addr, s_mask - a_mask);
         }
         if (use_armv7_instructions && s->page_bits <= 16) {
             tcg_out_movi32(s, COND_AL, TCG_REG_TMP, ~(s->page_mask | a_mask));
@@ -1558,7 +1540,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         } else {
             if (a_mask) {
                 tcg_debug_assert(a_mask <= 0xff);
-                tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, addrlo, a_mask);
+                tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, addr, a_mask);
             }
             tcg_out_dat_reg(s, COND_AL, ARITH_MOV, TCG_REG_TMP, 0, t_addr,
                             SHIFT_IMM_LSR(s->page_bits));
@@ -1566,21 +1548,16 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                             0, TCG_REG_R2, TCG_REG_TMP,
                             SHIFT_IMM_LSL(s->page_bits));
         }
-
-        if (s->addr_type != TCG_TYPE_I32) {
-            tcg_out_dat_reg(s, COND_EQ, ARITH_CMP, 0, TCG_REG_R3, addrhi, 0);
-        }
     } else if (a_mask) {
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addrlo;
-        ldst->addrhi_reg = addrhi;
+        ldst->addrlo_reg = addr;
 
         /* We are expecting alignment to max out at 7 */
         tcg_debug_assert(a_mask <= 0xff);
         /* tst addr, #mask */
-        tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, addrlo, a_mask);
+        tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, addr, a_mask);
     }
 
     return ldst;
@@ -1678,14 +1655,13 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, MemOp opc, TCGReg datalo,
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
     if (ldst) {
         ldst->type = data_type;
         ldst->datalo_reg = datalo;
@@ -1764,14 +1740,13 @@ static void tcg_out_qemu_st_direct(TCGContext *s, MemOp opc, TCGReg datalo,
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
     if (ldst) {
         ldst->type = data_type;
         ldst->datalo_reg = datalo;
@@ -2072,19 +2047,17 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_qemu_ld_i32:
-        tcg_out_qemu_ld(s, args[0], -1, args[1], -1, args[2], TCG_TYPE_I32);
+        tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
         break;
     case INDEX_op_qemu_ld_i64:
-        tcg_out_qemu_ld(s, args[0], args[1], args[2], -1,
-                        args[3], TCG_TYPE_I64);
+        tcg_out_qemu_ld(s, args[0], args[1], args[2], args[3], TCG_TYPE_I64);
         break;
 
     case INDEX_op_qemu_st_i32:
-        tcg_out_qemu_st(s, args[0], -1, args[1], -1, args[2], TCG_TYPE_I32);
+        tcg_out_qemu_st(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
         break;
     case INDEX_op_qemu_st_i64:
-        tcg_out_qemu_st(s, args[0], args[1], args[2], -1,
-                        args[3], TCG_TYPE_I64);
+        tcg_out_qemu_st(s, args[0], args[1], args[2], args[3], TCG_TYPE_I64);
         break;
 
     case INDEX_op_bswap16_i32:
-- 
2.43.0


