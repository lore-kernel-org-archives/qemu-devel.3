Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09F4C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwTB-000719-EY; Wed, 19 Mar 2025 12:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuwSs-0006tO-BH
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:40:26 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuwSp-00008x-PH
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:40:21 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so6319290f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742402417; x=1743007217; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fYn/0fdtTXI9SqR7hX3gE2Gqn6bttubotL9rPYKvl6g=;
 b=by37fB+IBzSNA8+gyot0Bo1uPhfDYt6MyWxkiIuXVQLGbYPKOQoXGHFMU6B7oTvr8R
 Xpw8C+MqHqiiqMMrB8eEZmUbEaGG8WgdxUcAvQOFDoF+pRNwI0WgISgMslXRmWeM3ymF
 eqMp6g7r5JSIVIIbnbcRXCVbnJ+Qj7VSuhVLSYxmPQB1xUzKPSED/UcHcuPA+f9xYRoU
 Xvp1+7oq788YjdkvX8R9frSzwh9GYQhY4rU56UF4puNm4Gu3ChrjRtUEVQfigcDv3+rN
 dPY89HTskyJyrW0O9ok1WWrrM93MdZx0yk8M1nX2e7eppn5JCjhESA1glVNhRkcVpq9o
 r0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742402417; x=1743007217;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fYn/0fdtTXI9SqR7hX3gE2Gqn6bttubotL9rPYKvl6g=;
 b=QtjXRUmFTWlAamJAFrv3qZnEha72rS3esumAWW2edn68AegiU9NC9IYZH7d1lnistv
 RrBOW6EYGFANHXYQnv6IfTX6nMLGb2AUxSIbCWqJn3WazNlRKMkxwn6ITBNUXyOl0PRs
 mzMeyq21P9tGU7JpP2V9sYXA+d6uJP/5RPMeMEtJxtHF7iYcaPivbNXXdZMbh1oG33n9
 L08FGw95KPzpbQQYeRuHkF78ko3TescokE9D6K3YTUiYb6JpJtnwU1ZQ29t6mZUhaJ89
 hV/LJa+uSRRwBEV2NpjvWjFS5yxa+EAyymYb203nTTRrLHQHvNVv8enLmiwSIsJ57hr9
 veDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWupW155FdJ5r4LHjDEIlPBko/NQMMjW24Xk2CRxnk7QLg4pUp785H3q4S9hHtxRkZIyqisbFlL82lW@nongnu.org
X-Gm-Message-State: AOJu0YwWFVXOOqJ4Y3Q5NBiMz/33AUOdbb/BQOF7Zz1PLK5lTQlIr+eV
 5UbepYlO/S0kNzoiv1twwbhKKjSGw5y9cdnlJD1TzMNENXIfROQiPsvFgb3sqJ4=
X-Gm-Gg: ASbGncuZ09CXop6esRnkctB/eOj/3xbFYwS43CRidQXXX3oV4xqdlmyMLstV1G/B7cP
 FrAahniyT7T3FaXx/4zrvLFS3cT9XdKfdi+MzXfNvhjyZd7c4EiYbyj5xxTucioSc+J1Rl6QE/Z
 mT4UsEDCrVwx7hP2L+OL0/j3+QB6nzpDwxj0h6S2VweeP5aclX3w5y8EUDkOZOPVAXWY8bIP0lc
 TeEEUqDg/gkuaerrGY2rUltrlCoB3NLq0KqS2KUnYix4OUnajKbRcGf8xQgD2fH05Mc++K8shYq
 N3iY1wkx1XHP2m9NqKpLJwjIrhJKp+9qgr776LNHZPa15RYwQe65Gx+qH/Zw54YVhMLSsR3yXHe
 4GgGKsht4CCdH
X-Google-Smtp-Source: AGHT+IGmO0RghhnElo92dsuq6kbWzJ2p1Cs9Ico7fv+LEiwTTgkPlgH7xjlI1AbRhp+SNYQy3pvGwA==
X-Received: by 2002:a5d:5f94:0:b0:391:1218:d5f7 with SMTP id
 ffacd0b85a97d-399795d8d10mr149750f8f.40.1742402416439; 
 Wed, 19 Mar 2025 09:40:16 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c83b6a27sm21672384f8f.31.2025.03.19.09.40.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:40:15 -0700 (PDT)
Message-ID: <451b6569-49ee-4f5a-96d7-f3128c5527c2@linaro.org>
Date: Wed, 19 Mar 2025 17:40:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/20] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, ddutile@redhat.com, berrange@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 linuxarm@huawei.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

On 11/3/25 15:10, Shameer Kolothum via wrote:
> Hi All,
> 
> This patch series introduces initial support for a user-creatable
> accelerated SMMUv3 device (-device arm-smmuv3-accel) in QEMU.

I'm a bit confused by the design here. Why are we introducing this as
some device while it is a core component of the bus topology (here PCI)?

Is is because this device is inspired on how x86 IOMMUs are wired?

> Why this is needed:
> 
> Currently, QEMU’s ARM SMMUv3 emulation (iommu=smmuv3) is tied to the
> machine and does not support configuring the host SMMUv3 in nested
> mode.This limitation prevents its use with vfio-pci passthrough
> devices.
> 
> The new pluggable smmuv3-accel device enables host SMMUv3 configuration
> with nested stage support (Stage 1 owned by the Guest and Stage 2 by the
> host) via the new IOMMUFD APIs. Additionally, it allows multiple
> accelerated vSMMUv3 instances for guests running on hosts with multiple
> physical SMMUv3s.
> 
> This will benefit in:
> -Reduced invalidation broadcasts and lookups for devices behind multiple
>   physical SMMUv3s.
> -Simplifies handling of host SMMUv3s with differing feature sets.
> -Lays the groundwork for additional capabilities like vCMDQ support.
> 
> 
> Changes from RFCv1[0]:
> 
> Thanks to everyone who provided feedback on RFCv1!.
> 
> –The device is now called arm-smmuv3-accel instead of arm-smmuv3-nested
>   to better reflect its role in using the host's physical SMMUv3 for page
>   table setup and cache invalidations.
> -Includes patches for VIOMMU and VDEVICE IOMMUFD APIs (patches 1,2).
> -Merges patches from Nicolin’s GitHub repository that add accelerated
>   functionalityi for page table setup and cache invalidations[1]. I have
>   modified these a bit, but hopefully has not broken anything.
> -Incorporates various fixes and improvements based on RFCv1 feedback.
> –Adds support for vfio-pci hotplug with smmuv3-accel.
> 
> Note: IORT RMR patches for MSI setup are currently excluded as we may
> adopt a different approach for MSI handling in the future [2].
> 
> Also this has dependency on the common iommufd/vfio patches from
> Zhenzhong's series here[3]
> 
> ToDos:
> 
> –At least one vfio-pci device must currently be cold-plugged to a
>   pxb-pcie bus associated with the arm-smmuv3-accel. This is required both
>   to associate a vSMMUv3 with a host SMMUv3 and also needed to
>   retrieve the host SMMUv3 IDR registers for guest export.
>   Future updates will remove this restriction by adding the
>   necessary kernel support.
>   Please find the discussion here[4]
> -This version does not yet support host SMMUv3 fault handling or
>   other event notifications. These will be addressed in a
>   future patch series.
> 
> 
> The complete branch can be found here:
> https://github.com/hisilicon/qemu/tree/master-smmuv3-accel-rfcv2-ext
> 
> I have done basic sanity testing on a Hisilicon Platform using the kernel
> branch here:
> https://github.com/nicolinc/iommufd/tree/iommufd_msi-rfcv2
> 
> Usage Eg:
> 
> On a HiSilicon platform that has multiple host SMMUv3s, the ACC ZIP VF
> devices and HNS VF devices are behind different host SMMUv3s. So for a
> Guest, specify two arm-smmuv3-accel devices each behind a pxb-pcie as below,
> 
> 
> ./qemu-system-aarch64 -machine virt,accel=kvm,gic-version=3 \
> -cpu host -smp cpus=4 -m size=4G,slots=4,maxmem=256G \
> -bios QEMU_EFI.fd \
> -object iommufd,id=iommufd0 \
> -device virtio-blk-device,drive=fs \
> -drive if=none,file=rootfs.qcow2,id=fs \
> -device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0 \
> -device arm-smmuv3-accel,bus=pcie.1 \
> -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,pref64-reserve=2M,io-reserve=1K \
> -device vfio-pci,host=0000:7d:02.1,bus=pcie.port1,iommufd=iommufd0 \
> -device pcie-root-port,id=pcie.port2,bus=pcie.1,chassis=2,pref64-reserve=2M,io-reserve=1K \
> -device vfio-pci,host=0000:7d:02.2,bus=pcie.port2,iommufd=iommufd0 \
> -device pxb-pcie,id=pcie.2,bus_nr=8,bus=pcie.0 \
> -device arm-smmuv3-accel,bus=pcie.2 \
> -device pcie-root-port,id=pcie.port3,bus=pcie.2,chassis=3,pref64-reserve=2M,io-reserve=1K \
> -device vfio-pci,host=0000:75:00.1,bus=pcie.port3,iommufd=iommufd0 \
> -kernel Image \
> -append "rdinit=init console=ttyAMA0 root=/dev/vda2 rw earlycon=pl011,0x9000000" \
> -device virtio-9p-pci,fsdev=p9fs,mount_tag=p9,bus=pcie.0 \
> -fsdev local,id=p9fs,path=p9root,security_model=mapped \
> -net none \
> -nographic
> 
> Guest will boot with two SMMUv3s,
> ...
> arm-smmu-v3 arm-smmu-v3.0.auto: option mask 0x0
> arm-smmu-v3 arm-smmu-v3.0.auto: ias 44-bit, oas 44-bit (features 0x00008325)
> arm-smmu-v3 arm-smmu-v3.0.auto: allocated 65536 entries for cmdq
> arm-smmu-v3 arm-smmu-v3.0.auto: allocated 32768 entries for evtq
> arm-smmu-v3 arm-smmu-v3.1.auto: option mask 0x0
> arm-smmu-v3 arm-smmu-v3.1.auto: ias 44-bit, oas 44-bit (features 0x00008325)
> arm-smmu-v3 arm-smmu-v3.1.auto: allocated 65536 entries for cmdq
> arm-smmu-v3 arm-smmu-v3.1.auto: allocated 32768 entries for evtq
> 
> With a pci topology like below,
> 
> [root@localhost ~]# lspci -tv
> -+-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
>   |           +-01.0  Red Hat, Inc. QEMU PCIe Expander bridge
>   |           +-02.0  Red Hat, Inc. QEMU PCIe Expander bridge
>   |           \-03.0  Virtio: Virtio filesystem
>   +-[0000:01]-+-00.0-[02]----00.0  Huawei Technologies Co., Ltd. HNS Network Controller (Virtual Function)
>   |           \-01.0-[03]----00.0  Huawei Technologies Co., Ltd. HNS Network Controller (Virtual Function)
>   \-[0000:08]---00.0-[09]----00.0  Huawei Technologies Co., Ltd. HiSilicon ZIP Engine(Virtual Function)
> 
> Further tests are always welcome.
> 
> Please take a look and let me know your feedback!
> 
> Thanks,
> Shameer
> 
> [0] https://lore.kernel.org/qemu-devel/20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com/
> [1] https://github.com/nicolinc/qemu/commit/3acbb7f3d114d6bb70f4895aa66a9ec28e6561d6
> [2] https://lore.kernel.org/linux-iommu/cover.1740014950.git.nicolinc@nvidia.com/
> [3] https://lore.kernel.org/qemu-devel/20250219082228.3303163-1-zhenzhong.duan@intel.com/
> [4] https://lore.kernel.org/qemu-devel/Z6TLSdwgajmHVmGH@redhat.com/


