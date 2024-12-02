Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D536DE69E85
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 18:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIBYO-0007RO-Nh; Mon, 02 Dec 2024 13:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tIBYA-0007JX-Sw
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 13:53:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tIBY7-0000Dm-5Q
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 13:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733165613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T2d3o4zFKpl8XI9/C48C2l91IQs53Z7HqX95j3jXgBg=;
 b=C3JFI+xVqRfcYjuWSVKqM+qk2vi0H5dkCpRYdri7hy08tycDHcXLdEJxnoV5hGBeRkJ4LG
 sX3p26+I57ZtH07lEzAJFP/2m8gS07DX4skjR4Rh9eRSb7jSw13ajrVzuKAA3JuDGAkjQW
 JAuQjlcvIwALvNovjiN6jkrdJnDBfAs=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-sNIqqYT3PtWQJZHME3w5SQ-1; Mon, 02 Dec 2024 13:53:30 -0500
X-MC-Unique: sNIqqYT3PtWQJZHME3w5SQ-1
X-Mimecast-MFC-AGG-ID: sNIqqYT3PtWQJZHME3w5SQ
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-84386a9b7e2so769175139f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 10:53:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733165609; x=1733770409;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T2d3o4zFKpl8XI9/C48C2l91IQs53Z7HqX95j3jXgBg=;
 b=iGaZ3MgmIpdRQfya4imEuPCRULA39BdsMqWZc6yY35pw6iaYzFZOpz4UnHT2Ru1Dp/
 6Hlzv9riNG3tx2ZFFMnZK+yor1Z/HpvFAbo20NQ6PqFNfkITJsv3DlBOa8LagjW1k5xV
 FP7KwgCRlRGXL4vvcbtJmojhEFgwHmMIRqDd+CyecMx08SDgK4wWd1MvjLRHAA8ZxLUj
 Luv1NdkNCKk3Rl9rBQg4ZMg3zAi8+tkRbQ0v1kXTMvsFfQi99+V08kLvU0XDDmn5Ka4g
 tqom8DAcJ3hk3FGAl0SKFG/nxQPIhKlcVNBVAq6Rc5KxgnFQ33G7UeG7vDyyoQSwI8Px
 UyTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB4IQmwQeZ9abwTZ69N9HJD4s/+Qz+fZPu+oibYCxilK2bOYMeQTLbQSPMj/Y6smzUKcNikqOBQiy6@nongnu.org
X-Gm-Message-State: AOJu0Yxa4I82zrLmx5zZKddFnkWBrR+vec5pPEA3VuqIkd1i/tHfraNY
 elin4RZiuWFxNtB1PPdXt/daknYD2JV211OCyNl+YDRP9GvnWxD7LAIrq/p7So8lZTPZgnrk/k3
 nWbTkCL/YOpvoLjCOSJHAfqUZvs0ZoYSAlfsWmiw7qyKwY/LVsvyY
X-Gm-Gg: ASbGncvRh5Dyn7z54rZnvKaoFY1gPTuAjbSURqBVQ2tXSJawhAWIOsa/NagUU37CjDn
 Rc0VCEpgsYxkmEtxMUXn6rkjJhBwMyZ37LujLJe+0aFsL8xEKoZP8QOfpdcWT9r8PSakN29smvi
 NVgkyZ7CwFCbEBG7WiZdOUox6YQiKGL2ft4eh9bKza+91leiEmdTSqV16SFxGg3UBBWCHT08fn/
 K+rXYefVjR+IfVM8L9JPC3Ri/S7phHYj+SEcaz9Dvs9Lmfyxec=
X-Received: by 2002:a05:6e02:190b:b0:3a7:dd62:e954 with SMTP id
 e9e14a558f8ab-3a7dd62ec53mr147976405ab.0.1733165609658; 
 Mon, 02 Dec 2024 10:53:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWoaJ0D4p/8rka2bDpgvI2L8f1Bv4ZACtB325qHjDfU9P6meLP9MbPMYwfAWDqHjSWKAn3ow==
X-Received: by 2002:a05:6e02:190b:b0:3a7:dd62:e954 with SMTP id
 e9e14a558f8ab-3a7dd62ec53mr147976095ab.0.1733165609356; 
 Mon, 02 Dec 2024 10:53:29 -0800 (PST)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7ccc5fc09sm22971325ab.61.2024.12.02.10.53.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 10:53:28 -0800 (PST)
Message-ID: <7d8fd88b-2b2a-4b1e-9feb-8030fc2111a4@redhat.com>
Date: Mon, 2 Dec 2024 13:53:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Eric Auger <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
 <00e8a5d6-c926-44bb-8d11-dab4ddc4820d@redhat.com>
 <ZzTqXCFKV9s++C2N@Asurada-Nvidia>
 <cfe8864c-f830-4b39-b4d5-f219f5a42eea@redhat.com>
 <d8fbaa677771425dac985438b4b1db59@huawei.com>
 <04c73d87-35ce-4e11-a906-17c1e2961387@redhat.com>
 <Z0f1P/Tie2Yhe1dv@Asurada-Nvidia> <20241128125426.GD1253388@nvidia.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20241128125426.GD1253388@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 11/28/24 7:54 AM, Jason Gunthorpe wrote:
> On Wed, Nov 27, 2024 at 08:44:47PM -0800, Nicolin Chen wrote:
>> On Wed, Nov 27, 2024 at 11:29:06PM -0500, Donald Dutile wrote:
>>> On 11/27/24 5:21 AM, Shameerali Kolothum Thodi wrote:
>>>>>> W.r.t naming, maybe something related to "hardware-accelerated"?
>>>>>>
>>>>> Given that 'accel' has been used for hw-acceleration elsewhere, that seems
>>>>> like a reasonable 'mode'.
>>>>> But, it needs a paramater to state was is being accelerated.
>>>>> i.e., the more global 'accel=kvm' has 'kvm'.
>>>>
>>>> I was thinking more like calling this hw accelerated nested SMMUv3 emulation
>>>> as 'smmuv3-accel'.  This avoids confusion with the already existing
>>>> 'iommu=smmuv3' that also has a nested emulation support.
>>>>
>>>> ie,
>>>> -device arm-smmuv3-accel,id=smmuv1,bus=pcie.1 \
>>>>
>> ..
>>> I -think- you are saying below, that we have to think a bit more about this
>>> device tagging.  I'm thinking more like
>>>   - device arm-smmuv3,accel=<vcmdq>,id=smmu1,bus=pcie.1 \
>>
>> I wonder if we really need a "vcmdq" enabling/disabling option?
>>
>> Jason's suggested approach for a vIOMMU allocation is to retry-
>> on-failure, so my draft patches allocate a TEGRA241_CMDQV type
>> of vIOMMU first, and then fall back to a regular SMMUV3 type if
>> it fails. So, a host that doesn't have a VCMDQ capability could
>> still work with the fallback/default pathway.
> 
> It needs to be configurable so the VM can be configured in a
> consistent way across nodes
> 
Yes.
To expound further, one wants to be able to define an 'acceptable'
VM criteria, so libvirt (or OpenStack?) can find and generate the list
of 'acceptable nodes', priori typically, that can be a match for the
acceptance criteria.
Conversely, if one specifies a set of systems that one wants to be able
to migrate across, then libvirt needs to find and select/set the features|attributes
that enable the VM to migrate in a compatible way.

> autodetection of host features is nice for experimenting but scale
> deployments should precisely specify every detail about the VM and not
> rely on host detection. Otherwise the VM instance type will be ill
> defined..
> 
> Jason
> 


