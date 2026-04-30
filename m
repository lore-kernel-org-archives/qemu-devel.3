Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4337FF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIFAO-0007Vd-5L; Wed, 29 Apr 2026 20:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFAG-00070m-2I
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:22:00 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFAD-0006Sf-1X
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:58 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82d0b68837aso190861b3a.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508516; x=1778113316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3WDr3PayIu/5R0rkFaPoO898PHb8bgqDCx/yK/Nmp/A=;
 b=VF4vbaEFHCi2X0ZP332Ta2iHX/6R4MJB7xC+5ZoT6LdYs0SgM1RHnBCf3KfNkg02NB
 +T1iuRgOyzDz9joHIK08hWeLptoCKzZbym/0Dd/BJBwIy9u7hTcpkfYhKGSyzxULMZAx
 VUX5XJzaW40+m6VcA5Cy6NIAGH/D/s3UuisE2KILJm9sQRYTPIK4SvMWvB0HCzHi2xQI
 1p9QwM38dCVIGOMag2sz8m9SJBJTvs5mYEKvx+95BvXYUXKmi10kFDxVR9A9nA4DlE+/
 ofGvH+pC1xp8T6RU5opQGJwzTH7NWtg+AQH6V2x85iz7UCyKUuYrWqgSsYGMY/iw/iZI
 DlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508516; x=1778113316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3WDr3PayIu/5R0rkFaPoO898PHb8bgqDCx/yK/Nmp/A=;
 b=QqZOuDVxNxSDNnkv5aadShzYgnajSh67UbIQKCV9Z89/o5YqajE2R6Zg/IbmgerKYK
 5mL5ygg9Pt4ovJV6SqQC0edgbzBacqK12JQKL4V5q2pfo2MGc1rNh7OydmoU/ax/l7vQ
 nSyVpFUmOyWcIToqjbrmlxBKkJBHspG/0KRxf2lztZd2WsqzpIr8XeCyfphBPSRHF1/A
 foXMBnb1znf0EqrgvO22JaQ+9ZqD5TROlFlFfTaojlq2Wce2d9nak8xhCeyrHudx6rfP
 DeMsPN9tWT1heBedTFdYCTQP3QTQzm6o50OPz72dwkw9ANIWgi2Dw0qu1l2x/eFxM3Av
 GCcQ==
X-Gm-Message-State: AOJu0YzOB80wdZkY2mW0y8zmlMhR86ePnGB8UaS98L6BZaN1njOpHD6u
 8ODU/AWb//aTe1oi4Klg8uDEOOv5l70YivbU+/wQZ7wOG1zCvJ3/ot9k8PoorzL+KvR0kDIOv0G
 aDW1ZhIo=
X-Gm-Gg: AeBDievyMlNU0bk485qFW539+d7CHGMfzAX8ejgPXwUXAwhhFtttSuF6JuuPK90WbbL
 AlTH+7B6YuLulkSyUXpnZ0jdTVE+R/wf8I3Yn/OeuUFlUjaQR93urKS1T8A7hllBYJtI5pekmzA
 vF4hTX8STfpIM7heHgmkcQNJrAnbiouUXBedPdA7BR1fBN4lzZaaD2hDIb/1ITXMlNLV3Ih04fR
 YfsOS5moWIxTP6lJ4IkMT0+dTQpKxSFXnih8RkZ6xHmgHkfAUo5RdXrEXiK9c+xFtPws+039Kpp
 azxfHBNRwOf3iYEJEZagTscVUppi683mIN71uJwU0C6M6JwhTMg/OcQIOKgZSNr97SowwoJhP2L
 HkdkraRT47Zi2XLMbUysIb/rjD821NFQE2125/rnU+G2C+mwEePEaSU/FITcXNk8ARHSMU3hP9W
 LNSl6CdJeYGXZjwJ3as+TICTz/JQPIVi9j0wIOw/nF
X-Received: by 2002:a05:6a00:22cc:b0:82a:6852:559e with SMTP id
 d2e1a72fcca58-834fdb29691mr934488b3a.12.1777508515534; 
 Wed, 29 Apr 2026 17:21:55 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:21:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 29/47] target/arm: Implement FCVTN (16- to 8-bit fp) for
 AdvSIMD
Date: Thu, 30 Apr 2026 10:20:28 +1000
Message-ID: <20260430002046.59739-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 target/arm/tcg/helper-fp8-defs.h |  2 +
 target/arm/tcg/fp8_helper.c      | 66 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   | 15 ++++++++
 target/arm/tcg/a64.decode        |  2 +
 4 files changed, 85 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index bbc8d69e28..6530d1a6da 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -14,3 +14,5 @@ DEF_HELPER_FLAGS_4(sme2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(sve2_bfcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fcvt_bh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 4270e13a8e..9658eeac8d 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -187,6 +187,24 @@ static float8_e5m2 fcvt_b16_to_fp8e5m2(bfloat16 x, int scale,
     return float8_e5m2_round_pack_canonical(&p, s, saturate);
 }
 
+static float8_e4m3 fcvt_f16_to_fp8e4m3(float16 x, int scale,
+                                       bool saturate, float_status *s)
+{
+    FloatParts64 p = float16_unpack_canonical(x, s);
+
+    p = parts64_scalbn(&p, scale, s);
+    return float8_e4m3_round_pack_canonical(&p, s, saturate);
+}
+
+static float8_e5m2 fcvt_f16_to_fp8e5m2(float16 x, int scale,
+                                       bool saturate, float_status *s)
+{
+    FloatParts64 p = float16_unpack_canonical(x, s);
+
+    scalbn_to_fp8e5m2(&p, scale, saturate, s);
+    return float8_e5m2_round_pack_canonical(&p, s, saturate);
+}
+
 void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
@@ -502,3 +520,51 @@ void HELPER(sve2_bfcvtn_bh)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_finish(env, &ctx);
 }
+
+void HELPER(gvec_fcvt_bh)(void *vd, void *vn, void *vm,
+                          CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc);
+    uint16_t *n = vn;
+    uint16_t *m = vm;
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+    ARMVectorReg scratch;
+
+    if (vd == vm) {
+        m = memcpy(&scratch, vm, oprsz);
+    }
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            float16 e = n[H2(i)];
+            d[H1(i)] = fcvt_f16_to_fp8e5m2(e, ctx.scale, osc, &ctx.stat);
+        }
+        for (size_t i = 0; i < nelem; ++i) {
+            float16 e = m[H2(i)];
+            d[H1(i) + nelem] =
+                fcvt_f16_to_fp8e5m2(e, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float16 e = n[H2(i)];
+            d[H1(i)] = fcvt_f16_to_fp8e4m3(e, ctx.scale, osc, &ctx.stat);
+        }
+        for (size_t i = 0; i < nelem; ++i) {
+            float16 e = m[H2(i)];
+            d[H1(i) + nelem] =
+                fcvt_f16_to_fp8e4m3(e, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    default:
+        float8_invalid_output(d, oprsz, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 565053a1a4..0927eb6516 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6522,6 +6522,21 @@ static gen_helper_gvec_3_ptr * const f_vector_fscale[3] = {
 };
 TRANS_FEAT(FSCALE, aa64_f8cvt, do_fp3_vector, a, 0, f_vector_fscale)
 
+static bool trans_FCVTN_bh(DisasContext *s, arg_qrrr_e *a)
+{
+    if (!dc_isar_feature(aa64_f8cvt, s)) {
+        return false;
+    }
+    if (fpmr_access_check(s) && fp_access_check(s)) {
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, a->q ? 16 : 8, vec_full_reg_size(s),
+                           FPST_A64 << 2, gen_helper_gvec_fcvt_bh);
+    }
+    return true;
+}
+
 static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
 {
     if (fp_access_check(s)) {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 26d31d0a33..71456d44e1 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1201,6 +1201,8 @@ FAMIN           0.10 1110 1.1 ..... 11011 1 ..... ..... @qrrr_sd
 FSCALE          0.10 1110 110 ..... 00111 1 ..... ..... @qrrr_h
 FSCALE          0.10 1110 1.1 ..... 11111 1 ..... ..... @qrrr_sd
 
+FCVTN_bh        0.00 1110 010 ..... 11110 1 ..... ..... @qrrr_h
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
-- 
2.43.0


