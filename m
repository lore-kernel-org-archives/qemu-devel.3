Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD2ACD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 10:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNTQH-0006i5-KM; Thu, 14 May 2026 06:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNTQC-0006fg-Tr
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:36:06 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNTQB-0006vq-Go
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:36:04 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-651c7ddf514so9352725d50.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 03:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778754962; cv=none;
 d=google.com; s=arc-20240605;
 b=GGp9zf2u3quikgEgqzGmkB3jHcxbNzn5UVGJr5Bfu+5FNbAtdJNT53MAjfW1d+wo44
 s+E7ONipqD2+DU82J/GWPABnnOU0RSX6+84Xk99t9dxsbG7L6HdQGQpVfTB9pgyzsYkf
 4nBTGnBwYpTXyS0sCMNIxpDGvcdR85V9eHGEUA0cim7sl5EZfWsX6EXHsZePeKoTEGez
 ZP5/Eu82ohPNXkaweTbqLAoHDRJVwDrVPrJrwai7GJONybP/v9zSnTsvyCMClQUQyWSf
 f72im6gOmS6bpqi7IC+Ss3WRdJ4uUuKXphzCN96GjvzoGrbEhxecSnmR/3gcJz0/i/bx
 Q00w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MrH5kM0u1sWk+ZNQaJmTKUQLLfGjq7iPep1qYDJzMsM=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=aVQIeAMJB0Y4YueF12ebcvGVvSPYtbrx7T2lsBl6r9xfe8oTFyJ9+oS8ZAtslv6oLy
 RfiAOwu4LqzjRyHgeGsg2Wa5G3y3jOcXGiE9EHYokwAuA4Gv4q6YpvHVEULmFXx6Qejo
 Ho/6ugPREL9/8PTwgwmWrlFSIogcQ8jm63qH0BiSSMJ+zERSFQjDQ4KH82TWYhIzUT5O
 RlBMpVIS/FF/4p0cavoFDhn0l4riQFTjiHtRypZUmiY4M27kDaJMZwZziXB2/aofXF39
 2Z02DTNTUPv6eb3xqobsIYOdm+kn1fzqPWi08uDryz+/ivfwXrCqxqQPmGlOc/5UXBwn
 UaHg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778754962; x=1779359762; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MrH5kM0u1sWk+ZNQaJmTKUQLLfGjq7iPep1qYDJzMsM=;
 b=qvN4xuQe4qt4/yDoMXWIKWkKYVA9HIrr40s6GxdRYPBPnLBMOJp8WhZV+1GniTBn3I
 4jmQRhFUAnRPBt+GcFKbrThrq9jNhe/fb6VdmdYsczsWHgRMVsJHyxaLAW4uYtDCxotP
 SRZJnYW4ZVCde2IL3y+fPx4rLk46grvJm/QEcHnCmAuQS6vq6TQZnYlYVoz9rkX2MPe/
 MoV7t3N9FIGPg9F04h5AdvQE2jBgUEl15vUJe5+EieEpid3uKr4vzPw59QGCyAivcBVB
 rVaHCYQksJrofvjsNhfA+GqOqvV1iVE+zFo41gWr63GKgSEAQC02OR05e6ACkz3rc5k0
 U0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778754962; x=1779359762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MrH5kM0u1sWk+ZNQaJmTKUQLLfGjq7iPep1qYDJzMsM=;
 b=T2aKeub/8Md/Pl9PLkAmm3QTSGzUPiQGoHqIQQvCHaQSreOk4iggG2ksSM00afsLQT
 VHUsgOvSr3Ww3bVrua6WbPyMJjPC55OO8cFd7vRRWw9sb84H68JsfxJzwGYw/bzP5JtD
 GXLG51DaGLIlVZGmvzl9x9+r+9kdFfslqVBuJ0FX9tBySsrStECYKkeVz7KHb2Zc1sic
 371k6ce0zcF9reX7ITZ2SiNcsJK3cpsfVRtich0U0xbZP1jgh44iXSlWxjRxnYxWG6Va
 eUw4kBpdaclpOK119GO9ZunU71JAsLxSQ3jduD+jRs8jtqy0FPFwqEOHY43Fz0FNNEm0
 pPag==
X-Gm-Message-State: AOJu0YxxXFFKdqZt2XHgDLR2z7gFzbRzWChG1nmrkWQuaZEkQ713LC0B
 GwroW4DkNXWRSae3lMA74g78M7hn00otkKigWSlJwQgGwRfiEc6h8JbzXWOBzfeRN8gz6a5Bqkg
 O3JXzFIvXeQanhSfQtqpB0VVof4Il9sdJieFQRpYLFQ==
X-Gm-Gg: Acq92OGt7IN4G5G8LteGuiCsxC5DUWr6g3v5G7N+46jkLIwc3D0mLf2hBk0M5sciQoy
 LB3pPR3RLusv/hW7y3mZOvsqZNWEI0DpH6B3rEPRL904cnDDAeKatyhx9aXC3wb9l0xSVqjI8T6
 YBH8+S/z2jFQ+K7QN9BJRILij5gGd9FoboR6os6ojJa8Dg/pnNIyVXqc8LEzKW/g1lz9PK274Yu
 ho/vJb/sTY2jneP3GXAXQ4y0QyOpjDjyshtvLi7i2wNSx/u3j3rTwQtBq8xmsIy6Vkh3+7TruJg
 ID3fYbXR1LXQh4sOXH19V9095tEMgdOzTzdA1Psff5Wl7KUxZZZIS58RztFp0dVTww0mAa0K8ls
 V0g==
X-Received: by 2002:a05:690e:dcb:b0:65c:1f97:2c4a with SMTP id
 956f58d0204a3-65df815aad9mr6798863d50.16.1778754961817; Thu, 14 May 2026
 03:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260421051346.41106-1-richard.henderson@linaro.org>
 <20260421051346.41106-3-richard.henderson@linaro.org>
In-Reply-To: <20260421051346.41106-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2026 11:35:50 +0100
X-Gm-Features: AVHnY4I4uQ3TcVSJRnoMyTMpOTgcUwN6cMiAddhvfk56TYLMqB6mLkczWSi-KEg
Message-ID: <CAFEAcA8cM2aKa=9Qh8LOVyoEZKQfw3rTBfNrDi4xd_s+tXq2Mg@mail.gmail.com>
Subject: Re: [PATCH 02/37] target/arm: Implement FEAT_FAMINMAX for AdvSIMD
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

On Tue, 21 Apr 2026 at 06:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h        |  5 +++++
>  target/arm/tcg/helper-a64-defs.h |  7 +++++++
>  target/arm/tcg/vec_internal.h    |  7 +++++++
>  target/arm/tcg/translate-a64.c   | 14 +++++++++++++
>  target/arm/tcg/vec_helper64.c    | 35 ++++++++++++++++++++++++++++++++
>  target/arm/tcg/a64.decode        |  5 +++++
>  6 files changed, 73 insertions(+)



> +#define DO_FAMINMAX(NAME, TYPE, FN)                             \
> +TYPE TYPE##_##NAME(TYPE a, TYPE b, float_status *s)             \
> +{                                                               \
> +    bool save_fz = get_flush_to_zero(s);                        \
> +    bool save_fiz = get_flush_inputs_to_zero(s);                \
> +    int new_flags, save_flags = get_float_exception_flags(s);   \
> +                                                                \
> +    set_flush_to_zero(0, s);                                    \
> +    set_flush_inputs_to_zero(0, s);                             \
> +    TYPE r = TYPE##_##FN(TYPE##_abs(a), TYPE##_abs(b), s);      \
> +                                                                \
> +    set_flush_to_zero(save_fz, s);                              \
> +    set_flush_inputs_to_zero(save_fiz, s);                      \
> +    new_flags = get_float_exception_flags(s);                   \
> +    new_flags = (save_flags & float_flag_input_denormal_used)   \
> +              | (new_flags & ~float_flag_input_denormal_used);  \
> +    set_float_exception_flags(new_flags, s);                    \
> +                                                                \
> +    return r;                                                   \
> +}

I don't think this has the right behaviour for NaN inputs.
We don't special-case NaNs in this function, and we pass
our inputs to the floatN_abs() functions, which also don't
special-case NaNs, they just flip the sign bit. So if the
input is a NaN with the sign bit set, the max/min function
will propagate a sign-flipped NaN to the output, rather
than correctly propagating the input NaN untouched.

-- PMM

