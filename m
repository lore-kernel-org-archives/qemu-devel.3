Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E169C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAzq-0001np-Go; Fri, 11 Jul 2025 06:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaAzn-0001j3-B9
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:28:47 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaAzh-00054V-Cg
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:28:47 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-455b00339c8so2747145e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 03:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752229719; x=1752834519; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=INfsuQXW2NSGThUPwFh45vtsrXF85sl+ip8yKq9Mo1c=;
 b=q9+U7KKD4P9K5b3dffb4ZFXJim4eHXuQbJilMjEn2k5rqrHD/HLjFsKuJxAst1TKzY
 ocNayUVYwjMlXvIT+XY65p7U5GKiucJK9zwaiOFhLgf2LdfR6LAfrxAEB4xsS1UR42PD
 3yLvG0xIOENqEvhuEJEwn+kq7stm2gaFva5bP+gV4kdQQwF1YB+UxwzTzTKkgY1NWAlW
 y2bVO+1/vCXinZ0CGR5/IaugQHpeQ8nrm2hn3GGUXgnuCJk3rbhBPvMv3xyaORIvrFxY
 mcixy3PQfjbZjspW2D+zWHFauZ5enF4LyGWTqVr4JCgvAoR/eNp8e9wQwFSqX1idW1Vl
 uj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752229719; x=1752834519;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=INfsuQXW2NSGThUPwFh45vtsrXF85sl+ip8yKq9Mo1c=;
 b=jIBXAUWwsnWLjEHkf2AwRhfENsFHnrx6zE1aGfyZGc8JymonrNWpLn0pl5KGEtCTU6
 bMr7Z+A+x9YZxh12c8x35FbENx/3l5fMJ51lizyCWbaoRknxdUEe0kATHNPsxwIRBX5I
 A2iwQr47WQ9MkUsQicOCyDQo5XEwTr3mBNzCeyWeTjif2SDugv3whVpYTYhtcpdN9dRp
 oX7YiVdXZRhCX5H0PmOwkmPX2n2A0+eE+w2L8L1XZnZ5GgVotyiTqk02vZMm8TrMtXP3
 5heypS3Cysq24UOX3FDOZcJZTHrLaI/92y4nARVh7Dx8bAgTp9P5/PYBQFNY2v/zQJ9p
 dh6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIY3yIbYYxnGKKaKzAmNUiLDpTp21Ey0ziZfhuCZfuIMeN3s+ywpMNF8k3zzdyWSV6n5RxzcmVnMwY@nongnu.org
X-Gm-Message-State: AOJu0Yw1Q08DP84wkNyYOjIkO3G/+6N3kjgOclk43Wsl40zaiSCGfSVB
 IrJm4ehce0LwKsv4qSOXRpa/1Zt28gBtnzmIVkvu/lqIQGTxz8hft3Uc4vgK0ZFL7Zo=
X-Gm-Gg: ASbGncuXoaUzfOKrQojghLZRYUHQpFQobg4eoPUXeVdO8PhAHM96QmNHi0qJx6rXyIB
 fx7KKgsX+7V4NtyDfEyqnnY/Voj88l3axAkqPO4G1dmQzzQrTj0gpUsjCj4ZaqKHYR6ciwZmCp6
 rvpm5B4u0W3KfmDfnc7p6nMcdU7RvSViPn5Cwg5BXtyG6+9pUC1FflxPIEV/5n5xc5d8c0BWigu
 hiMupd5Dk006yyrgjaCFfmEji5AdovPlwQgolVcXRmtPploxdAnGksoXe8VsTF4jOz71/EoFO6f
 SgDKgfMI/41zAI9p2MCp7Uk0DCar6rUjQ9huFXk3hSdFCbuwEsa3drT1rXXQ2GEA7C//jOTV0Mk
 Ij+yM48CdVKa2E6nKngv6vyJjiVEm56W7M3YPvCmJswbG6cYGgNZQnebFEec+QKafCC3IkQ==
X-Google-Smtp-Source: AGHT+IHKCpIitgbQMMVm46yPW9JmmBST0bNe1ag5G7PXf8ACvOTkwHKyIj5WkQAzrJhk4wjjtBx7RQ==
X-Received: by 2002:a05:600c:8b33:b0:441:d4e8:76cd with SMTP id
 5b1f17b1804b1-454f42744fbmr22879665e9.29.1752229719121; 
 Fri, 11 Jul 2025 03:28:39 -0700 (PDT)
Received: from [192.168.1.47] (lfbn-mon-1-587-20.w2-4.abo.wanadoo.fr.
 [2.4.165.20]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd54115bsm43934155e9.31.2025.07.11.03.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 03:28:37 -0700 (PDT)
Message-ID: <9179aa9b-52e2-4706-8dce-12dc20a05bb6@linaro.org>
Date: Fri, 11 Jul 2025 12:28:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/18] hw/i386/isapc.c: replace rom_memory with
 system_memory
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
 <20250710085308.420774-19-mark.caveayland@nutanix.com>
 <8e9e90f3-eb41-47db-8286-9d96a97c9cac@linaro.org>
 <695cf9b8-3e5e-4560-9847-688917796648@linaro.org>
 <6e04c7fc-f390-4245-be27-f5f37924943e@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6e04c7fc-f390-4245-be27-f5f37924943e@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 10/7/25 17:35, Mark Cave-Ayland wrote:
> On 10/07/2025 12:05, Philippe Mathieu-Daudé wrote:
> 
>> On 10/7/25 12:53, Philippe Mathieu-Daudé wrote:
>>> On 10/7/25 10:52, Mark Cave-Ayland wrote:
>>>> Now that we can guarantee the isapc machine will never have a PCI 
>>>> bus, any
>>>> instances of rom_memory can be replaced by system_memory and rom_memory
>>>> removed completely.
>>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>>> ---
>>>>   hw/i386/isapc.c | 3 +--
>>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
>>>> index bb22083821..27c075b5f3 100644
>>>> --- a/hw/i386/isapc.c
>>>> +++ b/hw/i386/isapc.c
>>>> @@ -35,7 +35,6 @@ static void pc_init_isa(MachineState *machine)
>>>>       ISABus *isa_bus;
>>>>       GSIState *gsi_state;
>>>>       MemoryRegion *ram_memory;
>>>> -    MemoryRegion *rom_memory = system_memory;
>>>>       DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>>>>       uint32_t irq;
>>>>       int i;
>>>> @@ -73,7 +72,7 @@ static void pc_init_isa(MachineState *machine)
>>>>       /* allocate ram and load rom/bios */
>>>>       if (!xen_enabled()) {
>>>> -        pc_memory_init(pcms, system_memory, rom_memory, 0);
>>>> +        pc_memory_init(pcms, system_memory, system_memory, 0);
>>>
>>> I'd prefer just call here:
>>>
>>>    x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, true);
>>>
>>> and in pc_system_firmware_init(): assert(pcmc->pci_enabled).
>>>
>>> WDYT?
>>
>> What I have in mind (untested):
>>
>> -- >8 --
>> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
>> index 27c075b5f32..a7c2146916c 100644
>> --- a/hw/i386/isapc.c
>> +++ b/hw/i386/isapc.c
>> @@ -74,3 +74,4 @@ static void pc_init_isa(MachineState *machine)
>>       if (!xen_enabled()) {
>> -        pc_memory_init(pcms, system_memory, system_memory, 0);
>> +        pc_memory_init(pcms, system_memory, NULL, 0);
>> +        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", 
>> system_memory, true);
>>       } else {
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index b2116335752..2952d3ee4ff 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -811,3 +811,3 @@ void pc_memory_init(PCMachineState *pcms,
>>                       MemoryRegion *system_memory,
>> -                    MemoryRegion *rom_memory,
>> +                    MemoryRegion *pci_memory,
>>                       uint64_t pci_hole64_size)
>> @@ -826,2 +826,3 @@ void pc_memory_init(PCMachineState *pcms,
>>
>> +    assert(pcmc->pci_enabled ^ !!pci_memory);
>>       assert(machine->ram_size == x86ms->below_4g_mem_size +
>> @@ -955,3 +956,5 @@ void pc_memory_init(PCMachineState *pcms,
>>       /* Initialize PC system firmware */
>> -    pc_system_firmware_init(pcms, rom_memory);
>> +    if (pcmc->pci_enabled) {
>> +        pc_system_firmware_init(pcms, pci_memory);
>> +    }
>>
>> @@ -969,3 +972,3 @@ void pc_memory_init(PCMachineState *pcms,
>>           }
>> -        memory_region_add_subregion_overlap(rom_memory,
>> +        memory_region_add_subregion_overlap(pci_memory,
>>                                               PC_ROM_MIN_VGA,
>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>> index 821396c16e9..0c29e4188fc 100644
>> --- a/hw/i386/pc_sysfw.c
>> +++ b/hw/i386/pc_sysfw.c
>> @@ -221,6 +221,3 @@ void pc_system_firmware_init(PCMachineState *pcms,
>>
>> -    if (!pcmc->pci_enabled) {
>> -        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, 
>> true);
>> -        return;
>> -    }
>> +    assert(pcmc->pci_enabled);
> 
> I think that's a good idea, however the original aim of this series was 
> just to do the basic split and tidy-up work (hopefully in time for 10.1).
> 
> There is certainly more tidy-up that is possible w.r.t. pc.c, but I 
> didn't want to start unraveling that thread right now for fear of this 
> series getting too large :/

Fair enough.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


