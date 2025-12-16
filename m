Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673DDD5B87C
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 06:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVOye-0007ty-NH; Tue, 16 Dec 2025 01:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vVOyd-0007tq-Q2
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 01:56:07 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vVOyb-0006rq-Vk
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 01:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765868166; x=1797404166;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=EtPPjUb5jk3N+ko7p9eJ+9XS5xi3923htr01zsrsydA=;
 b=BWIjr6C1M3LctKGhhwqj+rOSQxPukR8uggBY1geHFCoS/6BTZ/OzWbVV
 xzazjcdk2T3S/P6gDBAZFpFPXptfLUsXMdNRRu3OPzj++03NdX8cXY/j6
 r2YjUAP1T8Muo658pc7CVP2E2IzmwLtol28SXXbtKwAcsPMn7SNgSikQx
 wvbrjnVQ8IZbVf4TMW+TGgASWeNQQQchQtFrSLObGt4dr+sMTXcxyPoV0
 en/uld9trP18jj1UnNendSthypTx5I0bZc+HuwzTp4exIZ9F3mBPAAokS
 K5nbHLsZINGfyMEEaH3ynRAXINViFYJUo+9Fpagk9zGzP1Vs8qd63z6U/ g==;
X-CSE-ConnectionGUID: yyYk7HzrT3+M7BB40MsnPw==
X-CSE-MsgGUID: 843iVXCcSc6To/21qqgo+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67661983"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="67661983"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 22:56:02 -0800
X-CSE-ConnectionGUID: qQNwqRYMShilwPG/mcmJsQ==
X-CSE-MsgGUID: c57JB1e4RwCcMiDxHkSFJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="235338321"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.173])
 ([10.124.240.173])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 22:56:00 -0800
Message-ID: <4616e61e-fd49-4e94-aa03-93bdfb457a87@intel.com>
Date: Tue, 16 Dec 2025 14:55:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] machine: Rename machine_require_guest_memfd() to
 *_private()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Alexey Kardashevskiy <aik@amd.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-10-peterx@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251215205203.1185099-10-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.17; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 12/16/2025 4:52 AM, Peter Xu wrote:
> Differenciate it from fully shared guest-memfd use cases.
> 
> When at it, add proper brackets in kvm_handle_hc_map_gpa_range() otherwise
> checkpatch may complain.
> 
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   include/hw/boards.h   | 2 +-
>   backends/hostmem.c    | 2 +-
>   hw/core/machine.c     | 2 +-
>   hw/i386/pc.c          | 2 +-
>   hw/i386/pc_sysfw.c    | 4 ++--
>   hw/i386/x86-common.c  | 4 ++--
>   target/i386/kvm/kvm.c | 3 ++-
>   7 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index a48ed4f86a..3a0a051d19 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -42,7 +42,7 @@ bool machine_usb(MachineState *machine);
>   int machine_phandle_start(MachineState *machine);
>   bool machine_dump_guest_core(MachineState *machine);
>   bool machine_mem_merge(MachineState *machine);
> -bool machine_require_guest_memfd(MachineState *machine);
> +bool machine_require_guest_memfd_private(MachineState *machine);
>   HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine);
>   void machine_set_cpu_numa_node(MachineState *machine,
>                                  const CpuInstanceProperties *props,
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 70450733db..e2dcae50c4 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -288,7 +288,7 @@ static void host_memory_backend_init(Object *obj)
>       /* TODO: convert access to globals to compat properties */
>       backend->merge = machine_mem_merge(machine);
>       backend->dump = machine_dump_guest_core(machine);
> -    backend->guest_memfd_private = machine_require_guest_memfd(machine);
> +    backend->guest_memfd_private = machine_require_guest_memfd_private(machine);
>       backend->reserve = true;
>       backend->prealloc_threads = machine->smp.cpus;
>   }
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 27372bb01e..3bdce197f7 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1376,7 +1376,7 @@ bool machine_mem_merge(MachineState *machine)
>       return machine->mem_merge;
>   }
>   
> -bool machine_require_guest_memfd(MachineState *machine)
> +bool machine_require_guest_memfd_private(MachineState *machine)
>   {
>       return machine->cgs && machine->cgs->require_guest_memfd;
>   }
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f8b919cb6c..b2d55ceb5e 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -962,7 +962,7 @@ void pc_memory_init(PCMachineState *pcms,
>   
>       if (!is_tdx_vm()) {
>           option_rom_mr = g_malloc(sizeof(*option_rom_mr));
> -        if (machine_require_guest_memfd(machine)) {
> +        if (machine_require_guest_memfd_private(machine)) {
>               memory_region_init_ram_guest_memfd(option_rom_mr, NULL, "pc.rom",
>                                               PC_ROM_SIZE, &error_fatal);
>           } else {
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 1a12b635ad..1c37258654 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -52,7 +52,7 @@ static void pc_isa_bios_init(PCMachineState *pcms, MemoryRegion *isa_bios,
>   
>       /* map the last 128KB of the BIOS in ISA space */
>       isa_bios_size = MIN(flash_size, 128 * KiB);
> -    if (machine_require_guest_memfd(MACHINE(pcms))) {
> +    if (machine_require_guest_memfd_private(MACHINE(pcms))) {
>           memory_region_init_ram_guest_memfd(isa_bios, NULL, "isa-bios",
>                                              isa_bios_size, &error_fatal);
>       } else {
> @@ -71,7 +71,7 @@ static void pc_isa_bios_init(PCMachineState *pcms, MemoryRegion *isa_bios,
>              ((uint8_t*)flash_ptr) + (flash_size - isa_bios_size),
>              isa_bios_size);
>   
> -    if (!machine_require_guest_memfd(current_machine)) {
> +    if (!machine_require_guest_memfd_private(current_machine)) {
>           memory_region_set_readonly(isa_bios, true);
>       }
>   }
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index c844749900..33ac7fb6e9 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -1044,7 +1044,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
>           (bios_size % 65536) != 0) {
>           goto bios_error;
>       }
> -    if (machine_require_guest_memfd(MACHINE(x86ms))) {
> +    if (machine_require_guest_memfd_private(MACHINE(x86ms))) {
>           memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
>                                              bios_size, &error_fatal);
>           if (is_tdx_vm()) {
> @@ -1074,7 +1074,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
>       }
>       g_free(filename);
>   
> -    if (!machine_require_guest_memfd(MACHINE(x86ms))) {
> +    if (!machine_require_guest_memfd_private(MACHINE(x86ms))) {
>           /* map the last 128KB of the BIOS in ISA space */
>           x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
>                             !isapc_ram_fw);
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 60c7981138..5d0d02bcaf 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -6050,8 +6050,9 @@ static int kvm_handle_hc_map_gpa_range(X86CPU *cpu, struct kvm_run *run)
>       uint64_t gpa, size, attributes;
>       int ret;
>   
> -    if (!machine_require_guest_memfd(current_machine))
> +    if (!machine_require_guest_memfd_private(current_machine)) {
>           return -EINVAL;
> +    }
>   
>       gpa = run->hypercall.args[0];
>       size = run->hypercall.args[1] * TARGET_PAGE_SIZE;


