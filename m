Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5C3E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 07:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLHLb-0000YS-Lp; Wed, 11 Dec 2024 02:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLHLZ-0000Y5-S7; Wed, 11 Dec 2024 02:41:25 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLHLX-0007rV-Gh; Wed, 11 Dec 2024 02:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733902883; x=1765438883;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dDOHJ41l3MUhAgqubOFzjkFh87t967hVzLPF1iX+6uc=;
 b=l3dmKjPYqvh6y1Yvk1N8RDeYOP3n3GIf7S8AlqAV8A7B87dDXmNii8L5
 WghrWtUHmosDdCdFv0I5DA7GOPGgimpsGQhqNqsTSDj0oNFtDcO005OxH
 nVmrs/5ixifziBkTGynj6c1G+7X84vzOETmF6DgosqYY/O+oKlRPUMvnt
 TQhhJO+DoDDKgCaXVimgdncxc/50QZMtUqaUz+2xOOTwXbTZ/VrGyMk3f
 kjJltlBLm/13NNJwnHTMutaVsF3INy0C4er6sanqHRxrY15v2gb3Yv0Rt
 OLMKtvTcBfpDQJMX54uVRdzEUtI1zKsKrZifYyen7cTLaSjvjQ3daVm8l w==;
X-CSE-ConnectionGUID: QOOnu0r6Tfu7CfMPoimxdw==
X-CSE-MsgGUID: M1hl9/GDTjCxQNoGFm7QQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="21856401"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="21856401"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2024 23:41:20 -0800
X-CSE-ConnectionGUID: jm3PGVo4QRye6wc9FF9qLA==
X-CSE-MsgGUID: bxDbfuphRG+Z2LUHqbWpYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="96152946"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 10 Dec 2024 23:41:18 -0800
Date: Wed, 11 Dec 2024 15:59:33 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 14/26] rust: qom: move bridge for TypeInfo functions out
 of pl011
Message-ID: <Z1lGZdXsVR5ra4hl@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-15-pbonzini@redhat.com>
 <Z1hjX+5Yyi46N+sX@intel.com>
 <ada60844-546a-42ca-a05f-7b6dc225ff53@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada60844-546a-42ca-a05f-7b6dc225ff53@redhat.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
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

> > > -    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = Some(pl011_init);
> > > +    const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
> > 
> > No need to keep `unsafe` here?
> 
> Right now instance_init is called with only the parent initialized, and the
> remaining memory zeroed; its purpose is to prepare things for
> instance_post_init which can then be safe (it's also kind of wrong for
> instance_post_init to receive a &mut Self, because instance_init will create
> other pointers to the object, for example in a MemoryRegion's "parent"
> field).

Thank you for explanation. It makes a lot of sense.

> The right thing to do would be to have an argument of type &mut
> MaybeUninit<Self>.  Then the caller would do something like
> 
>     let maybe_uninit = obj as *mut MaybeUninit<Self>;
>     unsafe {
>         Self::INSTANCE_INIT(&mut *maybe_uninit);
>         maybe_uninit.assume_init_mut();
>     }
> 
> Note however that INSTANCE_INIT would still be unsafe, because its safety
> promise is that it prepares things for the caller's assume_init_mut().

Yes, I feel that this approach more clearly explains the purpose of QOM
init.

And since we are talking about the safety of INSTANCE_INIT, I think we
should add some safety guidelines here, like:
 * Proper Initialization of pointers and references
 * Explicit initialization of Non-Zero Fields
 * In placed memory region is correctly initialized.

(Or do you have any additional or clearer guidelines?)

This could be the reference when adding SAFETY comment for the device's
own `unsafe` init(). :-)

And this is also a good explanation to distinguish between initialization
in init() and realize(). For example, HPET attempts to initialize the
timer array in realize().

> The way that this will become safe is to use the pinned_init crate from
> Linux: instance_init returns the initialization as an "impl PinInit<Self>",

Then do we need to place OBJECT in some suitable memory location (Box or
something) for Rust implementation?

> and then instance_post_init can run with a &self.  Until then, however,
> instance_init has to remain unsafe.

Thanks for sharing! It's a very reasonable direction.

Regards,
Zhao


