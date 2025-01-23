Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BD9C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 09:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tat9U-00041V-QI; Thu, 23 Jan 2025 04:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tat9R-00041J-Ok; Thu, 23 Jan 2025 04:05:25 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tat9N-0002ih-Md; Thu, 23 Jan 2025 04:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737623122; x=1769159122;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hu9u32yL3yzPovbh79n//6bS6f/cnZyQCC+CXnJQj7s=;
 b=WNwVa+c/0tlJl5suxWNHaL/FVRp2cuBpGInNpQxvXD83tXIiaZwW9XEl
 gD4wBHjhSdYl7iFgxZlsNxCRnedm93exFM/cpn2iUTJ/XvkqOVJqa7lGZ
 Qu6c1YAIu3EDP7PIDMIxlPjkxCQEHSraoAwwrjgqusQ6SLf/BWbTrAjoW
 SqNB7Zpfnh4oc6YbnjUVM6UzehpWwD0zUvU8thTLj9RyDXTAluVvD/rs+
 n221amz2RvvSFPQK1onkJ9kJJe8o1dvXK3g2+KQlrnZFJoTyWtU0R3DoA
 iUCYxe1+r+bar5hA8zSnJT/2NfJKZW4p9d+5Xx9EF4Bb54zbfUx1Z2KEY Q==;
X-CSE-ConnectionGUID: wGPJ6Sj7QMCnz1WbGSwsPw==
X-CSE-MsgGUID: EIyBLHjAQOCSajZqEDyIag==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="38260471"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; d="scan'208";a="38260471"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2025 01:05:19 -0800
X-CSE-ConnectionGUID: A21SoZo6QHqwftZeSwlt8Q==
X-CSE-MsgGUID: L1vK8jpiTDir0NBvT6Z4MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="107832495"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 23 Jan 2025 01:05:17 -0800
Date: Thu, 23 Jan 2025 17:24:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Subject: Re: [PATCH 07/10] rust: pl011: wrap registers with BqlRefCell
Message-ID: <Z5IK1zuMJS+P3t9j@intel.com>
References: <20250117092657.1051233-1-pbonzini@redhat.com>
 <20250117092657.1051233-8-pbonzini@redhat.com>
 <Z5HX2G0+bt+3vzVB@intel.com>
 <CABgObfYRG-BFGj3cK4xz_PZYSiVgCY-YkSJitQMSk=2AtkcBcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfYRG-BFGj3cK4xz_PZYSiVgCY-YkSJitQMSk=2AtkcBcA@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

> > >  #[repr(C)]
> > > -#[derive(Debug, qemu_api_macros::Object, qemu_api_macros::offsets)]
> >
> > This is the issue I also met, so why not drive "Debug" for BqlRefCell?
> >
> 
> Because it is not entirely possible to do it safely--there could be
> outstanding borrows that break invariants and cause debug() to fail. Maybe
> we could implement it on BqlRefCell<PL011Registers> with a custom derive
> macro...
> 
> RefCell doesn't implement Debug either for the same reason.

Thank you for the clarification, I understand now (I was indeed puzzled
as to why RefCell didn't do this).

> I tried to do this in [*]. Do we need to reconsider this?
> >
> > [*]:
> > https://lore.kernel.org/qemu-devel/20241205060714.256270-3-zhao1.liu@intel.com/
> >
> > > +#[derive(qemu_api_macros::Object, qemu_api_macros::offsets)]
> > >  /// PL011 Device Model in QEMU
> > >  pub struct PL011State {
> > >      pub parent_obj: ParentField<SysBusDevice>,
> > >      pub iomem: MemoryRegion,
> > >      #[doc(alias = "chr")]
> > >      pub char_backend: CharBackend,
> > > -    pub regs: PL011Registers,
> > > +    pub regs: BqlRefCell<PL011Registers>,
> >
> > This is a good example on the usage of BqlRefCell!
> >
> > //! `BqlRefCell` is best suited for data that is primarily accessed by the
> > //! device's own methods, where multiple reads and writes can be grouped
> > within
> > //! a single borrow and a mutable reference can be passed around. "
> >
> 
> Yeah, the comment was inspired by this usage and not vice versa. :D
> 
> >      /// QEMU interrupts
> > >      ///
> > >      /// ```text
> > > @@ -530,8 +530,8 @@ fn post_init(&self) {
> > >          }
> > >      }
> > >
> > > +    #[allow(clippy::needless_pass_by_ref_mut)]
> >
> > How did you trigger this lint error? I switched to 1.84 and didn't get
> > any errors (I noticed that 1.84 fixed the issue of ignoring `self` [*],
> > but it still doesn't seem to work on my side).
> >
> 
> I will double check. But I do see that there is no mut access inside, at
> least not until the qemu_chr_fe_accept_input() is moved here. Unfortunately
> until all MemoryRegion and CharBackend bindings are available the uses of
> &mut and the casts to *mut are really really wonky.

yes, I agree here we should remove mut :-). (if needless_pass_by_ref_mut
doesn't work on this place, I think we can drop it.)

> (On the other hand it wouldn't be possible to have a grip on the qemu_api
> code without users).
> 
> Paolo
> 
> > @@ -603,19 +603,19 @@ pub fn realize(&mut self) {
> > >      }
> > >
> > >      pub fn reset(&mut self) {
> >
> > In principle, this place should also trigger `needless_pass_by_ref_mut`.
> >
> 
> Yes but clippy hides it because this function is assigned to a function
> pointer const. At least I think so---the point is more generally that you
> can't change &mut to & without breaking compilation.

Make sense!

> > > -        self.regs.reset();
> > > +        self.regs.borrow_mut().reset();
> > >      }
> >
> > [snip]
> >
> > > @@ -657,10 +657,10 @@ pub fn post_load(&mut self, _version_id: u32) ->
> > Result<(), ()> {
> > >  pub unsafe extern "C" fn pl011_receive(opaque: *mut c_void, buf: *const
> > u8, size: c_int) {
> > >      unsafe {
> > >          debug_assert!(!opaque.is_null());
> > > -        let mut state =
> > NonNull::new_unchecked(opaque.cast::<PL011State>());
> > > +        let state = NonNull::new_unchecked(opaque.cast::<PL011State>());
> >
> > Perhaps we can use NonNull::new and unwrap()? Then debug_assert! is
> > unnecessary.
> >
> > let state = unsafe {
> > NonNull::new(opaque.cast::<PL011State>()).unwrap().as_ref() };
> >
> 
> Yeah, though that's preexisting and it's code that will go away relatively
> soon. I tried to minimize unrelated changes and changes to these temporary
> unsafe functions, but in some cases there were some that sneaked in.
> 
> Let me know what you prefer.
>

I prefer to use NonNull::new and unwrap(). Too much assert() pattern is
not user-friendly. I also think it's unnecessary to change NonNull
interface in this patch, we can see what's left when you're done with
the most QAPI work.

Thanks,
Zhao



