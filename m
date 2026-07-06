Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE96C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggid-0007Cl-NH; Mon, 06 Jul 2026 06:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiF-000709-I2
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:10 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiD-0003Gb-Nf
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:07 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493d3135f62so9044145e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334284; x=1783939084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s6dzd1hn+vPgcOffUF2LY84jneo37++mNtdru7f80BM=;
 b=zRPkzlqy+JpyIMOz32jmojpY/YaNAlXHiVIoGiO/c7kmCWRQbYUYDv/1DjzHqpFzGm
 9lQmyEsGc8xdWA4c/fF/++X/1aVg3GQmMuP3K1knkqYe/79iErZRR4RO5KvwAmnG/Kz3
 WtXGRjY9fWehfxXG1ZI+i/KcjkWfhCGHAusToCMWHXSwYlFXvUaa9N+knGeLvP6c82HH
 AWB9M92ty696pSDXyexJqV/wH8nqrm59uhqnB+Y2KN95BkGwnK525fIH9C/0qPCbWBBm
 xZtyHCSvZlt4Rk5M1ZenazEm8JdKkCxrNDpPOk691buXTSF8hoMah9XVGbu9M90BkUTh
 nkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334284; x=1783939084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s6dzd1hn+vPgcOffUF2LY84jneo37++mNtdru7f80BM=;
 b=k29a0RsdPIvszm9/4Cv/CcQ8WI9vVpm0BzgsQt0EoJ6LhUXW9/K6fBSLL5w9wuXUAD
 eIjidYmRHMcwVPSvykbmZApAkk2lkmE/yFmLOv3BqY+VmrQU5YLvBd3TH4TV9CntSnXn
 1zrJIaCYQyW3ALjv57V3oabnFml7I2Hme34NSad+xN4srj77TsJHZtf4Fp2/aZcirnES
 Ioh+8tryV3dJxquxm9Xhk/6FF3ZzHAZBIP1krP9WvYkBjlGSKtTpWwZ4KBrcRPJG5Nnu
 q8OH/QIxVXf0OCB3rUhfgWDzxoDnRm+xcs0cQYM2aBZH2joSjnew3s0ZAKAxoGLd1ZP7
 1liQ==
X-Gm-Message-State: AOJu0YyKde4Qm2GxzO8ey8c57SOcVjSDOBe7NgqmUEGcAWMczVa2fzr7
 vXps1eBiwwNDdM8FyM17qquEzpi8G8qYVJObVXCk2B3OyklvRjuXzqHVPDKv8cTKBY3RXxJeNQH
 EUvVfl2XfzA==
X-Gm-Gg: AfdE7cnRwL9QBUL0Y55K4WgMNvS9xDP191OgU7hVJtbh+ek955DkDzEINP0/7syFUOs
 YPLjbA6vcGNGudWyIvM7xTRup52lzobRecl1c4o7trNopFCvyRgjpqpvj8ziAIEbMy29TPC69WY
 PrZ6QhfpgBFrPGt7AvenU3b4BxXxGxfin3ngDaO3gAOJAxWieKKg8ppUcG4AAr5OCCIbB/rjvc7
 jsDYQc9txBea/GHZbAlwOP6g5+dpbYBiMNnMJdYCUQ8XKWpvorwaVC99kWhN8lDlvJM+YyKbKO9
 VEFb+Ox3UKmlD49VYobLW6v72tegFuohKthKMhjTb73SldZExURZ3b4QDOAqhNGKVbxGQLTYRzu
 3pphcfBuiVkorCJDVopRjlYlrQlxr/wITMv6YmrKAK5M3g04HvxrDADeXS4C0vXCIN7tZ7oBsWj
 IlMl8qjWH7fdoLPFEtIecxSZCPbMjoTf5Xx8UN+dIU5O7Hf5vfgjnznoHZ5sOdYd97f22ENfCdQ
 hdgj1/TyFLhZ413ZXMnUScI9+WSQLQw
X-Received: by 2002:a05:600c:8b6e:b0:492:66fb:5dc5 with SMTP id
 5b1f17b1804b1-493d11f326fmr109313045e9.24.1783334284118; 
 Mon, 06 Jul 2026 03:38:04 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/49] target/arm: Implement and enable FEAT_SSVE_FEXPA for
 -cpu max
Date: Mon,  6 Jul 2026 11:37:13 +0100
Message-ID: <20260706103752.320511-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260626164819.770787-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst  |  1 +
 linux-user/aarch64/elfload.c   |  1 +
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/cpu64.c         |  1 +
 target/arm/tcg/translate-sve.c | 21 +++++++++++++++------
 5 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index b1fec58840..2864e25294 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -176,6 +176,7 @@ the following architecture extensions:
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
 - FEAT_SSVE_AES (Streaming SVE Mode Advanced Encryption Standard and 128-bit polynomial multiply long instructions)
+- FEAT_SSVE_FEXPA (Streaming FEXPA instruction)
 - FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index e33dce7830..850bfb8666 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -174,6 +174,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_f8mm8, ARM_HWCAP_A64_F8MM8);
     GET_FEATURE_ID(aa64_f8mm4, ARM_HWCAP_A64_F8MM4);
     GET_FEATURE_ID(aa64_ssve_aes, ARM_HWCAP_A64_SME_AES);
+    GET_FEATURE_ID(aa64_ssve_fexpa, ARM_HWCAP_A64_SME_SFEXPA);
     GET_FEATURE_ID(aa64_fprcvt, ARM_HWCAP_A64_FPRCVT);
 
     return hwcaps;
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index e1d9259d30..de81c4f103 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1580,6 +1580,11 @@ static inline bool isar_feature_aa64_sve_b16b16(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, B16B16);
 }
 
+static inline bool isar_feature_aa64_ssve_fexpa(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SFEXPA);
+}
+
 static inline bool isar_feature_aa64_ssve_aes(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, AES);
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 1f9eb56a94..e0d701a85c 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1384,6 +1384,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SFEXPA, 1);   /* FEAT_SSVE_FEXPA */
     t = FIELD_DP64(t, ID_AA64SMFR0, AES, 1);      /* FEAT_SSVE_AES */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 79e8e16b24..fc4cc8c479 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -1369,12 +1369,21 @@ TRANS_FEAT_NONSTREAMING(ADR_u32, aa64_sve, do_adr, a, gen_helper_sve_adr_u32)
  *** SVE Integer Misc - Unpredicated Group
  */
 
-static gen_helper_gvec_2 * const fexpa_fns[4] = {
-    NULL,                   gen_helper_sve_fexpa_h,
-    gen_helper_sve_fexpa_s, gen_helper_sve_fexpa_d,
-};
-TRANS_FEAT_NONSTREAMING(FEXPA, aa64_sve, gen_gvec_ool_zz,
-                        fexpa_fns[a->esz], a->rd, a->rn, s->fpcr_ah)
+static bool trans_FEXPA(DisasContext *s, arg_FEXPA *a)
+{
+    static gen_helper_gvec_2 * const fexpa_fns[4] = {
+        NULL,                   gen_helper_sve_fexpa_h,
+        gen_helper_sve_fexpa_s, gen_helper_sve_fexpa_d,
+    };
+
+    if (!dc_isar_feature(aa64_ssve_fexpa, s)) {
+        if (!dc_isar_feature(aa64_sve, s)) {
+            return false;
+        }
+        s->is_nonstreaming = true;
+    }
+    return gen_gvec_ool_zz(s, fexpa_fns[a->esz], a->rd, a->rn, s->fpcr_ah);
+}
 
 static gen_helper_gvec_3 * const ftssel_fns[4] = {
     NULL,                    gen_helper_sve_ftssel_h,
-- 
2.43.0


