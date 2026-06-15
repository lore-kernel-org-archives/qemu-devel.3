Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AB3CD98DE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 21:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZEtv-0003XD-VH; Mon, 15 Jun 2026 17:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZEtt-0003W4-1F
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 17:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZEtq-0006f8-0f
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 17:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781559075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ivSaEK0TXft5+28qRwf8wPm3vPTIZg3s6PdoccqhlI0=;
 b=cagY8O4oWVCSSOkX15S6UHIJCC95GEYel/Y9MHASy0YRvyCzfXCHEKdBeOvLhgaDdFi7fS
 ZFU5iXMeJcDNbwvJAKUJLphznsgfbc3i69RtKNYq7CZ65tOvFjD4RNjk4Jf3MdLjXn4NwI
 0iQE19vlJZgb+JcjdKPJJY+xunXM92o=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-BnKXJGVpPHuVf-lpzIZ4KA-1; Mon, 15 Jun 2026 17:31:14 -0400
X-MC-Unique: BnKXJGVpPHuVf-lpzIZ4KA-1
X-Mimecast-MFC-AGG-ID: BnKXJGVpPHuVf-lpzIZ4KA_1781559074
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c2b64850easo24906655ad.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 14:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781559074; x=1782163874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ivSaEK0TXft5+28qRwf8wPm3vPTIZg3s6PdoccqhlI0=;
 b=Qdmg/3TWJZqkSJMVV0NSl2JVxQNt0ga8OOIU+BcgxmhVjfd9ZgQLJcJzQWUlee9yt0
 Lr/t0Xg0XB9VTEYSvnKr5nfekpjFjxeM0YFmdGky24N1CmRJlzbiGAAowembQ5ZubhRt
 uoFdnCxNIb7d0Dpu2WR/RhP9fv0hxhtZtLopohsbQVdqP3OH19MI9rtrEfrxnOx2cdvV
 +G8WVL3iPVcZ68LJnRynoEtYSll6xaXBZVMYTJHbN1zb7eDPt+jFuJ86365/fLHgLGGF
 hZhcJryXiLdC1Np+Vyg1obYRhBWo1ktNScp3407UYaY78xyzy0hcoscmMNgs9R4K283A
 u/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781559074; x=1782163874;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ivSaEK0TXft5+28qRwf8wPm3vPTIZg3s6PdoccqhlI0=;
 b=OiLgMuo8ErjiG/M9l4waSk7GFNQDNyKybi8ySPzw4z7LXady836Kq20h3uSBHe2Cxj
 sl3kNY2YsrSlJZh2KBLHRMbDgWZeykWhjDKgE6BV5r7Q5OMIVBwZjXU/MGwW/JwHO96q
 kALjiTfz6vbYCnyESAhn+kWv4K+LO0h7SzSm+Ug/mNm7Gr5t0uB2KHYWfi4DPM9eZYJC
 7xHueFNlOglbvSC1D4D+4cHQv2Oa0sDcx69MfeNqT3wQOdFgWJa3dnbKShKHALhGac1A
 nNqOhkU+hnMb3ecRLrcEzjZHvJkIr3JREPhshQuzhKzX8zzNAAL4GtqT852dy9bmUgZE
 88Eg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9C/L43lPMcV85OCPUgJnBoO8XjbAj8jbPyHZ40ca2FkPpjkJo2WtXfmf2hipiiV9HwcLX+16Sqk7Kx@nongnu.org
X-Gm-Message-State: AOJu0YyHlQHx4gx7oysU4TaZXnlB98Ua84Lc76LWWrus+og/3PHZ9Zs4
 sZQLqEXCf/G8iuWRDwmijKGGRX2OC3FbzjAPbOzUz9G1mUrUJCWt5APBRkzYhcChLcwUsvTo3pq
 ISWECVYA1Ea4CkxEeCJHtOtbMweGbP4Et8QlnHL9xs6ZImWRnZdHDcPya
X-Gm-Gg: Acq92OHJVypeqaiz4qlZDHAfXgXmb6Lx2Q3WDhaov3ODroW2IS6VHvYfjeJYvPJZYp9
 xzNWBAwjqcmrhKFxMembxt9WGOPAEntK5/XbgqE1L9VYL3+AQUrCU77ODPltscfn7gBE95hQ49Q
 OEnF9JMPNyBEopaYZHzAIpOSiMZ17aQ7nMbbD028trAzcOhycpgT2nNzEnOCaAU4s0waXcwq3zX
 C8Mt92YJNA8f57Df+/l9YDoLiiAh8cbE8lpo+f8CJWqI04XNUiACiesm3yJh0NExIQjZAXoZFYU
 jqY+G4w9Lp6dl44ZtOT8m4JPmHm+7SAJIfUeRVuKhEkaQZqQ2je46fjBPeO/sHkJYFFjOIIC6WD
 ABY7HbKRUoCnNjW2+TKIDPYxJY3uqu6f7S/kEyGlPfapbXlyIfYsxvfgz+KJvDZGR
X-Received: by 2002:a17:903:228b:b0:2c0:a711:534 with SMTP id
 d9443c01a7336-2c6641baf51mr135207395ad.13.1781559073561; 
 Mon, 15 Jun 2026 14:31:13 -0700 (PDT)
X-Received: by 2002:a17:903:228b:b0:2c0:a711:534 with SMTP id
 d9443c01a7336-2c6641baf51mr135206945ad.13.1781559073007; 
 Mon, 15 Jun 2026 14:31:13 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4328abe7bsm105965675ad.49.2026.06.15.14.31.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 14:31:12 -0700 (PDT)
Message-ID: <22d55870-b521-4002-add7-791bce8ea96a@redhat.com>
Date: Tue, 16 Jun 2026 07:31:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, alex@shazbot.org,
 richard.henderson@linaro.org, berrange@redhat.com, philmd@oss.qualcomm.com,
 philmd@mailo.com, david@kernel.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
 <CAFEAcA9CT6E8dhEV7Ek6ruT_o2dKUf==2V+U-1WFDOLtYbgeeQ@mail.gmail.com>
 <20260615105556-mutt-send-email-mst@kernel.org>
 <CAFEAcA9Gi43qNZoZcGtq8ioffGwOc_XuhoFAjGx7-bt4U8qfxw@mail.gmail.com>
 <e399ceb9-bc4a-4ba6-8efd-ed2742d0853b@redhat.com>
 <20260615154054-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260615154054-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/16/26 5:42 AM, Michael S. Tsirkin wrote:
> On Tue, Jun 16, 2026 at 05:24:15AM +1000, Gavin Shan wrote:
>> Hi Peter and Michael,
>>
>> On 6/16/26 1:12 AM, Peter Maydell wrote:
>>> On Mon, 15 Jun 2026 at 15:56, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>
>>>> On Mon, Jun 15, 2026 at 11:57:09AM +0100, Peter Maydell wrote:
>>>>> On Mon, 15 Jun 2026 at 11:03, Gavin Shan <gshan@redhat.com> wrote:
>>>>>>
>>>>>> All ram device regions were turned to be indirectly accessible by commit
>>>>>> 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
>>>>>> to guest hang on attempt to build 'cuda-samples' as reported by Julia. The
>>>>>> guest is started by the following command lines, with GH100 GPU card passed
>>>>>> from the host.
>>>>>
>>>>>> diff --git a/include/system/memory.h b/include/system/memory.h
>>>>>> index 1417132f6d..5878727d09 100644
>>>>>> --- a/include/system/memory.h
>>>>>> +++ b/include/system/memory.h
>>>>>> @@ -2897,6 +2897,8 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
>>>>>>    void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
>>>>>>
>>>>>>    /* Internal functions, part of the implementation of address_space_read.  */
>>>>>> +void qemu_ram_copy(void *dest, const void *src, size_t n);
>>>>>> +void qemu_ram_move(void *dest, const void *src, size_t n);
>>>>>
>>>>> New function prototypes in include headers need documentation comments.
>>>>>
>>>>> In particular for these, it's really important that we clearly say
>>>>> what semantics we are attempting to provide with them, so that
>>>>> (a) when we're reviewing or later updating the implementation we
>>>>> know what we are trying to provide
>>>>> (b) when we're looking at the callsites we know what the function
>>>>> is guaranteeing to us and what it is not, and thus whether it's
>>>>> OK to use it or we need something els.
>>>>>
>>>>>> +#if defined(__i386__) || defined(__x86_64__)
>>>>>> +#define HOST_UNALIGNED_MMIO_OK 1
>>>>>> +#else
>>>>>> +#define HOST_UNALIGNED_MMIO_OK 0
>>>>>> +#endif
>>>>>
>>>>> We need to do something better than this. We can't
>>>>> just say "oh, we trust that on x86 this works": it is
>>>>> neither actually true that the compiler guarantees it
>>>>
>>>> sorry guarantee what?
>>>
>>> Well, that's part of my point about "we need a doc comment":
>>> what exactly are we trying to guarantee ? But whatever it is,
>>> "hardcoded ifdef that privileges x86" is definitely the wrong
>>> answer.
>>>
>>
>> Could you please check the following comments (documentation context) for the
>> added functions look good to you? Please let me know if there are anything
>> can be improved.
>>
>> +
>> +/**
>> + * qemu_ram_copy: copy data to a RAMBlock
>> + *
>> + * @dest: destination where the data is copied to. It's the pointer returned
>> + *        by ramblock_ptr() and its variants.
>> + * @src: source where the data is copied from. It can be a regular memory block
>> + *       or a pointer returned by ramblock_ptr() and its variants.
>> + * @n: length of data to be copied
>> + *
>> + * The destination is always a pointer to data area of a RAMBlock which can
>> + * be for a regular memory block or a MMIO region. The source can be a pointer
>> + * to a regular memory block or a MMIO region. Atomicity isn't guranteed by
>> + * memcpy() to copy data between those MMIO regions as we do in this function.
>> + * Besides, unaligned accesses are well handled on all architectures except
>> + * i386 and x86_64 where the unaligned accesses are supported by the CPUs.
>> + *
>> + * The ensured atomicity and alignment consideration, which aren't needed
>> + * by data copy between two regular memory blocks. So performance penalty
>> + * is introduced by this function in such circumstance.
>> + */
>> +void qemu_ram_copy(void *dest, const void *src, size_t n);
>> +
>> +/**
>> + * qemu_ram_move: move data to a RAMBlock
>> + *
>> + * @dest: destination where the data is moved to. It's the pointer returned
>> + *        by ramblock_ptr() and its variants.
>> + * @src: source where the data is moved from. It can be a regular memory block
>> + *       or a pointer returned by ramblock_ptr() and its variants.
>> + * @n: length of data to be moved
>> + *
>> + * The destination is always a pointer to data area of a RAMBlock which can
>> + * be for a regular memory block or a MMIO region. The source can be a pointer
>> + * to a regular memory block or a MMIO region. Atomicity isn't guranteed by
>> + * memmove() to move data from or to those MMIO regions as we do in this
>> + * function. Besides, unaligned accesses are well handled on all architectures
>> + * except i386 and x86_64 where the unaligned accesses are supported by the
>> + * CPUs.
>> + *
>> + * The ensured atomicity and alignment consideration, which aren't needed
>> + * by data movement between two regular memory blocks. So performance penalty
>> + * is introduced by this function in such circumstance.
>> + */
>> +void qemu_ram_move(void *dest, const void *src, size_t n);
>> +
> 
> 
> I apologize, I don't understand what these comments are saying, at all.
> 

Sorry to hear that, Michael. There are two things done in the newly added
function qemu_ram_{copy, move}(), comparing to the original memcpy() and
memmove():

- Data copy or movement on MMIO region(s) using __bultin_{memcopy, memmove}()
   on x86, or qatomic_set() on other architecutures, to avoid the unexpected
   optimization done by the compiler on memcpy/memmove. Unsafe instructions
   can be produced by the compiler's optimization. This fixes the issue resolved
   by commit 4a2e242bbb ("memory: Don't use memcpy for ram_device regions")

- The unaligned access is handled by forcing the access size aligned to (src | dest | n)
   on non-x86 architectures, comparing to the original memcpy() and memmove().

Please let me know if we're on same page. If we do, I can revise the comments
accordingly.

> 
> 
>>> -- PMM
>>>

Thanks,
Gavin


