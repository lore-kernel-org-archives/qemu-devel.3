Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806B1C0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht6Y-0007rN-IQ; Tue, 11 Feb 2025 11:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5i-0006Wc-7g
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:30 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5g-0003BK-H2
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:29 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4395561ab71so8285045e9.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291186; x=1739895986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2jpxKV3cZKID86X9NgsSgQN/RBeTni16lZXdGrHHA/o=;
 b=FIBHlqncEUjHO5nyP6Df3AwHZLwul6Ir+jMeCEsMVAWexWrcPrCW41w5xhiBfMi2CO
 fAUCvgu7Q4QnUs8VJEPCXg22qoD8NTvv9wa2UxMTPymXdybqkDOON2MXiZ4FyLd+jXQb
 g0Y+JqMODg3spm6P2qVF9tEZwF/OHGq9VibXAfX0+115SPHb+J7u6qEuxKshg9s7t6J8
 F83SMEQrqXdhh7M/oLOFXh/Wzq+FelsGY6CRCnkH5W/MmAD1xezF8YXYI3im15XXr61n
 feUkttL+25pSzGns1y904TwHbhzPrdLrgubMWGiD5vojzPyoARCXiaWBsWbugHiuQEAt
 5K+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291186; x=1739895986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jpxKV3cZKID86X9NgsSgQN/RBeTni16lZXdGrHHA/o=;
 b=ssJORCybVz3hSn4oZ2HV2nkfZ5jhJ9iin4FVlzokrN9x8F4rYFBTvcyBqrZLDyFVON
 GAnroVpSvQLoZkdRRRxNogV3M0TfF+CfjoU6ea9yA6AV5ecoiqRKWLbBBbVEXQNkh/6k
 2SePOOa7vw16cdy0ZUmET4vzL7kgbv4psm+JPb5osi/2Na7rR2W8PpiN3ncd/M0/AB2S
 vT5EEc5Aq5oOqw5W4ccoNR5q7ssXobNWUoFzETcXKarPaLkd4iB2S4Y/fuuNfMiTqBJo
 wbzuAf756Hyof+sykOHRoXIXYCSuf2IdG70o2zj23EquApSj7dht/AhmDY+UymaY/3En
 KSkg==
X-Gm-Message-State: AOJu0YzRfeG6TdnnOoxdx8q+5WtQ4kbe2pPuoj5oUOnv5l77JK8Q9Eyh
 tCtFVfPtnZ/ZAa9VA+3QNK40A7lGW1eSd/S9/kppNIjqB9Jhx5rjuYYrAwbcuyTe/ZjLDPIMwpD
 n
X-Gm-Gg: ASbGnctVgMVfQCB02XBkXmY46ft9fEEEflxrnlH2cbfLKalNc5RJYqVq8r2AYzBjaZ9
 vyTqW0h3KgPHlsJc3+q3MWSkKYmkEsKYrc5h/bTOEmZoZebdLMYXulm6sloPWSe6BaqgiT+cBbV
 leYc3Mh4/8X6Qv6A+lR090FITBrN5gZ2niBUbL+Yd138IuF5Vxphn/d6q1bw3L3tvevof9ac1e1
 QXlTI7VOzYAHalvIjDoXIf7eaFROU2TOzmq+RJU0Ot6io2L52/KuV0yfHUjHmrvmLO3MN33Vzk0
 lpGQW1N/n51UOdAj/Guy
X-Google-Smtp-Source: AGHT+IErVfUQNi/kSbwcyME3496lx18X1bTFn6QefN5eVJqgOjO7iG0UxQI9nITtYi2V8YQukA+6DQ==
X-Received: by 2002:a05:600c:3d06:b0:436:2238:97f6 with SMTP id
 5b1f17b1804b1-4392f1b8e78mr106415585e9.1.1739291186395; 
 Tue, 11 Feb 2025 08:26:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/68] target/arm: Implement FPCR.AH semantics for SVE
 FMIN/FMAX vector
Date: Tue, 11 Feb 2025 16:25:15 +0000
Message-Id: <20250211162554.4135349-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Implement the FPCR.AH semantics for the SVE FMAX and FMIN
operations that take two vector operands.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 14 ++++++++++++++
 target/arm/tcg/sve_helper.c    |  8 ++++++++
 target/arm/tcg/translate-sve.c | 17 +++++++++++++++--
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 3c1d2624ed4..918f2e61b7e 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1140,6 +1140,20 @@ DEF_HELPER_FLAGS_6(sve_fmax_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_fmax_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve_ah_fmin_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmin_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmin_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_6(sve_ah_fmax_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmax_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmax_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_6(sve_fminnum_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fminnum_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 2f6fc82ee4f..a688b98d284 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4347,6 +4347,14 @@ DO_ZPZZ_FP(sve_fmax_h, uint16_t, H1_2, float16_max)
 DO_ZPZZ_FP(sve_fmax_s, uint32_t, H1_4, float32_max)
 DO_ZPZZ_FP(sve_fmax_d, uint64_t, H1_8, float64_max)
 
+DO_ZPZZ_FP(sve_ah_fmin_h, uint16_t, H1_2, helper_vfp_ah_minh)
+DO_ZPZZ_FP(sve_ah_fmin_s, uint32_t, H1_4, helper_vfp_ah_mins)
+DO_ZPZZ_FP(sve_ah_fmin_d, uint64_t, H1_8, helper_vfp_ah_mind)
+
+DO_ZPZZ_FP(sve_ah_fmax_h, uint16_t, H1_2, helper_vfp_ah_maxh)
+DO_ZPZZ_FP(sve_ah_fmax_s, uint32_t, H1_4, helper_vfp_ah_maxs)
+DO_ZPZZ_FP(sve_ah_fmax_d, uint64_t, H1_8, helper_vfp_ah_maxd)
+
 DO_ZPZZ_FP(sve_fminnum_h, uint16_t, H1_2, float16_minnum)
 DO_ZPZZ_FP(sve_fminnum_s, uint32_t, H1_4, float32_minnum)
 DO_ZPZZ_FP(sve_fminnum_d, uint64_t, H1_8, float64_minnum)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 187bd647c29..2813e5f4871 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3759,11 +3759,24 @@ TRANS_FEAT_NONSTREAMING(FTSMUL, aa64_sve, gen_gvec_fpst_arg_zzz,
     };                                                          \
     TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz, name##_zpzz_fns[a->esz], a)
 
+#define DO_ZPZZ_AH_FP(NAME, FEAT, name, ah_name)                        \
+    static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = {         \
+        NULL,                  gen_helper_##name##_h,                   \
+        gen_helper_##name##_s, gen_helper_##name##_d                    \
+    };                                                                  \
+    static gen_helper_gvec_4_ptr * const name##_ah_zpzz_fns[4] = {      \
+        NULL,                  gen_helper_##ah_name##_h,                \
+        gen_helper_##ah_name##_s, gen_helper_##ah_name##_d              \
+    };                                                                  \
+    TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz,                      \
+               s->fpcr_ah ? name##_ah_zpzz_fns[a->esz] :                \
+               name##_zpzz_fns[a->esz], a)
+
 DO_ZPZZ_FP(FADD_zpzz, aa64_sve, sve_fadd)
 DO_ZPZZ_FP(FSUB_zpzz, aa64_sve, sve_fsub)
 DO_ZPZZ_FP(FMUL_zpzz, aa64_sve, sve_fmul)
-DO_ZPZZ_FP(FMIN_zpzz, aa64_sve, sve_fmin)
-DO_ZPZZ_FP(FMAX_zpzz, aa64_sve, sve_fmax)
+DO_ZPZZ_AH_FP(FMIN_zpzz, aa64_sve, sve_fmin, sve_ah_fmin)
+DO_ZPZZ_AH_FP(FMAX_zpzz, aa64_sve, sve_fmax, sve_ah_fmax)
 DO_ZPZZ_FP(FMINNM_zpzz, aa64_sve, sve_fminnum)
 DO_ZPZZ_FP(FMAXNM_zpzz, aa64_sve, sve_fmaxnum)
 DO_ZPZZ_FP(FABD, aa64_sve, sve_fabd)
-- 
2.34.1


