Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63759C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 02:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua3NQ-00010s-6d; Thu, 10 Jul 2025 22:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ua3NM-0000zH-Nn
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 22:20:37 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ua3NJ-0008UA-Su
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 22:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752200434; x=1783736434;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=PNz4nG40rk48yPG/KiiBEDYVcGf0vtPoIl3p6o224ng=;
 b=jprVhhWIlSuUjwurm40iz6fM227ackxEHUP/UqwhPIjs+Ghwzw6oLPsK
 jSD/oejRmWvS3RfVqTZAR2cHBxrBydjwqH/wTB6ogVlNzf2TTvKo/Yx1e
 dEukvfNp41ZebU2G6IkQqHcxmxKP8KIi7iCImRaG+Uo5Rtj4WXpuQL0Ik
 NOuMJRuvmp5wr223auGwxqzOXtJu0QBlx/77gTKW25DhB8dIsC/KWt6l/
 ctlY/Jkl+J1mudgD/Wifa7T7II2aRIuqh0h3U2QRXe37kflDNV8d93svc
 odepwOXOULyYlCQ+CW8tb4wrG6NdWeQ78ymlTHKp7o1+QA4P+XSB5nuhh g==;
X-CSE-ConnectionGUID: MWw2XIqCSDulknEUS+ig7A==
X-CSE-MsgGUID: izGhFtCSQJO0VASX3YRT9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54627221"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="54627221"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 19:20:32 -0700
X-CSE-ConnectionGUID: CoUCnJBXTdOiukCaXVIe/Q==
X-CSE-MsgGUID: XvNovRBUR+O0RViOHiH0lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="160803550"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 19:20:30 -0700
Message-ID: <f4ec472c-2966-42b8-82e2-ef228380aca8@intel.com>
Date: Fri, 11 Jul 2025 10:20:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/i386: allow reordering max_x86_cpu_initfn vs
 accel CPU init
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
References: <20250711000603.438312-1-pbonzini@redhat.com>
 <20250711000603.438312-4-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250711000603.438312-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=xiaoyao.li@intel.com;
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
> The PMU feature is only supported by KVM, so move it there.  And since
> all accelerators other than TCG overwrite the vendor, set it in
> max_x86_cpu_initfn only if it has not been initialized by the
> superclass.  This makes it possible to run max_x86_cpu_initfn
> after accelerator init.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   target/i386/cpu.c         | 24 ++++++++++++------------
>   target/i386/kvm/kvm-cpu.c |  2 ++
>   2 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 69bdffbfe46..46d59229200 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6204,21 +6204,21 @@ static void max_x86_cpu_class_init(ObjectClass *oc, const void *data)
>   static void max_x86_cpu_initfn(Object *obj)
>   {
>       X86CPU *cpu = X86_CPU(obj);
> -
> -    /* We can't fill the features array here because we don't know yet if
> -     * "migratable" is true or false.
> -     */
> -    object_property_set_bool(OBJECT(cpu), "pmu", true, &error_abort);
> +    CPUX86State *env = &cpu->env;
>   
>       /*
> -     * these defaults are used for TCG and all other accelerators
> -     * besides KVM and HVF, which overwrite these values
> +     * these defaults are used for TCG, other accelerators overwrite these
> +     * values
>        */
> -    object_property_set_str(OBJECT(cpu), "vendor", CPUID_VENDOR_AMD,
> -                            &error_abort);
> -    object_property_set_str(OBJECT(cpu), "model-id",
> -                            "QEMU TCG CPU version " QEMU_HW_VERSION,
> -                            &error_abort);
> +    if (!env->cpuid_vendor1) {
> +        object_property_set_str(OBJECT(cpu), "vendor", CPUID_VENDOR_AMD,
> +                                &error_abort);
> +    }
> +    if (!env->cpuid_model[0]) {
> +        object_property_set_str(OBJECT(cpu), "model-id",
> +                                "QEMU TCG CPU version " QEMU_HW_VERSION,
> +                                &error_abort);
> +    }
>   }
>   
>   static const TypeInfo max_x86_cpu_type_info = {
> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index 0fb88a239d4..6fed353548e 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -111,6 +111,8 @@ static void kvm_cpu_max_instance_init(X86CPU *cpu)
>   
>       host_cpu_max_instance_init(cpu);
>   
> +    object_property_set_bool(OBJECT(cpu), "pmu", true, &error_abort);
> +
>       if (lmce_supported()) {
>           object_property_set_bool(OBJECT(cpu), "lmce", true, &error_abort);
>       }


