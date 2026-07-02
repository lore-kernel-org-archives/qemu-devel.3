Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5708CC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOG9-0006of-C4; Thu, 02 Jul 2026 16:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFy-0006ic-4w
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:34 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFs-0000TI-Em
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:33 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-847a52edeb2so1740177b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783025001; x=1783629801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HH5Mv8QRP8On6VgPjyu1U5Lu1U9nhrHmAjbFLx0vPD8=;
 b=zTezFSDikUQvGYLCelgy5xYWY3jYajoArkgXEgCKFBiECRidbAw3f/e/A+OW5GfGk1
 VGnOAh84hm8GoLsQ0lvggQn8liD7EhNhwgHF08CwzK/T5Qs27jl3u/oPQRu2uzadPptc
 3J/en/l1Qb6zL31zP+mdjCQin2IiIvJNGkZSN7nuJnTW8rcy9EKeM82KAZvPefQeMfRT
 nf+CkX11Hx0/lhsC+VxZyW+0FbK98fvli8+/KLFsCpnymMraX+lujQz3HSSPCWM5pSxJ
 bYXFDHaU1sXiU9ujAkQUxaybll31qIZL8rEzSkPaojyGqPzouLepGOyUauxj3ngvnGfF
 Gu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783025001; x=1783629801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HH5Mv8QRP8On6VgPjyu1U5Lu1U9nhrHmAjbFLx0vPD8=;
 b=XT4WBAu8BO1gGNJvjvHm736Tx81ZbtsVJ/FL9JuMR8nb2oP/ikQPYadh0vG0qcXwjm
 SRBrAzJ8l+X8kRT3CHLGyyArEj7JxdN/wZ0lYUGv0TPrCglor3C24pdMyelAkcBPXMlg
 VCpYmL1+IfaZ/PuNTXYEVeOu0kleGhxfHVAFvr+Ak2qBXjt5wdidCDufkCkERMXY4N5v
 +fHKoRtT1G6JmoDQ8ai4lSQcDmTnPIyyyCpgv3VIZlOddYzh9Re1d31V3VbCB3wccqn8
 Ky04tISV3Fy5KZ2cR7AtIkgm1hyzpU1B0bM0s5XZst31vCbPcmU1z2PcmrtQY5MNr3zX
 9u7g==
X-Gm-Message-State: AOJu0YwgqskBV+IxkRyV/q1ll7Isa+iZyLWI7sWnh0LAzMh13F3kEqeq
 +1Txb4jss4cwnPaaPFWR6YCMZoRNIBipEPZehMdZKCGGXE3ypSxeRmH4wVe2RJk/z7pE1K/UuJ+
 gMWfN
X-Gm-Gg: AfdE7cl2L8Jd1cYNzjPFGpNe1u8Fs60xdL2PMokqfU3Gvm7qv6hFfLKANBXRtKeWj7m
 tdAOgiGoM+6kiVRiJS63nsJC5s5r26jq3Bl/TgSt56BkNbsFcU3Yi5mn6NtldwioEdXQudCBN2r
 oQZPvhEMPzqWIwjh2eOoVDQkTO4tyg1DGqIyD5KG6JHNHGdlFlA20NyGiMzXUaJ/S8EMrUYoqS4
 sR+xzqMGAKw4HK48MsaOvIOKs33KtpEI4tqL/DoT6/2ER9qTWWME0CrKAii9079iXIh2UmEFfue
 YOqTqKYLlKESTDq9uGLDQQ3b4ay5NSlajU9YMG45EJUtk6kjjcjZIeYMRd989WF2h4k2dMKJ0lE
 qmTE6wdLu/RdScQUbOy/E7xC/biqRxJlt+y8aSSWP1UowQ3SdvubOPoMPnkW3sH9x3A/SLyuZas
 3wlCdl/j3DtqIhkqnRbW5lq9DDj0E5NH4CR8IEdeaTV6Fl4GUWOQ==
X-Received: by 2002:a05:6a00:130f:b0:847:70cd:395a with SMTP id
 d2e1a72fcca58-847c0a08212mr7255572b3a.59.1783025001179; 
 Thu, 02 Jul 2026 13:43:21 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e921cd139sm1678941a12.23.2026.07.02.13.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 13:43:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 06/15] target/arm: Implement FMOP4 (widening,
 2-way fp16 to fp32)
Date: Thu,  2 Jul 2026 13:43:05 -0700
Message-ID: <20260702204314.79224-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702204314.79224-1-richard.henderson@linaro.org>
References: <20260702204314.79224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 target/arm/tcg/helper-sme-defs.h |  4 +++
 target/arm/tcg/sme_helper.c      | 51 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  7 +++++
 target/arm/tcg/sme.decode        |  1 +
 4 files changed, 63 insertions(+)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 0e4bb12b38..780b8f162a 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -375,3 +375,7 @@ DEF_HELPER_FLAGS_5(sme_ah_bfmop4s_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst
 DEF_HELPER_FLAGS_5(sme_bfmop4a_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(sme_bfmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(sme_ah_bfmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(sme_fmop4a_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(sme_fmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(sme_ah_fmop4s_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 5a661ca616..123f459342 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2887,3 +2887,54 @@ void HELPER(sme_ah_bfmop4s_sh)(void *vza, void *vzn, void *vzm,
              is_ebf(env, &fpst) ? inner_ebf_ah_bfmop4s_sh
                                 : inner_ah_bfmop4s_sh);
 }
+
+static void inner_fmop4a_sh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    CPUArchState *env = vinfo;
+
+    *d = f16_dotadd(*d, *n, *m,
+                    &env->vfp.fp_status[FPST_ZA_F16],
+                    &env->vfp.fp_status[FPST_ZA]);
+}
+
+void HELPER(sme_fmop4a_sh)(void *vza, void *vzn, void *vzm,
+                           CPUArchState *env, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, env, desc, sizeof(float32), inner_fmop4a_sh);
+}
+
+static void inner_fmop4s_sh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    CPUArchState *env = vinfo;
+
+    *d = f16_dotadd(*d, *n ^ 0x80008000u, *m,
+                    &env->vfp.fp_status[FPST_ZA_F16],
+                    &env->vfp.fp_status[FPST_ZA]);
+}
+
+void HELPER(sme_fmop4s_sh)(void *vza, void *vzn, void *vzm,
+                           CPUArchState *env, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, env, desc, sizeof(float32), inner_fmop4s_sh);
+}
+
+static void inner_ah_fmop4s_sh(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float32 *d = vd;
+    uint32_t *n = vn, *m = vm;
+    CPUArchState *env = vinfo;
+
+    *d = f16_dotadd(*d, f16mop_ah_neg_adj_pair(*n, -1), *m,
+                    &env->vfp.fp_status[FPST_ZA_F16],
+                    &env->vfp.fp_status[FPST_ZA]);
+}
+
+void HELPER(sme_ah_fmop4s_sh)(void *vza, void *vzn, void *vzm,
+                              CPUArchState *env, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, env, desc, sizeof(float32), inner_ah_fmop4s_sh);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index df4a5c2125..544a825595 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2065,3 +2065,10 @@ static gen_helper_gvec_3_ptr * const bfmop4_sh[3] = {
     gen_helper_sme_ah_bfmop4s_sh
 };
 TRANS_FEAT(BFMOP4_sh, aa64_sme_mop4, do_mop4_fp, a, MO_32, FPST_ENV, bfmop4_sh)
+
+static gen_helper_gvec_3_ptr * const fmop4_sh[3] = {
+    gen_helper_sme_fmop4a_sh,
+    gen_helper_sme_fmop4s_sh,
+    gen_helper_sme_ah_fmop4s_sh
+};
+TRANS_FEAT(FMOP4_sh, aa64_sme_mop4, do_mop4_fp, a, MO_32, FPST_ENV, fmop4_sh)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 12a3a61432..ea9f459e38 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1107,3 +1107,4 @@ FMOP4_ss        1000 0000 000. ...0 0000 00.. ..0. 00..         @mop4_o2
 FMOP4_dd        1000 0000 110. ...0 0000 00.. ..0. 1...         @mop4_o3
 
 BFMOP4_sh       1000 0001 000. ...0 0000 00.. ..0. 00..         @mop4_o2
+FMOP4_sh        1000 0001 001. ...0 0000 00.. ..0. 00..         @mop4_o2
-- 
2.43.0


