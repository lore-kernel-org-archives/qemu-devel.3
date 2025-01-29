Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07680C02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 07:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td2vU-0004mi-Os; Wed, 29 Jan 2025 02:55:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1td2vT-0004ma-LI
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 02:55:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1td2vS-0008Cj-2N
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 02:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738137352;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XpSm7iSgrJkvFtrNcJB3e64q71CjkGCD+5jKVVlI5sw=;
 b=NGfbSw9f/cuAgMAuxhvDKDIamHkWnNoWF2ylp2dzOamIFw5mdP/iobh4gjUHoiCW9oyEyw
 zA+76DsSKlu8mFenBrGBwvgXAukbU3LpU33fSso3k/CpwDbWQOI/aIUiULH+RYkWtKIMo3
 IOztM9XWOnbTtdnCmCbI/SsbeE+DB58=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-cDa46g0eNvyKhdzIF3oFKA-1; Wed, 29 Jan 2025 02:55:48 -0500
X-MC-Unique: cDa46g0eNvyKhdzIF3oFKA-1
X-Mimecast-MFC-AGG-ID: cDa46g0eNvyKhdzIF3oFKA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361f371908so45198935e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 23:55:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738137346; x=1738742146;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XpSm7iSgrJkvFtrNcJB3e64q71CjkGCD+5jKVVlI5sw=;
 b=Yfq+PQdBQeuEM63BaMu+EmQk0isTio8+ccN9G++OejtwhB6FDeAyD2fEKmt7u72kNV
 i3M5EgfzE00Nt/3SdbEDNwLA8vNh4y3xtV6I8vC5Bwh2Lsidj54puHla+iRVQC4omAvU
 8U3vQBtEE9Sgmf6d0aVDqNjB/tWJptEZ68MQ+UGWi96i9xo2oEhME32+eTwnn88lHHZI
 gkxPkBZJyET94XWnVJoTvLRaY4X7f8Jwd6J9TdedMb/VY2eWnrN+8VDFJbMMoJgxWH0R
 rKWshiPPMtrO6TIZi0uFWZqhTWzywaGHtgtpFCf1DVtJn5vyGrIML0xYnTYcyZHZ2vbs
 Q2wg==
X-Gm-Message-State: AOJu0YxmnOmwRe+UmSQICeolCS/efj2B6C4AK/JEFPvctrtbwfboICmB
 o81SKtDrvooWWhQ6pfwEh7+KJE6SE2C7wote/CR4bEbD63yaL+yLOEBOTG/rycl6RG4zwPbr9qi
 zCAj0y854oOHYu5MU0C2lRnWUxdklapf+hb1FJK35ibxnnNzqNYKGw1Xic3XD
X-Gm-Gg: ASbGnctQ4PcrnJinEQqCTp/sIZSXyBLb0ilSLSkLPNJyvqqUaY4D6oA5JbJeStVvFu+
 ketEXyWxRxAa26aO3jh9veiwaxCCx7nWZpywn2cv9s6c7plFIIa7SsjsVYn+UpMJtJvvJoBxl9c
 mblznyTzbvYKXiRl2L7WeS5VRYqBf0YXZ8gCBK8lGIfN8Mx2p1nQRtREL812i9BY6eNldH5Jvi1
 KZDQ7iGi92jrM4J3mwVO7PO9WSOe1iZM29i/ARYl4cw7anzzaP0a4MZcNj/634+4s1wpJtJjQon
 6c/9ylAbxUWciXIAv3OP5tAEbstWUVXw/6rwTHUIxhr43MiWM45W
X-Received: by 2002:a05:600c:46c9:b0:436:faeb:2a18 with SMTP id
 5b1f17b1804b1-438dc3bb657mr14228885e9.6.1738137346396; 
 Tue, 28 Jan 2025 23:55:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPUX5j7qVXvjGOwUX1AdkEoqAqXyPhztjf6NmUNF1N/8JzwhD/JqGnMd1tPHaDWLyVbK16jw==
X-Received: by 2002:a05:600c:46c9:b0:436:faeb:2a18 with SMTP id
 5b1f17b1804b1-438dc3bb657mr14228705e9.6.1738137345996; 
 Tue, 28 Jan 2025 23:55:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc6df51sm12926875e9.30.2025.01.28.23.55.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 23:55:44 -0800 (PST)
Message-ID: <0d303a69-0779-4309-9c00-c76afc82d324@redhat.com>
Date: Wed, 29 Jan 2025 08:55:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/virt: Support larger highmem MMIO regions
Content-Language: en-US
To: Matt Ochs <mochs@nvidia.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Nathan Chen <nathanc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>
References: <20250128160237.3379569-1-mochs@nvidia.com>
 <73f3e4cf927845809c6b10424c00c0ff@huawei.com>
 <cb91da0e-9163-4e59-a060-4a76a077c5d5@redhat.com>
 <BDF4F631-8A96-41B5-B7CE-2BD631C23A2B@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <BDF4F631-8A96-41B5-B7CE-2BD631C23A2B@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,


On 1/28/25 10:28 PM, Matt Ochs wrote:
>> On Jan 28, 2025, at 11:52 AM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> Hi Matthew, Shameer,
>>
>> On 1/28/25 6:36 PM, Shameerali Kolothum Thodi wrote:
>>>> -----Original Message-----
>>>> From: Matthew R. Ochs <mochs@nvidia.com>
>>>> Sent: Tuesday, January 28, 2025 4:03 PM
>>>> To: qemu-devel@nongnu.org; Shameerali Kolothum Thodi
>>>> <shameerali.kolothum.thodi@huawei.com>; nathanc@nvidia.com
>>>> Cc: ddutile@redhat.com; eric.auger@redhat.com; nicolinc@nvidia.com;
>>>> ankita@nvidia.com
>>>> Subject: [PATCH] hw/arm/virt: Support larger highmem MMIO regions
>>>>
>>>> The MMIO region size required to support virtualized environments with
>>>> large PCI BAR regions can exceed the hardcoded limit configured in QEMU.
>>>> For example, a VM with multiple NVIDIA Grace-Hopper GPUs passed
>>>> through
>>>> requires more MMIO memory than the amount provided by
>>>> VIRT_HIGH_PCIE_MMIO
>>>> (currently 512GB). Instead of updating VIRT_HIGH_PCIE_MMIO, introduce a
>>>> new parameter, highmem-mmio-size, that specifies the MMIO size required
>>>> to support the VM configuration.
>>>>
>>>> Example usage with 1TB MMIO region size:
>>>> -machine virt,gic-version=3,highmem-mmio-size=1099511627776
>>> I guess you could do highmem-mmio-size=1024G as well.
> Sure, the visit_type_size() helper can understand the common unit suffixes
> used for sizes, e.g. 1T. To clarify, I’ll update the example in v2.
>
>>>> +highmem-mmio-size
>>>> +  Set extended MMIO memory map size. Must be a power-of-2 and greater
>> maybe keep the existing terminology, ie. high PCIE MMIO region.
>> extended_memmap
>> Would deserve to add some comments on top of extended_memmap[] too.
> Thanks for the suggestion, will update the patch to use existing terminology.
>
>>>> +    if (!visit_type_size(v, name, &size, errp))
>>>> +        return;
>>> Qemu style mandates braces around.
> Will fix in v2.
>
>>>> +
>>>> +    if (!is_power_of_2(size)) {
>>>> +        error_setg(errp, "highmem_mmio_size is not a power-of-2");
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    if (size < extended_memmap[VIRT_HIGH_PCIE_MMIO].size) {
>>> Not sure it is better to fallback to default size here instead of setting error.
>> I think if the user sets a value it shall be obeyed
> Agreed.
>
>> Note that per the dynamic memory map algo, changing the size will also
>> change the base address. See
>>
>> virt_set_high_memmap(). By the wayn why do we forbid a smaller size?
> That’s a good point, I will remove this check.
>
>>>> +    object_class_property_add(oc, "highmem-mmio-size", "size",
>>>> +                                   virt_get_highmem_mmio_size,
>>>> +                                   virt_set_highmem_mmio_size,
>>>> +                                   NULL, NULL);
>>>> +    object_class_property_set_description(oc, "highmem-mmio-size",
>>>> +                                          "Set extended MMIO memory map size");
>>>> +
>>> I think this probably needs backward compatibility to keep migration happy.
>>> Isn't it? See the no_highmem_compact handling.
>> I guess if we keep the same value as default we are good. The difference
>> with highmem_compact is it was set by default from 7.2 onwards hence
>> changing the mmio layout. Here by default you keep the same IIUC.
> I’m not sure I see an issue since the code is directly modifying the size value
> in the extended_memmap array.

I meant that if by default we keep the size value equal to 512G (the
existing default value), I don't think we need to care about compats.

Eric
>
>


