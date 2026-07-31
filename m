Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7557AC55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 05:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpgDV-0001am-RB; Fri, 31 Jul 2026 01:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wpgDU-0001aZ-6G
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 01:55:32 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wpgDR-0002h2-Oc
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 01:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785477330; x=1817013330;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ELP27T7CzJ7pekqWXnrxNQUz7POvRwTX+9GwDoK/zbE=;
 b=dZFxY40NzCNoV7124nc7OCFExP2gbxhwheCN+Kv4MKsfeKl1jusNAK6B
 TLqKw4Ic0cgYdDhqJDK8l0Rhue2lJ5E1IEYK16DdOtu/N0mncxce9wc4g
 ZdidWVvxjWoHD+A5K58KEu5+BKKDxoIheOMz5rN/oY00PW5Xd/L4m5f7g
 Ws/lRZ6yw6FMUweu4G0mAte1Rzo4mmZnCzUn7fzwOBUAV1FopT9e0iSW1
 55ibMDApKGG/Aepm9YB/X9FuhOpA25RuFk59H7shsCSWcJ+s9BRdoscIx
 KKL7aZkv5JoZ0mjuoQ8Shj/S2v56uaYhs1uGo3oJ7SNYz8ZHH7MSwiYRy A==;
X-CSE-ConnectionGUID: WBMvzGv/QjCcoq/VklSAqQ==
X-CSE-MsgGUID: bKltecNdTRW4rYBOcz+aGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="89781924"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="89781924"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 22:55:23 -0700
X-CSE-ConnectionGUID: gL3LxDFUQGqam9BTzI7Ekw==
X-CSE-MsgGUID: vazUCHOIR4mqV+a7lYocZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="262463620"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa004.fm.intel.com with ESMTP; 30 Jul 2026 22:55:21 -0700
Date: Fri, 31 Jul 2026 13:55:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: zhang_wei@open-hieco.net
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v1 5/9] target/i386/kvm: Use AMD PMU MSR paths for Hygon
Message-ID: <amw4x/BFXEJMwbI9@intel.com>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
 <20260706055530.1752094-6-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706055530.1752094-6-zhang_wei@open-hieco.net>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hello Tina,

> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 8e2bfbbe1d..215e0c8f03 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2175,6 +2175,21 @@ static void kvm_init_pmu_info_amd(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
>      }
>  }
>  
> +/*
> + * KVM exposes the AMD PMU CPUID/MSR layout for Hygon guests, so QEMU must
> + * use the AMD PMU setup and MSR state paths for Hygon too.
> + */
> +static bool kvm_pmu_uses_amd_msrs(const CPUX86State *env)
> +{
> +    return IS_AMD_CPU(env) || IS_HYGON_CPU(env);
> +}
> +
> +static bool host_cpu_uses_amd_pmu_msrs(const char *host_vendor)
> +{
> +    return g_str_equal(host_vendor, CPUID_VENDOR_AMD) ||
> +           g_str_equal(host_vendor, CPUID_VENDOR_HYGON);
> +}
>
>  static bool is_host_compat_vendor(CPUX86State *env)
>  {
>      char host_vendor[CPUID_VENDOR_SZ + 1];
> @@ -2191,8 +2206,8 @@ static bool is_host_compat_vendor(CPUX86State *env)
>          return true;
>      }
>
> -    return g_str_equal(host_vendor, CPUID_VENDOR_AMD) &&
> -           IS_AMD_CPU(env);
> +    return host_cpu_uses_amd_pmu_msrs(host_vendor) &&
> +           kvm_pmu_uses_amd_msrs(env);
>  }

It seems to be doing the same thing as the previous Intel & Zhaoxin
compatibility check.

To unify similar checks, how about we abstract them into the "PMU vendor
family"?

For example,

typedef enum {
    X86_PMU_VENDOR_UNKNOWN,
    X86_PMU_VENDOR_INTEL,
    X86_PMU_VENDOR_AMD,
} X86PMUVendor;

static X86PMUVendor x86_cpu_pmu_vendor(const CPUX86State *env)
{
    if (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) {
        return X86_PMU_VENDOR_INTEL;
    }
    if (IS_AMD_CPU(env) || IS_HYGON_CPU(env)) {
        return X86_PMU_VENDOR_AMD;
    }
    return X86_PMU_VENDOR_UNKNOWN;
}

static X86PMUVendor x86_host_pmu_vendor(void)
{
    char host_vendor[CPUID_VENDOR_SZ + 1];

    host_cpu_vendor_fms(host_vendor, NULL, NULL, NULL);

    if (g_str_equal(host_vendor, CPUID_VENDOR_INTEL) ||
        g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN1) ||
        g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN2)) {
        return X86_PMU_VENDOR_INTEL;
    }

    if (g_str_equal(host_vendor, CPUID_VENDOR_AMD) ||
        g_str_equal(host_vendor, CPUID_VENDOR_HYGON)) {
        return X86_PMU_VENDOR_AMD;
    }
    return X86_PMU_VENDOR_UNKNOWN;
}

/*
 * The guest vPMU can be virtualized only when the host and guest's PMU
 * architectures are compatible.
 */
static bool is_host_compat_vendor(CPUX86State *env)
{
    X86PMUVendor guest = x86_cpu_pmu_vendor(env);

    return guest != X86_PMU_VENDOR_UNKNOWN && guest == x86_host_pmu_vendor();
}

>  static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
> @@ -2222,7 +2237,7 @@ static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
>  
>      if (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) {
>          kvm_init_pmu_info_intel(cpuid);
> -    } else if (IS_AMD_CPU(env)) {
> +    } else if (kvm_pmu_uses_amd_msrs(env)) {
>          kvm_init_pmu_info_amd(cpuid, cpu);
>      }
>  }

Then such CPU check can be replaced with:

    switch (x86_cpu_pmu_vendor(env)) {
    case X86_PMU_VENDOR_INTEL:
        kvm_init_pmu_info_intel(cpuid);
        break;
    case X86_PMU_VENDOR_AMD:
        kvm_init_pmu_info_amd(cpuid, cpu);
        break;
    default:
        g_assert_not_reached();
    }

The latter can also be replaced with "x86_cpu_pmu_vendor(env) ==
X86_PMU_VENDOR_AMD" instead of the "kvm_pmu_uses_amd_msrs(env)" you're
currently using.

What do you think?

Regards,
Zhao

