Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1599FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 14:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJukg-0006eP-G4; Mon, 04 May 2026 10:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wJukb-0006e8-EN
 for qemu-devel@nongnu.org; Mon, 04 May 2026 10:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wJukZ-0005Qf-Ju
 for qemu-devel@nongnu.org; Mon, 04 May 2026 10:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777906702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=71yVqRbbZQkSWbuB+RkiKwvWO3igM1/EmA0f6JVEUuY=;
 b=h/A9VdFUSTcfzcZYo493mN71La7CVFZHT9ej/SJ3ixxc0rk5u81nIcRqa6+sWMdkGtOIae
 /ndYGx52aGwG/Dl7l/lYlVGlcbaqaV4uqq+3w8EHYdHbcNIylybNkM+z5sdulAfwqC4v6C
 xEoKj45av9CkHVCbpMoNkOQNrbBdE0E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-Vh00VBuPOH2BkxXuB-tHig-1; Mon, 04 May 2026 10:58:20 -0400
X-MC-Unique: Vh00VBuPOH2BkxXuB-tHig-1
X-Mimecast-MFC-AGG-ID: Vh00VBuPOH2BkxXuB-tHig_1777906699
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488d2cd2674so33400065e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777906699; x=1778511499; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=71yVqRbbZQkSWbuB+RkiKwvWO3igM1/EmA0f6JVEUuY=;
 b=fgrgl8td7G0pjSydHmtJXKoCkMbxCka2C3t/Q8ZqtFUzIJL5IfrkW+4DWpbgmLKuRN
 ruzXxsv87VBHXt+U7HA+D5b5/KMgPT99/tzBpcek27uAzeHdhZShKl9aofrWqLkj0Bfy
 13N073wLPtrR0XQpHjAUjK9Bzw9uEJoDwWJdjeMYBmPBv9x9+S545j+TnDaBNwan/X7o
 fRwoRQPK1rA0R8w9MGO+7Y2hQFIEc/KK3PRL//X48VZfipTGjLx8Hw3YkIY17nCj/VwI
 mXq4r6ekOEE3/71gjLxLlZdiXi4VZ72eGIB/hbq5G+Q7Ab81PlVHa915sU+Z4ZlE58hT
 t3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777906699; x=1778511499;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=71yVqRbbZQkSWbuB+RkiKwvWO3igM1/EmA0f6JVEUuY=;
 b=NH1G6uqR0rDCzQZSFYAVbYfFYhh+or3v9TZOiFoQWxCqRBIzIT6GJxNLdBTWaUFIjw
 RURqDTcDxnU7HwSrILW/E6I96rF16fO/AZE8+Bj3QMOQMXKdhdZ7Pr7pz8qN9OTtJ1pU
 hj9vE/tdpSA9qijWqWQjrr+Z59MGxJoDsWKqGXwBhjCe0YYWf8UMZc069iA/+j+qbnzv
 d2uNLip1k/TysYmUXtMOaz/NmfsL+veo3t4LK8RNRKo3vS7R64CNdwDo4BYTwUMuhv4M
 4jRLJDHkKhWNTPxz6sliSC1eZcR1TqELj71ljYdUIpUaAHLgooTU1D3bP98WpM7UlO+u
 59bA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8pDeWBD+ZYROYha+Wt728mGFh91E3Qc41pCTFjXMKIU3i/sQiL4+3e0ts2XbDrg3a7jk5Vca+r06TN@nongnu.org
X-Gm-Message-State: AOJu0YxHidvSnXAxs50T+VEz/oy0x7+PfBqd3HBcq+cSnKXw1uXo3dh9
 1eThFK494jibPIpJa3na8/agTnV+HHYUUkB7F5ZOc8CXEP7EkirthYm2jwiJO5hE7UqJhSnF3m2
 r9PnLmDHQnO50KovqL4at5VPOiZP8mvmvJaNAHGNRkW+GbMNQN7+eDZOv
X-Gm-Gg: AeBDievLX+56KHZ/SnYtnuPcjteLbK3/90D5MCqAdTLGK/QFVvsezLRvtfJCwB/ZYGc
 VZh1xM+NSwd55LRRVtTRtikNqMSA6aV9uYLEl8fuGgNpHh5a/7rfNZmyEVOGaK5tGQokU/wGMSc
 NAaMbMHYawNpFVQxEE1KCSmKkqvXRknfzgI3IzKnB13+BDxFHAk1m7tF9ezENtZKmTMm9Of8pMy
 G6WkFt8UbdjZupgcKhP9MUf/8JxvsCXCILSixPQRBoz+rjaSZ7sWkw1HNNAO7EfwpWpXji51KnT
 B7HYpd1qF/lAXZL5hDL38J8FpTIbX7JumhZqSJDykiSzTJAh2I2hS0pxz6OKpvz5XRd+gv64uBP
 Z1zhKfw04BotU5OzRKKbXufkZgt6mWTuEEzdlRQRiZhRHbN85Fwr5LPqAsKDLkJTPcP/mUrg=
X-Received: by 2002:a05:600c:5253:b0:48a:5574:3a48 with SMTP id
 5b1f17b1804b1-48a9865d948mr159645245e9.16.1777906699421; 
 Mon, 04 May 2026 07:58:19 -0700 (PDT)
X-Received: by 2002:a05:600c:5253:b0:48a:5574:3a48 with SMTP id
 5b1f17b1804b1-48a9865d948mr159644785e9.16.1777906698877; 
 Mon, 04 May 2026 07:58:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82301ad1sm513642425e9.9.2026.05.04.07.58.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 07:58:18 -0700 (PDT)
Message-ID: <9ed5337c-abaf-4f5b-b17e-04dc87165ffa@redhat.com>
Date: Mon, 4 May 2026 16:58:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] hw/arm/smmuv3-accel: Resolve AUTO properties
To: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260422204335.23116-1-nathanc@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260422204335.23116-1-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Nathan,

On 4/22/26 22:43, Nathan Chen wrote:
> Hi,
> 
> This series introduces support for resolving 'auto' for arm-smmuv3
> accelerated mode's ATS, RIL, SSIDSIZE, and OAS feature properties based
> on host IOMMU capabilities. This is dependent on the series [0] for
> changing these property types to accept 'auto' values.
> 
> Accelerated SMMUv3 Address Translation Services support is derived from
> IDR0, Range Invalidation support is derived from IDR3, Substream ID
> size is derived from IDR1, and output address space is derived from
> IDR5.
> 
> The default values are set to 'auto' for all properties. If accel=off
> and the values are set to 'auto' or are omitted and resolve to 'auto',
> the default property values defined in smmuv3_init_id_regs() for OAS
> and RIL will remain unchanged, while SSIDSIZE and ATS values will
> remain initialized at 0.
> 
> A complete branch can be found here:
> https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto-resolve-v2
> 
> Please take a look and let me know your feedback.
> 
> Thanks,
> Nathan
> 
> [0] https://lore.kernel.org/qemu-arm/20260323182454.1416110-1-nathanc@nvidia.com/
> 
> Example usage:
> qemu-system-aarch64 \
>    -object iommufd,id=iommufd0 \
>    -machine virt,accel=kvm,gic-version=3,ras=on,highmem-mmio-size=4T \
>    -cpu host -smp cpus=4 -m size=16G -nographic \
>    -object memory-backend-ram,size=16G,id=m0 \
>    -numa node,memdev=m0,cpus=0-3,nodeid=0 \
>    -numa node,nodeid=1 -numa node,nodeid=2 -numa node,nodeid=3 -numa node,nodeid=4 \
>    -numa node,nodeid=5 -numa node,nodeid=6 -numa node,nodeid=7 -numa node,nodeid=8 \
>    -device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0,numa_node=0 \
>    -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1,accel=on,ats=auto,ssidsize=auto,ril=auto,oas=auto \
>    -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,io-reserve=0 \
>    -device vfio-pci-nohotplug,host=0009:06:00.0,bus=pcie.port1,rombar=0,id=dev0,iommufd=iommufd0,ats=auto \
>    -object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=1 \
>    -object acpi-generic-initiator,id=gi1,pci-dev=dev0,node=2 \
>    -object acpi-generic-initiator,id=gi2,pci-dev=dev0,node=3 \
>    -object acpi-generic-initiator,id=gi3,pci-dev=dev0,node=4 \
>    -object acpi-generic-initiator,id=gi4,pci-dev=dev0,node=5 \
>    -object acpi-generic-initiator,id=gi5,pci-dev=dev0,node=6 \
>    -object acpi-generic-initiator,id=gi6,pci-dev=dev0,node=7 \
>    -object acpi-generic-initiator,id=gi7,pci-dev=dev0,node=8 \
>    -bios /usr/share/AAVMF/AAVMF_CODE.fd \
>    -device nvme,drive=nvme0,serial=deadbeaf1,bus=pcie.0 \
>    -drive file=/var/lib/libvirt/images/guest.qcow2,index=0,media=disk,format=qcow2,if=none,id=nvme0 \
>    -device e1000,romfile=/usr/local/share/qemu/efi-e1000.rom,netdev=net0,bus=pcie.0 \
>    -netdev user,id=net0,hostfwd=tcp::5558-:22,hostfwd=tcp::5586-:5586
> 
> Testing:
> Basic sanity testing was performed on an NVIDIA Grace platform with GPU
> device assignment and running CUDA test apps on the guest. Observed the
> feature properties being set based on host IOMMU capabilities.
> Verified that the VM boot will fail without a cold-plugged device, and
> that a hot-plugged device re-uses the resolved values from the initial
> cold-plug. Additional testing and feedback are welcome.

It is helpful to have a changelog between different versions of
the same series of patches.

So, the linux headers and vfio update are not required anymore ?

Thanks,

C.


> 
> Nathan Chen (7):
>    hw/arm/smmuv3-accel: Add helper for resolving auto parameters
>    hw/arm/smmuv3-accel: Implement "auto" value for "ats"
>    hw/arm/smmuv3-accel: Implement "auto" value for "ril"
>    hw/arm/smmuv3-accel: Implement "auto" value for "ssidsize"
>    hw/arm/smmuv3-accel: Implement "auto" value for "oas"
>    hw/arm/smmuv3: Set default ats, ril, ssidsize, oas to auto
>    qemu-options.hx: Support "auto" for accel SMMUv3 properties
> 
>   hw/arm/smmuv3-accel.c   | 80 ++++++++++++++++++++++++++++++++++++++++-
>   hw/arm/smmuv3-accel.h   |  2 ++
>   hw/arm/smmuv3.c         | 63 +++++++++++++++-----------------
>   hw/core/machine.c       |  8 +++++
>   include/hw/arm/smmuv3.h |  2 ++
>   qemu-options.hx         | 33 +++++++++++------
>   6 files changed, 143 insertions(+), 45 deletions(-)
> 


