Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D52C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 08:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp1XG-0002No-Ky; Mon, 03 Mar 2025 03:52:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tp1Wh-0002Kz-Oz; Mon, 03 Mar 2025 03:51:51 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tp1Wf-00026e-R7; Mon, 03 Mar 2025 03:51:51 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e5491eb37dso1318879a12.0; 
 Mon, 03 Mar 2025 00:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740991906; x=1741596706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8k5V09WYWF1eZYIWc93WOqBUDRRC+nxI/pLHJkwJuo=;
 b=kfsSegyGi7Qvbni1PH8rEnzCNFKpPO7gFS1lE0vtFRsOTNrEXQGnmmBZBbJbUT6zM+
 SPn/WuUjGoJHNWaPpyBQFQxmPFZZellzkK/rMJkHnUUyf2ukagUsKBHeFzcHAteRIWHH
 JKDrFmGYQIHDwLNxLll3N5CElQy4IsLKKPArtpc0qm6pX4BfESJ0bf9Bpy3lYQ3gLF0p
 y0Hf/0eUqijJOKU/RMGZXJHkK7JEmENwVjdhaieLGizphIoK2+vXdSaj/RZCCevXWkEE
 tCKruNXfiA7UAD9MLRcjf3As9LA2TeN+b/Yw8rrlAnvE9Ag+7MIjUGSmQA3MY8waa3L/
 qGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740991906; x=1741596706;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c8k5V09WYWF1eZYIWc93WOqBUDRRC+nxI/pLHJkwJuo=;
 b=iscQYJtUp7rC03UKX3lSjK2O/Fu7i9IfV4wIC0EcGq4HahAj/3Q66ypSijbP+KE5hy
 5M5xIgsngZ/YxxFkjpkWev/VN5OZew01qXgCrz8CjNwLB4mKPGKsVOLxXOI+nR7SSY9t
 H/VxvTPVit+u9IfS4CAjf98eEGwTRxtOh6PAWOXEuRXUBTM877hM6xVwDbwQVNHJ3qtX
 zAmt8+Q2C731LLN3tkztzFG0K2pCT2pjYW7hGaQwLVV/KEI0z0ruqm6OkSPqDwJ3NA+K
 exy2ZdlUbDqGQzP2KJohzVrzTVj2ijJK629WbjLA6YLX73PlSEXXQWAqxWAXtSgmvkAc
 GQLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEXo+T5c71Dogj+4JvwLD632POn7qqZwv/HmQxbtQcDXBbPdV7iJoVtGGtV4/VLc/I6vg3Mi2fEMn6QA==@nongnu.org,
 AJvYcCXkpo1B+Ss11s+CpIuReuMSVQLZOi6IVYNYiR1aF/yeDLXPpb73ED9e0UvtQrtzW3OR/akDNLvYj8aA@nongnu.org
X-Gm-Message-State: AOJu0YzSgCbgW5NES9YD6450hJIsTO33SvrutCAaD7SODTk4mS+QVNXN
 2ZJ+nL9ZAfFQ7x9YZNRqYR997CwvKg4ubMk2a03WZPgIzuf+HxVR
X-Gm-Gg: ASbGncvt60XmIsskaOSWVpDu7pc/TkTi5Ca88fnWK9Ex+FO7DZgdKgr+YxSf/4/6IV0
 6+WjL/uTGxI216iC2XfTcC6npGfW1Gd7YMD3/BP9SqeI7nbP3w7gApyNEZLrXgBkNnbsQDIADRG
 wwfutkDF/XHwbZwp6dMf9BlEQGYi1/QgR200DRzeC4ueRChan70tsHFJaLlufsZKl8PbecXxn9h
 PjsPED6dtHiEzGZElEa79D2uf96+J0RMTZqx9F5UGQPCub9bRtQMJKCz3uWL5k6xUEYaClKFRNS
 k6Vk6O6tS8RzoQ4KGY+g3dBcU4/ZF8KXANYXWR5Qe+lv+021CntUvwgfJePqhjyUgr/n/tGzrMV
 z97OEHZDrnd3uzxI=
X-Google-Smtp-Source: AGHT+IFF1Ee6CEob4ntm4WxHu0N/ELrp5gMzsIMK3jNhGIw6u3Gs0Rsf8MyEEbCc/4EIKXgRfJiwng==
X-Received: by 2002:a17:907:6d02:b0:abf:7a80:1a7e with SMTP id
 a640c23a62f3a-abf7a8020bbmr289954466b.9.1740991906128; 
 Mon, 03 Mar 2025 00:51:46 -0800 (PST)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf7fb2eb4asm136816366b.55.2025.03.03.00.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 00:51:45 -0800 (PST)
Date: Mon, 03 Mar 2025 08:03:25 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
CC: philmd@linaro.org
Subject: Re: [PATCH v2] hw/sd/sdhci: Set reset value of interrupt registers
In-Reply-To: <0ead70ac-f2a6-cf7d-e6cb-533b0f30f8c2@eik.bme.hu>
References: <20250210160329.DDA7F4E600E@zero.eik.bme.hu>
 <0ead70ac-f2a6-cf7d-e6cb-533b0f30f8c2@eik.bme.hu>
Message-ID: <E24C0545-5B8D-4AE8-8B1A-BEF3A408248B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
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



Am 1=2E M=C3=A4rz 2025 16:02:05 UTC schrieb BALATON Zoltan <balaton@eik=2E=
bme=2Ehu>:
>On Mon, 10 Feb 2025, BALATON Zoltan wrote:
>> The interrupt enable registers are not reset to 0 on Freescale eSDHC
>> but some bits are enabled on reset=2E At least some U-Boot versions see=
m
>> to expect this and not initialise these registers before expecting
>> interrupts=2E Use existing vendor property for Freescale eSDHC and set
>> the reset value of the interrupt registers to match Freescale
>> documentation=2E
>
>Ping?
>
>> Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>> ---
>> v2: Restrict to e500=2E Adding a reset method in a subclass does not
>> work because the common reset function is called directly on register
>> write from the guest but there's already provision for vendor specific
>> behaviour which can be used to restrict this to Freescale SoCs=2E
>>=20
>> hw/ppc/e500=2Ec         | 1 +
>> hw/sd/sdhci=2Ec         | 4 ++++
>> include/hw/sd/sdhci=2Eh | 1 +
>> 3 files changed, 6 insertions(+)
>>=20
>> diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>> index 26933e0457=2E=2E560eb42a12 100644
>> --- a/hw/ppc/e500=2Ec
>> +++ b/hw/ppc/e500=2Ec
>> @@ -1044,6 +1044,7 @@ void ppce500_init(MachineState *machine)
>>         dev =3D qdev_new(TYPE_SYSBUS_SDHCI);
>>         qdev_prop_set_uint8(dev, "sd-spec-version", 2);
>>         qdev_prop_set_uint8(dev, "endianness", DEVICE_BIG_ENDIAN);
>> +        qdev_prop_set_uint8(dev, "vendor", SDHCI_VENDOR_FSL);
>>         s =3D SYS_BUS_DEVICE(dev);
>>         sysbus_realize_and_unref(s, &error_fatal);
>>         sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC85XX_ESDH=
C_IRQ));
>> diff --git a/hw/sd/sdhci=2Ec b/hw/sd/sdhci=2Ec
>> index 99dd4a4e95=2E=2Eafa3c6d448 100644
>> --- a/hw/sd/sdhci=2Ec
>> +++ b/hw/sd/sdhci=2Ec
>> @@ -307,6 +307,10 @@ static void sdhci_reset(SDHCIState *s)
>>     s->data_count =3D 0;
>>     s->stopped_state =3D sdhc_not_stopped;
>>     s->pending_insert_state =3D false;
>> +    if (s->vendor =3D=3D SDHCI_VENDOR_FSL) {
>> +        s->norintstsen =3D 0x013f;
>> +        s->errintstsen =3D 0x117f;
>> +    }
>> }
>>=20
>> static void sdhci_poweron_reset(DeviceState *dev)
>> diff --git a/include/hw/sd/sdhci=2Eh b/include/hw/sd/sdhci=2Eh
>> index 38c08e2859=2E=2Ef722d8eb1c 100644
>> --- a/include/hw/sd/sdhci=2Eh
>> +++ b/include/hw/sd/sdhci=2Eh
>> @@ -110,6 +110,7 @@ typedef struct SDHCIState SDHCIState;
>>=20
>> #define SDHCI_VENDOR_NONE       0
>> #define SDHCI_VENDOR_IMX        1
>> +#define SDHCI_VENDOR_FSL        2

From=20an i=2EMX point of view the sole "FSL" postfix seems confusing since =
these SoCs are from the same vendor=2E What about "FSL_ESDHC"?

Best regards,
Bernhard

>>=20
>> /*
>>  * Controller does not provide transfer-complete interrupt when not
>>=20

