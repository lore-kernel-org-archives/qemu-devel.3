Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF49EB26FD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 19:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpt3P-0000qh-66; Tue, 10 Feb 2026 14:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vpt3I-0000oy-Ih
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 14:05:37 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vpt3F-0007XJ-BA
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 14:05:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770750334; x=1802286334;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ylcl4fb3NHyomkpp/UlE8A9D2DVzsDW11g1wPGUvirE=;
 b=ERJNFB0CxpdRm6yutqDViLXtGWFAp07vM0djfk9EV3idjToCluUXAWcy
 8TJWufGoTVYEBvnG2To6OaFSswLlTSdU7c0S9mdfhekjsvW08iH0wuxmS
 IlN5RMmJ7OtgAQfQou3+D+CJnO2o3awuaHVwaH1sEiML4aBhg4Pfx1WFH
 FkVpnoqi2KxOz5p9IYpdlegRBeAwu3SdIuXMtrunxmTABF83e379WyQU/
 2eavpscBnE/ySeVL0O7KXTQsWmLPcH33mCekFMwbHFoMc+vdeL4OLN8WH
 m/HYZhZwaqXi5JHZoWHjTxW+/oo1gvNrqvMq3TdtHoDWdJoeqID1WHurv g==;
X-CSE-ConnectionGUID: nXYNsNWHTXmKdvbXQv/UHA==
X-CSE-MsgGUID: K5aQEIGOSEmf8ydPVxUzTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71789401"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71789401"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 11:05:28 -0800
X-CSE-ConnectionGUID: zCijB2DbQZuWXl8byfvD5w==
X-CSE-MsgGUID: AHHvJZfgS02KcdI2813xiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212098802"
Received: from unknown (HELO [10.241.241.84]) ([10.241.241.84])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 11:05:27 -0800
Message-ID: <488a2ea7-062d-4561-89ec-f053af234cdd@intel.com>
Date: Tue, 10 Feb 2026 11:05:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 11/11] target/i386: Disable guest PEBS capability when
 not enabled
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>
References: <20260128231003.268981-1-zide.chen@intel.com>
 <20260128231003.268981-12-zide.chen@intel.com>
 <576b57e3-92df-4a35-ba7c-00bf12833313@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <576b57e3-92df-4a35-ba7c-00bf12833313@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zide.chen@intel.com;
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/9/2026 11:30 PM, Mi, Dapeng wrote:
> 
> On 1/29/2026 7:09 AM, Zide Chen wrote:
>> When PMU is disabled, guest CPUID must not advertise Debug Store
>> support.  Clear both CPUID.01H:EDX[21] (DS) and CPUID.01H:ECX[2]
>> (DS64) in this case.
>>
>> Set IA32_MISC_ENABLE[12] (PEBS_UNAVAILABLE) when Debug Store is not
>> exposed to the guest.
>>
>> Note: Do not infer that PEBS is unsupported from
>> IA32_PERF_CAPABILITIES[11:8] (PEBS_FMT) being 0.  A value of 0 is a
>> valid PEBS record format on some CPUs.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> V2:
>> - New patch.
>>
>>  target/i386/cpu.c | 6 ++++++
>>  target/i386/cpu.h | 1 +
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index ec6f49916de3..445361ab7a06 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -9180,6 +9180,10 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
>>          env->msr_ia32_misc_enable |= MSR_IA32_MISC_ENABLE_MWAIT;
>>      }
>>  
>> +    if (!(env->features[FEAT_1_EDX] & CPUID_DTS)) {
>> +        env->msr_ia32_misc_enable |= MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL;
>> +    }
>> +
>>      memset(env->dr, 0, sizeof(env->dr));
>>      env->dr[6] = DR6_FIXED_1;
>>      env->dr[7] = DR7_FIXED_1;
>> @@ -9474,6 +9478,8 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>>              env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
>>          }
>>  
>> +        env->features[FEAT_1_ECX] &= ~CPUID_EXT_DTES64;
>> +        env->features[FEAT_1_EDX] &= ~CPUID_DTS;
> 
> Strictly speaking, we need to check BTS as well before clearing DS. BTS
> also depends on DS.

But BTS is already unconditionally disabled from the guest in patch 1/11.


> 
>>          env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_LBR;
>>      }
>>  
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index 5ab107dfa29f..0fecf561173e 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -483,6 +483,7 @@ typedef enum X86Seg {
>>  /* Indicates good rep/movs microcode on some processors: */
>>  #define MSR_IA32_MISC_ENABLE_FASTSTRING    (1ULL << 0)
>>  #define MSR_IA32_MISC_ENABLE_BTS_UNAVAIL   (1ULL << 11)
>> +#define MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL  (1ULL << 12)
>>  #define MSR_IA32_MISC_ENABLE_MWAIT      (1ULL << 18)
>>  #define MSR_IA32_MISC_ENABLE_DEFAULT    (MSR_IA32_MISC_ENABLE_FASTSTRING     |\
>>                                           MSR_IA32_MISC_ENABLE_BTS_UNAVAIL)


