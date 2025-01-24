Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D799DC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMdq-0000TQ-B6; Fri, 24 Jan 2025 11:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYz-0005fR-04
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:50 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYw-0005iI-0Y
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:43 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so23934575e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736180; x=1738340980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hq2s3IXVV8PkzL3MODbSyRBZT7eZFQL8olH5eQca4yA=;
 b=IvSPd9vf3cVr84dN8fnre8/vha11vLqMZsA6ND8brcC7+tB8dmY5T5RxMMIFaZaEUO
 SihFRzsxNi7LZnHuAsN6qp8fHxLsMLo2e3fC+7RTTz+dX6qidPmqiV9Vj/xhBAcLiDTe
 Bg8AmDnn5Gdek+E1hjQHjWOMBUx64IBX58OI0bLje7itHjvseJigZA2E0wBV0JTUIwY9
 VsWprj7fruunwbfOR36lRwbOvvlYgZVL/FBvwmft2WS1Lc3vsC20iCAJuuz9jT1wvytk
 wsdD8RRGDg2B9c2H4JswsKW2oZhLmhkho5BfO8zvcQBQsWTrhNFgOAA3i5PeoVb2PLd8
 wpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736180; x=1738340980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hq2s3IXVV8PkzL3MODbSyRBZT7eZFQL8olH5eQca4yA=;
 b=FNRuCg3wSNnMJMnvA6NHWCbhnfJ4CsDESazViFGk4ACY+wCwG1Yakt8rSFzgxGXduT
 j1Lm9qGMDYx+GGFBU5H6edhdMQexO+fnws8wmq9Z1l4jfmTR9wER+gq2Ig8SDXoL9B8F
 FyTRgmB0m7YjHdddVtVpyGJRkXtLUuyjUc+8LWeXv+ce85taHXvo5sG3J6OyKxypmi1H
 6yd4eexXN//302Bl3Acx5dkGpBhTtTHj7XnaoD9WyZm4o2PVjWD/JPMtK5pFrxsLhrVj
 3Z8ElHi3m8/j/dDiEgNQKSEi0MJNyvUMpdn8iGC+MqgqbclgbO+c2OOxfppL/XmpFcTu
 njsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX88BUGGBzOfn91OlHEiADGzCDoRTSK44mohnFmL72LEFP/iDaDwqQTZjv+Ysi+k/WdIk83z00uW65N@nongnu.org
X-Gm-Message-State: AOJu0Yx6il8lrxM9xGSMyYXxVSR2OeB87PbTzd5beOSzM/crOZBuMjN3
 aZtA3ehCGk2ZWRr8qiiAOqP7e3ygfjC8ovI+bxeU/rlpdOlk0oOrbBBbUZAGUfWQzZrWvYlMhgU
 v
X-Gm-Gg: ASbGncs7g1MvA8LDBu+UffgolhDC9nMOo31EvBZf/towAXLEVxPpCWpTDCQlI89kUP+
 CYnIxKzjHjmXhGVD8NCyU2JVcrQg4gpJSHHcEB+hOxtrfFggGjNYIksd9moO5lobermTB4TnyJ5
 zEHsYyC4gozFqurPNJfjCcv+OLE/1x+eRHlexhJEhxaXgaJyVdUr6bvBs2FzM56oJOGaIifKQO9
 /8Wv8vIWQCBvDE9FzTjrjHu2huY1UNHd5F7apwUTEwipKxVSRLztcKe0W+TKAON3LYh5rFFAGKp
 cPjSaBpUGiQ=
X-Google-Smtp-Source: AGHT+IGBGVmM5Wm3Nnt1PG1z/rDzV8FY3fe73vtLZRlXbLGXpOJI5l5115wD8jf8FQIYmwvOPIFg1w==
X-Received: by 2002:a05:600c:c0f:b0:42c:c28c:e477 with SMTP id
 5b1f17b1804b1-4389141c0a9mr263090115e9.23.1737736180490; 
 Fri, 24 Jan 2025 08:29:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 50/76] target/arm: Implement FPCR.AH semantics for SVE
 FMIN/FMAX immediate
Date: Fri, 24 Jan 2025 16:28:10 +0000
Message-Id: <20250124162836.2332150-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Implement the FPCR.AH semantics for the SVE FMAX and FMIN operations
that take an immediate as the second operand.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 14 ++++++++++++++
 target/arm/tcg/sve_helper.c    |  8 ++++++++
 target/arm/tcg/translate-sve.c | 25 +++++++++++++++++++++++--
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 7ca95b8fa94..3c1d2624ed4 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1231,6 +1231,20 @@ DEF_HELPER_FLAGS_6(sve_fmins_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_fmins_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, i64, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve_ah_fmaxs_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmaxs_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmaxs_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, fpst, i32)
+
+DEF_HELPER_FLAGS_6(sve_ah_fmins_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmins_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmins_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, fpst, i32)
+
 DEF_HELPER_FLAGS_5(sve_fcvt_sh, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvt_dh, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 3631d85f23a..2f6fc82ee4f 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4459,6 +4459,14 @@ DO_ZPZS_FP(sve_fmins_h, float16, H1_2, float16_min)
 DO_ZPZS_FP(sve_fmins_s, float32, H1_4, float32_min)
 DO_ZPZS_FP(sve_fmins_d, float64, H1_8, float64_min)
 
+DO_ZPZS_FP(sve_ah_fmaxs_h, float16, H1_2, helper_vfp_ah_maxh)
+DO_ZPZS_FP(sve_ah_fmaxs_s, float32, H1_4, helper_vfp_ah_maxs)
+DO_ZPZS_FP(sve_ah_fmaxs_d, float64, H1_8, helper_vfp_ah_maxd)
+
+DO_ZPZS_FP(sve_ah_fmins_h, float16, H1_2, helper_vfp_ah_minh)
+DO_ZPZS_FP(sve_ah_fmins_s, float32, H1_4, helper_vfp_ah_mins)
+DO_ZPZS_FP(sve_ah_fmins_d, float64, H1_8, helper_vfp_ah_mind)
+
 /* Fully general two-operand expander, controlled by a predicate,
  * With the extra float_status parameter.
  */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index effa23cefd7..214aec7f83b 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3821,14 +3821,35 @@ static bool do_fp_imm(DisasContext *s, arg_rpri_esz *a, uint64_t imm,
     TRANS_FEAT(NAME##_zpzi, aa64_sve, do_fp_imm, a,                     \
                name##_const[a->esz][a->imm], name##_fns[a->esz])
 
+#define DO_FP_AH_IMM(NAME, name, const0, const1)                        \
+    static gen_helper_sve_fp2scalar * const name##_fns[4] = {           \
+        NULL, gen_helper_sve_##name##_h,                                \
+        gen_helper_sve_##name##_s,                                      \
+        gen_helper_sve_##name##_d                                       \
+    };                                                                  \
+    static gen_helper_sve_fp2scalar * const name##_ah_fns[4] = {        \
+        NULL, gen_helper_sve_ah_##name##_h,                             \
+        gen_helper_sve_ah_##name##_s,                                   \
+        gen_helper_sve_ah_##name##_d                                    \
+    };                                                                  \
+    static uint64_t const name##_const[4][2] = {                        \
+        { -1, -1 },                                                     \
+        { float16_##const0, float16_##const1 },                         \
+        { float32_##const0, float32_##const1 },                         \
+        { float64_##const0, float64_##const1 },                         \
+    };                                                                  \
+    TRANS_FEAT(NAME##_zpzi, aa64_sve, do_fp_imm, a,                     \
+               name##_const[a->esz][a->imm],                            \
+               s->fpcr_ah ? name##_ah_fns[a->esz] : name##_fns[a->esz])
+
 DO_FP_IMM(FADD, fadds, half, one)
 DO_FP_IMM(FSUB, fsubs, half, one)
 DO_FP_IMM(FMUL, fmuls, half, two)
 DO_FP_IMM(FSUBR, fsubrs, half, one)
 DO_FP_IMM(FMAXNM, fmaxnms, zero, one)
 DO_FP_IMM(FMINNM, fminnms, zero, one)
-DO_FP_IMM(FMAX, fmaxs, zero, one)
-DO_FP_IMM(FMIN, fmins, zero, one)
+DO_FP_AH_IMM(FMAX, fmaxs, zero, one)
+DO_FP_AH_IMM(FMIN, fmins, zero, one)
 
 #undef DO_FP_IMM
 
-- 
2.34.1


