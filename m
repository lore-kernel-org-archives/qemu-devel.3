Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CD3CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDPm-0006qJ-Jg; Wed, 29 Apr 2026 18:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDPk-0006YA-Ay
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:29:52 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDPi-000703-Nl
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:29:52 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35d94f4ee36so128870a91.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501789; x=1778106589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Y7AOgeyZqnnu+WUEf2U46nh1dogopnE1E9orVyjUJg=;
 b=xWIOvQ/LDj5nKojW70IFn87v95QwVbHMjrTlinm608/T/uhvtQhDkTnsmMedtcOjKY
 jBmkDXUo1E05BKTePc0p6pXwziErgbcKejqre0wrp5EDZlJ9yIx6N4L9sQaCmKoix+lp
 wD/K7eo9gONm7m29r70UjjaAlSnectniHjg8Dw7y5vsHp+c8rcqHbBqeXE+6CCbg8Qyn
 TFsOLIWDvNgZ4eCcnyvUoEkNSQW+jjbDgEzJJNPdf21//61SqsfVxwl3GAfW/LTdvybH
 /ffhOrlsAcyQGHW0RfhxNYRzeJt1TWeR48Ovm1wEBy1A2BJd5F5ovjv6vKE9E1Rkrelf
 xRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501789; x=1778106589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+Y7AOgeyZqnnu+WUEf2U46nh1dogopnE1E9orVyjUJg=;
 b=OJ9D/deceUeRLDpfZ6qeV8t1gf/JPuZAnqOLyqNOFPTvkyeK0aE5TI/YuU23dH9u6j
 bbUM6ojiQ9iB4dzy2H9hbNfBhutNn+GHltKpM+wK1o9XDFYRQOG7arQJJ53rJmJIrtRh
 Akv9j6rh/fOah4QNjVdzUsdnZtszC+JUoIJflsxN0e4xUCC9/T4+jciDNpPhVSID3Kt6
 N094oSsjltIeTNbNVxrDRh4s/6mCcF41ILRUAPyvqLXFya8mluswF0glF7jKA2ABymFH
 JPtbAEAjawVnaW0Fola2PBGqfygWRWTo4gBXLvuzbCq3qWPpsQQ+xcZdEaZEJFkgUO8I
 LKFQ==
X-Gm-Message-State: AOJu0Yw9vDsSXVgIvt2w505UT5xcIsbnFyKTrHcv9imbqEaX7Kas9d0D
 MBIQ0fpcyzGMumedyRVVYF4k6ViaKuafy+k2l6PJlQ/ZiY/hhbn4CUi1Ce1dF7+/YyRS1wKa73T
 9CxgrEII=
X-Gm-Gg: AeBDietBl2+6y1JwrcUS9arrT71IWzt/fdJTAZ2SviRt9PEK8aW47VhnP3mD4GYxFuq
 E1eIsaAhOQRptx9m9F1VberObi6raYWJzWUZp26Xvg2GK4Y1RauZyQvXNtlqa72rXJh/MFyP0e/
 IfCL4j2YR4xNds52Wkl9+mS2zGBlEH1UJWNHWQm8gHI9xNhZunyOURmsUt2m2lMNxpb1te1HsNC
 br+eHXKtQLAeQ72YzwbUP4d5SBeTGKe7yb1I4MSezyVuqA2T+p+NvkAIXkoAWIndgVcnpZOr/id
 LBF9XiBYpUVeDUAmwQOYoy3s8vRTCxW6SWSwaSNMSZr9lwV8mzF8wSkNBp+/9UvSNaq4haphos2
 nBb0O52HKtxKCrIH7VH+PeR8U1QWLZdeoxbP80WlmcZvMLmP6BdwifjbS2OVKqqr02fjU0WG+6w
 S31RuxcYYtg5O7UlCzUb8uVGW20hSg+/lVOEm4pgUl9TA1qcz9pfA=
X-Received: by 2002:a17:90b:50cd:b0:35f:c1e1:a263 with SMTP id
 98e67ed59e1d1-364c3136dedmr184604a91.19.1777501789335; 
 Wed, 29 Apr 2026 15:29:49 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364bdf54203sm630479a91.7.2026.04.29.15.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:29:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 45/48] fpu: Return struct from float128_unpack_raw
Date: Thu, 30 Apr 2026 08:24:42 +1000
Message-ID: <20260429222445.26301-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 5412fd0360..a9c91fb8a4 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -646,12 +646,12 @@ static FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
     };
 }
 
-static void QEMU_FLATTEN float128_unpack_raw(FloatParts128 *p, float128 f)
+static FloatParts128 float128_unpack_raw(float128 f)
 {
     const int f_size = float128_params.frac_size - 64;
     const int e_size = float128_params.exp_size;
 
-    *p = (FloatParts128) {
+    return (FloatParts128) {
         .cls = float_class_unclassified,
         .sign = extract64(f.high, f_size + e_size, 1),
         .exp = extract64(f.high, f_size, e_size),
@@ -1586,7 +1586,7 @@ static float64 float64r32_round_pack_canonical(FloatParts64 *p,
 static void float128_unpack_canonical(FloatParts128 *p, float128 f,
                                       float_status *s)
 {
-    float128_unpack_raw(p, f);
+    *p = float128_unpack_raw(f);
     parts128_canonicalize(p, s, &float128_params);
 }
 
@@ -4845,9 +4845,8 @@ bfloat16 bfloat16_silence_nan(bfloat16 a, float_status *status)
 
 float128 float128_silence_nan(float128 a, float_status *status)
 {
-    FloatParts128 p;
+    FloatParts128 p = float128_unpack_raw(a);
 
-    float128_unpack_raw(&p, a);
     frac128_shl(&p, float128_params.frac_shift);
     parts128_silence_nan(&p, status);
     frac128_shr(&p, float128_params.frac_shift);
-- 
2.43.0


