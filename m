Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E87CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jqL-0007Im-OH; Fri, 03 Oct 2025 13:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixiaoyan@google.com>)
 id 1v4jq5-0006xz-47
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:45:11 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lixiaoyan@google.com>)
 id 1v4jpp-000779-RC
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:45:03 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4e576fef9c6so37311cf.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1759513482; x=1760118282; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ouzL6b3ma7uZ+1yon8bzp0WKYyNokwvTaK0TPZlUgk8=;
 b=ajy+3/OOHSK5nMCeNNDdgb/Sbbdwrqz0+pzGieel0Osv5ScH+9e92xqqWf9fYkOTP5
 iZBhvvuMHk/oLpqxTCukGP5k/VnGIWR2TOgNvK0T2tgRLtL/Si2Exv0VZZwKTAc9yu0m
 QFF1Dp1T7OCi9iE7nbvwBnTXpJ22r12GTy7Yq+8eA4M5zz2knWQZs/yVz2m8XU2seyvC
 eFKXCxkACCdiOy2TiuAsUJvfQ6GGsmvbnIHK7vTDRnK1koOGYZ1BnqCR2jswQqO/ZrOT
 9rtAtW5yuEzUM4R520RC99MH2PbIHsJFHfbqhHkViDzDlaMtGTutvi/3hZTec1AGaGG5
 rOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759513482; x=1760118282;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ouzL6b3ma7uZ+1yon8bzp0WKYyNokwvTaK0TPZlUgk8=;
 b=Bzg2mty/hwNECbnNst0y1DD7XSqBH6o7qv8xsVXFckH2z77eN16kq+bObyhyQVddei
 BDUPE5CCod4rPDAjxbYLB10RYAqNCrQ3JyF6jFw9ktDYCKd1y0utSr3DJ15LT7jogS9f
 EqjszhynBN7AMZMQDEQahmrM3Idb1HRIc9OYxuFAcKVyrOfAVb6Fu6tcQDQYYV01tALP
 6eOo1WHelJuwq4iMxoFa8uAfLx354bCnkZz/p4rRDAUPEztngilGO4xG5+YVNLhn8AiO
 YMyXRFeN1o/ZFCiFCbIQV8RE0h8hRiUvgvel635cGNRRIPhb/stbFlaQMD5DCctHn0Iw
 LP1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJg0KKmBaKQEeS0tILGLZ+/Z8hC1Qh8IYNJ0VNhewe3XlfxzT/aSPRkeMX0o+878/Ipz1mBrdAlVJp@nongnu.org
X-Gm-Message-State: AOJu0YxaIJtdjH8BjzZnl69L/ja4/j9rSGGk8uSEmyxpD1miXndsv0oT
 NwG/LcIimGeop9tiJaEpv/KDBP3nLGB7+51Oa2X0gHagIm5PhMvO9sL/UmmtEEt3G8EHlzxslnP
 bJxu4aUvcdYRhUOyiUM972hH72ElKLUNwahKSs3Q4
X-Gm-Gg: ASbGnctRNsMmqW51yFak+86FJjFklrpXitPvRojbXNXv6H3S1Bt+AG0VrTHpSrP9qMM
 w4kTQEsJaZ/Hn0+a6AwDjmkl/X15tdSqfWP7fqiHqc9g3ewnWYtC3PD9MVvng+nDVebu0fniRcv
 +iK7G24y2j9yEzwydX/IEHAvt/XKTMtdG6ua/kopmolC3bw3Iom1s1kt75tAc5Iq6ISaMOo+PL4
 e+cOL+4QD6CHGgsIiWBPvR3wb9ag/OgqsHuG0QxDlTVq2+DuSDVcDEAl0td2H+DrNy5+lC4n2YQ
 qtpxZybzOrBBBKrsJCPG7TAo8JclKsGV7CUmnA==
X-Google-Smtp-Source: AGHT+IGRtFY63kXj4PS9yermT3SftLbMgFoR+eGDqnkWAzxSAfwW9VE7N7h388IpoZINU9dnCRwSeXF2pmvG6dPsdJQ=
X-Received: by 2002:a05:622a:311:b0:4b7:9b06:ca9f with SMTP id
 d75a77b69052e-4e581f23eccmr340731cf.2.1759513481195; Fri, 03 Oct 2025
 10:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250925005832.3708492-1-lixiaoyan@google.com>
 <20250925005832.3708492-2-lixiaoyan@google.com>
 <b601f750adc19ea0fe8ec8f2c578f9f23d7259cc.camel@codeconstruct.com.au>
In-Reply-To: <b601f750adc19ea0fe8ec8f2c578f9f23d7259cc.camel@codeconstruct.com.au>
From: Coco Li <lixiaoyan@google.com>
Date: Fri, 3 Oct 2025 10:44:27 -0700
X-Gm-Features: AS18NWB1lZy_1CXrTQrf3ICdgwHTA-d7f9w_FRfL4FxnWxLqce5X-6W1p3zAEGI
Message-ID: <CADjXwjguvA6tsAjc65Fc=6S+k=pz1xry6Gd=mz6093GozuWDDQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] hw/gpio: Add property for ASPEED GPIO in 32 bits
 basis
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: clg@kaod.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, flwu@google.com, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=lixiaoyan@google.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -165
X-Spam_score: -16.6
X-Spam_bar: ----------------
X-Spam_report: (-16.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

On Wed, Oct 1, 2025 at 4:24=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Thu, 2025-09-25 at 00:58 +0000, Coco Li wrote:
> > From: Felix Wu <flwu@google.com>
> >
> > Added 32 bits property for ASPEED GPIO. Previously it can only be acces=
s in bitwise manner.
> >
> > This change gives ASPEED similar behavior as Nuvoton.
>
> I don't think this has adequately addressed my request on the prior
> series:
>
> https://lore.kernel.org/all/e244fdb5d2d889674a583df8f8b9bc4bf8d476f4.came=
l@codeconstruct.com.au/
>
> Can you please improve the commit message?
>
> I don't have any particular concern with the implementation, other than
> understanding whether it's something that's reasonable to add to begin
> with. The "sets" and their indexes are somewhat an implementation
> detail. Exposing them might preclude a different implementation design,
> though I'm also not sure why we'd change at this point.
>
> Andrew
>

Hello Andrew,

To confirm that I understand your request, I should do the following:

1) remove the reference to Nuvoton behavior in the ASPEED patches
(will do in follow up)
2) you asked for discussion of complex simulations, is the addition in
the cover patch sufficient? Otherwise, could you elaborate on your
comment here on what I can help provide please?

Best,
Coco


> >
> > Signed-off-by: Felix Wu <flwu@google.com>
> > ---
> >  hw/gpio/aspeed_gpio.c | 57 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >
> > diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
> > index 609a556908..2d78bf9515 100644
> > --- a/hw/gpio/aspeed_gpio.c
> > +++ b/hw/gpio/aspeed_gpio.c
> > @@ -1308,6 +1308,57 @@ static void aspeed_gpio_2700_write(void *opaque,=
 hwaddr offset,
> >  }
> >
> >  /* Setup functions */
> > +static void aspeed_gpio_set_set(Object *obj, Visitor *v,
> > +                                        const char *name, void *opaque=
,
> > +                                        Error **errp)
> > +{
> > +    uint32_t set_val =3D 0;
> > +    AspeedGPIOState *s =3D ASPEED_GPIO(obj);
> > +    AspeedGPIOClass *agc =3D ASPEED_GPIO_GET_CLASS(s);
> > +    int set_idx =3D 0;
> > +
> > +    if (!visit_type_uint32(v, name, &set_val, errp)) {
> > +        return;
> > +    }
> > +
> > +    if (sscanf(name, "gpio-set[%d]", &set_idx) !=3D 1) {
> > +        error_setg(errp, "%s: error reading %s", __func__, name);
> > +        return;
> > +    }
> > +
> > +    if (set_idx >=3D agc->nr_gpio_sets || set_idx < 0) {
> > +        error_setg(errp, "%s: invalid set_idx %s", __func__, name);
> > +        return;
> > +    }
> > +
> > +    aspeed_gpio_update(s, &s->sets[set_idx], set_val,
> > +                       ~s->sets[set_idx].direction);
> > +}
> > +
> > +static void aspeed_gpio_get_set(Object *obj, Visitor *v,
> > +                                        const char *name, void *opaque=
,
> > +                                        Error **errp)
> > +{
> > +    uint32_t set_val =3D 0;
> > +    AspeedGPIOState *s =3D ASPEED_GPIO(obj);
> > +    AspeedGPIOClass *agc =3D ASPEED_GPIO_GET_CLASS(s);
> > +    int set_idx =3D 0;
> > +
> > +    if (sscanf(name, "gpio-set[%d]", &set_idx) !=3D 1) {
> > +        error_setg(errp, "%s: error reading %s", __func__, name);
> > +        return;
> > +    }
> > +
> > +    if (set_idx >=3D agc->nr_gpio_sets || set_idx < 0) {
> > +        error_setg(errp, "%s: invalid set_idx %s", __func__, name);
> > +        return;
> > +    }
> > +
> > +    set_val =3D s->sets[set_idx].data_value;
> > +    visit_type_uint32(v, name, &set_val, errp);
> > +}
> > +
> > +/****************** Setup functions ******************/
> >  static const GPIOSetProperties ast2400_set_props[ASPEED_GPIO_MAX_NR_SE=
TS] =3D {
> >      [0] =3D {0xffffffff,  0xffffffff,  {"A", "B", "C", "D"} },
> >      [1] =3D {0xffffffff,  0xffffffff,  {"E", "F", "G", "H"} },
> > @@ -1435,6 +1486,12 @@ static void aspeed_gpio_init(Object *obj)
> >              g_free(name);
> >          }
> >      }
> > +
> > +    for (int i =3D 0; i < agc->nr_gpio_sets; i++) {
> > +        char *name =3D g_strdup_printf("gpio-set[%d]", i);
> > +        object_property_add(obj, name, "uint32", aspeed_gpio_get_set,
> > +        aspeed_gpio_set_set, NULL, NULL);
> > +    }
> >  }
> >
> >  static const VMStateDescription vmstate_gpio_regs =3D {

