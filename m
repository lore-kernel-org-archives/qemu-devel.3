Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED1CC531C7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmp6Q-0003GX-77; Thu, 23 Jul 2026 04:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wmp6M-0003GH-MT
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:48:23 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wmp6J-0000ts-Kl
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784796500; x=1816332500;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=P94Z702/lwPf9YzSQ+QPXlwtHz4U2+fGCTzIk5DgTU4=;
 b=OF+Gbgiy8BrDSgUh6MsKpB/O5HjSLQgVPO8ArfBmc4L7LrrB3C45x6Fr
 ktX0SAtMgTzBrw982/38jMo3IP9QufHgLAB9Gf+g0a8EdbqpP0/1khhSR
 BLZtLBdQfCJfzk9F/sRbc9/lQkr5zQ3t/36uX+wEfq6H8v/YsHQxSkHF6
 nyE7ls8fVKCIQL0SBW7GbUKpY9SYxk3/sv/0I5NnsqMMP9jQFBDjG85/z
 TC9rRNdMbPe4T1OXXe500IDgj1rttciXe78EtcnIMZuNdhGkFBK02GFXY
 Ntydhx3GnucLxFvt1FTGHPl7p3qQLgEXqmJN2UG8mnz8UCEPLLja02Xr2 Q==;
X-CSE-ConnectionGUID: cHcVzfJfS6iBy5kEQmnl1Q==
X-CSE-MsgGUID: W2aRRW7fQWCKI/yc8K1M1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85206688"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="85206688"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 01:48:17 -0700
X-CSE-ConnectionGUID: DvXs+p4UTPm63hKvdODYOQ==
X-CSE-MsgGUID: V4pe5TlwRyGRLavmfbGm8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="253997478"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
 by fmviesa006.fm.intel.com with ESMTP; 23 Jul 2026 01:48:15 -0700
Date: Thu, 23 Jul 2026 16:48:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com
Subject: Re: [PATCH v2 1/1] target/i386: Add support for KVM APERF/MPERF
 passthrough
Message-ID: <amHVTvcDeQXdrIbg@intel.com>
References: <20260602140348.774203-1-anderson@allelesecurity.com>
 <20260602140348.774203-2-anderson@allelesecurity.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602140348.774203-2-anderson@allelesecurity.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Anderson,

> +    [FEAT_6_ECX] = {
> +        .type = CPUID_FEATURE_WORD,
> +        .feat_names = {
> +            "aperfmperf", NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +            NULL, NULL, NULL, NULL,
> +        },
> +        .cpuid = { .eax = 6, .reg = R_ECX, },
> +        .tcg_features = 0,
> +        .unmigratable_flags = CPUID_6_ECX_APERFMPERF,

Considerring APER/MPERF passthrough have many specific restrictions
(listed in KVM's api.rst, "7.13 KVM_CAP_X86_DISABLE_EXITS"), I think
we also need not to enable it by default for max/host CPUs:

.no_autoenable_flags = CPUID_6_ECX_APERFMPERF

This indicates that users must manually enable this feature, and it is
assumed that they are aware of its limitations and have implemented
appropriate policies (such as no preemption, vCPU affinity, no idle or
C state in the guest, etc.).

> +    },

...

>  /* CPUID[0x80000007].EDX flags: */
>  #define CPUID_APM_INVTSC       (1U << 8)
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 9e352882c8..ca722ff9e9 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -498,6 +498,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>          }
>      } else if (function == 6 && reg == R_EAX) {
>          ret |= CPUID_6_EAX_ARAT; /* safe to allow because of emulated APIC */
> +    } else if (function == 6 && reg == R_ECX) {
> +        ret |= CPUID_6_ECX_APERFMPERF;

if we bind this feature to cpu-pm, then we should check enable_cpu_pm
before setting CPUID. Otherwise, if this CPUID is present but
cpu-pm=off, Guest may try to access related MSRs and triggers #GP.

        if (enable_cpu_pm) {
            int disable_exits = kvm_check_extension(s,
                                                    KVM_CAP_X86_DISABLE_EXITS);

            if (disable_exits & KVM_X86_DISABLE_EXITS_APERFMPERF) {
                ret |= CPUID_6_ECX_APERFMPERF;
            }
        }

But on the other hande, maybe we don't need to bind this feature to
cpu-pm?

For example, a compute-intensive workload doesn't allow the Guest to
enter idle, then it still seems make sense to estimate performance
using aperf and mperf?

Thanks,
Zhao


