Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715D8D1CA17
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 03:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8WqG-0003Rt-5g; Tue, 05 Nov 2024 22:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8WqF-0003Rj-2O
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 22:36:23 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8WqC-00069w-4I
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 22:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730864180; x=1762400180;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=b/LjEV98+IEYePScSsvtFe/I008tMdVIcy/1aEMTVQg=;
 b=VnrwF/CsoJYUcQiakjEjs8wbHlBPm0jY8K0DXhXgGLoyOkHWLNoylO3j
 WO9g/EaZ6XqBtQSYkGumgAII/06UdFuof0u6zkWnOmOZZMuWCBcPGCtZT
 GOP+wMT0nYkib6P4ACCsBTm8gQ9rBu6Y896t2Oq/XzcHVd8yHIeBsd2kY
 7HgHIKR4DlUdlZDLwg8gC9soUoAhDWBnFnJ4zuqmLtvpSYtuA+Y7Tevwm
 e3iviiHFqR5HXIS5Qgi/lO29/a7RKQxfg1BHWSAGxVD+zqprva8Q5dmlF
 BRLxvC6jHxf35CkQ2zIe9dlayEyGqDfaJ86s2A1AIubyGtkGL5KUyv1Mr Q==;
X-CSE-ConnectionGUID: TbIx5qKqTXi9SgH12Oy+eA==
X-CSE-MsgGUID: SvxON+9GSr60lsepb++tRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="34571411"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="34571411"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 19:36:16 -0800
X-CSE-ConnectionGUID: J1yWAnCQSK60motsMdSHig==
X-CSE-MsgGUID: LYxdUWSaT22FcM+nT4VHcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; d="scan'208";a="88855947"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 05 Nov 2024 19:36:12 -0800
Date: Wed, 6 Nov 2024 11:54:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com,
 zhenyuw@linux.intel.com, groug@kaod.org, lyan@digitalocean.com,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, joe.jin@oracle.com, davydov-max@yandex-team.ru
Subject: Re: [PATCH 1/7] target/i386: disable PerfMonV2 when PERFCORE
 unavailable
Message-ID: <ZyroXEOsRPonKD7x@intel.com>
References: <20241104094119.4131-1-dongli.zhang@oracle.com>
 <20241104094119.4131-2-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104094119.4131-2-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

Hi Dongli,

On Mon, Nov 04, 2024 at 01:40:16AM -0800, Dongli Zhang wrote:
> Date: Mon,  4 Nov 2024 01:40:16 -0800
> From: Dongli Zhang <dongli.zhang@oracle.com>
> Subject: [PATCH 1/7] target/i386: disable PerfMonV2 when PERFCORE
>  unavailable
> X-Mailer: git-send-email 2.43.5
> 
> When the PERFCORE is disabled with "-cpu host,-perfctr-core", it is
> reflected in in guest dmesg.
> 
> [    0.285136] Performance Events: AMD PMU driver.
> 
> However, the guest cpuid indicates the PerfMonV2 is still available.
> 
> CPU:
>    Extended Performance Monitoring and Debugging (0x80000022):
>       AMD performance monitoring V2         = true
>       AMD LBR V2                            = false
>       AMD LBR stack & PMC freezing          = false
>       number of core perf ctrs              = 0x6 (6)
>       number of LBR stack entries           = 0x0 (0)
>       number of avail Northbridge perf ctrs = 0x0 (0)
>       number of available UMC PMCs          = 0x0 (0)
>       active UMCs bitmask                   = 0x0
> 
> Disable PerfMonV2 in cpuid when PERFCORE is disabled.
> 
> Fixes: 209b0ac12074 ("target/i386: Add PerfMonV2 feature bit")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  target/i386/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 3baa95481f..4490a7a8d6 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7103,6 +7103,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          *eax = *ebx = *ecx = *edx = 0;
>          /* AMD Extended Performance Monitoring and Debug */
>          if (kvm_enabled() && cpu->enable_pmu &&
> +            (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_PERFCORE) &&
>              (env->features[FEAT_8000_0022_EAX] & CPUID_8000_0022_EAX_PERFMON_V2)) {
>              *eax |= CPUID_8000_0022_EAX_PERFMON_V2;
>              *ebx |= kvm_arch_get_supported_cpuid(cs->kvm_state, index, count,

You can define dependency like this:

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3baa95481fbc..99c69ec9f369 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1803,6 +1803,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_AVX10 },
         .to = { FEAT_24_0_EBX,              ~0ull },
     },
+    {
+        .from = { FEAT_8000_0001_ECX,       CPUID_EXT3_PERFCORE },
+        .to = { FEAT_8000_0022_EAX,         CPUID_8000_0022_EAX_PERFMON_V2 }
+    }
 };

 typedef struct X86RegisterInfo32 {

---
Does this meet your needs?

Regards,
Zhao


