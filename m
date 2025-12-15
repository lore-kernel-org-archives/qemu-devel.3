Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF571D5B16E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 14:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV9D6-0000ak-Up; Mon, 15 Dec 2025 09:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vV9Ca-0000XZ-NK
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 09:05:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vV9CS-00009j-Rq
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 09:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765807516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Xy7+PI6yiNwB5fEYVMvqhnyWmh89c3B5Z0OfCD4J5l0=;
 b=hcABVkXsqMKp47OH+48GvCDkCeYylqTSCi29+3kwC37ItqwDKoR2rgtNE7ugzXVNd+pC/6
 ZlBjFlTQ+DrW70R/e7XWJjNO071THsmUzcZc0H3ZW9b3wFue5pAm2OSjHys3Gsw7n0ZyP4
 /PltlHJkdpGvB6m4X5I4m1eKKgpmMxA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-rqadpCDJOSG8V4c4lirRLw-1; Mon, 15 Dec 2025 09:05:14 -0500
X-MC-Unique: rqadpCDJOSG8V4c4lirRLw-1
X-Mimecast-MFC-AGG-ID: rqadpCDJOSG8V4c4lirRLw_1765807513
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430f825d4d2so928775f8f.2
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 06:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765807513; x=1766412313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Xy7+PI6yiNwB5fEYVMvqhnyWmh89c3B5Z0OfCD4J5l0=;
 b=GEk3pB6U7dGhMeHm2KGrcVj/kD6HxKLZw53gVZfz1nd2xO8QTOxNonx5SgJZeWbK6M
 bfttUS7xxZTnC9ocd0Sb5YVSU+nfcjpHU+GfPLnumDXnOIAKs017tjbBArKLyiM/9HKD
 j6Jvh0BHzx3lywu+EJcgghV6K0qFxGWs+nhqj17GZBSo2++6HAnAVZLJcp586UVFskjG
 f29qS2zISqZIbCYnh2hWIOfDPufQFZs/xudy6f+svkykYeBzqpG6wTSyMlzgN2CqhD2/
 9cX4mBlt8xyVIibiCjIjqLuNGIvxM7k0+RNN2x00iWE6Lm/EJvZsL2xij794wKFhgaMM
 sQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765807513; x=1766412313;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xy7+PI6yiNwB5fEYVMvqhnyWmh89c3B5Z0OfCD4J5l0=;
 b=tvCFFy9LmxtS2ABQcGtBXa1HbYRR2XH3Y1anHy4YNwPA+5s3Ulwl6oYSpGnJA4vffv
 4QyQr3Qf+Mz0DjknkHaqDIAq/hu1pVWcqSZiLZ82vdrDC+UdxNyrD4fbjw0sLHhZKXLs
 qXUAoGm27bY0LiaQKsr/ypiMjJKIzzX5qa+mdP+yrPTLAulaM9+wGMeYaJS4/ctWmXy8
 /hTDhuqwMOCkk1i8DMwPK30IgyMP0HeyT7FXN6ld2gtWB/eMI4qG3gB/0eb0ZdAQ6kpn
 nb8V2aSlf9GpxF0cHtnWlcWyfhubu9PvosOBLTWq8nCMl9ZaCh/O0YfK9/VKW7E+dRou
 PlDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA0JeujxMf9fveppoHj0QZl0DZKB/gkSw3pp33yOEnJ7X25Wb/3GFvRCeO/etLPsdxa2DYUAPEXdtS@nongnu.org
X-Gm-Message-State: AOJu0Ywx3joUY0G4V4xevxxKfvtu+fSylkkkRsEdECdQ0H8vgikwW0cp
 2M83XhboXFFQS/2AvGOQ+Gts2AB8qjGMDU5EPMI45sspTl1bod7qVQMPlFjkUqTD1SoXBYWXEBm
 /SJ9Gfn7feS3goDr1fajt2t8sYqo4mY2j9L6HDxgih4a+wJHgo2JYlYvg
X-Gm-Gg: AY/fxX66w4deQc1kFM8s/eN5oTS4GtP7+pkmCoqsMwVZcgFoiJcjxqrE4peUa6G8Etv
 nnuYMxMnODL6tjomEmGugPUnhWwZY+lZ/LMpZ6Fe08CpaJLQjfrZctra234bGlw2T3MkjLS4AuS
 6mu1uUiySASEh7QaPwSR+2aj2RziR0UGID92CADZbg5sMF790u84CGrKKvaQTg+pt0e2dSs5eid
 PgWK09tQQ/cs3q51xd3TIF9pIZzocIq/WSTGh+vJXOMF8XLPbIRlp5QHvtiW1bc7MSpw5ZikI7l
 6nVLrxoeBPaLCN3siYzM0zYVNs0mUTR3RJnFgiBVedYpXH6KUSLRuol89z+ZzijLvavjB5Ro2gX
 6I3pwqqcOB7x90yWmyVJdnhW2YZ4YlXHLG7/rFf11QVgmCJIl
X-Received: by 2002:a05:6000:26d3:b0:430:fc5a:40ac with SMTP id
 ffacd0b85a97d-430fc5a456amr4878306f8f.54.1765807512822; 
 Mon, 15 Dec 2025 06:05:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEpflMTQMr005OAy51btXJBdI4nWS3ZG2dcnovTOvU70R89iXq8cPkQyAFVEd5mm41nhK6rQ==
X-Received: by 2002:a05:6000:26d3:b0:430:fc5a:40ac with SMTP id
 ffacd0b85a97d-430fc5a456amr4878231f8f.54.1765807512231; 
 Mon, 15 Dec 2025 06:05:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b85d1esm29831555f8f.26.2025.12.15.06.05.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 06:05:11 -0800 (PST)
Message-ID: <56e582e7-d14c-46f6-b2cb-4a328315d505@redhat.com>
Date: Mon, 15 Dec 2025 15:05:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/19] intel_iommu: Enable first stage translation for
 passthrough device
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251215065046.86991-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251215065046.86991-1-zhenzhong.duan@intel.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Zhenzhong

On 12/15/25 07:50, Zhenzhong Duan wrote:
> Hi,
> 
> Based on Cédric's suggestions[1], The nesting series v8 is split to
> "base nesting series" + "ERRATA_772415_SPR17 quirk series", this is the
> base nesting series.
> 
> For passthrough device with intel_iommu.x-flts=on, we don't do shadowing of
> guest page table but pass first stage page table to host side to construct a
> nested HWPT. There was some effort to enable this feature in old days, see
> [2] for details.
> 
> The key design is to utilize the dual-stage IOMMU translation (also known as
> IOMMU nested translation) capability in host IOMMU. As the below diagram shows,
> guest I/O page table pointer in GPA (guest physical address) is passed to host
> and be used to perform the first stage address translation. Along with it,
> modifications to present mappings in the guest I/O page table should be followed
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
>          .-------------.  .-----------------------------.
>          |   pIOMMU    |  | First stage for GIOVA->GPA  |
>          |             |  '-----------------------------'
>          .----------------/  |
>          | PASID Entry |     V (Nested xlate)
>          '----------------\.--------------------------------------------.
>          |             |   | Second stage for GPA->HPA, unmanaged domain|
>          |             |   '--------------------------------------------'
>          '-------------'
> <Intel VT-d Nested translation>
> 
> This series reuse VFIO device's default HWPT as nesting parent instead of
> creating new one. This way avoids duplicate code of a new memory listener,
> all existing feature from VFIO listener can be shared, e.g., ram discard,
> dirty tracking, etc. Two limitations are: 1) not supporting VFIO device
> under a PCI bridge with emulated device, because emulated device wants
> IOMMU AS and VFIO device stick to system AS; 2) not supporting kexec or
> reboot from "intel_iommu=on,sm_on" to "intel_iommu=on,sm_off" on platform
> with ERRATA_772415_SPR17, because VFIO device's default HWPT is created
> with NEST_PARENT flag, kernel inhibit RO mappings when switch to shadow
> mode.
> 
> This series is also a prerequisite work for vSVA, i.e. Sharing guest
> application address space with passthrough devices.
> 
> There are some interactions between VFIO and vIOMMU
> * vIOMMU registers PCIIOMMUOps [set|unset]_iommu_device to PCI
>    subsystem. VFIO calls them to register/unregister HostIOMMUDevice
>    instance to vIOMMU at vfio device realize stage.
> * vIOMMU registers PCIIOMMUOps get_viommu_flags to PCI subsystem.
>    VFIO calls it to get vIOMMU exposed flags.
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
>      |       | IOMMUFD |(set/unset_iommu_device) || Host IOMMU  |    |
>      |       | Device  |------------------------>|| Device list |    |
>      |       .---------|(get_viommu_flags)       |.-------------.    |
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
> Below is an example to enable first stage translation for passthrough device:
> 
>      -M q35,...
>      -device intel-iommu,x-scalable-mode=on,x-flts=on...
>      -object iommufd,id=iommufd0 -device vfio-pci,iommufd=iommufd0,...

What about libvirt support ? There are patches to enable IOMMUFD
support with device assignment but I don't see anything related
to first stage translation. Is there a plan ?

This raises a question. Should ftls support be automatically enabled
based on the availability of an IOMMUFD backend ?
  
> 
> Test done:
> - VFIO devices hotplug/unplug
> - different VFIO devices linked to different iommufds
> - vhost net device ping test
> - migration with QAT passthrough

Did you do any experiments with active mlx5 VFs ?

Thanks,

C.


> PATCH01-08: Some preparing work
> PATCH09-10: Compatibility check between vIOMMU and Host IOMMU
> PATCH11-16: Implement first stage translation for passthrough device
> PATCH17:    Add migration support and optimization
> PATCH18:    Enable first stage translation for passthrough device
> PATCH19:    Add doc
> 
> Qemu code can be found at [3], it's based on vfio-next.
> 
> Fault event injection to guest isn't supported in this series, we presume guest
> kernel always construct correct first stage page table for passthrough device.
> For emulated devices, the emulation code already provided first stage fault
> injection.
> 
> TODO:
> - Fault event injection to guest when HW first stage page table faults
> 
> [1] https://lore.kernel.org/qemu-devel/bbc8412b-25c3-4c95-9fde-a1c9c29b54ce@redhat.com/
> [2] https://patchwork.kernel.org/project/kvm/cover/20210302203827.437645-1-yi.l.liu@intel.com/
> [3] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting.v9
> 
> Thanks
> Zhenzhong
> 
> Changelog:
> v9:
> - split v8 to base nesting series + ERRATA_772415_SPR17 series (Cédric)
> - s/fs_hwpt/fs_hwpt_id, s/vtd_bind_guest_pasid/vtd_propagate_guest_pasid (Eric)
> - polish error msg when CONFIG_VTD_ACCEL isn't defined (Eric)
> - refactor hwpt_id assignment in vtd_device_attach_iommufd() (Eric)
> 
> v8:
> - add hw/i386/intel_iommu_accel.[hc] to hold accel code (Eric)
> - return bool for all vtd accel related functions (Cédric, Eric)
> - introduce a new PCIIOMMUOps::get_host_iommu_quirks() (Eric, Nicolin)
> - minor polishment to comment and code (Cédric, Eric)
> - drop some R-b as they have changes needing review again
> 
> v7:
> - s/host_iommu_extract_vendor_caps/host_iommu_extract_quirks (Nicolin)
> - s/RID_PASID/PASID_0 (Eric)
> - drop rid2pasid check in vtd_do_iommu_translate (Eric)
> - refine DID check in vtd_pasid_cache_sync_locked (Liuyi)
> - refine commit log (Nicolin, Eric, Liuyi)
> - Fix doc build (Cédric)
> - add migration support
> 
> v6:
> - delete RPS capability related supporting code (Eric, Yi)
> - use terminology 'first/second stage' to replace 'first/second level" (Eric, Yi)
> - use get_viommu_flags() instead of get_viommu_caps() (Nicolin)
> - drop non-RID_PASID related code and simplify pasid invalidation handling (Eric, Yi)
> - drop the patch that handle pasid replay when context invalidation (Eric)
> - move vendor specific cap check from VFIO core to backend/iommufd.c (Nicolin)
> 
> v5:
> - refine commit log of patch2 (Cédric, Nicolin)
> - introduce helper vfio_pci_from_vfio_device() (Cédric)
> - introduce helper vfio_device_viommu_get_nested() (Cédric)
> - pass 'bool bypass_ro' argument to vfio_listener_valid_section() instead of 'VFIOContainerBase *' (Cédric)
> - fix a potential build error reported by Jim Shu
> 
> v4:
> - s/VIOMMU_CAP_STAGE1/VIOMMU_CAP_HW_NESTED (Eric, Nicolin, Donald, Shameer)
> - clarify get_viommu_cap() return pure emulated caps and explain reason in commit log (Eric)
> - retrieve the ce only if vtd_as->pasid in vtd_as_to_iommu_pasid_locked (Eric)
> - refine doc comment and commit log in patch10-11 (Eric)
> 
> v3:
> - define enum type for VIOMMU_CAP_* (Eric)
> - drop inline flag in the patch which uses the helper (Eric)
> - use extract64 in new introduced MACRO (Eric)
> - polish comments and fix typo error (Eric)
> - split workaround patch for ERRATA_772415_SPR17 to two patches (Eric)
> - optimize bind/unbind error path processing
> 
> v2:
> - introduce get_viommu_cap() to get STAGE1 flag to create nesting parent HWPT (Liuyi)
> - reuse VFIO's default HWPT as parent HWPT of nested translation (Nicolin, Liuyi)
> - abandon support of VFIO device under pcie-to-pci bridge to simplify design (Liuyi)
> - bypass RO mapping in VFIO's default HWPT if ERRATA_772415_SPR17 (Liuyi)
> - drop vtd_dev_to_context_entry optimization (Liuyi)
> 
> v1:
> - simplify vendor specific checking in vtd_check_hiod (Cédric, Nicolin)
> - rebase to master
> 
> 
> Yi Liu (3):
>    intel_iommu_accel: Propagate PASID-based iotlb invalidation to host
>    intel_iommu: Replay all pasid bindings when either SRTP or TE bit is
>      changed
>    intel_iommu: Replay pasid bindings after context cache invalidation
> 
> Zhenzhong Duan (16):
>    intel_iommu: Rename vtd_ce_get_rid2pasid_entry to
>      vtd_ce_get_pasid_entry
>    intel_iommu: Delete RPS capability related supporting code
>    intel_iommu: Update terminology to match VTD spec
>    hw/pci: Export pci_device_get_iommu_bus_devfn() and return bool
>    hw/pci: Introduce pci_device_get_viommu_flags()
>    intel_iommu: Implement get_viommu_flags() callback
>    intel_iommu: Introduce a new structure VTDHostIOMMUDevice
>    vfio/iommufd: Force creating nesting parent HWPT
>    intel_iommu_accel: Check for compatibility with IOMMUFD backed device
>      when x-flts=on
>    intel_iommu_accel: Fail passthrough device under PCI bridge if
>      x-flts=on
>    intel_iommu_accel: Stick to system MR for IOMMUFD backed host device
>      when x-flts=on
>    intel_iommu: Add some macros and inline functions
>    intel_iommu_accel: Bind/unbind guest page table to host
>    intel_iommu: Add migration support with x-flts=on
>    intel_iommu: Enable host device when x-flts=on in scalable mode
>    docs/devel: Add IOMMUFD nesting documentation
> 
>   MAINTAINERS                    |   2 +
>   docs/devel/vfio-iommufd.rst    |  17 ++
>   hw/i386/intel_iommu_accel.h    |  51 ++++
>   hw/i386/intel_iommu_internal.h | 155 +++++++---
>   include/hw/i386/intel_iommu.h  |   6 +-
>   include/hw/iommu.h             |  25 ++
>   include/hw/pci/pci.h           |  24 ++
>   include/hw/vfio/vfio-device.h  |   2 +
>   hw/i386/intel_iommu.c          | 528 +++++++++++++++++++--------------
>   hw/i386/intel_iommu_accel.c    | 251 ++++++++++++++++
>   hw/pci/pci.c                   |  23 +-
>   hw/vfio/device.c               |  12 +
>   hw/vfio/iommufd.c              |   9 +
>   tests/qtest/intel-iommu-test.c |   4 +-
>   hw/i386/Kconfig                |   5 +
>   hw/i386/meson.build            |   1 +
>   hw/i386/trace-events           |   4 +
>   17 files changed, 833 insertions(+), 286 deletions(-)
>   create mode 100644 hw/i386/intel_iommu_accel.h
>   create mode 100644 include/hw/iommu.h
>   create mode 100644 hw/i386/intel_iommu_accel.c
> 


