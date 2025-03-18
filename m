Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B268FC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 06:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuQFe-0004D0-D2; Tue, 18 Mar 2025 02:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuQFa-0004AO-BJ; Tue, 18 Mar 2025 02:16:30 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuQFX-0003Z8-EG; Tue, 18 Mar 2025 02:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742278588; x=1773814588;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fOECzhny/oA7GZROn9Pky9w6OPheaR0WCegJEIidTKI=;
 b=MDuvNl2lgBKGobfr7bR516lkmsIHHHSoyGJIAUDP9SCgGamErWanhDwJ
 FVhRizWDBTYP4swVMni+ae/wHl1mjmNM7dP0hTFsWCslxy5pG2olUzaQk
 78JCY7Ijr4vEp5u1exLzGPu0N0PqC9NgiLg1cKk+LOMLgs6D0aMW7Fmsc
 BdKEEBMqj6HvWMs422r2Am2WWTqnHZF2TqtRQbUyqLOrlcEeOgNHF4+Ki
 cbsybzIE5O77Sl61uFAt8eQjT3ADH+uPu8R1xa/tcTWbA/P28zQXpPWRF
 YGKP6Q5tmYBEE6/Wdl1zmnNX7hTcAMxV0u0ck0keKyAaMKojXc/TganMt g==;
X-CSE-ConnectionGUID: pEiKP1hWQB+GMuqoLYtXEA==
X-CSE-MsgGUID: 9KQx9SajRU22/ahld3Ip3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54776627"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="54776627"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 23:16:24 -0700
X-CSE-ConnectionGUID: /4Tq/5tkTkSWxh7EGC7vmw==
X-CSE-MsgGUID: a151oO44Sea+hAskit1wFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="122176472"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 17 Mar 2025 23:16:22 -0700
Date: Tue, 18 Mar 2025 14:36:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 13/17] rust/vmstate: Support vmstate_validate
Message-ID: <Z9kUdJUP0JrkcKMJ@intel.com>
References: <20250317151236.536673-1-zhao1.liu@intel.com>
 <20250317151236.536673-14-zhao1.liu@intel.com>
 <CABgObfauvyAbmt7GewurAEw9d+HanhjvDa1tT=S_4Oo9Huty0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfauvyAbmt7GewurAEw9d+HanhjvDa1tT=S_4Oo9Huty0g@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

> > +#[doc(alias = "VMSTATE_VALIDATE")]
> > +#[macro_export]
> > +macro_rules! vmstate_validate {
> > +    ($struct_name:ty, $test_name:expr, $test_fn:expr $(,)?) => {
> > +        $crate::bindings::VMStateField {
> > +            name: ::std::ffi::CStr::as_ptr($test_name),
> > +            // TODO: Use safe callback.
> 
> Why is the TODO still there?

I forgot to delete this comment...

> > +            field_exists: {
> > +                const fn test_cb_builder__<
> > +                    T,
> > +                    F: for<'a> $crate::callbacks::FnCall<(&'a T, u8), bool>,
> > +                >(
> > +                    _phantom: ::core::marker::PhantomData<F>,
> > +                ) -> $crate::vmstate::VMSFieldExistCb {
> > +                    let _: () = F::ASSERT_IS_SOME;
> > +                    $crate::vmstate::rust_vms_test_field_exists::<T, F>
> > +                }
> > +
> > +                const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> {
> > +                    ::core::marker::PhantomData
> > +                }
> > +                Some(test_cb_builder__::<$struct_name, _>(phantom__(&$test_fn)))
> > +            },
> > +            ..$crate::zeroable::Zeroable::ZERO
> > +        }
> > +        .with_exist_check()
> > +    };
> 
> Would it be possible, or make sense, to move most of the code for
> field_exists inside .with_exist_check()?
> 

If so, the method would be like:

    pub fn with_exist_check<T, F>(
         mut self,
         _cb: F
     ) -> Self
     where
         F: for<'a> FnCall<(&'a T, u8), bool>,

Then the use case could be like:

    vmstate_struct!(HPETState, timers[0 .. num_timers], &VMSTATE_HPET_TIMER,
BqlRefCell<HPETTimer>).with_exist_check<HPETState, _>(foo_field_check),

Here we need to specify the structure type in with_exist_check, though it's
already specified in vmstate_struct as the first field.

In this way, I understand with_exist_check() doesn't need phantom__()
trick.

Instead, (after I dropped the few patches you mentioned,) now vmstate_of
& vmstate_struct could accept the optional "test_fn" field (luckily, at
least test_fn can still be parsed!), then the example would be:

    vmstate_struct!(HPETState, timers[0 .. num_timers], &VMSTATE_HPET_TIMER,
BqlRefCell<HPETTimer>, foo_field_check)

And in this way, phantom__() is necessary.

So I think the main issue is the format, which do you prefer?

Thanks,
Zhao


