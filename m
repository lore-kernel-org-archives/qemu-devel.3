Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40BCC87FCA
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 10:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiWEA-0005fU-1h; Sun, 03 Aug 2025 06:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWDR-00056Y-4a
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 06:45:22 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWDP-0005GP-C2
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 06:45:20 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e8dfa190de4so2566720276.1
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 03:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754217918; x=1754822718; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4eXKacnvhBLnN5QOXax4kvfMjGHxZxxVKn8kCzgpjkA=;
 b=EIxhgK6x/N56zkxUsWn6Vu5zEUEDh/8eTfXbMpXoKCVpfgz/6Q7INmhIwKPi/jFtEF
 JXiSiifPiKw3Vd6/OdR0LkAGXMWV3Vo4WVoYO7AuUjwN3khMw+o8wLGX/2G/6FMFIhb3
 aIoXKNmGB+a8ZGEx0HxHH/GlEgPg5uSQFvBvPO6bcGug1dHPLRTUDVjVs3xOM4XXke8G
 k0IPp9uzTvdGv9fPxEW5kiKl6ut2w1z94YHG/4foJaH3c48mCTgWU6EZPg20ImeaaN6k
 ow03dJEFIHbomcEzHO64RmWP2l9c8j2j3cXMy9Ihq0di8AxsgGAkOYIP6dGy1P9TRAK3
 40fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754217918; x=1754822718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4eXKacnvhBLnN5QOXax4kvfMjGHxZxxVKn8kCzgpjkA=;
 b=YvAaBcIjcnlzjv9EGXNjlORmS00AdVBrB+HX1uPR9SV6eOQAahBY82jhq//OwF5Oef
 Qlher4aCs1+rVz3EkyWwqmmQBEkXD5vOsR0psNY9avXlvKEDTjAd1fvPA8Z4CBCwxC0T
 vIIxNt+FFZf9fuWN6pOaQjqtjs0sOTAyDrGrwE87+iXHPrCyDiipnmNKlDnR360+YusO
 MNXl01mzmYME+1cPOWsrBBetcBhvqXm0FROSg2bOr+6Xwwq3RBNLAEJyhMQSyu9fe3Kd
 JW5fmTnJaqzxWSf3E5h1x/NMuZOor9XN8yCsH4tF67HU/arnfpbtkx8ViIJDeZxMi709
 kE7g==
X-Gm-Message-State: AOJu0YybE/eK9E0oMXq3GH37dtoqs/bO93TljowKSs1jEwRaGF2Rv/7V
 9cjUukVu5sBtDQUbacoPwzl0nZA24sbTRWEFXMbjS9YCShDKkJKzQqRkbB79q6sAInIc7iI+znH
 GsBVlcXvI7ZJj8dfy6LWLzKYQUKjWDTs/l5n69NsDt+AXRwXDFTqY
X-Gm-Gg: ASbGncvYu7TI5eEftU5TPJR/AnoFXOjbKjUyp8laacyMjXVLcAS6bWMNP2aa3FhES8y
 2UUbHUl2RWzRnnNgs/rZ3jdbwfDCGlgXifxA+KJDAIH3gms3pOS1wnhENyMHd2IdM1Sa0VVNX5h
 zR2diFHZMGmS+BlOn+/J7J/3NJGlsCrHetf7gEpUiBD94aV++HOz96Mz5eXvA31XMoGTrRbf581
 OS3kSmH
X-Google-Smtp-Source: AGHT+IHCS4s6rDBLqQ8/7QyVteilufwl+AYX70H3pGu8Hq6JaUDrBs+sbR32LkE6fWdmD1fAsaHYc6tz/irLZuy0I/w=
X-Received: by 2002:a05:690c:d8a:b0:71b:6c7b:c7f7 with SMTP id
 00721157ae682-71b7ed4fd3emr68404117b3.10.1754217918263; Sun, 03 Aug 2025
 03:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250802230459.412251-1-richard.henderson@linaro.org>
 <20250802230459.412251-29-richard.henderson@linaro.org>
In-Reply-To: <20250802230459.412251-29-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 3 Aug 2025 11:45:07 +0100
X-Gm-Features: Ac12FXwZyN98l7JGv4BSkyAJjT1FMh5Airp4uQTpPHChoByuzjvcjJKEZ4C-GiE
Message-ID: <CAFEAcA-Ec4gr_keawGfzfyQkkuNW5fo+Uz8qfZz-0pcFjW0Dyg@mail.gmail.com>
Subject: Re: [PATCH v2 28/95] linux-user/arm: Remove a.out startup remenents
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Sun, 3 Aug 2025 at 00:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The setting of r1/r2 was removed in kernel commit acfdd4b1f7590d0
> ("ARM: 7791/1: a.out: remove partial a.out support"), and the
> kernel commit message explains the history.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/arm/cpu_loop.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index 739e1607e3..9aeb9b0087 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -492,10 +492,6 @@ void init_main_thread(CPUState *cs, struct image_info *info)
>      env->regs[15] = entry & 0xfffffffe;
>      env->regs[13] = stack;
>
> -    /* FIXME - what to for failure of get_user()? */
> -    get_user_ual(env->regs[2], stack + 8); /* envp */
> -    get_user_ual(env->regs[1], stack + 4); /* envp */
> -
>      /*
>       * Per the SVR4 ABI, r0 contains a pointer to a function to be
>       * registered with atexit.  A value of 0 means we have no such handler.
> --
> 2.43.0

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

