Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598ACC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 09:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmr4M-0006BA-Si; Tue, 25 Feb 2025 04:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmr3s-00069o-MV; Tue, 25 Feb 2025 04:17:08 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmr3o-0002rq-Ln; Tue, 25 Feb 2025 04:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740475024; x=1772011024;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0hP/dOMHN9oIBVDBEonW6snT7aVupqS6iFBYUByyRjs=;
 b=DkZ6Ieu1m5QPOv1ifY+hLxYd9S8njCLqoa+DUcGeBn3BS6AkZ2PQhqSG
 20hU9AUqTtBRJBgc2Tn7cloH8yxs3A/xjx2s6XxFrTlopjlae/yg7dUKG
 bVVEc7yWjxLkSwQcIjYzTXynk/V4DVJEqbAdEKgMAu25GYa7UsUogCYoh
 xJUBGTHiETwqtV2e+nbjxbCrrqVcJHvAWaI/804AsOYHuEKReplXskfyV
 3d6FM7gho+maPYftt+4QhzRcMcW+1KIICVC7mAUTugdpUcb3h3lK98tuP
 uV6FR8QUDEi0hOYIGF1U8p+2bG/Z9RpXsZdLDxQO1CFBdddJAzxI1mb/b g==;
X-CSE-ConnectionGUID: DKBo3bCZTTq8bXTMr3g+Ug==
X-CSE-MsgGUID: 2xoCg28gRnK6WlzJMHe/yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52696479"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="52696479"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 01:17:01 -0800
X-CSE-ConnectionGUID: DbVFm30LSFiBwAGWUkadBQ==
X-CSE-MsgGUID: R6kjhA7GRBaH61CHc4i9Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="139568991"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 25 Feb 2025 01:16:59 -0800
Date: Tue, 25 Feb 2025 17:36:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 09/15] rust: irq: wrap IRQState with Opaque<>
Message-ID: <Z72PJVq+R0nsQSwR@intel.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
 <20250221170342.63591-10-pbonzini@redhat.com>
 <Z71+qiu+X4BKW2ja@intel.com>
 <a776b84b-dd3c-4e17-b89a-a745c1f89a83@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a776b84b-dd3c-4e17-b89a-a745c1f89a83@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Tue, Feb 25, 2025 at 09:28:52AM +0100, Paolo Bonzini wrote:
> Date: Tue, 25 Feb 2025 09:28:52 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 09/15] rust: irq: wrap IRQState with Opaque<>
> 
> On 2/25/25 09:26, Zhao Liu wrote:
> > > +/// An opaque wrapper around [`bindings::IRQState`].
> > > +#[repr(transparent)]
> > > +#[derive(Debug, qemu_api_macros::Wrapper)]
> > > +pub struct IRQState(Opaque<bindings::IRQState>);
> > > +
> > >   /// Interrupt sources are used by devices to pass changes to a value (typically
> > >   /// a boolean).  The interrupt sink is usually an interrupt controller or
> > >   /// GPIO controller.
> > > @@ -22,8 +28,7 @@
> > >   /// method sends a `true` value to the sink.  If the guest has to see a
> > >   /// different polarity, that change is performed by the board between the
> > >   /// device and the interrupt controller.
> > > -pub type IRQState = bindings::IRQState;
> > > -
> > > +///
> > >   /// Interrupts are implemented as a pointer to the interrupt "sink", which has
> > >   /// type [`IRQState`].  A device exposes its source as a QOM link property using
> > >   /// a function such as [`SysBusDeviceMethods::init_irq`], and
> > > @@ -41,7 +46,7 @@ pub struct InterruptSource<T = bool>
> > >   where
> > >       c_int: From<T>,
> > >   {
> > > -    cell: BqlCell<*mut IRQState>,
> > > +    cell: BqlCell<*mut bindings::IRQState>,
> > 
> > Once we've already wrapper IRQState in Opaque<>, should we still use
> > bindings::IRQState?
> > 
> > Although InterruptSource just stores a pointer. However, I think we can
> > use wrapped IRQState here instead of the native binding type, since this
> > item is also crossing the FFI boundary. What do you think?
> 
> Using the wrapped IRQState would be a bit more code because you have to cast
> the pointer all the time when calling C code.  As far as correctness is
> concerned, it does not really matter because as you said it only stores a
> pointer.

Yes, it makes sense. This conversion doesn't block the current patch. The
correctness has been guaranteed.

> However, if needed, InterruptSource could have a function that converts from
> IRQState to Option<&Opaque<irq::IRQState>>.  Since the accessor is needed
> anyway, that would be a good place to put the conversion. 

Then I understand we still need `assert!(bql_locked())` in assessor as
the doc said: "it is possible to assert in the code that the right lock
is taken, to use it together with a custom lock guard type, or to let C
code take the lock, as appropriate."



