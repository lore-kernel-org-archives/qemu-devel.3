Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A776C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 03:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXXA9-0000Uq-Aj; Thu, 03 Jul 2025 23:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXXA4-0000UO-UW
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 23:32:30 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXXA2-0001ec-2F
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 23:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751599946; x=1783135946;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=mfE/VDlmRHtwZHG5YH1KhJM1ldUSq8FuB9VJ06z5Bmc=;
 b=e+VOiEpNAqlVYUfQXZhx2V5JZYRngq25RfB0IaA8s6RaY4EEa06azfNd
 oEXsx9i9E9nm2+NGVzw8gHYh59LxdM6YvXYrlPKwR7GmVNMhualRTD/m+
 /J4W2piNDDGXoGONsJ8GwwgI13T2J3220I/L4MbcOFQqXIxJcgRdCgXtY
 BlnqrHSVfYvHTKdbSJB7dKwLWlEYw86aQ9Y+euAxJlDK22hg3SEnS2LFG
 9vX1QEgVYngu9vQSlQCJdzv9o0U/uMN7NrW1VSjWezjTCmO0KdW5cLZLa
 ypJqvFnYAYNbql3zRSxYw+jEPj0IcjnKZYpm/IXs3KRnqTA45GdMVEArs w==;
X-CSE-ConnectionGUID: Nl52pU9xQR6at8R4OXQBsw==
X-CSE-MsgGUID: sSGhYQBqTeywcFnWpi3/tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="41561885"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="41561885"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 20:32:23 -0700
X-CSE-ConnectionGUID: 9c+vJACqQQ+aOwmjhg/AxA==
X-CSE-MsgGUID: hMPFATv8QdunGKcDLi/9Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="158571042"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 20:32:21 -0700
Message-ID: <4d57f96b-ee72-484f-a1f5-dadbf773ef64@intel.com>
Date: Fri, 4 Jul 2025 11:32:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/39] system/memory: Restrict eventfd dispatch_write()
 to emulators
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-3-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250703173248.44995-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/4/2025 1:32 AM, Philippe Mathieu-Daudé wrote:
> Commit 8c56c1a592b ("memory: emulate ioeventfd") added a !KVM
> check because the only accelerator available back then were TCG,
> QTest and KVM. Then commit 126e7f78036 ("kvm: require
> KVM_CAP_IOEVENTFD and KVM_CAP_IOEVENTFD_ANY_LENGTH") suggested
> '!KVM' check should be '(TCG || QTest)'. Later more accelerator
> were added. Implement the suggestion as a safety measure, not
> dispatching to eventfd when hardware accelerator is used.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   system/memory.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 76b44b8220f..4f713889a8e 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -25,7 +25,7 @@
>   #include "qom/object.h"
>   #include "trace.h"
>   #include "system/ram_addr.h"
> -#include "system/kvm.h"
> +#include "system/qtest.h"
>   #include "system/runstate.h"
>   #include "system/tcg.h"
>   #include "qemu/accel.h"
> @@ -1530,12 +1530,7 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
>   
>       adjust_endianness(mr, &data, op);
>   
> -    /*
> -     * FIXME: it's not clear why under KVM the write would be processed
> -     * directly, instead of going through eventfd.  This probably should
> -     * test "tcg_enabled() || qtest_enabled()", or should just go away.
> -     */
> -    if (!kvm_enabled() &&
> +    if ((tcg_enabled() || qtest_enabled()) &&

The FIXME provides two options:
1. change to "tcg_enabled() || qtest_enabled()"
2. remove !kvm_enabled()

And as the FIXME said, it's not clear why under KVM the write would be 
processed directly. Now, the question becomes why under hardware 
accelerator is used the write would be processed directly instead of 
going through eventfd. I think it needs to answer this question when we 
do such change, and it's better to put the answer as the comment in the 
code.

>           memory_region_dispatch_write_eventfds(mr, addr, data, size, attrs)) {
>           return MEMTX_OK;
>       }


