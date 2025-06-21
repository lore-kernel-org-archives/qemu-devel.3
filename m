Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8375C7EE2A
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7zC-0005AM-Bl; Sat, 21 Jun 2025 19:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z8-00058Z-Kz
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:59 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z6-0004Up-QO
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:58 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso2537422b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549854; x=1751154654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RfCREBeWqP3xZCwzPTg3qYrCq3aLvYTQX4nKzsiQLes=;
 b=Y2OZzoWxDh87PmMoeV0B2ska6+iJRrP1+e+NMV+u69Q4pcUGZ2Nk6Q3aYvgRe5yUAG
 s/o4Af1cHADx7rN7calPzm0QeBh30HM/lNHzAutYcusR6AE2NuH89gRSUsh/T7nsVui6
 8nMtPKl1dWRXR6YNVi5aPeQzcVvOIfbQNmYfdmxf8Of/FVzXf8qIy/zio8ht87Hs5TA/
 JIbt3PXBXLQpQP/aDEfsx4CeWA2f8jIwznf3boZk+zgg9gYpupamSJnvBHtP0z6yAevM
 S4+useNosbVwwk+o3JxnHipGwSDwygUYiJufOV0/cD+FEt3rwha+b83BwVjAEjmlrgIv
 S64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549854; x=1751154654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RfCREBeWqP3xZCwzPTg3qYrCq3aLvYTQX4nKzsiQLes=;
 b=XGQGG2IHGfySRPkeJXwOoNjwJQ9TkFNzn1GWiRgpaSVV0gAOcd3MR/0rFApUXOfdWe
 2dsE2pqQw84X77AzsQTXjw8957FmCyoo9KjdOGUHfjq4CzUwSOdCuaxnBvKY0MMSpGM7
 8+6RA9clQykSfZYKwnFP4lieE4U4NFyQRUBXp3WlB7EE2GRA3eFws/eiHrhv5ykiXkkX
 36Iak9k+IqfXHG+0HAJk+3CTxetLCfkcKRvYcow+T2+ywEsTCC7wFVezLKM9JWwW53B5
 FJxVDyqsMKMvqpHIW9wXkWWCcGL8T8m0CwK+7MY7zAZAWo00imFZOxlFJPMU2PdV8J/r
 N8gA==
X-Gm-Message-State: AOJu0Yx+zJ5vMV81245rh9Y2/xjlsTscYJVz4iY3CTFdaKyTH/5Bakvv
 gV7mENPr8ttgu0U9+2P4sAcIc8JTnkOri3z+BklwYInCtd4+CNRq7Tus6JpZOnkZ25eDyiKBO1E
 zdXJE
X-Gm-Gg: ASbGnctcLMqWTYUhpy5ZU4KKOuixASOp5jxZOvBsmDnGWtKHn3TBoNiRFx+9FmASfZB
 SZE0IaraDUTT0TIOBiKN65rMBrQFLjdv7uetWbFsraPAC4Cn6zm9uJawDh0s55CDMttQmu1Tu+X
 9J1DOHrmT3WqHB1WxF0ew2IypjdZ68uVeMRoJCKP0wCmlFjvHj0KkWUMEwwsDSJEAjJnxnTFvEr
 JYpRCUuI/jr0QPmSbSTgfvpUev5T9L/YP3f6/1/wviqjFYyHRD23kUCQTu4U7ZHM6MvXnYVIvhE
 sAIYYtAH3ppPH+vLQ5jpjmm05kZBsAWXZnXVbEzOTxDWBLRpVnWGHe2jwG3cnJ9rnG5kU+KfiUh
 mjWxu6gF2rdsJ3Jry/Lh1
X-Google-Smtp-Source: AGHT+IEMR0zr1iueBBYR9oSmp369j5Px9hEh5DLvIzdgNtNkmGDRHGQTnv1zdLFEsXgR9bJYRUoIkA==
X-Received: by 2002:a05:6a20:734a:b0:21a:bdd2:c2f7 with SMTP id
 adf61e73a8af0-22026ef6690mr14568668637.29.1750549854362; 
 Sat, 21 Jun 2025 16:50:54 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 024/101] target/arm: Split out get_zarray
Date: Sat, 21 Jun 2025 16:49:20 -0700
Message-ID: <20250621235037.74091-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Prepare for MOVA array to/from vector with multiple registers
by adding a div_len parameter, herein always 1.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 40 ++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index eed9345651..a818a549cb 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -43,7 +43,7 @@ static bool sme2_zt0_enabled_check(DisasContext *s)
 
 /* Resolve tile.size[rs+imm] to a host pointer. */
 static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
-                                int tile, int imm, bool vertical)
+                                int tile, int imm, int div_len, bool vertical)
 {
     int pos, len, offset;
     TCGv_i32 tmp;
@@ -55,7 +55,7 @@ static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
     tcg_gen_addi_i32(tmp, tmp, imm);
 
     /* Prepare a power-of-two modulo via extraction of @len bits. */
-    len = ctz32(streaming_vec_reg_size(s)) - esz;
+    len = ctz32(streaming_vec_reg_size(s) / div_len) - esz;
 
     if (!len) {
         /*
@@ -111,6 +111,13 @@ static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
     return addr;
 }
 
+/* Resolve ZArray[rs+imm] to a host pointer. */
+static TCGv_ptr get_zarray(DisasContext *s, int rs, int imm, int div_len)
+{
+    /* ZA[n] equates to ZA0H.B[n]. */
+    return get_tile_rowcol(s, MO_8, rs, 0, imm, div_len, false);
+}
+
 /*
  * Resolve tile.size[0] to a host pointer.
  * Used by e.g. outer product insns where we require the entire tile.
@@ -177,7 +184,7 @@ static bool do_mova_tile(DisasContext *s, arg_mova_p *a, bool to_vec)
         return true;
     }
 
-    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za, a->off, a->v);
+    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za, a->off, 1, a->v);
     t_zr = vec_full_reg_ptr(s, a->zr);
     t_pg = pred_full_reg_ptr(s, a->pg);
 
@@ -234,7 +241,7 @@ static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
         for (int i = 0; i < n; ++i) {
             TCGv_ptr t_zr = vec_full_reg_ptr(s, a->zr * n + i);
             t_za = get_tile_rowcol(s, a->esz, a->rs, a->za,
-                                   a->off * n + i, a->v);
+                                   a->off * n + i, 1, a->v);
             if (to_vec) {
                 zc_fns[a->esz](t_zr, t_za, t_desc);
             } else {
@@ -243,13 +250,13 @@ static bool do_mova_tile_n(DisasContext *s, arg_mova_t *a, int n, bool to_vec)
         }
     } else {
         for (int i = 0; i < n; ++i) {
-            int zr_ofs = vec_full_reg_offset(s, a->zr * n + i);
+            int o_zr = vec_full_reg_offset(s, a->zr * n + i);
             t_za = get_tile_rowcol(s, a->esz, a->rs, a->za,
-                                   a->off * n + i, a->v);
+                                   a->off * n + i, 1, a->v);
             if (to_vec) {
-                tcg_gen_gvec_mov_var(MO_8, tcg_env, zr_ofs, t_za, 0, svl, svl);
+                tcg_gen_gvec_mov_var(MO_8, tcg_env, o_zr, t_za, 0, svl, svl);
             } else {
-                tcg_gen_gvec_mov_var(MO_8, t_za, 0, tcg_env, zr_ofs, svl, svl);
+                tcg_gen_gvec_mov_var(MO_8, t_za, 0, tcg_env, o_zr, svl, svl);
             }
         }
     }
@@ -315,7 +322,7 @@ static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
         return true;
     }
 
-    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za, a->off, a->v);
+    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za, a->off, 1, a->v);
     t_pg = pred_full_reg_ptr(s, a->pg);
     addr = tcg_temp_new_i64();
 
@@ -337,18 +344,13 @@ typedef void GenLdStR(DisasContext *, TCGv_ptr, int, int, int, int);
 
 static bool do_ldst_r(DisasContext *s, arg_ldstr *a, GenLdStR *fn)
 {
-    int svl = streaming_vec_reg_size(s);
-    int imm = a->imm;
-    TCGv_ptr base;
+    if (sme_za_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int imm = a->imm;
+        TCGv_ptr base = get_zarray(s, a->rv, imm, 1);
 
-    if (!sme_za_enabled_check(s)) {
-        return true;
+        fn(s, base, 0, svl, a->rn, imm * svl);
     }
-
-    /* ZA[n] equates to ZA0H.B[n]. */
-    base = get_tile_rowcol(s, MO_8, a->rv, 0, imm, false);
-
-    fn(s, base, 0, svl, a->rn, imm * svl);
     return true;
 }
 
-- 
2.43.0


