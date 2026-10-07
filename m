Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F0BCA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEafo-0004nT-4d; Wed, 07 Oct 2026 19:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xEafG-0004ey-Tn
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:03:10 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xEafE-0007dd-JL
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:03:10 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3a4dda53724so108334a91.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 16:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1791414187; x=1792018987; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9fYONzD3/kwX2rcLKOS7A7NAZqcYfDrGPOw0VIyqbd4=;
 b=T0GPIVd7XwjP/2l+bQFhfM2yuBlFFYWweGc4iomcZu06iP+NDsxcuWf9CCm4p7WtV+
 J+raGNq+AeqRjkpDX6lcvx8y56nea1Y1ioUgrGNlRpR+y5L4o7lH3ChnNWSUuvHyKeFg
 lUnMrxZFpm7zWFQ1r0Vz4eVZLLPC/yFGcAAISfdqdKN+h4GfGkzOgEW+cav49zfOAP63
 HyBVvpUasiukepiDMEUBXn1DEkE0gD5kl39Z3P6wh2E5xvHwgmjdDbs41xFTWkMOOch7
 LRaaE+/L7YpMNHPzPVdbocNS7iFqgVd9py4VVYt8GBZgEfig0Su7z6LCoUvwWvdLKkdl
 mprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791414187; x=1792018987;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9fYONzD3/kwX2rcLKOS7A7NAZqcYfDrGPOw0VIyqbd4=;
 b=PbI1aE80dOmdYcz2ncaxUirR5TUfugFTveiPL0YWyzBp8uGPsh/R7y+ZHl0lmdfpe4
 6e3uR3NPX5rMdQF7tX90nk8M+ZZYV/Vsreq+FCZF6bWYUCnni2++Xdgcht/T2gT4c5GO
 qctGJFiTSme0otAsMwrsfkSx4BoXLxTIkwVaz4ERg/VyVlFkxQx2t9X77KH4BM6sF5Gt
 dNFA1gH+9XA4OWQuF+0vU365bbTKAZiueI0VSUcKR+vzgxDzNVQCoz/iP2qOGkltBQhG
 vR9iYkWpCS/Rh/RFl40RsvsVh0Y6NUU5wiKN8IZS/rJ6cO0g/KGtvdFgTe4mVz2gb/Zm
 lc0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcaNrwBTpx5tfaY9xZ83JkkbAxG+BcRM9RtCjfYgi2t4pdN59j/vFfpOoYjJhhE6tvhqIYMcLSlcCz@nongnu.org
X-Gm-Message-State: AFq9FYIOogxgYf/b4iaoGXdt1/FYK10Oddk7IXMxsV76+s93W7HUeGAW
 RzOZEhk9K11FH7g91dIDxl0QLphcYjTLHaUfo9Zwy2aSlRBMWzjZBY7dRTm7lHKlFFM=
X-Gm-Gg: AYBFou395bVlUuiEvIVWcnFdGp4MOcREql7OuK3UPCQqorQEQX9eGniFgCaUREdFcX9
 5nycdOULpR9JMbqVVt4jUAF8ycMRkInK75C+nF8Tw05SRd5DIkixBZTcvsVdWesAxShdyvN9yym
 B7sxhcEeeQNkuuSA2YT7TUSHbkhtlP9mdd+qUR8kkoVV5hvdaZOy/GGrQYpkQpN+mJvi/rXLkiq
 N7yefrLT8IDIDdNG6QigznQp1qUYWPhG6lMBFgdYRTaDJR8fQvPPY/W/JP2r4GPSHHuvkzW75bG
 i8QOzCZhOJn+wzF7RPtKAWeeVhwLcysj3lXTd0TbXhqi1TPhGb5fsD1BOd5+GFjkiLaSaKxx8FK
 1OGD1S/z3WiXa9V0nEgA9kil2OmWg0vifx2yRmZSP+Y57Y5cEeF+etkNK6wyKMdUCXwmbT5Ir51
 DvT2EsdiEgkS1vzPnFcVXou2nCz2RJ1eTQmXUFnrBuhZU08UrclXJt1gvuiF5eIlyZa9UCKVWTG
 0jWwNotV9Sydtc9VmwB+xAfXQ==
X-Received: by 2002:a17:90b:268a:b0:3a7:fef3:8561 with SMTP id
 98e67ed59e1d1-3aaab2945bcmr876980a91.5.1791414186459; 
 Wed, 07 Oct 2026 16:03:06 -0700 (PDT)
Received: from [172.16.1.33] ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a9ff817537sm1327932a91.8.2026.10.07.16.03.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 16:03:06 -0700 (PDT)
Message-ID: <79349810-29d7-43bb-a3f4-91c0b70e73df@oss.tenstorrent.com>
Date: Thu, 8 Oct 2026 09:02:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] hw/riscv/atlantis: Add machine property to select
 default uart
To: Alistair <alistair@alistair23.me>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Ellerman <mpe@kernel.org>, Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Joel Stanley <joel@jms.id.au>
References: <20261001233324.2636629-1-portias@oss.tenstorrent.com>
 <20261001233324.2636629-4-portias@oss.tenstorrent.com>
 <41b85b9ad64efab7ae41cdc4a7315ffe6903264b.camel@alistair23.me>
Content-Language: en-US
From: Portia Stephens <portias@oss.tenstorrent.com>
In-Reply-To: <41b85b9ad64efab7ae41cdc4a7315ffe6903264b.camel@alistair23.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=portias@tenstorrent.com; helo=mail-pj1-x102a.google.com
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


On 6/10/2026 11:35 PM, Alistair wrote:
> On Fri, 2026-10-02 at 09:33 +1000, Portia Stephens wrote:
>> The Atlantis SoC has 5 UARTs. This adds a machine property to set
>> which uart is on the first serial interface. This is the same pattern
>> that is used by aspeed. The rest of the uart's will be added in
>> sequential order starting at serial interface 1.
>>
>> The default value is uart1 which means the Ascalon console will be on
>> serial interface 0 by default.
>>
>> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
>> Reviewed-by: Daniel Henrique Barboza
>> <daniel.barboza@oss.qualcomm.com>
>> ---
>>   hw/riscv/tt_atlantis.c         | 77 ++++++++++++++++++++++++++++++--
>> --
>>   include/hw/riscv/tt_atlantis.h |  1 +
>>   2 files changed, 69 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
>> index 2342edce93..7a5e1ddcd1 100644
>> --- a/hw/riscv/tt_atlantis.c
>> +++ b/hw/riscv/tt_atlantis.c
>> @@ -12,6 +12,7 @@
>>   #include "qemu/error-report.h"
>>   #include "qemu/guest-random.h"
>>   #include "qemu/units.h"
>> +#include "qapi/visitor.h"
>>   
>>   #include "hw/core/boards.h"
>>   #include "hw/core/loader.h"
>> @@ -422,6 +423,26 @@ static void load_fdt(TTAtlantisState *ams)
>>       create_fdt_memory(ms->fdt, &ams->soc);
>>   }
>>   
>> +static inline int tt_atlantis_uart_index(int uart_dev)
>> +{
>> +    return uart_dev - TT_ATL_UART0;
>> +}
>> +
>> +static void tt_atlantis_connect_serial_hds_to_uarts(TTAtlantisState
>> *ams)
>> +{
>> +    TTAtlantisSoCState *s = &ams->soc;
>> +    int uart_index = tt_atlantis_uart_index(ams->uart_chosen);
>> +
>> +    qdev_prop_set_chr(DEVICE(&s->uart[uart_index]), "chardev",
>> serial_hd(0));
>> +
>> +    for (int i = 1, uart = 0; i < TT_ATL_NUM_UARTS; uart++) {
>> +        if (uart == uart_index) {
>> +            continue;
>> +        }
>> +        qdev_prop_set_chr(DEVICE(&s->uart[uart]), "chardev",
>> serial_hd(i++));
>> +    }
> I don't like this. We shouldn't dynamically change the command line API
> based on a property


Fair enough, can we just take the first 3 patches in the series and drop 
this one? That will add modeling for all the uarts but only expose uart1 
on command line.


We will expose the remaining uarts as features as added to the model 
that produce output that anyone would care to look at. For example, 
uart0 is the system controller's console, when the system controller is 
added to the model then we will expose uart0 on the command line. This 
will prevent us from locking into a command line API before we need to.



>
> Alistair
>
>> +}
>> +
>>   static void tt_atlantis_machine_done(Notifier *n, void *data)
>>   {
>>       TTAtlantisState *ams = container_of(n, TTAtlantisState,
>> machine_done);
>> @@ -484,11 +505,6 @@ static void tt_atlantis_machine_done(Notifier
>> *n, void *data)
>>                                 fdt_load_addr);
>>   }
>>   
>> -static inline int tt_atlantis_uart_index(int uart_dev)
>> -{
>> -    return uart_dev - TT_ATL_UART0;
>> -}
>> -
>>   static void tt_atlantis_soc_init(Object *obj)
>>   {
>>       TTAtlantisSoCState *s = TT_ATLANTIS_SOC(obj);
>> @@ -592,10 +608,6 @@ static void tt_atlantis_soc_realize(DeviceState
>> *dev, Error **errp)
>>       memory_region_add_subregion(s->memory, s-
>>> memmap[TT_ATL_BOOTROM].base,
>>                                   &s->bootrom);
>>   
>> -    /* UART1, the soc console (UART0 is for the boot microcontroller
>> */
>> -    qdev_prop_set_chr(DEVICE(&s-
>>> uart[tt_atlantis_uart_index(TT_ATL_UART1)]),
>> -                      "chardev", serial_hd(0));
>> -
>>       for (int i = 0; i < TT_ATL_NUM_UARTS; i++) {
>>           SysBusDevice *sbd = SYS_BUS_DEVICE(&s->uart[i]);
>>           if (!sysbus_realize(sbd, errp)) {
>> @@ -663,6 +675,10 @@ static void
>> tt_atlantis_machine_init(MachineState *machine)
>>                                OBJECT(&ams->soc_memory),
>> &error_abort);
>>       object_property_set_link(OBJECT(&ams->soc), "dram",
>> OBJECT(machine->ram),
>>                                &error_abort);
>> +
>> +    /* Map serial interfaces to uart */
>> +    tt_atlantis_connect_serial_hds_to_uarts(ams);
>> +
>>       qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
>>   
>>       /* I2C peripherals: qemu specific */
>> @@ -680,6 +696,47 @@ static void
>> tt_atlantis_machine_init(MachineState *machine)
>>       qemu_add_machine_init_done_notifier(&ams->machine_done);
>>   }
>>   
>> +static void tt_atlantis_get_console(Object *obj, Visitor *v, const
>> char *name,
>> +                                    void *opaque, Error **errp)
>> +{
>> +    TTAtlantisState *ams = TT_ATLANTIS_MACHINE(obj);
>> +    uint32_t uart_index = tt_atlantis_uart_index(ams->uart_chosen);
>> +
>> +    visit_type_uint32(v, name, &uart_index, errp);
>> +}
>> +
>> +static void tt_atlantis_set_console(Object *obj, Visitor *v, const
>> char *name,
>> +                                    void *opaque, Error **errp)
>> +{
>> +    TTAtlantisState *ams = TT_ATLANTIS_MACHINE(obj);
>> +    uint32_t value;
>> +
>> +    if (!visit_type_uint32(v, name, &value, errp)) {
>> +        return;
>> +    }
>> +
>> +    if (value >= TT_ATL_NUM_UARTS) {
>> +        error_setg(errp, "\"console\" should be in range [%d - %d]",
>> +                   0, TT_ATL_NUM_UARTS - 1);
>> +        return;
>> +    }
>> +    ams->uart_chosen = value + TT_ATL_UART0;
>> +}
>> +
>> +static void tt_atlantis_machine_class_props_init(ObjectClass *oc)
>> +{
>> +    ObjectProperty *console;
>> +
>> +    console = object_class_property_add(oc, "console", "uint32_t",
>> +                                        tt_atlantis_get_console,
>> +                                        tt_atlantis_set_console,
>> NULL, NULL);
>> +    object_class_property_set_description(oc, "console",
>> +            "Change the default UART index on -serial. Valid values
>> are 0 " \
>> +            "through 4");
>> +    /* Default to UART1, the Ascalon console */
>> +    object_property_set_default_uint(console, 1);
>> +}
>> +
>>   static void tt_atlantis_machine_class_init(ObjectClass *oc, const
>> void *data)
>>   {
>>       MachineClass *mc = MACHINE_CLASS(oc);
>> @@ -693,6 +750,8 @@ static void
>> tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
>>       mc->block_default_type = IF_VIRTIO;
>>       mc->no_cdrom = 1;
>>       mc->default_ram_id = "tt_atlantis.ram";
>> +
>> +    tt_atlantis_machine_class_props_init(oc);
>>   }
>>   
>>   static const TypeInfo tt_atlantis_types[] = {
>> diff --git a/include/hw/riscv/tt_atlantis.h
>> b/include/hw/riscv/tt_atlantis.h
>> index b81b7c8abd..7bd46e9c9b 100644
>> --- a/include/hw/riscv/tt_atlantis.h
>> +++ b/include/hw/riscv/tt_atlantis.h
>> @@ -56,6 +56,7 @@ struct TTAtlantisState {
>>   
>>       MemoryRegion soc_memory;
>>       TTAtlantisSoCState soc;
>> +    uint32_t uart_chosen;
>>   };
>>   
>>   enum {

