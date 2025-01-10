Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48062E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 08:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWALl-0001Zm-7l; Fri, 10 Jan 2025 03:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tWALP-0001Vg-CY
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:26:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tWALL-0000aL-Qn
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 03:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736497568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZNCdfMLciPiU+Hqi6K7rO2KnG2CaaYlJQOkXTQzD/+Q=;
 b=KPofUSFf3t3x4JwODdQn1vS4GKrNA1mmLD+XYUqRCohEyKvIE5/pN/g9spNYyiACOq9Sa7
 M4mScGVuCBPSvy+RZYmTVou7iChwd7878O/v1FG4Brdt0zL/O1wFAjEHYpOuHFjftoisgI
 gv4wruu8/IQYD34g1rREkj9JcyQ/Y0I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-ymz4WDz-OKq60Tcg39ncLg-1; Fri, 10 Jan 2025 03:26:07 -0500
X-MC-Unique: ymz4WDz-OKq60Tcg39ncLg-1
X-Mimecast-MFC-AGG-ID: ymz4WDz-OKq60Tcg39ncLg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385e03f54d0so747448f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 00:26:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736497566; x=1737102366;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZNCdfMLciPiU+Hqi6K7rO2KnG2CaaYlJQOkXTQzD/+Q=;
 b=fCan8hNQGTfKU6IyNLhd7NX9oDirlFXV1vrGY5mngjfFvni5dVvHOx54FcpDBc1pJ0
 Vidyx77ueSdjjB+oSNSoPoywX5J1acpD7/qbqeQdui9lQXP8psB2+6j8fx3VFK4URb7P
 wqi3zVEXIbBMVBzTKBsOSob1yJC+ufo5BMRdcT8QGixwWmERHmWZdiM7bEhr+ZP6r11x
 dTRKt4Pk1bxsJ9NBSr5AzuWEd6lFiCJK+kH624PYh2R6QPVZuBGoorhbSJ5i7Tq3nW49
 3nL9laLfOSb7pFQolHVsH1CU4NHpgtU4ohiqOmVVii8LIfwFpxb1BFMntev1fjYtODwv
 LGZg==
X-Gm-Message-State: AOJu0YyUyx4ssjz0TEHmOqB7T5YtY6TA9kYDL23STaEuEYrhEa6gvlXB
 O5k4WDvm3fx4/4XEPVk8jPpl0xeTeyK8oa4544m17qFqsSwQWSCheUHSi2bdeBScwLveLvAmurn
 3UlwjFGGIcbKwbAnfCsiAiQx5LYErQkmLQNFSJr+Gjb99D12HWSQ9
X-Gm-Gg: ASbGncudrLS3/0z8QuuXfV40ik4QZzvx6USafK3IF5/aDa0v2O44BadkMxQVAI4bLtT
 NkC8CjK9FvhFxgb9NQXG/QOiILMuVoSZfP5zjNiC6LiD1RuEYM6y82kWsi7ZvZDyZZZjhmk9UgI
 Cosd5O+pXdtSy4mpuW0cROd1eLE9TSJsk0DyVIj4iqR16VY1ML8wmsoj6xKM4JPrPsnWgfu9oKZ
 7GBFnxme6rnmH8h/7xru96cTmU5YWfTJVNwDHlgdlz1vpBxEUA4XbjKL7cEvWg7zRlc30631OOy
 r5lcUgmW/B/tsklapUH4sNwrqOP7pmWhTU3RW2qutzNHeIX/p7EiTVSeCA06soCJIDj7w4If/O6
 F1zPN1qbm
X-Received: by 2002:a5d:59af:0:b0:382:31a1:8dc3 with SMTP id
 ffacd0b85a97d-38a87313151mr8810659f8f.35.1736497565793; 
 Fri, 10 Jan 2025 00:26:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlaHN9Zr4/ISK7a2mU4PnTAA3whAhhSfTaCWDxQQoyOOZUSqkWurhV/8+nhu5/HWOZvcv71A==
X-Received: by 2002:a5d:59af:0:b0:382:31a1:8dc3 with SMTP id
 ffacd0b85a97d-38a87313151mr8810628f8f.35.1736497565343; 
 Fri, 10 Jan 2025 00:26:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:e100:4f41:ff29:a59f:8c7a?
 (p200300cbc708e1004f41ff29a59f8c7a.dip0.t-ipconnect.de.
 [2003:cb:c708:e100:4f41:ff29:a59f:8c7a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e320329sm3896657f8f.0.2025.01.10.00.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 00:26:04 -0800 (PST)
Message-ID: <c318c89b-967d-456e-ade1-3a8cacb21bd7@redhat.com>
Date: Fri, 10 Jan 2025 09:26:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Enable shared device assignment
To: Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy
 <aik@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Michael Roth <michael.roth@amd.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
References: <20241213070852.106092-1-chenyi.qiang@intel.com>
 <2737cca7-ef2d-4e73-8b5a-67698c835e77@amd.com>
 <8457e035-40b0-4268-866e-baa737b6be27@intel.com>
 <6ac5ddea-42d8-40f2-beec-be490f6f289c@amd.com>
 <8f953ffc-6408-4546-a439-d11354b26665@intel.com>
 <d4b57eb8-03f1-40f3-bc7a-23b24294e3d7@amd.com>
 <57a3869d-f3d1-4125-aaa5-e529fb659421@intel.com>
 <008bfbf2-3ea4-4e6c-ad0d-91655cdfc4e8@amd.com>
 <1361f0b4-ddf8-4a83-ba21-b68321d921da@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1361f0b4-ddf8-4a83-ba21-b68321d921da@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
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

On 10.01.25 08:06, Chenyi Qiang wrote:
> 
> 
> On 1/10/2025 9:42 AM, Alexey Kardashevskiy wrote:
>>
>>
>> On 9/1/25 19:49, Chenyi Qiang wrote:
>>>
>>>
>>> On 1/9/2025 4:18 PM, Alexey Kardashevskiy wrote:
>>>>
>>>>
>>>> On 9/1/25 18:52, Chenyi Qiang wrote:
>>>>>
>>>>>
>>>>> On 1/8/2025 7:38 PM, Alexey Kardashevskiy wrote:
>>>>>>
>>>>>>
>>>>>> On 8/1/25 17:28, Chenyi Qiang wrote:
>>>>>>> Thanks Alexey for your review!
>>>>>>>
>>>>>>> On 1/8/2025 12:47 PM, Alexey Kardashevskiy wrote:
>>>>>>>> On 13/12/24 18:08, Chenyi Qiang wrote:
>>>>>>>>> Commit 852f0048f3 ("RAMBlock: make guest_memfd require
>>>>>>>>> uncoordinated
>>>>>>>>> discard") effectively disables device assignment when using
>>>>>>>>> guest_memfd.
>>>>>>>>> This poses a significant challenge as guest_memfd is essential for
>>>>>>>>> confidential guests, thereby blocking device assignment to these
>>>>>>>>> VMs.
>>>>>>>>> The initial rationale for disabling device assignment was due to
>>>>>>>>> stale
>>>>>>>>> IOMMU mappings (see Problem section) and the assumption that TEE
>>>>>>>>> I/O
>>>>>>>>> (SEV-TIO, TDX Connect, COVE-IO, etc.) would solve the device-
>>>>>>>>> assignment
>>>>>>>>> problem for confidential guests [1]. However, this assumption has
>>>>>>>>> proven
>>>>>>>>> to be incorrect. TEE I/O relies on the ability to operate devices
>>>>>>>>> against
>>>>>>>>> "shared" or untrusted memory, which is crucial for device
>>>>>>>>> initialization
>>>>>>>>> and error recovery scenarios. As a result, the current
>>>>>>>>> implementation
>>>>>>>>> does
>>>>>>>>> not adequately support device assignment for confidential guests,
>>>>>>>>> necessitating
>>>>>>>>> a reevaluation of the approach to ensure compatibility and
>>>>>>>>> functionality.
>>>>>>>>>
>>>>>>>>> This series enables shared device assignment by notifying VFIO of
>>>>>>>>> page
>>>>>>>>> conversions using an existing framework named RamDiscardListener.
>>>>>>>>> Additionally, there is an ongoing patch set [2] that aims to add 1G
>>>>>>>>> page
>>>>>>>>> support for guest_memfd. This patch set introduces in-place page
>>>>>>>>> conversion,
>>>>>>>>> where private and shared memory share the same physical pages as
>>>>>>>>> the
>>>>>>>>> backend.
>>>>>>>>> This development may impact our solution.
>>>>>>>>>
>>>>>>>>> We presented our solution in the guest_memfd meeting to discuss its
>>>>>>>>> compatibility with the new changes and potential future directions
>>>>>>>>> (see [3]
>>>>>>>>> for more details). The conclusion was that, although our
>>>>>>>>> solution may
>>>>>>>>> not be
>>>>>>>>> the most elegant (see the Limitation section), it is sufficient for
>>>>>>>>> now and
>>>>>>>>> can be easily adapted to future changes.
>>>>>>>>>
>>>>>>>>> We are re-posting the patch series with some cleanup and have
>>>>>>>>> removed
>>>>>>>>> the RFC
>>>>>>>>> label for the main enabling patches (1-6). The newly-added patch
>>>>>>>>> 7 is
>>>>>>>>> still
>>>>>>>>> marked as RFC as it tries to resolve some extension concerns
>>>>>>>>> related to
>>>>>>>>> RamDiscardManager for future usage.
>>>>>>>>>
>>>>>>>>> The overview of the patches:
>>>>>>>>> - Patch 1: Export a helper to get intersection of a
>>>>>>>>> MemoryRegionSection
>>>>>>>>>        with a given range.
>>>>>>>>> - Patch 2-6: Introduce a new object to manage the guest-memfd with
>>>>>>>>>        RamDiscardManager, and notify the shared/private state change
>>>>>>>>> during
>>>>>>>>>        conversion.
>>>>>>>>> - Patch 7: Try to resolve a semantics concern related to
>>>>>>>>> RamDiscardManager
>>>>>>>>>        i.e. RamDiscardManager is used to manage memory plug/unplug
>>>>>>>>> state
>>>>>>>>>        instead of shared/private state. It would affect future
>>>>>>>>> users of
>>>>>>>>>        RamDiscardManger in confidential VMs. Attach it behind as
>>>>>>>>> a RFC
>>>>>>>>> patch[4].
>>>>>>>>>
>>>>>>>>> Changes since last version:
>>>>>>>>> - Add a patch to export some generic helper functions from
>>>>>>>>> virtio-mem
>>>>>>>>> code.
>>>>>>>>> - Change the bitmap in guest_memfd_manager from default shared to
>>>>>>>>> default
>>>>>>>>>        private. This keeps alignment with virtio-mem that 1-
>>>>>>>>> setting in
>>>>>>>>> bitmap
>>>>>>>>>        represents the populated state and may help to export more
>>>>>>>>> generic
>>>>>>>>> code
>>>>>>>>>        if necessary.
>>>>>>>>> - Add the helpers to initialize/uninitialize the
>>>>>>>>> guest_memfd_manager
>>>>>>>>> instance
>>>>>>>>>        to make it more clear.
>>>>>>>>> - Add a patch to distinguish between the shared/private state
>>>>>>>>> change
>>>>>>>>> and
>>>>>>>>>        the memory plug/unplug state change in RamDiscardManager.
>>>>>>>>> - RFC: https://lore.kernel.org/qemu-devel/20240725072118.358923-1-
>>>>>>>>> chenyi.qiang@intel.com/
>>>>>>>>>
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> Background
>>>>>>>>> ==========
>>>>>>>>> Confidential VMs have two classes of memory: shared and private
>>>>>>>>> memory.
>>>>>>>>> Shared memory is accessible from the host/VMM while private
>>>>>>>>> memory is
>>>>>>>>> not. Confidential VMs can decide which memory is shared/private and
>>>>>>>>> convert memory between shared/private at runtime.
>>>>>>>>>
>>>>>>>>> "guest_memfd" is a new kind of fd whose primary goal is to serve
>>>>>>>>> guest
>>>>>>>>> private memory. The key differences between guest_memfd and normal
>>>>>>>>> memfd
>>>>>>>>> are that guest_memfd is spawned by a KVM ioctl, bound to its owner
>>>>>>>>> VM and
>>>>>>>>> cannot be mapped, read or written by userspace.
>>>>>>>>
>>>>>>>> The "cannot be mapped" seems to be not true soon anymore (if not
>>>>>>>> already).
>>>>>>>>
>>>>>>>> https://lore.kernel.org/all/20240801090117.3841080-1-
>>>>>>>> tabba@google.com/T/
>>>>>>>
>>>>>>> Exactly, allowing guest_memfd to do mmap is the direction. I
>>>>>>> mentioned
>>>>>>> it below with in-place page conversion. Maybe I would move it here to
>>>>>>> make it more clear.
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> In QEMU's implementation, shared memory is allocated with normal
>>>>>>>>> methods
>>>>>>>>> (e.g. mmap or fallocate) while private memory is allocated from
>>>>>>>>> guest_memfd. When a VM performs memory conversions, QEMU frees
>>>>>>>>> pages
>>>>>>>>> via
>>>>>>>>> madvise() or via PUNCH_HOLE on memfd or guest_memfd from one
>>>>>>>>> side and
>>>>>>>>> allocates new pages from the other side.
>>>>>>>>>
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>>>>
>>>>>>>>> One limitation (also discussed in the guest_memfd meeting) is that
>>>>>>>>> VFIO
>>>>>>>>> expects the DMA mapping for a specific IOVA to be mapped and
>>>>>>>>> unmapped
>>>>>>>>> with
>>>>>>>>> the same granularity. The guest may perform partial conversions,
>>>>>>>>> such as
>>>>>>>>> converting a small region within a larger region. To prevent such
>>>>>>>>> invalid
>>>>>>>>> cases, all operations are performed with 4K granularity. The
>>>>>>>>> possible
>>>>>>>>> solutions we can think of are either to enable VFIO to support
>>>>>>>>> partial
>>>>>>>>> unmap
>>>>>>
>>>>>> btw the old VFIO does not split mappings but iommufd seems to be
>>>>>> capable
>>>>>> of it - there is iopt_area_split(). What happens if you try
>>>>>> unmapping a
>>>>>> smaller chunk that does not exactly match any mapped chunk? thanks,
>>>>>
>>>>> iopt_cut_iova() happens in iommufd vfio_compat.c, which is to make
>>>>> iommufd be compatible with old VFIO_TYPE1. IIUC, it happens with
>>>>> disable_large_page=true. That means the large IOPTE is also disabled in
>>>>> IOMMU. So it can do the split easily. See the comment in
>>>>> iommufd_vfio_set_iommu().
>>>>>
>>>>> iommufd VFIO compatible mode is a transition from legacy VFIO to
>>>>> iommufd. For the normal iommufd, it requires the iova/length must be a
>>>>> superset of a previously mapped range. If not match, will return error.
>>>>
>>>>
>>>> This is all true but this also means that "The former requires complex
>>>> changes in VFIO" is not entirely true - some code is already there.
>>>> Thanks,
>>>
>>> Hmm, my statement is a little confusing.  The bottleneck is that the
>>> IOMMU driver doesn't support the large page split. So if we want to
>>> enable large page and want to do partial unmap, it requires complex
>>> change.
>>
>> We won't need to split large pages (if we stick to 4K for now), we need
>> to split large mappings (not large pages) to allow partial unmapping and
>> iopt_area_split() seems to be doing this. Thanks,
> 
> You mean we can disable large page in iommufd and then VFIO will be able
> to do partial unmap. Yes, I think it is doable and we can avoid many
> ioctl context switches overhead.

So I understand this correctly: the disable_large_pages=true will imply 
that we never have PMD mappings such that we can atomically poke a hole 
in a mapping, without temporarily having to remove a PMD mapping in the 
iommu table to insert a PTE table?

batch_iommu_map_small() seems to document that behavior.

It's interesting that that comment points out that this is purely "VFIO 
compatibility", and that it otherwise violates the iommufd invariant: 
"pairing map/unmap". So, it is against the real iommufd design ...

Back when working on virtio-mem support (RAMDiscardManager), thought 
there was not way to reliably do atomic partial unmappings.

-- 
Cheers,

David / dhildenb


