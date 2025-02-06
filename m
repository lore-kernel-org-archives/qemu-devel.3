Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6C6C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 10:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfzLb-00045s-2G; Thu, 06 Feb 2025 05:43:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yilun.xu@linux.intel.com>)
 id 1tfzLZ-00045X-G6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 05:43:01 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yilun.xu@linux.intel.com>)
 id 1tfzLX-0004Pp-BY
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 05:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738838579; x=1770374579;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kv5rnqaQVKnPdmx6jwXVGiOnMb+WXqSNmbdjEEWLRRA=;
 b=gTS5mEv7gF+CrzzONYH0ULzcd6HS8P3b3t0eiJ3zOQIXuPadYB469NHY
 wLKTx9ODmidBD5kulNqC92Wa5yPrbq3CCWRMB9Gd/8OOkJS5D7sXeaPIB
 fOiV7z2dyVvEzlvP9fhY+Chbx1NclsWBWa89JnQ/ldLqjpmxTB4674lWO
 mOhqlIeaBK/f5t5buXOvMx57Pz4YOFX/7NsCpwHlg6hqeb+nwkigLpFcN
 ycUsNqOuMhWOy7xZRqhmsmT9ztFCOepS7Gk3Fq26i7p5sRVoE6Xdj65NT
 8SeWmn+HCkl0gK6VCo0Vg5IEzzPxlW3bz/n6FbWCNRQ8dh2pND7Ftsf05 w==;
X-CSE-ConnectionGUID: 2/vs9f+9QP+8UF8351gnvg==
X-CSE-MsgGUID: 8n97ug9XT8GP87V7qA8gjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="61911293"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="61911293"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 02:42:55 -0800
X-CSE-ConnectionGUID: 5kRV3BfkT4yCGibliSd/UQ==
X-CSE-MsgGUID: isKgtj8jTzuJLw32cGbLIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="134407810"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost)
 ([10.239.159.165])
 by fmviesa002.fm.intel.com with ESMTP; 06 Feb 2025 02:42:02 -0800
Date: Thu, 6 Feb 2025 18:41:09 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Xu <peterx@redhat.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
Message-ID: <Z6SRxV83I9/kamop@yilunxu-OptiPlex-7050>
References: <Z4-6u5_9NChu_KZq@x1n>
 <95a14f7d-4782-40b3-a55d-7cf67b911bbe@amd.com>
 <Z5C9SzXxX7M1DBE3@yilunxu-OptiPlex-7050> <Z5EgFaWIyjIiOZnv@x1n>
 <Z5INAQjxyYhwyc+1@yilunxu-OptiPlex-7050> <Z5Jylb73kDJ6HTEZ@x1n>
 <Z5NhwW/IXaLfvjvb@yilunxu-OptiPlex-7050> <Z5O4BSCjlhhu4rrw@x1n>
 <Z5WtRYSf7cjqITXH@yilunxu-OptiPlex-7050>
 <Z5uom-NTtekV9Crd@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5uom-NTtekV9Crd@x1.local>
Received-SPF: none client-ip=198.175.65.9;
 envelope-from=yilun.xu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Thu, Jan 30, 2025 at 11:28:11AM -0500, Peter Xu wrote:
> On Sun, Jan 26, 2025 at 11:34:29AM +0800, Xu Yilun wrote:
> > > Definitely not suggesting to install an invalid pointer anywhere.  The
> > > mapped pointer will still be valid for gmem for example, but the fault
> > > isn't.  We need to differenciate two things (1) virtual address mapping,
> > > then (2) permission and accesses on the folios / pages of the mapping.
> > > Here I think it's okay if the host pointer is correctly mapped.
> > > 
> > > For your private MMIO use case, my question is if there's no host pointer
> > > to be mapped anyway, then what's the benefit to make the MR to be ram=on?
> > > Can we simply make it a normal IO memory region?  The only benefit of a
> > 
> > The guest access to normal IO memory region would be emulated by QEMU,
> > while private assigned MMIO requires guest direct access via Secure EPT.
> > 
> > Seems the existing code doesn't support guest direct access if
> > mr->ram == false:
> 
> Ah it's about this, ok.
> 
> I am not sure what's the best approach, but IMHO it's still better we stick
> with host pointer always available when ram=on.  OTOH, VFIO private regions
> may be able to provide a special mark somewhere, just like when romd_mode
> was done previously as below (qemu 235e8982ad39), so that KVM should still
> apply these MRs even if they're not RAM.

Also good to me.

> 
> > 
> > static void kvm_set_phys_mem(KVMMemoryListener *kml,
> >                              MemoryRegionSection *section, bool add)
> > {
> >     [...]
> > 
> >     if (!memory_region_is_ram(mr)) {
> >         if (writable || !kvm_readonly_mem_allowed) {
> >             return;
> >         } else if (!mr->romd_mode) {
> >             /* If the memory device is not in romd_mode, then we actually want
> >              * to remove the kvm memory slot so all accesses will trap. */
> >             add = false;
> >         }
> >     }
> > 
> >     [...]
> > 
> >     /* register the new slot */
> >     do {
> > 
> >         [...]
> > 
> >         err = kvm_set_user_memory_region(kml, mem, true);
> >     }
> > }
> > 
> > > ram=on MR is, IMHO, being able to be accessed as RAM-like.  If there's no
> > > host pointer at all, I don't yet understand how that helps private MMIO
> > > from working.
> > 
> > I expect private MMIO not accessible from host, but accessible from
> > guest so has kvm_userspace_memory_region2 set. That means the resolving
> > of its PFN during EPT fault cannot depends on host pointer.
> > 
> > https://lore.kernel.org/all/20250107142719.179636-1-yilun.xu@linux.intel.com/
> 
> I'll leave this to KVM experts, but I actually didn't follow exactly on why
> mmu notifier is an issue to make , as I thought that was per-mm anyway, and KVM
> should logically be able to skip all VFIO private MMIO regions if affected.

I think this creates logical inconsistency. You builds the private MMIO
EPT mapping on fault based on the HVA<->HPA mapping, but doesn't follow
the HVA<->HPA mapping change. Why KVM believes the mapping on fault time
but doesn't on mmu notify time?

> This is a comment to this part of your commit message:
> 
>         Rely on userspace mapping also means private MMIO mapping should
>         follow userspace mapping change via mmu_notifier. This conflicts
>         with the current design that mmu_notifier never impacts private
>         mapping. It also makes no sense to support mmu_notifier just for
>         private MMIO, private MMIO mapping should be fixed when CoCo-VM
>         accepts the private MMIO, any following mapping change without
>         guest permission should be invalid.
> 
> So I don't yet see a hard-no of reusing userspace mapping even if they're
> not faultable as of now - what if they can be faultable in the future?  I

The first commit of guest_memfd emphasize a lot on the benifit of
decoupling KVM mapping from host mapping. My understanding is even if
guest memfd can be faultable later, KVM should still work in a way
without userspace mapping.

> am not sure..
> 
> OTOH, I also don't think we need KVM_SET_USER_MEMORY_REGION3 anyway.. The
> _REGION2 API is already smart enough to leave some reserved fields:
> 
> /* for KVM_SET_USER_MEMORY_REGION2 */
> struct kvm_userspace_memory_region2 {
> 	__u32 slot;
> 	__u32 flags;
> 	__u64 guest_phys_addr;
> 	__u64 memory_size;
> 	__u64 userspace_addr;
> 	__u64 guest_memfd_offset;
> 	__u32 guest_memfd;
> 	__u32 pad1;
> 	__u64 pad2[14];
> };
> 
> I think we _could_ reuse some pad*?  Reusing guest_memfd field sounds error
> prone to me.

It truly is. I'm expecting some suggestions here.

Thanks,
Yilun

> 
> Not sure it could be easier if it's not guest_memfd* but fd + fd_offset
> since the start.  But I guess when introducing _REGION2 we didn't expect
> MMIO private regions come so soon..
> 
> Thanks,
> 
> -- 
> Peter Xu
> 

