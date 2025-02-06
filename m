Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC086C0219C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80q-0007zx-Jb; Thu, 06 Feb 2025 14:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80G-0007FD-95
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:36 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80D-0000Xf-OU
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:35 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21f50895565so203585ad.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871852; x=1739476652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RfCREBeWqP3xZCwzPTg3qYrCq3aLvYTQX4nKzsiQLes=;
 b=GwX72b2yimJNteFNGWpYilyekeb45zyTUFoaLQ/A18ujr9EvHqU7VdiUmApIPoN0wh
 29IgXwmqX/p3Vjo6h8B5aDCgoOJp20ag7EI8gJha+LJJ3tmq0gZEitrj0GZguCiWLwvF
 rwUYEdaG4AmfpnML6mMmHOz2xcFVYDlNFuM+JXcW9yScCcl7KLPWC4Kf4pur2gDKjMmx
 oyS1FuloVH9qXjH6OzdQVHPAf++vj54IGLMHjSjhoWtKs+zI8a7yHWeSjxHFwDhx3MdP
 6eAPhwP6m+2TH1P+QPor96hJqu3KoAVk4tOyoDyeLy0zQB3EgP9ZUSccGN+hLvH1xNLv
 TFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871852; x=1739476652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RfCREBeWqP3xZCwzPTg3qYrCq3aLvYTQX4nKzsiQLes=;
 b=HYpNuQSMoSr2+DtMQZKqtlsCNhgjkIZ9dmwxUxx3R5gEC3UZRcs767DCh0+IFQYNue
 ImZP+mQtgUEnR1fKRo6wZDvSjZf7HVmVIOUSGx8OcgzpMF0dncnaEn0e7ppOP2uCgr6H
 qZfqTkGyF4n88GHbrk3DrkEQL2N8q8dxM9/OTw0OhAlRjFo7HoD07U4urGzwHMKxTfb8
 kmUmCjmg0aSPERWZv5T3HkMPEZyOIAd1cbCyXC8LGiqXs8/GVkGj+6XeMswLvO03O+j+
 fXcMUfIyQ5JSSwwGJZbYXboTBexDpIaohn1ZVCAP0NCr3+hp/R1SPv7ygLTnaEm5S9x9
 kdoA==
X-Gm-Message-State: AOJu0YxVCJMjAoxOHRDL9XVGuzsTAxgxjn4CCX1grsxsAa8UYncLpVT6
 tWnNl7vx9mtfwHaqIkPv+MZ3UWuctPUwo55fG2lkdK+y/b47wASQTgfm/Q8IlyWj48/ghFsikAv
 K
X-Gm-Gg: ASbGncu/7oazX89qBsVa495evFV0I0pENqhVLR+aaSZGk/yz6XP8MHqxGmwZKxY+SVf
 ocTVWryK+NsRQ0faFD1+zvSb4dJy6y0v8GRziGT/HdotHGit4pC6ygMGwdq6eWH4cNgdjzxEtzw
 03VWqErmpNMihxFyGsoYHJSeL5UwSzkq93JdXi7g3UlZ9qUS1wlxIJHz9Y7R5bu+eQ6WigOqgaS
 Fbb3cgwSv535yUZD9L/y6ux2fifYgBVfAzoMkhIgC6WNFHjhYzdQ3NKHyXzQJm05jfj7DQqvl35
 itrwQSwa8kP8zjHNrKjsJwj2fXz7ehFhpyFdqkyJbQdjHio=
X-Google-Smtp-Source: AGHT+IExUn2PqlyVybj4hkYNrc8bu7m8w5OYMWbrLLp3RoRudia8qFKXTdBsDp3T1kPfzzLqoTl6Vw==
X-Received: by 2002:a05:6a00:3c88:b0:730:4598:ddb5 with SMTP id
 d2e1a72fcca58-7305d41760fmr827810b3a.2.1738871852018; 
 Thu, 06 Feb 2025 11:57:32 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 21/61] target/arm: Split out get_zarray
Date: Thu,  6 Feb 2025 11:56:35 -0800
Message-ID: <20250206195715.2150758-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


