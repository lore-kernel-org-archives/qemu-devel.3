Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AD5C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWGG-0005nZ-VN; Mon, 26 Feb 2024 03:22:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reWGG-0005nP-DJ
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:22:56 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reWGE-0004W6-Td
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708935775; x=1740471775;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RbiVZhx4U0HYlLH53dh6YvD41tDN1IyKQp0WaEI9vSc=;
 b=Wx3pW71VNXufL2shsFqdxjYz2x4SfDEmth/lyOP/Ejha32ValtpvaFSb
 wS2mm1lAo2WZr1hUD0Zk4oBZHj0z6Y0MqoTRREt/w47lj2NC+JJcL7vZ1
 +Vk7b3/8EFNUU8IoWS/8PH76isCk6Pn/3nCvfWIRXZEF8RAJ2u1kDLAyN
 P8Apzm+dQcnr8m8SeCmh79Vi8XSDCR9Nk5S5l72h/9bPj+uVLRW1PFjuF
 EGco3uvGtQAMSLaJhBwsA+jY7dJa0dztliuBFQQDuOGvbDxIHDZz/PPWo
 /9f+tuT3tnD/gESvX8P1XjBDcJBDaS8LoTcYob4rJLHd3J0v65cfPO/pH g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="20750468"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="20750468"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 00:22:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6577125"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 26 Feb 2024 00:22:51 -0800
Date: Mon, 26 Feb 2024 16:36:33 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, mcb30@ipxe.org
Subject: Re: [PATCH v2 4/7] target/i386: use separate MMU indexes for 32-bit
 accesses
Message-ID: <ZdxNkStjZyB6iJtk@intel.com>
References: <20240223130948.237186-1-pbonzini@redhat.com>
 <20240223130948.237186-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223130948.237186-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
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

On Fri, Feb 23, 2024 at 02:09:45PM +0100, Paolo Bonzini wrote:
> Date: Fri, 23 Feb 2024 14:09:45 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 4/7] target/i386: use separate MMU indexes for 32-bit
>  accesses
> X-Mailer: git-send-email 2.43.0
> 
> Accesses from a 32-bit environment (32-bit code segment for instruction
> accesses, EFER.LMA==0 for processor accesses) have to mask away the
> upper 32 bits of the address.  While a bit wasteful, the easiest way
> to do so is to use separate MMU indexes.  These days, QEMU anyway is
> compiled with a fixed value for NB_MMU_MODES.  Split MMU_USER_IDX,
> MMU_KSMAP_IDX and MMU_KNOSMAP_IDX in two.

Maybe s/in/into/ ?

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.h                    | 34 ++++++++++++++++++++--------
>  target/i386/cpu.c                    | 11 +++++----
>  target/i386/tcg/sysemu/excp_helper.c |  3 ++-
>  3 files changed, 33 insertions(+), 15 deletions(-)
> 

[snip]

>  
>  static inline int cpu_mmu_index_kernel(CPUX86State *env)
>  {
> -    return !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP_IDX :
> -        ((env->hflags & HF_CPL_MASK) < 3 && (env->eflags & AC_MASK))
> -        ? MMU_KNOSMAP_IDX : MMU_KSMAP_IDX;
> +    int mmu_index_32 = (env->hflags & HF_LMA_MASK) ? 1 : 0;
> +    int mmu_index_base =
> +        !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP64_IDX :
> +        ((env->hflags & HF_CPL_MASK) < 3 && (env->eflags & AC_MASK)) ? MMU_KNOSMAP64_IDX : MMU_KSMAP64_IDX;

Change the line?


