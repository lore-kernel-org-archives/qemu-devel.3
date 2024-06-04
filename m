Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925ECC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 14:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVXf-0007at-6O; Tue, 04 Jun 2024 10:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sEVXb-0007aD-9w; Tue, 04 Jun 2024 10:53:36 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sEVXX-0003fQ-OO; Tue, 04 Jun 2024 10:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717512812; x=1749048812;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=SGSNBVT24CLgFYh0gmcbAlq8CnGk2lYt6ssX5UVBfmM=;
 b=ZGJrmyPJ+8RpF8zdHSgVr97qUBRHqHTJxRUYjaaP8EOplVeltJUsyuWB
 RbX6IplyL8bX9HPW7ic/rQ+EyGHVuLrUSGjf5p7uGhODotVZsXCW/H5Fh
 22dac3Y7z6IhErBtGzv8AiFJGHIOH2YMV6jg9Lof6b4WUNCp8tYfrhnPE
 bz+IVkR0SjyNtjgay0PaegWDreCz7fCQTDa5fcpbFHhPLvuMjX2zrd9FF
 D3nHhiUbpp8dR0t5EWpPYm3NYfD0j/9GxCTLQp4t+RaZGr2U0v4iFTU5K
 Md3GFAhwvJFeqVa0u6FMbc/tMdINGYfLomqyFuLNWhEqtvSE6DFklGIEa w==;
X-CSE-ConnectionGUID: 0YurhFL9QDqqqhbHK7OqLA==
X-CSE-MsgGUID: t2kH48nGS1GJ+5CreGUuXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13813233"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="13813233"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 07:53:27 -0700
X-CSE-ConnectionGUID: +MSLjNmbSHO9xJyMF2SCGw==
X-CSE-MsgGUID: mt8LKw8XR6ags7DykOk4/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="41702943"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.125.247.52])
 ([10.125.247.52])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 07:53:24 -0700
Message-ID: <e112bdcf-8a38-4def-9ff8-9754d4822eb5@intel.com>
Date: Tue, 4 Jun 2024 22:53:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i386/cpu: fixup number of addressable IDs for
 processor cores in the physical package
To: Zhao Liu <zhao1.liu@intel.com>, Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xieyongji@bytedance.com,
 imammedo@redhat.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
References: <20240603083641.97241-1-xuchuangxclwt@bytedance.com>
 <Zl7hpyutlWN5iE+6@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <Zl7hpyutlWN5iE+6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.288, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/4/2024 5:43 PM, Zhao Liu wrote:
> Hi Chuang,
> 
> On Mon, Jun 03, 2024 at 04:36:41PM +0800, Chuang Xu wrote:
>> Date: Mon,  3 Jun 2024 16:36:41 +0800
>> From: Chuang Xu <xuchuangxclwt@bytedance.com>
>> Subject: [PATCH v2] i386/cpu: fixup number of addressable IDs for processor
>>   cores in the physical package
>> X-Mailer: git-send-email 2.24.3 (Apple Git-128)
>>
>> When QEMU is started with:
>> -cpu host,host-cache-info=on,l3-cache=off \
>> -smp 2,sockets=1,dies=1,cores=1,threads=2
>> Guest can't acquire maximum number of addressable IDs for processor cores in
>> the physical package from CPUID[04H].
>>
>> When testing Intel TDX, guest attempts to acquire extended topology from CPUID[0bH],
>> but because the TDX module doesn't provide the emulation of CPUID[0bH],
>> guest will instead acquire extended topology from CPUID[04H]. However,
>> due to QEMU's inaccurate emulation of CPUID[04H], one of the vcpus in 2c TDX
>> guest would be offline.
> 
> I guess this case is based on downstream's TDX patches... Since TDX
> hasn't landed in QEMU yet, it's a bit ahead of the curve to elaborate on
> TDX-specific case.
> 
> Because normal VM will also face the such cache topology error, I think
> it could be stated a bit more generically like:

yes. it's not TDX specific though it's found by TDX case.

I think We can reproduce it by limiting the "min-level" to less than 0xb 
and disable "full-cpuid-auto-level". With it, CPUID leaves 0xb are not 
exposed to guest and guest will use leaves 0x4 to enumerate the CPU 
topology.

> When creating a CPU topology of 1 core per package, host-cache-info only
> uses the Host's addressable core IDs field (CPUID.04H.EAX[bits 31-26]),
> resulting in a conflict (on the multicore Host) between the Guest core
> topology information in this field and the Guest's actual cores number.
> 
> Fix it by removing the unnecessary condition to cover 1 core per package
> case. This is safe because cores_per_pkg will not be 0 and will be at
> least 1.
> 
>> Fix it by removing the unnecessary condition.
>>
>> Fixes: d7caf13b5fcf742e5680c1d3448ba070fc811644 ("x86: cpu: fixup number of addressable IDs for logical processors sharing cache")

yeah. This is the exact commit that introduced the issue. Because it moved

	*eax &= ~0xFC000000;

into the condition of

	cs->nr_cores > 1

> 12 characters (d7caf13b5fcf) is enough. No blank line. ;-)
> 
>> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
>> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
>> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
>> ---
>>   target/i386/cpu.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index bc2dceb647..b68f7460db 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -6426,10 +6426,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>               if (*eax & 31) {
>>                   int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
>>   
>> -                if (cores_per_pkg > 1) {
>> -                    *eax &= ~0xFC000000;
>> -                    *eax |= max_core_ids_in_package(&topo_info) << 26;
>> -                }
>> +                *eax &= ~0xFC000000;
>> +                *eax |= max_core_ids_in_package(&topo_info) << 26;
>>                   if (host_vcpus_per_cache > threads_per_pkg) {
>>                       *eax &= ~0x3FFC000;
>>   
>> -- 
>> 2.20.1
>>
> 


