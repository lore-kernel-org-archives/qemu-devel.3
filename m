Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE93C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 14:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSHQw-0002jG-QH; Fri, 12 Jul 2024 10:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSHQu-0002ff-Fe
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:39:36 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sSHQi-0001g6-JQ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:39:36 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-595856e2336so3533709a12.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720795163; x=1721399963; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMKy2xWPKN8CaCqln94e9oqRO63Y+oepTLF5KfbXgKA=;
 b=RCMYWU7wZSoTxKKSUO5Qrdx9aahX3xYR4YEwVEh69kBOn39gwT7qc/t+wy75UA4mnG
 RDwDs60Kup25rWGPOuaVvAsOz53kp9q68xGImtsB9CnF2xK7waLcvSaAmZ6B8StWgF36
 uDmEjP9RWe+aGzo2HxAy4xuK9dhQFLz+SziHpuaJQPa5NvSixVONPc7cRewwhoygiABR
 HLFtMCyz69LkCzUGcbDFauGIMAhdFAz1+aI3BsoorbceekGqXggkHaQcAG+GUl0bdqbf
 2t8AgJMM5sy5vUilRAOGw/vR2I2Z0AVQ8YV30i0Yg5TqVJqpJV5Ipe0IT0VPfCZ7g3Ud
 Nj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720795163; x=1721399963;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMKy2xWPKN8CaCqln94e9oqRO63Y+oepTLF5KfbXgKA=;
 b=Cp78TBxeVo7+OmRuT8zMhj5pHSzZcmmaBslfZrvI6G4EFMe5F+nd8F1QQStCguj9As
 ApfK4HPHEMKzcrbH5nu3Xlm45xuG+L0Nk91O6JAi404gkOmFDwTfxcf4+1n4jkDB5zDB
 ANyM2AKOZeSJeKXWJzZUeIKvMR4GHMPFG8KkwG4v32Sl2zjAkU/F85nTsbNffdNgjf3R
 aXjC1LLSHSh4IE8OjGkYjZj3gSW61HtTq5o079Tb4/C+hcwvAsG51ucWERXwYfP7Mshe
 wsxaXlwZHPZ3j9XkgPOPIgRp1wOJYxy5DeWEJjINYTXqhym7krMD/S7qlOjck00WGKAq
 +E9A==
X-Gm-Message-State: AOJu0Yx8/R5SRyvNqfUvYI/IJhPeR3kkxfQKNLy1jFWUP1PauudUCYsD
 DmRyDzqn8C11xdDBZmCY5OnybJqbKsLcXnB8TvF4Wio4ld0QP3HAePOdMpk7FcFG78ES6Cy9hse
 HyDgzTD3gDgTWGq1OqpjbeQRgTjPqJU1uSVWVzEjga9Rsrfdu
X-Google-Smtp-Source: AGHT+IG67wJD7jEotnG/le5GhXCuBg9FkpZqZ94B1l4A7IaJ0bzYzjIwySKF/oGgYHNKA5EjGNoSaVTNL1e0sFTaIB4=
X-Received: by 2002:a50:d6dc:0:b0:57d:4a0d:d597 with SMTP id
 4fb4d7f45d1cf-599648a33ddmr2026947a12.12.1720795162819; Fri, 12 Jul 2024
 07:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190913154952.27724-1-peter.maydell@linaro.org>
 <20190913154952.27724-7-peter.maydell@linaro.org>
In-Reply-To: <20190913154952.27724-7-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jul 2024 15:39:11 +0100
Message-ID: <CAFEAcA9Bj5k_1kaqtmR4KfshGeDXomo5udFdWLW1cwySG4S=fQ@mail.gmail.com>
Subject: Re: [PULL 06/12] aspeed/smc: Add DMA calibration settings
To: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Fri, 13 Sept 2019 at 16:50, Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> From: C=C3=A9dric Le Goater <clg@kaod.org>
>
> When doing calibration, the SPI clock rate in the CE0 Control Register
> and the read delay cycles in the Read Timing Compensation Register are
> set using bit[11:4] of the DMA Control Register.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Acked-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Message-id: 20190904070506.1052-7-clg@kaod.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Hi; this is an old patch, but Coverity has suddenly decided
it doesn't like it (CID 1547822):

> +static uint8_t aspeed_smc_hclk_divisor(uint8_t hclk_mask)
> +{
> +    /* HCLK/1 .. HCLK/16 */
> +    const uint8_t hclk_divisors[] =3D {
> +        15, 7, 14, 6, 13, 5, 12, 4, 11, 3, 10, 2, 9, 1, 8, 0
> +    };
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(hclk_divisors); i++) {
> +        if (hclk_mask =3D=3D hclk_divisors[i]) {
> +            return i + 1;
> +        }
> +    }
> +
> +    qemu_log_mask(LOG_GUEST_ERROR, "invalid HCLK mask %x", hclk_mask);
> +    return 0;
> +}
> +
> +/*
> + * When doing calibration, the SPI clock rate in the CE0 Control
> + * Register and the read delay cycles in the Read Timing Compensation
> + * Register are set using bit[11:4] of the DMA Control Register.
> + */
> +static void aspeed_smc_dma_calibration(AspeedSMCState *s)
> +{
> +    uint8_t delay =3D
> +        (s->regs[R_DMA_CTRL] >> DMA_CTRL_DELAY_SHIFT) & DMA_CTRL_DELAY_M=
ASK;
> +    uint8_t hclk_mask =3D
> +        (s->regs[R_DMA_CTRL] >> DMA_CTRL_FREQ_SHIFT) & DMA_CTRL_FREQ_MAS=
K;
> +    uint8_t hclk_div =3D aspeed_smc_hclk_divisor(hclk_mask);
> +    uint32_t hclk_shift =3D (hclk_div - 1) << 2;

The code of aspeeed_smc_hclk_divisor() has a codepath where it
can return 0, and this callsite doesn't check for 0, and so
Coverity thinks that we might end up shifting -1 by 2 to get
the hclk_shift here, which means we overflow the value, which
it thinks is probably not what we meant to do.

In fact this can't happen, because we always pass aspeed_smc_hclk_divisor()
a value between 0 and 15, and if we do that then we always get back
a value between 1 and 16. So I think the right fix would be
to change the qemu_log_mask()/return 0 to be g_assert_not_reached().

thanks
-- PMM

