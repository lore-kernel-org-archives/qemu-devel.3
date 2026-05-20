Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FC6CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkZ7-0001SC-82; Wed, 20 May 2026 13:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ0-0001MZ-Dj
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:34 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkYw-0001ul-JK
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:34 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-36608b2f2dcso3178142a91.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297509; x=1779902309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6pOylLIPPF3SzGGD/hO5sB9wT9twUN2F4g4tckWWxE=;
 b=JTOVlhN0hKj6eFfy2eKZhjK5YuTQYkM6LaBb0GQtIWgNarywX7EqqB3f+6NzzfE8QD
 /pBQK6pPp+HQziBz16KMipe3XsbLKgCXqQiu3h2wOI8sVRBJS4O7I9SoqB/hkSBYlM0I
 TqoJaSa6quvdlTNVvKQlsKVu/2eUmJFY+4vNe53SOQ+c6LYARtXgiWlyBfrnrRoqSLVc
 XBe0BMfzweqVxwEtJN47Cj3dcnO2DH1KX/O8MXWviHB5IYhVE1lVaE+1JQ0uHEBc9/9P
 hIdAdj8aIVvrErTVxMgXMX1AJH+fgyOH/Qj/zvBDK/1JTlF7VhYB609FvweXolbLg+Yj
 +WxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297509; x=1779902309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N6pOylLIPPF3SzGGD/hO5sB9wT9twUN2F4g4tckWWxE=;
 b=Ks7wu9siw08aBMFbopAP8PosEFO7omtp9nj/Q70R2tynnCZhdHXMvhTMIiMBhOEqzM
 6QnbHBSwNyusdtD87jh1fhe7zR3RQuN2u2Y2xplyQbs9iPI91nAZK7brPsFLjpwpWTpu
 kqXyS/jrYRaNBuS1lcgx4IC+ycFFMn7ABXOzPG/6nTEiXMt2Q+SBxkUXJcbg0gJP2AAW
 4yOq6NG43BKcQeSG95hzJ1TchTaHikr6Y13q7x5UFGpSNipjTqDrP0KzL4orIHatUH05
 JrQmxPxtK8TIcXhOkng3dI7fj93zwKHlWX6RR1LiroccswjRS6lwjqP32jQAV1J5FlO7
 PlpA==
X-Gm-Message-State: AOJu0Yx6/IUc4s91LI5Id4S9ejGUKqskzFEX7DUr5eeH4MKpCDqdFVAX
 DIhsVYW0ZhNQx7iFEF+Gmww2LDxUoyhJsdqmKyW78UAxGcbtD0C6Up8wiewLK95MuJglBx8zWzK
 mBoQV4rU=
X-Gm-Gg: Acq92OHSZ/4cvNVxKi+qtada4WdImcdNz5LJI/9GeV2ah4SLLjFemKa89XUVu4YK9kE
 inrOC9686es/R6xzrZzkJbhRAeq9Wo+U5ocHMUCxco/hD+MTsoZxgyYwuYoNBBlEQYApyfxTHWa
 B5JrLCfqQfC1fPPahE7T0PtgmZ/wYZ0pt1mjfBpQOB6+xXUx13ZP5DXxJ3YUgFohq7ZvDo7H3wB
 ep4erwxreP4kXxx7wu221c7eCr0B+K+/hmC5AZvmoJcufLSq78qkzEQ8HUPZYaNXPDmnS9+XtBd
 qdBXW1yyiQjNwXe4P8jxew8c7qlutQRKd3CXJzyjisAokWAty0n3XDMDetEhk7W0CwrwRWT3RRe
 2sp/Zpedvf/DKuuFAQDbmJPavswRcsRLnKw8B1nQLobX4NNPmkZwQqBJ27ixxmMOEB2sE5I9HRE
 /xD+OpR9ju3en6xR1EGZe/i/iAMtZq
X-Received: by 2002:a17:90b:4a8a:b0:368:6998:b49d with SMTP id
 98e67ed59e1d1-369519cbf0bmr24408819a91.10.1779297509011; 
 Wed, 20 May 2026 10:18:29 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 10/30] fpu: Introduce FloatExceptionFlags
Date: Wed, 20 May 2026 10:18:00 -0700
Message-ID: <20260520171820.848839-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

We have, in the past, used any of uint8_t, uint16_t or int
to hold the set of exception flags.  Use a typedef instead.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h | 6 ++++--
 include/fpu/softfloat-types.h   | 4 +++-
 include/fpu/softfloat.h         | 2 +-
 fpu/softfloat.c                 | 2 +-
 fpu/softfloat-parts.c.inc       | 7 ++++---
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 90862f5cd2..745a49f07a 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -64,7 +64,8 @@ static inline void set_float_rounding_mode(FloatRoundMode val,
     status->float_rounding_mode = val;
 }
 
-static inline void set_float_exception_flags(int val, float_status *status)
+static inline void
+set_float_exception_flags(FloatExceptionFlags val, float_status *status)
 {
     status->float_exception_flags = val;
 }
@@ -146,7 +147,8 @@ static inline FloatRoundMode get_float_rounding_mode(const float_status *status)
     return status->float_rounding_mode;
 }
 
-static inline int get_float_exception_flags(const float_status *status)
+static inline FloatExceptionFlags
+get_float_exception_flags(const float_status *status)
 {
     return status->float_exception_flags;
 }
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index ead146c22d..5048faa76f 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -181,6 +181,8 @@ enum {
     float_flag_input_denormal_used = 0x4000,
 };
 
+typedef uint16_t FloatExceptionFlags;
+
 /*
  * Rounding precision for floatx80.
  */
@@ -385,7 +387,7 @@ typedef enum __attribute__((__packed__)) {
  */
 
 typedef struct float_status {
-    uint16_t float_exception_flags;
+    FloatExceptionFlags float_exception_flags;
     FloatRoundMode float_rounding_mode;
     FloatX80RoundPrec floatx80_rounding_precision;
     FloatX80Behaviour floatx80_behaviour;
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 1580d956d5..4ae4ddc799 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -101,7 +101,7 @@ typedef enum {
 | Routine to raise any or all of the software IEC/IEEE floating-point
 | exception flags.
 *----------------------------------------------------------------------------*/
-static inline void float_raise(uint16_t flags, float_status *status)
+static inline void float_raise(FloatExceptionFlags flags, float_status *status)
 {
     status->float_exception_flags |= flags;
 }
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index df94f299e1..391d8f3169 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2976,7 +2976,7 @@ static int64_t float128_to_int64_scalbn(float128 a, FloatRoundMode rmode,
 static Int128 float128_to_int128_scalbn(float128 a, FloatRoundMode rmode,
                                         int scale, float_status *s)
 {
-    int flags = 0;
+    FloatExceptionFlags flags = 0;
     Int128 r;
     FloatParts128 p = float128_unpack_canonical(a, s);
 
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 4715187017..bc348f75a3 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -297,7 +297,8 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
     const uint64_t roundeven_mask = round_mask | frac_lsb;
     uint64_t inc;
     bool overflow_norm = saturate;
-    int exp, flags = 0;
+    int exp;
+    FloatExceptionFlags flags = 0;
 
     switch (s->float_rounding_mode) {
     case float_round_nearest_even_max:
@@ -1256,7 +1257,7 @@ static int64_t partsN(float_to_sint)(FloatPartsN *p, FloatRoundMode rmode,
                                      int scale, int64_t min, int64_t max,
                                      float_status *s)
 {
-    int flags = 0;
+    FloatExceptionFlags flags = 0;
     uint64_t r;
 
     switch (p->cls) {
@@ -1324,7 +1325,7 @@ static int64_t partsN(float_to_sint)(FloatPartsN *p, FloatRoundMode rmode,
 static uint64_t partsN(float_to_uint)(FloatPartsN *p, FloatRoundMode rmode,
                                       int scale, uint64_t max, float_status *s)
 {
-    int flags = 0;
+    FloatExceptionFlags flags = 0;
     uint64_t r;
 
     switch (p->cls) {
-- 
2.43.0


