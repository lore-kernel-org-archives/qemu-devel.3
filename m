Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CBED1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 10:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSudQ-00068W-CO; Tue, 09 Dec 2025 05:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vSudL-00067k-Co
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 05:07:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vSudJ-0005Eq-8v
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 05:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765274868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VhL6eN5YgdIhKaSPmZ0cO+Q6UN4lVSrRO1fpoN43AU8=;
 b=RrHh9ysVZcs332DW5QRK8pGSvT/zPlFkgY9J8Tv8NJIOJbark/Yuzd/1s6VU52CxHhajPp
 fYijpMCrPz0EmS+We3hjfea2nYJ3/f5w9LXDG7JXdqaFZRDUtkBYbugp5Y3fMnYiox2bak
 QZjMwXg9+LA5t4Dk52oiSUn+OQ1ANaA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-KOTMaVAxP7qpG36v_zmWkg-1; Tue, 09 Dec 2025 05:07:46 -0500
X-MC-Unique: KOTMaVAxP7qpG36v_zmWkg-1
X-Mimecast-MFC-AGG-ID: KOTMaVAxP7qpG36v_zmWkg_1765274866
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42e2b9192a5so2633551f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 02:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765274865; x=1765879665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=VhL6eN5YgdIhKaSPmZ0cO+Q6UN4lVSrRO1fpoN43AU8=;
 b=RosHwESsibFnI57G1Uyy9dhlymb+geGsAVYYKBuM5h03PQrYH23uwStap+/QYtsBJb
 VdHhIjkBqjYW8VvVPY4MxADZmTPbFjc1iTp2c6K7okAyiTs/Q1mS4QWB0u6dsaHatzri
 8q5Tbe2F98BPHJMTB0pvTu/sfFuVOsYrLvhaqRSybrakxhSzk2MvJRKiaqew8JRgf9hv
 8+6Lr7rKRkz1Elucr938Nq9wj95b/mKz4WXvsSzAEGIyU18AOH2vpgXxg+GjWZ5Go9/L
 jf2O6dIO8EMg1CLTFj/4tN+/CQPVtxuNCDCqAj6R9IWD5o0L1qvrp+JADtM7DryqJ6lr
 +I3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765274865; x=1765879665;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VhL6eN5YgdIhKaSPmZ0cO+Q6UN4lVSrRO1fpoN43AU8=;
 b=FEV1wF1OOl8vGbq1f3Xd/t1Z/G0khOfTCGr7sIvyYQxSf0o/ggAPlHKGp9YgzNDU+O
 vGYI9L/Ym8xVpcmKW72PiUH9TJpcr9k1pldv5ebU6uwnhO2Mj0vOFNNaEj0hw/WNxUVX
 U6ZMBSROKSccxnBbzp9tzaTaSGHFjbcgxR8UJnywhfH4f7SlEx/OACTye764NtClZL8C
 4WG2FDMLaY6ddiHy3dHZ+vHCDPd2wHmXmYqG/wY0FjNc9OMADEN3d0xG0aeUd1OcUD1P
 LZf/BcfDB6U6e1CYOQsRWMj9zI+cafWb3in9pbRIhdnIfffQC4/u9UW/84MQP6UatBaO
 nEVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqY9gcKXMatYimO2JNljrVbbeo5zoW+kbV69OpzyLZ1pKU/o9qR02XbAb7Z8TUStyZmsKypQbyzo33@nongnu.org
X-Gm-Message-State: AOJu0YzqBzN6Uioizd2fxOUavmNjc2bBrCYQqJncS5xjGtoIL0n25oTF
 4VsW8F4/d8FnMCKrwDsi1rPBSKwQf974KejUVuxhnFnjEILS9y7WzHAuKZfb8Sf+Tga2Ml0Byad
 PK04gh0au1nS1CK3rz1YNcHwzrkl1CAOd5R7AgZSN0WbyuG8ICDcg7BQR
X-Gm-Gg: ASbGncurCmaRFbLK23oZ6rf8png5oLUzQ4YRTkNv3VRquBQehNReg3+F5sexqvvwjVI
 TACPJpm3tUK062GSn5lP9nz8PNUikRI81Gt+PfZ3x9+TacwH7InAW6jAMrhLA4iC9gDpmWp73L3
 34xm+tmGRMBMVbxC98tOkO/nc149ElIay8BHv3ERsMaSSEG6HUlEI6XznbQM2+9gpsnbpw0K/Ir
 YiCx3s5bAPPTEJHm8h6BFRgTOQX2WtM1RZyVPbk1dNuuNgBg15+H25l1+oRdOBm2efOLdKbJbGc
 6OKPFGHwEZ+DZitvqdNjCtTbWkC+TJg3WtzADiTB3KtEaishWgsrcqNXldI2ZZj9Ug1LNY7ebJS
 DaKGlzdIOjtmwkXglq0M6Z2izrxzu1cyKjU/J90VYopv03XeV
X-Received: by 2002:a05:600c:8184:b0:477:8ba7:fe0a with SMTP id
 5b1f17b1804b1-47939e27710mr117851925e9.24.1765274865247; 
 Tue, 09 Dec 2025 02:07:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHacV85vT5Hyo3baPvgthuy3VTFZk7pYyNwAdMzxcK6FX7Aq3ecfAu7VcEnB9HtQTQiocmNtA==
X-Received: by 2002:a05:600c:8184:b0:477:8ba7:fe0a with SMTP id
 5b1f17b1804b1-47939e27710mr117851605e9.24.1765274864759; 
 Tue, 09 Dec 2025 02:07:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d3319ccsm30079907f8f.34.2025.12.09.02.07.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 02:07:44 -0800 (PST)
Message-ID: <553c8bdc-2eb4-440c-b712-bf1f3443a0ed@redhat.com>
Date: Tue, 9 Dec 2025 11:07:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/32] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, ddutile@redhat.com, berrange@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
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

Hello Shameer,

On 10/31/25 11:49, Shameer Kolothum wrote:
> Hi,
> 
> Changes from v4:
>    https://lore.kernel.org/qemu-devel/20250929133643.38961-1-skolothumtho@nvidia.com/
> 
>   - Addressed feedback from v4 and picked up R-by and T-by tags.
>     Thanks to all!
>   - Split out the _DSM fix into a separate mini series which has
>     already been sent out [0].
>   - Introduced a global shared address space aliasing to the system
>     address space instead of directly using "address_space_memory" in the
>     get_address_space() callback(patch #6).
>   - Fixed pci_find_device() returning NULL in the get_address_space()
>     path (Patch #7).
>   - Introduced an optional supports_address_space() callback for
>     rejecting devices attached to a vIOMMU (Patch #8). This allows us
>     to reject emulated endpoints when using SMMUv3 with accel=on.
>   - Added BIOS table tests for the IORT revision change.
>   - Added support to install vSTE based on SMMUv3 GBPA (Patch #14).
>   - Factored out ID register initialization from the reset path so
>     that it can be used early in the SMMUv3 accel path for HW
>     compatibility checks (Patch #18).
>   - GBPA-based vSTE update depends on Nicolin's kernel patch [1].
>   - VFIO/IOMMUFD has dependency on Zhenzhong's patches: 4/5/8 from the
>     pass-through support series [3].
> 
> PATCH organization:
>   1–25: Enables accelerated SMMUv3 with features based on default QEMU SMMUv3,
>         including IORT RMR based MSI support.
>   26–28: Adds options for specifying RIL, ATS, and OAS features.
>   29–32: Adds PASID support, including VFIO changes.
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
> https://github.com/shamiali2008/qemu-master master-smmuv3-accel-v5
> 
> Please take a look and let me know your feedback.
> 
> Thanks,
> Shameer
> 
> [0] https://lore.kernel.org/qemu-devel/20251022080639.243965-1-skolothumtho@nvidia.com/
> [1] https://lore.kernel.org/linux-iommu/20251024040551.1711281-1-nicolinc@nvidia.com/
> [2] https://lore.kernel.org/qemu-devel/20251024084349.102322-1-zhenzhong.duan@intel.com/
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
> Shameer Kolothum (25):
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
>    hw/arm/smmuv3-accel: Install SMMUv3 GBPA based hwpt
>    hw/pci/pci: Introduce optional get_msi_address_space() callback
>    hw/arm/smmuv3-accel: Make use of get_msi_address_space() callback
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
>   backends/iommufd.c                            |  77 +-
>   backends/trace-events                         |   2 +
>   hw/arm/Kconfig                                |   5 +
>   hw/arm/meson.build                            |   3 +-
>   hw/arm/smmu-common.c                          |  51 +-
>   hw/arm/smmuv3-accel.c                         | 763 ++++++++++++++++++
>   hw/arm/smmuv3-accel.h                         |  92 +++
>   hw/arm/smmuv3-internal.h                      |  29 +-
>   hw/arm/smmuv3.c                               | 161 +++-
>   hw/arm/trace-events                           |   6 +
>   hw/arm/virt-acpi-build.c                      | 128 ++-
>   hw/arm/virt.c                                 |  31 +-
>   hw/i386/intel_iommu.c                         |   5 +-
>   hw/pci-bridge/pci_expander_bridge.c           |   1 -
>   hw/pci-host/gpex-acpi.c                       |  29 +-
>   hw/pci/pci.c                                  |  44 +-
>   hw/vfio/container-legacy.c                    |   8 +-
>   hw/vfio/iommufd.c                             |   7 +-
>   hw/vfio/pci.c                                 |  37 +

Could you please Cc: Alex and I on the VFIO parts ?

Thanks,

C.

>   include/hw/arm/smmu-common.h                  |   7 +
>   include/hw/arm/smmuv3.h                       |   9 +
>   include/hw/arm/virt.h                         |   1 +
>   include/hw/iommu.h                            |   1 +
>   include/hw/pci-host/gpex.h                    |   1 +
>   include/hw/pci/pci.h                          |  33 +
>   include/hw/pci/pci_bridge.h                   |   1 +
>   include/system/host_iommu_device.h            |  17 +-
>   include/system/iommufd.h                      |  29 +-
>   target/arm/kvm.c                              |   2 +-
>   tests/data/acpi/aarch64/virt/IORT             | Bin 128 -> 128 bytes
>   tests/data/acpi/aarch64/virt/IORT.its_off     | Bin 172 -> 172 bytes
>   tests/data/acpi/aarch64/virt/IORT.smmuv3-dev  | Bin 364 -> 364 bytes
>   .../data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 276 bytes
>   33 files changed, 1506 insertions(+), 74 deletions(-)
>   create mode 100644 hw/arm/smmuv3-accel.c
>   create mode 100644 hw/arm/smmuv3-accel.h
> 


