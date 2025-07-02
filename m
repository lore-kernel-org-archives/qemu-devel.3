Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38556C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 05:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWqFX-0004Uv-Nv; Wed, 02 Jul 2025 01:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uWqFS-0004UM-4k
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 01:43:10 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uWqFH-0008VU-Rl
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 01:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751434979; x=1782970979;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=JJu1pmmEn3alemdY/GcZx7/cDMvAq6dvoCyNi0CgS2Y=;
 b=F2qyyJew4WiGvu8dJgyqTDTWE0qsxqpkTvro9sS+N7cc9kahIJnbqEAe
 2MK/aj75qlFaw3ARx/KObZ9yJIXtTV8RMi092UO2K/h9Z5JyMW19XRQKF
 2JqD2ySaTuZyqXjQ5trl9Ys6n71QTzpFRdCrDqCCe9/y2RFGQZ7YpFC0l
 mWKioQ+CidIZ4Zipfwk8ghCaJ5iS9LAvccDkdejN71p/c4GGq4DVMney3
 8WoH9aFhBnPFq3L+C6Aqg7CS9+67TZwE+7gXOFsRGMPOr1gbmLQcij4cV
 O+vZ2QWoyu3b3oKqpMJkGmKE1H+wP9AAqgM0Zz1TOg/Hc0yYESHc4VlJe Q==;
X-CSE-ConnectionGUID: i03PfyhyRJi5eflQFLOehg==
X-CSE-MsgGUID: 8eOf8c9TR3uV5EA2fsVD9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="41347898"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="41347898"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 22:42:49 -0700
X-CSE-ConnectionGUID: H3MZBqqZQZ2uSfRfKb7nHQ==
X-CSE-MsgGUID: QqYDOrwuSy+jl9lKGS8glw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="153441060"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.80])
 ([10.124.240.80])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 22:42:44 -0700
Message-ID: <e55fcee5-73e6-404e-834e-f5ed51e2042d@linux.intel.com>
Date: Wed, 2 Jul 2025 13:42:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] target/i386/kvm: don't stop Intel PMU counters
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com, joe.jin@oracle.com,
 ewanhai-oc@zhaoxin.com, ewanhai@zhaoxin.com
References: <20250624074421.40429-1-dongli.zhang@oracle.com>
 <20250624074421.40429-10-dongli.zhang@oracle.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250624074421.40429-10-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.198.163.16;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 6/24/2025 3:43 PM, Dongli Zhang wrote:
> PMU MSRs are set by QEMU only at levels >= KVM_PUT_RESET_STATE,
> excluding runtime. Therefore, updating these MSRs without stopping events
> should be acceptable.
>
> In addition, KVM creates kernel perf events with host mode excluded
> (exclude_host = 1). While the events remain active, they don't increment
> the counter during QEMU vCPU userspace mode.
>
> Finally, The kvm_put_msrs() sets the MSRs using KVM_SET_MSRS. The x86 KVM
> processes these MSRs one by one in a loop, only saving the config and
> triggering the KVM_REQ_PMU request. This approach does not immediately stop
> the event before updating PMC. This approach is true since Linux kernel
> commit 68fb4757e867 ("KVM: x86/pmu: Defer reprogram_counter() to
> kvm_pmu_handle_event"), that is, v6.2.
>
> No Fixed tag is going to be added for the commit 0d89436786b0 ("kvm:
> migrate vPMU state"), because this isn't a bugfix.
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changed since v3:
>   - Re-order reasons in commit messages.
>   - Mention KVM's commit 68fb4757e867 (v6.2).
>   - Keep Zhao's review as there isn't code change.
>
>  target/i386/kvm/kvm.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 4bbdf996ef..207de21404 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -4186,13 +4186,6 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>          }
>  
>          if ((IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) && pmu_version > 0) {
> -            if (pmu_version > 1) {
> -                /* Stop the counter.  */
> -                kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
> -                kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
> -            }
> -
> -            /* Set the counter values.  */
>              for (i = 0; i < num_pmu_fixed_counters; i++) {
>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i,
>                                    env->msr_fixed_counters[i]);
> @@ -4208,8 +4201,6 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>                                    env->msr_global_status);
>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
>                                    env->msr_global_ovf_ctrl);
> -
> -                /* Now start the PMU.  */
>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL,
>                                    env->msr_fixed_ctr_ctrl);
>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL,

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



