Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C5AC43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:46:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOG8-0006n5-9c; Thu, 02 Jul 2026 16:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFs-0006dW-IB
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:29 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFk-0000SA-U0
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:25 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8479f1a86ecso1576849b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783024998; x=1783629798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aznq3Uqs/3cRH7j/pqiSwXtYe8SCzSrfHOaWqIOhEVM=;
 b=Dx7f6hMSXXNAXoznZFi7cphx4BhqoqXJebtcUn5WCZpW4smDJY3LeDKCZN7MDVK2iu
 0jpocFfvkO8uJczWZfxxqxRI3bx2f5S625sN270JpQODiYnfdiIphxe2yvR+0bgjK230
 WltXm64FqRDjsTMjFlsvrWs1akSxviOEcvGlng+Ib604Opb41fqdcuUooqQ/EORBITrG
 HdIP4Z99XB59zQoFDIx3HPoRZCr9Mn5IfBTzskPwjsBlPV3xQ//+gz+ThvFnYKbFSKSC
 2LLpTyfsbtZx9VJe6uATABAO6sVcTIn7PBex7x6dH8uurWM+kg3T28QOWhGAR5D1EZcf
 l0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783024998; x=1783629798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aznq3Uqs/3cRH7j/pqiSwXtYe8SCzSrfHOaWqIOhEVM=;
 b=O2wtr+9z8BlbJwB8e5eC8wVW+ilAfin21QKcrd5qo7FCRtUTaty1YMGO2xoTEy4r67
 R/JAj+sedisWN4LE4PAO7KKSTDLJdsqoHRoYsyTUi8xrU1g4MN9H4gzRw4pV9psTqwYF
 GsqDiQGpvgSYVXlYBnrAIDg6CpXdkXcpox4XVMwHH3dfPmguJAjA+E8Ji0htHVbFQOiP
 pSqDaBJoJ/17wvXvoKEZd6bH2ztu9Ul4t8W3bAoj6XFm0OtEDRlvgliHCS0ToxUbwNB8
 xK7jd2lriGurqppVfUeH2LLiagcTWqiea39snddau9O24IJ298wwOLGdlnyxLJhZxr/r
 5UsA==
X-Gm-Message-State: AOJu0Yy8rMfre3l90lPN6x3bBnyGE7Ln5phbnXgvj/pVqLS1b1RqrbcE
 62I3nnNFySqj3JlaJf2QnefbJFpdAUfp8/F43pRycqrT2tmdcySmLaa7QfinUkwikapsaAZyyI5
 mwzvu
X-Gm-Gg: AfdE7cn9Z6ZrIV+NAaTjApkUJxutfv8at4udAOjyAYSMdB5K73f1WelmXBODqp+lifU
 MrKW8MshJNp/CMfmOh9oDDhclMpUfhUsz3Fva4pCoKw5Wq8Y/DsLhkGxK5oNGI0gNHrJ6btCQ3S
 HdLU6Ez/NX3fJBDQRyOft01ifFb62/1hzCwG9Zg5mEsaUmEmeMbtaqgjwBJ0mWtW0aFr6TNcngl
 wcqwmNFFXGT05sCSYg109Q0e+plcijmfI/+iEosbJzewOfoNfNrlhPyLk+gxHgr9Z/nJoLPsGWO
 xpVWMewk1u9dYK3GpZenLmQhG4nE5IjZPdhcxcbaeRhb0a+hEEbrU6tqWXripzpcJiiGsfvx603
 2VImxcwdy7HChL6UanpRxzDM60VO9vZXpHAmsUl5JFm3c/VXHRI2zxQ3rLeRc3a0DEY39Gy4s7c
 VuZwGc68t01Kx5dESyK/Dt8E96V56I+lO1KlNS6w7oyMiFN9uwKV4eJitI3+4Z
X-Received: by 2002:a05:6a00:414f:b0:835:41f3:f440 with SMTP id
 d2e1a72fcca58-847c50428a1mr6691310b3a.14.1783024997715; 
 Thu, 02 Jul 2026 13:43:17 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e921cd139sm1678941a12.23.2026.07.02.13.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 13:43:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 02/15] target/arm: Implement FMOP4 (non-widening) for
 float16
Date: Thu,  2 Jul 2026 13:43:01 -0700
Message-ID: <20260702204314.79224-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702204314.79224-1-richard.henderson@linaro.org>
References: <20260702204314.79224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/helper-sme-defs.h |  4 +++
 target/arm/tcg/sme_helper.c      | 42 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  8 ++++++
 target/arm/tcg/sme.decode        |  3 +++
 5 files changed, 62 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 5a45358318..eb5c574e59 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1797,6 +1797,11 @@ isar_feature_aa64_sme_f16f16_or_f8f16(const ARMISARegisters *id)
     return isar_feature_aa64_sme_f16f16(id) || isar_feature_aa64_sme_f8f16(id);
 }
 
+static inline bool isar_feature_aa64_sme_mop4_f16f16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_f16f16(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 9e1f09ce5b..ec7389d2ae 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -356,6 +356,10 @@ DEF_HELPER_FLAGS_5(sme2_sel_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
 DEF_HELPER_FLAGS_5(sme2_sel_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
 DEF_HELPER_FLAGS_5(sme2_sel_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32, i32)
 
+DEF_HELPER_FLAGS_5(sme_fmop4a_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sme_fmop4s_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sme_ah_fmop4s_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_5(sme_fmop4a_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme_fmop4s_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme_ah_fmop4s_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index b08d91e6de..c4d149f7f7 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2636,6 +2636,48 @@ void sme_mop4(void *vza, void *vzn, void *vzm, void *fn_opaque,
     }
 }
 
+static void inner_fmop4a_hh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float16 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = float16_muladd(*n, *m, *d, 0, fpst);
+}
+
+void HELPER(sme_fmop4a_hh)(void *vza, void *vzn, void *vzm,
+                           float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float16), inner_fmop4a_hh);
+}
+
+static void inner_fmop4s_hh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float16 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = float16_muladd(float16_chs(*n), *m, *d, 0, fpst);
+}
+
+void HELPER(sme_fmop4s_hh)(void *vza, void *vzn, void *vzm,
+                           float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float16), inner_fmop4s_hh);
+}
+
+static void inner_ah_fmop4s_hh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float16 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = float16_muladd(*n, *m, *d, float_muladd_negate_product, fpst);
+}
+
+void HELPER(sme_ah_fmop4s_hh)(void *vza, void *vzn, void *vzm,
+                              float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float16), inner_ah_fmop4s_hh);
+}
+
 static void inner_fmop4a_ss(void *vd, void *vn, void *vm, void *vinfo)
 {
     float32 *d = vd, *n = vn, *m = vm;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index aab5eab9df..d19cd274ac 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2025,6 +2025,14 @@ static bool do_mop4_fp(DisasContext *s, arg_mop4 *a, MemOp esz,
     return true;
 }
 
+static gen_helper_gvec_3_ptr * const fmop4_hh[3] = {
+    gen_helper_sme_fmop4a_hh,
+    gen_helper_sme_fmop4s_hh,
+    gen_helper_sme_ah_fmop4s_hh
+};
+TRANS_FEAT(FMOP4_hh, aa64_sme_mop4_f16f16,
+           do_mop4_fp, a, MO_16, FPST_ZA_F16, fmop4_hh)
+
 static gen_helper_gvec_3_ptr * const fmop4_ss[3] = {
     gen_helper_sme_fmop4a_ss,
     gen_helper_sme_fmop4s_ss,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 5a3d47cdfe..227f3d7790 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1094,7 +1094,10 @@ LUTI4_s_4b      1100 0000 1001 101     1 00 00 00 ....0 zd:5    \
 %mop4_zm        17:3 !function=times_2_plus_16
 %mop4_zn        6:3  !function=times_2
 
+@mop4_o1        .... .... ... m:1 .... .... .. n:1 ... . s:1 ... zad:1 \
+                &mop4 zm=%mop4_zm zn=%mop4_zn
 @mop4_o2        .... .... ... m:1 .... .... .. n:1 ... . s:1 .. zad:2 \
                 &mop4 zm=%mop4_zm zn=%mop4_zn
 
+FMOP4_hh        1000 0001 000. ...0 0000 00.. ..0. 100.         @mop4_o1
 FMOP4_ss        1000 0000 000. ...0 0000 00.. ..0. 00..         @mop4_o2
-- 
2.43.0


