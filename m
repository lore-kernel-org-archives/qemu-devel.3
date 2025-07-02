Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E235DC83F05
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwm3-0006uv-TE; Wed, 02 Jul 2025 08:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjJ-0004Ht-Hb
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:30 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwj4-00021y-W2
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:23 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2efc0ed41efso2059746fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459886; x=1752064686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6/XKkly86pfJIi7WG6IB145/8kk5JqWQO5Z6Z5XVuE=;
 b=d3bg/9H7U02E49kxmotdciKdbhapjvBn5azk/2xSVUeOv5tXdnwaLtGfBlDhJ3mPeu
 VLk/ml5uNKGuy3M71LTM/RXwQDQxUESYWs8Gi8/lsLMck9P5HWBtKFFy3gUTaA+8jRqa
 sOI2cZkdSdqZCq99C9W/dLv73J3TvuQB7li1vctZ+agCW8rDpZ23HQNMkOf//NiU8UkW
 Kfc8+Ie1PbmaI/2zyYQE1VrtvNXm6fovNGAkWQtaoAb5axyfDNwV7y/J5c8KenRq2dZZ
 US3Tf5u/RjMIlqhkJM4OSDzOCAz1HTUWcsPH97W4+F/PEdqpHhgrYI38J3DClrW6UPp5
 f04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459886; x=1752064686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6/XKkly86pfJIi7WG6IB145/8kk5JqWQO5Z6Z5XVuE=;
 b=Hdg9QQXEJICBPYUPfnn8uOqiFy/4tjsvcvUJFFJfirnO2RxKi46lUqgzEGC//3FCLN
 iBlXKjsdbOrWh2r8s0+LnaaS5Esi36j5V60OU+EqW45JiNJez+52IL8CFsd4W5CRS936
 Jl1YNSdbDDuNnuDVlYjp9t+eemTCAwY9/e4igIRGBmjTlW2nG0ryRg1TVN0oftUyi6hF
 J+S9/rr1oel/NksK8fbJTxNapeh5hiXaPnCr9I7hjLSl3m6QJM4+yejbSrqMm+IKf0AH
 8ks4ETFNMvNimFZCO/Wv6WNsUeJ+PxesEPary7Tm4IZgRx93gmj7m+wxD5YIOi9ylZ0e
 JUjg==
X-Gm-Message-State: AOJu0YzhMIzGQQ6mjTawMZOpAw4nWhg2l+PGlsj4wEQGqcYv93vJQSkU
 /4hwGVnxqaSb6o8F2yRR5NVE2eAGKywfccfpCN8ILsKgktgS2cYW2tgDnapMqhtUaZZPNdPk7ZB
 uI4m689s=
X-Gm-Gg: ASbGnctnk5ul6U5qNM4AFdvC5yWHpQ7hg8cSPAbokUrQit0by3+IAgVg+OzPOHqedzs
 o8NhpHOSpP6Jd/vS1v9VPEhnDMk6CEtTlcRzKwakld5hrz/x3sX9FZDgJceUct1JN9wdPdJuL6E
 0ws8bNatb2czjvcFLRIB8YqUFgY1/1rgU+/ITM/gqWKV1SIEtnoUTn2J78t3Sj9tQm/8tfEln8U
 JN/XypN4HlghEXTl1WSL/y3Nt11HMiOCyLy9mFUkC7//HI4+wlFHwBxKl+I+0UHE9Qpb+yhGP2g
 9qpaT9byaczW7t8jPGB5EuhnCK3X2Lo+j49jwvNvpVcsyTHr6O8fu5oPxAEXdw4aqvDb4A==
X-Google-Smtp-Source: AGHT+IFaTtHtOiv9wVDRhSsAPbmmYvz3D7f3MvwJtJ8be+F+NnXeRLmBGV3VOwlhXyANjh5I49bJYA==
X-Received: by 2002:a05:6870:418c:b0:2f5:2b87:416a with SMTP id
 586e51a60fabf-2f5aed18a8dmr1904473fac.37.1751459886486; 
 Wed, 02 Jul 2025 05:38:06 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 43/97] target/arm: Implement SME2 FCVT (widening), FCVTL
Date: Wed,  2 Jul 2025 06:33:16 -0600
Message-ID: <20250702123410.761208-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/helper-sme.h    |  2 ++
 target/arm/tcg/vec_internal.h  |  1 +
 target/arm/tcg/sme_helper.c    | 38 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve_helper.c    |  2 +-
 target/arm/tcg/translate-sme.c |  5 +++++
 target/arm/tcg/sme.decode      |  5 +++++
 6 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 97e70959e8..be4621f2d9 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -217,3 +217,5 @@ DEF_HELPER_FLAGS_4(sme2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvt_n, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvt_w, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index c8199a3ef8..bbf76f63b1 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -306,6 +306,7 @@ static inline float64 float64_maybe_ah_chs(float64 a, bool fpcr_ah)
 bfloat16 helper_sme2_ah_fmax_b16(bfloat16 a, bfloat16 b, float_status *fpst);
 bfloat16 helper_sme2_ah_fmin_b16(bfloat16 a, bfloat16 b, float_status *fpst);
 
+float32 sve_f16_to_f32(float16 f, float_status *fpst);
 float16 sve_f32_to_f16(float32 f, float_status *fpst);
 
 #endif /* TARGET_ARM_VEC_INTERNAL_H */
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index d97afdb69c..b0e1fe845b 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1591,3 +1591,41 @@ void HELPER(sme2_fcvtn)(void *vd, void *vs, float_status *fpst, uint32_t desc)
         d[H2(i * 2 + 1)] = d1;
     }
 }
+
+/* Expand and convert */
+void HELPER(sme2_fcvt_w)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    ARMVectorReg scratch;
+    size_t oprsz = simd_oprsz(desc);
+    size_t i, n = oprsz / 4;
+    float16 *s = vs;
+    float32 *d0 = vd;
+    float32 *d1 = vd + sizeof(ARMVectorReg);
+
+    if (vd == vs) {
+        s = memcpy(&scratch, s, oprsz);
+    }
+
+    for (i = 0; i < n; ++i) {
+        d0[H4(i)] = sve_f16_to_f32(s[H2(i)], fpst);
+    }
+    for (i = 0; i < n; ++i) {
+        d1[H4(i)] = sve_f16_to_f32(s[H2(n + i)], fpst);
+    }
+}
+
+/* Deinterleave and convert. */
+void HELPER(sme2_fcvtl)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+{
+    size_t i, n = simd_oprsz(desc) / 4;
+    float16 *s = vs;
+    float32 *d0 = vd;
+    float32 *d1 = vd + sizeof(ARMVectorReg);
+
+    for (i = 0; i < n; ++i) {
+        float32 v0 = sve_f16_to_f32(s[H2(i * 2 + 0)], fpst);
+        float32 v1 = sve_f16_to_f32(s[H2(i * 2 + 1)], fpst);
+        d0[H4(i)] = v0;
+        d1[H4(i)] = v1;
+    }
+}
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index b522ddaf7c..4f12723afe 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4554,7 +4554,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vg,                       \
  * FZ16.  When converting from fp16, this affects flushing input denormals;
  * when converting to fp16, this affects flushing output denormals.
  */
-static inline float32 sve_f16_to_f32(float16 f, float_status *fpst)
+float32 sve_f16_to_f32(float16 f, float_status *fpst)
 {
     bool save = get_flush_inputs_to_zero(fpst);
     float32 ret;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 10e5b77040..d6167eafe1 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1360,3 +1360,8 @@ TRANS_FEAT(FCVT_n, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_sme2_fcvt_n)
 TRANS_FEAT(FCVTN, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_sme2_fcvtn)
+
+TRANS_FEAT(FCVT_w, aa64_sme_f16f16, do_zz_fpst, a, 0,
+           FPST_A64_F16, gen_helper_sme2_fcvt_w)
+TRANS_FEAT(FCVTL, aa64_sme_f16f16, do_zz_fpst, a, 0,
+           FPST_A64_F16, gen_helper_sme2_fcvtl)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 831179c0ee..5100ebaeba 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -726,9 +726,14 @@ SUB_aaz_d       11000001 111 000010 .. 111 ...00 11 ...     @az_4x4_o3
 &zz_n           zd zn n
 @zz_1x2         ........ ... ..... ...... ..... zd:5        \
                 &zz_n n=1 zn=%zn_ax2
+@zz_2x1         ........ ... ..... ...... zn:5  .....       \
+                &zz_n n=1 zd=%zd_ax2
 
 BFCVT           11000001 011 00000 111000 ....0 .....       @zz_1x2
 BFCVTN          11000001 011 00000 111000 ....1 .....       @zz_1x2
 
 FCVT_n          11000001 001 00000 111000 ....0 .....       @zz_1x2
 FCVTN           11000001 001 00000 111000 ....1 .....       @zz_1x2
+
+FCVT_w          11000001 101 00000 111000 ..... ....0       @zz_2x1
+FCVTL           11000001 101 00000 111000 ..... ....1       @zz_2x1
-- 
2.43.0


