Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB9BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 10:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc0AA-0007Kl-C2; Thu, 08 Aug 2024 06:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sc0A8-0007K7-LF
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:14:28 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sc0A6-0002m0-Ve
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723112067; x=1754648067;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=YOhx1boi9x9b6qcJA6P4XBVcLGPxFpM+NaTdwul0UXE=;
 b=fD/kV+/Hzywa+m5BrlG/tR3lxY92WtHT7uPjGE/wctxYKAKsj0aMJipN
 mtrwLb+zU443QwobVkiTga8h4gA//VHKQ+WIz9dxArm/MSskgyYYKjw24
 qY/YBimNtx4KdfN9F4uxffy/oEmlHR40xu6g/3U6V7SSW925yQQhYp6jx
 ik21+I4kqbroevH0HJ/buuUGEPDtPQy4eRVT3koeMVikckXqwA5eC6mpi
 pQpU1dQi81TLJVpN5woe/iigK0/QC+GjEa0tfU0JkBQe4B9jpFsZlTv5O
 iXXWFwISssGSrxpIfprAYvANWpKRpeuxOR61vYLmWzQUNh+/lminKyrLv A==;
X-CSE-ConnectionGUID: q8jioANxRb+mxHH0cZB6Vg==
X-CSE-MsgGUID: 5DMhKqPjSL2N1ldAp0SUYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21109575"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; d="scan'208";a="21109575"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 03:14:22 -0700
X-CSE-ConnectionGUID: aUKj9Wu6SP+7bAtj1pixXw==
X-CSE-MsgGUID: tUF6/aM6Q+CcKdFpArtNVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; d="scan'208";a="57410334"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 08 Aug 2024 03:14:20 -0700
Date: Thu, 8 Aug 2024 18:30:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: EwanHai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, qemu-devel@nongnu.org,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com, rockcui@zhaoxin.com,
 louisqi@zhaoxin.com, liamni@zhaoxin.com, frankzhu@zhaoxin.com
Subject: Re: [PATCH v2 4/4] target/i386: Update CMPLegacy handling for
 Zhaoxin CPUs
Message-ID: <ZrSeMfpBm8NrXRWK@intel.com>
References: <20240704112511.184257-1-ewanhai-oc@zhaoxin.com>
 <20240704112511.184257-5-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704112511.184257-5-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi EwanHai,

On Thu, Jul 04, 2024 at 07:25:11AM -0400, EwanHai wrote:
> Date: Thu, 4 Jul 2024 07:25:11 -0400
> From: EwanHai <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH v2 4/4] target/i386: Update CMPLegacy handling for Zhaoxin
>  CPUs
> X-Mailer: git-send-email 2.34.1
> 
> Zhaoxin CPUs handle the CMPLegacy bit in the same way
> as Intel CPUs. This patch simplifies the existing logic by
> using the IS_XXX_CPU macro and includes checks for Zhaoxin
> vendor to align their behavior with Intel.
> 
> Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
> ---
>  target/i386/cpu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a3747fc487..c52a4cf3ba 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6945,9 +6945,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           * So don't set it here for Intel to make Linux guests happy.
>           */
>          if (threads_per_pkg > 1) {
> -            if (env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1 ||
> -                env->cpuid_vendor2 != CPUID_VENDOR_INTEL_2 ||
> -                env->cpuid_vendor3 != CPUID_VENDOR_INTEL_3) {
> +            if (!IS_INTEL_CPU(env) && !IS_ZHAOXIN_CPU(env)) {

This change implicitly changes the behavior of existing VIA CPU.

Is this a bug for the original VIA? If so, I suggest a separate patch to
fix it and explain the effect on the VIA (Zhaoxin1) CPU.

Regards,
Zhao

>                  *ecx |= 1 << 1;    /* CmpLegacy bit */
>              }
>          }
> -- 
> 2.34.1
> 

