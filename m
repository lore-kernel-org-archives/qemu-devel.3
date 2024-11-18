Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659C9D49209
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 10:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCzLQ-0008Go-Pq; Mon, 18 Nov 2024 05:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tCzLO-0008GI-7p
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:50:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tCzLL-0003sn-U8
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 05:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731927054;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oaeFAzdxsX+dqU1kQ1prltk/oaieuo84DGrcSqOPNIE=;
 b=N5/UKaqbBGOIsWR9xYPcVBIx/NXTysLzufvGykgkgjQYWyg1SuYYmGtHpHeJx/EMwPNseE
 68p9VQBtPqImXIZ1cFUCp0tDRs6oaXMwRNvMm4elcAYe6hr+Yc/si7rXMQI95vqUY8Jqtj
 msLPq6gtjWOIrbbVjgQGfc/gfO7XzAY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-1hUbS_1tOc-L-P5O9LItfg-1; Mon, 18 Nov 2024 05:50:52 -0500
X-MC-Unique: 1hUbS_1tOc-L-P5O9LItfg-1
X-Mimecast-MFC-AGG-ID: 1hUbS_1tOc-L-P5O9LItfg
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d4189482d8so27826946d6.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 02:50:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731927052; x=1732531852;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oaeFAzdxsX+dqU1kQ1prltk/oaieuo84DGrcSqOPNIE=;
 b=hZuwQaQ1VGfXWYAHTiU+fTCEwZR/xDWtiMXvvXuxe/1eoSfpHQ89YgTjQnTLHLerE3
 d60buuHGatdUnbX8lTso6MGZbAm6UiPe77G2J+wMKigRGlEvw5oHn3s7RtBJt8nSDFyQ
 n+YPdF7E86UwZhqf5GDLwTvtg17JhQ2xUUmCa0y2CMMjV0aGQZ5ruwrNblJCIc7sLPlB
 XTcJHR2G3A9urRu+OE8K+aqO2ODzKHIGNa08huHbaE9bd+t4Tmy/gFwWOzrLbG2BiRL1
 LVZVIFXlsXTPyhFvLT077yDMMcfMoij6QmEM6tDM/X0Ih6fPeduKSSaesvGeW5UllOyu
 025w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmVFQ0Uy4Z5pQplY3BsrMzBdvUmkMbfXjlaOHXBXnoHah96FgSqAgcdXe3kR2Madg833ZZGFkB471K@nongnu.org
X-Gm-Message-State: AOJu0Yy3q0oD09hBaEWvQe2VlimOniKWYA4PLn+pUxAltE8eiDt7UU/z
 gHahy/XMbZAPUQAh0UW5GxjE/gmPZEE2JYJMtwn4Sz1tV91hegBpXGsssXO3UNd6HGMZe5xT+wl
 DlcwgiE+3q9qqNQ3o48wmleM1D0gplXyfghurmOk3Ve03ijXiLHr1
X-Received: by 2002:a05:6214:4282:b0:6d3:f671:8913 with SMTP id
 6a1803df08f44-6d3fb8590b2mr183285226d6.35.1731927051842; 
 Mon, 18 Nov 2024 02:50:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfloPH7WG1oxUx0bAJV27A9C8m1uPFS/vZ+CSRJF4IQbDJ8eumyYJ7zZ7jnEGFNCwMSPCF5Q==
X-Received: by 2002:a05:6214:4282:b0:6d3:f671:8913 with SMTP id
 6a1803df08f44-6d3fb8590b2mr183284956d6.35.1731927051493; 
 Mon, 18 Nov 2024 02:50:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d40dc48b9asm34217276d6.65.2024.11.18.02.50.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 02:50:50 -0800 (PST)
Message-ID: <8ce24003-66ad-43da-b68a-14686758a85a@redhat.com>
Date: Mon, 18 Nov 2024 11:50:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, Andrea Bolognani <abologna@redhat.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 11/8/24 13:52, Shameer Kolothum wrote:
> Hi,
>
> This series adds initial support for a user-creatable "arm-smmuv3-nested"
> device to Qemu. At present the Qemu ARM SMMUv3 emulation is per machine
> and cannot support multiple SMMUv3s.
>
> In order to support vfio-pci dev assignment with vSMMUv3, the physical
> SMMUv3 has to be configured in nested mode. Having a pluggable
> "arm-smmuv3-nested" device enables us to have multiple vSMMUv3 for Guests
> running on a host with multiple physical SMMUv3s. A few benefits of doing
> this are,
>
> 1. Avoid invalidation broadcast or lookup in case devices are behind
>    multiple phys SMMUv3s.
> 2. Makes it easy to handle phys SMMUv3s that differ in features.
> 3. Easy to handle future requirements such as vCMDQ support.
>
> This is based on discussions/suggestions received for a previous RFC by
> Nicolin here[0].
>
> This series includes,
>  -Adds support for "arm-smmuv3-nested" device. At present only virt is
>   supported and is using _plug_cb() callback to hook the sysbus mem
>   and irq (Not sure this has any negative repercussions). Patch #3.
>  -Provides a way to associate a pci-bus(pxb-pcie) to the above device.
>   Patch #3.
>  -The last patch is adding RMR support for MSI doorbell handling. Patch #5.
>   This may change in future[1].
>
> This RFC is for initial discussion/test purposes only and includes patches
> that are only relevant for adding the "arm-smmuv3-nested" support. For the
> complete branch please find,
> https://github.com/hisilicon/qemu/tree/private-smmuv3-nested-dev-rfc-v1
>
> Few ToDos to note,
> 1. At present default-bus-bypass-iommu=on should be set when
>    arm-smmuv3-nested dev is specified. Otherwise you may get an IORT
>    related boot error.  Requires fixing.
> 2. Hot adding a device is not working at the moment. Looks like pcihp irq issue.
>    Could be a bug in IORT id mappings.
> 3. The above branch doesn't support vSVA yet.
>
> Hopefully this is helpful in taking the discussion forward. Please take a
> look and let me know.
>
> How to use it(Eg:):
>
> On a HiSilicon platform that has multiple physical SMMUv3s, the ACC ZIP VF
> devices and HNS VF devices are behind different SMMUv3s. So for a Guest,
> specify two smmuv3-nested devices each behind a pxb-pcie as below,
>
> ./qemu-system-aarch64 -machine virt,gic-version=3,default-bus-bypass-iommu=on \
> -enable-kvm -cpu host -m 4G -smp cpus=8,maxcpus=8 \
> -object iommufd,id=iommufd0 \
> -bios QEMU_EFI.fd \
> -kernel Image \
> -device virtio-blk-device,drive=fs \
> -drive if=none,file=rootfs.qcow2,id=fs \
> -device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \
> -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1 \
> -device arm-smmuv3-nested,id=smmuv1,pci-bus=pcie.1 \
> -device vfio-pci,host=0000:7d:02.1,bus=pcie.port1,iommufd=iommufd0 \
> -device pxb-pcie,id=pcie.2,bus_nr=16,bus=pcie.0 \
> -device pcie-root-port,id=pcie.port2,bus=pcie.2,chassis=2 \
> -device arm-smmuv3-nested,id=smmuv2,pci-bus=pcie.2 \
> -device vfio-pci,host=0000:75:00.1,bus=pcie.port2,iommufd=iommufd0 \
> -append "rdinit=init console=ttyAMA0 root=/dev/vda2 rw earlycon=pl011,0x9000000" \
> -device virtio-9p-pci,fsdev=p9fs2,mount_tag=p9,bus=pcie.0 \
> -fsdev local,id=p9fs2,path=p9root,security_model=mapped \
This kind of instantiation matches what I had in mind. It is
questionable whether the legacy SMMU shouldn't be migrated to that mode
too (instead of using a machine option setting), depending on Peter's
feedbacks and also comments from Libvirt guys. Adding Andrea in the loop.

Thanks

Eric
> -net none \
> -nographic
>
> Guest will boot with two SMMuv3s,
> [    1.608130] arm-smmu-v3 arm-smmu-v3.0.auto: option mask 0x0
> [    1.609655] arm-smmu-v3 arm-smmu-v3.0.auto: ias 48-bit, oas 48-bit (features 0x00020b25)
> [    1.612475] arm-smmu-v3 arm-smmu-v3.0.auto: allocated 65536 entries for cmdq
> [    1.614444] arm-smmu-v3 arm-smmu-v3.0.auto: allocated 32768 entries for evtq
> [    1.617451] arm-smmu-v3 arm-smmu-v3.1.auto: option mask 0x0
> [    1.618842] arm-smmu-v3 arm-smmu-v3.1.auto: ias 48-bit, oas 48-bit (features 0x00020b25)
> [    1.621366] arm-smmu-v3 arm-smmu-v3.1.auto: allocated 65536 entries for cmdq
> [    1.623225] arm-smmu-v3 arm-smmu-v3.1.auto: allocated 32768 entries for evtq
>
> With a pci topology like below,
> [root@localhost ~]# lspci -tv
> -+-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
>  |           +-01.0  Red Hat, Inc. QEMU PCIe Expander bridge
>  |           +-02.0  Red Hat, Inc. QEMU PCIe Expander bridge
>  |           \-03.0  Virtio: Virtio filesystem
>  +-[0000:08]---00.0-[09]----00.0  Huawei Technologies Co., Ltd. HNS Network Controller (Virtual Function)
>  \-[0000:10]---00.0-[11]----00.0  Huawei Technologies Co., Ltd. HiSilicon ZIP Engine(Virtual Function)
> [root@localhost ~]#
>
> And if you want to add another HNS VF, it should be added to the same SMMUv3
> as of the first HNS dev,
>
> -device pcie-root-port,id=pcie.port3,bus=pcie.1,chassis=3 \
> -device vfio-pci,host=0000:7d:02.2,bus=pcie.port3,iommufd=iommufd0 \
>
> [root@localhost ~]# lspci -tv
> -+-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
>  |           +-01.0  Red Hat, Inc. QEMU PCIe Expander bridge
>  |           +-02.0  Red Hat, Inc. QEMU PCIe Expander bridge
>  |           \-03.0  Virtio: Virtio filesystem
>  +-[0000:08]-+-00.0-[09]----00.0  Huawei Technologies Co., Ltd. HNS Network Controller (Virtual Function)
>  |           \-01.0-[0a]----00.0  Huawei Technologies Co., Ltd. HNS Network Controller (Virtual Function)
>  \-[0000:10]---00.0-[11]----00.0  Huawei Technologies Co., Ltd. HiSilicon ZIP Engine(Virtual Function)
> [root@localhost ~]#
>
> Attempt to add the HNS VF to a different SMMUv3 will result in,
>
> -device vfio-pci,host=0000:7d:02.2,bus=pcie.port3,iommufd=iommufd0: Unable to attach viommu
> -device vfio-pci,host=0000:7d:02.2,bus=pcie.port3,iommufd=iommufd0: vfio 0000:7d:02.2:
>    Failed to set iommu_device: [iommufd=29] error attach 0000:7d:02.2 (38) to id=11: Invalid argument
>
> At present Qemu is not doing any extra validation other than the above
> failure to make sure the user configuration is correct or not. The
> assumption is libvirt will take care of this.
>
> Thanks,
> Shameer
> [0] https://lore.kernel.org/qemu-devel/cover.1719361174.git.nicolinc@nvidia.com/
> [1] https://lore.kernel.org/linux-iommu/ZrVN05VylFq8lK4q@Asurada-Nvidia/
>
> Eric Auger (1):
>   hw/arm/virt-acpi-build: Add IORT RMR regions to handle MSI nested
>     binding
>
> Nicolin Chen (2):
>   hw/arm/virt: Add an SMMU_IO_LEN macro
>   hw/arm/virt-acpi-build: Build IORT with multiple SMMU nodes
>
> Shameer Kolothum (2):
>   hw/arm/smmuv3: Add initial support for SMMUv3 Nested device
>   hw/arm/smmuv3: Associate a pci bus with a SMMUv3 Nested device
>
>  hw/arm/smmuv3.c          |  61 ++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c | 109 ++++++++++++++++++++++++++++++++-------
>  hw/arm/virt.c            |  33 ++++++++++--
>  hw/core/sysbus-fdt.c     |   1 +
>  include/hw/arm/smmuv3.h  |  17 ++++++
>  include/hw/arm/virt.h    |  15 ++++++
>  6 files changed, 215 insertions(+), 21 deletions(-)
>


