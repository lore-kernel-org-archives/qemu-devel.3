Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF01C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMdg-0008Qw-91; Fri, 24 Jan 2025 11:34:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYw-0005Xr-6t
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:42 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYu-0005he-1k
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:41 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so16743765e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736178; x=1738340978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uwLB2/qsas/ACZj3WYwXl/SE6xTdp+P0tyNcW+gNK5Y=;
 b=BnrH0Ir4KJy352jnc8jjIK2ofgDF2eS+TZhmvianF/mms1MpwG4tlFRRWEYLSoIRry
 Eq6EgkBC+nTnpgmikf+Zi3dsaor6veeUJ8F2jQt3f0c6RIZu/LFOiCSCnLsV7pwfU5xz
 7N8ZVxA/Lu1BFtoAknDjiEgd1AyCy3Mm3fDcTZHuzqxgaAIeu+C2iQ7lRVtO9o7pibr0
 +F31hM1b/WB9zXDhnEUDaVY9fXZRpxMkpgeTU5YMR9niSnV1vHX5QLjJNsj8o+2Mm7+p
 cIlyPXHDHB/pn8pzlpLVD7/NaRYxuTb+4NheDxM5o1SUREnfk095I85j1sBs4bmMZwDk
 WLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736178; x=1738340978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uwLB2/qsas/ACZj3WYwXl/SE6xTdp+P0tyNcW+gNK5Y=;
 b=Nzcffgsy+EsjhQ+9VBSKj03gDtISgoEs3dB7uVOElz9WiRCshpQFcvOgFQXPOKkTsb
 VcDkg1rrrgphAVTG9mCAVOrQpWO33A3atXVGttA/f9OnXHRSeZ5kaf0nPX32KmKe6aiI
 BWehI0XTx8UduI9E/QbRanjPKqkeIMt5a6C2q5rm2jw8+AoVGYE01LZ7DprHrZRBEvLO
 0ky3zEiFzaEOqxB1WhPPGFZnVj5tD9n1pQKb+TMku73Dbdh07SooILKmQ/PH8XjrCbHA
 VCOyFbYw4RNNdrqbyXYL6e5jFuVPffHkPr4h/EYOKCpntbcXrwlz/fdQZpU912MKx2yO
 NX0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqDiPrvmvsxm3lg3PoBcboo2CA41xzM5ya1/e9PrP9kkhDP/KJmNiLz+Ap64E6D6LH9w9tHioGz3qB@nongnu.org
X-Gm-Message-State: AOJu0YwKL8+ZyqOI/lvZVgkO9Y9y8jS6aaEKjhFsqsg/jhm2BpV6TJrl
 0BnhoVFkDptrUlnp5hzowe3m0/NK7DPFPf9EV+A7eGuWO3Blk96Nw2Ens/E+/guLiP/bE4YCc+1
 S
X-Gm-Gg: ASbGncvZGVKJpx/8VATOYl41e6zUiMeplHB+/zGp61AwQPhIltGrjamQ6gLn9JNnGxu
 zv0yh18qTw9YpOQssNyoTQSH8loYMPx90BR4XjGP8o2Kt/wY5kqiaoQQrbDu8zil1G9vBXipOjR
 y6ZLhEyzeEmkO+6kJoaZVM+APfJSMmbasCCXoJZesJQ7tsyp1lkmzJ8iC5ssQd6o78Kq5tAkwum
 4IUFlazLbcMKZDHm69rfA5gJVuHNqhh/bPU3AvMr0MN8Ke6V6HCZwKB8sQ615kF0JZRSP34gFLZ
 nEmkqjJu2tI=
X-Google-Smtp-Source: AGHT+IF5hnM3VS6ydwgr55m7aq12uE4lC2p+POmvoCGWxS84J4I6m6hqjAe+vhXEWfWMTEHSa3V2IA==
X-Received: by 2002:a05:600c:1f86:b0:436:aaf:7eb9 with SMTP id
 5b1f17b1804b1-43891439d5fmr257378745e9.20.1737736178519; 
 Fri, 24 Jan 2025 08:29:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 49/76] target/arm: Implement FPCR.AH semantics for SVE FMAXV
 and FMINV
Date: Fri, 24 Jan 2025 16:28:09 +0000
Message-Id: <20250124162836.2332150-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Implement the FPCR.AH semantics for the SVE FMAXV and FMINV
vector-reduction-to-scalar max/min operations.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 14 +++++++++++
 target/arm/tcg/sve_helper.c    | 43 +++++++++++++++++++++-------------
 target/arm/tcg/translate-sve.c | 16 +++++++++++--
 3 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 8349752e99b..7ca95b8fa94 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1035,6 +1035,20 @@ DEF_HELPER_FLAGS_4(sve_fminv_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_4(sve_fminv_d, TCG_CALL_NO_RWG,
                    i64, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_4(sve_ah_fmaxv_h, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sve_ah_fmaxv_s, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sve_ah_fmaxv_d, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_4(sve_ah_fminv_h, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sve_ah_fminv_s, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sve_ah_fminv_d, TCG_CALL_NO_RWG,
+                   i64, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_5(sve_fadda_h, TCG_CALL_NO_RWG,
                    i64, i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fadda_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 9837c5bc7ac..3631d85f23a 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4190,7 +4190,7 @@ static TYPE NAME##_reduce(TYPE *data, float_status *status, uintptr_t n) \
         uintptr_t half = n / 2;                                       \
         TYPE lo = NAME##_reduce(data, status, half);                  \
         TYPE hi = NAME##_reduce(data + half, status, half);           \
-        return TYPE##_##FUNC(lo, hi, status);                         \
+        return FUNC(lo, hi, status);                                  \
     }                                                                 \
 }                                                                     \
 uint64_t HELPER(NAME)(void *vn, void *vg, float_status *s, uint32_t desc) \
@@ -4211,26 +4211,37 @@ uint64_t HELPER(NAME)(void *vn, void *vg, float_status *s, uint32_t desc) \
     return NAME##_reduce(data, s, maxsz / sizeof(TYPE));              \
 }
 
-DO_REDUCE(sve_faddv_h, float16, H1_2, add, float16_zero)
-DO_REDUCE(sve_faddv_s, float32, H1_4, add, float32_zero)
-DO_REDUCE(sve_faddv_d, float64, H1_8, add, float64_zero)
+DO_REDUCE(sve_faddv_h, float16, H1_2, float16_add, float16_zero)
+DO_REDUCE(sve_faddv_s, float32, H1_4, float32_add, float32_zero)
+DO_REDUCE(sve_faddv_d, float64, H1_8, float64_add, float64_zero)
 
 /* Identity is floatN_default_nan, without the function call.  */
-DO_REDUCE(sve_fminnmv_h, float16, H1_2, minnum, 0x7E00)
-DO_REDUCE(sve_fminnmv_s, float32, H1_4, minnum, 0x7FC00000)
-DO_REDUCE(sve_fminnmv_d, float64, H1_8, minnum, 0x7FF8000000000000ULL)
+DO_REDUCE(sve_fminnmv_h, float16, H1_2, float16_minnum, 0x7E00)
+DO_REDUCE(sve_fminnmv_s, float32, H1_4, float32_minnum, 0x7FC00000)
+DO_REDUCE(sve_fminnmv_d, float64, H1_8, float64_minnum, 0x7FF8000000000000ULL)
 
-DO_REDUCE(sve_fmaxnmv_h, float16, H1_2, maxnum, 0x7E00)
-DO_REDUCE(sve_fmaxnmv_s, float32, H1_4, maxnum, 0x7FC00000)
-DO_REDUCE(sve_fmaxnmv_d, float64, H1_8, maxnum, 0x7FF8000000000000ULL)
+DO_REDUCE(sve_fmaxnmv_h, float16, H1_2, float16_maxnum, 0x7E00)
+DO_REDUCE(sve_fmaxnmv_s, float32, H1_4, float32_maxnum, 0x7FC00000)
+DO_REDUCE(sve_fmaxnmv_d, float64, H1_8, float64_maxnum, 0x7FF8000000000000ULL)
 
-DO_REDUCE(sve_fminv_h, float16, H1_2, min, float16_infinity)
-DO_REDUCE(sve_fminv_s, float32, H1_4, min, float32_infinity)
-DO_REDUCE(sve_fminv_d, float64, H1_8, min, float64_infinity)
+DO_REDUCE(sve_fminv_h, float16, H1_2, float16_min, float16_infinity)
+DO_REDUCE(sve_fminv_s, float32, H1_4, float32_min, float32_infinity)
+DO_REDUCE(sve_fminv_d, float64, H1_8, float64_min, float64_infinity)
 
-DO_REDUCE(sve_fmaxv_h, float16, H1_2, max, float16_chs(float16_infinity))
-DO_REDUCE(sve_fmaxv_s, float32, H1_4, max, float32_chs(float32_infinity))
-DO_REDUCE(sve_fmaxv_d, float64, H1_8, max, float64_chs(float64_infinity))
+DO_REDUCE(sve_fmaxv_h, float16, H1_2, float16_max, float16_chs(float16_infinity))
+DO_REDUCE(sve_fmaxv_s, float32, H1_4, float32_max, float32_chs(float32_infinity))
+DO_REDUCE(sve_fmaxv_d, float64, H1_8, float64_max, float64_chs(float64_infinity))
+
+DO_REDUCE(sve_ah_fminv_h, float16, H1_2, helper_vfp_ah_minh, float16_infinity)
+DO_REDUCE(sve_ah_fminv_s, float32, H1_4, helper_vfp_ah_mins, float32_infinity)
+DO_REDUCE(sve_ah_fminv_d, float64, H1_8, helper_vfp_ah_mind, float64_infinity)
+
+DO_REDUCE(sve_ah_fmaxv_h, float16, H1_2, helper_vfp_ah_maxh,
+          float16_chs(float16_infinity))
+DO_REDUCE(sve_ah_fmaxv_s, float32, H1_4, helper_vfp_ah_maxs,
+          float32_chs(float32_infinity))
+DO_REDUCE(sve_ah_fmaxv_d, float64, H1_8, helper_vfp_ah_maxd,
+          float64_chs(float64_infinity))
 
 #undef DO_REDUCE
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index ad415c43565..effa23cefd7 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3588,11 +3588,23 @@ static bool do_reduce(DisasContext *s, arg_rpr_esz *a,
     };                                                                   \
     TRANS_FEAT(NAME, aa64_sve, do_reduce, a, name##_fns[a->esz])
 
+#define DO_VPZ_AH(NAME, name)                                            \
+    static gen_helper_fp_reduce * const name##_fns[4] = {                \
+        NULL,                      gen_helper_sve_##name##_h,            \
+        gen_helper_sve_##name##_s, gen_helper_sve_##name##_d,            \
+    };                                                                   \
+    static gen_helper_fp_reduce * const name##_ah_fns[4] = {             \
+        NULL,                      gen_helper_sve_ah_##name##_h,         \
+        gen_helper_sve_ah_##name##_s, gen_helper_sve_ah_##name##_d,      \
+    };                                                                   \
+    TRANS_FEAT(NAME, aa64_sve, do_reduce, a,                             \
+               s->fpcr_ah ? name##_ah_fns[a->esz] : name##_fns[a->esz])
+
 DO_VPZ(FADDV, faddv)
 DO_VPZ(FMINNMV, fminnmv)
 DO_VPZ(FMAXNMV, fmaxnmv)
-DO_VPZ(FMINV, fminv)
-DO_VPZ(FMAXV, fmaxv)
+DO_VPZ_AH(FMINV, fminv)
+DO_VPZ_AH(FMAXV, fmaxv)
 
 #undef DO_VPZ
 
-- 
2.34.1


