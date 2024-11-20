Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154E7D711BC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 16:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDnIF-0001yC-1h; Wed, 20 Nov 2024 11:11:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tDnIC-0001xn-UT
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 11:11:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tDnIA-0008M5-49
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 11:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732119054;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nm/LX0o9cL2dfqFJviXHC7fgFsJ0xM8xd8o8x+AtuMc=;
 b=Kv5JmjW6a84gzSIrf/98kUWU6svmfR2tz8FfWhJR1YK9hdaVafI33+3BLURmzcQx8YdS1u
 NQdIb4rq+4Iad6fZMcYZOlR3KK4Wf0dlbMBp6C7/jTzjyGMZFqG4ExnrMZhFR0NbhSW0Ik
 mcTnF4B9m0gnkzNkb5EoKkyCVjQ+3+Q=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-t2_f9gvxPAC8B_IAEOj_4A-1; Wed, 20 Nov 2024 11:10:53 -0500
X-MC-Unique: t2_f9gvxPAC8B_IAEOj_4A-1
X-Mimecast-MFC-AGG-ID: t2_f9gvxPAC8B_IAEOj_4A
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b1492b01b0so674858485a.2
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 08:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732119053; x=1732723853;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nm/LX0o9cL2dfqFJviXHC7fgFsJ0xM8xd8o8x+AtuMc=;
 b=koQMW3Q2/TNxwsmXaPW8UustyfBEAFT6EHVAhlF2suwjyNQSAS9Bzk8xXXicijoUWE
 JD4cjN6Is/oOWxYoNeyWnN4CdvILhBYxBuf6q4l5V2zMc/xiXuMA2Sri4uU1idOjjcNr
 NvZ0R+k5xUEh4SffZxPLLqdfGsjzuu9JqXZGPtn0/ahl6HbTCmgB8/AGug7jDaL3kRuy
 /T8bsxcOVFmvsvtq4oV1NMF5Ab7QXRBNaW6LeZfFG0cRfbWzq4bkcu0dcZuFHfdB7/Q7
 GiZxDbvhqBvCuMW7FYFs44FJwDcWXt4HPoFSdcV119itIk0pZM4n3o0B6mltAncE+dug
 m/KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCqgHtIPn3v4g6scXqKZ03njMaPZ/ROD7li69FeehBzEoIv8+3hOsqsgPOYJ9+JPTZVI66CM/4ARFF@nongnu.org
X-Gm-Message-State: AOJu0YyogQhj4QYjhYpGbdUF9futIwhobj8rbBFarjRIRNyMqdXVmVUG
 HCXRhN2OFLKdLl3WGHXp4CRH/GMTm/xUaumYFtuczZ3nsUBTltNmkByIJB39FF8a+tA6qwF8h8G
 Lfml4VUfQLI/gEhu+QyGw70XoQB7FvpWI8aQw/dYaMv8DxSh7Idhl
X-Received: by 2002:a05:620a:1993:b0:7b1:12df:2589 with SMTP id
 af79cd13be357-7b42eda94d9mr412972985a.7.1732119053101; 
 Wed, 20 Nov 2024 08:10:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ15fw0dwscVD95A84qKm/wlvuBIkbAaLVy20vG+utP6QKkCa8T/WUu8baZ0nUuerpqhkooQ==
X-Received: by 2002:a05:620a:1993:b0:7b1:12df:2589 with SMTP id
 af79cd13be357-7b42eda94d9mr412969885a.7.1732119052787; 
 Wed, 20 Nov 2024 08:10:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b479d90edfsm111825685a.61.2024.11.20.08.10.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 08:10:52 -0800 (PST)
Message-ID: <41a67d4e-f7b8-4586-8d52-c32df400b675@redhat.com>
Date: Wed, 20 Nov 2024 17:10:48 +0100
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
 <aafc5fba-8d68-4796-a846-265362e7acac@redhat.com>
 <30ff8ac9ee9b4012aa6962c86ac06375@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <30ff8ac9ee9b4012aa6962c86ac06375@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/20/24 15:16, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Monday, November 18, 2024 6:10 PM
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
> [...]
>
>>> I think the above won't affect the basic case where I have only one
>>> pcie-pxb/SMMUv3. But even in that case hot add seems not working.
>>>
>>> I tried hacking the min/max ranges as suspected by Nicolin. But still not
>> enough to
>>> get it working.  Do you have any hint on why the hot add(described
>> below) is not
>>> working?
>> Hum thought the duplicate idmap could be the cause. Otherwise I have no
>> clue. I would advice to fix it first.
> I think I have an idea why the hot add was not working. 
>
> When we have the PCIe topology as something like below,
>
> -device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \
> -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1 \
> -device pcie-root-port,id=pcie.port2,bus=pcie.1,chassis=2 \
> -device arm-smmuv3-nested,id=smmuv1,pci-bus=pcie.1 \
> ...
>
> The current IORT generation includes the pcie-root-port dev ids also
> in the SMMUv3 node idmaps.
>
> Hence, when Guest kernel loads, pcieport is also behind the SMMUv3.
>
> [    1.466670] pcieport 0000:64:00.0: Adding to iommu group 1
> ...
> [    1.448205] pcieport 0000:64:01.0: Adding to iommu group 2

But it should be the same without multi-instantiation, no? I would have
expected this as normal. Has you tested hot-plug without the series
laterly? Do you have the same pb?

Thanks

Eric
>
>
> So when we do a  hot add,
> device_add vfio-pci,host=0000:75:00.1,bus=pcie.port1,iommufd=iommufd0
>
> The Qemu hotplug event handler tries to inject an IRQ to the Guest pcieport
> by retrieving the MSI address it is configured with. 
>
> hotplug_event_notify()
>     msix_prepare_message(): [address: 0xfffff040]
>          msix_notify()
>
> The ITS address retrieved here is actually the SMMUv3 translated iova addr,
> not the Guest PA.  So Guest never sees/receives the interrupt.
>
> I did hack the IORT code to exclude the pcie-root-port dev ids from the SMMUv3
> node idmaps and the hot add seems to work fine.
>
> Looks like we need to find all the pcie-root-port dev ids associated with a
> SMMUv3/pxb-pcie and exclude them from SMMUv3 node idmaps to get
> the hot add working.
>
> I am not sure though this will  create any other issues in IOMMU isolation criteria
> (ACS etc,), especially if we want to access the device in Guest user space( I hope
> not).
>
> Thanks,
> Shameer
>
>
>
>


