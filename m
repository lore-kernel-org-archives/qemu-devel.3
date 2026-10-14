Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FC9CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpam-0001OT-N6; Tue, 13 Oct 2026 23:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xGpaj-0001OD-Sm
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:23:45 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xGpah-00009z-Ku
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:23:45 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3ac6008c914so73203a91.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1791948220; x=1792553020; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oluE94ILmctJOhMYkVVCEvucPWdquNX70uNv7jnLdz0=;
 b=XNLsz5tTm4D8AgMst9Q2bdypcJMiAXsV2GZdGsC//tLh4wA1/FQPtw0ZL3Tg0QhLxi
 okp8w9KOWKo6+XqW7XdB70shuPFRQDKVOz2ugn0qoxwCWeYUm6jE5H7zke+/2ZYz7tnn
 2T+tNeDV7bL+tTEudqsHqgr+Q1hP2Yj2WwhtmlOfx1RDGRAZhguJGFnTmC3gENs4xX1/
 8WIs6Z7wtt5rrO4MjmUI3fdqAHNT4+eGe4yRpc5+BrB3GF8UZhmAQxDfOKT5w96Namtn
 ZjbMomjQmj3Y7UU/Ryrq9plJRPg/ozjXr4l7/l1WuANC2b5bFzWV8U9Xzz7i04oK8jVW
 m4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791948220; x=1792553020;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oluE94ILmctJOhMYkVVCEvucPWdquNX70uNv7jnLdz0=;
 b=aKfKoBTGwelsdVIw++WvWRnEma/KiOP7RQW2THqy80FN2pKE76itfVk65n9dh7utDl
 KygS9A6UbfQzvbakgdrIktp/mH25CeMaaV5H68hnB4trRoLgw1VK2BiW01Udb2ELEMFU
 AYuCYQuXEAdA/86KK1eI8FP8bv+TEcFqsnntT2bl5hpGL8O7SNhhTwWzX7R8Yc/nkeVo
 WSzj3Z/+p59LW554Wi4y/G94WtJNEM5SiZT0Phr8d2LHYXYz4rMJx6mUxIzacVMFqyp4
 wdtfnEUUgnY1X7/TQTDqJQTHs/nbpS/pJ46FvME89N1kucoP1ygoN1nbi2+X6WHVoJQO
 v4+A==
X-Forwarded-Encrypted: i=1;
 AKwUvByfA6FI0M5tghSBP7bdBcxdtndLMjwqpn4awpxMy9muVJBF4tH/FRWSC+VtkNLO4UtR7L3w0COkmKSD@nongnu.org
X-Gm-Message-State: AFq9FYIGIO95bv7WooJGHzJRu/CwVimbaB5x81rdonIm/BPrxBqVOjiZ
 rPJrrKBlwPTLK/rb/FXQuALIWy7HWEwueuz8dmYY/TOm17jM4yj4QhLao/QhLMMQ2EQ=
X-Gm-Gg: AYBFou0Aa0Pu/sO7oC3RS5n6QwuwNBZcGgSR+YgdfT8omzCvQGPEfkANz4s3pMfQabk
 DnaHg0J4IwREt7i2RVNkz3ol+ifD9ethAvwIO7TJBGRWoeke+t0WRzzfj462L/kUc1OWmsboy5w
 Ub0KlxsdSfM5UlJ3tp2R2YL2REFgvtmugMFyhaJ/ymPr7FRYGkC1ddRUi8XM61aBM1UFje5laLs
 XFD/PWfbgA5BcMUm+LvwTDRMHpebX0c/XTf3dJSZOJmEPPBq9mb+FnSEEzXznB+NQY++BCER9Gq
 5lLz9r9x5rcCittyoNbUnoXQgWJbt3Q7LChJfzHTn4mwn2eItyCC2x7dAjABRdabtP3nW1Caqmz
 p+bEKTEWBQ16h5jzJjdRAThYz/nKvfAuvLyDoQOQoOCdVtIGenmOmnVAh6mZKrgLJbKa+Nl/0GX
 HwecYwnZ0PzmkvUoAf3y7CxKtmkIfwfQ9zlFg9zgyj06I62ULMjoSXYBR+vSucc6RMaMyE/hyf2
 lNKampGyc8DYw94PAZJJUtpzIE=
X-Received: by 2002:a17:90b:3145:b0:3a6:f7be:fee6 with SMTP id
 98e67ed59e1d1-3ab3a346e9dmr19918039a91.1.1791948220534; 
 Tue, 13 Oct 2026 20:23:40 -0700 (PDT)
Received: from [172.16.1.33] ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac6006280dsm2271781a91.6.2026.10.13.20.23.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 20:23:40 -0700 (PDT)
Message-ID: <4cad38c5-c401-4a40-95d3-2cc4515b5bc3@oss.tenstorrent.com>
Date: Wed, 14 Oct 2026 13:23:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] hw/riscv/atlantis: Add machine property to select
 default uart
To: Alistair <alistair@alistair23.me>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Joel Stanley <joel@jms.id.au>
References: <20261001233324.2636629-1-portias@oss.tenstorrent.com>
 <20261001233324.2636629-4-portias@oss.tenstorrent.com>
 <41b85b9ad64efab7ae41cdc4a7315ffe6903264b.camel@alistair23.me>
 <79349810-29d7-43bb-a3f4-91c0b70e73df@oss.tenstorrent.com>
 <0a3ed698bfa98cd967788863d4cab1dd50f98b2f.camel@alistair23.me>
Content-Language: en-US
From: Portia Stephens <portias@oss.tenstorrent.com>
In-Reply-To: <0a3ed698bfa98cd967788863d4cab1dd50f98b2f.camel@alistair23.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=portias@tenstorrent.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 14/10/2026 12:40 PM, Alistair wrote:
> On Thu, 2026-10-08 at 09:02 +1000, Portia Stephens wrote:
>> On 6/10/2026 11:35 PM, Alistair wrote:
>>> On Fri, 2026-10-02 at 09:33 +1000, Portia Stephens wrote:
>>>> The Atlantis SoC has 5 UARTs. This adds a machine property to set
>>>> which uart is on the first serial interface. This is the same
>>>> pattern
>>>> that is used by aspeed. The rest of the uart's will be added in
>>>> sequential order starting at serial interface 1.
>>>>
>>>> The default value is uart1 which means the Ascalon console will
>>>> be on
>>>> serial interface 0 by default.
>>>>
>>>> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
>>>> Reviewed-by: Daniel Henrique Barboza
>>>> <daniel.barboza@oss.qualcomm.com>
>>>> ---
>>>>    hw/riscv/tt_atlantis.c         | 77
>>>> ++++++++++++++++++++++++++++++--
>>>> --
>>>>    include/hw/riscv/tt_atlantis.h |  1 +
>>>>    2 files changed, 69 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
>>>> index 2342edce93..7a5e1ddcd1 100644
>>>> --- a/hw/riscv/tt_atlantis.c
>>>> +++ b/hw/riscv/tt_atlantis.c
>>>> @@ -12,6 +12,7 @@
>>>>    #include "qemu/error-report.h"
>>>>    #include "qemu/guest-random.h"
>>>>    #include "qemu/units.h"
>>>> +#include "qapi/visitor.h"
>>>>    
>>>>    #include "hw/core/boards.h"
>>>>    #include "hw/core/loader.h"
>>>> @@ -422,6 +423,26 @@ static void load_fdt(TTAtlantisState *ams)
>>>>        create_fdt_memory(ms->fdt, &ams->soc);
>>>>    }
>>>>    
>>>> +static inline int tt_atlantis_uart_index(int uart_dev)
>>>> +{
>>>> +    return uart_dev - TT_ATL_UART0;
>>>> +}
>>>> +
>>>> +static void
>>>> tt_atlantis_connect_serial_hds_to_uarts(TTAtlantisState
>>>> *ams)
>>>> +{
>>>> +    TTAtlantisSoCState *s = &ams->soc;
>>>> +    int uart_index = tt_atlantis_uart_index(ams->uart_chosen);
>>>> +
>>>> +    qdev_prop_set_chr(DEVICE(&s->uart[uart_index]), "chardev",
>>>> serial_hd(0));
>>>> +
>>>> +    for (int i = 1, uart = 0; i < TT_ATL_NUM_UARTS; uart++) {
>>>> +        if (uart == uart_index) {
>>>> +            continue;
>>>> +        }
>>>> +        qdev_prop_set_chr(DEVICE(&s->uart[uart]), "chardev",
>>>> serial_hd(i++));
>>>> +    }
>>> I don't like this. We shouldn't dynamically change the command line
>>> API
>>> based on a property
>>
>> Fair enough, can we just take the first 3 patches in the series and
>> drop
>> this one? That will add modeling for all the uarts but only expose
>> uart1
>> on command line.
> This is path 3 though. Do you mean take the first 2 patches?


Yes but the documentation needs to be updated as well. I'll send a v4.


>
> I can do that if you want
>
> Alistair
>
>>
>> We will expose the remaining uarts as features as added to the model
>> that produce output that anyone would care to look at. For example,
>> uart0 is the system controller's console, when the system controller
>> is
>> added to the model then we will expose uart0 on the command line.
>> This
>> will prevent us from locking into a command line API before we need
>> to.
>>
>>
>>
>>> Alistair
>>>
>>>> +}
>>>> +
>>>>    static void tt_atlantis_machine_done(Notifier *n, void *data)
>>>>    {
>>>>        TTAtlantisState *ams = container_of(n, TTAtlantisState,
>>>> machine_done);
>>>> @@ -484,11 +505,6 @@ static void
>>>> tt_atlantis_machine_done(Notifier
>>>> *n, void *data)
>>>>                                  fdt_load_addr);
>>>>    }
>>>>    
>>>> -static inline int tt_atlantis_uart_index(int uart_dev)
>>>> -{
>>>> -    return uart_dev - TT_ATL_UART0;
>>>> -}
>>>> -
>>>>    static void tt_atlantis_soc_init(Object *obj)
>>>>    {
>>>>        TTAtlantisSoCState *s = TT_ATLANTIS_SOC(obj);
>>>> @@ -592,10 +608,6 @@ static void
>>>> tt_atlantis_soc_realize(DeviceState
>>>> *dev, Error **errp)
>>>>        memory_region_add_subregion(s->memory, s-
>>>>> memmap[TT_ATL_BOOTROM].base,
>>>>                                    &s->bootrom);
>>>>    
>>>> -    /* UART1, the soc console (UART0 is for the boot
>>>> microcontroller
>>>> */
>>>> -    qdev_prop_set_chr(DEVICE(&s-
>>>>> uart[tt_atlantis_uart_index(TT_ATL_UART1)]),
>>>> -                      "chardev", serial_hd(0));
>>>> -
>>>>        for (int i = 0; i < TT_ATL_NUM_UARTS; i++) {
>>>>            SysBusDevice *sbd = SYS_BUS_DEVICE(&s->uart[i]);
>>>>            if (!sysbus_realize(sbd, errp)) {
>>>> @@ -663,6 +675,10 @@ static void
>>>> tt_atlantis_machine_init(MachineState *machine)
>>>>                                 OBJECT(&ams->soc_memory),
>>>> &error_abort);
>>>>        object_property_set_link(OBJECT(&ams->soc), "dram",
>>>> OBJECT(machine->ram),
>>>>                                 &error_abort);
>>>> +
>>>> +    /* Map serial interfaces to uart */
>>>> +    tt_atlantis_connect_serial_hds_to_uarts(ams);
>>>> +
>>>>        qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
>>>>    
>>>>        /* I2C peripherals: qemu specific */
>>>> @@ -680,6 +696,47 @@ static void
>>>> tt_atlantis_machine_init(MachineState *machine)
>>>>        qemu_add_machine_init_done_notifier(&ams->machine_done);
>>>>    }
>>>>    
>>>> +static void tt_atlantis_get_console(Object *obj, Visitor *v,
>>>> const
>>>> char *name,
>>>> +                                    void *opaque, Error **errp)
>>>> +{
>>>> +    TTAtlantisState *ams = TT_ATLANTIS_MACHINE(obj);
>>>> +    uint32_t uart_index = tt_atlantis_uart_index(ams-
>>>>> uart_chosen);
>>>> +
>>>> +    visit_type_uint32(v, name, &uart_index, errp);
>>>> +}
>>>> +
>>>> +static void tt_atlantis_set_console(Object *obj, Visitor *v,
>>>> const
>>>> char *name,
>>>> +                                    void *opaque, Error **errp)
>>>> +{
>>>> +    TTAtlantisState *ams = TT_ATLANTIS_MACHINE(obj);
>>>> +    uint32_t value;
>>>> +
>>>> +    if (!visit_type_uint32(v, name, &value, errp)) {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    if (value >= TT_ATL_NUM_UARTS) {
>>>> +        error_setg(errp, "\"console\" should be in range [%d -
>>>> %d]",
>>>> +                   0, TT_ATL_NUM_UARTS - 1);
>>>> +        return;
>>>> +    }
>>>> +    ams->uart_chosen = value + TT_ATL_UART0;
>>>> +}
>>>> +
>>>> +static void tt_atlantis_machine_class_props_init(ObjectClass
>>>> *oc)
>>>> +{
>>>> +    ObjectProperty *console;
>>>> +
>>>> +    console = object_class_property_add(oc, "console",
>>>> "uint32_t",
>>>> +                                        tt_atlantis_get_console,
>>>> +                                        tt_atlantis_set_console,
>>>> NULL, NULL);
>>>> +    object_class_property_set_description(oc, "console",
>>>> +            "Change the default UART index on -serial. Valid
>>>> values
>>>> are 0 " \
>>>> +            "through 4");
>>>> +    /* Default to UART1, the Ascalon console */
>>>> +    object_property_set_default_uint(console, 1);
>>>> +}
>>>> +
>>>>    static void tt_atlantis_machine_class_init(ObjectClass *oc,
>>>> const
>>>> void *data)
>>>>    {
>>>>        MachineClass *mc = MACHINE_CLASS(oc);
>>>> @@ -693,6 +750,8 @@ static void
>>>> tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
>>>>        mc->block_default_type = IF_VIRTIO;
>>>>        mc->no_cdrom = 1;
>>>>        mc->default_ram_id = "tt_atlantis.ram";
>>>> +
>>>> +    tt_atlantis_machine_class_props_init(oc);
>>>>    }
>>>>    
>>>>    static const TypeInfo tt_atlantis_types[] = {
>>>> diff --git a/include/hw/riscv/tt_atlantis.h
>>>> b/include/hw/riscv/tt_atlantis.h
>>>> index b81b7c8abd..7bd46e9c9b 100644
>>>> --- a/include/hw/riscv/tt_atlantis.h
>>>> +++ b/include/hw/riscv/tt_atlantis.h
>>>> @@ -56,6 +56,7 @@ struct TTAtlantisState {
>>>>    
>>>>        MemoryRegion soc_memory;
>>>>        TTAtlantisSoCState soc;
>>>> +    uint32_t uart_chosen;
>>>>    };
>>>>    
>>>>    enum {

