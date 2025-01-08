Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655A9E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 06:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVPWm-0005Lr-5e; Wed, 08 Jan 2025 01:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVPWk-0005LU-Rx; Wed, 08 Jan 2025 01:26:50 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVPWX-0001Fg-MM; Wed, 08 Jan 2025 01:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736317598; x=1767853598;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=D+f6I4khuT9mZpVa85hfC86Y59CHSX5yUs05nQk0y6A=;
 b=oBcek3coS8mHO6d3sToHJIRXYuDTppLP2gD/HCfLa/F0l5IrDosi2CGT
 ZuNidEittDZtqpecTUIr1fwL181FIn4Vx/TfBlZT0yLBPSsptl54Stpgg
 YODyBVWWxLpvgg1j8dD5xK1JyFAzFn1n1cPyPE8GZE6/9nzoIC/wVn1yB
 9mvjMHN7Xm+Tsk40sjbEBHOcsQGdk/gkeVkMCnVkinIUd3x/YQLw75GQj
 rxzhodhZJ2XreNLF8FWJi99cCk5TF3HRWM0OA6PhdNygllRhsbEShv9Jf
 hk+PfdcMO3/gn9Id8/IcTDTnwkwXpHKirWGAjQtbATEEuQGILBpPNWl/D Q==;
X-CSE-ConnectionGUID: B2jM+MNlR5yzHnYMglU+5A==
X-CSE-MsgGUID: pmp3fQyQT72mUrKpbGBUEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="40297009"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; d="scan'208";a="40297009"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2025 22:26:34 -0800
X-CSE-ConnectionGUID: EooSmLB9S/6AFwlD2qyKOw==
X-CSE-MsgGUID: UH2Sqi0gRjqgfy3gWlERnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="108094319"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 07 Jan 2025 22:26:32 -0800
Date: Wed, 8 Jan 2025 14:45:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com
Subject: Re: [RFC PATCH 5/9] rust: vmstate: implement VMState for scalar types
Message-ID: <Z34fAFD4d/BVZQkn@intel.com>
References: <20241231002336.25931-1-pbonzini@redhat.com>
 <20241231002336.25931-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231002336.25931-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
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

>  #[macro_export]
>  macro_rules! vmstate_of {
> -    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])? $(,)?) => {
> +    ($struct_name:ty, $field_name:ident $([0 .. $num:tt $(* $factor:expr)?])? $(,)?) => {

Why change ident to tt? 

>          $crate::bindings::VMStateField {
>              name: ::core::concat!(::core::stringify!($field_name), "\0")
>                  .as_bytes()
> @@ -109,6 +197,11 @@ macro_rules! vmstate_of {
>              $(.num_offset: $crate::offset_of!($struct_name, $num),)?
>              // The calls to `call_func_with_field!` are the magic that
>              // computes most of the VMStateField from the type of the field.
> +            info: $crate::info_enum_to_ref!($crate::call_func_with_field!(
> +                $crate::vmstate::vmstate_scalar_type,
> +                $struct_name,
> +                $field_name
> +            )),
>              ..$crate::call_func_with_field!(
>                  $crate::vmstate::vmstate_base,
>                  $struct_name,

...

> +impl_vmstate_scalar!(vmstate_info_bool, bool);
> +impl_vmstate_scalar!(vmstate_info_int8, i8);
> +impl_vmstate_scalar!(vmstate_info_int16, i16);
> +impl_vmstate_scalar!(vmstate_info_int32, i32);

missed VMS_VARRAY_INT32 :-)

> +impl_vmstate_scalar!(vmstate_info_int64, i64);
> +impl_vmstate_scalar!(vmstate_info_uint8, u8, VMS_VARRAY_UINT8);
> +impl_vmstate_scalar!(vmstate_info_uint16, u16, VMS_VARRAY_UINT16);
> +impl_vmstate_scalar!(vmstate_info_uint32, u32, VMS_VARRAY_UINT32);

If we want to expand in the future (e.g., support vmstate_info_int32_equal
and vmstate_info_int32_le), then introducing new macro variants will be
straightforward. So, fair enough.

> +impl_vmstate_scalar!(vmstate_info_uint64, u64);

What about applying this to "usize" with vmstate_info_uint64?

For array length, I think usize is also used wildly. Maybe we can add
VMS_VARRAY_UINT64 and just treat usize as u64.

> +impl_vmstate_scalar!(vmstate_info_timer, bindings::QEMUTimer);
> +
>  // Pointer types using the underlying type's VMState plus VMS_POINTER
>  
>  macro_rules! impl_vmstate_pointer {
> -- 
> 2.47.1

Overall, I think it's good; the design idea is coherent.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



