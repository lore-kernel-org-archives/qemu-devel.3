Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4542CC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVlP-0006Z7-G2; Mon, 26 Feb 2024 02:51:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reVlN-0006Yx-QM
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:51:01 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reVlK-00079F-TT
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708933859; x=1740469859;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=JlIrO6bfZE7xktqwEbYS0M7m5/081rmSTL1+snXEIpA=;
 b=oCCkWF/++lbFZkXIOAK3S6+UgvbU8Qq9FNoBOAobJYcW69ahGAyAkGuQ
 +I6ZbT3F4MnEwIXIEZ93VpXNVsXWD/TTKExFTRf3Ar++mgNaXazRtjER/
 9g8sLBHntFmSVAx6KXWf5HIeY8YB1aXfn5d/h1YCZ7i3D+9Lfk7RFBY85
 wHV2GtQhn5bofHAKS6l5IRAg5RwDFXc7i9ek+47RdSbE9jIrQFT55B6dp
 x9wVhvOHr1FeO3UaOI/9SmeG4AdnLvybgujZZ5lnXucC4p2ali3zA/fpl
 9xdgYyLZ9LR2DEnWo88lXW32LF02hwE45/q3JuiSxrkf1wo6JmnX3Vniz g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3073607"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3073607"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2024 23:50:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6463284"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 25 Feb 2024 23:50:49 -0800
Date: Mon, 26 Feb 2024 16:04:31 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, mcb30@ipxe.org
Subject: Re: [PATCH v2 1/7] target/i386: mask high bits of CR3 in 32-bit mode
Message-ID: <ZdxGD1NhtoUljLSm@intel.com>
References: <20240223130948.237186-1-pbonzini@redhat.com>
 <20240223130948.237186-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223130948.237186-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 23, 2024 at 02:09:42PM +0100, Paolo Bonzini wrote:
> Date: Fri, 23 Feb 2024 14:09:42 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 1/7] target/i386: mask high bits of CR3 in 32-bit mode
> X-Mailer: git-send-email 2.43.0
> 
> CR3 bits 63:32 are ignored in 32-bit mode (either legacy 2-level
> paging or PAE paging).  Do this in mmu_translate() to remove
> the last case where get_physical_address() meaningfully drops
> the high bits of the address.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Fixes: 4a1e9d4d11c ("target/i386: Use atomic operations for pte updates", 2022-10-18)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/tcg/sysemu/excp_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
> index 5b86f439add..11126c860d4 100644
> --- a/target/i386/tcg/sysemu/excp_helper.c
> +++ b/target/i386/tcg/sysemu/excp_helper.c
> @@ -238,7 +238,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
>              /*
>               * Page table level 3
>               */
> -            pte_addr = ((in->cr3 & ~0x1f) + ((addr >> 27) & 0x18)) & a20_mask;
> +            pte_addr = ((in->cr3 & 0xffffffe0ULL) + ((addr >> 27) & 0x18)) & a20_mask;
>              if (!ptw_translate(&pte_trans, pte_addr)) {
>                  return false;
>              }
> @@ -306,7 +306,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
>          /*
>           * Page table level 2
>           */
> -        pte_addr = ((in->cr3 & ~0xfff) + ((addr >> 20) & 0xffc)) & a20_mask;
> +        pte_addr = ((in->cr3 & 0xfffff000ULL) + ((addr >> 20) & 0xffc)) & a20_mask;
>          if (!ptw_translate(&pte_trans, pte_addr)) {
>              return false;
>          }
> -- 
> 2.43.0
> 
> 

