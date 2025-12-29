Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C121E92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ2K-0001UB-Ok; Mon, 29 Dec 2025 14:36:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ2I-0001OM-6P
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:36:10 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ2E-0008IT-Up
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:36:09 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4ee147baf7bso3866821cf.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:36:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767036965; cv=none;
 d=google.com; s=arc-20240605;
 b=ZzA1x+NMYxhYQCqX4ZWc/pNxBuhtkiGWekJGpsXh4QhvZi23+7BHOpoNXz9Z67djeK
 CcN6pdsxfPgMXz+Sjbu/SzrR/jLKsTRpbbppC21Q97m29Ux0/Gs5MB4j/uCoZWMvCUcN
 ogYrtBbBhLve1oJzZeAvwOcKt8CAepzyVYrwHAn3gEl8sEqSUOIy/++xokopxGJ6juPs
 3bW/JLnxKOF8qGVChvUkMAx9FfzeYXm4qgWWFgkV3IVCHXYv/cQ7F0TqcgyckyaYoIvn
 oDynvzNrLtNyEdILufEW2R0ToGSpxzixwreKqGkHJGBHcwwv5pk7J+hKfA8FZ6xFo0px
 D4UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZRR3yxbpq2V3CkfGHou7Vzmk0iQ3VJchRoplq3BvZaI=;
 fh=2D7CzKXYWJgVMdypf6YwwC7ZINLPW47S231REpWyfCo=;
 b=bITVGFVT3UXJutybNObCGexVdvSdZYW4A4Qwf8PnYbFdw5M2x2Oqn7YGySjXEuxtOD
 odelnjyHGIcBF8h17OzwbP4L+a8vPfAkzA4KaPAmQRkUyvSyiQssRnkKAJNAX9M3mXbd
 6RJ98IOThsBk6VQMEC9Y5a77/lV9FJcYOrARQz/qG9jkbfmXW2+PZuy6odrKm0ZH8/Hl
 0d9WLe1WO+J433M5yPcOMZZqXmVedHRIaQlTzykEh+Mjc6JE8E3WXPEI1fOqHervSbJV
 JXGJua1Y7SYPa7Jtw2Gx+gE/dQXvPCDyhhSCsQz/lpLVUVX+FpuZ96EqdhDOYe4X6SWD
 BTRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767036965; x=1767641765; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZRR3yxbpq2V3CkfGHou7Vzmk0iQ3VJchRoplq3BvZaI=;
 b=28mw1Cwf5x8BpqD0K2whQapPDZpFqtyQfBpK4aI0e9kUjEqo0GsUnLzlb/q4Mm5emS
 Q+0DH70GM0yI35CTFvdmIyg1+O8XeFA1p0Elw629v+oOSWw0jyPz/xvE4xITPGSs9mSU
 cfhc9FK2N/EaeXG1GzqmYFTkmJF4i2BJ4i4JjCSDeVRbyFbxKjha9IwGzH9uWgjjSfse
 zcDZwcHlhJ8weQF+qKYl15Eud7rywcA3VAjHzse5qsa7lVrP35IIySMzoVuBE9lMblGM
 66UIHi241G+EtjDrj1s+2IOun6acrHTzdrtZKD+6DS+XmWm+qoOLZowZoiais/iNJVSn
 UWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767036965; x=1767641765;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZRR3yxbpq2V3CkfGHou7Vzmk0iQ3VJchRoplq3BvZaI=;
 b=pGW92SB0gQYQYpk/qVqTnk352OD7e3Eq3W2g5yJhGFWZqxxN5sbEUve+hJgQ9HwGtE
 Cx29kUa1l+vW6/EzvKcAIL0AlhNthwm7r50vQpqlIi8zgQhiuolIQRjDHaS1VzodGats
 CRvCHJg/TCPrrJm2yalLzIwDQ3+1R20iD0dEnA/TYP7B+46aoRuda1s8OJwxe6oOMxRK
 6PyM1DgRQkkeFBxgVKY5g6LuT1HxOu1xSw/pThU6m7iEMiiXPdI33bf7Il//o9Uv8eOV
 TwnLjX9An9LZ1/brbGaxhlqRisT3s/VEAjyFjxKyzoH6AGGf5ZGoOJEwj4Aokjn5fpqo
 KC+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW59BNNJpguHQXwTU8e7ZrJ6rR83QT9QTOn0T5JqoHP5Fn2ARDzS6AnRMSFxf+5YQdtIm6mNjVlj50l@nongnu.org
X-Gm-Message-State: AOJu0Yw7oe7t7E619A0Zb8fRaDjVYL1KrdZU2RaTL4+p2d34czXgtHII
 jSkcldy1+3hUCd6VwtHGjVqah7e10ibvQbKeMQXjnSmzwXyWZcos0ie+M3fa1/IFa4N9bM9i1gO
 HCHF5eI6NZ3oIRU5IQb84gTPQhPhrlU9y+6e9frUv
X-Gm-Gg: AY/fxX5ZtY/GnuBsdOJSGbEdKSdT+q2JkRqmEqhSs1t+dgh/FL3N3Hih3jD2gU+/shp
 7+QeQFxGq2+hF/W5NUOYspVIiJf8K4/i/8l7YCpM2uR8WRs1TdvPYwE9R0GYsu4szgoFnzu7MFX
 POi9eQiSc/9JB1rRgjCSrP1EoRtDNyh29wNzqImaJjYI8DhMSe1XLsiSs3IrxMWrKmocPIMWQOa
 zDv9RnrBw2RAsg7iteHjM4QScROB8oZWbGR+WySG3Qiz+jXkGcE9Uc0DqxKA/8QjXNXqVXkfOAO
 TsRKVpdPZqESIB5AmvfA5Tsr/A==
X-Google-Smtp-Source: AGHT+IGt38XSoG40pMa5YuNcdYBSB7uZ/EHfwgb+wVPmZUzlrS9ccxGMkQIbQafNyTPL7DW2K31uGc/D5qsIyf934Hc=
X-Received: by 2002:a05:622a:102:b0:4f1:aa29:7796 with SMTP id
 d75a77b69052e-4f4e5f88cd9mr31392371cf.15.1767036964658; Mon, 29 Dec 2025
 11:36:04 -0800 (PST)
MIME-Version: 1.0
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-7-kane_chen@aspeedtech.com>
 <465b0714-bd08-40b5-9cf9-5cd206e8548b@kaod.org>
 <SI6PR06MB76312852C6243B1F48202A89F7B0A@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <55adfce4-0dbc-492a-b586-4c46df78007a@kaod.org>
 <SI6PR06MB76318E7A596008386B0AE51CF7BFA@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <ed07c0f2-737d-4d65-917f-d39d02c37063@kaod.org>
 <006fa26f-6b84-4e82-b6e1-7d1353579441@kaod.org>
In-Reply-To: <006fa26f-6b84-4e82-b6e1-7d1353579441@kaod.org>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 29 Dec 2025 11:35:53 -0800
X-Gm-Features: AQt7F2ogMb0AC9i6qx8BM0zRYMH-1rriH9lHCIQsM2s8FJdC6js1NAlttpR3eDY
Message-ID: <CA+QoejXzjvyLA0Pp0xJjCsrwSyegSBRBs-MaT7yP41Nd2B9BcQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/19] hw/arm/aspeed: Integrate interrupt controller
 for AST1700
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x835.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Mon, Dec 29, 2025 at 8:51=E2=80=AFAM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> +phil
>
> On 12/29/25 12:41, C=C3=A9dric Le Goater wrote:
> > On 12/29/25 11:00, Kane Chen wrote:
> >>> -----Original Message-----
> >>> From: C=C3=A9dric Le Goater <clg@kaod.org>
> >>> Sent: Sunday, December 28, 2025 1:51 AM
> >>> To: Kane Chen <kane_chen@aspeedtech.com>; Peter Maydell
> >>> <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>; T=
roy
> >>> Lee <leetroy@gmail.com>; Jamin Lin <jamin_lin@aspeedtech.com>; Andrew
> >>> Jeffery <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>;
> >>> open list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC
> >>> here <qemu-devel@nongnu.org>
> >>> Cc: Troy Lee <troy_lee@aspeedtech.com>; nabihestefan@google.com
> >>> Subject: Re: [PATCH v4 06/19] hw/arm/aspeed: Integrate interrupt cont=
roller
> >>> for AST1700
> >>>
> >>> Hello Kane,
> >>>
> >>>> Thank you for the suggestion. Since I need to submit a v5 patch to
> >>>> split the I2C code changes anyway,
> >>>
> >>> Can you please introduce the bus label property at the end of the pat=
ch series ?
> >>> Please consider adding a functional test and updating the documentati=
on too.
> >>>
> >>>> I will handle the naming adjustments and other minor fixes myself in
> >>>> that version.
> >>>
> >>> Thanks,
> >>>
> >>> C.
> >>
> >> Hi C=C3=A9dric,
> >>
> >> If I move the bus label property to the end of this patch series, it w=
ill trigger
> >> a test failure in the current patch series.
> >
> > Which test ?
> >
> >> To avoid this, I plan to move the bus
> >> label changes into a separate patch series and submit it before the AS=
T1700
> >> series. I believe this approach ensures both series pass the tests pro=
perly.
> >> What are your thoughts on this?
> >
> > I would like to understand the issue first.
> I see.
>
> The AST2700 functional tests fail :
>
>         self.vm.add_args('-device',
>                           'tmp105,bus=3Daspeed.i2c.bus.1,address=3D0x4d,i=
d=3Dtmp-test')
>
> The "bus label" proposal renames the IO expander I2C buses (32) to avoid
> the name conflicts :
>
>            /aspeed.ioexp0.i2c.bus.0 (i2c-bus)
>            ...
>            /aspeed.ioexp0.i2c.bus.15 (i2c-bus)
>
>            /aspeed.ioexp1.i2c.bus.0 (i2c-bus)
>            ...
>            /aspeed.ioexp1.i2c.bus.15 (i2c-bus)
>
> Since this will be exposed in the user API, it would be best to avoid
> introducing poorly chosen names. Having so many I2C buses (48) in a
> single machine is somewhat new in QEMU and I am not aware of any naming
> convention for this.
>
> May be others do ?
>
> Thanks,
>
> C.

I'm not aware of any convention, but I'd argue the current naming with
the bus label makes sense. A i2c bus on the main machine is
"aspeed.i2c.bus.%d" which clearly makes it easy to differenciate but
see that the two busses are somehow related. Maybe it'd be worth
changing the `aspeed_i2c_class_init` to make this relation more
obvious by not using TYPE_ASPEED_I2C_BUS but use the string
explicitly?

Thanks,
Nabih

