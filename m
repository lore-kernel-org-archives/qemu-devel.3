Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E84BCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 12:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0fLe-0008RN-Dc; Mon, 22 Sep 2025 08:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0fLa-0008RB-84
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:08:46 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0fLW-00014F-A5
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:08:45 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45b9a856dc2so28937645e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 05:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758542919; x=1759147719; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q8d5XdTo2vGa5dJFYW+BPnbWGHGoLaoAkKexXeElvkg=;
 b=pf0UHbe/2wibT9z2CMUSG5845X6XF40sUS3PCTd89OpgWUq9ug3ynDpPMu9fHv5t+C
 kzqd7SvAVIybu1M6WlkC7Oi8QmJKWlyUW4e4ZvvvVeRhlt84CBmVQd2dmA/a+6IQD8oB
 qeVOmGMyadL1kX1pTOzjQ9t7j/79q1OfGHoKwDV49oNeLxK85yKSgf19sgkwA+ZZBQyp
 s7jjRzzUoHFj2kTxR2ZqYH9DYEcnwGTQq4NAC26KP/UvQxTQSc7BYx3uAx3m8i3/gb7M
 xo1+wbLonh2Ap0GK3qku04CI9blUpZ07r9iaR1o1NfkM+fxGrSkJi6b0ybfKJ/l5ebsJ
 tFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758542919; x=1759147719;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q8d5XdTo2vGa5dJFYW+BPnbWGHGoLaoAkKexXeElvkg=;
 b=jj/jhXhoy7CurOsqLqkOPf7imGw8gxtf4ERki6b6Fo36WTghza3No8rffxqj4KrWQY
 fj/cNTty1RgdU1Hj28hLLCALpvTTU+uiv0Yy4ZRnXF8aFOZmFP9T+VYwN51nRQw1PNtp
 aB2nd0M+xZW03WdnG+4walIA0I+EkZ7sAVroVJaA3AJrIyOO3vxcQ0+8fcX7irSh/lp1
 fr2DYXiZpMSopyg5VCiNkomNGFN3N8s49RnVzk3a6omDaZSGkTVAoNtmEBvYVl+DzVpc
 aOCbQal0gYs9aXTIDKOjGei9AbG/qqKw4FMkPj6dRsRsvYUSLetmd40uGOwXuCqR3SFM
 mSQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOXDMS63k8Ftz2oAWba44c1OVfULBKZl+iP2/WI8NBP2iwFZyMrQM8YwiyfxnuSSEfB+z69uE8N7tq@nongnu.org
X-Gm-Message-State: AOJu0YwbktY42TlOV7bd3Uice6phzRPqGloNb4mVYpqkozRggvejdNcj
 VX08xHet0gKADu2MLsWqBvC/6iNh//sI+rniwE01wy+/g5mZwUW7rle/Uw40HLINCM4=
X-Gm-Gg: ASbGncvdLZoUuEkbFhSLpDxGOHWEwEoW7TWlUMz15M7f0tZZz4dPAhC6dQLCY6W7aUm
 Uc3uqj0zdhFxZmIAB2H1mgd8hqjcmjSRRKcMbJlZ+kSHfG2xkWoHQFVw8PWYU2soxluZHlQFYEa
 G5rFfNfwN1h4PF45j2uKC2UkOM+k/eieB8KNH+zmIPQ0SJo1TDQQx1/IgJz2c8FC5HRKgO/mkpo
 y4hCEBHePBmKSnFKaTg2D2hxsLXaEUmx/2hXwyGZO4wFh8mOG0wyGWkZ1ewlH2M9fue8KfobHSm
 zs6E538nDDp/UmcT14SGK552ko/S+ySwtw/vDzaA/LrbQv+1ZDmVJ4zfnoc1XdEmxI9Iko8uOXM
 y6SCXBMoOw71hLYh2N0fqOgAwCT1q3K1o/dHjEYSy+TDmwcV/UxG512zz5jeu4dkELg==
X-Google-Smtp-Source: AGHT+IE+Vf/FCxqfjpqH2YO7lo2XwdJOy2TmWrr2juOsQNgey3o6HgNJadMTtpTXUABhqAshN8xZdA==
X-Received: by 2002:a05:600c:450a:b0:45e:8e:28bf with SMTP id
 5b1f17b1804b1-467eb231105mr102248915e9.28.1758542918510; 
 Mon, 22 Sep 2025 05:08:38 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f64ad359sm229677585e9.22.2025.09.22.05.08.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 05:08:37 -0700 (PDT)
Message-ID: <03daa425-0f1a-4377-90c1-34846e98e810@linaro.org>
Date: Mon, 22 Sep 2025 14:08:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/19] hw/i386/pc_piix.c: simplify RAM size logic in
 pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, imammedo@redhat.com,
 qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-10-mark.caveayland@nutanix.com>
 <7fa8968e-c584-4441-8859-a40788067e95@intel.com>
 <fd631cee-4089-400a-a79f-0091341fec1f@nutanix.com>
 <345b5031-c8e2-42d7-b944-5341747c7349@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <345b5031-c8e2-42d7-b944-5341747c7349@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 28/8/25 10:41, Mark Cave-Ayland wrote:
> On 27/08/2025 12:00, Mark Cave-Ayland wrote:
> 
>> On 26/08/2025 11:01, Xiaoyao Li wrote:
>>
>>> On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
>>>> All isapc machines must have 32-bit CPUs and so the RAM split logic 
>>>> can be hardcoded
>>>> accordingly.
>>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>>> ---
>>>>   hw/i386/pc_piix.c | 58 +++ 
>>>> +-------------------------------------------
>>>>   1 file changed, 4 insertions(+), 54 deletions(-)
>>>>
>>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>>> index 816124c027..fc94937ad4 100644
>>>> --- a/hw/i386/pc_piix.c
>>>> +++ b/hw/i386/pc_piix.c
>>>> @@ -444,69 +444,19 @@ static void pc_init_isa(MachineState *machine)
>>>>       GSIState *gsi_state;
>>>>       MemoryRegion *ram_memory;
>>>>       MemoryRegion *rom_memory = system_memory;
>>>> -    ram_addr_t lowmem;
>>>>       uint64_t hole64_size = 0;
>>>>       /*
>>>> -     * Calculate ram split, for memory below and above 4G.  It's a bit
>>>> -     * complicated for backward compatibility reasons ...
>>>> -     *
>>>> -     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is 
>>>> the
>>>> -     *    default value for max_ram_below_4g now.
>>>> -     *
>>>> -     *  - Then, to gigabyte align the memory, we move the split to 3G
>>>> -     *    (lowmem = 0xc0000000).  But only in case we have to split in
>>>> -     *    the first place, i.e. ram_size is larger than (traditional)
>>>> -     *    lowmem.  And for new machine types (gigabyte_align = true)
>>>> -     *    only, for live migration compatibility reasons.
>>>> -     *
>>>> -     *  - Next the max-ram-below-4g option was added, which allowed to
>>>> -     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
>>>> -     *    window below 4G.  qemu doesn't enforce gigabyte alignment 
>>>> here,
>>>> -     *    but prints a warning.
>>>> -     *
>>>> -     *  - Finally max-ram-below-4g got updated to also allow 
>>>> raising lowmem,
>>>> -     *    so legacy non-PAE guests can get as much memory as 
>>>> possible in
>>>> -     *    the 32bit address space below 4G.
>>>> -     *
>>>> -     *  - Note that Xen has its own ram setup code in xen_ram_init(),
>>>> -     *    called via xen_hvm_init_pc().
>>>> -     *
>>>> -     * Examples:
>>>> -     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low, 
>>>> 512M high
>>>> -     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 
>>>> 1024M high
>>>> -     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 
>>>> 2048M high
>>>> -     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low 
>>>> (=4G-128M)
>>>> +     * There is no RAM split for the isapc machine
>>>>        */
>>>>       if (xen_enabled()) {
>>>>           xen_hvm_init_pc(pcms, &ram_memory);
>>>>       } else {
>>>>           ram_memory = machine->ram;
>>>> -        if (!pcms->max_ram_below_4g) {
>>>> -            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
>>>> -        }
>>>> -        lowmem = pcms->max_ram_below_4g;
>>>> -        if (machine->ram_size >= pcms->max_ram_below_4g) {
>>>> -            if (pcmc->gigabyte_align) {
>>>> -                if (lowmem > 0xc0000000) {
>>>> -                    lowmem = 0xc0000000;
>>>> -                }
>>>> -                if (lowmem & (1 * GiB - 1)) {
>>>> -                    warn_report("Large machine and max_ram_below_4g "
>>>> -                                "(%" PRIu64 ") not a multiple of 1G; "
>>>> -                                "possible bad performance.",
>>>> -                                pcms->max_ram_below_4g);
>>>> -                }
>>>> -            }
>>>> -        }
>>>> -        if (machine->ram_size >= lowmem) {
>>>> -            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
>>>> -            x86ms->below_4g_mem_size = lowmem;
>>>> -        } else {
>>>> -            x86ms->above_4g_mem_size = 0;
>>>> -            x86ms->below_4g_mem_size = machine->ram_size;
>>>> -        }
>>>> +        pcms->max_ram_below_4g = 4 * GiB;
>>>> +        x86ms->above_4g_mem_size = 0;
>>>> +        x86ms->below_4g_mem_size = machine->ram_size;
>>>
>>> I think we need to sanity check the machine->ram_size is not bigger 
>>> than 4G, and error out if it exceeds.
>>
>> Amazingly there is currently no limit for the isapc machine, but I 
>> shall add it in for v7.
> 
> With the PCI hole removed it appears that TCG and KVM have a different 
> idea as to the maximum allowable amount of RAM available:
> 
> Fails with KVM:
> ./build/qemu-system-x86_64 -accel kvm -M isapc -m 4079M
> qemu-system-x86_64: kvm_set_user_memory_region: 
> KVM_SET_USER_MEMORY_REGION failed, slot=0, start=0x0, size=0xfef00000: 
> File exists
> kvm_set_phys_mem: error registering slot: File exists

Is this a bug? Clearly not obvious error message...

> 
> Works with TCG:
> ./build/qemu-system-x86_64 -accel tcg -M isapc -m 4096M
> 
> Given that the original limit above is 3.5G I think it's best to revert 
> back to using 3.5G instead of 4G so that both TCG and KVM behave the 
> same, whilst also allowing a bit of wiggle room if required.
> 
> 
> ATB,
> 
> Mark.
> 
> 


