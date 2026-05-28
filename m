Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7953DCD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 14:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSc6T-0002fg-Qk; Thu, 28 May 2026 10:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSc6R-0002ev-Ld
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:52:55 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSc6Q-0005HR-0z
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:52:55 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7d1bcb92072so80166907b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 07:52:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779979972; cv=none;
 d=google.com; s=arc-20240605;
 b=PlffZd2qT7vrj38YZ8xQdQF3JismyDJpi3xQG5KNrAUuadFDkidcbq+gBr9zO5m/mj
 UMlDMuJg7mY1pXCU8WinsHzOPhxro84JITUNs/iY7mGNGMe1Xlshmr8brGKOzCYmw+PS
 KK+i/D14qgVKJ7ic5LpORPDjlotb0IdOd8uMMEsq/+lO7eY5XnUcAaBFEryRxwqMLdLb
 Jxv4GLBoN5drzACzUwbiGA6pc6E+3K+Ii3UU6DFoN/OuvOJybuHEYs3/YO7bkVqZJTMC
 J5MWnSVGEiVMVr3o+o/zhI6/v6v3pr6Mq2vKD+plgZXaDM5snpJv/ky7lQbLEE5vraEd
 1wOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YAJ0dGPzwhje96Ryswv7lkftrV15fiyRJ6i2zYsnlCA=;
 fh=Q3krpAQIA0wAxp6tS0EmfBAbNCwv1IVxVd0z2YXKEao=;
 b=ljXBRbom0E1WH460N/ApesL8vj/RwfpeFA4ab50ZxE0w6PgfwqHmyrzixMdc8jC77f
 lv/DBJ/QooPn3vbmtDJzNc0amPohHzGsbryUIqnXl8/vwpbDwa+JKdhs6RoOH+mSNyuH
 fDWapZbvVknsNjKCiSuqMSGxRdcMQ+xWamfC19b5oWhnWEjiWDzZoutrwCNwP458k7I1
 zsYPHrFea0GvZDNiL8jYuPtSU9tnb1RbbqocDFN9UEJjuUx5M8ySbw6NaxezCjmoGhB6
 VNv9e+zzJhovUo5HdHMDviO1g9+jniJhRwzNYeBh3t3513LpwJtNd+2wTCJmIjqe4BSJ
 P/Fw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779979972; x=1780584772; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YAJ0dGPzwhje96Ryswv7lkftrV15fiyRJ6i2zYsnlCA=;
 b=xRmHg5JOE/vxZZZeoZD7YQJltN3lBCodI42VeEwqnURUOHKwlR5G/eqkfuB3Tkgcx/
 JPBqmJnpLN1oTUx0wBrx1V5+fZzFd0U048pq/2Dy9gmFY9cOxuHmvRuujhWihTI5dYMR
 GsQDkZdAcP9TamDbVwh2rHVK0Lyaya8QjHHBGq1rkeAtX2KC/kJ4yFTL1uSrCZyPLIGM
 mKTAmfBtUco4PH9wwoU4PKr8HBgd93UExL0q3+9XItC+9aA4PR6BIOBAJ2c8p0tG8IOa
 kKwO+XNxiTh3+RxV/CDGysgjlTttHZ+M+AqwmSh81pIuBkiDLLHeipb7ODtlszzlViHC
 tv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779979972; x=1780584772;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YAJ0dGPzwhje96Ryswv7lkftrV15fiyRJ6i2zYsnlCA=;
 b=GceMBAQLTu6L7diUA8UiGfh8EVw/dT+NwVDYdcCXBe72OkfUJqOqHtAcmx84LB1SQG
 bJKB1KPc716hz4yTC/NyPH48u7E1wNvGVITdSyJAGEdXo8g39MBf186Jj3qgWCi0EJb4
 lcy8eGXbfBgLySWbmMwr/SO36xz8ykbXbYBMJHBXvBFEyoYd6eVWqoYuwcikEXvzJYp6
 3R4T6fGZMXT12vAIAKQ8zyn1sW3wQGj3Cj1hLXCYaQ90mHRZGO4hunyFUrNi5ap8uHdA
 Z25IMqhSkWDUtCCUpctLBGrixShLaqhsXxic7J0TQA/stbeA+qPAvnFscHSdUSYM4YQj
 +dZw==
X-Gm-Message-State: AOJu0Ywhzida2VzNxfbu63NJOK7qYO/V8XW9fWoeYu9CFC0nhLsXST8B
 jjMHUMETpcWQ8WOu2zs1oXAkN5vUtpFM9QfFI7G9uMBhW6wt/xiANb+09NsjDhYVISdfGQjZ3lU
 K1Izkv2oZzuxac88E0V/9VS0cZuYld3wIF6x4wlkGAw==
X-Gm-Gg: Acq92OEfNWlDFpfC+YUM46btFJpNDMYN8f9qP5k/YV8ZkmJJWpf1HpJ2okYFPsN8X4w
 WjLVY9k+GmkU+1/rZ9XV55iO66B4LQHuk+5sHurgzDXCJp8b8RF52xmzSW2ncKBUwk6GN9Y3n9s
 PGNgA4A2Vud/MtAA5JT5pfWxOJoAwr3SzJO23tZXfeCwTtrgSVF4f65gwAWZ22A8SepyT8vkQwm
 5KZaK6IHdkM96b3Oqx/gyP3gPoVDkqSJ8OYwPzBBgZke1P9awPQMZE28Bv6gNEIhW2fq4Fzpnss
 WVioKS8CP+0kEaxqMwN6OZueLhgAHLe3cWRyY+qsTGORNhJcxPwqix0E23C2ip1ROLG5YqHgDsl
 fSBX9gWHf5HGm
X-Received: by 2002:a05:690c:6a12:b0:7dc:1d92:17f9 with SMTP id
 00721157ae682-7dc1d921c36mr44219887b3.27.1779979971780; Thu, 28 May 2026
 07:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
 <20260511-feat-mte4-v6-3-8557cc1313b9@gmail.com>
In-Reply-To: <20260511-feat-mte4-v6-3-8557cc1313b9@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 15:52:40 +0100
X-Gm-Features: AVHnY4LhXf20mD6Gfud7JWBwpztXsU0lgtjVeaZi0M5L1ySHEb28Qa0YpvAv1lo
Message-ID: <CAFEAcA_DxvTNq6qV0JXP5T+1r2035zuYM-G-n51H0ZkETPVzGQ@mail.gmail.com>
Subject: Re: [PATCH v6 03/15] target/arm: mte_check unemitted on STORE_ONLY
 load
To: Gabriel Brookman <brookmangabriel@gmail.com>
Cc: qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Mon, 11 May 2026 at 15:01, Gabriel Brookman
<brookmangabriel@gmail.com> wrote:
>
> This feature disables generation of the mte check helper on loads when
> STORE_ONLY tag checking mode is enabled.
>
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h               |  2 ++
>  target/arm/tcg/hflags.c        | 12 ++++++++++++
>  target/arm/tcg/translate-a64.c |  8 ++++++--
>  target/arm/tcg/translate.h     |  2 ++
>  4 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 0894a050b1..fce0bde168 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2531,6 +2531,8 @@ FIELD(TBFLAG_A64, ZT0EXC_EL, 39, 2)
>  FIELD(TBFLAG_A64, GCS_EN, 41, 1)
>  FIELD(TBFLAG_A64, GCS_RVCEN, 42, 1)
>  FIELD(TBFLAG_A64, GCSSTR_EL, 43, 2)
> +FIELD(TBFLAG_A64, MTE_STORE_ONLY, 45, 1)
> +FIELD(TBFLAG_A64, MTE0_STORE_ONLY, 46, 1)

You'll find when you next rebase this that you'll need to bump
up the bit numbers here, as the FPMR_EL field that just
landed is using bits 45 and 46 now.

thanks
-- PMM

