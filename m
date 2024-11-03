Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0A3D10C0E
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 11:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7ZA2-0005D7-GW; Sun, 03 Nov 2024 06:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7Z9z-0005Bn-Jz; Sun, 03 Nov 2024 06:52:47 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7Z9v-0002D1-U0; Sun, 03 Nov 2024 06:52:46 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso26700295e9.1; 
 Sun, 03 Nov 2024 03:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730634761; x=1731239561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kaiT1jnsntFJKviwi5aBpX6zZopAHL1AYFYYPBoSFtA=;
 b=di0Gfu+n9xLPco4qz9ysqu6tCRIhiMOtyYYzA2ZnIE+rat/7MS3WbAcZCgaE55oONf
 y+pP0K0neMeHZdVgY4u2NCWnOSE9SqcUa28nO5CfW119ePUW9V+2UJhF4/yxZKhy1vdY
 C0tmmU9MRr9b2b7d3P+8emqDB/5dz1dVTckLLi987FgXOKKwq2g82dU5PzZ/CTLfHM/0
 klf6gMezmCPNh1vIiz/KzludnHumRMhF/uwW1OWopbkdgWNrxjHLwWJ7qiuDvEs/YdaL
 V+wT+cTx3I3ZxjMwp1drXwUyWHwyYO3lmrPJE/hk8/NUacyIopm7c7uEpiAJmOrZbPgi
 TsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730634761; x=1731239561;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kaiT1jnsntFJKviwi5aBpX6zZopAHL1AYFYYPBoSFtA=;
 b=EMaVuYRkLsUw4rRu7Q6w7JR8QF9V7CUAuaqgvMqp7kO0XLawlodTQNpGSlsfvEC6C1
 eYmZlSffC8XysJe+BsKSSfQuToEEv8apU/iydJSidE6jJtqTX2NTY+7O/3/bqf8lWt8w
 3EZgbSN4Foe70DnZTjHTl26Dma1De5yQVCUEr2Iu9iLIG3bY5u+h186GTVo/uux/RvVx
 vfP9011kmPm3LMDE4jYcqTwCJpAGziTJkXMTLChau5XKRuX2C4vnOGCAIX4sSOjUjIII
 1qTaVpIbxFKdpHnmbozYV+jg9zyPQNBXY2jEg+/O+uxptir2bIYm065ddPzg5OaXu/Ch
 6eBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2Oasi3ibuZ5yJPny4a5q3Fg7EAO7c/F4St29nJDIYq5SS+xdya0Cx9jPEdQ9jWoLdo1GFfVMg0Kd4@nongnu.org,
 AJvYcCXyj1rW+Qldpzr97qB6+T6Gr4x4g8Ue0D1oYm6eGTyHCVF+/Lh/4TFY+EwHnspF+sJ3+5murqRhqxk=@nongnu.org
X-Gm-Message-State: AOJu0YxG7RxstSjYHd0JoAKm202EPTus5ZlRm1fJsOXV2SGtovs1gs9q
 zPyMzcwReX3Cv2pubPXRYc2VLRP7A8cDy/OJPsfeTA8vtEVU7F95
X-Google-Smtp-Source: AGHT+IHd1+28J074v1zCrAJtij4OzQtE/Oe30zUvVrm68NhiLF/k2nfD9diI8v8bqlWaGb0DCInfog==
X-Received: by 2002:a05:600c:3583:b0:431:5503:43ca with SMTP id
 5b1f17b1804b1-4328328494dmr67049535e9.28.1730634761111; 
 Sun, 03 Nov 2024 03:52:41 -0800 (PST)
Received: from ?IPv6:::1?
 (p200300faaf0043008d496915e5ce0c3d.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:8d49:6915:e5ce:c3d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bb793e51sm148704475e9.1.2024.11.03.03.52.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Nov 2024 03:52:40 -0800 (PST)
Date: Sun, 03 Nov 2024 11:52:40 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Corey Minyard <corey@minyard.net>
CC: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v3 22/26] hw/i2c/smbus_eeprom: Prefer DEFINE_TYPES() macro
In-Reply-To: <F35089BE-2008-4C0B-AECE-067A732EEFE6@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
 <20241102131715.548849-23-shentey@gmail.com>
 <CAB9gMfrd+E=yv6L4JZ6KuTJv496omKdN3DAw+AyWQG6vjac5Bg@mail.gmail.com>
 <F35089BE-2008-4C0B-AECE-067A732EEFE6@gmail.com>
Message-ID: <EAD2880C-8F56-4EBA-8664-5844E9FFE14B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x329.google.com
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



Am 3=2E November 2024 07:51:46 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>
>
>Am 2=2E November 2024 17:24:25 UTC schrieb Corey Minyard <corey@minyard=
=2Enet>:
>>On Sat, Nov 2, 2024 at 8:25=E2=80=AFAM Bernhard Beschow <shentey@gmail=
=2Ecom> wrote:
>>>
>>> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat=2Ecom>
>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>> ---
>>>  hw/i2c/smbus_eeprom=2Ec | 19 ++++++++-----------
>>>  1 file changed, 8 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/hw/i2c/smbus_eeprom=2Ec b/hw/i2c/smbus_eeprom=2Ec
>>> index 9e62c27a1a=2E=2E1d4d9704bf 100644
>>> --- a/hw/i2c/smbus_eeprom=2Ec
>>> +++ b/hw/i2c/smbus_eeprom=2Ec
>>> @@ -151,19 +151,16 @@ static void smbus_eeprom_class_initfn(ObjectClas=
s *klass, void *data)
>>>      dc->user_creatable =3D false;
>>>  }
>>>
>>> -static const TypeInfo smbus_eeprom_info =3D {
>>> -    =2Ename          =3D TYPE_SMBUS_EEPROM,
>>> -    =2Eparent        =3D TYPE_SMBUS_DEVICE,
>>> -    =2Einstance_size =3D sizeof(SMBusEEPROMDevice),
>>> -    =2Eclass_init    =3D smbus_eeprom_class_initfn,
>>> +static const TypeInfo types[] =3D {
>>
>>This is better, but why did you change the name to "types"=2E  The
>>previous name was fairly descriptive, though you might change "info"
>>to "types"=2E
>
>I took inspiration from https://lore=2Ekernel=2Eorg/qemu-devel/2024021517=
5752=2E82828-20-philmd@linaro=2Eorg =2E I could preserve the old names (als=
o in the other patches) by simply converting to plural form=2E Here it woul=
d be: smbus_eeprom_infos=2E OK?

Well, the plural form of " info" is also "info"=2E So I'll keep the names =
in the patches as they are in master, except when multiple types are define=
d where I'll draw inspiration from the file names=2E

Best regards,
Bernhard

>
>Best regards,
>Bernhard
>
>>
>>-corey
>>
>>> +    {
>>> +        =2Ename          =3D TYPE_SMBUS_EEPROM,
>>> +        =2Eparent        =3D TYPE_SMBUS_DEVICE,
>>> +        =2Einstance_size =3D sizeof(SMBusEEPROMDevice),
>>> +        =2Eclass_init    =3D smbus_eeprom_class_initfn,
>>> +    },
>>>  };
>>>
>>> -static void smbus_eeprom_register_types(void)
>>> -{
>>> -    type_register_static(&smbus_eeprom_info);
>>> -}
>>> -
>>> -type_init(smbus_eeprom_register_types)
>>> +DEFINE_TYPES(types)
>>>
>>>  void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *e=
eprom_buf)
>>>  {
>>> --
>>> 2=2E47=2E0
>>>
>>>

