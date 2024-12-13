Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D67AE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 16:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM8L8-0008Dp-4O; Fri, 13 Dec 2024 11:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM8L6-0008Dg-BO
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:16:28 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM8L4-0007zc-Jv
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 11:16:28 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6f00b10bc1dso17803117b3.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 08:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734106585; x=1734711385; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n5yq8m9etLbOFIeY34o894flVPY1UWwHzW9+riYgCek=;
 b=pMkroiMI6PY4V0Hr4Rt6vsCg5hzDqgCINjXqnB8/6Nzw3h6fxUSm9ZDQo7EWxwAlxq
 mpSiigSFRFa0PUqj0j56we1HY5QRW21zt58HIryBN+lJFUJUZ++uM5/CWLkudry4igYv
 Yznno/b9GDv4bUdQBmpnZOAG7MGIfgK0C8BwY20VEmZC7fLIrIFkAk4B8s52VKQ2jX+Y
 0sCFqP4hiZhAQSDJITTxinmYTkinyXJ141BmSkk/qzzgVaZxGOVSChL+JMohjZDzJxiP
 M24E9XMjneWLOJhd30a11rGhjkz1egiMc2Gbmmk1uwwKAGKCSOhA19LsLHwx5uZybZFc
 xbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734106585; x=1734711385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n5yq8m9etLbOFIeY34o894flVPY1UWwHzW9+riYgCek=;
 b=RnAzd+eb0hJSJgYtPelL2hclyY09zPz/HPYyC0CrNO//JVHXSjit3yJSUktX7V0KSk
 XjhKLrQul05K0w4sOUD0IR3ua0vayFuEVHLyNV83HTHWG2ybrh+5QbSLPbmwDdqwTbkm
 O4e+K5O0OWVjT/a4krn7Nx3/SB45esp1p29m/aruD8zjUYhWH4tfeAuKcm6weByJsWqS
 XUhlu+oYLAwMnIQ/+RIo/doq6fi5QG7vs4hCYw+J7QmFujv1cn+vghA6smTsej1LePXW
 eYfoA5bXcQP7NuUV4qbeEXBQXOrAsjsfGXOukCGM+273pt2lzUXUTIIQpSctVkLOtje4
 664A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9cvjKMD8+K7p2EKuuEnpC5wp8YVcLTcsq89pYQdshobTyMNFvHf+qBxdsG5AzV4Wd/vMO+6NkLFaY@nongnu.org
X-Gm-Message-State: AOJu0YzYPflyKj/VT5/An+WM34pHEtPaGiYuQTrPYOmS5ODuAILwQDiK
 z0YSOQt8Svs/r5LQqnDURJYQD3RqHAZADzvokpSgi+SqOU351VK7XBcZ4PfLLQ/5/dgKMDdMseE
 I2HnTqM7Ehk6D5BbvMVXchS/vXneRTIVaHpSXsg==
X-Gm-Gg: ASbGncuZPl2BVetVcsqZU6nGNivHMYA0uJAB16c+vnJc1Rg7HYgyVaMy8/wSNI/hnFn
 v2vNeokG/g9Y5NpCDxLqHg+mXcGKScZUX12Hz4Yo=
X-Google-Smtp-Source: AGHT+IHySbFGksmTnqumZ5Fgz5PGbUf8YtvKOqodl5Tx8h+2lAIlH71wzZQQ9QtuDUvlF65akEkLhkxQpbBcjU9c15U=
X-Received: by 2002:a05:690c:6312:b0:6ef:7f89:d923 with SMTP id
 00721157ae682-6f279b8858cmr32431287b3.31.1734106585052; Fri, 13 Dec 2024
 08:16:25 -0800 (PST)
MIME-Version: 1.0
References: <20241212142716.523980-1-gerben@altlinux.org>
In-Reply-To: <20241212142716.523980-1-gerben@altlinux.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Dec 2024 16:16:13 +0000
Message-ID: <CAFEAcA_cUPQ1n4t7RGaez3-odPWmc4PbZYD+eZVB8QQ_NSv84w@mail.gmail.com>
Subject: Re: [PATCH] target/arm/tcg: fix potential integer overflow in
 iwmmxt_macuw()
To: gerben@altlinux.org
Cc: philmd@linaro.org, andrew@openedhand.com, richard.henderson@linaro.org, 
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org, 
 Denis Sergeev <zeff@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Thu, 12 Dec 2024 at 14:28, <gerben@altlinux.org> wrote:
>
> From: Denis Rastyogin <gerben@altlinux.org>
>
> The function iwmmxt_macuw() could potentially cause an integer
> overflow when summing up four 32-bit multiplications.
> This occurs because the intermediate results may exceed the 32-bit
> range before being cast to uint64_t. The fix ensures each
> multiplication is explicitly cast to uint64_t prior to summation,
> preventing potential issues and ensuring correctness.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Denis Sergeev <zeff@altlinux.org>
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> ---
>  target/arm/tcg/iwmmxt_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/tcg/iwmmxt_helper.c b/target/arm/tcg/iwmmxt_helper.c
> index 610b1b2103..19c709655e 100644
> --- a/target/arm/tcg/iwmmxt_helper.c
> +++ b/target/arm/tcg/iwmmxt_helper.c
> @@ -140,7 +140,7 @@ uint64_t HELPER(iwmmxt_macsw)(uint64_t a, uint64_t b)
>
>  uint64_t HELPER(iwmmxt_macuw)(uint64_t a, uint64_t b)
>  {
> -#define MACU(SHR) ( \
> +#define MACU(SHR) (uint64_t)( \
>          (uint32_t) ((a >> SHR) & 0xffff) * \
>          (uint32_t) ((b >> SHR) & 0xffff))
>      return MACU(0) + MACU(16) + MACU(32) + MACU(48);

This makes the unsigned version of iwMMXt WMAC behave differently
from the signed version (which is still doing the addition at
32 bits and then sign extending to 64 bits). The description in
the Intel Wireless MMX Technology Developer Guide is not
super clear (it says "The input arguments are (Ax,Bx) 16-bits,
the intermediate values (Px) are 32-bits, and the result is
64-bits" where the Px are the results of the multiplies;
there's just a diagram of a sum being done on the Px and the
64-bit wRd input into the 64-bit wRd output, so although it's
clear that the Px should be 32-bits it's not totally clear
that the accumulation of these different sized inputs should
all be done at 64-bit width) -- but it seems pretty plausible
that this is supposed to be done with 64-bit addition.

But it definitely doesn't seem like the signed and unsigned
versions of the insn should be doing this differently, so
changing the iwmmxt_macuw helper and not iwmmxt_macsw doesn't
look right.

More generally, I am super reluctant to apply changes to the
iwMMXt decoder unless they come attached to descriptions of
testing that's been done against some known-good implementation
of iwMMXt (ideally hardware), because we have basically no
testing capability here. This is moribund code for a dead
subset of the architecture, and I am inclined to say
"don't touch it unless we know for a fact that it's
broken"...

thanks
-- PMM

