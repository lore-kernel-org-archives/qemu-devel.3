Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C34C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 09:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tatbL-0000wm-Ty; Thu, 23 Jan 2025 04:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yilun.xu@linux.intel.com>)
 id 1tatbK-0000wQ-10
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 04:34:14 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yilun.xu@linux.intel.com>)
 id 1tatbH-00086p-1M
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 04:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737624851; x=1769160851;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=LFoe2M4h2MR8WGWqKYSw1Zj4e0KwcSMzi45qyN7Ol4c=;
 b=GBpETM/H8+YIVmlMp6HVnAm9+mhhoEMQD2aWFP9pcfy8U3GVLUnIdRbe
 RjgmNRHgN2Kg98GJyjvzQKZ4gPUVm2sHp08K0O8Am2jdKonyWmZQ3KYHg
 Vl4EqDc+L1cP1PNfRQIvpu4I5vHpc1R0sVu6Q6GCvIoP+NDsGuHeCLw6y
 TaaosxBYGEUjFVX0NO7jEGI2UhnxIins/ZZZf9oL/R6oaHwtlF+z4CXsh
 Z6LbYO44XxKj8NFzI5xhycnpX5tCf3Nx97p3xlj56ePVAM95V1cc6W8Jt
 gQbDXXm1NCw10slhEQoP1kMUsIztgfGm5Ml9FfHosNL1i39ohIDJa586g g==;
X-CSE-ConnectionGUID: 96PYmK/eQWaEvV5sQ7vpvQ==
X-CSE-MsgGUID: sEShgFz8RfeXn6oAjfiNpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="37996843"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; d="scan'208";a="37996843"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2025 01:34:08 -0800
X-CSE-ConnectionGUID: ZDooXmqKQd2+fDzx0x5NVw==
X-CSE-MsgGUID: Rr12phi6QGGYF8BLwSYDbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; d="scan'208";a="138269350"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost)
 ([10.239.159.165])
 by orviesa002.jf.intel.com with ESMTP; 23 Jan 2025 01:34:05 -0800
Date: Thu, 23 Jan 2025 17:33:53 +0800
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
Message-ID: <Z5INAQjxyYhwyc+1@yilunxu-OptiPlex-7050>
References: <2b799426-deaa-4644-aa17-6ef31899113b@intel.com>
 <2400268e-d26a-4933-80df-cfe44b38ae40@amd.com>
 <590432e1-4a26-4ae8-822f-ccfbac352e6b@intel.com>
 <2b2730f3-6e1a-4def-b126-078cf6249759@amd.com>
 <Z462F1Dwm6cUdCcy@x1n> <ZnmfUelBs3Cm0ZHd@yilunxu-OptiPlex-7050>
 <Z4-6u5_9NChu_KZq@x1n>
 <95a14f7d-4782-40b3-a55d-7cf67b911bbe@amd.com>
 <Z5C9SzXxX7M1DBE3@yilunxu-OptiPlex-7050> <Z5EgFaWIyjIiOZnv@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5EgFaWIyjIiOZnv@x1n>
Received-SPF: none client-ip=198.175.65.19;
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

On Wed, Jan 22, 2025 at 11:43:01AM -0500, Peter Xu wrote:
> On Wed, Jan 22, 2025 at 05:41:31PM +0800, Xu Yilun wrote:
> > On Wed, Jan 22, 2025 at 03:30:05PM +1100, Alexey Kardashevskiy wrote:
> > > 
> > > 
> > > On 22/1/25 02:18, Peter Xu wrote:
> > > > On Tue, Jun 25, 2024 at 12:31:13AM +0800, Xu Yilun wrote:
> > > > > On Mon, Jan 20, 2025 at 03:46:15PM -0500, Peter Xu wrote:
> > > > > > On Mon, Jan 20, 2025 at 09:22:50PM +1100, Alexey Kardashevskiy wrote:
> > > > > > > > It is still uncertain how to implement the private MMIO. Our assumption
> > > > > > > > is the private MMIO would also create a memory region with
> > > > > > > > guest_memfd-like backend. Its mr->ram is true and should be managed by
> > > > > > > > RamdDiscardManager which can skip doing DMA_MAP in VFIO's region_add
> > > > > > > > listener.
> > > > > > > 
> > > > > > > My current working approach is to leave it as is in QEMU and VFIO.
> > > > > > 
> > > > > > Agreed.  Setting ram=true to even private MMIO sounds hackish, at least
> > > > > 
> > > > > The private MMIO refers to assigned MMIO, not emulated MMIO. IIUC,
> > > > > normal assigned MMIO is always set ram=true,
> > > > > 
> > > > > void memory_region_init_ram_device_ptr(MemoryRegion *mr,
> > > > >                                         Object *owner,
> > > > >                                         const char *name,
> > > > >                                         uint64_t size,
> > > > >                                         void *ptr)
> 
> [1]
> 
> > > > > {
> > > > >      memory_region_init(mr, owner, name, size);
> > > > >      mr->ram = true;
> > > > > 
> > > > > 
> > > > > So I don't think ram=true is a problem here.
> > > > 
> > > > I see.  If there's always a host pointer then it looks valid.  So it means
> > > > the device private MMIOs are always mappable since the start?
> > > 
> > > Yes. VFIO owns the mapping and does not treat shared/private MMIO any
> > > different at the moment. Thanks,
> > 
> > mm.. I'm actually expecting private MMIO not have a host pointer, just
> > as private memory do.
> > 
> > But I'm not sure why having host pointer correlates mr->ram == true.
> 
> If there is no host pointer, what would you pass into "ptr" as referenced
> at [1] above when creating the private MMIO memory region?

Sorry for confusion. I mean existing MMIO region use set mr->ram = true,
and unmappable region (gmem) also set mr->ram = true. So don't know why
mr->ram = true for private MMIO is hackish.

I think We could add another helper to create memory region for private
MMIO.

> 
> OTOH, IIUC guest private memory finally can also have a host pointer (aka,
> mmap()-able), it's just that even if it exists, accessing it may crash QEMU
> if it's private.

Not sure if I get it correct: when memory will be converted to private, QEMU
should firstly unmap the host ptr, which means host ptr doesn't alway exist.

Thanks,
Yilun

> 
> Thanks,
> 
> -- 
> Peter Xu
> 

