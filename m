Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C205FC6165
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 00:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbpUR-0004nq-A0; Fri, 02 Jan 2026 19:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vbpUO-0004nE-HF
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 19:27:28 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vbpUL-00032C-Q1
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 19:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767400046; x=1798936046;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=IAttkKUPdKV3jr6OHhRsvukqZBqhsMR4lNcX9qeUMRE=;
 b=Ts58lDhx5oqm33FY8W1SYeMNkY1Fojn7cLlUlrc19yHxO3IRXJIsMWn0
 Ib9Gjhr9bT14rUgehVMbvqnpSlh9DqDepos3BMpcz3KgxuKT+7zehoR2v
 JUhPZa7E2MMllXjwq+bkYf79q12cTeuI485O3J0+kxu0TIT4x+cVUoXt3
 AMLeVbhaR+FkNsFuWe9lkOG8MwmHQeYXkTmqIaKskDyT4de4SpyOOLDVs
 oUYQBefk3E2CDrSEyyjMV4GJ/RX65p1jo1UNros0lIvC1Oym3GnJL2oOH
 v+uEvH/3ikSXsm3JHa8A7w1nEacTrDiCCyyfvecHQENCd8wt8TDWWhI6H Q==;
X-CSE-ConnectionGUID: uO0Tq/KlSpm9lOKr5WnAmg==
X-CSE-MsgGUID: 9hrZQqg8Tq2CUdbZfzHxJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="91535746"
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; d="scan'208";a="91535746"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jan 2026 16:27:22 -0800
X-CSE-ConnectionGUID: vCR2KWO/StmyDAmprPanQQ==
X-CSE-MsgGUID: dHMzlpObSQWoeWYUhFs9EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; d="scan'208";a="225411362"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.241.240.111])
 ([10.241.240.111])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jan 2026 16:27:21 -0800
Message-ID: <de20e04a-bfeb-4737-9e30-15d117e796e8@intel.com>
Date: Fri, 2 Jan 2026 16:27:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/7] target/i386/kvm: don't stop Intel PMU counters
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com
References: <20251230074354.88958-1-dongli.zhang@oracle.com>
 <20251230074354.88958-8-dongli.zhang@oracle.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20251230074354.88958-8-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zide.chen@intel.com;
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



On 12/29/2025 11:42 PM, Dongli Zhang wrote:
> PMU MSRs are set by QEMU only at levels >= KVM_PUT_RESET_STATE,
> excluding runtime. Therefore, updating these MSRs without stopping events
> should be acceptable.

It seems preferable to keep the existing logic. The sequence of
disabling -> setting new counters -> re-enabling is complete and
reasonable. Re-enabling the PMU implicitly tell KVM to do whatever
actions are needed to make the new counters take effect.

If the purpose of this patch to improve performance, given that this is
a non-critical path, trading this clear and robust logic for a minor
performance gain does not seem necessary.


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

This seems to assume KVM's internal behavior. While that is true today
(and possibly in the future), it’s not necessary for QEMU to  make such
assumptions, as that could unnecessarily limit KVM’s flexibility to
change its behavior later.


> No Fixed tag is going to be added for the commit 0d89436786b0 ("kvm:
> migrate vPMU state"), because this isn't a bugfix.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
> Changed since v3:
>   - Re-order reasons in commit messages.
>   - Mention KVM's commit 68fb4757e867 (v6.2).
>   - Keep Zhao's review as there isn't code change.
> Changed since v6:
>   - Add Reviewed-by from Dapeng Mi.
> 
>  target/i386/kvm/kvm.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 99837048b8..742dc6ac0d 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -4222,13 +4222,6 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
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
> @@ -4244,8 +4237,6 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
>                                    env->msr_global_status);
>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
>                                    env->msr_global_ovf_ctrl);
> -
> -                /* Now start the PMU.  */
>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL,
>                                    env->msr_fixed_ctr_ctrl);
>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL,


