Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7717FC021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS6R-0007hU-NP; Sat, 15 Feb 2025 19:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS64-0007bf-TK
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:23 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS60-0006Fk-Lt
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:18 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220e989edb6so56607575ad.1
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664075; x=1740268875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S+kIGuGBK8eG0Jdr2LQlsshBeedKRjQUqU3s0GIA0mE=;
 b=MZi1fG6y9m033RNV080YbWQdmxmCl0S7y5QnBeybHhVAJ5l+iyX77llFICdrJCHXEk
 M/zArboGa9B13SDkm07g8vBYrVoKJotEv29qMH+LMwjMXjTuWVd00vjZFh7apNGfcm8N
 gDZ945x7UPE5OEZoaowVycKA2I//yPHGNPKiLYHI8facrPZLHhZShqc3QSLlsH1TabRq
 5r/4tZlFa+oyWGt8EaV3n4kH7pmwuWJBFmD1E2GIP9AQWIovnDtcmg/0www8RuZIIjoh
 Cw4a9kW0h80FB/bkvPXhFx2PaKUKtySs6gYVSkQCLcSOBKq+otRXU3VMrs8FFUNKmsWi
 RzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664075; x=1740268875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+kIGuGBK8eG0Jdr2LQlsshBeedKRjQUqU3s0GIA0mE=;
 b=dq+1zgyM+YM15hjQCFXlxtwJMoVNCwaMBG5X3+osYfNdqFDTksj2Cnwm6Vo6hF7epS
 9X3WJMhdpPCEyIKtJMDhXG6UwyvZkvdnCiamfg3RzjGfFojFeDO1LzvhhhCll7xMqB4Y
 ugUTl05Rjuzekj4VC1zsJvpsoDQzhYVgxNme0aMuPouxzh5zzvgZ9PpnDnY8oSRIG9Cf
 0MynO2Uwkdgz86lVGvBgEGGXy3fCZCVvarb9NYR3Iy/0QnhmCya71f0pgNWRmfgIqvLl
 r3P04pzTXojuO0hu7vAF2RIG38i+SULm66e+PU66c5BkjaQXL8YBIjDjfxfkApYtooeg
 39ag==
X-Gm-Message-State: AOJu0Yy05v4KhyxMUGbyr4Mg+IWEgzlwMayuQgxIC0PubX1t33mdnP6I
 JRuJ7SSaQ+fr6YT8dLYxRyD0Tl0ecuN1GxK637YJLbW8Nnob7QTfGddUB9hB/DlW8Gp1NdSg11B
 e
X-Gm-Gg: ASbGncuV9yEFJJrDcsm1g5Aw6Piyal3XTUnD6CfakyhzoEzcLCMVJgXK4uLI8stYavT
 QrFxlP3Bj6SUInLBWZNUo9QJeDvMm0T5yyjumy6XWu8IEFXuj/AvRjdBAiG5ZvBpofa9V2EGYR6
 bcSC7Uen5nNHbum/fBVHW3VzUjt6laGZhjSpBWn9Mfn6EPr9X35CyGq4MTVTj0u/lLF3OYutLQf
 p4Cocx4efjhSmOY36ZdBh2GxG0qeJltQeIw6BKaPTrSlG2kZJOQtJMNz7zuXQ85itsa1aTIyTSq
 Omv+UnJ5WYzGZ6VAWr/qeuyQlAXF5GZ5Pe+oXTEvpn7kWDo=
X-Google-Smtp-Source: AGHT+IFonR8UMoFz/WEXERMd7qSFAY37WW3OqknkZieYLOY0B6FDU+W0h5NRpuPd1h9PtB8REscYYA==
X-Received: by 2002:a17:902:fc4e:b0:21f:71b4:d2aa with SMTP id
 d9443c01a7336-22103efeebcmr82131775ad.5.1739664075079; 
 Sat, 15 Feb 2025 16:01:15 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/24] tcg/arm: Drop addrhi from prepare_host_addr
Date: Sat, 15 Feb 2025 16:00:49 -0800
Message-ID: <20250216000109.2606518-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.c.inc | 63 ++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 42 deletions(-)

diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 05bb367a39..252d9aa7e5 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1455,8 +1455,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
 #define MIN_TLB_MASK_TABLE_OFS  -256
 
 static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
-                                           TCGReg addrlo, TCGReg addrhi,
-                                           MemOpIdx oi, bool is_ld)
+                                           TCGReg addr, MemOpIdx oi, bool is_ld)
 {
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
@@ -1465,14 +1464,14 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
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
@@ -1492,8 +1491,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addrlo;
-        ldst->addrhi_reg = addrhi;
+        ldst->addrlo_reg = addr;
 
         /* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {r0,r1}.  */
         QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
@@ -1501,30 +1499,20 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
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
@@ -1543,11 +1531,11 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
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
@@ -1558,7 +1546,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         } else {
             if (a_mask) {
                 tcg_debug_assert(a_mask <= 0xff);
-                tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, addrlo, a_mask);
+                tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, addr, a_mask);
             }
             tcg_out_dat_reg(s, COND_AL, ARITH_MOV, TCG_REG_TMP, 0, t_addr,
                             SHIFT_IMM_LSR(s->page_bits));
@@ -1566,21 +1554,16 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
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
@@ -1678,14 +1661,13 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, MemOp opc, TCGReg datalo,
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
@@ -1764,14 +1746,13 @@ static void tcg_out_qemu_st_direct(TCGContext *s, MemOp opc, TCGReg datalo,
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
@@ -2072,19 +2053,17 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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


