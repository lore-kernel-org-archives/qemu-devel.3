Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798A7C54E58
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 13:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riaG9-0000k9-GN; Fri, 08 Mar 2024 08:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riaG8-0000i4-CF
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:27:36 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riaFy-0003FN-R0
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 08:27:36 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2d094bc2244so29306691fa.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 05:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709904445; x=1710509245; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CMwrJpB/DJy52CSm232qW3g+OfPChW9UXY1c0q2947s=;
 b=MMMHMZ3a6slhGLtxNCDxVa7+Yqwkf4PXXbrx6rVTZ3D7sUD2xCTxVCvtNrI6vYyT7G
 gLb+UA4xzrw4YN6EAsb+nDBk8FZm/L80VG0EJZtNdEybD9wnJ1OqdS6+BUDpsOJsis0S
 2RbuNXtwV9iDtriMzFWHsDIQ5iYhONpfi85M15ltgG+xhz4m9tcGpeN+f+ouKWAKwZzA
 aam/2ASuoeWHACnABXEHDXLYjqguF/la2lFoTVAIkSoszWYRj6djDKGL4/SW5WMmGctA
 U4FsHc34YLyJvY5Nx6H7vXMeokOOAH74wN4nnb1mk5ryYyEoZird2GQcOvGG0Z0FCSYY
 pM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709904445; x=1710509245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CMwrJpB/DJy52CSm232qW3g+OfPChW9UXY1c0q2947s=;
 b=mQ1bidakoH+XSWzkqcUsD7SAAPI0rNhlbfOkBObuxqi4Z3KSyqxYdR7kihNc/gHoFH
 tsX7cO15rbKQgYe5t75qQ1VQ6BfvScxk7hfWwj5++F8F+bmhfL6gRf/KJTfvRF20HXyK
 zNLeSundLqmF0IyMed8UPGq2m/iZdD/oaeJneuVavRRAerm4OtYu2eo5+rat3RqvDAAI
 fC6K5ZvGMLEUaUGrsj2DlJW4M6ngvCXiGm3uYvtaTFgEpwevPTqrKrggJ5Vh2ry+KNQK
 mtfiYURzzgFdafNFHDD8HNgl9Uo9xhPMTwucVQhdycQiGNruxqYDANp2b75ei0w0kaxR
 qBaA==
X-Gm-Message-State: AOJu0YzFarXa/E8PWE+bqBBv6cfiuR1Fto3f+S8SG9CYaNGw+AzlhetE
 D3a7ehB9xgRNWm0Ogu1mkvCaUDCCzOeJK3oatI1EKI154lAYymbf1g0PB/uGxidin3Ccb4ShiQY
 jjZ+v3FIS9b5ayqdyBkU63/PPQQNcNyEkYWGWpg==
X-Google-Smtp-Source: AGHT+IEFQkRHt7DHp2GZnlXxCq+W37/giJEYKGVsGTjsJC3bF02mSgmQxbAOPmFwlLBk+ZgX/iKdxNPNILRhpbYTAAY=
X-Received: by 2002:a05:651c:2de:b0:2d2:acef:6aca with SMTP id
 f30-20020a05651c02de00b002d2acef6acamr3290897ljo.41.1709904444869; Fri, 08
 Mar 2024 05:27:24 -0800 (PST)
MIME-Version: 1.0
References: <20240215175752.82828-1-philmd@linaro.org>
 <20240215175752.82828-35-philmd@linaro.org>
In-Reply-To: <20240215175752.82828-35-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2024 13:27:14 +0000
Message-ID: <CAFEAcA-HpKCk-n4HsnZPiz09xq9sk=Sh5nt05KpRymy-NQ2HEg@mail.gmail.com>
Subject: Re: [PULL 34/56] hw/intc/grlib_irqmp: add ncpus property
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, 
 qemu-block@nongnu.org, =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, 
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 15 Feb 2024 at 18:04, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> From: Cl=C3=A9ment Chigot <chigot@adacore.com>
>
> This adds a "ncpus" property to the "grlib-irqmp" device to be used
> later, this required a little refactoring of how we initialize the
> device (ie: use realize instead of init).
>
> Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Message-ID: <20240131085047.18458-3-chigot@adacore.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Hi; Coverity points out a bug in this commit (CID 1534914):


> -static void grlib_irqmp_init(Object *obj)
> +static void grlib_irqmp_realize(DeviceState *dev, Error **errp)
>  {
> -    IRQMP *irqmp =3D GRLIB_IRQMP(obj);
> -    SysBusDevice *dev =3D SYS_BUS_DEVICE(obj);
> +    IRQMP *irqmp =3D GRLIB_IRQMP(dev);
>
> -    qdev_init_gpio_in(DEVICE(obj), grlib_irqmp_set_irq, MAX_PILS);
> -    qdev_init_gpio_out_named(DEVICE(obj), &irqmp->irq, "grlib-irq", 1);
> -    memory_region_init_io(&irqmp->iomem, obj, &grlib_irqmp_ops, irqmp,
> +    if ((!irqmp->ncpus) || (irqmp->ncpus > IRQMP_MAX_CPU)) {
> +        error_setg(errp, "Invalid ncpus properties: "
> +                   "%u, must be 0 < ncpus =3D< %u.", irqmp->ncpus,
> +                   IRQMP_MAX_CPU);
> +    }

We detect the out-of-range 'ncpus' value, but forget the "return"
statement, so execution will continue onward regardless, and
overrun the irqmp->irq[] array when we call qdev_init_gpio_out_named().

> +
> +    qdev_init_gpio_in(dev, grlib_irqmp_set_irq, MAX_PILS);
> +    qdev_init_gpio_out_named(dev, &irqmp->irq, "grlib-irq", 1);
> +    memory_region_init_io(&irqmp->iomem, OBJECT(dev), &grlib_irqmp_ops, =
irqmp,
>                            "irqmp", IRQMP_REG_SIZE);
>
>      irqmp->state =3D g_malloc0(sizeof *irqmp->state);
>
> -    sysbus_init_mmio(dev, &irqmp->iomem);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &irqmp->iomem);
>  }

thanks
-- PMM

