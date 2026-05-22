Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD323CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXzO-0002J6-8C; Fri, 22 May 2026 18:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXy5-0007pX-Rr
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:55 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXy1-0008Np-UM
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:44 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-36a35e4eefeso1935303a91.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487418; x=1780092218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9uX8NoWKwP9a9B5vn4qVOFP1Yc4reVtYrzDFJuHRuxc=;
 b=zAc/DuQBzOVR/16E5gQUDT2vpl8NfTR+ictB/iMGyB+WPt38V6PLYp+uhNtK8N2A5+
 /1rrE712Qr2EWK7h3F2OHJBYFFx6IbYj6Cyc8E72sea9bWa2LTK9UuW6l/sXHve1eJSt
 3AK1OdbghDw8jTMEa0JzGn93q2XgOhM1ZWMIMN0U5rxxVYr9wKNuC2gp7HZixGAiDlu+
 HfyY/EK3GCZyNLVDeaklhpCZ8nswgnVZXeIXSL2gbH/3rsQYfJ/lQNGD/UiYjXLMXxth
 7MqXiCqeffR/fxaKhU3LAfkxU5fM3JbkAm9vfvtvhaOppL2MEgxYbRWdO+ePGhWlP5iJ
 9+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487418; x=1780092218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9uX8NoWKwP9a9B5vn4qVOFP1Yc4reVtYrzDFJuHRuxc=;
 b=SJEEKv2VIXnZsNHqBC5jsl8WwEXOXxGC83+veLraLGmCOeU7qfa2/typ6np6bQAumk
 O1N472ceMvPS3SqsAR/JWesDgTc1xjcKD0tg7apTwUaad4nAK7bWRlU7ZUmoA8gM6xnH
 iiJ1TwtcwmtsByHO25l2QHIy10K4HpKJJfkkPuTggYSFu7/kUH2lK13b6JCW6cvS4N2q
 WO4DuZllijXdfOir8Jdy4FxVRVGQJXjS0kXE99QhxSDBa4wHvY2G4CXLyXEcB1nytuy8
 WKWM4yvl15OyiqEazqYlzgLOpZcMZuBuGWCGgtgQO2eiYH6uY+l5HeFxMXCcgEtyBZxs
 WKVQ==
X-Gm-Message-State: AOJu0YwtI2DoRs//4Cbs2f7vAvfGi9hlP4k3B8Z1+vPQoTjcJ7NvqnWT
 oPwGROkDUXwnTcsKBGEqkC7ordNu+NjbH173ek4q3aruWeZo/EuCcj1BnLo8Tk8uz9s4TaBgkjp
 hExYh
X-Gm-Gg: Acq92OEHjwqYwSYOIzAle335HfVxKSEb+8tpKbkYvzQ8LJyKqt4nhOtDN0pKN2gDEnQ
 ICQRINR2WfpJ33JVELC30m4+P0j4Rfh7PY1jW9RGf6vXmTnXBD6ZMEE3AJ6ERYJ1kCRk8ZT2NqY
 1BzE6wv2GBSfx6UfxJdvUxkxK2dgvbPz8NMjfISIXTHkjWzrDpfR9WVtRPsKL4vdzsnfZ6a+ICz
 BbbmzE2D84OiE9PF1bJAT7GnLbjRQBfq0NdfL3sHeCp6uEtpqb6Xy3Nz1xmqDOtj7dRaTM7HcMs
 cAmNTTxiarn4mmhd7me22oOGXfRvSCldep+pYFCSoZg3VVgkGGgzqoGxAx0S/TfSmophlLD0zSU
 yrWfqNUH3WeQ0RIZFp8zxfrNUC4NmaWVYezqIj61XP+Wwu+ed4cs17iMgylCwbA8i0haPI+QqUX
 sayIWhh6g9H1FnpkMjMfMxhexgvZot
X-Received: by 2002:a17:90b:5785:b0:369:1dcf:4a46 with SMTP id
 98e67ed59e1d1-36a67649211mr5043261a91.25.1779487418332; 
 Fri, 22 May 2026 15:03:38 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 31/64] target/arm: Implement F1CVT, F1CVTLT, F2CVT,
 F2CVTLT for SVE
Date: Fri, 22 May 2026 15:02:33 -0700
Message-ID: <20260522220306.235200-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 16 ++++++++++++++++
 target/arm/tcg/translate-sve.c   |  9 +++++++++
 target/arm/tcg/sve.decode        |  5 +++++
 4 files changed, 31 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 718463422b..3021dafd44 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -9,3 +9,4 @@ DEF_HELPER_FLAGS_4(sme2_bfcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(advsimd_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 0f3c279696..75c89203fe 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -168,6 +168,22 @@ void HELPER(sve2_bfcvt)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     fp8_cvt_finish(env, &ctx);
 }
 
+void HELPER(sve2_fcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0xf);
+    fp8_input_fn *input_fmt = fp8_input_fmt[ctx.f8fmt];
+    uint8_t *n = vn;
+    uint16_t *d = vd;
+    size_t nelem = simd_oprsz(desc) / 2;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        d[H2(i)] = fcvt_fp8_to_f16(n[H1(2 * i + ctx.high)],
+                                   input_fmt, ctx.scale, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+}
+
 void HELPER(sme2_bfcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index dc832dfd93..18a69013fc 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4081,6 +4081,15 @@ static bool do_f8cvt(DisasContext *s, arg_rr_esz *a,
     return true;
 }
 
+TRANS_FEAT_STREAMING_SME2(F1CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+                          gen_helper_sve2_fcvt_hb, false, false)
+TRANS_FEAT_STREAMING_SME2(F2CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+                          gen_helper_sve2_fcvt_hb, true, false)
+TRANS_FEAT_STREAMING_SME2(F1CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+                          gen_helper_sve2_fcvt_hb, false, true)
+TRANS_FEAT_STREAMING_SME2(F2CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+                          gen_helper_sve2_fcvt_hb, true, true)
+
 TRANS_FEAT_STREAMING_SME2(BF1CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
                           gen_helper_sve2_bfcvt, false, false)
 TRANS_FEAT_STREAMING_SME2(BF2CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index e7984fa8e0..ca110f4bc1 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1091,6 +1091,11 @@ FMINQV          01100100 .. 010 111 101 ... ..... .....         @rd_pg_rn
 FRECPE          01100101 .. 001 110 001100 ..... .....          @rd_rn
 FRSQRTE         01100101 .. 001 111 001100 ..... .....          @rd_rn
 
+F1CVT           01100101 00 001 000 001100 ..... .....          @rd_rn_e0
+F2CVT           01100101 00 001 000 001101 ..... .....          @rd_rn_e0
+F1CVTLT         01100101 00 001 001 001100 ..... .....          @rd_rn_e0
+F2CVTLT         01100101 00 001 001 001101 ..... .....          @rd_rn_e0
+
 BF1CVT          01100101 00 001 000 001110 ..... .....          @rd_rn_e0
 BF2CVT          01100101 00 001 000 001111 ..... .....          @rd_rn_e0
 BF1CVTLT        01100101 00 001 001 001110 ..... .....          @rd_rn_e0
-- 
2.43.0


