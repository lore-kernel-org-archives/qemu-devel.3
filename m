Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94C3C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mnO-0000xA-O8; Sun, 05 May 2024 21:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmh-0007vG-2O
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:52 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmL-0002W3-6Q
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:50 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5e4f79007ffso946501a12.2
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957468; x=1715562268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UP8W08jGkabjOFnDqgYkqKZsFFwz0sFiQIo8Kb1nNMs=;
 b=yObNugZe8tccZv+byBrMRVK32QIlE5yeLSlw88oLu0kQuTIJk8X24XHySV6pQsOvw5
 9KXvO0Q1sR4ta826rmJlKeIXFpTU6YbeYvMW6y4vxRUW05gkOPqsL8G0pZW4202AGSPD
 fiLJ3vH+j/qJYCunaKs0ViVy/m3T7At1ZA8NBsx47s9Fk89he/NOxuUpf0MGaLfNy36x
 HjU4ksE5ItkQfH0T14BgC7pSxWggjtDPEn8XeESSt+TjM+AtmneyvobPTrVmuAizrMpU
 zD1S1HY2JfiJLZAQ3nj9SQqa6T/RD2sS4Te626YHHRqyOGLEYhH8txBwfbmjV64zXcKG
 s9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957468; x=1715562268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UP8W08jGkabjOFnDqgYkqKZsFFwz0sFiQIo8Kb1nNMs=;
 b=Ca2mNuiAIKBvKHQlHrSkXSsOn4SgCR8V9tSKp224ArZAqhuKOeVshdjv69RdXVyvBP
 yStHPz0bjWD4WGHqoV2gNUazU5kh2vox9ICgRWlxDpsgXYRc2MFoSZ/1bkFiMeGRynTK
 kpgxRj+xUIC3SwCktr0Sj0nPtojSFauLp1+XcE3UkIlSHWlc4VBxoHIo7744IMZ/p5Qp
 yf9HmrgOfJFTmVq/O6hBAE25jatV5zmEIpzy6YMBJBeMFGNXlx2CTSW0iy6nRsPOyvH/
 5TOjQU0a9wGUAEK/fymi0oAdBQZq1vvdptQya7LIC6ZEELri1H6kM1V9XL2fdemM058O
 QgRg==
X-Gm-Message-State: AOJu0Yy+GdnA4C94VhMe5ZBC7sgT6qOVqwyyfORlWtuH80tZL40o/3gz
 Mj1vz15yHw6vyrablxThq1F5b9e7HI0qVOYxKOX2M4IEF9hhoCQjukbWjGLxCm30IzLiMICkc80
 9
X-Google-Smtp-Source: AGHT+IG2UGj2r9JFd3Bz54wadVaattxQ0BejZk9jmZ/ZjXmobb9WcaZVXoxpFq88J+Ua1vzK41j60w==
X-Received: by 2002:a05:6a20:4328:b0:1a9:8152:5102 with SMTP id
 h40-20020a056a20432800b001a981525102mr12628161pzk.24.1714957467736; 
 Sun, 05 May 2024 18:04:27 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 27/57] target/arm: Use gvec for neon pmax, pmin
Date: Sun,  5 May 2024 18:03:33 -0700
Message-Id: <20240506010403.6204-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-neon.c | 78 ++-------------------------------
 1 file changed, 4 insertions(+), 74 deletions(-)

diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 6c5a7a98e1..18b048611b 100644
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


