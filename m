Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D77C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqE79-00006m-Fu; Thu, 06 Mar 2025 11:30:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tqE6o-0008Uq-Dm
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:30:08 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tqE6l-0003CU-QG
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741278604; x=1772814604;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9JT6hQcuHPteGjoaNI+sWKgKEc5E/9AZD+AdonkE+gQ=;
 b=Tm11V0NaurniXzAkZR8hY+PCrLEyUBMH3EUXKpppVj/66VVpGWADyidm
 zO0Efh9ceVn0Qi+l2PEFYmhRWsCvb9Y8P1jTD4roiiHFrF5OwaeAMBJYj
 sswFJNH4V7s4urey94xyHo/f0xAVPBAnm8tgfHIVGU3v9eS5GedNXLKf7
 6ZsWoe4jEpQHqAwfzLf3mK85LyGXxCHwyFpJuV7XFOiRCWfTbbBdZJ9Ox
 bPGF3rRdAuEydKYU93tANbHYkiqFAzXwCHLPOZ6qvCO54FqDBTmd3e1Oi
 KUvCzF7CjU4I2C6gGIakq2BgkwYkmBDVValaijzcItU136eX8y4wL0Z8q w==;
X-CSE-ConnectionGUID: gdBHqypTSPaTNMgJxPW33w==
X-CSE-MsgGUID: dwFjMivZRLS3u/F6UcFTxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46069640"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; d="scan'208";a="46069640"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2025 08:30:01 -0800
X-CSE-ConnectionGUID: 6/o4d1CJRlmH59W6JvCY3g==
X-CSE-MsgGUID: 9vz7cgYqQKO18CkQEoPjYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119579483"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 06 Mar 2025 08:29:57 -0800
Date: Fri, 7 Mar 2025 00:50:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com,
 zhenyuw@linux.intel.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com
Subject: Re: [PATCH v2 02/10] target/i386: disable PERFCORE when "-pmu" is
 configured
Message-ID: <Z8nSPf4bUPICgf3g@intel.com>
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-3-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302220112.17653-3-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Dongli,

> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b6d6167910..61a671028a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7115,6 +7115,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              !(env->hflags & HF_LMA_MASK)) {
>              *edx &= ~CPUID_EXT2_SYSCALL;
>          }
> +
> +        if (kvm_enabled() && IS_AMD_CPU(env) && !cpu->enable_pmu) {

No need to check "kvm_enabled() && IS_AMD_CPU(env)" because:

 * "pmu" is a general CPU property option which should cover all PMU
   related features, and not kvm-specific/vendor-specific.
 * this bit is reserved on Intel. So the following operation doesn't
   affect Intel.

I think Xiaoyao's idea about checking in x86_cpu_expand_features() is
good. And I believe it's worth having another cleanup series to revisit
pmu dependencies. I can help you later to consolidate and move this
check to x86_cpu_expand_features(), so this patch can focus on correctly
defining the current dependency relationship.

With the above nit fixed,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>




