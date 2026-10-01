Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F3FCA5FC4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 03:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC7Fp-00051K-Pq; Wed, 30 Sep 2026 23:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xC7Fo-000515-Sl
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 23:14:40 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xC7Fm-0006Yh-Sz
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 23:14:40 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 d9443c01a7336-2e2c19789f6so3944405ad.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 20:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1790824477; x=1791429277; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=W4pKwbZ1d4Hh8IuzsJJDtyop1pD0hZIltrVzpSp2FA8=;
 b=e+dN25929C+nY5IlnEd1MgQctrWQTyQk7jXCRM8gyghzfYT5R9GOwXNP1Wd7U1etAL
 U+JNPNrCSfGhEOsdFTmxO4H7j32485TW/z70yksjgpAVa8yFSZryygrVRYdosJ8rTu/3
 avOHjleG2QqgmEjHvhWNdaH6LthG50txB/GgVv8v9pFcn7LeQVaYCAb5mxd5Zxq4Qbv9
 7knt1pjmhl2fmM6+7lxqch72TK5SZJcicFDhPvpwMK4iU+6W1lRJNslHXU6v8FIPzUKS
 Ozthb1mPmIJmQXOuC0Z4kjYBy+piHtx1m5Aj3/pN9DEIFuhaXrXdUQwQ4GSTdf7BfzDz
 6ATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790824477; x=1791429277;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W4pKwbZ1d4Hh8IuzsJJDtyop1pD0hZIltrVzpSp2FA8=;
 b=OVySDGRHbPzMNq19cxyIJ5qFFOvfWrJVGjoYIUuSLTvEH2UOUg+lJ4OMB4m8vxXBl/
 rtnOuprO0E0j3iY6+UuylBdpqZyl1wOlyL0joA/9RFgxttrQPJaK9snWd+fSoDyvGDd9
 Up5Yo7ctyTJKouD7GW2kA4aOT1CmhACs+HlB3+Gg0BF8jJVlfHsNK3B8q/xOjUgLBBme
 J2b31ASEaweGnYnhjz1GHV7+IrFV8FHXMJn3JavhYB+p1QBB8VrMSbgbRS6/xzFdjTYF
 dewGrxUmomhd/t7fkv9/VCAM6TUm820TqRtTeVdkMVZhlCnPIVomruWujRen+1mQ0W80
 aEbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBykJNjjBr2e0bBGACpJ6zNhsfIkshqGw1a7Gi0xl/xb8qgVvNimZGkXtV/E62Icj0TgoTaVAmUu4p+h@nongnu.org
X-Gm-Message-State: AFq9FYIrpCfdonxLT7TsUarFkt9VRwIwiYe2xpdhqJuWQTFu2emckcHE
 3Cba4PMHBIxWeVBH7cKzkeWCJF/fFzfWxBviOFxLrkhj0vrHREZo+chOiRNIz75zgjo=
X-Gm-Gg: AYBFou281e/PMBJ7EGyC5cIDqZHbhNP/gI50FEi2QDfvfoA8woNvCvAPAQKjO6Krlu9
 /mXw1jdgyLHLL869XnR8Zs9Ql6A69akcNPfYy0BOYKuslJb8jOp9BPQPgjNJ8do121n8vUjzzk8
 29hJQj4YNuK/62idkA+lTh16EntMTbq8RjkzIN/zrz8wTPJ3rYA5nfFrSNkkNX4Rp17kzJ4S4kI
 wmm8LTPbiB81Pd4axZ8YFt3dTFJTbxDUfTywjcV5xKNhDRJdpWnPBb9sW0aoAteLCWXXQJmbj4V
 VxnGGMgUrgLwI0nZKMuU77lijaBHhtCtXaTgSQP1XA/KHuEMBBlXS11NEQOJ2g5F8b56r0uwnnm
 n7+KhVWz6ICqtI6UIE8Nx7qpVSxpbaDUvh2V8CnW9nxv25XaSu9RZyyhKk6JeP058Mh6tXllt59
 0d8DgvymAxx/8udAckMQy8CW+bTWsNB1EcaV4kXDMqBA9Zs90j8lBfCXSVQfTRaJ14WNuFLdGN3
 0kr3pMHWTjVW8udCIjnGcP68w==
X-Received: by 2002:a17:903:8cd:b0:2e2:d09f:d762 with SMTP id
 d9443c01a7336-2e2e49ef7d5mr45574375ad.3.1790824477343; 
 Wed, 30 Sep 2026 20:14:37 -0700 (PDT)
Received: from [172.16.1.33] ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e300b0800asm4381155ad.52.2026.09.30.20.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 20:14:36 -0700 (PDT)
Message-ID: <74c91fe7-c3cc-4cb8-af4c-d406851a3690@oss.tenstorrent.com>
Date: Thu, 1 Oct 2026 13:14:31 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/riscv/atlantis: Add machine property to select
 default uart
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Joel Stanley <joel@jms.id.au>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Michael Ellerman <mpe@kernel.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260929031644.1016354-1-portias@oss.tenstorrent.com>
 <20260929031644.1016354-5-portias@oss.tenstorrent.com>
 <706bc560-ee8d-4529-8ece-c849fa8a4602@oss.qualcomm.com>
Content-Language: en-US
From: Portia Stephens <portias@oss.tenstorrent.com>
In-Reply-To: <706bc560-ee8d-4529-8ece-c849fa8a4602@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=portias@tenstorrent.com; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


On 1/10/2026 12:48 AM, Daniel Henrique Barboza wrote:
>
>
> On 9/29/2026 12:16 AM, portias@oss.tenstorrent.com wrote:
>> From: Portia Stephens <portias@oss.tenstorrent.com>
>>
>> The Atlantis SoC has 5 UARTs. This adds a machine property to set
>> which uart is on the first serial interface. This is the same pattern
>> that is used by aspeed. The rest of the uart's will be added in
>> sequential order starting at serial interface 1.
>>
>> The default value is uart1 which means the Ascalon console will be on
>> serial interface 0 by default.
>>
>> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
>> ---
>
> The code LGTM but I wonder if we can make it simpler.
>
> IIUC there is a new ams->uart_chosen being added that holds the 
> numeric ID of
> the first UART.  Then there's a new string property called "console" 
> that needs
> to be on the format "uartN".  To do that there's a string parsing code in
> tt_atlantis_set_console() to guarantee it.  And there's code to 
> guarantee that
> N is also in an acceptable range.  Aside from parsing N the 'console' 
> string is
> not being used.
>
> I believe there's a good case here to make "console" an uint32_t 
> property instead,
> receiving N, getting rid of all the string parsing code.
>
> Also, there's a couple of instances of this:
>
>
> int uart_chosen = ams->uart_chosen ? ams->uart_chosen : TT_ATL_UART1;
>
>
> You can avoid this ternary by initializing ams->uart_chosen  = 
> TT_ATL_UART1; during
> tt_atlantis_soc_init().  Coupled with the parsing code from the 
> "console" property
> there is a guarantee that ams->uart_chosen will always be an 
> acceptable value.


uart_chosen is part of the machine class, so it would need to be 
initialized in the machine_init.  The machine property is set from user 
inputs prior to the machine_init being called.  Initializing uart_chosen 
in the machine_init will just overwrite the user input value. There is a 
object_property_set_default_uint() which allows setting a default value 
for a machine property , I have used this instead in v2 which has the 
same end result.


>
>
>
> Thanks,
> Daniel
>
>
>>   hw/riscv/tt_atlantis.c         | 77 ++++++++++++++++++++++++++++++----
>>   include/hw/riscv/tt_atlantis.h |  1 +
>>   2 files changed, 69 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
>> index d567ec1155..32ba755bbf 100644
>> --- a/hw/riscv/tt_atlantis.c
>> +++ b/hw/riscv/tt_atlantis.c
>> @@ -420,6 +420,29 @@ static void load_fdt(TTAtlantisState *ams)
>>       create_fdt_memory(ms->fdt, &ams->soc);
>>   }
>>   +static inline int tt_atlantis_uart_index(int uart_dev)
>> +{
>> +    return uart_dev - TT_ATL_UART0;
>> +}
>> +
>> +static void tt_atlantis_connect_serial_hds_to_uarts(TTAtlantisState 
>> *ams)
>> +{
>> +    TTAtlantisSoCState *s = &ams->soc;
>> +
>> +    int uart_chosen = ams->uart_chosen ? ams->uart_chosen : 
>> TT_ATL_UART1;
>> +    int uart_index = tt_atlantis_uart_index(uart_chosen);
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
>> +}
>> +
>> +
>>   static void tt_atlantis_machine_done(Notifier *n, void *data)
>>   {
>>       TTAtlantisState *ams = container_of(n, TTAtlantisState, 
>> machine_done);
>> @@ -482,11 +505,6 @@ static void tt_atlantis_machine_done(Notifier 
>> *n, void *data)
>>                                 fdt_load_addr);
>>   }
>>   -static inline int tt_atlantis_uart_index(int uart_dev)
>> -{
>> -    return uart_dev - TT_ATL_UART0;
>> -}
>> -
>>   static void tt_atlantis_soc_init(Object *obj)
>>   {
>>       TTAtlantisSoCState *s = TT_ATLANTIS_SOC(obj);
>> @@ -590,10 +608,6 @@ static void tt_atlantis_soc_realize(DeviceState 
>> *dev, Error **errp)
>>       memory_region_add_subregion(s->memory, 
>> s->memmap[TT_ATL_BOOTROM].base,
>>                                   &s->bootrom);
>>   -    /* UART1, the soc console (UART0 is for the boot 
>> microcontroller */
>> - 
>> qdev_prop_set_chr(DEVICE(&s->uart[tt_atlantis_uart_index(TT_ATL_UART1)]),
>> -                      "chardev", serial_hd(0));
>> -
>>       for (int i = 0; i < TT_ATL_NUM_UARTS; i++) {
>>           SysBusDevice *sbd = SYS_BUS_DEVICE(&s->uart[i]);
>>           if (!sysbus_realize(sbd, errp)) {
>> @@ -661,6 +675,10 @@ static void 
>> tt_atlantis_machine_init(MachineState *machine)
>>                                OBJECT(&ams->soc_memory), &error_abort);
>>       object_property_set_link(OBJECT(&ams->soc), "dram", 
>> OBJECT(machine->ram),
>>                                &error_abort);
>> +
>> +    /* Map serial interfaces to uart */
>> +    tt_atlantis_connect_serial_hds_to_uarts(ams);
>> +
>>       qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
>>         /* I2C peripherals: qemu specific */
>> @@ -678,6 +696,45 @@ static void 
>> tt_atlantis_machine_init(MachineState *machine)
>> qemu_add_machine_init_done_notifier(&ams->machine_done);
>>   }
>>   +static char *tt_atlantis_get_console(Object *obj, Error **errp)
>> +{
>> +    TTAtlantisState *ams = TT_ATLANTIS_MACHINE(obj);
>> +
>> +    /* Default to Ascalon console */
>> +    int uart_chosen = ams->uart_chosen ? ams->uart_chosen : 
>> TT_ATL_UART1;
>> +
>> +    return g_strdup_printf("uart%d", 
>> tt_atlantis_uart_index(uart_chosen));
>> +}
>> +
>> +static void tt_atlantis_set_console(Object *obj, const char *value, 
>> Error **errp)
>> +{
>> +    TTAtlantisState *ams = TT_ATLANTIS_MACHINE(obj);
>> +
>> +    int val;
>> +    int uart_first = tt_atlantis_uart_index(TT_ATL_UART0);
>> +    int uart_last = tt_atlantis_uart_index(TT_ATL_UART4);
>> +
>> +    if (sscanf(value, "uart%d", &val) != 1 || val < 0) {
>> +        error_setg(errp, "Bad value for \"uart\" property");
>> +        return;
>> +    }
>> +
>> +    if (val < uart_first || val > uart_last) {
>> +        error_setg(errp, "\"uart\" should be in range [%d - %d]",
>> +                   uart_first, uart_last);
>> +        return;
>> +    }
>> +    ams->uart_chosen = val + TT_ATL_UART0;
>> +}
>> +
>> +static void tt_atlantis_machine_class_props_init(ObjectClass *oc)
>> +{
>> +    object_class_property_add_str(oc, "console", 
>> tt_atlantis_get_console,
>> +                                  tt_atlantis_set_console);
>> +    object_class_property_set_description(oc, "console",
>> +                           "Change the default UART to \"uartX\"");
>> +}
>> +
>>   static void tt_atlantis_machine_class_init(ObjectClass *oc, const 
>> void *data)
>>   {
>>       MachineClass *mc = MACHINE_CLASS(oc);
>> @@ -691,6 +748,8 @@ static void 
>> tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
>>       mc->block_default_type = IF_VIRTIO;
>>       mc->no_cdrom = 1;
>>       mc->default_ram_id = "tt_atlantis.ram";
>> +
>> +    tt_atlantis_machine_class_props_init(oc);
>>   }
>>     static const TypeInfo tt_atlantis_types[] = {
>> diff --git a/include/hw/riscv/tt_atlantis.h 
>> b/include/hw/riscv/tt_atlantis.h
>> index b81b7c8abd..7bd46e9c9b 100644
>> --- a/include/hw/riscv/tt_atlantis.h
>> +++ b/include/hw/riscv/tt_atlantis.h
>> @@ -56,6 +56,7 @@ struct TTAtlantisState {
>>         MemoryRegion soc_memory;
>>       TTAtlantisSoCState soc;
>> +    uint32_t uart_chosen;
>>   };
>>     enum {
>

