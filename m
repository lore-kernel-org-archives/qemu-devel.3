Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A118C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 08:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh1s7-0004fp-9V; Wed, 30 Jul 2025 04:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uh1Zo-0006Wi-QS
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 03:50:30 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uh1Zi-000632-1d
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 03:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753861811; x=1785397811;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Hy5yGYlKFNhPLaGusC7T4ybhSpH28mkF5JMzPVdav9I=;
 b=ZyLm070xRZ/OLxBvyW59dyuS2SHVoNrhYz8rphsiv9zFMg1A0HtvxI6/
 DTD8IaPXJcDRwiDWmemRVDlM0sHD6uLQengDvchjUFoaO1RmnF1u22cty
 DpOiVIx33VYFWbQovmy8KLBDv4cuCqfxIn1aum/HDpAS2vrxYx5yPFQPc
 ly7ZTAWtXtGNxDPsYQrGsynH0tG7uZLShb2hFS1Aaar6OZY8jC56UuTTK
 7O9mJEw9TBehHi+jUkr2Y34Nnip6nojkPJM7kEV5WNCOGzSQNkWFtHSwO
 7rubLH1U7S/ZlbY4NaQ+NDzFXHkgqIpU1xbmbbA1XyHKjv9qh0Pmh7k5c g==;
X-CSE-ConnectionGUID: tbJnozgHRGyamPsuZEgemQ==
X-CSE-MsgGUID: uzeZ+FBCRjiUIErG+saEgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="55852567"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="55852567"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 00:50:05 -0700
X-CSE-ConnectionGUID: eNJhPzgHTZS4bLNmD18eNA==
X-CSE-MsgGUID: djthuoOaSBaZ4bq+YiQ7jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="162193164"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 30 Jul 2025 00:50:03 -0700
Date: Wed, 30 Jul 2025 16:11:38 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] i386/cpu: Enable SMM cpu addressspace
Message-ID: <aInTujVM5hr6/cJw@intel.com>
References: <20250729054023.1668443-1-xiaoyao.li@intel.com>
 <20250729054023.1668443-2-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729054023.1668443-2-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> @@ -91,6 +92,15 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>          kvm_set_guest_phys_bits(cs);
>      }
>  
> +    /*
> +     * When SMM is enabled, there is 2 address spaces. Otherwise only 1.
> +     *
> +     * Only init address space 0 here, the second one for SMM is initialized at
               ^^^^
	       initialize

> +     * register_smram_listener() after machine init done.
> +     */
> +    cs->num_ases = x86_machine_is_smm_enabled(X86_MACHINE(current_machine)) ? 2 : 1;
> +    cpu_address_space_init(cs, 0, "cpu-mmeory", cs->memory);
> +
>      return true;
>  }
>  
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 369626f8c8d7..47fb5c673c8e 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2704,6 +2704,7 @@ static MemoryRegion smram_as_mem;
>  
>  static void register_smram_listener(Notifier *n, void *unused)
>  {
> +    CPUState *cpu;
>      MemoryRegion *smram =
>          (MemoryRegion *) object_resolve_path("/machine/smram", NULL);
>  
> @@ -2728,6 +2729,10 @@ static void register_smram_listener(Notifier *n, void *unused)
>      address_space_init(&smram_address_space, &smram_as_root, "KVM-SMRAM");
>      kvm_memory_listener_register(kvm_state, &smram_listener,
>                                   &smram_address_space, 1, "kvm-smram");
> +
> +    CPU_FOREACH(cpu) {
> +        cpu_address_space_init(cpu, 1, "cpu-smm", &smram_as_root);

It is worth mentioning in the commit message that directly sharing
MemoryRegion in CPUAddressSpace is safe.

> +    }

I still think such CPU_FOREACH in machine_done callback is not the
best approach - it's better to initialize all the address spaces in
kvm_cpu_realizefn(), and not to go far away from cs->num_ases, as I
said in the previous discussion.

But it's still good to fix this bug. So, with other comments
addressed,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


