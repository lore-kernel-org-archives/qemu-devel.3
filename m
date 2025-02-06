Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB81C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 19:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg805-00078Q-9k; Thu, 06 Feb 2025 14:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg804-000772-1x
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:24 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg801-0000Rt-UG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:23 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21f48ebaadfso12071805ad.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871840; x=1739476640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RfMF2F0u1KO0UNQVblc+TNx0Vp4TbWKK/lW8gV/9m78=;
 b=Qmc97TnJGNpHnzcB927XzFlQKxRtWa8AwawN0uKirxluzCLarH330YK2kAy1MSPvew
 jHjqsEv8M3K2SpVkXxApUmalyb2mFleORw4l98oj02AmWyp8+grp+14gz3UbZ6GfTe/e
 eWbl25TlwmqYrOBMsYIeXtu5KukQPIHh+zS3OJbdBai/DqyoxtyGg6nePp+phoW75tWa
 ge+dgVHy3RfHYR7+V2yFJR+qJ99trfjEj+THNReNBjMbj8f82XT6IBbqao65L5GuIEx2
 /kl66fkxDjQvmdKkaLBJz/J6CDNKA+TXfsjnUEi8nluHhE3HJYFr9vbJ7c3wfUV5PdEU
 wuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871840; x=1739476640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RfMF2F0u1KO0UNQVblc+TNx0Vp4TbWKK/lW8gV/9m78=;
 b=LO1pqaoS+3tfPpHqqjFcVSniVOvdHQvjzNexPHKCedsC8JrrsQrV0XqXYvkWwWYTrG
 gBg6B/IUgFhUt18GUU24ThHgFSgirgF+5fRy2wx1/LNmmI+bqaTYKtLFp+OfgPdyObwr
 A8IxlewXc/G+xSNDBUTo9jPU0P0uRzs7aNih6VpRttwUIHvgen99AmfVbG0j/ifI7W9W
 iXcmwKwPcD4RICs/Uwx5hC4anHE5Q6fN8kfJlVFsQkSAdUWcc048M0DJNk5r9BRhfZip
 OncEjyXnSmrN66vYdlfkJJgxMP/YkWnLimUX7YiS8wXwXaH+cUrFgucEiFCO/yTMOEtc
 DTAw==
X-Gm-Message-State: AOJu0YwIae/RDFceKdFLusZca+8wb8ZZ+u6nxyS2mZnw+gHHn7i9XBAP
 lnZNDL8kwX0WwLcEy3xy3LpAX0TwoPE0dEa1dX6OU6YEOBx5tB4o+gThJgSz4ayJQ6Od3u03qHU
 s
X-Gm-Gg: ASbGnctAbZ1GqAuEZfk5KtNsOWroJLFwdGr8W3s+Fe+LnqOraVYUQviEb3c/3rJqJIE
 +7zSYiFTYaL01RwT7p0CjpeIEwrPl07/DvnzGZ3+2HmE9d8B6TmXNkOaHvnh2PFYh05E69ScqmB
 SKo0HCSPLX8qAjSrDq9WXUn1SMwicSLEm8Qn4VutJDr5bOEdPr60/cFRuZHvvvwlCaruRk98/jr
 Dkfp5d7H5h9SKmrO/a8uvvCNBzkea4S2o+2QNiAZ28oTl4+shmZUEotnCw4CTz9lLy7/+FNF0Bf
 9Nr8x5QEbck5XSTbpcOD+IanYqWvDj60ynVkwnnHSz1kARI=
X-Google-Smtp-Source: AGHT+IEiXlXeYDXvHZnNpbF62Q661oxYhEiax5pJtHec4AR8pzJzTNrn4y1mCNsW1OxgiuKnwYwKSA==
X-Received: by 2002:a05:6a00:148d:b0:724:e75b:22d1 with SMTP id
 d2e1a72fcca58-7305d4f0349mr940057b3a.16.1738871840376; 
 Thu, 06 Feb 2025 11:57:20 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 05/61] tcg: Split out tcg_gen_gvec_2_var
Date: Thu,  6 Feb 2025 11:56:19 -0800
Message-ID: <20250206195715.2150758-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 include/tcg/tcg-op-gvec-common.h |  3 ++
 tcg/tcg-op-gvec.c                | 85 ++++++++++++++++++++------------
 2 files changed, 56 insertions(+), 32 deletions(-)

diff --git a/include/tcg/tcg-op-gvec-common.h b/include/tcg/tcg-op-gvec-common.h
index 65553f5f97..877871c101 100644
--- a/include/tcg/tcg-op-gvec-common.h
+++ b/include/tcg/tcg-op-gvec-common.h
@@ -227,6 +227,9 @@ typedef struct {
     bool prefer_i64;
 } GVecGen4i;
 
+void tcg_gen_gvec_2_var(TCGv_ptr dbase, uint32_t dofs,
+                        TCGv_ptr abase, uint32_t aofs,
+                        uint32_t oprsz, uint32_t maxsz, const GVecGen2 *);
 void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen2 *);
 void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 54304d08cc..08019421f2 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -129,9 +129,10 @@ uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data)
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
@@ -139,8 +140,8 @@ void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,
     a0 = tcg_temp_ebb_new_ptr();
     a1 = tcg_temp_ebb_new_ptr();
 
-    tcg_gen_addi_ptr(a0, tcg_env, dofs);
-    tcg_gen_addi_ptr(a1, tcg_env, aofs);
+    tcg_gen_addi_ptr(a0, dbase, dofs);
+    tcg_gen_addi_ptr(a1, abase, aofs);
 
     fn(a0, a1, desc);
 
@@ -148,6 +149,13 @@ void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,
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
@@ -719,20 +727,21 @@ static void expand_clr(TCGv_ptr dbase, uint32_t dofs, uint32_t maxsz)
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
@@ -882,20 +891,21 @@ static void expand_4i_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
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
@@ -1045,7 +1055,8 @@ static void expand_4i_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
 }
 
 /* Expand OPSZ bytes worth of two-operand operations using host vectors.  */
-static void expand_2_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
+static void expand_2_vec(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                         TCGv_ptr abase, uint32_t aofs,
                          uint32_t oprsz, uint32_t tysz, TCGType type,
                          bool load_dest,
                          void (*fni)(unsigned, TCGv_vec, TCGv_vec))
@@ -1054,12 +1065,12 @@ static void expand_2_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
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
 
@@ -1201,8 +1212,9 @@ static void expand_4i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
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
@@ -1210,7 +1222,7 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs);
-    check_overlap_2(tcg_env, dofs, tcg_env, aofs, maxsz);
+    check_overlap_2(dbase, dofs, abase, aofs, maxsz);
 
     type = 0;
     if (g->fniv) {
@@ -1223,8 +1235,8 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
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
@@ -1234,22 +1246,25 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
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
@@ -1260,10 +1275,16 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
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


