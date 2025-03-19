Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8EEC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 17:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwzS-0003lV-48; Wed, 19 Mar 2025 13:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuwzQ-0003ig-7c
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tuwzM-0003Il-AW
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742404434;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8dzJ1lLiZ4vNOYYQKoBmFyqaGFYpyhp4CrrvgLlvMEA=;
 b=LxywMJv+nLmcb7YG+Fm2aIWL2iVrbY3tYjl41SK0dFGfArTODggyE1QtoAhza+qYp5GGOT
 iZLbQ5j+xrF4iAF33RK3fFHU3PJJpqM8UAUaTISGXHH3yS9qePc4E2KZsgylwXVkv5EUdY
 I1f2i4ZNtoPBvAZm0ahK4P4kIc+BgHI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-k3qaWZ0YPziiqLkW3Phetg-1; Wed, 19 Mar 2025 13:13:53 -0400
X-MC-Unique: k3qaWZ0YPziiqLkW3Phetg-1
X-Mimecast-MFC-AGG-ID: k3qaWZ0YPziiqLkW3Phetg_1742404432
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d22c304adso4562745e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 10:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742404432; x=1743009232;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8dzJ1lLiZ4vNOYYQKoBmFyqaGFYpyhp4CrrvgLlvMEA=;
 b=Rnr4X8VhvtPoFL12KX7AtzTQ56B3eylNTBYk5j/YFjSzZUTQ8nr1Lw/3fBjSi/kaSI
 YlQsI7cus48yKO0FkixpRJKs+J69MEHoSyJW+u0gWaeo0ylkGbToUsq3BcWUuS3pTeAF
 80vanc7J4wDb6/sRmpd/zoTBwj54fsSHraCsT0S58EZK6opJyQZWXtALw6xCD0CwUBll
 /83UQrJqf/KgPGkHXanMxyT6rkZBgm+8OH0wC8R89kWEjaOAUhXlV0b9oBF/qYwLeL3c
 1fGav2p4jBNKy8uWOTXD3NytB4Cmzy3tKUV24HD4fUqc89tUuY+i0Fle41wXroWSiZ1Q
 Pz7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjwDmMYjT6gS9PsFBiz9nUXAa8qerJFAXIdLNiItcOeIN3sbU4XIQ2RaVCBqyHpzko2wHj1orf+dXf@nongnu.org
X-Gm-Message-State: AOJu0Yxdw8RD3AuKKuqTkoKDtUJEG8deeDA4PcEOnSlwcytDcuuHIsOP
 msOKqdDDDf4rUcD6RpYDc4Q3FisYtLQOePRSXRsQmxUax1FMdNmYnpf3nTK2QvDjC1q0njzCYMp
 2umBATyTnmxJIwGfaI4wkzVs2/7Mq6DM5DEhC0Bj6e3CMGo+Z8FMy
X-Gm-Gg: ASbGncsX9/hlJ+eJwrXQ5x+p9JpGv+CdTP90SAbZtrulwo2cvu/gYBiCixRk6beawzf
 yCjlESD2Vpu2z2nlKtdWEVuKdGGtZib5A5KsP6qZwXv5KkjBlLmmGGE2lSqPJHVYspUHC2E5w6f
 BQ6Xg2RA6/gzxcF1t6ueQWHGZVV3X2zgEOqyevuVRZwWPWGxqpA5lwhdHWNbitkU31OpP6f3mlw
 s36DZWY7RsUFXXDm9c5yiSJh8bXdAhbtEf8Oltg2oIteNEN2C7H+Z1ZpEKtnSNeSnuc8MrXhj5g
 l4E0Bv1WdZFktnV8wRBqnOk4yPwrq8hjU8mOOAXjnnajkKD/htzx3MUP9oSA2h4=
X-Received: by 2002:a5d:5f4c:0:b0:391:b93:c971 with SMTP id
 ffacd0b85a97d-39979586d6fmr337837f8f.20.1742404431882; 
 Wed, 19 Mar 2025 10:13:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPQ2K1Ji/GC79IjY0khjl9kAv6cj15Jqit6/nkLZ5w37n9s2Pw4grRuyELX/FF8pXiUMSTVw==
X-Received: by 2002:a5d:5f4c:0:b0:391:b93:c971 with SMTP id
 ffacd0b85a97d-39979586d6fmr337778f8f.20.1742404431297; 
 Wed, 19 Mar 2025 10:13:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb40cdd0sm21576430f8f.77.2025.03.19.10.13.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 10:13:50 -0700 (PDT)
Message-ID: <6b5369c1-fd1c-4282-9e9b-1b9041f04167@redhat.com>
Date: Wed, 19 Mar 2025 18:13:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/20] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <451b6569-49ee-4f5a-96d7-f3128c5527c2@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <451b6569-49ee-4f5a-96d7-f3128c5527c2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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


Hi Philippe,

On 3/19/25 5:40 PM, Philippe Mathieu-Daudé wrote:
> Hi,
>
> On 11/3/25 15:10, Shameer Kolothum via wrote:
>> Hi All,
>>
>> This patch series introduces initial support for a user-creatable
>> accelerated SMMUv3 device (-device arm-smmuv3-accel) in QEMU.
>
> I'm a bit confused by the design here. Why are we introducing this as
> some device while it is a core component of the bus topology (here PCI)?

At the moment the SMMU machine wide and is optin-in with a machine option.

However there is a need to be able to instantiate multiple of them to
match the physical implementation. and there is a need to define what
bus topology each instance is translating, hence the idea to attach it
to a bus.

At ACPI level the IORT table allows to precisely define which RID is
translated by each SMMU instance and this is something we fail to model
with the machine wide option.

Eric
>
> Is is because this device is inspired on how x86 IOMMUs are wired?
>
>> Why this is needed:
>>
>> Currently, QEMU’s ARM SMMUv3 emulation (iommu=smmuv3) is tied to the
>> machine and does not support configuring the host SMMUv3 in nested
>> mode.This limitation prevents its use with vfio-pci passthrough
>> devices.
>>
>> The new pluggable smmuv3-accel device enables host SMMUv3 configuration
>> with nested stage support (Stage 1 owned by the Guest and Stage 2 by the
>> host) via the new IOMMUFD APIs. Additionally, it allows multiple
>> accelerated vSMMUv3 instances for guests running on hosts with multiple
>> physical SMMUv3s.
>>
>> This will benefit in:
>> -Reduced invalidation broadcasts and lookups for devices behind multiple
>>   physical SMMUv3s.
>> -Simplifies handling of host SMMUv3s with differing feature sets.
>> -Lays the groundwork for additional capabilities like vCMDQ support.
>>
>>
>> Changes from RFCv1[0]:
>>
>> Thanks to everyone who provided feedback on RFCv1!.
>>
>> –The device is now called arm-smmuv3-accel instead of arm-smmuv3-nested
>>   to better reflect its role in using the host's physical SMMUv3 for
>> page
>>   table setup and cache invalidations.
>> -Includes patches for VIOMMU and VDEVICE IOMMUFD APIs (patches 1,2).
>> -Merges patches from Nicolin’s GitHub repository that add accelerated
>>   functionalityi for page table setup and cache invalidations[1]. I have
>>   modified these a bit, but hopefully has not broken anything.
>> -Incorporates various fixes and improvements based on RFCv1 feedback.
>> –Adds support for vfio-pci hotplug with smmuv3-accel.
>>
>> Note: IORT RMR patches for MSI setup are currently excluded as we may
>> adopt a different approach for MSI handling in the future [2].
>>
>> Also this has dependency on the common iommufd/vfio patches from
>> Zhenzhong's series here[3]
>>
>> ToDos:
>>
>> –At least one vfio-pci device must currently be cold-plugged to a
>>   pxb-pcie bus associated with the arm-smmuv3-accel. This is required
>> both
>>   to associate a vSMMUv3 with a host SMMUv3 and also needed to
>>   retrieve the host SMMUv3 IDR registers for guest export.
>>   Future updates will remove this restriction by adding the
>>   necessary kernel support.
>>   Please find the discussion here[4]
>> -This version does not yet support host SMMUv3 fault handling or
>>   other event notifications. These will be addressed in a
>>   future patch series.
>>
>>
>> The complete branch can be found here:
>> https://github.com/hisilicon/qemu/tree/master-smmuv3-accel-rfcv2-ext
>>
>> I have done basic sanity testing on a Hisilicon Platform using the
>> kernel
>> branch here:
>> https://github.com/nicolinc/iommufd/tree/iommufd_msi-rfcv2
>>
>> Usage Eg:
>>
>> On a HiSilicon platform that has multiple host SMMUv3s, the ACC ZIP VF
>> devices and HNS VF devices are behind different host SMMUv3s. So for a
>> Guest, specify two arm-smmuv3-accel devices each behind a pxb-pcie as
>> below,
>>
>>
>> ./qemu-system-aarch64 -machine virt,accel=kvm,gic-version=3 \
>> -cpu host -smp cpus=4 -m size=4G,slots=4,maxmem=256G \
>> -bios QEMU_EFI.fd \
>> -object iommufd,id=iommufd0 \
>> -device virtio-blk-device,drive=fs \
>> -drive if=none,file=rootfs.qcow2,id=fs \
>> -device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0 \
>> -device arm-smmuv3-accel,bus=pcie.1 \
>> -device
>> pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,pref64-reserve=2M,io-reserve=1K
>> \
>> -device vfio-pci,host=0000:7d:02.1,bus=pcie.port1,iommufd=iommufd0 \
>> -device
>> pcie-root-port,id=pcie.port2,bus=pcie.1,chassis=2,pref64-reserve=2M,io-reserve=1K
>> \
>> -device vfio-pci,host=0000:7d:02.2,bus=pcie.port2,iommufd=iommufd0 \
>> -device pxb-pcie,id=pcie.2,bus_nr=8,bus=pcie.0 \
>> -device arm-smmuv3-accel,bus=pcie.2 \
>> -device
>> pcie-root-port,id=pcie.port3,bus=pcie.2,chassis=3,pref64-reserve=2M,io-reserve=1K
>> \
>> -device vfio-pci,host=0000:75:00.1,bus=pcie.port3,iommufd=iommufd0 \
>> -kernel Image \
>> -append "rdinit=init console=ttyAMA0 root=/dev/vda2 rw
>> earlycon=pl011,0x9000000" \
>> -device virtio-9p-pci,fsdev=p9fs,mount_tag=p9,bus=pcie.0 \
>> -fsdev local,id=p9fs,path=p9root,security_model=mapped \
>> -net none \
>> -nographic
>>
>> Guest will boot with two SMMUv3s,
>> ...
>> arm-smmu-v3 arm-smmu-v3.0.auto: option mask 0x0
>> arm-smmu-v3 arm-smmu-v3.0.auto: ias 44-bit, oas 44-bit (features
>> 0x00008325)
>> arm-smmu-v3 arm-smmu-v3.0.auto: allocated 65536 entries for cmdq
>> arm-smmu-v3 arm-smmu-v3.0.auto: allocated 32768 entries for evtq
>> arm-smmu-v3 arm-smmu-v3.1.auto: option mask 0x0
>> arm-smmu-v3 arm-smmu-v3.1.auto: ias 44-bit, oas 44-bit (features
>> 0x00008325)
>> arm-smmu-v3 arm-smmu-v3.1.auto: allocated 65536 entries for cmdq
>> arm-smmu-v3 arm-smmu-v3.1.auto: allocated 32768 entries for evtq
>>
>> With a pci topology like below,
>>
>> [root@localhost ~]# lspci -tv
>> -+-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
>>   |           +-01.0  Red Hat, Inc. QEMU PCIe Expander bridge
>>   |           +-02.0  Red Hat, Inc. QEMU PCIe Expander bridge
>>   |           \-03.0  Virtio: Virtio filesystem
>>   +-[0000:01]-+-00.0-[02]----00.0  Huawei Technologies Co., Ltd. HNS
>> Network Controller (Virtual Function)
>>   |           \-01.0-[03]----00.0  Huawei Technologies Co., Ltd. HNS
>> Network Controller (Virtual Function)
>>   \-[0000:08]---00.0-[09]----00.0  Huawei Technologies Co., Ltd.
>> HiSilicon ZIP Engine(Virtual Function)
>>
>> Further tests are always welcome.
>>
>> Please take a look and let me know your feedback!
>>
>> Thanks,
>> Shameer
>>
>> [0]
>> https://lore.kernel.org/qemu-devel/20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com/
>> [1]
>> https://github.com/nicolinc/qemu/commit/3acbb7f3d114d6bb70f4895aa66a9ec28e6561d6
>> [2]
>> https://lore.kernel.org/linux-iommu/cover.1740014950.git.nicolinc@nvidia.com/
>> [3]
>> https://lore.kernel.org/qemu-devel/20250219082228.3303163-1-zhenzhong.duan@intel.com/
>> [4] https://lore.kernel.org/qemu-devel/Z6TLSdwgajmHVmGH@redhat.com/
>


