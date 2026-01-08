Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6846D1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdibx-0005pw-7k; Thu, 08 Jan 2026 00:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibv-0005dA-6d
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:03 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibs-0005Oy-3M
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:02 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7b8bbf16b71so1918560b3a.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850258; x=1768455058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g71XoEgTnRrKlmLnqVlg/PQBSmJy8VValiVqdAtVf3U=;
 b=XbltOnW9dvey1E09s6TgCfMDAt1UtCUI24GhHIaKS9ZH1OGUYoFjOeWblaV4ifJxnS
 SLDm/r/dBlAUZnZYA1+ONq5t0AZSpFZxjYoi8VOwBmEAFEV9YMn2QH+6mfaJJ0KXontW
 Y+AP24fHO2wM51Z2aK3O4MikmygJgMWhntfDxDHqIJWC5qlGaEq+sjtiHEO9IYNGGRNL
 f4K06Wcx/ipf2smNa6y5Bd4K4S8QsvOxBMz0HuCjkB7PWeEJTNmdXWPLGHMZAiABsVae
 +HWT3GSjmBCB1B4q6uCJZZMLFcEspAGt3OCoLX/A5RsIppQzKp0p05mjKuzVJ8irthF3
 GcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850258; x=1768455058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g71XoEgTnRrKlmLnqVlg/PQBSmJy8VValiVqdAtVf3U=;
 b=gAuyeSpRc6sOl5X+2dBKqP47vzhtIAIN9t5uRKzET0FAlpBZpz/+uJ5UOdxHhfuaaP
 tZcxNEdwiHWn8V6r8qdUTHQrS1sYbAQUGfM4W6hihyKiFTtgDRE0G4QFwsLmr6EW2Tby
 nadXOi3KZwEsBcY/AYmjGk/SC9MTRDuJUJqm88DquGd0oXaVrw7Cy2Q9BxcyPX7xz8j4
 RWy0twvuOYGCjXHH0YysfHaqkh1Nl2RmsCko1lZRbRDpX+zpm/OPvTEp5voepvPpOPkS
 xsUvuBP1ADDAAzydmg8wBt9b89/G3qCfPYmY5/W2qgnlDM1VetL7sx4qqBGwnkdZKWMp
 vLRg==
X-Gm-Message-State: AOJu0YyCtgGzyP+qGMrSEY3lv3EpKIhxW38AGTMIpVrd9MPp+oNfZjJw
 1sN4qNKtV6Civ6uqM1UzvbKKVU6Ic51BVZUXcYGR8NsKhqPLJsteSbk4eTQJ7ZmwYOOAE590TTM
 B8zaZXas=
X-Gm-Gg: AY/fxX6bCBF9GfWjjGOwzzT2phvkoZFgdBrf2qMLUqVjX5NgErToZMAn8v0UrBlGIl2
 GNV2dnQEVGs+VsJbbesmSS/iXzeG22D6LxJDgMmEErNr2D+LhajDpc0pV9NaR4N+PTdVP7HQmuF
 Hqb/qopaagpAgZH1ZjwFvUQvA/wYTgbf+wIyn6C5/4A/Hz+7Vpc6ArKWQo8j+MF23riIicSW79F
 ko0PU3Udjs01zOE1Hb4eqGme/4RJO3eyrIXvCdYtOIW2bq98tn9GAwWBbbqwD8NkXTNM90RL2+d
 nYhxdq7MDzmWztUewzOynTak8eSvpa+FuW/wLdkkKgFcAJGVCe384oGh3Ecf2LIlttPFh/W40S5
 zR+SUizcmMZ1eR96uD+haFW1niZYkorIUyrKRDaf91uKT6FWs+UuPte7FKuecOgJQ//MPnrTqLL
 OMCWzGWEs5qyG6m/X93w==
X-Google-Smtp-Source: AGHT+IFB+iY4W4o9ExtR6gKYTsubFhKRiEkXCUR1pyArMpucL0yptT+f5YBOciBP8HuaysVieWzODw==
X-Received: by 2002:a05:6a21:3299:b0:366:18a7:88bd with SMTP id
 adf61e73a8af0-3898f92c9ccmr4187895637.2.1767850258357; 
 Wed, 07 Jan 2026 21:30:58 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.30.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:30:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/50] *: Drop TCG_TARGET_REG_BITS test for prefer_i64
Date: Thu,  8 Jan 2026 16:29:46 +1100
Message-ID: <20260108053018.626690-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Mechanically via sed -i.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/gengvec.c                | 32 ++++++-------
 target/arm/tcg/gengvec64.c              |  4 +-
 target/arm/tcg/translate-sve.c          | 26 +++++------
 tcg/tcg-op-gvec.c                       | 62 ++++++++++++-------------
 target/i386/tcg/emit.c.inc              |  2 +-
 target/riscv/insn_trans/trans_rvv.c.inc |  2 +-
 6 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 01867f8ace..f97d63549c 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -165,7 +165,7 @@ void gen_gvec_ssra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
         { .fni8 = gen_ssra64_i64,
           .fniv = gen_ssra_vec,
           .fno = gen_helper_gvec_ssra_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .opt_opc = vecop_list,
           .load_dest = true,
           .vece = MO_64 },
@@ -241,7 +241,7 @@ void gen_gvec_usra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
         { .fni8 = gen_usra64_i64,
           .fniv = gen_usra_vec,
           .fno = gen_helper_gvec_usra_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .load_dest = true,
           .opt_opc = vecop_list,
           .vece = MO_64, },
@@ -349,7 +349,7 @@ void gen_gvec_srshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
         { .fni8 = gen_srshr64_i64,
           .fniv = gen_srshr_vec,
           .fno = gen_helper_gvec_srshr_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .opt_opc = vecop_list,
           .vece = MO_64 },
     };
@@ -439,7 +439,7 @@ void gen_gvec_srsra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
         { .fni8 = gen_srsra64_i64,
           .fniv = gen_srsra_vec,
           .fno = gen_helper_gvec_srsra_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .opt_opc = vecop_list,
           .load_dest = true,
           .vece = MO_64 },
@@ -543,7 +543,7 @@ void gen_gvec_urshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
         { .fni8 = gen_urshr64_i64,
           .fniv = gen_urshr_vec,
           .fno = gen_helper_gvec_urshr_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .opt_opc = vecop_list,
           .vece = MO_64 },
     };
@@ -652,7 +652,7 @@ void gen_gvec_ursra(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
         { .fni8 = gen_ursra64_i64,
           .fniv = gen_ursra_vec,
           .fno = gen_helper_gvec_ursra_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .opt_opc = vecop_list,
           .load_dest = true,
           .vece = MO_64 },
@@ -736,7 +736,7 @@ void gen_gvec_sri(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
         { .fni8 = gen_shr64_ins_i64,
           .fniv = gen_shr_ins_vec,
           .fno = gen_helper_gvec_sri_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .load_dest = true,
           .opt_opc = vecop_list,
           .vece = MO_64 },
@@ -823,7 +823,7 @@ void gen_gvec_sli(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
         { .fni8 = gen_shl64_ins_i64,
           .fniv = gen_shl_ins_vec,
           .fno = gen_helper_gvec_sli_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .load_dest = true,
           .opt_opc = vecop_list,
           .vece = MO_64 },
@@ -927,7 +927,7 @@ void gen_gvec_mla(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
           .vece = MO_32 },
         { .fni8 = gen_mla64_i64,
           .fniv = gen_mla_vec,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .load_dest = true,
           .opt_opc = vecop_list,
           .vece = MO_64 },
@@ -959,7 +959,7 @@ void gen_gvec_mls(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
           .vece = MO_32 },
         { .fni8 = gen_mls64_i64,
           .fniv = gen_mls_vec,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .load_dest = true,
           .opt_opc = vecop_list,
           .vece = MO_64 },
@@ -1002,7 +1002,7 @@ void gen_gvec_cmtst(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
           .vece = MO_32 },
         { .fni8 = gen_cmtst_i64,
           .fniv = gen_cmtst_vec,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .opt_opc = vecop_list,
           .vece = MO_64 },
     };
@@ -1691,7 +1691,7 @@ void gen_gvec_sabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
         { .fni8 = gen_sabd_i64,
           .fniv = gen_sabd_vec,
           .fno = gen_helper_gvec_sabd_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .opt_opc = vecop_list,
           .vece = MO_64 },
     };
@@ -1748,7 +1748,7 @@ void gen_gvec_uabd(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
         { .fni8 = gen_uabd_i64,
           .fniv = gen_uabd_vec,
           .fno = gen_helper_gvec_uabd_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .opt_opc = vecop_list,
           .vece = MO_64 },
     };
@@ -1803,7 +1803,7 @@ void gen_gvec_saba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
         { .fni8 = gen_saba_i64,
           .fniv = gen_saba_vec,
           .fno = gen_helper_gvec_saba_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .opt_opc = vecop_list,
           .load_dest = true,
           .vece = MO_64 },
@@ -1859,7 +1859,7 @@ void gen_gvec_uaba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
         { .fni8 = gen_uaba_i64,
           .fniv = gen_uaba_vec,
           .fno = gen_helper_gvec_uaba_d,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .opt_opc = vecop_list,
           .load_dest = true,
           .vece = MO_64 },
@@ -2429,7 +2429,7 @@ void gen_gvec_rev32(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     static const GVecGen2 g = {
         .fni8 = gen_bswap32_i64,
         .fni4 = tcg_gen_bswap32_i32,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
         .vece = MO_32
     };
 
diff --git a/target/arm/tcg/gengvec64.c b/target/arm/tcg/gengvec64.c
index 2429cab1b8..c425d2b149 100644
--- a/target/arm/tcg/gengvec64.c
+++ b/target/arm/tcg/gengvec64.c
@@ -157,7 +157,7 @@ void gen_gvec_eor3(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
         .fniv = gen_eor3_vec,
         .fno = gen_helper_sve2_eor3,
         .vece = MO_64,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
     tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
 }
@@ -183,7 +183,7 @@ void gen_gvec_bcax(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
         .fniv = gen_bcax_vec,
         .fno = gen_helper_sve2_bcax,
         .vece = MO_64,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
     tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
 }
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 07b827fa8e..64adb5c1ce 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -623,7 +623,7 @@ static void gen_bsl1n(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
         .fniv = gen_bsl1n_vec,
         .fno = gen_helper_sve2_bsl1n,
         .vece = MO_64,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
     tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
 }
@@ -661,7 +661,7 @@ static void gen_bsl2n(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
         .fniv = gen_bsl2n_vec,
         .fno = gen_helper_sve2_bsl2n,
         .vece = MO_64,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
     tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
 }
@@ -690,7 +690,7 @@ static void gen_nbsl(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
         .fniv = gen_nbsl_vec,
         .fno = gen_helper_sve2_nbsl,
         .vece = MO_64,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
     tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &op);
 }
@@ -1367,7 +1367,7 @@ static bool trans_AND_pppp(DisasContext *s, arg_rprr_s *a)
         .fni8 = gen_and_pg_i64,
         .fniv = gen_and_pg_vec,
         .fno = gen_helper_sve_and_pppp,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
 
     if (!dc_isar_feature(aa64_sve, s)) {
@@ -1405,7 +1405,7 @@ static bool trans_BIC_pppp(DisasContext *s, arg_rprr_s *a)
         .fni8 = gen_bic_pg_i64,
         .fniv = gen_bic_pg_vec,
         .fno = gen_helper_sve_bic_pppp,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
 
     if (!dc_isar_feature(aa64_sve, s)) {
@@ -1436,7 +1436,7 @@ static bool trans_EOR_pppp(DisasContext *s, arg_rprr_s *a)
         .fni8 = gen_eor_pg_i64,
         .fniv = gen_eor_pg_vec,
         .fno = gen_helper_sve_eor_pppp,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
 
     if (!dc_isar_feature(aa64_sve, s)) {
@@ -1483,7 +1483,7 @@ static bool trans_ORR_pppp(DisasContext *s, arg_rprr_s *a)
         .fni8 = gen_orr_pg_i64,
         .fniv = gen_orr_pg_vec,
         .fno = gen_helper_sve_orr_pppp,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
 
     if (!dc_isar_feature(aa64_sve, s)) {
@@ -1514,7 +1514,7 @@ static bool trans_ORN_pppp(DisasContext *s, arg_rprr_s *a)
         .fni8 = gen_orn_pg_i64,
         .fniv = gen_orn_pg_vec,
         .fno = gen_helper_sve_orn_pppp,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
 
     if (!dc_isar_feature(aa64_sve, s)) {
@@ -1542,7 +1542,7 @@ static bool trans_NOR_pppp(DisasContext *s, arg_rprr_s *a)
         .fni8 = gen_nor_pg_i64,
         .fniv = gen_nor_pg_vec,
         .fno = gen_helper_sve_nor_pppp,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
 
     if (!dc_isar_feature(aa64_sve, s)) {
@@ -1570,7 +1570,7 @@ static bool trans_NAND_pppp(DisasContext *s, arg_rprr_s *a)
         .fni8 = gen_nand_pg_i64,
         .fniv = gen_nand_pg_vec,
         .fno = gen_helper_sve_nand_pppp,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
 
     if (!dc_isar_feature(aa64_sve, s)) {
@@ -3680,7 +3680,7 @@ static bool trans_SUBR_zzi(DisasContext *s, arg_rri_esz *a)
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_sve_subri_d,
           .opt_opc = vecop_list,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .vece = MO_64,
           .scalar_first = true }
     };
@@ -8024,7 +8024,7 @@ static void gen_sclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
           .fno  = gen_helper_gvec_sclamp_d,
           .opt_opc = vecop,
           .vece = MO_64,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64 }
+          .prefer_i64 = true }
     };
     tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &ops[vece]);
 }
@@ -8075,7 +8075,7 @@ static void gen_uclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
           .fno  = gen_helper_gvec_uclamp_d,
           .opt_opc = vecop,
           .vece = MO_64,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64 }
+          .prefer_i64 = true }
     };
     tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &ops[vece]);
 }
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 9c33430638..2cfc7e9409 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1754,7 +1754,7 @@ void tcg_gen_gvec_mov_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
         .fni8 = tcg_gen_mov_i64,
         .fniv = vec_mov2,
         .fno = gen_helper_gvec_mov,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
 
     if (dofs == aofs && dbase == abase) {
@@ -1917,7 +1917,7 @@ void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_not_i64,
         .fniv = tcg_gen_not_vec,
         .fno = gen_helper_gvec_not,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
     tcg_gen_gvec_2(dofs, aofs, oprsz, maxsz, &g);
 }
@@ -2030,7 +2030,7 @@ void tcg_gen_gvec_add_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
           .fniv = tcg_gen_add_vec,
           .fno = gen_helper_gvec_add64,
           .opt_opc = vecop_list_add,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .vece = MO_64 },
     };
 
@@ -2069,7 +2069,7 @@ void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs, uint32_t aofs,
           .fniv = tcg_gen_add_vec,
           .fno = gen_helper_gvec_adds64,
           .opt_opc = vecop_list_add,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .vece = MO_64 },
     };
 
@@ -2109,7 +2109,7 @@ void tcg_gen_gvec_subs(unsigned vece, uint32_t dofs, uint32_t aofs,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_gvec_subs64,
           .opt_opc = vecop_list_sub,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .vece = MO_64 },
     };
 
@@ -2221,7 +2221,7 @@ void tcg_gen_gvec_sub_var(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
           .fniv = tcg_gen_sub_vec,
           .fno = gen_helper_gvec_sub64,
           .opt_opc = vecop_list_sub,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .vece = MO_64 },
     };
 
@@ -2260,7 +2260,7 @@ void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,
           .fniv = tcg_gen_mul_vec,
           .fno = gen_helper_gvec_mul64,
           .opt_opc = vecop_list_mul,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .vece = MO_64 },
     };
 
@@ -2289,7 +2289,7 @@ void tcg_gen_gvec_muls(unsigned vece, uint32_t dofs, uint32_t aofs,
           .fniv = tcg_gen_mul_vec,
           .fno = gen_helper_gvec_muls64,
           .opt_opc = vecop_list_mul,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .vece = MO_64 },
     };
 
@@ -2618,7 +2618,7 @@ void tcg_gen_gvec_neg(unsigned vece, uint32_t dofs, uint32_t aofs,
           .fniv = tcg_gen_neg_vec,
           .fno = gen_helper_gvec_neg64,
           .opt_opc = vecop_list,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .vece = MO_64 },
     };
 
@@ -2682,7 +2682,7 @@ void tcg_gen_gvec_abs(unsigned vece, uint32_t dofs, uint32_t aofs,
           .fniv = tcg_gen_abs_vec,
           .fno = gen_helper_gvec_abs64,
           .opt_opc = vecop_list,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .vece = MO_64 },
     };
 
@@ -2697,7 +2697,7 @@ void tcg_gen_gvec_and(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_and_i64,
         .fniv = tcg_gen_and_vec,
         .fno = gen_helper_gvec_and,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
 
     if (aofs == bofs) {
@@ -2714,7 +2714,7 @@ void tcg_gen_gvec_or(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_or_i64,
         .fniv = tcg_gen_or_vec,
         .fno = gen_helper_gvec_or,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
 
     if (aofs == bofs) {
@@ -2731,7 +2731,7 @@ void tcg_gen_gvec_xor(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_xor_i64,
         .fniv = tcg_gen_xor_vec,
         .fno = gen_helper_gvec_xor,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
 
     if (aofs == bofs) {
@@ -2748,7 +2748,7 @@ void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_andc_i64,
         .fniv = tcg_gen_andc_vec,
         .fno = gen_helper_gvec_andc,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
 
     if (aofs == bofs) {
@@ -2765,7 +2765,7 @@ void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_orc_i64,
         .fniv = tcg_gen_orc_vec,
         .fno = gen_helper_gvec_orc,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
 
     if (aofs == bofs) {
@@ -2782,7 +2782,7 @@ void tcg_gen_gvec_nand(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_nand_i64,
         .fniv = tcg_gen_nand_vec,
         .fno = gen_helper_gvec_nand,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
 
     if (aofs == bofs) {
@@ -2799,7 +2799,7 @@ void tcg_gen_gvec_nor(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_nor_i64,
         .fniv = tcg_gen_nor_vec,
         .fno = gen_helper_gvec_nor,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
 
     if (aofs == bofs) {
@@ -2816,7 +2816,7 @@ void tcg_gen_gvec_eqv(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_eqv_i64,
         .fniv = tcg_gen_eqv_vec,
         .fno = gen_helper_gvec_eqv,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
     };
 
     if (aofs == bofs) {
@@ -2830,7 +2830,7 @@ static const GVecGen2s gop_ands = {
     .fni8 = tcg_gen_and_i64,
     .fniv = tcg_gen_and_vec,
     .fno = gen_helper_gvec_ands,
-    .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    .prefer_i64 = true,
     .vece = MO_64
 };
 
@@ -2857,7 +2857,7 @@ void tcg_gen_gvec_andcs(unsigned vece, uint32_t dofs, uint32_t aofs,
         .fni8 = tcg_gen_andc_i64,
         .fniv = tcg_gen_andc_vec,
         .fno = gen_helper_gvec_andcs,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+        .prefer_i64 = true,
         .vece = MO_64
     };
 
@@ -2871,7 +2871,7 @@ static const GVecGen2s gop_xors = {
     .fni8 = tcg_gen_xor_i64,
     .fniv = tcg_gen_xor_vec,
     .fno = gen_helper_gvec_xors,
-    .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    .prefer_i64 = true,
     .vece = MO_64
 };
 
@@ -2895,7 +2895,7 @@ static const GVecGen2s gop_ors = {
     .fni8 = tcg_gen_or_i64,
     .fniv = tcg_gen_or_vec,
     .fno = gen_helper_gvec_ors,
-    .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+    .prefer_i64 = true,
     .vece = MO_64
 };
 
@@ -2967,7 +2967,7 @@ void tcg_gen_gvec_shli(unsigned vece, uint32_t dofs, uint32_t aofs,
           .fniv = tcg_gen_shli_vec,
           .fno = gen_helper_gvec_shl64i,
           .opt_opc = vecop_list,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .vece = MO_64 },
     };
 
@@ -3032,7 +3032,7 @@ void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
           .fniv = tcg_gen_shri_vec,
           .fno = gen_helper_gvec_shr64i,
           .opt_opc = vecop_list,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .vece = MO_64 },
     };
 
@@ -3125,7 +3125,7 @@ void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
           .fniv = tcg_gen_sari_vec,
           .fno = gen_helper_gvec_sar64i,
           .opt_opc = vecop_list,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .vece = MO_64 },
     };
 
@@ -3184,7 +3184,7 @@ void tcg_gen_gvec_rotli(unsigned vece, uint32_t dofs, uint32_t aofs,
           .fniv = tcg_gen_rotli_vec,
           .fno = gen_helper_gvec_rotl64i,
           .opt_opc = vecop_list,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .vece = MO_64 },
     };
 
@@ -3513,7 +3513,7 @@ void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs, uint32_t aofs,
           .fniv = tcg_gen_shlv_mod_vec,
           .fno = gen_helper_gvec_shl64v,
           .opt_opc = vecop_list,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .vece = MO_64 },
     };
 
@@ -3576,7 +3576,7 @@ void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs, uint32_t aofs,
           .fniv = tcg_gen_shrv_mod_vec,
           .fno = gen_helper_gvec_shr64v,
           .opt_opc = vecop_list,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .vece = MO_64 },
     };
 
@@ -3639,7 +3639,7 @@ void tcg_gen_gvec_sarv(unsigned vece, uint32_t dofs, uint32_t aofs,
           .fniv = tcg_gen_sarv_mod_vec,
           .fno = gen_helper_gvec_sar64v,
           .opt_opc = vecop_list,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .vece = MO_64 },
     };
 
@@ -3702,7 +3702,7 @@ void tcg_gen_gvec_rotlv(unsigned vece, uint32_t dofs, uint32_t aofs,
           .fniv = tcg_gen_rotlv_mod_vec,
           .fno = gen_helper_gvec_rotl64v,
           .opt_opc = vecop_list,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .vece = MO_64 },
     };
 
@@ -3761,7 +3761,7 @@ void tcg_gen_gvec_rotrv(unsigned vece, uint32_t dofs, uint32_t aofs,
           .fniv = tcg_gen_rotrv_mod_vec,
           .fno = gen_helper_gvec_rotr64v,
           .opt_opc = vecop_list,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .vece = MO_64 },
     };
 
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 0fde3d669d..535844dc09 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3005,7 +3005,7 @@ static void gen_PMOVMSKB(DisasContext *s, X86DecodedInsn *decode)
         .fniv = gen_pmovmskb_vec,
         .opt_opc = vecop_list,
         .vece = MO_64,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64
+        .prefer_i64 = true
     };
     MemOp ot = decode->op[2].ot;
     int vec_len = vector_len(s, decode);
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 2a487179f6..caefd38216 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1489,7 +1489,7 @@ static void tcg_gen_gvec_rsubs(unsigned vece, uint32_t dofs, uint32_t aofs,
           .fniv = gen_rsub_vec,
           .fno = gen_helper_vec_rsubs64,
           .opt_opc = vecop_list,
-          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .prefer_i64 = true,
           .vece = MO_64 },
     };
 
-- 
2.43.0


