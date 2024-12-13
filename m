Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D50DE7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 14:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM6sm-0005hJ-4I; Fri, 13 Dec 2024 09:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1tM6sS-0005X4-IO
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:42:49 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1tM6sQ-0006zu-0G
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734100966; x=1765636966;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ewF6klg4X9hljS7CKMG70YMyGmFT9UUVDYLBQ26g12E=;
 b=Lmt7Kuk8bSJ2VTUPpt9wg0Kzla3Scg3symUXCl+y1RmqJs0OLLS8mZff
 vTI3qUafUtgwNCWaNts6O82jAm3Y02pEJ0gAX62UfkkmeiNC8PedYNJnb
 q8V3+YIP7MOBoPnt9Ar8jTuMf2HsrEfUAISMJosugFSJ6mOz4eTWQnXak
 2IYPUvwVtFLlcfdqmFlYsGzVIjVZwkcRDvowrrhiPI6yjwWCIHWKoKBik
 rf/ZsFWj1eS0+CMn99GzuC5chqYy+HFsc+Qu6kg+Znjsu0zaAaqB3CdbP
 cvEK5uc31QMroEwLvl1/fwJv5olcU7+HIL1P10+GxkhjZ8QcLh3Ih1iU3 w==;
X-CSE-ConnectionGUID: uBsP752yQke+X/xbeTAmag==
X-CSE-MsgGUID: cKeplhuKSDCBIT6GELLoGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="33881429"
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; d="scan'208";a="33881429"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2024 06:42:27 -0800
X-CSE-ConnectionGUID: WUSWQzgSTt+pHbHcWopBQQ==
X-CSE-MsgGUID: e6gS6JrRTEWFSxL5eKTxfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; d="scan'208";a="96438363"
Received: from ldmartin-desk2.corp.intel.com (HELO localhost)
 ([10.125.110.201])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Dec 2024 06:42:25 -0800
Date: Fri, 13 Dec 2024 08:42:22 -0600
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
Subject: Re: [PATCH v6 43/60] i386/tdx: Only configure MSR_IA32_UCODE_REV in
 kvm_init_msrs() for TDs
Message-ID: <Z1xHztTldnFDih8W@iweiny-mobl>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-44-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105062408.3533704-44-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=ira.weiny@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Nov 05, 2024 at 01:23:51AM -0500, Xiaoyao Li wrote:
> For TDs, only MSR_IA32_UCODE_REV in kvm_init_msrs() can be configured
> by VMM, while the features enumerated/controlled by other MSRs except
> MSR_IA32_UCODE_REV in kvm_init_msrs() are not under control of VMM.

I'm confused by this commit message.  If these features are not under VMM
control with TDX who controls them?  I assume it is the TDX module.  But where
are the qemu hooks to talk to the module?  Are they not needed in qemu at all?

Also, why are the has_msr_* flags true for a TDX TD in the first place?

Ira

> 
> Only configure MSR_IA32_UCODE_REV for TDs.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  target/i386/kvm/kvm.c | 44 ++++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 595439f4a4d6..8909fce14909 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -3852,32 +3852,34 @@ static void kvm_init_msrs(X86CPU *cpu)
>      CPUX86State *env = &cpu->env;
>  
>      kvm_msr_buf_reset(cpu);
> -    if (has_msr_arch_capabs) {
> -        kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
> -                          env->features[FEAT_ARCH_CAPABILITIES]);
> -    }
> -
> -    if (has_msr_core_capabs) {
> -        kvm_msr_entry_add(cpu, MSR_IA32_CORE_CAPABILITY,
> -                          env->features[FEAT_CORE_CAPABILITY]);
> -    }
> -
> -    if (has_msr_perf_capabs && cpu->enable_pmu) {
> -        kvm_msr_entry_add_perf(cpu, env->features);
> +
> +    if (!is_tdx_vm()) {
> +        if (has_msr_arch_capabs) {
> +            kvm_msr_entry_add(cpu, MSR_IA32_ARCH_CAPABILITIES,
> +                                env->features[FEAT_ARCH_CAPABILITIES]);
> +        }
> +
> +        if (has_msr_core_capabs) {
> +            kvm_msr_entry_add(cpu, MSR_IA32_CORE_CAPABILITY,
> +                                env->features[FEAT_CORE_CAPABILITY]);
> +        }
> +
> +        if (has_msr_perf_capabs && cpu->enable_pmu) {
> +            kvm_msr_entry_add_perf(cpu, env->features);
> +        }
> +
> +        /*
> +         * Older kernels do not include VMX MSRs in KVM_GET_MSR_INDEX_LIST, but
> +         * all kernels with MSR features should have them.
> +         */
> +        if (kvm_feature_msrs && cpu_has_vmx(env)) {
> +            kvm_msr_entry_add_vmx(cpu, env->features);
> +        }
>      }
>  
>      if (has_msr_ucode_rev) {
>          kvm_msr_entry_add(cpu, MSR_IA32_UCODE_REV, cpu->ucode_rev);
>      }
> -
> -    /*
> -     * Older kernels do not include VMX MSRs in KVM_GET_MSR_INDEX_LIST, but
> -     * all kernels with MSR features should have them.
> -     */
> -    if (kvm_feature_msrs && cpu_has_vmx(env)) {
> -        kvm_msr_entry_add_vmx(cpu, env->features);
> -    }
> -
>      assert(kvm_buf_set_msrs(cpu) == 0);
>  }
>  
> -- 
> 2.34.1
> 

