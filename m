Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AFCC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 12:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s92T1-0004AN-4I; Mon, 20 May 2024 08:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s92Sz-00049v-13
 for qemu-devel@nongnu.org; Mon, 20 May 2024 08:50:13 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s92Su-0003rG-SM
 for qemu-devel@nongnu.org; Mon, 20 May 2024 08:50:12 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5751bcb3139so4018634a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 05:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716209406; x=1716814206; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2ixQmw20dR9maTZtq6FPKPfJlf+1+8yLpTShmbUGfU=;
 b=FvUVKOZfvWv7Jkyv5bnLCXY7z5ZyKiSy6bcC1zko11VjjhnMqt0KQFD5MERE4wMufK
 J9e7M8jWCEiGyzoT1DXBZgw40Cjk1vu6XO4OOWEbDBkk5LjCAWi5AsF1+/6zOFF2+GEi
 sezj9gLCMWomfUgWwZvP1AaZvc4XH6EfnjMdGCTXEJMnpU+N75Sja5Z9bkwYWICK2Cky
 aCNqwcyrYA4XZ27p20TmkdQqbvkUQ+HWmuuWEZxrXsZfM1CEFYAKeJChh1myJPUdFvaV
 s3excVCB3TO9S0wkm4IWCoOJ+L+6dEuE3RSqPn20kQnWyjJVN73TmC7H6PExhovR+7Wl
 x0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716209406; x=1716814206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+2ixQmw20dR9maTZtq6FPKPfJlf+1+8yLpTShmbUGfU=;
 b=VVcvjgzYevfnYozzavFWwsWNL2dfRDkG1nxxoJLXLHBvS4UUFlhXBkp6O9jlNOLiM+
 +3nSRLkKZzOZsSGurBtZqAE+g9t5ohf5djnDL4NBtQ+ExzgbotR6DuIkQcrKoVFMWgOO
 ShA+afPQ8cv5azbJQ8Of3LUWiKC6Tp0rqw/Vc8hJkBaAx7YjHGAhY0ERYQA53b/yJ6o3
 KBLwOFHeNtUlRP/ILnoKgsxV/tkFXSBiXvEL4b+DiPZCIjm8lfmOiQwgKwXq9bX/sX4J
 lFOnX0HD+IySenkcmtWGFys9qTmabP49VgbJKgXx5I85HlfXOtPywWvzj5l+xXqbZixZ
 XdsQ==
X-Gm-Message-State: AOJu0YwjhDUrsqCWtmvmqMRgvqxTUv7aNwaImLq8o3IpE7ekXdRctqyH
 P8SOLL+h4uuI5f2mjD5IWs9l1/Izoz7ABXx1QU5qlzNN1b9fj6SkvLXbO6ahVrojt70qAGVHduo
 RQJJuGfYOfv4mbw4Fzeh3s0MT0bja92Ayn2tKfw==
X-Google-Smtp-Source: AGHT+IEPhw5DuIh/WDYgD9avG/SDHYYc7FTfX8omiaipTCON/s5yTwOgTizSMeewQpvQVeXCnXDpeW1nXrPeH87faj8=
X-Received: by 2002:a50:9fc9:0:b0:56e:24a5:587a with SMTP id
 4fb4d7f45d1cf-5734d5bec0fmr22990260a12.11.1716209405662; Mon, 20 May 2024
 05:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240508143513.44996-1-philmd@linaro.org>
In-Reply-To: <20240508143513.44996-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2024 13:49:53 +0100
Message-ID: <CAFEAcA-apsUZeNdpC9QfJm+Xqr8Z-LhfZXiv6YxcSXo2bKsocQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/input/tsc2005: Fix -Wchar-subscripts warning in
 tsc2005_txrx()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, 8 May 2024 at 15:35, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Check the function index is in range and use an unsigned
> variable to avoid the following warning with GCC 13.2.0:
>
>   [666/5358] Compiling C object libcommon.fa.p/hw_input_tsc2005.c.o
>   hw/input/tsc2005.c: In function 'tsc2005_timer_tick':
>   hw/input/tsc2005.c:416:26: warning: array subscript has type 'char' [-W=
char-subscripts]
>     416 |     s->dav |=3D mode_regs[s->function];
>         |                         ~^~~~~~~~~~
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> v2: Use Peter suggestion
> ---
>  hw/input/tsc2005.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/input/tsc2005.c b/hw/input/tsc2005.c
> index 941f163d36..8d35892c09 100644
> --- a/hw/input/tsc2005.c
> +++ b/hw/input/tsc2005.c
> @@ -406,6 +406,9 @@ uint32_t tsc2005_txrx(void *opaque, uint32_t value, i=
nt len)
>  static void tsc2005_timer_tick(void *opaque)
>  {
>      TSC2005State *s =3D opaque;
> +    unsigned int function =3D s->function;
> +
> +    assert(function < ARRAY_SIZE(mode_regs);

Missing ')' -- this doesn't compile ;-)


Applied to target-arm.next with the typo fixed, thanks.

-- PMM

