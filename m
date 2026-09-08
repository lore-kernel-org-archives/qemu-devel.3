Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063ECC79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3x9G-0005Iv-UE; Tue, 08 Sep 2026 10:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3x9B-0005GE-4p
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:50:06 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3x99-0004oy-Hd
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:50:04 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-836c4474028so42987787b3.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 07:50:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788879002; cv=none;
 d=google.com; s=arc-20260327;
 b=ALdvGvb3Zw0Os6BFByHBwM+GEMWTDUsJM8SoHpQOicNV4uUfEIZa6LFMHkWTJ79qdZ
 m9SeT1tI2aOcdk4Ax2tt1dXjHsS0lMnbAqKFBM/rAXlBeAz1QLCiMt2SAOm3d172lgoZ
 0xIZMQpmFNa+T77/maeSJBO9KcKV4oAge3ZbZAlOThZs7S6gUnQdi5n+kqFcvkRPFYze
 T7UkVvenL52B3dahS2bCd2W0vvLMxgE59UA2af+DLMHUbLBMFG6jT4gP54nQG3WwN361
 kT5dzZ3vM4dqRQR/4RxFNP5HeLrhXABXIkU1Xk2tvhlRlTNquSvDolviRaP3DxDrrOKX
 orwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0PweadR5DzLlHNp2ywJu36Rmc5GHCrjnRVL1gJyfuP0=;
 fh=ieLaz7e/0RpAqfE5XLQ1RcBHWjTUv1z6arE2SouQh04=;
 b=IAsQ8mSEbbmROcqRIqng1WohQKSjWOanjLULq/hJIbwylpGv2J/0xgyUS68Tks+QGA
 2NhiBPxQK4vCjF8ws7UTPtwor8ZTT2Uxnz1agy5x66CYoN90o4zjx4rpaVeiMD5QS2W4
 pXg2m6l0dKp7+p/vUBUixhB5BdjIvfr8Hnk+nj2vDKNndWbqe7XaYjm6tWpFuWObXJun
 sE+W+F2k37wc+Pv7zAqZQ4tFLZ/aGHQdVr8Rdth97H25L+gqqky0rH4/n2ZpSq2IJ538
 PN5E9Czm0asH1KeooDK71PlTSZgohAXdHyYqMTtpwNZj1sw1HfhGGW3MGZld9MPN5Wv1
 CboA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788879002; x=1789483802; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0PweadR5DzLlHNp2ywJu36Rmc5GHCrjnRVL1gJyfuP0=;
 b=bZzAbhX/TmNwLtWrGyOuMOAmCEyzmBFx9MhB7Px0c0MtRJSKG8Vn2KiAeyG+IfukSl
 nTFDOJgntYrwF3nViiVSzog3k8TyfDi0vdr7OmkB8Gv2womgikQSq2zExDaYVoQ/40jc
 KxEnanItYT+H6wDldQMAG/YdtXoaA91NvnD7wsMA1v+jYH5W0qnLKtn+Z5/+9y5RPbY1
 w+ijBoX+kJiUr15f9qJdJ2vsgo8MjhbgHdWZKoCPdn972/Xe9UDqCMWKuYQXN3bZ/Hj0
 nLcentFERHra4Z9Zb0dK0W6k5cQCLD9XfKWckZzwAEeZsW4ZfYrv/VN12Y/aVRZJFrYj
 Z4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788879002; x=1789483802;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0PweadR5DzLlHNp2ywJu36Rmc5GHCrjnRVL1gJyfuP0=;
 b=SD8ibUy5dLN8cGYbLpES2/cKqp9RFY0etMNI9aEHvJQdTW0R5uYW5wIwIc8Z0Z15zr
 sRHbhE1wdeNDAnVQp5I+C7/yhf2bsFCdoTiPDkfFEdAfZ6bXNp2RNr8dl4ie+/9LZn0H
 FDnc5I+HQLAXU0A70KAZ85kEy6LziDEyWdGtdEwmlVfWjktXFezUtDeIshd2Wpv3oW0o
 /v+ZfTTP9kNpLVOCqr60ERneQS2JxSx/w7I7G6JVvOlKzOobsH8s5E+/UJvaD57j3q33
 yYNeR2tqjeuCSQcboAxVjlY4VcIIzXNHMU9oo9TOsiaU5Fj6fehsOfrWYNHpMSSRaHwA
 6+Pg==
X-Gm-Message-State: AFuF++mInHgH/39XYWK1AW3jKIVRWV40ulF0XvwL0tmAZCou9LdjU627
 U//8MDp3rAUiEqF0s03fQS2vKCZ5cU1n7Rxcqs7x3lN8M1TzrMYe2LaIPA/obgVbm/3jLTtYIXf
 HCMAw9zNPxXj1BvP36af4EkwRuRt3SRH4xs8OHJcuUg==
X-Gm-Gg: AYBFou2fBmtV4Qk+HYLMbOkn2TlE1LzQ0EEtQ/eZZLc0O4t5MuCt2NnQfX4rTv2yB0A
 cKds7FPE612/jh/ZTT6BZ3XaV1mRyTkxnK4Zt+KWw5avita306v4aBDWpTS1wUvBD/V7LNzm1Re
 uQq3J5SkIiqDguGWHqtE2c5DmTbGeCWzvXiy1cnNYcQIxxNNXINc5hD8M5m+Q4b6c7g9i+ju2Kc
 rJtQeekVI7hVvOI9Lza3VMTLM1idhCmnOrh0B+yWlQYrAlGEc+1VaVKi3jH4z+BqmTW9PCKtUkR
 4H1wgzzh/Po+LYqu1ytpkFH1bcMGyqAdHAbzoPUdz+Mzr5Aw+ZaZPi/og4BnMj+RZfkAgvVLaZj
 Ysi7ozHGLLXsoYZb2X4ZHTiRX9Z04Lg==
X-Received: by 2002:a05:690c:a7cb:b0:81e:6658:53fe with SMTP id
 00721157ae682-87126aa6a93mr75906647b3.20.1788879001416; Tue, 08 Sep 2026
 07:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260902122646.2848464-1-imammedo@redhat.com>
 <20260902122646.2848464-4-imammedo@redhat.com>
In-Reply-To: <20260902122646.2848464-4-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 15:49:47 +0100
X-Gm-Features: AcwNN1VBB39C1azmISHeW2Ow01jri6VWsbWgi_h4K37pMtbgKPJa62Aont-2QTk
Message-ID: <CAFEAcA-2yqVBHw1RTJW5TSuA89qbQQPRSQBMcKu92okJ+QtB5g@mail.gmail.com>
Subject: Re: [PATCH 3/6] arm: gwdt: simplify WCV update condition
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, leif.lindholm@oss.qualcomm.com, eauger@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Wed, 2 Sept 2026 at 13:27, Igor Mammedov <imammedo@redhat.com> wrote:
>
> Current code implements SBSA 5.0, revision 1 of the generic watchdog.

The comment in the source code says "v6.0".

> Which requires WCV retain time when WS1 was triggered.
>
> towards that effect sbsa_gwdt_update_timer(), used condition
>    (rtype == TIMEOUT_REFRESH) && !(s->wcs & SBSA_GWDT_WCS_WS0)
> to make sure that WCV won't be updated on WS1.
>
> However that is dead code as sbsa_gwdt_timer_sysinterrupt() when
> signalling WS1, never calls sbsa_gwdt_update_timer().
>
> Delete dead condition and add assert to make sure that
> sbsa_gwdt_update_timer() is never called unnoticed on WS1 path.
>
> Above change leaves us with always true remaining if condition:
>   (rtype == EXPLICIT_REFRESH) || (rtype == TIMEOUT_REFRESH)
> drop it and update WCV unconditionaly.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/watchdog/sbsa_gwdt.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
> index 2aa44573a7..a9bf3f8312 100644
> --- a/hw/watchdog/sbsa_gwdt.c
> +++ b/hw/watchdog/sbsa_gwdt.c
> @@ -123,12 +123,12 @@ static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
>      timeout = muldiv64(timeout, NANOSECONDS_PER_SECOND, s->freq);
>      timeout += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>
> -    if ((rtype == EXPLICIT_REFRESH) || ((rtype == TIMEOUT_REFRESH) &&
> -            (!(s->wcs & SBSA_GWDT_WCS_WS0)))) {
> -        /* store the current timeout value into compare registers */
> -        s->wcvu = timeout >> 32;
> -        s->wcvl = timeout;
> -    }
> +    g_assert(!(s->wcs & SBSA_GWDT_WCS_WS1));

I think this could use a comment to clarify, because it moves us
away from how the pseudocode in the spec is written.

    /*
     * We only call this function for an explicit refresh (which
     * clears WS0 and WS1) or after the first timeout setting WS0;
     * so we can always load the compare registers with the new
     * timeout value (which is not permitted when the second timeout
     * that sets WS1 happens).
     */
> +
> +    /* store the current timeout value into compare registers */
> +    s->wcvu = timeout >> 32;
> +    s->wcvl = timeout;
> +
>      timer_mod(s->timer, timeout);
>  }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

