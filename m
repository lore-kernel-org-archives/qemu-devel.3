Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459BACD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjry-0004iy-3P; Wed, 20 May 2026 12:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPjrj-0004hb-9d
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:33:51 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPjrf-0004E4-5V
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:33:48 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6587cee8b57so6059490d50.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 09:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779294826; cv=none;
 d=google.com; s=arc-20240605;
 b=O7uGjTulusgsNBrNILeJj7mVatoS2L5ja3nXta+eYSxAXy/I9IEmvU28cAgpWg4Vcx
 PCsCI2tD6o66mb1FBJqIVHTh1n0tcSVyUsuybIiEqlQR+U2+Z9BmykT9cBnhDaBxPbLl
 VabLD0iKaCDhFklrYmv7pWnwcjJlCmJ85YKid7+0OKVLWVVq3sccY0AqGvre7CCq1Qi2
 X8EitXkEtuuHGjgR6YztCQ+hUWmbmszCfRFivyU06NSPWcxk7mzI4ZqQD8VkKC5Axl8N
 WagzzZ6+mRQAy6dFG4pvFMYf9Fos6ECpl7cKGdzzxeZA+OYd4UrAzPbUxPu70w24Pz1X
 yzpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ilXmKd4vt5E2uTWQGrfTbvCC8r36p1523wjeuX6smhY=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=VDftD0MjnZfhhmIuDK2O2ahGcnJoKqulaOVHdpFkEiTyesZj22A3PoVSQHUt4SXBWz
 8ezp/f+Q4t7Vj/04PB5jV0kodAOczEEGh2/qpafBSnD8IcodGHTcq0BFAScR1y0oHTfS
 UHHp47C6Xt7xJ+VXR/YqEzVgzX5Td2wlMTRIXcjRjzhQgypGv8Eyix4jlzpxblXrjvWw
 Txah7vIxM9LbX4NvhVEqgFEzC4doBJFI8uXmBRT78tKnZuwKKnKU2nUvr3+Oy2PdjYrK
 etZKwg24YD/8uwgJlxTEly44xz+wE1hretnOZ8ahDdvkIAXzEkJDJkBt6QDb3pJ6JYne
 xpzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779294825; x=1779899625; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ilXmKd4vt5E2uTWQGrfTbvCC8r36p1523wjeuX6smhY=;
 b=ydht2wzvCBx86FnaKnE3HX1aakgAt3ntMO8p36EFfbO2gskazRC7L1HLO9+vy5NQsg
 8LvyOSrg7wHk/tkmRhi+w5GPey8wkAUEKGPwlUvig0z1/GiaE0n7mTnM2E5brndlpfTH
 /Q0T6BJosB2FiuiCE3lmVdXy+GmGmamrZ/wBpjIOVUlG1429zEUtuN+joSrGtSjM9c+G
 DoxSAAazmQeciHhQTX5sP12uR+08q8GD8m5L9h9NiueX7pug2qDf/jbqgx6HTAwLPWCN
 ZwZMr1f1WJkziM6yLaIwoOvWz/UO5PoLsQP9zLBwhq0How70gac8t9dkaX1B9fJ7CmWu
 Jlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779294826; x=1779899626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ilXmKd4vt5E2uTWQGrfTbvCC8r36p1523wjeuX6smhY=;
 b=fvACsR51G/sK9J/MvJg9Yxr0UUnoOrmHNbcve3DW06rgjHmbdcm8nOT02+9r0O1XOi
 UWeKKtvJTFDy0AqjWftHukEHw/kvfuO2XfL2dh8D20+HyyTgsB6iazoSCGUThU1P0UbB
 8GH3amn9Deva/K0NWuE2HayMRvn3JLKuQJmxyJlFqE5i6xFOSKt2Y+KrrQwErSZHVfnl
 qFy2Vo9HfocPtM8/uNvp7o6zP9Dg1v21rFXB54h17XTBMqi0uSMkkPwCpzifA7ndUMwa
 W8s8ABrv/GekfmmSQu9ac9vCPCDm+F5lzS/hE5vOIDkyC16K5bUbdLOkGfABg3que24w
 HJcQ==
X-Gm-Message-State: AOJu0YxX11o+X/0oB5Gbo6HDK2wBCaYUoPNUsxRFL5wszddbSs59vspI
 hRGloq1xUnRPnfL79c6xgozbN7MUPyOFY2cpq9s7E3KXkm7u09AgWqwn2FVqxEP0zbyepDBEeOy
 O3ztoAy34bP39UYkT6/9+zZq54ovdp1sBT0hccqxmsA==
X-Gm-Gg: Acq92OESLu6sO6tddTdzKUts10XPmjp5lAn4SP1OvyykauVW2U0r8DD6uVQwjFkafbH
 EhVPqgYaYwVTPdYWXV0LWak4GkJJqAgHp2clMfu5w2Yg5rtNx6PhTZEbOCp0MqUMO9boMWLYq3y
 9n2EK6XTyYMsx7KgUgfuLWCgq3XNR/JiJk6721oH2bVFaG7prH1EhhQcRGBOvb+wIIK0ZZqHL5a
 7z+SdmPws80BWdirkjfMGp2MUg0JRRS2VP75SsrMa/6LrmGVc1DVcvFhSv0yAekMZMaddKkJThQ
 My/j9UH+aMEmQgRs2RjxnjUelP9NZmMOrwMBi++/oprO9LX703fT8i16gUS1pc9vyw8=
X-Received: by 2002:a05:690e:419b:b0:650:7841:6dd with SMTP id
 956f58d0204a3-65e2284edfemr21837183d50.31.1779294825598; Wed, 20 May 2026
 09:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260517003002.321430-1-richard.henderson@linaro.org>
 <20260517003002.321430-46-richard.henderson@linaro.org>
In-Reply-To: <20260517003002.321430-46-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 May 2026 17:33:33 +0100
X-Gm-Features: AVHnY4K2AklTn3F9OotRAPjhpJILGgV9OVczu7Hx9StKnIOJRaPt27OijCdhr58
Message-ID: <CAFEAcA_Qr+D+qrTd7q0s8Ka0YF5NVM01dDMHm3irQDxiZW0n6g@mail.gmail.com>
Subject: Re: [PATCH v5 45/63] target/arm: Implement FMLALB, FMLALT for AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Sun, 17 May 2026 at 01:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>



> +static FP8MulContext fp8_mul_start(CPUARMState *env, int scale_mask)
> +{
> +    uint64_t fpmr = env->vfp.fpmr;
> +
> +    FP8MulContext ret = {
> +        .stat = env->vfp.fp_status[FPST_A64],
> +        .fmt1 = fp8_input_fmt[FIELD_EX64(fpmr, FPMR, F8S1)],
> +        .fmt2 = fp8_input_fmt[FIELD_EX64(fpmr, FPMR, F8S2)],
> +        .scale = -(FIELD_EX64(fpmr, FPMR, LSCALE) & scale_mask),
> +    };
> +
> +    set_flush_to_zero(0, &ret.stat);
> +    set_flush_inputs_to_zero(0, &ret.stat);
> +    set_default_nan_mode(true, &ret.stat);
> +    set_float_rounding_mode(FIELD_EX64(fpmr, FPMR, OSM)
> +                            ? float_round_nearest_even_max
> +                            : float_round_nearest_even, &ret.stat);
> +
> +    return ret;
> +}

This use of float_round_nearest_even_max prompted me to look at
the uses of it in fpu/, and it looks like the implementation is
incomplete. Most importantly, although commit 72330260cdb420 added
it to the first "switch (s->float_rounding_mode)" in uncanon_normal,
it missed adding it to the one later in the same function, which
I think means we will generate wrongly-rounded answers for
denormals. A fix is probably:

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index efd130bf16..6cc9429ebe 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -450,6 +450,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p,
float_status *s,
             /* Need to recompute round-to-even/round-to-odd. */
             switch (s->float_rounding_mode) {
             case float_round_nearest_even:
+            case float_round_nearest_even_max:
                 if (N > 64 && frac_lsb == 0) {
                     inc = ((p->frac_hi & 1) ||
                            (p->frac_lo & round_mask) != frac_lsbm1

There are also other places within fpu/ which switch on the
rounding mode and have no support for the new even_nearest_max
enum value. Those ones have a default case that asserts or
aborts, so at least you'll know it if you run into them.
They are round_to_int_normal, and roundAndPackFloatx80.
Is it worth extending the support for this rounding mode to
either of those?

-- PMM

