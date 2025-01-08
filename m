Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D546AE77197
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 03:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVMS2-0003kM-AG; Tue, 07 Jan 2025 22:09:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVMS0-0003k9-7c; Tue, 07 Jan 2025 22:09:44 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVMRx-0003c1-RI; Tue, 07 Jan 2025 22:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736305782; x=1767841782;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=venH0gsGse56FvTnI1E73uXmJ/NSnyci+2xe3OHoz5w=;
 b=HUXqNcL4kspWpscsX1QbbyvgEfylw2qvd2Yk0Vheew29hskVzhrE1mwy
 hPbJeN22x/yDB0LToLQEvPy2AYU2SkFY9JSk/GSz7TNUvBu9Zj1YsT80+
 jIlKFrpIuDv/EK2Aw3Ed8s8NIaNhtxZGakgkrLcncFAxN1Cp5HxX4aeb1
 U+Pe0RnjLQ4w8ho5m8QSoUvnxB+C6Li3pX+jRAO56I9FgO719PHjt9J+7
 8LLV9faXF1OFaUJJAySnjjCtViCnX7hMwJhPHq35J02joExf9Aju5fHIM
 NSTh3xPw4BFp4dR7J6lb6wOO3YfdYIXIEwbDyOqnBX6E+vZ1/Oj63/a8r w==;
X-CSE-ConnectionGUID: KBDNU0wRSa+r/JxpYLd2mA==
X-CSE-MsgGUID: eqQ1Se7gQWy5/sdv8iAZzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="39338693"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; d="scan'208";a="39338693"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2025 19:09:37 -0800
X-CSE-ConnectionGUID: KoHM1h5USe6vOHx5Xl5CHQ==
X-CSE-MsgGUID: j8v5p1WRRVCTF45Umq/tRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="126254074"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 07 Jan 2025 19:09:35 -0800
Date: Wed, 8 Jan 2025 11:28:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [RFC PATCH 3/9] rust: vmstate: add varray support to vmstate_of!
Message-ID: <Z33w1ykoafUl2WD7@intel.com>
References: <20241231002336.25931-1-pbonzini@redhat.com>
 <20241231002336.25931-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231002336.25931-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Tue, Dec 31, 2024 at 01:23:30AM +0100, Paolo Bonzini wrote:
> Date: Tue, 31 Dec 2024 01:23:30 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [RFC PATCH 3/9] rust: vmstate: add varray support to vmstate_of!
> X-Mailer: git-send-email 2.47.1
> 
> Untested...
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/vmstate.rs | 45 +++++++++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
> index e20f27b172b..079c19c687b 100644
> --- a/rust/qemu-api/src/vmstate.rs
> +++ b/rust/qemu-api/src/vmstate.rs
> @@ -69,6 +69,15 @@ pub unsafe trait VMState {
>      /// The base contents of a `VMStateField` (minus the name and offset) for
>      /// the type that is implementing the trait.
>      const BASE: VMStateField;
> +
> +    /// A flag that is added to another field's `VMStateField` to specify the
> +    /// length's type in a variable-sized array.  If this is not a supported
> +    /// type for the length (i.e. if it is not `u8`, `u16`, `u32`), using it
> +    /// in a call to [`vmstate_of!`](crate::vmstate_of) will cause a
> +    /// compile-time error.
> +    const VARRAY_FLAG: VMStateFlags = {
> +        panic!("invalid type for variable-sized array");
> +    };
>  }
>  
>  /// Internal utility function to retrieve a type's `VMStateField`;
> @@ -77,6 +86,13 @@ pub const fn vmstate_base<T: VMState>(_: PhantomData<T>) -> VMStateField {
>      T::BASE
>  }
>  
> +/// Internal utility function to retrieve a type's `VMStateFlags` when it
> +/// is used as the element count of a `VMSTATE_VARRAY`; used by
> +/// [`vmstate_of!`](crate::vmstate_of).
> +pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateField {
> +    T::BASE
> +}

a copy issue:

pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags {
    T::VARRAY_FLAG
}

> +
>  /// Return the `VMStateField` for a field of a struct.  The field must be
>  /// visible in the current scope.
>  ///
> @@ -84,18 +100,24 @@ pub const fn vmstate_base<T: VMState>(_: PhantomData<T>) -> VMStateField {
>  /// for them.
>  #[macro_export]
>  macro_rules! vmstate_of {
> -    ($struct_name:ty, $field_name:ident $(,)?) => {
> +    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])? $(,)?) => {

Compared to something like "[num]", the format "[0 .. num]" is more
elegant, so I also support this style.

>          $crate::bindings::VMStateField {
>              name: ::core::concat!(::core::stringify!($field_name), "\0")
>                  .as_bytes()
>                  .as_ptr() as *const ::std::os::raw::c_char,
>              offset: $crate::offset_of!($struct_name, $field_name),
> -            // Compute most of the VMStateField from the type of the field.
> +            $(.num_offset: $crate::offset_of!($struct_name, $num),)?
> +            // The calls to `call_func_with_field!` are the magic that
> +            // computes most of the VMStateField from the type of the field.
>              ..$crate::call_func_with_field!(
>                  $crate::vmstate::vmstate_base,
>                  $struct_name,
>                  $field_name
> -            )
> +            )$(.with_varray_flag($crate::call_func_with_field!(
> +                    $crate::vmstate::vmstate_varray_flag,
> +                    $struct_name,
> +                    $num))
> +               $(.with_varray_multiply($factor))?)?
>          }
>      };
>  }
> @@ -130,6 +152,22 @@ pub const fn with_pointer_flag(mut self) -> Self {
>          self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_POINTER.0);
>          self
>      }
> +
> +    #[must_use]
> +    pub const fn with_varray_flag<T: VMState>(mut self, flag: VMStateFlags) -> VMStateField {
> +        assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);

I understand you checked VMS_ARRAY here since [T; N] has this array
flag.

What if a Rust device just store a pointer to the array? If we allow
this use, then it seems also possible to set varray flags...Then what
about dropping this limitation?

However, I also doube that pointer usage is bad; we should always use
Vec.

> +        self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_ARRAY.0);
> +        self.flags = VMStateFlags(self.flags.0 | flag.0);
> +        self
> +    }
> +
> +    #[must_use]
> +    pub const fn with_varray_multiply(mut self, num: u32) -> VMStateField {
> +        assert!(num <= 0x7FFF_FFFFu32);

Similarly, what about using "assert!(num <= i32::MAX as u32);"?

> +        self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0);
> +        self.num = num as i32;
> +        self
> +    }
>  }
>  
>  // Transparent wrappers: just use the internal type
> @@ -141,6 +179,7 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
>                  size: mem::size_of::<$type>(),
>                  ..<$base as VMState>::BASE
>              };
> +            const VARRAY_FLAG: VMStateFlags = <$base as VMState>::VARRAY_FLAG;
>          }
>      };
>  }
> -- 
> 2.47.1
> 

