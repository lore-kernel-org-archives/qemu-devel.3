Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4980C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEJ-0000HT-9S; Fri, 04 Jul 2025 12:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEG-0008UO-8x
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:36 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEC-0006Bu-O6
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:35 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso848033f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646331; x=1752251131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AX6lSFvuJZRlBDTjE81KModGHPcQQt3xlR79uNFSkaU=;
 b=l2tvPJG2zz5KlKelmBbZ5pRo4ltgk1PlK7zpT/G9bFo+vCAPTyqU5rBFb0ab4tgfga
 E51DqqNYLeFgfy3N0DRYSkRgJy6wzKK5NO9Ugmjkg2kLvMRmxmtLld3LNpV3SUCqjpQ5
 DWB97LtpZxidCOSFGfEA+2mWEHIg3Ei/qSgycJ+EdyBa1HW3WTETHGi+oaZ2uxLXdLpU
 +f2Q7U9G2vehwPRRD43DvjXRGxUuXWsXPsrvTHltBg2THdM3Cva5PHapXtsRngEGGm42
 RroG+f/v+9ZdW8pU+Sx23CY1pFpmHEXeLSZQ7VTGORihzXTPx4f8+QkFeMT86zumsQxL
 JIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646331; x=1752251131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AX6lSFvuJZRlBDTjE81KModGHPcQQt3xlR79uNFSkaU=;
 b=WFixxjMIsk58QVvVUKhJHaT9LwHzf3CuwTmgcmpPh6lJ3PKrt/moK781zDeOkDu9Gv
 9scpCSpzNftKT9ogjX1gqIxYKbBmP6YpEovHThMncq5NdznDcZlx8rypAW3Yo3n1T/qy
 Q9lVrVEDh+oRL2GCWNwybGV4pRck/TpIxcpK83sIvJDMaw+sLFapIw7FDQbN4KLYRFOd
 wqREmm6hoj/RGyURkOjay2gdxFJVSsf9rwQAcJe0i7j3xc9/ErgdVJL4qeSZsHG1mlxt
 RFDtC/GfQg2lgx1CJWfpamVNo8/xV5DmG9CBc7j3s1f/0o7i0AOnzPcBw6bOw7LHnpsz
 t38g==
X-Gm-Message-State: AOJu0YwTVIkFlno+nDBnhLcPmzueoedlk7jXn7vko4urhzvSxbxu49dd
 s9DP79armwlejDIGfA5M308Ts56NiuDjI+pyvWq5G5TJBHMKTsrjR+3dq5u1oPNczl5KRPvt2IC
 x5xW+
X-Gm-Gg: ASbGncvZKGy8CqI2ez2rjhj4yjaPigY2b9i5YcfpjMAWFYy9Xh9NtzrNO1uPRsCm/db
 r7KEXc2NlRwSqiDDZVcNJbQ2StvsaeCxh7hJi1E9Nkjr4/15eBLNSJjEgYiY9w2FK7aCY3EtHnd
 ef8Pg9lrKf70K5L1kcAwFsYruZEmjYojjLxvYLlsPkJ0YgpAHSyRvBYRN04tPgaPDR/Nd2fHW0z
 z8JWyB/O/hqQNQf2KPagTpUg9JMTgRnGuQzgIjtsfV0FgHZq0ZnxPURkmtLn9FEFhk5qIY/GF58
 OaspGrdbnGrk0c/P+Fb6Vm9AiXmt0nygpHefVv3iN9Jf1xJAZR+nYts+Rxw4ezmKOU08
X-Google-Smtp-Source: AGHT+IFxoZYnwmzxHCqdnEEMc3JVn58ooPnfbNenDPdCyapDuy5KlARW/HXWAyPY136uspN5Mc9NQw==
X-Received: by 2002:a05:6000:4908:b0:3a5:2ec5:35a9 with SMTP id
 ffacd0b85a97d-3b4964f4e01mr2984647f8f.3.1751646330925; 
 Fri, 04 Jul 2025 09:25:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 030/119] target/arm: Add alignment argument to gen_sve_{ldr,
 str}
Date: Fri,  4 Jul 2025 17:23:30 +0100
Message-ID: <20250704162501.249138-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Honor AlignmentEnforced() for LDR/STR (vector),
(predicate), and (array vector).

Within the expansion functions, clear @align when we're
done emitting loads at the largest size.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-19-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.h |  6 ++--
 target/arm/tcg/translate-sme.c |  5 ++--
 target/arm/tcg/translate-sve.c | 50 ++++++++++++++++++++++++----------
 3 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index b2420f59ebe..8a9f4b20539 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -225,7 +225,9 @@ void gen_gvec_usqadd_qc(unsigned vece, uint32_t rd_ofs,
                         uint32_t rn_ofs, uint32_t rm_ofs,
                         uint32_t opr_sz, uint32_t max_sz);
 
-void gen_sve_ldr(DisasContext *s, TCGv_ptr, int vofs, int len, int rn, int imm);
-void gen_sve_str(DisasContext *s, TCGv_ptr, int vofs, int len, int rn, int imm);
+void gen_sve_ldr(DisasContext *s, TCGv_ptr, int vofs,
+                 int len, int rn, int imm, MemOp align);
+void gen_sve_str(DisasContext *s, TCGv_ptr, int vofs,
+                 int len, int rn, int imm, MemOp align);
 
 #endif /* TARGET_ARM_TRANSLATE_A64_H */
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 246f191eca2..1dbd0199af0 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -269,7 +269,7 @@ static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
     return true;
 }
 
-typedef void GenLdStR(DisasContext *, TCGv_ptr, int, int, int, int);
+typedef void GenLdStR(DisasContext *, TCGv_ptr, int, int, int, int, MemOp);
 
 static bool do_ldst_r(DisasContext *s, arg_ldstr *a, GenLdStR *fn)
 {
@@ -284,7 +284,8 @@ static bool do_ldst_r(DisasContext *s, arg_ldstr *a, GenLdStR *fn)
     /* ZA[n] equates to ZA0H.B[n]. */
     base = get_tile_rowcol(s, MO_8, a->rv, imm, false);
 
-    fn(s, base, 0, svl, a->rn, imm * svl);
+    fn(s, base, 0, svl, a->rn, imm * svl,
+       s->align_mem ? MO_ALIGN_16 : MO_UNALN);
     return true;
 }
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 8403034a0e2..d2cd298b5b2 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4160,7 +4160,7 @@ TRANS_FEAT(UCVTF_dd, aa64_sve, gen_gvec_fpst_arg_zpz,
  */
 
 void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
-                 int len, int rn, int imm)
+                 int len, int rn, int imm, MemOp align)
 {
     int len_align = QEMU_ALIGN_DOWN(len, 16);
     int len_remain = len % 16;
@@ -4189,12 +4189,15 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
 
         for (i = 0; i < len_align; i += 16) {
             tcg_gen_qemu_ld_i128(t16, clean_addr, midx,
-                                 MO_LE | MO_128 | MO_ATOM_NONE);
+                                 MO_LE | MO_128 | MO_ATOM_NONE | align);
             tcg_gen_extr_i128_i64(t0, t1, t16);
             tcg_gen_st_i64(t0, base, vofs + i);
             tcg_gen_st_i64(t1, base, vofs + i + 8);
             tcg_gen_addi_i64(clean_addr, clean_addr, 16);
         }
+        if (len_align) {
+            align = MO_UNALN;
+        }
     } else {
         TCGLabel *loop = gen_new_label();
         TCGv_ptr tp, i = tcg_temp_new_ptr();
@@ -4204,7 +4207,7 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
 
         t16 = tcg_temp_new_i128();
         tcg_gen_qemu_ld_i128(t16, clean_addr, midx,
-                             MO_LE | MO_128 | MO_ATOM_NONE);
+                             MO_LE | MO_128 | MO_ATOM_NONE | align);
         tcg_gen_addi_i64(clean_addr, clean_addr, 16);
 
         tp = tcg_temp_new_ptr();
@@ -4219,6 +4222,7 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
         tcg_gen_st_i64(t1, tp, vofs + 8);
 
         tcg_gen_brcondi_ptr(TCG_COND_LTU, i, len_align, loop);
+        align = MO_UNALN;
     }
 
     /*
@@ -4227,7 +4231,9 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
      */
     if (len_remain >= 8) {
         t0 = tcg_temp_new_i64();
-        tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEUQ | MO_ATOM_NONE);
+        tcg_gen_qemu_ld_i64(t0, clean_addr, midx,
+                            MO_LEUQ | MO_ATOM_NONE | align);
+        align = MO_UNALN;
         tcg_gen_st_i64(t0, base, vofs + len_align);
         len_remain -= 8;
         len_align += 8;
@@ -4242,12 +4248,14 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
         case 4:
         case 8:
             tcg_gen_qemu_ld_i64(t0, clean_addr, midx,
-                                MO_LE | ctz32(len_remain) | MO_ATOM_NONE);
+                                MO_LE | ctz32(len_remain)
+                                | MO_ATOM_NONE | align);
             break;
 
         case 6:
             t1 = tcg_temp_new_i64();
-            tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEUL | MO_ATOM_NONE);
+            tcg_gen_qemu_ld_i64(t0, clean_addr, midx,
+                                MO_LEUL | MO_ATOM_NONE | align);
             tcg_gen_addi_i64(clean_addr, clean_addr, 4);
             tcg_gen_qemu_ld_i64(t1, clean_addr, midx, MO_LEUW | MO_ATOM_NONE);
             tcg_gen_deposit_i64(t0, t0, t1, 32, 32);
@@ -4262,7 +4270,7 @@ void gen_sve_ldr(DisasContext *s, TCGv_ptr base, int vofs,
 
 /* Similarly for stores.  */
 void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
-                 int len, int rn, int imm)
+                 int len, int rn, int imm, MemOp align)
 {
     int len_align = QEMU_ALIGN_DOWN(len, 16);
     int len_remain = len % 16;
@@ -4294,9 +4302,12 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
             tcg_gen_ld_i64(t1, base, vofs + i + 8);
             tcg_gen_concat_i64_i128(t16, t0, t1);
             tcg_gen_qemu_st_i128(t16, clean_addr, midx,
-                                 MO_LE | MO_128 | MO_ATOM_NONE);
+                                 MO_LE | MO_128 | MO_ATOM_NONE | align);
             tcg_gen_addi_i64(clean_addr, clean_addr, 16);
         }
+        if (len_align) {
+            align = MO_UNALN;
+        }
     } else {
         TCGLabel *loop = gen_new_label();
         TCGv_ptr tp, i = tcg_temp_new_ptr();
@@ -4320,13 +4331,16 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
         tcg_gen_addi_i64(clean_addr, clean_addr, 16);
 
         tcg_gen_brcondi_ptr(TCG_COND_LTU, i, len_align, loop);
+        align = MO_UNALN;
     }
 
     /* Predicate register stores can be any multiple of 2.  */
     if (len_remain >= 8) {
         t0 = tcg_temp_new_i64();
         tcg_gen_ld_i64(t0, base, vofs + len_align);
-        tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUQ | MO_ATOM_NONE);
+        tcg_gen_qemu_st_i64(t0, clean_addr, midx,
+                            MO_LEUQ | MO_ATOM_NONE | align);
+        align = MO_UNALN;
         len_remain -= 8;
         len_align += 8;
         if (len_remain) {
@@ -4342,11 +4356,13 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
         case 4:
         case 8:
             tcg_gen_qemu_st_i64(t0, clean_addr, midx,
-                                MO_LE | ctz32(len_remain) | MO_ATOM_NONE);
+                                MO_LE | ctz32(len_remain)
+                                | MO_ATOM_NONE | align);
             break;
 
         case 6:
-            tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUL | MO_ATOM_NONE);
+            tcg_gen_qemu_st_i64(t0, clean_addr, midx,
+                                MO_LEUL | MO_ATOM_NONE | align);
             tcg_gen_addi_i64(clean_addr, clean_addr, 4);
             tcg_gen_shri_i64(t0, t0, 32);
             tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUW | MO_ATOM_NONE);
@@ -4366,7 +4382,8 @@ static bool trans_LDR_zri(DisasContext *s, arg_rri *a)
     if (sve_access_check(s)) {
         int size = vec_full_reg_size(s);
         int off = vec_full_reg_offset(s, a->rd);
-        gen_sve_ldr(s, tcg_env, off, size, a->rn, a->imm * size);
+        gen_sve_ldr(s, tcg_env, off, size, a->rn, a->imm * size,
+                    s->align_mem ? MO_ALIGN_16 : MO_UNALN);
     }
     return true;
 }
@@ -4379,7 +4396,8 @@ static bool trans_LDR_pri(DisasContext *s, arg_rri *a)
     if (sve_access_check(s)) {
         int size = pred_full_reg_size(s);
         int off = pred_full_reg_offset(s, a->rd);
-        gen_sve_ldr(s, tcg_env, off, size, a->rn, a->imm * size);
+        gen_sve_ldr(s, tcg_env, off, size, a->rn, a->imm * size,
+                    s->align_mem ? MO_ALIGN_2 : MO_UNALN);
     }
     return true;
 }
@@ -4392,7 +4410,8 @@ static bool trans_STR_zri(DisasContext *s, arg_rri *a)
     if (sve_access_check(s)) {
         int size = vec_full_reg_size(s);
         int off = vec_full_reg_offset(s, a->rd);
-        gen_sve_str(s, tcg_env, off, size, a->rn, a->imm * size);
+        gen_sve_str(s, tcg_env, off, size, a->rn, a->imm * size,
+                    s->align_mem ? MO_ALIGN_16 : MO_UNALN);
     }
     return true;
 }
@@ -4405,7 +4424,8 @@ static bool trans_STR_pri(DisasContext *s, arg_rri *a)
     if (sve_access_check(s)) {
         int size = pred_full_reg_size(s);
         int off = pred_full_reg_offset(s, a->rd);
-        gen_sve_str(s, tcg_env, off, size, a->rn, a->imm * size);
+        gen_sve_str(s, tcg_env, off, size, a->rn, a->imm * size,
+                    s->align_mem ? MO_ALIGN_2 : MO_UNALN);
     }
     return true;
 }
-- 
2.43.0


