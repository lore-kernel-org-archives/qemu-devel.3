Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A3FE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 21:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKl2b-00069F-GY; Mon, 09 Dec 2024 16:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tKl2Z-000697-Ep
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 16:11:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tKl2W-0006k3-Mg
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 16:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733778695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eUWm5QpVRl8BYIHRxPMjrObDKo/qqCHKCHLNiPZJxeM=;
 b=YbBq433GQQAdAG2+zAmwl8FIla2qeZmUXWl02y0AnBHIasZnZaPTLLVsosQgpJwQKgXKPw
 g1MofD6KXS0x0rwAUcavNMrLqDCtS/Ki5w7Tyvf9wtP7I3xiFRLOegsf0nkdKB76+mDMRY
 7zUfgnrxrSbSITe1+LKTHgJp9BIrRM4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-KDbIGibMN0GR3zsDJL57OA-1; Mon, 09 Dec 2024 16:11:33 -0500
X-MC-Unique: KDbIGibMN0GR3zsDJL57OA-1
X-Mimecast-MFC-AGG-ID: KDbIGibMN0GR3zsDJL57OA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e9c69929so948435f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 13:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733778692; x=1734383492;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eUWm5QpVRl8BYIHRxPMjrObDKo/qqCHKCHLNiPZJxeM=;
 b=TZl/PVv6opLZIsvrLNvp9Sdm+AIr2LOsAoxX9UZV/O6KorNm2B4B8l/fvG7IaNPc9N
 HHNBbqMjCVnsdVE2tGE+FgcgujU/YFTPUYvDqBPOicHL9/yE6CnuuxTnhVysmAJJgRvy
 3/jXHdSe7okEnsqfSeODHCX7dSClGi4hRHrRgI+RJcO+38ElP+mne81UNRVOWHKQQl8a
 wm/C1OcshtmaJVANB3H96kz34kLEAudlTHkdP7mhH9lUyYbjsMoBmkGhYvSe7WkMrjMA
 K3WH2xWX4e5PxJ5kTpk0vHWL3ioEJApH2yMzNBQR2GgOIwTDjtdpct6q7SGoxhSGzPSe
 rktA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkxmbccBVVweMQRVaZupYYYwqAHAx9M9xMQ6yXeXrT/md8uFLnRFdH8hVmV9/XtAs7rOKtBnE5pUH7@nongnu.org
X-Gm-Message-State: AOJu0Yw3x/F2TUw3/dx0d9hAWVVztpcmT3BsUH1at4feW+2casXaJ4eF
 Q08oDx4rebOIGm/wqP1OisO4tUj9QaBxy1sWDlBNWScC8OHBIIuKjoYrc//Tq+3D7y5/wQR9ErJ
 bhGOzSBPHVLe2asygM2+gAT5WKQe0pdaKTY3d2nw5dYBZES27tMCz
X-Gm-Gg: ASbGnctK99nHJpyRTvqQle0g+7oenHf1eLVWR8HNAIPoI4uVFdT1VKV/RxXB4yziuNo
 bzAvczkVZXZ5GkSGRFLtsirBlzgqY1ndSbSQIsrAJUIAAodjZLwq55375dlMRz7kBHKHslOhber
 pC/9YUsHMdWDgrOyav/SUwR1ZIor4vN0vaRAwiSzdsFJpQCFbT0dLWNbs0tBrnPlyJDVDw7jKo+
 Lh4vyX1sefnEStCwVuc8ymlMNPH2wyshqo1tpLl3Er2i1SVmnOFxgDwJcgGi0Mn8mbHE4vfksMc
 4+lg1fghYG8mQA64DaBorG9WqyjL53ztf6ge3i3l48BmGpcTwOiEGmaz3k5M5hEmXJaLR3bZ9EW
 3aw==
X-Received: by 2002:a05:6000:178e:b0:385:e1a8:e2a1 with SMTP id
 ffacd0b85a97d-386453d2830mr1770861f8f.3.1733778692646; 
 Mon, 09 Dec 2024 13:11:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFucV2Y23Pqxd3HNlY+XglMsleLftyo1D2hScHZYGT5a+0nMQ3dXtOjOIYaUrDqNbxAetmy0g==
X-Received: by 2002:a05:6000:178e:b0:385:e1a8:e2a1 with SMTP id
 ffacd0b85a97d-386453d2830mr1770840f8f.3.1733778692204; 
 Mon, 09 Dec 2024 13:11:32 -0800 (PST)
Received: from ?IPV6:2003:cb:c71b:2c00:7bfb:29fe:9e6f:2e65?
 (p200300cbc71b2c007bfb29fe9e6f2e65.dip0.t-ipconnect.de.
 [2003:cb:c71b:2c00:7bfb:29fe:9e6f:2e65])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862f0e6ea2sm10526542f8f.79.2024.12.09.13.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 13:11:31 -0800 (PST)
Message-ID: <ab889035-afa2-4a32-8a13-b8bd21b69fc7@redhat.com>
Date: Mon, 9 Dec 2024 22:11:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hostmem-file: add the 'hmem' option
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20241204171114.20033-1-Zhigang.Luo@amd.com>
 <5d4019cd-a3fb-4bed-8bab-e0388ccffee7@redhat.com>
 <BL1PR12MB531759C282DC7A424CBC56E8F1312@BL1PR12MB5317.namprd12.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <BL1PR12MB531759C282DC7A424CBC56E8F1312@BL1PR12MB5317.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06.12.24 18:58, Luo, Zhigang wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi David,

Hi!

> 
> Thanks for your comments.
> Let me give you some background for this patch.
> I am currently engaged in a project that requires to pass the EFI_MEMORY_SP (Special Purpose Memory) type memory from host to a virtual machine within QEMU. This memory needs to be EFI_MEMORY_SP type in the virtual machine as well.
> This particular memory type is essential for the functionality of my project.

Which exact guest memory will be backed by this memory? All guest-memory?

And, what is the guest OS going to do with this memory?

Usually, this SP memory (dax, cxl, ...) is not used as boot memory. Like 
on a bare metal system, one would expect that only CXL memory will be 
marked as special and put aside to the cxl driver, such that the OS can 
boot on ordinary DIMMs, such that cxl can online it etc.

So maybe you would want to expose this memory using CXL-mem device to 
the VM? Or a DIMM?

I assume the alternative is to tell the VM on the Linux kernel cmdline 
to set EFI_MEMORY_SP on this memory. I recall that there is a way to 
achieve that.

> In Linux, the SPM memory will be claimed by hmem-dax driver by default. With this patch I can use the following config to pass the SPM memory to guest VM.
> -object memory-backend-file,size=30G,id=m1,mem-path=/dev/dax0.0,prealloc=on,align=1G,hmem=on
> 
> I was thinking to change the option name from "hmem" to "spm" to avoid confusion.

Likely it should be specified elsewhere, that you want specific guest 
RAM ranges to be EFI_MEMORY_SP. For a DIMM, it could be a property, 
similarly maybe for CXL-mem devices (no expert on that).

For boot memory / machine memory it could be a machine property. But 
I'll first have to learn which ranges you actually want to expose that 
way, and what the VM will do with that information.

> 
> Do you have any suggestions to achieve this more reasonable?

The problem with qemu_ram_foreach_block() is that you would indicate 
also DIMMs, virtio-mem, ... and even RAMBlocks that are not even used 
for backing anything to the VM as EFI_MEMORY_SP, which is wrong.

> 
> Thanks,
> Zhigang
> 
> -----Original Message-----
> From: David Hildenbrand <david@redhat.com>
> Sent: Friday, December 6, 2024 5:08 AM
> To: Luo, Zhigang <Zhigang.Luo@amd.com>; qemu-devel@nongnu.org
> Cc: kraxel@redhat.com; Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH] hostmem-file: add the 'hmem' option
> 
> On 04.12.24 18:11, Zhigang Luo wrote:
>> This boolean option 'hmem' allows users to set a memory region from
>> memory-backend-file as heterogeneous memory. If 'hmem=on', QEMU will
>> set the flag RAM_HMEM in the RAM block of the corresponding memory
>> region and set the e820 type to E820_SOFT_RESERVED for this region.
>>
> 
> Hi,
> 
> ./scripts/get_maintainer.pl is your friend to figure out whom to CC on patches.
> 
> In general: not a fan. You seem to be abusing memory backend properties
> + RAM flags to merely modify how memory is going to be exposed in the
> memory map on x86.
> 
> It's not even clear why heterogeneous memory should be exposed like
> that, and how reasonable it is to essentially expose all of guest RAM as
> E820_SOFT_RESERVED.
> 
> 
> Note that the whole "pmem=on" case was very different, because it
> required mmap() modifications.
> 
>> Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
>> ---
>>    backends/hostmem-file.c      | 23 +++++++++++++++++++++++
>>    hw/i386/e820_memory_layout.h |  1 +
>>    hw/i386/pc.c                 | 16 ++++++++++++++++
>>    include/exec/cpu-common.h    |  1 +
>>    include/exec/memory.h        |  3 +++
>>    qapi/qom.json                |  4 ++++
>>    system/physmem.c             |  7 ++++++-
>>    7 files changed, 54 insertions(+), 1 deletion(-)
>>
>> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
>> index 7e5072e33e..5ddfdbaf86 100644
>> --- a/backends/hostmem-file.c
>> +++ b/backends/hostmem-file.c
>> @@ -32,6 +32,7 @@ struct HostMemoryBackendFile {
>>        uint64_t offset;
>>        bool discard_data;
>>        bool is_pmem;
>> +    bool is_hmem;
>>        bool readonly;
>>        OnOffAuto rom;
>>    };
>> @@ -88,6 +89,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
>>        ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
>>        ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
>>        ram_flags |= fb->is_pmem ? RAM_PMEM : 0;
>> +    ram_flags |= fb->is_hmem ? RAM_HMEM : 0;
>>        ram_flags |= RAM_NAMED_FILE;
>>        return memory_region_init_ram_from_file(&backend->mr, OBJECT(backend), name,
>>                                                backend->size, fb->align, ram_flags,
>> @@ -256,6 +258,25 @@ static void file_memory_backend_set_rom(Object *obj, Visitor *v,
>>        visit_type_OnOffAuto(v, name, &fb->rom, errp);
>>    }
>>
>> +static bool file_memory_backend_get_hmem(Object *o, Error **errp)
>> +{
>> +    return MEMORY_BACKEND_FILE(o)->is_hmem;
>> +}
>> +
>> +static void file_memory_backend_set_hmem(Object *o, bool value, Error **errp)
>> +{
>> +    HostMemoryBackend *backend = MEMORY_BACKEND(o);
>> +    HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
>> +
>> +    if (host_memory_backend_mr_inited(backend)) {
>> +        error_setg(errp, "cannot change property 'hmem' of %s.",
>> +                   object_get_typename(o));
>> +        return;
>> +    }
>> +
>> +    fb->is_hmem = value;
>> +}
>> +
>>    static void file_backend_unparent(Object *obj)
>>    {
>>        HostMemoryBackend *backend = MEMORY_BACKEND(obj);
>> @@ -295,6 +316,8 @@ file_backend_class_init(ObjectClass *oc, void *data)
>>        object_class_property_add_bool(oc, "pmem",
>>            file_memory_backend_get_pmem, file_memory_backend_set_pmem);
>>    #endif
>> +    object_class_property_add_bool(oc, "hmem",
>> +        file_memory_backend_get_hmem, file_memory_backend_set_hmem);
>>        object_class_property_add_bool(oc, "readonly",
>>            file_memory_backend_get_readonly,
>>            file_memory_backend_set_readonly);
>> diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
>> index b50acfa201..8af6a9cfac 100644
>> --- a/hw/i386/e820_memory_layout.h
>> +++ b/hw/i386/e820_memory_layout.h
>> @@ -15,6 +15,7 @@
>>    #define E820_ACPI       3
>>    #define E820_NVS        4
>>    #define E820_UNUSABLE   5
>> +#define E820_SOFT_RESERVED  0xEFFFFFFF
>>
>>    struct e820_entry {
>>        uint64_t address;
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 317aaca25a..41e9cc276c 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -785,6 +785,21 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
>>        return pc_above_4g_end(pcms) - 1;
>>    }
>>
>> +static int pc_update_hmem_memory(RAMBlock *rb, void *opaque)
>> +{
>> +    X86MachineState *x86ms = opaque;
>> +    ram_addr_t offset;
>> +    ram_addr_t length;
>> +
>> +    if (qemu_ram_is_hmem(rb)) {
>> +        offset = qemu_ram_get_offset(rb) + (0x100000000ULL - x86ms->below_4g_mem_size);
>> +        length = qemu_ram_get_used_length(rb);
>> +        e820_add_entry(offset, length, E820_SOFT_RESERVED);
>> +    }
> 
> I am pretty sure this will break in NUMA setups, where we have multiple
> memory backends mapped in different locations.
> 
> The whole "(0x100000000ULL - x86ms->below_4g_mem_size)" looks hacky.
> 
> --
> Cheers,
> 
> David / dhildenb
> 


-- 
Cheers,

David / dhildenb


