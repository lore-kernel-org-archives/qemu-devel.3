Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9F7D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 10:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSv0l-0006PR-La; Tue, 09 Dec 2025 05:32:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vSv0e-0006Op-87
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 05:31:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vSv0Z-0003tb-Uj
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 05:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765276310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wiaPmYAw/k3RkmnvJ86TKUAEaDvsCoN4EGuvsb8ZBLs=;
 b=Prdu/oYdzLRp7YDWr3f3NSzKkaNhggDG3KT8w5PjpGPNcHIODdCZ+gOLZW2f4pe1bqqMmh
 QQTCONwHXfRLcuzp2VaJ+eBnMxE0Q8qSpcpMzqc00YIssjhs3MGOfnVtEeq3eA1TIfomYO
 YosQR1F/Ef2/QDmpY1jqmw35zc4VCdc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-bnXN1GD7M3WyGoGm2z8EZg-1; Tue, 09 Dec 2025 05:31:49 -0500
X-MC-Unique: bnXN1GD7M3WyGoGm2z8EZg-1
X-Mimecast-MFC-AGG-ID: bnXN1GD7M3WyGoGm2z8EZg_1765276308
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so45197635e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 02:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765276308; x=1765881108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=wiaPmYAw/k3RkmnvJ86TKUAEaDvsCoN4EGuvsb8ZBLs=;
 b=p8p2CU0ytw1n/rGPmwOo91kI4sL+fiM04mqV4hcD6+Cps+s7kKj2oRjQ9bkKc3nkSe
 W7l2CExGimtmwjbKG5rQOey0mJvNJOzlGdtsXs92u9XpozY6T4rv8f9lWi+ikNlSqh8N
 OBEGm5PtjaHeO+JzZKAhGiavoSCe5pCZNEtjOXGq0R2LJSekRecQLys76MWdYc5vp3f+
 BB7DUTtq1gz6Zhn5b7creq9cnDaeNxq7d1XPQQ8XZGWRl4HshYlUxphofnn+usgAhpW8
 ZKd7Sa5zA+ph3H8nVCmNBc2134xnwUeRkI3Y2/WTN6Sa+957hxoaCgQjmLtEUK51nxFE
 zcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765276308; x=1765881108;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wiaPmYAw/k3RkmnvJ86TKUAEaDvsCoN4EGuvsb8ZBLs=;
 b=cPM5YcPtG+1Q8BmPxBJJOoujSgVoptsZ95s45uG8EyhWaLxr6fchNaDsrmuxNEM8dU
 dqLJDx/E04L+20bjhHWvdekPfqNGzi08pJGJWSmW30Za6bCQUyOQWLPEFlEJX1rBqlT2
 HGwrMOyPRV/li8guQIs0GhczssJdRPzASDvn+/6HluDeBV8hUiiearrbFqE7hC70I4pA
 Ii1EGUy57EGTfUlkmokLsYR+AlfkpfDqh4XI3i6AlYdL1EryMNtd9gkwFlxZwCFnT7yY
 Uj5FUEEaZzvvTIpYQiwYAI4kNJNrdjkFFOMe7/gpWoGeGRbsRww1aZIIBltL/9bWFsHc
 9wqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMeLaHWLbwRe2X3wlmUS+0F2OTQXRhgOUh7qO2R418HmHMrDMT8/2ZEfmAPB7dWrpSNaPb+NzvTwZG@nongnu.org
X-Gm-Message-State: AOJu0YzCPrTWbfjzsZaWllFTcydb9EWFT/+5f6lP9RnIsWR1Ji0oRR5f
 4MLetEP5/x6mrNQ0LROwUPmPeEup23PBER1DN1dtbHub+V8fh/cFsnTDcNSrKqbs813ukU5z4Ep
 zVl7D5EbpCi/E0WJRec+sI8aw75DVNawhtpNKiJd4ptWIyZqTBKSrI/tR
X-Gm-Gg: ASbGncvoiUt2jTki8yWfMcUg8DWBEdWMU32i0IrPGtJB+1vWwGy3ApNM3Skn6p/CCH1
 L9BdB0zfQrtI7bKhHDg3sEcB9lzwNTb7w8kNieRQEYJdJOI2lUex4WzYbX0ShHy+ho2NKKQ6CpB
 1nveSudEg/PUUYXceVmFPW0cbULkEGLdsUPWpV5wc0QmXk3IcENhWa9NZtZmaWvv2gZsOj+zXes
 WnMMOSD9FogmiiUegMpK5isElqTiTWx+14aBq0vMcB6C2GDIHzc+9l1CWY2ZbrdwK1Jcrd8EuMP
 7iwQUG97B6bT85nDUFG1tqXgNvSDAVeDQIdZntpEWWrnR4EXVK5UcmMJd3xqvDutIjRsopER8p0
 iUQlkbal0nma6QDtZo+Vgmqle5OtR3MJLCdGh3FY4EyJEcoVD
X-Received: by 2002:a05:600c:154c:b0:477:7991:5d1e with SMTP id
 5b1f17b1804b1-47939e386dfmr109106045e9.25.1765276307644; 
 Tue, 09 Dec 2025 02:31:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESiHzYh45fITQWmiXwlDRMoogcAhJPOpd3e9JbWsgTfwRr61yyn+ZLr6YmiepiOB0724dUJg==
X-Received: by 2002:a05:600c:154c:b0:477:7991:5d1e with SMTP id
 5b1f17b1804b1-47939e386dfmr109105555e9.25.1765276307087; 
 Tue, 09 Dec 2025 02:31:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a815e862asm2321195e9.1.2025.12.09.02.31.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 02:31:46 -0800 (PST)
Message-ID: <1ee20ead-6978-4c2b-9b2f-ad778107ad04@redhat.com>
Date: Tue, 9 Dec 2025 11:31:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/33] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, ddutile@redhat.com, berrange@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/20/25 14:21, Shameer Kolothum wrote:
> Hi,
> 
> Changes from v5:
>    https://lore.kernel.org/qemu-devel/20251031105005.24618-1-skolothumtho@nvidia.com/
> 
>   - Addressed feedback from v5 and picked up R-by tags. Thanks to all!
>   - The previously split out _DSM fix mini-series is now accepted [0].
>   - Improved documentation about the rationale behind the design choice of
>     returning an address space aliased to the system address space for
>     vfio-pci endpoint devices (patch #10).
>   - Added error propagation support for smmuv3_cmdq_consume() (patch #13).
>   - Updated vSTE based HWPT installation to check the SMMU enabled case
>     (patch #14).
>   - Introduced an optional callback to PCIIOMMUOps to retrieve the MSI
>     doorbell GPA directly, allowing us to avoid unsafe page table walks for
>     MSI translation in accelerated SMMUv3 cases (patch #16).
>   - GBPA-based vSTE update depends on Nicolin's kernel patch [1].
>   - VFIO/IOMMUFD has dependency on Zhenzhong's patches: 4/5/8 from the
>     pass-through support series [2].
> 
> PATCH organization:
>   1–26: Enables accelerated SMMUv3 with features based on default QEMU SMMUv3,
>         including IORT RMR based MSI support.
>   27–29: Adds options for specifying RIL, ATS, and OAS features.
>   30–33: Adds PASID support, including VFIO changes.
> 
> Tests:
> Performed basic sanity tests on an NVIDIA GRACE platform with GPU device
> assignments. A CUDA test application was used to verify the SVA use case.
> Further tests are always welcome.
> 
> Eg: Qemu Cmd line:
> 
> qemu-system-aarch64 -machine virt,gic-version=3,highmem-mmio-size=2T \
> -cpu host -smp cpus=4 -m size=16G,slots=2,maxmem=66G -nographic \
> -bios QEMU_EFI.fd -object iommufd,id=iommufd0 -enable-kvm \
> -object memory-backend-ram,size=8G,id=m0 \
> -object memory-backend-ram,size=8G,id=m1 \
> -numa node,memdev=m0,cpus=0-3,nodeid=0 -numa node,memdev=m1,nodeid=1 \
> -numa node,nodeid=2 -numa node,nodeid=3 -numa node,nodeid=4 -numa node,nodeid=5 \
> -numa node,nodeid=6 -numa node,nodeid=7 -numa node,nodeid=8 -numa node,nodeid=9 \
> -device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0 \
> -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.0,accel=on,ats=on,ril=off,pasid=on,oas=48 \
> -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,pref64-reserve=512G,id=dev0 \
> -device vfio-pci,host=0019:06:00.0,rombar=0,id=dev0,iommufd=iommufd0,bus=pcie.port1 \
> -object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=2 \
> ...
> -object acpi-generic-initiator,id=gi7,pci-dev=dev0,node=9 \
> -device pxb-pcie,id=pcie.2,bus_nr=8,bus=pcie.0 \
> -device arm-smmuv3,primary-bus=pcie.2,id=smmuv3.1,accel=on,ats=on,ril=off,pasid=on \
> -device pcie-root-port,id=pcie.port2,bus=pcie.2,chassis=2,pref64-reserve=512G \
> -device vfio-pci,host=0018:06:00.0,rombar=0,id=dev1,iommufd=iommufd0,bus=pcie.port2 \
> -device virtio-blk-device,drive=fs \
> -drive file=image.qcow2,index=0,media=disk,format=qcow2,if=none,id=fs \
> -net none \
> -nographic
> 
> A complete branch can be found here,
> https://github.com/shamiali2008/qemu-master master-smmuv3-accel-v6
> 
> Please take a look and let me know your feedback.
> 
> Thanks,
> Shameer
> 
> [0] https://lore.kernel.org/qemu-devel/20251022080639.243965-1-skolothumtho@nvidia.com/
> [1] https://lore.kernel.org/linux-iommu/20251103172755.2026145-1-nicolinc@nvidia.com/
> [2] https://lore.kernel.org/qemu-devel/20251117093729.1121324-1-zhenzhong.duan@intel.com/
> 
> Details from RFCv3 Cover letter:
> -------------------------------
> https://lore.kernel.org/qemu-devel/20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com/
> 
> This patch series introduces initial support for a user-creatable,
> accelerated SMMUv3 device (-device arm-smmuv3,accel=on) in QEMU.
> 
> This is based on the user-creatable SMMUv3 device series [0].
> 
> Why this is needed:
> 
> On ARM, to enable vfio-pci pass-through devices in a VM, the host SMMUv3
> must be set up in nested translation mode (Stage 1 + Stage 2), with
> Stage 1 (S1) controlled by the guest and Stage 2 (S2) managed by the host.
> 
> This series introduces an optional accel property for the SMMUv3 device,
> indicating that the guest will try to leverage host SMMUv3 features for
> acceleration. By default, enabling accel configures the host SMMUv3 in
> nested mode to support vfio-pci pass-through.
> 
> This new accelerated, user-creatable SMMUv3 device lets you:
> 
>   -Set up a VM with multiple SMMUv3s, each tied to a different physical SMMUv3
>    on the host. Typically, you’d have multiple PCIe PXB root complexes in the
>    VM (one per virtual NUMA node), and each of them can have its own SMMUv3.
>    This setup mirrors the host's layout, where each NUMA node has its own
>    SMMUv3, and helps build VMs that are more aligned with the host's NUMA
>    topology.
> 
>   -The host–guest SMMUv3 association results in reduced invalidation broadcasts
>    and lookups for devices behind different physical SMMUv3s.
> 
>   -Simplifies handling of host SMMUv3s with differing feature sets.
> 
>   -Lays the groundwork for additional capabilities like vCMDQ support.
> -------------------------------
> 
> Eric Auger (2):
>    hw/pci-host/gpex: Allow to generate preserve boot config DSM #5
>    hw/arm/virt-acpi-build: Add IORT RMR regions to handle MSI nested
>      binding
> 
> Nicolin Chen (4):
>    backends/iommufd: Introduce iommufd_backend_alloc_viommu
>    backends/iommufd: Introduce iommufd_backend_alloc_vdev
>    hw/arm/smmuv3-accel: Add set/unset_iommu_device callback
>    hw/arm/smmuv3-accel: Add nested vSTE install/uninstall support
> 
> Shameer Kolothum (26):
>    hw/arm/smmu-common: Factor out common helper functions and export
>    hw/arm/smmu-common: Make iommu ops part of SMMUState
>    hw/arm/smmuv3-accel: Introduce smmuv3 accel device
>    hw/arm/smmuv3-accel: Initialize shared system address space
>    hw/pci/pci: Move pci_init_bus_master() after adding device to bus
>    hw/pci/pci: Add optional supports_address_space() callback
>    hw/pci-bridge/pci_expander_bridge: Move TYPE_PXB_PCIE_DEV to header
>    hw/arm/smmuv3-accel: Restrict accelerated SMMUv3 to vfio-pci endpoints
>      with iommufd
>    hw/arm/smmuv3: Implement get_viommu_cap() callback
>    hw/arm/smmuv3: propagate smmuv3_cmdq_consume() errors to caller
>    hw/arm/smmuv3-accel: Install SMMUv3 GBPA based hwpt
>    hw/pci/pci: Introduce a callback to retrieve the MSI doorbell GPA
>      directly
>    hw/arm/smmuv3: Add support for providing a direct MSI doorbell GPA
>    hw/arm/smmuv3-accel: Add support to issue invalidation cmd to host
>    hw/arm/smmuv3: Initialize ID registers early during realize()
>    hw/arm/smmuv3-accel: Get host SMMUv3 hw info and validate
>    hw/arm/virt: Set PCI preserve_config for accel SMMUv3
>    tests/qtest/bios-tables-test: Prepare for IORT revison upgrade
>    tests/qtest/bios-tables-test: Update IORT blobs after revision upgrade
>    hw/arm/smmuv3: Add accel property for SMMUv3 device
>    hw/arm/smmuv3-accel: Add a property to specify RIL support
>    hw/arm/smmuv3-accel: Add support for ATS
>    hw/arm/smmuv3-accel: Add property to specify OAS bits
>    backends/iommufd: Retrieve PASID width from
>      iommufd_backend_get_device_info()
>    Extend get_cap() callback to support PASID
>    hw/arm/smmuv3-accel: Add support for PASID enable
> 
> Yi Liu (1):
>    vfio: Synthesize vPASID capability to VM
> 
>   backends/iommufd.c                            |  82 +-
>   backends/trace-events                         |   2 +
>   hw/arm/Kconfig                                |   5 +
>   hw/arm/meson.build                            |   3 +-
>   hw/arm/smmu-common.c                          |  51 +-
>   hw/arm/smmuv3-accel.c                         | 756 ++++++++++++++++++
>   hw/arm/smmuv3-accel.h                         |  86 ++
>   hw/arm/smmuv3-internal.h                      |  27 +-
>   hw/arm/smmuv3.c                               | 206 ++++-
>   hw/arm/trace-events                           |   6 +
>   hw/arm/virt-acpi-build.c                      | 127 ++-
>   hw/arm/virt.c                                 |  30 +
>   hw/i386/intel_iommu.c                         |   8 +-
>   hw/pci-bridge/pci_expander_bridge.c           |   1 -
>   hw/pci-host/gpex-acpi.c                       |  29 +-
>   hw/pci/pci.c                                  |  43 +-
>   hw/vfio/container-legacy.c                    |   8 +-
>   hw/vfio/iommufd.c                             |   7 +-
>   hw/vfio/pci.c                                 |  38 +
>   include/hw/arm/smmu-common.h                  |   7 +
>   include/hw/arm/smmuv3.h                       |  10 +
>   include/hw/arm/virt.h                         |   1 +
>   include/hw/iommu.h                            |   1 +
>   include/hw/pci-host/gpex.h                    |   1 +
>   include/hw/pci/pci.h                          |  34 +
>   include/hw/pci/pci_bridge.h                   |   1 +
>   include/system/host_iommu_device.h            |  21 +-
>   include/system/iommufd.h                      |  29 +-
>   target/arm/kvm.c                              |  18 +-
>   tests/data/acpi/aarch64/virt/IORT             | Bin 128 -> 128 bytes
>   tests/data/acpi/aarch64/virt/IORT.its_off     | Bin 172 -> 172 bytes
>   tests/data/acpi/aarch64/virt/IORT.smmuv3-dev  | Bin 364 -> 364 bytes
>   .../data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 276 bytes
>   33 files changed, 1536 insertions(+), 102 deletions(-)
>   create mode 100644 hw/arm/smmuv3-accel.c
>   create mode 100644 hw/arm/smmuv3-accel.h
> 

FYI, I am seeing configure errors :

The following clauses were found for ARM_SMMUV3_ACCEL
     select ARM_SMMUV3_ACCEL if ARM_VIRT
     config ARM_SMMUV3_ACCEL depends on (ARM_SMMUV3 && IOMMUFD)

KconfigDataError: contradiction between clauses when setting ARM_SMMUV3_ACCEL

Thanks,

C.


