Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29B1CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 09:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ05O-0007m8-Sq; Thu, 21 May 2026 05:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ05N-0007ld-8P
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:53:01 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ05L-0004v5-Oa
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:53:00 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-65c2cd216c9so5019713d50.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 02:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779357178; cv=none;
 d=google.com; s=arc-20240605;
 b=LzWSWI+dUeDIF+1fiAkBSTXoxEbGJEUObsPZvBkiFXbjYlKdLJZjyA215u1lzMrfTO
 f9aoWGiGARaLsKZujAK6vNRbu7hgXaWjc6MzIVjrCdVjWp/ErBtSNFVCeo5ddbB89Hjs
 Tj1oI/1oja6+55HyngYFDpOEDPknFtswDKsVEY/UeLjvplLU0fy9jt7X3MP6P6fRDThT
 B7mD5uBq8vnKRywe1p4MIlvI87AjA4bIDEXJ+YYQWH4QOdcjSUKdm0LoM8hP7OxtNtrB
 JnmoDRSAJIgg0QloLuakgNBpD55kSpRQAPV68JEelEWpZaaSfX63f66kuGfZ2oUJcX0X
 JiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nUgeBFh1V4EOv6CYNGi1f0MN9FXnwdnSuM0h+QguS+Q=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=h9blbY3duQOrGjT7HeTw1FcsGM0PkrOfr5g478UWLA+tXiQ+0WeP412DWt3qX0FP44
 qDsiQtyZH+9tqLv0eCDD4bPImxtokQgcmgPFBCFC4jHFE0qM3Rc1lp19phX7LFLQULIn
 mkveE0IdKIzUtwYV7Gc/0kTG1WcNr7HsbW/rKTm9dY5Sf3bszW8NSrJPYWqfEDvFlngg
 oGq1E+SDJXDzDAodc+V2vW5twQ+LmugaaMSEmzAA4DuUj1bteIzyAMRpMSxADJS65OJ7
 j9qvkLMXVDMRjwvKWdSQTXRynLmnR+mqW0XeNGqi20MNRcgnpbDuBKGvGAob436Bt83M
 e2iA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779357178; x=1779961978; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nUgeBFh1V4EOv6CYNGi1f0MN9FXnwdnSuM0h+QguS+Q=;
 b=aN0Wc0TNzpmzN95B4bMfvrhcPWUw4ehjIBlMHdjslUgXRcE05oZUENeA1zjkSiD7Nz
 w8KbTQNqYtd9IBUIxtNCe27K5sZFeW3YJLTjkcK8YEya+WlYchzmV5iwzOfIGgBwl/cN
 vp/gG5Vio6DI8oO1QX9bikvo8Rh5NxDskWOoha4tMlkBE7F/hf3uTK1IQDShIjbx7yYt
 tqNxAcFVOefEzq9XA6nMyzynFV+v0WEFx4vX9+LRhHW4GL3brDAhfAhlQRRl9lD364lF
 /T6bgXu21Ub6kXL9ZriqeYrzqna2et3327nT3oK0x6WchA/uUro7QseQp0bT+b0vDqMg
 Fakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779357178; x=1779961978;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nUgeBFh1V4EOv6CYNGi1f0MN9FXnwdnSuM0h+QguS+Q=;
 b=Q7nFXTaD0NiRVk+KAU+NFU0E6DfIuUGc5tDkDxWIyhu5jHmIh+RsYw16E9CiSJSfoM
 YnHIA0ZJivGii1NXki7h2M5CCz3ab1s8t0lLtKEZQ9CZI0nyjposzdCsRT9gKgh5TgF0
 BVZqrHH2Lb950yi14hF+iaUalzqYmqfnttqVpNU2W2WCVkh/A9C5WfO0HF46QIhaC/yQ
 2pyAhPa00gm2uHMtvMEguo9tls8r0764ZMXXaJtZ3Rixi8FGGFUiF8LtxECzYQuBR2P3
 YV/3JzFpT/exW4NICTUCTsZIuenx2L2LmZXTiXDbMnZDKqw1E9RnTX0+SKDcokcoNLG7
 Ui9Q==
X-Gm-Message-State: AOJu0YwX95ojfkfoFWFklvDjjXPuh4eaSJJ8xfANX7GbriFZfivHcrFi
 IOmhf0y9usoGNnsMlE5SGipH5cXMPvUX4gsFnquqYY2zyN3QauM6ZWfSg3xAxopoW2thJ4WZm8a
 yV+d4VOhb/fwmD8TKFFde4cRerug95LqWnbEtRcbIqg==
X-Gm-Gg: Acq92OHLVp5i8Da11Amp2cB9ltZ+N3g7FsbzA3mo2Rnt57fbAUxM27qsvbvSahkR+GN
 wdwFSFvYMkIUZblZfmoax+rzmUQ00T+5wiQLYuGVb449mcKFh1AYmefjXv7OnIsILkNRi4IC9NC
 hoZoVYx14ul0qKi7gam/smK1vEtDq53uhWemQs2X3dhQKMmScp7HTk6TyUWarRShGewMbKeqq0B
 86gZIgERItMtM2qapF+L22uYS8YruLzoITXp3Jmui/7CUMxUEY4lxox55fiLaAI5ikNFr3Ag6co
 uTF2NZQ1WHKInpPh3pMgCrBAk1nuuxjN+QKY5PGi80bYlEuxRL4u90koVEQO2FbUs2g=
X-Received: by 2002:a05:690e:191b:b0:650:1bf0:ca62 with SMTP id
 956f58d0204a3-65eadfbf3b1mr1632986d50.6.1779357178208; Thu, 21 May 2026
 02:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-61-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-61-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 10:52:46 +0100
X-Gm-Features: AVHnY4KzFW7o7duDWfFFBk208fM3EgldrA5vL9H3OhtFIjRKgYUvaYDJcRGYe5E
Message-ID: <CAFEAcA8+VBdRt3DO9zgwQccbH+O2PMZnK3o81zmX9M1GmgiseA@mail.gmail.com>
Subject: Re: [PATCH v6 60/64] target/arm: Implement FMMLA (FP8 to FP16) for
 AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Wed, 20 May 2026 at 19:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> +void HELPER(gvec_fmmla_hb)(void *vd, void *vn, void *vm,
> +                           CPUARMState *env, uint32_t desc)

This still has some lurking copy-and-paste issues from the _sb
version:

> +{
> +    FP8MulContext ctx = fp8_mul_start(env, 0xf);
> +    size_t oprsz = simd_oprsz(desc);
> +    size_t nseg = oprsz / 16;

Each loop here handles 4 16-bit halfprec outputs == 8 bytes,
so we want oprsz / 8.

> +    uint32_t *n = vn;
> +    uint32_t *m = vm;
> +    float16 *d = vd;
> +
> +    for (size_t seg = 0; seg < nseg; seg++, d += 4, n += 2, m += 2) {
> +        float16 d0 = f8dotadd_h(n[0], m[0], 4, d[H4(0)], &ctx);
> +        float16 d1 = f8dotadd_h(n[0], m[1], 4, d[H4(1)], &ctx);
> +        float16 d2 = f8dotadd_h(n[1], m[0], 4, d[H4(2)], &ctx);
> +        float16 d3 = f8dotadd_h(n[1], m[1], 4, d[H4(3)], &ctx);
> +
> +        d[H4(0)] = d0;
> +        d[H4(1)] = d1;
> +        d[H4(2)] = d2;
> +        d[H4(3)] = d3;

The H macros here I think are wrong -- d is a float16 so we
want H2(), and we need H4() macros for the n and m arrays.
(I think in fact if you work it through then all the H macros
cancel out and we could drop the lot, but since they're all
acting on constant indexes there's no runtime cost and having
them present is clearer for the reader.)

thanks
-- PMM

