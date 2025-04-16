Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26FBC369C2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 12:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u51qi-0000qs-Uy; Wed, 16 Apr 2025 08:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u51eO-0001BP-Sy; Wed, 16 Apr 2025 08:13:58 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u51eI-0002PE-F6; Wed, 16 Apr 2025 08:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744805631; x=1776341631;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=BCu7uGJI12d9kaGwBw0mVPWM82NUyxixbN4TgRX2RPg=;
 b=anKSQWkiJ9D/hV3QWVziZmgX5M9F0K5RjgvtaJ/U/F99HthqFoy+k//b
 l5dKOWeLNPlCG41CiBBDB6uil7RMsbxwEweoWehtY7qJeSivuJuUMMze/
 6c7O6zP6qO+vcNt6Wq1G8pkpuKSWbpb+9Up0GsGp0zbB1I3qKyhBQ/cXP
 2wV6TDXEClq3E4992yveatXUyUvCzzEi12Ctmr751jEMJjw5MyNA2XR4v
 Cje7wRQJpbzl06UGiAN6H5dRaZw03Bpw8QCGwDxihFkCVKI9xOV8JQpZZ
 B5k5xhohmZLtLvYfQIOTBeqr/XPsPw3sRUnu0v/5s+NwbEhcFw/qYEnHe g==;
X-CSE-ConnectionGUID: ZPKjDVq/Q4GMEKGQuymDbQ==
X-CSE-MsgGUID: uj3/TbR7S16AHVjUi4glTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="56984908"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; d="scan'208";a="56984908"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2025 05:13:47 -0700
X-CSE-ConnectionGUID: XmmKXVy8SqWwE1vkTlRKig==
X-CSE-MsgGUID: oS8JfjvrT6qst16OYfIHZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; d="scan'208";a="167626400"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 16 Apr 2025 05:13:46 -0700
Date: Wed, 16 Apr 2025 20:34:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 2/9] rust/vmstate: Support varray's num field wrapped in
 BqlCell
Message-ID: <Z/+j3be+ZT7G1ToL@intel.com>
References: <20250414144943.1112885-1-zhao1.liu@intel.com>
 <20250414144943.1112885-3-zhao1.liu@intel.com>
 <c44eebb9-1252-447e-9262-e2946f90f01c@redhat.com>
 <Z/97xG5VONqmlK+7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/97xG5VONqmlK+7@intel.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

> > #[macro_export]
> > macro_rules! if_present {
> >      ([$($cond:tt)*]: $($result:tt)*) => { $($result)* };
> > }
> > 
> > to expand the array part of the access:
> > 
> > assert_field_type!(...
> >     $($crate::if_present!([$num]: [0]))?;
> 
> This example remind me that I introduced a bug into array part:
> 
>     let index: usize = v.$num.try_into().unwrap();
>     types_must_be_equal::<_, &$ti>(&v.$i[index]);
> 
> In the current code, actually it accesses v[num], but when num
> stores the length of the whole array, it will cause index out of bounds.
> 
> So for current code, at least it should access `v.i[num - 1]`:
> 
>     let index: usize = v.$num.try_into().unwrap() - 1; // access the last element.
>     types_must_be_equal::<_, &$ti>(&v.$i[index]);

I realize that my thinking was wrong here! The `v` (with specific type)
isn't a valid instance, and the variable `num` being passed isn't
correctly initialized. Therefore, checking `num`'s value here is
meaningless; it's enough to just check if the type matches!

> > );
> > 
> > With this change, assert_field_type! is nicer and at least the trait you're
> > introducing in assertions.rs goes away...
> 
> Yes! Great idea.
> 
> Then with your help, we could integrate the array part like:
> 
> #[macro_export]
> macro_rules! if_present {
>     ([$($cond:tt)*]: $($result:tt)*) => { $($result)* };
> }
> 
> ...
> 
> #[macro_export]
> macro_rules! assert_field_type {
>     ($t:ty, $i:tt, $ti:ty $(, $num:ident)?) => {
>         const _: () = {
>             #[allow(unused)]
>             fn assert_field_type(v: $t) {
>                 fn types_must_be_equal<T, U>(_: T)
>                 where
>                     T: $crate::assertions::EqType<Itself = U>,
>                 {
>                 }
> 
>                 let access = v.$i$($crate::if_present!([$num]: [v.$num - 1])])?;

So, the correct code should just check array[0] as you said:

let access = v.$i$($crate::if_present!([$num]: [0])])?;

Based on this, there's no need for anything else such as `Into`.

>                 types_must_be_equal::<_, $ti>(access);
>             }
>         };
>     };
> }

Thanks,
Zhao


