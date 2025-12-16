Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09CBD5C0DD
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 08:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVQex-0005sR-KZ; Tue, 16 Dec 2025 03:43:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vVQew-0005rn-Cv
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 03:43:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vVQet-00012O-Sa
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 03:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765874630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=liUtfTTKSqYwIrq0S90I2PkMUUBHMo6jME2+WxhrXAc=;
 b=flsWMhcmacfSjUSZ6Z8+RUxa96mARH/0sswUrn/7iLQ88IkwImBJ7ITrnVkuYOX76bNTJK
 y19xrVPkTvSrhPPbwMSJN4KAouZcJcbupiciz4moajbNPRmP8Xk7PWLVpVisBFsQfskqhf
 3NQq8AZrcoN7trbqFV2YdIgGinVTpOc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-hvg7Ej-BP_GYv7gVqZCJvw-1; Tue, 16 Dec 2025 03:43:48 -0500
X-MC-Unique: hvg7Ej-BP_GYv7gVqZCJvw-1
X-Mimecast-MFC-AGG-ID: hvg7Ej-BP_GYv7gVqZCJvw_1765874627
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fdaba167so979658f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 00:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765874627; x=1766479427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=liUtfTTKSqYwIrq0S90I2PkMUUBHMo6jME2+WxhrXAc=;
 b=lBVzKTAY21sn99YQykayONZLU0Z50Ennx5EqIansPoR8iaONtY6mtPd9qusq1XWkW+
 TIX8XsMjNlgmIAgEHTavEllo7golbHqYLt9hCAIPC6Le+O/WxyBDYUHUjt9SYXhQm3gR
 2sLzYqclnIKbyHlKuBb/ldvDnz+0Q/uiAZftaD8Oh2fbiEZcxnR/TpjicmKWuKBH2aQg
 39Yy5fvn8IZincVkLEaugo54xJlFD8GYkAJ/tOLhtKLr/twYSeHHGZ+fC3oKcjo2xwKh
 ov5TxQYzPQVggV6GqJtIjurfADiTdYuIRa3pukjB/L2jGmvr8acqi1nZv4duzMeUQJQ7
 2eVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765874627; x=1766479427;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=liUtfTTKSqYwIrq0S90I2PkMUUBHMo6jME2+WxhrXAc=;
 b=sjMm57VPIuzPUQFrfkYlG5Mke0+BQAdQ13K9iPSwcEHnQUxkx9k3VRQYQFfuxVsBIk
 CjJD73CgbVNmdeSE0B3NDGj+O0ov7gr6YvuUaSpas8ycODM7bPoO7Br7oT7M8As3Ml6u
 sLStXmBEDEW/F7cXgMD6aHtCCW2xgxcpAD8vgBkoGhszFpTqOrLPWTjwX/drSNCG/n5C
 7avgar9x/Tw6LxPlNWSQjAeXZpfAgrUZAqkfQ9zqnnqVFJaYolB6hMAB122ng0oCG5Ko
 jXUd2RRppDGqvJOht3cabE6WLwKgJKxVCSHY1YGdtGrL3dot5ZDYA65wNZMOkyJD3Boo
 RmcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3dOn44AfMbsxldnLtr3aqZYPf2TQoRorO8aDmPoCNuqdVqxCT2xm3/n/8UzrHfXH2MzYXwMMJWtvR@nongnu.org
X-Gm-Message-State: AOJu0Yzp0eRuTm3ir/ekEqtxbfassbQcGiJFYQXZwhdFS6TYHUYBDjhN
 dYQabHZUlWWQxpQSFOTtMRK6viep9P4FGkekJ28e8jkb3BzQ312V9eBIGLm3+ed49R1e/AUuG0r
 vs5HqR05qL3hePoh82qnHwF6GCb97xJIpzwSj0mre1hyrrB5mg+dydMyw
X-Gm-Gg: AY/fxX5JOB8KLOcifj2gpg0pw7hFMm0Y4GDEQsCKc3jpd9T+09sgyo+foGwM/FjU3lu
 0gRgc3eg1TVDmcgxmG0EXtz4tl1GxVvrPYknacvsiCJgLv5eoxyAQU9/vBMH6Uv2t2YnyJpDb3W
 D9GQsY3KFjQEhNYwJmNn5kXcS9FvapNKM+HYUgYSr3IDFB4rdAp+J+HKie2s7OICB6+J1Qrlz1l
 CI3Je4pbIOpvqtksFJAKeu7gZPPgAfvSoEc/fGe5DpYci8LHPSkEn8oLrOJZv7vgxTaf2O7Cp7l
 fu068qWTmkh1x8KFlJC0oWFzwLdrwbOvDzq6rf0pJTet7CsQsRvI2CRilhJzynf6eHQ7qC4swaw
 RllO0E82NaeTDHiyc4dSQLmJPwSGgzKuFIwCvFY/iVTY8xIY4
X-Received: by 2002:a05:6000:2909:b0:427:854:770 with SMTP id
 ffacd0b85a97d-42fb46eaf10mr13173020f8f.43.1765874627359; 
 Tue, 16 Dec 2025 00:43:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3567Wrqrk3QBbpbM4ar/B8puTiy+wB+tZsNbNyt5k4LPPY15IvioEArHEt4KeyKVqSiNz1w==
X-Received: by 2002:a05:6000:2909:b0:427:854:770 with SMTP id
 ffacd0b85a97d-42fb46eaf10mr13172993f8f.43.1765874626863; 
 Tue, 16 Dec 2025 00:43:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fbbeb5298sm22991079f8f.20.2025.12.16.00.43.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 00:43:46 -0800 (PST)
Message-ID: <0b2f87ff-2c5f-4a1a-b4a6-db640f0bafb0@redhat.com>
Date: Tue, 16 Dec 2025 09:43:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/19] intel_iommu: Enable first stage translation for
 passthrough device
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex@shazbot.org" <alex@shazbot.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20251215065046.86991-1-zhenzhong.duan@intel.com>
 <56e582e7-d14c-46f6-b2cb-4a328315d505@redhat.com>
 <IA3PR11MB913661A98BDF8BE7019277D192AAA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <IA3PR11MB913661A98BDF8BE7019277D192AAA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello Zhenzhong,

On 12/16/25 04:24, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v9 00/19] intel_iommu: Enable first stage translation for
>> passthrough device
>>
>> Hello Zhenzhong
>>
>> On 12/15/25 07:50, Zhenzhong Duan wrote:
>>> Hi,
>>>
>>> Based on Cédric's suggestions[1], The nesting series v8 is split to
>>> "base nesting series" + "ERRATA_772415_SPR17 quirk series", this is the
>>> base nesting series.
>>>
>>> For passthrough device with intel_iommu.x-flts=on, we don't do shadowing
>> of
>>> guest page table but pass first stage page table to host side to construct a
>>> nested HWPT. There was some effort to enable this feature in old days, see
>>> [2] for details.
>>>
>>> The key design is to utilize the dual-stage IOMMU translation (also known as
>>> IOMMU nested translation) capability in host IOMMU. As the below
>> diagram shows,
>>> guest I/O page table pointer in GPA (guest physical address) is passed to
>> host
>>> and be used to perform the first stage address translation. Along with it,
>>> modifications to present mappings in the guest I/O page table should be
>> followed
>>> with an IOTLB invalidation.
>>>
>>>           .-------------.  .---------------------------.
>>>           |   vIOMMU    |  | Guest I/O page table      |
>>>           |             |  '---------------------------'
>>>           .----------------/
>>>           | PASID Entry |--- PASID cache flush --+
>>>           '-------------'                        |
>>>           |             |                        V
>>>           |             |           I/O page table pointer in GPA
>>>           '-------------'
>>>       Guest
>>>       ------| Shadow |---------------------------|--------
>>>             v        v                           v
>>>       Host
>>>           .-------------.  .-----------------------------.
>>>           |   pIOMMU    |  | First stage for GIOVA->GPA  |
>>>           |             |  '-----------------------------'
>>>           .----------------/  |
>>>           | PASID Entry |     V (Nested xlate)
>>>           '----------------\.--------------------------------------------.
>>>           |             |   | Second stage for GPA->HPA, unmanaged
>> domain|
>>>           |             |   '--------------------------------------------'
>>>           '-------------'
>>> <Intel VT-d Nested translation>
>>>
>>> This series reuse VFIO device's default HWPT as nesting parent instead of
>>> creating new one. This way avoids duplicate code of a new memory
>> listener,
>>> all existing feature from VFIO listener can be shared, e.g., ram discard,
>>> dirty tracking, etc. Two limitations are: 1) not supporting VFIO device
>>> under a PCI bridge with emulated device, because emulated device wants
>>> IOMMU AS and VFIO device stick to system AS; 2) not supporting kexec or
>>> reboot from "intel_iommu=on,sm_on" to "intel_iommu=on,sm_off" on
>> platform
>>> with ERRATA_772415_SPR17, because VFIO device's default HWPT is
>> created
>>> with NEST_PARENT flag, kernel inhibit RO mappings when switch to shadow
>>> mode.
>>>
>>> This series is also a prerequisite work for vSVA, i.e. Sharing guest
>>> application address space with passthrough devices.
>>>
>>> There are some interactions between VFIO and vIOMMU
>>> * vIOMMU registers PCIIOMMUOps [set|unset]_iommu_device to PCI
>>>     subsystem. VFIO calls them to register/unregister HostIOMMUDevice
>>>     instance to vIOMMU at vfio device realize stage.
>>> * vIOMMU registers PCIIOMMUOps get_viommu_flags to PCI subsystem.
>>>     VFIO calls it to get vIOMMU exposed flags.
>>> * vIOMMU calls HostIOMMUDeviceIOMMUFD interface [at|de]tach_hwpt
>>>     to bind/unbind device to IOMMUFD backed domains, either nested
>>>     domain or not.
>>>
>>> See below diagram:
>>>
>>>           VFIO Device                                 Intel
>> IOMMU
>>>       .-----------------.                         .-------------------.
>>>       |                 |                         |
>> |
>>>       |       .---------|PCIIOMMUOps              |.-------------.
>> |
>>>       |       | IOMMUFD |(set/unset_iommu_device) || Host IOMMU
>> |    |
>>>       |       | Device  |------------------------>|| Device list |    |
>>>       |       .---------|(get_viommu_flags)       |.-------------.    |
>>>       |                 |                         |       |
>> |
>>>       |                 |                         |       V
>> |
>>>       |       .---------|  HostIOMMUDeviceIOMMUFD |  .-------------.
>> |
>>>       |       | IOMMUFD |            (attach_hwpt)|  | Host
>> IOMMU  |  |
>>>       |       | link    |<------------------------|  |   Device    |  |
>>>       |       .---------|            (detach_hwpt)|  .-------------.  |
>>>       |                 |                         |       |
>> |
>>>       |                 |                         |       ...
>> |
>>>       .-----------------.                         .-------------------.
>>>
>>> Below is an example to enable first stage translation for passthrough
>> device:
>>>
>>>       -M q35,...
>>>       -device intel-iommu,x-scalable-mode=on,x-flts=on...
>>>       -object iommufd,id=iommufd0 -device
>> vfio-pci,iommufd=iommufd0,...
>>
>> What about libvirt support ? There are patches to enable IOMMUFD
>> support with device assignment but I don't see anything related
>> to first stage translation. Is there a plan ?
> 
> I think IOMMUFD support in libvirt is non-trivial, good to know there is progress.
> But I didn't find a match in libvirt mailing list, https://lists.libvirt.org/archives/search?q=iommufd
> Do you have a link?

Here  :

   https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/KFYUQGMXWV64QPI245H66GKRNAYL7LGB/

There might be an update. We should ask Nathan.

> I think first stage support is trivial, only to support a new property <...x-flts=on/off>.
> I can apply a few time resource from my manager to work on it after this series is merged.
> It's also welcome if anyone is interested to take it.

ok. So, currently, we have no way to benefit from translation
acceleration on the host unless we directly set the 'x-flts'
property on the QEMU command line.

>> This raises a question. Should ftls support be automatically enabled
>> based on the availability of an IOMMUFD backend ?
> 
> Yes, if user doesn't force it off, like <...iommufd='off'> and IOMMUFD backend available, we can enable it automatically.

The plan is to keep VFIO IOMMU Type1 as the default host IOMMU
backend to maintain a consistent behavior. If an IOMMUFD backend
is required, it should be set explicitly. One day we might revisit
this choice and change the default. Not yet.


>>> Test done:
>>> - VFIO devices hotplug/unplug
>>> - different VFIO devices linked to different iommufds
>>> - vhost net device ping test
>>> - migration with QAT passthrough
>>
>> Did you do any experiments with active mlx5 VFs ?
> 
> No, there are only a few device drivers supporting VFIO migration and we only have QAT.
> Let me know if you see issue on other devices.
Since we lack libvirt integration (of flts), the tests need
to be run manually which is more complex for QE. IOW, it will
take more time but we should definitely evaluate other devices.


Thanks,

C.


