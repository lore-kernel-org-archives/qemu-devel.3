Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45ACC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 16:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdtZR-0005Pp-2d; Fri, 31 Jan 2025 11:08:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tdtZP-0005PR-Nf
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 11:08:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tdtZN-0007AJ-Ec
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 11:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738339715;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6aajYEpX8wIlISw9r5i3wytkU3PBeq2yQPEpeWE9yXw=;
 b=XixCaU/Samh6FVALTbIHjbOxgwkyJ40q1Mcjd8TVWhR+3Gjk609pYDBg8kqX/0jJ9HsIKq
 Bdm7A4Ntl1TuSGoWpu0dJ/ddoraqLk2jAnAtR9WGrMmlAHAeDJl9asPjwf1aG+XdDTv20S
 AOaNtHGvSOSeQZpygLzQui2tqakNtsQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-tWdfWEOdPYmVu0HM3HhtKA-1; Fri, 31 Jan 2025 11:08:33 -0500
X-MC-Unique: tWdfWEOdPYmVu0HM3HhtKA-1
X-Mimecast-MFC-AGG-ID: tWdfWEOdPYmVu0HM3HhtKA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361efc9d1fso16534545e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 08:08:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738339712; x=1738944512;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6aajYEpX8wIlISw9r5i3wytkU3PBeq2yQPEpeWE9yXw=;
 b=q/vGEV0L7Ke6iAzTOODnKCSl1sxLAOUtmhhRm45w99r6VbuZnReVdVbbkHqoTTWpae
 BGcpx1rBBPSZAWSVJCUUoSmzFVlkAFXcwLMRcaBnnRb4dONrcS9MnK9sDJr6jPj1G6iO
 NzfWyLnEQd4wfQKmeD9YSB4BKUGQvEqO0XSHqUWBmDqM7SWAzh/k8k9GDYZE2BBkQMvS
 IhCR1dHzVhm+X1sbaOyaw7EHp1pQigAZz/8xs+QAxaW+3MECqbXDsmoTiBCKmo1IcrbR
 dIhAG60q/KhMEScDqd7sQVsj298EPUXdy1DYTzjQvcKtFLtMSXtVfbaHPOIz7Mvl7lRW
 BNdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN1/CG8Za/Zv5gnJ6HjIzOtfjPDHdIAlBo8taAfoINC2eaSk0WMYNAAZAXpbzJ3fzGVZp0SB0sIUn7@nongnu.org
X-Gm-Message-State: AOJu0YzoPXhxI/j5RnDQoiBfx4c2YfrqmyB5aQCWGt3Rb7X9l6yPBSva
 dehQ5BkB18YINkIhfHAWC8dNoER04uApKPSZXFkXJdNq2vVeqekM/M6BhwrxMk4hzSWPtNQ8GbH
 ipfG+WRwrhhhYj2MfMiVFbE9i/bZBfbY52fCbHv/xLDuiwEgX/pog
X-Gm-Gg: ASbGncv5ABXsdNVi9z0PKz2+UUikVwCKh8D4NQW/TglYS+YquhpJRS7gPRcoL9cq42x
 x69UVWxg7rSv0YOpIJpjvn690rPPn1sM0tR4HdKayJ3LlXMzqQs+GurtBx0svYeK0d9EyuBltUs
 g7iCd74IOneOBDyX2Z6bXJozw80HiTniz75gZUA3ytQP7aec6K277ju0iJjJrQEPtozN3lR4P0q
 JiRVCcVT1hmbx4XF7vRVk2xMi9V4NG+rfNAwhvOy86J0ZhjOwFCn9fVj3q4R1T72m3GT9O4ZfJK
 y/XZeG1A0SaGlDPQ+QRRpjSsQNFeIEW158reWVntKoWYxiM7MNyb
X-Received: by 2002:a05:600c:1c93:b0:435:9ed3:5698 with SMTP id
 5b1f17b1804b1-438dc41d1cbmr98456365e9.24.1738339712030; 
 Fri, 31 Jan 2025 08:08:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiaOsnypjQZYP0JyKVw8kvMrGunHylv67sc+KD0Lu3DbDdn8sNLEM5cne3sVJoqNvaak+HZw==
X-Received: by 2002:a05:600c:1c93:b0:435:9ed3:5698 with SMTP id
 5b1f17b1804b1-438dc41d1cbmr98455845e9.24.1738339711596; 
 Fri, 31 Jan 2025 08:08:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438d755387fsm80315405e9.0.2025.01.31.08.08.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 08:08:30 -0800 (PST)
Message-ID: <c292ab40-3620-4e72-b043-4e3cbd7fd297@redhat.com>
Date: Fri, 31 Jan 2025 17:08:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Nathan Chen <nathanc@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z5uiGnAxUf4jXTEI@redhat.com> <7ecabe74e0514367baf28d67675e5db8@huawei.com>
 <fc91e1a798324390b2a556fae5d40f46@huawei.com>
 <20250131142404.GP5556@nvidia.com>
 <3efcea1171af4b2f81be842f2c55fe51@huawei.com>
 <20250131145411.GR5556@nvidia.com>
 <20039bbc40df453a8a41a863d74b9ff9@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20039bbc40df453a8a41a863d74b9ff9@huawei.com>
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,


On 1/31/25 4:23 PM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Friday, January 31, 2025 2:54 PM
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> Cc: Daniel P. Berrangé <berrange@redhat.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org; eric.auger@redhat.com;
>> peter.maydell@linaro.org; nicolinc@nvidia.com; ddutile@redhat.com;
>> Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
>> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
>> Jonathan Cameron <jonathan.cameron@huawei.com>;
>> zhangfei.gao@linaro.org; Nathan Chen <nathanc@nvidia.com>
>> Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
>> nested SMMUv3
>>
>> On Fri, Jan 31, 2025 at 02:39:53PM +0000, Shameerali Kolothum Thodi
>> wrote:
>>
>>>>> And Qemu does some checking to make sure that the device is indeed
>>>> associated
>>>>> with the specified phys-smmuv3.  This can be done going through the
>>>> sysfs path checking
>>>>> which is what I guess libvirt is currently doing to populate the
>> topology.
>>>> So basically
>>>>> Qemu is just replicating that to validate again.
>>>> I would prefer that iommufd users not have to go out to sysfs..
>>>>
>>>>> Or another option is extending the IOMMU_GET_HW_INFO IOCTL to
>>>> return the phys
>>>>> smmuv3 base address which can avoid going through the sysfs.
>>>> It also doesn't seem great to expose a physical address. But we could
>>>> have an 'iommu instance id' that was a unique small integer?
>>> Ok. But how the user space can map that to the device?
>> Why does it need to?
>>
>> libvirt picks some label for the vsmmu instance, it doesn't matter
>> what the string is.
>>
>> qemu validates that all of the vsmmu instances are only linked to PCI
>> device that have the same iommu ID. This is already happening in the
>> kernel, it will fail attaches to mismatched instances.
>>
>> Nothing further is needed?
> -device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \
> -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1 \
> -device arm-smmuv3-accel,bus=pcie.1,id=smmuv1 \
I don't get what is the point of adding such an id if it is not
referenced anywhere?

Eric
> -device vfio-pci,host=0000:7d:02.1,bus=pcie.port1,iommufd=iommufd0 \
>
> -device pxb-pcie,id=pcie.2,bus_nr=16,bus=pcie.0 \
> -device pcie-root-port,id=pcie.port2,bus=pcie.2,chassis=2 \
> -device arm-smmuv3-accel,pci-bus=pcie.2,id=smmuv2 \
> -device vfio-pci,host=0000:75:00.1,bus=pcie.port2,iommufd=iommufd0 \
>
> I think it works from a functionality point of view. A  particular
> instance of arm-smmuv3-accel(say id=smmuv1) can only have devices attached
> to the same phys smmuv3 "iommu instance id"
>
> But not sure from a libvirt/Qemu interface point of view[0] the concerns
> are addressed. Daniel/Nathan?
>
> Thanks,
> Shameer
> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/message/X6R52JRBYDFZ5PSJFR534A655UZ3RHKN/
>


