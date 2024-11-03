Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C43FE67807
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 07:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7VOr-0003m1-0A; Sun, 03 Nov 2024 02:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7VOp-0003lj-A7; Sun, 03 Nov 2024 02:51:51 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7VOn-0006pj-Hh; Sun, 03 Nov 2024 02:51:51 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37d4a5ecc44so2011999f8f.2; 
 Sun, 03 Nov 2024 00:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730620307; x=1731225107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M3pEreXAeYA4y9REHP0khDzcGKOBknkGZcbn2/2Try8=;
 b=SLwfmKdfJM1azZqkRNOn6vOvoE+YurxfggQqX2l+wX/mLCHjwMWP+3p4eg1LB6o2ZJ
 rInKq1CtmV73ozQP7k7YRzxAA7HOwC1cO5zCtpZg3Aw+rEmvLDqxL7OfrMl5ZtXHSXaZ
 DsyODlHVFZT63JCCDPFZwclSNNGb/PJZjgM8dxWXgQMYo5Uae1MnqkX9XoUWPl+1Bt4C
 ilH1FXrxZkl6BHqyow/90OwR5FkWfbKzU8/Z0OuRBa+/SSBEoU5TGv+bFqigILlzedoJ
 bNnuwJE1TJa3H+KvEgPG8ev143Lk32qyzbjNxNdzhWRalxxdzmw4ERJGvhw0Jn/2FlrK
 VEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730620307; x=1731225107;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M3pEreXAeYA4y9REHP0khDzcGKOBknkGZcbn2/2Try8=;
 b=u7bCx4uLQR6xnNG32pHRWiDLOcbiuI1B3mn40mQCkNFLoBqrDfFc8TLeAKQkAuGuFP
 yGcTpzzkWZIDQCs+QIf4rLJHdSrEHPypzbQxMM78QrGd5dwGVgwqOePIfd66b3QqfI0G
 8eMxthKXoYiKvasfvBlTNXIHfIXNBA0x7VvdHHesDttN0WoITsDjUMqzbZokuTGHSEtg
 YhtD6ig50RwK5NkGErZNVjfUd/GQorVKDMg5VVbnleTBIGZaL7Fj1WJIfrGYH2I8DG7+
 /+6ffAeXHhDwhsouaobUzk06tPB/+gJBt6G4+f5tkjCzow4zeoF5Brfr6CKjLOU/clAF
 tr4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ/5WzJG00T1UkuD/cJVX1+F4PwYROrShExVzzVkHGNOLMeatkn8B0djfACvtpLbvOZ1tc7q3pzU0=@nongnu.org,
 AJvYcCXu5uZErDaoN9b6mMHLa1KLch+GGVyDq/B7PAvtCrsBBHuWI2mKB4/LSh65+ZJwQwqLX4jr+Ih4BP20@nongnu.org
X-Gm-Message-State: AOJu0YxaCp7qOc1JY3LDquNOvhYP2HEu8KPMUrmFGjPe4in0LTTPXzq7
 zHS8cbtaZ/jg9JQEo0J1OdjVTvO8JxedI9GP8PHJpzxcKWT7cMY2
X-Google-Smtp-Source: AGHT+IFJLWgQ+UIo1FIwmUObBlEZ/eZpSdBX+QSluDkMaXmWRVoXDkl4AOJn7Ka6D8u09Ceo/+BxrA==
X-Received: by 2002:adf:9bd4:0:b0:37d:4e74:687 with SMTP id
 ffacd0b85a97d-380611e1392mr19503594f8f.41.1730620307039; 
 Sun, 03 Nov 2024 00:51:47 -0700 (PDT)
Received: from ?IPv6:::1?
 (p200300faaf0043008d496915e5ce0c3d.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:8d49:6915:e5ce:c3d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c1168afcsm10000234f8f.91.2024.11.03.00.51.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Nov 2024 00:51:46 -0700 (PDT)
Date: Sun, 03 Nov 2024 07:51:46 +0000
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
In-Reply-To: <CAB9gMfrd+E=yv6L4JZ6KuTJv496omKdN3DAw+AyWQG6vjac5Bg@mail.gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
 <20241102131715.548849-23-shentey@gmail.com>
 <CAB9gMfrd+E=yv6L4JZ6KuTJv496omKdN3DAw+AyWQG6vjac5Bg@mail.gmail.com>
Message-ID: <F35089BE-2008-4C0B-AECE-067A732EEFE6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42f.google.com
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



Am 2=2E November 2024 17:24:25 UTC schrieb Corey Minyard <corey@minyard=2E=
net>:
>On Sat, Nov 2, 2024 at 8:25=E2=80=AFAM Bernhard Beschow <shentey@gmail=2E=
com> wrote:
>>
>> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat=2Ecom>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>  hw/i2c/smbus_eeprom=2Ec | 19 ++++++++-----------
>>  1 file changed, 8 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/i2c/smbus_eeprom=2Ec b/hw/i2c/smbus_eeprom=2Ec
>> index 9e62c27a1a=2E=2E1d4d9704bf 100644
>> --- a/hw/i2c/smbus_eeprom=2Ec
>> +++ b/hw/i2c/smbus_eeprom=2Ec
>> @@ -151,19 +151,16 @@ static void smbus_eeprom_class_initfn(ObjectClass=
 *klass, void *data)
>>      dc->user_creatable =3D false;
>>  }
>>
>> -static const TypeInfo smbus_eeprom_info =3D {
>> -    =2Ename          =3D TYPE_SMBUS_EEPROM,
>> -    =2Eparent        =3D TYPE_SMBUS_DEVICE,
>> -    =2Einstance_size =3D sizeof(SMBusEEPROMDevice),
>> -    =2Eclass_init    =3D smbus_eeprom_class_initfn,
>> +static const TypeInfo types[] =3D {
>
>This is better, but why did you change the name to "types"=2E  The
>previous name was fairly descriptive, though you might change "info"
>to "types"=2E

I took inspiration from https://lore=2Ekernel=2Eorg/qemu-devel/20240215175=
752=2E82828-20-philmd@linaro=2Eorg =2E I could preserve the old names (also=
 in the other patches) by simply converting to plural form=2E Here it would=
 be: smbus_eeprom_infos=2E OK?

Best regards,
Bernhard

>
>-corey
>
>> +    {
>> +        =2Ename          =3D TYPE_SMBUS_EEPROM,
>> +        =2Eparent        =3D TYPE_SMBUS_DEVICE,
>> +        =2Einstance_size =3D sizeof(SMBusEEPROMDevice),
>> +        =2Eclass_init    =3D smbus_eeprom_class_initfn,
>> +    },
>>  };
>>
>> -static void smbus_eeprom_register_types(void)
>> -{
>> -    type_register_static(&smbus_eeprom_info);
>> -}
>> -
>> -type_init(smbus_eeprom_register_types)
>> +DEFINE_TYPES(types)
>>
>>  void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *ee=
prom_buf)
>>  {
>> --
>> 2=2E47=2E0
>>
>>

