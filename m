Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40CAC83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 06:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXZyb-0006Gi-QI; Fri, 04 Jul 2025 02:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXZyZ-0006GF-UM
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 02:32:47 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXZyW-0000R3-T1
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 02:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751610765; x=1783146765;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Qw6bzewriL21oMuleRkiEa31G7c8ozNNgkYXmj82q0g=;
 b=kmPrTZcfijE75IaTN+vl8gOYJ+zavOLjm9Dg2auW6xNs0LMlks2vkZ1e
 fltsLiHT86F+RO9S7u3g242+Dq0hQzlzoLy+voVwlY/I6aSIUZTASNKeL
 oNu7YCPfagBOuHSaRleX/g+62OEp6n/bDlTbcqxX+EKvuPjNiSXBA07o6
 ch+jnnT2f6wnXaSGpA/cHyGKYjOxD17PDidSIGHNEZBC3YCJPUd7Gbd3d
 5cB5Dj5VS0//ayeBwhDWilWvYTt9zPwwItoFHUwvZNgL+E1tvjT1uSdz5
 jNLNJQjwI5PclcWlyrbEBt/OIUNQiatKlG9LaXvqI4bNdxLjYPQlXtSCl w==;
X-CSE-ConnectionGUID: B/hPq0m1SgukVMQlPU5A+g==
X-CSE-MsgGUID: oRKV2+TQRJSlLutGSebBoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65393175"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="65393175"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 23:32:42 -0700
X-CSE-ConnectionGUID: /39/9IWiSxaT/z45FOFIxA==
X-CSE-MsgGUID: JPc6KZViSWiMz/74tFJIHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="158601471"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 23:32:38 -0700
Message-ID: <81e3775f-88b1-4cdc-981a-f5ffcc3c7c28@intel.com>
Date: Fri, 4 Jul 2025 14:32:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 27/39] accel: Pass old/new interrupt mask to
 handle_interrupt() handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-28-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250703173248.44995-28-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=xiaoyao.li@intel.com;
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
> Update CPUState::interrupt_request once in cpu_interrupt().
> Pass the old and new masks along.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops-icount.h |  2 +-
>   accel/tcg/tcg-accel-ops.h        |  2 +-
>   include/system/accel-ops.h       |  2 +-
>   accel/tcg/tcg-accel-ops-icount.c |  8 +++-----
>   accel/tcg/tcg-accel-ops.c        |  4 +---
>   system/cpus.c                    | 12 +++++++-----
>   6 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/accel/tcg/tcg-accel-ops-icount.h b/accel/tcg/tcg-accel-ops-icount.h
> index 16a301b6dc0..1d9d66f0707 100644
> --- a/accel/tcg/tcg-accel-ops-icount.h
> +++ b/accel/tcg/tcg-accel-ops-icount.h
> @@ -15,6 +15,6 @@ void icount_prepare_for_run(CPUState *cpu, int64_t cpu_budget);
>   int64_t icount_percpu_budget(int cpu_count);
>   void icount_process_data(CPUState *cpu);
>   
> -void icount_handle_interrupt(CPUState *cpu, int mask);
> +void icount_handle_interrupt(CPUState *cpu, int old_mask, int new_mask);
>   
>   #endif /* TCG_ACCEL_OPS_ICOUNT_H */
> diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
> index 6feeb3f3e9b..6e7c2aae5a8 100644
> --- a/accel/tcg/tcg-accel-ops.h
> +++ b/accel/tcg/tcg-accel-ops.h
> @@ -16,7 +16,7 @@
>   
>   void tcg_cpu_destroy(CPUState *cpu);
>   int tcg_cpu_exec(CPUState *cpu);
> -void tcg_handle_interrupt(CPUState *cpu, int mask);
> +void tcg_handle_interrupt(CPUState *cpu, int old_mask, int new_mask);
>   void tcg_cpu_init_cflags(CPUState *cpu, bool parallel);
>   
>   #endif /* TCG_ACCEL_OPS_H */
> diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
> index 2075691331c..d84eaa376c2 100644
> --- a/include/system/accel-ops.h
> +++ b/include/system/accel-ops.h
> @@ -61,7 +61,7 @@ struct AccelOpsClass {
>       void (*synchronize_pre_loadvm)(CPUState *cpu);
>       void (*synchronize_pre_resume)(bool step_pending);
>   
> -    void (*handle_interrupt)(CPUState *cpu, int mask);
> +    void (*handle_interrupt)(CPUState *cpu, int old_mask, int new_mask);
>   
>       /**
>        * @get_virtual_clock: fetch virtual clock
> diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
> index d0f7b410fab..500b5dd4942 100644
> --- a/accel/tcg/tcg-accel-ops-icount.c
> +++ b/accel/tcg/tcg-accel-ops-icount.c
> @@ -147,14 +147,12 @@ void icount_process_data(CPUState *cpu)
>       replay_mutex_unlock();
>   }
>   
> -void icount_handle_interrupt(CPUState *cpu, int mask)
> +void icount_handle_interrupt(CPUState *cpu, int old_mask, int new_mask)
>   {
> -    int old_mask = cpu->interrupt_request;
> -
> -    tcg_handle_interrupt(cpu, mask);
> +    tcg_handle_interrupt(cpu, old_mask, new_mask);
>       if (qemu_cpu_is_self(cpu) &&
>           !cpu->neg.can_do_io
> -        && (mask & ~old_mask) != 0) {
> +        && (new_mask & ~old_mask) != 0) {

This patch changes the behavior,

Assume the @mask is the value passed to cpu_interrupt()

- before this patch:

	(mask & ~old_mask) is

	(@mask & ~cpu->interrupt_request)

- after this patch:

	(new_mask & ~old_mask) is

	((@mask | cpu->interrupt_request) & ~cpu->interrupt_request)


