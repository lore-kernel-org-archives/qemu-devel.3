Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2370ED10C0E
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7aJH-0001NO-09; Sun, 03 Nov 2024 08:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7aJF-0001Mw-0e; Sun, 03 Nov 2024 08:06:25 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7aJD-0005FR-6e; Sun, 03 Nov 2024 08:06:24 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d447de11dso2709940f8f.1; 
 Sun, 03 Nov 2024 05:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730639179; x=1731243979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bq5B6yvFu13g38UC/HuP3IL/2ofZP8iKYXLutfjrIAw=;
 b=CAlcUylsBaz1zXtm+HbubUvCv6oj62I9wWpIzlL+R1pjnXs0LhCsvpVAv3TXTQKZsh
 M10Wpomr4xZkDOdVgVpKK8TwwtYUdm6fPzYXdTbqG3rtqhPzV1nrCHVukC1N4Z2EE/ra
 Qbf3kO4tp/JyPqUNot8TKmUkUNUVVH6DM3Vt8FZX9dLnufayJ2MdbB+b/2xIBwf7rxVM
 Mr1TKLocO3Lrrs/NoDZAaYg1hEPVl0bdxStD4kj/bCWlinRrRXDMhkW6qi2GaHAJnqgf
 +gA8v11KBFLpMENPJweUqNxPhLiqYmQSRPr8Wxsy+cHULW5ZKf/r0b8bgfSwD7EsUhGP
 bxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730639179; x=1731243979;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bq5B6yvFu13g38UC/HuP3IL/2ofZP8iKYXLutfjrIAw=;
 b=wCTUS6Ju5E2i+elZ108clzGUvjNt1kPXewLw4Ck/hE3S8Y7lp+q6y8sYVAFQzpMwKS
 vTcUlVrYe1FTDkzku/skO9PC70oFWW8xIhTSLm6gyr84KEKOVRh8OHdtm1lp2dgcoMLK
 /jG+x6PKCfbcnB2Qz3MCdCtkc0IktCe4VuRFvdwspNZFY7NDSRQ/G0sAKXRqh0SnEg/C
 1wf5YFSSItMlGU5RXMaffuIs9JYfTHu4amCw29FDM8no0pwfr+dLgvAlINcfoDhZe+uf
 XWbfXO5i0WPXM2SkkU6OItonhT7I50zTrGLCpOubvm4IfvXX2241HvxOQkfhbiQXXcsj
 8CYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUrFMgUwskH9PCb1l/F6XSM5rBzh4vqC08nBxD1RErXTFikkZJrO04nSpcCuXExpEEKNcfnqIp+oQ=@nongnu.org,
 AJvYcCWgeFAJawd6WVOGsAbeUku1zoOg5+DAjzyeKgScA17pLslxjZANQZsCtJiP2HT5p1npaZIF/szKhkt7@nongnu.org
X-Gm-Message-State: AOJu0Ywu/0/sE76s0j9jSZKrh7Uw8qHiyZMh4f0u33FUbELTAiNkkhrf
 YyfLb0lpxJc8Mo/cO1CHnz7JxuSDvRrGTpcalDcpL1qVSNzLVftt
X-Google-Smtp-Source: AGHT+IH6zS3zJnj+CSyx+fI8sd75D39WC7dXb8BsYPc+r4Yq2RFHZHpX1Nm4ITGMzXCSoiQyNGMerg==
X-Received: by 2002:a05:6000:2a1:b0:37d:4e59:549a with SMTP id
 ffacd0b85a97d-381be7c7350mr11168118f8f.16.1730639179121; 
 Sun, 03 Nov 2024 05:06:19 -0800 (PST)
Received: from ?IPv6:::1?
 (p200300faaf0043008d496915e5ce0c3d.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:8d49:6915:e5ce:c3d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116ad6fsm10529660f8f.98.2024.11.03.05.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Nov 2024 05:06:18 -0800 (PST)
Date: Sun, 03 Nov 2024 13:06:18 +0000
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
In-Reply-To: <EAD2880C-8F56-4EBA-8664-5844E9FFE14B@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
 <20241102131715.548849-23-shentey@gmail.com>
 <CAB9gMfrd+E=yv6L4JZ6KuTJv496omKdN3DAw+AyWQG6vjac5Bg@mail.gmail.com>
 <F35089BE-2008-4C0B-AECE-067A732EEFE6@gmail.com>
 <EAD2880C-8F56-4EBA-8664-5844E9FFE14B@gmail.com>
Message-ID: <0989F1AD-E584-4750-8966-76DD86E70738@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x429.google.com
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



Am 3=2E November 2024 11:52:40 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>
>
>Am 3=2E November 2024 07:51:46 UTC schrieb Bernhard Beschow <shentey@gmai=
l=2Ecom>:
>>
>>
>>Am 2=2E November 2024 17:24:25 UTC schrieb Corey Minyard <corey@minyard=
=2Enet>:
>>>On Sat, Nov 2, 2024 at 8:25=E2=80=AFAM Bernhard Beschow <shentey@gmail=
=2Ecom> wrote:
>>>>
>>>> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat=2Ecom>
>>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>> ---
>>>>  hw/i2c/smbus_eeprom=2Ec | 19 ++++++++-----------
>>>>  1 file changed, 8 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/hw/i2c/smbus_eeprom=2Ec b/hw/i2c/smbus_eeprom=2Ec
>>>> index 9e62c27a1a=2E=2E1d4d9704bf 100644
>>>> --- a/hw/i2c/smbus_eeprom=2Ec
>>>> +++ b/hw/i2c/smbus_eeprom=2Ec
>>>> @@ -151,19 +151,16 @@ static void smbus_eeprom_class_initfn(ObjectCla=
ss *klass, void *data)
>>>>      dc->user_creatable =3D false;
>>>>  }
>>>>
>>>> -static const TypeInfo smbus_eeprom_info =3D {
>>>> -    =2Ename          =3D TYPE_SMBUS_EEPROM,
>>>> -    =2Eparent        =3D TYPE_SMBUS_DEVICE,
>>>> -    =2Einstance_size =3D sizeof(SMBusEEPROMDevice),
>>>> -    =2Eclass_init    =3D smbus_eeprom_class_initfn,
>>>> +static const TypeInfo types[] =3D {
>>>
>>>This is better, but why did you change the name to "types"=2E  The
>>>previous name was fairly descriptive, though you might change "info"
>>>to "types"=2E
>>
>>I took inspiration from https://lore=2Ekernel=2Eorg/qemu-devel/202402151=
75752=2E82828-20-philmd@linaro=2Eorg =2E I could preserve the old names (al=
so in the other patches) by simply converting to plural form=2E Here it wou=
ld be: smbus_eeprom_infos=2E OK?
>
>Well, the plural form of " info" is also "info"=2E So I'll keep the names=
 in the patches as they are in master, except when multiple types are defin=
ed where I'll draw inspiration from the file names=2E

Checking other usages of DEFINE_TYPES(), the majority by far uses a "types=
" suffix while qom=2Erst suggests "info"=2E Still, 2nd place is "infos" suf=
fix=2E I'll go with "types" suffix then which makes hcd-ehci-sysbus consist=
ent with hcd-ohci-sysbus=2E

Best regards,
Bernhard

>
>Best regards,
>Bernhard
>
>>
>>Best regards,
>>Bernhard
>>
>>>
>>>-corey
>>>
>>>> +    {
>>>> +        =2Ename          =3D TYPE_SMBUS_EEPROM,
>>>> +        =2Eparent        =3D TYPE_SMBUS_DEVICE,
>>>> +        =2Einstance_size =3D sizeof(SMBusEEPROMDevice),
>>>> +        =2Eclass_init    =3D smbus_eeprom_class_initfn,
>>>> +    },
>>>>  };
>>>>
>>>> -static void smbus_eeprom_register_types(void)
>>>> -{
>>>> -    type_register_static(&smbus_eeprom_info);
>>>> -}
>>>> -
>>>> -type_init(smbus_eeprom_register_types)
>>>> +DEFINE_TYPES(types)
>>>>
>>>>  void smbus_eeprom_init_one(I2CBus *smbus, uint8_t address, uint8_t *=
eeprom_buf)
>>>>  {
>>>> --
>>>> 2=2E47=2E0
>>>>
>>>>

