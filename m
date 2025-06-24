Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA891C7115B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 01:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTsJZ-0000Ye-9P; Mon, 23 Jun 2025 21:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJX-0000Y4-Ux
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:07 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJV-0005nS-TZ
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:07 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-747fba9f962so3733219b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 18:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750727944; x=1751332744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b3bQlxtzdvRq49LaNxL8i9SqtH1rO/onPFJfQvnOe7Y=;
 b=txzcvkl+IvkV/PkJVAfGMqxsgZF40pTFCfh6waSH6vQ/WFolv6OhkdxPR8InBj15FI
 M9POI/bdg7YqXfhqLzzSTiyp+g1dojwUWdjl6E9IEaG+W0zikbOR7is6UkK/JBV/sTXl
 U+bpQAUbiAfZDuejbGX16/EQi+J98MhqVbacjheFrjOc+nfxeFyTLWtBXNvCu5F+dJX3
 MeqG64KgfdYklQ5/eZwBu2E48ofKjXQl+ZKdxAOd3lq17lyrkGwH9GRgqCR/FnU38bw3
 PzzYDd/sbsDAS7u/p0kXRSi07l6MI2mEZ/Q4rWy3+n+lywoa1aZsYu/n1Zyo71i3qeKh
 MPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750727944; x=1751332744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b3bQlxtzdvRq49LaNxL8i9SqtH1rO/onPFJfQvnOe7Y=;
 b=AL8ZyYsh1Y6h46waVrppi4nqSST/Li1xiID4lxsxVkj6Mk2jWdDNbXuahCaUVaYykn
 LuSYVvHBn05jm4eii7wDjc06kWq1CosVmK9b1PaoPmSYPybOxKADFWNJhzTERNhSLAR5
 OxHrSP5fupelUZPwN/DvkjFfo8EOMkBMAKtiufC+2xWe5XDmPT1xVkZfwvboU0ehWGf8
 uph+fSnBv+i/7zisjumva3wa/hjf9C8YT0/akKRh+5fdIEJuYD6YxPvnPFBFgPcZlCzS
 Js68KnjK6U06rtT5pvrmlS4m8Aino51jsKGZR+5dCKdIJPHT+oFr0sxQM/8vQ6eS2jVV
 Q7Vw==
X-Gm-Message-State: AOJu0YwktgXCo+2Egd0ogo+Vr6uS/pnlSAzi3Vf0DTrkmq4dEeQizen7
 6cxlgVKgz6/gxmVCcTj5XSWv5xjdq2OIhe7a+OR6Kcram1Sp1SBkLgAPBIdwh8Eajl1ptpLLWVy
 dZx+vf7Q=
X-Gm-Gg: ASbGncusWZxKA1rR0T3rO+mrjTnLgBhrt6PtlbePkqBEIsRuAJWKD1f9ZzAuN8wAk9B
 LOekkYIW64OdndXPUd97/rk60I+CXNOmUnR3o4oLfs7FcdOypFTtY/DyNzJwBt8PnjxXq4CoNrC
 alqk37Gv4rnEhIZxqDtFi1iIGY+H7NjgvE+9a8sbnJWD2F4gOEXLx+pvTc9BMXEMISzbnbGncwq
 iQ7aQX3MEzfUOP/B7JbUCr2o0SYwgFOB4FsY+wIOEGR7dPLeFNtzw5EdArRKaduU1D3C+PHe1qM
 wLAqX7CLzoC0lNE4wlUtgjNzSP+w6/ri/KeHpEm8AuE3WpZqNvpFGUMAA3Epk1+IWn7JdEBxZNk
 iGdX2Vn50HxAGg0FmX2nh
X-Google-Smtp-Source: AGHT+IFrBScu+aNdN6vtQ+PDUqJp81Fk+6K1esGIU6WNUDnaCsoxb6AJmlp9i/AFk+ZNLxh+KELR6g==
X-Received: by 2002:a05:6a00:a8c:b0:736:4d05:2e35 with SMTP id
 d2e1a72fcca58-74955b64e9amr2381953b3a.3.1750727944043; 
 Mon, 23 Jun 2025 18:19:04 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e08d28sm412080b3a.28.2025.06.23.18.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 18:19:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/11] tcg: Split out tcg_gen_gvec_2_var
Date: Mon, 23 Jun 2025 18:18:53 -0700
Message-ID: <20250624011859.112010-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624011859.112010-1-richard.henderson@linaro.org>
References: <20250624011859.112010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec-common.h | 14 ++++--
 tcg/tcg-op-gvec.c                | 85 ++++++++++++++++++++------------
 2 files changed, 64 insertions(+), 35 deletions(-)

diff --git a/include/tcg/tcg-op-gvec-common.h b/include/tcg/tcg-op-gvec-common.h
index 65553f5f97..f00af047c4 100644
--- a/include/tcg/tcg-op-gvec-common.h
+++ b/include/tcg/tcg-op-gvec-common.h
@@ -227,12 +227,20 @@ typedef struct {
     bool prefer_i64;
 } GVecGen4i;
 
+/* Expand (dbase+dofs) = op(abase+aofs), length @oprsz, clearing to @maxsz. */
+void tcg_gen_gvec_2_var(TCGv_ptr dbase, uint32_t dofs,
+                        TCGv_ptr abase, uint32_t aofs,
+                        uint32_t oprsz, uint32_t maxsz, const GVecGen2 *op);
+/* Similarly, expand (env+dofs) = op(env+aofs). */
 void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
-                    uint32_t oprsz, uint32_t maxsz, const GVecGen2 *);
+                    uint32_t oprsz, uint32_t maxsz, const GVecGen2 *op);
+/* Similarly, expand (env+dofs) = op(env+aofs, c). */
 void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                     uint32_t maxsz, int64_t c, const GVecGen2i *);
+                     uint32_t maxsz, int64_t c, const GVecGen2i *op);
+/* Similarly, expand (env+dofs) = op(env+aofs, s). */
 void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                     uint32_t maxsz, TCGv_i64 c, const GVecGen2s *);
+                     uint32_t maxsz, TCGv_i64 c, const GVecGen2s *op);
+
 void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen3 *);
 void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 0e6b42476e..ec926bdcd7 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -133,9 +133,10 @@ uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data)
 }
 
 /* Generate a call to a gvec-style helper with two vector operands.  */
-void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,
-                        uint32_t oprsz, uint32_t maxsz, int32_t data,
-                        gen_helper_gvec_2 *fn)
+static void expand_2_ool(TCGv_ptr dbase, uint32_t dofs,
+                         TCGv_ptr abase, uint32_t aofs,
+                         uint32_t oprsz, uint32_t maxsz,
+                         int32_t data, gen_helper_gvec_2 *fn)
 {
     TCGv_ptr a0, a1;
     TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
@@ -143,8 +144,8 @@ void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,
     a0 = tcg_temp_ebb_new_ptr();
     a1 = tcg_temp_ebb_new_ptr();
 
-    tcg_gen_addi_ptr(a0, tcg_env, dofs);
-    tcg_gen_addi_ptr(a1, tcg_env, aofs);
+    tcg_gen_addi_ptr(a0, dbase, dofs);
+    tcg_gen_addi_ptr(a1, abase, aofs);
 
     fn(a0, a1, desc);
 
@@ -152,6 +153,13 @@ void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,
     tcg_temp_free_ptr(a1);
 }
 
+void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,
+                        uint32_t oprsz, uint32_t maxsz, int32_t data,
+                        gen_helper_gvec_2 *fn)
+{
+    expand_2_ool(tcg_env, dofs, tcg_env, aofs, oprsz, maxsz, data, fn);
+}
+
 /* Generate a call to a gvec-style helper with two vector operands
    and one scalar operand.  */
 void tcg_gen_gvec_2i_ool(uint32_t dofs, uint32_t aofs, TCGv_i64 c,
@@ -724,20 +732,21 @@ static void expand_clr(TCGv_ptr dbase, uint32_t dofs, uint32_t maxsz)
 }
 
 /* Expand OPSZ bytes worth of two-operand operations using i32 elements.  */
-static void expand_2_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                         bool load_dest, void (*fni)(TCGv_i32, TCGv_i32))
+static void expand_2_i32(TCGv_ptr dbase, uint32_t dofs, TCGv_ptr abase,
+                         uint32_t aofs, uint32_t oprsz, bool load_dest,
+                         void (*fni)(TCGv_i32, TCGv_i32))
 {
     TCGv_i32 t0 = tcg_temp_new_i32();
     TCGv_i32 t1 = tcg_temp_new_i32();
     uint32_t i;
 
     for (i = 0; i < oprsz; i += 4) {
-        tcg_gen_ld_i32(t0, tcg_env, aofs + i);
+        tcg_gen_ld_i32(t0, abase, aofs + i);
         if (load_dest) {
-            tcg_gen_ld_i32(t1, tcg_env, dofs + i);
+            tcg_gen_ld_i32(t1, dbase, dofs + i);
         }
         fni(t1, t0);
-        tcg_gen_st_i32(t1, tcg_env, dofs + i);
+        tcg_gen_st_i32(t1, dbase, dofs + i);
     }
     tcg_temp_free_i32(t0);
     tcg_temp_free_i32(t1);
@@ -887,20 +896,21 @@ static void expand_4i_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
 }
 
 /* Expand OPSZ bytes worth of two-operand operations using i64 elements.  */
-static void expand_2_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                         bool load_dest, void (*fni)(TCGv_i64, TCGv_i64))
+static void expand_2_i64(TCGv_ptr dbase, uint32_t dofs, TCGv_ptr abase,
+                         uint32_t aofs, uint32_t oprsz, bool load_dest,
+                         void (*fni)(TCGv_i64, TCGv_i64))
 {
     TCGv_i64 t0 = tcg_temp_new_i64();
     TCGv_i64 t1 = tcg_temp_new_i64();
     uint32_t i;
 
     for (i = 0; i < oprsz; i += 8) {
-        tcg_gen_ld_i64(t0, tcg_env, aofs + i);
+        tcg_gen_ld_i64(t0, abase, aofs + i);
         if (load_dest) {
-            tcg_gen_ld_i64(t1, tcg_env, dofs + i);
+            tcg_gen_ld_i64(t1, dbase, dofs + i);
         }
         fni(t1, t0);
-        tcg_gen_st_i64(t1, tcg_env, dofs + i);
+        tcg_gen_st_i64(t1, dbase, dofs + i);
     }
     tcg_temp_free_i64(t0);
     tcg_temp_free_i64(t1);
@@ -1050,7 +1060,8 @@ static void expand_4i_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
 }
 
 /* Expand OPSZ bytes worth of two-operand operations using host vectors.  */
-static void expand_2_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
+static void expand_2_vec(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                         TCGv_ptr abase, uint32_t aofs,
                          uint32_t oprsz, uint32_t tysz, TCGType type,
                          bool load_dest,
                          void (*fni)(unsigned, TCGv_vec, TCGv_vec))
@@ -1059,12 +1070,12 @@ static void expand_2_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
         TCGv_vec t0 = tcg_temp_new_vec(type);
         TCGv_vec t1 = tcg_temp_new_vec(type);
 
-        tcg_gen_ld_vec(t0, tcg_env, aofs + i);
+        tcg_gen_ld_vec(t0, abase, aofs + i);
         if (load_dest) {
-            tcg_gen_ld_vec(t1, tcg_env, dofs + i);
+            tcg_gen_ld_vec(t1, dbase, dofs + i);
         }
         fni(vece, t1, t0);
-        tcg_gen_st_vec(t1, tcg_env, dofs + i);
+        tcg_gen_st_vec(t1, dbase, dofs + i);
     }
 }
 
@@ -1206,8 +1217,9 @@ static void expand_4i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
 }
 
 /* Expand a vector two-operand operation.  */
-void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
-                    uint32_t oprsz, uint32_t maxsz, const GVecGen2 *g)
+void tcg_gen_gvec_2_var(TCGv_ptr dbase, uint32_t dofs,
+                        TCGv_ptr abase, uint32_t aofs,
+                        uint32_t oprsz, uint32_t maxsz, const GVecGen2 *g)
 {
     const TCGOpcode *this_list = g->opt_opc ? : vecop_list_empty;
     const TCGOpcode *hold_list = tcg_swap_vecop_list(this_list);
@@ -1215,7 +1227,7 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs);
-    check_overlap_2(tcg_env, dofs, tcg_env, aofs, maxsz);
+    check_overlap_2(dbase, dofs, abase, aofs, maxsz);
 
     type = 0;
     if (g->fniv) {
@@ -1228,8 +1240,8 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
          * that e.g. size == 80 would be expanded with 2x32 + 1x16.
          */
         some = QEMU_ALIGN_DOWN(oprsz, 32);
-        expand_2_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256,
-                     g->load_dest, g->fniv);
+        expand_2_vec(g->vece, dbase, dofs, abase, aofs, some, 32,
+                     TCG_TYPE_V256, g->load_dest, g->fniv);
         if (some == oprsz) {
             break;
         }
@@ -1239,22 +1251,25 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
         maxsz -= some;
         /* fallthru */
     case TCG_TYPE_V128:
-        expand_2_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,
-                     g->load_dest, g->fniv);
+        expand_2_vec(g->vece, dbase, dofs, abase, aofs, oprsz, 16,
+                     TCG_TYPE_V128, g->load_dest, g->fniv);
         break;
     case TCG_TYPE_V64:
-        expand_2_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,
-                     g->load_dest, g->fniv);
+        expand_2_vec(g->vece, dbase, dofs, abase, aofs, oprsz, 8,
+                     TCG_TYPE_V64, g->load_dest, g->fniv);
         break;
 
     case 0:
         if (g->fni8 && check_size_impl(oprsz, 8)) {
-            expand_2_i64(dofs, aofs, oprsz, g->load_dest, g->fni8);
+            expand_2_i64(dbase, dofs, abase, aofs,
+                         oprsz, g->load_dest, g->fni8);
         } else if (g->fni4 && check_size_impl(oprsz, 4)) {
-            expand_2_i32(dofs, aofs, oprsz, g->load_dest, g->fni4);
+            expand_2_i32(dbase, dofs, abase, aofs,
+                         oprsz, g->load_dest, g->fni4);
         } else {
             assert(g->fno != NULL);
-            tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, g->data, g->fno);
+            expand_2_ool(dbase, dofs, abase, aofs,
+                         oprsz, maxsz, g->data, g->fno);
             oprsz = maxsz;
         }
         break;
@@ -1265,10 +1280,16 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
     tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
-        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
+        expand_clr(dbase, dofs + oprsz, maxsz - oprsz);
     }
 }
 
+void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
+                    uint32_t oprsz, uint32_t maxsz, const GVecGen2 *g)
+{
+    tcg_gen_gvec_2_var(tcg_env, dofs, tcg_env, aofs, oprsz, maxsz, g);
+}
+
 /* Expand a vector operation with two vectors and an immediate.  */
 void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
                      uint32_t maxsz, int64_t c, const GVecGen2i *g)
-- 
2.43.0


