Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E71C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMcB-0005FO-Qb; Fri, 24 Jan 2025 11:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZ4-0005o5-8h
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:54 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZ1-0005jl-N1
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:49 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436202dd730so16572115e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736186; x=1738340986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=llFk2Hwm2qS6gPzAdVlCRdXm81oU4Fumc3QBeOF7eqA=;
 b=JRQHoH5AYzaEQa80G4DcEoZs3r/m17URfp5GeF4MqiUD/Hfq7ZB+JQY5QaZi+KQSzQ
 958wmlivfl6PUx64bhQRqBLifJ7SdBlYqVW+vPn9ws4EnUFpyMl7UcPkhTHEdo8ybRup
 i1GvmwjdyRmq8UqVPPwBBPWJ0dVQPAlH+//fuDJaMAJ+vHrDSGSQPEW1nd3YQvaMiMlG
 YydrmafQ6PzPvKnm6s9UaYpNtmu0mrEyoTJyFOxQk9WQl7JEn8O8aVI+OSR0IkCWaQuM
 nU6SjAhxP6VRj+cZW8NeWw4xxWR9r0j4V/Wm5uzI0Z3oqaRAS3vJ0u6vK5OhKNpiyLC4
 giDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736186; x=1738340986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=llFk2Hwm2qS6gPzAdVlCRdXm81oU4Fumc3QBeOF7eqA=;
 b=NQ8tuS5hrMLsDmh/HqMNBt41by7xvY/fgsRDb2SV/pGJSz3y8/o5IgMwNWsmRClRzl
 UjMp4qHy/ZpuKnnxFb4f5z7e3Fz6jky2S66OgwP57x8sE1Zk/G3jtxep7obPofTZ0R19
 xYN2Kyu3sJU9etkCslrWc4YFkiV4U6x/mm0XVakEjuJfwwP/ahQ0IzVCp+7TFA/n6ZZt
 PpmqubnUYeW08qz9h2K2CzRhgq4W7Rt7bf2S4uVN4TPgTSGocRGHQ7JTDWN4q0t30CB8
 tlRxHIFsK9dgyiU9fA22a0pGVODNkexBQDoFtVrK8OtXM2f7/DnvbU/zAz1XQQjDRF7g
 iQRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2kWJlYcGkiQ/R2aqWxK8dz11k0v7oIyEq9JZryzs+llLm37XrxZW/OOtJt2wQlgF6fN5g7x7aMtzR@nongnu.org
X-Gm-Message-State: AOJu0Yw34H6bSh9EHaDsLZC5iYu/4lybLmWti22+9fbnlr9ranxoc7Sb
 LEORwpLP5HHGbIN00iy2QclaNjKurDb9rKkxwJgOBDyi8wHp5cFJ9LleqC76N+YMLJh0xxdJ37G
 k
X-Gm-Gg: ASbGncvCQIKf7iCbPIsOJt+8z6NtnwCb8Cah1UYASjXFC8DLUs1Rqi+/MJ4SgmVn5Xm
 wNTC84aEWj12+osAzpNJYeQv3p6nqfsjAn99agf5VfZFpqz6p0mN9HHqNowaZCAIcHyeM0i0iR9
 bQNpDNncwgqNVMqQEZjE0VgAug0hKaAzTasdKAPCYv9yK1HsciGxr7c4r6E5KV8AWSo6+6lKcJq
 G7GlPyglBvnJXwaqRM3gNOGOMWdiXSPmBQoADCrEOyCAt5BB7YVWwFKhUHD3pdw3RRJ5yufrN2I
 F4XvfYiffU4=
X-Google-Smtp-Source: AGHT+IHBakJuFVfACELseKgPwcyXN0eRYuYhWLnSi+ZF0XfWHNFr4KTwphHguU36bmhoIt0y/lBhfA==
X-Received: by 2002:a05:600c:4687:b0:435:b064:7dce with SMTP id
 5b1f17b1804b1-438913f2df1mr295364005e9.18.1737736186333; 
 Fri, 24 Jan 2025 08:29:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 54/76] target/arm: Handle FPCR.AH in vector FABD
Date: Fri, 24 Jan 2025 16:28:14 +0000
Message-Id: <20250124162836.2332150-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Split the handling of vector FABD so that it calls a different set
of helpers when FPCR.AH is 1, which implement the "no negation of
the sign of a NaN" semantics.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h            |  4 ++++
 target/arm/tcg/translate-a64.c |  7 ++++++-
 target/arm/tcg/vec_helper.c    | 23 +++++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 15bad0773c0..43505d5fedc 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -722,6 +722,10 @@ DEF_HELPER_FLAGS_5(gvec_fabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_ah_fabd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fabd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_fabd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_5(gvec_fceq_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fceq_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fceq_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 542e774790b..ce9ab75bc2f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5899,7 +5899,12 @@ static gen_helper_gvec_3_ptr * const f_vector_fabd[3] = {
     gen_helper_gvec_fabd_s,
     gen_helper_gvec_fabd_d,
 };
-TRANS(FABD_v, do_fp3_vector, a, 0, f_vector_fabd)
+static gen_helper_gvec_3_ptr * const f_vector_ah_fabd[3] = {
+    gen_helper_gvec_ah_fabd_h,
+    gen_helper_gvec_ah_fabd_s,
+    gen_helper_gvec_ah_fabd_d,
+};
+TRANS(FABD_v, do_fp3_vector_2fn, a, 0, f_vector_fabd, f_vector_ah_fabd)
 
 static gen_helper_gvec_3_ptr * const f_vector_frecps[3] = {
     gen_helper_gvec_recps_h,
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index d3f2eaa807e..3b87e5b8d6d 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1302,6 +1302,25 @@ static float64 float64_abd(float64 op1, float64 op2, float_status *stat)
     return float64_abs(float64_sub(op1, op2, stat));
 }
 
+/* ABD when FPCR.AH = 1: avoid flipping sign bit of a NaN result */
+static float16 float16_ah_abd(float16 op1, float16 op2, float_status *stat)
+{
+    float16 r = float16_sub(op1, op2, stat);
+    return float16_is_any_nan(r) ? r : float16_abs(r);
+}
+
+static float32 float32_ah_abd(float32 op1, float32 op2, float_status *stat)
+{
+    float32 r = float32_sub(op1, op2, stat);
+    return float32_is_any_nan(r) ? r : float32_abs(r);
+}
+
+static float64 float64_ah_abd(float64 op1, float64 op2, float_status *stat)
+{
+    float64 r = float64_sub(op1, op2, stat);
+    return float64_is_any_nan(r) ? r : float64_abs(r);
+}
+
 /*
  * Reciprocal step. These are the AArch32 version which uses a
  * non-fused multiply-and-subtract.
@@ -1389,6 +1408,10 @@ DO_3OP(gvec_fabd_h, float16_abd, float16)
 DO_3OP(gvec_fabd_s, float32_abd, float32)
 DO_3OP(gvec_fabd_d, float64_abd, float64)
 
+DO_3OP(gvec_ah_fabd_h, float16_ah_abd, float16)
+DO_3OP(gvec_ah_fabd_s, float32_ah_abd, float32)
+DO_3OP(gvec_ah_fabd_d, float64_ah_abd, float64)
+
 DO_3OP(gvec_fceq_h, float16_ceq, float16)
 DO_3OP(gvec_fceq_s, float32_ceq, float32)
 DO_3OP(gvec_fceq_d, float64_ceq, float64)
-- 
2.34.1


