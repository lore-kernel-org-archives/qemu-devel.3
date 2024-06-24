Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5B6C02181
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 01:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta30d-0004AD-F8; Mon, 20 Jan 2025 20:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yilun.xu@linux.intel.com>)
 id 1ta30Z-00049p-VH
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 20:24:48 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yilun.xu@linux.intel.com>)
 id 1ta30X-0005lJ-Tq
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 20:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737422686; x=1768958686;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=FPg3TuHPY7jtHz85ISGqMg2kzizpxcy1l51R+UxE23U=;
 b=jsnvYfZ9nRuNduR5WCsLgrioOXqSeZVtx1w0olptr4Z91tdrnHrO41kX
 EiyZ1d+TfI7QV+4KHC86naF292Lh73DaU6E6Gb17REU2prBhoNtwSEqkG
 UJ8G+d5mYXKTxUVY8z4BiqkQhWJOnI4psWCYLNpDUQbQ/aIUAzLvpnZLk
 A4NS7Ze7uzNaa6ATRiveJflmUFZZOrynSyhLq93oQX4JaCSutR2g6ZgtE
 mSeEVblbqYebpk63Aocp7f1BIzAfqUVrbXR0xnkh1TduVqW7zbt4syCm/
 XvZTbFofs5upTmv8Y3ZAxS/mldomgUo71iq62OP6qKObRxUyLwyNo/hiF Q==;
X-CSE-ConnectionGUID: Yr6wXjk5S1Ssvx5UPiBfEQ==
X-CSE-MsgGUID: 3nTZu4IDQoC50Wqq71jmiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="41582951"
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; d="scan'208";a="41582951"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2025 17:24:42 -0800
X-CSE-ConnectionGUID: dtDZMTL1Q1+tmX9xtX/OAQ==
X-CSE-MsgGUID: v7KlY8qVQRG7mxL/M8gSPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,220,1732608000"; d="scan'208";a="107257927"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost)
 ([10.239.159.165])
 by fmviesa009.fm.intel.com with ESMTP; 20 Jan 2025 17:24:38 -0800
Date: Tue, 25 Jun 2024 00:31:13 +0800
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
Message-ID: <ZnmfUelBs3Cm0ZHd@yilunxu-OptiPlex-7050>
References: <219a4a7a-7c96-4746-9aba-ed06a1a00f3e@amd.com>
 <58b96b74-bf9c-45d3-8c2e-459ec2206fc8@intel.com>
 <8c8e024d-03dc-4201-8038-9e9e60467fad@amd.com>
 <ca9bc239-d59b-4c53-9f14-aa212d543db9@intel.com>
 <4d22d3ce-a5a1-49f2-a578-8e0fe7d26893@amd.com>
 <2b799426-deaa-4644-aa17-6ef31899113b@intel.com>
 <2400268e-d26a-4933-80df-cfe44b38ae40@amd.com>
 <590432e1-4a26-4ae8-822f-ccfbac352e6b@intel.com>
 <2b2730f3-6e1a-4def-b126-078cf6249759@amd.com>
 <Z462F1Dwm6cUdCcy@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z462F1Dwm6cUdCcy@x1n>
Received-SPF: none client-ip=198.175.65.14;
 envelope-from=yilun.xu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-3, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 20, 2025 at 03:46:15PM -0500, Peter Xu wrote:
> On Mon, Jan 20, 2025 at 09:22:50PM +1100, Alexey Kardashevskiy wrote:
> > > It is still uncertain how to implement the private MMIO. Our assumption
> > > is the private MMIO would also create a memory region with
> > > guest_memfd-like backend. Its mr->ram is true and should be managed by
> > > RamdDiscardManager which can skip doing DMA_MAP in VFIO's region_add
> > > listener.
> > 
> > My current working approach is to leave it as is in QEMU and VFIO.
> 
> Agreed.  Setting ram=true to even private MMIO sounds hackish, at least

The private MMIO refers to assigned MMIO, not emulated MMIO. IIUC,
normal assigned MMIO is always set ram=true,

void memory_region_init_ram_device_ptr(MemoryRegion *mr,
                                       Object *owner,
                                       const char *name,
                                       uint64_t size,
                                       void *ptr)
{
    memory_region_init(mr, owner, name, size);
    mr->ram = true;


So I don't think ram=true is a problem here.

Thanks,
Yilun

> currently QEMU heavily rely on that flag for any possible direct accesses.
> E.g., in memory_access_is_direct().
> 
> -- 
> Peter Xu
> 
> 

