Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E46C0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80a-0007S6-1g; Thu, 06 Feb 2025 14:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80J-0007GS-Ib
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:41 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80G-0000Yr-Cl
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:38 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21f0bc811dbso36350755ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871855; x=1739476655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZnOov9Q8Xvb775TM41H1ruTNMzSk5UaJhoV8tS6Pdg=;
 b=iMq8IPiLfUjIPXVSSFv9VKNW/QpzmRgLlPaGkDSQIxSpUu9K9M9XEm/a5pYh1w8LPe
 w6lOOkaTVrS9AAdDUbGJH8qAKVUccJMn1NWfF96lh54zarj1ZofRuhoIRzhJcvefNB9n
 Y79+YZNZEzqLUu2rj69LR0x76igEEjs2Vf5xwYnrn7zQsVsimyaxUCYBSHFBJhu1s7Sy
 o5rmls3TpMgOGacTV0+sUasiiSApOZ2AvC8D9iI5rnDO4feFldf0DLPuMhD4+i/S+OEL
 li9N1HPGZRTogfOzcOyeVjsELhHseJZGCj04dSi2Mtysur6q7fKfxRqJdZTfTgn4BuuC
 UG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871855; x=1739476655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nZnOov9Q8Xvb775TM41H1ruTNMzSk5UaJhoV8tS6Pdg=;
 b=jyRSSedFklXDuHhlUDke5bgo9GHYDIDZvlcS9dOyADIz0H2UOJ+K8MrZ8SobnyAWoO
 P7mZe2Osqf4w+xdq+nd/l25G21RML23t7MfIlmZQDFUcf0lyKk8xdSIEj5stGgw8dt6X
 fcw6nCtgMi+Vmbbh1xXlM8FCjzKCFvUs/+EzCP8rwgSuGPydNhiNqLX4RLghN3inJyt5
 o4UDvKGJO6gNmG20gjWqAXd94jba4BIn5mGNJBFaL+biLzrHUcQjAoJwQ4RPs3ZhF9tU
 W8taW50bM6/125TXNPZaIwZvNiLYB0yZf4G3SYGAsrwohfW6O0QcaWw9+CHaAy/4YIdO
 Rbnw==
X-Gm-Message-State: AOJu0YwMj7Zz5UaFJTVmfkj2HrL59jZ44luIjLsLsb1YXwjfYYn6sewC
 w7SvoloqLWthCOpEkBNS7BHApqkumJ44wlsdB77t2cLYmB2PLlvAA8Ud3AQy3mBeQCDvof5MUH6
 2
X-Gm-Gg: ASbGnctSXCmrYXcUQd/o4RqeEj4GBkyIyjGO5/UplAQYv/4Ygb0yT4y4DHdvdTC7GC1
 CvBNmubevETulLz1+IfFlZg3+sxATM3yOV0PxFaDmlseHL1Z+tBw5CkLD+m/xGp2m2MhJOI+Gdo
 /r6Q3wHuC1pHMoKZjuV28lznIvubeiIPCdiQpP5+hsnkYVwR3o608gdYS2e4bFtd3Bv49u9kCc+
 +s8iDF0kLBFHJ+9hEmueFqaqnuaDXS1b0SIujhPTMbHzvehNNnjyYVxwvsnkWVsq6B+gfvx+cHC
 wVDAIQ6G5Y/fKo5K8CuFn87AFyrwchZ+W2IraGW1f6zZdvY=
X-Google-Smtp-Source: AGHT+IHDV0VWKSesIjo68m28gs72fixSJrzk2bkJfCZFOfmWnOnteevbEqq8ANpocWm6qfiQVTG6oQ==
X-Received: by 2002:a05:6a20:c792:b0:1e1:ad7:3282 with SMTP id
 adf61e73a8af0-1ee05290951mr419986637.7.1738871855106; 
 Thu, 06 Feb 2025 11:57:35 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 25/61] target/arm: Introduce gen_gvec_sve2_sqdmulh
Date: Thu,  6 Feb 2025 11:56:39 -0800
Message-ID: <20250206195715.2150758-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

To be used by both SVE2 and SME2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.h |  4 ++++
 target/arm/tcg/gengvec64.c     | 11 +++++++++++
 target/arm/tcg/translate-sve.c |  8 +-------
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index 7d3b59ccd9..481dfeb965 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -225,6 +225,10 @@ void gen_gvec_usqadd_qc(unsigned vece, uint32_t rd_ofs,
                         uint32_t rn_ofs, uint32_t rm_ofs,
                         uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_sve2_sqdmulh(unsigned vece, uint32_t rd_ofs,
+                           uint32_t rn_ofs, uint32_t rm_ofs,
+                           uint32_t opr_sz, uint32_t max_sz);
+
 void gen_sve_ldr(DisasContext *s, TCGv_ptr, int vofs, int len, int rn, int imm);
 void gen_sve_str(DisasContext *s, TCGv_ptr, int vofs, int len, int rn, int imm);
 
diff --git a/target/arm/tcg/gengvec64.c b/target/arm/tcg/gengvec64.c
index 2617cde0a5..2429cab1b8 100644
--- a/target/arm/tcg/gengvec64.c
+++ b/target/arm/tcg/gengvec64.c
@@ -369,3 +369,14 @@ void gen_gvec_usqadd_qc(unsigned vece, uint32_t rd_ofs,
     tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
+
+void gen_gvec_sve2_sqdmulh(unsigned vece, uint32_t rd_ofs,
+                           uint32_t rn_ofs, uint32_t rm_ofs,
+                           uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve2_sqdmulh_b, gen_helper_sve2_sqdmulh_h,
+        gen_helper_sve2_sqdmulh_s, gen_helper_sve2_sqdmulh_d,
+    };
+    tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, 0, fns[vece]);
+}
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index d23be477b4..0907a4e9e9 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -5911,6 +5911,7 @@ TRANS_FEAT(MOVPRFX_z, aa64_sve, do_movz_zpz, a->rd, a->rn, a->pg, a->esz, false)
  */
 
 TRANS_FEAT(MUL_zzz, aa64_sve2, gen_gvec_fn_arg_zzz, tcg_gen_gvec_mul, a)
+TRANS_FEAT(SQDMULH_zzz, aa64_sve2, gen_gvec_fn_arg_zzz, gen_gvec_sve2_sqdmulh, a)
 
 static gen_helper_gvec_3 * const smulh_zzz_fns[4] = {
     gen_helper_gvec_smulh_b, gen_helper_gvec_smulh_h,
@@ -5929,13 +5930,6 @@ TRANS_FEAT(UMULH_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
 TRANS_FEAT(PMUL_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
            gen_helper_gvec_pmul_b, a, 0)
 
-static gen_helper_gvec_3 * const sqdmulh_zzz_fns[4] = {
-    gen_helper_sve2_sqdmulh_b, gen_helper_sve2_sqdmulh_h,
-    gen_helper_sve2_sqdmulh_s, gen_helper_sve2_sqdmulh_d,
-};
-TRANS_FEAT(SQDMULH_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
-           sqdmulh_zzz_fns[a->esz], a, 0)
-
 static gen_helper_gvec_3 * const sqrdmulh_zzz_fns[4] = {
     gen_helper_sve2_sqrdmulh_b, gen_helper_sve2_sqrdmulh_h,
     gen_helper_sve2_sqrdmulh_s, gen_helper_sve2_sqrdmulh_d,
-- 
2.43.0


