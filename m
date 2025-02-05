Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B999C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 04:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfWdo-0008IU-TX; Tue, 04 Feb 2025 23:03:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfWdk-0008Hl-Jh
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 23:03:52 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfWdg-00079N-T3
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 23:03:51 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21f05693a27so18806185ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 20:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738728227; x=1739333027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=swreBxlAtnKlo1b9Cq2bkzMDz6ZCxQg5nbFtz31l2ew=;
 b=QfB1aghfVKP0L3YjlsiRNYTuHKgYqf7H6tJ6szcub82vRCC4KVJ/5BA3qoAOcnzyZC
 k+ZJccd99gWmvdxKPt7Ldn1vA2/njKcIEJZ3wtDrztRM3oIUbAWD3Y9mj8ABAOlrcGm3
 uXlm8SWcYBcO+C0HZb4W+EbB7ZH+A4cMi1UGexMjiMJfJ72Kqj8bNZTGmi4oXWCtpLCK
 xC89zm2SeXzpmV6wrLVn1g9IG8n+TgiA8/kwA7m1oHJEDkywRZyuMMqOuOp994/TohuX
 LAo1owvpksrSLRkdnPmU7/J4LWcsTNF5rmvI56Nfqhi6rHgFcv7dJzQ2mpg2eSLwgYOS
 KXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738728227; x=1739333027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=swreBxlAtnKlo1b9Cq2bkzMDz6ZCxQg5nbFtz31l2ew=;
 b=blwSm7Lj7e/Gfph2Xg5pODMmlRzm7CDe/gso62XSQhGOv9zzje/1VQpoE96gcobOn9
 OY2yz1x/rKlzVYUgPsRdK5ZN2WALCuc2kR335jun7Za+iN/wOhH0uUYjqr1xxG0it5E4
 TRZiRCsvX7TOsw5KDmPGsBa61+pDOW2ox7NzTF2OqnIKsQvllVcf2hsypxQu8v5CNIC+
 7vrPb2WmlqhkULgVICUhjRJTTpvDZAdkcGEO3yLZmbF+qkcpyifHM6klm3gRBKdhUPgX
 mB4c7QS56+MC9vgG9ZZgC2fxPesT5msEj89dfPd3Epy1YQxr4UgCXdRc5xCcRfOuZsiX
 fEtw==
X-Gm-Message-State: AOJu0YwPgfPjghf2JwqYduaEk19D++odmo46s0klI/IKfJadGuzxQtnd
 BmQG60qob029Fct8I22lT2JsngYX2V8jVbCo6f7cRI9DbDMmcaJS3cJx98udrhIy2cdtu1/G5g8
 6
X-Gm-Gg: ASbGncumoUeHE7riXn2s/DN6MCNMJSr/d9i/bZoXpo1mPC+bgP72LpDpVSXyeBJvuX6
 cW+C8aSfhCiv6Iy7XprLY1TcGdEydaLHw/A1kdl0Dtcb8+VfqkfUR+eAMmXDpkpYw8uhKtSTNYF
 F+Sfh/p49LJ87teA0MRe9BOfaGYxgLib7+j+QDalFjmeGc2T1y/pwlDnTwovbfrCSotCcOBBGBI
 BuRjRMn3hoxiuJKkoK1QVfMbLfOZ1m+2/fFLy/0je6dkYjV4XC6pHs8zWWpPz5y3poPrsGrlcDX
 ZP8vfFVLemPMljy//dD4MmsvbiSQFQVNYsZX7iZBuYT0omo=
X-Google-Smtp-Source: AGHT+IGA9j2tfHjlqwT92r3JXJXsPCDRw8iyQBF8p+P3JZ1vW5+opiQyghtiUZjnYTWy8fkMPCr3Tg==
X-Received: by 2002:a17:902:f686:b0:216:2426:7666 with SMTP id
 d9443c01a7336-21f17df5651mr21307135ad.12.1738728227219; 
 Tue, 04 Feb 2025 20:03:47 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f054eb89esm22380325ad.79.2025.02.04.20.03.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 20:03:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/11] tcg/i386: Drop addrhi from prepare_host_addr
Date: Tue,  4 Feb 2025 20:03:34 -0800
Message-ID: <20250205040341.2056361-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205040341.2056361-1-richard.henderson@linaro.org>
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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


