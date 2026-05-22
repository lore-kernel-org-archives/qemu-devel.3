Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CB5CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUb2-0004pf-IY; Fri, 22 May 2026 14:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUay-0004lM-6C
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:40 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUaw-0005PN-6J
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:39 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b458ca2296so56004825ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474457; x=1780079257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6pOylLIPPF3SzGGD/hO5sB9wT9twUN2F4g4tckWWxE=;
 b=eKX2Fx4E+ua434tjuaBvpkG+XvXSW2CSX+3QKwBhmhHZntQFH0pZZvCXOuhFYD6Eft
 vf3XYII2bUfQ35NtJaPcdwftmnk+BPU14QmA7CMafVag6Y+pTfHgWwVnzNfrAZITIFLK
 Snpa06tLJnAT2bIUsX5H2ZTlDvP1DBhxzyi0BRbLN0BqmlqsEJWyNe6UljGTgcrGExJ5
 t8j1WgK5bltMqObBIo7ED5WS6AuXCe0JetiLF/zdawEUMEfwFTg/7Ss6lfPT4jN0W5Zh
 qAQZ0Tw7aV3Gr2GeHB9MGe8Hp/gMZYS0CsOaBqavtlQ1443wGEf+fPC+891Bh4rGAMmo
 M6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474457; x=1780079257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N6pOylLIPPF3SzGGD/hO5sB9wT9twUN2F4g4tckWWxE=;
 b=So/KERLSnfUKDSsE+mslBo5V08tjiV/Fkl1vc1IXo0scF5rwA31TcFFRFM7OgIYkcK
 HU65VCIHq0AxvxUyiNtkVTchX2JfsI+ffijxhXlp1WubG6HEwRjjZd1/+0+xEdb7BW7y
 1/ukIs6g1YAGC0ycFIaxoBdErx7yLfsXPXtJ0IEuNg2Z19dwpzZv7U3Y1XRUdk0UfdAV
 8PalvvzTh3e0TRrNbjtKpcIKyN5WYoC+JxbdOSruhJ3KYwBD41LaWWDfHg6CaE3eZwsg
 cppbQh1S6sL+3rw+8p0TOlGSbS2IYfyCAkn3M+Rl/oeOPUZBpzfkX/PHQwn6dWrhzQR8
 nsGg==
X-Gm-Message-State: AOJu0YwOw7dOwYfDcY+S9Ivt6FsXbIq6zYKyw5EsL2bgg52smPM2uPPl
 U5zXAtbxfF7EEOBCt+dxBMgh0+pY+YPH3zSy+nLcWqyr9zBsDAlTkuVpWkfsA+PMOUL5XGiwtf1
 t5ReR
X-Gm-Gg: Acq92OE1ESnPpGJ6OBftsoEW87ftwAuYc/K7cKrHgtImAwXhW/HsRCy5VJ05dmBu4JG
 9DQSyWxnQPNTHdn7UTxC3NqkxJz/ktHFP+rhRrcJ6Svp/dlaF3Ov9e/k5D3veMhDN+GCWUPvFbA
 qV16ByWR3XjP/fDz5j7p/dh6yEXgHhMNkkoVy0BHtza5ckvAbhEYp99XwSN6kp0sHPUR3txXVEb
 KpEWewCw1MKm0JEUQnj//95hHmZ3YjL2LkFA2aAt3ocx1epD531qfj0jtn7A/gkvvDJ9UQud4yr
 JuuohlUVDzqBBiuZFbCxtnPvyInKd2uXB3rLLjsXqYkrBIZfcPkJ2v+/hyJhDFk6XJ2BrjdCi/o
 rzn7GEw4MXdFKVcYSP6z/M2NNMWs15sfb1g4GQy0384Eoy34AALKd9V8wzG05DwR5jlCX6SQxos
 +QTAPvjtv47Xx+trOs8zG8xAj274pc
X-Received: by 2002:a17:902:fc48:b0:2b0:c45a:bc2 with SMTP id
 d9443c01a7336-2beb059cebcmr51923135ad.16.1779474456695; 
 Fri, 22 May 2026 11:27:36 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/30] fpu: Introduce FloatExceptionFlags
Date: Fri, 22 May 2026 11:26:38 -0700
Message-ID: <20260522182658.184604-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


