Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BB4C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGEl-000247-Uq; Tue, 21 Jan 2025 10:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1taGEj-0001zz-OO
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:32:17 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1taGEi-00075z-1d
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:32:17 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d4e2aa7ea9so10729408a12.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737473534; x=1738078334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+jk4e/F8Tu0rwwR4NSYttHuoKAaAOpNe188q48KN6xM=;
 b=h/VXC2rki3Ho8Nw9YGB0W1pX9rOQlOVOTIy1Yoj/uYaBF6k6Mh6qqVOKBq4FQ75CB9
 8QxbMVox7pVcLu98vZ1pxAAiBRC7MrfjWKqhdeCunIsklHKfDexF7Bpfhw1HJCW+tMTi
 qOdTP2Vbqc01na6BWXBi5FY230HtKhjUzOSg7X0mOH4LkrVaXBUGMs7KIOhl1i6u0LFb
 fQRCoUis8Hh9GEzL1j5ll+6p9Jdv7mGspIAF2eBNXftJ3S7/4aL8ACwcwZgXMxq56jKw
 +vS30CIzbU1RJc2YEUUH1n2kSJGSr7qHfCz05Io0kx0zGrkpGjn8aR6FSYfT7Thj8j6y
 to+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737473534; x=1738078334;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+jk4e/F8Tu0rwwR4NSYttHuoKAaAOpNe188q48KN6xM=;
 b=qGOkhvwKeEqemdT3A1itRbdvnF0QbKad/kh+xEnCNuu0LTSthxfG3ev7VxCbH8z655
 DQJQc4VMXn1H7XMzPjv7erMV25731+rjS5ahTmbeqr1TUNhT+PaNFyr8wCHJ5G5sSmcE
 eGss7XDT3AinoZDYO3w7Z/83zECEqovpKFU9tBg0oZaegWkfS3XVNXxzZBYh1ynhH0VL
 xOQY2RKQUgvmOVP8gUXcXQvLCkSb7vb7xoGGvUP1Gxw2o8s2GQgOv1l7OuUCtXmJugia
 IlCyNalFvyRn3zdiWt4oIWe7U9P0PWOxKymnO9xQ9JzA4Ug9ngQZ71+D3x0+Ec5ZbLCV
 YjFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFQ3y7TwFMpqViIL3/BDefM25vXK2unB8EKu0kXIp5lCzR+FncMzholqy/8/bp1nAZUGSfSDTGRi/C@nongnu.org
X-Gm-Message-State: AOJu0Yx4lqr/0scAfa1MjHOcF/QKfkcjHt1m9+GLWK0yX12V59Jwx8rB
 IaAv+Cga9tBqMbBLFFL/8+iOiG1hXhflHQ+iEiGkn7tUvVs206hl
X-Gm-Gg: ASbGnctrKpaq+eYm3Z1agE1dQn/gEx4BxmjTjgp0ILiusMqyNF6pbjOtBEVnwV8O6FO
 gVYox5hQ7t5qWFNazvxDE2xDkj1QqUmpVdH3G/ckaVzK5jCVXF0PPHbLQalDzK3zzCtJzWnSFiU
 7sEcEg/Pjo6dzRgY5Zuf59mLn3ZDJLo7HMUWseTgr3Qf0c/5KWnFidChXcEdmgZa+VtDJAIT/jw
 wLLmz2BWICW57nNBFPf/wUJD9Rmfc+TuoMp8Vf9h3Xwh00kSwVrUQ08oMAP03YUMKzERHg4yMuG
 RUBz2Mkjs+G/vKdpBo9NJoKeFbLNs+mnuDrFxoDm
X-Google-Smtp-Source: AGHT+IEZDY7IT99PRcM3qkF17tohTXiV/QpJVGlVGv7yEGW8RrqrDk5f4bDaB5AAyHZA4xDAzWrDiw==
X-Received: by 2002:a05:6402:2547:b0:5d8:a46f:110b with SMTP id
 4fb4d7f45d1cf-5db7d318f9cmr16491752a12.17.1737473534079; 
 Tue, 21 Jan 2025 07:32:14 -0800 (PST)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db8942cad4sm6061113a12.60.2025.01.21.07.32.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 07:32:13 -0800 (PST)
Date: Tue, 21 Jan 2025 15:32:12 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Alberto Garcia <berto@igalia.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/2] hw/ipack: Remove legacy qemu_allocate_irqs() use
In-Reply-To: <a301444f-623e-4ba3-9868-b301f6e86a87@linaro.org>
References: <20250121084452.81941-1-philmd@linaro.org>
 <20250121084452.81941-3-philmd@linaro.org>
 <27522A5D-63E7-45B7-8A54-A19E453AB401@gmail.com>
 <a301444f-623e-4ba3-9868-b301f6e86a87@linaro.org>
Message-ID: <645CEBF7-DD35-494C-BAA1-6B3B8C5951AF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
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



Am 21=2E Januar 2025 10:04:43 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>On 21/1/25 10:24, Bernhard Beschow wrote:
>>=20
>>=20
>> Am 21=2E Januar 2025 08:44:52 UTC schrieb "Philippe Mathieu-Daud=C3=A9"=
 <philmd@linaro=2Eorg>:
>>> No need to dynamically allocate IRQ when we know before hands
>>> how many we'll use=2E Declare the 2 of them in IPackDevice state
>>> and initialize them in the DeviceRealize handler=2E
>>>=20
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>>> ---
>>> include/hw/ipack/ipack=2Eh | 7 ++-----
>>> hw/char/ipoctal232=2Ec     | 4 ++--
>>> hw/ipack/ipack=2Ec         | 7 +++----
>>> hw/ipack/tpci200=2Ec       | 6 +++---
>>> 4 files changed, 10 insertions(+), 14 deletions(-)
>>>=20
>>> diff --git a/include/hw/ipack/ipack=2Eh b/include/hw/ipack/ipack=2Eh
>>> index cbcdda509d3=2E=2E00f397fd020 100644
>>> --- a/include/hw/ipack/ipack=2Eh
>>> +++ b/include/hw/ipack/ipack=2Eh
>>> @@ -12,6 +12,7 @@
>>> #define QEMU_IPACK_H
>>>=20
>>> #include "hw/qdev-core=2Eh"
>>> +#include "hw/irq=2Eh"
>>> #include "qom/object=2Eh"
>>>=20
>>>=20
>>> @@ -19,10 +20,8 @@
>>> OBJECT_DECLARE_SIMPLE_TYPE(IPackBus, IPACK_BUS)
>>>=20
>>> struct IPackBus {
>>> -    /*< private >*/
>>>      BusState parent_obj;
>>>=20
>>> -    /* All fields are private */
>>>      uint8_t n_slots;
>>>      uint8_t free_slot;
>>>      qemu_irq_handler set_irq;
>>> @@ -58,13 +57,11 @@ struct IPackDeviceClass {
>>> };
>>>=20
>>> struct IPackDevice {
>>> -    /*< private >*/
>>>      DeviceState parent_obj;
>>> -    /*< public >*/
>>>=20
>>>      int32_t slot;
>>>      /* IRQ objects for the IndustryPack INT0# and INT1# */
>>> -    qemu_irq *irq;
>>> +    IRQState irq[2];
>>> };
>>>=20
>>> extern const VMStateDescription vmstate_ipack_device;
>>> diff --git a/hw/char/ipoctal232=2Ec b/hw/char/ipoctal232=2Ec
>>> index d1e5f6dad2e=2E=2Ea2879977fb3 100644
>>> --- a/hw/char/ipoctal232=2Ec
>>> +++ b/hw/char/ipoctal232=2Ec
>>> @@ -184,9 +184,9 @@ static void update_irq(IPOctalState *dev, unsigned=
 block)
>>>      unsigned intno =3D block / 2;
>>>=20
>>>      if ((blk0->isr & blk0->imr) || (blk1->isr & blk1->imr)) {
>>> -        qemu_irq_raise(idev->irq[intno]);
>>> +        qemu_irq_raise(&idev->irq[intno]);
>>>      } else {
>>> -        qemu_irq_lower(idev->irq[intno]);
>>> +        qemu_irq_lower(&idev->irq[intno]);
>>>      }
>>> }
>>>=20
>>> diff --git a/hw/ipack/ipack=2Ec b/hw/ipack/ipack=2Ec
>>> index ed75f791832=2E=2Eeeb48dd331c 100644
>>> --- a/hw/ipack/ipack=2Ec
>>> +++ b/hw/ipack/ipack=2Ec
>>> @@ -55,22 +55,21 @@ static void ipack_device_realize(DeviceState *dev,=
 Error **errp)
>>>      }
>>>      bus->free_slot =3D idev->slot + 1;
>>>=20
>>> -    idev->irq =3D qemu_allocate_irqs(bus->set_irq, idev, 2);
>>> +    for (int i =3D 0; i < ARRAY_SIZE(idev->irq); i++) {
>>> +        qemu_init_irq(&idev->irq[i], bus->set_irq, idev, i);
>>=20
>> I wonder if we eventually need a qemu_init_irqs() (note the plural) as =
we remove further uses of qemu_allocate_irqs()=2E
>
>Yeah I thought about it, but looking at other "Initialize pre-allocated
>QOM object in place", we don't have helpers for arrays=2E Usually because
>we can set properties, and array initializer doesn't scale then=2E

Fair enough=2E I'd call this "addressed"=2E

>
>For now IRQ doesn't have properties, so can do=2E
>
>> With the above addressed:
>> Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>
>
>Thanks!

