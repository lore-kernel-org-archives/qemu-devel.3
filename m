Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE682FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIFAI-00078j-IO; Wed, 29 Apr 2026 20:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFA7-0006qm-H9
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:51 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFA5-0006P4-3g
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:50 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82748257f5fso1063852b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508507; x=1778113307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMoYzuRPqODpMRORB+9R841nOiCKW8bvTvK/FcN9j6k=;
 b=LHfY87dpU0jXl4dMPpMQ5zL41/skKnxDwPTwDLiYqINzUKXfSST3vZJH1VpUqpjFe2
 nCApUhjpysLZrKIyk/m4bXy/HnCSDQWkkDHU90RV2LD9Fo1hTeAQJeuZKEvqD6PAWE97
 JBpRz2qLpZHEDjUfkY+GKwne/L7fATdP+OVuCTk75MvCFmMDkar7h8dPjVHwlCTB3sN5
 n/XLo5EMWUWeM8dMM58sec0MjuWEemTKdCQI0fmBBrq3cvqVe3E+jDVloEol4srV63JH
 uj1hxjhjCrWUeJPSnWTDO0gcRfGiUqLQqztbjtFvdqEwjhjLxzS42nzdzeYn/Z16hlty
 D2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508507; x=1778113307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iMoYzuRPqODpMRORB+9R841nOiCKW8bvTvK/FcN9j6k=;
 b=GqTlpATfRT69zaoWX1SwJ7lU5VmQd3azhkkdDIZLmyEMJnIs36aWa0tf2Y82yyg+Xa
 BYHbGUpGyS9kUZHrU3ZPtj0ejKawt+bnXcWiLbfsePeivs2A9qmK3PMZ3vDx5Eam8EHS
 yoFVzOyn9M/xgjpjZw+W/yxa9hWM10EJyORHWc6KD/G5ubHO1aoBljjinKDZYA35Fgnn
 uWwauERxHbcvnrw3Z6m15UGuvsrqsxCGiPTqRQQpslUVyyVBNcB1edOLLuRvBN71eytB
 T9HM65r1kz2s6770cNQ8FoLkJ2Jxd63q2a7KdzUaNRIKntWXX7AMXKrhGnUYrWebPU8V
 AewQ==
X-Gm-Message-State: AOJu0YyP4olxYRHUcu0U2mF361th84MdIYamBppuMjr6i1BbtEozNK3O
 JJgU3fbme271xbHvQhM4SXNGSp9+buwm0MQg/+IYr5/rafZ6fEZSozQdJVt17R0Czf23F0IeTea
 otvKopHk=
X-Gm-Gg: AeBDiesjMSzErVnkIv3PnDgWMQyi0wgf02aTIbbPkcC9AOTjtK1XIo/9ljKwIld7Q/O
 KU2bY4pzA2fid6DNI7JxSSMbETa/XKAPPMpeUMnx5gnzGaOGe9+CDREvwFXKVyZWZe+qJxfhce/
 wqL9GnZ4jfLjAnvjah+LOa3l9R1JdzGg1Lxs/yDtw/L6u7MwYlrwuB7o9jRmBTK/BzZY7wERLEe
 0bH/yvoRfSDCy6j84jHs82q6Doeh99KPGaOT8kqaZCeWuWT4t4o8iNve143XcCefTCtKzuPsfQe
 vFgh8waQL1tqhm8htGUJOLhD0OkZIafG5qxCYdzHAYyTZzD3jxLwKQsc6kin58MJnymrOqFHqFW
 iUZHM6YcvBK0kjv7Ko2YZs+LZBeRJv+22XShVZTxFFh+lZXn6hJKebYeqiI43Y2ApS7VTBLsMXR
 X8p1Tm/073/XsSFsBPb35zyftuKgfx5/l2kORdJKO3lHqvwtuR7/U=
X-Received: by 2002:a05:6a00:14ca:b0:82f:51e8:b38e with SMTP id
 d2e1a72fcca58-8350014e5c9mr266346b3a.24.1777508506908; 
 Wed, 29 Apr 2026 17:21:46 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:21:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 25/47] target/arm: Implement F1CVTL, F1CVTL2, F2CVTL,
 F2CVTL2 for AdvSIMD
Date: Thu, 30 Apr 2026 10:20:24 +1000
Message-ID: <20260430002046.59739-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 56 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  3 ++
 target/arm/tcg/a64.decode        |  3 ++
 4 files changed, 64 insertions(+)

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
index 7598871f87..2739cdb343 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -92,6 +92,16 @@ static void bfloat16_invalid_input(bfloat16 *d, size_t nelem, float_status *s)
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
 static bfloat16 fcvt_fp8e4m3_to_b16(float8_e4m3 x, int scale, float_status *s)
 {
     FloatParts64 p = float8_e4m3_unpack_canonical(x, s);
@@ -106,6 +116,20 @@ static bfloat16 fcvt_fp8e5m2_to_b16(float8_e5m2 x, int scale, float_status *s)
     return bfloat16_round_pack_canonical(&p, s);
 }
 
+static float16 fcvt_fp8e4m3_to_f16(float8_e4m3 x, int scale, float_status *s)
+{
+    FloatParts64 p = float8_e4m3_unpack_canonical(x, s);
+    p = parts64_scalbn(&p, scale, s);
+    return float16_round_pack_canonical(&p, s);
+}
+
+static float16 fcvt_fp8e5m2_to_f16(float8_e5m2 x, int scale, float_status *s)
+{
+    FloatParts64 p = float8_e5m2_unpack_canonical(x, s);
+    p = parts64_scalbn(&p, scale, s);
+    return float16_round_pack_canonical(&p, s);
+}
+
 void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
@@ -137,6 +161,38 @@ void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
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
+            d[H2(i)] = fcvt_fp8e5m2_to_f16(n[H1(i)], ctx.scale, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (int i = 0; i < 8; ++i) {
+            d[H2(i)] = fcvt_fp8e4m3_to_f16(n[H1(i)], ctx.scale, &ctx.stat);
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
index 085e7e3b95..565053a1a4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10643,6 +10643,9 @@ static bool do_f8cvt(DisasContext *s, arg_qrr_e *a,
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


