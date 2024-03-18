Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DC3C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 08:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm8Rs-0000iP-Ey; Mon, 18 Mar 2024 04:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rm8Ro-0000i4-KY; Mon, 18 Mar 2024 04:34:20 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rm8Rk-0006XI-7O; Mon, 18 Mar 2024 04:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710750856; x=1742286856;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=JUZW5gGldw4BXTAwUQ0eaRr94wgH03/4Fmcn9iVi/8o=;
 b=gFbU9WFDoNIqE611BLAeg2Ai9ft6HA4HQxtZaAHn6wpM81Mth7cVm8eQ
 JUQGr1OjBCRN8CgBX9vogT2q73yLVxNLxPzILqN96FUwrWp7p3TgFvjDt
 9faoD4rJkMZFswr+1C4aRrHzzddslbZRfMeIlRv4+WvhNLl2CTCWSDKR6
 MHdJtDFRdeAsMxh1Hvy2fLRGHIet1Y6IrXAKOylfP1KUKRHQZPlGCwE5Z
 Cs/jkXmU4FU2KjbC2nwY4WDjGGkjvK+fKvtlUhVZrW+zeT3V4Tbsv/NT1
 TSC9wT5zOoX6IfeE1B6ZK/BjApDoLjHaIBFAAiiI5tUVFYHbAnR+NzL7p g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="16951484"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; d="scan'208";a="16951484"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 01:34:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; d="scan'208";a="13286825"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 18 Mar 2024 01:34:07 -0700
Date: Mon, 18 Mar 2024 16:47:59 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH-for-9.1 06/21] target/i386: Make X86_CPU common to new
 I386_CPU / X86_64_CPU types
Message-ID: <Zff/v7aK182oxbM2@intel.com>
References: <20240315130910.15750-1-philmd@linaro.org>
 <20240315130910.15750-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315130910.15750-7-philmd@linaro.org>
Received-SPF: none client-ip=192.198.163.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Hi Philippe,

On Fri, Mar 15, 2024 at 02:08:54PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Fri, 15 Mar 2024 14:08:54 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-9.1 06/21] target/i386: Make X86_CPU common to new
>  I386_CPU / X86_64_CPU types
> X-Mailer: git-send-email 2.41.0
> 
> "target/foo/cpu-qom.h" can not use any target specific definitions.
> 
> Currently "target/i386/cpu-qom.h" defines TYPE_X86_CPU depending
> on the i386/x86_64 build type. This doesn't scale in a heterogeneous
> context where we need to access both types concurrently.

Does this mean that there would be a TCG case contains both 64-bit and
32-bit i386 core? ;-)

> In order to do that, introduce the new I386_CPU / X86_64_CPU
> types, both inheriting a common TYPE_X86_CPU base type.
> 
> Keep the current "base" and "max" CPU types as 32 or 64-bit,
> depending on the binary built.
> 
> Adapt the cpu-plug-test, since the 'base' architecture is now
> common to both 32/64-bit x86 targets.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/i386/cpu-qom.h       | 16 ++++++++++------
>  target/i386/cpu.c           | 20 ++++++++++++++++++--
>  tests/qtest/cpu-plug-test.c |  2 +-
>  3 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
> index d4e216d000..de28d7ea20 100644
> --- a/target/i386/cpu-qom.h
> +++ b/target/i386/cpu-qom.h
> @@ -1,5 +1,5 @@
>  /*
> - * QEMU x86 CPU
> + * QEMU x86 CPU QOM header (target agnostic)
>   *
>   * Copyright (c) 2012 SUSE LINUX Products GmbH
>   *
> @@ -22,14 +22,18 @@
>  
>  #include "hw/core/cpu.h"
>  
> -#ifdef TARGET_X86_64
> -#define TYPE_X86_CPU "x86_64-cpu"
> -#else
> -#define TYPE_X86_CPU "i386-cpu"
> -#endif
> +#define TYPE_X86_CPU    "x86-cpu"
> +#define TYPE_I386_CPU   "i386-cpu"
> +#define TYPE_X86_64_CPU "x86_64-cpu"
>  
>  OBJECT_DECLARE_CPU_TYPE(X86CPU, X86CPUClass, X86_CPU)
>  
> +OBJECT_DECLARE_CPU_TYPE(I386CPU, X86CPUClass, I386_CPU)
> +OBJECT_DECLARE_CPU_TYPE(X86_64CPU, X86CPUClass, X86_64_CPU)
> +
> +#define X86_CPU_TYPE_SUFFIX "-" TYPE_X86_CPU
> +#define X86_CPU_TYPE_NAME(name) (name X86_CPU_TYPE_SUFFIX)
> +

X86_CPU_TYPE_NAME seems to be duplicated because the following line is
the existing X86_CPU_TYPE_NAME definition.

>  #define X86_CPU_TYPE_SUFFIX "-" TYPE_X86_CPU
>  #define X86_CPU_TYPE_NAME(name) (name X86_CPU_TYPE_SUFFIX)
>  
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index ebf555f50f..07f64c1ea5 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8057,12 +8057,28 @@ static const TypeInfo x86_cpu_types[] = {
>          .class_size     = sizeof(X86CPUClass),
>          .class_init     = x86_cpu_common_class_init,
>      }, {
> -        .name           = X86_CPU_TYPE_NAME("base"),
> +        .name           = TYPE_I386_CPU,
>          .parent         = TYPE_X86_CPU,
> +        .abstract       = true,
> +    }, {
> +        .name           = TYPE_X86_64_CPU,
> +        .parent         = TYPE_X86_CPU,
> +        .abstract       = true,
> +    }, {

Should TYPE_I386_CPU/TYPE_X86_64_CPU be also wrapped with TARGET_X86_64?

Otherwise, we would keep the 32-bit CPU type definition of TYPE_I386_CPU
in the 64-bit case.

> +        .name           = X86_CPU_TYPE_NAME("base"),
> +#ifdef TARGET_X86_64
> +        .parent         = TYPE_X86_64_CPU,
> +#else
> +        .parent         = TYPE_I386_CPU,
> +#endif
>          .class_init     = x86_cpu_base_class_init,
>      }, {
>          .name           = X86_CPU_TYPE_NAME("max"),
> -        .parent         = TYPE_X86_CPU,
> +#ifdef TARGET_X86_64
> +        .parent         = TYPE_X86_64_CPU,
> +#else
> +        .parent         = TYPE_I386_CPU,
> +#endif
>          .instance_init  = max_x86_cpu_initfn,
>          .class_init     = max_x86_cpu_class_init,
>      }

