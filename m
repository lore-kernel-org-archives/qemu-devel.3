Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB310C38150
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 02:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQdkW-0004uB-Eb; Sun, 07 Jul 2024 22:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sQdkU-0004tU-MM
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 22:05:02 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sQdkS-0007y3-NF
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 22:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720404301; x=1751940301;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xUkLj7gycHRPrc2vJ98aEzGOvd7jb/4I0Fb5L2d3we8=;
 b=fAMlW5nefFnwZH3wNKHWzafjZmZ3Bd1gKlrtuBkQUzHqtAHPYmbbuKmk
 e9AiN3fk371foBP4Wg3AF5v66tHgWSkTj47hfjVRTdwFNM5kk8qUhy0Ao
 Jx/6mNiexqe410q2Q95YDRiSHA8E9BMwK2ZXVUImd/JiOwpUIO3717NYr
 PELiUL+N9e8F7ReyN5nYaCjQfs/d0BHYXZIb4nV00yGfu5PC2qapx7vCH
 py1wMwc1jizOX1Cdp+70ChVW4udcVrMCC95xiXbnt98yfSny5eOzKdfRe
 vxuTzFiUwNOOnKzOLZnhBX3LY0gNpe4P902AfbYZE0nCUmnDZHuY12UZ4 w==;
X-CSE-ConnectionGUID: oFpZSotPTqafcD5mES/lKA==
X-CSE-MsgGUID: DB2wV2KgQNS5F+RPDjC+pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17463581"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; d="scan'208";a="17463581"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2024 19:04:55 -0700
X-CSE-ConnectionGUID: 4nyaRrFQRF2E1T5hgo1Y/A==
X-CSE-MsgGUID: wIM4lsQ3S4SfsWRiP6ZMjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; d="scan'208";a="47246725"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 07 Jul 2024 19:04:53 -0700
Date: Mon, 8 Jul 2024 10:20:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] i386/cpu: Drop the check of phys_bits in
 host_cpu_realizefn()
Message-ID: <ZotM8CF4ZpdhYhWB@intel.com>
References: <20240704111231.2881016-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704111231.2881016-1-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Xiaoyao,

On Thu, Jul 04, 2024 at 07:12:31AM -0400, Xiaoyao Li wrote:
> Date: Thu,  4 Jul 2024 07:12:31 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH] i386/cpu: Drop the check of phys_bits in
>  host_cpu_realizefn()
> X-Mailer: git-send-email 2.34.1
> 
> The check of cpu->phys_bits to be in range between
> [32, TARGET_PHYS_ADDR_SPACE_BITS] in host_cpu_realizefn()
> is duplicated with check in x86_cpu_realizefn().
> 
> Since the ckeck in x86_cpu_realizefn() is called later and can cover all
> teh x86 case. Remove the one in host_cpu_realizefn().
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/host-cpu.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
> index 8b8bf5afeccf..b109c1a2221f 100644
> --- a/target/i386/host-cpu.c
> +++ b/target/i386/host-cpu.c
> @@ -75,17 +75,7 @@ bool host_cpu_realizefn(CPUState *cs, Error **errp)
>      CPUX86State *env = &cpu->env;
>  
>      if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
> -        uint32_t phys_bits = host_cpu_adjust_phys_bits(cpu);
> -
> -        if (phys_bits &&
> -            (phys_bits > TARGET_PHYS_ADDR_SPACE_BITS ||
> -             phys_bits < 32)) {
> -            error_setg(errp, "phys-bits should be between 32 and %u "
> -                       " (but is %u)",
> -                       TARGET_PHYS_ADDR_SPACE_BITS, phys_bits);
> -            return false;
> -        }
> -        cpu->phys_bits = phys_bits;
> +        cpu->phys_bits = host_cpu_adjust_phys_bits(cpu);

Just nit:

cpu->phys_bits can be adjusted directly in host_cpu_adjust_phys_bits(),
and no need to return it out again.

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


