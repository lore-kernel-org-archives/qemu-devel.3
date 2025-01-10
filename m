Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2BDE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHTl-0007cG-69; Fri, 10 Jan 2025 11:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tWHSn-0007FL-T1
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tWHSj-0004Br-KS
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736524935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IfxVX7+fjghKrEOWwFHCVjmyLVqMv7InmOGTCeicA5s=;
 b=FPOdhvONaQMtN6VK7GjFOKTTY6w3UV38UIxn65zSOSQpPvoOEdwBxgxXhhK7SR2RuAlIHW
 Y1u8zUE4Ow99QxKntqDrB8vEX7k582LdyOHtAPDgbNqb98PNbGrHGR/hG1clXaeqY6ORPd
 3vRM8Ev81d45NiqH+SC3z2KCPTvkpiI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-tV7x5dCZNzi558feIdemWw-1; Fri, 10 Jan 2025 11:02:10 -0500
X-MC-Unique: tV7x5dCZNzi558feIdemWw-1
X-Mimecast-MFC-AGG-ID: tV7x5dCZNzi558feIdemWw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43619b135bcso11407185e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736524929; x=1737129729;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IfxVX7+fjghKrEOWwFHCVjmyLVqMv7InmOGTCeicA5s=;
 b=DTOTjMQSEkV6OptXc0gdoHMsk7r7/+OMF9T4ozJAtdJrfIh8gDlbgGGojD3j2FSTq0
 xzgHZ2rDYj/2JEqnG8KQCvPHmhVMj+tz7ae+bBOwTV3BQDHcH27KbFOn8JM9kWOSLGgl
 YPKBaJfJoQO/4TYdm5kY8Ldb171M+LREg1d3B8QuQuH8e01Vy0BCSyvsoV5xWtuoqCne
 dYPKYZQU06/3t9+Szbysk4kUMnDhro7n88MyAytrX+pJPr5Mk5emVpVZhHSh95LQjcML
 BbjRBzOQ7LxgdMXDpHB0N+hU+MRxupiGNcvW2KdI6BHVikwkxVvUKb9/5igeRMLNet4o
 CIMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9ok58sswUXnKHewwS2914DZl951HBuaTo9iDXbObIF53aqiesd2LiDx4UjbMhaem88AOCI09jusjy@nongnu.org
X-Gm-Message-State: AOJu0Yzdt2mLR6m+llgMy2tHFzOecUVaUX/zh+xjcYP/vffebtKTU8KU
 i33ohJxAnIboxJSgq6Ndmm+BtSGwD8dXu819UThlLxa2cR2wrT7Q6AWaOfmPcm6JZXETUIk1LY9
 6RKM6N4esA9tdH5edXRQAcjTPNDwxzktyJwwPTyummxCv68u/eBQ4
X-Gm-Gg: ASbGnctuLYipE7XMTq38WVes/YbIf4/qHKBBYYn+yVPsw03JhKESHS2E/XgnvucP1hT
 rT7r9ORAi5ncN7hPm3gveqNPj18jCFTF00mbFSx8FoxBW8QIffqnoC8TQPXIYHwU02G7LWB7OjT
 nGDoOSQ16WNNIH6mxKYAFMNEGukppPJL+d6how9m5jjPfNOetRCss210R0BNtAB/YdwMSBr2MWY
 VtPqRCBeHOsUAx1HTZNM0g/cqkSLXXEjx5TDT3Sbe39OSnDIsZcz/P+eFx4eBDcLmwgxf4KGns5
 RfN8Nvs4rlloYVP4fAN6Hv8pwTBG4yYTr2iPcSM81qk5llfZdDsKJ/lAY3DW90Y4S2tsPSL6+eA
 I+g9JA8t7
X-Received: by 2002:a05:600c:1ca9:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-436e2551d7bmr112560865e9.0.1736524929451; 
 Fri, 10 Jan 2025 08:02:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5GDUMfS24XwIpL41dkDJQF8NTrKvbgoAPTHeff5XlCj2DM41LKisnhVErmFdzvoO89SLDhA==
X-Received: by 2002:a05:600c:1ca9:b0:435:136:75f6 with SMTP id
 5b1f17b1804b1-436e2551d7bmr112558385e9.0.1736524927447; 
 Fri, 10 Jan 2025 08:02:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:e100:4f41:ff29:a59f:8c7a?
 (p200300cbc708e1004f41ff29a59f8c7a.dip0.t-ipconnect.de.
 [2003:cb:c708:e100:4f41:ff29:a59f:8c7a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e62116sm55551845e9.35.2025.01.10.08.02.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 08:02:06 -0800 (PST)
Message-ID: <a496369e-69c8-4398-961e-afabdc69317f@redhat.com>
Date: Fri, 10 Jan 2025 17:02:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] physmem: allow cpu_memory_rw_debug to write to MMIO
 devices
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Zabka <git@zabka.it>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20241220195923.314208-1-git@zabka.it>
 <a9313931-a41e-46e1-b8b9-d2cc83cd663c@redhat.com>
 <44f99f89-edb6-4007-a367-f7f3b9e10b7b@zabka.it>
 <b36f85c4-4f1b-4721-bab5-56e89550f421@redhat.com>
 <f1d67bea-7389-40c3-a304-6cec459a2f49@zabka.it>
 <4aa676ea-331f-4c8b-be1d-208804ede674@redhat.com>
 <CAFEAcA_2CEJKFyjvbwmpt=on=GgMVamQ5hiiVt+zUr6AY3X=Xg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAFEAcA_2CEJKFyjvbwmpt=on=GgMVamQ5hiiVt+zUr6AY3X=Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 10.01.25 16:44, Peter Maydell wrote:
> On Wed, 8 Jan 2025 at 20:10, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.01.25 19:35, Stefan Zabka wrote:
>>> On 21/12/2024 15:55, David Hildenbrand wrote:
>>>    > Let's wait for opinions from others first.
>>>
>>> <https://www.qemu.org/docs/master/devel/submitting-a-patch.html#if-your-patch-seems-to-have-been-ignored>
>>> states that two weeks is a reasonable amount of time for follow-up.
>>>
>>> Should I also ping the original patch? I thought pinging the thread
>>> would be more appropriate, as it contains relevant information.
>>>
>>
>> I just pushed a compiling version of the attrs.debug approach to:
>>
>>          https://github.com/davidhildenbrand/qemu/tree/debug_access
> 
> I think this approach (having a 'debug' attribute in the MemTxAttrs
> seems reasonable. I do note that if we allow this kind of access
> to write to MMIO devices then we are also permitting ELF (and other)
> image loads to write to MMIO devices where currently we ignore those.

Right. The "debug" access semantics will change for all users.

> That means there's probably a class of guest images (of dubious
> correctness) which will start writing junk (likely zeroes) into
> device model registers; we previously would silently ignore any
> such bogus ELF sections.

Do you have any specific instances in mind that we could try?

> 
> Q: should we suggest behaviour for device models if they see a
> 'debug = 1' transaction, e.g. "don't update your internal state
> for a debug read if you have clear-on-read or similar kinds of
> register fields" ?

Not an expert on that, but I assume you mean that we start making use of 
this debug flag also to modify *read* behavior, not only *write* 
behavior. That would make sense to me.

> 
>> With two preparation patches, the relevant patch is:
>>
>>
>>   From 2e85cb1724385e4b8640364415832c030e5c5e6d Mon Sep 17 00:00:00 2001
>> From: David Hildenbrand <david@redhat.com>
>> Date: Wed, 8 Jan 2025 20:58:00 +0100
>> Subject: [PATCH] physmem: allow cpu_memory_rw_debug to write to MMIO devices
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    hw/core/cpu-sysemu.c    | 13 +++++++++----
>>    include/exec/memattrs.h |  5 ++++-
>>    include/exec/memory.h   |  2 ++
>>    system/physmem.c        |  9 ++-------
>>    4 files changed, 17 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/core/cpu-sysemu.c b/hw/core/cpu-sysemu.c
>> index 2a9a2a4eb5..0aa0a569e4 100644
>> --- a/hw/core/cpu-sysemu.c
>> +++ b/hw/core/cpu-sysemu.c
>> @@ -51,13 +51,18 @@ hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
>>                                         MemTxAttrs *attrs)
>>    {
>>        CPUClass *cc = CPU_GET_CLASS(cpu);
>> +    hwaddr paddr;
>>
>>        if (cc->sysemu_ops->get_phys_page_attrs_debug) {
>> -        return cc->sysemu_ops->get_phys_page_attrs_debug(cpu, addr, attrs);
>> +        paddr = cc->sysemu_ops->get_phys_page_attrs_debug(cpu, addr, attrs);
>> +    } else {
>> +        /* Fallback for CPUs which don't implement the _attrs_ hook */
>> +        *attrs = MEMTXATTRS_UNSPECIFIED;
>> +        paddr = cc->sysemu_ops->get_phys_page_debug(cpu, addr);
>>        }
>> -    /* Fallback for CPUs which don't implement the _attrs_ hook */
>> -    *attrs = MEMTXATTRS_UNSPECIFIED;
>> -    return cc->sysemu_ops->get_phys_page_debug(cpu, addr);
>> +    /* Indicate that this is a debug access. */
>> +    attrs->debug = 1;
>> +    return paddr;
>>    }
>>
>>    hwaddr cpu_get_phys_page_debug(CPUState *cpu, vaddr addr)
>> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
>> index e27c18f3dc..14e0edaa58 100644
>> --- a/include/exec/memattrs.h
>> +++ b/include/exec/memattrs.h
>> @@ -26,7 +26,8 @@ typedef struct MemTxAttrs {
>>        /* Bus masters which don't specify any attributes will get this
>>         * (via the MEMTXATTRS_UNSPECIFIED constant), so that we can
>>         * distinguish "all attributes deliberately clear" from
>> -     * "didn't specify" if necessary.
>> +     * "didn't specify" if necessary. "debug" can be set alongside
>> +     * "unspecified".
>>         */
> 
> This feels like one of those changes which is "*probably* OK,
> but breaks a thing that was previously an invariant" ones.
> But trying to get all targets to support reporting real
> attributes is probably too long a side-quest (we can't really
> do it in cpu_get_phys_page_attrs_debug() because I don't think
> we have a pre-existing way to ask the target "are you in usermode
> now"; the rest of the fields we could validly leave 0).

Yes, and having this as part of MemTxAttrs looked cleaner than passing 
yet another flag (bool debug) around.

> 
>>        unsigned int unspecified:1;
>>        /*
>> @@ -50,6 +51,8 @@ typedef struct MemTxAttrs {
>>         * (see MEMTX_ACCESS_ERROR).
>>         */
>>        unsigned int memory:1;
>> +    /* Debug access that can even write to ROM. */
>> +    unsigned int debug:1;
>>        /* Requester ID (for MSI for example) */
>>        unsigned int requester_id:16;
>>
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index 3dcadcf3a2..7458082455 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -2990,6 +2990,8 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write,
>>                                               MemTxAttrs attrs)
>>    {
>>        if (is_write) {
>> +        if (attrs.debug)
>> +            return memory_region_is_ram(mr) || memory_region_is_romd(mr);
> 
> It's a bit weird that the condition for "debug access can write"
> is not the same as the one for "debug access can read"...

True, for now I copied what the write_rom function would have done.

Now I wonder why we don't allow read-access to 
memory_region_is_ram_device. Does anybody know why?

Either that one is wrong, or the write_rom function should have also 
ignored it.

Likely we should do here

if (attrs.debug) {
	return memory_region_is_ram(mr) || memory_region_is_romd(mr);
} else if (is_write) {
	...
}


Thanks!

-- 
Cheers,

David / dhildenb


