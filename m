Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FC5C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 05:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7pVK-0007DV-8K; Thu, 24 Apr 2025 01:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u7pVI-0007DI-65
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 01:52:08 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1u7pVF-0000ts-Nz
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 01:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745473926; x=1777009926;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=bEXJv9PIByrS1p+kj+bzV/0sGFaz6Cp/dC7FgW0hGlk=;
 b=kMpyS6+9L9iC2Kf8/TYArwvOCfx1E3+8ybRIgyOHjgLj64B2MdtS2MTV
 xWY1N+XQ/nHlcaMi/Xx6pGsahsL/8UdF/qoS6L+8BhVxvsERz2KEjqPKz
 lwB2h+fzVD0OA1iMRvSPqRLpzMiKSkFxWiEtCvEkPlv/aiGFeeqmTbZcB
 nKwlW0sDRFHsyFSAa9MGaoz/B8DHlrwaPiqPOihFh74SDN6+r3TJvQSbW
 dRbMquBZi3pfSXt1ESouWr4tYPShpnZvkrXQGckSxXt9PrLESV8/JiUoR
 a76eq9aqe0iCqNILN2GdctnxbrUaO5Uo6OP++GDkPTioxICdheasRdnFy Q==;
X-CSE-ConnectionGUID: e/pHritqSJaQHY1qy31cJw==
X-CSE-MsgGUID: pgVFvlWaSg6p9eK+mCvecA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46797029"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="46797029"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 22:52:02 -0700
X-CSE-ConnectionGUID: rwxKsCQNTtGyu9NN76x9Zg==
X-CSE-MsgGUID: kJtkQ2peSi+kdPdwbM+/kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="133042115"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 22:52:00 -0700
Message-ID: <884fdc77-94f8-41f5-a579-aa70fa652eb9@intel.com>
Date: Thu, 24 Apr 2025 13:51:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 31/55] i386/cpu: introduce
 x86_confidential_guest_cpu_instance_init()
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-32-xiaoyao.li@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250401130205.2198253-32-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

Hi Paolo,

On 4/1/2025 9:01 PM, Xiaoyao Li wrote:
...
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index add6430f7edd..5c69d1489365 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -36,6 +36,7 @@
>   #include "hw/qdev-properties.h"
>   #include "hw/i386/topology.h"
>   #ifndef CONFIG_USER_ONLY
> +#include "confidential-guest.h"
>   #include "system/reset.h"
>   #include "qapi/qapi-commands-machine-target.h"
>   #include "exec/address-spaces.h"
> @@ -8504,6 +8505,15 @@ static void x86_cpu_post_initfn(Object *obj)
>       }
>   
>       accel_cpu_instance_init(CPU(obj));
> +
> +#ifndef CONFIG_USER_ONLY
> +    MachineState *ms = MACHINE(object_dynamic_cast(qdev_get_machine(),
> +                                                   TYPE_MACHINE));

It leads to

   qemu-system-x86_64: ../hw/core/qdev.c:824: qdev_get_machine: 
Assertion `dev' failed.
   Aborted (core dumped)

for the case of "-cpu help" due to the assert(dev) in qdev_get_machine().

How do you want to resolve it? I can think of two:
1. remove the assert() in qdev_get_machine(). or
2. drop the callback introduce by this patch. Instead just do

    if (is_tdx_vm()) {
	tdx_cpu_instance_init();
    }

> +    if (ms && ms->cgs) {
> +        x86_confidential_guest_cpu_instance_init(X86_CONFIDENTIAL_GUEST(ms->cgs),
> +                                                 (CPU(obj)));
> +    }
> +#endif
>   }
>   
>   static void x86_cpu_init_default_topo(X86CPU *cpu)


