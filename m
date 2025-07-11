Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC80C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua8wd-0003nl-T5; Fri, 11 Jul 2025 04:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ua8oD-0001Sx-TW
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:08:42 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ua8oB-0001Jw-2e
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752221319; x=1783757319;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=2oEtY2OWjHRph5dh9gdlj3LXKF5u1l7UJCT9NH5PLI8=;
 b=Sxz18QHGsfgTFUhpXa/nSc7oWV6b8YY8e1dIHGGOhgGerRjP4gnIi4ED
 Nrv6d+0Ivtnwww1grgF24AjLivvYVItIk3KtqbyUfuk44htuN9LtmaHE8
 QNgvPsPe/Bl3hiNz1W0vmg5brPAGT5I3MzyITzll0cgD8rINbwrleWQuh
 27oXKWrlOjEr+tgXxxgksJ1It/B0M/F5SA+2F2BmIR7yuTnwyEHxEPVsa
 0eVYfe/RI8NrPzGGG8XdQgXxKqyj2GSeqmUDjFu5dOZo2RRSJEcSxYutl
 H1UpXcnz05ABICE2qCaglQpj1GxMXB573RKV9jiB+cepjnx4re0eAv5p4 g==;
X-CSE-ConnectionGUID: AEpZvAsmR2Wl/92xayaKeA==
X-CSE-MsgGUID: CgEBX2dOSvC1AGasaKIUkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="58323857"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="58323857"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 01:08:36 -0700
X-CSE-ConnectionGUID: IWyG5ePHQFy0OjX4+f3U/g==
X-CSE-MsgGUID: w3GweDxOSnOxZdsuGu4YcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="162000340"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 01:08:35 -0700
Message-ID: <71fcacbf-d210-48fb-81fd-64deceb4ba07@intel.com>
Date: Fri, 11 Jul 2025 16:08:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: merge host_cpu_instance_init() and
 host_cpu_max_instance_init()
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250711075507.451540-1-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250711075507.451540-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
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

On 7/11/2025 3:55 PM, Paolo Bonzini wrote:
> Simplify the accelerators' cpu_instance_init callbacks by doing all
> host-cpu setup in a single function.
> 
> Based-on: <20250711000603.438312-1-pbonzini@redhat.com>
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Miss to remove the declaration.

With below added,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

-------------8<-------------------
diff --git a/target/i386/host-cpu.h b/target/i386/host-cpu.h
index b97ec01c9bec..5b2ad491a8ca 100644
--- a/target/i386/host-cpu.h
+++ b/target/i386/host-cpu.h
@@ -12,7 +12,6 @@

  uint32_t host_cpu_phys_bits(void);
  void host_cpu_instance_init(X86CPU *cpu);
-void host_cpu_max_instance_init(X86CPU *cpu);
  bool host_cpu_realizefn(CPUState *cs, Error **errp);

  void host_cpu_vendor_fms(char *vendor, int *family, int *model, int 
*stepping);


> ---
>   target/i386/host-cpu.c    | 28 ++++++++++++++--------------
>   target/i386/hvf/hvf-cpu.c |  2 --
>   target/i386/kvm/kvm-cpu.c |  2 --
>   3 files changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
> index 7512567298b..3399edc1ad0 100644
> --- a/target/i386/host-cpu.c
> +++ b/target/i386/host-cpu.c
> @@ -132,27 +132,27 @@ void host_cpu_instance_init(X86CPU *cpu)
>   {
>       X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
>   
> -    if (xcc->model) {
> -        char vendor[CPUID_VENDOR_SZ + 1];
> -
> -        host_cpu_vendor_fms(vendor, NULL, NULL, NULL);
> -        object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
> -    }
> -}
> -
> -void host_cpu_max_instance_init(X86CPU *cpu)
> -{
>       char vendor[CPUID_VENDOR_SZ + 1] = { 0 };
>       char model_id[CPUID_MODEL_ID_SZ + 1] = { 0 };
>       int family, model, stepping;
>   
> +    /*
> +     * setting vendor applies to both max/host and builtin_x86_defs CPU.
> +     * FIXME: this probably should warn or should be skipped if vendors do
> +     * not match, because family numbers are incompatible between Intel and AMD.
> +     */
> +    host_cpu_vendor_fms(vendor, &family, &model, &stepping);
> +    object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
> +
> +    if (!xcc->max_features) {
> +        return;
> +    }
> +
> +    host_cpu_fill_model_id(model_id);
> +
>       /* Use max host physical address bits if -cpu max option is applied */
>       object_property_set_bool(OBJECT(cpu), "host-phys-bits", true, &error_abort);
>   
> -    host_cpu_vendor_fms(vendor, &family, &model, &stepping);
> -    host_cpu_fill_model_id(model_id);
> -
> -    object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
>       object_property_set_int(OBJECT(cpu), "family", family, &error_abort);
>       object_property_set_int(OBJECT(cpu), "model", model, &error_abort);
>       object_property_set_int(OBJECT(cpu), "stepping", stepping,
> diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
> index 2b991f2fc8e..94ee096ecf7 100644
> --- a/target/i386/hvf/hvf-cpu.c
> +++ b/target/i386/hvf/hvf-cpu.c
> @@ -21,8 +21,6 @@ static void hvf_cpu_max_instance_init(X86CPU *cpu)
>   {
>       CPUX86State *env = &cpu->env;
>   
> -    host_cpu_max_instance_init(cpu);
> -
>       env->cpuid_min_level =
>           hvf_get_supported_cpuid(0x0, 0, R_EAX);
>       env->cpuid_min_xlevel =
> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index 6fed353548e..a99b8764644 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -109,8 +109,6 @@ static void kvm_cpu_max_instance_init(X86CPU *cpu)
>       CPUX86State *env = &cpu->env;
>       KVMState *s = kvm_state;
>   
> -    host_cpu_max_instance_init(cpu);
> -
>       object_property_set_bool(OBJECT(cpu), "pmu", true, &error_abort);
>   
>       if (lmce_supported()) {


