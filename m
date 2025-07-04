Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0582C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhLE-0002dh-Sx; Fri, 04 Jul 2025 10:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIU-0005RX-Kg
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:51 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIS-00067o-RM
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:50 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2ea58f008e9so1150180fac.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638907; x=1752243707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgAkAg7YJqGfUg4WhfoOWkT+HZptAFeo1x8ZSeNdF3g=;
 b=uhk+5QQ6H/vh6VjONSgQRcdVuM3mtU2NDpH0SG+C9AcMMqXRg6mb5+lgJWD4CaFxRS
 HSJwOVqfDPjO3kqiCDwd+qL8f98NQySuypzkqEuSnD+VFThnhkPD7Nxm9UxZPS+ke6FA
 ZXHK46Xwy4uOZ/dm+2/qCexm9CTjbvurTfx5YHJzWwBWhmOsiDTl/3KpOyA/7yYo0U7q
 2x52LcfElg6PxGb2jNuqRvi0Ggy3menmKnYijRv18FwbDk8xPcADsJlvicRa5Wc/xbyw
 nD8VtD7tekCVFuoKjk/vEU0BWMgxXTnpPx/FOC/pVZhn1qAVXfm0claUgSLa/JtULRm+
 DSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638907; x=1752243707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hgAkAg7YJqGfUg4WhfoOWkT+HZptAFeo1x8ZSeNdF3g=;
 b=tAi4zr7x1LZR54muDkchwsqypiwzr2EiZObj/u0gh6Y32XzxYOLq5oaWId7NXGwdQV
 pDmltDv90WypesveYasYOfvzMrPPdftRt9mwWEUn/IXhrHZ8HhBaUxySXh0Y1FvTs0RK
 dpmM1pHbPW1qFaCO1Ll7kJ4ciHdjhuukbPKOGaBSi8qeeRw3krqSZKVTMR9NN5IEcjja
 zkPT/QxnQA9ypm/yVVOspOwEE4vMOPkEJeb0iqyqec3PINAw3jFgD0mzU/+WOUb+qIvQ
 DIO0a0r3g7aZrbJK1320y1+2Vja1IkxXuzq81hNrJ1GYtanTUG3k7x3f6MaVUpmBqrmY
 iIBA==
X-Gm-Message-State: AOJu0YzmEwTT3B2QE3TTJL6FrHwpDQO8lNyen0+fTPT234LCp2P4Yr0Q
 5+AqwvOF9zhvBdazcliiMaCMXh4aTdXSHMboz+fz+4dUyJ+su5I2WrkOG0bW8kjjSJ8L5ypVjey
 cklMWoHo=
X-Gm-Gg: ASbGncuTzanQaW0EFuOBkUsJsvRo6kyRIODcHePwIQhlFQ3ovesb7SnRzc3kz7yFl+0
 g5Noi1dIw1ynO7MUyhgSISZex/NBT+uZiQesFZwC7a6dsOodnynBcj01+xIJ5OF+AMHT60VKpvh
 dgXsrhqNtsZGLD8HsRCOyFfotgZ1NFGWS9JZanfAOQXlfQQzfSD3NSbfruI66fjK+B7ByZ7kSXh
 I8JBElyg9uY9rEicbrXPdOYdvPw5S65jL+mX+S3n7R0XXs/dJvg7fix9UoB/5PNZDdOaJ83ChOy
 HFyuH0nUs68FOlV0R63chzwZI6uA8NYz7bc1hBMRv5WR3a6pIYocTy5ZYlV4xd0TPrHgZt8MJn3
 BJ1t1hSv254vZRR8mBvRTNIyR6fY70Bq4TTSSIILxB99BD7PpJuOZGJIKoxY=
X-Google-Smtp-Source: AGHT+IEnpBHqTYyJuu93rNXGlEcxyZoP6waxK2X1oKwyz2Bpoc1rdQVozo9V/ay/aSF1iArkfxk+pg==
X-Received: by 2002:a05:6871:7823:b0:2f3:e087:6b08 with SMTP id
 586e51a60fabf-2f796c685bdmr1760676fac.24.1751638907369; 
 Fri, 04 Jul 2025 07:21:47 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 032/108] target/arm: Implement SME2 ADD/SUB (array results,
 multiple and single vector)
Date: Fri,  4 Jul 2025 08:19:55 -0600
Message-ID: <20250704142112.1018902-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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
index a18d07540e..f974996f3f 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -643,6 +643,8 @@ typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
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


