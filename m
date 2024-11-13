Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F9FD462D0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 16:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBG2y-0007Rc-Do; Wed, 13 Nov 2024 11:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1tBG2w-0007QH-QI
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 11:16:47 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1tBG2u-0005BO-HA
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 11:16:46 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-53da266cf37so4753e87.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 08:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731514602; x=1732119402; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LiSHDbLAv6mIXLorT18cINUKafJvqOrs9fp4p3I+ElY=;
 b=gUAa1EneOjWJuSmW5/r0xYkEQHVjjpbrm+cWPwEWhIQ/h4LHGC0V/cLocvb2REqywn
 r/JkZsfQ5EMtu1+HFiNtB1iNglecR2cHEpYCB8ES8UCRv4k/5DEgAEx5DcuY1PhJnlzj
 cneHyMkryOC4FYV47x6RYN7YT/hQfpbVH7H1Oiyd0o3TyIPO5DUZoNOlrXbPVKa6fXEj
 cnSWvhFM6McOPQmAqi/JtQJ+jMFcMdOP+qgzCJCFQJz82X8/r7fjgUbfGJNmtRyH24kQ
 OSuAPrNvlwfYopUlZ7UESeZKCqIuKTK+L4HRCMLTTOFXnBqIP2QD/vCX8JELZRYXGsf0
 dsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731514602; x=1732119402;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LiSHDbLAv6mIXLorT18cINUKafJvqOrs9fp4p3I+ElY=;
 b=qQigs8Ow7uGNgHMIJ8XzFOSdxO5VTymsy6qvYnLSXqXIRWMvJILnVZsUlcxa+LEt7i
 NUP3MhB4/Ekzu25uMxgh9DjnZd4VOl4DF+HDnLD/GUaPTu/nDZDjqDM3zBpwFcTyypXX
 oR1cmfFa1IVtcIb0Ew+qRYjVt3HBhBcFyAFdOKWOmrNESR0SYsOzLkoFD9I83Q4DovK4
 38OusnBsOHnGoYQAH0XE5dnlzYIaBZWxtSc2VuMjnVTb3JcrY4hgClGJkrgMAojQhqEC
 n/zALaRuflGszeGtltpXBIHWHUCNv55XOJEhN9fWcA45GcphNiNfjEX/4XHc+rE0E0vu
 mEjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGak4xR5lOthEUdf+0Dl4/V9w8BevuoykqU9763RwelqMUcYRBFhU0jFMeXCuCPz7fzwjoW03+EV9f@nongnu.org
X-Gm-Message-State: AOJu0YzLtAD7C0QPyrOVd4kqNSy2+XRU9ytOQKdxAsE7MKAB7es7PwUR
 Dj96PLuve8liaRs8HkVO6QV6luXBL+5nWoQ8gx5cEQeaE4PLFTJbHGHgN2QdDw==
X-Gm-Gg: ASbGncuwA6LPlm8bbUNErcnntquLtSVHzVwhc7/iySM205lQpSiKOgIUz/6VUiST0li
 abIAUhxnCmdZR/ufk8ulDVLcRgC4VXFpBzIr8b/rXXG4RWQNg5u2AK9U/lUKVD2+p4zyqxIQU45
 85YaiLKffh+y2xF88RWwEIp7Bq7ifPvXSHBvpl86Mgygo6c6/qxgdk+5yHspZYzbJFwOIJDNMLb
 NNXIloR0+mziBHY76JVHqL6Zt9rJTXlxSmulPfmlQgPulP8/L4d8mrJUOa3oZg3+9JpDvPWgRt1
 cLKBxVosIybm
X-Google-Smtp-Source: AGHT+IEC3l7msHlGWD4j+YVAY1Ft2m20Cc39K5nYzCi7d+6hSBbvBph5YiM7FfXwnHA3qFwQWegHhg==
X-Received: by 2002:ac2:42d1:0:b0:53b:4c7c:a792 with SMTP id
 2adb3069b0e04-53da024641dmr101138e87.6.1731514601330; 
 Wed, 13 Nov 2024 08:16:41 -0800 (PST)
Received: from google.com (158.100.79.34.bc.googleusercontent.com.
 [34.79.100.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9978afsm18603259f8f.52.2024.11.13.08.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 08:16:40 -0800 (PST)
Date: Wed, 13 Nov 2024 16:16:36 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <ZzTQ5Dn8ckIJjxc-@google.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=smostafa@google.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Shameer,

On Fri, Nov 08, 2024 at 12:52:37PM +0000, Shameer Kolothum via wrote:
> Hi,
> 
> This series adds initial support for a user-creatable "arm-smmuv3-nested"
> device to Qemu. At present the Qemu ARM SMMUv3 emulation is per machine
> and cannot support multiple SMMUv3s.
> 

I had a quick look at the SMMUv3 files, as now SMMUv3 supports nested
translation emulation, would it make sense to rename this? As AFAIU,
this is about virt (stage-1) SMMUv3 that is emulated to a guest.
Including vSMMU or virt would help distinguish the code, as now
some new function as smmu_nested_realize() looks confusing.

Thanks,
Mostafa

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
> -- 
> 2.34.1
> 
> 

