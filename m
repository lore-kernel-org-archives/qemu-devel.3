Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF91D1A441
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 07:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szWJg-0007XW-9c; Sat, 12 Oct 2024 03:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1szWJf-0007XK-3B; Sat, 12 Oct 2024 03:13:31 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1szWJc-0001CO-O1; Sat, 12 Oct 2024 03:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728717209; x=1760253209;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=yIUI9kHzniRLdxWChq1x156eZCzJa9nmlhRfAoAyv+I=;
 b=TAUQ/8YtA4+mAHSqWC7AqVCqmgHAg3GS8mzh6/CUbpa8yB99HSTDXz1D
 oPgFZkkQMKjrg3czJ1e+BMnRdJX5+R5gq3RhhqxX3OVlJ+APTJ6RE2Vn2
 er+1pAwQciIh+H4e+JDG3rLiDeokfxJCmjV8PLjdo+VM+/H/AJB3r3ZCl
 vGcn+pMgGgjdA/gPaLIiCR2a4mLrEuOQIx/U/Kpx8QJKKDQsp8o3g5pPC
 ubpmax1RwxZU4MZ2xyBrVV+FWa4flf+aO0l2KhTLnbVtqMs7ApUtSdvxs
 wceK1NYAweEzhnoerv6XaDb6iHI1CALE8lwYNPzhNz9D2vNDxdUaqf1cC w==;
X-CSE-ConnectionGUID: CZBo7B43TZCVKir1KJDI5Q==
X-CSE-MsgGUID: 7VP6MxQcSz6F22VdXANzxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28256933"
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; d="scan'208";a="28256933"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2024 00:13:24 -0700
X-CSE-ConnectionGUID: 6wWebLfFSqmRrgEa6BYDng==
X-CSE-MsgGUID: z8AxWSpnRVGjFZuJwXKt+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; d="scan'208";a="81732808"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.224.38])
 ([10.124.224.38])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2024 00:13:21 -0700
Message-ID: <00f25e56-72e4-485a-a6a4-6b0c5563330d@intel.com>
Date: Sat, 12 Oct 2024 15:13:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
To: Chuang Xu <xuchuangxclwt@bytedance.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, imammedo@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
References: <20241009035638.59330-1-xuchuangxclwt@bytedance.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20241009035638.59330-1-xuchuangxclwt@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.649, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/9/2024 11:56 AM, Chuang Xu wrote:
> When QEMU is started with:
> -cpu host,migratable=on,host-cache-info=on,l3-cache=off
> -smp 180,sockets=2,dies=1,cores=45,threads=2
> 
> On Intel platform:
> CPUID.01H.EBX[23:16] is defined as "max number of addressable IDs for
> logical processors in the physical package".
> 
> When executing "cpuid -1 -l 1 -r" in the guest, we obtain a value of 90 for
> CPUID.01H.EBX[23:16], whereas the expected value is 128. Additionally,
> executing "cpuid -1 -l 4 -r" in the guest yields a value of 63 for
> CPUID.04H.EAX[31:26], which matches the expected result.
> 
> As (1+CPUID.04H.EAX[31:26]) rounds up to the nearest power-of-2 integer,
> we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
> integer too. Otherwise we may encounter unexpected results in guest.
> 
> For example, when QEMU is started with CLI above and xtopology is disabled,
> guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
> calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
> as the result, even though threads-per-core should actually be 2.
> 
> And on AMD platform:
> CPUID.01H.EBX[23:16] is defined as "Logical processor count". Current
> result meets our expectation.

So for AMD platform, what's result for the same situation with xtopology 
disabled? Does AMD uses another algorithm to calculate other than 
CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) ?

> So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
> only for Intel platform to solve the unexpected result.
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> ---
>   target/i386/cpu.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index ff227a8c5c..641d4577b0 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6462,7 +6462,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           }
>           *edx = env->features[FEAT_1_EDX];
>           if (threads_per_pkg > 1) {
> -            *ebx |= threads_per_pkg << 16;
> +            /*
> +             * AMD requires logical processor count, but Intel needs maximum
> +             * number of addressable IDs for logical processors per package.
> +             */
> +            if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
> +                *ebx |= threads_per_pkg << 16;
> +            } else {
> +                *ebx |= 1 << apicid_pkg_offset(&topo_info) << 16;
> +            }

you need to handle the overflow case when the number of logical 
processors > 255.

>               *edx |= CPUID_HT;
>           }
>           if (!cpu->enable_pmu) {


