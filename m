Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8FEE67807
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 17:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7Hrf-0003KF-TB; Sat, 02 Nov 2024 13:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1t7Hrd-0003Jc-SD
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 13:24:41 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1t7Hrc-0008TM-1H
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 13:24:41 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53a007743e7so3166313e87.1
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2024 10:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1730568277; x=1731173077;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ikBgZ+L88jpe8vrOgdEvzV7rBj0Ggiq7vNLqo7AV/o=;
 b=xZC3bynyBiBqywGjMvJC2abo+zuhUMus5EYS9vogFNttiBvudhXsf/QqER7b3r/rxn
 TlGc/umPWluFkFHyCkFTijuWlW51pRbmVsGAzNA9SFW67707NL5zhZXAvR4ULzPOKceS
 jUONi/f2KKkJeowamx30WUs4JKdm7EFU4tppiDrztQn51eq58fSDYxP8jQCzx2AWKYLZ
 C7/udpWZo3sCD9Ma3Ts5zh7dkl9hdm/YrJ470C/atlOnPFvZi6ACNauS+R7sPCxEjEaj
 9MtKMdvA7ZydBboItG90ujVwBzQlxP2RiwVp6JbzNSAqgY2C//CQyfyyoW7vPZ+9iNT/
 vqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730568277; x=1731173077;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ikBgZ+L88jpe8vrOgdEvzV7rBj0Ggiq7vNLqo7AV/o=;
 b=bUZrq4Ri+C0/WrgMd8cwoT689Jiap7lGNOZZjCZnxhtZrZyhZ/dFD5fzyCpNc8aBp/
 t9IBmzNJERJ3CPzQ5DVlKuGrMtRFtofS1NOKCw3TxEq8NJyod26aPHmPbdsg1Hzz6Hdk
 5dpm6/QPbh8q5PsU/eWrzGpLKchsac64HEJaVS9fZGhO31cvnwWEOav4Wy5hZRXZCFb6
 5yLj0ox3cK7BUQQnh6wO6hrU4QVAuYQWQl2Sm9McsJnYlzZxI22LE371F5/3/MGsHKsG
 jLLMliSqo3Fankhg73w/B13d/lgZq5cGHScH+Xm37nOFoUwmn4esr5a6DNIfI8gxte5X
 9YUQ==
X-Gm-Message-State: AOJu0YypyA0vxIVIrkHcmeoFSg81BURz7n5oZf/N5rufcI8fAGnll2jQ
 4FcI8fg0GChUC86br3CXbteRTGbVKwbBpV+kpQgQjXV/JiClFc3NH7lgvPqfT+27x8p9KyTqdOK
 Jv6dkCcA9hChKr3XvYlHDPtLHqml+666H+wgD3A==
X-Google-Smtp-Source: AGHT+IF7aFsdL1B+97ee0MXOCSW8hNbbV4v5OT8yhL6hKJjKDUspvqnQQUxrjRdQsURWRBlwb2VJ9puFtrfgZNHPI0k=
X-Received: by 2002:a05:6512:b94:b0:539:f7ab:e161 with SMTP id
 2adb3069b0e04-53c79e8ec22mr6065850e87.45.1730568277102; Sat, 02 Nov 2024
 10:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20241102131715.548849-1-shentey@gmail.com>
 <20241102131715.548849-23-shentey@gmail.com>
In-Reply-To: <20241102131715.548849-23-shentey@gmail.com>
From: Corey Minyard <corey@minyard.net>
Date: Sat, 2 Nov 2024 12:24:25 -0500
Message-ID: <CAB9gMfrd+E=yv6L4JZ6KuTJv496omKdN3DAw+AyWQG6vjac5Bg@mail.gmail.com>
Subject: Re: [PATCH v3 22/26] hw/i2c/smbus_eeprom: Prefer DEFINE_TYPES() macro
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-block@nongnu.org, 
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org, 
 Corey Minyard <cminyard@mvista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::12c;
 envelope-from=corey@minyard.net; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Sat, Nov 2, 2024 at 8:25=E2=80=AFAM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/i2c/smbus_eeprom.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index 9e62c27a1a..1d4d9704bf 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -151,19 +151,16 @@ static void smbus_eeprom_class_initfn(ObjectClass *=
klass, void *data)
>      dc->user_creatable =3D false;
>  }
>
> -static const TypeInfo smbus_eeprom_info =3D {
> -    .name          =3D TYPE_SMBUS_EEPROM,
> -    .parent        =3D TYPE_SMBUS_DEVICE,
> -    .instance_size =3D sizeof(SMBusEEPROMDevice),
> -    .class_init    =3D smbus_eeprom_class_initfn,
> +static const TypeInfo types[] =3D {

This is better, but why did you change the name to "types".  The
previous name was fairly descriptive, though you might change "info"
to "types".

-corey

> +    {
> +        .name          =3D TYPE_SMBUS_EEPROM,
> +        .parent        =3D TYPE_SMBUS_DEVICE,
> +        .instance_size =3D sizeof(SMBusEEPROMDevice),
> +        .class_init    =3D smbus_eeprom_class_initfn,
> +    },
>  };
>
> -static void smbus_eeprom_register_types(void)
> -{
> -    type_register_static(&smbus_eeprom_info);
> -}
> -
> -type_init(smbus_eeprom_register_types)
> +DEFINE_TYPES(types)
>
>  void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *eepr=
om_buf)
>  {
> --
> 2.47.0
>
>

