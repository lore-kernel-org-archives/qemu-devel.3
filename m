Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0C1CD5BAB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkZR-0001hW-1u; Wed, 20 May 2026 13:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZA-0001WQ-Kp
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:44 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ4-0001yt-DB
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:44 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-369576666d5so2407013a91.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297516; x=1779902316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7CkGcitbVj7Tw/zFQo/cJKaPLwAnxuxCUWUlpY6Me2M=;
 b=JdBCnpGW3cOPhOjD97g+KCpBgBaQeYUDkunHl6gVrVGO/lYincfvRym2ftjDCkN7ZY
 B5qhC2u+z9RsZPJsZ/sgZHszrVMfqFjLeBAEwsRVzyDo8zZGzqruns5Phnhlsb2zi4iC
 H+sb/7NSA5Arhw7I2FfE8DuFyi7sfglGqU6ErfWtZ4u7SY/zqbLgQ39UJ34qQlVH7ZSm
 cTtbViwt1xXnxF9EHdNfs8nUazTvgTQ2BM805JmtvII7PAhW6N21Jl6tL1k1j1ezo8Y0
 MFOLl+Bs9GFigWE7eN4rJJ2szVuBbgT0FbBEb+kmrhizmY6cFVb1RNpimPW4Yb7p2KyB
 qzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297516; x=1779902316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7CkGcitbVj7Tw/zFQo/cJKaPLwAnxuxCUWUlpY6Me2M=;
 b=fkAm/21cwWtjl4FoZUlFm2IkSUgOFUAvD7HwzLd8OvMy1rsS+Uflz+QaKR6gmjsZSq
 GJXjqG3RIF6SNMq7bsOOW/EhTstWNiIXBHhBNWkc+GjUKf/t+3KjpxsjhMmyf7GcDT5R
 oG3i5UfNE20RC+wL4HM04+9TgVt+5iZtlqMQl0GFjDBk0k3yBABUsVslNVrkPcfpjCGI
 RkR803rbxwwUvkf6A/UGWyeDnN3oLydETGjWnbtDT2tJb8m6e+axT6xIKiy7j2MO6gx7
 g+0mElbVeP1YpEhKRsW9a0WlJq49SSaNdH0a5hswhQ2fWLbUHUrH9rJN3zEUZSkB0p8C
 30/w==
X-Gm-Message-State: AOJu0YxRePbhNLVyvfgfzrhlohFXTJOFh2bJ0N/RBJc+KKJbLuUcxsjs
 4rYernwUmmL/nBv/WOry9+M9TZu497Puf5OkqyTbvlS7zdnKu+8U2ueyMASy8MRBJ9Vxh9m2EV0
 Ql1Cq15k=
X-Gm-Gg: Acq92OGSmBdlQXq2AzW/pYDTy3dnP7WWJtX9CWLNhgJke446aBuOK215JyanPYRuzTa
 pjTe1WCZWPyzRZ3DARGEuCrTuAMgzHfju7yc5SmZ2hgqf5p1leva79M23FccqnoLDw65DpD2F/O
 m7XDTMFRF6p4F+a6ElDxoOHC/q6Fl4dqiORxOd3JWh4zd4AU1lFF6n4n8WgW28IX46Zy5ae0Dk9
 x6qCn6sZGw64KiqfX4hj/mxG+737Eeu2Ju2r+G2QajbMcCZH2yxGrIZXRCGd5aRQoivKgudS9lC
 b6RGmkJKDjjBPXlYXLcrEWrwQFBCouGSMsdydAvD9g1pezpTjpG+R9xmyA0x2cyPGE483qaOumf
 lP+HtN1W/p4xW6GAL+8NQLvUkDPz3iNzNDlKCou+kPOUeTm03k3OrhogIno+pj+lGXW50LISvtM
 ILxHFo3pViDcFKTCU2pJAY3dcEmmNp
X-Received: by 2002:a17:90b:3505:b0:368:9da3:c496 with SMTP id
 98e67ed59e1d1-36951ca7638mr24829565a91.24.1779297516353; 
 Wed, 20 May 2026 10:18:36 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 20/30] fpu: Use accessors for tininess_before_rounding
Date: Wed, 20 May 2026 10:18:10 -0700
Message-ID: <20260520171820.848839-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Rename get_float_detect_tininess to get_tininess_before_rounding
and move to softfloat.c, as there are no external users.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h | 5 -----
 fpu/softfloat.c                 | 4 ++--
 tests/fp/fp-test.c              | 2 +-
 fpu/softfloat-parts.c.inc       | 2 +-
 fpu/softfloat-specialize.c.inc  | 5 +++++
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 95edd22842..395ce67abf 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -132,11 +132,6 @@ static inline void set_snan_rule(FloatSNaNRule val, float_status *status)
     status->float_snan_rule = val;
 }
 
-static inline bool get_float_detect_tininess(const float_status *status)
-{
-    return status->tininess_before_rounding;
-}
-
 static inline FloatRoundMode get_float_rounding_mode(const float_status *status)
 {
     return status->float_rounding_mode;
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index f774ff278c..c7c750f284 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4923,7 +4923,7 @@ floatx80 roundAndPackFloatx80(FloatX80RoundPrec roundingPrecision, bool zSign,
                 float_raise(float_flag_output_denormal_flushed, status);
                 return packFloatx80(zSign, 0, 0);
             }
-            isTiny = status->tininess_before_rounding
+            isTiny = get_tininess_before_rounding(status)
                   || (zExp < 0 )
                   || (zSig0 <= zSig0 + roundIncrement);
             shift64RightJamming( zSig0, 1 - zExp, &zSig0 );
@@ -4997,7 +4997,7 @@ floatx80 roundAndPackFloatx80(FloatX80RoundPrec roundingPrecision, bool zSign,
             return floatx80_default_inf(zSign, status);
         }
         if ( zExp <= 0 ) {
-            isTiny = status->tininess_before_rounding
+            isTiny = get_tininess_before_rounding(status)
                   || (zExp < 0)
                   || !increment
                   || (zSig0 < UINT64_C(0xFFFFFFFFFFFFFFFF));
diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index 326a1201f3..16ffd36e6f 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -1011,7 +1011,7 @@ void run_test(void)
 
                     verCases_tininessCode = 0;
                     slowfloat_detectTininess = tmode;
-                    qsf.tininess_before_rounding = sf_tininess_to_qemu(tmode);
+                    set_float_detect_tininess(sf_tininess_to_qemu(tmode), &qsf);
 
                     if (attrs & FUNC_EFF_TININESSMODE ||
                         ((attrs & FUNC_EFF_TININESSMODE_REDUCEDPREC) &&
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 1e92251761..1c726cb86e 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -418,7 +418,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
         exp = 0;
         fracN(clear)(p);
     } else {
-        bool is_tiny = s->tininess_before_rounding || exp < 0;
+        bool is_tiny = get_tininess_before_rounding(s) || exp < 0;
         bool has_pseudo_denormals = fmt->has_explicit_bit &&
             (get_floatx80_behaviour(s) & floatx80_pseudo_denormal_valid);
 
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 4b6c17e433..0b62b0e907 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -79,6 +79,11 @@ this code that are retained.
  * version 2 or later. See the COPYING file in the top-level directory.
  */
 
+static inline bool get_tininess_before_rounding(const float_status *status)
+{
+    return status->tininess_before_rounding;
+}
+
 /*----------------------------------------------------------------------------
 | For the deconstructed floating-point with fraction FRAC, return true
 | if the fraction represents a signalling NaN; otherwise false.
-- 
2.43.0


