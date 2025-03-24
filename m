Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B81C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 15:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twjpX-0003cj-SA; Mon, 24 Mar 2025 11:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1twjpT-0003av-OS
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 11:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1twjpP-0000aw-Jd
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 11:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742830500;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0mF0KCivyzFQot6GHwz/QXo5Xq1LGOjWGQ7K2aoxWRk=;
 b=eXTLdJZuOQmMVSBj6hlYurN0gCR+xX4UA1AkepKfffuOvN+y7D1Vyz/+VmopBf6RMYaAQG
 i4accnvxwhrw25oBfVWNzzJvSKdQE4tLSFb2VWo6QU7xJ6cxjKjCsZfENToIDTOoAEU12h
 qp7jdSzrhYO0Ogqou6B52bLNTxy4d5w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-U8tijGPdMmCxnIOH-PMkHw-1; Mon, 24 Mar 2025 11:34:59 -0400
X-MC-Unique: U8tijGPdMmCxnIOH-PMkHw-1
X-Mimecast-MFC-AGG-ID: U8tijGPdMmCxnIOH-PMkHw_1742830498
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39abdadb0f0so710421f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 08:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742830498; x=1743435298;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0mF0KCivyzFQot6GHwz/QXo5Xq1LGOjWGQ7K2aoxWRk=;
 b=oYdSlWTFKrshPMo6eCZVbT7h5J87WUevrOvl1xgEglaUo+KYkrMENafu5uea54MGN9
 6sOrei9j5WcCbWLhxal0JRWzc0xyeol2x3z9mH+SzbT4CZtH/Q8YZrtp3ffRoJzjtsqa
 5xxYFMC1zLaCv/HgQFYac9Kj+CAY8rnQuLbXEex/Wj44CSUZfvSwfXedNFlpiIZZGvN2
 GkthAW+1J/LTokzCjX96EOkW4YwEG1WecinIfz6izt/lZ4J7XODXMKcKcD0lwuUFH7rb
 SopaNlZuXY6NmYWJAtfIoeNpPaASZdJqGn1x2fcjOlsZQfBJBeae532atsEA+yNPlYSN
 Bf7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM6kGgXj5rs/I/gqLvKbpaBX5+2bkMHbyODZhlMZLhvcNmFtzDXt8JgHC8puyOTiNcHI/XHFzfkffo@nongnu.org
X-Gm-Message-State: AOJu0YyvBoEI/mxY+h+tXZUJDCfWwtNVICgRtzeHpuXCeTnW+pt5/iCv
 9lX2muYrwHmZ/qWr8GBE7RV3dOncJ4DOBCyBTSJYQmt4L3+yVq2D/Gzr+6p7S3LukKnssRU8lII
 pohEFG//Vf3/F/+3mxGapFzdac2RhEIB+PGWszSzpPpfW7HnHbePg
X-Gm-Gg: ASbGncvlhZayEGnNTGFc3hH5dTmpPPExNAxec2ZZ0QfSlPveuoZKVXRsAtWv/FT2boQ
 vFAWqKzaTF/t2mJwIJMx8XYhhsSBKxvFmHJ/x/26D1PnPenC28Fk+AQiED3J6auCgQaVV2Aiw4K
 qKyHdd5y1UQYKNs94xZ+5WJAlMqBw35ukK9oB46a/E9P2jR92l/5vzcSKupbrwd+sRxSYCTFazk
 +3R2PPtl0WPSiHH9VCeDoLGWz+caQWm0LakwTIYQacd0sODr+WFygiB1ZJn6NPAd4e9jNHK1Q/n
 R8d8nh5spdxx3UFn7TwMvG2TWVArknk3SqfnVKbREZHf+ef8HAz+IZZYiw16v0I=
X-Received: by 2002:a05:6000:2b08:b0:38f:3c01:fb1f with SMTP id
 ffacd0b85a97d-3997f90a518mr7781355f8f.30.1742830497862; 
 Mon, 24 Mar 2025 08:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSa/DU6c7EEy+1/VhhSmi7lCCdIgg0Ru7/rMIXj9ZdIOON91LQXU8/rlNnn8fECv2T7ezQ4Q==
X-Received: by 2002:a05:6000:2b08:b0:38f:3c01:fb1f with SMTP id
 ffacd0b85a97d-3997f90a518mr7781331f8f.30.1742830497415; 
 Mon, 24 Mar 2025 08:34:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39abafed528sm7815944f8f.27.2025.03.24.08.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 08:34:56 -0700 (PDT)
Message-ID: <466ea2a7-c113-426d-ad71-cb39efd2595f@redhat.com>
Date: Mon, 24 Mar 2025 16:34:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: Donald Dutile <ddutile@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
 <b3a4ce7f-41a9-4da9-a8ca-54848b9e9cf1@redhat.com>
 <3d1312b411f04121a3be90879a915982@huawei.com>
 <Z9xKL49nOenvQIsW@Asurada-Nvidia>
 <2f84490d309440a4a2ac56fd893ddab8@huawei.com>
 <ad0b5fac-2a7f-4978-9f6b-0f7b1df14a35@redhat.com>
 <a5ba5e2228b24338b4ef509bb1748739@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <a5ba5e2228b24338b4ef509bb1748739@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 3/24/25 2:55 PM, Shameerali Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: qemu-devel-
>> bounces+shameerali.kolothum.thodi=huawei.com@nongnu.org <qemu-
>> devel-bounces+shameerali.kolothum.thodi=huawei.com@nongnu.org> On
>> Behalf Of Eric Auger
>> Sent: Monday, March 24, 2025 1:13 PM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; Nicolin Chen
>> <nicolinc@nvidia.com>
>> Cc: Donald Dutile <ddutile@redhat.com>; qemu-arm@nongnu.org; qemu-
>> devel@nongnu.org; peter.maydell@linaro.org; jgg@nvidia.com;
>> berrange@redhat.com; nathanc@nvidia.com; mochs@nvidia.com;
>> smostafa@google.com; Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
>> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
>> Jonathan Cameron <jonathan.cameron@huawei.com>;
>> zhangfei.gao@linaro.org
>> Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-
>> pcie bus
>>
>> Hi Shameer,
>>
>> On 3/24/25 9:19 AM, Shameerali Kolothum Thodi wrote:
>>>> -----Original Message-----
>>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>> Sent: Thursday, March 20, 2025 5:03 PM
>>>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>
>>>> Cc: Donald Dutile <ddutile@redhat.com>; qemu-arm@nongnu.org;
>> qemu-
>>>> devel@nongnu.org; eric.auger@redhat.com; peter.maydell@linaro.org;
>>>> jgg@nvidia.com; berrange@redhat.com; nathanc@nvidia.com;
>>>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>>>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>>>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>>>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>>>> Subject: Re: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a
>> pxb-
>>>> pcie bus
>>>>
>>>> On Wed, Mar 19, 2025 at 09:26:29AM +0000, Shameerali Kolothum Thodi
>>>> wrote:
>>>>> Having said that,  current code only allows pxb-pcie root complexes
>>>> avoiding
>>>>> the pcie.0. The idea behind this was, user can use pcie.0 with a non
>> accel
>>>> SMMUv3
>>>>> for any emulated devices avoiding the performance bottlenecks we are
>>>>> discussing for emulated dev+smmuv3-accel cases. But based on the
>>>> feedback from
>>>>> Eric and Daniel I will relax that restriction and will allow association
>> with
>>>> pcie.0.
>>>>
>>>> Just want a clarification here..
>>>>
>>>> If VM has a passthrough device only:
>>>>  attach it to PCIE.0 <=> vSMMU0 (accel=on)
>>> Yes. Basically support accel=on to pcie.0 as well.
>> agreed we shall be able to instantiate the accelerated SMMU on pcie.0 too.
>>>> If VM has an emulated device and a passthrough device:
>>>>  attach the emulated device to PCIE.0 <=> vSMMU bypass (or accel=off?)
>>>>  attach the passthrough device to pxb-pcie <=> vSMMU0 (accel=on)
>>> This can be other way around as well:
>>> ie,
>>> pass-through to pcie.0(accel=on) and emulated to any other pxb-pcie with
>> accel = off.
>> +1
>>> I think the way bus numbers are allocated in Qemu for pcie.0 and pxb-
>> pcie allows
>>> us to support this in IORT ID maps.
>> One trouble we may get into is possible bus reordering by the guest. I
>> don't know the details but I remember that in certain conditions the
>> guest can reorder the bus numbers.
> Yeah, Guest kernel can re-enumerate PCIe. I will check.
>  
>> Besides what I don't get in the above discussion, related to whether the
>> accelerated mode can also sipport emulated devices, is that if you use
>> the originally suggested hierarchy (pxb-pcie + root port + VFIO device)
>> you eventually get on guest side 2 devices protected by the SMMU
>> instance: the root port and the VFIO device. They end up in different
>> iommu groups. So there is already a mix of emulated and VFIO device.
> True. But I guess the root port associated activity(invalidations etc) will be
> very minimal(or nil?) compared to a virtio device.
Agreed. I just meant discriminating between devices that can bring
trouble and others may require some caution

Eric
>
> Thanks,
> Shameer
>
>
>


