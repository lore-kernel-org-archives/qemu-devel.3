Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A667C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 09:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPdnP-00013c-Ud; Thu, 12 Jun 2025 05:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPdnN-00011Y-Mu; Thu, 12 Jun 2025 05:00:25 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPdnK-00005L-3p; Thu, 12 Jun 2025 05:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749718822; x=1781254822;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=uunrVqsDwUhwOpEvjWu0C+dxLc3o7sRI7x+svKoU9QM=;
 b=J+QFeoaERH4HoSAikZouppLvmTOEHl1Cq8YxA/fd94FND5eXH9M31eUk
 RYs7D+9qUzaaATBCiq7lYIdC2vVfv9b+NJk+z1QLK9uUeaku29QeVVfZQ
 F5IA5hyAElWBg8T8Nh5pY4L44MFw0ppP5RK1sfgUPhzc9kLX8e67OhMCx
 FN9QosTQuPO1jBS7GMsQsCXuzKE+TxRseKjt8h6AXAW4SQQZwN1VBxt6R
 0czGyXN5KMUXvEwef+8atQuIo3ajCK8o0sZMdonqa0rluZGcVkbOWkEgb
 U12ZO/IJPcv9yKous66Vlqf0uce4536a5eEKnv/BFRuaRpZUybCml17y0 w==;
X-CSE-ConnectionGUID: YiGsrBobSM+LqDBJXFIB5g==
X-CSE-MsgGUID: wIpsrb5CR4axzcNW3/M2cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="50996953"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="50996953"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 02:00:15 -0700
X-CSE-ConnectionGUID: ddP/SHrNQz2kh+pnVshG8g==
X-CSE-MsgGUID: TbezF1vPQvSJBrvMHBLRgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="148007715"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 12 Jun 2025 02:00:14 -0700
Date: Thu, 12 Jun 2025 17:21:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 4/5] rust: qom: make ParentInit lifetime-invariant
Message-ID: <aEqcGiGmZiMoIhY5@intel.com>
References: <20250609154423.706056-1-pbonzini@redhat.com>
 <20250609154423.706056-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609154423.706056-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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

On Mon, Jun 09, 2025 at 05:44:22PM +0200, Paolo Bonzini wrote:
> Date: Mon,  9 Jun 2025 17:44:22 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 4/5] rust: qom: make ParentInit lifetime-invariant
> X-Mailer: git-send-email 2.49.0
> 
> This is the trick that allows the parent-field initializer to be used
> only for the object that it's meant to be initialized.  This way,
> the owner of a MemoryRegion must be the object that embeds it.
> 
> More information is in the comments; it's best explained with a simplified
> example.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/qom.rs | 88 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 84 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
> index 21c271cd2f9..1481ef20f0c 100644
> --- a/rust/qemu-api/src/qom.rs
> +++ b/rust/qemu-api/src/qom.rs
> @@ -95,6 +95,7 @@
>  use std::{
>      ffi::{c_void, CStr},
>      fmt,
> +    marker::PhantomData,
>      mem::{ManuallyDrop, MaybeUninit},
>      ops::{Deref, DerefMut},
>      ptr::NonNull,
> @@ -208,12 +209,91 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
>  
>  /// This struct knows that the superclasses of the object have already been
>  /// initialized.
> -pub struct ParentInit<'a, T>(&'a mut MaybeUninit<T>);
> +///
> +/// The declaration of `ParentInit` is.. *"a kind of magic"*.  It uses a
> +/// technique that is found in several crates, the main ones probably being
> +/// `ghost-cell` (in fact it was introduced by the [`GhostCell` paper](https://plv.mpi-sws.org/rustbelt/ghostcell/))
> +/// and `generativity`.

From the paper, I understand this technique should be "branded type". :-)

> +/// The `PhantomData` makes the `ParentInit` type *invariant* with respect to
> +/// the lifetime argument `'init`.  This, together with the `for<'...>` in
> +/// `[ParentInit::with]`, block any attempt of the compiler to be creative when
> +/// operating on types of type `ParentInit` and to extend their lifetimes.  In
> +/// particular, it ensures that the `ParentInit` cannot be made to outlive the
> +/// `rust_instance_init()` function that creates it, and therefore that the
> +/// `&'init T` reference is valid.
> +///
> +/// This implementation of the same concept, without the QOM baggage, can help
> +/// understanding the effect:
> +///
> +/// ```
> +/// use std::marker::PhantomData;
> +///
> +/// #[derive(PartialEq, Eq)]
> +/// pub struct Jail<'closure, T: Copy>(&'closure T, PhantomData<fn(&'closure ()) -> &'closure ()>);
> +///
> +/// impl<'closure, T: Copy> Jail<'closure, T> {
> +///     fn get(&self) -> T {
> +///         *self.0
> +///     }
> +///
> +///     #[inline]
> +///     fn with<U>(v: T, f: impl for<'id> FnOnce(Jail<'id, T>) -> U) -> U {
> +///         let parent_init = Jail(&v, PhantomData);
> +///         f(parent_init)
> +///     }
> +/// }
> +/// ```
> +///
> +/// It's impossible to escape the `Jail`; `token1` cannot be moved out of the
> +/// closure:
> +///
> +/// ```ignore
> +/// let x = 42;
> +/// let escape = Jail::with(&x, |token1| {
> +///     println!("{}", token1.get());
> +///     token1

This line will fail to compile (the below comment "// fails to compile" seems
to indicate that println! will fail):

error: lifetime may not live long enough
  --> src/main.rs:22:9
   |
20 |     let escape = Jail::with(x, |token1| {
   |                                 ------- return type of closure is Jail<'2, i32>
   |                                 |
   |                                 has type `Jail<'1, i32>`
21 |         println!("{}", token1.get());
22 |         token1
   |         ^^^^^^ returning this value requires that `'1` must outlive `'2`


Referring to GhostToken::new() [*], it said:

        // Return the result of running `f`.  Note that the `GhostToken` itself
        // cannot be returned, because `R` cannot mention the lifetime `'id`, so
        // the `GhostToken` only exists within its scope.

So this example is good, I think just need to optimize the location of the error hint.

[*]: https://gitlab.mpi-sws.org/FP/ghostcell/-/blob/master/ghostcell/src/lib.rs#L128

> +/// });
> +/// // fails to compile:
> +/// println!("{}", escape.get());
> +/// ```
> +///
> +/// Likewise, in the QOM case the `ParentInit` cannot be moved out of
> +/// `instance_init()`. Without this trick it would be possible to stash a
> +/// `ParentInit` and use it later to access uninitialized memory.
> +///
> +/// Here is another example, showing how separately-created "identities" stay
> +/// isolated:
> +///
> +/// ```ignore
> +/// impl<'closure, T: Copy> Clone for Jail<'closure, T> {
> +///     fn clone(&self) -> Jail<'closure, T> {
> +///         Jail(self.0, PhantomData)
> +///     }
> +/// }
> +///
> +/// fn main() {
> +///     Jail::with(42, |token1| {
> +///         // this works and returns true: the clone has the same "identity"
> +///         println!("{}", token1 == token1.clone());
> +///         Jail::with(42, |token2| {
> +///             // here the outer token remains accessible...
> +///             println!("{}", token1.get());
> +///             // ... but the two are separate: this fails to compile:
> +///             println!("{}", token1 == token2);
> +///         });
> +///     });
> +/// }
> +/// ```
> +pub struct ParentInit<'init, T>(
> +    &'init mut MaybeUninit<T>,
> +    PhantomData<fn(&'init ()) -> &'init ()>,
> +);
>  
> -impl<'a, T> ParentInit<'a, T> {
> +impl<'init, T> ParentInit<'init, T> {
>      #[inline]
> -    pub fn with(obj: &'a mut MaybeUninit<T>, f: impl FnOnce(ParentInit<'a, T>)) {
> -        let parent_init = ParentInit(obj);
> +    pub fn with(obj: &'init mut MaybeUninit<T>, f: impl for<'id> FnOnce(ParentInit<'id, T>)) {
> +        let parent_init = ParentInit(obj, PhantomData);

I think it's also valuable to add the similar comment as GhostToken did,
mentioning this `f` can't reture ParentInit itself.

>          f(parent_init)
>      }
>  }
> -- 
> 2.49.0
> 

Nice comment and nice reference (learned a lot).

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



