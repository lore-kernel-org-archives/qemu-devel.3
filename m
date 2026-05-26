Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452F0CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsc8-0004NQ-Ip; Tue, 26 May 2026 10:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsbv-0004Jx-0v
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:18:24 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsbs-00065o-CH
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:18:21 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-654672a6d68so10132165d50.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:18:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779805099; cv=none;
 d=google.com; s=arc-20240605;
 b=apP7fgDUeMFRiLE2Tgyy1AS8fdGDOlhJalWRhNNPR+EIu5YGlBpO3FEPqPIgCS4+LF
 sGBkyBcH0ejhklE+JTB+Fhxl4F+JJinfJXVKddkfXDY5lo2xx28h+ufswGyF1pVq1Hqj
 he2kmf/YyxXzV06iDhN7Og+gT7vz16JwKEYoepNTdAzyc7C3QbwNe1dyTqUdqg/dAL0Q
 comyIgVT1pfVS0t2EK4ZTTaKdtWWfU4oFwRMgqiJSxA9SSMUjjmG1ItHEXS5+rGNT7lh
 hjaSlXVdOXEVSwRNpC5M9ncjcBx4YJfr+gnuQ6lUt3mUFQtSTVUYGYibR26QAsSB29cB
 OUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5435hPVfkU6qu5ckWttJ1DUdzguYwxrzKpqM4tOi4wU=;
 fh=VUZ7eJox894qpEuQTEFSefKlY4l3x+uBmRGBSaSsOHU=;
 b=Ee6mwT77HDXp9CWE8i6dDM3pXfuOqfxueFNYdkpTIeq5oHWbvRqkM4TbYtPS3LUIQV
 msVJ924gA2LH71+AQALQ/9eehpY92l9iRhUYjVlddMX29Zfz5wheD1XHfGGGuuV9AcwO
 dSbcpDIXzQ7jEdRYZtwE1wgj6z1hbj3TUAq9eBl1IeSwujqvj3AucKd7mpioPR5WUqyb
 fgjclJSzFXkppP+m6Kaf3iZyg0k04qpUli8P15Qhc3xLH11EevQls8mCL9Jg/DLvslFi
 /QlUmzgp78xZCDGPJlWGauzvOBVeRAG9+e9W7MewJiCFRKEhCqe7Ji04t/zN3UqXqqkC
 EFdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805099; x=1780409899; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5435hPVfkU6qu5ckWttJ1DUdzguYwxrzKpqM4tOi4wU=;
 b=YX5WOQl8jpZPD5cE1PAy6ylfbPPg/TxYLXPbmIFNXcIiRAVGUjZZY9hLiPcWORQRLs
 jEUcqnLqqHwmdRtGMzXyR9Qxy/31aOYPRXUjFcjp3JZvBQloVOHoryKKnQlKG8jRv3MW
 RldNcqHypcRcSm+oXKL2H/HZ5ue6/YZ1Q8+eCH2ZjO+SdEtOaeJmjAifR2F8T3TDtwV3
 EUPb4rL+r0meclOsvnOX5G7+gucalGK+po+EyaRVMzr/LU/8QbkTsD8IMmPigcdc2ksu
 8tM9h8nnyRu0NHhdAPSVIvpOwhBnkciUtn1F/E7kI98vm38FPxEMl4RArbH/CEDpw7fo
 BuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805099; x=1780409899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5435hPVfkU6qu5ckWttJ1DUdzguYwxrzKpqM4tOi4wU=;
 b=E6eTR5xSQY5mbz9PZCiJ1vg46KW7uMIwhgKJYM+QVrVO4dw8nWwPAVoVQBBFvYinI0
 Q17b72daYpkMF+Dv3xGcZb0F3m+NY+K9zM1YICpYXSPzoIfzkCEkvFzv7ogwhsmssFCV
 iIu1h0AxKZavw36VSoNlBBjPFzW/O+0nS1vCF3Yf9A+sgxszEhXvU2ZjG0CEWr3vot2U
 upIWBPtLyFFSzanJGW6sOztlhVxFahwAg64FW9wrWDSYUO/kC8zcMjfRcXw4sqL6al+y
 JN0eT9w03J8ScApBrt9w/86RHTN821VrMmeC+9/yCYfvcxaqeD6KBk4sowZ/JzBZAckL
 iR5Q==
X-Gm-Message-State: AOJu0YwZtPjCZYF8M1jULOZojlw2ip0NqRksRdCD20SY8PmiUU1pzdjw
 p2ts3UfX/NeZSgDgy7zHdvlIFi+3XhJ8guCViisu+641K5ydLd7pjdxhMLOzX81By5C1/XXAUPJ
 3RXfNfuhijdWQVvTbPQg0uN0DD1MRgG4tHST/f6j/XA==
X-Gm-Gg: Acq92OG8SmXQLEBMdLPKF0jDGRvesjHdHkVZ0yGf05gXVudxH4+4Tr+gottwtLwxzCB
 Q9TjeUJszuDdDn042RMdT6NAmge1qvhUsH6EfbsthfHq4E39rtG1gPt8c2vusemBxe6bOmKYExV
 jg9yypZx33TsKh3oW+8zXCdgSqx1+0TkizeT4evnUb0xXoZMUPRRGtnCCPFSDhatfG/hjAglmNH
 8InFlgwesMHYd6lgwzioc4EdVquqqLrkkT3rGJB/yTAnNw0hYrTDsFKEDQ8znUaAZZztiaJKmYC
 EnTKdrR37/AjEeTCDwt4MWmXTZ65ZHD73FGAV/rqYl5EJ3qycmM+btwSMYv41Env/fqyVLvjanC
 kgQ==
X-Received: by 2002:a05:690e:43da:b0:65c:7636:2b09 with SMTP id
 956f58d0204a3-65ec96184efmr12202133d50.5.1779805098821; Tue, 26 May 2026
 07:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260430091832.1846637-1-kchiu@axiado.com>
 <20260430091832.1846637-4-kchiu@axiado.com>
In-Reply-To: <20260430091832.1846637-4-kchiu@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 15:18:05 +0100
X-Gm-Features: AVHnY4Jl03-LKQ5EcWu3RuddstO3EiGHE356JXisztPvI1Rm0TUDzhsj4iLFUeg
Message-ID: <CAFEAcA8a6iSeqOf_PsMSEV_PaNm8NoBrH7DpOYFK+K=UjtiD-w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] hw/gpio: Add Cadence GPIO controller
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Thu, 30 Apr 2026 at 10:19, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> This patch add a new model for Cadence GPIO controller which
> supports 32 pins and interrupts for level-triggered/edge-triggered type on
> input pins.
>
> Also define new trace functions for analysis purpose and new configuration to
> enable this model.
>
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> ---
>  hw/gpio/Kconfig                |   3 +
>  hw/gpio/cadence_gpio.c         | 301 +++++++++++++++++++++++++++++++++
>  hw/gpio/meson.build            |   1 +
>  hw/gpio/trace-events           |   5 +
>  include/hw/gpio/cadence_gpio.h |  55 ++++++
>  5 files changed, 365 insertions(+)
>  create mode 100644 hw/gpio/cadence_gpio.c
>  create mode 100644 include/hw/gpio/cadence_gpio.h
>
> diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
> index a209294c20..fcc7c70bd5 100644
> --- a/hw/gpio/Kconfig
> +++ b/hw/gpio/Kconfig
> @@ -30,3 +30,6 @@ config PCF8574
>
>  config ZAURUS_SCOOP
>      bool
> +
> +config CADENCE_GPIO
> +    bool
> diff --git a/hw/gpio/cadence_gpio.c b/hw/gpio/cadence_gpio.c
> new file mode 100644
> index 0000000000..2410753abc
> --- /dev/null
> +++ b/hw/gpio/cadence_gpio.c
> @@ -0,0 +1,301 @@
> +/*
> + * Cadence GPIO emulation.
> + *
> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later

Is there an available data sheet for this device?

What is the actual device model name? "Cadence GPIO" is
extremely vague...

thanks
-- PMM

