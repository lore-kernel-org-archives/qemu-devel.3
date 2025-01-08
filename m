Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8755E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 07:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVQwC-0006JH-Bb; Wed, 08 Jan 2025 02:57:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVQw5-0006Ix-IP; Wed, 08 Jan 2025 02:57:06 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tVQw2-0004go-F7; Wed, 08 Jan 2025 02:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736323023; x=1767859023;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=L8iGmJGftk6anNkS54L2FV2VsQMpmuaKKArYMciGhOk=;
 b=CT4q7jMjFxKw2zkEix3wkEJ443IObhQJHudYp4Ese/1UhDN9tJ3PCWjL
 VWQOZC3kOLLEEdtayU7TbzTeUpjpkI8u20Js2ncOkmaaVwHVbf59HkNNq
 CsQQxGxrvL1bStURVa3PaFx+ezYJl/0MNB01V3sEZVPE6dV5NQO3TwCn/
 MeQy9Faidve2bw4R9zJ6cTgepNmJOvWUoU8C0yA5mmob8VJ3OJe7dXkdP
 CzmXdepRawelroEYetyCEwjNlXe+D9kuncmwYHEl6vXHV7jG5kBDwfZHU
 bXEF5RczmTQpRxtKKYtG+eWolW7vnC2EokXyMTrjs3Waaxp6ekOY4ceRR w==;
X-CSE-ConnectionGUID: NSgOqwq0SyGenMrumgk9qQ==
X-CSE-MsgGUID: s3ww+mvSQmq2Wx3oiFxylg==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="59000786"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; d="scan'208";a="59000786"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2025 23:56:58 -0800
X-CSE-ConnectionGUID: qgvx7Wm3SlqiF5eMbcnjCw==
X-CSE-MsgGUID: 11hJ5wH6Swa5OGPIXji5mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; d="scan'208";a="103524003"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 07 Jan 2025 23:56:57 -0800
Date: Wed, 8 Jan 2025 16:15:45 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [RFC PATCH 6/9] rust: vmstate: add public utility macros to
 implement VMState
Message-ID: <Z340Mb21QlQGl4kJ@intel.com>
References: <20241231002336.25931-1-pbonzini@redhat.com>
 <20241231002336.25931-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241231002336.25931-7-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
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

> +/// This macro can be used (by just passing it a type) to forward the `VMState`
> +/// trait to the first field of a tuple.  This is a workaround for lack of
> +/// support of nested [`offset_of`](core::mem::offset_of) until Rust 1.82.0.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use qemu_api::vmstate::impl_vmstate_forward;
> +/// pub struct Fifo([u8; 16]);
> +/// impl_vmstate_forward!(Fifo);
> +/// ```
> +#[macro_export]
> +macro_rules! impl_vmstate_forward {
> +    // This is similar to impl_vmstate_transparent below, but it
> +    // uses the same trick as vmstate_of! to obtain the type of
> +    // the first field of the tuple
> +    ($tuple:ty) => {
> +        unsafe impl $crate::vmstate::VMState for $tuple {
> +            const SCALAR_TYPE: $crate::vmstate::VMStateFieldType =
> +                $crate::call_func_with_field!($crate::vmstate::vmstate_scalar_type, $tuple, 0);
> +            const BASE: $crate::bindings::VMStateField =
> +                $crate::call_func_with_field!($crate::vmstate::vmstate_base, $tuple, 0);
> +        }
> +    };
> +}
> +

Powerful!

>  // Transparent wrappers: just use the internal type
>  
>  macro_rules! impl_vmstate_transparent {
> @@ -283,6 +318,26 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
>  impl_vmstate_transparent!(crate::cell::BqlCell<T> where T: VMState);
>  impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
>  
> +#[macro_export]
> +macro_rules! impl_vmstate_bitsized {
> +    ($type:ty) => {
> +        unsafe impl $crate::vmstate::VMState for $type {
> +            const SCALAR_TYPE: $crate::vmstate::VMStateFieldType =
> +                                        <<<$type as ::bilge::prelude::Bitsized>::ArbitraryInt
> +                                          as ::bilge::prelude::Number>::UnderlyingType
> +                                         as $crate::vmstate::VMState>::SCALAR_TYPE;
> +            const BASE: $crate::bindings::VMStateField =
> +                                        <<<$type as ::bilge::prelude::Bitsized>::ArbitraryInt
> +                                          as ::bilge::prelude::Number>::UnderlyingType
> +                                         as $crate::vmstate::VMState>::BASE;
> +            const VARRAY_FLAG: $crate::bindings::VMStateFlags =
> +                                        <<<$type as ::bilge::prelude::Bitsized>::ArbitraryInt
> +                                          as ::bilge::prelude::Number>::UnderlyingType
> +                                         as $crate::vmstate::VMState>::VARRAY_FLAG;
> +        }
> +    };
> +}
> +
>  // Scalar types using predefined VMStateInfos
>  
>  macro_rules! impl_vmstate_scalar {

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



