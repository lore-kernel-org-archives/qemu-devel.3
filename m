Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480BFE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 09:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVocx-0004Ap-RL; Thu, 09 Jan 2025 04:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVocv-0004A5-FX; Thu, 09 Jan 2025 04:14:53 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVoct-00045g-HY; Thu, 09 Jan 2025 04:14:53 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d3d0205bd5so870469a12.3; 
 Thu, 09 Jan 2025 01:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736414088; x=1737018888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWRrfO4Kr9kWaN1B3fCkDoHvwrSbxB90G1KygsMhiqk=;
 b=A4jiYOmIZrWUpiF9L9NSW/sz24MELLXeWGL7lP0cveHXunCVC9vsrlaekK2CcimRu0
 qCt08+hUlSNRp4ief/lB1CS3a6Ug+uNSW55KeGvo/8lHRsckIsmgg8EUZtBystcIPqfB
 nBDTHirbQ0vadcOJADOn/2EymQdt6j6LfO/p0zSHd2+t3Tz+gOORk5bdhWAjLPELSapU
 lD07dffdg7WmEcLpXLx98AoVHaMOhxw07tvAygDB32JJ6nWqkaH9BBeYZgf8SlfznoI5
 /hOS/PzFpLht7m/JAKwbAeaVG9RDBGbfnqephtphSITP5lnWoDMkc55NVhyQPDCAlE3V
 Uu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736414088; x=1737018888;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWRrfO4Kr9kWaN1B3fCkDoHvwrSbxB90G1KygsMhiqk=;
 b=tZbTn1kH+2RyBsSFOKv3pSSIFafjL4tTQSmylQX1IkhUZKtiTndCawAW3ZJH2hZgId
 ns5XRdKL6GbA10ulx8YX+AxUMxokG5cEsK+QDLG2NV3bZz6DIh+oguxzZZfmJ8ebyiUw
 U13tLcD7xFa49bkQrmimi1G5iEFfOW7niZTUb93K5+bUg1ep5F0r5DaGzp87uoWHCThk
 VMECUWP8jLVfdsyEBdLBwdOHvyjg9ieWLKvTnQA8Rc3QwRLrQC+KJLYIcUNM/DEWufhL
 EawX2ToEaAY9/O/EhdxhMZXztINDVhsu8imn3koE4HaY83Yc/2ag7dYrhdZgJn3C1V2S
 /KuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHiSH4M6SSPk+x/qVesFqfW15CvDC8s+g/XSEHivw4fByaHa/f6lBN65cUuPnOqZEltdqB+dApJbeD2A==@nongnu.org,
 AJvYcCXPwRGu0BdOHaHn6ZeCkqgZBd10cgfJ89w69pB4Ftxmte6bdla2T5V5MTPgFyiynajCxO0CL76+Vw==@nongnu.org
X-Gm-Message-State: AOJu0YwFIwZkCNFj1qtMUu08IH6BujQs0ggi3IyAtXI9Asi30jzFleQ4
 QTV/CTll3WDyiq17quviW5NKy6L0qZqloQLODvgd9BclFzwK/JBe
X-Gm-Gg: ASbGncsKP4ZBQ1rp6JPbIKQWwh5FiNOlleXlAQ6AcfttUyZ1YqQ0JYzrrCZp3J1cR6N
 MM3wBQ1XaFSuv5lXotINWm3JR226I1HqVVyQ/jivP4v4XXzxR9oVybmzT3rQm3uiOK84BngFmgG
 5RfaK7EHPKkpQnUUy1H2A8e8n645pDoUpulMggUi/88H8HrkuYqWuuqaHN/sLZCRe2m9rSceCXq
 XVG2w/Y1WubM8FElD0pyom5EI9BfcD4rJgwrAzEdNsrKbczCptkcDqhd9Pqb5+/8+aW/x6AM68M
 lmKOt5YGiO7uWGRSrmSpRHT1tj/g
X-Google-Smtp-Source: AGHT+IGTEZOBxMyWikN489Ho8Iybu6l0yihaBYDGeUQ+hT8q8setDCttLLDLZTdLWBDmcvXyF5ZolQ==
X-Received: by 2002:a17:907:d9f:b0:aac:180e:b1d4 with SMTP id
 a640c23a62f3a-ab2ab6fe016mr507553366b.27.1736414088214; 
 Thu, 09 Jan 2025 01:14:48 -0800 (PST)
Received: from [127.0.0.1] (dynamic-002-242-081-030.2.242.pool.telefonica.de.
 [2.242.81.30]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95b29aesm49907266b.156.2025.01.09.01.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 01:14:47 -0800 (PST)
Date: Thu, 09 Jan 2025 09:14:46 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Guenter Roeck <linux@roeck-us.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 04/14] hw/core: Introduce TYPE_SHARED_IRQ
In-Reply-To: <8c12f28d-ee24-d4dc-f472-a6fe2e401dee@eik.bme.hu>
References: <20250108092538.11474-1-shentey@gmail.com>
 <20250108092538.11474-5-shentey@gmail.com>
 <8c12f28d-ee24-d4dc-f472-a6fe2e401dee@eik.bme.hu>
Message-ID: <29384082-B8A0-4FAD-914D-CFADDCD48755@gmail.com>
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



Am 8=2E Januar 2025 13:53:02 UTC schrieb BALATON Zoltan <balaton@eik=2Ebme=
=2Ehu>:
>On Wed, 8 Jan 2025, Bernhard Beschow wrote:
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> include/hw/core/shared-irq=2Eh | 39 ++++++++++++++++
>> hw/core/shared-irq=2Ec         | 88 +++++++++++++++++++++++++++++++++++=
+
>> hw/core/Kconfig              |  3 ++
>> hw/core/meson=2Ebuild          |  1 +
>> 4 files changed, 131 insertions(+)
>> create mode 100644 include/hw/core/shared-irq=2Eh
>> create mode 100644 hw/core/shared-irq=2Ec
>>=20
>> diff --git a/include/hw/core/shared-irq=2Eh b/include/hw/core/shared-ir=
q=2Eh
>> new file mode 100644
>> index 0000000000=2E=2E803c303dd0
>> --- /dev/null
>> +++ b/include/hw/core/shared-irq=2Eh
>> @@ -0,0 +1,39 @@
>> +/*
>> + * IRQ sharing device=2E
>> + *
>> + * Copyright (c) 2025 Bernhard Beschow <shentey@gmail=2Ecom>
>> + *
>> + * SPDX-License-Identifier: GPL-2=2E0-or-later
>> + */
>> +
>> +/*
>> + * This is a simple device which has one GPIO output line and multiple=
 GPIO
>> + * input lines=2E The output line is active if at least one of the inp=
ut lines is=2E
>
>How is this different from TYPE_OR_IRQ=2E Also or-irq=2Eh is in include/h=
w/or-irq=2Eh not in include/hw/core/ where split-irq=2Eh is

I missed exactly that=2E

> so maybe these could all be moved to one place for consistency? Or-irq a=
lso has a reset method, do you need one in this device?

TYPE_OR_IRQ should be used instead=2E The next iteration will use it and t=
his patch will be dropped=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> + *
>> + * QEMU interface:
>> + *  + N unnamed GPIO inputs: the input lines
>> + *  + one unnamed GPIO output: the output line
>> + *  + QOM property "num-lines": sets the number of input lines
>> + */
>> +#ifndef HW_SHARED_IRQ_H
>> +#define HW_SHARED_IRQ_H
>> +
>> +#include "hw/sysbus=2Eh"
>> +#include "qom/object=2Eh"
>> +
>> +#define TYPE_SHARED_IRQ "shared-irq"
>> +
>> +#define MAX_SHARED_LINES 16
>> +
>> +
>> +OBJECT_DECLARE_SIMPLE_TYPE(SharedIRQ, SHARED_IRQ)
>> +
>> +struct SharedIRQ {
>> +    DeviceState parent_obj;
>> +
>> +    qemu_irq out_irq;
>> +    uint16_t irq_states;
>> +    uint8_t num_lines;
>> +};
>> +
>> +#endif
>> diff --git a/hw/core/shared-irq=2Ec b/hw/core/shared-irq=2Ec
>> new file mode 100644
>> index 0000000000=2E=2Eb2a4ea4a66
>> --- /dev/null
>> +++ b/hw/core/shared-irq=2Ec
>> @@ -0,0 +1,88 @@
>> +/*
>> + * IRQ sharing device=2E
>> + *
>> + * Copyright (c) 2025 Bernhard Beschow <shentey@gmail=2Ecom>
>> + *
>> + * SPDX-License-Identifier: GPL-2=2E0-or-later
>> + */
>> +
>> +#include "qemu/osdep=2Eh"
>> +#include "hw/core/shared-irq=2Eh"
>> +#include "hw/irq=2Eh"
>> +#include "hw/qdev-properties=2Eh"
>> +#include "qapi/error=2Eh"
>> +#include "migration/vmstate=2Eh"
>> +
>> +static void shared_irq_handler(void *opaque, int n, int level)
>> +{
>> +    SharedIRQ *s =3D opaque;
>> +    uint16_t mask =3D BIT(n);
>> +
>> +    if (level) {
>> +        s->irq_states |=3D mask;
>> +    } else {
>> +        s->irq_states &=3D ~mask;
>> +    }
>> +
>> +    qemu_set_irq(s->out_irq, !!s->irq_states);
>> +}
>> +
>> +static void shared_irq_init(Object *obj)
>> +{
>> +    SharedIRQ *s =3D SHARED_IRQ(obj);
>> +
>> +    qdev_init_gpio_out(DEVICE(s), &s->out_irq, 1);
>> +}
>> +
>> +static void shared_irq_realize(DeviceState *dev, Error **errp)
>> +{
>> +    SharedIRQ *s =3D SHARED_IRQ(dev);
>> +
>> +    if (s->num_lines < 1 || s->num_lines >=3D MAX_SHARED_LINES) {
>> +        error_setg(errp,
>> +                   "IRQ shared number of lines %d must be between 1 an=
d %d",
>> +                   s->num_lines, MAX_SHARED_LINES);
>> +        return;
>> +    }
>> +
>> +    qdev_init_gpio_in(dev, shared_irq_handler, s->num_lines);
>> +}
>> +
>> +static const Property shared_irq_properties[] =3D {
>> +    DEFINE_PROP_UINT8("num-lines", SharedIRQ, num_lines, 1),
>> +};
>> +
>> +static const VMStateDescription shared_irq_vmstate =3D {
>> +    =2Ename =3D TYPE_SHARED_IRQ,
>> +    =2Eversion_id =3D 1,
>> +    =2Eminimum_version_id =3D 1,
>> +    =2Efields =3D (const VMStateField[]) {
>> +        VMSTATE_UINT16(irq_states, SharedIRQ),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> +
>> +static void shared_irq_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    /* No state to reset */
>> +    device_class_set_props(dc, shared_irq_properties);
>> +    dc->vmsd =3D &shared_irq_vmstate;
>> +    dc->realize =3D shared_irq_realize;
>> +
>> +    /* Reason: Needs to be wired up to work */
>> +    dc->user_creatable =3D false;
>> +}
>> +
>> +static const TypeInfo shared_irq_types[] =3D {
>> +    {
>> +       =2Ename =3D TYPE_SHARED_IRQ,
>> +       =2Eparent =3D TYPE_DEVICE,
>> +       =2Einstance_size =3D sizeof(SharedIRQ),
>> +       =2Einstance_init =3D shared_irq_init,
>> +       =2Eclass_init =3D shared_irq_class_init,
>> +    },
>> +};
>> +
>> +DEFINE_TYPES(shared_irq_types)
>> diff --git a/hw/core/Kconfig b/hw/core/Kconfig
>> index d1bdf765ee=2E=2Eddff977963 100644
>> --- a/hw/core/Kconfig
>> +++ b/hw/core/Kconfig
>> @@ -32,6 +32,9 @@ config PLATFORM_BUS
>> config REGISTER
>>     bool
>>=20
>> +config SHARED_IRQ
>> +    bool
>> +
>> config SPLIT_IRQ
>>     bool
>>=20
>> diff --git a/hw/core/meson=2Ebuild b/hw/core/meson=2Ebuild
>> index ce9dfa3f4b=2E=2E6b5bdc8ec7 100644
>> --- a/hw/core/meson=2Ebuild
>> +++ b/hw/core/meson=2Ebuild
>> @@ -21,6 +21,7 @@ system_ss=2Eadd(when: 'CONFIG_OR_IRQ', if_true: files=
('or-irq=2Ec'))
>> system_ss=2Eadd(when: 'CONFIG_PLATFORM_BUS', if_true: files('platform-b=
us=2Ec'))
>> system_ss=2Eadd(when: 'CONFIG_PTIMER', if_true: files('ptimer=2Ec'))
>> system_ss=2Eadd(when: 'CONFIG_REGISTER', if_true: files('register=2Ec')=
)
>> +system_ss=2Eadd(when: 'CONFIG_SHARED_IRQ', if_true: files('shared-irq=
=2Ec'))
>> system_ss=2Eadd(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq=2Ec=
'))
>> system_ss=2Eadd(when: 'CONFIG_XILINX_AXI', if_true: files('stream=2Ec')=
)
>> system_ss=2Eadd(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt=
=2Ec'))
>>=20

