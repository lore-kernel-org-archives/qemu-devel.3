Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDB6C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwgE-0008Cf-TO; Wed, 02 Jul 2025 08:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwg1-0007pl-0K
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:03 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfk-00013D-Hw
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:58 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6118b000506so1613921eaf.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459681; x=1752064481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jfD7brFizp76W5ey2BEJuLnJue/+9RsnLtE1z9wY2gg=;
 b=gS8Bu2rR0oGJqPa5dM8JyM/C9OKLzVnlhP9BaxZR4NTGawqIVCNLYbFtG4hy9b9EqY
 H58gGJp1p+ob5XvULHaBaU1BKvgC9lPGc7yJWBMncLqGX/vAGWMRRyEhSt01ir086uWS
 H+z53cPYzBunB4VDuXMflq3PHA9iPLLohWDxLdzxS0BvOgx/9lIs5fK/z9nZ5uRwD6qC
 cbo/Dv4ns6Hawx00ufkJUCwvbOsZD8uHpDB7RyFv1/NcZLZlcCMPrNeDWNf0sBoEbiC+
 lum6ttiAEktaJVsH0MkL6gpcjkxRgXd5gkAWj7UToCneDZGOZpxhMeZ73dDWr9o/+obI
 kuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459681; x=1752064481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jfD7brFizp76W5ey2BEJuLnJue/+9RsnLtE1z9wY2gg=;
 b=h4TOqp0Gv5JfjbBd79YBaRoY0Rxb3eNVN3Y7/ZA06NiCXJFszzJ7wLvH3QMIsvHn6k
 XIcjZ7zmi2DAGf6lAX0fdPWGu6dXTxbO0n8uaatMqjBDW1SlhRJdexIAnMcFM8JKURnR
 QKL2DK800dYiHlN2K6Szn3sNIrA1DN/5cwTWLodSBCiMjXxk4AN/Z3S1dmu4YLAdHVrU
 nw77ikLgggOw1AKVzDHtyehcT6ZQMRsxIoeUI6r4nYe6JiO1F57HOMQWiQ47xFt+wVh6
 BL+Eb4Whfp0JQT2+dUq4CXNTXOu+3y1CJJaseCliP1BV+149qOYLPjUW4iM9f22uLCss
 VTfw==
X-Gm-Message-State: AOJu0Yzkl1yQXHt96nWb/7dDCKWS/i0QNY5+mIV+WezKFzskPwSP8J8m
 otcjmbYKDVdJq6ripbYN1josWDalzjwWLNaTkUBOmHJhGBtEIeS3qVgDcxEAWjBW08ofokwHWvg
 keKLykW0=
X-Gm-Gg: ASbGnctohJ3dGd4ojh8qZFA2YTqihVWHpXLTuFiJMbI+gbBZh2VXjh918ziqDzDc47B
 Qp6i8Ib3noUNCp4Bwzw93wSoTeZNYwtuJ1Iw9jYjfDXoZwyTXd0FsDkPE3FCisSPp0c0IfMbeY4
 V3oSdjQZiK0Hdun5BdY8thowh9/4HSUdFA0uGm67079DPDLlhXScSFTsGK5ezS5KZeRUNBqsAD9
 HZiTfYzbH/72ko5BGpmkKmZbNOUJsGkAbRa7nkoM75SNRoFQKU+AcbgNbsBr6e5Q9YIgZt7TS1b
 7w85/T3GoLYUKBb+p04yfu/dPtAVGtdx1dLUa7C1zBf7OrIgQlE4kWVnTm/Vu7Apwqwvrl/xNyT
 rT9/e
X-Google-Smtp-Source: AGHT+IHkiv81svtN1m78n8xXBPmw2k5+QFlSfbcf2h6D6qYj/MxAjtx5KaFCIqsMV1+RXgB3M4XndQ==
X-Received: by 2002:a05:6870:1b15:b0:2eb:87a9:7fc1 with SMTP id
 586e51a60fabf-2f5a8d27727mr2046558fac.27.1751459680746; 
 Wed, 02 Jul 2025 05:34:40 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 22/97] target/arm: Implement SME2 ADD/SUB (array results,
 multiple and single vector)
Date: Wed,  2 Jul 2025 06:32:55 -0600
Message-ID: <20250702123410.761208-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     |  2 ++
 target/arm/tcg/translate-sme.c | 30 ++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 15 +++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 1b29b958f3..acfc00be78 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -642,6 +642,8 @@ typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
                         uint32_t, uint32_t, uint32_t);
 typedef void GVecGen4Fn(unsigned, uint32_t, uint32_t, uint32_t,
                         uint32_t, uint32_t, uint32_t);
+typedef void GVecGen3FnVar(unsigned, TCGv_ptr, uint32_t, TCGv_ptr, uint32_t,
+                           TCGv_ptr, uint32_t, uint32_t, uint32_t);
 
 /* Function prototype for gen_ functions for calling Neon helpers */
 typedef void NeonGenOneOpFn(TCGv_i32, TCGv_i32);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 0a6a10b63d..4bb880d9ef 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -745,3 +745,33 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
 };
 TRANS_FEAT(FMINNM_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fminnm)
 TRANS_FEAT(FMINNM_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fminnm)
+
+/* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
+static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
+                      GVecGen3FnVar *fn)
+{
+    TCGv_ptr t_za;
+    int svl, n, o_zm;
+
+    if (!sme_smza_enabled_check(s)) {
+        return true;
+    }
+
+    n = a->n;
+    t_za = get_zarray(s, a->rv, a->off, n, 0);
+    o_zm = vec_full_reg_offset(s, a->zm);
+    svl = streaming_vec_reg_size(s);
+
+    for (int i = 0; i < n; ++i) {
+        int o_za = (svl / n * sizeof(ARMVectorReg)) * i;
+        int o_zn = vec_full_reg_offset(s, (a->zn + i) % 32);
+
+        fn(esz, t_za, o_za, tcg_env, o_zn, tcg_env, o_zm, svl, svl);
+    }
+    return true;
+}
+
+TRANS_FEAT(ADD_azz_n1_s, aa64_sme2, do_azz_n1, a, MO_32, tcg_gen_gvec_add_var)
+TRANS_FEAT(SUB_azz_n1_s, aa64_sme2, do_azz_n1, a, MO_32, tcg_gen_gvec_sub_var)
+TRANS_FEAT(ADD_azz_n1_d, aa64_sme2_i16i64, do_azz_n1, a, MO_64, tcg_gen_gvec_add_var)
+TRANS_FEAT(SUB_azz_n1_d, aa64_sme2_i16i64, do_azz_n1, a, MO_64, tcg_gen_gvec_sub_var)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 470592f4c0..8b81c0a0ce 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -245,3 +245,18 @@ URSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 1    @z2z_4x4
 
 SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_2x2
 SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_4x4
+
+### SME2 Multi-vector Multiple and Single Array Vectors
+
+&azz_n          n off rv zn zm
+@azz_nx1_o3     ........ .... zm:4 ...... zn:5 .. off:3     &azz_n rv=%mova_rv
+
+ADD_azz_n1_s    11000001 0010 .... 0 .. 110 ..... 10 ...    @azz_nx1_o3 n=2
+ADD_azz_n1_s    11000001 0011 .... 0 .. 110 ..... 10 ...    @azz_nx1_o3 n=4
+ADD_azz_n1_d    11000001 0110 .... 0 .. 110 ..... 10 ...    @azz_nx1_o3 n=2
+ADD_azz_n1_d    11000001 0111 .... 0 .. 110 ..... 10 ...    @azz_nx1_o3 n=4
+
+SUB_azz_n1_s    11000001 0010 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=2
+SUB_azz_n1_s    11000001 0011 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=4
+SUB_azz_n1_d    11000001 0110 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=2
+SUB_azz_n1_d    11000001 0111 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=4
-- 
2.43.0


