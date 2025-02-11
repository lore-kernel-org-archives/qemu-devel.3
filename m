Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF278C021A1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht7V-0002S3-Jc; Tue, 11 Feb 2025 11:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5g-0006WU-O6
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:29 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5e-0003AR-7q
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:27 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38dcb7122c1so3729322f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291184; x=1739895984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OQ8+UEDyF+vR9XVEdsyAorb54BbrDnxn4gmI2dF7CEQ=;
 b=TJgpVcZFV8/Vzaord+7xkb2opk32v9N89sqnAIssDG0i2HhT3AgC7pr/fNFlhaK3D3
 IV05Yl31lzqM5l8BLTb8CEI/g1u548OJDRkDvzOxNgfmUTWROFPDVsxNwmK6hf6O/8F5
 rzi7ykz5KDWfqDdafVmqT6saQEbS1J0WjsFi74slhqj6O5n3s/z9lsC9IqZPE1o+f6Pu
 WAzNXHQzZOu7zYoO+UMJ+DVZrpM5IED804wnSy3aEQlMt7C5V5FiAUYCt5LqQlZMNIj2
 LqzUR5iDHciu3oj0rlhb/Sh9C8BKlKC/qCknyVi5v1aiWSg4mXkYwZQCNzOr+hfbiGJA
 yqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291184; x=1739895984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQ8+UEDyF+vR9XVEdsyAorb54BbrDnxn4gmI2dF7CEQ=;
 b=T69ojY/vmCNL7z07NrWbIMSa9JD8Wc5bs8Np28vWcjblg+DcDvIp9bUx7RaeupRP8F
 NiBxCjpB8DkUvdHiT0rPmZk8kAcvEAqf7kPuRd+3j5VZ2wYhSj19hKQRW0hkqoFSg72w
 VujuOW4ByFPKYJuw5/6ztlnDtDyAqcL+Bbxj5FlrRMMp7dLck+eHS0bNAobfx3HWqFZA
 QF5+MKPOxSQx+a6HItzO04EKHW7elVIsN/edS4dK2SXA2ISv7tq1GQSSy9tSeJ+cz+2R
 kCnsJ5wFPpq6fT7csiwQsr0vDc6ZdqXdw5Uia9SJC8mnzITo+Fs7ni6u15nzo/Hrjfp4
 Vmhw==
X-Gm-Message-State: AOJu0YxRteMIzj0qbqqM9vX4tclXJ9C/DmcNaSihqdKgypgEf9o49RzK
 iV2CHJoEpEPMfA54/Sk2qKkHVSvRhTzie0v0fpNFt9F19MEfbNOW+8X2Y5sYCTkIYpGXAYA05Tf
 c
X-Gm-Gg: ASbGncuM6b27RJrkJw2QwaEW7isPIL3HBt1ZTh08xWDrez5QJ9VW1Yi7oK33kpEfmND
 Ng+reE+EOihQKTZ5grNpXQWMhXH+An7j4t40TPp73FvhikP0yn2RCwH8b4D122EKXvvPQPspceM
 CwoRqJt4T672dMdg/KtFV4OViMJO6Ms9U0eQSoqaBJnDaS0O+h0mTdk+I0lUYSaleTNOXwPXeeD
 fTrCESJsB6revAtScTjRHOZ3xAAJcmQ9Z5JhCWUPkXbU/2oNNkbgmmTNRp7nQP0kGk+ItxuxAoD
 Z/YdB/15wnvDE0h5XL7H
X-Google-Smtp-Source: AGHT+IF79mh0BHd0eDCJI50tH245dELYYjoTz1iX3vXlMI3RXGGY/dT2G620FCEMsOE4q9kHqwKe6w==
X-Received: by 2002:a05:6000:178c:b0:38d:e401:fd66 with SMTP id
 ffacd0b85a97d-38de937cf1emr338446f8f.31.1739291184618; 
 Tue, 11 Feb 2025 08:26:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/68] target/arm: Implement FPCR.AH semantics for SVE FMAXV
 and FMINV
Date: Tue, 11 Feb 2025 16:25:13 +0000
Message-Id: <20250211162554.4135349-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Implement the FPCR.AH semantics for the SVE FMAXV and FMINV
vector-reduction-to-scalar max/min operations.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index e38a49dd31c..35f6d78a0e0 100644
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


