Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5157C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdiW-0004cE-CQ; Tue, 04 Mar 2025 20:38:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tpdiT-0004bp-5t
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:38:35 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tpdiP-0002lv-VZ
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741138710; x=1772674710;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=K4absVKzsv8lTq4U5SKjFXUqDZfm7QdEVd3JKOxSQqQ=;
 b=UIMI67+Nklx4XEXhwqLXBPjjl0cVV7uLPycxodqlgltOgQwvF4Rlj0no
 gugKcnTqZdFrB+D1uN22ySWakDRO7WBhrSBQ4uy8+o79r6dcOHHuZVa8P
 Piq+S/XBf1zwFZyQjHnwWTb9KLkuUFKh0L4ru3Rnr3UOKemAzY+ysJYOk
 nSwcfxuEZT1pRIbwOPq2HV636QG5kLFBzQzc8zFeEu4Bm3ULZEACSjtr4
 6UlhOIAO9j8rfowboGWfFnackr9bDWwGuNKHPA1pLV/HDwU8+SHCheUmV
 oWCmGuP/aCqycHQfcXKvuHQaNaSZNQA0uV1xNW2QeeKhHQiJSh1a19Ect Q==;
X-CSE-ConnectionGUID: FxgCA+fKTQK0BlTGdatrzw==
X-CSE-MsgGUID: 7X1g9RiURVCyoA8qriEBvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41976199"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; d="scan'208";a="41976199"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 17:38:27 -0800
X-CSE-ConnectionGUID: 7VCINtbaT/mZ4zjbg4es1Q==
X-CSE-MsgGUID: 2uAVGxFmTKO5RLyBpkwRtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119439029"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 17:38:23 -0800
Message-ID: <1412c575-0a04-4d36-8b7f-e722da4d291f@intel.com>
Date: Wed, 5 Mar 2025 09:38:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] target/i386: disable PerfMonV2 when PERFCORE
 unavailable
To: dongli.zhang@oracle.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, zhenyuw@linux.intel.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, dapeng1.mi@linux.intel.com, joe.jin@oracle.com
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-2-dongli.zhang@oracle.com>
 <46cd2769-aad6-4b99-aea9-426968a9d7cb@intel.com>
 <d6644767-3ed9-41be-847f-950d3666e0c6@oracle.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <d6644767-3ed9-41be-847f-950d3666e0c6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=xiaoyao.li@intel.com;
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

On 3/5/2025 6:53 AM, dongli.zhang@oracle.com wrote:
> Hi Xiaoyao,
> 
> On 3/4/25 6:40 AM, Xiaoyao Li wrote:
>> On 3/3/2025 6:00 AM, Dongli Zhang wrote:
>>> When the PERFCORE is disabled with "-cpu host,-perfctr-core", it is
>>> reflected in in guest dmesg.
>>>
>>> [    0.285136] Performance Events: AMD PMU driver.
>>
>> I'm a little confused. wWhen no perfctr-core, AMD PMU driver can still be
>> probed? (forgive me if I ask a silly question)
> 
> Intel use "cpuid -1 -l 0xa" to determine the support of PMU.
> 
> However, AMD doesn't use CPUID to determine PMU support (except AMD PMU
> PerfMonV2).
> 
> I have derived everything from Linux kernel function amd_pmu_init().
> 
> As line 1521, the PMU isn't supported by old AMD CPUs.
> 
> 1516 __init int amd_pmu_init(void)
> 1517 {
> 1518         int ret;
> 1519
> 1520         /* Performance-monitoring supported from K7 and later: */
> 1521         if (boot_cpu_data.x86 < 6)
> 1522                 return -ENODEV;
> 1523
> 1524         x86_pmu = amd_pmu;
> 1525
> 1526         ret = amd_core_pmu_init();
> 
> 
> 1. Therefore, at least 4 PMCs are available (without 'perfctr-core').
> 
> 2. With 'perfctr-core', there are 6 PMCs. (line 1410)
> 
> 1404 static int __init amd_core_pmu_init(void)
> 1405 {
> 1406         union cpuid_0x80000022_ebx ebx;
> 1407         u64 even_ctr_mask = 0ULL;
> 1408         int i;
> 1409
> 1410         if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
> 1411                 return 0;
> 1412
> 1413         /* Avoid calculating the value each time in the NMI handler */
> 1414         perf_nmi_window = msecs_to_jiffies(100);
> 1415
> 1416         /*
> 1417          * If core performance counter extensions exists, we must use
> 1418          * MSR_F15H_PERF_CTL/MSR_F15H_PERF_CTR msrs. See also
> 1419          * amd_pmu_addr_offset().
> 1420          */
> 1421         x86_pmu.eventsel        = MSR_F15H_PERF_CTL;
> 1422         x86_pmu.perfctr         = MSR_F15H_PERF_CTR;
> 1423         x86_pmu.cntr_mask64     = GENMASK_ULL(AMD64_NUM_COUNTERS_CORE
> - 1, 0);
> 
> 
> 3. With PerfMonV2, extra global registers are available, as well as PMCs.
> (line 1426)
> 
> 1425         /* Check for Performance Monitoring v2 support */
> 1426         if (boot_cpu_has(X86_FEATURE_PERFMON_V2)) {
> 1427                 ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
> 1428
> 1429                 /* Update PMU version for later usage */
> 1430                 x86_pmu.version = 2;
> 1431
> 1432                 /* Find the number of available Core PMCs */
> 1433                 x86_pmu.cntr_mask64 =
> GENMASK_ULL(ebx.split.num_core_pmc - 1, 0);
> 1434
> 1435                 amd_pmu_global_cntr_mask = x86_pmu.cntr_mask64;
> 1436
> 1437                 /* Update PMC handling functions */
> 1438                 x86_pmu.enable_all = amd_pmu_v2_enable_all;
> 1439                 x86_pmu.disable_all = amd_pmu_v2_disable_all;
> 1440                 x86_pmu.enable = amd_pmu_v2_enable_event;
> 1441                 x86_pmu.handle_irq = amd_pmu_v2_handle_irq;
> 1442                 static_call_update(amd_pmu_test_overflow,
> amd_pmu_test_overflow_status);
> 1443         }
> 
> 
> That's why legacy 4-PMC PMU is probed after we disable perfctr-core.
> 
> - (boot_cpu_data.x86 < 6): No PMU.
> - Without perfctr-core: 4 PMCs
> - With perfctr-core: 6 PMCs
> - PerfMonV2: PMCs (currently 6) + global PMU registers
> 
> 
> May this resolve your concern in another thread that "This looks like a KVM
> bug."? This isn't a KVM bug. It is because AMD's lack of the configuration
> to disable PMU.

It helps a lot! Yes, it doesn't a KVM bug.

Thanks for your elaborated explanation!

> Thank you very much!
> 
> Dongli Zhang
> 
>>
>>> However, the guest CPUID indicates the PerfMonV2 is still available.
>>>
>>> CPU:
>>>      Extended Performance Monitoring and Debugging (0x80000022):
>>>         AMD performance monitoring V2         = true
>>>         AMD LBR V2                            = false
>>>         AMD LBR stack & PMC freezing          = false
>>>         number of core perf ctrs              = 0x6 (6)
>>>         number of LBR stack entries           = 0x0 (0)
>>>         number of avail Northbridge perf ctrs = 0x0 (0)
>>>         number of available UMC PMCs          = 0x0 (0)
>>>         active UMCs bitmask                   = 0x0
>>>
>>> Disable PerfMonV2 in CPUID when PERFCORE is disabled.
>>>
>>> Suggested-by: Zhao Liu <zhao1.liu@intel.com>
>>
>> Though I have above confusion of the description, the change itself looks
>> good to me. So
>>
>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>
>>> Fixes: 209b0ac12074 ("target/i386: Add PerfMonV2 feature bit")
>>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>>> ---
>>> Changed since v1:
>>>     - Use feature_dependencies (suggested by Zhao Liu).
>>>
>>>    target/i386/cpu.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 72ab147e85..b6d6167910 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -1805,6 +1805,10 @@ static FeatureDep feature_dependencies[] = {
>>>            .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_AVX10 },
>>>            .to = { FEAT_24_0_EBX,              ~0ull },
>>>        },
>>> +    {
>>> +        .from = { FEAT_8000_0001_ECX,       CPUID_EXT3_PERFCORE },
>>> +        .to = { FEAT_8000_0022_EAX,
>>> CPUID_8000_0022_EAX_PERFMON_V2 },
>>> +    },
>>>    };
>>>      typedef struct X86RegisterInfo32 {
>>
> 


