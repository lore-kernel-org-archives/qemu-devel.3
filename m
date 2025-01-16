Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0526E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 06:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYJYv-0006Eb-2G; Thu, 16 Jan 2025 01:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tYJYp-0006Dw-R8; Thu, 16 Jan 2025 01:41:00 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tYJYn-0001Go-Ks; Thu, 16 Jan 2025 01:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737009658; x=1768545658;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/wsEbh5k8KU0W75EnTf8XFQwAcpvl3BDAnKbMS64w3o=;
 b=amepFBkMC7QhBff9Ofajgqd0+jKFdUjmd9HtRHqKVTiP3TUWsoBoOR8x
 eLns9YfV90FjI36vD/iNrRcxMkgnf2KIv0HExnWijv8uvFk9tUHY1oyFn
 GZOIRjStm8BKA0DhSKE5G6LwlrxJxSmhvEKEYXFtDhMg0qCCQhp3PIbl7
 PsdRPO2qm0UnhaONBTRXboUyzFEZuSPiL5tT+47qfS6RynDYsgzFzO1ZN
 jZbtNUPwB85fxXn6/LW/l5iphLA+qadbWB0IcHcxGs+vG+5i5/oQjH5Cc
 26eFojDsFWCvz1CxbT0+y7bUSeXn4ptUCAn7ZEFKVjRyXLM294wtNWD+0 g==;
X-CSE-ConnectionGUID: gxDFPZ1wTuK+iYNuXfe6/A==
X-CSE-MsgGUID: f4U1XzK4RJaI0+lUeM5g7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="48772795"
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; d="scan'208";a="48772795"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2025 22:40:54 -0800
X-CSE-ConnectionGUID: LgUVV+bpROGqC/5MIp4pbg==
X-CSE-MsgGUID: Z4KYTdadT/6Pl+s/Qb027g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; d="scan'208";a="110362990"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 15 Jan 2025 22:40:51 -0800
Date: Thu, 16 Jan 2025 14:59:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [RFC PATCH 5/9] rust: vmstate: implement VMState for scalar types
Message-ID: <Z4iuX5oTr2r5B569@intel.com>
References: <20241231002336.25931-1-pbonzini@redhat.com>
 <20241231002336.25931-6-pbonzini@redhat.com>
 <Z34fAFD4d/BVZQkn@intel.com>
 <f1e17aac-543a-4d9b-906b-8ee98d1ff55e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1e17aac-543a-4d9b-906b-8ee98d1ff55e@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

 
> > > +impl_vmstate_scalar!(vmstate_info_uint64, u64);
> > 
> > What about applying this to "usize" with vmstate_info_uint64?
> 
> There's 32-bit hosts too...  So one would have to add vmstate_info_ulong
> which is serialized as 64-bit.
> 
> We can add it later, but perhaps we could also create a derive(Index,
> IndexMut) macro that makes it possible to specify the type of the index.
> While Rust uses usize instead of uNN for array indices, that does not have
> to be universal; using uNN is a lot better if it means you can get rid of
> casts from register values to array indices and back.  See for example
> commit 6b4f7b0705b ("rust: pl011: fix migration stream", 2024-12-19).

Yes, I agree!

> That is indeed also an issue for HPET, but in that case it can be isolated
> to a couple lines,
> 
>             let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
> 
> and it could even be wrapped further
> 
>     fn timer_and_addr(&self, addr: hwaddr) -> Option<&BqlRefCell<HPETTimer>,
> hwaddr> {
>         let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
>         if timer_id > self.num_timers.get() {
>             // TODO: Add trace point -
> trace_hpet_timer_id_out_of_range(timer_id)
>             None
>         } else {
>             Some((self.get_timer(timer_id), addr & 0x18))
>         }
>     }
> 
>     ...
> 
>     match self.timer_and_addr(addr) {
>         None => 0 // Reserved,
>         Some(timer, addr) => timer.borrow_mut().read(addr, size)
>     }
> 
> 
> So for HPET you didn't reach the threshold of having to create "pub struct
> HPETTimers([BqlRefCell<HPETTimer>; MAX_HPET_TIMERS])" and implement Index<>.
> 

Thank you Paolo! Will apply your wrapping suggestion!

Regards,
Zhao



