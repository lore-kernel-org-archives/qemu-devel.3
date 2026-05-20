Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1453CCD5BAB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkZ9-0001Tn-5u; Wed, 20 May 2026 13:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ6-0001Qh-Eq
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:40 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ0-0001wr-CZ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:40 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-36974221f93so2743018a91.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297513; x=1779902313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q+5cfWNTJB+4Qam3ofEoqEbOPB2mlqf7aJzYceF2Hgc=;
 b=HwE6e6s+O51aDV+qqifdVju2819fDR9VYRr5nbd6Rtn+M7byCFDrU7vB1PbHw9M9VC
 9S/iejBq8gcIzokXy1ue6RNPi2k++Ncr22ngSv3NC9W7+ZdEZ7itsbmr4R4p9YgzaGhC
 Bo4RrLf3WxsZndvOXKNiA9Mxg4Ri5xWJZ1fTFUHZKBpLG25QOtuUF98/ebBh4jOHksGc
 4UOzpMTPSlcyytYTXtwUOSubimCLVKhyW//LcCAJkc5CgvJPPbW8PX1l6U4P8AIQg8pi
 N6m97ELiLbCi1p5rnLhol9ABqr1WKSHtgd/6gflFAETNJtILtlNWVFtFK7Grhwgz5NIw
 gNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297513; x=1779902313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q+5cfWNTJB+4Qam3ofEoqEbOPB2mlqf7aJzYceF2Hgc=;
 b=CRuTpdoqbK/4u9TzOLga+UJgcfk6PiV3tdVxhi3lyUv0c9C+N8mvYziqdpIN3vGaWe
 J3lS53LuLBu1l8akWgPWtLBXirx7tTNgsnsknF3kR7gAfpGIJ7a1ZJaZHY93A/qP6p+B
 pX7DhGV7Pq/z+FGnBd4qCuKbBuaK2ZnsHVYD3okrmFObUKrtHntVNtX13N1krDlOgRiL
 hHZOP4yoYJm1rxFeFicJNihpZq4zaaexxTrem3JOhoLJvJjIi0xAA15cuRToLZKtYPjG
 EzMMkQRVrKKYjDOeEJ7zJsaDwWXLFcDpPh5xpmtiSu5IzDY17sSwm2IUoEO3Bqh7+o5d
 Dncw==
X-Gm-Message-State: AOJu0YyoDb/CGIk2TO4mhX0SAr/bN57xa/6jHYy0DaCL+ARyrkDYQWl/
 /qh3v/3DWyCxNKnz8yt0cUOqAzY46o9fswaS5TeHOik6TlfEocXt6/fk8WtDz3pi3vPqda0rqZu
 9jwHJZ/o=
X-Gm-Gg: Acq92OFKHwzAZZy2YEitlUh7pjKKyorOf2+uAxrYJ34q+Vi3DyqgPoaS0VtFpBXGYTw
 ewMK9ltzmGWJeQDXS6BCfH+KyZ1Smn/jr4lfNIMdK6sPWbgV9eil+/DblRhg6D5L0v7w8WX/53e
 cN3gRI+E7RO62xBmhKSM8iEHMapuSi81wnoIErKPynikh2RcgvE+vai9WckFWx1q9x1OIB5a4p6
 bqbnryPlWZ2ajtFnJOuQ6W+ZEVtJVcEG/W49gslFDN+TKlJ32NVn7FZ/ER8KQWtvDbuAMNW6XDn
 NnC3uHTQUhXkSc2LrwUdeYVCde7EzXiSjgi7xthZmfzBXNQtjyNfWDJLCw5/dtzzSAS7V9UMf3s
 riD1wvyB4iCcYFdj3OAHQX5m+rzj2+GtdVLWsCOZv476pCMM1QMcRkkaWWEIk3nS17VjH74aqnS
 3B9cdKeqcAmkF0BGkHZGgeTSN8sJUwJ35fbltwRv4=
X-Received: by 2002:a17:90b:4a:b0:35d:a0b7:9608 with SMTP id
 98e67ed59e1d1-369519feb17mr23970154a91.7.1779297512413; 
 Wed, 20 May 2026 10:18:32 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 14/30] fpu: Use {get,set}_float_rounding_mode everywhere
Date: Wed, 20 May 2026 10:18:04 -0700
Message-ID: <20260520171820.848839-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
 target/i386/ops_sse.h         |  24 ++---
 fpu/softfloat.c               |  88 +++++++++---------
 target/alpha/fpu_helper.c     |   2 +-
 target/arm/tcg/vfp_helper.c   |   8 +-
 target/hexagon/fma_emu.c      |   6 +-
 target/i386/tcg/fpu_helper.c  |  28 +++---
 target/m68k/softfloat.c       | 170 +++++++++++++++++-----------------
 target/ppc/fpu_helper.c       |  14 +--
 target/riscv/vector_helper.c  |   6 +-
 target/s390x/tcg/fpu_helper.c |   4 +-
 tests/fp/fp-bench.c           |   2 +-
 tests/fp/fp-test.c            |   2 +-
 fpu/softfloat-parts.c.inc     |   8 +-
 tests/fp/wrap.c.inc           |  12 +--
 14 files changed, 185 insertions(+), 189 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 99c4728ec8..5176a9f9e3 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -601,7 +601,7 @@ void glue(helper_cvtph2ps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 void glue(helper_cvtps2ph, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, int mode)
 {
     int i;
-    FloatRoundMode prev_rounding_mode = env->sse_status.float_rounding_mode;
+    FloatRoundMode prev_rounding_mode = get_float_rounding_mode(&env->sse_status);
     if (!(mode & (1 << 2))) {
         set_x86_rounding_mode(mode & 3, &env->sse_status);
     }
@@ -613,7 +613,7 @@ void glue(helper_cvtps2ph, SUFFIX)(CPUX86State *env, Reg *d, Reg *s, int mode)
         d->Q(i) = 0;
     }
 
-    env->sse_status.float_rounding_mode = prev_rounding_mode;
+    set_float_rounding_mode(prev_rounding_mode, &env->sse_status);
 }
 #endif
 
@@ -1715,10 +1715,9 @@ void glue(helper_roundps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
                                   uint32_t mode)
 {
     int old_flags = get_float_exception_flags(&env->sse_status);
-    signed char prev_rounding_mode;
+    FloatRoundMode prev_rounding_mode = get_float_rounding_mode(&env->sse_status);
     int i;
 
-    prev_rounding_mode = env->sse_status.float_rounding_mode;
     if (!(mode & (1 << 2))) {
         set_x86_rounding_mode(mode & 3, &env->sse_status);
     }
@@ -1732,17 +1731,16 @@ void glue(helper_roundps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
                                   ~float_flag_inexact,
                                   &env->sse_status);
     }
-    env->sse_status.float_rounding_mode = prev_rounding_mode;
+    set_float_rounding_mode(prev_rounding_mode, &env->sse_status);
 }
 
 void glue(helper_roundpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
                                   uint32_t mode)
 {
     int old_flags = get_float_exception_flags(&env->sse_status);
-    signed char prev_rounding_mode;
+    FloatRoundMode prev_rounding_mode = get_float_rounding_mode(&env->sse_status);
     int i;
 
-    prev_rounding_mode = env->sse_status.float_rounding_mode;
     if (!(mode & (1 << 2))) {
         set_x86_rounding_mode(mode & 3, &env->sse_status);
     }
@@ -1756,7 +1754,7 @@ void glue(helper_roundpd, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
                                   ~float_flag_inexact,
                                   &env->sse_status);
     }
-    env->sse_status.float_rounding_mode = prev_rounding_mode;
+    set_float_rounding_mode(prev_rounding_mode, &env->sse_status);
 }
 
 #if SHIFT == 1
@@ -1764,10 +1762,9 @@ void glue(helper_roundss, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
                                   uint32_t mode)
 {
     int old_flags = get_float_exception_flags(&env->sse_status);
-    signed char prev_rounding_mode;
+    FloatRoundMode prev_rounding_mode = get_float_rounding_mode(&env->sse_status);
     int i;
 
-    prev_rounding_mode = env->sse_status.float_rounding_mode;
     if (!(mode & (1 << 2))) {
         set_x86_rounding_mode(mode & 3, &env->sse_status);
     }
@@ -1782,17 +1779,16 @@ void glue(helper_roundss, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
                                   ~float_flag_inexact,
                                   &env->sse_status);
     }
-    env->sse_status.float_rounding_mode = prev_rounding_mode;
+    set_float_rounding_mode(prev_rounding_mode, &env->sse_status);
 }
 
 void glue(helper_roundsd, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
                                   uint32_t mode)
 {
     int old_flags = get_float_exception_flags(&env->sse_status);
-    signed char prev_rounding_mode;
+    FloatRoundMode prev_rounding_mode = get_float_rounding_mode(&env->sse_status);
     int i;
 
-    prev_rounding_mode = env->sse_status.float_rounding_mode;
     if (!(mode & (1 << 2))) {
         set_x86_rounding_mode(mode & 3, &env->sse_status);
     }
@@ -1807,7 +1803,7 @@ void glue(helper_roundsd, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s,
                                   ~float_flag_inexact,
                                   &env->sse_status);
     }
-    env->sse_status.float_rounding_mode = prev_rounding_mode;
+    set_float_rounding_mode(prev_rounding_mode, &env->sse_status);
 }
 #endif
 
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 391d8f3169..d99543cc60 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -234,7 +234,7 @@ static inline bool can_use_fpu(const float_status *s)
         return false;
     }
     return likely(s->float_exception_flags & float_flag_inexact &&
-                  s->float_rounding_mode == float_round_nearest_even);
+                  get_float_rounding_mode(s) == float_round_nearest_even);
 }
 
 /*
@@ -2803,7 +2803,7 @@ float16 float16_round_to_int(float16 a, float_status *s)
 {
     FloatParts64 p = float16_unpack_canonical(a, s);
 
-    p = parts64_round_to_int(&p, s->float_rounding_mode, 0, s,
+    p = parts64_round_to_int(&p, get_float_rounding_mode(s), 0, s,
                              &float16_params);
     return float16_round_pack_canonical(&p, s);
 }
@@ -2812,7 +2812,7 @@ float32 float32_round_to_int(float32 a, float_status *s)
 {
     FloatParts64 p = float32_unpack_canonical(a, s);
 
-    p = parts64_round_to_int(&p, s->float_rounding_mode, 0, s,
+    p = parts64_round_to_int(&p, get_float_rounding_mode(s), 0, s,
                              &float32_params);
     return float32_round_pack_canonical(&p, s);
 }
@@ -2821,7 +2821,7 @@ float64 float64_round_to_int(float64 a, float_status *s)
 {
     FloatParts64 p = float64_unpack_canonical(a, s);
 
-    p = parts64_round_to_int(&p, s->float_rounding_mode, 0, s,
+    p = parts64_round_to_int(&p, get_float_rounding_mode(s), 0, s,
                              &float64_params);
     return float64_round_pack_canonical(&p, s);
 }
@@ -2830,7 +2830,7 @@ bfloat16 bfloat16_round_to_int(bfloat16 a, float_status *s)
 {
     FloatParts64 p = bfloat16_unpack_canonical(a, s);
 
-    p = parts64_round_to_int(&p, s->float_rounding_mode, 0, s,
+    p = parts64_round_to_int(&p, get_float_rounding_mode(s), 0, s,
                              &bfloat16_params);
     return bfloat16_round_pack_canonical(&p, s);
 }
@@ -2839,7 +2839,7 @@ float128 float128_round_to_int(float128 a, float_status *s)
 {
     FloatParts128 p = float128_unpack_canonical(a, s);
 
-    p = parts128_round_to_int(&p, s->float_rounding_mode, 0, s,
+    p = parts128_round_to_int(&p, get_float_rounding_mode(s), 0, s,
                               &float128_params);
     return float128_round_pack_canonical(&p, s);
 }
@@ -2852,7 +2852,7 @@ floatx80 floatx80_round_to_int(floatx80 a, float_status *status)
         return floatx80_default_nan(status);
     }
 
-    p = parts128_round_to_int(&p, status->float_rounding_mode, 0, status,
+    p = parts128_round_to_int(&p, get_float_rounding_mode(status), 0, status,
                               &floatx80_params[status->floatx80_rounding_precision]);
     return floatx80_round_pack_canonical(&p, status);
 }
@@ -3050,77 +3050,77 @@ static int64_t floatx80_to_int64_scalbn(floatx80 a, FloatRoundMode rmode,
 
 int8_t float16_to_int8(float16 a, float_status *s)
 {
-    return float16_to_int8_scalbn(a, s->float_rounding_mode, 0, s);
+    return float16_to_int8_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 int16_t float16_to_int16(float16 a, float_status *s)
 {
-    return float16_to_int16_scalbn(a, s->float_rounding_mode, 0, s);
+    return float16_to_int16_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 int32_t float16_to_int32(float16 a, float_status *s)
 {
-    return float16_to_int32_scalbn(a, s->float_rounding_mode, 0, s);
+    return float16_to_int32_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 int64_t float16_to_int64(float16 a, float_status *s)
 {
-    return float16_to_int64_scalbn(a, s->float_rounding_mode, 0, s);
+    return float16_to_int64_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 int16_t float32_to_int16(float32 a, float_status *s)
 {
-    return float32_to_int16_scalbn(a, s->float_rounding_mode, 0, s);
+    return float32_to_int16_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 int32_t float32_to_int32(float32 a, float_status *s)
 {
-    return float32_to_int32_scalbn(a, s->float_rounding_mode, 0, s);
+    return float32_to_int32_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 int64_t float32_to_int64(float32 a, float_status *s)
 {
-    return float32_to_int64_scalbn(a, s->float_rounding_mode, 0, s);
+    return float32_to_int64_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 int16_t float64_to_int16(float64 a, float_status *s)
 {
-    return float64_to_int16_scalbn(a, s->float_rounding_mode, 0, s);
+    return float64_to_int16_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 int32_t float64_to_int32(float64 a, float_status *s)
 {
-    return float64_to_int32_scalbn(a, s->float_rounding_mode, 0, s);
+    return float64_to_int32_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 int64_t float64_to_int64(float64 a, float_status *s)
 {
-    return float64_to_int64_scalbn(a, s->float_rounding_mode, 0, s);
+    return float64_to_int64_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 int32_t float128_to_int32(float128 a, float_status *s)
 {
-    return float128_to_int32_scalbn(a, s->float_rounding_mode, 0, s);
+    return float128_to_int32_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 int64_t float128_to_int64(float128 a, float_status *s)
 {
-    return float128_to_int64_scalbn(a, s->float_rounding_mode, 0, s);
+    return float128_to_int64_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 Int128 float128_to_int128(float128 a, float_status *s)
 {
-    return float128_to_int128_scalbn(a, s->float_rounding_mode, 0, s);
+    return float128_to_int128_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 int32_t floatx80_to_int32(floatx80 a, float_status *s)
 {
-    return floatx80_to_int32_scalbn(a, s->float_rounding_mode, 0, s);
+    return floatx80_to_int32_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 int64_t floatx80_to_int64(floatx80 a, float_status *s)
 {
-    return floatx80_to_int64_scalbn(a, s->float_rounding_mode, 0, s);
+    return floatx80_to_int64_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 int16_t float16_to_int16_round_to_zero(float16 a, float_status *s)
@@ -3195,22 +3195,22 @@ int64_t floatx80_to_int64_round_to_zero(floatx80 a, float_status *s)
 
 int8_t bfloat16_to_int8(bfloat16 a, float_status *s)
 {
-    return bfloat16_to_int8_scalbn(a, s->float_rounding_mode, 0, s);
+    return bfloat16_to_int8_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 int16_t bfloat16_to_int16(bfloat16 a, float_status *s)
 {
-    return bfloat16_to_int16_scalbn(a, s->float_rounding_mode, 0, s);
+    return bfloat16_to_int16_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 int32_t bfloat16_to_int32(bfloat16 a, float_status *s)
 {
-    return bfloat16_to_int32_scalbn(a, s->float_rounding_mode, 0, s);
+    return bfloat16_to_int32_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 int64_t bfloat16_to_int64(bfloat16 a, float_status *s)
 {
-    return bfloat16_to_int64_scalbn(a, s->float_rounding_mode, 0, s);
+    return bfloat16_to_int64_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 int8_t bfloat16_to_int8_round_to_zero(bfloat16 a, float_status *s)
@@ -3489,67 +3489,67 @@ static Int128 float128_to_uint128_scalbn(float128 a, FloatRoundMode rmode,
 
 uint8_t float16_to_uint8(float16 a, float_status *s)
 {
-    return float16_to_uint8_scalbn(a, s->float_rounding_mode, 0, s);
+    return float16_to_uint8_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 uint16_t float16_to_uint16(float16 a, float_status *s)
 {
-    return float16_to_uint16_scalbn(a, s->float_rounding_mode, 0, s);
+    return float16_to_uint16_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 uint32_t float16_to_uint32(float16 a, float_status *s)
 {
-    return float16_to_uint32_scalbn(a, s->float_rounding_mode, 0, s);
+    return float16_to_uint32_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 uint64_t float16_to_uint64(float16 a, float_status *s)
 {
-    return float16_to_uint64_scalbn(a, s->float_rounding_mode, 0, s);
+    return float16_to_uint64_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 uint16_t float32_to_uint16(float32 a, float_status *s)
 {
-    return float32_to_uint16_scalbn(a, s->float_rounding_mode, 0, s);
+    return float32_to_uint16_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 uint32_t float32_to_uint32(float32 a, float_status *s)
 {
-    return float32_to_uint32_scalbn(a, s->float_rounding_mode, 0, s);
+    return float32_to_uint32_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 uint64_t float32_to_uint64(float32 a, float_status *s)
 {
-    return float32_to_uint64_scalbn(a, s->float_rounding_mode, 0, s);
+    return float32_to_uint64_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 uint16_t float64_to_uint16(float64 a, float_status *s)
 {
-    return float64_to_uint16_scalbn(a, s->float_rounding_mode, 0, s);
+    return float64_to_uint16_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 uint32_t float64_to_uint32(float64 a, float_status *s)
 {
-    return float64_to_uint32_scalbn(a, s->float_rounding_mode, 0, s);
+    return float64_to_uint32_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 uint64_t float64_to_uint64(float64 a, float_status *s)
 {
-    return float64_to_uint64_scalbn(a, s->float_rounding_mode, 0, s);
+    return float64_to_uint64_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 uint32_t float128_to_uint32(float128 a, float_status *s)
 {
-    return float128_to_uint32_scalbn(a, s->float_rounding_mode, 0, s);
+    return float128_to_uint32_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 uint64_t float128_to_uint64(float128 a, float_status *s)
 {
-    return float128_to_uint64_scalbn(a, s->float_rounding_mode, 0, s);
+    return float128_to_uint64_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 Int128 float128_to_uint128(float128 a, float_status *s)
 {
-    return float128_to_uint128_scalbn(a, s->float_rounding_mode, 0, s);
+    return float128_to_uint128_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 uint16_t float16_to_uint16_round_to_zero(float16 a, float_status *s)
@@ -3614,22 +3614,22 @@ Int128 float128_to_uint128_round_to_zero(float128 a, float_status *s)
 
 uint8_t bfloat16_to_uint8(bfloat16 a, float_status *s)
 {
-    return bfloat16_to_uint8_scalbn(a, s->float_rounding_mode, 0, s);
+    return bfloat16_to_uint8_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 uint16_t bfloat16_to_uint16(bfloat16 a, float_status *s)
 {
-    return bfloat16_to_uint16_scalbn(a, s->float_rounding_mode, 0, s);
+    return bfloat16_to_uint16_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 uint32_t bfloat16_to_uint32(bfloat16 a, float_status *s)
 {
-    return bfloat16_to_uint32_scalbn(a, s->float_rounding_mode, 0, s);
+    return bfloat16_to_uint32_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 uint64_t bfloat16_to_uint64(bfloat16 a, float_status *s)
 {
-    return bfloat16_to_uint64_scalbn(a, s->float_rounding_mode, 0, s);
+    return bfloat16_to_uint64_scalbn(a, get_float_rounding_mode(s), 0, s);
 }
 
 uint8_t bfloat16_to_uint8_round_to_zero(bfloat16 a, float_status *s)
@@ -4878,7 +4878,7 @@ floatx80 roundAndPackFloatx80(FloatX80RoundPrec roundingPrecision, bool zSign,
     bool roundNearestEven, increment, isTiny;
     int64_t roundIncrement, roundMask, roundBits;
 
-    roundingMode = status->float_rounding_mode;
+    roundingMode = get_float_rounding_mode(status);
     roundNearestEven = ( roundingMode == float_round_nearest_even );
     switch (roundingPrecision) {
     case floatx80_precision_x:
diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 9af77777da..0ced53c54e 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -485,7 +485,7 @@ static uint64_t do_cvttq(CPUAlphaState *env, uint64_t a, int roundmode)
 
 uint64_t helper_cvttq(CPUAlphaState *env, uint64_t a)
 {
-    return do_cvttq(env, a, FP_STATUS.float_rounding_mode);
+    return do_cvttq(env, a, get_float_rounding_mode(&FP_STATUS));
 }
 
 uint64_t helper_cvttq_c(CPUAlphaState *env, uint64_t a)
diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index e692bc568b..5839e82449 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -423,10 +423,10 @@ ftype HELPER(vfp_##name##to##p)(uint##isz##_t  x, uint32_t shift,      \
                                                      float_status *fpst) \
     {                                                                  \
         ftype ret;                                                     \
-        FloatRoundMode oldmode = fpst->float_rounding_mode;            \
-        fpst->float_rounding_mode = float_round_nearest_even;          \
+        FloatRoundMode oldmode = get_float_rounding_mode(fpst);        \
+        set_float_rounding_mode(float_round_nearest_even, fpst);       \
         ret = itype##_to_##float##fsz##_scalbn(x, -shift, fpst);       \
-        fpst->float_rounding_mode = oldmode;                           \
+        set_float_rounding_mode(oldmode, fpst);                        \
         return ret;                                                    \
     }
 
@@ -663,7 +663,7 @@ static uint64_t call_recip_estimate(int *exp, int exp_off, uint64_t frac,
 
 static bool round_to_inf(float_status *fpst, bool sign_bit)
 {
-    switch (fpst->float_rounding_mode) {
+    switch (get_float_rounding_mode(fpst)) {
     case float_round_nearest_even: /* Round to Nearest */
         return true;
     case float_round_up: /* Round to +Inf */
diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
index c557141f11..a90f5c87b6 100644
--- a/target/hexagon/fma_emu.c
+++ b/target/hexagon/fma_emu.c
@@ -315,7 +315,7 @@ static float64 accum_round_float64(Accum a, float_status *fp_status)
     if ((int128_gethi(a.mant) == 0) && (int128_getlo(a.mant) == 0)
         && ((a.guard | a.round | a.sticky) == 0)) {
         /* result zero */
-        switch (fp_status->float_rounding_mode) {
+        switch (get_float_rounding_mode(fp_status)) {
         case float_round_down:
             return zero_float64(1);
         default:
@@ -362,7 +362,7 @@ static float64 accum_round_float64(Accum a, float_status *fp_status)
     /* OK, we're relatively canonical... now we need to round */
     if (a.guard || a.round || a.sticky) {
         float_raise(float_flag_inexact, fp_status);
-        switch (fp_status->float_rounding_mode) {
+        switch (get_float_rounding_mode(fp_status)) {
         case float_round_to_zero:
             /* Chop and we're done */
             break;
@@ -401,7 +401,7 @@ static float64 accum_round_float64(Accum a, float_status *fp_status)
         /* Yep, inf result */
         float_raise(float_flag_overflow, fp_status);
         float_raise(float_flag_inexact, fp_status);
-        switch (fp_status->float_rounding_mode) {
+        switch (get_float_rounding_mode(fp_status)) {
         case float_round_to_zero:
             return maxfinite_float64(a.sign);
         case float_round_up:
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 37c83ded38..7b0b0dd520 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1183,10 +1183,10 @@ void helper_f2xm1(CPUX86State *env)
         bool asign, bsign;
         int32_t n, aexp, bexp;
         uint64_t asig0, asig1, asig2, bsig0, bsig1;
-        FloatRoundMode save_mode = env->fp_status.float_rounding_mode;
+        FloatRoundMode save_mode = get_float_rounding_mode(&env->fp_status);
         FloatX80RoundPrec save_prec =
             env->fp_status.floatx80_rounding_precision;
-        env->fp_status.float_rounding_mode = float_round_nearest_even;
+        set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
         env->fp_status.floatx80_rounding_precision = floatx80_precision_x;
 
         /* Find the nearest multiple of 1/32 to the argument.  */
@@ -1202,7 +1202,7 @@ void helper_f2xm1(CPUX86State *env)
              */
             ST0 = f2xm1_table[n].t;
             set_float_exception_flags(float_flag_inexact, &env->fp_status);
-            env->fp_status.float_rounding_mode = save_mode;
+            set_float_rounding_mode(save_mode, &env->fp_status);
         } else {
             /*
              * Compute the lower parts of a polynomial expansion for
@@ -1282,7 +1282,7 @@ void helper_f2xm1(CPUX86State *env)
                     asign = bsign;
                 }
             }
-            env->fp_status.float_rounding_mode = save_mode;
+            set_float_rounding_mode(save_mode, &env->fp_status);
             /* This result is inexact.  */
             asig1 |= 1;
             ST0 = normalizeRoundAndPackFloatx80(floatx80_precision_x,
@@ -1483,10 +1483,10 @@ void helper_fpatan(CPUX86State *env)
             uint64_t azsig0, azsig1;
             uint64_t azsig2, azsig3, axsig0, axsig1;
             floatx80 x8;
-            FloatRoundMode save_mode = env->fp_status.float_rounding_mode;
+            FloatRoundMode save_mode = get_float_rounding_mode(&env->fp_status);
             FloatX80RoundPrec save_prec =
                 env->fp_status.floatx80_rounding_precision;
-            env->fp_status.float_rounding_mode = float_round_nearest_even;
+            set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
             env->fp_status.floatx80_rounding_precision = floatx80_precision_x;
 
             if (arg0_exp == 0) {
@@ -1793,7 +1793,7 @@ void helper_fpatan(CPUX86State *env)
                 }
             }
 
-            env->fp_status.float_rounding_mode = save_mode;
+            set_float_rounding_mode(save_mode, &env->fp_status);
             env->fp_status.floatx80_rounding_precision = save_prec;
         }
         /* This result is inexact.  */
@@ -2121,10 +2121,10 @@ void helper_fyl2xp1(CPUX86State *env)
     } else {
         int32_t aexp;
         uint64_t asig0, asig1, asig2;
-        FloatRoundMode save_mode = env->fp_status.float_rounding_mode;
+        FloatRoundMode save_mode = get_float_rounding_mode(&env->fp_status);
         FloatX80RoundPrec save_prec =
             env->fp_status.floatx80_rounding_precision;
-        env->fp_status.float_rounding_mode = float_round_nearest_even;
+        set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
         env->fp_status.floatx80_rounding_precision = floatx80_precision_x;
 
         helper_fyl2x_common(env, ST0, &aexp, &asig0, &asig1);
@@ -2139,7 +2139,7 @@ void helper_fyl2xp1(CPUX86State *env)
         aexp += arg1_exp - 0x3ffe;
         /* This result is inexact.  */
         asig1 |= 1;
-        env->fp_status.float_rounding_mode = save_mode;
+        set_float_rounding_mode(save_mode, &env->fp_status);
         ST1 = normalizeRoundAndPackFloatx80(floatx80_precision_x,
                                             arg0_sign ^ arg1_sign, aexp,
                                             asig0, asig1, &env->fp_status);
@@ -2224,10 +2224,10 @@ void helper_fyl2x(CPUX86State *env)
     } else {
         int32_t int_exp;
         floatx80 arg0_m1;
-        FloatRoundMode save_mode = env->fp_status.float_rounding_mode;
+        FloatRoundMode save_mode = get_float_rounding_mode(&env->fp_status);
         FloatX80RoundPrec save_prec =
             env->fp_status.floatx80_rounding_precision;
-        env->fp_status.float_rounding_mode = float_round_nearest_even;
+        set_float_rounding_mode(float_round_nearest_even, &env->fp_status);
         env->fp_status.floatx80_rounding_precision = floatx80_precision_x;
 
         if (arg0_exp == 0) {
@@ -2245,7 +2245,7 @@ void helper_fyl2x(CPUX86State *env)
                                floatx80_one, &env->fp_status);
         if (floatx80_is_zero(arg0_m1)) {
             /* Exact power of 2; multiply by ST1.  */
-            env->fp_status.float_rounding_mode = save_mode;
+            set_float_rounding_mode(save_mode, &env->fp_status);
             ST1 = floatx80_mul(int32_to_floatx80(int_exp, &env->fp_status),
                                ST1, &env->fp_status);
         } else {
@@ -2284,7 +2284,7 @@ void helper_fyl2x(CPUX86State *env)
             aexp += arg1_exp - 0x3ffe;
             /* This result is inexact.  */
             asig1 |= 1;
-            env->fp_status.float_rounding_mode = save_mode;
+            set_float_rounding_mode(save_mode, &env->fp_status);
             ST1 = normalizeRoundAndPackFloatx80(floatx80_precision_x,
                                                 asign ^ arg1_sign, aexp,
                                                 asig0, asig1, &env->fp_status);
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index d1f150e641..51706f6db8 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -266,9 +266,9 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
         return floatx80_move(a, status);
     }
 
-    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_mode = get_float_rounding_mode(status);
     user_rnd_prec = status->floatx80_rounding_precision;
-    status->float_rounding_mode = float_round_nearest_even;
+    set_float_rounding_mode(float_round_nearest_even, status);
     status->floatx80_rounding_precision = floatx80_precision_x;
 
     compact = floatx80_make_compact(aExp, aSig);
@@ -336,7 +336,7 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
                            status); /* LOG(F)+U*V*(A2+V*(A4+V*A6)) */
         fp0 = floatx80_add(fp0, fp1, status); /* FP0 IS LOG(F) + LOG(1+U) */
 
-        status->float_rounding_mode = user_rnd_mode;
+        set_float_rounding_mode(user_rnd_mode, status);
         status->floatx80_rounding_precision = user_rnd_prec;
 
         a = floatx80_add(fp0, klog2, status);
@@ -402,7 +402,7 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
         fp0 = floatx80_mul(fp0, fp1,
                            status); /* U*V*([B1+W*(B3+W*B5)] + [V*(B2+W*B4)]) */
 
-        status->float_rounding_mode = user_rnd_mode;
+        set_float_rounding_mode(user_rnd_mode, status);
         status->floatx80_rounding_precision = user_rnd_prec;
 
         a = floatx80_add(fp0, saveu, status);
@@ -464,9 +464,9 @@ floatx80 floatx80_logn(floatx80 a, float_status *status)
         return floatx80_default_nan(status);
     }
 
-    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_mode = get_float_rounding_mode(status);
     user_rnd_prec = status->floatx80_rounding_precision;
-    status->float_rounding_mode = float_round_nearest_even;
+    set_float_rounding_mode(float_round_nearest_even, status);
     status->floatx80_rounding_precision = floatx80_precision_x;
 
     compact = floatx80_make_compact(aExp, aSig);
@@ -523,7 +523,7 @@ floatx80 floatx80_logn(floatx80 a, float_status *status)
                            status); /* LOG(F)+U*V*(A2+V*(A4+V*A6)) */
         fp0 = floatx80_add(fp0, fp1, status); /* FP0 IS LOG(F) + LOG(1+U) */
 
-        status->float_rounding_mode = user_rnd_mode;
+        set_float_rounding_mode(user_rnd_mode, status);
         status->floatx80_rounding_precision = user_rnd_prec;
 
         a = floatx80_add(fp0, klog2, status);
@@ -569,7 +569,7 @@ floatx80 floatx80_logn(floatx80 a, float_status *status)
         fp0 = floatx80_mul(fp0, fp1,
                            status); /* U*V*([B1+W*(B3+W*B5)] + [V*(B2+W*B4)]) */
 
-        status->float_rounding_mode = user_rnd_mode;
+        set_float_rounding_mode(user_rnd_mode, status);
         status->floatx80_rounding_precision = user_rnd_prec;
 
         a = floatx80_add(fp0, saveu, status);
@@ -620,15 +620,15 @@ floatx80 floatx80_log10(floatx80 a, float_status *status)
         return floatx80_default_nan(status);
     }
 
-    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_mode = get_float_rounding_mode(status);
     user_rnd_prec = status->floatx80_rounding_precision;
-    status->float_rounding_mode = float_round_nearest_even;
+    set_float_rounding_mode(float_round_nearest_even, status);
     status->floatx80_rounding_precision = floatx80_precision_x;
 
     fp0 = floatx80_logn(a, status);
     fp1 = packFloatx80(0, 0x3FFD, UINT64_C(0xDE5BD8A937287195)); /* INV_L10 */
 
-    status->float_rounding_mode = user_rnd_mode;
+    set_float_rounding_mode(user_rnd_mode, status);
     status->floatx80_rounding_precision = user_rnd_prec;
 
     a = floatx80_mul(fp0, fp1, status); /* LOGN(X)*INV_L10 */
@@ -679,13 +679,13 @@ floatx80 floatx80_log2(floatx80 a, float_status *status)
         return floatx80_default_nan(status);
     }
 
-    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_mode = get_float_rounding_mode(status);
     user_rnd_prec = status->floatx80_rounding_precision;
-    status->float_rounding_mode = float_round_nearest_even;
+    set_float_rounding_mode(float_round_nearest_even, status);
     status->floatx80_rounding_precision = floatx80_precision_x;
 
     if (aSig == one_sig) { /* X is 2^k */
-        status->float_rounding_mode = user_rnd_mode;
+        set_float_rounding_mode(user_rnd_mode, status);
         status->floatx80_rounding_precision = user_rnd_prec;
 
         a = int32_to_floatx80(aExp - 0x3FFF, status);
@@ -693,7 +693,7 @@ floatx80 floatx80_log2(floatx80 a, float_status *status)
         fp0 = floatx80_logn(a, status);
         fp1 = packFloatx80(0, 0x3FFF, UINT64_C(0xB8AA3B295C17F0BC)); /* INV_L2 */
 
-        status->float_rounding_mode = user_rnd_mode;
+        set_float_rounding_mode(user_rnd_mode, status);
         status->floatx80_rounding_precision = user_rnd_prec;
 
         a = floatx80_mul(fp0, fp1, status); /* LOGN(X)*INV_L2 */
@@ -739,9 +739,9 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
         return packFloatx80(0, one_exp, one_sig);
     }
 
-    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_mode = get_float_rounding_mode(status);
     user_rnd_prec = status->floatx80_rounding_precision;
-    status->float_rounding_mode = float_round_nearest_even;
+    set_float_rounding_mode(float_round_nearest_even, status);
     status->floatx80_rounding_precision = floatx80_precision_x;
 
     adjflag = 0;
@@ -817,7 +817,7 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
                 fp0 = floatx80_mul(fp0, adjscale, status);
             }
 
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             a = floatx80_mul(fp0, scale, status);
@@ -827,7 +827,7 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
             return a;
         } else { /* |X| >= 16380 log2 */
             if (compact > 0x400CB27C) { /* |X| >= 16480 log2 */
-                status->float_rounding_mode = user_rnd_mode;
+                set_float_rounding_mode(user_rnd_mode, status);
                 status->floatx80_rounding_precision = user_rnd_prec;
                 if (aSign) {
                     a = roundAndPackFloatx80(
@@ -876,7 +876,7 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
             }
         }
     } else { /* |X| < 2^(-65) */
-        status->float_rounding_mode = user_rnd_mode;
+        set_float_rounding_mode(user_rnd_mode, status);
         status->floatx80_rounding_precision = user_rnd_prec;
 
         a = floatx80_add(a, float32_to_floatx80(make_float32(0x3F800000),
@@ -922,9 +922,9 @@ floatx80 floatx80_twotox(floatx80 a, float_status *status)
         return packFloatx80(0, one_exp, one_sig);
     }
 
-    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_mode = get_float_rounding_mode(status);
     user_rnd_prec = status->floatx80_rounding_precision;
-    status->float_rounding_mode = float_round_nearest_even;
+    set_float_rounding_mode(float_round_nearest_even, status);
     status->floatx80_rounding_precision = floatx80_precision_x;
 
     fp0 = a;
@@ -934,7 +934,7 @@ floatx80 floatx80_twotox(floatx80 a, float_status *status)
     if (compact < 0x3FB98000 || compact > 0x400D80C0) {
         /* |X| > 16480 or |X| < 2^(-70) */
         if (compact > 0x3FFF8000) { /* |X| > 16480 */
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             if (aSign) {
@@ -945,7 +945,7 @@ floatx80 floatx80_twotox(floatx80 a, float_status *status)
                                             0, 0x8000, aSig, 0, status);
             }
         } else { /* |X| < 2^(-70) */
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             a = floatx80_add(fp0, float32_to_floatx80(
@@ -1027,7 +1027,7 @@ floatx80 floatx80_twotox(floatx80 a, float_status *status)
         fp0 = floatx80_add(fp0, fact2, status);
         fp0 = floatx80_add(fp0, fact1, status);
 
-        status->float_rounding_mode = user_rnd_mode;
+        set_float_rounding_mode(user_rnd_mode, status);
         status->floatx80_rounding_precision = user_rnd_prec;
 
         a = floatx80_mul(fp0, adjfact, status);
@@ -1072,9 +1072,9 @@ floatx80 floatx80_tentox(floatx80 a, float_status *status)
         return packFloatx80(0, one_exp, one_sig);
     }
 
-    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_mode = get_float_rounding_mode(status);
     user_rnd_prec = status->floatx80_rounding_precision;
-    status->float_rounding_mode = float_round_nearest_even;
+    set_float_rounding_mode(float_round_nearest_even, status);
     status->floatx80_rounding_precision = floatx80_precision_x;
 
     fp0 = a;
@@ -1084,7 +1084,7 @@ floatx80 floatx80_tentox(floatx80 a, float_status *status)
     if (compact < 0x3FB98000 || compact > 0x400B9B07) {
         /* |X| > 16480 LOG2/LOG10 or |X| < 2^(-70) */
         if (compact > 0x3FFF8000) { /* |X| > 16480 */
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             if (aSign) {
@@ -1095,7 +1095,7 @@ floatx80 floatx80_tentox(floatx80 a, float_status *status)
                                             0, 0x8000, aSig, 0, status);
             }
         } else { /* |X| < 2^(-70) */
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             a = floatx80_add(fp0, float32_to_floatx80(
@@ -1182,7 +1182,7 @@ floatx80 floatx80_tentox(floatx80 a, float_status *status)
         fp0 = floatx80_add(fp0, fact2, status);
         fp0 = floatx80_add(fp0, fact1, status);
 
-        status->float_rounding_mode = user_rnd_mode;
+        set_float_rounding_mode(user_rnd_mode, status);
         status->floatx80_rounding_precision = user_rnd_prec;
 
         a = floatx80_mul(fp0, adjfact, status);
@@ -1227,9 +1227,9 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
         return packFloatx80(aSign, 0, 0);
     }
 
-    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_mode = get_float_rounding_mode(status);
     user_rnd_prec = status->floatx80_rounding_precision;
-    status->float_rounding_mode = float_round_nearest_even;
+    set_float_rounding_mode(float_round_nearest_even, status);
     status->floatx80_rounding_precision = floatx80_precision_x;
 
     compact = floatx80_make_compact(aExp, aSig);
@@ -1294,7 +1294,7 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
             fp1 = floatx80_add(fp1, fp3, status); /* FP1 is r := (A-R)+a */
             goto loop;
         } else {
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             a = floatx80_move(a, status);
@@ -1354,7 +1354,7 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
             xSign ^= 1;
             fp1 = packFloatx80(xSign, xExp, xSig);
 
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             a = floatx80_div(fp0, fp1, status);
@@ -1392,7 +1392,7 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
                                make_float32(0x3F800000), status),
                                status); /* 1+S(Q1+S(Q2+S(Q3+SQ4))) */
 
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             a = floatx80_div(fp0, fp1, status);
@@ -1438,9 +1438,9 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
         return packFloatx80(aSign, 0, 0);
     }
 
-    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_mode = get_float_rounding_mode(status);
     user_rnd_prec = status->floatx80_rounding_precision;
-    status->float_rounding_mode = float_round_nearest_even;
+    set_float_rounding_mode(float_round_nearest_even, status);
     status->floatx80_rounding_precision = floatx80_precision_x;
 
     compact = floatx80_make_compact(aExp, aSig);
@@ -1509,7 +1509,7 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
             fp0 = float32_to_floatx80(make_float32(0x3F800000),
                                       status); /* 1 */
 
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             /* SINTINY */
@@ -1582,7 +1582,7 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
             x = packFloatx80(xSign, xExp, xSig);
             fp0 = floatx80_mul(fp0, x, status);
 
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             a = floatx80_add(fp0, float32_to_floatx80(posneg1, status), status);
@@ -1632,7 +1632,7 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
             fp0 = floatx80_mul(fp0, x, status); /* R'*S */
             fp0 = floatx80_mul(fp0, fp1, status); /* SIN(R')-R' */
 
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             a = floatx80_add(fp0, x, status);
@@ -1678,9 +1678,9 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
         return packFloatx80(0, one_exp, one_sig);
     }
 
-    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_mode = get_float_rounding_mode(status);
     user_rnd_prec = status->floatx80_rounding_precision;
-    status->float_rounding_mode = float_round_nearest_even;
+    set_float_rounding_mode(float_round_nearest_even, status);
     status->floatx80_rounding_precision = floatx80_precision_x;
 
     compact = floatx80_make_compact(aExp, aSig);
@@ -1748,7 +1748,7 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
             /* SINSM */
             fp0 = float32_to_floatx80(make_float32(0x3F800000), status); /* 1 */
 
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             /* COSTINY */
@@ -1822,7 +1822,7 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
             x = packFloatx80(xSign, xExp, xSig);
             fp0 = floatx80_mul(fp0, x, status);
 
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             a = floatx80_add(fp0, float32_to_floatx80(posneg1, status), status);
@@ -1870,7 +1870,7 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
             fp0 = floatx80_mul(fp0, x, status); /* R'*S */
             fp0 = floatx80_mul(fp0, fp1, status); /* SIN(R')-R' */
 
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             a = floatx80_add(fp0, x, status);
@@ -1917,9 +1917,9 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
 
     compact = floatx80_make_compact(aExp, aSig);
 
-    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_mode = get_float_rounding_mode(status);
     user_rnd_prec = status->floatx80_rounding_precision;
-    status->float_rounding_mode = float_round_nearest_even;
+    set_float_rounding_mode(float_round_nearest_even, status);
     status->floatx80_rounding_precision = floatx80_precision_x;
 
     if (compact < 0x3FFB8000 || compact > 0x4002FFFF) {
@@ -1929,7 +1929,7 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
                 fp0 = packFloatx80(aSign, piby2_exp, pi_sig);
                 fp1 = packFloatx80(aSign, 0x0001, one_sig);
 
-                status->float_rounding_mode = user_rnd_mode;
+                set_float_rounding_mode(user_rnd_mode, status);
                 status->floatx80_rounding_precision = user_rnd_prec;
 
                 a = floatx80_sub(fp0, fp1, status);
@@ -1969,7 +1969,7 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
                 fp0 = floatx80_add(fp0, xsave, status);
                 fp1 = packFloatx80(aSign, piby2_exp, pi_sig);
 
-                status->float_rounding_mode = user_rnd_mode;
+                set_float_rounding_mode(user_rnd_mode, status);
                 status->floatx80_rounding_precision = user_rnd_prec;
 
                 a = floatx80_add(fp0, fp1, status);
@@ -1980,7 +1980,7 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
             }
         } else { /* |X| < 1/16 */
             if (compact < 0x3FD78000) { /* |X| < 2^(-40) */
-                status->float_rounding_mode = user_rnd_mode;
+                set_float_rounding_mode(user_rnd_mode, status);
                 status->floatx80_rounding_precision = user_rnd_prec;
 
                 a = floatx80_move(a, status);
@@ -2020,7 +2020,7 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
                 /* X*Y*([B1+Z*(B3+Z*B5)]+[Y*(B2+Z*(B4+Z*B6))]) */
                 fp0 = floatx80_mul(fp0, fp1, status);
 
-                status->float_rounding_mode = user_rnd_mode;
+                set_float_rounding_mode(user_rnd_mode, status);
                 status->floatx80_rounding_precision = user_rnd_prec;
 
                 a = floatx80_add(fp0, xsave, status);
@@ -2069,7 +2069,7 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
         fp1 = floatx80_mul(fp1, fp2, status); /* A1*U*V*(A2+V*(A3+V)) */
         fp0 = floatx80_add(fp0, fp1, status); /* ATAN(U) */
 
-        status->float_rounding_mode = user_rnd_mode;
+        set_float_rounding_mode(user_rnd_mode, status);
         status->floatx80_rounding_precision = user_rnd_prec;
 
         a = floatx80_add(fp0, fp3, status); /* ATAN(X) */
@@ -2122,9 +2122,9 @@ floatx80 floatx80_asin(floatx80 a, float_status *status)
 
     } /* |X| < 1 */
 
-    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_mode = get_float_rounding_mode(status);
     user_rnd_prec = status->floatx80_rounding_precision;
-    status->float_rounding_mode = float_round_nearest_even;
+    set_float_rounding_mode(float_round_nearest_even, status);
     status->floatx80_rounding_precision = floatx80_precision_x;
 
     one = packFloatx80(0, one_exp, one_sig);
@@ -2136,7 +2136,7 @@ floatx80 floatx80_asin(floatx80 a, float_status *status)
     fp1 = floatx80_sqrt(fp1, status);       /* SQRT((1+X)*(1-X)) */
     fp0 = floatx80_div(fp0, fp1, status);   /* X/SQRT((1+X)*(1-X)) */
 
-    status->float_rounding_mode = user_rnd_mode;
+    set_float_rounding_mode(user_rnd_mode, status);
     status->floatx80_rounding_precision = user_rnd_prec;
 
     a = floatx80_atan(fp0, status);         /* ATAN(X/SQRT((1+X)*(1-X))) */
@@ -2192,9 +2192,9 @@ floatx80 floatx80_acos(floatx80 a, float_status *status)
         }
     } /* |X| < 1 */
 
-    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_mode = get_float_rounding_mode(status);
     user_rnd_prec = status->floatx80_rounding_precision;
-    status->float_rounding_mode = float_round_nearest_even;
+    set_float_rounding_mode(float_round_nearest_even, status);
     status->floatx80_rounding_precision = floatx80_precision_x;
 
     one = packFloatx80(0, one_exp, one_sig);
@@ -2206,7 +2206,7 @@ floatx80 floatx80_acos(floatx80 a, float_status *status)
     fp0 = floatx80_sqrt(fp0, status);       /* SQRT((1-X)/(1+X)) */
     fp0 = floatx80_atan(fp0, status);       /* ATAN(SQRT((1-X)/(1+X))) */
 
-    status->float_rounding_mode = user_rnd_mode;
+    set_float_rounding_mode(user_rnd_mode, status);
     status->floatx80_rounding_precision = user_rnd_prec;
 
     a = floatx80_add(fp0, fp0, status);     /* 2 * ATAN(SQRT((1-X)/(1+X))) */
@@ -2256,9 +2256,9 @@ floatx80 floatx80_atanh(floatx80 a, float_status *status)
         }
     } /* |X| < 1 */
 
-    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_mode = get_float_rounding_mode(status);
     user_rnd_prec = status->floatx80_rounding_precision;
-    status->float_rounding_mode = float_round_nearest_even;
+    set_float_rounding_mode(float_round_nearest_even, status);
     status->floatx80_rounding_precision = floatx80_precision_x;
 
     one = packFloatx80(0, one_exp, one_sig);
@@ -2270,7 +2270,7 @@ floatx80 floatx80_atanh(floatx80 a, float_status *status)
     fp0 = floatx80_div(fp0, fp1, status); /* Z = 2Y/(1-Y) */
     fp0 = floatx80_lognp1(fp0, status); /* LOG1P(Z) */
 
-    status->float_rounding_mode = user_rnd_mode;
+    set_float_rounding_mode(user_rnd_mode, status);
     status->floatx80_rounding_precision = user_rnd_prec;
 
     a = floatx80_mul(fp0, fp2,
@@ -2315,9 +2315,9 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
         return packFloatx80(aSign, 0, 0);
     }
 
-    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_mode = get_float_rounding_mode(status);
     user_rnd_prec = status->floatx80_rounding_precision;
-    status->float_rounding_mode = float_round_nearest_even;
+    set_float_rounding_mode(float_round_nearest_even, status);
     status->floatx80_rounding_precision = floatx80_precision_x;
 
     if (aExp >= 0x3FFD) { /* |X| >= 1/4 */
@@ -2410,7 +2410,7 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
 
             sc = packFloatx80(0, m + 0x3FFF, one_sig);
 
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             a = floatx80_mul(fp0, sc, status);
@@ -2423,7 +2423,7 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
                 fp0 = float32_to_floatx80(make_float32(0xBF800000),
                       status); /* -1 */
 
-                status->float_rounding_mode = user_rnd_mode;
+                set_float_rounding_mode(user_rnd_mode, status);
                 status->floatx80_rounding_precision = user_rnd_prec;
 
                 a = floatx80_add(fp0, float32_to_floatx80(
@@ -2434,7 +2434,7 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
 
                 return a;
             } else {
-                status->float_rounding_mode = user_rnd_mode;
+                set_float_rounding_mode(user_rnd_mode, status);
                 status->floatx80_rounding_precision = user_rnd_prec;
 
                 return floatx80_etox(a, status);
@@ -2495,7 +2495,7 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
             fp1 = floatx80_add(fp1, fp2, status); /* Q */
             fp0 = floatx80_add(fp0, fp1, status); /* S*B1+Q */
 
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             a = floatx80_add(fp0, a, status);
@@ -2513,14 +2513,14 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
                                    status);
                 fp0 = floatx80_add(fp0, sc, status);
 
-                status->float_rounding_mode = user_rnd_mode;
+                set_float_rounding_mode(user_rnd_mode, status);
                 status->floatx80_rounding_precision = user_rnd_prec;
 
                 a = floatx80_mul(fp0, float64_to_floatx80(
                                  make_float64(0x3730000000000000), status),
                                  status);
             } else {
-                status->float_rounding_mode = user_rnd_mode;
+                set_float_rounding_mode(user_rnd_mode, status);
                 status->floatx80_rounding_precision = user_rnd_prec;
 
                 a = floatx80_add(fp0, sc, status);
@@ -2565,9 +2565,9 @@ floatx80 floatx80_tanh(floatx80 a, float_status *status)
         return packFloatx80(aSign, 0, 0);
     }
 
-    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_mode = get_float_rounding_mode(status);
     user_rnd_prec = status->floatx80_rounding_precision;
-    status->float_rounding_mode = float_round_nearest_even;
+    set_float_rounding_mode(float_round_nearest_even, status);
     status->floatx80_rounding_precision = floatx80_precision_x;
 
     compact = floatx80_make_compact(aExp, aSig);
@@ -2576,7 +2576,7 @@ floatx80 floatx80_tanh(floatx80 a, float_status *status)
         /* TANHBORS */
         if (compact < 0x3FFF8000) {
             /* TANHSM */
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             a = floatx80_move(a, status);
@@ -2593,7 +2593,7 @@ floatx80 floatx80_tanh(floatx80 a, float_status *status)
                 sign &= 0x80000000;
                 sign ^= 0x80800000; /* -SIGN(X)*EPS */
 
-                status->float_rounding_mode = user_rnd_mode;
+                set_float_rounding_mode(user_rnd_mode, status);
                 status->floatx80_rounding_precision = user_rnd_prec;
 
                 a = floatx80_add(fp0, float32_to_floatx80(make_float32(sign),
@@ -2615,7 +2615,7 @@ floatx80 floatx80_tanh(floatx80 a, float_status *status)
                 fp0 = float32_to_floatx80(make_float32(sign | 0x3F800000),
                                           status); /* SIGN */
 
-                status->float_rounding_mode = user_rnd_mode;
+                set_float_rounding_mode(user_rnd_mode, status);
                 status->floatx80_rounding_precision = user_rnd_prec;
 
                 a = floatx80_add(fp1, fp0, status);
@@ -2638,7 +2638,7 @@ floatx80 floatx80_tanh(floatx80 a, float_status *status)
 
         fp1 = packFloatx80(vSign ^ aSign, vExp, vSig);
 
-        status->float_rounding_mode = user_rnd_mode;
+        set_float_rounding_mode(user_rnd_mode, status);
         status->floatx80_rounding_precision = user_rnd_prec;
 
         a = floatx80_div(fp0, fp1, status);
@@ -2681,9 +2681,9 @@ floatx80 floatx80_sinh(floatx80 a, float_status *status)
         return packFloatx80(aSign, 0, 0);
     }
 
-    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_mode = get_float_rounding_mode(status);
     user_rnd_prec = status->floatx80_rounding_precision;
-    status->float_rounding_mode = float_round_nearest_even;
+    set_float_rounding_mode(float_round_nearest_even, status);
     status->floatx80_rounding_precision = floatx80_precision_x;
 
     compact = floatx80_make_compact(aExp, aSig);
@@ -2691,7 +2691,7 @@ floatx80 floatx80_sinh(floatx80 a, float_status *status)
     if (compact > 0x400CB167) {
         /* SINHBIG */
         if (compact > 0x400CB2B3) {
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             return roundAndPackFloatx80(status->floatx80_rounding_precision,
@@ -2707,7 +2707,7 @@ floatx80 floatx80_sinh(floatx80 a, float_status *status)
             fp0 = floatx80_etox(fp0, status);
             fp2 = packFloatx80(aSign, 0x7FFB, one_sig);
 
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             a = floatx80_mul(fp0, fp2, status);
@@ -2727,7 +2727,7 @@ floatx80 floatx80_sinh(floatx80 a, float_status *status)
 
         fact = packFloat32(aSign, 0x7E, 0);
 
-        status->float_rounding_mode = user_rnd_mode;
+        set_float_rounding_mode(user_rnd_mode, status);
         status->floatx80_rounding_precision = user_rnd_prec;
 
         a = floatx80_mul(fp0, float32_to_floatx80(fact, status), status);
@@ -2767,16 +2767,16 @@ floatx80 floatx80_cosh(floatx80 a, float_status *status)
         return packFloatx80(0, one_exp, one_sig);
     }
 
-    user_rnd_mode = status->float_rounding_mode;
+    user_rnd_mode = get_float_rounding_mode(status);
     user_rnd_prec = status->floatx80_rounding_precision;
-    status->float_rounding_mode = float_round_nearest_even;
+    set_float_rounding_mode(float_round_nearest_even, status);
     status->floatx80_rounding_precision = floatx80_precision_x;
 
     compact = floatx80_make_compact(aExp, aSig);
 
     if (compact > 0x400CB167) {
         if (compact > 0x400CB2B3) {
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
             return roundAndPackFloatx80(status->floatx80_rounding_precision, 0,
                                         0x8000, one_sig, 0, status);
@@ -2791,7 +2791,7 @@ floatx80 floatx80_cosh(floatx80 a, float_status *status)
             fp0 = floatx80_etox(fp0, status);
             fp1 = packFloatx80(0, 0x7FFB, one_sig);
 
-            status->float_rounding_mode = user_rnd_mode;
+            set_float_rounding_mode(user_rnd_mode, status);
             status->floatx80_rounding_precision = user_rnd_prec;
 
             a = floatx80_mul(fp0, fp1, status);
@@ -2809,7 +2809,7 @@ floatx80 floatx80_cosh(floatx80 a, float_status *status)
     fp1 = float32_to_floatx80(make_float32(0x3E800000), status); /* 1/4 */
     fp1 = floatx80_div(fp1, fp0, status); /* 1/(2*EXP(|X|)) */
 
-    status->float_rounding_mode = user_rnd_mode;
+    set_float_rounding_mode(user_rnd_mode, status);
     status->floatx80_rounding_precision = user_rnd_prec;
 
     a = floatx80_add(fp0, fp1, status);
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index 850aca6ed1..c1bdde9e10 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -1616,7 +1616,7 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opcode,
 
     tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
-        tstat.float_rounding_mode = float_round_to_odd;
+        set_float_rounding_mode(float_round_to_odd, &tstat);
     }
 
     set_float_exception_flags(0, &tstat);
@@ -1688,7 +1688,7 @@ void helper_xsmulqp(CPUPPCState *env, uint32_t opcode,
     helper_reset_fpstatus(env);
     tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
-        tstat.float_rounding_mode = float_round_to_odd;
+        set_float_rounding_mode(float_round_to_odd, &tstat);
     }
 
     set_float_exception_flags(0, &tstat);
@@ -1762,7 +1762,7 @@ void helper_xsdivqp(CPUPPCState *env, uint32_t opcode,
     helper_reset_fpstatus(env);
     tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
-        tstat.float_rounding_mode = float_round_to_odd;
+        set_float_rounding_mode(float_round_to_odd, &tstat);
     }
 
     set_float_exception_flags(0, &tstat);
@@ -2095,7 +2095,7 @@ void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *s1, ppc_vsr_t *s2,\
     float_status tstat = env->fp_status;                                       \
     set_float_exception_flags(0, &tstat);                                      \
     if (ro) {                                                                  \
-        tstat.float_rounding_mode = float_round_to_odd;                        \
+        set_float_rounding_mode(float_round_to_odd, &tstat);                   \
     }                                                                          \
     t.f128 = float128_muladd(s1->f128, s3->f128, s2->f128, maddflgs, &tstat);  \
     env->fp_status.float_exception_flags |= tstat.float_exception_flags;       \
@@ -2706,7 +2706,7 @@ void helper_XSCVQPDP(CPUPPCState *env, uint32_t ro, ppc_vsr_t *xt,
 
     tstat = env->fp_status;
     if (ro != 0) {
-        tstat.float_rounding_mode = float_round_to_odd;
+        set_float_rounding_mode(float_round_to_odd, &tstat);
     }
 
     t.VsrD(0) = float128_to_float64(xb->f128, &tstat);
@@ -3306,7 +3306,7 @@ void helper_xssqrtqp(CPUPPCState *env, uint32_t opcode,
 
     tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
-        tstat.float_rounding_mode = float_round_to_odd;
+        set_float_rounding_mode(float_round_to_odd, &tstat);
     }
 
     set_float_exception_flags(0, &tstat);
@@ -3332,7 +3332,7 @@ void helper_xssubqp(CPUPPCState *env, uint32_t opcode,
 
     tstat = env->fp_status;
     if (unlikely(Rc(opcode) != 0)) {
-        tstat.float_rounding_mode = float_round_to_odd;
+        set_float_rounding_mode(float_round_to_odd, &tstat);
     }
 
     set_float_exception_flags(0, &tstat);
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 5a3554dd71..c826702bf8 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4270,9 +4270,9 @@ static uint64_t frec7(uint64_t f, int exp_size, int frac_size,
             s->float_exception_flags |= (float_flag_inexact |
                                          float_flag_overflow);
 
-            if ((s->float_rounding_mode == float_round_to_zero) ||
-                ((s->float_rounding_mode == float_round_down) && !sign) ||
-                ((s->float_rounding_mode == float_round_up) && sign)) {
+            if ((get_float_rounding_mode(s) == float_round_to_zero) ||
+                ((get_float_rounding_mode(s) == float_round_down) && !sign) ||
+                ((get_float_rounding_mode(s) == float_round_up) && sign)) {
                 /* Return greatest/negative finite value. */
                 return (sign << (exp_size + frac_size)) |
                        (MAKE_64BIT_MASK(frac_size, exp_size) - 1);
diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index 33e0f6100d..6ca0b7162b 100644
--- a/target/s390x/tcg/fpu_helper.c
+++ b/target/s390x/tcg/fpu_helper.c
@@ -62,7 +62,7 @@ static int s390_get_bfp_rounding_mode(CPUS390XState *env, int m3)
     switch (m3) {
     case 0:
         /* current mode */
-        return env->fpu_status.float_rounding_mode;
+        return get_float_rounding_mode(&env->fpu_status);
     case 1:
         /* round to nearest with ties away from 0 */
         return float_round_ties_away;
@@ -634,7 +634,7 @@ uint32_t HELPER(cxb)(CPUS390XState *env, Int128 a, Int128 b)
 
 int s390_swap_bfp_rounding_mode(CPUS390XState *env, int m3)
 {
-    int ret = env->fpu_status.float_rounding_mode;
+    int ret = get_float_rounding_mode(&env->fpu_status);
 
     set_float_rounding_mode(s390_get_bfp_rounding_mode(env, m3),
                             &env->fpu_status);
diff --git a/tests/fp/fp-bench.c b/tests/fp/fp-bench.c
index d90f542ea2..2b6f66817e 100644
--- a/tests/fp/fp-bench.c
+++ b/tests/fp/fp-bench.c
@@ -615,7 +615,7 @@ static void set_soft_precision(enum rounding rounding)
     default:
         g_assert_not_reached();
     }
-    soft_status.float_rounding_mode = mode;
+    set_float_rounding_mode(mode, &soft_status);
 }
 
 static void parse_args(int argc, char *argv[])
diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index c619e5dbf7..fdb0cccf14 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -967,7 +967,7 @@ void run_test(void)
 
             verCases_roundingCode = 0;
             slowfloat_roundingMode = rmode;
-            qsf.float_rounding_mode = sf_rounding_to_qemu(rmode);
+            set_float_rounding_mode(sf_rounding_to_qemu(rmode), &qsf);
 
             if (attrs & (FUNC_ARG_ROUNDINGMODE | FUNC_EFF_ROUNDINGMODE)) {
                 /* print rounding mode if the op is affected by it */
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index bc348f75a3..7311c3696e 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -300,7 +300,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
     int exp;
     FloatExceptionFlags flags = 0;
 
-    switch (s->float_rounding_mode) {
+    switch (get_float_rounding_mode(s)) {
     case float_round_nearest_even_max:
         overflow_norm = true;
         /* fall through */
@@ -431,7 +431,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
 
         if (p->frac_lo & round_mask) {
             /* Need to recompute round-to-even/round-to-odd. */
-            switch (s->float_rounding_mode) {
+            switch (get_float_rounding_mode(s)) {
             case float_round_nearest_even:
                 if (N > 64 && frac_lsb == 0) {
                     inc = ((p->frac_hi & 1) ||
@@ -558,7 +558,7 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
 
         if (ab_mask == float_cmask_zero) {
             /* 0 - 0 */
-            a.sign = s->float_rounding_mode == float_round_down;
+            a.sign = get_float_rounding_mode(s) == float_round_down;
             return a;
         }
 
@@ -763,7 +763,7 @@ FloatPartsN partsN(muladd)(const FloatPartsN *a, const FloatPartsN *b,
  return_sub_zero:
     /* 0 - 0 == -0 for round_down, +0 otherwise. */
     return (FloatPartsN){
-        .sign = s->float_rounding_mode == float_round_down,
+        .sign = get_float_rounding_mode(s) == float_round_down,
         .cls = float_class_zero
     };
 
diff --git a/tests/fp/wrap.c.inc b/tests/fp/wrap.c.inc
index 9ff884c140..a67b390e5a 100644
--- a/tests/fp/wrap.c.inc
+++ b/tests/fp/wrap.c.inc
@@ -168,7 +168,7 @@ WRAP_SF_TO_128(qemu_f64_to_f128M, float64_to_float128, float64)
     {                                                                   \
         type *ap = (type *)&a;                                          \
                                                                         \
-        qsf.float_rounding_mode = sf_rounding_to_qemu(round);           \
+        set_float_rounding_mode(sf_rounding_to_qemu(round), &qsf);      \
         return func(*ap, &qsf);                                         \
     }
 
@@ -328,7 +328,7 @@ WRAP_INT_TO_80(qemu_i64_to_extF80M, int64_to_floatx80, int64_t)
         floatx80 a;                                                     \
                                                                         \
         a = soft_to_qemu80(*ap);                                        \
-        qsf.float_rounding_mode = sf_rounding_to_qemu(round);           \
+        set_float_rounding_mode(sf_rounding_to_qemu(round), &qsf);      \
         return func(a, &qsf);                                           \
     }
 
@@ -360,7 +360,7 @@ WRAP_80_TO_INT_MINMAG(qemu_extF80M_to_i64_r_minMag,
         float128 a;                                                     \
                                                                         \
         a = soft_to_qemu128(*ap);                                       \
-        qsf.float_rounding_mode = sf_rounding_to_qemu(round);           \
+        set_float_rounding_mode(sf_rounding_to_qemu(round), &qsf);      \
         return func(a, &qsf);                                           \
     }
 
@@ -414,7 +414,7 @@ WRAP_INT_TO_128(qemu_i64_to_f128M, int64_to_float128, int64_t)
         type *ap = (type *)&a;                                          \
         type ret;                                                       \
                                                                         \
-        qsf.float_rounding_mode = sf_rounding_to_qemu(round);           \
+        set_float_rounding_mode(sf_rounding_to_qemu(round), &qsf);      \
         ret = func(*ap, &qsf);                                          \
         return *(type##_t *)&ret;                                       \
     }
@@ -431,7 +431,7 @@ static void qemu_extF80M_roundToInt(const extFloat80_t *ap, uint_fast8_t round,
     floatx80 ret;
 
     a = soft_to_qemu80(*ap);
-    qsf.float_rounding_mode = sf_rounding_to_qemu(round);
+    set_float_rounding_mode(sf_rounding_to_qemu(round), &qsf);
     ret = floatx80_round_to_int(a, &qsf);
     *res = qemu_to_soft80(ret);
 }
@@ -443,7 +443,7 @@ static void qemu_f128M_roundToInt(const float128_t *ap, uint_fast8_t round,
     float128 ret;
 
     a = soft_to_qemu128(*ap);
-    qsf.float_rounding_mode = sf_rounding_to_qemu(round);
+    set_float_rounding_mode(sf_rounding_to_qemu(round), &qsf);
     ret = float128_round_to_int(a, &qsf);
     *res = qemu_to_soft128(ret);
 }
-- 
2.43.0


