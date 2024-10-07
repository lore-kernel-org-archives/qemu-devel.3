Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C6DCFB449
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 16:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxqcU-0006o8-6r; Mon, 07 Oct 2024 12:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sxqcS-0006nL-7w
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:30:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sxqcQ-0007uM-3T
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728318597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MWpaqFztT6vJFysQ3qnmofMl7bo5aV/JsBw22pQ4ozs=;
 b=FSYcqYO93PbHzciGEB9RfBY9iyGtJRiur3A8ba+bh7B3DfubqdJcsfjm+keRM3Rzgfj19Y
 4p64nZQpGs3la1aGF9Hv7kAM3HOQIxGp1JtzjjDsakFvxyWAy7zEjqFqTGrGQIEUlZZq7r
 FMoRxXhDsdaIdpl8zLngFw2K6B21uCw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-5QtcZ1L2M-qX-fAtbUdApw-1; Mon, 07 Oct 2024 12:23:30 -0400
X-MC-Unique: 5QtcZ1L2M-qX-fAtbUdApw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37cd32f9c59so1743855f8f.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 09:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728318209; x=1728923009;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MWpaqFztT6vJFysQ3qnmofMl7bo5aV/JsBw22pQ4ozs=;
 b=bpPpFUVlxI2G5eeHsDRhtuEfZ27djl23sZy1BwR6UaGxs6Xa9od7Y8xkT4aC52f7jz
 NcjAvBlNE0LR9eiPt2/jCTICLsvwwzHW5YlYOS7ZYds6TE54d9b7KW6UBVpI92hnKsO0
 3A/T8v+iy6Iu+YzF7hfJFIQkbEn7nHriXdV+30Kow0ySCgs3PwYOST++f3VGK1tnJM9K
 S1izPbkGwkoLd1MdGqP4PIoFQU0kYigcAkX/lEnXiJAzaB2svoHOYuswrurJ3bAe4jHF
 qT6Mzz7dSbPuRDYiz+c7T6J1UMC7RlzE5a4gW+LXUkjMFrz3bpmD5XXrYGXrPwd+bq4M
 gQ0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/L+2FlkPXJ9yAeVTWMmqZnuxd0sON3AWMqO4SXWCB/PNQXc1YMgEkVadqUAT2vcxBc95r6C7aR3K8@nongnu.org
X-Gm-Message-State: AOJu0Ywx/khQ8+r/gjf27r4By9Vi6J+G8glLNZwKxKc2IMKP8EP1yHLp
 cvzS9I+vwsoeiOK5fMCA/2xN0V+4r5o6fA3gbdRBPRovMhgm1509bAvw/+jURZwa3tcTsu2U0ui
 lp6o+CDwcsJTrN99mK7YkBZVehTCLnN8LAISwZke/oW9AEjWHp/AY
X-Received: by 2002:a5d:5f46:0:b0:37c:cc60:2c63 with SMTP id
 ffacd0b85a97d-37d0e6dab88mr8163615f8f.5.1728318208809; 
 Mon, 07 Oct 2024 09:23:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDWk/ktOBFGRJvZBONByKYslLlAHeSAXyzAyC1kXej3V32hCO94D9bTi1V/+1kXcr8zdWXbQ==
X-Received: by 2002:a5d:5f46:0:b0:37c:cc60:2c63 with SMTP id
 ffacd0b85a97d-37d0e6dab88mr8163586f8f.5.1728318208307; 
 Mon, 07 Oct 2024 09:23:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c725:8700:77c7:bde:9446:8d34?
 (p200300cbc725870077c70bde94468d34.dip0.t-ipconnect.de.
 [2003:cb:c725:8700:77c7:bde:9446:8d34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1695e7e2sm6054417f8f.84.2024.10.07.09.23.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 09:23:27 -0700 (PDT)
Message-ID: <47ba3f75-147d-4ea6-a576-eba6ef168643@redhat.com>
Date: Mon, 7 Oct 2024 18:23:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/13] machine: alloc-anon option
To: Peter Xu <peterx@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-2-git-send-email-steven.sistare@oracle.com>
 <Zv7C7MeVP2X8bEJU@x1n> <2143f803-439e-4b8b-ae92-07caa913d646@redhat.com>
 <Zv_ghrH6i4QOzne8@x1n> <bffa3dc0-36b7-4fa1-a0b6-cce34743a46c@redhat.com>
 <Zv_spkFwqwgxGkNY@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zv_spkFwqwgxGkNY@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 04.10.24 15:24, Peter Xu wrote:
> On Fri, Oct 04, 2024 at 02:54:38PM +0200, David Hildenbrand wrote:
>> On 04.10.24 14:33, Peter Xu wrote:
>>> On Fri, Oct 04, 2024 at 12:14:35PM +0200, David Hildenbrand wrote:
>>>> On 03.10.24 18:14, Peter Xu wrote:
>>>>> On Mon, Sep 30, 2024 at 12:40:32PM -0700, Steve Sistare wrote:
>>>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>>>> on the value of the anon-alloc machine property.  This option applies to
>>>>>> memory allocated as a side effect of creating various devices. It does
>>>>>> not apply to memory-backend-objects, whether explicitly specified on
>>>>>> the command line, or implicitly created by the -m command line option.
>>>>>>
>>>>>> The memfd option is intended to support new migration modes, in which the
>>>>>> memory region can be transferred in place to a new QEMU process, by sending
>>>>>> the memfd file descriptor to the process.  Memory contents are preserved,
>>>>>> and if the mode also transfers device descriptors, then pages that are
>>>>>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>>>>>> for supporting vfio, vdpa, and iommufd devices with the new modes.
>>>>>>
>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>>
>>>>> [Igor seems missing in the loop; added]
>>>>>
>>>>>> ---
>>>>>>     hw/core/machine.c   | 19 +++++++++++++++++++
>>>>>>     include/hw/boards.h |  1 +
>>>>>>     qapi/machine.json   | 14 ++++++++++++++
>>>>>>     qemu-options.hx     | 11 +++++++++++
>>>>>>     system/physmem.c    | 35 +++++++++++++++++++++++++++++++++++
>>>>>>     system/trace-events |  3 +++
>>>>>>     6 files changed, 83 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>>>> index adaba17..a89a32b 100644
>>>>>> --- a/hw/core/machine.c
>>>>>> +++ b/hw/core/machine.c
>>>>>> @@ -460,6 +460,20 @@ static void machine_set_mem_merge(Object *obj, bool value, Error **errp)
>>>>>>         ms->mem_merge = value;
>>>>>>     }
>>>>>> +static int machine_get_anon_alloc(Object *obj, Error **errp)
>>>>>> +{
>>>>>> +    MachineState *ms = MACHINE(obj);
>>>>>> +
>>>>>> +    return ms->anon_alloc;
>>>>>> +}
>>>>>> +
>>>>>> +static void machine_set_anon_alloc(Object *obj, int value, Error **errp)
>>>>>> +{
>>>>>> +    MachineState *ms = MACHINE(obj);
>>>>>> +
>>>>>> +    ms->anon_alloc = value;
>>>>>> +}
>>>>>> +
>>>>>>     static bool machine_get_usb(Object *obj, Error **errp)
>>>>>>     {
>>>>>>         MachineState *ms = MACHINE(obj);
>>>>>> @@ -1078,6 +1092,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
>>>>>>         object_class_property_set_description(oc, "mem-merge",
>>>>>>             "Enable/disable memory merge support");
>>>>>> +    object_class_property_add_enum(oc, "anon-alloc", "AnonAllocOption",
>>>>>> +                                   &AnonAllocOption_lookup,
>>>>>> +                                   machine_get_anon_alloc,
>>>>>> +                                   machine_set_anon_alloc);
>>>>>> +
>>>>>>         object_class_property_add_bool(oc, "usb",
>>>>>>             machine_get_usb, machine_set_usb);
>>>>>>         object_class_property_set_description(oc, "usb",
>>>>>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>>>>>> index 5966069..5a87647 100644
>>>>>> --- a/include/hw/boards.h
>>>>>> +++ b/include/hw/boards.h
>>>>>> @@ -393,6 +393,7 @@ struct MachineState {
>>>>>>         bool enable_graphics;
>>>>>>         ConfidentialGuestSupport *cgs;
>>>>>>         HostMemoryBackend *memdev;
>>>>>> +    AnonAllocOption anon_alloc;
>>>>>>         /*
>>>>>>          * convenience alias to ram_memdev_id backend memory region
>>>>>>          * or to numa container memory region
>>>>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>>>>> index a6b8795..d4a63f5 100644
>>>>>> --- a/qapi/machine.json
>>>>>> +++ b/qapi/machine.json
>>>>>> @@ -1898,3 +1898,17 @@
>>>>>>     { 'command': 'x-query-interrupt-controllers',
>>>>>>       'returns': 'HumanReadableText',
>>>>>>       'features': [ 'unstable' ]}
>>>>>> +
>>>>>> +##
>>>>>> +# @AnonAllocOption:
>>>>>> +#
>>>>>> +# An enumeration of the options for allocating anonymous guest memory.
>>>>>> +#
>>>>>> +# @mmap: allocate using mmap MAP_ANON
>>>>>> +#
>>>>>> +# @memfd: allocate using memfd_create
>>>>>> +#
>>>>>> +# Since: 9.2
>>>>>> +##
>>>>>> +{ 'enum': 'AnonAllocOption',
>>>>>> +  'data': [ 'mmap', 'memfd' ] }
>>>>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>>>>> index d94e2cb..90ab943 100644
>>>>>> --- a/qemu-options.hx
>>>>>> +++ b/qemu-options.hx
>>>>>> @@ -38,6 +38,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>>>>>>         "                nvdimm=on|off controls NVDIMM support (default=off)\n"
>>>>>>         "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
>>>>>>         "                hmat=on|off controls ACPI HMAT support (default=off)\n"
>>>>>> +    "                anon-alloc=mmap|memfd allocate anonymous guest RAM using mmap MAP_ANON or memfd_create (default: mmap)\n"
>>>>>>         "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
>>>>>>         "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n",
>>>>>>         QEMU_ARCH_ALL)
>>>>>> @@ -101,6 +102,16 @@ SRST
>>>>>>             Enables or disables ACPI Heterogeneous Memory Attribute Table
>>>>>>             (HMAT) support. The default is off.
>>>>>> +    ``anon-alloc=mmap|memfd``
>>>>>> +        Allocate anonymous guest RAM using mmap MAP_ANON (the default)
>>>>>> +        or memfd_create.  This option applies to memory allocated as a
>>>>>> +        side effect of creating various devices. It does not apply to
>>>>>> +        memory-backend-objects, whether explicitly specified on the
>>>>>> +        command line, or implicitly created by the -m command line
>>>>>> +        option.
>>>>>> +
>>>>>> +        Some migration modes require anon-alloc=memfd.
>>>>>> +
>>>>>>         ``memory-backend='id'``
>>>>>>             An alternative to legacy ``-mem-path`` and ``mem-prealloc`` options.
>>>>>>             Allows to use a memory backend as main RAM.
>>>>>> diff --git a/system/physmem.c b/system/physmem.c
>>>>>> index dc1db3a..174f7e0 100644
>>>>>> --- a/system/physmem.c
>>>>>> +++ b/system/physmem.c
>>>>>> @@ -47,6 +47,7 @@
>>>>>>     #include "qemu/qemu-print.h"
>>>>>>     #include "qemu/log.h"
>>>>>>     #include "qemu/memalign.h"
>>>>>> +#include "qemu/memfd.h"
>>>>>>     #include "exec/memory.h"
>>>>>>     #include "exec/ioport.h"
>>>>>>     #include "sysemu/dma.h"
>>>>>> @@ -69,6 +70,8 @@
>>>>>>     #include "qemu/pmem.h"
>>>>>> +#include "qapi/qapi-types-migration.h"
>>>>>> +#include "migration/options.h"
>>>>>>     #include "migration/vmstate.h"
>>>>>>     #include "qemu/range.h"
>>>>>> @@ -1849,6 +1852,35 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>>>>>>                     qemu_mutex_unlock_ramlist();
>>>>>>                     return;
>>>>>>                 }
>>>>>> +
>>>>>> +        } else if (current_machine->anon_alloc == ANON_ALLOC_OPTION_MEMFD &&
>>>>>> +                   !object_dynamic_cast(new_block->mr->parent_obj.parent,
>>>>>> +                                        TYPE_MEMORY_BACKEND)) {
>>>>>
>>>>> This is pretty fragile.. if someone adds yet another layer on top of memory
>>>>> backend objects, the ownership links can change and this might silently run
>>>>> into something else even without any warning..
>>>>>
>>>>> I wished we dig into what is missing, but maybe that's too trivial.  If
>>>>> not, we still need to make this as solid.  Perhaps that can be a ram flag
>>>>> and let relevant callers pass in that flag explicitly.
>>>>
>>>> How would they decide whether or not we want to set the flag in the current
>>>> configuration?
>>>
>>> It was in the previous email where it got cut..  I listed four paths that
>>> may need change.
>>
>> That's not my question. Who would decide whether we want to set MAP_SHARED
>> in these callers or not?
>>
>> If you have "unconditionally" in mind, I think it's a bad idea. If there is
>> some other toggle to perform that setting conditionally, why not.
> 
> Yes I thought it could be unconditionally.  We can discuss downside below,
> I think we can still use a new flag otherwise, but the idea would be the
> same, where I want the flag to be explicit in the callers not implicitly
> with the object type check, which I think can be hackish.

I agree that the caller should specify it.

But I don't think using shared memory where shared memory is not 
warranted is a reasonable approach.

I'm quite surprise you're considering such changes with unclear impacts 
on other OSes besides Linux (Freedbsd? Windows that doeasn';t even 
support shared memory?) just to make one corner-case QEMU use case happy.

But I'm sure there are valid reasons why you had that idea, so I'm happy 
to learn why using shared memory unconditionally here is better than 
providing a clean alternative path with the feature enabled and memfd 
actually being supported on the setup (e.g., newer Linux kernel).

> 
>>
>>>
>>>>
>>>>>
>>>>> I think RAM_SHARED can actually be that flag already - I mean, in all paths
>>>>> that we may create anon mem (but not memory-backend-* objects), is it
>>>>> always safe we always switch to RAM_SHARED from anon?
>>>>
>>>> Do you mean only setting the flag (-> anonymous shmem) or switching also to
>>>> memfd, which is a bigger change?
>>>
>>> Switching to memfd.  I thought anon shmem (mmap(MAP_SHARED)) is mostly the
>>> same internally, if we create memfd then mmap(MAP_SHARED) on top of it, no?
>>
>> Memfd is Linux specific, keep that in mind. Apart from that there shouldn't
>> be much difference between anon shmem and memfd (there are memory commit
>> differences, though).
> 
> Could you elaborate the memory commit difference and what does that imply
> to QEMU's usage?

Note how memfd code passed VM_NORESERVE to shmem_file_setup() and 
shmem_zero_setup() effectively doesn't (unless MAP_NORESERVE was 
specified IIRC).

Not sure if the change makes a big impact in QEMU's usage, it's just one 
of these differences between memfd and shared anonymous memory. 
(responding to your "mostly the same").

> 
>>
>> Of course, there is a difference between anon memory and shmem, for example
>> regarding what viritofsd faced (e.g., KSM) recently.
> 
> The four paths shouldn't be KSM target, AFAICT.

Do you have a good overview of what is deduplicated in practice and why 
these don't apply? For example, I thought these functions are also used 
for hosting the BIOS, and that might just be deduplciated between VMs?

Anyhow, there are obviously other differences with shmem vs. anonymous 
(THP handling, page fault performance, userfaultfd compatibility on 
older kernels) at least on Linux, but I have absolutely no clue how that 
would differ on other host OSes.

None of them are major

This is probably going to result in a bigger discussion, for which I 
don't have any time. So my opinion on it is above.

Anyhow, this sounds like one of the suggestions I wouldn't suggest Steve 
to actually implement.


-- 
Cheers,

David / dhildenb


