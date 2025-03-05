Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A22C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdfo-00062y-Dj; Tue, 04 Mar 2025 20:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tpdfX-0005e9-1j
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:35:32 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tpdfT-0002HS-Oc
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741138528; x=1772674528;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=QiMh0iRts9104TqNvjrIL2k35D8Y8FztnArkpKW4d2k=;
 b=kD2/LUve/BNIbddCM1BjLrQSXMRIZPE1TVh9tyYSa8e+oNEatPiE3PCK
 WdMRve6Ngs6LIqSoYkr6ItodbYJBwOcnIYtx62PhVGZ9FEzZNitwO4vS/
 vq8WMW/o9/cc0JIyXMvv9OTb1HENqGyGvUMrmVigDZ8edkLJT8JC7MzOQ
 nA2UUyip2l7H0aUfkk806YTGdyrywZDZZFecFZWyLY68XwvkkiwS95tiy
 TSJAjRemna7mywtnZjmkrbW/6BdDeONv+yK6Gn+DdlsDEDPVSr2Sj8P7e
 9sD+LC8wi/7HfD67A2sdMsO+iD1xuSJr3UsvUZk6Q9geh7s/0UPCkAWzh g==;
X-CSE-ConnectionGUID: Oh9NHNjoTgeH5Wp9hPnBaw==
X-CSE-MsgGUID: Lkqx0JOnTD2VDieaDU4y2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41940133"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; d="scan'208";a="41940133"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 17:35:25 -0800
X-CSE-ConnectionGUID: KjNWeVdOSIm87daBpzdDXA==
X-CSE-MsgGUID: yrfcwCikRGW9vGRnzZvTaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; d="scan'208";a="118264472"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 17:35:20 -0800
Message-ID: <f6fd4fd9-0284-4c7c-b314-c3985306689a@intel.com>
Date: Wed, 5 Mar 2025 09:35:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] target/i386/kvm: set KVM_PMU_CAP_DISABLE if
 "-pmu" is configured
To: Sean Christopherson <seanjc@google.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, pbonzini@redhat.com, zhao1.liu@intel.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com, zhenyuw@linux.intel.com,
 groug@kaod.org, khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, davydov-max@yandex-team.ru, dapeng1.mi@linux.intel.com,
 joe.jin@oracle.com
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-5-dongli.zhang@oracle.com>
 <76da2b4a-2dc4-417c-91bc-ad29e08c8ba0@intel.com>
 <Z8enUUXhfRTr7KCf@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Z8enUUXhfRTr7KCf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3/5/2025 9:22 AM, Sean Christopherson wrote:
> On Tue, Mar 04, 2025, Xiaoyao Li wrote:
>> On 3/3/2025 6:00 AM, Dongli Zhang wrote:
>>> Although AMD PERFCORE and PerfMonV2 are removed when "-pmu" is configured,
>>> there is no way to fully disable KVM AMD PMU virtualization. Neither
>>> "-cpu host,-pmu" nor "-cpu EPYC" achieves this.
>>
>> This looks like a KVM bug.
> 
> Heh, the patches you sent do fix _a_ KVM bug, but this is something else entirely.

Aha, that fix was just found by code inspection. It was not supposed to 
be related with this.

> In practice, the KVM bug only affects what KVM_GET_SUPPORTED_CPUID returns when
> enable_pmu=false, and in that case, it's only a reporting issue, i.e. KVM will
> still block usage of the PMU.
> 
> As Dongli pointed out, older AMD CPUs don't actually enumerate a PMU in CPUID,
> and so the kernel assumes that not-too-old CPUs have a PMU:
> 
> 	/* Performance-monitoring supported from K7 and later: */
> 	if (boot_cpu_data.x86 < 6)
> 		return -ENODEV;
> 
> The "expected" output:
> 
>     Performance Events: PMU not available due to virtualization, using software events only.
> 
> is a long-standing workaround in the kernel to deal with lack of enumeration.  On
> top of explicit enumeration, init_hw_perf_events() => check_hw_exists() probes
> hardware to see if it actually works.  If an MSR is unexpectedly unavailable, as
> is the case when running as a guest, the kernel prints a message and disables PMU
> usage.  E.g. the above message is specific to running as a guest:
> 
> 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
> 		pr_cont("PMU not available due to virtualization, using software events only.\n");
> 
>  From the KVM side, because there's no CPUID enumeration, there's no way for KVM
> to know that userspace wants to completely disable PMU virtualization from CPUID
> alone.  Whereas with Intel CPUs, KVM infers that the PMU should be disabled by
> lack of a non-zero PMU version, e.g. if CPUID.0xA is omitted.

I see now.

Thanks to you and Dongli!

>> Anyway, since QEMU can achieve its goal with KVM_PMU_CAP_DISABLE with
>> current KVM, I'm fine with it.
> 
> Yeah, this is the only way other than disabling KVM's PMU virtualization via
> module param (enable_pmu).


