Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2B7C7115D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7yy-00052Z-AO; Sat, 21 Jun 2025 19:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yw-00050s-FE
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:46 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yu-0004R2-I6
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:46 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-742caef5896so2329793b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549843; x=1751154643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9cf3tZ+uL08zlh8bFAF0MJI9Fv9UayGjAADjcJixVgA=;
 b=hdzeNEPAxu2GFJAOfAijvgnutWdLVfMCDmztrLV96E6du/C37eRRRkU7bbmu56+IT6
 KnAmt1wROpoA7j02olTSIo/c46ZauVHswnQE4bkmOz/iLif/hOENeW0u+BROsMLMl83S
 lf04y2GxuKOfYFCZKXtB3l6WNPBf84+RkliWudAwhHGAWh3yQS2Zl389kOI4AkCG8mCo
 ksPPYSXuFl8spFRCQsPE7+gFdQwOEFAEv7WaX4QsP7g0rW+2wadMVagUlDFxm15RJUD7
 TASBerMwNueD9Z4LYqg8d5GSXyt6Q+tesTqck8ePsDnJ/aIWh5xXHW1VnvO7+JAVE0fF
 nhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549843; x=1751154643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9cf3tZ+uL08zlh8bFAF0MJI9Fv9UayGjAADjcJixVgA=;
 b=uAZOUqgQ2IBGJ4e8rZDptaZqLcQWR8KmtyHjrGcZVlVPmAI5/wH33pu8NmwHLDRCHb
 lUtKE+5IB5Zrin5kDF/87O1QeeN7k4gz/llsP5s32AbSh3YfXGe/zbb0LFbLG9ayJFCk
 TNdCPjAvUURr3BN8W0aAjmccSvSL4L/MgVK7YxSBXKnHZdpcHWxkrRv862Dnpfsu8DcL
 HpZoDJn5NkOujHjTQbPdIAO9mR+a3jOmjhnKMdxRIjwAMG/aT7LOF6D4sFLbGAqi7PRI
 tNzEa5G4EW5OykvvANIQjkIV1zptQZtpB2vkIezaApjEV22NBghsEPMMgENenr93tpCS
 Y/tQ==
X-Gm-Message-State: AOJu0YzRmUEmZ6xuoItAf7ZXBeN7aMwwLRb9Yw/XNijvDF+sEzxeir4f
 x8MLGbTuyUmk5OziTXHuRfrpn/117pdA3mQCsf282/YHlJtVKiJg4KwzidBrysyG3fuSt3nwybO
 pzyrS
X-Gm-Gg: ASbGncvXf8tTWUt5HBMPVZgotp7kC3dOPdTPnaZO2gN1wr+pDgfzsQKvEVV9Jct3Yfn
 PfSIeu6faOF245RP90H2wdgSjrUidb7ZnHMBYEX+XgMrtzd1OY3BpkDyBBs4QQee/EF5I9khh7n
 F9kN7vGNgEysmIl8169I3C1wMbWiLAuztkjK8AWVvbFfymYvpQK6yU+guUjdmm5fnSRg86Hy/wM
 x80Dh08AWyQG3w4EhkVtu8bsbi6DCMWGCyKzyDVASS9n4nydgQnwDfpNXhJwUQS63lYLvWebzN7
 LBKC9Fh63n78oJz16bI0qx+8B24y+wmWiCW1WR6P2ZgrZ8LFGsLLCxrn/DtMkVZwkegMxoB1MTt
 eYrKnOK4Tq/8LblmeCWE3IV0ylQCJf4c=
X-Google-Smtp-Source: AGHT+IHM+xK3hNe6f+EnJztszqqiMrh4+mtIlLVnLOVUWqsTBMhAjNl8uDr7ljMN8wm3m19LxOoNvQ==
X-Received: by 2002:a05:6a00:c82:b0:73e:2dc5:a93c with SMTP id
 d2e1a72fcca58-7490da69427mr9909107b3a.11.1750549843151; 
 Sat, 21 Jun 2025 16:50:43 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 006/101] tcg: Split out tcg_gen_gvec_3_var
Date: Sat, 21 Jun 2025 16:49:02 -0700
Message-ID: <20250621235037.74091-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, OBFU_UNSUB_UL=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec-common.h |   4 ++
 tcg/tcg-op-gvec.c                | 102 +++++++++++++++++++------------
 2 files changed, 68 insertions(+), 38 deletions(-)

diff --git a/include/tcg/tcg-op-gvec-common.h b/include/tcg/tcg-op-gvec-common.h
index 877871c101..6e8fccad01 100644
--- a/include/tcg/tcg-op-gvec-common.h
+++ b/include/tcg/tcg-op-gvec-common.h
@@ -236,6 +236,10 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
                      uint32_t maxsz, int64_t c, const GVecGen2i *);
 void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
                      uint32_t maxsz, TCGv_i64 c, const GVecGen2s *);
+void tcg_gen_gvec_3_var(TCGv_ptr dbase, uint32_t dofs,
+                        TCGv_ptr abase, uint32_t aofs,
+                        TCGv_ptr bbase, uint32_t bofs,
+                        uint32_t oprsz, uint32_t maxsz, const GVecGen3 *);
 void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen3 *);
 void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 08019421f2..3e53e43354 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -178,9 +178,11 @@ void tcg_gen_gvec_2i_ool(uint32_t dofs, uint32_t aofs, TCGv_i64 c,
 }
 
 /* Generate a call to a gvec-style helper with three vector operands.  */
-void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                        uint32_t oprsz, uint32_t maxsz, int32_t data,
-                        gen_helper_gvec_3 *fn)
+static void expand_3_ool(TCGv_ptr dbase, uint32_t dofs,
+                         TCGv_ptr abase, uint32_t aofs,
+                         TCGv_ptr bbase, uint32_t bofs,
+                         uint32_t oprsz, uint32_t maxsz,
+                         int32_t data, gen_helper_gvec_3 *fn)
 {
     TCGv_ptr a0, a1, a2;
     TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
@@ -189,9 +191,9 @@ void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     a1 = tcg_temp_ebb_new_ptr();
     a2 = tcg_temp_ebb_new_ptr();
 
-    tcg_gen_addi_ptr(a0, tcg_env, dofs);
-    tcg_gen_addi_ptr(a1, tcg_env, aofs);
-    tcg_gen_addi_ptr(a2, tcg_env, bofs);
+    tcg_gen_addi_ptr(a0, dbase, dofs);
+    tcg_gen_addi_ptr(a1, abase, aofs);
+    tcg_gen_addi_ptr(a2, bbase, bofs);
 
     fn(a0, a1, a2, desc);
 
@@ -200,6 +202,14 @@ void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_temp_free_ptr(a2);
 }
 
+void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t oprsz, uint32_t maxsz, int32_t data,
+                        gen_helper_gvec_3 *fn)
+{
+    expand_3_ool(tcg_env, dofs, tcg_env, aofs, tcg_env, bofs,
+                 oprsz, maxsz, data, fn);
+}
+
 /* Generate a call to a gvec-style helper with four vector operands.  */
 void tcg_gen_gvec_4_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         uint32_t cofs, uint32_t oprsz, uint32_t maxsz,
@@ -789,8 +799,10 @@ static void expand_2s_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
 }
 
 /* Expand OPSZ bytes worth of three-operand operations using i32 elements.  */
-static void expand_3_i32(uint32_t dofs, uint32_t aofs,
-                         uint32_t bofs, uint32_t oprsz, bool load_dest,
+static void expand_3_i32(TCGv_ptr dbase, uint32_t dofs,
+                         TCGv_ptr abase, uint32_t aofs,
+                         TCGv_ptr bbase, uint32_t bofs,
+                         uint32_t oprsz, bool load_dest,
                          void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
     TCGv_i32 t0 = tcg_temp_new_i32();
@@ -799,13 +811,13 @@ static void expand_3_i32(uint32_t dofs, uint32_t aofs,
     uint32_t i;
 
     for (i = 0; i < oprsz; i += 4) {
-        tcg_gen_ld_i32(t0, tcg_env, aofs + i);
-        tcg_gen_ld_i32(t1, tcg_env, bofs + i);
+        tcg_gen_ld_i32(t0, abase, aofs + i);
+        tcg_gen_ld_i32(t1, bbase, bofs + i);
         if (load_dest) {
-            tcg_gen_ld_i32(t2, tcg_env, dofs + i);
+            tcg_gen_ld_i32(t2, dbase, dofs + i);
         }
         fni(t2, t0, t1);
-        tcg_gen_st_i32(t2, tcg_env, dofs + i);
+        tcg_gen_st_i32(t2, dbase, dofs + i);
     }
     tcg_temp_free_i32(t2);
     tcg_temp_free_i32(t1);
@@ -953,8 +965,10 @@ static void expand_2s_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
 }
 
 /* Expand OPSZ bytes worth of three-operand operations using i64 elements.  */
-static void expand_3_i64(uint32_t dofs, uint32_t aofs,
-                         uint32_t bofs, uint32_t oprsz, bool load_dest,
+static void expand_3_i64(TCGv_ptr dbase, uint32_t dofs,
+                         TCGv_ptr abase, uint32_t aofs,
+                         TCGv_ptr bbase, uint32_t bofs,
+                         uint32_t oprsz, bool load_dest,
                          void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
     TCGv_i64 t0 = tcg_temp_new_i64();
@@ -963,13 +977,13 @@ static void expand_3_i64(uint32_t dofs, uint32_t aofs,
     uint32_t i;
 
     for (i = 0; i < oprsz; i += 8) {
-        tcg_gen_ld_i64(t0, tcg_env, aofs + i);
-        tcg_gen_ld_i64(t1, tcg_env, bofs + i);
+        tcg_gen_ld_i64(t0, abase, aofs + i);
+        tcg_gen_ld_i64(t1, bbase, bofs + i);
         if (load_dest) {
-            tcg_gen_ld_i64(t2, tcg_env, dofs + i);
+            tcg_gen_ld_i64(t2, dbase, dofs + i);
         }
         fni(t2, t0, t1);
-        tcg_gen_st_i64(t2, tcg_env, dofs + i);
+        tcg_gen_st_i64(t2, dbase, dofs + i);
     }
     tcg_temp_free_i64(t2);
     tcg_temp_free_i64(t1);
@@ -1114,8 +1128,9 @@ static void expand_2s_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
 }
 
 /* Expand OPSZ bytes worth of three-operand operations using host vectors.  */
-static void expand_3_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
-                         uint32_t bofs, uint32_t oprsz,
+static void expand_3_vec(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                         TCGv_ptr abase, uint32_t aofs,
+                         TCGv_ptr bbase, uint32_t bofs, uint32_t oprsz,
                          uint32_t tysz, TCGType type, bool load_dest,
                          void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
 {
@@ -1124,13 +1139,13 @@ static void expand_3_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
         TCGv_vec t1 = tcg_temp_new_vec(type);
         TCGv_vec t2 = tcg_temp_new_vec(type);
 
-        tcg_gen_ld_vec(t0, tcg_env, aofs + i);
-        tcg_gen_ld_vec(t1, tcg_env, bofs + i);
+        tcg_gen_ld_vec(t0, abase, aofs + i);
+        tcg_gen_ld_vec(t1, bbase, bofs + i);
         if (load_dest) {
-            tcg_gen_ld_vec(t2, tcg_env, dofs + i);
+            tcg_gen_ld_vec(t2, dbase, dofs + i);
         }
         fni(vece, t2, t0, t1);
-        tcg_gen_st_vec(t2, tcg_env, dofs + i);
+        tcg_gen_st_vec(t2, dbase, dofs + i);
     }
 }
 
@@ -1432,8 +1447,10 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
 }
 
 /* Expand a vector three-operand operation.  */
-void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                    uint32_t oprsz, uint32_t maxsz, const GVecGen3 *g)
+void tcg_gen_gvec_3_var(TCGv_ptr dbase, uint32_t dofs,
+                        TCGv_ptr abase, uint32_t aofs,
+                        TCGv_ptr bbase, uint32_t bofs,
+                        uint32_t oprsz, uint32_t maxsz, const GVecGen3 *g)
 {
     const TCGOpcode *this_list = g->opt_opc ? : vecop_list_empty;
     const TCGOpcode *hold_list = tcg_swap_vecop_list(this_list);
@@ -1441,7 +1458,7 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs | bofs);
-    check_overlap_3(tcg_env, dofs, tcg_env, aofs, tcg_env, bofs, maxsz);
+    check_overlap_3(dbase, dofs, abase, aofs, bbase, bofs, maxsz);
 
     type = 0;
     if (g->fniv) {
@@ -1454,8 +1471,8 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
          * that e.g. size == 80 would be expanded with 2x32 + 1x16.
          */
         some = QEMU_ALIGN_DOWN(oprsz, 32);
-        expand_3_vec(g->vece, dofs, aofs, bofs, some, 32, TCG_TYPE_V256,
-                     g->load_dest, g->fniv);
+        expand_3_vec(g->vece, dbase, dofs, abase, aofs, bbase, bofs,
+                     some, 32, TCG_TYPE_V256, g->load_dest, g->fniv);
         if (some == oprsz) {
             break;
         }
@@ -1466,23 +1483,25 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
         maxsz -= some;
         /* fallthru */
     case TCG_TYPE_V128:
-        expand_3_vec(g->vece, dofs, aofs, bofs, oprsz, 16, TCG_TYPE_V128,
-                     g->load_dest, g->fniv);
+        expand_3_vec(g->vece, dbase, dofs, abase, aofs, bbase, bofs,
+                     oprsz, 16, TCG_TYPE_V128, g->load_dest, g->fniv);
         break;
     case TCG_TYPE_V64:
-        expand_3_vec(g->vece, dofs, aofs, bofs, oprsz, 8, TCG_TYPE_V64,
-                     g->load_dest, g->fniv);
+        expand_3_vec(g->vece, dbase, dofs, abase, aofs, bbase, bofs,
+                     oprsz, 8, TCG_TYPE_V64, g->load_dest, g->fniv);
         break;
 
     case 0:
         if (g->fni8 && check_size_impl(oprsz, 8)) {
-            expand_3_i64(dofs, aofs, bofs, oprsz, g->load_dest, g->fni8);
+            expand_3_i64(dbase, dofs, abase, aofs, bbase, bofs,
+                         oprsz, g->load_dest, g->fni8);
         } else if (g->fni4 && check_size_impl(oprsz, 4)) {
-            expand_3_i32(dofs, aofs, bofs, oprsz, g->load_dest, g->fni4);
+            expand_3_i32(dbase, dofs, abase, aofs, bbase, bofs,
+                         oprsz, g->load_dest, g->fni4);
         } else {
             assert(g->fno != NULL);
-            tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz,
-                               maxsz, g->data, g->fno);
+            expand_3_ool(dbase, dofs, abase, aofs, bbase, bofs,
+                         oprsz, maxsz, g->data, g->fno);
             oprsz = maxsz;
         }
         break;
@@ -1493,10 +1512,17 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
-        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
+        expand_clr(dbase, dofs + oprsz, maxsz - oprsz);
     }
 }
 
+void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                    uint32_t oprsz, uint32_t maxsz, const GVecGen3 *g)
+{
+    tcg_gen_gvec_3_var(tcg_env, dofs, tcg_env, aofs, tcg_env, bofs,
+                       oprsz, maxsz, g);
+}
+
 /* Expand a vector operation with three vectors and an immediate.  */
 void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                      uint32_t oprsz, uint32_t maxsz, int64_t c,
-- 
2.43.0


