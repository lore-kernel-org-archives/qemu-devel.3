Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C684C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 10:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ6In-0001sx-9X; Wed, 31 Jul 2024 06:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yilun.xu@linux.intel.com>)
 id 1sZ3Xs-0005h8-TW
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 03:14:48 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yilun.xu@linux.intel.com>)
 id 1sZ3Xq-0004RZ-T9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 03:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722410087; x=1753946087;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ssbII7MpEx5cZOyBZ8ZwGo8GeGJli2aCyYIPdwP4ZJA=;
 b=kDFlgEe+hvge18NZv+dHYZ4wdpTKNoH81SEhvYH3RUQXrnOOrIAHctIs
 5uvjdA66rrCVAde27CTvj0zrje1x3vSsH0ypR5HUSK+RtYl6JYa6nS5Ih
 Tzw9+EVcRvtRt+NSxfm1BS8dxGZfvWlhqehwtJH/aTbx9dG1dnAtBnmSY
 ytGQrYXgPsNG+3Pzq3xrWeqokGm5wR0nEs29tQ4qFZytLZhdVZUruCJfh
 uyTp8gvmQhCjrtXT2bLXIGDjX3SgEwibZEhJXPRsDlBoiYN893c0k6q3H
 f6EB4+a4DM+jdOxXhVk4s0Y5F677LuCm7OFPal8AflPAaUW/AFPtWIBPE A==;
X-CSE-ConnectionGUID: //sX5l0ZRAOH2GYvqmA5ZA==
X-CSE-MsgGUID: QxHAoqFbSvu5CAh99ATkeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="45687469"
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; d="scan'208";a="45687469"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2024 00:14:42 -0700
X-CSE-ConnectionGUID: 7xnhCxgnTAeY/NKjeetbXw==
X-CSE-MsgGUID: trA+W0KpRZqggGOAshqrDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; d="scan'208";a="55396439"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost)
 ([10.239.159.165])
 by orviesa008.jf.intel.com with ESMTP; 31 Jul 2024 00:14:38 -0700
Date: Wed, 31 Jul 2024 15:12:44 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "Qiang, Chenyi" <chenyi.qiang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Williams, Dan J" <dan.j.williams@intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "Wang, Wei W" <wei.w.wang@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 "Gao, Chao" <chao.gao@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Xu, Yilun" <yilun.xu@intel.com>
Subject: Re: [RFC PATCH 0/6] Enable shared device assignment
Message-ID: <Zqnj7PZKX6Rzh/yl@yilunxu-OptiPlex-7050>
References: <20240725072118.358923-1-chenyi.qiang@intel.com>
 <ace9bb98-1415-460f-b8f5-e50607fbce20@redhat.com>
 <BN9PR11MB527635939C0A2A0763E326A58CB42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c9556944-16e4-4eb0-b9cd-56426099f813@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9556944-16e4-4eb0-b9cd-56426099f813@redhat.com>
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=yilun.xu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 31 Jul 2024 06:11:23 -0400
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

On Fri, Jul 26, 2024 at 09:08:51AM +0200, David Hildenbrand wrote:
> On 26.07.24 07:02, Tian, Kevin wrote:
> > > From: David Hildenbrand <david@redhat.com>
> > > Sent: Thursday, July 25, 2024 10:04 PM
> > > 
> > > > Open
> > > > ====
> > > > Implementing a RamDiscardManager to notify VFIO of page conversions
> > > > causes changes in semantics: private memory is treated as discarded (or
> > > > hot-removed) memory. This isn't aligned with the expectation of current
> > > > RamDiscardManager users (e.g. VFIO or live migration) who really
> > > > expect that discarded memory is hot-removed and thus can be skipped
> > > when
> > > > the users are processing guest memory. Treating private memory as
> > > > discarded won't work in future if VFIO or live migration needs to handle
> > > > private memory. e.g. VFIO may need to map private memory to support
> > > > Trusted IO and live migration for confidential VMs need to migrate
> > > > private memory.
> > > 
> > > "VFIO may need to map private memory to support Trusted IO"
> > > 
> > > I've been told that the way we handle shared memory won't be the way
> > > this is going to work with guest_memfd. KVM will coordinate directly
> > > with VFIO or $whatever and update the IOMMU tables itself right in the
> > > kernel; the pages are pinned/owned by guest_memfd, so that will just
> > > work. So I don't consider that currently a concern. guest_memfd private
> > > memory is not mapped into user page tables and as it currently seems it
> > > never will be.
> > 
> > Or could extend MAP_DMA to accept guest_memfd+offset in place of

With TIO, I can imagine several buffer sharing requirements: KVM maps VFIO
owned private MMIO, IOMMU maps gmem owned private memory, IOMMU maps VFIO
owned private MMIO. These buffers cannot be found by user page table
anymore. I'm wondering it would be messy to have specific PFN finding
methods for each FD type. Is it possible we have a unified way for
buffer sharing and PFN finding, is dma-buf a candidate?

> > 'vaddr' and have VFIO/IOMMUFD call guest_memfd helpers to retrieve
> > the pinned pfn.
> 
> In theory yes, and I've been thinking of the same for a while. Until people
> told me that it is unlikely that it will work that way in the future.

Could you help specify why it won't work? As Kevin mentioned below, SEV-TIO
may still allow userspace to manage the IOMMU mapping for private. I'm
not sure how they map private memory for IOMMU without touching gmemfd.

Thanks,
Yilun

> 
> > 
> > IMHO it's more the TIO arch deciding whether VFIO/IOMMUFD needs
> > to manage the mapping of the private memory instead of the use of
> > guest_memfd.
> > 
> > e.g. SEV-TIO, iiuc, introduces a new-layer page ownership tracker (RMP)
> > to check the HPA after the IOMMU walks the existing I/O page tables.
> > So reasonably VFIO/IOMMUFD could continue to manage those I/O
> > page tables including both private and shared memory, with a hint to
> > know where to find the pfn (host page table or guest_memfd).
> > 
> > But TDX Connect introduces a new I/O page table format (same as secure
> > EPT) for mapping the private memory and further requires sharing the
> > secure-EPT between CPU/IOMMU for private. Then it appears to be
> > a different story.
> 
> Yes. This seems to be the future and more in-line with in-place/in-kernel
> conversion as e.g., pKVM wants to have it. If you want to avoid user space
> altogether when doing shared<->private conversions, then letting user space
> manage the IOMMUs is not going to work.
> 
> 
> If we ever have to go down that path (MAP_DMA of guest_memfd), we could have
> two RAMDiscardManager for a RAM region, just like we have two memory
> backends: one for shared memory populate/discard (what this series tries to
> achieve), one for private memory populate/discard.
> 
> The thing is, that private memory will always have to be special-cased all
> over the place either way, unfortunately.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 
> 

