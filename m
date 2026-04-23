Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815DDF589C4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFtXd-0002z2-Jd; Thu, 23 Apr 2026 08:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFtXb-0002yk-93
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 08:52:23 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFtXY-0000W2-6S
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 08:52:23 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-654672a6d68so863964d50.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 05:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776948739; cv=none;
 d=google.com; s=arc-20240605;
 b=kOci60hB2Yp8OFUMgbXHZyKfK+STYMeKGSeaxOMjYsHgVjWtegaKkN8kbOUKJO5raA
 RUfoH2FEZaC4nbbKNx2bhfRBLMI03M+ELpU3gxj9Puhvq4E525m+kEz4EVtvSdhSTpo2
 PuYN3WLpM5OrqyX9mIYJDm30x/iEn3sADlz8PbJjszOG1CHQ9AjAiUfT4VidUYDsEbKf
 0C2lUI+htdH0sR7QF/IpJGhPaVpclcGDsD5c6zpAvTvwxELuWGslN5yf+xijFdnalZdZ
 nkUs1HwU7H6PGYQ2+2kZldGEqAGSaHyEoPdNdyXMyflJSRVI/puBll9+aV7j/XwVFxh5
 LxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=98iGWxy2WlsLSGh/rC2LM2VieUzajCJwpG0bN2vnSp8=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=SuQb+JzlIbV1rz64Ci7JugHayjscUi7pKFr6bt9t0uT2eZ3nbnBlGwnfliArMqCIzS
 wp4VUflNcFKkHIAmVwJesILlCCWgBkQX3hrqzNVe1ghRhd518bWChaa9jLCjfrZvBxBm
 KIaaaxYrBSEBfbVH43lE/akEA7quQxpbmilOleus6m9DIsxpu9IGuH1IR07Nrehu0hAV
 bKLtCBjKA6W0ZwXTDADQufNTFOuXyFhVSEANnyQ+Dy7CG/Y8WPr9dyk8ZRc5BUGWHMDc
 Sprn4NpWKnctB8KZsCI3i8JbKKWsjM1sF7O7OvSVLO95TmhXh8sGpHZW6FIvq9wLzubr
 1h+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776948739; x=1777553539; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98iGWxy2WlsLSGh/rC2LM2VieUzajCJwpG0bN2vnSp8=;
 b=qtgEQmKfW1WUkhlnjm34f/vTwigfkgUljqMP1khT8Ws4T0KuJliCMVADOaFnkQMmLz
 xGoHISJw0+aYyd9BczFYeMoo1RKnPZQ45p241XB6V+EhdzjFYKHVOTBcUloQdzBf9aNK
 naqQyKPw7300eCVjKA+a5mkxTUYl6pivJefoYmfCm5J7vc8PxmStyAuDcDkx5XsgNdsU
 XqRQuF1Dz4NyVFWIvaisJ5d0jb4votMkOUZvHtGNer4TWdzj5kEoo02zr0jgD1eG9OEs
 myJ3thhS8zgjxFnbryshmxTq3/6v/eqiLaS7DFPfePi4FDT1jJw+q3ly6tE9rORqcrv+
 NGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776948739; x=1777553539;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=98iGWxy2WlsLSGh/rC2LM2VieUzajCJwpG0bN2vnSp8=;
 b=aZZNmOJk8Oo/vbQ5N1kNPzd2uCNSRdBV/rNMztgYH6Cs0WM3a+XsM8lkTNhyPtfXT7
 tXvuXG2bxYZXj/zEZ6l8u4rg3eqandoKxQDoNc+HCGKQwpQMLvfOfCelwBYegs+dWfcX
 P8a8jUX0xkkHfLKpWarl+buUje2GWyasL4XhdCeZRnmRkVxS/TfYQNZDtNhxwEsUmIm6
 hCXIWyx/8O6UAoMc3W1uQbdhplACXgYzyb9i7d1aQxKnmd+riO3lGoqz61VBk9wWkIXI
 WoyehSfGQD94EGz69pXmtK+It2WkisnnF4VAB7UouLfuujjeSYQMFtlq5yhx7OjY8ZBv
 EaeQ==
X-Gm-Message-State: AOJu0Yz5nJuzk6uCoIe1HBSKLmYQY3HXhddLAyBGa7nyRFR08sWnkEVs
 ndL+GUF20Q0R74JcritNJUYPBQfu8DKX3mGJcgYeC7vMJafWqvT8Sd3Zjpne23Fgvq/LxguNNkn
 omxAzGhAYWAtD/ThJvOqEowZT19L4+5jPJddBAnehbw==
X-Gm-Gg: AeBDietzRKBeNkEQb2ckBhEv7t/bzbzwu6cSBI9F7DfiHuvloj5ikKVLYZvggGG4cUJ
 b7wvkc01K5gErEnXoj8qXCn6wpJxvrVke1Nfas0Q+qU6FTR6TieVHbAXpqZB3YkcqXUOETjq3GM
 pqH+H8PHoKl9d448fQiT2fj2gSBUb2HO7OPfgTxJqPd48gqTlml1fyE/TD3a3TCdc3OsAFjY3LT
 hJib/7f89PsLz1xQuq+CJNZPnGtI0dlslgpnMsOUO+BX+azEuyXTXYy7yOw7p+lQScG1JLGbED8
 3kg1s+PWQATqKMl5WNdyGmXYCH93VmxCTomWyatHF62WqrFNuh+OnJd7eww/M1eW/bU+7F4xI3I
 Q4A==
X-Received: by 2002:a05:690e:128a:b0:650:1cf8:f608 with SMTP id
 956f58d0204a3-65310a62a92mr25618151d50.45.1776948738747; Thu, 23 Apr 2026
 05:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
 <20260423100229.2941820-11-peter.maydell@linaro.org>
 <51498985-6742-4d9d-b924-07ce873cd531@linaro.org>
In-Reply-To: <51498985-6742-4d9d-b924-07ce873cd531@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Apr 2026 13:52:07 +0100
X-Gm-Features: AQROBzBiMZHKtar2btUyf40BoVGDUIymt12ZWtml6JYqjvUym48WWNzRNJbf_r0
Message-ID: <CAFEAcA90md66h-73qDBX=jX4jvD9j4z5F1puv4awho3gCUQ9nQ@mail.gmail.com>
Subject: Re: [PULL 10/59] include/tcg/tcg-op: extract memory operations to
 tcg-op-mem.h
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 23 Apr 2026 at 13:35, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 23/4/26 12:01, Peter Maydell wrote:
> > From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >
> > This new header defines a new type for target virtual address,
> > independent from TCGv and is parameterized by a new define
> > TCG_ADDRESS_BITS (name was suggested by Paolo instead of
> > TARGET_ADDRESS_BITS).
> >
> > By default, tcg-op.h include set this define to TARGET_LONG_BITS, but
> > it's also possible to include only tcg-op-common.h and tcg-op-mem.h and
> > set TCG_ADDRESS_BITS manually, which is what next commits will do.

>
> Missing:
>
> -- >8 --
> diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
> index 36931d1dd57..ea35a02fb40 100644
> --- a/include/tcg/tcg-op-mem.h
> +++ b/include/tcg/tcg-op-mem.h
> @@ -12,6 +12,8 @@
>   #error TCG_ADDRESS_BITS must be defined
>   #endif
>
> +#include "tcg/tcg-op-common.h"
> +
>   #if TCG_ADDRESS_BITS =3D=3D 32
>   typedef TCGv_i32 TCGv_va;
>   #define TCG_TYPE_VA TCG_TYPE_I32
> ---
>
> "tcg-op-mem.h" uses methods declared in "tcg/tcg-op-common.h"

Yes, but all two of the places that include tcg-op-mem.h
include tcg-op-common.h (directly or indirectly) first.

I agree that it would be nicer for the header to explicitly
include what it uses, but do we really need to mess around
re-rolling the pullreq just for this? I would rather not...

-- PMM

