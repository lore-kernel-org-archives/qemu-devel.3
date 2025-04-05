Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61B7C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 03:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0tnq-00017k-7S; Fri, 04 Apr 2025 23:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1u0tno-00017G-6L
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 23:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1u0tnl-0004WD-CB
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 23:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743822144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0S7lcN7XcxjFYRQlrqqK3gavPsr5w5g8Dke+nMOoY3M=;
 b=YeMVEVT9klW6cDzyqQRjKbizx8hbEBDhOR8+g/p4qIt9q4ycd35RgMsZzTpD/mKHcO07j3
 C+DO4D0i2pRAj1pRCnSSuyL5/dDZk6nlBd6M76AQCwtfVrPG6QkzpalxPBXLGxEO6lpiAc
 Mqa97KtLV72aw9HwAVkyAOwSpCgGKwQ=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-rSrk4Re0OAW_B3EYf7vFUw-1; Fri, 04 Apr 2025 23:02:23 -0400
X-MC-Unique: rSrk4Re0OAW_B3EYf7vFUw-1
X-Mimecast-MFC-AGG-ID: rSrk4Re0OAW_B3EYf7vFUw_1743822142
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-3d443811ed2so45513135ab.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 20:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743822142; x=1744426942;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0S7lcN7XcxjFYRQlrqqK3gavPsr5w5g8Dke+nMOoY3M=;
 b=fkgnJTFK7BeDdWaFYDrPjQ1IG8T1dWGmItGiRQia9qWY9YsbFwBf+ZmQgBqh6aqmgE
 R4PniG/8lNRx+Yb0c+t0nmEfFScXkvFKrZNDDgkXY37AVyx9frw/dwb5DBbser6s6uk2
 ESEywpAo59bUYH4i9n/y5w+JTYNr0V3NSLxs7LfDOfsgONnqpd2czTTIaqSNa9yEKkZN
 lly+sYwXxGcLa5PT6i+CJEgcNqNbYX7i3NwytsCQMuXt1EwWLXSeHNQzk0YYdr/821GX
 I6XvvX6tCk+9k3iyliRjDCzDPBtNGf6LLsRWsos0Kl0zAMpw2gSIrGQeoln5cIvFCHtu
 hH2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAd8Sri4t5alv5APR8fMsjJPRaX7y3Nv+Tv0cUvDNkzIRsyh8Bp8rxOwDmACyTNi6AHZmlIVQ8nGFI@nongnu.org
X-Gm-Message-State: AOJu0YwMPfi7axOv3Of1i6mme7IAwt0+lXLEuPrV6VCVxl11llY/nHtU
 bt79cxCywLGGg+O+dWcriQmOEoVgceishWMQe2jagZyynrzkOiok0DT5RLXSa5TY5PdAsF4+k6z
 nEsXZYMNy0GQNiLDmr1ZyuWBbM8W4ADEN7nL7WDHZGVB+6KKJtLUO
X-Gm-Gg: ASbGncvJZXMQxGuJD9uCbz43xL/g/xVdffzkK9zcj0KhjlhrIzUvg9nKP4hz+uXfTT0
 wuqWS1M8bbyCEx8P4d3Ovgd3B6KYnrmG5shUAfJ0gDC7n+QPALYW0njBGZ3BWNdLH/ZuQtT/yfQ
 7ni3bEDTpXotN5ACYCUtLQfPz/LbOB5v1AqJEAMev3CFF4EPKQcpqnxzJXEKLSgMJfZaimVPRdL
 cAebvLGMns4fjFXhpqCk5azDdWi6e6JyIfFpOtu08KpTHSQFJaFKoGu1OscbaGzxJAlZShbO/1a
 EuaA2wfgAHCEjtrY
X-Received: by 2002:a05:6e02:17c9:b0:3d4:6dcf:d8f5 with SMTP id
 e9e14a558f8ab-3d6ec52d0c9mr14987945ab.1.1743822142290; 
 Fri, 04 Apr 2025 20:02:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyjGtoSQ4cyMF2drx8U6ntjHk3JZSr7INYdgvys6N6TBJUntjx9JoFZDzB97TQ3gn/BoUQNw==
X-Received: by 2002:a05:6e02:17c9:b0:3d4:6dcf:d8f5 with SMTP id
 e9e14a558f8ab-3d6ec52d0c9mr14987725ab.1.1743822141816; 
 Fri, 04 Apr 2025 20:02:21 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d6de9731casm11152535ab.71.2025.04.04.20.02.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 20:02:21 -0700 (PDT)
Message-ID: <eacfc52a-2dee-49a8-8994-67b738ece68d@redhat.com>
Date: Fri, 4 Apr 2025 23:01:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 00/20] intel_iommu: Enable stage-1 translation for
 passthrough device
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Zhenzhong,

Hi!
Eric asked me to review this series.
Since it's rather late since you posted will summarize review feedback below/bottom.

- Don

On 2/19/25 3:22 AM, Zhenzhong Duan wrote:
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
> the stage-1 address translation. Along with it, modifications to
> present mappings in the guest I/O page table should be followed
> with an IOTLB invalidation.
> 
>          .-------------.  .---------------------------.
>          |   vIOMMU    |  | Guest I/O page table      |
>          |             |  '---------------------------'
>          .----------------/
>          | PASID Entry |--- PASID cache flush --+
>          '-------------'                        |
>          |             |                        V
>          |             |           I/O page table pointer in GPA
>          '-------------'
>      Guest
>      ------| Shadow |---------------------------|--------
>            v        v                           v
>      Host
>          .-------------.  .------------------------.
>          |   pIOMMU    |  |  FS for GIOVA->GPA     |
>          |             |  '------------------------'
>          .----------------/  |
>          | PASID Entry |     V (Nested xlate)
>          '----------------\.----------------------------------.
>          |             |   | SS for GPA->HPA, unmanaged domain|
>          |             |   '----------------------------------'
>          '-------------'
> Where:
>   - FS = First stage page tables
>   - SS = Second stage page tables
> <Intel VT-d Nested translation>
> 
I'd prefer the use of 's1' for stage1/First stage, and 's2' for stage2/second stage.
We don't need different terms for the same technology in the iommu/iommufd space(s).

> There are some interactions between VFIO and vIOMMU
> * vIOMMU registers PCIIOMMUOps [set|unset]_iommu_device to PCI
>    subsystem. VFIO calls them to register/unregister HostIOMMUDevice
>    instance to vIOMMU at vfio device realize stage.
> * vIOMMU calls HostIOMMUDeviceIOMMUFD interface [at|de]tach_hwpt
>    to bind/unbind device to IOMMUFD backed domains, either nested
>    domain or not.
> 
> See below diagram:
> 
>          VFIO Device                                 Intel IOMMU
>      .-----------------.                         .-------------------.
>      |                 |                         |                   |
>      |       .---------|PCIIOMMUOps              |.-------------.    |
>      |       | IOMMUFD |(set_iommu_device)       || Host IOMMU  |    |
>      |       | Device  |------------------------>|| Device list |    |
>      |       .---------|(unset_iommu_device)     |.-------------.    |
>      |                 |                         |       |           |
>      |                 |                         |       V           |
>      |       .---------|  HostIOMMUDeviceIOMMUFD |  .-------------.  |
>      |       | IOMMUFD |            (attach_hwpt)|  | Host IOMMU  |  |
>      |       | link    |<------------------------|  |   Device    |  |
>      |       .---------|            (detach_hwpt)|  .-------------.  |
>      |                 |                         |       |           |
>      |                 |                         |       ...         |
>      .-----------------.                         .-------------------.
> 
> Based on Yi's suggestion, this design is optimal in sharing ioas/hwpt
> whenever possible and create new one on demand, also supports multiple
> iommufd objects and ERRATA_772415.
> 
> E.g., Stage-2 page table could be shared by different devices if there
> is no conflict and devices link to same iommufd object, i.e. devices
> under same host IOMMU can share same stage-2 page table. If there is
and 'devices under the same guest'.
Different guests cant be sharing the same stage-2 page tables.

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
>        IntelIOMMUState
>               |
>               V
>      .------------------.    .------------------.    .-------------------.
>      | VTDIOASContainer |--->| VTDIOASContainer |--->| VTDIOASContainer  |-->...
>      | (iommufd0,RW&RO) |    | (iommufd1,RW&RO) |    | (iommufd0,RW only)|
>      .------------------.    .------------------.    .-------------------.
>               |                       |                              |
>               |                       .-->...                        |
>               V                                                      V
>        .-------------------.    .-------------------.          .---------------.
>        |   VTDS2Hwpt(CC)   |--->| VTDS2Hwpt(non-CC) |-->...    | VTDS2Hwpt(CC) |-->...
>        .-------------------.    .-------------------.          .---------------.
>            |            |               |                            |
>            |            |               |                            |
>      .-----------.  .-----------.  .------------.              .------------.
>      | IOMMUFD   |  | IOMMUFD   |  | IOMMUFD    |              | IOMMUFD    |
>      | Device(CC)|  | Device(CC)|  | Device     |              | Device(CC) |
>      | (iommufd0)|  | (iommufd0)|  | (non-CC)   |              | (errata)   |
>      |           |  |           |  | (iommufd0) |              | (iommufd0) |
>      .-----------.  .-----------.  .------------.              .------------.
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
>    iommu pasid, this is important for dropping VTDPASIDAddressSpace
> 
> Yi Liu (3):
>    intel_iommu: Replay pasid binds after context cache invalidation
>    intel_iommu: Propagate PASID-based iotlb invalidation to host
>    intel_iommu: Refresh pasid bind when either SRTP or TE bit is changed
> 
> Zhenzhong Duan (17):
>    backends/iommufd: Add helpers for invalidating user-managed HWPT
>    vfio/iommufd: Add properties and handlers to
>      TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>    HostIOMMUDevice: Introduce realize_late callback
>    vfio/iommufd: Implement HostIOMMUDeviceClass::realize_late() handler
>    vfio/iommufd: Implement [at|de]tach_hwpt handlers
>    host_iommu_device: Define two new capabilities
>      HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
>    iommufd: Implement query of HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
>    iommufd: Implement query of HOST_IOMMU_DEVICE_CAP_ERRATA
>    intel_iommu: Rename vtd_ce_get_rid2pasid_entry to
>      vtd_ce_get_pasid_entry
>    intel_iommu: Optimize context entry cache utilization
>    intel_iommu: Check for compatibility with IOMMUFD backed device when
>      x-flts=on
>    intel_iommu: Introduce a new structure VTDHostIOMMUDevice
>    intel_iommu: Add PASID cache management infrastructure
>    intel_iommu: Bind/unbind guest page table to host
>    intel_iommu: ERRATA_772415 workaround
>    intel_iommu: Bypass replay in stage-1 page table mode
>    intel_iommu: Enable host device when x-flts=on in scalable mode
> 
>   hw/i386/intel_iommu_internal.h     |   56 +
>   include/hw/i386/intel_iommu.h      |   33 +-
>   include/system/host_iommu_device.h |   40 +
>   include/system/iommufd.h           |   53 +
>   backends/iommufd.c                 |   58 +
>   hw/i386/intel_iommu.c              | 1660 ++++++++++++++++++++++++----
>   hw/vfio/common.c                   |   17 +-
>   hw/vfio/iommufd.c                  |   48 +
>   backends/trace-events              |    1 +
>   hw/i386/trace-events               |   13 +
>   10 files changed, 1776 insertions(+), 203 deletions(-)
> 
Relative to the patches:
Patch 1: As Eric eluded to, a proper description for the patch should be written, and the title should change 'helpers' to 'helper'

Patch 2:
(1) Introduce 'realize_late()' interface, but leave the reader wondering 'ah, why? what?' ... after reading farther down the series, I learn more about realize_late(), but more on that later...
(2) For my education, can you provide ptrs to VFIO & VPDA code paths that demonstrate the need for different [at|de]tach_<>_hwpt()

Patch 3: Why can't the realize() be moved to after attach?  isn't realize() suppose to indicate 'all is setup and object can now be used' -- apologies for what could be a dumb question, as that's my understanding of realize().  If the argument is such that there needs to be two steps, how does the first realize() that put the object into a used state <somehow> wait until realize_late()?

Patch 4: Shouldn't the current/existing realize callback just be overwritten with the later one, when this is needed?

Patch 5: no issues.

Patch 6: ewww -- fs1gp ... we use underlines all over the place for multi-word elements; so how about 's1_1g_pg'
           -- how many places is that really used that multiple underlines is an issue?

Patch 7: intel-iommu-specific callbacks in the common vfio & iommufd-backend code; nack. This won't compile w/intel-iommu included with iommufd... I think backend, intel-iommu hw-caps should provide the generic 'caps' boolean-type values/states; ... and maybe they should be extracted via vfio? .... like
      case HOST_IOMMU_DEVICE_CAP_AW_BITS:
          return vfio_device_get_aw_bits(hiod->agent);

Patch 8: Again, VTD-specific code in IOMMUFD is a nack; again, maybe via vfio, or a direct call into an iommu-device-cap api.

Patch 9: no issues.

Patch 10: "except it's stale"  likely "except when it's entry is stale" ?
           Did you ever put some tracing in to capture avg hits in cache? ... if so, add as a comment.
           Otherwise, looks good.

Patch 11: Apologies, I don't know what 'flts' stands for, and why it is relative to 2-stage mapping, or SIOV.  Could you add verbage to explain the use of it, as the rest of this patch doesn't make any sense to me without the background.
The patch introduces hw-info-type (none or intel), and then goes on to add a large set of checks; seems like the caps & this checking should go together (split for each cap; put all caps together & the check...).

Patch 12: Why isn't HostIOMMUDevice extended to have another iommu-specif element, opaque in HostIOMMUDevice, but set to specific IOMMU in use?   e.g. void *hostiommustate;

Patch 13: Isn't PASID just an extension/addition of BDF id? and doesn't each PASID have its own address space?
So, why isn't it handle via a uniqe AS cache like 'any other device'?  Maybe I'm thinking too SMMU-StreamID, which can be varying length, depending on subsystem support.  I see what appears to be sid+pasid calls to do the AS lookups; hmm, so maybe this is the generalized BDF+pasid AS lookup?  if so, maybe a better description stating this transition to a wider stream-id would set the code context better.
As for the rest of the (400 intel-iommu) code, I'm not that in-depth in intel-iommu to determine if its all correct or not.

Patch 14: Define PGTT; the second paragraph seem self-contradicting -- it says it uses a 2-stage page table in each case, but it implies it should be different.  At 580 lines of code changes, you win! ;-)

Patch 15: Read-only and Read/write areas have different IOMMUFDs?  is that an intel-iommu requriement?
           At least this intel-iommu-errata code is only in hw/i386/<> modules.

Patch 16: Looks reasonable.  What does the 'SI' mean after "CACHE_DEV", "CACHE_DOM" & "CACHE_PASID" ? -- stream-invalidation?

Patch 17: Looks reasonable.

Patch 18: Looks good.

Patch 19: No comment; believe AlexW should weigh in on this change.

Patch 20: Looks good.

  

Patch 17:

Patch 14

Patch 14:
           


