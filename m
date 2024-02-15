Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9C8C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafer-0000OZ-33; Thu, 15 Feb 2024 12:36:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeH-0007wn-Gi
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:49 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeC-0003uZ-G2
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:49 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33ce55ab993so632595f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018542; x=1708623342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R5btJS3y3hUR8gjDhf2ty8AwSTtFlSAZAgw0FD5O3yo=;
 b=v81wawKSWPSx2yYlEDrGwDxMYp9XisLPmN9FHPwOQUXIpvJdCrDCdGSH4qNlUIuhLn
 0GqYceh1sZ3+u0BBKByazZqbIDMq/VcTzOVFqGEjK6cPt1Fth3EKJDU9xoFYs9vxb01T
 At25RlSwMIe6027GtxxFk+5eao9xcJjyg3be9GF5GFSUH1zD/1p1jdoTSnKfeRE6gJJ/
 c0qtXtHX/aGvDgQNf7+OflnrFmVqrmQsjl6WPw2N104rXa/jlRaOCtPXI0HyC7/uPZ1g
 P7ucsif9HPtU831RW3/y6nUX6/sw8uTSUV5W/MHc5G1S5ol6FCR3bHChkue2ohesh3Ss
 77KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018542; x=1708623342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R5btJS3y3hUR8gjDhf2ty8AwSTtFlSAZAgw0FD5O3yo=;
 b=OHLq0vmdHe1wVBurTQERIpDGoxabRYIXnQMGlaLgIL2FVYSkFjqPzYARYd6SWSupAy
 0sXd4i5XGeBwaVGQXB+hhDgKYMM5d2KawG1L7eDaJdCXwp9ZD2pi0jhgigOuveVSSIaA
 s9791B1fa31ksMTjm1NpFUWljZqqQvIIYz+2+L79bRDx4pEBQrkWlnVHJ0l1X4slU7yR
 9+s5eI/67kDQkSpARU6ZXvvQP7y1aKDUtZAXN9coElpz8NpmdctT15xGVgiFiSgtUqHl
 wHFfVq1lKyIFS4Orrwtao9wyoYZza0j4sg4WA0tM0Pjivziz50wXe3zakgsijuP/Asnb
 6NBA==
X-Gm-Message-State: AOJu0YyhzfKPSA2kOw4wEHRpuk9CYiWnOsZ3ETMpqeHu9F7bIITENQZ0
 hkCMLVEMZdiShlkjK7VYefdRasvdjelAwkCMZThhc0tczvXuPLNEWeDX6cc2ja3E6Ipp25uhOWZ
 J
X-Google-Smtp-Source: AGHT+IEUcGgmB7OzyaWSHkaYCnKhM9p+KXwf29dAJvP9ys6UA5UxpaDTinTEAFFKYlKQFF8gYLXaKg==
X-Received: by 2002:a5d:644b:0:b0:33b:87c1:c4d with SMTP id
 d11-20020a5d644b000000b0033b87c10c4dmr1702299wrw.0.1708018541906; 
 Thu, 15 Feb 2024 09:35:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/35] target/arm: Split out make_svemte_desc
Date: Thu, 15 Feb 2024 17:35:08 +0000
Message-Id: <20240215173538.2430599-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Share code that creates mtedesc and embeds within simd_desc.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20240207025210.8837-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.h |  2 ++
 target/arm/tcg/translate-sme.c | 15 +++--------
 target/arm/tcg/translate-sve.c | 47 ++++++++++++++++++----------------
 3 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index 96ba39b37e9..7b811b8ac51 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -28,6 +28,8 @@ bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
 bool sve_access_check(DisasContext *s);
 bool sme_enabled_check(DisasContext *s);
 bool sme_enabled_check_with_svcr(DisasContext *s, unsigned);
+uint32_t make_svemte_desc(DisasContext *s, unsigned vsz, uint32_t nregs,
+                          uint32_t msz, bool is_write, uint32_t data);
 
 /* This function corresponds to CheckStreamingSVEEnabled. */
 static inline bool sme_sm_enabled_check(DisasContext *s)
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 8f0dfc884ec..46c7fce8b4e 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -206,7 +206,7 @@ static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
 
     TCGv_ptr t_za, t_pg;
     TCGv_i64 addr;
-    int svl, desc = 0;
+    uint32_t desc;
     bool be = s->be_data == MO_BE;
     bool mte = s->mte_active[0];
 
@@ -224,18 +224,11 @@ static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
     tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), a->esz);
     tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
 
-    if (mte) {
-        desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
-        desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
-        desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
-        desc = FIELD_DP32(desc, MTEDESC, WRITE, a->st);
-        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, (1 << a->esz) - 1);
-        desc <<= SVE_MTEDESC_SHIFT;
-    } else {
+    if (!mte) {
         addr = clean_data_tbi(s, addr);
     }
-    svl = streaming_vec_reg_size(s);
-    desc = simd_desc(svl, svl, desc);
+
+    desc = make_svemte_desc(s, streaming_vec_reg_size(s), 1, a->esz, a->st, 0);
 
     fns[a->esz][be][a->v][mte][a->st](tcg_env, t_za, t_pg, addr,
                                       tcg_constant_i32(desc));
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index a88e523cbab..508f7b6bbdc 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4437,18 +4437,18 @@ static const uint8_t dtype_esz[16] = {
     3, 2, 1, 3
 };
 
-static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
-                       int dtype, uint32_t mte_n, bool is_write,
-                       gen_helper_gvec_mem *fn)
+uint32_t make_svemte_desc(DisasContext *s, unsigned vsz, uint32_t nregs,
+                          uint32_t msz, bool is_write, uint32_t data)
 {
-    unsigned vsz = vec_full_reg_size(s);
-    TCGv_ptr t_pg;
     uint32_t sizem1;
-    int desc = 0;
+    uint32_t desc = 0;
 
-    assert(mte_n >= 1 && mte_n <= 4);
-    sizem1 = (mte_n << dtype_msz(dtype)) - 1;
+    /* Assert all of the data fits, with or without MTE enabled. */
+    assert(nregs >= 1 && nregs <= 4);
+    sizem1 = (nregs << msz) - 1;
     assert(sizem1 <= R_MTEDESC_SIZEM1_MASK >> R_MTEDESC_SIZEM1_SHIFT);
+    assert(data < 1u << SVE_MTEDESC_SHIFT);
+
     if (s->mte_active[0]) {
         desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
         desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
@@ -4456,7 +4456,18 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
         desc = FIELD_DP32(desc, MTEDESC, SIZEM1, sizem1);
         desc <<= SVE_MTEDESC_SHIFT;
-    } else {
+    }
+    return simd_desc(vsz, vsz, desc | data);
+}
+
+static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
+                       int dtype, uint32_t nregs, bool is_write,
+                       gen_helper_gvec_mem *fn)
+{
+    TCGv_ptr t_pg;
+    uint32_t desc;
+
+    if (!s->mte_active[0]) {
         addr = clean_data_tbi(s, addr);
     }
 
@@ -4465,7 +4476,8 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
      * registers as pointers, so encode the regno into the data field.
      * For consistency, do this even for LD1.
      */
-    desc = simd_desc(vsz, vsz, zt | desc);
+    desc = make_svemte_desc(s, vec_full_reg_size(s), nregs,
+                            dtype_msz(dtype), is_write, zt);
     t_pg = tcg_temp_new_ptr();
 
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, pg));
@@ -5224,25 +5236,16 @@ static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
                        int scale, TCGv_i64 scalar, int msz, bool is_write,
                        gen_helper_gvec_mem_scatter *fn)
 {
-    unsigned vsz = vec_full_reg_size(s);
     TCGv_ptr t_zm = tcg_temp_new_ptr();
     TCGv_ptr t_pg = tcg_temp_new_ptr();
     TCGv_ptr t_zt = tcg_temp_new_ptr();
-    int desc = 0;
-
-    if (s->mte_active[0]) {
-        desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
-        desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
-        desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
-        desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
-        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, (1 << msz) - 1);
-        desc <<= SVE_MTEDESC_SHIFT;
-    }
-    desc = simd_desc(vsz, vsz, desc | scale);
+    uint32_t desc;
 
     tcg_gen_addi_ptr(t_pg, tcg_env, pred_full_reg_offset(s, pg));
     tcg_gen_addi_ptr(t_zm, tcg_env, vec_full_reg_offset(s, zm));
     tcg_gen_addi_ptr(t_zt, tcg_env, vec_full_reg_offset(s, zt));
+
+    desc = make_svemte_desc(s, vec_full_reg_size(s), 1, msz, is_write, scale);
     fn(tcg_env, t_zt, t_pg, t_zm, scalar, tcg_constant_i32(desc));
 }
 
-- 
2.34.1


