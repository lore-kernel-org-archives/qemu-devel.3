Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4AAC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwls-00060N-1N; Wed, 02 Jul 2025 08:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwj7-00048w-Ff
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:14 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwiz-00021I-HE
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:13 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2e9071e3706so2779098fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459884; x=1752064684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lr+1Q+4HQrkLwxVzhzbDGgM0JcjXpo7ZMJemC3MVnNE=;
 b=Mb8Y8snjiEvOcxWRF+Oy9Mb2sseWlDaowczDjyJ3EHL9cDXER21F8pVDEun+KmAtPu
 /G4fWI675Btn9E3Mo1S3lrgeTaNOSliQN63Dt/EghBQAk/j7INyEu8kU92pWf2DxoMsb
 o71gJmThf5PU7bOH3VMNVqNfNZ2ysCgTEae5dfUPGjLTHimmoCELejev3bZ4eiAf5yIo
 RLEBoCPgJblY2S4RqnksN5e21+NCCLdZoz3w+O//GfOitQ1vyundkvDVr+aXMCRMIpLF
 ue1Fohmq/a+tG/2CcmVPpE/iDRdjuhWRXNgT2vih8H+PY15k5C1bZiban9WOrbSjMoC9
 sKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459884; x=1752064684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lr+1Q+4HQrkLwxVzhzbDGgM0JcjXpo7ZMJemC3MVnNE=;
 b=PoZNE7cHjIwDwHQh2OweicE/+AAB66+hCCSiR+m1DX7aF6NzRiwXtyGA4MTwVfBlPu
 HuavsatxCVb5CtooA/g3sme5ZYyFP6GFUBhl0/e/HfIDp1RaEURgJ3oUACu+SEbg+0U8
 QHWZVOuvcSaX/MZT3NHz4/IgFNDIel2dNMMcM4SaWwh5+aE+UsLEe4g/HUvFddQ/+2nZ
 wFOPXXiOxnghpYstl+626kCww1CnX0BvOUe7835aLAZCdYgfLrHCa08kgh8xsI/5XmSt
 AkLPtPJooCX98xINxkkI6S9jz03d5nccLOG8F8nji4tFXWGIOWj1cTEbML1SghIlmqpy
 574w==
X-Gm-Message-State: AOJu0YxYPRt+2/nXLJaDbyWlmttAtLLmXfGuNcU09KCKw8MwzF+RBJ7V
 IELsYA81jh/S5OAnIDPEAmmiF/KOZQwj8PIiIyvRtLDjEYoLPjUhyO25iim8+PC8E1jFGdA88C5
 UnRGnjGs=
X-Gm-Gg: ASbGnctaVEH1Zt5V1vpUmtyB43LmDkSogsvBLG45fjhk5CjmHTwc8KpvZNbBiCHEreM
 iqA5FcobfhMy8I1losKmwqRaBMh1X9PrJIXAGhERnArkmiaLpWe6v369rNYtaDzFyPr24H5fLny
 LSUx9TiAD+Yy2rULe8XI79sdOA+zkog9mo5JDDIei++mtFK8ba0X1DUSL5iQ3QHYB2e5DKZmXdP
 YwFnHl+Ww0Je0Jr495C2hScM4Gb0hn8Wj3jlUcaXOQlx4fo2q9U11ILJYQhPCJLVdPIwSlXyAzu
 bFKCruoMRC1joBDb2k2QcQcLxVmUQ79jricB82X7nAfPTduI26QY9ipVDDqitGPiFD6dUg==
X-Google-Smtp-Source: AGHT+IHa2PPfrYemIN4q4lRVrK/WrE68c1DmA5zGXItK3SAj29IVJseZ4OO65fwitP28WpYOnbCxUA==
X-Received: by 2002:a05:6870:288b:b0:2d4:e101:13ec with SMTP id
 586e51a60fabf-2f5a8d3f1b6mr2038531fac.33.1751459883892; 
 Wed, 02 Jul 2025 05:38:03 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 41/97] target/arm: Implement SME2 ADD/SUB (array
 accumulator)
Date: Wed,  2 Jul 2025 06:33:14 -0600
Message-ID: <20250702123410.761208-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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
 target/arm/tcg/translate-sme.c | 28 ++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 12 ++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 664fdd86aa..4c3b9aa7d6 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -806,6 +806,34 @@ TRANS_FEAT(SUB_azz_nn_s, aa64_sme2, do_azz_nn, a, MO_32, tcg_gen_gvec_sub_var)
 TRANS_FEAT(ADD_azz_nn_d, aa64_sme2_i16i64, do_azz_nn, a, MO_64, tcg_gen_gvec_add_var)
 TRANS_FEAT(SUB_azz_nn_d, aa64_sme2_i16i64, do_azz_nn, a, MO_64, tcg_gen_gvec_sub_var)
 
+/* Add/Sub each ZA[d*N] += Z[m*N] */
+static bool do_aaz(DisasContext *s, arg_az_n *a, int esz, GVecGen3FnVar *fn)
+{
+    TCGv_ptr t_za;
+    int svl, n;
+
+    if (!sme_smza_enabled_check(s)) {
+        return true;
+    }
+
+    n = a->n;
+    t_za = get_zarray(s, a->rv, a->off, n, 0);
+    svl = streaming_vec_reg_size(s);
+
+    for (int i = 0; i < n; ++i) {
+        int o_za = (svl / n * sizeof(ARMVectorReg)) * i;
+        int o_zm = vec_full_reg_offset(s, a->zm + i);
+
+        fn(esz, t_za, o_za, t_za, o_za, tcg_env, o_zm, svl, svl);
+    }
+    return true;
+}
+
+TRANS_FEAT(ADD_aaz_s, aa64_sme2, do_aaz, a, MO_32, tcg_gen_gvec_add_var)
+TRANS_FEAT(SUB_aaz_s, aa64_sme2, do_aaz, a, MO_32, tcg_gen_gvec_sub_var)
+TRANS_FEAT(ADD_aaz_d, aa64_sme2_i16i64, do_aaz, a, MO_64, tcg_gen_gvec_add_var)
+TRANS_FEAT(SUB_aaz_d, aa64_sme2_i16i64, do_aaz, a, MO_64, tcg_gen_gvec_sub_var)
+
 /*
  * Expand array multi-vector single (n1), array multi-vector (nn),
  * and array multi-vector indexed (nx), for floating-point accumulate.
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 0badc8f9fa..22e2a68b1b 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -708,3 +708,15 @@ BFMLS_nx        11000001 0001 .... 1 .. 1.. ...01 1 ....    @azx_4x1_i3_o3
 FMLS_nx_h       11000001 0001 .... 1 .. 1.. ...00 1 ....    @azx_4x1_i3_o3
 FMLS_nx_s       11000001 0101 .... 1 .. 0.. ...00 10 ...    @azx_4x1_i2_o3
 FMLS_nx_d       11000001 1101 .... 1 .. 00. ...00 10 ...    @azx_4x1_i1_o3
+
+### SME2 Add / Sub array accumulators
+
+ADD_aaz_s       11000001 101 000000 .. 111 ....0 10 ...     @az_2x2_o3
+ADD_aaz_s       11000001 101 000010 .. 111 ...00 10 ...     @az_4x4_o3
+ADD_aaz_d       11000001 111 000000 .. 111 ....0 10 ...     @az_2x2_o3
+ADD_aaz_d       11000001 111 000010 .. 111 ...00 10 ...     @az_4x4_o3
+
+SUB_aaz_s       11000001 101 000000 .. 111 ....0 11 ...     @az_2x2_o3
+SUB_aaz_s       11000001 101 000010 .. 111 ...00 11 ...     @az_4x4_o3
+SUB_aaz_d       11000001 111 000000 .. 111 ....0 11 ...     @az_2x2_o3
+SUB_aaz_d       11000001 111 000010 .. 111 ...00 11 ...     @az_4x4_o3
-- 
2.43.0


