Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438D6C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 12:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfISP-00082M-BG; Tue, 04 Feb 2025 07:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfISF-0007wH-8p
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:55:09 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfISC-0003IN-Uo
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:55:02 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e3983426f80so4875796276.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 04:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738673698; x=1739278498; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oyQ8CXOngeg/b735pN3KNX+FSZLfevEtQ3Xv4cbYKyg=;
 b=CNOY7pujLKsYsYuIyNhKD+kP0fdxERVBRrWZtdfhypzx2S3raFGKhPKFUFAwF2Utbf
 2xXtyJv7CYCwW1EjG8bRIf8NBLyyUJR4l+Ishj9ZX2WdoktGkO06mqpgwKQmQYgnIEvS
 mTb/zCU5Y970VdOhOJBMG7ME1BloOq3J7cCniiefuodADDQbe6MCIJuURV01PaCUB1y0
 aoORK72XxKQupB9VGc7JvOrowkTGDnBfAsP7Itkt7r0g3vSnFDSpWexwT+KdOdO2ij9C
 2tkq3t507kejkE9xpZTzORYguMM7JxVvUg5K+Z1Xw8B5VeZITUKXgHlt5rxLYHHIm8/j
 23+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738673698; x=1739278498;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oyQ8CXOngeg/b735pN3KNX+FSZLfevEtQ3Xv4cbYKyg=;
 b=sLhlDK9QyaqGnbjjdQBRAsJz/7fIyJ2M83VZH0gXFv9kxRRLy3wA8twsQVUMDFGI/T
 BAdmIRcVww2mQogT5EVtDptIp40tryWwLSxrSzEEDZCTC4GWeoDSwr3uvKxPKz7cTpDY
 b5ZXQkXMY0mV5IGYhgbntdxSwo5ePBFlCcYWKvGizNLg95uunDE+oR/MbAXcVjGt+KDn
 B5t0ujkAX8GvsFydw5kPWZcgkF11oIYWFvQ4c4VvvX2IajAsQ5QxVgWsdiOKpZLn4riF
 k7jQJ04+N4JJ0V+BHRQhdvX2f3OV3JzX805KI/KVKSh3a5gSO12gHIVopbAhlgLUMu/m
 8wsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxiVjOKhVv3FvlC8P/ZMgZ+HJvD7bb6d1WSOcT+czZZs1h9pSbJgPhsxZC5amKCYHH5RB1C5qrT5I7@nongnu.org
X-Gm-Message-State: AOJu0YyDm+gmPdH7I0vxb/0V1R2DIr7mwFFt6/hNOFZ9EP8jRMzDnghn
 q3h4sAaVu7gxTjCn90HJweoq/48QXaniO0cQLe3U9oZte3tKSU/nbURDIQR/WIx9G2DtFibDuW6
 yJUrhscG83c+5Aqa6hNHDVKK6mRVc8TUTVhFGxg==
X-Gm-Gg: ASbGncuaLO7vmyPJoV/WAtewRl6AenbtYblo8vpc1iAP/RuKK4ZlhpkBFW6PFPn2Rnd
 5b3idXxsqm+I9G3Xst+ixyLdwRxPHLbwVcyqC0MG4YHQJcS3ovkStvKQDQlUcGEHlnlMKH67TAg
 ==
X-Google-Smtp-Source: AGHT+IFJtbpLfUH1SlcKK/7LrQyJ3s7gQlxBgS+UJVgTkxqG6UnycPK8qR7gdpC6G3FjKFOd9i8Zca6jqGJRmYRpPEc=
X-Received: by 2002:a05:6902:1ac6:b0:e5b:16b3:ecfb with SMTP id
 3f1490d57ef6-e5b16b3edafmr1190308276.35.1738673698111; Tue, 04 Feb 2025
 04:54:58 -0800 (PST)
MIME-Version: 1.0
References: <20250127123113.2947620-1-peter.maydell@linaro.org>
In-Reply-To: <20250127123113.2947620-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 12:54:46 +0000
X-Gm-Features: AWEUYZmFgUpkCvg6DWFgEyBWwRxPuynyYrJZJmt0_i4uSp_OUbuCqwhzPbaHjTI
Message-ID: <CAFEAcA_J+dVU2gKHVf8y_mrPMfyBWKCuJZQoaurbT7qGha-9HA@mail.gmail.com>
Subject: Re: [PATCH] qemu-options: Deprecate -old-param command line option
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

Ping for code review, please?

thanks
-- PMM

On Mon, 27 Jan 2025 at 12:31, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The '-old-param' command line option is specific to Arm targets; it
> is very briefly documented as "old param mode".  What this option
> actually does is change the behaviour when directly booting a guest
> kernel, so that command line arguments are passed to the kernel using
> the extremely old "param_struct" ABI, rather than the newer ATAGS or
> even newer DTB mechanisms.
>
> This support was added back in 2007 to support an old vendor kernel
> on the akita/terrier board types:
>  https://mail.gnu.org/archive/html/qemu-devel/2007-07/msg00344.html
> Even then, it was an out-of-date mechanism from the kernel's
> point of view -- the kernel has had a comment since 2001 marking
> it as deprecated. As of mid-2024, the kernel only retained
> param_struct support for the RiscPC and Footbridge platforms:
>  https://lore.kernel.org/linux-arm-kernel/2831c5a6-cfbf-4fe0-b51c-0396e5b0aeb7@app.fastmail.com/
>
> None of the board types QEMU supports need param_struct support;
> mark this option as deprecated.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/about/deprecated.rst | 13 +++++++++++++
>  system/vl.c               |  1 +
>  2 files changed, 14 insertions(+)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 29de49351d1..a4c7d642236 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -68,6 +68,19 @@ configurations (e.g. -smp drawers=1,books=1,clusters=1 for x86 PC machine) is
>  marked deprecated since 9.0, users have to ensure that all the topology members
>  described with -smp are supported by the target machine.
>
> +``-old-param`` option for booting Arm kernels via param_struct (since 10.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``-old-param`` command line option is specific to Arm targets:
> +it is used when directly booting a guest kernel to pass it the
> +command line and other information via the old ``param_struct`` ABI,
> +rather than the newer ATAGS or DTB mechanisms. This option was only
> +ever needed to support ancient kernels on some old board types
> +like the ``akita`` or ``terrier``; it has been deprecated in the
> +kernel since 2001. None of the board types QEMU supports need
> +``param_struct`` support, so this option has been deprecated and will
> +be removed in a future QEMU version.
> +
>  User-mode emulator command line arguments
>  -----------------------------------------
>
> diff --git a/system/vl.c b/system/vl.c
> index c5678267182..32ee1ce7041 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -3438,6 +3438,7 @@ void qemu_init(int argc, char **argv)
>                  nb_prom_envs++;
>                  break;
>              case QEMU_OPTION_old_param:
> +                warn_report("-old-param is deprecated");
>                  old_param = 1;
>                  break;
>              case QEMU_OPTION_rtc:
> --

