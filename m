Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674DFC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggij-0007Hv-Ci; Mon, 06 Jul 2026 06:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggif-0007E4-WE
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:34 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggie-0003Ue-0p
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:33 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so19616225e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334311; x=1783939111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OZnBonC4QH+1tQ9Nd+N4BbfpyRgjS2deaEmDcHEFx44=;
 b=GpVx9Mm5/jONnnDbkYwFiTc9ddZzoMPs+pzvJdSRbxcFGx/KRWmfyfBjBBdCP2jdvr
 sfSkzy2hcLCPLsNw5JV415seXaMOXG0c2kveT00s7mgNfEx8CnNoT3yUiIq2VjZHFBF1
 cbIhH1BOaATnKQhQghLUB1GXb3AcRSC9KgTr3AYup9d7uwiT6hGUy/Ybn643mnFiC3a7
 Bbo+ZcEal3rsO6yqD6avakxupt4m3grL89RzOK1nQAo8oAFJXj8m/EOW5BZQVUYcnTPg
 rblkuaTTwW++lC8xCHSZkqNkeZidSUPwJZ798RHcB2vRnEdNpgkJkZIOFxMr3kjJSEcV
 EWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334311; x=1783939111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OZnBonC4QH+1tQ9Nd+N4BbfpyRgjS2deaEmDcHEFx44=;
 b=rAGvq1jDt9ppUbZmu4wzleKuQ+Isp6Z7/l20ilfYamtVQivOzRihcZVpA3ua7CP8Kj
 sZlA6RZzmXByjn8mTKN54BiA8hIyE1xwJdTabKeTS6FhFqz0skcko3q1yiC2wi24u2P/
 sxMkJJM6NOWqg5LwOxUc+Bss++0xtRAYLW/b9o6zI7wPgHZ3pc5VqWC8SWu/HtVPWQXN
 iZcvSBIGbYMztz+fCK4CK1cXXQX0ZO1sHo6mu1XfAYMWRbF+AB1ICXarbha3Fc9BzNzX
 ZiCeNHlDB1QKNEBkHwZkjJD4YIBR31+80YzXKNc2WEbbTwAEanKS7Dilp8UfzPimseWQ
 dYIw==
X-Gm-Message-State: AOJu0YyNjfadmNWd3qwabyRYl7J83OR05O5kKpxi+7JXc+M1y/8YQzQf
 E5kzEI5hO2Ufu9cte6IBHd+seHNpSnZty67vcbX7t4cl7LwZnHALags5mV10vtBlI4JbFKipmHb
 TE8ifacWSIg==
X-Gm-Gg: AfdE7cnj5VKwFLYIpmSLAE2Azr4rrla/qxbk2BqvVl68SEWYKOkEpG23+JCovCS5gXV
 o95ArLh2/yd4/zfspRxC8jBwWydGInpm8o1TwW14w2ZbRdnO/eSY2EXVFN9IPpmWg7vDc1Ef5rh
 Ayc/35VUlDVgvfc/VOBJo9exhq6LKRFP4ik9YpYA2VSH+EKY8jocBZYHqZ4IaJM8obI8SM8uTPj
 laM1MUWKo0IZq1z92ps5d66KfZLPydpRp6sXYs1a15b7pZzVtHk8gt19ITwcxzPKDUJVV65KkBZ
 karvYEeO1cn/JugK59fOw/POaJvZGSxf8D/JfrcGPfxEVxbZC0taTNJD78OjCeAzNvyeClB2y+R
 HqomJFYK2mtcvOnJ84KR8IPIrPJMLN7JH7lhF3oX3MbJkBpoVj4hYpDnllBwpJr6PjIKb/diZTO
 /YGYlkF8xZIm9AVT+JICKNd0OPNibShK/dWatfLoSrbWZL7x6Z6VDUuBlu3vSmTrug4qDRUowkh
 8GiSmCra/yDFXx+ThcfkQ==
X-Received: by 2002:a05:600c:3f0a:b0:493:bfad:9d99 with SMTP id
 5b1f17b1804b1-493d11db690mr104942445e9.13.1783334310515; 
 Mon, 06 Jul 2026 03:38:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/49] target/arm: Implement FMOP4 (non-widening) for float64
Date: Mon,  6 Jul 2026 11:37:36 +0100
Message-ID: <20260706103752.320511-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260702204314.79224-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h        |  5 ++++
 target/arm/tcg/helper-sme-defs.h |  4 +++
 target/arm/tcg/sme.decode        |  3 +++
 target/arm/tcg/sme_helper.c      | 42 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  8 ++++++
 5 files changed, 62 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index a1a4f37277..a07151e634 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1812,6 +1812,11 @@ static inline bool isar_feature_aa64_sme_mop4_f16f16(const ARMISARegisters *id)
     return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_f16f16(id);
 }
 
+static inline bool isar_feature_aa64_sme_mop4_f64f64(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_mop4(id) && isar_feature_aa64_sme_f64f64(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index ec7389d2ae..8a2ff88d49 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -363,3 +363,7 @@ DEF_HELPER_FLAGS_5(sme_ah_fmop4s_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst,
 DEF_HELPER_FLAGS_5(sme_fmop4a_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme_fmop4s_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sme_ah_fmop4s_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sme_fmop4a_dd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sme_fmop4s_dd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sme_ah_fmop4s_dd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 227f3d7790..3b7d8e9430 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1098,6 +1098,9 @@ LUTI4_s_4b      1100 0000 1001 101     1 00 00 00 ....0 zd:5    \
                 &mop4 zm=%mop4_zm zn=%mop4_zn
 @mop4_o2        .... .... ... m:1 .... .... .. n:1 ... . s:1 .. zad:2 \
                 &mop4 zm=%mop4_zm zn=%mop4_zn
+@mop4_o3        .... .... ... m:1 .... .... .. n:1 ... . s:1 . zad:3 \
+                &mop4 zm=%mop4_zm zn=%mop4_zn
 
 FMOP4_hh        1000 0001 000. ...0 0000 00.. ..0. 100.         @mop4_o1
 FMOP4_ss        1000 0000 000. ...0 0000 00.. ..0. 00..         @mop4_o2
+FMOP4_dd        1000 0000 110. ...0 0000 00.. ..0. 1...         @mop4_o3
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index c4d149f7f7..81ec7ccfa1 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2719,3 +2719,45 @@ void HELPER(sme_ah_fmop4s_ss)(void *vza, void *vzn, void *vzm,
 {
     sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float32), inner_ah_fmop4s_ss);
 }
+
+static void inner_fmop4a_dd(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float64 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = float64_muladd(*n, *m, *d, 0, fpst);
+}
+
+void HELPER(sme_fmop4a_dd)(void *vza, void *vzn, void *vzm,
+                           float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float64), inner_fmop4a_dd);
+}
+
+static void inner_fmop4s_dd(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float64 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = float64_muladd(float64_chs(*n), *m, *d, 0, fpst);
+}
+
+void HELPER(sme_fmop4s_dd)(void *vza, void *vzn, void *vzm,
+                           float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float64), inner_fmop4s_dd);
+}
+
+static void inner_ah_fmop4s_dd(void *vd, void *vn, void *vm, void *vinfo)
+{
+    float64 *d = vd, *n = vn, *m = vm;
+    float_status *fpst = vinfo;
+
+    *d = float64_muladd(*n, *m, *d, float_muladd_negate_product, fpst);
+}
+
+void HELPER(sme_ah_fmop4s_dd)(void *vza, void *vzn, void *vzm,
+                              float_status *fpst, uint32_t desc)
+{
+    sme_mop4(vza, vzn, vzm, fpst, desc, sizeof(float64), inner_ah_fmop4s_dd);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index d19cd274ac..b6c49b9993 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2039,3 +2039,11 @@ static gen_helper_gvec_3_ptr * const fmop4_ss[3] = {
     gen_helper_sme_ah_fmop4s_ss
 };
 TRANS_FEAT(FMOP4_ss, aa64_sme_mop4, do_mop4_fp, a, MO_32, FPST_ZA, fmop4_ss)
+
+static gen_helper_gvec_3_ptr * const fmop4_dd[3] = {
+    gen_helper_sme_fmop4a_dd,
+    gen_helper_sme_fmop4s_dd,
+    gen_helper_sme_ah_fmop4s_dd
+};
+TRANS_FEAT(FMOP4_dd, aa64_sme_mop4_f64f64,
+           do_mop4_fp, a, MO_64, FPST_ZA, fmop4_dd)
-- 
2.43.0


