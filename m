Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E710C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwgM-0008Lw-Qk; Wed, 02 Jul 2025 08:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwg5-0007vh-P8
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:05 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfm-00013n-9a
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:02 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72bc3987a05so4100147a34.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459683; x=1752064483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2U5p1MzK0qCl5rjkb4N72c8zKR970KadGxVxWW1Bymo=;
 b=gMDmph7OtDjSMyT++MFmKDyZl/ecRrmxDEiEyznmHta02SfopSHIAU55TrMd+PNlKE
 tVz6LtPcXG5EIdcbdq2W/uTa4dvrUyLBjDv5ncihnsaT3S48jpF9sajV9cxupK6Qw+so
 gRZzicori4K57gI1FnHLLRwV7hTMoZZsJYzWZYK6Y9cAw0Wciq44zngfpFaINUawHlC8
 foGaCx2PFZob/OAj/ZBdixSx67XCUEqmBvoVM6QwxixjXgc2dLP1O1KW0csCdKYI8Otf
 wGaVx+46tKJaLpt6J6eeijTVRYm7fRjyJVlvvfObcCVxjIck0P9hSibNifZmKLLvUGsL
 zFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459683; x=1752064483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2U5p1MzK0qCl5rjkb4N72c8zKR970KadGxVxWW1Bymo=;
 b=a9I2M1HdmcpyhtYdrV6xbCMbVc58j/ZNKbtlxmxPVcWXmvGEFuvUgAd15XAGdjYFK0
 ihFKspzGrDSVf3VGE2IdyuXJw4YyYA7//xQEivWkgoUjRqMwt8j5YNf9fGKFf3cm/kS7
 ZZ4kEjbovuYiD4hEvC2pZSlYE9xOBqG0mloWOWWka5+0bPt0rXOWmjfz1Yiz65s/CMDp
 if2tNC02EbPTF37FFFJSM99jM7vTBYAAFMIipw1a1mB+x1HlKzkR/XwSlOGF99qlThpi
 hu7UDS5CCkjtTqSzg6yzAjRoo4htJ0q2xhi6LV6xo4iM5Lo1ofQnfdiXt92h4Lm8rUzA
 LSzA==
X-Gm-Message-State: AOJu0YyeiiA9pqzG1A+8CkLKgwi77lZv3Cah4zK7cvciCxZG17mvvE5i
 qNlC6tb48qyDf8P6jc0IYSVgGeyi0gPhqwb8w2EvYItHjxdIvUsA7DG82S2tpUI4+xumL1LNJzj
 AWmemNjs=
X-Gm-Gg: ASbGnct9R1AVXnlej3vQwS74ZUS2sIKU3ANd/R+GdtrpXIdC8+/VFCdM22rqEg+5x4w
 me0kRO+4g6tlyzUTwGZgZMlJIocIsMw6Ew2SQDEzMruOjMo2+7ogGXcnVHx6H3kl7UB1hMQGfVj
 mIK02cihzB2iEfAA9qw8W7w9cT6+GJt0IF8Y4N1UJZbxUOeY2qPe1W8hWzodS2FaFvTD4Pnztil
 tR5aztHnRdRkOPvyRKirFNM6CbAJPHhjX4GWBl+5QAUVv3dHMsLIzkNAX6oQc/BeCUfBBHU42K3
 HdfGenIU/YetckKIOhyO7o3TsR+y6vdSfnM2rLjbKyUaZPzkKGuYqJ1kcYNh3VOg5ehKNw==
X-Google-Smtp-Source: AGHT+IGc5sfiNua9HfP64fbvAg1sp947jx8940BuPO/+AY5tC/fLJMM9oDx1kSLnFfkvTGzKo88e8w==
X-Received: by 2002:a05:6830:8088:b0:735:a6df:babc with SMTP id
 46e09a7af769-73b4ee1916amr1281087a34.3.1751459682804; 
 Wed, 02 Jul 2025 05:34:42 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 24/97] target/arm: Pass ZA to helper_sve2_fmlal_zz[zx]w_s
Date: Wed,  2 Jul 2025 06:32:57 -0600
Message-ID: <20250702123410.761208-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

Indicate whether to use FPST_FPCR or FPST_ZA via bit 2 of
simd_data(desc).  For SVE, this bit remains zero.
For do_FMLAL_zzzw, this requires no change.
For do_FMLAL_zzxw, move the index up one bit.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 2 +-
 target/arm/tcg/vec_helper.c    | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 7e304245c6..b85bd885f9 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7214,7 +7214,7 @@ static bool do_FMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sub, bool sel)
 {
     return gen_gvec_ptr_zzzz(s, gen_helper_sve2_fmlal_zzxw_s,
                              a->rd, a->rn, a->rm, a->ra,
-                             (a->index << 2) | (sel << 1) | sub, tcg_env);
+                             (a->index << 3) | (sel << 1) | sub, tcg_env);
 }
 
 TRANS_FEAT(FMLALB_zzxw, aa64_sve2, do_FMLAL_zzxw, a, false, false)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 40ce0cbc8b..f3de26ca54 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2191,7 +2191,8 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
     intptr_t i, oprsz = simd_oprsz(desc);
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
-    float_status *status = &env->vfp.fp_status[FPST_A64];
+    bool za = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    float_status *status = &env->vfp.fp_status[za ? FPST_ZA : FPST_A64];
     bool fz16 = env->vfp.fpcr & FPCR_FZ16;
     int negx = 0, negf = 0;
 
@@ -2274,8 +2275,9 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
     intptr_t i, j, oprsz = simd_oprsz(desc);
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
-    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
-    float_status *status = &env->vfp.fp_status[FPST_A64];
+    bool za = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 3, 3) * sizeof(float16);
+    float_status *status = &env->vfp.fp_status[za ? FPST_ZA : FPST_A64];
     bool fz16 = env->vfp.fpcr & FPCR_FZ16;
     int negx = 0, negf = 0;
 
-- 
2.43.0


