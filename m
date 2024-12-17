Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE03E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 18:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNcQl-0006rX-4R; Tue, 17 Dec 2024 13:36:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tNcQk-0006rD-1t
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 13:36:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tNcQg-0004sg-5j
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 13:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734460578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VhNRHwQJN+qr5GRuAJxkLst4QTuVIPazKslo8UWX+m4=;
 b=NOtVnDEUvKRYryaWQDIUkzQjTWwuSsBZh4cBBcVDWpV6jpqHoG8+okDe60bUeDpnqoEQKy
 xj9L7AWvsoKRNDCuRNvTc44W4Ti6u2GiRhhdDCwn0PNjFmGa4ItvJPwclgwCpQBRahKtvw
 Hzz4yofBYBbHQof0nk7/N+7r1v/fdfE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-CEL4lziqMfa5pB_7ZNPfqw-1; Tue, 17 Dec 2024 13:36:17 -0500
X-MC-Unique: CEL4lziqMfa5pB_7ZNPfqw-1
X-Mimecast-MFC-AGG-ID: CEL4lziqMfa5pB_7ZNPfqw
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d8edc021f9so97054706d6.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 10:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734460577; x=1735065377;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VhNRHwQJN+qr5GRuAJxkLst4QTuVIPazKslo8UWX+m4=;
 b=tqTVYwj7G8vs/1SK6h2tu7VPR4FeAetRcN9bfXBuAAf+qBRK+VkTt0OQAo5xwBCXKR
 4/hWD1LOWcxUJYi+lHIGF3henj/IC7NgdgJWlNT+b2p1jj1SaJ3pDTvatAVPsXMncoqC
 VyHUxgR+LZVu5ugOWgfCr1pUxCyi+qKEQYq54a+d5auuX1FCEqK/maXNp/lES8PP65XP
 BLF5tI9DlUiIKd0yD42K5ILL2wb4b4Pnl+LssnRFmS/5LjUhwVAb8zurTeq72aOht79z
 ZgaKJNZKOcRb2JiWLy8+YoN2bopjJEl4ALdmIjyP+BYmyui8T/Q9tvP6u8cpfNBgJrrp
 nohA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbPsZmomIIiQDUIpqHri0leAsYQH6bT61sN1Pnk+thxXKVHWSOo800p+HDMDinxm7aCedkkdgV3EWp@nongnu.org
X-Gm-Message-State: AOJu0Yz6lB2Dgbk8wATRxHV3lFFlWQ6KeUKJoUGAgxQ9Z2JDaJJ73Ekb
 1e++if8OybiaD0Ictcz4X5WIgKPBqf3HBLxE+4jND9Ftggb+MGQ3SEEwgvSn2IZ9mvjHR5ex++D
 v7RNpXKzUcb8S3WuJHmP0k+NmRnCgjpeGF6GlX2RjMEYL6DSWjj+r
X-Gm-Gg: ASbGncsjVcITsYG3eJo4X+TcJqxYAsykbZBO6enlARZXm4HX0kBnLEyMaYK5WollT1Q
 gnVodQtXtQeCLUqROmd9X7h2rKugFchEYEu2HbjmEGuBgAyVCYJyHQNiJrWSb/WQhc18spJPblB
 yFVhr5W9xmUb6i0x3pt+6e77Fqy1W7hajmCNqjGpjCJYMwkWNcmuGznn/CzZ2ULwRCIWweq2ox7
 e52ua8oDigIBMd81qN33DN6FbA5tSWcYLCqWbgj4OtWGhrlZKJ1dEc4gw==
X-Received: by 2002:a05:6214:501a:b0:6d8:b292:1e17 with SMTP id
 6a1803df08f44-6dd091ac0dfmr1226936d6.15.1734460577069; 
 Tue, 17 Dec 2024 10:36:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQCgR/teYysj1/C6LIaIiaiHv7aWhFXCzpHJYOfkLE8BKYl1Ii0A1QQ7JTgLTcAiF1grbSwA==
X-Received: by 2002:a05:6214:501a:b0:6d8:b292:1e17 with SMTP id
 6a1803df08f44-6dd091ac0dfmr1226606d6.15.1734460576753; 
 Tue, 17 Dec 2024 10:36:16 -0800 (PST)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd36312csm41432126d6.82.2024.12.17.10.36.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 10:36:15 -0800 (PST)
Message-ID: <7c7c52c1-9558-4547-95d8-fb2ded592309@redhat.com>
Date: Tue, 17 Dec 2024 13:36:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 peter.maydell@linaro.org, nicolinc@nvidia.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <Z1w0cgrK6Ri6smFM@redhat.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <Z1w0cgrK6Ri6smFM@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 12/13/24 8:19 AM, Daniel P. Berrangé wrote:
> On Fri, Dec 13, 2024 at 08:46:42AM -0400, Jason Gunthorpe wrote:
>> On Fri, Dec 13, 2024 at 12:00:43PM +0000, Daniel P. Berrangé wrote:
>>> On Fri, Nov 08, 2024 at 12:52:37PM +0000, Shameer Kolothum via wrote:
>>>> Hi,
>>>>
>>>> This series adds initial support for a user-creatable "arm-smmuv3-nested"
>>>> device to Qemu. At present the Qemu ARM SMMUv3 emulation is per machine
>>>> and cannot support multiple SMMUv3s.
>>>>
>>>> In order to support vfio-pci dev assignment with vSMMUv3, the physical
>>>> SMMUv3 has to be configured in nested mode. Having a pluggable
>>>> "arm-smmuv3-nested" device enables us to have multiple vSMMUv3 for Guests
>>>> running on a host with multiple physical SMMUv3s. A few benefits of doing
>>>> this are,
>>>
>>> I'm not very familiar with arm, but from this description I'm not
>>> really seeing how "nesting" is involved here. You're only talking
>>> about the host and 1 L1 guest, no L2 guest.
>>
>> nesting is the term the iommu side is using to refer to the 2
>> dimensional paging, ie a guest page table on top of a hypervisor page
>> table.
>>
>> Nothing to do with vm nesting.
> 
> Ok, that naming is destined to cause confusion for many, given the
> commonly understood use of 'nesting' in the context of VMs...
> 
>>   
>>> Also what is the relation between the physical SMMUv3 and the guest
>>> SMMUv3 that's referenced ? Is this in fact some form of host device
>>> passthrough rather than nesting ?
>>
>> It is an acceeleration feature, the iommu HW does more work instead of
>> the software emulating things. Similar to how the 2d paging option in
>> KVM is an acceleration feature.
>>
>> All of the iommu series on vfio are creating paravirtualized iommu
>> models inside the VM. They access various levels of HW acceleration to
>> speed up the paravirtualization.
> 
> ... describing it as a HW accelerated iommu makes it significantly clearer
> to me what this proposal is about. Perhaps the device is better named as
> "arm-smmuv3-accel" ?
> 
I'm having deja-vu! ;-)
Thanks for echo-ing my earlier statements in this patch series about the use of 'nested'.
and the better use of 'accel' in these circumstances.
Even 'accel' on an 'arm-smmuv3' is a bit of a hammer, as there can be multiple accel's features
&/or implementations... I would like to see the 'accel' as a parameter to 'arm-smmuv3', and not
a complete name-space onto itself, so we can do things like 'accel=cmdvq', accel='2-level', ...

and for libvirt's sanity, a way to get those hw features from sysfs for
(possible) migration-compatibility testing.

> 
> With regards,
> Daniel


