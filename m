Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71891E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAJY-0003ab-JY; Mon, 16 Dec 2024 07:35:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNAJV-0003PL-No; Mon, 16 Dec 2024 07:35:06 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNAJS-0002PX-Ha; Mon, 16 Dec 2024 07:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734352502; x=1765888502;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=PJbQUpSzHru3Or0Hsk5sXZKTXf6u8uddRQxbCcbgebA=;
 b=BvBeivy8Z5E+E3wXfyeovSG6J5WD3P9Zy0IjZhcVrKIC1b/Ho4RVfavV
 qlNM4lbgyQsdaa2r1IHGGdTiaTcNBdXgtklkyvtXz6XuL1ZA6Gvg5ysyN
 VzAl7GawO8OTqeHyR6l26Wys68PP8OyZQKRV0TwqoP7j7/cTtdbPbe6fi
 myJ2vPaaDxFGhyl6lPb1gW9vdly26p79uKuoQOTnQfJ4YBFe6iMF21qdH
 drW7HQXEEtuyp/rG2ZYefXAAJv4KbatjSM7d7xeXvY5Nt6tEqogNd7f3G
 XOahy9FmrH1fnK7ySZtWFw0rwzC168War+Y/7oW+kBadj7+5lvDevcnXd A==;
X-CSE-ConnectionGUID: MXuPkOKaSUqyraAJ+qo4+A==
X-CSE-MsgGUID: LwjJ6sP2Rw2YYadpXccAiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34880277"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; d="scan'208";a="34880277"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2024 04:34:58 -0800
X-CSE-ConnectionGUID: 5v5vmB0NSw+oliPe7HCIzA==
X-CSE-MsgGUID: YoukiSnhTLyh4FWjfkGsww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="120442632"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 16 Dec 2024 04:34:57 -0800
Date: Mon, 16 Dec 2024 20:53:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 22/26] rust: qom: add casting functionality
Message-ID: <Z2Ai0Ipv9RtwQndB@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-23-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-23-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

> +/// Macro to mark superclasses of QOM classes.  This enables type-safe
> +/// up- and downcasting.
> +///
> +/// # Safety
> +///
> +/// This macro is a thin wrapper around the [`IsA`] trait and performs
> +/// no checking whatsoever of what is declared.  It is the caller's
> +/// responsibility to have $struct begin, directly or indirectly, with
> +/// a field of type `$parent`.
> +#[macro_export]
> +macro_rules! qom_isa {
> +    ($struct:ty : $($parent:ty),* ) => {

This macro is quite good, but it requires specifying all the parents...
So I am thinking if it is possible to move ParentType to ObjectType, and
then try to traverse the ParentType in the macro, implementing IsA for
each ParentType... However, the first difficulty has already stopped me:
I cannot define ParentType for Object itself.

> +        $(
> +            // SAFETY: it is the caller responsibility to have $parent as the
> +            // first field
> +            unsafe impl $crate::qom::IsA<$parent> for $struct {}
> +
> +            impl AsRef<$parent> for $struct {
> +                fn as_ref(&self) -> &$parent {
> +                    // SAFETY: follows the same rules as for IsA<U>, which is
> +                    // declared above.
> +                    let ptr: *const Self = self;
> +                    unsafe { &*ptr.cast::<$parent>() }
> +                }
> +            }
> +        )*
> +    };
> +}
>  
>  unsafe extern "C" fn rust_instance_init<T: ObjectImpl>(obj: *mut Object) {
>      // SAFETY: obj is an instance of T, since rust_instance_init<T>
> @@ -94,8 +147,224 @@ pub unsafe trait ObjectType: Sized {
>      /// The name of the type, which can be passed to `object_new()` to
>      /// generate an instance of this type.
>      const TYPE_NAME: &'static CStr;
> +
> +    /// Return the receiver as an Object.  This is always safe, even
> +    /// if this type represents an interface.

This comment is a bit confusing to me... EMM, why mention the interface?
I understand if something implements ObjectType, then it should be an
Object, so deref/cast here would be valid. And if it is an interface,
it would need to implement the corresponding trait.

...

This cast idea is nice! In the future, class might also need to implement
similar cast support (e.g., class_init in virtio).

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



