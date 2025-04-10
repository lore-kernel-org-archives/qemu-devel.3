Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1354FC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 07:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2mG2-0002a3-IK; Thu, 10 Apr 2025 03:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u2mFv-0002ZA-98; Thu, 10 Apr 2025 03:23:25 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u2mFr-0001d0-Ee; Thu, 10 Apr 2025 03:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744269799; x=1775805799;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Lh9jXEP9tgVr78Y+bjPvBpsrVvBVBSu8yVPe3X6/PBk=;
 b=nRSb0qd0mPvsnCA8UggK+s4HYDYYQqiZHFFKu2AgqgRgHa5OErudp0kh
 dPSwh8QqCcAJzjAZEsnMMCnieQhOcVkL7ACndmJPk/WpbHJQhGBrDR7sN
 Lysqx2d25eDSWh3e1Odxb/56DgVXlReueZ1Pg0v5Be7d9xtvp4MOPEJEG
 Qsuo9TFSxOaYOmsezbLCMlPJUqGt28hi7VFvu6fmhmuzzNIKZVRx5hPmU
 ZigwN8HYEdRwAxsQHegTcV+XcF7S1o03cSxSSZ5fHm1ZOim03DgidL94y
 c74j86YTvk7wyg3UJbIoIelKTCqebbc9mxwqZtBYRfKHO0zEKxYN7L57+ Q==;
X-CSE-ConnectionGUID: NOrZ43W/SsKlMPxVOpa4XA==
X-CSE-MsgGUID: o8wDdkHJQ6+PtL+MBLCRVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="48477565"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; d="scan'208";a="48477565"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2025 00:23:14 -0700
X-CSE-ConnectionGUID: XUminAD6T0GYkRlVFemdzg==
X-CSE-MsgGUID: pctWMc5OS/GsMX0hxH8+og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; d="scan'208";a="128681029"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 10 Apr 2025 00:23:05 -0700
Date: Thu, 10 Apr 2025 15:43:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, mtosatti@redhat.com, sandipan.das@amd.com,
 babu.moger@amd.com, likexu@tencent.com, like.xu.linux@gmail.com,
 groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com,
 peter.maydell@linaro.org, gaosong@loongson.cn,
 chenhuacai@kernel.org, philmd@linaro.org, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, arikalo@gmail.com, npiggin@gmail.com,
 danielhb413@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 thuth@redhat.com, flavra@baylibre.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com, louisqi@zhaoxin.com,
 liamni@zhaoxin.com, frankzhu@zhaoxin.com, silviazhao@zhaoxin.com
Subject: Re: [PATCH v3 08/10] target/i386/kvm: reset AMD PMU registers during
 VM reset
Message-ID: <Z/d2ucu6Y5xlNh6S@intel.com>
References: <20250331013307.11937-1-dongli.zhang@oracle.com>
 <20250331013307.11937-9-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331013307.11937-9-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

...

> TODO:
>   - This patch adds is_host_compat_vendor(), while there are something
>     like is_host_cpu_intel() from target/i386/kvm/vmsr_energy.c. A rework
>     may help move those helpers to target/i386/cpu*.

vmsr_energy emulates RAPL in user space...but RAPL is not architectural
(no CPUID), so this case doesn't need to consider "compat" vendor.

>  target/i386/cpu.h     |   8 ++
>  target/i386/kvm/kvm.c | 176 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 180 insertions(+), 4 deletions(-)

...

> +static bool is_host_compat_vendor(CPUX86State *env)
> +{
> +    char host_vendor[CPUID_VENDOR_SZ + 1];
> +    uint32_t host_cpuid_vendor1;
> +    uint32_t host_cpuid_vendor2;
> +    uint32_t host_cpuid_vendor3;
>
> +    host_cpuid(0x0, 0, NULL, &host_cpuid_vendor1, &host_cpuid_vendor3,
> +               &host_cpuid_vendor2);
> +
> +    x86_cpu_vendor_words2str(host_vendor, host_cpuid_vendor1,
> +                             host_cpuid_vendor2, host_cpuid_vendor3);

We can use host_cpu_vendor_fms() (with a little change). If you like
this idea, pls feel free to pick my cleanup patch into your series.

> +    /*
> +     * Intel and Zhaoxin are compatible.
> +     */
> +    if ((g_str_equal(host_vendor, CPUID_VENDOR_INTEL) ||
> +         g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN1) ||
> +         g_str_equal(host_vendor, CPUID_VENDOR_ZHAOXIN2)) &&
> +        (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
> +        return true;
> +    }
> +
> +    return env->cpuid_vendor1 == host_cpuid_vendor1 &&
> +           env->cpuid_vendor2 == host_cpuid_vendor2 &&
> +           env->cpuid_vendor3 == host_cpuid_vendor3;

Checking AMD directly makes the "compat" rule clear:

    return g_str_equal(host_vendor, CPUID_VENDOR_AMD) &&
           IS_AMD_CPU(env);

> +}

...

>      if (env->mcg_cap) {
>          kvm_msr_entry_add(cpu, MSR_MCG_STATUS, 0);
>          kvm_msr_entry_add(cpu, MSR_MCG_CTL, 0);
> @@ -4871,6 +5024,21 @@ static int kvm_get_msrs(X86CPU *cpu)
>          case MSR_P6_EVNTSEL0 ... MSR_P6_EVNTSEL0 + MAX_GP_COUNTERS - 1:
>              env->msr_gp_evtsel[index - MSR_P6_EVNTSEL0] = msrs[i].data;
>              break;
> +        case MSR_K7_EVNTSEL0 ... MSR_K7_EVNTSEL0 + AMD64_NUM_COUNTERS - 1:
> +            env->msr_gp_evtsel[index - MSR_K7_EVNTSEL0] = msrs[i].data;
> +            break;
> +        case MSR_K7_PERFCTR0 ... MSR_K7_PERFCTR0 + AMD64_NUM_COUNTERS - 1:
> +            env->msr_gp_counters[index - MSR_K7_PERFCTR0] = msrs[i].data;
> +            break;
> +        case MSR_F15H_PERF_CTL0 ...
> +             MSR_F15H_PERF_CTL0 + AMD64_NUM_COUNTERS_CORE * 2 - 1:
> +            index = index - MSR_F15H_PERF_CTL0;
> +            if (index & 0x1) {
> +                env->msr_gp_counters[index] = msrs[i].data;
> +            } else {
> +                env->msr_gp_evtsel[index] = msrs[i].data;

This msr_gp_evtsel[] array's size is 18:

#define MAX_GP_COUNTERS    (MSR_IA32_PERF_STATUS - MSR_P6_EVNTSEL0)

This formula is based on Intel's MSR, it's best to add a note that the
current size also meets AMD's needs. (No need to adjust the size, as
it will affect migration).

> +            }
> +            break;
>          case HV_X64_MSR_HYPERCALL:
>              env->msr_hv_hypercall = msrs[i].data;
>              break;

Others LGTM!

Thanks,
Zhao


