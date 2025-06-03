Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61767C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 03:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMHx8-0002m3-DN; Mon, 02 Jun 2025 23:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMHx5-0002lg-MN
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 23:04:36 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMHx3-0006t1-7l
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 23:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748919873; x=1780455873;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=4cg9VXTG81Ls7EZD64z5rtZ8DbhDt/nWF3OZTQJpi2c=;
 b=ghOF15jJPEvMaJKJ96v1t/WuReYZR6tNz91Aq7R5MfeMtD6Pz4qUU9yj
 l5ePIbngvK4TSNs2/YB6Wx7H9ut6q3hcrEAau2H8JQ3X0DsmoillQDvt+
 Y8/MYE0zfG+Sx8RBJ8jtkQ35nWmQ4Rfe9o53NG3SfOmoUTw8RGQ2en7J0
 o9CxX34itif29igy2GNFrEZ5yldCyZ+i+JTLvobL4NoLuaUSB5ePPeq/V
 kAJl+jBFiiU3mSKF2FQPg6GTdC81ZTxPi5ehW6O2TpqX7IqiSLIN1vhzN
 Ts9kfvPYWPvx2kSySgcWCyk7E52P1pemWB9ZZipCPuMEEajU7oWJ+da9j A==;
X-CSE-ConnectionGUID: qVMHYPU7RWOftJuHwA5fPw==
X-CSE-MsgGUID: 4bemAgdWQ1CnlyTgtMr+tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="50640812"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="50640812"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2025 20:04:20 -0700
X-CSE-ConnectionGUID: S616NJWbTnC+900O+ExQfw==
X-CSE-MsgGUID: 5U0jB3FhScq1q30R6cmfiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="181895439"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2025 20:04:18 -0700
Message-ID: <b30050b0-68d3-4b42-85f3-9aeca26fb830@intel.com>
Date: Tue, 3 Jun 2025 11:04:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] i386/tdx: Fix build on 32-bit host
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti <mtosatti@redhat.com>
References: <20250602173101.1052983-1-clg@redhat.com>
 <20250602173101.1052983-2-clg@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250602173101.1052983-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
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

On 6/3/2025 1:31 AM, Cédric Le Goater wrote:
> Use PRI formats where required and fix pointer cast.

Maybe we can make 32-bit build exclusive with CONFIG_TDX? since TDX is 
not supported on 32-bit host.

> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   target/i386/kvm/tdx.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 0a21ae555c5c..820ca3614e27 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -284,7 +284,7 @@ static void tdx_post_init_vcpus(void)
>   
>       hob = tdx_get_hob_entry(tdx_guest);
>       CPU_FOREACH(cpu) {
> -        tdx_vcpu_ioctl(cpu, KVM_TDX_INIT_VCPU, 0, (void *)hob->address,
> +        tdx_vcpu_ioctl(cpu, KVM_TDX_INIT_VCPU, 0, (void *)(uintptr_t)hob->address,
>                          &error_fatal);
>       }
>   }
> @@ -339,7 +339,7 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
>           uint32_t flags;
>   
>           region = (struct kvm_tdx_init_mem_region) {
> -            .source_addr = (uint64_t)entry->mem_ptr,
> +            .source_addr = (uintptr_t)entry->mem_ptr,
>               .gpa = entry->address,
>               .nr_pages = entry->size >> 12,
>           };
> @@ -893,16 +893,16 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
>   static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
>   {
>       if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
> -        error_setg(errp, "Invalid attributes 0x%lx for TDX VM "
> -                   "(KVM supported: 0x%llx)", tdx->attributes,
> -                   tdx_caps->supported_attrs);
> +        error_setg(errp, "Invalid attributes 0x%"PRIx64" for TDX VM "
> +                   "(KVM supported: 0x%"PRIx64")", tdx->attributes,
> +                   (uint64_t)tdx_caps->supported_attrs);
>           return -1;
>       }
>   
>       if (tdx->attributes & ~TDX_SUPPORTED_TD_ATTRS) {
>           error_setg(errp, "Some QEMU unsupported TD attribute bits being "
> -                    "requested: 0x%lx (QEMU supported: 0x%llx)",
> -                    tdx->attributes, TDX_SUPPORTED_TD_ATTRS);
> +                    "requested: 0x%"PRIx64" (QEMU supported: 0x%"PRIx64")",
> +                    tdx->attributes, (uint64_t)TDX_SUPPORTED_TD_ATTRS);
>           return -1;
>       }
>   
> @@ -931,8 +931,8 @@ static int setup_td_xfam(X86CPU *x86cpu, Error **errp)
>              env->features[FEAT_XSAVE_XSS_HI];
>   
>       if (xfam & ~tdx_caps->supported_xfam) {
> -        error_setg(errp, "Invalid XFAM 0x%lx for TDX VM (supported: 0x%llx))",
> -                   xfam, tdx_caps->supported_xfam);
> +        error_setg(errp, "Invalid XFAM 0x%"PRIx64" for TDX VM (supported: 0x%"PRIx64"))",
> +                   xfam, (uint64_t)tdx_caps->supported_xfam);
>           return -1;
>       }
>   
> @@ -999,14 +999,14 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>   
>       if (env->tsc_khz && (env->tsc_khz < TDX_MIN_TSC_FREQUENCY_KHZ ||
>                            env->tsc_khz > TDX_MAX_TSC_FREQUENCY_KHZ)) {
> -        error_setg(errp, "Invalid TSC %ld KHz, must specify cpu_frequency "
> +        error_setg(errp, "Invalid TSC %"PRId64" KHz, must specify cpu_frequency "
>                            "between [%d, %d] kHz", env->tsc_khz,
>                            TDX_MIN_TSC_FREQUENCY_KHZ, TDX_MAX_TSC_FREQUENCY_KHZ);
>          return -EINVAL;
>       }
>   
>       if (env->tsc_khz % (25 * 1000)) {
> -        error_setg(errp, "Invalid TSC %ld KHz, it must be multiple of 25MHz",
> +        error_setg(errp, "Invalid TSC %"PRId64" KHz, it must be multiple of 25MHz",
>                      env->tsc_khz);
>           return -EINVAL;
>       }
> @@ -1014,7 +1014,7 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>       /* it's safe even env->tsc_khz is 0. KVM uses host's tsc_khz in this case */
>       r = kvm_vm_ioctl(kvm_state, KVM_SET_TSC_KHZ, env->tsc_khz);
>       if (r < 0) {
> -        error_setg_errno(errp, -r, "Unable to set TSC frequency to %ld kHz",
> +        error_setg_errno(errp, -r, "Unable to set TSC frequency to %"PRId64" kHz",
>                            env->tsc_khz);
>           return r;
>       }
> @@ -1139,7 +1139,7 @@ int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
>       uint64_t gpa = -1ull;
>   
>       if (error_code & 0xffff) {
> -        error_report("TDX: REPORT_FATAL_ERROR: invalid error code: 0x%lx",
> +        error_report("TDX: REPORT_FATAL_ERROR: invalid error code: 0x%"PRIx64,
>                        error_code);
>           return -1;
>       }


