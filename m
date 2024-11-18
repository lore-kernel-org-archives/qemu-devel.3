Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9F5D591A9
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 18:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD6CM-0007RM-1E; Mon, 18 Nov 2024 13:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tD6C3-0007BN-SP
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 13:09:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tD6C2-0000J7-2x
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 13:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731953385;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hPbCzkjs6ZZWhiwVvW4S1AqDNtM3toEreWpvw/bel0=;
 b=Yq78sD1ABuDWAxPXmpZaAuSv5BUImBq+toNh2QVQKbzRvzYKMPDXWb7PE6zaBg5/aLgOdE
 sav/HmuOBsRVODs6Qba61XSEx2d5B4pDMGuGfo8fXsZHbTYNZf303etnhYGP760LWl63E1
 vDFByD5Crj9fgDH7SyIRe9MFgKQkHq8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-9dRi6neVMQeb7JUdSNZFXA-1; Mon, 18 Nov 2024 13:09:41 -0500
X-MC-Unique: 9dRi6neVMQeb7JUdSNZFXA-1
X-Mimecast-MFC-AGG-ID: 9dRi6neVMQeb7JUdSNZFXA
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4635782f000so92157871cf.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 10:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731953381; x=1732558181;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8hPbCzkjs6ZZWhiwVvW4S1AqDNtM3toEreWpvw/bel0=;
 b=SP1neabUm4AyM/MxvsORYiDpUT9YoAqk8mYAcph+xwkgvfcngmC//ZMaQE7bPqewce
 /uRQIn4gyomymtvUlbr8u3i2GpaYZDWD8wvEHAPqeX5/QgDACt3VGqi186xuJk3UYgDw
 K4byCUokY+H3/DoB+5EoVYo6pYNDrHkgpZUM/+3XZiabwe+/2QBbskEerLSIlgdFGCDD
 TIXU38R8OfFSqSfUqmeQGM4vtcdW7S4rVnYzW/wVYFbaIpbFs/LnUTLqXaQ4tbAvJe6J
 SDkWUs0wp/BH++h7Ybh8WtcPMBkd4JzSp+EzTLbLH5hKgkNkq/h0HVw7hTvsE8TEP44L
 6RNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTqLbf10dccAjtyB6IVF/AMrvH/KveGtmQIOlvAoHuEgjI/7H9qnkWFJX7TnDdEjjde1gk/Nva4nSX@nongnu.org
X-Gm-Message-State: AOJu0Yw+aPZieGyUoCIfYATrgpoRCLNuECkl3Z6qVYLJWtF86r0hwyxs
 taTkJ7KFFXIAeLBimlzaS+kzmZx8UNt0B+Og0eeP3w0krBjpnxvxysWEDaPG8dBhP067CXmksSS
 Zi5Vh5+3P1MrODeUS6XzJO4ewJvNN4v0K1BU7niGXRF2WlDQHkpz1
X-Received: by 2002:a05:622a:54:b0:461:2536:f226 with SMTP id
 d75a77b69052e-46392d80757mr5554451cf.12.1731953381360; 
 Mon, 18 Nov 2024 10:09:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3txuHkLgBqBoPU4Z0YENOa03qotQlBSE365V80NLx2d23Qr1vkM2u/TiwNEF2f/ECnWcekA==
X-Received: by 2002:a05:622a:54:b0:461:2536:f226 with SMTP id
 d75a77b69052e-46392d80757mr5553951cf.12.1731953381037; 
 Mon, 18 Nov 2024 10:09:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b37a856e2asm12441385a.41.2024.11.18.10.09.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 10:09:40 -0800 (PST)
Message-ID: <aafc5fba-8d68-4796-a846-265362e7acac@redhat.com>
Date: Mon, 18 Nov 2024 19:09:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] hw/arm/virt-acpi-build: Build IORT with multiple
 SMMU nodes
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-5-shameerali.kolothum.thodi@huawei.com>
 <1dcea5ca-806f-4f51-8b13-faf5d62eb086@redhat.com>
 <efb9fb7fb0f04d92b7776cdbc474585d@huawei.com>
 <48bb0455-7c2e-4cc6-aa15-ebe4311d8430@redhat.com>
 <0803ec1a010a46b9811543e1044c3176@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <0803ec1a010a46b9811543e1044c3176@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/18/24 16:00, Shameerali Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Monday, November 18, 2024 1:46 PM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
>> ddutile@redhat.com; Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
>> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
>> Jonathan Cameron <jonathan.cameron@huawei.com>;
>> zhangfei.gao@linaro.org
>> Subject: Re: [RFC PATCH 4/5] hw/arm/virt-acpi-build: Build IORT with
>> multiple SMMU nodes
>>
>>>>>      /* Number of IORT Nodes */
>>>>> @@ -342,10 +356,9 @@ build_iort(GArray *table_data, BIOSLinker
>>>> *linker, VirtMachineState *vms)
>>>>>      /* GIC ITS Identifier Array */
>>>>>      build_append_int_noprefix(table_data, 0 /* MADT translation_id */,
>>>> 4);
>>>>> -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
>>>>> -        int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
>>>>> +    for (i = 0; i < num_smmus; i++) {
>>>>> +        smmu_offset[i] = table_data->len - table.table_offset;
>>>>>
>>>> I would have expected changes in the smmu idmap has well. If a given
>>>> SMMU instance now protects a given bus hierarchy shouldn't it be
>>>> reflected in a differentiated SMMU idmap for each of them (RID subset
>> of
>>>> SMMU->pci-bus mapping to a specific IORT SMMU node)? How is it done
>>>> currently?
>>> I thought that smmu_idmaps will be handled by this ?
>>>
>>> object_child_foreach_recursive(object_get_root(),
>>>                                        iort_host_bridges, smmu_idmaps);
>> to me this traverses the qemu object hierarchy to find all host bridges
>> and for each of them builds an idmap array (smmu_idmaps mapping this
>> RC
>> RID range to this SMMU). But to me those idmaps will be assigned to
>> *all* SMMU insteaces leading to a wong IORT description because all
>> SMMUs will be protecting all devices. You shall only retain idmaps which
>> correspond to the pci_bus a given vSMMU is attached to. Then each SMMU
>> will protect a distinct PCIe subtree which does not seem the case today.
>> At least that's my current understanding.
> Ah..right. I will fix that in next version. 
>
> I think the above won't affect the basic case where I have only one
> pcie-pxb/SMMUv3. But even in that case hot add seems not working.
>
> I tried hacking the min/max ranges as suspected by Nicolin. But still not enough to 
> get it working.  Do you have any hint on why the hot add(described below) is not
> working?
Hum thought the duplicate idmap could be the cause. Otherwise I have no
clue. I would advice to fix it first.

Eric
>
> Thanks,
> Shameer
>
>> Eric
>>
>>
>>> But it is possible that, there is a bug in this IORT generation here as I am
>> not
>>> able to hot add  devices. It looks like the pciehp interrupt is not
>> generated/received
>>> for some reason. Nicolin[0] is suspecting the min/max bus range in
>>> iort_host_bridges() may not leave enough ranges for hot add later.
>>>
>>> Cold plugging devices to different SMMUv3/pcie-pxb seems to be alright.
>>>
>>> I will debug that soon.
>>>
>>> Thanks,
>>> Shameer
>>> [0] https://lore.kernel.org/qemu-devel/ZzPd1F%2FUA2MKMbwl@Asurada-
>> Nvidia/
>>>


