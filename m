Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2943FCF539E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 15:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3d4q-0008Bt-Cb; Wed, 23 Oct 2024 11:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3d4o-0008BN-MJ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 11:15:10 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3d4m-0003Yt-19
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 11:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729696509; x=1761232509;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dXBbQkVpOUCjH2gFM8xfJKZSyTki1cY/gXs7z1WB7Q0=;
 b=W5+kqPsoLNKphKHB1gt0wtEcV1oitTNT35RqfBARPdRF0ygbmlIm36Zs
 Tq0niKFvLAQQd6sgpmOi1+3gVS9LPT4zx2qHuB0c1LPRhrvyIRHvmVt0b
 mcj73qXn4E/DxRmeJfsB8OtU1exf3NcMW9glpjeh8uT1cYmiKOkwqcjs+
 ajABFZw3XSOv1XoppCNbTRNt8cgWjrkESzwxUI0/JzkBFME/xPsyFcZMn
 63BEZWq3LtKuO7DlzUBAE7dPUbgnBEMOvvnRwJ7A34OVBIW3Jb+hfYuVE
 fNNBGKH5obyPRk0lnYKb8snKjvcvyXlPJ18VBPa9hUqqZSK/ms98pMEQ7 A==;
X-CSE-ConnectionGUID: XNzmJOgfRkucKL6mKVKSoQ==
X-CSE-MsgGUID: H5+HEgWOQWOuKHKyUdAH8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29070803"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29070803"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2024 08:15:05 -0700
X-CSE-ConnectionGUID: w15DfiwGQVC87Iz25EWDMA==
X-CSE-MsgGUID: qrvLr+hkSO2J3rgbFnRYEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; d="scan'208";a="80262241"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 23 Oct 2024 08:15:03 -0700
Date: Wed, 23 Oct 2024 23:31:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH v2 06/13] rust: modernize link_section usage for ELF
 platforms
Message-ID: <ZxkWyN4OrbWlQXEa@intel.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-7-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021163538.136941-7-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

On Mon, Oct 21, 2024 at 06:35:31PM +0200, Paolo Bonzini wrote:
> Date: Mon, 21 Oct 2024 18:35:31 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 06/13] rust: modernize link_section usage for ELF
>  platforms
> X-Mailer: git-send-email 2.46.2
> 
> Some newer ABI implementations do not provide .ctors; and while
> some linkers rewrite .ctors into .init_array, not all of them do.
> Use the newer .init_array ABI, which works more reliably, and
> apply it to all non-Apple, non-Windows platforms.
> 
> This is similar to how the ctor crate operates; without this change,
> "#[derive(Object)]" does not work on Fedora 41.
> 
> Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api-macros/src/lib.rs  |  7 +++++--
>  rust/qemu-api/src/definitions.rs | 14 ++++++++++----
>  2 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
> index 59aba592d9a..70e3f920460 100644
> --- a/rust/qemu-api-macros/src/lib.rs
> +++ b/rust/qemu-api-macros/src/lib.rs
> @@ -16,8 +16,11 @@ pub fn derive_object(input: TokenStream) -> TokenStream {
>      let expanded = quote! {
>          #[allow(non_upper_case_globals)]
>          #[used]
> -        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
> -        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
> +        #[cfg_attr(
> +            not(any(target_vendor = "apple", target_os = "windows")),

EMM, "apple" vendor contains macOS, iOS and other variations of iOS.
Do we need to consider other OSs besides macOS for now?

And it seems that the Rust people don't like "target_vendor = 'apple'".
(https://github.com/rust-lang/rust/issues/100343). :-)


Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


