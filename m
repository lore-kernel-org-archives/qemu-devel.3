Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EDAD3B7E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 17:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSeex-0003Ai-S5; Mon, 08 Dec 2025 12:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSeeu-00038h-TM
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 12:04:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSeet-0000St-3M
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 12:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765213462;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kJFajqK+BAme7a0UeF4POH4PUCJNId/qHlmErNU28j4=;
 b=MG7syjJqeClbUhAvrnIXazUnb7avPjHz7jbbM2SeivUNXUQWlQ29yCcdPp2J5AlF0UOYR5
 42w479Tym8UUNSo90m/dM+rF9GiTZV1mX9KnXfOXUp4X82YCxk3e3nFIa9ZUUZlNgasXad
 XlzPBkHuBZHmo3mUJHR6lAuy5KHJX2M=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-FxddGuIPP9Wg0_y9B3eCkA-1; Mon, 08 Dec 2025 12:03:54 -0500
X-MC-Unique: FxddGuIPP9Wg0_y9B3eCkA-1
X-Mimecast-MFC-AGG-ID: FxddGuIPP9Wg0_y9B3eCkA_1765213434
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4ee27e24711so84753831cf.1
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 09:03:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765213434; x=1765818234;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kJFajqK+BAme7a0UeF4POH4PUCJNId/qHlmErNU28j4=;
 b=esQEY2KR9VEYfASkEYWKKjAikyW6Hfv2qV2ceP3vFIHLlgGxQIbG6jjrGrY21c3bRe
 +Hv3s7ixf4jggaTVcZwz1efTSMyj4Q06fDBVp0ibxSm0yMz41EKLvXdgtuR4+o4rpEf9
 r8UwZRiqCuUI11qsyIxduospvX+NRWbEagwX5u1V8/9JpYyd3Td9+6yAoiX+RY2VxmtV
 FimnL6tCTo53nKz2Bd96Zhy3owS9RCHfiUpj2nAuhXp3e2/QO5yxIzvmkpDRP+OFAuRH
 /WUO5E7ikpOAXss1aYCunHoMYhtR+knaNsiUGqiuQ6mwv69Aa7Rrdhb4pH3xki2USAGp
 nr2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOT9A5Z3Zx05xFHAK9YoNeFbzmQaaViaSMCRl0U7wBIb7WUyIIlL0ELjkKNFujs6g5Fmy2nG21x0Zj@nongnu.org
X-Gm-Message-State: AOJu0YzbboiK4u93aPT++7mObAIiqpdXMqZlbr2GCeVvj0qRtUUvBmSt
 6D1DTJXcSX8aCKQZBmKHFoOvycC0SpsiwN1WoYVmwHv44e6PoynHhQMC4bFooAEcLvz1zgRZwOe
 GeZ0xhzOFu+NaXAmqPbcc0okLgFn6QBYoKBzOXjZ/TFWc2ZS4d1Mhjv7n
X-Gm-Gg: ASbGncsyvSYpeVPhAyb3X0AVLuqgRnfBC8yeE63+fccQzf4Hqc0/xKiSDQzz9vDRK2H
 Yx2qJhaRQGDSvf8HbqyDFiorYjdp70CkBcmfB2iDbZ1Rtb39L/cuWa1Rxqo8q7CDBfu9tRTQp/T
 0Aq0y8KHTQ8reXbcLiOVmR0NqkAGGPYJoScRo+eQ7lUQ2cDdWCcdY8SmsBiI/cXIGUV5rrI4W3l
 hnnFrY5pwnYtiE2uvL7q6ozEKrqEyiY56wVdt/LIfjTZQXvPVELqJ70RJaojiH9hzMO6HBhELGA
 ypCWENhnowv24fVtCQ9x+aSziKXzizLHSq/TC7UQUntxEGornuysVxN18S3RLcT/6eoo1NonHyd
 yqjUCkuOHgtuVLt/McG+pvRR8rT+IKGfVlKdcuuYceu6CIqeBgq0zQPPmlw==
X-Received: by 2002:a05:622a:2598:b0:4b7:a680:2111 with SMTP id
 d75a77b69052e-4f03fde8ca1mr102420871cf.8.1765213433857; 
 Mon, 08 Dec 2025 09:03:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCiIch+3JpLNDXcLRMMCmCbIgw+K/9ssf7JvjBPoGZrlzBz77BF26hYeCTNfVLlkzjBMxHIw==
X-Received: by 2002:a05:622a:2598:b0:4b7:a680:2111 with SMTP id
 d75a77b69052e-4f03fde8ca1mr102420361cf.8.1765213433458; 
 Mon, 08 Dec 2025 09:03:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f027d0132fsm86452571cf.18.2025.12.08.09.03.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 09:03:52 -0800 (PST)
Message-ID: <fe2728de-4399-4452-8f8f-a9b1dfb6be62@redhat.com>
Date: Mon, 8 Dec 2025 18:03:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/33] hw/pci/pci: Introduce a callback to retrieve the
 MSI doorbell GPA directly
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-17-skolothumtho@nvidia.com>
 <377d4c92-bfb0-4743-94d4-c4bf8dcb2934@redhat.com>
 <CH3PR12MB754847D3EC2A35D54F0317EAABA6A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB754847D3EC2A35D54F0317EAABA6A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 12/4/25 7:57 PM, Shameer Kolothum wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 04 December 2025 16:39
>> To: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; Jason Gunthorpe <jgg@nvidia.com>; Nicolin
>> Chen <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
>> Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>> smostafa@google.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
>> Krishnakant Jaju <kjaju@nvidia.com>; Michael S . Tsirkin <mst@redhat.com>
>> Subject: Re: [PATCH v6 16/33] hw/pci/pci: Introduce a callback to retrieve the
>> MSI doorbell GPA directly
>>
>> External email: Use caution opening links or attachments
> ...
>  
>>> --- a/target/arm/kvm.c
>>> +++ b/target/arm/kvm.c
>>> @@ -1620,26 +1620,42 @@ int kvm_arch_fixup_msi_route(struct
>> kvm_irq_routing_entry *route,
>>>          return 0;
>>>      }
>>>
>>> +    /*
>>> +     * We do have an IOMMU address space, but for some vIOMMU
>> implementations
>>> +     * (e.g. accelerated SMMUv3) the translation tables are programmed into
>>> +     * the physical SMMUv3 in the host (nested S1=guest, S2=host). QEMU
>> cannot
>>> +     * walk these tables in a safe way, so in that case we obtain the MSI
>>> +     * doorbell GPA directly from the vIOMMU backend and ignore the
>> gIOVA
>>> +     * @address.
>>> +     */
>>> +    if (pci_device_iommu_msi_direct_gpa(dev, &doorbell_gpa)) {
>>> +        goto set_doorbell;
>>> +    }
>>> +
>>>      /* MSI doorbell address is translated by an IOMMU */
>>>
>>> -    RCU_READ_LOCK_GUARD();
>>> +    rcu_read_lock();
>> what is the rationale behind the RCU changes?
>>
> Otherwise, it will crash if this fn returns via the goto set_doorbell path
> with,
>
> include/qemu/rcu.h:101: rcu_read_unlock: Assertion `p_rcu_reader->depth != 0' failed
>
> goto set_doorbell path skips over the scope where RCU_READ_LOCK_GUARD() 
> is active. When the function later reaches rcu_read_unlock() implicitly via
> destructor,  the guard was never entered, so we hit above.
>
> An alternative would be to wrap the translation logic in its own block, like
>
>     if (pci_device_iommu_msi_direct_gpa(dev, &doorbell_gpa)) {
>          goto set_doorbell;
>     }
>
>     {
>         RCU_READ_LOCK_GUARD();
>        /* MSI translation logic */
>     }
>
> set_doorbell:
>     route->u.msi.address_lo = doorbell_gpa;
>     route->u.msi.address_hi = doorbell_gpa >> 32;
>     return 0;
>
> Or could do:
>
> if (!pci_device_iommu_msi_direct_gpa(dev, &doorbell_gpa)) {
>     RCU_READ_LOCK_GUARD();
>     /* translation logic */
> }
> route->u.msi.address_lo = doorbell_gpa;
> route->u.msi.address_hi = doorbell_gpa >> 32;
> return 0;
>
> Both approaches work, but I find the explicit lock/unlock variant easier
> to follow. Please let me know if there is a better way.

thank you for the explanation. It was not obvious to me. Maybe document
that in the commit msg and keep the current version.
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric

>
> Thanks,
> Shameer
>


