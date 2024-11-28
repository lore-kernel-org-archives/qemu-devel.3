Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E88D690FA
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 11:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGcMZ-0003X6-9E; Thu, 28 Nov 2024 06:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGcMT-0003W4-29
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 06:07:05 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGcMM-0005oq-Hb
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 06:07:02 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d01db666ceso837130a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 03:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732792015; x=1733396815; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8kNjCRSoXw2jqQFwpOaavwKDFP4GzOqvpfROk6xC3N4=;
 b=TP2zoSAm/jipZkA17Sor8QdKYZpGcbDLqblorBi92fc43FG9nR3ltzIqvzCMCk/8Gr
 l8hSydpfPjhd4KQ39JoudsujcVuvT26MfVzEzN+UOhvQ2iqDJsY6BQ1hJ2IgjK9FWvXx
 te64vH+JjeYYfZdzHH0WZ/XIa2jPWprbkXuLXYG2vxlSzgYOD+kdjTTjw/EuL9vtOH+T
 v/vmOhujieYqBoJsDEaNLB6FXAw0PuxSM1iID4hNBwjFiwFd73Gp3m1gx7k/cD+PGNfg
 A6LIR68GDJgixLuF2qMPRO9d53bghtoLX59c25OfJk0L1EXAl6PC1kqTJFJTyPF9PduN
 V9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732792015; x=1733396815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8kNjCRSoXw2jqQFwpOaavwKDFP4GzOqvpfROk6xC3N4=;
 b=ngrTPKKp3OGkFIwYl7ob4cWa4GK6vSvqNB8ZcxyZkkQeW1Y87X1xjV6oftJEUmrMzj
 fY1pKeYkZ9Lc9d64GLQedZ0/5HbmfCiqKHIphgblYjwhEgn4IFz+kSLD5CmIv0hfxUCs
 0QCtY+211ki75egATavyX2V0++YwnwZ+pKAYoKU6OuSOf5mBOUJbmIqjxH+jDtkUibTC
 4A/6W1GgZgOmrBeAHpmneveK1Xp0OdUleuBmEzCv3nNTyKYg1w9no9Ov1Zjwb594hGfT
 uUmbvb2OmSuEhMSRu2PPAwG2ZMETnrAm2vd47WX+BuhBJviwhpej8+r5eQhRRyDYC18y
 doxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA2aw+4yvtZ5OnsIZnw4kbt4AqHvUUSGXbL7M7LHkXQI0hfIBUx9dh8KdsBpE2OranPCFVBRsCplDP@nongnu.org
X-Gm-Message-State: AOJu0YwupBVazyFHHg2xFsNmnrM/CO3uueHZL/ed3zjqKGZsN5Mmx9ic
 AZ/ZNtDDOagHGHbX8yAL19A9gBvOXJ9Flhf3+HaDRubxvlphnsqTYN6Rc5z4eUlLvvDd/8vJbxW
 w7kgBX2qdh0wPTG3nLBAgsPpqO5maD5HVbsc5uw==
X-Gm-Gg: ASbGncvaqCJUvbTMIaxKhBVStIWraZYVrcgHfyhPlTq+q4SE4sTz6D3iM5paEtJXExM
 2tKjjdSZ8jlxm2dHmflFv2zUSAlUo7j11
X-Google-Smtp-Source: AGHT+IEo13wQbIF3z3AAwBM2bi/j5Ye6dnd/ySq80ABX3xotUry3K7QB9GrlqhSFrpDxSgQBLeR2FNRmvCdEuUj+xrE=
X-Received: by 2002:a05:6402:40c6:b0:5cf:f82:ecef with SMTP id
 4fb4d7f45d1cf-5d080b8c951mr6241892a12.2.1732792015459; Thu, 28 Nov 2024
 03:06:55 -0800 (PST)
MIME-Version: 1.0
References: <20241114094839.4128404-1-jamin_lin@aspeedtech.com>
 <2e956389-289a-4806-8985-ab846d808736@kaod.org>
 <b520adf4-12f1-4261-a48f-bb74589bb31d@linaro.org>
 <a7c967ce-6bc0-47e0-aa25-cc89dab29cfb@kaod.org>
In-Reply-To: <a7c967ce-6bc0-47e0-aa25-cc89dab29cfb@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Nov 2024 11:06:44 +0000
Message-ID: <CAFEAcA9e5PFNoNh4u7paY5k5RnMgJ-3c++eGJd4u8CjjvDCvYw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Introduce a new Write Protected pin inverted
 property
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:SD (Secure Card)" <qemu-block@nongnu.org>, troy_lee@aspeedtech.com,
 yunlin.tang@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Wed, 27 Nov 2024 at 11:26, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
>
> > Having to modify sdhci.c internals is dubious, since inversion
> > occurs out of this block. If this is the soc/board layer, isn't
> > better to model at this level? Smth like:
> >
> > -- >8 --
> > diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> > index be3eb70cdd7..aad9be66b75 100644
> > --- a/hw/arm/aspeed_ast2600.c
> > +++ b/hw/arm/aspeed_ast2600.c
> > @@ -559,8 +559,9 @@ static void aspeed_soc_ast2600_realize(DeviceState =
*dev, Error **errp)
> >       }
> >       aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->sdhci), 0,
> >                       sc->memmap[ASPEED_DEV_SDHCI]);
> > +    irq =3D aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI);
> >       sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
> > -                       aspeed_soc_get_irq(s, ASPEED_DEV_SDHCI));
> > +                       sc->sdhci_wp_inverted ? qemu_irq_invert(irq) : =
irq);
> >
> >       /* eMMC */
> >       if (!sysbus_realize(SYS_BUS_DEVICE(&s->emmc), errp)) {
> > ---
>
> Nice ! I didn't know about qemu_irq_invert().

I am not a fan of qemu_irq_invert(). It's one of those ancient
pre-QOM APIs that we ideally would get rid of at some point.
Two problems with it:

(1) It allocates and returns a qemu_irq directly,
so in the patch above you're effectively leaking that
allocation. (Not a big deal since the SoC object is going to
be around for the life of the QEMU process, but probably
the clang leak-sanitizer will complain.)

(2) It calls qemu_irq_raise() directly, immediately. This is
kind of bogus in a realize function, where you're not supposed
to be raising IRQ lines yet; it also doesn't do anything about
reset, so if the device on the other end *did* care about seeing
that 0->1 transition then it will be broken on system-reset
because the transition won't happen. (Handling "device is supposed
to have an asserted-as-1 line coming out of reset" is not
something that we do very well in QEMU generally. In theory
3-phase reset is supposed to help with this by letting you do
the assert-the-line in the reset-exit phase, but in practice we
typically just don't model the line-assertion at all and
trust that the reset state of the device on the far end is
what it ought to be anyway...)

I would not recommend using qemu_irq_invert() in new code.

I guess in an ideal world we'd implement a QOM object
that encapsulated the the "not gate" logic, similar to
TYPE_OR_IRQ. (Though for TYPE_OR_IRQ we made the mistake
of making it inherit from TYPE_DEVICE, not TYPE_SYSBUS_DEVICE,
so it doesn't get reset properly on system reset and so
the "what happens to the output on reset" is still not
really correct.)

thanks
-- PMM

