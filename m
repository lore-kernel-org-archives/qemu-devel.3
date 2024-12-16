Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C059DE77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 15:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNDFR-0002yd-4M; Mon, 16 Dec 2024 10:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tNDFO-0002yH-6B
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:43:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tNDFM-0003BC-F2
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734363777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V8p7yShjCyLlaBnN4P4LdEOJxaosHJK9whpqCs1S0VI=;
 b=bOnFcz9wIw2C9RYs/O7OWFqEZeTkNdapJ/J0CELRbcswUvGk0MlFF6ApfX8vfF0M8kCzh1
 KJ1vEDmG67wOiU9mt4zm/CppTjbGlEDkUlk03X0p6Ilc2GXHI6fqUsxSNF98eAamsZ8wEw
 OCRnqZtMAfvC3zJ9yWA40Jl028xPeOo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-csqC-_3iMJ2Q7_yFzMSAaw-1; Mon, 16 Dec 2024 10:42:54 -0500
X-MC-Unique: csqC-_3iMJ2Q7_yFzMSAaw-1
X-Mimecast-MFC-AGG-ID: csqC-_3iMJ2Q7_yFzMSAaw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43623bf2a83so36013405e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 07:42:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734363774; x=1734968574;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=V8p7yShjCyLlaBnN4P4LdEOJxaosHJK9whpqCs1S0VI=;
 b=Ao0JFb4D6bCdoJRS0pYYAaFUupqPjHsJA9oEZrn++c90WBH4QVWL7OSD3GeFGlhzZB
 TS2mVSJYJViHdeC0MWmXB2ttc18jcF11cvMoD+lRUeONYlrRNcguNhPYmxVuOXnMDVEo
 87xj3qUXRmouD7XaKu2rh1tPzfF5u3UVuJMDIXMG9OJDOVDkKOuiV+FtLcqPzmJALlEB
 AxjEo/v+RsBZaWZtjJq8etqaAsXBfLdI9/Ng+QiJYWgfcFfLY8x/upVI13QSkeS65XOq
 +n2J7DcT0x+yOe+LXFMnk61ikVJkzy8ZRPAw4u5A5/yDHTiwrKWRBZsfkin3QxDHWzbL
 g7WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkoismP/QvoMPasDxRQvlJzTCihjLTUZVXkAwI40Ls+VJdrVBbbR9Uyt/rBIfQ8ZiZ/vN7Qh+BPzdQ@nongnu.org
X-Gm-Message-State: AOJu0YyA0lRnGZoTDL4aXEetVA7X9eXwCn6gs1b+0qAtJ4w0witm3jvW
 g1W0TxAJGhzdcIgzmIM3UttEKe9nSUtrPbDDyE0rpDIxZ8CtJ1CJV9epL/tjIVx0yC9iFrhQMdV
 E37cyP57aQ5YHCi1CExi1usfM6YQUPcalV2cQPjgV3yZSTI6oLZMh
X-Gm-Gg: ASbGncu9XcDnG4/YaLRCHBUECQmCxgrtHv1kM6kEj5tDzzuVonbSFkcX0BWSVd4iRRk
 GN6oFDY6qFwD0LH9cSA1rqIQmVrk3B8+o1Iu6SzQrAry+KCXPrbC7uf4jZh90Xu0PNynv7hvdKq
 guGAZEX/Tg/Wi1u873zbAZKUhYSD/9hSP8WX0S1gSxjfD53oEqQiB29s1kpZnaAXQtD1swVF7S2
 BmUfDyTjzjXPpnyrTs7kTXifdp4HjV5UVg7QTwnE+KIFYSgYVTOxVm9BwEL9DAtXON32ZCSrFDb
 b13s9KOjEOHKxow4Evp5+EasLJeqXuALD1D1jyRHtkhwosYgRTxAYMKmPDywdMB0NMsIt4p4ARG
 mUDtJB335
X-Received: by 2002:a05:6000:144f:b0:386:37f5:99f6 with SMTP id
 ffacd0b85a97d-3888e0c1671mr9911121f8f.53.1734363773576; 
 Mon, 16 Dec 2024 07:42:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCtHqbT7r6osYBj+q2wZC/R+TQcEZCVNFkfY3Qb+0wInc/6KBBDcWzQ0ryu4z1OUKZGuN0Fg==
X-Received: by 2002:a05:6000:144f:b0:386:37f5:99f6 with SMTP id
 ffacd0b85a97d-3888e0c1671mr9911097f8f.53.1734363773180; 
 Mon, 16 Dec 2024 07:42:53 -0800 (PST)
Received: from ?IPV6:2003:cb:c72a:f600:c577:b537:f52a:b994?
 (p200300cbc72af600c577b537f52ab994.dip0.t-ipconnect.de.
 [2003:cb:c72a:f600:c577:b537:f52a:b994])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8060582sm8327591f8f.93.2024.12.16.07.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 07:42:52 -0800 (PST)
Message-ID: <46acb391-154e-43a1-a459-1646dc27fb33@redhat.com>
Date: Mon, 16 Dec 2024 16:42:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] s390x/pci: add support for guests that request
 direct mapping
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, clegoate@redhat.com,
 qemu-devel@nongnu.org
References: <20241213225440.571382-1-mjrosato@linux.ibm.com>
 <20241213225440.571382-2-mjrosato@linux.ibm.com>
 <7e07ef1e-4fa5-40d7-85f9-d7a199901b4f@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7e07ef1e-4fa5-40d7-85f9-d7a199901b4f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 16.12.24 16:37, Philippe Mathieu-Daudé wrote:
> Hi Matthew,
> 
> On 13/12/24 23:54, Matthew Rosato wrote:
>> When receiving a guest mpcifc(4) or mpcifc(6) instruction without the T
>> bit set, treat this as a request to perform direct mapping instead of
>> address translation.  In order to facilitate this, pin the entirety of
>> guest memory into the host iommu.
>>
>> Subsequent guest DMA operations are all expected to be of the format
>> guest_phys+sdma, allowing them to be used as lookup into the host
>> iommu table.
>>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>    hw/s390x/s390-pci-bus.c         | 34 +++++++++++++++++++++++++++++++--
>>    hw/s390x/s390-pci-inst.c        | 13 +++++++++++--
>>    hw/s390x/s390-virtio-ccw.c      |  5 +++++
>>    include/hw/s390x/s390-pci-bus.h |  4 ++++
>>    4 files changed, 52 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 40b2567aa7..95dbe0c984 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -18,6 +18,7 @@
>>    #include "hw/s390x/s390-pci-inst.h"
>>    #include "hw/s390x/s390-pci-kvm.h"
>>    #include "hw/s390x/s390-pci-vfio.h"
>> +#include "hw/boards.h"
>>    #include "hw/pci/pci_bus.h"
>>    #include "hw/qdev-properties.h"
>>    #include "hw/pci/pci_bridge.h"
>> @@ -720,16 +721,43 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
>>                                 TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
>>                                 name, iommu->pal + 1);
>>        iommu->enabled = true;
>> +    iommu->direct_map = false;
>>        memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
>>        g_free(name);
>>    }
>>    
>> +void s390_pci_iommu_dm_enable(S390PCIIOMMU *iommu)
>> +{
>> +    MachineState *ms = MACHINE(qdev_get_machine());
>> +
>> +    /*
>> +     * For direct-mapping we must map the entire guest address space.  Rather
>> +     * than using an iommu, create a memory region alias that maps GPA X to
>> +     * iova X + SDMA.  VFIO will handle pinning via its memory listener.
>> +     */
>> +    g_autofree char *name = g_strdup_printf("iommu-dm-s390-%04x",
>> +                                            iommu->pbdev->uid);
>> +    memory_region_init_alias(&iommu->dm_mr, OBJECT(&iommu->mr), name, ms->ram,
>> +                             0, ms->ram_size);
> 
> Is it a good idea to take the whole machine ram-size here?
> Could it be better to pass it as qdev property?

I think we want all guest RAM, just like ordinary vfio on !s390x without 
a viommu would do.

Matthew, I assume to handle virtio-mem, we would actually pass in here 
the result from s390_get_memory_limit(), which will cover initial+device 
RAM, correct? Until then, this would map initial RAM only.

-- 
Cheers,

David / dhildenb


