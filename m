Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3161DE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 17:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLnMx-0006ez-Ce; Thu, 12 Dec 2024 12:52:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1tLnMt-0006ek-QT
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:52:55 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1tLnMq-00088P-Uk
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734025973; x=1765561973;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/D7194Ss/b+oJBhhO0FKkDLp1gnVp/0N2VBsO0P1xVw=;
 b=Rx3cqmyqriKztXT+3nlO0XHobUE+vreZURoTt+okBFFeBK+l+DYLdwIH
 2juMY8ER0BI+OHUZ2uX8J75U1nME010ZCPjpUaOOAVutJtRiB/jECuLHo
 PH1LAQOb1vphevrwJ8nVUf0O1nwS/MYB0+8shqiaIM5a5UJrddmMCWtLW
 ECJziH++WfLk0fL6YcHFzcjoffmwJ7MqhwPAA++UMDKJ433YiTYR6duMh
 zXPJkq9wFnVrnwEKjy5o4oNxPgqnNdizzeu2+bZB3p5pHz0cO5OkvynJL
 iVQ8uA7cuPgoXMiGMFohYDY8VyZtg2DAou2y5hBWAH2HlRz+x8oNeFCAO Q==;
X-CSE-ConnectionGUID: fTUuaAjlSQ654B20Cs8fwQ==
X-CSE-MsgGUID: jSFazlMrRoK5jVbOZFKcpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34700260"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; d="scan'208";a="34700260"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 09:52:49 -0800
X-CSE-ConnectionGUID: UIxZ9EhrT+2os9RG/KDzcQ==
X-CSE-MsgGUID: jxboOayXTd2VbDYvDAM1Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; d="scan'208";a="96705388"
Received: from puneetse-mobl.amr.corp.intel.com (HELO localhost)
 ([10.125.110.112])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 09:52:47 -0800
Date: Thu, 12 Dec 2024 11:52:43 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 55/60] i386/tdx: Fetch and validate CPUID of TD guest
Message-ID: <Z1si66iUjsqCoUgL@iweiny-mobl>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-56-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105062408.3533704-56-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=ira.weiny@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 05, 2024 at 01:24:03AM -0500, Xiaoyao Li wrote:
> Use KVM_TDX_GET_CPUID to get the CPUIDs that are managed and enfored
> by TDX module for TD guest. Check QEMU's configuration against the
> fetched data.
> 
> Print wanring  message when 1. a feature is not supported but requested
> by QEMU or 2. QEMU doesn't want to expose a feature while it is enforced
> enabled.
> 
> - If cpu->enforced_cpuid is not set, prints the warning message of both
> 1) and 2) and tweak QEMU's configuration.
> 
> - If cpu->enforced_cpuid is set, quit if any case of 1) or 2).

Patches 52, 53, 54, and this one should probably be squashed

53's commit message is non-existent and really only makes sense because the
function is used here.  52's commit message is pretty thin.  Both 52 and 53 are
used here, the size of this patch is not adversely affected, and the reason for
the changes are more clearly shown in this patch.

54 somewhat stands on its own.  But really it is just calling the functionality
of this patch.  So I don't see a big reason for it to be on its own but up to
you.

> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/kvm/tdx.c | 81 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index e7e0f073dfc9..9cb099e160e4 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -673,6 +673,86 @@ static uint32_t tdx_adjust_cpuid_features(X86ConfidentialGuest *cg,
>      return value;
>  }
>  
> +
> +static void tdx_fetch_cpuid(CPUState *cpu, struct kvm_cpuid2 *fetch_cpuid)
> +{
> +    int r;
> +
> +    r = tdx_vcpu_ioctl(cpu, KVM_TDX_GET_CPUID, 0, fetch_cpuid);
> +    if (r) {
> +        error_report("KVM_TDX_GET_CPUID failed %s", strerror(-r));
> +        exit(1);
> +    }
> +}
> +
> +static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
> +{
> +    uint64_t actual, requested, unavailable, forced_on;
> +    g_autofree struct kvm_cpuid2 *fetch_cpuid;
> +    const char *forced_on_prefix = NULL;
> +    const char *unav_prefix = NULL;
> +    struct kvm_cpuid_entry2 *entry;
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +    FeatureWordInfo *wi;
> +    FeatureWord w;
> +    bool mismatch = false;
> +
> +    fetch_cpuid = g_malloc0(sizeof(*fetch_cpuid) +
> +                    sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);

Is this a memory leak?  I don't see fetch_cpuid returned or free'ed.  If so, it
might be better to use g_autofree() for this allocation.

Alternatively, this allocation size is constant, could this be on the heap and
not allocated at all?  (I assume it is big enough that a stack allocation is
unwanted.)

Ira

> +    tdx_fetch_cpuid(cs, fetch_cpuid);
> +
> +    if (cpu->check_cpuid || cpu->enforce_cpuid) {
> +        unav_prefix = "TDX doesn't support requested feature";
> +        forced_on_prefix = "TDX forcibly sets the feature";
> +    }
> +
> +    for (w = 0; w < FEATURE_WORDS; w++) {
> +        wi = &feature_word_info[w];
> +        actual = 0;
> +
> +        switch (wi->type) {
> +        case CPUID_FEATURE_WORD:
> +            entry = cpuid_find_entry(fetch_cpuid, wi->cpuid.eax, wi->cpuid.ecx);
> +            if (!entry) {
> +                /*
> +                 * If KVM doesn't report it means it's totally configurable
> +                 * by QEMU
> +                 */
> +                continue;
> +            }
> +
> +            actual = cpuid_entry_get_reg(entry, wi->cpuid.reg);
> +            break;
> +        case MSR_FEATURE_WORD:
> +            /*
> +             * TODO:
> +             * validate MSR features when KVM has interface report them.
> +             */
> +            continue;
> +        }
> +
> +        requested = env->features[w];
> +        unavailable = requested & ~actual;
> +        mark_unavailable_features(cpu, w, unavailable, unav_prefix);
> +        if (unavailable) {
> +            mismatch = true;
> +        }
> +
> +        forced_on = actual & ~requested;
> +        mark_forced_on_features(cpu, w, forced_on, forced_on_prefix);
> +        if (forced_on) {
> +            mismatch = true;
> +        }
> +    }
> +
> +    if (cpu->enforce_cpuid && mismatch) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>  static int tdx_validate_attributes(TdxGuest *tdx, Error **errp)
>  {
>      if ((tdx->attributes & ~tdx_caps->supported_attrs)) {
> @@ -1019,4 +1099,5 @@ static void tdx_guest_class_init(ObjectClass *oc, void *data)
>      x86_klass->cpu_instance_init = tdx_cpu_instance_init;
>      x86_klass->cpu_realizefn = tdx_cpu_realizefn;
>      x86_klass->adjust_cpuid_features = tdx_adjust_cpuid_features;
> +    x86_klass->check_features = tdx_check_features;
>  }
> -- 
> 2.34.1
> 

