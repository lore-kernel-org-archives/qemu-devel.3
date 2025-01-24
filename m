Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5067DC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGIQ-0006eH-7x; Fri, 24 Jan 2025 04:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yilun.xu@linux.intel.com>)
 id 1tbGIM-0006M8-8T
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:48:10 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yilun.xu@linux.intel.com>)
 id 1tbGIJ-0004Jt-7U
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737712087; x=1769248087;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZCO/MfX8NlwMysTySYqInSrG/aVh4QrZSiFlw8U2DTU=;
 b=lbNpEBWDFInCsG+znNzKnNhNQ+sGuG34BDe60qsyUpcErhWiJDE3vzSx
 Zjx4qPrxMgGcq6EUqAA4ryt3GkzZUXMfaFilESEO2yGlZRUVW3+K3rA5g
 W1HyhOjI+6NXX/u+1oZyDeiAiZLsC7/lRi34IfxQ+aZAybpnYes9x/1OM
 AfQ6CFVyG+Nx/1khwixfoqIZ3idzR3LqeJxIhmBRKIVjY2CYEdHej0zKS
 HvOn3vG+YANOSuuFHO1yKj9HrKEiZ54/tp9kh/P48wAHpU7+gwalpDOdi
 lfSuycyPd+fnv8EDmkw3k9ZTiA2H5gVAv10PuGKPpDgu85RsLBMMDTiKG Q==;
X-CSE-ConnectionGUID: VAWGa73aSZS/cnQ15ckY/A==
X-CSE-MsgGUID: NBv7TbcdQ56/zmjnnGqa1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="38384681"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; d="scan'208";a="38384681"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 01:48:04 -0800
X-CSE-ConnectionGUID: 9Ia2M76ySwGjhE/uJ2a80A==
X-CSE-MsgGUID: tdwLn7+uRXqx0YvAArLPNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; d="scan'208";a="138593034"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost)
 ([10.239.159.165])
 by orviesa002.jf.intel.com with ESMTP; 24 Jan 2025 01:48:01 -0800
Date: Fri, 24 Jan 2025 17:47:45 +0800
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
Message-ID: <Z5NhwW/IXaLfvjvb@yilunxu-OptiPlex-7050>
References: <590432e1-4a26-4ae8-822f-ccfbac352e6b@intel.com>
 <2b2730f3-6e1a-4def-b126-078cf6249759@amd.com>
 <Z462F1Dwm6cUdCcy@x1n> <ZnmfUelBs3Cm0ZHd@yilunxu-OptiPlex-7050>
 <Z4-6u5_9NChu_KZq@x1n>
 <95a14f7d-4782-40b3-a55d-7cf67b911bbe@amd.com>
 <Z5C9SzXxX7M1DBE3@yilunxu-OptiPlex-7050> <Z5EgFaWIyjIiOZnv@x1n>
 <Z5INAQjxyYhwyc+1@yilunxu-OptiPlex-7050> <Z5Jylb73kDJ6HTEZ@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5Jylb73kDJ6HTEZ@x1n>
Received-SPF: none client-ip=198.175.65.16;
 envelope-from=yilun.xu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jan 23, 2025 at 11:47:17AM -0500, Peter Xu wrote:
> On Thu, Jan 23, 2025 at 05:33:53PM +0800, Xu Yilun wrote:
> > On Wed, Jan 22, 2025 at 11:43:01AM -0500, Peter Xu wrote:
> > > On Wed, Jan 22, 2025 at 05:41:31PM +0800, Xu Yilun wrote:
> > > > On Wed, Jan 22, 2025 at 03:30:05PM +1100, Alexey Kardashevskiy wrote:
> > > > > 
> > > > > 
> > > > > On 22/1/25 02:18, Peter Xu wrote:
> > > > > > On Tue, Jun 25, 2024 at 12:31:13AM +0800, Xu Yilun wrote:
> > > > > > > On Mon, Jan 20, 2025 at 03:46:15PM -0500, Peter Xu wrote:
> > > > > > > > On Mon, Jan 20, 2025 at 09:22:50PM +1100, Alexey Kardashevskiy wrote:
> > > > > > > > > > It is still uncertain how to implement the private MMIO. Our assumption
> > > > > > > > > > is the private MMIO would also create a memory region with
> > > > > > > > > > guest_memfd-like backend. Its mr->ram is true and should be managed by
> > > > > > > > > > RamdDiscardManager which can skip doing DMA_MAP in VFIO's region_add
> > > > > > > > > > listener.
> > > > > > > > > 
> > > > > > > > > My current working approach is to leave it as is in QEMU and VFIO.
> > > > > > > > 
> > > > > > > > Agreed.  Setting ram=true to even private MMIO sounds hackish, at least
> > > > > > > 
> > > > > > > The private MMIO refers to assigned MMIO, not emulated MMIO. IIUC,
> > > > > > > normal assigned MMIO is always set ram=true,
> > > > > > > 
> > > > > > > void memory_region_init_ram_device_ptr(MemoryRegion *mr,
> > > > > > >                                         Object *owner,
> > > > > > >                                         const char *name,
> > > > > > >                                         uint64_t size,
> > > > > > >                                         void *ptr)
> > > 
> > > [1]
> > > 
> > > > > > > {
> > > > > > >      memory_region_init(mr, owner, name, size);
> > > > > > >      mr->ram = true;
> > > > > > > 
> > > > > > > 
> > > > > > > So I don't think ram=true is a problem here.
> > > > > > 
> > > > > > I see.  If there's always a host pointer then it looks valid.  So it means
> > > > > > the device private MMIOs are always mappable since the start?
> > > > > 
> > > > > Yes. VFIO owns the mapping and does not treat shared/private MMIO any
> > > > > different at the moment. Thanks,
> > > > 
> > > > mm.. I'm actually expecting private MMIO not have a host pointer, just
> > > > as private memory do.
> > > > 
> > > > But I'm not sure why having host pointer correlates mr->ram == true.
> > > 
> > > If there is no host pointer, what would you pass into "ptr" as referenced
> > > at [1] above when creating the private MMIO memory region?
> > 
> > Sorry for confusion. I mean existing MMIO region use set mr->ram = true,
> > and unmappable region (gmem) also set mr->ram = true. So don't know why
> > mr->ram = true for private MMIO is hackish.
> 
> That's exactly what I had on the question in the previous email - please
> have a look at what QEMU does right now with memory_access_is_direct().

I see memory_access_is_direct() should exclude mr->ram_device == true, which
is the case for normal assigned MMIO and for private assigned MMIO. So
this func is not a problem.

But I think flatview_access_allowed() is a problem that it doesn't filter
out the private memory. When memory is converted to private, the result
of host access can't be what you want and should be errored out. IOW,
the host ptr is sometimes invalid.

> I'm not 100% sure it'll work if the host pointer doesn't exist.
> 
> Let's take one user of it to be explicit: flatview_write_continue_step()
> will try to access the ram pointer if it's direct:
> 
>     if (!memory_access_is_direct(mr, true)) {
>         ...
>     } else {
>         /* RAM case */
>         uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
>                                                false, true);
> 
>         memmove(ram_ptr, buf, *l);
>         invalidate_and_set_dirty(mr, mr_addr, *l);
> 
>         return MEMTX_OK;
>     }
> 
> I don't see how QEMU could work yet if one MR set ram=true but without a
> host pointer..
> 
> As discussed previously, IMHO it's okay that the pointer is not accessible,

Maybe I missed something in previous discussion, I assume it is OK cause
no address_space_rw is happening on this host ptr when memory is
private, is it?

> but still I assume QEMU assumes the pointer at least existed for a ram=on
> MR.  I don't know whether it's suitable to set ram=on if the pointer
> doesn't ever exist.

In theory, any code logic should not depends on an invalid pointer. I
think a NULL pointer would be much better than a invalid pointer, at
least you can check whether to access. So if you think an invalid
pointer is OK, a NULL pointer should be also OK.

Thanks,
Yilun

> 
> > 
> > I think We could add another helper to create memory region for private
> > MMIO.
> > 
> > > 
> > > OTOH, IIUC guest private memory finally can also have a host pointer (aka,
> > > mmap()-able), it's just that even if it exists, accessing it may crash QEMU
> > > if it's private.
> > 
> > Not sure if I get it correct: when memory will be converted to private, QEMU
> > should firstly unmap the host ptr, which means host ptr doesn't alway exist.
> 
> At least current QEMU doesn't unmap it? 
> 
> kvm_convert_memory() does ram_block_discard_range() indeed, but that's hole
> punches, not unmap.  So the host pointer can always be there.
> 
> Even if we could have in-place gmemfd conversions in the future for guest
> mem, we should also need the host pointer to be around, in which case (per
> my current understand) it will even avoid hole punching but instead make
> the page accessible (by being able to be faulted in).
> 
> Thanks,
> 
> -- 
> Peter Xu
> 
> 

