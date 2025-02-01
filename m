Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886D1C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 15:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teFQ3-0002YG-Qh; Sat, 01 Feb 2025 10:28:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1teFQ2-0002XC-67; Sat, 01 Feb 2025 10:28:26 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1teFQ0-0000fm-82; Sat, 01 Feb 2025 10:28:25 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ab6f636d821so399186666b.1; 
 Sat, 01 Feb 2025 07:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738423702; x=1739028502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ecnRoOou/eC8mN1Aov2SrfquPydsBM9yvKAQmT4HQI=;
 b=gkK/wfH//c76+MfmjENYstcjrO6GDinoXFmEU3nA8+mh8GUWdUSNRncbxnCT8hG6oY
 3YzJnfGWfZ+v6G8sMYcv8/kPPsvRkYm+MBKSk3p0jIrRGk/17FblES1NO8hEIKlp1Cv1
 vHOg5DGgJifJEMv6Bv5NiqsIxU+kInAyhyAwX8ReVvgwo7Rev9gglOv27M0wyB82cwo7
 lqNPWSMX28V4CbBV065TD+eTuqu8ZwegLOHa8SIvFu7xbAiJRLtBsAq5rr9UZfsyumon
 SgQ/lCRYz4b2C46XHXdRCBhPxVjXkyT1zF9eu/JuBeBO1TUBdiaL47HoPa7otOZYLHWU
 V2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738423702; x=1739028502;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ecnRoOou/eC8mN1Aov2SrfquPydsBM9yvKAQmT4HQI=;
 b=GO/ufGa0WYELNJOYv9YHCNxVBbMD7ehPamXrkhfWU9kVZHCw3BmAD32M3XgI4qrKu5
 HvO6lrCgH543NOAE82fA8DiXDSXue56jf+l4MF0TuIzVqDFLwCvkX3ZaHUET27RGqsSA
 h6qVrQDK81qeb4scYqFU9FLaLyMckGRk7grCM8bff+vuWX+B8XTBmmC9OICnjRbtBeag
 p/3QQFhZvXAqaOmwr+YsBxLEXBXGUh2x5AvgajMhSBCkHITV+gTqU0YjgshtgumAbPsM
 4JEXwD579vPLWq4zYioiSise53Z5NX7tEa/hS7j2OshMkKpakyD4Ip7FMbPC9sCLHcHD
 8JNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsN8MuByVN7zdwjD+sbdtGe5Cs/PCDmqaXJH/X46NOGlMGxAZiXYwo6JoBbFbHS+KqqU7f+Zt78Q==@nongnu.org,
 AJvYcCXJxnAGHHSI9Eh8CByV04fi1yUAxvmYfH/AhWMXJQwrvdbyScSMbLH8uPig3EGHH0x0FqdamZ2tMKqHFw==@nongnu.org
X-Gm-Message-State: AOJu0YzGQyTeJzkuZrcMk3wvnACoZbX9m3Vh/Ir6xLhwYJeFMi4BgJda
 t3Mpk+e8ZY2/5W2MY395zCWxjNkGuL9CjeIj2bQcXNiWcZJwTAg9
X-Gm-Gg: ASbGnctdVxbnqDNdV91sXezb0GsqsCe0t1kKMkuqoFCsonocGhk6/6PBDWWLTS73njb
 cq+GlFBHVzYRZekunDMjIJYbb8OC5rZNQ80sXBkHFNrUf8+9lGyw9GhaQcpJdFwhI0Vjglmva1I
 5gBpb5xWcc6AUjxFClwb7H3/agylNN0/af7MM2OW/XgE4O77JEw7ZUEwQVgY8MG9wXJHWHrTRBD
 oV24rJ3InZaBE8CKntMHozifCw6WsXsPgklduMJl86beW5b+XtFYTDSww+8UG+ETOo6BVYQMnGU
 mrAhctQhCYiMsp5YQr7nfcsd3ovM+O7DVBmsS2OYgpc6XcjpnhjlGKogUSmqWy0QBAo=
X-Google-Smtp-Source: AGHT+IEX8sQACPf67jOYUla+Oh+Prq9vxT8EHmgnvZ6yn0cEiFZopNC7kFjtQYs1FRQSf6Dk4YMuVg==
X-Received: by 2002:a17:907:8688:b0:ab6:dd6c:e30c with SMTP id
 a640c23a62f3a-ab6dd6ce41cmr1506900466b.45.1738423701601; 
 Sat, 01 Feb 2025 07:28:21 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-183-083-158.77.183.pool.telefonica.de.
 [77.183.83.158]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47a7fd9sm454264866b.34.2025.02.01.07.28.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Feb 2025 07:28:21 -0800 (PST)
Date: Sat, 01 Feb 2025 15:28:20 +0000
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
In-Reply-To: <df0ed59a-fe1b-44b0-a0cc-c62303294d7b@linaro.org>
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-21-shentey@gmail.com>
 <df0ed59a-fe1b-44b0-a0cc-c62303294d7b@linaro.org>
Message-ID: <32A9B14A-A0F9-4768-A28F-80702FA93960@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
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



Am 30=2E Januar 2025 23:05:53 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>Cc'ing AMD folks
>
>Hi Bernhard,
>
>TL;DR; can't you use the PCF8574 which is a more complete model of I/O
>expander? (See hw/gpio/pcf8574=2Ec)

If it is software-compatible then I could use it=2E I'm modeling a real bo=
ard whose device tree I'd like to use unchanged, so I don't have much choic=
e=2E The only reason I need it is because its absence clogs the i2c bus=2E

Best regards,
Bernhard

>
>On 20/1/25 21:37, Bernhard Beschow wrote:
>> Xilinx QEMU implements a TCA6416 device model which may be useful for t=
he
>> broader QEMU community, so upstream it=2E In the Xilinx fork, the devic=
e model
>> gets compiled whenever CONFIG_CADENCE is true, so have it maintained by=
 the
>> "hw/*/cadence_*" maintainers=2E
>>=20
>> The code is based on Xilinx QEMU version xilinx_v2024=2E2 plus the foll=
owing
>> modifications:
>> * Use OBJECT_DECLARE_SIMPLE_TYPE()
>> * Port from DPRINTF() to trace events
>> * Follow QEMU conventions for naming of state struct
>> * Rename type to not contain a ','
>> * Use DEFINE_TYPES() macro
>> * Implement under hw/gpio since device is i2c client and gpio provider
>> * Have dedicated Kconfig switch
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>=20
>> --
>> I have a use for TCA6416 emulation=2E Question: Are Xilinx Zynq maintai=
ners
>> willing to maintain this device model?
>> ---
>>   MAINTAINERS          |   1 +
>>   hw/gpio/tca6416=2Ec    | 122 ++++++++++++++++++++++++++++++++++++++++=
+++
>>   hw/gpio/Kconfig      |   5 ++
>>   hw/gpio/meson=2Ebuild  |   1 +
>>   hw/gpio/trace-events |   4 ++
>>   5 files changed, 133 insertions(+)
>>   create mode 100644 hw/gpio/tca6416=2Ec
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7531d65429=2E=2E0cac9c90bc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1030,6 +1030,7 @@ S: Maintained
>>   F: hw/*/xilinx_*
>>   F: hw/*/cadence_*
>>   F: hw/misc/zynq_slcr=2Ec
>> +F: hw/gpio/tca6416=2Ec
>>   F: hw/adc/zynq-xadc=2Ec
>>   F: include/hw/misc/zynq_slcr=2Eh
>>   F: include/hw/adc/zynq-xadc=2Eh
>> diff --git a/hw/gpio/tca6416=2Ec b/hw/gpio/tca6416=2Ec
>> new file mode 100644
>> index 0000000000=2E=2E81ed7a654d
>> --- /dev/null
>> +++ b/hw/gpio/tca6416=2Ec
>> @@ -0,0 +1,122 @@
>> +/*
>> + * QEMU model of TCA6416 16-Bit I/O Expander
>
>Please add datasheet reference=2E
>
>> + *
>> + * Copyright (c) 2018 Xilinx Inc=2E
>> + *
>> + * Written by Sai Pavan Boddu <sai=2Epavan=2Eboddu@xilinx=2Ecom>
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
>> + * of this software and associated documentation files (the "Software"=
), to deal
>> + * in the Software without restriction, including without limitation t=
he rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
>> + * copies of the Software, and to permit persons to whom the Software =
is
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be incl=
uded in
>> + * all copies or substantial portions of the Software=2E
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=2E IN NO EVENT=
 SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
>> + * THE SOFTWARE=2E
>
>Sai/Edgar/Francisco, should we update to AMD here? Remove or update the
>email address? Also, can you Ack the replacement of this license by a
>SPDX tag?
>
>> + */
>> +#include "qemu/osdep=2Eh"
>> +#include "hw/i2c/i2c=2Eh"
>> +#include "trace=2Eh"
>> +
>> +#define TYPE_TCA6416 "tca6416"
>> +OBJECT_DECLARE_SIMPLE_TYPE(Tca6416State, TCA6416)
>> +
>> +#define IN_PORT0    0
>> +#define IN_PORT1    1
>> +#define OUT_PORT0   2
>> +#define OUT_PORT1   3
>> +#define POL_INV0    4
>> +#define POL_INV1    5
>> +#define CONF_PORT0  6
>> +#define CONF_PORT1  7
>
>enum up to here?
>
>> +#define RMAX (CONF_PORT1 + 1)
>> +
>> +enum tca6416_events {
>> +     ADDR_DONE,
>> +     ADDRESSING,
>> +};
>> +
>> +struct Tca6416State {
>> +     I2CSlave i2c;
>> +
>> +     uint8_t addr;
>> +     uint8_t state;
>> +     uint8_t regs[RMAX];
>> +};
>> +
>> +static uint8_t tca6416_read(I2CSlave *i2c)
>> +{
>> +    Tca6416State *s =3D TCA6416(i2c);
>> +    uint8_t ret;
>> +
>> +    ret =3D s->regs[s->addr];
>> +    trace_tca6416_read(ret);
>> +    return ret;
>> +}
>> +
>> +static int tca6416_write(I2CSlave *i2c, uint8_t data)
>> +{
>> +    Tca6416State *s =3D TCA6416(i2c);
>> +
>> +    trace_tca6416_write(data);
>> +    if (s->state =3D=3D ADDRESSING) {
>> +        s->addr =3D data;
>
>I suppose HW masks here=2E
>
>          s->addr =3D data & 0xf;
>
>> +    } else {
>> +        s->regs[s->addr] =3D data;
>
>(otherwise this could overflow)=2E
>
>So this device isn't doing anything actually (I'd have
>expected 1 IRQ and 16 GPIO lines)=2E What is the point,
>at least in this state?
>
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void tca6416_realize(DeviceState *dev, Error **errp)
>> +{
>> +    Tca6416State *s =3D TCA6416(dev);
>> +
>
>Missing:
>
>       s->regs[OUT_PORT0] =3D 0xff;
>       s->regs[OUT_PORT1] =3D 0xff;
>       s->regs[POL_INV0] =3D 0x00;
>       s->regs[POL_INV1] =3D 0x00;
>
>> +    s->regs[CONF_PORT0] =3D 0xFF;
>> +    s->regs[CONF_PORT1] =3D 0xFF;
>
>Style is 0xff=2E
>
>That said, this is not a REALIZE but RESET handler=2E
>
>> +}
>> +
>> +static int tca6416_event(I2CSlave *i2c, enum i2c_event event)
>> +{
>> +    Tca6416State *s =3D TCA6416(i2c);
>> +
>> +    switch (event) {
>> +    case I2C_START_SEND:
>> +        s->state =3D ADDRESSING;
>> +        break;
>> +    default:
>> +         s->state =3D ADDR_DONE;
>> +    };
>> +    return 0;
>> +}
>> +
>> +static void tca6416_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
>> +
>> +    dc->realize =3D tca6416_realize;
>
>(tca6416_realize is a reset handler)=2E
>
>Please complete:
>
>       dc->desc =3D "TCA6416 I/O Expander";
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>
>No migration state?
>
>> +    k->recv =3D tca6416_read;
>> +    k->send =3D tca6416_write;
>> +    k->event =3D tca6416_event;
>> +}> +
>> +static const TypeInfo tca6416_types[] =3D {
>> +    {
>> +        =2Ename =3D TYPE_TCA6416,
>> +        =2Eparent =3D TYPE_I2C_SLAVE,
>> +        =2Eclass_init =3D tca6416_class_init,
>> +        =2Einstance_size =3D sizeof(Tca6416State),
>> +    }
>> +};
>> +
>> +DEFINE_TYPES(tca6416_types)
>> diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
>> index c423e10f59=2E=2Ea240cf2de2 100644
>> --- a/hw/gpio/Kconfig
>> +++ b/hw/gpio/Kconfig
>> @@ -20,5 +20,10 @@ config PCF8574
>>       bool
>>       depends on I2C
>>   +config TCA6416
>> +    bool
>> +    depends on I2C
>> +    default y if I2C_DEVICES
>> +
>>   config ZAURUS_SCOOP
>>       bool
>> diff --git a/hw/gpio/meson=2Ebuild b/hw/gpio/meson=2Ebuild
>> index 74840619c0=2E=2Eb3ff7c7460 100644
>> --- a/hw/gpio/meson=2Ebuild
>> +++ b/hw/gpio/meson=2Ebuild
>> @@ -18,3 +18,4 @@ system_ss=2Eadd(when: 'CONFIG_STM32L4X5_SOC', if_true=
: files('stm32l4x5_gpio=2Ec'))
>>   system_ss=2Eadd(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpi=
o=2Ec'))
>>   system_ss=2Eadd(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gp=
io=2Ec'))
>>   system_ss=2Eadd(when: 'CONFIG_PCF8574', if_true: files('pcf8574=2Ec')=
)
>> +system_ss=2Eadd(when: 'CONFIG_TCA6416', if_true: files('tca6416=2Ec'))
>> diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
>> index cea896b28f=2E=2E6724f2efb8 100644
>> --- a/hw/gpio/trace-events
>> +++ b/hw/gpio/trace-events
>> @@ -46,3 +46,7 @@ stm32l4x5_gpio_read(char *gpio, uint64_t addr) "GPIO%=
s addr: 0x%" PRIx64 " "
>>   stm32l4x5_gpio_write(char *gpio, uint64_t addr, uint64_t data) "GPIO%=
s addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
>>   stm32l4x5_gpio_update_idr(char *gpio, uint32_t old_idr, uint32_t new_=
idr) "GPIO%s from: 0x%x to: 0x%x"
>>   stm32l4x5_gpio_pins(char *gpio, uint16_t disconnected, uint16_t high)=
 "GPIO%s disconnected pins: 0x%x levels: 0x%x"
>> +
>> +# tca6416=2Ec
>> +tca6416_write(uint8_t value) "0x%02x"
>
>"wr 0x%02x"
>
>> +tca6416_read(uint8_t value) "0x%02x"
>
>"rd =2E=2E=2E"
>
>Regards,
>
>Phil=2E

