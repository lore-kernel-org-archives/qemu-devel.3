Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F282C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 19:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlBqD-0001Bx-J1; Thu, 20 Feb 2025 14:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlBq8-0001Be-SX
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 14:04:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tlBq6-00088p-L0
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 14:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740078239;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2srM+ImX4HK8jUyvI7ptpY1+Rk5obqep5AW0iyZInvU=;
 b=ZrQ7aQDjrDV7LgN06Ocq7JMKalkNH8uoM9Tk0SRK2+estyztjjOHysUBAiC72lR1LfbJQz
 nLZKhkeV8tSuA3gikXNdelEXUrgkfeN1au84ZBX5abmzT2537sH/TYIOTXJcmCsVvNhv4h
 VHrLC0POPfow2jbSgfkg/WYbpZhbpf0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-zqKYSOJdNdWV7k5zp2VVjQ-1; Thu, 20 Feb 2025 14:03:58 -0500
X-MC-Unique: zqKYSOJdNdWV7k5zp2VVjQ-1
X-Mimecast-MFC-AGG-ID: zqKYSOJdNdWV7k5zp2VVjQ_1740078237
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f443b4949so639227f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 11:03:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740078237; x=1740683037;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2srM+ImX4HK8jUyvI7ptpY1+Rk5obqep5AW0iyZInvU=;
 b=VzM/P/cv1xMLRhb0vCEV0g7VDtkjUqZMkz0ANUQnkAUXuXl8MRLModbR+kr9YCWBqi
 sq/0sUY3xq7O34B1QI/+tkdXA2vGUsGP8x9WDWxMHiX+HdtzVvDR7FWJ+0QTKFYoMN/Z
 8THFxilU7dMX+gF/V+esZS6FEyRCkJG9xeGKpj6T7rjBh8QembhnmpjY9Nk0UdQRW9bZ
 6LgTLpH3ojoqX7fwzJf2E5iU/3FIqZOIuqRq9j1CteXhxTa9g67sx7zmEg0W15lOMptA
 NjnPbLrB14md/rfjWKn23r3L06LnJM1gaq3hXn+dwxZV/6UxKTn95WV0ez22SDPbB2/Y
 hWTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwwAGzKwIB7FB0i/ll6fUP7Ds23WappowhDv2Z38FxCo9aFRomJgKSe0rdARH/UeecNDQtSzcDXk3h@nongnu.org
X-Gm-Message-State: AOJu0YyILeIF+FYoRmlCcse4rpIx0HvFrJzDpRdfUQ7aIeNcLGO0RZg2
 yp/s2q2zeGPd1PNk1zyg4Yi5MiU3i9pIRYGcVBSrlUriD4ogZy9gTh4pwy2a1rKNhuPjNfwM3hq
 XqoyW3fk+EB1XLlPbocQUpLotv0MuWvX3uC1uW2h+TdDz1feZzyJb
X-Gm-Gg: ASbGncsD4NBqF1ea4+PG6Si7wKgOAeS7RGMeibMJb6Tu6P4m6virQQ61fE8LDTJpRPA
 ICIZtYU36p3rTf9iiWkHmBbG29DnU8qBXoLsnMoIcRtwsZxg8bBFjTlsNbFl6CMQUVxJI4E/u+h
 2fIFFN9FQpFfjnzGhmLhBghEitiioKMBq0MNdShNAoTwOub52JtlkCGvKYVA8ATWW6z5uscoJFv
 6ivANlhfxsRWUzZG4u5/EbDu57HA7DmavRCfjlmmX+IRYxjvEO25pp1I5UqBEpPAY2WALln//cp
 KDinzhrT2ELuS4RfRkx2/bBetHWUjVZMulrybpVpGqRqN6xIDLnd
X-Received: by 2002:a5d:5847:0:b0:387:8752:5691 with SMTP id
 ffacd0b85a97d-38f6f0bde5emr262884f8f.47.1740078236690; 
 Thu, 20 Feb 2025 11:03:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBqkKOlzDFlEZFtBc8q2eUIWIFGSgIMG8JtpZwqav4rUTqBbqLWxtWb6R6y6WEXsNURCJNAw==
X-Received: by 2002:a5d:5847:0:b0:387:8752:5691 with SMTP id
 ffacd0b85a97d-38f6f0bde5emr262816f8f.47.1740078236048; 
 Thu, 20 Feb 2025 11:03:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f69b3ca41sm1697488f8f.27.2025.02.20.11.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 11:03:55 -0800 (PST)
Message-ID: <242f875d-a47c-4732-9f17-1a121e89b053@redhat.com>
Date: Thu, 20 Feb 2025 20:03:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 00/20] intel_iommu: Enable stage-1 translation for
 passthrough device
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi Zhenzhong

On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
> Hi,
>
> Per Jason Wang's suggestion, iommufd nesting series[1] is split into
> "Enable stage-1 translation for emulated device" series and
> "Enable stage-1 translation for passthrough device" series.
>
> This series is 2nd part focusing on passthrough device. We don't do
> shadowing of guest page table for passthrough device but pass stage-1
> page table to host side to construct a nested domain. There was some
> effort to enable this feature in old days, see [2] for details.
>
> The key design is to utilize the dual-stage IOMMU translation
> (also known as IOMMU nested translation) capability in host IOMMU.
> As the below diagram shows, guest I/O page table pointer in GPA
> (guest physical address) is passed to host and be used to perform
s/be/is
> the stage-1 address translation. Along with it, modifications to
> present mappings in the guest I/O page table should be followed
> with an IOTLB invalidation.
>
>         .-------------.  .---------------------------.
>         |   vIOMMU    |  | Guest I/O page table      |
>         |             |  '---------------------------'
>         .----------------/
>         | PASID Entry |--- PASID cache flush --+
>         '-------------'                        |
>         |             |                        V
>         |             |           I/O page table pointer in GPA
>         '-------------'
>     Guest
>     ------| Shadow |---------------------------|--------
>           v        v                           v
>     Host
>         .-------------.  .------------------------.
>         |   pIOMMU    |  |  FS for GIOVA->GPA     |
>         |             |  '------------------------'
>         .----------------/  |
>         | PASID Entry |     V (Nested xlate)
>         '----------------\.----------------------------------.
>         |             |   | SS for GPA->HPA, unmanaged domain|
>         |             |   '----------------------------------'
>         '-------------'
> Where:
>  - FS = First stage page tables
>  - SS = Second stage page tables
> <Intel VT-d Nested translation>
>
> There are some interactions between VFIO and vIOMMU
> * vIOMMU registers PCIIOMMUOps [set|unset]_iommu_device to PCI
>   subsystem. VFIO calls them to register/unregister HostIOMMUDevice
>   instance to vIOMMU at vfio device realize stage.
> * vIOMMU calls HostIOMMUDeviceIOMMUFD interface [at|de]tach_hwpt
>   to bind/unbind device to IOMMUFD backed domains, either nested
>   domain or not.
>
> See below diagram:
>
>         VFIO Device                                 Intel IOMMU
>     .-----------------.                         .-------------------.
>     |                 |                         |                   |
>     |       .---------|PCIIOMMUOps              |.-------------.    |
>     |       | IOMMUFD |(set_iommu_device)       || Host IOMMU  |    |
>     |       | Device  |------------------------>|| Device list |    |
>     |       .---------|(unset_iommu_device)     |.-------------.    |
>     |                 |                         |       |           |
>     |                 |                         |       V           |
>     |       .---------|  HostIOMMUDeviceIOMMUFD |  .-------------.  |
>     |       | IOMMUFD |            (attach_hwpt)|  | Host IOMMU  |  |
>     |       | link    |<------------------------|  |   Device    |  |
>     |       .---------|            (detach_hwpt)|  .-------------.  |
>     |                 |                         |       |           |
>     |                 |                         |       ...         |
>     .-----------------.                         .-------------------.
>
> Based on Yi's suggestion, this design is optimal in sharing ioas/hwpt
> whenever possible and create new one on demand, also supports multiple
> iommufd objects and ERRATA_772415.
>
> E.g., Stage-2 page table could be shared by different devices if there
> is no conflict and devices link to same iommufd object, i.e. devices
> under same host IOMMU can share same stage-2 page table. If there is
> conflict, i.e. there is one device under non cache coherency mode
> which is different from others, it requires a separate stage-2 page
> table in non-CC mode.
>
> SPR platform has ERRATA_772415 which requires no readonly mappings
> in stage-2 page table. This series supports creating VTDIOASContainer
> with no readonly mappings. If there is a rare case that some IOMMUs
> on a multiple IOMMU host have ERRATA_772415 and others not, this
> design can still survive.
>
> See below example diagram for a full view:
>
>       IntelIOMMUState
>              |
>              V
>     .------------------.    .------------------.    .-------------------.
>     | VTDIOASContainer |--->| VTDIOASContainer |--->| VTDIOASContainer  |-->...
>     | (iommufd0,RW&RO) |    | (iommufd1,RW&RO) |    | (iommufd0,RW only)|
>     .------------------.    .------------------.    .-------------------.
>              |                       |                              |
>              |                       .-->...                        |
>              V                                                      V
>       .-------------------.    .-------------------.          .---------------.
>       |   VTDS2Hwpt(CC)   |--->| VTDS2Hwpt(non-CC) |-->...    | VTDS2Hwpt(CC) |-->...
>       .-------------------.    .-------------------.          .---------------.
>           |            |               |                            |
>           |            |               |                            |
>     .-----------.  .-----------.  .------------.              .------------.
>     | IOMMUFD   |  | IOMMUFD   |  | IOMMUFD    |              | IOMMUFD    |
>     | Device(CC)|  | Device(CC)|  | Device     |              | Device(CC) |
>     | (iommufd0)|  | (iommufd0)|  | (non-CC)   |              | (errata)   |
>     |           |  |           |  | (iommufd0) |              | (iommufd0) |
>     .-----------.  .-----------.  .------------.              .------------.
>
> This series is also a prerequisite work for vSVA, i.e. Sharing
> guest application address space with passthrough devices.
>
> To enable stage-1 translation, only need to add "x-scalable-mode=on,x-flts=on".
> i.e. -device intel-iommu,x-scalable-mode=on,x-flts=on...
>
> Passthrough device should use iommufd backend to work with stage-1 translation.
> i.e. -object iommufd,id=iommufd0 -device vfio-pci,iommufd=iommufd0,...
>
> If host doesn't support nested translation, qemu will fail with an unsupported
> report.

you're not mentioning lack of error reporting from HW S1 faults to
guests. Are there other deps missing?

Eric
>
> Test done:
> - VFIO devices hotplug/unplug
> - different VFIO devices linked to different iommufds
> - vhost net device ping test
>
> PATCH1-8:  Add HWPT-based nesting infrastructure support
> PATCH9-10: Some cleanup work
> PATCH11:   cap/ecap related compatibility check between vIOMMU and Host IOMMU
> PATCH12-19:Implement stage-1 page table for passthrough device
> PATCH20:   Enable stage-1 translation for passthrough device
>
> Qemu code can be found at [3]
>
> TODO:
> - RAM discard
> - dirty tracking on stage-2 page table
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02740.html
> [2] https://patchwork.kernel.org/project/kvm/cover/20210302203827.437645-1-yi.l.liu@intel.com/
> [3] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_rfcv2
>
> Thanks
> Zhenzhong
>
> Changelog:
> rfcv2:
> - Drop VTDPASIDAddressSpace and use VTDAddressSpace (Eric, Liuyi)
> - Move HWPT uAPI patches ahead(patch1-8) so arm nesting could easily rebase
> - add two cleanup patches(patch9-10)
> - VFIO passes iommufd/devid/hwpt_id to vIOMMU instead of iommufd/devid/ioas_id
> - add vtd_as_[from|to]_iommu_pasid() helper to translate between vtd_as and
>   iommu pasid, this is important for dropping VTDPASIDAddressSpace
>
> Yi Liu (3):
>   intel_iommu: Replay pasid binds after context cache invalidation
>   intel_iommu: Propagate PASID-based iotlb invalidation to host
>   intel_iommu: Refresh pasid bind when either SRTP or TE bit is changed
>
> Zhenzhong Duan (17):
>   backends/iommufd: Add helpers for invalidating user-managed HWPT
>   vfio/iommufd: Add properties and handlers to
>     TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>   HostIOMMUDevice: Introduce realize_late callback
>   vfio/iommufd: Implement HostIOMMUDeviceClass::realize_late() handler
>   vfio/iommufd: Implement [at|de]tach_hwpt handlers
>   host_iommu_device: Define two new capabilities
>     HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
>   iommufd: Implement query of HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
>   iommufd: Implement query of HOST_IOMMU_DEVICE_CAP_ERRATA
>   intel_iommu: Rename vtd_ce_get_rid2pasid_entry to
>     vtd_ce_get_pasid_entry
>   intel_iommu: Optimize context entry cache utilization
>   intel_iommu: Check for compatibility with IOMMUFD backed device when
>     x-flts=on
>   intel_iommu: Introduce a new structure VTDHostIOMMUDevice
>   intel_iommu: Add PASID cache management infrastructure
>   intel_iommu: Bind/unbind guest page table to host
>   intel_iommu: ERRATA_772415 workaround
>   intel_iommu: Bypass replay in stage-1 page table mode
>   intel_iommu: Enable host device when x-flts=on in scalable mode
>
>  hw/i386/intel_iommu_internal.h     |   56 +
>  include/hw/i386/intel_iommu.h      |   33 +-
>  include/system/host_iommu_device.h |   40 +
>  include/system/iommufd.h           |   53 +
>  backends/iommufd.c                 |   58 +
>  hw/i386/intel_iommu.c              | 1660 ++++++++++++++++++++++++----
>  hw/vfio/common.c                   |   17 +-
>  hw/vfio/iommufd.c                  |   48 +
>  backends/trace-events              |    1 +
>  hw/i386/trace-events               |   13 +
>  10 files changed, 1776 insertions(+), 203 deletions(-)
>


