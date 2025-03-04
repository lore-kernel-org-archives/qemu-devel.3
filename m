Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8CDC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 14:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpTRR-0008MH-5L; Tue, 04 Mar 2025 09:40:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tpTRP-0008Lr-8Y
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 09:40:15 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tpTRL-0002Vy-53
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 09:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741099211; x=1772635211;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=BkcukU1BDLk2mTwIOUdDKSgw1hKEbvTZjuCIFTQz47c=;
 b=PTIWo/vDDixUHNQrSG4323sdKYWCFT0U8o76tP67Xlj2cPSSj9LHlRdu
 ul/ThLKnlwtlZg7Yx2MKgCcRpzrWZ3WJIGu+Q251SHIg5t5ACy42auZca
 pmnj3PQWsLUNkZBeDCbsCgiJHYuE3Ovl/k4IKsIbnm3zjerZ4LEOYdGmE
 VMeBSvYfB6TKnr88Q1ZJaGj2a27s4Rx4kBaAJdDdPkz1Lp1XF1FpJIEA/
 08ycA10+FqOJ7C8efJiF6YkqjvZ92vn/FAh8z9aqU/sffc6fcoairJqey
 R4s7GQjShbTc1ySTEW8HQLVxT2MQgSMyj0/xCi60PicOTAk4m/WzwdFUW g==;
X-CSE-ConnectionGUID: dagAn8KrTYeSy6XimftHuQ==
X-CSE-MsgGUID: RzFkys1eRLm/XzNv5aBIeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52657720"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; d="scan'208";a="52657720"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 06:40:08 -0800
X-CSE-ConnectionGUID: 92loLUt3Qwyag4Zc3g121g==
X-CSE-MsgGUID: nw1HtKbyQ8eArmS7eVlySg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; d="scan'208";a="141614002"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 06:40:03 -0800
Message-ID: <46cd2769-aad6-4b99-aea9-426968a9d7cb@intel.com>
Date: Tue, 4 Mar 2025 22:40:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] target/i386: disable PerfMonV2 when PERFCORE
 unavailable
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, zhenyuw@linux.intel.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, dapeng1.mi@linux.intel.com, joe.jin@oracle.com
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-2-dongli.zhang@oracle.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250302220112.17653-2-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
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

On 3/3/2025 6:00 AM, Dongli Zhang wrote:
> When the PERFCORE is disabled with "-cpu host,-perfctr-core", it is
> reflected in in guest dmesg.
> 
> [    0.285136] Performance Events: AMD PMU driver.

I'm a little confused. wWhen no perfctr-core, AMD PMU driver can still 
be probed? (forgive me if I ask a silly question)

> However, the guest CPUID indicates the PerfMonV2 is still available.
> 
> CPU:
>     Extended Performance Monitoring and Debugging (0x80000022):
>        AMD performance monitoring V2         = true
>        AMD LBR V2                            = false
>        AMD LBR stack & PMC freezing          = false
>        number of core perf ctrs              = 0x6 (6)
>        number of LBR stack entries           = 0x0 (0)
>        number of avail Northbridge perf ctrs = 0x0 (0)
>        number of available UMC PMCs          = 0x0 (0)
>        active UMCs bitmask                   = 0x0
> 
> Disable PerfMonV2 in CPUID when PERFCORE is disabled.
> 
> Suggested-by: Zhao Liu <zhao1.liu@intel.com>

Though I have above confusion of the description, the change itself 
looks good to me. So

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> Fixes: 209b0ac12074 ("target/i386: Add PerfMonV2 feature bit")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> Changed since v1:
>    - Use feature_dependencies (suggested by Zhao Liu).
> 
>   target/i386/cpu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 72ab147e85..b6d6167910 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1805,6 +1805,10 @@ static FeatureDep feature_dependencies[] = {
>           .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_AVX10 },
>           .to = { FEAT_24_0_EBX,              ~0ull },
>       },
> +    {
> +        .from = { FEAT_8000_0001_ECX,       CPUID_EXT3_PERFCORE },
> +        .to = { FEAT_8000_0022_EAX,         CPUID_8000_0022_EAX_PERFMON_V2 },
> +    },
>   };
>   
>   typedef struct X86RegisterInfo32 {


