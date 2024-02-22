Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D02C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5eO-000746-HU; Thu, 22 Feb 2024 04:45:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rd5eN-00071r-3P; Thu, 22 Feb 2024 04:45:55 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rd5e9-0005ap-0G; Thu, 22 Feb 2024 04:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708595141; x=1740131141;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ygelKKtftfpkZ77QNd+mRGBqXa2fzaaVubxUabmKpZs=;
 b=m5yDDw//eeQNPmF2Z6ZQlxGsqpuBmsSbY66xksRxe7JgA+Xjr7wgnaW1
 Zi2+7+GIbAznes+PJDkHa6bnSsU5lMyJ4Vy3mDzzmjYmUz7zf7gxXH6VG
 7BEsVA6AUSeaymSZvpV95GesTU4v0xt+E+4/Aet7tguXF00LnepO6kvsE
 1hncmAFYvHpdVKG+QaEp2k8LLJRlzYfW1nNaNv9JqC3z3sQh4rF0HDjm1
 WLYycR/exQD+ItV1S/+bij8oLY5thwhuiMOdoko62GI5u8XwTA7nYUqct
 dser+ZAemg2ErJPg3qxiRL6pu01nBnI682uXun5IX1t+xmEx7nnh9IhPl w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13506989"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; d="scan'208";a="13506989"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2024 01:45:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; d="scan'208";a="10022376"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 22 Feb 2024 01:45:25 -0800
Date: Thu, 22 Feb 2024 17:59:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH 21/21] hw: Add QOM parentship relation with CPUs
Message-ID: <Zdca6ZYOzgSXIlpr@intel.com>
References: <20240216110313.17039-1-philmd@linaro.org>
 <20240216110313.17039-22-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216110313.17039-22-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 16, 2024 at 12:03:12PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Fri, 16 Feb 2024 12:03:12 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 21/21] hw: Add QOM parentship relation with CPUs
> X-Mailer: git-send-email 2.41.0
> 
> QDev objects created with object_new() need to manually add
> their parent relationship with object_property_add_child().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/i386/x86.c                            | 1 +
>  hw/microblaze/petalogix_ml605_mmu.c      | 1 +
>  hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 +
>  hw/mips/cps.c                            | 1 +
>  hw/nios2/10m50_devboard.c                | 1 +
>  hw/ppc/e500.c                            | 1 +
>  hw/ppc/spapr.c                           | 1 +
>  7 files changed, 7 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 684dce90e9..7021419d91 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -102,6 +102,7 @@ void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
>      if (!object_property_set_uint(cpu, "apic-id", apic_id, errp)) {
>          goto out;
>      }
> +    object_property_add_child(OBJECT(x86ms), "cpu[*]", OBJECT(cpu));
>      qdev_realize(DEVICE(cpu), NULL, errp);
>  
>  out:
> diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
> index 0f5fabc32e..dfd881322d 100644
> --- a/hw/microblaze/petalogix_ml605_mmu.c
> +++ b/hw/microblaze/petalogix_ml605_mmu.c
> @@ -83,6 +83,7 @@ petalogix_ml605_init(MachineState *machine)
>  
>      /* init CPUs */
>      cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
> +    object_property_add_child(OBJECT(machine), "cpu", OBJECT(cpu));
>      object_property_set_str(OBJECT(cpu), "version", "8.10.a", &error_abort);
>      /* Use FPU but don't use floating point conversion and square
>       * root instructions
> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> index dad46bd7f9..255d8d4d47 100644
> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> @@ -70,6 +70,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>      MemoryRegion *sysmem = get_system_memory();
>  
>      cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
> +    object_property_add_child(OBJECT(machine), "cpu", OBJECT(cpu));
>      object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
>      qdev_realize(DEVICE(cpu), NULL, &error_abort);
>  
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index 07b73b0a1f..6b4e918807 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -84,6 +84,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
>          /* All cores use the same clock tree */
>          qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->clock);
>  
> +        object_property_add_child(OBJECT(dev), "cpu[*]", OBJECT(cpu));
>          if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
>              return;
>          }
> diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
> index 6cb32f777b..f6a691d340 100644
> --- a/hw/nios2/10m50_devboard.c
> +++ b/hw/nios2/10m50_devboard.c
> @@ -95,6 +95,7 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
>      cpu->exception_addr = 0xc8000120;
>      cpu->fast_tlb_miss_addr = 0xc0000100;
>  
> +    object_property_add_child(OBJECT(machine), "cpu", OBJECT(cpu));
>      qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
>  
>      if (nms->vic) {
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 3bd12b54ab..77b7d2858c 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -956,6 +956,7 @@ void ppce500_init(MachineState *machine)
>           */
>          object_property_set_bool(OBJECT(cs), "start-powered-off", i != 0,
>                                   &error_abort);
> +        object_property_add_child(OBJECT(machine), "cpu[*]", OBJECT(cpu));
>          qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
>  
>          if (!firstenv) {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0d72d286d8..b6e5caa0d2 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2715,6 +2715,7 @@ static void spapr_init_cpus(SpaprMachineState *spapr)
>                                      &error_fatal);
>              object_property_set_int(core, CPU_CORE_PROP_CORE_ID, core_id,
>                                      &error_fatal);
> +            object_property_add_child(OBJECT(spapr), "cpu[*]", OBJECT(core));
>              qdev_realize(DEVICE(core), NULL, &error_fatal);
>  
>              object_unref(core);
> -- 
> 2.41.0
> 
> 

