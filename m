Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888F9F513F6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 05:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyNf6-00006g-IP; Fri, 06 Mar 2026 00:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vyNf5-00006Q-9q
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 00:23:43 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vyNf2-0002Yk-2t
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 00:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772774620; x=1804310620;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=0ax+oQaiJNLdZbHr5DGxG6SrjHrdNmxRhayTtiFKdUc=;
 b=dheexKQdO0ZyByigS+n7K5qtVz3eNBTxM6rLIqLlW/twikvxL2xSw4oZ
 OYRqbl/TIAo+l2LH9yJv6vVtLBkS+cPxJWsPS24KuaOjWhbvisshoOxXx
 WJo39eAEtANxWmD98pvu/Og8K9c7m6fFS3o9PSb7V7hCTpeM1BIvhFAmn
 zvFd3+nC/7Zal15qq1gL3cIKFmXXSKQYpvpNU1Jo6fX0kWX2WeP4yH6tE
 LxJA5i7M8oeKpkna6Grc/+al2fTh+Wc8hD+hyDrSSup3bcP2h7jIcPJ1E
 Q9YQPU+rdU55ni4OLq1sqtZxdPJEAWwmZG9fO7Y4w2/IZeE8euVvquCW7 w==;
X-CSE-ConnectionGUID: 2oH1BKv1QwSZlF3G0pBAXA==
X-CSE-MsgGUID: MJ/xaqNmRgOFNPcYhQ5cIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="85227019"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="85227019"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 21:23:36 -0800
X-CSE-ConnectionGUID: wN8otppCTQqGbCxZ6jpQYw==
X-CSE-MsgGUID: 5X38X1puTrub+C0yV+nrcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="215629134"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147])
 ([10.124.241.147])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 21:23:33 -0800
Message-ID: <143fcad8-1637-45e9-94e5-5ca3cca499bb@linux.intel.com>
Date: Fri, 6 Mar 2026 13:23:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 11/13] target/i386: Add pebs-fmt CPU option
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
 <20260304180713.360471-12-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260304180713.360471-12-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 3/5/2026 2:07 AM, Zide Chen wrote:
> Similar to lbr-fmt, target/i386 does not support multi-bit CPU
> properties, so the PEBS record format cannot be exposed as a
> user-visible CPU feature.
>
> Add a pebs-fmt option to allow users to specify the PEBS format via the
> command line.  Since the PEBS state is part of the vmstate, this option
> is considered migratable.
>
> We do not support PEBS record format 0.  Although it is a valid format
> on some very old CPUs, it is unlikely to be used in practice.  This
> allows pebs-fmt=0 to be used to explicitly disable PEBS in the case of
> migratable=off.
>
> If PEBS is not enabled, mark it as unavailable in IA32_MISC_ENABLE and
> clear the PEBS-related bits in IA32_PERF_CAPABILITIES.
>
> If migratable=on on PEBS capable host and pmu is enabled:
> - PEBS is disabled if pebs-fmt is not specified or pebs-fmt=0.
> - PEBS is enabled if pebs-fmt is set to the same value as the host.
>
> When migratable=off, the behavior is similar, except that omitting
> the pebs-fmt option does not disable PEBS.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V3:
> - If DS is not available, make this option invalid.
> - If pebs_fmt is 0, mark PEBS unavailable.
> - Move MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL code from [patch v2 11/11] to
>   this patch for tighter logic.
> - Add option usage to commit message.
>
> V2: New patch.
> ---
>  target/i386/cpu.c         | 23 ++++++++++++++++++++++-
>  target/i386/cpu.h         |  7 +++++++
>  target/i386/kvm/kvm-cpu.c |  1 +
>  3 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index d5e00b41fb04..2e1dea65d708 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -9170,6 +9170,13 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
>          env->msr_ia32_misc_enable |= MSR_IA32_MISC_ENABLE_MWAIT;
>      }
>  
> +    if (!(env->features[FEAT_1_EDX] & CPUID_DTS) ||
> +	!(env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_PEBS_FORMAT)) {
> +        /* Mark PEBS unavailable and clear all PEBS related bits. */
> +        env->msr_ia32_misc_enable |= MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL;
> +        env->features[FEAT_PERF_CAPABILITIES] &= ~0x34fc0ull;

Better use a combined macro bitmap to clear the PEBS bits instead of a
magic number. It's hard to read and check.


> +    }
> +
>      memset(env->dr, 0, sizeof(env->dr));
>      env->dr[6] = DR6_FIXED_1;
>      env->dr[7] = DR7_FIXED_1;
> @@ -9784,10 +9791,17 @@ static bool x86_cpu_apply_lbr_pebs_fmt(X86CPU *cpu, uint64_t host_perf_cap,
>          shift = PERF_CAP_LBR_FMT_SHIFT;
>          name = "lbr";
>      } else {
> -        return false;
> +        mask = PERF_CAP_PEBS_FMT_MASK;
> +        shift = PERF_CAP_PEBS_FMT_SHIFT;
> +        name = "pebs";
>      }
>  
>      if (user_req != -1) {
> +        if (!is_lbr_fmt && !(env->features[FEAT_1_EDX] & CPUID_DTS)) {
> +            error_setg(errp, "vPMU: %s is unsupported without Debug Store", name);

Better change the name to preciser "ds pebs" since arch-PEBS doesn't depend
on DS. Thanks.


> +            return false;
> +        }
> +
>          env->features[FEAT_PERF_CAPABILITIES] &= ~(mask << shift);
>          env->features[FEAT_PERF_CAPABILITIES] |= (user_req << shift);
>      }
> @@ -9825,6 +9839,11 @@ static int x86_cpu_pmu_realize(X86CPU *cpu, Error **errp)
>          return -EINVAL;
>      }
>  
> +    if (!x86_cpu_apply_lbr_pebs_fmt(cpu, host_perf_cap,
> +                                    cpu->pebs_fmt, false, errp)) {
> +        return -EINVAL;
> +    }
> +
>      return 0;
>  }
>  
> @@ -10291,6 +10310,7 @@ static void x86_cpu_initfn(Object *obj)
>  
>      object_property_add_alias(obj, "hv-apicv", obj, "hv-avic");
>      object_property_add_alias(obj, "lbr_fmt", obj, "lbr-fmt");
> +    object_property_add_alias(obj, "pebs_fmt", obj, "pebs-fmt");
>  
>      if (xcc->model) {
>          x86_cpu_load_model(cpu, xcc->model);
> @@ -10462,6 +10482,7 @@ static const Property x86_cpu_properties[] = {
>      DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
>      DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
>      DEFINE_PROP_UINT64_CHECKMASK("lbr-fmt", X86CPU, lbr_fmt, PERF_CAP_LBR_FMT_MASK),
> +    DEFINE_PROP_UINT64_CHECKMASK("pebs-fmt", X86CPU, pebs_fmt, PERF_CAP_PEBS_FMT_MASK),
>  
>      DEFINE_PROP_UINT32("hv-spinlocks", X86CPU, hyperv_spinlock_attempts,
>                         HYPERV_SPINLOCK_NEVER_NOTIFY),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index a064bf8ab17e..6a9820c4041a 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -422,6 +422,10 @@ typedef enum X86Seg {
>  #define MSR_IA32_PERF_CAPABILITIES      0x345
>  #define PERF_CAP_LBR_FMT_MASK           0x3f
>  #define PERF_CAP_LBR_FMT_SHIFT          0x0
> +#define PERF_CAP_PEBS_FMT_MASK          0xf
> +#define PERF_CAP_PEBS_FMT_SHIFT         0x8
> +#define PERF_CAP_PEBS_FORMAT            (PERF_CAP_PEBS_FMT_MASK << \
> +                                         PERF_CAP_PEBS_FMT_SHIFT)
>  #define PERF_CAP_FULL_WRITE             (1U << 13)
>  #define PERF_CAP_PEBS_BASELINE          (1U << 14)
>  
> @@ -2410,6 +2414,9 @@ struct ArchCPU {
>       */
>      uint64_t lbr_fmt;
>  
> +    /* PEBS_FMT bits in IA32_PERF_CAPABILITIES MSR. */
> +    uint64_t pebs_fmt;
> +
>      /* LMCE support can be enabled/disabled via cpu option 'lmce=on/off'. It is
>       * disabled by default to avoid breaking migration between QEMU with
>       * different LMCE configurations.
> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index 1d0047d037c7..60bf3899852a 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -231,6 +231,7 @@ static void kvm_cpu_instance_init(CPUState *cs)
>      }
>  
>      cpu->lbr_fmt = -1;
> +    cpu->pebs_fmt = -1;
>  
>      kvm_cpu_xsave_init();
>  }

