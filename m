Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F2AC83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 02:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua3TU-0005QI-Mt; Thu, 10 Jul 2025 22:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ua3TP-0005NZ-IE
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 22:26:53 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ua3TN-0002Pt-GK
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 22:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752200809; x=1783736809;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=wj9BjgraGLCfEyRLU4To+qZCsHPU5gEXBa88NaRqATo=;
 b=PyE4YRRG6BHyAqL+fUYs5MyoeKfKmaPBO7QfOVtKVuveV9/hHuTMdviD
 put5JeENIDEnlERnEFnlg9XTnXDVX/U/L2UfHDP7ghmwuMynElaaoUZkV
 WA38EFj8qanMSIPLyHLY4t7cDAmz2N2gmkKTtT/Zc/KU4bPLfSnSyLfIP
 oOBv2yXgiMtQ3Jr5jnyQJOTFNXMryby7zqynUksouyTngJE2gWPtQKh8y
 lw0QoQcxV+vtsbd2T+Shfn7SSRNk/WQ4YGSqWuhw3qjsPnTumdsK08PyF
 f+DTgJfVBxqz0nD4I5QCJs7ALwXaHkL2GBmfzJ8okz/k0Fq5JjkVViDnQ Q==;
X-CSE-ConnectionGUID: nP7WPlxTTHyRtLP0mtNVvA==
X-CSE-MsgGUID: 2c4UlHpOQcmjzEy/Gfx65Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="65845790"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="65845790"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 19:26:47 -0700
X-CSE-ConnectionGUID: XDgLp30rSZOkfpp1awtHyA==
X-CSE-MsgGUID: iQt5Yc5sSteF2zsM37tIfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="155882344"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 19:26:46 -0700
Message-ID: <3c4f798e-1519-459f-b142-07ca39cf738e@intel.com>
Date: Fri, 11 Jul 2025 10:26:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] target/i386: move accel_cpu_instance_init to
 .instance_init
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
References: <20250711000603.438312-1-pbonzini@redhat.com>
 <20250711000603.438312-5-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250711000603.438312-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/11/2025 8:06 AM, Paolo Bonzini wrote:
> With the reordering of instance_post_init callbacks that is new in 10.1
> accel_cpu_instance_init must execute in .instance_init as is already
> the case for RISC-V.  Otherwise, for example, setting the vendor
> property is broken when using KVM or Hypervisor.framework, because
> KVM sets it *after* the user's value is set by DeviceState's
> intance_post_init callback.
> 
> Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

BTW, the user's value of "pmu" and "invtsc" are still broken for TDX 
case.  tdx_cpu_instance_init() will always overwrite "pmu" and "invtsc" 
even if users explicitly request a different value via "-cpu" option.

Will we leave it as intentional? or fix it as well?

> ---
>   target/i386/cpu.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 46d59229200..5f95bb97b82 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6207,8 +6207,8 @@ static void max_x86_cpu_initfn(Object *obj)
>       CPUX86State *env = &cpu->env;
>   
>       /*
> -     * these defaults are used for TCG, other accelerators overwrite these
> -     * values
> +     * these defaults are used for TCG, other accelerators have overwritten
> +     * these values
>        */
>       if (!env->cpuid_vendor1) {
>           object_property_set_str(OBJECT(cpu), "vendor", CPUID_VENDOR_AMD,
> @@ -9043,8 +9043,6 @@ static void x86_cpu_post_initfn(Object *obj)
>           }
>       }
>   
> -    accel_cpu_instance_init(CPU(obj));
> -
>   #ifndef CONFIG_USER_ONLY
>       if (current_machine && current_machine->cgs) {
>           x86_confidential_guest_cpu_instance_init(
> @@ -9119,6 +9117,8 @@ static void x86_cpu_initfn(Object *obj)
>       if (xcc->model) {
>           x86_cpu_load_model(cpu, xcc->model);
>       }
> +
> +    accel_cpu_instance_init(CPU(obj));
>   }
>   
>   static int64_t x86_cpu_get_arch_id(CPUState *cs)


