Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA95CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkZU-0001m2-2y; Wed, 20 May 2026 13:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZE-0001a2-Sl
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:48 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkZ8-00020q-AQ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:48 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3697f25d26eso2646479a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297521; x=1779902321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZFFZPDMpbzdsj37a9/p1FZxebig9+4EbrHozdK8lKs=;
 b=FGBHIIsWjAWHTiYfsJzsz7B1BL+Mh13/bavrT+MWum8lksazwMyMjnN3FiCrns7fhp
 D6VsvfP5oxeg/P6xq8v3IILet2ZkafpZOcXGz/fmSPYqZ7HoUz78vASQPgKPGcruzHqC
 JVvOz0KNiopJP8TIaDfl7O3XQh9lzXWP9XBck6JvEU9W+rDAsK12IxmEK9dkCcjeIbKd
 5JzEimVk0VhUMjz8ZpM6Q8OuJJQMP3gyn0QL0yyE9sSrAwRWllTHgiL1N+Ul5ZjdVnsx
 rzO96Obf94zee0MIh7OCfOTOOE04YnxvfnZ/8yKQC+A7NhUo+R8RJ46xg388rIbGcMqP
 X1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297521; x=1779902321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cZFFZPDMpbzdsj37a9/p1FZxebig9+4EbrHozdK8lKs=;
 b=ov21kiY6e9+Vevse2nfGzGXbIBKt/LYYn1uX+IyqxYGqn2ghzba50s/bgqMwwFtKmh
 hhKbTIFxkFDZfHuxfxcyBvD0WkSxHG6kwk+35gv0anGoypdkeqmRtSi0L7IrGPNZ6rRR
 dXpayvYm/dTyjBDG3EUeeI0RHtDzk5oWvLFxHo8M02/TaeeixxxC0R9n/SwBjW6/+MXx
 04sZgZj1aUsD2IV23mkoO4d0eb8nsHTfPT2VuEtrVivCDaNBIBmIE9nic2LEGxnpsL2U
 TLGkKmn9ljkbCvH1Q8UDEOOp3wLpf8yQXl4QxaT+CYNnr6xkLsdo/YjazkEhOnvGHH8L
 99qw==
X-Gm-Message-State: AOJu0Yy5Cw6mrVwJGQyizifFLRK1t0X0fuCabuVMDdY5/7YL8DE1Xa9a
 NoA0rnIVN7IPs6r1AJ77cUddT6zi5RiYT9pnC4XCe656hkqnjpEQcsab9yqms0CMTEmMQJ0XYzC
 QlTeomyY=
X-Gm-Gg: Acq92OFoSYfZcezPSn0JjPUL3DBjBwg2k2Lehnw9a18uBi9Iw6KJphH/5C3ITQM0mlX
 WxNWkD2kLqkhX5qJdUcrx3UaxCf1PwYnPiJ0e0PlT2k+u9+kwsvvYxHOauhezBBbsgIO4YwU6iq
 EMrikZz4Fea2oqNDHvRTvPM+0ri4/M0tZRkaLXVk4LJhMe74nypv7UlKALNSMD9sOZ/OHLglD0A
 uTbsLo5HLKQhmESE1V12OdWbGgbSgugfH4TmrFSlF9joUZxIuLFz6PC3GXoSDA46tBeAEMSsu6p
 Elmb7cIFU9JvvfpmdRW8XHKdn47F9d7AlObLESKZsJxp8HB4xQ4k4pZLZNfDDOorrhjucNHh/oE
 xCba8TQ4vB46pL8/qZReXUGZIU33zQhw9IEJjVJSwSV26gmRQ5cZBfypklBKheC/eQGUbk60nOI
 pysNO9FI/txSlGVXySJJGDR68YEoe3K3n9uo1fLdE=
X-Received: by 2002:a17:90b:2f08:b0:369:996d:282c with SMTP id
 98e67ed59e1d1-369996d2ea1mr16182128a91.9.1779297520833; 
 Wed, 20 May 2026 10:18:40 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 27/30] fpu: Reorg float_status
Date: Wed, 20 May 2026 10:18:17 -0700
Message-ID: <20260520171820.848839-28-richard.henderson@linaro.org>
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

Use bitfields to compress float_status from 18 bytes down to 8 bytes.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-types.h | 53 ++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 67b7f38aef..c5a6684763 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -327,7 +327,7 @@ typedef enum __attribute__((__packed__)) {
      * This is a flag which can be ORed in with any of the above
      * DNaN behaviour options.
      */
-    float_infzeronan_suppress_invalid = (1 << 7),
+    float_infzeronan_suppress_invalid = (1 << 2),
 } FloatInfZeroNaNRule;
 
 /*
@@ -402,22 +402,39 @@ typedef enum __attribute__((__packed__)) {
  */
 
 typedef struct float_status {
-    FloatExceptionFlags float_exception_flags;
-    FloatRoundMode float_rounding_mode;
-    FloatX80RoundPrec floatx80_rounding_precision;
-    FloatX80Behaviour floatx80_behaviour;
-    Float2NaNPropRule float_2nan_prop_rule;
-    Float3NaNPropRule float_3nan_prop_rule;
-    FloatInfZeroNaNRule float_infzeronan_rule;
-    FloatSNaNRule float_snan_rule;
-    bool tininess_before_rounding;
+    FloatExceptionFlags float_exception_flags : 16;
+
+    /*
+     * Floating point status controls.
+     * Items that, in general, may be updated by writes to an architectural
+     * floating point control register.
+     */
+    FloatRoundMode float_rounding_mode : 3;
+    FloatX80RoundPrec floatx80_rounding_precision : 2;
     /* should denormalised results go to zero and set output_denormal_flushed? */
-    bool flush_to_zero;
-    /* do we detect and flush denormal results before or after rounding? */
-    bool ftz_before_rounding;
+    bool flush_to_zero : 1;
     /* should denormalised inputs go to zero and set input_denormal_flushed? */
-    bool flush_inputs_to_zero;
-    bool default_nan_mode;
+    bool flush_inputs_to_zero : 1;
+    /* should default nans be produced instead of propagating an input nan? */
+    bool default_nan_mode : 1;
+    /* should overflowed results subtract re_bias to its exponent? */
+    bool rebias_overflow : 1;
+    /* should underflowed results add re_bias to its exponent? */
+    bool rebias_underflow : 1;
+
+    /*
+     * Floating point behaviour controls.
+     * Items that, in general, will be set at cpu realization because
+     * the behaviour is baked into the specific hardware implementation.
+     */
+    bool tininess_before_rounding : 1;
+    /* do we detect and flush denormal results before or after rounding? */
+    bool ftz_before_rounding : 1;
+    FloatSNaNRule float_snan_rule : 2;
+    Float2NaNPropRule float_2nan_prop_rule : 3;
+    Float3NaNPropRule float_3nan_prop_rule : 7;
+    FloatInfZeroNaNRule float_infzeronan_rule: 3;
+    FloatX80Behaviour floatx80_behaviour : 5;
     /*
      * The pattern to use for the default NaN. Here the high bit specifies
      * the default NaN's sign bit, and bits 6..0 specify the high bits of the
@@ -427,11 +444,7 @@ typedef struct float_status {
      * this to the correct non-zero value, or we will assert when trying to
      * create a default NaN.
      */
-    uint8_t default_nan_pattern;
-    /* should overflowed results subtract re_bias to its exponent? */
-    bool rebias_overflow;
-    /* should underflowed results add re_bias to its exponent? */
-    bool rebias_underflow;
+    unsigned default_nan_pattern : 8;
 } float_status;
 
 #endif /* SOFTFLOAT_TYPES_H */
-- 
2.43.0


