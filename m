Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BFFD64063
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 16:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9S8n-0007lP-Hc; Fri, 08 Nov 2024 11:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9S8j-0007kr-LV
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 11:47:18 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9S8h-0007G6-Vj
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 11:47:17 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-539e13375d3so2931396e87.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 08:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731084433; x=1731689233; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R8zGb2dhUd3CPvTZFvmjRInsJcZ7jyLj7QqnuR/5rPI=;
 b=zeusT1/V2u41oukGYSfPERlax77H7YO5cP5ja+XkZGidjZfmwjqJwEtAgK5UuOTrin
 c/zsVJOJaX0x4dUdlWqP/Hevn9h6OqBxvSS1OUnMGJmreIAJKCQDcvfmnlF6mXqNN1zT
 xDKGgHZ2XBMtIw/3EnQKuRoWL9dUoMtcY/J/Ys/UOjr4qGQVl05qh49OHZzw1thlkI4s
 50kv8GFsNWhyfb2+1D606WlBt3lPHFETG1KMXkjQnw3IlDK4Fj2K0TtcWVdzZyD6oFCJ
 Bf1Rn5tQblh8EOWvK7xjAzsBZ6V0tEEqE22v0ppjKTjMiqAx24fQ+wbunPs6rGzJ4f8N
 Q0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731084433; x=1731689233;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R8zGb2dhUd3CPvTZFvmjRInsJcZ7jyLj7QqnuR/5rPI=;
 b=X/WNNRykyEYomS8x0YnuBWDMiJbYrqJeeUhqtyNoFVSBr9BJmZjokDH4xsdN7noTLT
 JHi5phnbU8AZlCP2qR5SSHcvCsrVmrDZ/4tsz//hDzRHkcIhcPLBHPkkI9NWpClFw53x
 mu8HsJ7REz4t1OBdOPdRzAVj1+O/J+h3po7Toyngo0uXbEVtMsPVrG5aMDsR/FbNFIwj
 YocUqcyUvsVHhgZ8sifOG5bHd2iz/XYsa//xsZ3/vNCPSmFEsAFfLKtrwWLmCzRTrnxr
 /IFzbmtmd4ZzdCu6bFjI3sdbAj7woRKxDQFnaVhp7HFznva5MVRuNp+CQcJJwvLY6syj
 uoMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkSc5+qxlorlaump0tzrsuYWv4s/3F5UUblI+UaoCoju5RA2yblxqqhbceAWLQF8psLY1vgX1Jrn9j@nongnu.org
X-Gm-Message-State: AOJu0Yy+ZNjou8p+wWP2klPsckjMuc4R1NwuhLqXvOoyzToA5aZ42Bcw
 0V1relgv7Iut2AcNw1q9qUF4GSQKj7Hi8sUMOqC8K7R7/38y0meZVM9BaNvKb3n8XgnSZeFVLxG
 a9kbVKTxPGQPh8b15Cqi45F82ysfaD6MAeMc/Lw==
X-Google-Smtp-Source: AGHT+IEQ3IeQKRBoR4BldOHAat+zBcEbAV9rh0r1K6v71PYynqkWIMBRL387bJcTVCQbHjPV8g6zQX+vE8Y0rUjWEZc=
X-Received: by 2002:a2e:be9b:0:b0:2fa:d604:e525 with SMTP id
 38308e7fff4ca-2ff20225bbdmr20236071fa.28.1731084433203; Fri, 08 Nov 2024
 08:47:13 -0800 (PST)
MIME-Version: 1.0
References: <20241106083801.219578-2-frolov@swemel.ru>
In-Reply-To: <20241106083801.219578-2-frolov@swemel.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2024 16:47:02 +0000
Message-ID: <CAFEAcA9joGGX46UnkVvapvhyFr7ryhMeczWdT7D+wJLfR4wyCA@mail.gmail.com>
Subject: Re: [PATCH] hw/timer: fix possible int overflow
To: Dmitry Frolov <frolov@swemel.ru>
Cc: i.mitsyanko@gmail.com, sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Wed, 6 Nov 2024 at 08:38, Dmitry Frolov <frolov@swemel.ru> wrote:
>
> The product "icnto * s->tcntb" may overflow uint32_t.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>  hw/timer/exynos4210_mct.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
> index e807fe2de9..5c6e139b20 100644
> --- a/hw/timer/exynos4210_mct.c
> +++ b/hw/timer/exynos4210_mct.c
> @@ -815,7 +815,7 @@ static uint32_t exynos4210_ltick_cnt_get_cnto(struct tick_timer *s)
>          /* Both are counting */
>          icnto = remain / s->tcntb;
>          if (icnto) {
> -            tcnto = remain % (icnto * s->tcntb);
> +            tcnto = remain % ((uint64_t)icnto * s->tcntb);
>          } else {
>              tcnto = remain % s->tcntb;
>          }
> --



Applied to target-arm.next, thanks.

-- PMM

