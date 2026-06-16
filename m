Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27096CD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 04:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZLJt-0007ff-F5; Tue, 16 Jun 2026 00:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZLJr-0007f8-42
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 00:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZLJo-0001gV-Oz
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 00:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781583751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sT4MY/TUEmRBstNa2Xop+PyY6+qD+vSLh/zM16NN8eM=;
 b=A4ypVVb3rA4vas2u3sI7naEyi8PAExLUB3pAH8jZGTSgRgJZsPjmDtvs1qcVIQ4GdthDZc
 g+zgIv9a6JqXsnFG79oXHCCUxAkBd7+qf9MLiLMjrESHrkak/r2pWGAJjgBQgwjbm2lK+B
 8jD31D/nY89M59c4TdNNLldyvKiIp+M=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-7DWUvwg0Pr6IbVaCGt5CGA-1; Tue, 16 Jun 2026 00:22:30 -0400
X-MC-Unique: 7DWUvwg0Pr6IbVaCGt5CGA-1
X-Mimecast-MFC-AGG-ID: 7DWUvwg0Pr6IbVaCGt5CGA_1781583749
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304dd917645so8508339eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 21:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781583749; x=1782188549; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sT4MY/TUEmRBstNa2Xop+PyY6+qD+vSLh/zM16NN8eM=;
 b=BvFDyY7DecXdHJdmhcxNWU3qeilkUCaBU8pfSvxsWBIGdqKsR84sqEWnKI9Vkgaxhl
 HWMSD5Yzj3PWIupB37gY7kc+uxewhjMIeN1t52z0qHOdkXN/z67yrZb2w/AiN/b1DHKV
 0xALE+KEc9fUnPVMfz3i7+ZnYLVLdEvbyJQjLODPCJ9EJ1l5omdwcMmuiHsJWzqw/Kuj
 QU4AJtKyjc+N/jY/eZcOQwuCJCSOgnu45JfKiClOJC9OyhOwG8rkQltM8SdJpflYEedR
 i+trbeg47TME/niq2MwJ5AOn7K7uGV4nfJj3fM1uuEznogEl9OJNDXWQSzSLgpvL3wx7
 uKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781583749; x=1782188549;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sT4MY/TUEmRBstNa2Xop+PyY6+qD+vSLh/zM16NN8eM=;
 b=lY8GgybKoEYXlVKwm99OTqs7H9fG2z7SBgPYQ+kEh/vFIon8Z9ImEYj2a8NPtZg7R2
 gjtAh5YvJ6r6G3kM51TRMFHW+vte3Z9gfco9ITmTZGN9bdFIqYHuo8vev1eAys4Swc9B
 4feptplsezTunxEAyuZr4Hwv83KIkzmB6owEeFPWgODmfJwg06x+6rhmaVUMd+tHxFEn
 IAZiEcBAxNLUyaFxZtd/a6tobzlbyXQtYRzspS3nMQHjSaNgveKPY5Gd5uc0sHJf6T43
 8/OxgEpamaz6CfmW5bgrPRWq+P28bDAowUG4uqdzOgFSp8zmX8T8n04au2rtaWQ9ml0z
 r0nQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9f+uYzZ6EoAcUcPgygt8mxvneiDfpBa0OUFzThh43zjHsqkvWclqQPLWGot2nlgyy4icsPnUztiV7B@nongnu.org
X-Gm-Message-State: AOJu0YyPz3bl+Gd9bTAR/VlZz8qAtY4p42dj6tL+5r4WJCeLeQMMsvym
 CNeKGEpawsVg/gHpMhze974cIEHfpypG0Hfm+BsxBYzDFwdm8UydtW3FCI7IkI2S7KdVl9rt6kC
 WjJ60HooRX1SVEsq6tqtupiy8EHG5ipDLC/Z391WS/jbkIeDA+HzJHGKS
X-Gm-Gg: Acq92OG1x1SuA9StteGsxA4yzZ8P436gwLAni4DZM9ctaryB5d4MU4UC2O7oZ1SRUOk
 PCJ8nyGGIS4kV/3nmL9u4YGFvVHOppD9Fy1rOOz8Cojvqcbvza1wQzZTA5B0ul5AJ23WJXGJtC6
 MyeWLRzGteRHzi2v+ezJRdZJLtElCzGK9WKHcKOAcJQXaEnF9XJdD1A3cpEoVrZTwD/m27znDbv
 F9kzgX4wUzLDwUC2fPuyV8vhoZ0wEC+WAF5cTY6+7LJXYZ0r3Ms9KeqZ65BjBIilkemFtybrJR3
 n0CEfWWFloMbYLfNXEC+Fac0B64ItxGsiH/iTNQKllljyO9ShdhxJb+hh+xvhtOQvt7NExegA+d
 3wrViTEIYJoNlWwao+zw1R0JYQpieWTYAtkri8i2SPH1wjxNFsIrEngZG2Ahyg4UG
X-Received: by 2002:a05:7300:2388:b0:2da:44ac:6d17 with SMTP id
 5a478bee46e88-3082005fe9fmr11006605eec.17.1781583748695; 
 Mon, 15 Jun 2026 21:22:28 -0700 (PDT)
X-Received: by 2002:a05:7300:2388:b0:2da:44ac:6d17 with SMTP id
 5a478bee46e88-3082005fe9fmr11006587eec.17.1781583748073; 
 Mon, 15 Jun 2026 21:22:28 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5fefecsm17474049eec.13.2026.06.15.21.22.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 21:22:27 -0700 (PDT)
Message-ID: <2535e092-b3ef-427c-9d33-39861b3a43f1@redhat.com>
Date: Tue, 16 Jun 2026 14:22:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
From: Gavin Shan <gshan@redhat.com>
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
 <22d55870-b521-4002-add7-791bce8ea96a@redhat.com>
Content-Language: en-US
In-Reply-To: <22d55870-b521-4002-add7-791bce8ea96a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/16/26 7:31 AM, Gavin Shan wrote:
> On 6/16/26 5:42 AM, Michael S. Tsirkin wrote:
>> On Tue, Jun 16, 2026 at 05:24:15AM +1000, Gavin Shan wrote:
>>> Hi Peter and Michael,
>>>
>>> On 6/16/26 1:12 AM, Peter Maydell wrote:
>>>> On Mon, 15 Jun 2026 at 15:56, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>
>>>>> On Mon, Jun 15, 2026 at 11:57:09AM +0100, Peter Maydell wrote:
>>>>>> On Mon, 15 Jun 2026 at 11:03, Gavin Shan <gshan@redhat.com> wrote:
>>>>>>>
>>>>>>> All ram device regions were turned to be indirectly accessible by commit
>>>>>>> 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
>>>>>>> to guest hang on attempt to build 'cuda-samples' as reported by Julia. The
>>>>>>> guest is started by the following command lines, with GH100 GPU card passed
>>>>>>> from the host.
>>>>>>
>>>>>>> diff --git a/include/system/memory.h b/include/system/memory.h
>>>>>>> index 1417132f6d..5878727d09 100644
>>>>>>> --- a/include/system/memory.h
>>>>>>> +++ b/include/system/memory.h
>>>>>>> @@ -2897,6 +2897,8 @@ void address_space_register_map_client(AddressSpace *as, QEMUBH *bh);
>>>>>>>    void address_space_unregister_map_client(AddressSpace *as, QEMUBH *bh);
>>>>>>>
>>>>>>>    /* Internal functions, part of the implementation of address_space_read.  */
>>>>>>> +void qemu_ram_copy(void *dest, const void *src, size_t n);
>>>>>>> +void qemu_ram_move(void *dest, const void *src, size_t n);
>>>>>>
>>>>>> New function prototypes in include headers need documentation comments.
>>>>>>
>>>>>> In particular for these, it's really important that we clearly say
>>>>>> what semantics we are attempting to provide with them, so that
>>>>>> (a) when we're reviewing or later updating the implementation we
>>>>>> know what we are trying to provide
>>>>>> (b) when we're looking at the callsites we know what the function
>>>>>> is guaranteeing to us and what it is not, and thus whether it's
>>>>>> OK to use it or we need something els.
>>>>>>
>>>>>>> +#if defined(__i386__) || defined(__x86_64__)
>>>>>>> +#define HOST_UNALIGNED_MMIO_OK 1
>>>>>>> +#else
>>>>>>> +#define HOST_UNALIGNED_MMIO_OK 0
>>>>>>> +#endif
>>>>>>
>>>>>> We need to do something better than this. We can't
>>>>>> just say "oh, we trust that on x86 this works": it is
>>>>>> neither actually true that the compiler guarantees it
>>>>>
>>>>> sorry guarantee what?
>>>>
>>>> Well, that's part of my point about "we need a doc comment":
>>>> what exactly are we trying to guarantee ? But whatever it is,
>>>> "hardcoded ifdef that privileges x86" is definitely the wrong
>>>> answer.
>>>>
>>>
>>> Could you please check the following comments (documentation context) for the
>>> added functions look good to you? Please let me know if there are anything
>>> can be improved.
>>>
>>> +
>>> +/**
>>> + * qemu_ram_copy: copy data to a RAMBlock
>>> + *
>>> + * @dest: destination where the data is copied to. It's the pointer returned
>>> + *        by ramblock_ptr() and its variants.
>>> + * @src: source where the data is copied from. It can be a regular memory block
>>> + *       or a pointer returned by ramblock_ptr() and its variants.
>>> + * @n: length of data to be copied
>>> + *
>>> + * The destination is always a pointer to data area of a RAMBlock which can
>>> + * be for a regular memory block or a MMIO region. The source can be a pointer
>>> + * to a regular memory block or a MMIO region. Atomicity isn't guranteed by
>>> + * memcpy() to copy data between those MMIO regions as we do in this function.
>>> + * Besides, unaligned accesses are well handled on all architectures except
>>> + * i386 and x86_64 where the unaligned accesses are supported by the CPUs.
>>> + *
>>> + * The ensured atomicity and alignment consideration, which aren't needed
>>> + * by data copy between two regular memory blocks. So performance penalty
>>> + * is introduced by this function in such circumstance.
>>> + */
>>> +void qemu_ram_copy(void *dest, const void *src, size_t n);
>>> +
>>> +/**
>>> + * qemu_ram_move: move data to a RAMBlock
>>> + *
>>> + * @dest: destination where the data is moved to. It's the pointer returned
>>> + *        by ramblock_ptr() and its variants.
>>> + * @src: source where the data is moved from. It can be a regular memory block
>>> + *       or a pointer returned by ramblock_ptr() and its variants.
>>> + * @n: length of data to be moved
>>> + *
>>> + * The destination is always a pointer to data area of a RAMBlock which can
>>> + * be for a regular memory block or a MMIO region. The source can be a pointer
>>> + * to a regular memory block or a MMIO region. Atomicity isn't guranteed by
>>> + * memmove() to move data from or to those MMIO regions as we do in this
>>> + * function. Besides, unaligned accesses are well handled on all architectures
>>> + * except i386 and x86_64 where the unaligned accesses are supported by the
>>> + * CPUs.
>>> + *
>>> + * The ensured atomicity and alignment consideration, which aren't needed
>>> + * by data movement between two regular memory blocks. So performance penalty
>>> + * is introduced by this function in such circumstance.
>>> + */
>>> +void qemu_ram_move(void *dest, const void *src, size_t n);
>>> +
>>
>>
>> I apologize, I don't understand what these comments are saying, at all.
>>
> 
> Sorry to hear that, Michael. There are two things done in the newly added
> function qemu_ram_{copy, move}(), comparing to the original memcpy() and
> memmove():
> 
> - Data copy or movement on MMIO region(s) using __bultin_{memcopy, memmove}()
>    on x86, or qatomic_set() on other architecutures, to avoid the unexpected
>    optimization done by the compiler on memcpy/memmove. Unsafe instructions
>    can be produced by the compiler's optimization. This fixes the issue resolved
>    by commit 4a2e242bbb ("memory: Don't use memcpy for ram_device regions")
> 
> - The unaligned access is handled by forcing the access size aligned to (src | dest | n)
>    on non-x86 architectures, comparing to the original memcpy() and memmove().
> 
> Please let me know if we're on same page. If we do, I can revise the comments
> accordingly.
> 

I've modified the comments to something as below. Please let me know if it's
better. The point is to emphasize qemu_ram_{copy, memmove}() are friendly to
IO regions :-)

-----> include/system/memory.h

+/**
+ * qemu_ram_copy: copy data to a guest memory block
+ *
+ * @dest: destination where the data is copied to. A pointer to a guest memory
+ *        block returned from ramblock_ptr() or its variants
+ * @src: source where the data is copied from. A pointer to host memory block
+ *       or guest memory block returned from ramblock_ptr() or its variants.
+ * @n: length of data to be copied
+ *
+ * When the source pointer, destinatoin pointer or both dereference guest
+ * memory blocks, which can be IO blocks (regions). Under this cirtumstance,
+ * data copy between those blocks is equivalent to IO accesses. It's unsafe
+ * to use memcpy(), which could be translated to IO unfriendly instructions
+ * by the compiler due to code level optimization, resulting in the unexpected
+ * behavior. This function is ensured to be friendly to both IO and memory
+ * accesses. No optimized instructions should be generated by the compiler,
+ * and no unexpected behavior should be observed for IO accesses.
+ */
+void qemu_ram_copy(void *dest, const void *src, size_t n);
+
+/**
+ * qemu_ram_move: move data to a guest memory block
+ *
+ * @dest: destination where the data is moved to. A pointer to a guest memory
+ *        block returned from ramblock_ptr() or its variants
+ * @src: source where the data is moved from. A pointer to host memory block
+ *       or guest memory block returned from ramblock_ptr() or its variants.
+ * @n: length of data to be copied
+ *
+ * Similar to qemu_ram_copy(), this function is ensured to be friendly to both
+ * IO and memory accesses. No optimized instructions should be generated by
+ * the compiler, and no unexpected behavior should be observed for IO accesses.
+ */
+void qemu_ram_move(void *dest, const void *src, size_t n);


>>
>>
>>>> -- PMM
>>>>

Thanks,
Gavin


