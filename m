Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B777CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 14:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6VEG-00087X-Kh; Wed, 08 Oct 2025 10:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6VEF-00087K-Fq
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 10:33:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6VEB-0007nI-8R
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 10:33:18 -0400
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so3524220f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759933988; x=1760538788; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4fAJbdZF9s4z4lfAb2y9xHtHmkKOpYdQnWX33Kl9O7Q=;
 b=m6JLW76kSqicSgBBFS4aT03KR6R5/6rF8ZQunCThJT3fUgdUtdATII2M4HTFS68rX9
 cB6HCsTyf3sJHgObtEHMwEqhhG9lVGJfqGLZKiXI4oUvPuUnx1AlfNhPRipIRNznqAcf
 FZBP3WFcd7/XMhXKc6BFq1b4RQF2XTAPrJn1hR7Hu7MT2JJRHH0zRd0odwuqYJ23uha1
 p1l3E5heidYZE0lxDyRl/mupbAIxodEwlYa127TSpC3LvIEd0SKZj5mvEJi7CpMTXpMi
 w8e7RUREXyfVOeDuajFVXaGOcrIVAd4u88UgNbJUrNu7LA62v1P3zWvnbH4EimvcuLn2
 6yCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759933988; x=1760538788;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4fAJbdZF9s4z4lfAb2y9xHtHmkKOpYdQnWX33Kl9O7Q=;
 b=quihafi+wDp8ZHJZ7SvTlXCrjKlB2h7Tx4eFQqtUQHFYFq2sH0TOT+RETngVl+Ke0X
 TFOd9ac0QZq4yKIPSIvFLEcUYluh+++4+8Q43gw+8mp1UGvXrxrtmjXKUHSFiFOxz+1I
 9TUBz+qWIGpu4E88WMXdvTCFUafK1ApoAWSuxdezpzgpy63al9iUf604O4nOprJYAxE2
 L/xPvRfApiGlZ2+7An8pX9S+psD/xOWM6mNsyWbb0UZABFxqE1ZGhskRXZhMV4Td7WdC
 MLm9wKMJskzBjEc6Sb/D/s/v/2j5TMAoXnu4ddc1IgukeAuZSvrnLVRRV3/zlXy1C4gH
 uCzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjHiQt2X6hNSJUOrKtaWKkoMt3BRBQhqlGYsRCh42KSfzgjyfXZB2uOen6xe5Cl8elTYATx2rPfAT0@nongnu.org
X-Gm-Message-State: AOJu0YxaguOUouQvhxQ9bfrvzswKxVcdODrB1TGZX82urFoCL71kGce6
 CkeyXiP7K6TnnVBGm3OuJDVREitlMrSgEh8pBBa8P0xoAMXf2hVqLoNQH5xnyiU+Hg4=
X-Gm-Gg: ASbGncu0JA9F9qK0b/q2aO9JcEr62bZ66QhqNx8A6un985gVYKdqKfRyeUIx9L5pgvV
 wwzsZzx147FMW5+RZA6DPZqhH4r8+3v/ZBp0L7YSsnBCRRekzCInpyTwpjrAvjQXRIHjn1cSJRG
 NubkWG7960kSt1u81Co9gY3qJjh1Yta+R2QGXu+T+qeVThaxd5ai94sOLnZqIObX0hj7XFgih0V
 Mqcls24ViUD8R7kt6h5WR8qJ+4lNdYRs0tk8fVH+3o6lF54V4QCFFeUFbLpZHXYTa4+hzWz9TH6
 l6dQrJXthNkl/RPxHWPG0hQMpZGgvLmQcLntjvICsZUHCjf7EdYij/2GCSnAbBf4KY7IqHOsKfG
 XYZPcZ0ynU5k9ktzdZavO9VrDdwEf9CIAh3nFet/ZPyeihiOrRyxdZKgcTc/AidoD4urIyo57U3
 Lmn+T45RkLcebdenDMYw==
X-Google-Smtp-Source: AGHT+IED2ayDysruE89bXJH+liU+LqOJJwNVkByxKxVpoMV7cHri8ubi9XZABjORdTPVDoiAlxO+gQ==
X-Received: by 2002:a05:6000:186f:b0:425:75b7:4b67 with SMTP id
 ffacd0b85a97d-4266e8da717mr2393134f8f.58.1759933988030; 
 Wed, 08 Oct 2025 07:33:08 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46faf16abf6sm2084485e9.12.2025.10.08.07.33.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 07:33:07 -0700 (PDT)
Message-ID: <f2628aaa-5bea-45be-b0ca-7d0aa5384f2a@linaro.org>
Date: Wed, 8 Oct 2025 16:33:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/hppa: Fix booting Linux kernel with initrd
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, deller@kernel.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250122180913.18667-1-deller@kernel.org>
 <20250122180913.18667-3-deller@kernel.org>
 <8eb571a6-f48c-4083-85ef-3e92603c84d1@linaro.org>
 <e11fbe55-2768-4acd-9ec3-37eb0ae14d7a@gmx.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e11fbe55-2768-4acd-9ec3-37eb0ae14d7a@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x443.google.com
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

On 8/10/25 15:49, Helge Deller wrote:
> Hi Philippe,
> 
> On 10/8/25 15:43, Philippe Mathieu-Daudé wrote:
>> On 22/1/25 19:09, deller@kernel.org wrote:
>>> From: Helge Deller <deller@gmx.de>
>>>
>>> Commit 20f7b890173b ("hw/hppa: Reset vCPUs calling resettable_reset()")
>>> broke booting the Linux kernel with initrd which may have been provided
>>> on the command line. The problem is, that the mentioned commit zeroes
>>> out initial registers which were preset with addresses for the Linux
>>> kernel and initrd.
>>>
>>> Fix it by adding proper variables which are set shortly before starting
>>> the firmware.
>>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>> Fixes: 20f7b890173b ("hw/hppa: Reset vCPUs calling resettable_reset()")
>>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/hppa/machine.c | 48 +++++++++++++++++++----------------------------
>>>   target/hppa/cpu.h |  4 ++++
>>>   2 files changed, 23 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>> index 4bcc66cd6f..0dd1908214 100644
>>> --- a/hw/hppa/machine.c
>>> +++ b/hw/hppa/machine.c
>>> @@ -356,7 +356,6 @@ static void 
>>> machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>>>       uint64_t kernel_entry = 0, kernel_low, kernel_high;
>>>       MemoryRegion *addr_space = get_system_memory();
>>>       MemoryRegion *rom_region;
>>> -    unsigned int smp_cpus = machine->smp.cpus;
>>>       SysBusDevice *s;
>>>       /* SCSI disk setup. */
>>> @@ -482,8 +481,8 @@ static void 
>>> machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>>>                         kernel_low, kernel_high, kernel_entry, size / 
>>> KiB);
>>>           if (kernel_cmdline) {
>>> -            cpu[0]->env.gr[24] = 0x4000;
>>> -            pstrcpy_targphys("cmdline", cpu[0]->env.gr[24],
>>> +            cpu[0]->env.cmdline_or_bootorder = 0x4000;
>>> +            pstrcpy_targphys("cmdline", cpu[0]- 
>>> >env.cmdline_or_bootorder,
>>>                                TARGET_PAGE_SIZE, kernel_cmdline);
>>
>> I am a bit confused, here @cmdline_or_bootorder contains the physical
>> address of the kernel command line, ...
> ...
>>>           kernel_entry = machine->boot_config.has_menu ? machine- 
>>> >boot_config.menu : 0;
>>> -        cpu[0]->env.gr[24] = machine->boot_config.order[0];
>>> +        cpu[0]->env.cmdline_or_bootorder = machine- 
>>> >boot_config.order[0];
>>
>> ... but here a char ('c' or 'd'). Both seems different things.
>> Is that expected?
> Yes. That's why this variable is called "cmdline" or "bootorder".
> If kernel and cmdline is given, the bios does not need to follow any 
> bootorder
> (which means: boot kernel from C or D).
> If no kernel/cmdline, this parameter tells the firmare to load bootloader
> from c (harddisc) or d (cdrom).

Ah, now I get the variable name... cmdline is used as hwaddr, and 
bootorder as plain char. OK!

