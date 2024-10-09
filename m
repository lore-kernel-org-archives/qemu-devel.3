Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F21FCEDDA1
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 14:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syXjp-0007dZ-Ep; Wed, 09 Oct 2024 10:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rcardenas.rod@gmail.com>)
 id 1syXjo-0007dL-4r; Wed, 09 Oct 2024 10:32:28 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rcardenas.rod@gmail.com>)
 id 1syXjm-000437-Hu; Wed, 09 Oct 2024 10:32:27 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53988c54ec8so8141490e87.0; 
 Wed, 09 Oct 2024 07:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728484343; x=1729089143; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IUY+PgorULmvKl8Nuh1flWONR31fIfcbhFz5AkHpU8U=;
 b=ES1r6O+98RunnRIErbUygHz9pTUbVYlxeTj708v64JszuVc59OxONO3ed/ZBUchHE/
 0FsPUOW0uULvcz/pjSFrTL7gnzZJU48fkW+hWk6yGx5nhQotpf29kZznOr6rJVXRO3zi
 cHfEJErwSKdJ8s2GyXGFndAy3RYgyqayVHKPfYsp7f0r6L0Sghw5o3fC7JEZ+PwM7eQO
 WI7b4wFjlTOBQeZshLycfZSO0KPksjjb8DSgw+j7mrF9agEwbOwVztooloxenusmuvbm
 3vkKXsn7QaSDapaPtP6GVCT6XjvV2jhvPKeUM7uFKbepDw/5+n8NiUTtZLHAfRMiRUyq
 U3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728484343; x=1729089143;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IUY+PgorULmvKl8Nuh1flWONR31fIfcbhFz5AkHpU8U=;
 b=XWJbb8rvV4iNKjeJ8mIwvEzerBhaWXnnfnBPLIw2TJFcdSDT4sHlmo1TdB1hWPQOTS
 DLlM9PvM5y6BM62GDWFefwyBtJdC9t/ztJVXZGTsd84QKaLdwW7rxnDSpqrcE6d/bkm1
 2eizwb113x72j14SYbV1nuQjjzTqzeQvP/gc9NLjgnbquTozZsx+3NXEG2NYz37aZojx
 AtKT30+H5olFl31MKD7smyf7cHp18Z5+QXTpK2D2ut0fPYlee/V1WSG9PJcPV2ioED9q
 wxgYXXtbjbLsyvd5muhP56mumqspdGtdyQs4D3X9Ey8DtRXlvBcb+rjmC62SJaWBB+xn
 vQ8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDGpAaWHkyvNGkaib/KI2aIH+RBP7Nr2d0rd4DWNG9tdn0zC2w6VSq74tyMz52msI9CLIdHkA7Szr4@nongnu.org
X-Gm-Message-State: AOJu0YwVaG9oTXaq810sh7iKHTmln9+iJ7qZrQymKRFz3IVDOhIJza7d
 4oSG2IpCy1qrDZtEumo0HuvPJEKwelj7a5a52YG+LZsbTam7oVUv
X-Google-Smtp-Source: AGHT+IFkYttkl2MYo1v6HjZ0mShraJ77SyLJTlXuiQw7Kcf92bTEWeynhtYsXBGEKgh05P1ByWBKJQ==
X-Received: by 2002:a05:6512:3ca7:b0:538:9e40:94b with SMTP id
 2adb3069b0e04-539c489754fmr1797497e87.19.1728484343036; 
 Wed, 09 Oct 2024 07:32:23 -0700 (PDT)
Received: from smtpclient.apple ([138.4.224.164])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d2e65d618sm3933939f8f.23.2024.10.09.07.32.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Oct 2024 07:32:22 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH 3/4] STM32: new GPIO device
From: =?utf-8?B?Um9tw6FuIEPDoXJkZW5hcyBSb2Ryw61ndWV6?=
 <rcardenas.rod@gmail.com>
In-Reply-To: <CAFEAcA-QUAKPuzcjLafU8U_=wk2HWhHbxx76WgwN+Cgdec_kGQ@mail.gmail.com>
Date: Wed, 9 Oct 2024 16:32:11 +0200
Cc: qemu-arm@nongnu.org,
 alistair@alistair23.me,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <63F1DC02-ECC8-44C8-91BB-337DDC9420D8@gmail.com>
References: <20240927150738.57786-1-rcardenas.rod@gmail.com>
 <20240927150738.57786-3-rcardenas.rod@gmail.com>
 <CAFEAcA-QUAKPuzcjLafU8U_=wk2HWhHbxx76WgwN+Cgdec_kGQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=rcardenas.rod@gmail.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Looks like the stm32l4x5 is quite similar to my implementation. It =
didn=E2=80=99t exist when I started with my implementation . I will take =
a closer look and work on improving/extending the stm32l4x5 GPIO with my =
proposal. Is it OK if I rename it to stm32_gpio? so it is clearer that =
the implementation is generic and can fit almost any STM32 target.

Sorry about the issues with the patches, I am not familiar with this =
methodology of working with git.
Could you guide me on how to send with you a revised version of patches =
3 and 4?

> On 4 Oct 2024, at 20:08, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Fri, 27 Sept 2024 at 16:08, Rom=C3=A1n C=C3=A1rdenas Rodr=C3=ADguez
> <rcardenas.rod@gmail.com> wrote:
>>=20
>> Generic GPIO class for STM32 devices. It can be used for most of =
STM32 chips.
>> Note that it does not implement configuration locking mechanisms.
>=20
> So we already have an stm32l4x5 GPIO device. How different
> is that one from these ones? Should we be sharing implementation,
> or are they too different?
>=20
> When adding a new file, could you please add lines to
> the MAINTAINERS file putting it in an appropriate subsection?
>=20
>> +static void stm32_gpio_irq_reset(void *opaque, int line, int value)
>> +{
>> +    STM32GPIOState *s =3D STM32_GPIO(opaque);
>> +
>> +    trace_stm32_gpio_irq_reset(line, value);
>> +
>> +    bool prev_reset =3D s->reset;
>=20
> QEMU's coding style says that variable declarations
> should always be at the start of a code block, never
> in the middle. (There are some other cases of this here
> and in patch 4, I think.)
>=20
>> +    s->reset =3D value !=3D 0;
>> +    if (prev_reset !=3D s->reset) {
>> +        if (s->reset) {
>> +            stm32_gpio_reset(DEVICE(s));
>> +        } else {
>> +            stm32_gpio_update_state(s);
>> +        }
>> +    }
>> +}
>=20
>> +static Property stm32_gpio_properties[] =3D {
>> +    DEFINE_PROP_UINT32("family", STM32GPIOState, family, STM32_F2),
>=20
> For this sort of situation where we have a set of devices that
> are very similar but have some slight model-to-model variation,
> rather than using a device property to tell the device which
> variation it is, we generally use a parent class with the
> implementation and a set of child classes which tweak fields
> controlling the parent class behaviour. For an example, look at
> hw/gpio/aspeed_gpio.c -- TYPE_ASPEED_GPIO is marked ".abstract =3D =
true",
> and it has most of the implementation. Then the various subtypes
> inherit from it, and their class init functions set fields in
> the class struct to define the behaviour.
> hw/char/stm32l4x5_usart.c is another example.
>=20
>> +static void stm32_gpio_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    device_class_set_props(dc, stm32_gpio_properties);
>> +    dc->vmsd =3D &vmstate_stm32_gpio;
>> +    dc->realize =3D stm32_gpio_realize;
>> +    device_class_set_legacy_reset(dc, stm32_gpio_reset);
>=20
> Could you use the non-legacy reset instead? It's not much of
> a change, instead of calling this you set the ResettableClass
> phases.hold, and the reset function has a slightly different
> function signature. hw/char/stm32l4x5_usart.c has an example.
>=20
> thanks
> -- PMM


