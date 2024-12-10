Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B294FE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 07:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKv6M-0008SO-8f; Tue, 10 Dec 2024 02:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKv6J-0008S5-M5; Tue, 10 Dec 2024 02:56:12 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKv6G-0006im-D3; Tue, 10 Dec 2024 02:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733817368; x=1765353368;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AW/OojooGAlOfX+HuWRZqnlmLd0Vt5vDPewJ7bPTJSE=;
 b=iRpOh0Ihy6KSNNKh6eiflQ08CSjly/GHPKNiMderzhAaw07rF08GjuEW
 rzN97YHeWbCfYUNr0BpzmVftPAu+L8lJDizXWg6ZWV6Iny6iHQBrT86jO
 6S/fDdLbk2utfSZkaVcduTulrzTK8e4Ty+jvyuJK8e6jzoZSMGU3tYOwV
 nANYrdCMHX/FHct/2WTtL9bPPyt+oo1O9K8Pp7gJhPNQEYGCRZ+7P3jsg
 VddaHnyd6WHIkerLy4EqvHFEjDpweF6UUAzpltE7oup5NLlmAgISIdifk
 xbEFWs32r35yBbD15jHuFsSWlnzELHWF5aJT6V105UDpbexOjtuF3ZLDx A==;
X-CSE-ConnectionGUID: W0utFZ91RBy6LGqD1nYqhg==
X-CSE-MsgGUID: wPpPHXzJRGW6byWmG53LFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="44821631"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; d="scan'208";a="44821631"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2024 23:55:07 -0800
X-CSE-ConnectionGUID: 8ixUab6yQ8S1c+yl9L+yzw==
X-CSE-MsgGUID: 7Fg0VOayQbicBKB41pWVmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; d="scan'208";a="95775342"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 09 Dec 2024 23:55:06 -0800
Date: Tue, 10 Dec 2024 16:13:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 06/26] rust: add a bit operation module
Message-ID: <Z1f4IN3mfYB/jq8G@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-7-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

On Mon, Dec 09, 2024 at 01:36:57PM +0100, Paolo Bonzini wrote:
> Date: Mon,  9 Dec 2024 13:36:57 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 06/26] rust: add a bit operation module
> X-Mailer: git-send-email 2.47.1
> 
> The bindgen supports `static inline` function binding since v0.64.0 as
> an experimental feature (`--wrap-static-fns`), and stabilizes it after
> v0.70.0.
> 
> But the oldest version of bindgen supported by QEMU is v0.60.1, so
> there's no way to generate the binding for deposit64() which is `static
> inline` (in include/qemu/bitops.h).
> 
> Instead, implement it by hand in Rust and make it available for all
> unsigned types through an IntegerExt trait. Since it only involves bit
> operations, the Rust version of the code is almost identical to the
> original C version, but it applies to more types than just u64.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/meson.build    |   1 +
>  rust/qemu-api/src/bitops.rs  | 119 +++++++++++++++++++++++++++++++++++
>  rust/qemu-api/src/lib.rs     |   1 +
>  rust/qemu-api/src/prelude.rs |   2 +
>  4 files changed, 123 insertions(+)
>  create mode 100644 rust/qemu-api/src/bitops.rs
>
> diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
> index b927eb58c8e..adcee661150 100644
> --- a/rust/qemu-api/meson.build
> +++ b/rust/qemu-api/meson.build
> @@ -16,6 +16,7 @@ _qemu_api_rs = static_library(
>      [
>        'src/lib.rs',
>        'src/bindings.rs',
> +      'src/bitops.rs',
>        'src/cell.rs',
>        'src/c_str.rs',
>        'src/definitions.rs',
> diff --git a/rust/qemu-api/src/bitops.rs b/rust/qemu-api/src/bitops.rs
> new file mode 100644
> index 00000000000..5acd6642d1a
> --- /dev/null
> +++ b/rust/qemu-api/src/bitops.rs
> @@ -0,0 +1,119 @@
> +// Copyright (C) 2024 Intel Corporation.
> +// Author(s): Zhao Liu <zhai1.liu@intel.com>

You deserve to be the author!

> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +//! This module provides bit operation extensions to integer types.
> +//! It is usually included via the `qemu_api` prelude.
> +
> +use std::ops::{
> +    Add, AddAssign, BitAnd, BitAndAssign, BitOr, BitOrAssign, BitXor, BitXorAssign, Div, DivAssign,
> +    Mul, MulAssign, Not, Rem, RemAssign, Shl, ShlAssign, Shr, ShrAssign,
> +};
> +
> +/// Trait for extensions to integer types
> +pub trait IntegerExt:
> +    Add<Self, Output = Self> + AddAssign<Self> +
> +    BitAnd<Self, Output = Self> + BitAndAssign<Self> +
> +    BitOr<Self, Output = Self> + BitOrAssign<Self> +
> +    BitXor<Self, Output = Self> + BitXorAssign<Self> +
> +    Copy +
> +    Div<Self, Output = Self> + DivAssign<Self> +
> +    Eq +
> +    Mul<Self, Output = Self> + MulAssign<Self> +
> +    Not<Output = Self> + Ord + PartialOrd +
> +    Rem<Self, Output = Self> + RemAssign<Self> +
> +    Shl<Self, Output = Self> + ShlAssign<Self> +
> +    Shl<u32, Output = Self> + ShlAssign<u32> + // add more as needed

Ah, I used to define shift bits as usize. I can change the bit shift
type back to u32 in HPET.

> +    Shr<Self, Output = Self> + ShrAssign<Self> +
> +    Shr<u32, Output = Self> + ShrAssign<u32> // add more as needed
> +{
> +    const BITS: u32;
> +    const MAX: Self;
> +    const MIN: Self;
> +    const ONE: Self;
> +    const ZERO: Self;
> +
> +    #[inline]
> +    #[must_use]
> +    fn bit(start: u32) -> Self
> +    {
> +        assert!(start <= Self::BITS);
> +
> +        Self::ONE << start
> +    }

I think with this helper, I can add activating_bit() and deactivating_bit()
bindings, as they are also commonly used operations.

I will rename them to activate_bit and deactivate_bit, if no one has any
objections.

> +    #[inline]
> +    #[must_use]
> +    fn mask(start: u32, length: u32) -> Self
> +    {
> +        /* FIXME: Implement a more elegant check with error handling support? */

I think current design is elegant enough, and this FIXME is not needed.

> +        assert!(length > 0 && length <= Self::BITS - start);
> +
> +        (Self::MAX >> (Self::BITS - length)) << start
> +    }
> +
> +    #[inline]
> +    #[must_use]
> +    fn deposit<U: IntegerExt>(self, start: u32, length: u32,
> +                          fieldval: U) -> Self
> +        where Self: From<U>
> +    {
> +        debug_assert!(length <= U::BITS);

assert? as you've already replaced debug_assert with assert in BqlCell.

> +        let mask = Self::mask(start, length);
> +        (self & !mask) | ((Self::from(fieldval) << start) & mask)
> +    }
> +

Very useful for HPET! Thanks.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


