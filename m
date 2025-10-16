Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22589CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 07:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9I2b-0002Jp-8Y; Thu, 16 Oct 2025 03:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9I2a-0002Jf-7u
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 03:04:48 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9I2X-00009E-6s
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 03:04:47 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so369361b3a.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 00:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760598281; x=1761203081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QK7CB95SnpYaR79BK/2HE8D78sK7zSMAuXNZb88nXzA=;
 b=m5tUMLU6pGJrFjg4B8umsvHOPcP+ZM5K/BqZpJZ489mOmdpvyYWrYp1Iq+hhEJUNZe
 0YcpigdQ8VQE7QPQGe8WK9ZBUzP66JQscbp+vpqiX6IAM1ZfB/T8DYVZuM3L+8ZZMvEY
 AVoFiZPOH+t8FOXpeCjoQUGcEiw4bbiel8dAVGBg9oxnQP1cM2z5TLGuWWd3i/V68ikI
 Y6ptpQciTQFTftSpAmT/TI4CKrYtbbTU8KzurUwcLwpL5Tp3TUxF+C3Se/mER39xcQCo
 S6nmQQttL+BIW8QE97bFGXkWDhml/uk2EagaSyxq4vbS96+T9tr4EqDHfzhJsimXGKIQ
 tipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760598281; x=1761203081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QK7CB95SnpYaR79BK/2HE8D78sK7zSMAuXNZb88nXzA=;
 b=iTAc/ucHVPOrUOjEQlVMkDWV+fzK9Hn0mQB4qr1m6R5xxUA+cKkIaz6euOhBf0LSbT
 TdAlUVPhE41O5XANKToV0+2+3HsX6Jf91u/y9snpaQzFzVw9YSuF2L5OFTvKCoE/clDE
 FWhLCILaeKzy1k31Jg+dHCDX3wAaVbeXbBb/fZSmGCvuMEY6mqOgq8QLEFhQFqm8EP76
 KLGlOTacVIfsabmYQobikqrPeV83CJH+7v6FmtLxhWuO7hp0TeL4dsPeUNs6vnrFAMo3
 Pyt9+khdNbqlrMpvelwV7J30uI4CGzl2g7r8KQzOmUCthH0CjbF94UmIJiMXyyQzsZpI
 VUgg==
X-Gm-Message-State: AOJu0Yz3eXd/kMIBbWwIoMk7GuLn7o/XJOl2ajbwMmkiDuadps7hn1Pm
 9dYwXOrbyI/gnoCF3daYSocXwgG7cWdrb/ZvsSvck5FTWMD4I2mNuKgZZ0R9pNgilAM=
X-Gm-Gg: ASbGncvDfdzBs96ZNOinnQf5twRWnybJfMMbm+Ba1V5lhC5a/4rR/Lz1eoXR+8XNXjk
 Js1eK2aHlXgKcGrKa9Zg8TaA/ga0tUZsO2sif8oOYkyJRGWMQ1Q1N8VLgzuh3oKcIo+afAjkzNF
 I6JWdFdwHN5n2G5/gONmxDUJF/FFKa5ZyGq21V+Ij/T56+LLuRfJJwYkTYnaFEcwF+BKajIYi9o
 4ezT7jbE7ZKKmbvCe1rGE8WBTK1yDD/j24Ebi9hoptI1oBUnAsHdpi47/Og0Ae77pYHrepjZYLs
 9WhpriuwHRtLkhuR4S3W9ayGg9+8fbD62D2C2QNHDxSN7gzSccfebqx9WEQMNVQqEmhQPG+NPdJ
 yseu3lW8mYGikzRgnnwuzBSugc1plEp3xRa4KXxbHESYUHItVtbNYoU74qgcvmhWQSpXwyF4Ffe
 /Y2caCyESMSZoviItL+XHCCtG37tI=
X-Google-Smtp-Source: AGHT+IFRwbd5QkdGsvvQHQOiz1erV275o1FkMbKoA0c1thRgAbQCSD4WO1nYGDc6qUfjPlTBtTcgbA==
X-Received: by 2002:a05:6a21:9981:b0:2b9:5bdc:8e28 with SMTP id
 adf61e73a8af0-33495e484dfmr3991762637.15.1760598281256; 
 Thu, 16 Oct 2025 00:04:41 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6a228a5b78sm1761165a12.14.2025.10.16.00.04.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 00:04:40 -0700 (PDT)
Message-ID: <75d10ffd-eafe-4daa-b763-6e1f3e90c766@linaro.org>
Date: Thu, 16 Oct 2025 00:04:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 19/21] hw/arm/smmuv3: Use iommu_index to represent the
 security context
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
 <20251012151501.4131026-1-tangtao1634@phytium.com.cn>
 <dbc4d33e-3477-4f39-a745-4fdc0866fc08@linaro.org>
 <5bde6664-c830-44dd-9513-700980a43ade@phytium.com.cn>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <5bde6664-c830-44dd-9513-700980a43ade@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 10/15/25 11:37 PM, Tao Tang wrote:
> Hi Pierrick:
> 
> On 2025/10/15 08:02, Pierrick Bouvier wrote:
>> Hi Tao,
>>
>> On 10/12/25 8:15 AM, Tao Tang wrote:
>>> The Arm SMMUv3 architecture uses a SEC_SID (Secure StreamID) to select
>>> the programming interface. To support future extensions like RME, which
>>> defines four security states (Non-secure, Secure, Realm, and Root), the
>>> QEMU model must cleanly separate these contexts for all operations.
>>>
>>> This commit leverages the generic iommu_index to represent this
>>> security context. The core IOMMU layer now uses the SMMU's
>>> .attrs_to_index
>>> callback to map a transaction's ARMSecuritySpace attribute to the
>>> corresponding iommu_index.
>>>
>>> This index is then passed down to smmuv3_translate and used throughout
>>> the model to select the correct register bank and processing logic. This
>>> makes the iommu_index the clear QEMU equivalent of the architectural
>>> SEC_SID, cleanly separating the contexts for all subsequent lookups.
>>>
>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>> ---
>>>    hw/arm/smmuv3.c | 36 +++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 35 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>> index c9c742c80b..b44859540f 100644
>>> --- a/hw/arm/smmuv3.c
>>> +++ b/hw/arm/smmuv3.c
>>> @@ -1080,6 +1080,38 @@ static void smmuv3_fixup_event(SMMUEventInfo
>>> *event, hwaddr iova)
>>>        }
>>>    }
>>>    +static SMMUSecSID smmuv3_attrs_to_sec_sid(MemTxAttrs attrs)
>>> +{
>>> +    switch (attrs.space) {
>>> +    case ARMSS_Secure:
>>> +        return SMMU_SEC_SID_S;
>>> +    case ARMSS_NonSecure:
>>> +    default:
>>> +        return SMMU_SEC_SID_NS;
>>> +    }
>>> +}
>>> +
>>> +/*
>>> + * ARM IOMMU index mapping (implements SEC_SID from ARM SMMU):
>>> + * iommu_idx = 0: Non-secure transactions
>>> + * iommu_idx = 1: Secure transactions
>>> + *
>>> + * The iommu_idx parameter effectively implements the SEC_SID
>>> + * (Security Stream ID) attribute from the ARM SMMU architecture
>>> specification,
>>> + * which allows the SMMU to differentiate between different security
>>> state
>>> + * transactions at the hardware level.
>>> + */
>>> +static int smmuv3_attrs_to_index(IOMMUMemoryRegion *iommu,
>>> MemTxAttrs attrs)
>>> +{
>>> +    return (int)smmuv3_attrs_to_sec_sid(attrs);
>>> +}
>>> +
>>> +static int smmuv3_num_indexes(IOMMUMemoryRegion *iommu)
>>> +{
>>> +    /* Support 2 IOMMU indexes for now: NS/S */
>>> +    return SMMU_SEC_SID_NUM;
>>> +}
>>> +
>>>    /* Entry point to SMMU, does everything. */
>>>    static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr
>>> addr,
>>>                                          IOMMUAccessFlags flag, int
>>> iommu_idx)
>>> @@ -1087,7 +1119,7 @@ static IOMMUTLBEntry
>>> smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>>        SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
>>>        SMMUv3State *s = sdev->smmu;
>>>        uint32_t sid = smmu_get_sid(sdev);
>>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>> +    SMMUSecSID sec_sid = iommu_idx;
>>>        SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>>>        SMMUEventInfo event = {.type = SMMU_EVT_NONE,
>>>                               .sid = sid,
>>> @@ -2540,6 +2572,8 @@ static void
>>> smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
>>>          imrc->translate = smmuv3_translate;
>>>        imrc->notify_flag_changed = smmuv3_notify_flag_changed;
>>> +    imrc->attrs_to_index = smmuv3_attrs_to_index;
>>> +    imrc->num_indexes = smmuv3_num_indexes;
>>>    }
>>>      static const TypeInfo smmuv3_type_info = {
>>
>> I noticed that this commit breaks boot of a simple Linux kernel. It
>> was already the case with v2, and it seems there is a deeper issue.
>>
>> Virtio drive initialization hangs up with:
>> [    9.421906] virtio_blk virtio2: [vda] 20971520 512-byte logical
>> blocks (10.7 GB/10.0 GiB)
>> smmuv3_translate_disable smmuv3-iommu-memory-region-24-3 sid=0x18
>> bypass (smmu disabled) iova:0xfffff040 is_write=1
>>
>> You can reproduce that with any kernel/rootfs, but if you want a
>> simple recipe (you need podman and qemu-user-static):
>> $ git clone https://github.com/pbo-linaro/qemu-linux-stack
>> $ cd qemu-linux-stack
>> $ ./build_kernel.sh
>> $ ./build_rootfs.sh
>> $ /path/to/qemu-system-aarch64 \
>> -nographic -M virt,iommu=smmuv3 -cpu max -kernel out/Image.gz \
>> -append "root=/dev/vda rw" out/host.ext4 -trace 'smmuv3*'
>>
>> Looking more closely,
>> we reach SMMU_TRANS_DISABLE, because iommu_idx associated is 1.
>> This values comes from smmuv3_attrs_to_sec_sid, by reading
>> attrs.space, which is ArmSS_Secure.
>>
>> The problem is that it's impossible to have anything Secure given that
>> all the code above runs in NonSecure world.
>> After investigation, the original value read from attrs.space has not
>> been set anywhere, and is just the default zero-initialized value
>> coming from pci_msi_trigger. It happens that it defaults to SEC_SID_S,
>> which probably matches your use case with hafnium, but it's an happy
>> accident.
>>
>> Looking at the SMMU spec, I understand that SEC_SID is configured for
>> each stream, and can change dynamically.
>> On the opposite, a StreamID is fixed and derived from PCI bus and slot
>> for a given device.
>>
>> Thus, I think we are missing some logic here.
>> I'm still trying to understand where the SEC_SID should come from
>> initially.
>> "The association between a device and the Security state of the
>> programming interface is a system-defined property."
>> Does it mean we should be able to set a QEMU property for any device?
>>
>> Does anyone familiar with this has some idea?
>>
>> As well, we should check the SEC_SID found based on
>> SMMU_S_IDR1.SECURE_IMPL.
>> 3.10.1 StreamID Security state (SEC_SID)
>> If SMMU_S_IDR1.SECURE_IMPL == 0, then incoming transactions have a
>> StreamID, and either:
>> • A SEC_SID identifier with a value of 0.
>> • No SEC_SID identifer, and SEC_SID is implicitly treated as 0.
>> If SMMU_S_IDR1.SECURE_IMPL == 1, incoming transactions have a
>> StreamID, and a SEC_SID identifier.
>>
>> Regards,
>> Pierrick
> 
> Thank you very much for your detailed review and in-depth analysis, and
> for pointing out this critical issue that breaks the Linux boot.
> 
> 
> To be transparent, my initial approach was indeed tailored to my
> specific test case, where I was effectively hardcoding the device's
> StreamID to represent it's a so-called Secure device in my self testing.
> This clearly isn't a general solution.
> 

It's definitely not a bad approach, and it's a good way to exercise the 
secure path. It would have been caught by some of QEMU functional tests 
anyway, so it's not a big deal.

A solution would be to define the secure attribute as a property of the 
PCI device, and query that to identify sec_sid accordingly.
As you'll see in 3.10.1 StreamID Security state (SEC_SID), "Whether a 
stream is under Secure control or not is a different property to the 
target PA space of a transaction.", so we definitely should *not* do any 
funky stuff depending on which address is accessed.

By curiosity, which kind of secure device are you using? Is it one of 
the device available upstream, or a specific one you have in your fork?

> 
> You've raised a crucial architectural point that I hadn't fully
> considered: how a standard "Normal World" PCIe device should be properly
> associated with the "Secure World". To be honest, I didn't have a clear
> answer for this, so your feedback is a perfect opportunity for me to dig
> in and understand this area correctly.
> 
It took time for us to reach that question also.
Our current understanding is that SEC_SID == Realm is identified by bits 
on pci side (part of TDISP protocol), and that secure devices are indeed 
hardcoded somewhere.

We asked this question to some Arm folks working on this area, to 
confirm Secure devices are supposed to be defined this way.

> 
> I'd be very interested to hear ideas from others on the list who are
> more familiar with this topic.
> 
> 
> Best,
> 
> Tao
> 
> 


