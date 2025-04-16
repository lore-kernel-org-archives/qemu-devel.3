Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B268EC369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 10:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4zlY-0001W5-Bs; Wed, 16 Apr 2025 06:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4zlT-0001Ve-U3; Wed, 16 Apr 2025 06:13:08 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4zlQ-0004ph-OY; Wed, 16 Apr 2025 06:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744798384; x=1776334384;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=V1tD4762zIW5vFUKrm/TKIOsDhWgGz05D4XIQjZH/0c=;
 b=hUroMVy+dvPuxYJiGRHS9d17aru5cOC2DWJJefLU5MSCScUZeLIp2YaS
 Sdo9V+c/TVTJeK94ayIcK0awTfMnil9J2OOHC9ecIsaxcANn0Od13N0ft
 SmSNftIpa+OJs6HiGjDMpxXapqNIljaIFvXtgSYTqwgayj0tiBndP3BGA
 FnXERwNP35rNWkKQwPAReyNn+QcTd8Prcq6B0s8vcu35ATtfSqoq0F5aL
 fSlB4GESwcICMaBhdPMrAd6y8O+zUbvfpd8YQ5F4oY8Tl+kBSYpgIeqbN
 Vm5U/TUd+nok8QlVVkX1CEYSjx7kqF8gsilKHNFUZlfjrh2b+KUpEemqv w==;
X-CSE-ConnectionGUID: 28JHLWudScmamrCrazLgvg==
X-CSE-MsgGUID: 4kOb7LiLT3KIub3S4gBGNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="57331871"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; d="scan'208";a="57331871"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2025 03:13:01 -0700
X-CSE-ConnectionGUID: UcsXT1GbTF2S+ZxYC37epw==
X-CSE-MsgGUID: 1jBxpUaUSoSkimnvpdpfqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; d="scan'208";a="130372260"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 16 Apr 2025 03:12:59 -0700
Date: Wed, 16 Apr 2025 18:33:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 8/9] rust/hpet: Support migration
Message-ID: <Z/+HkId2+ORzERJN@intel.com>
References: <20250414144943.1112885-1-zhao1.liu@intel.com>
 <20250414144943.1112885-9-zhao1.liu@intel.com>
 <Z/5KlfQgC65g6Kid@intel.com>
 <78fdfdaf-7c94-4d79-be39-8215c033b423@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78fdfdaf-7c94-4d79-be39-8215c033b423@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> > Although it can handle callbacks well, I found that the difficulty still
> > lies in the fact that the vmstate_fields and vmstate_subsections macros
> > cannot be eliminated, because any dynamic creation of arrays is not
> > allowed in a static context!
> 
> Yes, this makes sense.  Array size must be known inside a const function and
> the extra terminator at the end of fields and subsections cannot be added by
> the builder itself.  c_str! has the same issue for the name, if I understand
> correctly.

Yes, I have to use c_str! in name().

> > In any case, it's definitely still rough, but hope it helps and
> > takes a small step forward.
> 
> Yes, of course---this:
> 
> +static VMSTATE_HPET_RTC_IRQ_LEVEL: VMStateDescription<HPETState> =
> +    VMStateDescriptionBuilder::<HPETState>::new()
> +        .name(c_str!("hpet/rtc_irq_level"))
> +        .version_id(1)
> +        .minimum_version_id(1)
> +        .needed(&HPETState::is_rtc_irq_level_needed)
> +        .fields(vmstate_fields! {
> +            vmstate_of!(HPETState, rtc_irq_level),
> +        })
> +        .build();
> +
> 
> is readable, not foreign (it's similar to the MemoryRegionOps) and provides
> an easy way to insert FFI wrappers.
> 
> Right now it's now fully typesafe, because the VMStateField returned by
> vmstate_of! (as well as the arrays returned by vmstate_fields! and
> vmstate_subsections!) does not track that it's for an HPETState; but that's
> a small thing overall and getting the basic builder right is more important.

I agree, additional consideration is needed here. Currently it is
vmstate_fields! that limits changes to vmstate_of!.

> I also made a note to check which callbacks could have a Result<> as the
> return type, possibly reusing the Errno module (Result<(), ()> looks a bit
> silly); but that is also not needed for this early stage.
> 
> Just a couple notes:
> 
> > +    bindings::{VMStateDescription as RawVMStateDescription, VMStateFlags},
> 
> I would use bindings::VMStateDescription throughout, similar to how
> it's done in memory.rs.

Sure, will fix.

> > +    pub const fn name(mut self, name_str: &CStr) -> Self {
> > +        self.0.name = ::std::ffi::CStr::as_ptr(name_str);
> 
> 
> This can use "name_str.as_ptr()" because the type of name_str is known
> (unlike in macros, such as define_property! or vmstate_validate!).

I see and will fix.

> (By the way, talking about macros, I have just stumbled on the attrs crate,
> which is something to keep an eye on for when QOM/qdev bindings are extended
> along the lines of https://lore.kernel.org/qemu-devel/e8e55772-906b-42cb-a744-031e6ae65f16@redhat.com/T/.
> But I don't think procedural macros are a good match for VMState).

I didn't have a deep understanding of this previously :-(. I'll take a
closer look at this.

Thanks,
Zhao


