Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76617C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVmq-0007Ea-5c; Mon, 26 Feb 2024 02:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reVmp-0007EO-1s
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:52:31 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reVmb-0007Jo-Qx
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708933938; x=1740469938;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=sqzyhp8PDv/oEhB/u2EqGaZR7JoP1mphizz5058AedU=;
 b=LSPBNyLdMI+yvQ4GHhGOIYeDvIgm8B8AEyntOI3Gl0bkdTs8YJHGEhpr
 uWxSBjlRdoEDNRYvOGc7P8zg9bzKIhb3UaE74OCob6FSg9n/x8AI/oefC
 7b5RqYnHZyBxqQFfEmkGOewhESolkKUgxN5lvK2qhFtu8Yd307StwSL85
 opZoFo4THvNDRjUdHHcV996mpuKFXO0RfMVR6IX6rEktA+qLj3huxMhaf
 c+YIEIln+u9I9YOGOTPBGAbkF8L9ItHNepPxIZmcJyvsF2LwmvIrIoZJ/
 vlJs+HS5EtxDDU/pHbgk0+HgEVhPdF7/jLVJimj6lMY70HX5i/fMDIr8n Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="13755523"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="13755523"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2024 23:52:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6786720"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 25 Feb 2024 23:52:14 -0800
Date: Mon, 26 Feb 2024 16:05:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, mcb30@ipxe.org
Subject: Re: [PATCH v2 3/7] target/i386: introduce function to query MMU
 indices
Message-ID: <ZdxGZPMXAB5rTIZl@intel.com>
References: <20240223130948.237186-1-pbonzini@redhat.com>
 <20240223130948.237186-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223130948.237186-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

On Fri, Feb 23, 2024 at 02:09:44PM +0100, Paolo Bonzini wrote:
> Date: Fri, 23 Feb 2024 14:09:44 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 3/7] target/i386: introduce function to query MMU indices
> X-Mailer: git-send-email 2.43.0
> 
> Remove knowledge of specific MMU indexes (other than MMU_NESTED_IDX and
> MMU_PHYS_IDX) from mmu_translate().  This will make it possible to split
> 32-bit and 64-bit MMU indexes.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.h                    | 10 ++++++++++
>  target/i386/tcg/sysemu/excp_helper.c |  4 ++--
>  2 files changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index dfe43b82042..8c271ca62e5 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2305,6 +2305,16 @@ uint64_t cpu_get_tsc(CPUX86State *env);
>  #define MMU_NESTED_IDX  3
>  #define MMU_PHYS_IDX    4
>  
> +static inline bool is_mmu_index_smap(int mmu_index)
> +{
> +    return mmu_index == MMU_KSMAP_IDX;
> +}
> +
> +static inline bool is_mmu_index_user(int mmu_index)
> +{
> +    return mmu_index == MMU_USER_IDX;
> +}
> +
>  static inline int cpu_mmu_index_kernel(CPUX86State *env)
>  {
>      return !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP_IDX :
> diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
> index 11126c860d4..a0d5ce39300 100644
> --- a/target/i386/tcg/sysemu/excp_helper.c
> +++ b/target/i386/tcg/sysemu/excp_helper.c
> @@ -137,7 +137,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
>      const int32_t a20_mask = x86_get_a20_mask(env);
>      const target_ulong addr = in->addr;
>      const int pg_mode = in->pg_mode;
> -    const bool is_user = (in->mmu_idx == MMU_USER_IDX);
> +    const bool is_user = is_mmu_index_user(in->mmu_idx);
>      const MMUAccessType access_type = in->access_type;
>      uint64_t ptep, pte, rsvd_mask;
>      PTETranslate pte_trans = {
> @@ -363,7 +363,7 @@ do_check_protect_pse36:
>      }
>  
>      int prot = 0;
> -    if (in->mmu_idx != MMU_KSMAP_IDX || !(ptep & PG_USER_MASK)) {
> +    if (!is_mmu_index_smap(in->mmu_idx) || !(ptep & PG_USER_MASK)) {
>          prot |= PAGE_READ;
>          if ((ptep & PG_RW_MASK) || !(is_user || (pg_mode & PG_MODE_WP))) {
>              prot |= PAGE_WRITE;
> -- 
> 2.43.0
> 
> 

