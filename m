Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA32CFA775
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 12:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swhpY-0007hv-Px; Fri, 04 Oct 2024 08:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1swhpW-0007he-Q2
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 08:54:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1swhpU-0006kk-Uj
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 08:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728046483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=msHAd5aAEyYHpBcMiGh4PkaZ1rKZkZeygsPekaasJFw=;
 b=Fcq6Lza85IeOe5Q/iuR2tgt5ccZZ4218GnyUg6aD4iYGd+sbz++G7rxdVw9C4pKi3JBz/Y
 ISHVONCNZzPXD9dGijn9e0cJO1BpJD9DOhVE509Dk17rp9jOlc1J/SORcoqGVW1q2pbrne
 3mVsKeF87wmKA6ccLOFCxvR1T0pCG58=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-0heB3-mKP9KW9BYACsPX7w-1; Fri, 04 Oct 2024 08:54:42 -0400
X-MC-Unique: 0heB3-mKP9KW9BYACsPX7w-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37cdb0e9eb7so826091f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 05:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728046481; x=1728651281;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=msHAd5aAEyYHpBcMiGh4PkaZ1rKZkZeygsPekaasJFw=;
 b=S3hs8WrGco6vTF7eN15iVyf2mp+vSBHJEP/FFHSukXOUW5wVELiyPS3IPzWV13+PTj
 TsYK9a+QjFochdgaM6/oQMTtoumr8x3/7gEio1trXkWz0xZJUT9LHxZw1BYRoQRKmwNv
 QvmTPOe6oEASXtbSYfQ/IFZW6h5XjB8h4QapzfEB52flD2syU6T2loJNTSfaVUaDOdwv
 C0BNN+lKnCf4mSidWxuV1GEIH/znadOsTZ/tCdgPOURwR108sYP+6qKTnuvq5FQNU7a5
 tOrefHPwpkg4g4cyyj66NgEth0DVvtEIhDr0qldcUGcbRiCqu964i0rOUyetDAbj1zXw
 pGpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgv54OTr/GM0MOLstAWpTJFVz7IyLVt5QzGmBiRw8lT9albODw7RJUGDBW0zmRmPKn11e3UMDD01TX@nongnu.org
X-Gm-Message-State: AOJu0YwV/Oipsx5+bWcwuZfAztTdfCcdmlqZY0uohpglnh+GwND6Q47S
 NORSg2/nLl5ITcon5BTaTfavqXAFxxCiCFYDV6/WSt+uweNn4pNlz/J/dgMXspELHyNYRikanN+
 G2ilbbq8dPRvGN7i4gTgTSpRGOj876oJa7Qu4jkA3nzXoY5RSgFtF
X-Received: by 2002:a5d:510e:0:b0:37c:c4d3:b9c8 with SMTP id
 ffacd0b85a97d-37d0e717a7dmr1622335f8f.18.1728046481236; 
 Fri, 04 Oct 2024 05:54:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU1q0ZQ9GYl7XEa8tVAQKC/O+SJug1knx7gK1xQ1s4bJa8DT25NggMKq7jOZzs6JrzUWGW1w==
X-Received: by 2002:a5d:510e:0:b0:37c:c4d3:b9c8 with SMTP id
 ffacd0b85a97d-37d0e717a7dmr1622317f8f.18.1728046480823; 
 Fri, 04 Oct 2024 05:54:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c714:d00:a1ab:bff4:268f:d7c5?
 (p200300cbc7140d00a1abbff4268fd7c5.dip0.t-ipconnect.de.
 [2003:cb:c714:d00:a1ab:bff4:268f:d7c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d081f70a6sm3216498f8f.11.2024.10.04.05.54.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 05:54:40 -0700 (PDT)
Message-ID: <bffa3dc0-36b7-4fa1-a0b6-cce34743a46c@redhat.com>
Date: Fri, 4 Oct 2024 14:54:38 +0200
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
 <Zv_ghrH6i4QOzne8@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zv_ghrH6i4QOzne8@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
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

On 04.10.24 14:33, Peter Xu wrote:
> On Fri, Oct 04, 2024 at 12:14:35PM +0200, David Hildenbrand wrote:
>> On 03.10.24 18:14, Peter Xu wrote:
>>> On Mon, Sep 30, 2024 at 12:40:32PM -0700, Steve Sistare wrote:
>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>> on the value of the anon-alloc machine property.  This option applies to
>>>> memory allocated as a side effect of creating various devices. It does
>>>> not apply to memory-backend-objects, whether explicitly specified on
>>>> the command line, or implicitly created by the -m command line option.
>>>>
>>>> The memfd option is intended to support new migration modes, in which the
>>>> memory region can be transferred in place to a new QEMU process, by sending
>>>> the memfd file descriptor to the process.  Memory contents are preserved,
>>>> and if the mode also transfers device descriptors, then pages that are
>>>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>>>> for supporting vfio, vdpa, and iommufd devices with the new modes.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>
>>> [Igor seems missing in the loop; added]
>>>
>>>> ---
>>>>    hw/core/machine.c   | 19 +++++++++++++++++++
>>>>    include/hw/boards.h |  1 +
>>>>    qapi/machine.json   | 14 ++++++++++++++
>>>>    qemu-options.hx     | 11 +++++++++++
>>>>    system/physmem.c    | 35 +++++++++++++++++++++++++++++++++++
>>>>    system/trace-events |  3 +++
>>>>    6 files changed, 83 insertions(+)
>>>>
>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>> index adaba17..a89a32b 100644
>>>> --- a/hw/core/machine.c
>>>> +++ b/hw/core/machine.c
>>>> @@ -460,6 +460,20 @@ static void machine_set_mem_merge(Object *obj, bool value, Error **errp)
>>>>        ms->mem_merge = value;
>>>>    }
>>>> +static int machine_get_anon_alloc(Object *obj, Error **errp)
>>>> +{
>>>> +    MachineState *ms = MACHINE(obj);
>>>> +
>>>> +    return ms->anon_alloc;
>>>> +}
>>>> +
>>>> +static void machine_set_anon_alloc(Object *obj, int value, Error **errp)
>>>> +{
>>>> +    MachineState *ms = MACHINE(obj);
>>>> +
>>>> +    ms->anon_alloc = value;
>>>> +}
>>>> +
>>>>    static bool machine_get_usb(Object *obj, Error **errp)
>>>>    {
>>>>        MachineState *ms = MACHINE(obj);
>>>> @@ -1078,6 +1092,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
>>>>        object_class_property_set_description(oc, "mem-merge",
>>>>            "Enable/disable memory merge support");
>>>> +    object_class_property_add_enum(oc, "anon-alloc", "AnonAllocOption",
>>>> +                                   &AnonAllocOption_lookup,
>>>> +                                   machine_get_anon_alloc,
>>>> +                                   machine_set_anon_alloc);
>>>> +
>>>>        object_class_property_add_bool(oc, "usb",
>>>>            machine_get_usb, machine_set_usb);
>>>>        object_class_property_set_description(oc, "usb",
>>>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>>>> index 5966069..5a87647 100644
>>>> --- a/include/hw/boards.h
>>>> +++ b/include/hw/boards.h
>>>> @@ -393,6 +393,7 @@ struct MachineState {
>>>>        bool enable_graphics;
>>>>        ConfidentialGuestSupport *cgs;
>>>>        HostMemoryBackend *memdev;
>>>> +    AnonAllocOption anon_alloc;
>>>>        /*
>>>>         * convenience alias to ram_memdev_id backend memory region
>>>>         * or to numa container memory region
>>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>>> index a6b8795..d4a63f5 100644
>>>> --- a/qapi/machine.json
>>>> +++ b/qapi/machine.json
>>>> @@ -1898,3 +1898,17 @@
>>>>    { 'command': 'x-query-interrupt-controllers',
>>>>      'returns': 'HumanReadableText',
>>>>      'features': [ 'unstable' ]}
>>>> +
>>>> +##
>>>> +# @AnonAllocOption:
>>>> +#
>>>> +# An enumeration of the options for allocating anonymous guest memory.
>>>> +#
>>>> +# @mmap: allocate using mmap MAP_ANON
>>>> +#
>>>> +# @memfd: allocate using memfd_create
>>>> +#
>>>> +# Since: 9.2
>>>> +##
>>>> +{ 'enum': 'AnonAllocOption',
>>>> +  'data': [ 'mmap', 'memfd' ] }
>>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>>> index d94e2cb..90ab943 100644
>>>> --- a/qemu-options.hx
>>>> +++ b/qemu-options.hx
>>>> @@ -38,6 +38,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>>>>        "                nvdimm=on|off controls NVDIMM support (default=off)\n"
>>>>        "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
>>>>        "                hmat=on|off controls ACPI HMAT support (default=off)\n"
>>>> +    "                anon-alloc=mmap|memfd allocate anonymous guest RAM using mmap MAP_ANON or memfd_create (default: mmap)\n"
>>>>        "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
>>>>        "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n",
>>>>        QEMU_ARCH_ALL)
>>>> @@ -101,6 +102,16 @@ SRST
>>>>            Enables or disables ACPI Heterogeneous Memory Attribute Table
>>>>            (HMAT) support. The default is off.
>>>> +    ``anon-alloc=mmap|memfd``
>>>> +        Allocate anonymous guest RAM using mmap MAP_ANON (the default)
>>>> +        or memfd_create.  This option applies to memory allocated as a
>>>> +        side effect of creating various devices. It does not apply to
>>>> +        memory-backend-objects, whether explicitly specified on the
>>>> +        command line, or implicitly created by the -m command line
>>>> +        option.
>>>> +
>>>> +        Some migration modes require anon-alloc=memfd.
>>>> +
>>>>        ``memory-backend='id'``
>>>>            An alternative to legacy ``-mem-path`` and ``mem-prealloc`` options.
>>>>            Allows to use a memory backend as main RAM.
>>>> diff --git a/system/physmem.c b/system/physmem.c
>>>> index dc1db3a..174f7e0 100644
>>>> --- a/system/physmem.c
>>>> +++ b/system/physmem.c
>>>> @@ -47,6 +47,7 @@
>>>>    #include "qemu/qemu-print.h"
>>>>    #include "qemu/log.h"
>>>>    #include "qemu/memalign.h"
>>>> +#include "qemu/memfd.h"
>>>>    #include "exec/memory.h"
>>>>    #include "exec/ioport.h"
>>>>    #include "sysemu/dma.h"
>>>> @@ -69,6 +70,8 @@
>>>>    #include "qemu/pmem.h"
>>>> +#include "qapi/qapi-types-migration.h"
>>>> +#include "migration/options.h"
>>>>    #include "migration/vmstate.h"
>>>>    #include "qemu/range.h"
>>>> @@ -1849,6 +1852,35 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>>>>                    qemu_mutex_unlock_ramlist();
>>>>                    return;
>>>>                }
>>>> +
>>>> +        } else if (current_machine->anon_alloc == ANON_ALLOC_OPTION_MEMFD &&
>>>> +                   !object_dynamic_cast(new_block->mr->parent_obj.parent,
>>>> +                                        TYPE_MEMORY_BACKEND)) {
>>>
>>> This is pretty fragile.. if someone adds yet another layer on top of memory
>>> backend objects, the ownership links can change and this might silently run
>>> into something else even without any warning..
>>>
>>> I wished we dig into what is missing, but maybe that's too trivial.  If
>>> not, we still need to make this as solid.  Perhaps that can be a ram flag
>>> and let relevant callers pass in that flag explicitly.
>>
>> How would they decide whether or not we want to set the flag in the current
>> configuration?
> 
> It was in the previous email where it got cut..  I listed four paths that
> may need change.

That's not my question. Who would decide whether we want to set 
MAP_SHARED in these callers or not?

If you have "unconditionally" in mind, I think it's a bad idea. If there 
is some other toggle to perform that setting conditionally, why not.

> 
>>
>>>
>>> I think RAM_SHARED can actually be that flag already - I mean, in all paths
>>> that we may create anon mem (but not memory-backend-* objects), is it
>>> always safe we always switch to RAM_SHARED from anon?
>>
>> Do you mean only setting the flag (-> anonymous shmem) or switching also to
>> memfd, which is a bigger change?
> 
> Switching to memfd.  I thought anon shmem (mmap(MAP_SHARED)) is mostly the
> same internally, if we create memfd then mmap(MAP_SHARED) on top of it, no?

Memfd is Linux specific, keep that in mind. Apart from that there 
shouldn't be much difference between anon shmem and memfd (there are 
memory commit differences, though).

Of course, there is a difference between anon memory and shmem, for 
example regarding what viritofsd faced (e.g., KSM) recently.

-- 
Cheers,

David / dhildenb


