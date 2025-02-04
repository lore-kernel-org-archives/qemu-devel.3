Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC46EC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQc2-0004Ky-Js; Tue, 04 Feb 2025 16:37:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfQc1-0004Kc-D7
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:37:41 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfQbz-0003gn-KS
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:37:41 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so5093689f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738705058; x=1739309858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b+/20tDTP8NTJnxJop7bS90VmUnyU5FskD/ld8HnQGc=;
 b=oDonpOsR4rTTD9mBIr9G0mP7pM2FMzd+7osGedtaaZb3hEwwzpXYps26AB5YxBCx3Y
 2aYs9+Mswfq0C5cypZPJERYhU7p3ULa4bbiIgq8L1qvt0+oEmBN14yalN+5pwdPmzwn0
 Lwa1jr4ncEKpRznabCzOc6oIXGWLyPXSjlmJJIcqdTWThwMMtiT/N67zUctHqym1QJ14
 p4FOTUugYDdVEsuO7zL8KikrGaVSC4ixHmSlP6P7Qxs9WrN1TL+Jy7RLVA0fkw94honY
 8l5cQQGT1IJaImqttqk85xe3kh5UnmVcim/WLolIY8GTQ1G6OAxaaGyUV6HBh/gfyEMh
 //HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738705058; x=1739309858;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b+/20tDTP8NTJnxJop7bS90VmUnyU5FskD/ld8HnQGc=;
 b=BKxvEIxD4n6P4R+CmShfKB3weOheZFNdqlp2rvbI4K5fZlh7QzaUMNBqtsyeoks6Na
 Uta0DE9IoMCNkHsgPTWjbAehRGL995yw/iL6SKcEHdKwh78R4QzBOYj8iWaS8hmnEwVZ
 lPv0gw+px4W7ibrbLKQ7Z1U2ybQ2yVOGEVzXS0xJ3F1gq/N3MKYAiWVNm8yY4JHfuOhA
 QOxdsoJGUnH60opdC7BNO7xsNlBELRPXoEugsoZuaMwl7H8II+3KVIb53lMBF7FKJKfY
 4E2Hk0xhLu86RKjg6RZZXHYrd87CiNJVD0MzCz9/DR8qDg1feBmSmDkxORgvizs9ka+S
 cakw==
X-Gm-Message-State: AOJu0Yy+XIywiQcPqnmW1DWJH4vBgiTeuPpYQf+toDFXLS88hWSunjvr
 NFD0vrQexyxGr5Q7wxA954VeFUqRhYLOigoNhT3UlSpK7Xv5Xi45Xvd1fLyLb/k=
X-Gm-Gg: ASbGncuFjyDAt5F4fbPxDHueSJUVM3CVRcb1asNBRhE/s4L/JSgmr2UmjjKEh7nM6YX
 xQeUMoFCDLJ7Ul1ERv1QEiQav4Km/1SNXgp4laa5qi//TrZLWV8AgQBlr9cDQuynCdRGDtA0ee4
 QVYIOl9hynjw/XWOiWoJp8mH+3AFUbrH00cQUgG9w5fT42NuHIdSGn+MKY8Sya99egcGuU6HpCW
 emp83ce17pzZytzJWKuFKkRimASLawHCu5FWRN3zfFp9j+y52Nf5I8smQgfDuOFAv7WXRldu8Pm
 BVonOHgttN+VfiSPhnhHbM8BRwuhi1TeSvPtJg6A+aVUts9WEl033vV87pQ=
X-Google-Smtp-Source: AGHT+IHzPc2WUX8ng3Fg8K3FvRTmG8xXpsTYQ4elDHvByFMB/F4sjZi7IPodrvWaLOc9GVZCTre44w==
X-Received: by 2002:a05:6000:402b:b0:38b:eb7b:316 with SMTP id
 ffacd0b85a97d-38db4947bc9mr212668f8f.47.1738705057617; 
 Tue, 04 Feb 2025 13:37:37 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1016easm16869349f8f.24.2025.02.04.13.37.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 13:37:37 -0800 (PST)
Message-ID: <22242a9b-97b9-49c6-b0f7-57697184e5b8@linaro.org>
Date: Tue, 4 Feb 2025 22:37:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/pc: Fix crash that occurs when introspecting
 TYPE_PC_MACHINE machines
To: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250117192106.471029-1-thuth@redhat.com>
 <7e719e2d-1f89-4f67-b519-3279f18bccd6@redhat.com>
 <20250129150352-mutt-send-email-mst@kernel.org>
 <023ea75f-855d-4e95-82e4-05015554a0c6@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <023ea75f-855d-4e95-82e4-05015554a0c6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 4/2/25 09:57, Thomas Huth wrote:
> On 29/01/2025 21.04, Michael S. Tsirkin wrote:
>> On Wed, Jan 29, 2025 at 08:00:40AM +0100, Thomas Huth wrote:
>>> On 17/01/2025 20.21, Thomas Huth wrote:
>>>> QEMU currently crashes when you try to inspect the machines based on
>>>> TYPE_PC_MACHINE for their properties:
>>>>
>>>>    $ echo '{ "execute": "qmp_capabilities" }
>>>>            { "execute": "qom-list-properties","arguments":
>>>>                         { "typename": "pc-q35-10.0-machine"}}' \
>>>>      | ./qemu-system-x86_64 -M pc -qmp stdio
>>>>    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 9},
>>>>     "package": "v9.2.0-1070-g87e115c122-dirty"}, "capabilities": 
>>>> ["oob"]}}
>>>>    {"return": {}}
>>>>    Segmentation fault (core dumped)
>>>>
>>>> This happens because TYPE_PC_MACHINE machines add a machine_init-
>>>> done_notifier in their instance_init function - but instance_init
>>>> of machines are not only called for machines that are realized,
>>>> but also for machines that are introspected, so in this case the
>>>> listener is added for a q35 machine that is never realized. But
>>>> since there is already a running pc machine, the listener function
>>>> is triggered immediately, causing a crash since it was not for the
>>>> right machine it was meant for.
>>>>
>>>> Such listener functions must never be installed from an instance_init
>>>> function. Let's do it from pc_basic_device_init() instead - this
>>>> function is called from the MachineClass->init() function instead,
>>>> i.e. guaranteed to be only called once in the lifetime of a QEMU
>>>> process.
>>>>
>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2779
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>    hw/i386/pc.c | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>>> index b46975c8a4..85b8a76455 100644
>>>> --- a/hw/i386/pc.c
>>>> +++ b/hw/i386/pc.c
>>>> @@ -1241,6 +1241,9 @@ void pc_basic_device_init(struct 
>>>> PCMachineState *pcms,
>>>>        /* Super I/O */
>>>>        pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
>>>>                        pcms->vmport != ON_OFF_AUTO_ON, &error_fatal);
>>>> +
>>>> +    pcms->machine_done.notify = pc_machine_done;
>>>> +    qemu_add_machine_init_done_notifier(&pcms->machine_done);
>>>>    }
>>>>    void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus 
>>>> *pci_bus)
>>>> @@ -1714,9 +1717,6 @@ static void pc_machine_initfn(Object *obj)
>>>>        if (pcmc->pci_enabled) {
>>>>            cxl_machine_init(obj, &pcms->cxl_devices_state);
>>>>        }
>>>> -
>>>> -    pcms->machine_done.notify = pc_machine_done;
>>>> -    qemu_add_machine_init_done_notifier(&pcms->machine_done);
>>>>    }
>>>>    static void pc_machine_reset(MachineState *machine, ResetType type)
>>>
>>> Friendly ping!
>>>
>>>   Thomas
>>
>>
>> donnu how i missed it.  pls address Philip's comment though.
> 
>   Hi Michael,
> 
> I think we should *not* rename pc_machine_done() since this is about a 
> "machine_done" notifier, not about a "basic_device_init_done" or 
> whatever notifier. So I'd prefer if we can keep this patch as it is. 
> Unless you disagree, could you please pick this up?

I don't have a strong opinion on this, so fine by me!

