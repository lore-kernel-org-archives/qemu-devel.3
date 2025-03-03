Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E05C19F32
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 02:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tov6B-0007ja-W1; Sun, 02 Mar 2025 21:00:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tov69-0007hT-6i
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 21:00:01 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tov66-00072L-7g
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 21:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740967198; x=1772503198;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=b9QpLGmIQbZ2m/C2hiQDOvkUV1SQvurxkHtaCC5I4M8=;
 b=BKcF89pQpadQIBafjFDbx2TVPNBhOHpQSo9MuHeCz/D4VtI8rgFVnhVK
 +ghPHBHDeeW73FXhD33KFKrsCD3QS31v4PcjjXtxWXd8k3J5TKpBlbJpH
 Vw1VBKaCKL4n3A8ES7FvVibTpmH9sqWj5L4GrWoYDlSAeFPd4ENAXvenM
 zGKyE6cY1BzQGUFi2brN09dp3rL6V74RUcDkxdx/M4klkEjf6sMKk1P58
 K4k5ZbBdaLcEv5+XFVhwRdW25U6LID7Y+ecZ1uj7KHsMZ/5yCsV4YI0ck
 PFKS+ME0ks20e2diKbaqCOrSZmle1Bam8cnrDrlMhJJvum/1tzxQ0s/Vy Q==;
X-CSE-ConnectionGUID: DzS4nGp5Sj64nFFGrNSk1g==
X-CSE-MsgGUID: XaHjAYEnRVOGR7Px0P/hTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41073909"
X-IronPort-AV: E=Sophos;i="6.13,328,1732608000"; d="scan'208";a="41073909"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2025 17:59:54 -0800
X-CSE-ConnectionGUID: OOFxQS0NQDGoXCDVjGWcPg==
X-CSE-MsgGUID: RAp19QrkRou8c2hipeL4Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="117720819"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2025 17:59:49 -0800
Message-ID: <99810e4f-f41d-4905-ae6d-1080b14fc8fd@intel.com>
Date: Mon, 3 Mar 2025 09:59:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] target/i386: disable PERFCORE when "-pmu" is
 configured
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, zhenyuw@linux.intel.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, dapeng1.mi@linux.intel.com, joe.jin@oracle.com
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-3-dongli.zhang@oracle.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250302220112.17653-3-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/3/2025 6:00 AM, Dongli Zhang wrote:
> Currently, AMD PMU support isn't determined based on CPUID, that is, the
> "-pmu" option does not fully disable KVM AMD PMU virtualization.
> 
> To minimize AMD PMU features, remove PERFCORE when "-pmu" is configured.
> 
> To completely disable AMD PMU virtualization will be implemented via
> KVM_CAP_PMU_CAPABILITY in upcoming patches.
> 
> As a reminder, neither CPUID_EXT3_PERFCORE nor
> CPUID_8000_0022_EAX_PERFMON_V2 is removed from env->features[] when "-pmu"
> is configured. Developers should query whether they are supported via
> cpu_x86_cpuid() rather than relying on env->features[] in future patches.

I don't think it is the correct direction to go.

env->features[] should be finalized before cpu_x86_cpuid() and 
env->features[] needs to be able to be exposed to guest directly. This 
ensures guest and QEMU have the same view of CPUIDs and it simplifies 
things.

We can adjust env->features[] by filtering all PMU related CPUIDs based 
on cpu->enable_pmu in x86_cpu_realizefn().

> Suggested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>   target/i386/cpu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b6d6167910..61a671028a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7115,6 +7115,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               !(env->hflags & HF_LMA_MASK)) {
>               *edx &= ~CPUID_EXT2_SYSCALL;
>           }
> +
> +        if (kvm_enabled() && IS_AMD_CPU(env) && !cpu->enable_pmu) {
> +            *ecx &= ~CPUID_EXT3_PERFCORE;
> +        }
>           break;
>       case 0x80000002:
>       case 0x80000003:


