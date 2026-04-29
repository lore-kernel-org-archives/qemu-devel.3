Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B13FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDPp-0007Hf-NA; Wed, 29 Apr 2026 18:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDPn-0006xF-E0
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:29:55 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDPl-00070E-AO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:29:55 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35fb7c1a455so72586a91.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501792; x=1778106592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cKfv1vhY7Ui3LYik1NVKPOQOgbLeGD0tQcqmZyxoafw=;
 b=lX+Ep3xF6hmrQfPT1H2frKLXrWguRd2k9PitiTaIUsVej/pxT5i3gbObbt9tu3j3tF
 YWxv3G/U1b+qzCYLgbTfww9iX49x9L2Nwx8Xgd283jy1hteX2jNrsKG1sMvItGVvSNGe
 vGWDo8agtiCUA3rnz+YfsY9djyMp2aQDxZJykELWeS9V0r7QEcDkLlRi+R8FyMwxl0+v
 2bWqYPiEpjc7zjGYvzTJrTToEG74W46CpXx+DxIYqJlEVQRoogF7cYgXsqtsd2AMpPBx
 ge+FAivJAtUuvCm3cLIExNVfLcDVNLup5C8ngtsX8hGxgoTuauTGibfCBTmkyT0KckO5
 0org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501792; x=1778106592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cKfv1vhY7Ui3LYik1NVKPOQOgbLeGD0tQcqmZyxoafw=;
 b=fqDEHQ/VwEndO740FZ1fxg+0ksr702d38pAIz9C9uX4X3AwSelZWCoo+Er73NjP7o/
 Gk5j1dkk+8PT0TdxFVVKl++lGvhjxG6bFd7QoxJJeaNnhACYp53qOYH6M/srbhEsqjnC
 ipFhXRE4P1ouTkH5QiZ8US3uHhcW/RxXy+p01msCmx9QU12SGNsFd6T/oBY0RnDm0Zk0
 SXl7xU3TUcHvw1E2AXDdQSDnxljFIILCdT4tiwNwjvhCOg9VpyyEdabmsRtu1O9nPJOT
 d4MnJ7ePjcUbpaztQ0UvPoPyfyp3w2+ZgVXqH89kZLV1xBG29/vX6VXytUfE5sfUrHwk
 tW3w==
X-Gm-Message-State: AOJu0Yy53DUUYENEM64i/E0QcjWc7pdIH7F2UcnzUoyMdDpn3X7OvPwB
 h0i08cza/7VNU88IFybN4MrMuSkTa6Exm9qeNbJR9NqL7t34V/+LNRIpoXzbz4bAfuZesBAG4cc
 tVbxUVeM=
X-Gm-Gg: AeBDieu8nppSij5IW3awVGX0C+JdERN8gY2MAKWpgmOKSpOdCa0Dt5Nq2/T8DCxcOKi
 Lx1aQQBFXhtqFo5L2i4rigoYNPer15/QskrdX01ai6TO/rAViBneQQc9LsuAHvzSMnNLQAUDKX8
 9sMvsu8rji00Uw6h7UEpqVT1TWvLb3HlZmWggGaIYi/YDnzgyKoKOO7OHBSkt//FKEGklBYNC9b
 hruqtIkvBPfzdD9QEX57dhLTJR5AYUwbhFjErIneE9ZS+7UU71gTT8CPfXuqShot7Yax1544BfP
 xUMVnKK7XRv6QWB8kpSIxJWVPyTs2jaPTazgcF2dl9EiNnpvd59XqSOGORINqP/MK2tB2wRw7Eo
 Ob7RAHbKHCLH+UtWS03DooElGFNkm9p4di2/veFkCfTpSu0D0+UecX9j2DW8ixp3xRRyxLxgzw8
 qALQ67Og4LgF21DIHqox5pjTJSspWIQgM0bD0bto5j
X-Received: by 2002:a17:90a:d2c7:b0:35a:189b:43db with SMTP id
 98e67ed59e1d1-364c2f97ceemr169653a91.4.1777501791829; 
 Wed, 29 Apr 2026 15:29:51 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364bdf54203sm630479a91.7.2026.04.29.15.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:29:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 46/48] fpu: Return struct from float128_unpack_canonical
Date: Thu, 30 Apr 2026 08:24:43 +1000
Message-ID: <20260429222445.26301-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
 fpu/softfloat.c | 105 +++++++++++++++++-------------------------------
 1 file changed, 37 insertions(+), 68 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index a9c91fb8a4..77585fa11f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1583,11 +1583,11 @@ static float64 float64r32_round_pack_canonical(FloatParts64 *p,
     return float64r32_pack_raw(p);
 }
 
-static void float128_unpack_canonical(FloatParts128 *p, float128 f,
-                                      float_status *s)
+static FloatParts128 float128_unpack_canonical(float128 f, float_status *s)
 {
-    *p = float128_unpack_raw(f);
-    parts128_canonicalize(p, s, &float128_params);
+    FloatParts128 p = float128_unpack_raw(f);
+    parts128_canonicalize(&p, s, &float128_params);
+    return p;
 }
 
 static float128 float128_round_pack_canonical(FloatParts128 *p,
@@ -1872,11 +1872,9 @@ bfloat16 bfloat16_sub(bfloat16 a, bfloat16 b, float_status *status)
 static float128 QEMU_FLATTEN
 float128_addsub(float128 a, float128 b, float_status *status, bool subtract)
 {
-    FloatParts128 pa, pb, *pr;
-
-    float128_unpack_canonical(&pa, a, status);
-    float128_unpack_canonical(&pb, b, status);
-    pr = parts128_addsub(&pa, &pb, status, subtract);
+    FloatParts128 pa = float128_unpack_canonical(a, status);
+    FloatParts128 pb = float128_unpack_canonical(b, status);
+    FloatParts128 *pr = parts128_addsub(&pa, &pb, status, subtract);
 
     return float128_round_pack_canonical(pr, status);
 }
@@ -1994,11 +1992,9 @@ bfloat16_mul(bfloat16 a, bfloat16 b, float_status *status)
 float128 QEMU_FLATTEN
 float128_mul(float128 a, float128 b, float_status *status)
 {
-    FloatParts128 pa, pb, *pr;
-
-    float128_unpack_canonical(&pa, a, status);
-    float128_unpack_canonical(&pb, b, status);
-    pr = parts128_mul(&pa, &pb, status);
+    FloatParts128 pa = float128_unpack_canonical(a, status);
+    FloatParts128 pb = float128_unpack_canonical(b, status);
+    FloatParts128 *pr = parts128_mul(&pa, &pb, status);
 
     return float128_round_pack_canonical(pr, status);
 }
@@ -2255,12 +2251,10 @@ bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
 float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
                                       int flags, float_status *status)
 {
-    FloatParts128 pa, pb, pc, *pr;
-
-    float128_unpack_canonical(&pa, a, status);
-    float128_unpack_canonical(&pb, b, status);
-    float128_unpack_canonical(&pc, c, status);
-    pr = parts128_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
+    FloatParts128 pa = float128_unpack_canonical(a, status);
+    FloatParts128 pb = float128_unpack_canonical(b, status);
+    FloatParts128 pc = float128_unpack_canonical(c, status);
+    FloatParts128 *pr = parts128_muladd_scalbn(&pa, &pb, &pc, 0, flags, status);
 
     /* Round before applying negate result. */
     parts128_uncanon(pr, status, &float128_params, false);
@@ -2383,11 +2377,9 @@ bfloat16_div(bfloat16 a, bfloat16 b, float_status *status)
 float128 QEMU_FLATTEN
 float128_div(float128 a, float128 b, float_status *status)
 {
-    FloatParts128 pa, pb, *pr;
-
-    float128_unpack_canonical(&pa, a, status);
-    float128_unpack_canonical(&pb, b, status);
-    pr = parts128_div(&pa, &pb, status);
+    FloatParts128 pa = float128_unpack_canonical(a, status);
+    FloatParts128 pb = float128_unpack_canonical(b, status);
+    FloatParts128 *pr = parts128_div(&pa, &pb, status);
 
     return float128_round_pack_canonical(pr, status);
 }
@@ -2429,11 +2421,9 @@ float64 float64_rem(float64 a, float64 b, float_status *status)
 
 float128 float128_rem(float128 a, float128 b, float_status *status)
 {
-    FloatParts128 pa, pb, *pr;
-
-    float128_unpack_canonical(&pa, a, status);
-    float128_unpack_canonical(&pb, b, status);
-    pr = parts128_modrem(&pa, &pb, NULL, status);
+    FloatParts128 pa = float128_unpack_canonical(a, status);
+    FloatParts128 pb = float128_unpack_canonical(b, status);
+    FloatParts128 *pr = parts128_modrem(&pa, &pb, NULL, status);
 
     return float128_round_pack_canonical(pr, status);
 }
@@ -2782,20 +2772,18 @@ bfloat16 float64_to_bfloat16(float64 a, float_status *s)
 
 float32 float128_to_float32(float128 a, float_status *s)
 {
+    FloatParts128 p128 = float128_unpack_canonical(a, s);
     FloatParts64 p64;
-    FloatParts128 p128;
 
-    float128_unpack_canonical(&p128, a, s);
     parts_float_to_float_narrow(&p64, &p128, s);
     return float32_round_pack_canonical(&p64, s);
 }
 
 float64 float128_to_float64(float128 a, float_status *s)
 {
+    FloatParts128 p128 = float128_unpack_canonical(a, s);
     FloatParts64 p64;
-    FloatParts128 p128;
 
-    float128_unpack_canonical(&p128, a, s);
     parts_float_to_float_narrow(&p64, &p128, s);
     return float64_round_pack_canonical(&p64, s);
 }
@@ -2876,9 +2864,8 @@ floatx80 float64_to_floatx80(float64 a, float_status *s)
 
 floatx80 float128_to_floatx80(float128 a, float_status *s)
 {
-    FloatParts128 p;
+    FloatParts128 p = float128_unpack_canonical(a, s);
 
-    float128_unpack_canonical(&p, a, s);
     parts128_float_to_float(&p, s);
     return floatx80_round_pack_canonical(&p, s);
 }
@@ -2921,9 +2908,8 @@ bfloat16 bfloat16_round_to_int(bfloat16 a, float_status *s)
 
 float128 float128_round_to_int(float128 a, float_status *s)
 {
-    FloatParts128 p;
+    FloatParts128 p = float128_unpack_canonical(a, s);
 
-    float128_unpack_canonical(&p, a, s);
     parts128_round_to_int(&p, s->float_rounding_mode, 0, s, &float128_params);
     return float128_round_pack_canonical(&p, s);
 }
@@ -3046,18 +3032,14 @@ int64_t bfloat16_to_int64_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
 static int32_t float128_to_int32_scalbn(float128 a, FloatRoundMode rmode,
                                         int scale, float_status *s)
 {
-    FloatParts128 p;
-
-    float128_unpack_canonical(&p, a, s);
+    FloatParts128 p = float128_unpack_canonical(a, s);
     return parts128_float_to_sint(&p, rmode, scale, INT32_MIN, INT32_MAX, s);
 }
 
 static int64_t float128_to_int64_scalbn(float128 a, FloatRoundMode rmode,
                                         int scale, float_status *s)
 {
-    FloatParts128 p;
-
-    float128_unpack_canonical(&p, a, s);
+    FloatParts128 p = float128_unpack_canonical(a, s);
     return parts128_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
 }
 
@@ -3066,9 +3048,7 @@ static Int128 float128_to_int128_scalbn(float128 a, FloatRoundMode rmode,
 {
     int flags = 0;
     Int128 r;
-    FloatParts128 p;
-
-    float128_unpack_canonical(&p, a, s);
+    FloatParts128 p = float128_unpack_canonical(a, s);
 
     switch (p.cls) {
     case float_class_snan:
@@ -3512,18 +3492,14 @@ uint64_t bfloat16_to_uint64_scalbn(bfloat16 a, FloatRoundMode rmode,
 static uint32_t float128_to_uint32_scalbn(float128 a, FloatRoundMode rmode,
                                           int scale, float_status *s)
 {
-    FloatParts128 p;
-
-    float128_unpack_canonical(&p, a, s);
+    FloatParts128 p = float128_unpack_canonical(a, s);
     return parts128_float_to_uint(&p, rmode, scale, UINT32_MAX, s);
 }
 
 static uint64_t float128_to_uint64_scalbn(float128 a, FloatRoundMode rmode,
                                           int scale, float_status *s)
 {
-    FloatParts128 p;
-
-    float128_unpack_canonical(&p, a, s);
+    FloatParts128 p = float128_unpack_canonical(a, s);
     return parts128_float_to_uint(&p, rmode, scale, UINT64_MAX, s);
 }
 
@@ -3532,9 +3508,7 @@ static Int128 float128_to_uint128_scalbn(float128 a, FloatRoundMode rmode,
 {
     int flags = 0;
     Int128 r;
-    FloatParts128 p;
-
-    float128_unpack_canonical(&p, a, s);
+    FloatParts128 p = float128_unpack_canonical(a, s);
 
     switch (p.cls) {
     case float_class_snan:
@@ -4210,11 +4184,9 @@ static float64 float64_minmax(float64 a, float64 b, float_status *s, int flags)
 static float128 float128_minmax(float128 a, float128 b,
                                 float_status *s, int flags)
 {
-    FloatParts128 pa, pb, *pr;
-
-    float128_unpack_canonical(&pa, a, s);
-    float128_unpack_canonical(&pb, b, s);
-    pr = parts128_minmax(&pa, &pb, s, flags);
+    FloatParts128 pa = float128_unpack_canonical(a, s);
+    FloatParts128 pb = float128_unpack_canonical(b, s);
+    FloatParts128 *pr = parts128_minmax(&pa, &pb, s, flags);
 
     return float128_round_pack_canonical(pr, s);
 }
@@ -4393,10 +4365,9 @@ FloatRelation bfloat16_compare_quiet(bfloat16 a, bfloat16 b, float_status *s)
 static FloatRelation QEMU_FLATTEN
 float128_do_compare(float128 a, float128 b, float_status *s, bool is_quiet)
 {
-    FloatParts128 pa, pb;
+    FloatParts128 pa = float128_unpack_canonical(a, s);
+    FloatParts128 pb = float128_unpack_canonical(b, s);
 
-    float128_unpack_canonical(&pa, a, s);
-    float128_unpack_canonical(&pb, b, s);
     return parts128_compare(&pa, &pb, s, is_quiet);
 }
 
@@ -4470,9 +4441,8 @@ bfloat16 bfloat16_scalbn(bfloat16 a, int n, float_status *status)
 
 float128 float128_scalbn(float128 a, int n, float_status *status)
 {
-    FloatParts128 p;
+    FloatParts128 p = float128_unpack_canonical(a, status);
 
-    float128_unpack_canonical(&p, a, status);
     parts128_scalbn(&p, n, status);
     return float128_round_pack_canonical(&p, status);
 }
@@ -4590,9 +4560,8 @@ bfloat16 QEMU_FLATTEN bfloat16_sqrt(bfloat16 a, float_status *status)
 
 float128 QEMU_FLATTEN float128_sqrt(float128 a, float_status *status)
 {
-    FloatParts128 p;
+    FloatParts128 p = float128_unpack_canonical(a, status);
 
-    float128_unpack_canonical(&p, a, status);
     parts128_sqrt(&p, status, &float128_params);
     return float128_round_pack_canonical(&p, status);
 }
-- 
2.43.0


