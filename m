Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC82C531C9
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 15:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woNjo-0004Yo-Fv; Mon, 27 Jul 2026 11:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woNji-0004YY-TO
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 11:59:27 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woNjh-0006Vs-E9
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 11:59:26 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6689f36ae56so3883598d50.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 08:59:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785167964; cv=none;
 d=google.com; s=arc-20260327;
 b=PPa40HoMRzs5zz6YqxIf3EZNIEh6OH+Mgtpn2wxp7waCmyrOIAISPxE+WgMVr0tuJG
 STfOX/wTCDV8GZjd9B1TzBZbMjnvzLbjGveN4TAOoxFFixE503+yzzJphxD2hyOyksTs
 bg8GgcZIhZUXi3wWOWMnhX+J0AFCrJpRQRVZSWK/ZpRGca6LhMF55PiKHGzpuw+mUOSQ
 U4rHfKtWtF4Lq7fQoAkjfGmexkgApLeaNF36ygVVF1sRcbz/7eVJTwLnnRbnIF9NOxLs
 Mz+wgSkXfhPYJnwS2pi4HczwbEzPagJQETtMgMMjsY5VF7eNMGLzkmcdi9lvbK/gfhnl
 uIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=LzCA0dcBWw9zMpBSkkCLQ5WnVwl27Gu831ToutkkOXc=;
 fh=is0PmghpAaD8HWE2NeKY0gf5ol8lwYlrfMQpiQ6YqX8=;
 b=gqzYmcFbPNu+MOYwM+vnFQjY04+HG2OaTb67BuYaOM1ssFKWVb/XAJugGpyZIrBcjR
 cNd6LyVCbpdnFbA5L4Dj3KGEKURwUqIAV96At/EVqyZfFE9U+Itdpj4haFitKV2TeqSk
 Bpg8eI84WX+9cMRCZ2H4t79VhQhnyKLe31wl3Y/6aXWx+8ZdJEUvYNX9SPqyw9b6of2O
 /pqGg4Z8A9yDdUO6L2TdEcAiFkGp1ML1yC9se1Str3PlSfQYdvKibIwldFYPtE8eoSzH
 crHzLQmxGJGivb+iFnTeSTO3t4qhmy9XqE9mmv7HFU56s6pr1gKYGCtMJxiLOcBPlvJd
 UHbw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785167964; x=1785772764; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LzCA0dcBWw9zMpBSkkCLQ5WnVwl27Gu831ToutkkOXc=;
 b=R/9Dnue3xrj30dNVAxd0uVKHbDQBCY99W/Fjn1z32o3+YqclJ9iblt9Y5IvNvUnwz/
 CStJTqceblWg2BWiUAkZhGVp/9JqQxCus/0VvdJ0rR+HLO4bxWfKzNpm9zluHMQfk9S8
 6XRMob4uqKMJltHwAJRF+lRcyQbUjU7hNkRp1jSc8jvmT1bCe8x3zMIQDibEg+TIQuBX
 oTPZEn0vtcyG2esuFV7CaK1TYnFNX2376uTHSmnfKWQKj14GeDOy1ZcIUDD0WwJcaMrX
 hnXRmCVKDqTkImKc8Zu9tumM7qJDgrWJWBScfjd1yJ/PY1YffYFy+26et2/PZkrEJTwk
 aYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785167964; x=1785772764;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LzCA0dcBWw9zMpBSkkCLQ5WnVwl27Gu831ToutkkOXc=;
 b=RfmiJ3AHGi1TzBvnlNUQocU+zJcWgO7jyrmWX+ogkdMK+rpyJOm0Y9cjmOjmOxhpMw
 rexmZWj8fw7dhLpTwi+ccEBxicxGABtzXFTfD+k5+67dakJ5nAQdePMQSXXD8ymuujP9
 +R8QG+5rNzsJ3cxtLr5RkhL5D2b/kzRwQfAqSfl8W6MsodqmBnnOzW1v7Jw+zR2Jgzrj
 mnIrqFKyWnNdqsD43QY1Qlffiyj4u2A4xkvIKN2ptRHrtqUsJIuhI7jyoBtFwNQ1HMyv
 n7AaSe/ksORr06LDCjvJnl87exL3K36uok9wrUOLgUWczRV9eUcWLLYaTV//Hga85m1R
 VIVg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMYNOBwlfdLvqOCf+r8FnNzv0S+Ua5n/P8ZGnd1nZbXgLyOOw3C2l9Fgz3y7XtbnSrayZQX1xVJaa+@nongnu.org
X-Gm-Message-State: AOJu0Yxhl9qlpk7irJFCDEx5TJOYVANFQi65ofA19EnWKe2104z3UdSy
 y/LyiHGPajz2OWXZh1UqSX4Akh5DKRQKfxJAQqGZSZ/GHXxemUDASBOBzKSxQ3Y0A5ffoefOgfj
 V5wcyeGSxdcZGbjCl/q5fH/FYjGJXKgG5Ub8FPMeEtA==
X-Gm-Gg: AR+sD136Czs0gt7Y/Nc7b5k023WR1L3DaukEQy7U5UeZtvey0qrXeHyivl3yBqw+EhJ
 iKO8pprNyQ9B/4eBih6uWeMTtNmxBLrxcn5o4W7TQ6y7hY7i+LahUABj+Xgl38uRLYfJMywzazG
 fvB53QY5wTkkLzDKDsz9Ws6aPBLPZN0n7k3i4Nc5ebQacyRr/FeVRs5hy9JXjgGQ17dFtRb8kQb
 1Yitd/LeJDuDB4rryHcAMt2Lv4GbdWuhRgiVakymCTxA0JJ5N7X9eF8hKvTU5NZnY5/b/lYvACV
 GWJPe/dpF8QzW8zOAN1v9vx1pgEjq2Lj6oT82OzOo7XA+g==
X-Received: by 2002:a53:d045:0:10b0:668:311a:d444 with SMTP id
 956f58d0204a3-668c7c31410mr2054205d50.106.1785167963650; Mon, 27 Jul 2026
 08:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260706173324.804340-1-peter.maydell@linaro.org>
 <CAFEAcA-C4t+=KYiX5sk_Fj528u2MkB4AE74gC1yrWTzAxmTYew@mail.gmail.com>
In-Reply-To: <CAFEAcA-C4t+=KYiX5sk_Fj528u2MkB4AE74gC1yrWTzAxmTYew@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2026 16:59:11 +0100
X-Gm-Features: AUfX_mw6ZDsX8z5Uy4FWAFW2YWnUqtzXC94srrSFLgVBsAoAvrNiIX6wwTpZdwc
Message-ID: <CAFEAcA8rFv3B5r8ZjwD080NO9mpc640QLsy0_bugkADKYBPz8g@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/display/exynos4210_find: Clamp windows to screen
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
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

ping^2?

-- PMM

On Mon, 20 Jul 2026 at 09:40, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Ping for code review, please?
>
> thanks
> -- PMM
>
> On Mon, 6 Jul 2026 at 18:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > The exynos4210_fimd device has a setup where the guest can program
> > both the overall size of the LCD screen and also the corners of
> > "windows" that define where the guest memory should appear on that
> > screen. The current code assumes that the guest is sensible and
> > puts the corners of windows inside the overall screen. If it doesn't
> > then we will try to copy data to an address that is outside the
> > interfal framebuffer memory that we allocate to be the size of the
> > screen.
> >
> > This patchset clamps the window coordinates to be within the screen
> > size. Patches 1 and 2 are simple refactorings to make the third
> > patch easier to read.
> >
> > This fixes https://gitlab.com/qemu-project/qemu/-/work_items/3795
> >
> > thanks
> > -- PMM
> >
> > Peter Maydell (3):
> >   hw/display/exynos4210_fimd: Factor out finding screen width/height
> >   hw/display/exynos4210_fimd: Pass width to draw_line functions
> >   hw/display/exynos4210_fimd: Clamp windows to screen size
> >
> >  hw/display/exynos4210_fimd.c | 54 ++++++++++++++++++++++++++----------
> >  1 file changed, 39 insertions(+), 15 deletions(-)

