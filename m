Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A00C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 03:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWoWM-0005YA-Rd; Tue, 01 Jul 2025 23:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uWoWL-0005Xw-EA
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 23:52:29 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uWoWD-00065D-6y
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 23:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751428341; x=1782964341;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ijwJ+PlLJaAwgiDKAbcCgBAxgNGVERXIgFbmZkE6Sfs=;
 b=md2ajYJnvWEXJIo5V4zg9R1lwsAM7JhD6OkhpdsFga12L7uQTdguOcPr
 Glspa9f2PHE6v5u+KdT0zL/jstL08Hyet+I227kvM/jYuPNQRowmf6XfB
 uLzvxfwYvVUXaTimGgdQnm6K3irRc8xhfH4ywbCZNAA7vlLkdtMLhTy15
 1/mC8DaEP+tKAawZsYyUeqnfErDssME14Z/Czqnpc7aCeGcyhDr+T9QrF
 J4xyDXuu4ukQAdHnma7dUBgtxrVQYl945PFYqbsMdG5jznOgYvDWZwzIC
 px4V0S8neD/d6AIbxazwCEVlr7W2/PjBV7XW44cFYwvlW9I1on3i4nfpB A==;
X-CSE-ConnectionGUID: thscG8sDTNC8e8LDGfJQYg==
X-CSE-MsgGUID: d7j582cxQ/OfWROwfg1Skg==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53670775"
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; d="scan'208";a="53670775"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 20:52:17 -0700
X-CSE-ConnectionGUID: Q/nhgqerQCmOc4CQjnPDTg==
X-CSE-MsgGUID: 7U9qfPclTiW0lCR+Y7KYfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,280,1744095600"; d="scan'208";a="154278881"
Received: from jiatingt-mobl.ccr.corp.intel.com (HELO [10.124.240.80])
 ([10.124.240.80])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2025 20:52:13 -0700
Message-ID: <59fb1bc6-e3d6-4865-87f0-ed7182caaee5@linux.intel.com>
Date: Wed, 2 Jul 2025 11:52:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] target/i386/kvm: extract unrelated code out of
 kvm_x86_build_cpuid()
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com, joe.jin@oracle.com,
 ewanhai-oc@zhaoxin.com, ewanhai@zhaoxin.com
References: <20250624074421.40429-1-dongli.zhang@oracle.com>
 <20250624074421.40429-5-dongli.zhang@oracle.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250624074421.40429-5-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=198.175.65.17;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> The initialization of 'has_architectural_pmu_version',
> 'num_architectural_pmu_gp_counters', and
> 'num_architectural_pmu_fixed_counters' is unrelated to the process of
> building the CPUID.
>
> Extract them out of kvm_x86_build_cpuid().
>
> In addition, use cpuid_find_entry() instead of cpu_x86_cpuid(), because
> CPUID has already been filled at this stage.
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changed since v1:
>   - Still extract the code, but call them for all CPUs.
> Changed since v2:
>   - Use cpuid_find_entry() instead of cpu_x86_cpuid().
>   - Didn't add Reviewed-by from Dapeng as the change isn't minor.
>
>  target/i386/kvm/kvm.c | 62 ++++++++++++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 27 deletions(-)
>
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 15155b79b5..4baaa069b8 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1968,33 +1968,6 @@ uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
>          }
>      }
>  
> -    if (limit >= 0x0a) {
> -        uint32_t eax, edx;
> -
> -        cpu_x86_cpuid(env, 0x0a, 0, &eax, &unused, &unused, &edx);
> -
> -        has_architectural_pmu_version = eax & 0xff;
> -        if (has_architectural_pmu_version > 0) {
> -            num_architectural_pmu_gp_counters = (eax & 0xff00) >> 8;
> -
> -            /* Shouldn't be more than 32, since that's the number of bits
> -             * available in EBX to tell us _which_ counters are available.
> -             * Play it safe.
> -             */
> -            if (num_architectural_pmu_gp_counters > MAX_GP_COUNTERS) {
> -                num_architectural_pmu_gp_counters = MAX_GP_COUNTERS;
> -            }
> -
> -            if (has_architectural_pmu_version > 1) {
> -                num_architectural_pmu_fixed_counters = edx & 0x1f;
> -
> -                if (num_architectural_pmu_fixed_counters > MAX_FIXED_COUNTERS) {
> -                    num_architectural_pmu_fixed_counters = MAX_FIXED_COUNTERS;
> -                }
> -            }
> -        }
> -    }
> -
>      cpu_x86_cpuid(env, 0x80000000, 0, &limit, &unused, &unused, &unused);
>  
>      for (i = 0x80000000; i <= limit; i++) {
> @@ -2098,6 +2071,39 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
>      return 0;
>  }
>  
> +static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid)
> +{
> +    struct kvm_cpuid_entry2 *c;
> +
> +    c = cpuid_find_entry(cpuid, 0xa, 0);
> +
> +    if (!c) {
> +        return;
> +    }
> +
> +    has_architectural_pmu_version = c->eax & 0xff;
> +    if (has_architectural_pmu_version > 0) {
> +        num_architectural_pmu_gp_counters = (c->eax & 0xff00) >> 8;
> +
> +        /*
> +         * Shouldn't be more than 32, since that's the number of bits
> +         * available in EBX to tell us _which_ counters are available.
> +         * Play it safe.
> +         */
> +        if (num_architectural_pmu_gp_counters > MAX_GP_COUNTERS) {
> +            num_architectural_pmu_gp_counters = MAX_GP_COUNTERS;
> +        }
> +
> +        if (has_architectural_pmu_version > 1) {
> +            num_architectural_pmu_fixed_counters = c->edx & 0x1f;
> +
> +            if (num_architectural_pmu_fixed_counters > MAX_FIXED_COUNTERS) {
> +                num_architectural_pmu_fixed_counters = MAX_FIXED_COUNTERS;
> +            }
> +        }
> +    }
> +}
> +
>  int kvm_arch_init_vcpu(CPUState *cs)
>  {
>      struct {
> @@ -2288,6 +2294,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>      cpuid_i = kvm_x86_build_cpuid(env, cpuid_data.entries, cpuid_i);
>      cpuid_data.cpuid.nent = cpuid_i;
>  
> +    kvm_init_pmu_info(&cpuid_data.cpuid);
> +
>      if (((env->cpuid_version >> 8)&0xF) >= 6
>          && (env->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
>             (CPUID_MCE | CPUID_MCA)) {

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>




