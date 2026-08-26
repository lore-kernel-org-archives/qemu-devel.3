Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64ACC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHeN-0000Y0-6k; Wed, 26 Aug 2026 13:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHe5-0000D1-52
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:47 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHe2-0004rC-Lr
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:40 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cc1c7364550so950841a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766157; x=1788370957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hbxE8j5TnyHhPNt4mCLhEpSl1dMLWX06clsmhks0gDQ=;
 b=yUxF3iaOuQkhPX6XF8w70RQINkr6HcfDR9HbdtC3A0GEgg8fFTPhQkHCIAscfKhOjI
 xI8McqK5YtpHMKtWg6eUfHKLUp8d08zQIFYydohR3loniGM0tPLPLWurFV6cyt7MmAUR
 ik2bSzKv0WfJiRUPYHBjAr0sCHTIuw+L0wAkt4judTHc/YU2CNfXa2BzQYMMHXWlVeOz
 NU8btHfBfdmIpF30QlMK5mayG5jtXhkXdOOiitrKhf2ZW0Jj/nLjFvLnu8/FNbkkEQQ7
 A5KYzFqjmxmSOr8a4f9eC83w9ks5g9WvFPZ/zTZtR7CSX+7E3SQSs3EzhpAwXbC9vTyF
 Ypig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766157; x=1788370957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hbxE8j5TnyHhPNt4mCLhEpSl1dMLWX06clsmhks0gDQ=;
 b=YMAZ7UXIkn7jtIbhyOjDTjdMS7C0PG6HSCduECVER6vU51zOOItrJIoo21BlmD9nPo
 dMtwzW5ijGjQafEgp/4/owToyvi5i2WUW+ps1jg9g9UVhux3DZndwSeqvgmInmp4xWth
 EbVQe/A2KH9nflhQ6JG8cTT/0tPNGAR6lsfKssQXEMEZHmMAgwfrxvr6Xazs507evA8I
 c3IaxVDkm5k9fA5ax/eOoX7tEyb+B4AWJZ8O972x3+diD71mUnPrKKf6xgPCHqUUvqig
 vBwNPhCsfzidv/2l0Jp48DbGWG2OCZMOy39sQWKnky7PXSrzXIgsFpX4/Wo/p7nPU0aQ
 p0iQ==
X-Gm-Message-State: AFuF++lY1VJx1axpffVEnu3vKpjT/WW+ytWn0NGJ9545Qx5Mr6CHXxLL
 a1vEe2ICyxImjTNIhYhhNT5qQ6EGfOb66LKjyBP/ipW3t6u/wroX0X6HoW2nRN2coA1d4Dq0SGx
 +5OgeQ4U=
X-Gm-Gg: AR+sD130rJ2G7CZIk2tiRCBqcB4qXbfoMq3VjwT0kskVL9I6M3MttWMBLg2YPhN4V5X
 nVn3P95DSbzbsZ9E8h3ybfX3vojpLjSGdwGBtcXlyERjKOTxB8eHUZ5kCwehIcggv7azU/o+J63
 rxRZfSd6kJ3fFE6M4YU/xCisQRMLhhyffL0m1HkXtC9ypXVsCZag7xYK3zILL2SpOGOkoUh0TnT
 mRsO2oJkkAmXvLmg2QeOY3bMUFqjF8qfgZHHpd9CjLBX/brSlRPYP5FpUHkKy6zr9lQhcBjn59k
 1JTQot5LWlWr2/3pt+fiGLYa5YsRzs9Qv0izFbV5WEqulwPUU2saz+YY401fV2mV5GKV4S6bd2C
 wKRZYlH67Xjvcg7SGdciOPJXHkxjyyguIxRBiyaZlQqmNT0DjBlTVQ/PQhNVjSo1hCuiFGb97+Z
 XNAoi+lpBqbC0p3/mHOJHYv5zDxS77Nhp9v+8OR/js0Avb8KKsSU7w/8p78Isoq0hv33xZBPwIH
 rkbtqBSnQn3y+OHAA==
X-Received: by 2002:a05:6a21:3a4a:b0:3cc:2552:ddd7 with SMTP id
 adf61e73a8af0-3cf8293ba48mr20415402637.5.1787766156907; 
 Wed, 26 Aug 2026 10:42:36 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 19/25] target/arm: Implement and enable FEAT_SSVE_BitPerm
 for -cpu max
Date: Wed, 26 Aug 2026 10:42:06 -0700
Message-ID: <20260826174213.614571-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
References: <20260826174213.614571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 linux-user/aarch64/elfload.c   |  1 +
 target/arm/tcg/cpu64.c         |  1 +
 target/arm/tcg/translate-sve.c | 12 ++++++------
 docs/system/arm/emulation.rst  |  1 +
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 44dfc7d457c..d3130fbe671 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1605,6 +1605,11 @@ static inline bool isar_feature_aa64_ssve_aes(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, AES);
 }
 
+static inline bool isar_feature_aa64_ssve_bitperm(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SBITPERM);
+}
+
 static inline bool isar_feature_aa64_ssve_f8fma(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8FMA);
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 7afbfca4183..4359312ee38 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -181,6 +181,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_sve2p2, ARM_HWCAP_A64_SVE2P2);
     GET_FEATURE_ID(aa64_sme2p2, ARM_HWCAP_A64_SME2P2);
     GET_FEATURE_ID(aa64_sve_bfscale, ARM_HWCAP_A64_SVE_BFSCALE);
+    GET_FEATURE_ID(aa64_ssve_bitperm, ARM_HWCAP_A64_SME_SBITPERM);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index f04d708bcc2..ab32cedba46 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1483,6 +1483,7 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, STMOP, 1);    /* v9.4: FEAT_SME_TMOP */
     t = FIELD_DP64(t, ID_AA64SMFR0, SFEXPA, 1);   /* v9.4: FEAT_SSVE_FEXPA */
     t = FIELD_DP64(t, ID_AA64SMFR0, AES, 1);      /* v9.5: FEAT_SSVE_AES */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SBITPERM, 1); /* v9.4: FEAT_SSVE_BitPerm */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* v9.2: FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* v9.2: FEAT_SSVE_FP8DOT4 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* v9.2: FEAT_SSVE_FP8FMA */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 3d823674cca..8a5903da4fc 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7430,22 +7430,22 @@ static gen_helper_gvec_3 * const bext_fns[4] = {
     gen_helper_sve2_bext_b, gen_helper_sve2_bext_h,
     gen_helper_sve2_bext_s, gen_helper_sve2_bext_d,
 };
-TRANS_FEAT_NONSTREAMING(BEXT, aa64_sve_bitperm, gen_gvec_ool_arg_zzz,
-                        bext_fns[a->esz], a, 0)
+TRANS_FEAT_STREAMING_IF(BEXT, aa64_sve_bitperm, aa64_ssve_bitperm,
+                        gen_gvec_ool_arg_zzz, bext_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const bdep_fns[4] = {
     gen_helper_sve2_bdep_b, gen_helper_sve2_bdep_h,
     gen_helper_sve2_bdep_s, gen_helper_sve2_bdep_d,
 };
-TRANS_FEAT_NONSTREAMING(BDEP, aa64_sve_bitperm, gen_gvec_ool_arg_zzz,
-                        bdep_fns[a->esz], a, 0)
+TRANS_FEAT_STREAMING_IF(BDEP, aa64_sve_bitperm, aa64_ssve_bitperm,
+                        gen_gvec_ool_arg_zzz, bdep_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const bgrp_fns[4] = {
     gen_helper_sve2_bgrp_b, gen_helper_sve2_bgrp_h,
     gen_helper_sve2_bgrp_s, gen_helper_sve2_bgrp_d,
 };
-TRANS_FEAT_NONSTREAMING(BGRP, aa64_sve_bitperm, gen_gvec_ool_arg_zzz,
-                        bgrp_fns[a->esz], a, 0)
+TRANS_FEAT_STREAMING_IF(BGRP, aa64_sve_bitperm, aa64_ssve_bitperm,
+                        gen_gvec_ool_arg_zzz, bgrp_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const cadd_fns[4] = {
     gen_helper_sve2_cadd_b, gen_helper_sve2_cadd_h,
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index d41ad978bbd..b9c6b8226d6 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -191,6 +191,7 @@ the following architecture extensions:
 - FEAT_SME_MOP4 (Quarter-tile outer product instructions)
 - FEAT_SME_TMOP (Structured sparsity outer product instructions)
 - FEAT_SSVE_AES (Streaming SVE Mode Advanced Encryption Standard and 128-bit polynomial multiply long instructions)
+- FEAT_SSVE_BitPerm (Streaming Scalable Vector Bit Permutes instructions)
 - FEAT_SSVE_FEXPA (Streaming FEXPA instruction)
 - FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
-- 
2.53.0


