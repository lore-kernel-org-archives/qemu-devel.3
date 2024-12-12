Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BDAE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 22:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLrU8-0003C8-PT; Thu, 12 Dec 2024 17:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1tLrU6-0003Bt-Qd
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 17:16:38 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1tLrU3-0007t8-Rf
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 17:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734041795; x=1765577795;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=L0kUO9Zc9aPn1M/kjfuUhl6rSW2X2XL2ry4fhK9++8E=;
 b=Ms4tjYMOE39XDx44jNzIA/7m/h6A0/OAClL4QsbbfH377ggiij+i46bo
 A551H/3GsN+faWAflEUAB/VALhD9bZmwi/vO6518l0C0AgwRTZvaAsD+d
 K5h3LMq6UI9Ags+2ve+gHe/57NLuVj31bHcS/IaRKGffT+NASejbGtb6h
 VtRFguAaK5FQgpH1NUzIBEEDNdD6t/E9uM6khAuqOMbhPHDQ7DzhVKjYl
 dkf4WH4+/hyB7Gdq4KAWjwEFU5hKO7HcBU8FBEPHMBDWFyXvmafPRAy/0
 DT1o9odvYK6byQceHqxUgxpEzrnvnvhj+eH4jZNcbF8G5uDRqq3dOvs+9 Q==;
X-CSE-ConnectionGUID: gvgK4B9jQ1iHicGBg41pbQ==
X-CSE-MsgGUID: VTCLAWBzQkCPOF6IkgBtQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34400013"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; d="scan'208";a="34400013"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 14:16:33 -0800
X-CSE-ConnectionGUID: TRYlwhXoSOyJLm7Xz90EMg==
X-CSE-MsgGUID: i7NLU5X2Ro+s+BIZxKpnOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="100935842"
Received: from puneetse-mobl.amr.corp.intel.com (HELO localhost)
 ([10.125.110.112])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 14:16:31 -0800
Date: Thu, 12 Dec 2024 16:16:29 -0600
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
Subject: Re: [PATCH v6 35/60] i386/cpu: Introduce enable_cpuid_0x1f to force
 exposing CPUID 0x1f
Message-ID: <Z1tgvQdLeafHKXIe@iweiny-mobl>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-36-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105062408.3533704-36-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=ira.weiny@intel.com;
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

On Tue, Nov 05, 2024 at 01:23:43AM -0500, Xiaoyao Li wrote:
> Currently, QEMU exposes CPUID 0x1f to guest only when necessary, i.e.,
> when topology level that cannot be enumerated by leaf 0xB, e.g., die or
> module level, are configured for the guest, e.g., -smp xx,dies=2.
> 
> However, TDX architecture forces to require CPUID 0x1f to configure CPU
> topology.
> 
> Introduce a bool flag, enable_cpuid_0x1f, in CPU for the case that
> requires CPUID leaf 0x1f to be exposed to guest.
> 
> Introduce a new function x86_has_cpuid_0x1f(), which is the warpper of
> cpu->enable_cpuid_0x1f and x86_has_extended_topo() to check if it needs
> to enable cpuid leaf 0x1f for the guest.

Could you elaborate on the relation between cpuid_0x1f and the extended
topology support?  I feel like x86_has_cpuid_0x1f() is a poor name for this
check.

Perhaps I'm just not understanding what is required here?

Ira

> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c     | 4 ++--
>  target/i386/cpu.h     | 9 +++++++++
>  target/i386/kvm/kvm.c | 2 +-
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1ffbafef03e7..119b38bcb0c1 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6731,7 +6731,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          break;
>      case 0x1F:
>          /* V2 Extended Topology Enumeration Leaf */
> -        if (!x86_has_extended_topo(env->avail_cpu_topo)) {
> +        if (!x86_has_cpuid_0x1f(cpu)) {
>              *eax = *ebx = *ecx = *edx = 0;
>              break;
>          }
> @@ -7588,7 +7588,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>           * cpu->vendor_cpuid_only has been unset for compatibility with older
>           * machine types.
>           */
> -        if (x86_has_extended_topo(env->avail_cpu_topo) &&
> +        if (x86_has_cpuid_0x1f(cpu) &&
>              (IS_INTEL_CPU(env) || !cpu->vendor_cpuid_only)) {
>              x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x1F);
>          }
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 59959b8b7a4d..dcc673262c06 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2171,6 +2171,9 @@ struct ArchCPU {
>      /* Compatibility bits for old machine types: */
>      bool enable_cpuid_0xb;
>  
> +    /* Force to enable cpuid 0x1f */
> +    bool enable_cpuid_0x1f;
> +
>      /* Enable auto level-increase for all CPUID leaves */
>      bool full_cpuid_auto_level;
>  
> @@ -2431,6 +2434,12 @@ void host_cpuid(uint32_t function, uint32_t count,
>                  uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
>  bool cpu_has_x2apic_feature(CPUX86State *env);
>  
> +static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
> +{
> +    return cpu->enable_cpuid_0x1f ||
> +           x86_has_extended_topo(cpu->env.avail_cpu_topo);
> +}
> +
>  /* helper.c */
>  void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
>  void cpu_sync_avx_hflag(CPUX86State *env);
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index dea0f83370d5..022809bad36e 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1874,7 +1874,7 @@ uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
>              break;
>          }
>          case 0x1f:
> -            if (!x86_has_extended_topo(env->avail_cpu_topo)) {
> +            if (!x86_has_cpuid_0x1f(env_archcpu(env))) {
>                  cpuid_i--;
>                  break;
>              }
> -- 
> 2.34.1
> 

