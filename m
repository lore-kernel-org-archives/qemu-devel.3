Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE8BE74AC3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 16:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIW32-0002da-Ng; Tue, 03 Dec 2024 11:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIW2v-0002Z4-2p
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:46:47 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIW2s-0003eM-Va
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:46:44 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ffc80318c9so60450281fa.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 08:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733244401; x=1733849201; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gu6IFtHi6NhS1YbAIlb98eMw8DAkKkiLvZulg8F6074=;
 b=RR0+Bilh9igXLTUoQBfoubDhogMqPbJ9IjodsLUsnu8IvJDmtjLkUqBJCu3A7GDiQ+
 jYWlK5COAPNXhIk4WPcKFFa0HIqdjNb7qXJpcMeaw64G2fn9DHN6pHlark9gSQCSbU5k
 NrSqYHT9T9DMN4KKbWDXl2rAkADkY9bjhkZZ9XkXBhUQxwb/4krWaKqtjMsMWz7JhlI3
 8pW5e/mca2dB6JV/4Tomwba4nH44a9fvn04TITdxk1PtVTYcA68S5k0WdAIHEZeF0yAd
 MYzZF80p5ID66TPFNx4IUFtYD/3UUCJm8LX7b+2yXwjNGdqmnYHlnIujI2EYesEpA4O/
 lkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733244401; x=1733849201;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gu6IFtHi6NhS1YbAIlb98eMw8DAkKkiLvZulg8F6074=;
 b=gXMfeMNVB0nJDABo6y3k8G8K4G66xCB5IMSDABdtUBPU2LRilljslzlJzkwKlcQHI4
 0ftgB9GlAqDnwDkvKP4eUqtiUvfNLkLhIN5wO8Ku5UgpGDJZcS5cbY8ezBuV1eZcQoYj
 3LOGayYcq+0E0Cvgk2zo44jeCzWoY+VeVhnfw407lWNIsf55a5r3h6huA5jiPW0GaCBl
 tZnyvDmmm930QWhwJ9yEsWxjADcqLPoXF/Lps3EGIjnIOpdad1QdfzRSRF8ekCwAi4Nm
 ygBACn9k/RQT9Cni4I0csl4uIRPoi4A0fmABbrSi5vmcbjTJ6P8nVaDeFE0pOjDN5KW2
 ExGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqq0G5NwC7X3Te1LPmtkCIl65lEVHgMYg3c04dd9A2LkLHdLYxlnIwgKkjAdk7Spq6clVZ3wNlbmLs@nongnu.org
X-Gm-Message-State: AOJu0Ywp08Ned3m1/idREYu9xcIwghQqc0s1Q1KpFIGKLZoiiG9sNCLA
 xPYxsKXvfNCwyXpX61/tzHEHaTMTko1ru7rTeGPUTD5zshkoi8yXT4FfYUK3XcMXEo7dKRNrL1x
 kl558kjhlSTmIIpJ2jaZYUwUBeaI50qd9xGFmKA==
X-Gm-Gg: ASbGncsoDRxi2RWizS0Cdyf8YOtDPDh1UPinrjKRrhiuv3oeUOPiuF6C1+1KQEF0dVf
 8NKTsJDNM6KEHZcFqpdqTslRyfSVKVfQV
X-Google-Smtp-Source: AGHT+IGdtrc+qhIaKBg5Q9kBcX67gHJV5fyWnKwnqmfmMlYpZy37iyoGBi/H8hNyHqWsdrtWGIQpP2WL6xkieIUHNjE=
X-Received: by 2002:a2e:a98f:0:b0:2ff:e5fc:fd0a with SMTP id
 38308e7fff4ca-30009c12978mr20821791fa.23.1733244400798; Tue, 03 Dec 2024
 08:46:40 -0800 (PST)
MIME-Version: 1.0
References: <20241203162525.75156-1-abelova@astralinux.ru>
In-Reply-To: <20241203162525.75156-1-abelova@astralinux.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2024 16:46:29 +0000
Message-ID: <CAFEAcA-y2-k8HnTHwTzqL4MGqrTAC1AKD5iP1s9XOTk0OrVYTg@mail.gmail.com>
Subject: Re: [PATCH] hw/timer/nrf51_timer: prevent integer overflow
To: Anastasia Belova <abelova@astralinux.ru>
Cc: Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

On Tue, 3 Dec 2024 at 16:25, Anastasia Belova <abelova@astralinux.ru> wrote:
>
> Both counter and tick are uint32_t and the result
> of their addition may not fit this type. Add
> explicit casting to uint64_t.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: c5a4829c08 ("hw/timer/nrf51_timer: Add nRF51 Timer peripheral")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  hw/timer/nrf51_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/timer/nrf51_timer.c b/hw/timer/nrf51_timer.c
> index 35b0e62d5b..b5ff235eb8 100644
> --- a/hw/timer/nrf51_timer.c
> +++ b/hw/timer/nrf51_timer.c
> @@ -44,7 +44,7 @@ static uint32_t update_counter(NRF51TimerState *s, int64_t now)
>  {
>      uint32_t ticks = ns_to_ticks(s, now - s->update_counter_ns);
>
> -    s->counter = (s->counter + ticks) % BIT(bitwidths[s->bitmode]);
> +    s->counter = ((uint64_t)s->counter + ticks) % BIT(bitwidths[s->bitmode]);

Can you explain when adding the cast makes a difference?
Since s->counter is 32 bits and ticks is 32 bits and
the RHS of the % is a power of 2, it's not clear to
me that keeping the top 32 bits in the addition and then
discarding it after the % is any different from only
taking the bottom 32 bits of the addition.

thanks
-- PMM

