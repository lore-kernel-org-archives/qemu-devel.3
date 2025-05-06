Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4CCC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 07:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCCpw-0006gg-C0; Tue, 06 May 2025 03:35:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCCpt-0006g6-Se; Tue, 06 May 2025 03:35:30 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCCpr-0006Ob-9z; Tue, 06 May 2025 03:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746516927; x=1778052927;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Bo3D3sOz2UBrzjyIlIEuW94krZX/F6SvPwagPvXjXzc=;
 b=LLTw+r4toPimefZ1jZH46IOHE06obxbT13p8xfu3Y5V9ba5XiZ7CIhG2
 9iX4v3zEBKtRvpMLVeuikwoW1LQDsN/bHiuwLF4y+acCzpLceaNyf+ylp
 FJC6w5AsMgZw4WF3CwDUYATEd2tDzru799z9VI44+wTPxmXb7te1Caw4P
 MqQ5HvrXeYGFRdCZBbclOGp6NW9GInNQOSr2YhJ2xUAr5Wy/zJSLVwGOl
 Y56Z9+ZWhb82e56DvPU/d4W1YXQn4DcLAl8zk8NzhTGbe4wiBe1jdljyI
 4tbiJgExDVRWfSvrbwVWW5cMDRODGiU9E2P3Gu9hP1Q5kJuuGZ/VJfcuu w==;
X-CSE-ConnectionGUID: BBhupoF/TL2kpxz9wgnO+Q==
X-CSE-MsgGUID: UuYFtOCSRaeCDSlSWfFLoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="51976460"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="51976460"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 00:35:24 -0700
X-CSE-ConnectionGUID: gdqLWOodT7OwnSj8hEQ49w==
X-CSE-MsgGUID: Q4RCZAzPQHCkioumJ4nAyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="158778286"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 06 May 2025 00:35:22 -0700
Date: Tue, 6 May 2025 15:56:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 06/11] rust: use MaybeUninit::zeroed() in const context
Message-ID: <aBnAp+uQgFFiGG+8@intel.com>
References: <20250505090438.24992-1-pbonzini@redhat.com>
 <20250505090438.24992-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505090438.24992-7-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Mon, May 05, 2025 at 11:04:31AM +0200, Paolo Bonzini wrote:
> Date: Mon,  5 May 2025 11:04:31 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 06/11] rust: use MaybeUninit::zeroed() in const context
> X-Mailer: git-send-email 2.49.0
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst              |   4 --
>  rust/hw/timer/hpet/src/fw_cfg.rs |   6 +-
>  rust/qemu-api/src/zeroable.rs    | 104 +++++--------------------------
>  3 files changed, 18 insertions(+), 96 deletions(-)

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

...

> -/// The need for a manual implementation is only because `zeroed()` cannot
> -/// be used as a `const fn` prior to Rust 1.75.0. Once we can assume a new
> -/// enough version of the compiler, we could provide a `#[derive(Zeroable)]`

Do we still need `#[derive(Zeroable)]`? I think at least it can help
HPETFwEntry & HPETFwConfig and reduces manual blanket implementation.

> -/// macro to check at compile-time that all struct fields are Zeroable, and
> -/// use the above blanket implementation of the `ZERO` constant.
> +/// behavior.
>  ///

...

> +unsafe impl Zeroable for crate::bindings::Property__bindgen_ty_1 {}
> +unsafe impl Zeroable for crate::bindings::Property {}
> +unsafe impl Zeroable for crate::bindings::VMStateFlags {}
> +unsafe impl Zeroable for crate::bindings::VMStateField {}
> +unsafe impl Zeroable for crate::bindings::VMStateDescription {}
> +unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_1 {}
> +unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_2 {}
> +unsafe impl Zeroable for crate::bindings::MemoryRegionOps {}
> +unsafe impl Zeroable for crate::bindings::MemTxAttrs {}
> +unsafe impl Zeroable for crate::bindings::CharBackend {}

Anyway, `#[derive(Zeroable)]` can't help these types from
crate::bindings::*.

Thanks,
Zhao



