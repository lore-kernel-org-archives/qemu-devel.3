Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC0CC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxVJ-0001qa-GH; Tue, 28 May 2024 10:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxV3-0001jn-78
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:25 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUz-00077s-4e
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:24 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-354faf5f1b4so667177f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905299; x=1717510099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eUpqWL0RMr00yluMUjIv8p2E8ThsTmcfnEs2p/FMlME=;
 b=JP63YODxM8Aj1Vu1jqUhVe+jhQemESSYdb4OoU6Kwrd6tsN+XuvBMTYz+PtwaTeXUN
 3DwFEvRvMv7J2s5xid1ADIkilUcWqm9/mNik3uH7rvYlEDQcptePYP4Mqd68ymS6slVj
 kv9JiZdq2fUCAT6QtiHC4OqE7IkESkqf4uIMxnZx9pvJ0opjTNmxtcqX499oRckHyE7z
 cPys387hDKsbJ86l9iAOCZtQ1PIHMQk8ABXsy8jAEmP/EIz1KnM+UgSW16DoMWIGh7HH
 q5gW648c15As5hcS/kSnJ9uN6/8yuiHRFbJ7Mi/QVIWeJP0KJwQGqB0+WZiwwQlPfyYb
 VYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905299; x=1717510099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUpqWL0RMr00yluMUjIv8p2E8ThsTmcfnEs2p/FMlME=;
 b=r/ZT+8Tm9cd+keGTho7gUjDM0IQj930NS983yF9rj394GMVdNqNRI6eflVczYp3w9N
 oHYXYixVB0AaZZOlVFrhHbks6I2NwyldB8stXiAUxZM9TRwJUnXSg4dUXSjinybcogfb
 UyJVVyxVnK3P/LK2rMi1fZSd1gPPc8pDpgTy+b3AODQayazkzxQXjXOkyYxjkO7zK6Gw
 jec4xpfjv/A62SklHbpWjaz+crqlxNffuczxE5O/NZEUwArWsN3W0V7aVXBSEcHcsQOG
 0qr8PHBcrEarAscSBvoey3LF5Pj6gLZkAZ3IEjAwJB3OYEX6ktGq5Z0UkAbjhKtMobDD
 8nfg==
X-Gm-Message-State: AOJu0Ywsqkfi/1DASY3i55wZso8ruvSNHCJgEVd0ufnGaPqIqP6gSVRm
 BBgM26GgO61F0YufEOpHtmR9lK5Fg3V7Cpv5PX2PmKUf29AoV5ZyA0e7rFGAOGOCTALSVQIWwqY
 P
X-Google-Smtp-Source: AGHT+IHy74CYbwVxFL+QM+ExcaMEvgte74rWtd/AKdTuJSoE/8Bx9BcuHKH53zQDqRNhwql/sY0LAQ==
X-Received: by 2002:adf:f24b:0:b0:34e:93c1:7979 with SMTP id
 ffacd0b85a97d-3552fdaa2fcmr11715091f8f.38.1716905299632; 
 Tue, 28 May 2024 07:08:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.08.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:08:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/42] target/arm: Use gvec for neon pmax, pmin
Date: Tue, 28 May 2024 15:07:51 +0100
Message-Id: <20240528140753.3620597-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240524232121.284515-35-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-neon.c | 78 ++-------------------------------
 1 file changed, 4 insertions(+), 74 deletions(-)

diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 6c5a7a98e1b..18b048611b3 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -831,6 +831,10 @@ DO_3SAME_NO_SZ_3(VABA_S, gen_gvec_saba)
 DO_3SAME_NO_SZ_3(VABD_U, gen_gvec_uabd)
 DO_3SAME_NO_SZ_3(VABA_U, gen_gvec_uaba)
 DO_3SAME_NO_SZ_3(VPADD, gen_gvec_addp)
+DO_3SAME_NO_SZ_3(VPMAX_S, gen_gvec_smaxp)
+DO_3SAME_NO_SZ_3(VPMIN_S, gen_gvec_sminp)
+DO_3SAME_NO_SZ_3(VPMAX_U, gen_gvec_umaxp)
+DO_3SAME_NO_SZ_3(VPMIN_U, gen_gvec_uminp)
 
 #define DO_3SAME_CMP(INSN, COND)                                        \
     static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
@@ -1003,80 +1007,6 @@ DO_3SAME_32_ENV(VQSHL_U, qshl_u)
 DO_3SAME_32_ENV(VQRSHL_S, qrshl_s)
 DO_3SAME_32_ENV(VQRSHL_U, qrshl_u)
 
-static bool do_3same_pair(DisasContext *s, arg_3same *a, NeonGenTwoOpFn *fn)
-{
-    /* Operations handled pairwise 32 bits at a time */
-    TCGv_i32 tmp, tmp2, tmp3;
-
-    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
-        return false;
-    }
-
-    if (a->size == 3) {
-        return false;
-    }
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    assert(a->q == 0); /* enforced by decode patterns */
-
-    /*
-     * Note that we have to be careful not to clobber the source operands
-     * in the "vm == vd" case by storing the result of the first pass too
-     * early. Since Q is 0 there are always just two passes, so instead
-     * of a complicated loop over each pass we just unroll.
-     */
-    tmp = tcg_temp_new_i32();
-    tmp2 = tcg_temp_new_i32();
-    tmp3 = tcg_temp_new_i32();
-
-    read_neon_element32(tmp, a->vn, 0, MO_32);
-    read_neon_element32(tmp2, a->vn, 1, MO_32);
-    fn(tmp, tmp, tmp2);
-
-    read_neon_element32(tmp3, a->vm, 0, MO_32);
-    read_neon_element32(tmp2, a->vm, 1, MO_32);
-    fn(tmp3, tmp3, tmp2);
-
-    write_neon_element32(tmp, a->vd, 0, MO_32);
-    write_neon_element32(tmp3, a->vd, 1, MO_32);
-
-    return true;
-}
-
-#define DO_3SAME_PAIR(INSN, func)                                       \
-    static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
-    {                                                                   \
-        static NeonGenTwoOpFn * const fns[] = {                         \
-            gen_helper_neon_##func##8,                                  \
-            gen_helper_neon_##func##16,                                 \
-            gen_helper_neon_##func##32,                                 \
-        };                                                              \
-        if (a->size > 2) {                                              \
-            return false;                                               \
-        }                                                               \
-        return do_3same_pair(s, a, fns[a->size]);                       \
-    }
-
-/* 32-bit pairwise ops end up the same as the elementwise versions.  */
-#define gen_helper_neon_pmax_s32  tcg_gen_smax_i32
-#define gen_helper_neon_pmax_u32  tcg_gen_umax_i32
-#define gen_helper_neon_pmin_s32  tcg_gen_smin_i32
-#define gen_helper_neon_pmin_u32  tcg_gen_umin_i32
-
-DO_3SAME_PAIR(VPMAX_S, pmax_s)
-DO_3SAME_PAIR(VPMIN_S, pmin_s)
-DO_3SAME_PAIR(VPMAX_U, pmax_u)
-DO_3SAME_PAIR(VPMIN_U, pmin_u)
-
 #define DO_3SAME_VQDMULH(INSN, FUNC)                                    \
     WRAP_ENV_FN(gen_##INSN##_tramp16, gen_helper_neon_##FUNC##_s16);    \
     WRAP_ENV_FN(gen_##INSN##_tramp32, gen_helper_neon_##FUNC##_s32);    \
-- 
2.34.1


