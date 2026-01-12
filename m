Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50901CF45D4
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQ2A-0000Mq-MD; Mon, 12 Jan 2026 17:05:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vfQ28-0000M7-Vg
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:05:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vfQ26-0005Nj-P8
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768255504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1OJtsN1Ax7FVJGNYU0ajPQwRKVBqkPvkvEzJZ4QSG7I=;
 b=fpbxcw3YrKaeJ7IPLzLYW9S08gLst1q1nyfWXoOBCcMVzO1+m+xlAdtiSurfckyTkqrshW
 qk0dwCBmvoY1twk0TMeuAShv3yaw5EK9sJ+rcEEO1yrMXJkaQACIIt5Zwb3Ah1S3v8c1Xs
 kBx9rzjinppisZZpMTtltLGAwDh5YsQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-1RiEymMaMqCZXNex8QeGpw-1; Mon, 12 Jan 2026 17:05:02 -0500
X-MC-Unique: 1RiEymMaMqCZXNex8QeGpw-1
X-Mimecast-MFC-AGG-ID: 1RiEymMaMqCZXNex8QeGpw_1768255501
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4775d8428e8so56486235e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768255501; x=1768860301; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1OJtsN1Ax7FVJGNYU0ajPQwRKVBqkPvkvEzJZ4QSG7I=;
 b=LGGsUUAMKI5QwLeXnjGqg23hG2h3vCzikkbqDQFM78myRfAVVqnL/2Z40hn68Jxp0i
 Lyz48EDLSpg0QBAqtFHwA/Znl1fbOWPdEwBUZg46o+694SFQampfragSFw1uKEq/vSNJ
 dKz4XsiiNyLfuwho7X6joZR4NR73ZixlVQv3jKPP2h6Vpbrq4obnqwoLH+mPoJgHHzis
 m+qbr1BM99kSm9t6D4lROMGKMQ7OMg0DYdSsQPEcxOLEjXKcuOUCfmgibD1M3cOqwoLX
 lbN1ejFMTpkFPgZqpt884uRxmm3UrcyZxCyJ8TlL2kP/H9QvyoU5PZ8fmYAJZ0Sx3fjh
 2NSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768255501; x=1768860301;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1OJtsN1Ax7FVJGNYU0ajPQwRKVBqkPvkvEzJZ4QSG7I=;
 b=Gvse8NJsvph7BNAi6hpqkw7oReLTR/o0CqVAfWG2QWndaZ8CjhJ4++Q//NAiGwZp/l
 N2AAWlrj/kS31QUByvzdZ+Ir7E6xxo7A2X5oCC9oQ76Mq4f+pb5Qhh1LF+IMD7lPHNHT
 bMGu0JQHlUGuKBPY/Nm43mwhQ52UTahaFfkWowIP4jqskY1BZaHRk9KpRD5W4Af4b21V
 /RsKuVkVsaS+UF1Di4VWGyJggSC5Afalgj2CLcot6Mf63WjD0kWTnXJb6B0qcrEQs6EE
 pUtr8n1TDahhgt0/3UHgMOSQPhVZVgc3n+TejTjMZLqEAfoC7TKwfMAft6KeSwcP3LAZ
 9SoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2d8tEPfcZVzkDlIDOwMHYd6P8aHXTk3wjPbMveMKy+Qm/dc3g0FmSelzEaMThPQPRxQhU4I+RLyn8@nongnu.org
X-Gm-Message-State: AOJu0YzfnIGzlCs/qOFtectGQp2UCaoSWZgyUpglVhUW0KkycuS/hPBz
 iJfv1sFQrF3NSqM6zVMvtpIT6uQ/Vu2n7rSn2ilzDM47JUf76UJhqRiVJJq4StDyTnqVoDXVNlI
 5N8GZ7BraNZ+D+nV2h54Yki8Am/czVYr1zqBGuTzaz4xz2iYwVFmsA5V7
X-Gm-Gg: AY/fxX6H9S3b77QYkhMhXJdrlhimf0s5OHJy+FeQ+rWd3f5fnTce3JzLjUhieYBxHN8
 7e5jiNVYt4RMZ0xfHRm8hb0bPiXxY8YglaB138tJgbeveqtO9ciqL7CGRtzMl+lDC5gH9OjUXlE
 tNxY1ZSJNZnfer+nQmwHtuip41ucg1kQMCPh9kYViBB6DC9R1qRgAVbsPeyV08qBYIV84xmygLg
 AoSEklsQ82Hx2No1sfa7a/ywWphCVbFz6luyboi5UjAjrlzku6sz+TSBFdNKSmonOeJfz1smkPI
 Yyjci2X5q3fcIADy4ALR/bVa6CCPoTF6YMOTef5dvV8TFW1fKvXJ0ajXP+So9Pnsg0vlGdHNbCj
 TkdLj4r4DOHcqz5eVMvHSCgDcA2FIJgQ=
X-Received: by 2002:a05:600c:3493:b0:477:a54a:acba with SMTP id
 5b1f17b1804b1-47d84b33b86mr236502215e9.17.1768255501026; 
 Mon, 12 Jan 2026 14:05:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGp2diphYbJjPQeG/xQrQ/ULbFh1QOWIOAzNpURG3KTkj+wVL0KvRtANP3aoV8IQ0QOkSt5Ig==
X-Received: by 2002:a05:600c:3493:b0:477:a54a:acba with SMTP id
 5b1f17b1804b1-47d84b33b86mr236501795e9.17.1768255500494; 
 Mon, 12 Jan 2026 14:05:00 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f653c61sm379764895e9.10.2026.01.12.14.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 14:04:59 -0800 (PST)
Date: Mon, 12 Jan 2026 17:04:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 alex@shazbot.org, eric.auger@redhat.com, jasowang@redhat.com,
 peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v10 00/19] intel_iommu: Enable first stage translation
 for passthrough device
Message-ID: <20260112170421-mutt-send-email-mst@kernel.org>
References: <20260106061304.314546-1-zhenzhong.duan@intel.com>
 <a080e728-6754-4897-9531-61b875720b33@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a080e728-6754-4897-9531-61b875720b33@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Fri, Jan 09, 2026 at 03:34:48PM +0100, Cédric Le Goater wrote:
> Michael,
> 
> Since there are a couple of VFIO series depending on this one, do you mind
> if it goes through the VFIO queue ?
> 
> Thanks,
> 
> C.

Okay, I can drop it for now. Feel free to add:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> 
> 
> 
> On 1/6/26 07:12, Zhenzhong Duan wrote:
> > Hi,
> > 
> > Based on Cédric's suggestions[1], The nesting series v8 is split to
> > "base nesting series" + "ERRATA_772415_SPR17 quirk series", this is the
> > base nesting series.
> > 
> > For passthrough device with intel_iommu.x-flts=on, we don't do shadowing of
> > guest page table but pass first stage page table to host side to construct a
> > nested HWPT. There was some effort to enable this feature in old days, see
> > [2] for details.
> > 
> > The key design is to utilize the dual-stage IOMMU translation (also known as
> > IOMMU nested translation) capability in host IOMMU. As the below diagram shows,
> > guest I/O page table pointer in GPA (guest physical address) is passed to host
> > and be used to perform the first stage address translation. Along with it,
> > modifications to present mappings in the guest I/O page table should be followed
> > with an IOTLB invalidation.
> > 
> >          .-------------.  .---------------------------.
> >          |   vIOMMU    |  | Guest I/O page table      |
> >          |             |  '---------------------------'
> >          .----------------/
> >          | PASID Entry |--- PASID cache flush --+
> >          '-------------'                        |
> >          |             |                        V
> >          |             |           I/O page table pointer in GPA
> >          '-------------'
> >      Guest
> >      ------| Shadow |---------------------------|--------
> >            v        v                           v
> >      Host
> >          .-------------.  .-----------------------------.
> >          |   pIOMMU    |  | First stage for GIOVA->GPA  |
> >          |             |  '-----------------------------'
> >          .----------------/  |
> >          | PASID Entry |     V (Nested xlate)
> >          '----------------\.--------------------------------------------.
> >          |             |   | Second stage for GPA->HPA, unmanaged domain|
> >          |             |   '--------------------------------------------'
> >          '-------------'
> > <Intel VT-d Nested translation>
> > 
> > This series reuse VFIO device's default HWPT as nesting parent instead of
> > creating new one. This way avoids duplicate code of a new memory listener,
> > all existing feature from VFIO listener can be shared, e.g., ram discard,
> > dirty tracking, etc. Two limitations are: 1) not supporting VFIO device
> > under a PCI bridge with emulated device, because emulated device wants
> > IOMMU AS and VFIO device stick to system AS; 2) not supporting kexec or
> > reboot from "intel_iommu=on,sm_on" to "intel_iommu=on,sm_off" on platform
> > with ERRATA_772415_SPR17, because VFIO device's default HWPT is created
> > with NEST_PARENT flag, kernel inhibit RO mappings when switch to shadow
> > mode.
> > 
> > This series is also a prerequisite work for vSVA, i.e. Sharing guest
> > application address space with passthrough devices.
> > 
> > There are some interactions between VFIO and vIOMMU
> > * vIOMMU registers PCIIOMMUOps [set|unset]_iommu_device to PCI
> >    subsystem. VFIO calls them to register/unregister HostIOMMUDevice
> >    instance to vIOMMU at vfio device realize stage.
> > * vIOMMU registers PCIIOMMUOps get_viommu_flags to PCI subsystem.
> >    VFIO calls it to get vIOMMU exposed flags.
> > * vIOMMU calls HostIOMMUDeviceIOMMUFD interface [at|de]tach_hwpt
> >    to bind/unbind device to IOMMUFD backed domains, either nested
> >    domain or not.
> > 
> > See below diagram:
> > 
> >          VFIO Device                                 Intel IOMMU
> >      .-----------------.                         .-------------------.
> >      |                 |                         |                   |
> >      |       .---------|PCIIOMMUOps              |.-------------.    |
> >      |       | IOMMUFD |(set/unset_iommu_device) || Host IOMMU  |    |
> >      |       | Device  |------------------------>|| Device list |    |
> >      |       .---------|(get_viommu_flags)       |.-------------.    |
> >      |                 |                         |       |           |
> >      |                 |                         |       V           |
> >      |       .---------|  HostIOMMUDeviceIOMMUFD |  .-------------.  |
> >      |       | IOMMUFD |            (attach_hwpt)|  | Host IOMMU  |  |
> >      |       | link    |<------------------------|  |   Device    |  |
> >      |       .---------|            (detach_hwpt)|  .-------------.  |
> >      |                 |                         |       |           |
> >      |                 |                         |       ...         |
> >      .-----------------.                         .-------------------.
> > 
> > Below is an example to enable first stage translation for passthrough device:
> > 
> >      -M q35,...
> >      -device intel-iommu,x-scalable-mode=on,x-flts=on...
> >      -object iommufd,id=iommufd0 -device vfio-pci,iommufd=iommufd0,...
> > 
> > Test done:
> > - VFIO devices hotplug/unplug
> > - different VFIO devices linked to different iommufds
> > - vhost net device ping test
> > - migration with QAT passthrough
> > 
> > PATCH01-08: Some preparing work
> > PATCH09-10: Compatibility check between vIOMMU and Host IOMMU
> > PATCH11-16: Implement first stage translation for passthrough device
> > PATCH17:    Add migration support and optimization
> > PATCH18:    Enable first stage translation for passthrough device
> > PATCH19:    Add doc
> > 
> > Qemu code can be found at [3], it's based on master 159107e.
> > 
> > Fault event injection to guest isn't supported in this series, we presume guest
> > kernel always construct correct first stage page table for passthrough device.
> > For emulated devices, the emulation code already provided first stage fault
> > injection.
> > 
> > TODO:
> > - Fault event injection to guest when HW first stage page table faults
> > 
> > [1] https://lore.kernel.org/qemu-devel/bbc8412b-25c3-4c95-9fde-a1c9c29b54ce@redhat.com/
> > [2] https://patchwork.kernel.org/project/kvm/cover/20210302203827.437645-1-yi.l.liu@intel.com/
> > [3] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting.v10
> > 
> > Thanks
> > Zhenzhong
> > 
> > Changelog:
> > v10:
> > - All headers under include/hw/ have been moved to include/hw/core/, do
> >    the same for iommu.h (Cédric)
> > 
> > v9:
> > - split v8 to base nesting series + ERRATA_772415_SPR17 series (Cédric)
> > - s/fs_hwpt/fs_hwpt_id, s/vtd_bind_guest_pasid/vtd_propagate_guest_pasid (Eric)
> > - polish error msg when CONFIG_VTD_ACCEL isn't defined (Eric)
> > - refactor hwpt_id assignment in vtd_device_attach_iommufd() (Eric)
> > 
> > v8:
> > - add hw/i386/intel_iommu_accel.[hc] to hold accel code (Eric)
> > - return bool for all vtd accel related functions (Cédric, Eric)
> > - introduce a new PCIIOMMUOps::get_host_iommu_quirks() (Eric, Nicolin)
> > - minor polishment to comment and code (Cédric, Eric)
> > - drop some R-b as they have changes needing review again
> > 
> > v7:
> > - s/host_iommu_extract_vendor_caps/host_iommu_extract_quirks (Nicolin)
> > - s/RID_PASID/PASID_0 (Eric)
> > - drop rid2pasid check in vtd_do_iommu_translate (Eric)
> > - refine DID check in vtd_pasid_cache_sync_locked (Liuyi)
> > - refine commit log (Nicolin, Eric, Liuyi)
> > - Fix doc build (Cédric)
> > - add migration support
> > 
> > v6:
> > - delete RPS capability related supporting code (Eric, Yi)
> > - use terminology 'first/second stage' to replace 'first/second level" (Eric, Yi)
> > - use get_viommu_flags() instead of get_viommu_caps() (Nicolin)
> > - drop non-RID_PASID related code and simplify pasid invalidation handling (Eric, Yi)
> > - drop the patch that handle pasid replay when context invalidation (Eric)
> > - move vendor specific cap check from VFIO core to backend/iommufd.c (Nicolin)
> > 
> > v5:
> > - refine commit log of patch2 (Cédric, Nicolin)
> > - introduce helper vfio_pci_from_vfio_device() (Cédric)
> > - introduce helper vfio_device_viommu_get_nested() (Cédric)
> > - pass 'bool bypass_ro' argument to vfio_listener_valid_section() instead of 'VFIOContainerBase *' (Cédric)
> > - fix a potential build error reported by Jim Shu
> > 
> > v4:
> > - s/VIOMMU_CAP_STAGE1/VIOMMU_CAP_HW_NESTED (Eric, Nicolin, Donald, Shameer)
> > - clarify get_viommu_cap() return pure emulated caps and explain reason in commit log (Eric)
> > - retrieve the ce only if vtd_as->pasid in vtd_as_to_iommu_pasid_locked (Eric)
> > - refine doc comment and commit log in patch10-11 (Eric)
> > 
> > v3:
> > - define enum type for VIOMMU_CAP_* (Eric)
> > - drop inline flag in the patch which uses the helper (Eric)
> > - use extract64 in new introduced MACRO (Eric)
> > - polish comments and fix typo error (Eric)
> > - split workaround patch for ERRATA_772415_SPR17 to two patches (Eric)
> > - optimize bind/unbind error path processing
> > 
> > v2:
> > - introduce get_viommu_cap() to get STAGE1 flag to create nesting parent HWPT (Liuyi)
> > - reuse VFIO's default HWPT as parent HWPT of nested translation (Nicolin, Liuyi)
> > - abandon support of VFIO device under pcie-to-pci bridge to simplify design (Liuyi)
> > - bypass RO mapping in VFIO's default HWPT if ERRATA_772415_SPR17 (Liuyi)
> > - drop vtd_dev_to_context_entry optimization (Liuyi)
> > 
> > v1:
> > - simplify vendor specific checking in vtd_check_hiod (Cédric, Nicolin)
> > - rebase to master
> > 
> > 
> > Yi Liu (3):
> >    intel_iommu_accel: Propagate PASID-based iotlb invalidation to host
> >    intel_iommu: Replay all pasid bindings when either SRTP or TE bit is
> >      changed
> >    intel_iommu: Replay pasid bindings after context cache invalidation
> > 
> > Zhenzhong Duan (16):
> >    intel_iommu: Rename vtd_ce_get_rid2pasid_entry to
> >      vtd_ce_get_pasid_entry
> >    intel_iommu: Delete RPS capability related supporting code
> >    intel_iommu: Update terminology to match VTD spec
> >    hw/pci: Export pci_device_get_iommu_bus_devfn() and return bool
> >    hw/pci: Introduce pci_device_get_viommu_flags()
> >    intel_iommu: Implement get_viommu_flags() callback
> >    intel_iommu: Introduce a new structure VTDHostIOMMUDevice
> >    vfio/iommufd: Force creating nesting parent HWPT
> >    intel_iommu_accel: Check for compatibility with IOMMUFD backed device
> >      when x-flts=on
> >    intel_iommu_accel: Fail passthrough device under PCI bridge if
> >      x-flts=on
> >    intel_iommu_accel: Stick to system MR for IOMMUFD backed host device
> >      when x-flts=on
> >    intel_iommu: Add some macros and inline functions
> >    intel_iommu_accel: Bind/unbind guest page table to host
> >    intel_iommu: Add migration support with x-flts=on
> >    intel_iommu: Enable host device when x-flts=on in scalable mode
> >    docs/devel: Add IOMMUFD nesting documentation
> > 
> >   MAINTAINERS                    |   2 +
> >   docs/devel/vfio-iommufd.rst    |  17 ++
> >   hw/i386/intel_iommu_accel.h    |  51 ++++
> >   hw/i386/intel_iommu_internal.h | 155 +++++++---
> >   include/hw/core/iommu.h        |  25 ++
> >   include/hw/i386/intel_iommu.h  |   6 +-
> >   include/hw/pci/pci.h           |  24 ++
> >   include/hw/vfio/vfio-device.h  |   2 +
> >   hw/i386/intel_iommu.c          | 528 +++++++++++++++++++--------------
> >   hw/i386/intel_iommu_accel.c    | 251 ++++++++++++++++
> >   hw/pci/pci.c                   |  23 +-
> >   hw/vfio/device.c               |  12 +
> >   hw/vfio/iommufd.c              |   9 +
> >   tests/qtest/intel-iommu-test.c |   4 +-
> >   hw/i386/Kconfig                |   5 +
> >   hw/i386/meson.build            |   1 +
> >   hw/i386/trace-events           |   4 +
> >   17 files changed, 833 insertions(+), 286 deletions(-)
> >   create mode 100644 hw/i386/intel_iommu_accel.h
> >   create mode 100644 include/hw/core/iommu.h
> >   create mode 100644 hw/i386/intel_iommu_accel.c
> > 
> 
> 


