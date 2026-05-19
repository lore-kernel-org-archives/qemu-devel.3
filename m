Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9FBCD5BA3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 09:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHBS-0004SZ-ID; Tue, 19 May 2026 05:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPHBN-0004Re-96
 for qemu-devel@nongnu.org; Tue, 19 May 2026 05:56:14 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPHBL-000050-RZ
 for qemu-devel@nongnu.org; Tue, 19 May 2026 05:56:13 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-651c5d525f6so3346776d50.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 02:56:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779184570; cv=none;
 d=google.com; s=arc-20240605;
 b=IjuMncOz1L9CTxxkSwVPKT0d+ibk8fW0oDuaaGZBnbnf+vLDd5ioeq6GJWKCrY/RW7
 dZ95MlA3WJEXmFFd+1TyxEFoFrNAOocoUuHi7xokDpxmDFTFMoIN6ck+g5gsC1o479md
 Wq+BTceslGEM3ZdQ97bJJ01N3Hzpb5IBFiuFMzSklCEiQSDHN2d2bAy8wP9ktNRyesQE
 3hPF2/u+kb2X7JbrG8hCl+HjRboc/b7Ts5Maxkv0fVBBj1F7tDgC0EK+nr64/RLJlIuB
 oRR/G+kRURSJNKZBNkmUipKp3xLkDD4QnIh3kvg4xXMTgjPw7sUe4O5g26gh0VWTa4e0
 k2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gkCjMqavYc+FldQbptUhkyVgCAzaUrs2O5oOYAytzd0=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=L5b+knWYfCCBz2l3zN5roPTPBGL3SrUvkKhDuyRFPnv5tnD/T8y3L+jsdXjkcwjiGD
 OvI2aEWBJThxPN62eiVg4xwEYBne4R2IGQ0kkgJr1Pkw8eIBOHoCH8vPmZQB0bkCJFcQ
 2cyIfQolM3e8deic/O8YkT4dXs/SwWSU0iqrJt6bDQfCkdmyOCnYE7cNRaYdt13LUMYC
 0bIjSYeUhIIkptScqX5VBFDKZuWARvo5AZL4yIPhG7m0iQwsFljnxpD6zlRthL4g//PS
 78yw5Ly5k595ZA85R9T7Wrv6tHqJhchY2ZzLf8R5m+9zryBcKGZeJIzlzDw+PSqrNHSK
 sKPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779184570; x=1779789370; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gkCjMqavYc+FldQbptUhkyVgCAzaUrs2O5oOYAytzd0=;
 b=HBCY0y/yH6HhdLBvDPUHBsoI9I202HUeGJ5ycz8ozphAPC2emVN4mAJgpfalDfRYmG
 FjDz/3yecxh5BMm7u7d9AOcUsJMBqmReZkESAx2VV44SErtbfGcqpMz+2hCXVA2yAHkL
 CP28RzlGIfwq/Hsi8qVRHwyBbq5yB9nxtZDo2+3Z03+6wX8FEyAc4TX3rhS+s1Rwlf05
 sgJtUhng3/q0jVjQj8LgKGTMFkgU3dBvOiGsJREjtXjZwiCNeKHeoISsg2FiXrnO4fW5
 47weU1l1TFurcAMnEig7YpIet8TC6+dEoqZQDdrEmAWKlT0mIgAPhZNS7ksYb7WWXXnw
 fRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779184570; x=1779789370;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gkCjMqavYc+FldQbptUhkyVgCAzaUrs2O5oOYAytzd0=;
 b=JMooKq1bfumOedez/dcv3lGBlhcf/bHnk+1YxRPkeVfymaPVcc3jvE2EVTaH3yjWu0
 glZwEqOi/RXTUZwoD5qIJQ4lzkfMDq+YIk0t58H/E/0kzGXWm8djWPdoH13R+FcsGIPq
 0PNPvRm3jXkEEstwNSiLZWJlzvVvU0tCAREUgC3Usm7D4UKwEoI+maJcqTZdm7K7f1Zf
 r64FLmljXDebxlIaVeNERpEg+MiMS6336jlA5V3rCIZzVVNsIp1+eHI0JmTwZFZy0J8d
 32OMYu7c6f8ZYX5J/pJ3daixEhwMIszCJj8ZYqnn/2oc2VkezuEB36L4UCdaGBJNfb/G
 L0yg==
X-Gm-Message-State: AOJu0Yzm/6UKW5w6AU/O7EBEQfeWljb6c0Su0IWLOBhPcLRZQ9+n4VWK
 dyrBnatBS3ixP6dnbyDMjAlPlcnwJPYA7qvTEEFCLuGL7n4EetkYiTk37IhAcmthoCBMfIuFsgf
 fGnLMov7mdkTxx/9pe8PNQK47X7n0U1NqQLddIanlfw==
X-Gm-Gg: Acq92OEQjT9Az1claGkoDsf2KbqQmGgpSBTVHhJ4H/tw5404MGiFPhmc2+/MZx4wVO+
 ni8F4G4Ozlp4i6s+0CauXwyacDfUCsxTD4GvgxnOLDwWUByZwmjEj6jvxKlC/6RpdvOLGuSKQHH
 ZHPmjXA1+D6MNsanGnA0pHX0xZrjw4VuySyZvLVFvkLSGrJgiYDj4xrIO+M9/C8OCsrGKeN8UNC
 eMC0XUNSEsL00z0QPcLzGzbMFTk0K+LWzG3ANDPNLKcb9xjKHhOkBTpl7oRV0QSYroL0STzpPph
 cKHraMhHwoOoq3Kv7qT3FL4Ack8T9dKLwbZiZlRogxetjvELwbOtKFw6wW4iDwidTFM=
X-Received: by 2002:a05:690e:1285:b0:63f:b4ee:7920 with SMTP id
 956f58d0204a3-65e226841e6mr17865145d50.11.1779184569611; Tue, 19 May 2026
 02:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260517003002.321430-1-richard.henderson@linaro.org>
 <20260517003002.321430-31-richard.henderson@linaro.org>
In-Reply-To: <20260517003002.321430-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 May 2026 10:55:58 +0100
X-Gm-Features: AVHnY4JJh3U0_rWfkSglvBYAxMVO30asz6DBcesnaWV5sz2dpa2UAheCqIpqqoo
Message-ID: <CAFEAcA_9Gz1Nnb9-xbgjpySG0NkO9QaMudtUs=1Ef47gF15oTg@mail.gmail.com>
Subject: Re: [PATCH v5 30/63] target/arm: Implement BFCVTN for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Sun, 17 May 2026 at 01:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> +static uint8_t fcvt_fp8_e5m2_output(FloatParts64 *p, int scale,
> +                                    bool saturate, float_status *s)
> +{
> +    /*
> +     * Because e5m2 has an infinity encoding, we need to handle
> +     * conversion of Inf -> Max manually.  This will be converted
> +     * to the actual maximum value during rounding.
> +     */
> +    if (unlikely(p->cls == float_class_inf)) {
> +        if (saturate) {
> +            p->cls = float_class_normal;
> +            p->exp = INT_MAX;
> +            p->frac = -1;
> +        }

This "saturate to the maximum value" codepath doesn't seem
to work -- we end up returning 0. But I don't know if this is
a bug in the softfloat code, or if this FloatParts64 is not
a valid thing to pass to it.

> +    } else {
> +        *p = parts64_scalbn(p, scale, s);
> +    }
> +    return float8_e5m2_round_pack_canonical(p, s, saturate);

What happens is that float8_e5m2_round_pack_canonical()
calls parts64_uncanon() on this. In the uncanon_normal code
we end up in this path:

    if (likely(exp > 0)) {
        if (p->frac_lo & round_mask) {
            flags |= float_flag_inexact;
            if (fracN(addi)(p, p, inc)) {
                fracN(shr)(p, 1);
                p->frac_hi |= DECOMPOSED_IMPLICIT_BIT;
                exp++;
            }
            p->frac_lo &= ~round_mask;
        }

Since round_mask is 0x1fffffffffffffff and p->frac_lo is
all-ones, we take the "do rounding" branch. The "round to
nearest even" logic decided it needed to round up, so
inc is 0x1000000000000000. So we add to the fractional
part and increment the exponent. This means that exp is
0x80000000 (i.e. has overflowed to negative, because it
is an int type), and we don't trigger the "exp >= exp_max"
check for overflow. So instead we return this bogus struct:
  {cls = float_class_normal, sign = 0x0, exp = 0x80000000, {frac =
0x4, frac_hi = 0x4, frac_lo = 0x4}}

where the exponent and frac values are too big for the
format, and then the packing code produces a zero byte
because the parts of the struct members it is extracting
are all zero.

So is the problem that we shouldn't be feeding in INT_MAX
as a p->exp, or that the "round up" code should be
checking that it isn't going to overflow with the exp++?
Does the same thing apply to the "exp = INT32_MAX" in the
exp_bias handling in parts_uncanon itself ?

thanks
-- PMM

