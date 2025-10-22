Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D220FCCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 10:29:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBW5Q-0004w7-EI; Wed, 22 Oct 2025 06:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1vBW5P-0004vq-DR
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 06:28:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1vBW5M-0002Hp-1s
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 06:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761128928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wRjJ3se2iyyxKlA7RWztRzuZOe5BqauAwZrD8EJCG4Y=;
 b=J0hhwhoiGKwFqdbd4aDHAFDrG8ZP3YoppwvHeUQ1Lt19qheu520Od+SAAc0VyyBJrHI6Lo
 j460tX5nuDqFULDcBicOYfnczc1P42TIaS5Zgzi/g2CWSdnnyQlM5c3cjGe3u6Vx2VoXb8
 Eq5QHuaupNPGe3XNvxpoiCsdSde+wkU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-sGNtmQ34NUqhA0TiM3DvHg-1; Wed, 22 Oct 2025 06:28:47 -0400
X-MC-Unique: sGNtmQ34NUqhA0TiM3DvHg-1
X-Mimecast-MFC-AGG-ID: sGNtmQ34NUqhA0TiM3DvHg_1761128926
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4256fae4b46so4757705f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 03:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761128926; x=1761733726;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wRjJ3se2iyyxKlA7RWztRzuZOe5BqauAwZrD8EJCG4Y=;
 b=MXtizHOTP1JfmSQ3P5HSnhwy/3wY0GUy+D2A3MbQSJOIoIbGjg5H40EcfZ/216AtYg
 Fs9yylYsrgFFn5P8dEaFvTTje0Bun2XekRmWU0X5KYL02ZTWG1deb1+4KsWBpI05B3ks
 1hE5FBp1Q7yeN91s0Rd13FZH4ndsUuC4ABHAFYXrId5OZN+T8AK2hQYPDilZHCqfVFjG
 VlsECJoAISeSVYRPK2l1S/MF1jc8ekGnQfqHksOTTlm5QQL1SlU8l8VYAiQ4MPnofhxt
 LypCdxLTasURC6AuRXQH92T4+bAmwSNibGa6C6sndpT1ur+6jA8KHPTdaUidLgLi4jBx
 FLeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnBUo0woapkJVeUFXwLGf1lgoDRJTo3iElrqQTGBI+D6JM4c1hGUL4IuXPFuAy7N4sH38J3ZHwe6XM@nongnu.org
X-Gm-Message-State: AOJu0YzmZ2iOoX/G08mKfAWrGMlgH/sxrlyokt9AOqRCca6uIy+5Ev5v
 UbM1h+QGG5VMv0R+uztz3ViIXu75M01bjXMxFlDHyG696IwaCkwch/Wz0NqP/LZ/OAXjSeeOJmV
 H7vtAGlMPKl/eAWLdywbRI8MXdMi3G+UJqRYb9VQMGeUGDuWx4vHgY7sb
X-Gm-Gg: ASbGncujN2PtYYgePny+izHlHkK3TXTC8cMyu5p1+oUJRPCA8NZ2obemCydcUan5jZI
 hzaYUYFz4o03OtpPCOzBiGdBrUZpa/r9r9FJfhh/sNijrplkNQojy/00VRcoAr6f+uv1qolJesT
 TJobL8iqgAxb0dACIsRZ5aivhNejhsIgOijJ2L51vwbvC6BT+BHaklVSkDIRXN363KyWv6cfFVw
 4ad7Uw/7cvtV0XnZ8x0RK96e97KMYyvMVE9XzFHQ5t9vgW32mK3cKe5Pw1dibS9xOInL9W5LQin
 kbMeo3rfwcfomtdVoz5tl7BLdMxg27PmV3AI+TeoAJYnY/7ATzLHrUwN4XpBcofHK1rE0b7MchF
 SkficYPimsjoGvfVR4gNSMSQmwZcEG+zFTnRVVvOphZP1FKn64YwhDZvr5eFpit+4ugfA0t0s4D
 9aFA0S7wvM9c/ldpJ6czzfRmLpzDM=
X-Received: by 2002:a05:6000:2081:b0:428:52c7:feae with SMTP id
 ffacd0b85a97d-42852c80272mr2371366f8f.32.1761128925863; 
 Wed, 22 Oct 2025 03:28:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9NsXwm8hIr3gd4SCgsKkh4v+oW6zy5FRfMlSaem8mah+TOVzvsSBXdBQvBVo2p3owNa0BoQ==
X-Received: by 2002:a05:6000:2081:b0:428:52c7:feae with SMTP id
 ffacd0b85a97d-42852c80272mr2371349f8f.32.1761128925423; 
 Wed, 22 Oct 2025 03:28:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3?
 (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de.
 [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a75bsm24836027f8f.23.2025.10.22.03.28.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 03:28:44 -0700 (PDT)
Message-ID: <eb1b524d-3a8c-481b-85eb-6697f5ee332b@redhat.com>
Date: Wed, 22 Oct 2025 12:28:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] numa: add 'spm' option for Specific Purpose Memory
To: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>,
 qemu-devel@nongnu.org, imammedo@redhat.com
Cc: Zhigang.Luo@amd.com, Lianjie.Shi@amd.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20251020090701.4036748-1-FangSheng.Huang@amd.com>
 <c35a21dd-40e5-4fa5-87c4-18ebe8ca73ca@redhat.com>
 <2d0d56d5-72e3-4ae6-b657-96522fde6149@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <2d0d56d5-72e3-4ae6-b657-96522fde6149@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 22.10.25 12:09, Huang, FangSheng (Jerry) wrote:
> 
> 
> On 10/21/2025 4:10 AM, David Hildenbrand wrote:
>> On 20.10.25 11:07, fanhuang wrote:
>>> Hi David and Igor,
>>>
>>> I apologize for the delayed response. Thank you very much for your
>>> thoughtful
>>> questions and feedback on the SPM patch series.
>>>
>>> Before addressing your questions, I'd like to briefly mention what the
>>> new
>>> QEMU patch series additionally resolves:
>>>
>>> 1. **Corrected SPM terminology**: Fixed the description error from the
>>> previous
>>>      version. The correct acronym is "Specific Purpose Memory" (not
>>> "special
>>>      purpose memory" as previously stated).
>>>
>>> 2. **Fixed overlapping E820 entries**: Updated the implementation to
>>> properly
>>>      handle overlapping E820 RAM entries before adding E820_SOFT_RESERVED
>>>      regions.
>>>
>>>      The previous implementation created overlapping E820 entries by
>>> first adding
>>>      a large E820_RAM entry covering the entire above-4GB memory range,
>>> then
>>>      adding E820_SOFT_RESERVED entries for SPM regions that overlapped
>>> with the
>>>      RAM entry. This violated the E820 specification and caused OVMF/UEFI
>>>      firmware to receive conflicting memory type information for the same
>>>      physical addresses.
>>>
>>>      The new implementation processes SPM regions first to identify
>>> reserved
>>>      areas, then adds RAM entries around the SPM regions, generating a
>>> clean,
>>>      non-overlapping E820 map.
>>>
>>> Now, regarding your questions:
>>>
>>> ========================================================================
>>> Why SPM Must Be Boot Memory
>>> ========================================================================
>>>
>>> SPM cannot be implemented as hotplug memory (DIMM/NVDIMM) because:
>>>
>>> The primary goal of SPM is to ensure that memory is managed by guest
>>> device drivers, not the guest OS. This requires boot-time discovery
>>> for three key reasons:
>>>
>>> 1. SPM regions must appear in the E820 memory map as `E820_SOFT_RESERVED`
>>>      during firmware initialization, before the OS starts.
>>>
>>> 2. Hotplug memory is integrated into kernel memory management, making
>>>      it unavailable for device-specific use.
>>>
>>> ========================================================================
>>> Detailed Use Case
>>> ========================================================================
>>>
>>> **Background**
>>> Unified Address Space for CPU and GPU:
>>>
>>> Modern heterogeneous computing architectures implement a coherent and
>>> unified address space shared between CPUs and GPUs. Unlike traditional
>>> discrete GPU designs with dedicated frame buffer, these accelerators
>>> connect CPU and GPU through high-speed interconnects (e.g., XGMI):
>>>
>>> - **HBM (High Bandwidth Memory)**: Physically attached to each GPU,
>>>     reported to the OS as driver-managed system memory
>>>
>>> - **XGMI (eXternal Global Memory Interconnect, aka. Infinity Fabric)**:
>>>     Maintains data coherence between CPU and GPU, enabling direct CPU
>>>     access to GPU HBM without data copying
>>>
>>> In this architecture, GPU HBM is reported as system memory to the OS,
>>> but it needs to be managed exclusively by the GPU driver rather than
>>> the general OS memory allocator. This driver-managed memory provides
>>> optimal performance for GPU workloads while enabling coherent CPU-GPU
>>> data sharing through the XGMI. This is where SPM (Specific Purpose
>>> Memory) becomes essential.
>>>
>>> **Virtualization Scenario**
>>>
>>> In virtualization, hypervisor need to expose this memory topology to
>>> guest VMs while maintaining the same driver-managed vs OS-managed
>>> distinction.
>>
>> Just wondering, could device hotplug in that model ever work? I guess we
>> wouldn't expose the memory at all in e820 (after all, it gets hotplugged
>> later) and instead the device driver in the guest would have to
>> detect+hotplug that memoory.
>>
>> But that sounds weird, because the device driver in the VM shouldn't do
>> something virt specific.
>>
>> Which raises the question: how is device hoplug of such gpus handled on
>> bare metal? Or does it simply not work? :)
>>
> Hi David, Thank you for your thoughtful feedback.
> To directly answer your question:
> in our use case, GPU device hotplug does NOT work on bare metal,
> and this is by design.

Cool, thanks for clarifying!

-- 
Cheers

David / dhildenb


