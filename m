Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C56C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pA-0001yQ-1k; Mon, 17 Feb 2025 14:30:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6ov-0001uM-2q
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:22 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6os-0008JO-K8
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:20 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-219f8263ae0so83256895ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820615; x=1740425415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkSZ1z/mYS0WLY38Nj4nOWztbQOUR5F30WqULi7ciuM=;
 b=JCP9SudIvzqypuZuynvTjbSARncuzrurhS5r/tYST/OZicpZH9wEx964AV6tBe3pug
 vJi8C8s2QOb1i12tBEBPHF2AuZ1VcXEIRNwsDwJi5J9qS/huxQeL9mR+kvSsxxRygzX5
 uznH0dBAEEW63KylMdMJWZJ0tG1bifl3ARMGLCTURxooG+uEpdtT6duqLcegz/GCOdoW
 cWFN9aWoG048pAj+rePAD8PbX3X4PuODk64BV7yOM6tCNXdKCWVddEStdUdc919hC4XV
 D+wN23SzOpCnZQJexmLsJcza/b8z3wtY4BHlIJjX057rQu0lOXmlobz38SmkzljXRCL6
 jHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820615; x=1740425415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MkSZ1z/mYS0WLY38Nj4nOWztbQOUR5F30WqULi7ciuM=;
 b=WM6PVUdWRVpINpeQeQousODmkZU3uHq4749WanwqSYMu7C9q8FG8ibliHIHjGs7KdD
 4uRkyjdJP5JrqJBhfp9okIpe5JOBGBb1XlLNdS3FqK5cd2oCS6xQHNzYoeLW5DPmBHoH
 ZLarSRsbiilotcfOwR9C0R/rTFMRG3cKW6LNeS2NambekMr/e++OfhPudsXQ9K4VBUEZ
 WLCNSS+3U2oiHxy4ngDbcmUxeRPTB5usdu8BzOnmExloEHq9Z8mnWAvGx+5RBnFA2xkW
 j6zO8EKPicvJYh0zJrYgfwvdIyRExF6JZZ44ZtqN2bv4oG2qUN58sxTjdgGXi4zX4th+
 vWRQ==
X-Gm-Message-State: AOJu0Ywrjx46OhlVXaUR+nKyUJ7yutCE6RX+EdSgF4vJI0bouXnh1muN
 LVswZuHe/tXCl0XMShQehjBmBXUV0Uno6IumswnxeBu/ND9FUuKUA38hZ1XzPfqT//BJdpr7MDE
 R
X-Gm-Gg: ASbGncuZeGR7kW7xqBxE38oK++c39HQMPk8F4W3Bly9ur5WvYJBKPuO90JmzfnvSP0H
 Xant6+OiJj64lMYgGPhbx1/OHnnIus42F13kQCtcw42zSvT82KepcWBKtmGUYadIQxDQ7m0sjO5
 cO4Uqq8As83MDVVFacyX8gU2jIklfd9noO14jRvivSyuqC2qtZWr9okTJF9qS6UfPncJKiZMCFW
 zYEpB7Trvvb+6r5NzWztvgNKK37yk1/XSBd36ihUsMFnPC3Tqv5/nlzewDC97riJfVk5wa31p2f
 gigIVCvA7v8JCiBOoc70ZTDGoaMjdWKLhv4UW0dVPYLmTRQ=
X-Google-Smtp-Source: AGHT+IF++rLmmL4NMOJLzICqB3mZ5LG2760Rn+f5NJ79hA4IU94tEdyWd9h51UEOuy7JWsk9reiaVQ==
X-Received: by 2002:a05:6a21:898c:b0:1ee:aa06:1a48 with SMTP id
 adf61e73a8af0-1eeaa06b243mr8842112637.22.1739820615191; 
 Mon, 17 Feb 2025 11:30:15 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 06/27] tcg/i386: Drop addrhi from prepare_host_addr
Date: Mon, 17 Feb 2025 11:29:47 -0800
Message-ID: <20250217193009.2873875-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
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
 tcg/i386/tcg-target.c.inc | 56 ++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 36 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index ca6e8abc57..b33fe7fe23 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2169,8 +2169,7 @@ static inline int setup_guest_base_seg(void)
  * is required and fill in @h with the host address for the fast path.
  */
 static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
-                                           TCGReg addrlo, TCGReg addrhi,
-                                           MemOpIdx oi, bool is_ld)
+                                           TCGReg addr, MemOpIdx oi, bool is_ld)
 {
     TCGLabelQemuLdst *ldst = NULL;
     MemOp opc = get_memop(oi);
@@ -2184,7 +2183,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     } else {
         *h = x86_guest_base;
     }
-    h->base = addrlo;
+    h->base = addr;
     h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, s_bits == MO_128);
     a_mask = (1 << h->aa.align) - 1;
 
@@ -2202,8 +2201,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addrlo;
-        ldst->addrhi_reg = addrhi;
+        ldst->addrlo_reg = addr;
 
         if (TCG_TARGET_REG_BITS == 64) {
             ttype = s->addr_type;
@@ -2217,7 +2215,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             }
         }
 
-        tcg_out_mov(s, tlbtype, TCG_REG_L0, addrlo);
+        tcg_out_mov(s, tlbtype, TCG_REG_L0, addr);
         tcg_out_shifti(s, SHIFT_SHR + tlbrexw, TCG_REG_L0,
                        s->page_bits - CPU_TLB_ENTRY_BITS);
 
@@ -2233,10 +2231,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
          * check that we don't cross pages for the complete access.
          */
         if (a_mask >= s_mask) {
-            tcg_out_mov(s, ttype, TCG_REG_L1, addrlo);
+            tcg_out_mov(s, ttype, TCG_REG_L1, addr);
         } else {
             tcg_out_modrm_offset(s, OPC_LEA + trexw, TCG_REG_L1,
-                                 addrlo, s_mask - a_mask);
+                                 addr, s_mask - a_mask);
         }
         tlb_mask = s->page_mask | a_mask;
         tgen_arithi(s, ARITH_AND + trexw, TCG_REG_L1, tlb_mask, 0);
@@ -2250,17 +2248,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst->label_ptr[0] = s->code_ptr;
         s->code_ptr += 4;
 
-        if (TCG_TARGET_REG_BITS == 32 && s->addr_type == TCG_TYPE_I64) {
-            /* cmp 4(TCG_REG_L0), addrhi */
-            tcg_out_modrm_offset(s, OPC_CMP_GvEv, addrhi,
-                                 TCG_REG_L0, cmp_ofs + 4);
-
-            /* jne slow_path */
-            tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
-            ldst->label_ptr[1] = s->code_ptr;
-            s->code_ptr += 4;
-        }
-
         /* TLB Hit.  */
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_L0, TCG_REG_L0,
                    offsetof(CPUTLBEntry, addend));
@@ -2270,11 +2257,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addrlo;
-        ldst->addrhi_reg = addrhi;
+        ldst->addrlo_reg = addr;
 
         /* jne slow_path */
-        jcc = tcg_out_cmp(s, TCG_COND_TSTNE, addrlo, a_mask, true, false);
+        jcc = tcg_out_cmp(s, TCG_COND_TSTNE, addr, a_mask, true, false);
         tcg_out_opc(s, OPC_JCC_long + jcc, 0, 0, 0);
         ldst->label_ptr[0] = s->code_ptr;
         s->code_ptr += 4;
@@ -2446,13 +2432,12 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
 }
 
 static void tcg_out_qemu_ld(TCGContext *s, TCGReg datalo, TCGReg datahi,
-                            TCGReg addrlo, TCGReg addrhi,
-                            MemOpIdx oi, TCGType data_type)
+                            TCGReg addr, MemOpIdx oi, TCGType data_type)
 {
     TCGLabelQemuLdst *ldst;
     HostAddress h;
 
-    ldst = prepare_host_addr(s, &h, addrlo, addrhi, oi, true);
+    ldst = prepare_host_addr(s, &h, addr, oi, true);
     tcg_out_qemu_ld_direct(s, datalo, datahi, h, data_type, get_memop(oi));
 
     if (ldst) {
@@ -2574,13 +2559,12 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
 }
 
 static void tcg_out_qemu_st(TCGContext *s, TCGReg datalo, TCGReg datahi,
-                            TCGReg addrlo, TCGReg addrhi,
-                            MemOpIdx oi, TCGType data_type)
+                            TCGReg addr, MemOpIdx oi, TCGType data_type)
 {
     TCGLabelQemuLdst *ldst;
     HostAddress h;
 
-    ldst = prepare_host_addr(s, &h, addrlo, addrhi, oi, false);
+    ldst = prepare_host_addr(s, &h, addr, oi, false);
     tcg_out_qemu_st_direct(s, datalo, datahi, h, get_memop(oi));
 
     if (ldst) {
@@ -2880,34 +2864,34 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     case INDEX_op_qemu_ld_i32:
-        tcg_out_qemu_ld(s, a0, -1, a1, -1, a2, TCG_TYPE_I32);
+        tcg_out_qemu_ld(s, a0, -1, a1, a2, TCG_TYPE_I32);
         break;
     case INDEX_op_qemu_ld_i64:
         if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_ld(s, a0, -1, a1, -1, a2, TCG_TYPE_I64);
+            tcg_out_qemu_ld(s, a0, -1, a1, a2, TCG_TYPE_I64);
         } else {
-            tcg_out_qemu_ld(s, a0, a1, a2, -1, args[3], TCG_TYPE_I64);
+            tcg_out_qemu_ld(s, a0, a1, a2, args[3], TCG_TYPE_I64);
         }
         break;
     case INDEX_op_qemu_ld_i128:
         tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-        tcg_out_qemu_ld(s, a0, a1, a2, -1, args[3], TCG_TYPE_I128);
+        tcg_out_qemu_ld(s, a0, a1, a2, args[3], TCG_TYPE_I128);
         break;
 
     case INDEX_op_qemu_st_i32:
     case INDEX_op_qemu_st8_i32:
-        tcg_out_qemu_st(s, a0, -1, a1, -1, a2, TCG_TYPE_I32);
+        tcg_out_qemu_st(s, a0, -1, a1, a2, TCG_TYPE_I32);
         break;
     case INDEX_op_qemu_st_i64:
         if (TCG_TARGET_REG_BITS == 64) {
-            tcg_out_qemu_st(s, a0, -1, a1, -1, a2, TCG_TYPE_I64);
+            tcg_out_qemu_st(s, a0, -1, a1, a2, TCG_TYPE_I64);
         } else {
-            tcg_out_qemu_st(s, a0, a1, a2, -1, args[3], TCG_TYPE_I64);
+            tcg_out_qemu_st(s, a0, a1, a2, args[3], TCG_TYPE_I64);
         }
         break;
     case INDEX_op_qemu_st_i128:
         tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
-        tcg_out_qemu_st(s, a0, a1, a2, -1, args[3], TCG_TYPE_I128);
+        tcg_out_qemu_st(s, a0, a1, a2, args[3], TCG_TYPE_I128);
         break;
 
     OP_32_64(mulu2):
-- 
2.43.0


