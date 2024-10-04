Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BACCF8854
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 18:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swmjs-0005IE-W3; Fri, 04 Oct 2024 14:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swmjr-0005Hr-7D
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 14:09:15 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swmjo-0000bd-9l
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 14:09:14 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2fad75b46a3so25316011fa.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728065350; x=1728670150; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVhmfTB3+t8GIphg/MqRf11PybumnQ5PkJB9ZmVTj88=;
 b=QCLgcWkxnJdXAO5FO3QGGHP8lSZhxQQ7ORb+0DJb2Dlud8D4WpLBOnGWUCu9AiYnKv
 vXSd/Fb6y8LfvUkXXhgX0RZZqt7Sqfh78Tp8tj22+LMeYOWY+ir4HjJ28i+YTvJ5GaC5
 AC90E2XfoARMKlI9KsyeBRYDT5A/26djfYw9t6Qz1r42NgduoNVLYPJaMYBuXjszFbQT
 l3xYNGRN5/9toZt4frmUoaS9Q4Qf15fcPDUyCF2IQ/8D39UqOME3MGP01CeNt6oZkvi8
 p2d8J/t1fOWS0K+KbHEcqrcGINxRFKfixokHvJ6Nlos7vID824BujTGYfBkTqiCfTV+Q
 qPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728065350; x=1728670150;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NVhmfTB3+t8GIphg/MqRf11PybumnQ5PkJB9ZmVTj88=;
 b=GI9Q6jwI/e4LHH7U/J2iqser/Aap6tgmWRW27iQCBECj4nPGLEL6t9sEPG1uydBncp
 u7b6bRz36s5Yy3fWuta9h/3fG/IAhS5Fa+aEUltBUyEW96dc3Mk6tyy1ejWFTWDTbHcI
 kwslPA4ondoeTwSirunk1IOpj4ZJxWeuzZXFeD8d8R4gMl5JZ9HIOE8HShlQ5Y6M8Guy
 /K1+X8vQO1SD1czLrIkYEYrTjIn683LNItorqdf7KDWwqH6AK6+Od1dvrp+YpSnxFPNR
 cx0XOhnV+WOUkr5KkC1ZU+1S/qpw2QMMxyhEcRA0x74l4I+E0boLZImNrCJmgiDn4AYA
 SIvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyg8drqwi8Jzok+ZOoYTR4SWAPUcvfo15h3TDMYD3cfgsMHIxG/ESwuGRU7C1d+zcdpH0wwUi+SxxY@nongnu.org
X-Gm-Message-State: AOJu0Yy+qFnQuc2tAtLBGcU8TkYKYKo4AMpsuIKJzq7Ffwfp00BNU87J
 t3t7QLcxVa2y3oyAS6j2KbI2fCmjMy+bYc/XAhClHWz6scSSrMTt7HruN05A4PEKWzZEtNNoHOo
 cdJ3Q6pB6pb3HWDdel3XX5Ijxw+izeuswaBfN8w==
X-Google-Smtp-Source: AGHT+IFROItvoDSZcs8nDfCRAMb40tewK7vTRRLEShvfxzWrlwWkyTV2zZAZ6a+4prPlZ9mrbvM0wrUSM0oxhJ7CP/8=
X-Received: by 2002:a05:6512:2313:b0:535:d4e6:14e2 with SMTP id
 2adb3069b0e04-539ab89ac5bmr2199845e87.36.1728065349985; Fri, 04 Oct 2024
 11:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240927150738.57786-1-rcardenas.rod@gmail.com>
 <20240927150738.57786-3-rcardenas.rod@gmail.com>
In-Reply-To: <20240927150738.57786-3-rcardenas.rod@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2024 19:08:58 +0100
Message-ID: <CAFEAcA-QUAKPuzcjLafU8U_=wk2HWhHbxx76WgwN+Cgdec_kGQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] STM32: new GPIO device
To: =?UTF-8?B?Um9tw6FuIEPDoXJkZW5hcyBSb2Ryw61ndWV6?= <rcardenas.rod@gmail.com>
Cc: qemu-arm@nongnu.org, alistair@alistair23.me, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

On Fri, 27 Sept 2024 at 16:08, Rom=C3=A1n C=C3=A1rdenas Rodr=C3=ADguez
<rcardenas.rod@gmail.com> wrote:
>
> Generic GPIO class for STM32 devices. It can be used for most of STM32 ch=
ips.
> Note that it does not implement configuration locking mechanisms.

So we already have an stm32l4x5 GPIO device. How different
is that one from these ones? Should we be sharing implementation,
or are they too different?

When adding a new file, could you please add lines to
the MAINTAINERS file putting it in an appropriate subsection?

> +static void stm32_gpio_irq_reset(void *opaque, int line, int value)
> +{
> +    STM32GPIOState *s =3D STM32_GPIO(opaque);
> +
> +    trace_stm32_gpio_irq_reset(line, value);
> +
> +    bool prev_reset =3D s->reset;

QEMU's coding style says that variable declarations
should always be at the start of a code block, never
in the middle. (There are some other cases of this here
and in patch 4, I think.)

> +    s->reset =3D value !=3D 0;
> +    if (prev_reset !=3D s->reset) {
> +        if (s->reset) {
> +            stm32_gpio_reset(DEVICE(s));
> +        } else {
> +            stm32_gpio_update_state(s);
> +        }
> +    }
> +}

> +static Property stm32_gpio_properties[] =3D {
> +    DEFINE_PROP_UINT32("family", STM32GPIOState, family, STM32_F2),

For this sort of situation where we have a set of devices that
are very similar but have some slight model-to-model variation,
rather than using a device property to tell the device which
variation it is, we generally use a parent class with the
implementation and a set of child classes which tweak fields
controlling the parent class behaviour. For an example, look at
hw/gpio/aspeed_gpio.c -- TYPE_ASPEED_GPIO is marked ".abstract =3D true",
and it has most of the implementation. Then the various subtypes
inherit from it, and their class init functions set fields in
the class struct to define the behaviour.
hw/char/stm32l4x5_usart.c is another example.

> +static void stm32_gpio_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    device_class_set_props(dc, stm32_gpio_properties);
> +    dc->vmsd =3D &vmstate_stm32_gpio;
> +    dc->realize =3D stm32_gpio_realize;
> +    device_class_set_legacy_reset(dc, stm32_gpio_reset);

Could you use the non-legacy reset instead? It's not much of
a change, instead of calling this you set the ResettableClass
phases.hold, and the reset function has a slightly different
function signature. hw/char/stm32l4x5_usart.c has an example.

thanks
-- PMM

