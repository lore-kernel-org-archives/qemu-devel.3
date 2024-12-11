Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81484E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPjj-0001yK-8u; Wed, 11 Dec 2024 11:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLPjX-0001iN-QS; Wed, 11 Dec 2024 11:38:44 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tLPjU-0002a0-LE; Wed, 11 Dec 2024 11:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733935121; x=1765471121;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lGDuG1wgfD376M5q17+Nm6wS/8Utxh8Nhg6DJY2dVy4=;
 b=BGYMsv1E4Sg44ohemjGXj8BnsdILYvqxNZVOK1Tbb4kTgJ31bK+//l0X
 norbdW1Mh8yU5B9stfzn6eg5wy1KtC++jQMu/cayGVb931ZcZQCz7Wyzd
 tsREQYofQnMKKaVV2d4NZf5DXyJJfkOnQYQK1oj1Pn/zLou7is7Q9Kg0Q
 eIeySSgx1g+3JXcL1oVlfYh+yCbSkeeI6BcJwlFbBxm8y+RRCuJIMMMB8
 Ip/4sMUTBlJjgrlrJdNXG3TABiX4RCI++R7sD8ntD3H9Jdtb/E1Ls1fzw
 wRyOxSIyScn9YGr8xtU+1iOy5QOkKmqw5ErrJzI1NZrsyb00Q8KIhVLZy A==;
X-CSE-ConnectionGUID: RV/taBWnS8KkeZKYS+szNQ==
X-CSE-MsgGUID: vvDQ+nSoRyiHoyjQKgbt4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="45705027"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; d="scan'208";a="45705027"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 08:38:38 -0800
X-CSE-ConnectionGUID: 2Gqx/xJyRiuGDAUtKFQIfw==
X-CSE-MsgGUID: m2OIRmbLRTK9OGji4TxRRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; d="scan'208";a="95725577"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 11 Dec 2024 08:38:36 -0800
Date: Thu, 12 Dec 2024 00:56:50 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 14/26] rust: qom: move bridge for TypeInfo functions out
 of pl011
Message-ID: <Z1nEUmzHa5dA5C0d@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-15-pbonzini@redhat.com>
 <Z1hjX+5Yyi46N+sX@intel.com>
 <ada60844-546a-42ca-a05f-7b6dc225ff53@redhat.com>
 <Z1lGZdXsVR5ra4hl@intel.com>
 <CABgObfbs57rVNU4jTwUbPeZEbvEKpVPAZj0Pd8OF75D8ojQEMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfbs57rVNU4jTwUbPeZEbvEKpVPAZj0Pd8OF75D8ojQEMQ@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> Generally:
> 
> - embedded objects will have to be initialized in instance_init unless they
> are Options

I see, at least for HPETTimer array, I need to prepare all of them in
instance_init()...

> - if you don't need properties you can choose between post_init and
> realize, if you need properties you need to initialize in realize (and
> then, unlike C, you might need to explicitly allow the pre-realize state;
> for example using Option<&...> instead of just a reference; or Vec<>
> instead of an array).

...in realize(), also need to handle the "timers" property to enable
the timers that property requires.

> - sysbus_init_irq and sysbus_init_mmio can be called in both instance_init
> and instance_post_init for now, but they will have to be in post_init once
> the signature of init changes to return impl PinInit

make sense, thanks!

> >
> > > The way that this will become safe is to use the pinned_init crate from
> > > Linux: instance_init returns the initialization as an "impl
> > PinInit<Self>",
> >
> > Then do we need to place OBJECT in some suitable memory location (Box or
> > something) for Rust implementation?
> >
> 
> Allocation is still done by the C code, so I am not sure I understand the
> question. Rust code allocates QOM objects with object_new() so they are
> malloc-ed.

Sorry, I'm not familiar enough with this piece...I have the question
because PinInit doc said "you will need a suitable memory location that
can hold a T. This can be KBox<T>, Arc<T>, UniqueArc<T> or even the
stack (see stack_pin_init!)."

I see that the core point is ensuring that structures cannot be moved.
Given that object_new() on the C side ensures that the allocated object
will not be moved, Rust side does not need to worry about pinning, correct?

> I discussed it with Manos some time ago and in principle you
> could use a Box (QOM supports custom freeing functions) but it's a bit
> complex because the freeing function would have to free the memory without
> dropping the contents of the Box (the drop is done by QOM via
> instance_finalize).
> 
> If you want to allocate the HPETTimers at realize time, I think you can
> place them in a Vec. I think you won't need NonNull for this, but I am not
> 100% sure. Alternatively if you want to always prepare all MAX_TIMERS of
> them and then only use a subset, you can use an array.

Vec seems to lack proper vmstate support. I understand that we need to
modify VMSTATE_STRUCT_VARRAY_POINTER_* to introduce a variant for Vec.

Since the array support is already available, I chose to use an array
instead (although vmstate is disabled for now).

> Either way, probably it makes sense for you to have an "fn
> timers_iter(&self) -> impl Iter<Item = &BqlRefCell<HPETTimer>>" in
> HPETState, or something like that. Then you can easily use for loops to
> walk all timers between 0 and self.num_timers-1.

Good idea, yes, will do.

Thanks,
Zhao


