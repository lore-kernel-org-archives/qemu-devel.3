Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969B8E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 15:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVBRr-00019j-1B; Tue, 07 Jan 2025 10:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVBRn-00019M-OS; Tue, 07 Jan 2025 10:24:47 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVBRk-0003jp-RJ; Tue, 07 Jan 2025 10:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736263485; x=1767799485;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=TIIM4dkj0OCU1RcFETy0gaMxAsMM7RGugczvPHwe4Zo=;
 b=SMItgzSN5y1FTEUooomrzEO2/Mp015UOJADYt5HL8vz2Rf0BzrQwo+Co
 EO4Ho2+ek7I+qsvCdr4aeKoXLOwL7pB2uL4dNX2fNJguJrEBo6inZ+Ymp
 QdZ6s5TN4U0BtMB9rmaUQ3rtsbOffY7fzXGACP1FoLKlXzhAliOj6HJep
 qbD1WR1tsc18ezgVfCVa6dvOjNLLyYI9hF7lxTy9X+xBOSrUj7rAhiV6K
 854LuuHVKXW9rrOSuoyDxkyk7nDVJ7Gzv0EXZahWCBh3k5tqk/eZ9t1Lm
 /fqUM+vCgf+ehLz8WJC0C4bFa597PBQjHRD4W7JtPTFteQtWqH8sTxFan g==;
X-CSE-ConnectionGUID: lvwt563PRi+FYaBlMVUvnQ==
X-CSE-MsgGUID: eaGsVRjYSlaZFaBWmLh3jA==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="53869682"
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; d="scan'208";a="53869682"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2025 07:24:39 -0800
X-CSE-ConnectionGUID: 6pRcvfvdQOG3g0wiFP28Aw==
X-CSE-MsgGUID: oG3Lstq1RaCMyT0mDjn9uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,295,1728975600"; d="scan'208";a="103307912"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 07 Jan 2025 07:24:37 -0800
Date: Tue, 7 Jan 2025 23:43:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [RFC PATCH 2/9] rust: vmstate: implement VMState for non-leaf
 types
Message-ID: <Z31LnWiD8jysxBGv@intel.com>
References: <20241231002336.25931-1-pbonzini@redhat.com>
 <20241231002336.25931-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231002336.25931-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
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

On Tue, Dec 31, 2024 at 01:23:29AM +0100, Paolo Bonzini wrote:
> Date: Tue, 31 Dec 2024 01:23:29 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [RFC PATCH 2/9] rust: vmstate: implement VMState for non-leaf types
> X-Mailer: git-send-email 2.47.1
> 
> Arrays, pointers and cells use a VMStateField that is based on that
> for the inner type.  The implementation therefore delegates to the
> VMState implementation of the inner type.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/vmstate.rs | 66 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
> index bfcf06e8f1d..e20f27b172b 100644
> --- a/rust/qemu-api/src/vmstate.rs
> +++ b/rust/qemu-api/src/vmstate.rs
> @@ -19,8 +19,9 @@
>  //!   `include/migration/vmstate.h`. These are not type-safe and should not be
>  //!   used if the equivalent functionality is available with `vmstate_of!`.
>  
> -use core::marker::PhantomData;
> +use core::{marker::PhantomData, mem, ptr::NonNull};
>  
> +use crate::bindings::VMStateFlags;
>  pub use crate::bindings::{VMStateDescription, VMStateField};
>  
>  /// This macro is used to call a function with a generic argument bound
> @@ -108,6 +109,69 @@ pub const fn with_version_id(mut self, version_id: i32) -> Self {
>          self.version_id = version_id;
>          self
>      }
> +
> +    #[must_use]
> +    pub const fn with_array_flag(mut self, num: usize) -> Self { 
> +        assert!(num <= 0x7FFF_FFFFusize);

I see, this is the similar case to check overflow like your comment for
patch 1. I think we can use i32::MAX to avoid such magic number.

> +        assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) == 0);

Do we need to also check varray flags? e.g.,

But the doc (in vmstate.h) of VMS_ARRAY said "May not be combined with
VMS_VARRAY*", I understand VMS_ARRAY shouldn't be combined with
VMS_VARRAY*, am I right?

If so, we can add a simple const variable that combines all VARRY flags,
e.g,

const VMS_VARRAY_FLAGS: VMStateFlags = VMStateFlags(
    VMStateFlags::VMS_VARRAY_INT32.0 |
    VMStateFlags::VMS_VARRAY_UINT8.0 |
    VMStateFlags::VMS_VARRAY_UINT16.0 |
    VMStateFlags::VMS_VARRAY_UINT32.0
);

...

assert!((self.flags.0 & VMS_VARRAY_FLAGS.0) == 0);

> +        if (self.flags.0 & VMStateFlags::VMS_POINTER.0) != 0 {
> +            self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_POINTER.0);
> +            self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_ARRAY_OF_POINTER.0);
> +        }
> +        self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_SINGLE.0);
> +        self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_ARRAY.0);
> +        self.num = num as i32;
> +        self
> +    }
> +
> +    #[must_use]
> +    pub const fn with_pointer_flag(mut self) -> Self {
> +        assert!((self.flags.0 & VMStateFlags::VMS_POINTER.0) == 0);

Maybe VMS_ARRAY_OF_POINTER should be checked here as well?

> +        self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_POINTER.0);
> +        self
> +    }
> +}
> +
> +// Transparent wrappers: just use the internal type
> +
> +macro_rules! impl_vmstate_transparent {
> +    ($type:ty where $base:tt: VMState $($where:tt)*) => {
> +        unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
> +            const BASE: VMStateField = VMStateField {
> +                size: mem::size_of::<$type>(),
> +                ..<$base as VMState>::BASE
> +            };
> +        }
> +    };
> +}
> +
> +impl_vmstate_transparent!(std::cell::Cell<T> where T: VMState);
> +impl_vmstate_transparent!(std::cell::UnsafeCell<T> where T: VMState);
> +impl_vmstate_transparent!(crate::cell::BqlCell<T> where T: VMState);
> +impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
> +
> +// Pointer types using the underlying type's VMState plus VMS_POINTER
> +
> +macro_rules! impl_vmstate_pointer {
> +    ($type:ty where $base:tt: VMState $($where:tt)*) => {
> +        unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
> +            const SCALAR_TYPE: VMStateFieldType = <T as VMState>::SCALAR_TYPE;

Rebase issue: SCALAR_TYPE is introduced in patch 5.

> +            const BASE: VMStateField = <$base as VMState>::BASE.with_pointer_flag();
> +        }
> +    };
> +}
> +
> +impl_vmstate_pointer!(*const T where T: VMState);
> +impl_vmstate_pointer!(*mut T where T: VMState);
> +impl_vmstate_pointer!(NonNull<T> where T: VMState);
> +impl_vmstate_pointer!(Option<NonNull<T>> where T: VMState);
> +
> +// Arrays using the underlying type's VMState plus
> +// VMS_ARRAY/VMS_ARRAY_OF_POINTER
> +
> +unsafe impl<T: VMState, const N: usize> VMState for [T; N] {
> +    const SCALAR_TYPE: VMStateFieldType = <T as VMState>::SCALAR_TYPE;

Ditto.

> +    const BASE: VMStateField = <T as VMState>::BASE.with_array_flag(N);
>  }
>  
>  #[doc(alias = "VMSTATE_UNUSED_BUFFER")]
> -- 
> 2.47.1
>

Overall, I think this patch handles the array/pointer/cell cases very
well. So (with some nits fixed :-)),

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


