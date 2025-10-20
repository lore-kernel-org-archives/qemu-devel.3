Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C7CCCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 20:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAw6u-0005tW-R0; Mon, 20 Oct 2025 16:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1vAw6t-0005tN-7V
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1vAw6n-0001OE-QV
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760990635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ry62v2DibaYMhJyFXUsDi9vpGBKDoxNjTSn+MGs8/dM=;
 b=Zu+L0kYwxtPn3jHwCtw+oQEcs8r1L7Wo7wEWYaMYbWHkU8XZUvtJ4aUPXwBVHomS6bVvsj
 tRo0YJP0+sUfqP/oQU0AdrVvoaGVwulb25hbYEQOPzOCBEBJ/vbVVLyoCqSIHlR09Do7Qm
 zcZkV9F3ZpL2S9ZbXfHNUzoLvV5tGkg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-lnTia1gwMK-Kgwd7caPIkw-1; Mon, 20 Oct 2025 16:03:54 -0400
X-MC-Unique: lnTia1gwMK-Kgwd7caPIkw-1
X-Mimecast-MFC-AGG-ID: lnTia1gwMK-Kgwd7caPIkw_1760990633
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4711899ab0aso37171895e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 13:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760990633; x=1761595433;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ry62v2DibaYMhJyFXUsDi9vpGBKDoxNjTSn+MGs8/dM=;
 b=oO4ayclG0mctWU5/2n90VsjTrctMa4FvlevBrqdb2icUjSqsOTLK2FPWiW4YN+Mf4X
 vlR9+9DS6OUQ6eTmklgULvKnCU2bT83SV4i2T1RkjlIT61tQ0rntse2wPhpEw2dfubaV
 m4exfSEUY0+/7fPl/JFwdk1fR8eg/4EZT7QfGk6ccwghJJmeWYmzP/xm2+OrxcALDBWk
 8dIyXfuCPM/6uqXzSuckGqL6HiH4c28EMedbdi4i0ZCp8UyFCLx7Clxi1FVWwOLBnG4y
 XghPm8JXCDLg+rOiZ49nGSx8Xd7QOvgvolIpizrcQX+VJtlrpAiPuE+U1LO7MGZ2ntrn
 eNOQ==
X-Gm-Message-State: AOJu0YxhcjjFs0bVzsDCL4sI8EmKf31gezXDXmgfyxq2zDVPuxwkcKJG
 bPe1aM9QM/tHOnb637EgrNGZQjYxz21rDxUTmZnnqRlDcq9s+LbynOo4/9YExnLKeT2w832Vn/l
 AZFNPqLfYsNKw0gujW6wEyhN3I94o0zuYhI0lPIbrw0s2mDbyXUTI34XS
X-Gm-Gg: ASbGnctRWuyuShZJhJwArnNq4AkT8WVeMFR3JohhWWu3gf+bhZ6JJeYVVx6wV5b76M2
 ZKzPdDBQ9QTq31fKb0KlvJXHqGxQ/SPjdecch6CtPj4nKUVHW+qWavLGR0p/D8hZABZ050KOcmT
 PN+Dz+4MORSIxBcY+LgSYnPbIOJnNyPQrHc61R5XyRMGUhw3A3S8bAHAcRRRZSoAxQQDn2ppo5N
 Rtr0vpEtriNJ6VlvG3vNikNRaDd/jM6gqbwhTkGb9Fs8jB0m8128ab3rv4RwLRa+uJiLNrLwsxm
 ZNLH2+qMPd7F8y5C6tkridwefHDRQiCXpPhSjHgpXv1MJb0k+EaK5xc3xv+Fy39UUDrvGhXR2as
 GXHtsh6T/AwiG1HYD6YEl13lqPCNWDDeWWKftKxm8BmShN2bqKdjFOciC8pqfjtYXbJ5jplIIaL
 kuwLwkqPVEiVp031hHxyzJbuTA9Po=
X-Received: by 2002:a05:600c:800f:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-471179041b6mr107765085e9.25.1760990632940; 
 Mon, 20 Oct 2025 13:03:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWJgWNOzNFEglGe1TJFSdlDwkfVxyVi9tYWjCh1JbJLo6wL/nTOGYoeHBSzd2OEo13XqMh/g==
X-Received: by 2002:a05:600c:800f:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-471179041b6mr107764915e9.25.1760990632462; 
 Mon, 20 Oct 2025 13:03:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce?
 (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de.
 [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144d17cdsm243299605e9.18.2025.10.20.13.03.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 13:03:52 -0700 (PDT)
Message-ID: <40005e02-17df-43d1-a1d7-0b3bcfefdbf1@redhat.com>
Date: Mon, 20 Oct 2025 22:03:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] numa: add 'spm' option for Specific Purpose Memory
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 fanhuang <FangSheng.Huang@amd.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, Zhigang.Luo@amd.com,
 Lianjie.Shi@amd.com, Oscar Salvador <osalvador@suse.de>
References: <20251020090701.4036748-1-FangSheng.Huang@amd.com>
 <20251020111534.00004a29@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251020111534.00004a29@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20.10.25 12:15, Jonathan Cameron wrote:
> On Mon, 20 Oct 2025 17:07:00 +0800
> fanhuang <FangSheng.Huang@amd.com> wrote:
> 
>> Hi David and Igor,
>>
>> I apologize for the delayed response. Thank you very much for your thoughtful
>> questions and feedback on the SPM patch series.
>>
>> Before addressing your questions, I'd like to briefly mention what the new
>> QEMU patch series additionally resolves:
>>
>> 1. **Corrected SPM terminology**: Fixed the description error from the previous
>>     version. The correct acronym is "Specific Purpose Memory" (not "special
>>     purpose memory" as previously stated).
>>
>> 2. **Fixed overlapping E820 entries**: Updated the implementation to properly
>>     handle overlapping E820 RAM entries before adding E820_SOFT_RESERVED
>>     regions.
>>
>>     The previous implementation created overlapping E820 entries by first adding
>>     a large E820_RAM entry covering the entire above-4GB memory range, then
>>     adding E820_SOFT_RESERVED entries for SPM regions that overlapped with the
>>     RAM entry. This violated the E820 specification and caused OVMF/UEFI
>>     firmware to receive conflicting memory type information for the same
>>     physical addresses.
>>
>>     The new implementation processes SPM regions first to identify reserved
>>     areas, then adds RAM entries around the SPM regions, generating a clean,
>>     non-overlapping E820 map.
> 
> I'm definitely in favor of this support for testing purposes as well as
> for the GPU cases you describe.

Thanks for taking a look!

> 
> Given I took your brief comment on hotplug and expanded on it +CC David
> and Oscar.
> 
>>
>> Now, regarding your questions:
>>
>> ========================================================================
>> Why SPM Must Be Boot Memory
>> ========================================================================
>>
>> SPM cannot be implemented as hotplug memory (DIMM/NVDIMM) because:
>>
>> The primary goal of SPM is to ensure that memory is managed by guest
>> device drivers, not the guest OS. This requires boot-time discovery
>> for three key reasons:
>>
>> 1. SPM regions must appear in the E820 memory map as `E820_SOFT_RESERVED`
>>     during firmware initialization, before the OS starts.
>>
>> 2. Hotplug memory is integrated into kernel memory management, making
>>     it unavailable for device-specific use.
> 
> This is only sort of true and perhaps reflects support in the kernel for ACPI
> features being missing as no one has yet been interested in them.
> See 9.11.3 Hot-pluggable Memory Description Illustrated in the 6.6 ACPI spec.
> That has an example where the EFI_MEMORY_SP bit is provided.
> I had a dig around and for now ACPICA / kernel doesn't seem to put that alongside
> write_protect and the other bits that IIUC come from the same field.
> It would be relatively easy to pipe that through and potentially add handling
> in the memory hotplug path to allow for drivers to pick these regions up
> (which boils down I think to making them visible in some way but doing nothing
> else with them)

Considering something like DIMMs, one challenge is also that hotplugged 
memory in QEMU is never advertised in e820 (we only indicate the 
hotpluggable region), which is different to real hardware but let's us 
stop the early kernel that is booting up from considering these areas 
"initial memory" and effectively turning them hot-unpluggable in the 
default case.

Then, the question is what happens when someone plugs such a DIMM, 
unplugs it, and plugs something else in there that's not supposed to be SP.

I assume that's all solvable, just want to point out that the default 
memory hotplug path in QEMU is not really suitable for that right now I 
think.

> 
> Other path would be to use a discoverable path such as emulating CXL memory.
> Hotplug of that would work fine from point of view of coming up as driver managed
> SPM style (the flag is in runtime data provided by the device). It would however
> look different to the firmware managed approach you are using in the host.

Right.

-- 
Cheers

David / dhildenb


