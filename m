Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A87C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlUDI-000283-1v; Fri, 21 Feb 2025 09:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlUDG-00027V-0t
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:41:10 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlUDD-0006Na-SC
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:41:09 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso14056755e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 06:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740148865; x=1740753665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ytf/9Z3XeJMD7xaiGw0J9GGs9IYtrINu7waX4wKwDr8=;
 b=unG7V2ECIqnS0xaKjG88Ggos4jxQTw+x/lM2rez9v1CQUVl0jEbXfg4ksII+ZIEPIx
 S4WBuX0jK8aY52GRQALOnYGRVZA8cjGDsUGCpT6PSdq9QCjwvTAY4IygX04iKzRpX91c
 CSsyW8R/+3baOtZi3v4PJfd1OpcjW72kDdg5ShfDkk6MtWsmtExu64Nh4aVLGeb9m0AM
 qe2GNfoLjukUAbITPhxHzkF7GNrdxJkWIe3btMT3/D0uzZ46pc+A5h5hJ3OcfOPHAVam
 8ARFZwKVIgAUK3rTddg0gKXO9JlBpl8luiWT5iFHDOkvM6VreH4H9ZuMxhgguuAMN/Is
 R6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740148865; x=1740753665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ytf/9Z3XeJMD7xaiGw0J9GGs9IYtrINu7waX4wKwDr8=;
 b=wNziT+0i0xPHSrXCBG/msmLaXsNap4qI5faL02uCqsPQczYedMQZfoGQiWIVAgfdgT
 YtaerwMPOABPTAlp9aTqO4TNGDPQHMmfuVtqNjKS5CmX8FeArzurjKc1buYKOtY4o0Hx
 P5XiNU7cXHcNM+NdYWi3Df9Zk8my6lfzdhL7wRoSsVn21YBt4SgUtwtGhszJQfJupTX+
 gwWB5lAYYt11p92JhIV/8QEH4l2r3iQr4exLGWuU2QwRH1NWdV+DMC0PD1l8uvweMg1E
 C/jhuxGI1qrRxtewFaHx8xV1RUq+X98zxusqRK1uNk7J3o9hUODVGibol+mSN7bM+eZU
 jd8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyxkxv9nMgMJyJsRg8lUj3Be0v3q13dL9xc54cx6cyF0IXKYeF4sbK7dQr3BGa4CDJNaQTPxxY7+dP@nongnu.org
X-Gm-Message-State: AOJu0YyynIx6JzIkNbv4lFd8oanTb10HZV7zhQoOdd7ien9pYZq2hMiJ
 Y2C1+5O0RQgNsVp5DzVpvJ6cmd+KFcXEVqDrC5vlt5K5Ae1SyqEl+KjNHGHJ+DL3UerqEpPD1+H
 gQis=
X-Gm-Gg: ASbGncsf4eKM8FO4jfcUL7jPIlA9pRCxTMzBtew2TJfN+SdQiDTuGWqif+1fkJ2ZliI
 LKGRPHxBkS3MmUchHPbAI4c7SIlvpbl8KocWBaqHC6j4UGDVLPn6T8L8gnJBsujWfI3BURKcPWB
 55odbgRCBFPZk1WEwZ1jRs8aWAFbaDxNDsei3im9MikNVAEZV3JU9sbYzHcd/WFE3lLq3IYTfri
 WcLLOA0f9M+ISuLV7ysXG+4ynD1sgRrMWblvIwae+0RqGFS3sv7KW9dTPA8CsjVj4y47WKiGMpO
 oYHagPa4BmfI1A1FYYiYdDZp2ofpM6YNRMKqM6tdJ/RF3dG6JHRMcfzWTcdGHb+tidbmBw==
X-Google-Smtp-Source: AGHT+IEcd97yOQp1o9rmjpCPju1nBxMAWmT+F0y/T9pzuBF8Ixnw9mbBBrbg19IMpvZLty0qA7sJjg==
X-Received: by 2002:a05:600c:a384:b0:439:8a8c:d3ca with SMTP id
 5b1f17b1804b1-439ae21d2a0mr29584495e9.29.1740148865243; 
 Fri, 21 Feb 2025 06:41:05 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02e489esm19280735e9.21.2025.02.21.06.41.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 06:41:04 -0800 (PST)
Message-ID: <93307c7c-c29f-4061-94ae-461bf196ff41@linaro.org>
Date: Fri, 21 Feb 2025 15:41:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] fpu: Remove remaining target ifdefs and build only
 once
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250217125055.160887-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/2/25 13:50, Peter Maydell wrote:

> (1) floatx80 behaviours
> 
> Two QEMU targets implement floatx80: x86 and m68k. (PPC also has one
> use in the xsrqpxp round-to-80-bit-precision operation, and the
> Linux-user NWFPE emulation nominally supports it, but these are
> minor.) x86 and m68k disagree about some of the corner cases of
> floatx80 where the value has the explicit Integer bit wrongly set.  At
> the moment the fpu code defaults to "floatx80 behaves like x86", with
> TARGET_M68K ifdefs to get the other option.
> 
> The first six patches in this series remove those ifdefs, replacing
> them with a floatx80_behaviour field in float_status which can have
> various flags set to select the individual behaviours. The default is
> "like x86", which allows us to set these only for m68k and not worry
> about the minor "technically makes some use of floatx80" cases.


> Peter Maydell (10):
>    fpu: Make targets specify floatx80 default Inf at runtime
>    target/m68k: Avoid using floatx80_infinity global const
>    target/i386: Avoid using floatx80_infinity global const

Bothering again, we can add the floatx80_default_inf() refactor as the
first patch:

-- >8 --
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 09a40b43106..afae3906024 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -963,0 +964 @@ extern const floatx80 floatx80_infinity;
+floatx80 floatx80_default_inf(bool zSign, float_status *status);
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index f4fed9bfda9..f56ae886c53 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5147,3 +5147 @@ floatx80 roundAndPackFloatx80(FloatX80RoundPrec 
roundingPrecision, bool zSign,
-            return packFloatx80(zSign,
-                                floatx80_infinity_high,
-                                floatx80_infinity_low);
+            return floatx80_default_inf(zSign, status);
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index f112c6c6737..741af09f908 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -1835 +1835 @@ void helper_fxtract(CPUX86State *env)
-        ST1 = floatx80_infinity;
+        ST1 = floatx80_default_inf(0, &env->fp_status);
@@ -2361,3 +2361,2 @@ void helper_fscale(CPUX86State *env)
-                ST0 = (floatx80_is_neg(ST0) ?
-                       floatx80_chs(floatx80_infinity) :
-                       floatx80_infinity);
+                ST0 = floatx80_default_inf(floatx80_is_neg(ST0),
+                                           &env->fp_status);
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 02dcc03d15d..d1f150e641f 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -145,2 +145 @@ floatx80 floatx80_scale(floatx80 a, floatx80 b, 
float_status *status)
-        return packFloatx80(aSign, floatx80_infinity.high,
-                            floatx80_infinity.low);
+        return floatx80_default_inf(aSign, status);
@@ -248 +247 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
-        return packFloatx80(0, floatx80_infinity.high, 
floatx80_infinity.low);
+        return floatx80_default_inf(0, status);
@@ -258,2 +257 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
-            return packFloatx80(aSign, floatx80_infinity.high,
-                                floatx80_infinity.low);
+            return floatx80_default_inf(aSign, status);
@@ -445,2 +443 @@ floatx80 floatx80_logn(floatx80 a, float_status *status)
-            return packFloatx80(0, floatx80_infinity.high,
-                                floatx80_infinity.low);
+            return floatx80_default_inf(0, status);
@@ -455,2 +452 @@ floatx80 floatx80_logn(floatx80 a, float_status *status)
-            return packFloatx80(1, floatx80_infinity.high,
-                                floatx80_infinity.low);
+            return floatx80_default_inf(1, status);
@@ -613,2 +609 @@ floatx80 floatx80_log10(floatx80 a, float_status *status)
-            return packFloatx80(0, floatx80_infinity.high,
-                                floatx80_infinity.low);
+            return floatx80_default_inf(0, status);
@@ -620,2 +615 @@ floatx80 floatx80_log10(floatx80 a, float_status *status)
-        return packFloatx80(1, floatx80_infinity.high,
-                            floatx80_infinity.low);
+        return floatx80_default_inf(1, status);
@@ -671,2 +665 @@ floatx80 floatx80_log2(floatx80 a, float_status *status)
-            return packFloatx80(0, floatx80_infinity.high,
-                                floatx80_infinity.low);
+            return floatx80_default_inf(0, status);
@@ -679,2 +672 @@ floatx80 floatx80_log2(floatx80 a, float_status *status)
-            return packFloatx80(1, floatx80_infinity.high,
-                                floatx80_infinity.low);
+            return floatx80_default_inf(1, status);
@@ -743,2 +735 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
-        return packFloatx80(0, floatx80_infinity.high,
-                            floatx80_infinity.low);
+        return floatx80_default_inf(0, status);
@@ -927,2 +918 @@ floatx80 floatx80_twotox(floatx80 a, float_status *status)
-        return packFloatx80(0, floatx80_infinity.high,
-                            floatx80_infinity.low);
+        return floatx80_default_inf(0, status);
@@ -1078,2 +1068 @@ floatx80 floatx80_tentox(floatx80 a, float_status 
*status)
-        return packFloatx80(0, floatx80_infinity.high,
-                            floatx80_infinity.low);
+        return floatx80_default_inf(0, status);
@@ -2263,2 +2252 @@ floatx80 floatx80_atanh(floatx80 a, float_status 
*status)
-            return packFloatx80(aSign, floatx80_infinity.high,
-                                floatx80_infinity.low);
+            return floatx80_default_inf(aSign, status);
@@ -2323,2 +2311 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status 
*status)
-        return packFloatx80(0, floatx80_infinity.high,
-                            floatx80_infinity.low);
+        return floatx80_default_inf(0, status);
@@ -2690,2 +2677 @@ floatx80 floatx80_sinh(floatx80 a, float_status *status)
-        return packFloatx80(aSign, floatx80_infinity.high,
-                            floatx80_infinity.low);
+        return floatx80_default_inf(aSign, status);
@@ -2777,2 +2763 @@ floatx80 floatx80_cosh(floatx80 a, float_status *status)
-        return packFloatx80(0, floatx80_infinity.high,
-                            floatx80_infinity.low);
+        return floatx80_default_inf(0, status);
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index cbbbab52ba3..403f7a9d69d 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -239,0 +240,5 @@ const floatx80 floatx80_infinity
+floatx80 floatx80_default_inf(bool zSign, float_status *status)
+{
+    return packFloatx80(zSign, floatx80_infinity_high, 
floatx80_infinity_low);
+}
+
---

The single non-obvious thing to mention is the x86 floatx80_chs()
removal.

This effectively absorb patch #3 (x86).

Then patch #2 (m68k) becomes:

-- >8 --
diff --git a/include/fpu/softfloat-helpers.h 
b/include/fpu/softfloat-helpers.h
index 8983c2748ec..90862f5cd22 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -77,0 +78,6 @@ static inline void 
set_floatx80_rounding_precision(FloatX80RoundPrec val,
+static inline void set_floatx80_behaviour(FloatX80Behaviour b,
+                                          float_status *status)
+{
+    status->floatx80_behaviour = b;
+}
+
@@ -153,0 +160,6 @@ get_floatx80_rounding_precision(const float_status 
*status)
+static inline FloatX80Behaviour
+get_floatx80_behaviour(const float_status *status)
+{
+    return status->floatx80_behaviour;
+}
+
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 53d5eb85210..dd22ecdbe60 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -322,0 +323,12 @@ typedef enum __attribute__((__packed__)) {
+/*
+ * floatx80 is primarily used by x86 and m68k, and there are
+ * differences in the handling, largely related to the explicit
+ * Integer bit which floatx80 has and the other float formats do not.
+ * These flag values allow specification of the target's requirements
+ * and can be ORed together to set floatx80_behaviour.
+ */
+typedef enum __attribute__((__packed__)) {
+    /* In the default Infinity value, is the Integer bit 0 ? */
+    floatx80_default_inf_int_bit_is_zero = 1,
+} FloatX80Behaviour;
+
@@ -333,0 +346 @@ typedef struct float_status {
+    FloatX80Behaviour floatx80_behaviour;
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index f56ae886c53..b12ad2b42a9 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1863 +1863,2 @@ static floatx80 
floatx80_round_pack_canonical(FloatParts128 *p,
-        frac = floatx80_infinity_low;
+        frac = s->floatx80_behaviour & 
floatx80_default_inf_int_bit_is_zero ?
+               0 : (1ULL << 63);
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 41dfdf58045..df66e8ba22a 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -109,0 +110,6 @@ static void m68k_cpu_reset_hold(Object *obj, 
ResetType type)
+    /*
+     * m68k-specific floatx80 behaviour:
+     *  * default Infinity values have a zero Integer bit
+     */
+    set_floatx80_behaviour(floatx80_default_inf_int_bit_is_zero,
+                           &env->fp_status);
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 403f7a9d69d..77a43f46597 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -242 +242,6 @@ floatx80 floatx80_default_inf(bool zSign, float_status 
*status)
-    return packFloatx80(zSign, floatx80_infinity_high, 
floatx80_infinity_low);
+    /*
+     * Whether the Integer bit is set in the default Infinity is
+     * target dependent.
+     */
+    bool z = status->floatx80_behaviour & 
floatx80_default_inf_int_bit_is_zero;
+    return packFloatx80(zSign, 0x7fff, z ? 0 : (1ULL << 63));
---

