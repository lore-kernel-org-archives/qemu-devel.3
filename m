Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D97C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 15:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKg4L-0005n6-EQ; Fri, 21 Jun 2024 11:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKg4B-0005kd-IE
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:20:43 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKg49-0008MX-Jn
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:20:43 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57cfe600cbeso2560944a12.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718983240; x=1719588040; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pHbVYmuZWd1OxdpX60I95J8UDkauo542zRAeutaxzk8=;
 b=ZBXxgSvDIVE5TuLJ3PQNUylTKmASLWeRSTobXpTCvDIsDY0itMfwPnKA8b1ypdKLhi
 dYZr2NvMFGdIkooBKqstKoX4wOtaNDQowzfHZW0wT/sMSuQqhiCLELto6dxaT4hI3/Ou
 9HJusF91sVM+/AbV/VbS6uaAeXNE1SrwiFTPuiaf/NTl7N3QJaa811AkbTh7vz4BrQy5
 M6z7S2ZewcFz9QSW67DJPA1Oe+Ag8HjTWVLKhakoSMqA4KKgtpnAVVgiDkLR/uLOKm/K
 ruvR56vcUZ0DC/L2QSZQEiPcjs19uwQnLlGeVWkDxjiUMhYEN+FxMaBA1sHEFjwEB6uL
 TXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718983240; x=1719588040;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pHbVYmuZWd1OxdpX60I95J8UDkauo542zRAeutaxzk8=;
 b=DpDNsiUuO8DV9EeGF7RS47AFfVPJwnC4UW6LIfFiSs0shE452DSBk7lLz6nXYg3+br
 giDh15w1Hs0ZHn8XvXGtEYWjVRUs3fhwOqTaJ/miDSCwab7zujaB7f+JfWp/AbuPzaSc
 tgyytrgdmNeEk3Q726A3N59xW1LdMpOS0kCxJw2tqBkfeiBhP1g3FhpCfPiHqvlJV4fv
 +Onp44+PoMx5UXrgFgY7MdVKvftOBkjng9/hh4gVFWTnAlKbyg+secsqKQBaq9K7FvaG
 8gQOIbQco8AKjmC0gC6wGTD0Cluvr++9qI6w5mWgUhTBKelLYO1R9JZqgtGLK5txNXsl
 yspA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6nU4IXfZ+OiW7If0dtNFWqhd1wuKYUaAKB0qczyzMSIpB8jh6NJhWkG6Ag8Z88WFDQZhigE+BvFypK9rjtHDZuYXIhTg=
X-Gm-Message-State: AOJu0YwKz8sqgdIr8tRNODg+DMklL7P5tNFzi4/LANs7JpY6RQ1zFSWW
 g6Iocv6JT2ADsyGe9HnfznnVxQ9vXSHDzQxkgPaho3DXQ+tD+UnNdKKeFtnfR2mH59AH5TVlQgy
 QWjIDYZ34HMaecuqWhYdP/SLMNcLDdsZhnEFAQQ==
X-Google-Smtp-Source: AGHT+IFOVk+xciihb2GFZnC3wFhbsFdVzTF1KBHulqx05EDnRi7ti+RIRD8HH8e5IyCj1ph7AoDiPzOJm+iTF2vUWvE=
X-Received: by 2002:a50:cdc4:0:b0:57c:6c1c:f942 with SMTP id
 4fb4d7f45d1cf-57d07ee7911mr5961618a12.38.1718983239918; Fri, 21 Jun 2024
 08:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240618135550.3108739-1-zheyuma97@gmail.com>
 <6030d030-cfce-4253-ad4d-f7e2a37e2957@linaro.org>
In-Reply-To: <6030d030-cfce-4253-ad4d-f7e2a37e2957@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jun 2024 16:20:27 +0100
Message-ID: <CAFEAcA8NK5oEFwfnbHPd2NQvTQYauife-KLS--09L6e_mzi-zg@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/stm32l4x5_rcc: Add validation for MCOPRE and
 MCOSEL values
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Zheyu Ma <zheyuma97@gmail.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 21 Jun 2024 at 16:03, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 18/6/24 15:55, Zheyu Ma wrote:
> > This commit adds validation checks for the MCOPRE and MCOSEL values in
> > the rcc_update_cfgr_register function. If the MCOPRE value exceeds
> > 0b100 or the MCOSEL value exceeds 0b111, an error is logged and the
> > corresponding clock mux is disabled. This helps in identifying and
> > handling invalid configurations in the RCC registers.
> >
> > Reproducer:
> > cat << EOF | qemu-system-aarch64 -display \
> > none -machine accel=3Dqtest, -m 512M -machine b-l475e-iot01a -qtest \
> > stdio
> > writeq 0x40021008 0xffffffff
> > EOF
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> >   hw/misc/stm32l4x5_rcc.c | 28 ++++++++++++++++++++--------
> >   1 file changed, 20 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
> > index 417bd5e85f..59d428fa66 100644
> > --- a/hw/misc/stm32l4x5_rcc.c
> > +++ b/hw/misc/stm32l4x5_rcc.c
> > @@ -543,19 +543,31 @@ static void rcc_update_cfgr_register(Stm32l4x5Rcc=
State *s)
> >       uint32_t val;
> >       /* MCOPRE */
> >       val =3D FIELD_EX32(s->cfgr, CFGR, MCOPRE);
> > -    assert(val <=3D 0b100);
> > -    clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_MCO],
> > -                         1, 1 << val);
> > +    if (val > 0b100) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Invalid MCOPRE value: 0x%"PRIx32"\n",
> > +                      __func__, val);
>
> How the hardware handles that? I suppose it just ignores the
> value, so I'd simply:
>
>            return;
>
> instead of disabling the clock...
>
> In=C3=A8s, Arnaud, what do you think?

The datasheet just says the values are reserved. The hardware
might do anything, including behaving completely weirdly (e.g
trying to divide the clock by something more than 16 and running
into timing problems as a result). I suggested "disable" in review
on the first version of this patch (you'll definitely notice the
guest bug then ;-)).

> > +        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_MCO], false=
);
> > +    } else {
> > +        clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_MCO],
> > +                             1, 1 << val);
> > +    }
> >
> >       /* MCOSEL */
> >       val =3D FIELD_EX32(s->cfgr, CFGR, MCOSEL);
>
> MCOSEL is 3-bit wide, so ...
>
> > -    assert(val <=3D 0b111);
>
> ... this condition is always true (and can be removed) ...

Yes, I noticed that. But if you look at the datasheet[*] the actual
field in the register is 4 bits wide, because on some l4x5 SoCs
bit 4 is used for something. So it seemed to me reasonable to have
the guard against this, because at some point somebody might update
the FIELD definition to match the datasheet field width.

[*] https://www.st.com/resource/en/reference_manual/rm0351-stm32l47xxx-stm3=
2l48xxx-stm32l49xxx-and-stm32l4axxx-advanced-armbased-32bit-mcus-stmicroele=
ctronics.pdf

thanks
-- PMM

