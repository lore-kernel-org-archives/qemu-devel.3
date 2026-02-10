Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00844EA3F09
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 07:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vphqn-0002CB-VY; Tue, 10 Feb 2026 02:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vphql-0002Bg-Qp
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:07:55 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1vphqk-0005LK-4I
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770707274; x=1802243274;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=VCHm+1U7yx0luMTFJ4dTIegtYJP0FVqEZIZriluU/LE=;
 b=Co0HwO8l1+lKqi3Ma5ICurouMA1ZCh7+ofleirTSwpYn0HFR0OKQqZU4
 FlZkoqslMJdNuGJ77CvsaW53A3BvZEnZf9dgDd4SlEe30wCwM5yMj0G9f
 g/8eET6hLsgYIfNhfRXUxOJ6UxnKfAlI7V0oY2vsnSj+xxlOtrUHYV+O/
 m6Dksx0Tw+sr6mUbagQjJJ4w7rI4IKD2dEBK3ADp67ixUko6cwEhrAAl9
 WEEyQuUKOPfXdabGpfmbaHQJbFuKwhG7++nQefvD8mCLJxL9U+MHRnn1B
 MTnlml7QgHhYHxoxrsm4hgt1XLr3UMFno5fduNuLZn5ESHFDkQM7XpJ1R w==;
X-CSE-ConnectionGUID: zi2Jm6FrS++zG6hQpowtZA==
X-CSE-MsgGUID: NvmK9mT8S0izEF5VcjSJQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71039004"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71039004"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 23:07:52 -0800
X-CSE-ConnectionGUID: GRhIKsADTVSQ1t+LQYmsqA==
X-CSE-MsgGUID: 9spyRXT5SyWOs1i1oC+1Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211038275"
Received: from qianm-mobl2.ccr.corp.intel.com (HELO [10.238.1.184])
 ([10.238.1.184])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 23:07:49 -0800
Message-ID: <aebb7e2a-9690-45d2-8410-3d27bb3fa715@linux.intel.com>
Date: Tue, 10 Feb 2026 15:07:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 08/11] target/i386: Clean up LBR format handling
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>
References: <20260128231003.268981-1-zide.chen@intel.com>
 <20260128231003.268981-9-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260128231003.268981-9-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 1/29/2026 7:09 AM, Zide Chen wrote:
> Since the lbr-fmt property is masked with PERF_CAP_LBR_FMT in
> DEFINE_PROP_UINT64_CHECKMASK(), there is no need to explicitly validate
> user-requested lbr-fmt values.
>
> The PMU feature is only supported when running under KVM, so initialize
> cpu->lbr_fmt in kvm_cpu_instance_init().  Use -1 as the default lbr-fmt,
> rather than initializing it with ~PERF_CAP_LBR_FMT, which is misleading
> as it suggests a semantic relationship that does not exist.
>
> Rename requested_lbr_fmt to a more generic guest_fmt.  When lbr-fmt is
> not specified and cpu->migratable is false, the guest lbr_fmt value is
> not user-requested.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V2:
> - New patch.
>
>  target/i386/cpu.c         | 18 ++++++------------
>  target/i386/kvm/kvm-cpu.c |  2 ++
>  2 files changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f2c83b4f259c..09180c718d58 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -9788,7 +9788,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>      X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
>      CPUX86State *env = &cpu->env;
>      Error *local_err = NULL;
> -    unsigned requested_lbr_fmt;
> +    unsigned guest_fmt;
>  
>      if (!kvm_enabled())
>          cpu->enable_pmu = false;
> @@ -9828,11 +9828,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>       * Override env->features[FEAT_PERF_CAPABILITIES].LBR_FMT
>       * with user-provided setting.
>       */
> -    if (cpu->lbr_fmt != ~PERF_CAP_LBR_FMT) {
> -        if ((cpu->lbr_fmt & PERF_CAP_LBR_FMT) != cpu->lbr_fmt) {
> -            error_setg(errp, "invalid lbr-fmt");
> -            return;
> -        }
> +    if (cpu->lbr_fmt != -1) {
>          env->features[FEAT_PERF_CAPABILITIES] &= ~PERF_CAP_LBR_FMT;
>          env->features[FEAT_PERF_CAPABILITIES] |= cpu->lbr_fmt;
>      }
> @@ -9841,9 +9837,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>       * vPMU LBR is supported when 1) KVM is enabled 2) Option pmu=on and
>       * 3)vPMU LBR format matches that of host setting.
>       */
> -    requested_lbr_fmt =
> -        env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_LBR_FMT;
> -    if (requested_lbr_fmt && kvm_enabled()) {
> +    guest_fmt = env->features[FEAT_PERF_CAPABILITIES] & PERF_CAP_LBR_FMT;
> +    if (guest_fmt) {
>          uint64_t host_perf_cap =
>              x86_cpu_get_supported_feature_word(NULL, FEAT_PERF_CAPABILITIES);
>          unsigned host_lbr_fmt = host_perf_cap & PERF_CAP_LBR_FMT;
> @@ -9852,10 +9847,10 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>              error_setg(errp, "vPMU: LBR is unsupported without pmu=on");
>              return;
>          }
> -        if (requested_lbr_fmt != host_lbr_fmt) {
> +        if (guest_fmt != host_lbr_fmt) {
>              error_setg(errp, "vPMU: the lbr-fmt value (0x%x) does not match "
>                          "the host value (0x%x).",
> -                        requested_lbr_fmt, host_lbr_fmt);
> +                        guest_fmt, host_lbr_fmt);
>              return;
>          }
>      }
> @@ -10279,7 +10274,6 @@ static void x86_cpu_initfn(Object *obj)
>      object_property_add_alias(obj, "sse4_2", obj, "sse4.2");
>  
>      object_property_add_alias(obj, "hv-apicv", obj, "hv-avic");
> -    cpu->lbr_fmt = ~PERF_CAP_LBR_FMT;
>      object_property_add_alias(obj, "lbr_fmt", obj, "lbr-fmt");
>  
>      if (xcc->model) {
> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index 33a8c26bc27c..b4500ab69f82 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -231,6 +231,8 @@ static void kvm_cpu_instance_init(CPUState *cs)
>          kvm_cpu_max_instance_init(cpu);
>      }
>  
> +    cpu->lbr_fmt = -1;
> +
>      kvm_cpu_xsave_init();
>  }
>  

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



