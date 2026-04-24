Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22167FB44A4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8DM-0002Jg-3L; Fri, 24 Apr 2026 00:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8DD-0001NR-MC
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:19 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8DB-0003Sy-J1
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:19 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-40427db1300so5595063fac.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005136; x=1777609936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCib0BGYEL+yIv2p4qc75g1dc9HJbacYoxAIh15CdAM=;
 b=MPHFMMejCNzIDvlBmvFYp/CIiflHUvQ2KxwYeBZfkCD8i72kc8AJzRbKrk5z2nH9EI
 JD5S+1Kk5V6N0IpgOyj8vsj2E7qPhxgec5Dd4rP2ypjPjv9o6qIbeKB63y7wm2aITlm3
 jEV0Tu3nSGaolmbi51XRXZVG3OQ9tCSXkYkPlqznmIqbJOpCivPL20X0V5sdsCFFgJQw
 G10D4Z3LjajqNuVljsxXPTA17i8Lf4Kq8sH40HawwHxK4sbzByZfJ39PEPRVo4AMq7aG
 PWE0dyUpv7QIF4Xth3Jm1Eh5vnoQZM0div+jDck57jF61jnjcuYqQ7KFzf5/eeydQd2p
 WsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005136; x=1777609936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MCib0BGYEL+yIv2p4qc75g1dc9HJbacYoxAIh15CdAM=;
 b=TA9FLvDwKGjfo+y19UW9iQu8tTVdY29l5XM6Kq9U1jZ11MTzTGcGOhKX6cehjpdLGk
 04JzuQy7LJgpIZXQDl0KjQ8Rg1IY8CYKAaKZMzOu6GTD3xQfp5ctEh3l3TIMzIoLirCc
 dMno3wMtO+Fa/OKpNl1yKbVJInbhecY3ailqis/EWRgSLUbAmbeqFuDvI9Hk6I7HftTe
 1TT1icMM+3aInycjgZ+Ov4CBdKYs3iNjgMM6I2nd4IEEfCwDPPbg2ByJiKixGeLWEQWp
 8ThXCMSWCHodd8sdZZSRdp9cLWh+IIp/9tNVGVUoX52o7KqUc9EZKErlt5LWppsnIOvk
 Ifnw==
X-Gm-Message-State: AOJu0YxHB577Y9iNDRU6L0LoXmnTvRZzxXBbd+G1XzxSh6uo+78In6iG
 fT4PRRzDxKqIntnZYLGeByWqzv60MnjYEeCZv/fvE7l7Hm9rX1/ziYKMwYrk+FDaiIJ3hRDuILD
 CSapEN9w=
X-Gm-Gg: AeBDievurddZOWkg56+FrrUVChGa1nyBqYYbigWOgq1+8AwX5cVxdPTcVbR4uxLnAVk
 AqKvWJZUhRX7skYHCmqaIq9gjSf1r89WTt02BjDzhuPqiC2jh8ePHt04lWsBnqKKvbO2eq16HoN
 avje2OuWaUJH9Xkn+TdcFKHCkL4rm6V0p2wS86zPvsh88UVqDrTXutgRMTlax/aQDkm34IdYvTl
 b8gI/4FhBBshZqnJ/IVIh94KEYQRE1OfwF+Cr5j+2dx2CmHmD7+5bf8T9FGPP7Avd/l3pWCoczZ
 LUWmg0hCXrKiv/Q0A+5eBSRSXmA5QVUzfNlC3kaLqvazomELt3mTQkix1SVVaShe3bJ6yc5nU1y
 mWWNqC7ye/AS9vpPb19diO2UA1/ZLeTbGfISzdoOXtZmCKTTLuNBgcEt7RiZygOzc1lvtwRq38e
 +hVtlVg/mFCcQLLsosArBSHBt7oWzLorzpbxw0djjxYCQM0RZRJ1fLDw0fHLGfKg==
X-Received: by 2002:a05:6870:8a07:b0:417:ab68:fbaf with SMTP id
 586e51a60fabf-42adecd155dmr17504613fac.20.1777005136220; 
 Thu, 23 Apr 2026 21:32:16 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:32:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 27/40] target/arm: Implement F1CVTL, F1CVTL2, F2CVTL,
 F2CVTL2 for AdvSIMD
Date: Fri, 24 Apr 2026 14:30:01 +1000
Message-ID: <20260424043014.46305-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 42 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  3 +++
 target/arm/tcg/a64.decode        |  3 +++
 4 files changed, 50 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 966f83d796..718463422b 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -7,3 +7,5 @@ DEF_HELPER_FLAGS_4(advsimd_bfcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(advsimd_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index daf9c35720..ed4923b1d5 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -91,6 +91,16 @@ static void bfloat16_invalid_input(bfloat16 *d, size_t nelem, float_status *s)
     float_raise(float_flag_invalid | float_flag_invalid_snan, s);
 }
 
+static void float16_invalid_input(float16 *d, size_t nelem, float_status *s)
+{
+    float16 dnan = float16_default_nan(s);
+
+    for (size_t i = 0; i < nelem; ++i) {
+        d[i] = dnan;
+    }
+    float_raise(float_flag_invalid | float_flag_invalid_snan, s);
+}
+
 void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
@@ -122,6 +132,38 @@ void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     clear_tail(vd, 16, simd_maxsz(desc));
 }
 
+void HELPER(advsimd_fcvtl_hb)(void *vd, void *vn,
+                              CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0xf);
+    uint8_t *n = vn, scratch[16];
+    float16 *d = vd;
+
+    if (vd == vn) {
+        n = memcpy(scratch, vn, 16);
+    }
+    n += ctx.high * 8;
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (int i = 0; i < 8; ++i) {
+            d[H2(i)] = float8_e5m2_to_float16(n[H1(i)], ctx.scale, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (int i = 0; i < 8; ++i) {
+            d[H2(i)] = float8_e4m3_to_float16(n[H1(i)], ctx.scale, &ctx.stat);
+        }
+        break;
+    default:
+        float16_invalid_input(d, 8, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+    clear_tail(vd, 16, simd_maxsz(desc));
+}
+
 void HELPER(sve2_bfcvt)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d23d1a0bf5..b3fbc5f193 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10642,6 +10642,9 @@ static bool do_f8cvt(DisasContext *s, arg_qrr_e *a,
     return true;
 }
 
+TRANS_FEAT(F1CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_fcvtl_hb, false)
+TRANS_FEAT(F2CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_fcvtl_hb, true)
+
 TRANS_FEAT(BF1CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_bfcvtl, false)
 TRANS_FEAT(BF2CVTL, aa64_f8cvt, do_f8cvt, a, gen_helper_advsimd_bfcvtl, true)
 
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b7aac148f2..26d31d0a33 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1910,6 +1910,9 @@ URSQRTE_v       0.10 1110 101 00001 11001 0 ..... .....     @qrr_s
 
 FCVTL_v         0.00 1110 0.1 00001 01111 0 ..... .....     @qrr_sd
 
+F1CVTL          0.10 1110 001 00001 01111 0 ..... .....     @qrr_h
+F2CVTL          0.10 1110 011 00001 01111 0 ..... .....     @qrr_h
+
 BF1CVTL         0.10 1110 101 00001 01111 0 ..... .....     @qrr_h
 BF2CVTL         0.10 1110 111 00001 01111 0 ..... .....     @qrr_h
 
-- 
2.43.0


