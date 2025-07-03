Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B201CC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFgG-000817-DC; Thu, 03 Jul 2025 04:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXFgF-00080l-BU
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:52:31 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1uXFgD-0005Tz-1c
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751532749; x=1783068749;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=RGp2IYBSlgL7Z2QGkvyqlsl6XvSBu1LGZnAFDOo6OB8=;
 b=eGa8VrO5keQLg42NevZxqxVOlk6kTluP0T4VLHA+X3CTzbKte83PMfFA
 vo1XoME8asaR1sMTcv862Uf3OMGWu14xZemXO+h3POjDsWFhFxgw5/V85
 sEAsIFxzWLdpkwRACoKoLGwnZ4Q7vDHXLCtN5hEuRFuLheNmRj9VRE6e9
 EQDnnBQSm4E3fhFTc1I3pQZrefaE5z/s5EVhFLvWsG15UCfsax2YUAtcQ
 2LjGJB7LrhSyF/7CUmkKczq+W3JoTZkfOMKTslDuZ/UBEo4OuII8h527x
 CRwIYLrIANnGoDdgVbj5a6YWQmrNJSP1kP07BYIk4oBRPo6nO5fvChFRd Q==;
X-CSE-ConnectionGUID: zKdnEyY3TTqW1CD8dPuguA==
X-CSE-MsgGUID: C5C45qigRCOInmogYgVGsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="57656084"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="57656084"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 01:52:22 -0700
X-CSE-ConnectionGUID: 6rgvgJ6DR4CPcCqSE8VxMw==
X-CSE-MsgGUID: gsaNmN6GT7mfyeE6+TmyVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="160010870"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.80])
 ([10.124.240.80])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 01:52:18 -0700
Message-ID: <e654a638-1dc0-4ee5-b3cb-74ca34145ab8@linux.intel.com>
Date: Thu, 3 Jul 2025 16:52:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] i386/cpu: Select legacy cache model based on vendor
 in CPUID 0x80000005
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20250620092734.1576677-1-zhao1.liu@intel.com>
 <20250620092734.1576677-14-zhao1.liu@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250620092734.1576677-14-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.198.163.12;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 6/20/2025 5:27 PM, Zhao Liu wrote:
> As preparation for merging cache_info_cpuid4 and cache_info_amd in
> X86CPUState, set legacy cache model based on vendor in the CPUID
> 0x80000005 leaf. For AMD CPU, select legacy AMD cache model (in
> cache_info_amd) as the default cache model like before, otherwise,
> select legacy Intel cache model (in cache_info_cpuid4).
>
> To ensure compatibility is not broken, add an enable_legacy_vendor_cache
> flag based on x-vendor-only-v2 to indicate cases where the legacy cache
> model should be used regardless of the vendor. For CPUID 0x80000005
> leaf, enable_legacy_vendor_cache flag indicates to pick legacy AMD cache
> model, which is for compatibility with the behavior of PC machine v10.0
> and older.
>
> The following explains how current vendor-based default legacy cache
> model ensures correctness without breaking compatibility.
>
> * For the PC machine v6.0 and older, vendor_cpuid_only=false, and
>   vendor_cpuid_only_v2=false.
>
>   - If the named CPU model has its own cache model, and doesn't use
>     legacy cache model (legacy_cache=false), then cache_info_cpuid4 and
>     cache_info_amd are same, so 0x80000005 leaf uses its own cache model
>     regardless of the vendor.
>
>   - For max/host/named CPU (without its own cache model), then the flag
>     enable_legacy_vendor_cache is true, they will use legacy AMD cache
>     model just like their previous behavior.
>
> * For the PC machine v10.0 and older (to v6.1), vendor_cpuid_only=true,
>   and vendor_cpuid_only_v2=false.
>
>   - No change, since this leaf doesn't aware vendor_cpuid_only.
>
> * For the PC machine v10.1 and newer, vendor_cpuid_only=true, and
>   vendor_cpuid_only_v2=true.
>
>   - If the named CPU model has its own cache model (legacy_cache=false),
>     then cache_info_cpuid4 & cache_info_amd both equal to its own cache
>     model, so it uses its own cache model in 0x80000005 leaf regardless
>     of the vendor. Only Intel CPUs have all-0 leaf due to
>     vendor_cpuid_only_2=true, and this is exactly the expected behavior.
>
>   - For max/host/named CPU (without its own cache model), then the flag
>     enable_legacy_vendor_cache is false, the legacy cache model is
>     selected based on vendor.
>
>     For AMD CPU, it will use legacy AMD cache as expected.
>
>     For Intel CPU, it will use legacy Intel cache but still get all-0
>     leaf due to vendor_cpuid_only_2=true as expected.
>
>     (Note) And for Zhaoxin CPU, it will use legacy Intel cache model
>     instead of AMD's. This is the difference brought by this change! But
>     it's correct since then Zhaoxin could have the consistent cache info
>     in CPUID 0x2, 0x4 and 0x80000005 leaves.
>
>     Here, except Zhaoxin, selecting the legacy cache model based on the
>     vendor does not change the previous (before the change) behavior.
>     And the change for Zhaoxin is also a good improvement.
>
> Therefore, the above analysis proves that, with the help of the flag
> enable_legacy_vendor_cache, it is acceptable to select the default
> legacy cache model based on the vendor.
>
> For the CPUID 0x80000005 leaf, in X86CPUState, a unified cache_info is
> enough. It only needs to be initialized and configured with the
> corresponding legacy cache model based on the vendor.
>
> Cc: EwanHai <ewanhai-oc@zhaoxin.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Note, side effect of this patch: fix the inconsistency cache info for
> Zhaoxin. For more details, see the commit message above.
> ---
>  target/i386/cpu.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index afbf11569ab4..16b4ecb76113 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7945,8 +7945,35 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          *ecx = env->cpuid_model[(index - 0x80000002) * 4 + 2];
>          *edx = env->cpuid_model[(index - 0x80000002) * 4 + 3];
>          break;
> -    case 0x80000005:
> -        /* cache info (L1 cache/TLB Associativity Field) */
> +    case 0x80000005: { /* cache info (L1 cache/TLB Associativity Field) */
Better put the comment into an independent line.

> +        const CPUCaches *caches;
> +
> +        if (env->enable_legacy_vendor_cache) {
> +            caches = &legacy_amd_cache_info;
> +        } else {
> +            /*
> +             * FIXME: Temporarily select cache info model here based on
> +             * vendor, and merge these 2 cache info models later.
> +             *
> +             * This condition covers the following cases (with
> +             * enable_legacy_vendor_cache=false):
> +             *  - When CPU model has its own cache model and doesn't uses legacy
> +             *    cache model (legacy_model=off). Then cache_info_amd and
> +             *    cache_info_cpuid4 are the same.
> +             *
> +             *  - For v10.1 and newer machines, when CPU model uses legacy cache
> +             *    model. AMD CPUs use cache_info_amd like before and non-AMD
> +             *    CPU will use cache_info_cpuid4. But this doesn't matter,
> +             *    because for Intel CPU, it will get all-0 leaf, and Zhaoxin CPU
> +             *    will get correct cache info. Both are expected.
> +             */
> +            if (IS_AMD_CPU(env)) {
> +                caches = &env->cache_info_amd;
> +            } else {
> +                caches = &env->cache_info_cpuid4;
> +            }
> +        }
> +
>          if (cpu->cache_info_passthrough) {
>              x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
>              break;
> @@ -7961,9 +7988,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                 (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
>          *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |
>                 (L1_ITLB_4K_ASSOC <<  8) | (L1_ITLB_4K_ENTRIES);
> -        *ecx = encode_cache_cpuid80000005(env->cache_info_amd.l1d_cache);
> -        *edx = encode_cache_cpuid80000005(env->cache_info_amd.l1i_cache);
> +        *ecx = encode_cache_cpuid80000005(caches->l1d_cache);
> +        *edx = encode_cache_cpuid80000005(caches->l1i_cache);
>          break;
> +    }
>      case 0x80000006:
>          /* cache info (L2 cache/TLB/L3 cache) */
>          if (cpu->cache_info_passthrough) {

