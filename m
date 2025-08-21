Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEE2CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up10N-0004yl-Qu; Thu, 21 Aug 2025 04:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1up10I-0004ui-Lg
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:50:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1up101-00025m-Nz
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755766215;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w9KeNcA9HL4jMBHFgQA3cHl6aj3xT3F91l/m43fOfAQ=;
 b=EhziWTq44qgvhvWWET88RcGL6e9qmsWwNBXu5JVC3F6C5dYTUU621E+NhtJgtOUjSoubO6
 dNk93mclwDc00fOw15YAE9X4rL722KOOf5JraJuM0lKhvfmUsM4X9rk8Lr9nOtNwUBsYuh
 pL4bWAcoLXJy0B7iOo0aME4d/zrlZfA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-azOfMWY3PPiB2QRA2ZBnyA-1; Thu, 21 Aug 2025 04:50:11 -0400
X-MC-Unique: azOfMWY3PPiB2QRA2ZBnyA-1
X-Mimecast-MFC-AGG-ID: azOfMWY3PPiB2QRA2ZBnyA_1755766210
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a1b0b46bbso3737315e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755766210; x=1756371010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w9KeNcA9HL4jMBHFgQA3cHl6aj3xT3F91l/m43fOfAQ=;
 b=L/M3goVaFeG+hs6uVFAxR9x2OZONcaF/D8TKcxYYqorRfLu3+rftxkhy8GqOW04FbD
 xF1+C77/a3Xuxc3zoRfLZ3TpwLP0PC2xMiIuHoVd5dj8LQj69jX5xtDbRiPcFw5LxFJ9
 9TJodSFmUnXWObL1q+lL8zygTsmXe0tiLG0/cffBfabfQKfWz2Hs05YqPqZFiJQArrHn
 /vhGj+rNSzHdvpts62KeSlRgbBbJFCpvCuJDcjmFdsjgV2mi4wMsx6ufmb0PC5rsncoS
 lGNUqGSZqdmXr/SoQTZeRx9DWIolTu9kC6SOsfsqdyfHIPi5+avbOjMAWqYgCq8sPGCL
 WTjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6p8WxTXpp/Z8yoe0fA7+Lqxisd1vOAA40nHNFrpQ1457kcCcyI5I8+NWEXhakCzMEbuupamJci+fM@nongnu.org
X-Gm-Message-State: AOJu0Yz2nmb+y3SB9h0bVAXyINNmQcfwOMESSpSbBDCz3MHaVR9HCQJc
 ZKbJANLSjZyZMXiA3UvX98jNO6qKzuWNeyaF2OxteBfZ1AL6OLgqH/87IZcvG9ajnG3p8eI2svj
 Psu1GpgJ4nJJleU9QYguvIb21pmLfELYrcaP4XHtl4R56/KOOAnpPKt+o
X-Gm-Gg: ASbGnctWnxAlN/j4MNOFe9czd4T2j45xHPN1flqnW3muuFL0UlgfVskW5T4hpLYwbB+
 IYv20oqaCVE9RLIKY6B9r+55VnhbQt3RCcZtimQ1Kc6lr10I/1Yqemt+5l1kvzp6KDf2oqoobsH
 ZW5VJIB8CkURg5pSK/ixdO+16zSaDZjq+FUPU+KRQBo1RIdxWTVjaEvji1N3N71AEUURCiib5bv
 fq1rhXHvn3leORRrXqaq8DXrEZG2PsekEBPv3nvqy+y3CNGFfUEy2Pso0tktEdYe+5vpA6tUY3z
 LYwLuYpdFRQNfCEquPr3TTCaxQNzxUjnNGmSmuRpeAZKRhf9+P1zhYDEI9WV+ywusWuDXeRGncx
 Cs1xN84Dy6Ws=
X-Received: by 2002:a05:600c:4748:b0:45b:43cc:e557 with SMTP id
 5b1f17b1804b1-45b4d85ceebmr10903205e9.34.1755766209638; 
 Thu, 21 Aug 2025 01:50:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE909W4sP0t2MC23BKoJkM3w1AuIbB0VuoiTOHW4mSHbSgGm8CHB9uE6ZsYKwSvqOjkZZ28RQ==
X-Received: by 2002:a05:600c:4748:b0:45b:43cc:e557 with SMTP id
 5b1f17b1804b1-45b4d85ceebmr10902795e9.34.1755766209084; 
 Thu, 21 Aug 2025 01:50:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b4de5b52esm18416025e9.20.2025.08.21.01.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Aug 2025 01:50:08 -0700 (PDT)
Message-ID: <5ebbfbde-cf12-4bf8-b01a-253ea4ed5dee@redhat.com>
Date: Thu, 21 Aug 2025 10:50:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/20] intel_iommu: Enable stage-1 translation for
 passthrough device
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
 <DS4PPF93A1BBECD1D6A6FEA7C800E6EDD069232A@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
 <5d3d46b3-ce2d-455a-b8bd-57213f9ea093@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <5d3d46b3-ce2d-455a-b8bd-57213f9ea093@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 8/21/25 10:50 AM, Yi Liu wrote:
> On 2025/8/21 15:19, Duan, Zhenzhong wrote:
>> Kindly ping, any more comments?
>
> Do you have enough comments for a new version. I plan to have a look
> either this version or a new version next week. :)
same for me ;-)

Eric
>
> Regards,
> Yi Liu
>
>> Thanks
>> Zhenzhong
>>
>>> -----Original Message-----
>>> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>>> Subject: [PATCH v4 00/20] intel_iommu: Enable stage-1 translation for
>>> passthrough device
>>>
>>> Hi,
>>>
>>> For passthrough device with intel_iommu.x-flts=on, we don't do
>>> shadowing
>>> of
>>> guest page table for passthrough device but pass stage-1 page table
>>> to host
>>> side to construct a nested domain. There was some effort to enable this
>>> feature
>>> in old days, see [1] for details.
>>>
>>> The key design is to utilize the dual-stage IOMMU translation (also
>>> known as
>>> IOMMU nested translation) capability in host IOMMU. As the below
>>> diagram
>>> shows,
>>> guest I/O page table pointer in GPA (guest physical address) is
>>> passed to host
>>> and be used to perform the stage-1 address translation. Along with it,
>>> modifications to present mappings in the guest I/O page table should be
>>> followed
>>> with an IOTLB invalidation.
>>>
>>>         .-------------.  .---------------------------.
>>>         |   vIOMMU    |  | Guest I/O page table      |
>>>         |             |  '---------------------------'
>>>         .----------------/
>>>         | PASID Entry |--- PASID cache flush --+
>>>         '-------------'                        |
>>>         |             |                        V
>>>         |             |           I/O page table pointer in GPA
>>>         '-------------'
>>>     Guest
>>>     ------| Shadow |---------------------------|--------
>>>           v        v                           v
>>>     Host
>>>         .-------------.  .------------------------.
>>>         |   pIOMMU    |  | Stage1 for GIOVA->GPA  |
>>>         |             |  '------------------------'
>>>         .----------------/  |
>>>         | PASID Entry |     V (Nested xlate)
>>>         '----------------\.--------------------------------------.
>>>         |             |   | Stage2 for GPA->HPA, unmanaged domain|
>>>         |             |   '--------------------------------------'
>>>         '-------------'
>>> For history reason, there are different namings in different VTD
>>> spec rev,
>>> Where:
>>> - Stage1 = First stage = First level = flts
>>> - Stage2 = Second stage = Second level = slts
>>> <Intel VT-d Nested translation>
>>>
>>> This series reuse VFIO device's default hwpt as nested parent
>>> instead of
>>> creating new one. This way avoids duplicate code of a new memory
>>> listener,
>>> all existing feature from VFIO listener can be shared, e.g., ram
>>> discard,
>>> dirty tracking, etc. Two limitations are: 1) not supporting VFIO device
>>> under a PCI bridge with emulated device, because emulated device wants
>>> IOMMU AS and VFIO device stick to system AS; 2) not supporting kexec or
>>> reboot from "intel_iommu=on,sm_on" to "intel_iommu=on,sm_off", because
>>> VFIO device's default hwpt is created with NEST_PARENT flag, kernel
>>> inhibit RO mappings when switch to shadow mode.
>>>
>>> This series is also a prerequisite work for vSVA, i.e. Sharing guest
>>> application address space with passthrough devices.
>>>
>>> There are some interactions between VFIO and vIOMMU
>>> * vIOMMU registers PCIIOMMUOps [set|unset]_iommu_device to PCI
>>>   subsystem. VFIO calls them to register/unregister HostIOMMUDevice
>>>   instance to vIOMMU at vfio device realize stage.
>>> * vIOMMU registers PCIIOMMUOps get_viommu_cap to PCI subsystem.
>>>   VFIO calls it to get vIOMMU exposed capabilities.
>>> * vIOMMU calls HostIOMMUDeviceIOMMUFD interface [at|de]tach_hwpt
>>>   to bind/unbind device to IOMMUFD backed domains, either nested
>>>   domain or not.
>>>
>>> See below diagram:
>>>
>>>         VFIO Device                                 Intel IOMMU
>>>     .-----------------.                         .-------------------.
>>>     |                 |                         |
>>> |
>>>     |       .---------|PCIIOMMUOps              |.-------------.    |
>>>     |       | IOMMUFD |(set/unset_iommu_device) || Host IOMMU  |
>>> |
>>>     |       | Device  |------------------------>|| Device list |    |
>>>     |       .---------|(get_viommu_cap)         |.-------------.    |
>>>     |                 |                         |       |
>>> |
>>>     |                 |                         |       V
>>> |
>>>     |       .---------|  HostIOMMUDeviceIOMMUFD |  .-------------.  |
>>>     |       | IOMMUFD |            (attach_hwpt)|  | Host IOMMU
>>> |  |
>>>     |       | link    |<------------------------|  |   Device    |  |
>>>     |       .---------|            (detach_hwpt)|  .-------------.  |
>>>     |                 |                         |       |
>>> |
>>>     |                 |                         |       ...
>>> |
>>>     .-----------------.                         .-------------------.
>>>
>>> Below is an example to enable stage-1 translation for passthrough
>>> device:
>>>
>>>     -M q35,...
>>>     -device intel-iommu,x-scalable-mode=on,x-flts=on...
>>>     -object iommufd,id=iommufd0 -device vfio-pci,iommufd=iommufd0,...
>>>
>>> Test done:
>>> - VFIO devices hotplug/unplug
>>> - different VFIO devices linked to different iommufds
>>> - vhost net device ping test
>>>
>>> PATCH1-6:  Some preparing work
>>> PATCH7-8:  Compatibility check between vIOMMU and Host IOMMU
>>> PATCH9-17: Implement stage-1 page table for passthrough device
>>> PATCH18-19:Workaround for ERRATA_772415_SPR17
>>> PATCH20:   Enable stage-1 translation for passthrough device
>>>
>>> Qemu code can be found at [2]
>>>
>>> Fault report isn't supported in this series, we presume guest kernel
>>> always
>>> construct correct stage1 page table for passthrough device. For
>>> emulated
>>> devices, the emulation code already provided stage1 fault injection.
>>>
>>> TODO:
>>> - Fault report to guest when HW stage1 faults
>>>
>>> [1]
>>> https://patchwork.kernel.org/project/kvm/cover/20210302203827.437645-1
>>> -yi.l.liu@intel.com/
>>> [2] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting.v4
>>>
>>> Thanks
>>> Zhenzhong
>>>
>>> Changelog:
>>> v4:
>>> - s/VIOMMU_CAP_STAGE1/VIOMMU_CAP_HW_NESTED (Eric, Nicolin,
>>> Donald, Shameer)
>>> - clarify get_viommu_cap() return pure emulated caps and explain
>>> reason in
>>> commit log (Eric)
>>> - retrieve the ce only if vtd_as->pasid in
>>> vtd_as_to_iommu_pasid_locked (Eric)
>>> - refine doc comment and commit log in patch10-11 (Eric)
>>>
>>> v3:
>>> - define enum type for VIOMMU_CAP_* (Eric)
>>> - drop inline flag in the patch which uses the helper (Eric)
>>> - use extract64 in new introduced MACRO (Eric)
>>> - polish comments and fix typo error (Eric)
>>> - split workaround patch for ERRATA_772415_SPR17 to two patches (Eric)
>>> - optimize bind/unbind error path processing
>>>
>>> v2:
>>> - introduce get_viommu_cap() to get STAGE1 flag to create nested parent
>>> hwpt (Liuyi)
>>> - reuse VFIO's default hwpt as parent hwpt of nested translation
>>> (Nicolin,
>>> Liuyi)
>>> - abandon support of VFIO device under pcie-to-pci bridge to
>>> simplify design
>>> (Liuyi)
>>> - bypass RO mapping in VFIO's default hwpt if ERRATA_772415_SPR17
>>> (Liuyi)
>>> - drop vtd_dev_to_context_entry optimization (Liuyi)
>>>
>>> v1:
>>> - simplify vendor specific checking in vtd_check_hiod (Cedric, Nicolin)
>>> - rebase to master
>>>
>>> rfcv3:
>>> - s/hwpt_id/id in iommufd_backend_invalidate_cache()'s parameter
>>> (Shameer)
>>> - hide vtd vendor specific caps in a wrapper union (Eric, Nicolin)
>>> - simplify return value check of get_cap() (Eric)
>>> - drop realize_late (Cedric, Eric)
>>> - split patch13:intel_iommu: Add PASID cache management infrastructure
>>> (Eric)
>>> - s/vtd_pasid_cache_reset/vtd_pasid_cache_reset_locked (Eric)
>>> - s/vtd_pe_get_domain_id/vtd_pe_get_did (Eric)
>>> - refine comments (Eric, Donald)
>>>
>>> rfcv2:
>>> - Drop VTDPASIDAddressSpace and use VTDAddressSpace (Eric, Liuyi)
>>> - Move HWPT uAPI patches ahead(patch1-8) so arm nesting could easily
>>> rebase
>>> - add two cleanup patches(patch9-10)
>>> - VFIO passes iommufd/devid/hwpt_id to vIOMMU instead of
>>> iommufd/devid/ioas_id
>>> - add vtd_as_[from|to]_iommu_pasid() helper to translate between vtd_as
>>> and
>>>   iommu pasid, this is important for dropping VTDPASIDAddressSpace
>>>
>>>
>>> Yi Liu (3):
>>>   intel_iommu: Replay pasid bindings after context cache invalidation
>>>   intel_iommu: Propagate PASID-based iotlb invalidation to host
>>>   intel_iommu: Replay all pasid bindings when either SRTP or TE bit is
>>>     changed
>>>
>>> Zhenzhong Duan (17):
>>>   intel_iommu: Rename vtd_ce_get_rid2pasid_entry to
>>>     vtd_ce_get_pasid_entry
>>>   hw/pci: Introduce pci_device_get_viommu_cap()
>>>   intel_iommu: Implement get_viommu_cap() callback
>>>   vfio/iommufd: Force creating nested parent domain
>>>   hw/pci: Export pci_device_get_iommu_bus_devfn() and return bool
>>>   intel_iommu: Introduce a new structure VTDHostIOMMUDevice
>>>   intel_iommu: Check for compatibility with IOMMUFD backed device when
>>>     x-flts=on
>>>   intel_iommu: Fail passthrough device under PCI bridge if x-flts=on
>>>   intel_iommu: Introduce two helpers vtd_as_from/to_iommu_pasid_locked
>>>   intel_iommu: Handle PASID entry removal and update
>>>   intel_iommu: Handle PASID entry addition
>>>   intel_iommu: Introduce a new pasid cache invalidation type
>>> FORCE_RESET
>>>   intel_iommu: Stick to system MR for IOMMUFD backed host device when
>>>     x-fls=on
>>>   intel_iommu: Bind/unbind guest page table to host
>>>   vfio: Add a new element bypass_ro in VFIOContainerBase
>>>   Workaround for ERRATA_772415_SPR17
>>>   intel_iommu: Enable host device when x-flts=on in scalable mode
>>>
>>> MAINTAINERS                           |   1 +
>>> hw/i386/intel_iommu_internal.h        |  68 +-
>>> include/hw/i386/intel_iommu.h         |   9 +-
>>> include/hw/iommu.h                    |  17 +
>>> include/hw/pci/pci.h                  |  27 +
>>> include/hw/vfio/vfio-container-base.h |   1 +
>>> hw/i386/intel_iommu.c                 | 941
>>> +++++++++++++++++++++++++-
>>> hw/pci/pci.c                          |  23 +-
>>> hw/vfio/iommufd.c                     |  22 +-
>>> hw/vfio/listener.c                    |  13 +-
>>> hw/i386/trace-events                  |   8 +
>>> 11 files changed, 1088 insertions(+), 42 deletions(-)
>>> create mode 100644 include/hw/iommu.h
>>>
>>>
>>> base-commit: 92c05be4dfb59a71033d4c57dac944b29f7dabf0
>>> -- 
>>> 2.47.1
>>
>


