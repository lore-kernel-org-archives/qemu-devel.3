Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0389FC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEU-0000g4-4t; Fri, 04 Jul 2025 12:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEN-0000SD-Qc
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:43 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEM-0006Fm-1a
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-453398e90e9so7307635e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646340; x=1752251140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TeVABKU27JjQMH5BNqpGbGewIvYogQ219hdAmQQCeWo=;
 b=XzaNeYiTVMqsKl2ykNsucU8hVD96SaG7X9DkV+MOkHGjfruGje0LCnZy6IY1wiV6fA
 ZuHBAJcy3RjfzaErL+V3tmErm2hmg57tkllL/jux7DQ4WYDv00F9j8B0BJ+z0ppBu13T
 TXizn1LTJDjODk8jn/wUzKuxE4sFl4uH47YXMArVezOL3yiPE8gs+K62qyfzI+l8XFDF
 D73ch9+ouzl3gTX1QVDYYhAKRRemiUOeHvHo0D+c8CJogoz1GkSK3jU01M5+13Fdiq7i
 jM2P0P8eZP534tOfColpwF4SI6uevkja/YH8FxDOCxttfCU1RglZI+2G6+dudZqeV0z2
 P07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646340; x=1752251140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TeVABKU27JjQMH5BNqpGbGewIvYogQ219hdAmQQCeWo=;
 b=XyCWF5OfZI4EpcPpQonpKZiPpFOSMf9t7l+abevU4FN6In5SSvInRChgpvOYEmcSZW
 c7dNafAEvl8n15gXuvR6QtxB28tLLGKqVWhN0Da5RmyrN07JCnuGMc2e/cpdl4RagB2R
 Tra5blYIzmzwnBB7fVgPinmNnX+1Kls0Pm2ORHlxmiQ4HFU7ImB+WZYhz+iqVMhGiAYC
 qXY8Iyb+f5dEWpv6lanEd+C0gWH8n9kM/c0TveSxQx2JX9J75LayZ7VBDl+ntCTdOfVe
 QjPlFtnNmfF77TmlgV81vIF1WCZxxm+XveGeC3/xgUvXe4S9N2vF6OxBTAUhLcRcehu3
 /+WA==
X-Gm-Message-State: AOJu0YyDQUO2YxadpGTjwpuP6Nsp0zDWOpd6DRuCR1v+efNqJqNxNWNQ
 OPHThIdELnCs1GZNccarbCK7VX3l1Q+AtpMCwSBhNutFQS+TPm1R4Lbh3AAdLE/hDjCAGq1z7dA
 Pw7nJ
X-Gm-Gg: ASbGncvY7jfd+i0uGywqFvzmleyEjsfO32b+kDd2H+vYw0UAj27yWjJdol8qU7kSj8I
 eadA1qtdziEeoBovQfpz8R3f8l391lS4ZBD4iiFXYe89amcqEts1S2PU1q7d+wAYaHrs0PrxlQG
 qPl7Shp0hKRlO5DQtXFjBJLOTYy4bVEMslKOwCXkcW3+ZRTOnkQGHAFHk5JD+5cMAzxmqLTTKZ7
 w72twmmM+WggxqBzhmxH48vuXgGs57nszec0Vow2FJZot1aWp6b7G2pDYtbvxY5q96nwH4/mDIH
 +4n18b3Xw+3yDn2s20fJj9KTSKUX3LcOnr6LzlSFOWbphwRxXIOf4UmPc5NmvQGBlmK8
X-Google-Smtp-Source: AGHT+IEPvhZMVgok86HdGMPH6JvqG1ufGauo1N7LE6Lv4mv9zELyfCvqjAY2G7+Fd1IERtMRz4UZlA==
X-Received: by 2002:a05:600c:6819:b0:43b:ce36:7574 with SMTP id
 5b1f17b1804b1-454b3116294mr30564805e9.11.1751646340471; 
 Fri, 04 Jul 2025 09:25:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 041/119] target/arm: Introduce gen_gvec_sve2_sqdmulh
Date: Fri,  4 Jul 2025 17:23:41 +0100
Message-ID: <20250704162501.249138-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

To be used by both SVE2 and SME2.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-30-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.h |  4 ++++
 target/arm/tcg/gengvec64.c     | 11 +++++++++++
 target/arm/tcg/translate-sve.c |  8 +-------
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index 8a9f4b20539..993dde61a4d 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -225,6 +225,10 @@ void gen_gvec_usqadd_qc(unsigned vece, uint32_t rd_ofs,
                         uint32_t rn_ofs, uint32_t rm_ofs,
                         uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_sve2_sqdmulh(unsigned vece, uint32_t rd_ofs,
+                           uint32_t rn_ofs, uint32_t rm_ofs,
+                           uint32_t opr_sz, uint32_t max_sz);
+
 void gen_sve_ldr(DisasContext *s, TCGv_ptr, int vofs,
                  int len, int rn, int imm, MemOp align);
 void gen_sve_str(DisasContext *s, TCGv_ptr, int vofs,
diff --git a/target/arm/tcg/gengvec64.c b/target/arm/tcg/gengvec64.c
index 2617cde0a5f..2429cab1b88 100644
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
index d2cd298b5b2..7e304245c64 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -5948,6 +5948,7 @@ TRANS_FEAT(MOVPRFX_z, aa64_sve, do_movz_zpz, a->rd, a->rn, a->pg, a->esz, false)
  */
 
 TRANS_FEAT(MUL_zzz, aa64_sve2, gen_gvec_fn_arg_zzz, tcg_gen_gvec_mul, a)
+TRANS_FEAT(SQDMULH_zzz, aa64_sve2, gen_gvec_fn_arg_zzz, gen_gvec_sve2_sqdmulh, a)
 
 static gen_helper_gvec_3 * const smulh_zzz_fns[4] = {
     gen_helper_gvec_smulh_b, gen_helper_gvec_smulh_h,
@@ -5966,13 +5967,6 @@ TRANS_FEAT(UMULH_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
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


