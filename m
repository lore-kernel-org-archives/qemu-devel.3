Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92B4C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HXM-0004vR-Rf; Tue, 07 May 2024 05:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4HXL-0004uq-10
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:55:03 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4HXJ-0004pz-1Y
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:55:02 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a59b178b75bso489633966b.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 02:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715075699; x=1715680499; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZhmjIXKYgZr53hDN6H3dymNuLmy1NqHDwPG6SPwx0I=;
 b=NvRZXbdVXwC+Kjh+aG2x4JtUzluYHpSBQ3G5sCO6su4j2zxb1tRc7bZUMz6cMTNruu
 AehWY8tpn2TjYhEHO4v663+aN+RjZZwGnlCbnhSTAGflFtEbO1SAXOR1h4upaMeMlxBF
 wG7tAC1g+0RRJOoka+gjm9FRax4IV6MR4D62PIsQYPlTB8+Qir3EujlgA9aqKMyYkhYG
 YslBGz0vpyjn/tEL4L0pW2/JlKG0qlQSPFxGfXBgqRWhIBxovhSt9O5ePk2+5NhvFqnW
 8FGlUZ+JZjF8KLe0lCTIl9m9Xf193I9j4cVsVOeMMMHEskTb6woFtiaqsskEs0nP7plL
 CUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715075699; x=1715680499;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZhmjIXKYgZr53hDN6H3dymNuLmy1NqHDwPG6SPwx0I=;
 b=MfXqLFxIRlEFkiD+d2Zuo1h62fFJTjKna1gjPRKe7rc2NTONPiz/WgUU82hF4Dit6H
 nmwJy6iOQM8WdKPTzMPC1HHDdokaQSiU3MnZWUEWH3Mf+QRgx+xxCHSDsyiDqTIq4Yml
 Dsn20lyVT8JCEIeIW8MJaZL6vnkNryw37H46UCfTJAFWs1JyFl+n+53/uF73Cf02BgSZ
 ndMhgO6WlLLkyFw5gz69aKYFP9KYiB2cgmgZl1v/gnCotCtB9IR2KkmOQJx6gHt6/g7r
 AtTs5ha/u48GuRK5Hv6EXShumVno0Xd/ogtGBODTvmy+gbya1b9HpIsvXn0DZUu0IZOj
 t6xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoe1IJ0w96L9ssD8/5D0E2CZ/DVHllJYInu06XGXPT4T3Xja0l6cH9QOh2BPQjsg0HNWHHfA5+eS1Gwhe4KSLNN+zep+o=
X-Gm-Message-State: AOJu0Yym/RpMgN/uqExb0gE/Mhtq4+/0yf1RLAru5jfucuV7iAyXtjve
 wcCbizUzkAyAXUfhmzbuXKB7RMKBH+EgvGM3QPzFbbQx1XbhQnH0cPd3msS2/BptTntC3WzA8Lu
 ds4agiAig+gXDLGwdlNmmxnc622r26kSceaJyOg==
X-Google-Smtp-Source: AGHT+IHxU1fgtm3u/rJu5/THz8zAlTgomluLzMBl0PqV3+pCwf4r0kSWgg+YmKTHgF3wjl96KAZ83WQ1HZRk4kNzUNM=
X-Received: by 2002:a50:9faa:0:b0:572:326b:c055 with SMTP id
 c39-20020a509faa000000b00572326bc055mr9358675edf.13.1715075699100; Tue, 07
 May 2024 02:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240505140556.373711-1-ines.varhol@telecom-paris.fr>
 <20240505140556.373711-4-ines.varhol@telecom-paris.fr>
 <06e98554-3430-49d5-94f3-c5d683327f55@linaro.org>
In-Reply-To: <06e98554-3430-49d5-94f3-c5d683327f55@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 May 2024 10:54:47 +0100
Message-ID: <CAFEAcA83cgqq3yh3=d=gHd-LK3qh2g-pE2v734apKmcNTJTvww@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/char: Add QOM property for STM32L4x5 USART clock
 frequency
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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

On Mon, 6 May 2024 at 10:34, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Hi,
>
> On 5/5/24 16:05, In=C3=A8s Varhol wrote:
> > Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> > ---
> >   hw/char/stm32l4x5_usart.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
> > index fc5dcac0c4..ee7727481c 100644
> > --- a/hw/char/stm32l4x5_usart.c
> > +++ b/hw/char/stm32l4x5_usart.c
> > @@ -26,6 +26,7 @@
> >   #include "hw/clock.h"
> >   #include "hw/irq.h"
> >   #include "hw/qdev-clock.h"
> > +#include "qapi/visitor.h"
> >   #include "hw/qdev-properties.h"
> >   #include "hw/qdev-properties-system.h"
> >   #include "hw/registerfields.h"
> > @@ -523,6 +524,14 @@ static Property stm32l4x5_usart_base_properties[] =
=3D {
> >       DEFINE_PROP_END_OF_LIST(),
> >   };
> >
> > +static void clock_freq_get(Object *obj, Visitor *v,
> > +    const char *name, void *opaque, Error **errp)
> > +{
> > +    Stm32l4x5UsartBaseState *s =3D STM32L4X5_USART_BASE(obj);
> > +    uint32_t clock_freq_hz =3D clock_get_hz(s->clk);
> > +    visit_type_uint32(v, name, &clock_freq_hz, errp);
> > +}
> > +
> >   static void stm32l4x5_usart_base_init(Object *obj)
> >   {
> >       Stm32l4x5UsartBaseState *s =3D STM32L4X5_USART_BASE(obj);
> > @@ -534,6 +543,9 @@ static void stm32l4x5_usart_base_init(Object *obj)
> >       sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> >
> >       s->clk =3D qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
> > +
> > +    object_property_add(obj, "clock-freq-hz", "uint32",
> > +                        clock_freq_get, NULL, NULL, NULL);
>
> Patch LGTM, but I wonder if registering QOM getter without setter
> is recommended. Perhaps we should encourage parity? In normal HW
> emulation we shouldn't update this clock externally, but thinking
> about testing, this could be interesting to introduce jitter.

object_property_add() with the set function NULL is fine,
and is documented to mean "property cannot be set". Attempts
to set it will be failed (in object_property_set()) with a
reasonable error.

But it's not clear to me why we want the property in the first
place -- we don't generally have devices which take a Clock
input have properties exposing its frequency. If we did want
that it would probably be better if we could do it generically
rather than by adding more boilerplate code to each device.
Mostly "frequency" properties on devices are for the case
where  they *don't* have a Clock input and instead have
ad-hoc legacy handling where the board/SoC that creates the
device sets an integer property to define the input frequency
because it doesn't model the clock tree with Clock objects.

thanks
-- PMM

