Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294B8C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwdt-0001pN-91; Wed, 19 Mar 2025 12:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tuwdr-0001oc-Po; Wed, 19 Mar 2025 12:51:43 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tuwdq-0003hB-3y; Wed, 19 Mar 2025 12:51:43 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ab78e6edb99so1086570966b.2; 
 Wed, 19 Mar 2025 09:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742403099; x=1743007899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ouZx7qFmj5er/LXPW47ACshYryaCgxL7gy3M/1R3puE=;
 b=RJcZRQoEo+YGw0CGguSVuxSQ2wj5X/0w4817s+r/WcMOL9IbINAnm4zFkHmvjycHlT
 uTKPEeYITyefp2vuuXvdJo1MmoJGPCTnWneC6QjOxr7ilK8CfXThMbnHae4ut3oB7GdD
 1NyRyMShFOYfnG6rvbUJ2m1VD/Ddwuk0u3jg4XvyeUoHRDj4vL2BkHMGq/Kbn4Xj78mC
 vgzGZ3R13Vuaqaw232UaU33phNDpiICGbPClrTZgs8JcwqN/POXYMCLNVoS0OMcP+RnF
 Uksuxh4pfALFCIh4YYpKoYJwJk5gHsPXR0IqGHr74UycA75PeK6iYUINl5ZjdBLWMRHc
 g56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742403099; x=1743007899;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ouZx7qFmj5er/LXPW47ACshYryaCgxL7gy3M/1R3puE=;
 b=NReVIW1lStzCdaO/McqpS1FlnQT4Krk8QsM/X5nkVaVYmIx14RcNoI3kaTNp77uyiX
 HYq78NCiYmXo0XRrT5mWglmA5rB9FA+L7Oq7Xa3IL4r9OwdPwrh82qnmh5fLM8Lf//Fw
 k0G4Q9dCTS9FfzRfB7szGP/hTFxwgl2Xz9jwtyeDZZukjQZ/04jBaGH+fpfrH/kijy7p
 HeaCMNnIhsyRYSvggzxKOerRVxnCz11SBq4rBiuvCLePVDgV6SbFUPRpMn+NQCwxJM1K
 cYrKpvQyEujWPAp4VKGhAwXSGe35vgKZsaLPBf5LoHINQ23UP8M9L8epLG+k5R+nj8IX
 0JCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMB6gxSdzjcj0oJkR1UIpDEtPSLgam+gigAacPOlTv16olkEmxrdet7Fi9EPd/iKJMadAbWXE6/w==@nongnu.org
X-Gm-Message-State: AOJu0Yy86xgNCeakLvVUE1P5CKt9kbE4zrzWiYYzYyd6k8nJqTddX1Z+
 NGxNHfyHfMeOhR37RN1IWK/xMpDS+K/lysY+ASPVeI/1mMb+PR6B
X-Gm-Gg: ASbGncuJMmgwJ7+C3EgHTsdf8OMbDb8tYxW86v2XlGtB5446GzZ6ZPo9DXvIl09BDQ+
 t8ipujAjcGaRaOO63yZdugC2h7X0l3VOBE3lSYYUcVrxyGIRqcWsVc22OrrQXcBmCqspI9QqpE0
 5K5WJKh2CqNpPyrND/pUNGhy4YMoMR6yRc4FDS6qBEZVB/8o72wyflGlW7XyaJTHlZEZu8r3T0b
 lS/sUll+Q8fPJ8UWnPl02UsqEXCznXIvf+6cZOjq+K+Y4c85j4XwO1oDnBhHJqKbnJ4R2GkeYHt
 ib9V4TgV/ytKtH6pIQzXAqZsamhwhtSFclLwsRVPkc2UWRq0N2g=
X-Google-Smtp-Source: AGHT+IE8boKLyqy1r0bQG9PwgN1F170AYSjfOO/p852fODCbEV6PKoAe14EOHUNGF2XDoOZ5e18N2w==
X-Received: by 2002:a17:907:3d89:b0:abe:fdfc:47d6 with SMTP id
 a640c23a62f3a-ac3cdfbffb3mr26746066b.23.1742403099085; 
 Wed, 19 Mar 2025 09:51:39 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147ef34asm1051331566b.68.2025.03.19.09.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:51:38 -0700 (PDT)
Date: Wed, 19 Mar 2025 16:51:38 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/2=5D_hw/arm/fsl-imx8mp=3A_Derive_?=
 =?US-ASCII?Q?struct_FslImx8mpState_from_TYPE=5FSYS=5FBUS=5FDEVICE?=
In-Reply-To: <CAFEAcA-jbRt7x7w-gA5KEBRK8_kHgHRcX4ri+vn-umz2wAsGxA@mail.gmail.com>
References: <20250314183224.21822-1-shentey@gmail.com>
 <20250314183224.21822-2-shentey@gmail.com>
 <CAFEAcA8DPonw1+GsBJ079AfeSyO9=3B93P1yj3uLTBzF4uf0Ug@mail.gmail.com>
 <CAFEAcA-jbRt7x7w-gA5KEBRK8_kHgHRcX4ri+vn-umz2wAsGxA@mail.gmail.com>
Message-ID: <10C0F394-2118-4AA6-A815-44B636B5DCEB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
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



Am 18=2E M=C3=A4rz 2025 15:29:17 UTC schrieb Peter Maydell <peter=2Emaydel=
l@linaro=2Eorg>:
>On Tue, 18 Mar 2025 at 15:27, Peter Maydell <peter=2Emaydell@linaro=2Eorg=
> wrote:
>>
>> On Fri, 14 Mar 2025 at 18:32, Bernhard Beschow <shentey@gmail=2Ecom> wr=
ote:
>> >
>> > Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset up=
on machine
>> > reset=2E It also makes the SoC implementation not user-creatable whic=
h can trigger
>> > the following crash:
>> >
>> >   $ =2E/qemu-system-aarch64  -M virt -device fsl-imx8mp
>> >   **
>> >   ERROR:=2E=2E/=2E=2E/devel/qemu/tcg/tcg=2Ec:1006:tcg_register_thread=
: assertion failed:
>> >   (n < tcg_max_ctxs)
>> >   Bail out! ERROR:=2E=2E/=2E=2E/devel/qemu/tcg/tcg=2Ec:1006:tcg_regis=
ter_thread:
>> >   assertion failed: (n < tcg_max_ctxs)
>> >   Aborted (core dumped)
>>
>> > diff --git a/hw/arm/fsl-imx8mp=2Ec b/hw/arm/fsl-imx8mp=2Ec
>> > index c3f6da6322=2E=2E82edf61082 100644
>> > --- a/hw/arm/fsl-imx8mp=2Ec
>> > +++ b/hw/arm/fsl-imx8mp=2Ec
>> > @@ -702,7 +702,7 @@ static void fsl_imx8mp_class_init(ObjectClass *oc=
, void *data)
>> >  static const TypeInfo fsl_imx8mp_types[] =3D {
>> >      {
>> >          =2Ename =3D TYPE_FSL_IMX8MP,
>> > -        =2Eparent =3D TYPE_DEVICE,
>> > +        =2Eparent =3D TYPE_SYS_BUS_DEVICE,
>> >          =2Einstance_size =3D sizeof(FslImx8mpState),
>> >          =2Einstance_init =3D fsl_imx8mp_init,
>> >          =2Eclass_init =3D fsl_imx8mp_class_init,
>> > diff --git a/hw/arm/imx8mp-evk=2Ec b/hw/arm/imx8mp-evk=2Ec
>> > index e1a7892fd7=2E=2Ef17d5db466 100644
>> > --- a/hw/arm/imx8mp-evk=2Ec
>> > +++ b/hw/arm/imx8mp-evk=2Ec
>> > @@ -37,7 +37,7 @@ static void imx8mp_evk_init(MachineState *machine)
>> >      s =3D FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
>> >      object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
>> >      object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fa=
tal);
>> > -    qdev_realize(DEVICE(s), NULL, &error_fatal);
>> > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
>>
>> You want sysbus_realize() here, not the _and_unref() variant,
>> because the device was created with object_initialize_child()=2E
>
>No, that's wrong, we create it with object_new()=2E So
>the _and_unref() *is* correct, but this is a separate bug fix
>from the "should be sysbus, not qdev" bug this patch says
>it is fixing=2E Can it be in a separate patch, please?

Sure, fixed in v3=2E

Best regards,
Bernhard

>
>thanks
>-- PMM

