Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A35C369C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 09:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4yyv-0005Kk-Pl; Wed, 16 Apr 2025 05:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4yyr-0005Jw-BD; Wed, 16 Apr 2025 05:22:53 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4yym-0000tv-Gj; Wed, 16 Apr 2025 05:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744795368; x=1776331368;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6kkcbVRiGm+IDFcg7xHiAdB1rRbDbGRHT6//Z+zcFLk=;
 b=b8hPub37RqMhQpN4nlhtfr/EFSQan64j7pxvh8UvdEHtZING4Edym62+
 FcHDolSZ6yqKpzJz5y1yPZ6AoCCu18VKniFMMJib0TtH8KMNLQAc0PvXC
 SJXZKfPRL3+1+/ZI0b1oR2l6h+xMMiOiSg9KK94K2gYwmTjIs34AMYTZU
 oxxGJ40x4e3OOikx6s3818XwiMbiNU2Ffgl/Ba4H+9j8NY7NtiTquHJ44
 xLeIzk+6PCrnng7OST5h5u1pXBfxPBVKDnMJyGTrdgLsXNQ8b6BEj490R
 vCrbyBn52ZL2KPh0FEHcxHhpRyyBWaNOf7zsTjUkD2avjClLKOjra0EOL w==;
X-CSE-ConnectionGUID: emqHGqJLSRag8M9SKzJS0g==
X-CSE-MsgGUID: alXW0CUXQXmSgk4tebQvhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="50155941"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; d="scan'208";a="50155941"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2025 02:22:41 -0700
X-CSE-ConnectionGUID: xmyv6m72SEiny3VSLNijcQ==
X-CSE-MsgGUID: hqWxc7wwRA20jBy7Pxm8dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; d="scan'208";a="130923475"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 16 Apr 2025 02:22:40 -0700
Date: Wed, 16 Apr 2025 17:43:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 2/9] rust/vmstate: Support varray's num field wrapped in
 BqlCell
Message-ID: <Z/97xG5VONqmlK+7@intel.com>
References: <20250414144943.1112885-1-zhao1.liu@intel.com>
 <20250414144943.1112885-3-zhao1.liu@intel.com>
 <c44eebb9-1252-447e-9262-e2946f90f01c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c44eebb9-1252-447e-9262-e2946f90f01c@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
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

On Tue, Apr 15, 2025 at 12:54:51PM +0200, Paolo Bonzini wrote:
> Date: Tue, 15 Apr 2025 12:54:51 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 2/9] rust/vmstate: Support varray's num field wrapped
>  in BqlCell
> 
> On 4/14/25 16:49, Zhao Liu wrote:
> > Currently, if the `num` field of a varray is not a numeric type, such as
> > being placed in a wrapper, the array variant of assert_field_type will
> > fail the check.
> > 
> > HPET currently wraps num_timers in BqlCell<>. Although BqlCell<> is not
> > necessary from strictly speaking, it makes sense for vmstate to respect
> > BqlCell.
> 
> Dropping BqlCell<> from num_timers is indeed possible.

I can move the num_timers adjustment from realize() into init().

> But I agree that getting BqlCell<> varrays to work is a good thing anyway;

While num_timers can get out of BqlCell<>, num_timers_save is still
needed to stay in BqlCell<>, since I understand pre_save - as a callback
of the vmstate - still needs the bql protection.

So this patch is still necessary to support migration for HPET.

> then you can separately decide whether to drop BqlCell<> from num_timers.

Yes. In the next version, I can drop BqlCell<> and adjust the C version
as well. But then I can't update the document at the same time, because
the document needs to list the synchronized commit ID. I can update the
document after the HPET migration is able to be merged.

> > The failure of assert_field_type is because it cannot convert BqlCell<T>
> > into usize for use as the index.
> > 
> > Therefore, first, implement `From` trait for common numeric types on
> > BqlCell<>. Then, abstract the wrapper and non-wrapper cases uniformly
> > into a `IntoUsize` trait and make assert_field_type to get usize type
> > index via `IntoUsize` trait.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   rust/qemu-api/src/assertions.rs | 30 +++++++++++++++++++++++++++++-
> >   rust/qemu-api/src/cell.rs       | 23 +++++++++++++++++++++++
> >   2 files changed, 52 insertions(+), 1 deletion(-)
> 
> I think you can drop the "num=" case of assert_field_type!, and use
> something like this macro:
> 
> /// Drop everything up to the colon, with the intention that
> /// `if_present!` is called inside an optional macro substitution
> /// (such as `$(... $arg ...)?` or `$(... $arg ...)*`).  This allows
> /// expanding `$result` depending on the presence of an argument,
> /// even if the argument itself is not included in `$result`.
> ///
> /// # Examples
> ///
> /// ```
> /// # use qemu_api::if_present;
> /// macro_rules! is_present {

I understand this is_present could have another name to avoid confusion
with our real is_present macro.

> ///     ($($cond:expr)?) => {
> ///         loop {
> ///             $(if_present!([$cond]: break true;);)?
> ///             #[allow(unreachable_code)]
> ///             break false;
> ///         }
> ///     }
> /// }
> ///
> /// assert!(!is_present!());
> /// assert!(is_present!("abc"));
> /// ```
> #[macro_export]
> macro_rules! if_present {
>      ([$($cond:tt)*]: $($result:tt)*) => { $($result)* };
> }
> 
> to expand the array part of the access:
> 
> assert_field_type!(...
>     $($crate::if_present!([$num]: [0]))?;

This example remind me that I introduced a bug into array part:

    let index: usize = v.$num.try_into().unwrap();
    types_must_be_equal::<_, &$ti>(&v.$i[index]);

In the current code, actually it accesses v[num], but when num
stores the length of the whole array, it will cause index out of bounds.

So for current code, at least it should access `v.i[num - 1]`:

    let index: usize = v.$num.try_into().unwrap() - 1; // access the last element.
    types_must_be_equal::<_, &$ti>(&v.$i[index]);

> );
> 
> With this change, assert_field_type! is nicer and at least the trait you're
> introducing in assertions.rs goes away...

Yes! Great idea.

Then with your help, we could integrate the array part like:

#[macro_export]
macro_rules! if_present {
    ([$($cond:tt)*]: $($result:tt)*) => { $($result)* };
}

...

#[macro_export]
macro_rules! assert_field_type {
    ($t:ty, $i:tt, $ti:ty $(, $num:ident)?) => {
        const _: () = {
            #[allow(unused)]
            fn assert_field_type(v: $t) {
                fn types_must_be_equal<T, U>(_: T)
                where
                    T: $crate::assertions::EqType<Itself = U>,
                {
                }

                let access = v.$i$($crate::if_present!([$num]: [v.$num - 1])])?;
                types_must_be_equal::<_, $ti>(access);
            }
        };
    };
}

> > +// Orphan rules don't like something like `impl<T> From<BqlCell<T>> for T`.
> > +// It's enough to just implement Into for common types.
> > +macro_rules! impl_into_inner {
> > +    ($type:ty) => {
> > +        impl From<BqlCell<$type>> for $type {
> > +            fn from(c: BqlCell<$type>) -> $type {
> > +                c.get()
> > +            }
> > +        }
> > +    };
> > +}
> 
> ... and it's not clear to me whether this is needed with the change above?
> Would impl_vmstate_transparent!'s definition of VARRAY_FLAG be enough?

If I change the array part like (the change is needed because: cannot
subtract `{integer}` from `BqlCell<u8>`):

- let access = v.$i$([$crate::if_present!([$num]: v.$num) - 1])?;
+ let access = v.$i$([$crate::if_present!([$num]: v.$num).into() - 1])?;

Then there'll be an error:

85   | macro_rules! assert_field_type {
     | ------------------------------ in this expansion of `$crate::assert_field_type!` (#2)
...
96   |                 let access = v.$i$([$crate::if_present!([$num]: v.$num).into() - 1])?;
     |                                                                         ^^^^ cannot infer type


This is because I want to also check whether "num" would cause index out
of bounds. If we just check the [0] element, then everything is OK...

> If not, I *think* you can do a blanket implementation of Into<T> for
> BqlCell<T>.  Maybe that's nicer, you can decide.

I tired this way, but there's 2 difficulities:
 * Into<T> for BqlCell<T> will violate coherence rules:

error[E0119]: conflicting implementations of trait `Into<_>` for type `cell::BqlCell<_>`
   --> qemu-api/src/cell.rs:312:1
    |
312 | impl<T> Into<T> for BqlCell<T> {}
    | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    |
    = note: conflicting implementation in crate `core`:
            - impl<T, U> Into<U> for T
              where U: From<T>;

 * As index, we need to convert BqlCell<T> into T and then convert T
   into usize. :-(

Do you think there is a better way to check array[num -1]? (array's
len() method also returns usize).

Or do you think whether it's necessary to check array[num -1]?
(referring to C version, for example, VMSTATE_STRUCT_VARRAY_UINT8, it
doesn't check the array's out of bounds case.)

Thanks,
Zhao


