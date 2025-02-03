Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96651C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 22:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf55M-00074n-UT; Mon, 03 Feb 2025 17:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tf55C-00074P-1w; Mon, 03 Feb 2025 17:38:22 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tf55A-000411-1e; Mon, 03 Feb 2025 17:38:21 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so49616815e9.3; 
 Mon, 03 Feb 2025 14:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738622298; x=1739227098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IAKLNEpDR6VD1VyCrD9gEMLtDw9+ZUPBORuPtT24fN0=;
 b=Nj/XLXDFsHsIyZg9A+3r/2VDHfj0WtSUXCkE+7K4/0ss39b70oh//x1ZSg1m4FK9Mp
 yB0DmQBanOpI3vN4NeRyhSqTX+Eugpnm2GZLrHFONZl3knzsueYVtG0kCxfUPNHv9jsr
 C0ZrqucKu/1jzPvpdfqynMVgdNnBcrLleQMKCk1O3VugEN2lO7th0siA1CWhVW9V6ZWr
 G+J4CUH+l6mNChMBBSK3nXS3aVWI0xng+OgQvvdWa9YsboNucIFZ2bCy0perDzeNBs+B
 o5E37WlxNUvZEz9cbB9X1bCroZLnY9GsisrKkQFMR4DrT1tnezwRh+L115PIOWlNrWqr
 Fc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738622298; x=1739227098;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IAKLNEpDR6VD1VyCrD9gEMLtDw9+ZUPBORuPtT24fN0=;
 b=w5SHD6WzQVOzbknIQJ4sK4XipPeRHiOM17SNoPLwg8ogjROQvluQEXnneZ7EZBXJKS
 naIyy9nbx8FYxd05iuG4+hUgm/sPo5fve2JYkv7pxCxMqDEne8TYro0UaI79JaPK8DBi
 2z+iirgQYz+V3rLKqEmzx7BXqZwy705Fq1ZTe7UXerCnBHXjIMEykbPSLeHIPy9aRcZF
 Yr5/N50YaeEqRtAVqcoVYXmVzFGcWXELz06BxvyGfggf3PHHRkDNRHu3NjIoi9nrt1eb
 yD3pZegSKD7w3hUVVRSjJcCAo6Xyj4bACxPhEiUWaQYiYyg8eR/uUyfbkiIdhse2AzAm
 fpwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzjopM2dOecADCOeAwy6VJl/qJm6bh+8OsIgEs2tadfADkSfZdp0+hIVoxtcNrRdP4zg0JkmxOfyJhJA==@nongnu.org,
 AJvYcCX//RvYPni5piHJGLsXpaQtaGINzlI+5RNAhD3QgV1srrbwJqL/nNG4h4y46bG+CcsJFo+hYyLGUQ==@nongnu.org
X-Gm-Message-State: AOJu0Yw2ML5FxLyjYjvuB6AO8TNV34ATuEV62PAWitmmrkLFRNEgW+DW
 CfgjX1aFneeEiaSiql40oqQdmAZELsWHAbPmNbPF2li0ZxPZFfe/
X-Gm-Gg: ASbGncvxrv7ysNvhSj84Qvq7wqr7zJDdFhQ8fCXuC+aWZg5Cr7tf8ELNZIYwLXhowzF
 mzZEQsX+78egcE4LPLPDHSaqu2J75wqBHkdX5pvDIFSdBS1q/ue38/mpa91mB98lWs97LXjE/Cq
 GsnbqAfvHum/d41fHE04KxYwZJ4aBk3NiLDyaBjVkOu7c2EVp8TXLK3ownvEzSi501zh11ija2Q
 13v7OyEdUnvL47aVBIx9Dojh4hRSs477Urk5cFjR9wUWv3cE3/1H0Y6tm/5BrrvITRDDT+VZogs
 ShAbDFunJQT2r+ohTQctwBH0O7ziYot8fY+/pvP5KE6C5B9IiIHE3drHCBKckui619U+m33+WQ=
 =
X-Google-Smtp-Source: AGHT+IEQOHqQ02etw0Uh7zEBEhJr+Pz5YKRBOc7FW+pApMvhOR0LZM8R5ChN3iWQCxbLCxyLpg7rNg==
X-Received: by 2002:a05:600c:1c93:b0:435:9ed3:5698 with SMTP id
 5b1f17b1804b1-438dc41d1cbmr183241135e9.24.1738622297240; 
 Mon, 03 Feb 2025 14:38:17 -0800 (PST)
Received: from ?IPv6:::1?
 (p200300faaf00430048cf2359cf0b0456.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:48cf:2359:cf0b:456])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38da1ac7297sm2903156f8f.38.2025.02.03.14.38.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 14:38:16 -0800 (PST)
Date: Mon, 03 Feb 2025 22:38:13 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Dmitrii Sharikhin <d.sharikhin@yadro.com>
CC: Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 20/21] hw/i2c: Import TCA6416 emulation from Xilinx
In-Reply-To: <9d957453-5749-47c7-aad1-6977dac9aeea@linaro.org>
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-21-shentey@gmail.com>
 <df0ed59a-fe1b-44b0-a0cc-c62303294d7b@linaro.org>
 <32A9B14A-A0F9-4768-A28F-80702FA93960@gmail.com>
 <9d957453-5749-47c7-aad1-6977dac9aeea@linaro.org>
Message-ID: <2DFC7DBA-A73C-4BF2-8DD1-B52BCA4FFED2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
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



Am 2=2E Februar 2025 17:09:06 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>On 1/2/25 16:28, Bernhard Beschow wrote:
>>=20
>>=20
>> Am 30=2E Januar 2025 23:05:53 UTC schrieb "Philippe Mathieu-Daud=C3=A9"=
 <philmd@linaro=2Eorg>:
>>> Cc'ing AMD folks
>>>=20
>>> Hi Bernhard,
>>>=20
>>> TL;DR; can't you use the PCF8574 which is a more complete model of I/O
>>> expander? (See hw/gpio/pcf8574=2Ec)
>>=20
>> If it is software-compatible then I could use it=2E I'm modeling a real=
 board whose device tree I'd like to use unchanged, so I don't have much ch=
oice=2E The only reason I need it is because its absence clogs the i2c bus=
=2E
>
>No clue about compatibility=2E If you unfortunately need to add it,
>then please address my comments in the next version=2E

Sure, I'll link your and Zoltan's comments as todos in the next version=2E

Best regards,
Bernhard

>
>>=20
>> Best regards,
>> Bernhard
>>=20
>>>=20
>>> On 20/1/25 21:37, Bernhard Beschow wrote:
>>>> Xilinx QEMU implements a TCA6416 device model which may be useful for=
 the
>>>> broader QEMU community, so upstream it=2E In the Xilinx fork, the dev=
ice model
>>>> gets compiled whenever CONFIG_CADENCE is true, so have it maintained =
by the
>>>> "hw/*/cadence_*" maintainers=2E
>>>>=20
>>>> The code is based on Xilinx QEMU version xilinx_v2024=2E2 plus the fo=
llowing
>>>> modifications:
>>>> * Use OBJECT_DECLARE_SIMPLE_TYPE()
>>>> * Port from DPRINTF() to trace events
>>>> * Follow QEMU conventions for naming of state struct
>>>> * Rename type to not contain a ','
>>>> * Use DEFINE_TYPES() macro
>>>> * Implement under hw/gpio since device is i2c client and gpio provide=
r
>>>> * Have dedicated Kconfig switch
>>>>=20
>>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>>>=20
>>>> --
>>>> I have a use for TCA6416 emulation=2E Question: Are Xilinx Zynq maint=
ainers
>>>> willing to maintain this device model?
>>>> ---
>>>>    MAINTAINERS          |   1 +
>>>>    hw/gpio/tca6416=2Ec    | 122 +++++++++++++++++++++++++++++++++++++=
++++++
>>>>    hw/gpio/Kconfig      |   5 ++
>>>>    hw/gpio/meson=2Ebuild  |   1 +
>>>>    hw/gpio/trace-events |   4 ++
>>>>    5 files changed, 133 insertions(+)
>>>>    create mode 100644 hw/gpio/tca6416=2Ec
>>>>=20
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 7531d65429=2E=2E0cac9c90bc 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -1030,6 +1030,7 @@ S: Maintained
>>>>    F: hw/*/xilinx_*
>>>>    F: hw/*/cadence_*
>>>>    F: hw/misc/zynq_slcr=2Ec
>>>> +F: hw/gpio/tca6416=2Ec
>>>>    F: hw/adc/zynq-xadc=2Ec
>>>>    F: include/hw/misc/zynq_slcr=2Eh
>>>>    F: include/hw/adc/zynq-xadc=2Eh
>>>> diff --git a/hw/gpio/tca6416=2Ec b/hw/gpio/tca6416=2Ec
>>>> new file mode 100644
>>>> index 0000000000=2E=2E81ed7a654d
>>>> --- /dev/null
>>>> +++ b/hw/gpio/tca6416=2Ec
>>>> @@ -0,0 +1,122 @@
>>>> +/*
>>>> + * QEMU model of TCA6416 16-Bit I/O Expander
>>>=20
>>> Please add datasheet reference=2E
>>>=20
>>>> + *
>>>> + * Copyright (c) 2018 Xilinx Inc=2E
>>>> + *
>>>> + * Written by Sai Pavan Boddu <sai=2Epavan=2Eboddu@xilinx=2Ecom>
>>>> + *
>>>> + * Permission is hereby granted, free of charge, to any person obtai=
ning a copy
>>>> + * of this software and associated documentation files (the "Softwar=
e"), to deal
>>>> + * in the Software without restriction, including without limitation=
 the rights
>>>> + * to use, copy, modify, merge, publish, distribute, sublicense, and=
/or sell
>>>> + * copies of the Software, and to permit persons to whom the Softwar=
e is
>>>> + * furnished to do so, subject to the following conditions:
>>>> + *
>>>> + * The above copyright notice and this permission notice shall be in=
cluded in
>>>> + * all copies or substantial portions of the Software=2E
>>>> + *
>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, E=
XPRESS OR
>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTA=
BILITY,
>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVE=
NT SHALL
>>>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR OTHER
>>>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, A=
RISING FROM,
>>>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEA=
LINGS IN
>>>> + * THE SOFTWARE=2E
>>>=20
>>> Sai/Edgar/Francisco, should we update to AMD here? Remove or update th=
e
>>> email address? Also, can you Ack the replacement of this license by a
>>> SPDX tag?
>>>=20
>>>> + */
>>>> +#include "qemu/osdep=2Eh"
>>>> +#include "hw/i2c/i2c=2Eh"
>>>> +#include "trace=2Eh"
>>>> +
>>>> +#define TYPE_TCA6416 "tca6416"
>>>> +OBJECT_DECLARE_SIMPLE_TYPE(Tca6416State, TCA6416)
>>>> +
>>>> +#define IN_PORT0    0
>>>> +#define IN_PORT1    1
>>>> +#define OUT_PORT0   2
>>>> +#define OUT_PORT1   3
>>>> +#define POL_INV0    4
>>>> +#define POL_INV1    5
>>>> +#define CONF_PORT0  6
>>>> +#define CONF_PORT1  7
>>>=20
>>> enum up to here?
>>>=20
>>>> +#define RMAX (CONF_PORT1 + 1)
>>>> +
>>>> +enum tca6416_events {
>>>> +     ADDR_DONE,
>>>> +     ADDRESSING,
>>>> +};
>>>> +
>>>> +struct Tca6416State {
>>>> +     I2CSlave i2c;
>>>> +
>>>> +     uint8_t addr;
>>>> +     uint8_t state;
>>>> +     uint8_t regs[RMAX];
>>>> +};
>>>> +
>>>> +static uint8_t tca6416_read(I2CSlave *i2c)
>>>> +{
>>>> +    Tca6416State *s =3D TCA6416(i2c);
>>>> +    uint8_t ret;
>>>> +
>>>> +    ret =3D s->regs[s->addr];
>>>> +    trace_tca6416_read(ret);
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int tca6416_write(I2CSlave *i2c, uint8_t data)
>>>> +{
>>>> +    Tca6416State *s =3D TCA6416(i2c);
>>>> +
>>>> +    trace_tca6416_write(data);
>>>> +    if (s->state =3D=3D ADDRESSING) {
>>>> +        s->addr =3D data;
>>>=20
>>> I suppose HW masks here=2E
>>>=20
>>>           s->addr =3D data & 0xf;
>>>=20
>>>> +    } else {
>>>> +        s->regs[s->addr] =3D data;
>>>=20
>>> (otherwise this could overflow)=2E
>>>=20
>>> So this device isn't doing anything actually (I'd have
>>> expected 1 IRQ and 16 GPIO lines)=2E What is the point,
>>> at least in this state?
>>>=20
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static void tca6416_realize(DeviceState *dev, Error **errp)
>>>> +{
>>>> +    Tca6416State *s =3D TCA6416(dev);
>>>> +
>>>=20
>>> Missing:
>>>=20
>>>        s->regs[OUT_PORT0] =3D 0xff;
>>>        s->regs[OUT_PORT1] =3D 0xff;
>>>        s->regs[POL_INV0] =3D 0x00;
>>>        s->regs[POL_INV1] =3D 0x00;
>>>=20
>>>> +    s->regs[CONF_PORT0] =3D 0xFF;
>>>> +    s->regs[CONF_PORT1] =3D 0xFF;
>>>=20
>>> Style is 0xff=2E
>>>=20
>>> That said, this is not a REALIZE but RESET handler=2E
>>>=20
>>>> +}
>>>> +
>>>> +static int tca6416_event(I2CSlave *i2c, enum i2c_event event)
>>>> +{
>>>> +    Tca6416State *s =3D TCA6416(i2c);
>>>> +
>>>> +    switch (event) {
>>>> +    case I2C_START_SEND:
>>>> +        s->state =3D ADDRESSING;
>>>> +        break;
>>>> +    default:
>>>> +         s->state =3D ADDR_DONE;
>>>> +    };
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static void tca6416_class_init(ObjectClass *klass, void *data)
>>>> +{
>>>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>>>> +    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
>>>> +
>>>> +    dc->realize =3D tca6416_realize;
>>>=20
>>> (tca6416_realize is a reset handler)=2E
>>>=20
>>> Please complete:
>>>=20
>>>        dc->desc =3D "TCA6416 I/O Expander";
>>>        set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>>=20
>>> No migration state?
>>>=20
>>>> +    k->recv =3D tca6416_read;
>>>> +    k->send =3D tca6416_write;
>>>> +    k->event =3D tca6416_event;
>>>> +}> +
>>>> +static const TypeInfo tca6416_types[] =3D {
>>>> +    {
>>>> +        =2Ename =3D TYPE_TCA6416,
>>>> +        =2Eparent =3D TYPE_I2C_SLAVE,
>>>> +        =2Eclass_init =3D tca6416_class_init,
>>>> +        =2Einstance_size =3D sizeof(Tca6416State),
>>>> +    }
>>>> +};
>>>> +
>>>> +DEFINE_TYPES(tca6416_types)
>>>> diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
>>>> index c423e10f59=2E=2Ea240cf2de2 100644
>>>> --- a/hw/gpio/Kconfig
>>>> +++ b/hw/gpio/Kconfig
>>>> @@ -20,5 +20,10 @@ config PCF8574
>>>>        bool
>>>>        depends on I2C
>>>>    +config TCA6416
>>>> +    bool
>>>> +    depends on I2C
>>>> +    default y if I2C_DEVICES
>>>> +
>>>>    config ZAURUS_SCOOP
>>>>        bool
>>>> diff --git a/hw/gpio/meson=2Ebuild b/hw/gpio/meson=2Ebuild
>>>> index 74840619c0=2E=2Eb3ff7c7460 100644
>>>> --- a/hw/gpio/meson=2Ebuild
>>>> +++ b/hw/gpio/meson=2Ebuild
>>>> @@ -18,3 +18,4 @@ system_ss=2Eadd(when: 'CONFIG_STM32L4X5_SOC', if_tr=
ue: files('stm32l4x5_gpio=2Ec'))
>>>>    system_ss=2Eadd(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_=
gpio=2Ec'))
>>>>    system_ss=2Eadd(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive=
_gpio=2Ec'))
>>>>    system_ss=2Eadd(when: 'CONFIG_PCF8574', if_true: files('pcf8574=2E=
c'))
>>>> +system_ss=2Eadd(when: 'CONFIG_TCA6416', if_true: files('tca6416=2Ec'=
))
>>>> diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
>>>> index cea896b28f=2E=2E6724f2efb8 100644
>>>> --- a/hw/gpio/trace-events
>>>> +++ b/hw/gpio/trace-events
>>>> @@ -46,3 +46,7 @@ stm32l4x5_gpio_read(char *gpio, uint64_t addr) "GPI=
O%s addr: 0x%" PRIx64 " "
>>>>    stm32l4x5_gpio_write(char *gpio, uint64_t addr, uint64_t data) "GP=
IO%s addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
>>>>    stm32l4x5_gpio_update_idr(char *gpio, uint32_t old_idr, uint32_t n=
ew_idr) "GPIO%s from: 0x%x to: 0x%x"
>>>>    stm32l4x5_gpio_pins(char *gpio, uint16_t disconnected, uint16_t hi=
gh) "GPIO%s disconnected pins: 0x%x levels: 0x%x"
>>>> +
>>>> +# tca6416=2Ec
>>>> +tca6416_write(uint8_t value) "0x%02x"
>>>=20
>>> "wr 0x%02x"
>>>=20
>>>> +tca6416_read(uint8_t value) "0x%02x"
>>>=20
>>> "rd =2E=2E=2E"
>>>=20
>>> Regards,
>>>=20
>>> Phil=2E
>

