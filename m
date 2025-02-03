Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FCDC02196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 16:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tezVW-0006DC-RQ; Mon, 03 Feb 2025 11:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tezVQ-0006C9-PY
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:41:04 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tezVO-0007iq-Gq
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 11:41:04 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361c705434so34462425e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 08:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738600861; x=1739205661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=deP0TVM+Uq6KcTITWVx+Nfx0o4bPFnV/VRl8WWgRPGY=;
 b=GjRjcujm1Vv07EiivoKCPJsJouVrmrA8WjuWnDD/SzJEHCDEFZVbzr6TuTzMeZ53tN
 QEFzabeGiUDTe3cvl19DPSnm6DzVL0xwIdnB3mLwzVUL/K1BSYznZH/mv/0N9yQqB5K6
 nMCzxtxH6pXBzo46ELW0lD9sR83DrRktELyauJl+i+cBa2CJxij+KJZC9RfMey4aVoEG
 jdjdemcwatvlxV+y/S+//P56k7yn3fFzTVVDaX7b2IH7knjcQ7Nyr4a6NDPpG1nY5mKw
 Tce/CRvRhsIYW9jKhT7V9gty7Yrk67AC5rE/ZeFZAwNBq7csqX/y/YZ1mbE0eBB5hq0D
 M3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738600861; x=1739205661;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=deP0TVM+Uq6KcTITWVx+Nfx0o4bPFnV/VRl8WWgRPGY=;
 b=gCLWja+TxWCFXgPQ0BSOv0UKG+qs0QO8uqkVO+/CkgAKyx9yBpiFS46T6+MCbdI46U
 4PYfs/I1Gago+6b8eEDGeA2ZKqLJwuO1DIDQdeGyOM1dk2PDZoP/URPzY8Qw1rXJckvy
 q45u6sV5OV7Q99Z67h+Uk6jSl6rZkI/rxOG3/8Kg/nZQh6pOY6Di4X23Fhk+Iludb9Io
 joftn40N0Ee71q5Xt8SVnSwvyN8dJ7WfwXD47UShBiMF6Dg+AFie7Wa+X/EPdH1A0o2T
 YWoK4i2EMx//B4RwjZGM5ljWatfMKfH7B1N9zYbMlO1MGPH9lXCBRWuL8WCN1pYbDVZk
 Awxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL+Fg7anBUyAIAITT7/KunCNF86tlpEimbIhvb6bX+5z6X3IE0+34Ufn17v3niRLWdiZqS9VtrACjk@nongnu.org
X-Gm-Message-State: AOJu0YxHOvzwnr/rBEgVGPtP7IY+7HDKdezE/zvIw6Kf36dx0DykLBwo
 69vpzUTUaWB627eWJQsB0l1zWzUyhUlb8RgHOFzylhviMaZZHM8aE+dkF991bLE=
X-Gm-Gg: ASbGncvDXYY9AKva29SYmHtJDpKfYFDvEYD27HmHnZkLa1YtMI7RXpoTURJ7gSREs5o
 PF7xt80y/hZejY1SQDpKKfUAoZBSaz6GFmLB/7QtGACFsA1SMUtQ9JzTiYuVym7w8ei3mKOFffO
 omKpgYKl2iGHNItkcrN0/r1mDX5dqlClra1+oPeAESXopeyNwbhsmXrAyX9suv2b+0nSbAy5/lN
 LlRK8l5KmbNMPDZQMv6rW/msYn+wimNa8jHr0+epVZPA23f7swG6YKG628efEO+UoNwIqWaYpuY
 s23Bh6DHg/EVk2KkLsdTGR1dX+bPca6EFyFq633OrbcSUMVFYqF/7FExj/c=
X-Google-Smtp-Source: AGHT+IE9oISZOeGpRUOLk6H+4lhBkU1WS8Gqtvwq4xeg6wGwGqBQfWlE866HO5CUpLGTLKMJV4PbXg==
X-Received: by 2002:a05:600c:4e01:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-438dc34b179mr224375625e9.0.1738600860883; 
 Mon, 03 Feb 2025 08:41:00 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1cf2eesm13074468f8f.85.2025.02.03.08.40.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 08:41:00 -0800 (PST)
Message-ID: <1e8f3190-cf23-4eeb-a5fd-189f61a834b6@linaro.org>
Date: Mon, 3 Feb 2025 17:40:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/17] aspeed/soc: Add AST2700 support
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>
References: <20240604054438.3424349-1-jamin_lin@aspeedtech.com>
 <20240604054438.3424349-14-jamin_lin@aspeedtech.com>
 <ffafbec0-db25-478b-8eba-39162f9bce0d@linaro.org>
 <SI2PR06MB5041F84077718CE5A58B8F54FCF52@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <SI2PR06MB50417A6E45521504224146A9FCF52@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <SI2PR06MB50417A6E45521504224146A9FCF52@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 3/2/25 08:43, Jamin Lin wrote:
> Hi Philippe,
> 
>> From: Jamin Lin
>> Sent: Monday, February 3, 2025 3:29 PM
>> To: Philippe Mathieu-Daudé <philmd@linaro.org>; Cédric Le Goater
>> <clg@kaod.org>; Peter Maydell <peter.maydell@linaro.org>; Andrew Jeffery
>> <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>; Alistair
>> Francis <alistair@alistair23.me>; Cleber Rosa <crosa@redhat.com>; Wainer
>> dos Santos Moschetta <wainersm@redhat.com>; Beraldo Leal
>> <bleal@redhat.com>; open list:ASPEED BMCs <qemu-arm@nongnu.org>; open
>> list:All patches CC here <qemu-devel@nongnu.org>; Jinjie Ruan
>> <ruanjinjie@huawei.com>
>> Cc: Troy Lee <troy_lee@aspeedtech.com>; Yunlin Tang
>> <yunlin.tang@aspeedtech.com>
>> Subject: RE: [PATCH v5 13/17] aspeed/soc: Add AST2700 support
>>
>> Hi Philippe,
>>
>>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Sent: Thursday, January 30, 2025 11:14 PM
>>> To: Jamin Lin <jamin_lin@aspeedtech.com>; Cédric Le Goater
>>> <clg@kaod.org>; Peter Maydell <peter.maydell@linaro.org>; Andrew
>>> Jeffery <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>;
>>> Alistair Francis <alistair@alistair23.me>; Cleber Rosa
>>> <crosa@redhat.com>; Wainer dos Santos Moschetta
>> <wainersm@redhat.com>;
>>> Beraldo Leal <bleal@redhat.com>; open list:ASPEED BMCs
>>> <qemu-arm@nongnu.org>; open list:All patches CC here
>>> <qemu-devel@nongnu.org>; Jinjie Ruan <ruanjinjie@huawei.com>
>>> Cc: Troy Lee <troy_lee@aspeedtech.com>; Yunlin Tang
>>> <yunlin.tang@aspeedtech.com>
>>> Subject: Re: [PATCH v5 13/17] aspeed/soc: Add AST2700 support
>>>
>>> Hi Jamin,
>>>
>>> On 4/6/24 07:44, Jamin Lin wrote:
>>>> Initial definitions for a simple machine using an AST2700 SOC
>>>> (Cortex-a35
>>> CPU).
>>>>
>>>> AST2700 SOC and its interrupt controller are too complex to handle
>>>> in the common Aspeed SoC framework. We introduce a new ast2700 class
>>>> with instance_init and realize handlers.
>>>>
>>>> AST2700 is a 64 bits quad core cpus and support 8 watchdog.
>>>> Update maximum ASPEED_CPUS_NUM to 4 and ASPEED_WDTS_NUM to 8.
>>>> In addition, update AspeedSocState to support scuio, sli, sliio and intc.
>>>>
>>>> Add TYPE_ASPEED27X0_SOC machine type.
>>>>
>>>> The SDMC controller is unlocked at SPL stage.
>>>> At present, only supports to emulate booting start from u-boot stage.
>>>> Set SDMC controller unlocked by default.
>>>>
>>>> In INTC, each interrupt of INT 128 to INT 136 combines 32 interrupts.
>>>> It connect GICINT IRQ GPIO-OUTPUT pins to GIC device with irq 128 to 136.
>>>> And, if a device irq is 128 to 136, its irq GPIO-OUTPUT pin is
>>>> connected to GICINT or-gates instead of GIC device.
>>>>
>>>> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
>>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>>> ---
>>>>    hw/arm/aspeed_ast27x0.c     | 563
>>> ++++++++++++++++++++++++++++++++++++
>>>>    hw/arm/meson.build          |   1 +
>>>>    include/hw/arm/aspeed_soc.h |  28 +-
>>>>    3 files changed, 590 insertions(+), 2 deletions(-)
>>>>    create mode 100644 hw/arm/aspeed_ast27x0.c
>>>
>>>
>>>> +static bool aspeed_soc_ast2700_gic_realize(DeviceState *dev, Error
>>>> +**errp) {
>>>> +    Aspeed27x0SoCState *a = ASPEED27X0_SOC(dev);
>>>> +    AspeedSoCState *s = ASPEED_SOC(dev);
>>>> +    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>>>> +    SysBusDevice *gicbusdev;
>>>> +    DeviceState *gicdev;
>>>> +    QList *redist_region_count;
>>>> +    int i;
>>>> +
>>>> +    gicbusdev = SYS_BUS_DEVICE(&a->gic);
>>>> +    gicdev = DEVICE(&a->gic);
>>>> +    qdev_prop_set_uint32(gicdev, "revision", 3);
>>>> +    qdev_prop_set_uint32(gicdev, "num-cpu", sc->num_cpus);
>>>> +    qdev_prop_set_uint32(gicdev, "num-irq", AST2700_MAX_IRQ);
>>>> +
>>>> +    redist_region_count = qlist_new();
>>>> +    qlist_append_int(redist_region_count, sc->num_cpus);
>>>> +    qdev_prop_set_array(gicdev, "redist-region-count",
>>>> + redist_region_count);
>>>> +
>>>> +    if (!sysbus_realize(gicbusdev, errp)) {
>>>> +        return false;
>>>> +    }
>>>> +    sysbus_mmio_map(gicbusdev, 0, sc->memmap[ASPEED_GIC_DIST]);
>>>> +    sysbus_mmio_map(gicbusdev, 1,
>> sc->memmap[ASPEED_GIC_REDIST]);
>>>> +
>>>> +    for (i = 0; i < sc->num_cpus; i++) {
>>>> +        DeviceState *cpudev = DEVICE(&a->cpu[i]);
>>>> +        int NUM_IRQS = 256, ARCH_GIC_MAINT_IRQ = 9,
>>> VIRTUAL_PMU_IRQ = 7;
>>>> +        int ppibase = NUM_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
>>>> +
>>>> +        const int timer_irq[] = {
>>>> +            [GTIMER_PHYS] = 14,
>>>> +            [GTIMER_VIRT] = 11,
>>>> +            [GTIMER_HYP]  = 10,
>>>> +            [GTIMER_SEC]  = 13,
>>>> +        };
>>>> +        int j;
>>>> +
>>>> +        for (j = 0; j < ARRAY_SIZE(timer_irq); j++) {
>>>> +            qdev_connect_gpio_out(cpudev, j,
>>>> +                    qdev_get_gpio_in(gicdev, ppibase +
>> timer_irq[j]));
>>>> +        }
>>>> +
>>>> +        qemu_irq irq = qdev_get_gpio_in(gicdev,
>>>> +                                        ppibase +
>>> ARCH_GIC_MAINT_IRQ);
>>>> +        qdev_connect_gpio_out_named(cpudev,
>>> "gicv3-maintenance-interrupt",
>>>> +                                    0, irq);
>>>> +        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
>>>> +                qdev_get_gpio_in(gicdev, ppibase +
>>> VIRTUAL_PMU_IRQ));
>>>> +
>>>> +        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev,
>>> ARM_CPU_IRQ));
>>>> +        sysbus_connect_irq(gicbusdev, i + sc->num_cpus,
>>>> +                           qdev_get_gpio_in(cpudev,
>>> ARM_CPU_FIQ));
>>>> +        sysbus_connect_irq(gicbusdev, i + 2 * sc->num_cpus,
>>>> +                           qdev_get_gpio_in(cpudev,
>>> ARM_CPU_VIRQ));
>>>> +        sysbus_connect_irq(gicbusdev, i + 3 * sc->num_cpus,
>>>> +                           qdev_get_gpio_in(cpudev,
>>> ARM_CPU_VFIQ));
>>>
>>> Your patch was merged around the same time Jinjie added NMI support
>>> (see commit b36a32ead1 "target/arm: Add support for Non-maskable
>> Interrupt").
>>>
>>> Should we add them now?

> I referred to this line, https://github.com/qemu/qemu/blob/master/hw/arm/virt.c#L907, in QEMU's virt.c to add NMI support.
> 
> Are you suggesting adding the following lines to enable NMI support?
> It worked as well.
> 
> ```
> sysbus_connect_irq(gicbusdev, i + 4 * sc->num_cpus,
>                     qdev_get_gpio_in(cpudev, ARM_CPU_NMI));
> sysbus_connect_irq(gicbusdev, i + 5 * sc->num_cpus,
>                     qdev_get_gpio_in(cpudev, ARM_CPU_VINMI));
> ```

Yes, correct!

Thanks.


