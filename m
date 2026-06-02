Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B72CD6E69
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUXDE-0007a1-TB; Tue, 02 Jun 2026 18:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUXDD-0007ZY-1t
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 18:03:51 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUXDB-00074C-1N
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 18:03:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cD8n93C7wnzy/sCW1qmw95Q/gjdiYRHRJor7sR7r0ypchNYwSoPs48HaCYJLqB45YUR74T++W1I6kvdAv5Y1HaidI76XufH6VQNvsz/O3IyWpCIKer3X9KzcMlygSC0tYL4ZK5ymSdxqyfYDbCeDTcrnOkZYauFPoCDHNQMOPt1BSlewz6i1Tkv+Xl+0YEJSbVf7/lO1ESDSR9TK9zbPLo3OyThOWVzWznEeWzRwUmelWhb4ibqhKxSH5aBNSMUxt+YBJZza87J768bLdAjvaY9SLaIgTcx+ov11UGrelxhZkf/gqThV4af+mb9sDxeE+Ek2AaBvpJHntMQ3lervfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGTuIz9r4X8oveCa3kFD4mGS1W3USwYMfSDEIcQTY5E=;
 b=W7mGY6T5PWmRWvICapCZggcX7vfm4MFAti22ImUdhp5MPgL+eza8yNK9M88IewYA5atMKWjVoMTjETWTDSP5peAqfry6QcBRKGhr/DSFiKaB99oG4S80V0zewKrqf9G07dZeqiNSf77solVVhtWqJQKeHF+GmfBZnxRNbHCdkfJHy6DIbIK+8/7vdv7A63f7j50ax4lFP4KF+FGK4YAk+dKyHMcXcCAkxqTAqhwgmi3Tlm5IFfEgeZKjfUXCaF2ZaxSIJ5QVpZmsOUCHDNNFV1s9gqxnrYA9H9lGW4ndY1I4+i2/vu2egaaFeX4GOnvbkz/E6ibgci+Nciwv0u67Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGTuIz9r4X8oveCa3kFD4mGS1W3USwYMfSDEIcQTY5E=;
 b=LHL4uF336CLDCWO28EoG1TBnJaEwjjDF8Uz16yM1akT/hRS5eSv6SH3t7nwlm+ScHA26DGodtZEYkGG6hCO/Id9bKamDgZBzUrAgquuBaV8DgCGYJgWzevlLNe8UBicU0vdhhedASmRndVqaeBVfNkd7ehjLdjerAN/VEYnx8H8=
Received: from PH7P221CA0048.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::8)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 22:03:44 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:33c::4) by PH7P221CA0048.outlook.office365.com
 (2603:10b6:510:33c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 22:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 22:03:44 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 17:03:44 -0500
Date: Tue, 2 Jun 2026 16:46:10 -0500
From: Michael Roth <michael.roth@amd.com>
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, Juraj Marcin <jmarcin@redhat.com>, "David
 Hildenbrand" <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Chenyi
 Qiang" <chenyi.qiang@intel.com>, Fabiano Rosas <farosas@suse.de>, "Alexey
 Kardashevskiy" <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 09/12] machine: Rename machine_require_guest_memfd()
 to *_private()
Message-ID: <pvi4zsmelmnf3wn4nrqi3skacpzsfz4jealle6ckm2hgpbvme2@2ujsct4jabj6>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-10-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251215205203.1185099-10-peterx@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: fa78b6c4-9667-48ed-c607-08dec0f2d06a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099006|4143699003|11063799006|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 2rK/jBqkD70gCTFu4xGqdOeiK+idLFjZYzOgFdg4x1sUMKDDMAoYGVWK+tYqxuFQA+E0aBC6z7Btdntlk2q4sv28dj3tUD+uG0SWUTqTRYZ+MJK03fk5uuSYVh1xW5c4IA7lmu+ghWOI8aNGPB92q48GF6rrT3FKIhAt13kbmrSZKEbX60tEq6SdQ91sv4ZZA/mK5H4s4KlkKVjn2apbWs8LcrPSbGV+441kLQ8jkyOSxeNclAdqi3GclpVYX4WX7dt0/NqWXjFzijXoAM4tI9RrWZ5udBmvbCrLJHjbkkJl2rreSYw36+3o8unEF1cGOG/1T6ME1B5QqIvdpgpzRuG27bBo1jUZvYGtmQpGC8/SafOxqewOHgfUsXQAhhySJifvBwV2jIm/hVYNlCh3senZTqIyvugTJ6dfMFQYPjGog1IiqVg66lBWdO4t6z1Vq6i2AQMepgqA79bgnA6VjUhLenSOYYIoIQ3olFnbaCFSQGqu0DYy8gLC16fryT/3dBRIRlWmoMfRBZotksXBLG8FQdzUxhn3SM2kcK8d/PWYd6SjXcLlH6VDJMQgDkNNaNiMYo0jTNYVv96IOAk4PE27AeZT/cFN9a3nnjYmdTp5TaEvAv3FVanOzGHJaFgfIwDJqRbd+X3ofWwrtROyyB3V1XtWDoX/IT2EzHa7vJSmMoHpYn5Khbsy0cxKSkGGbFfBUX1NgKubu0mWsAzzclyXImQysgqorJKqg0xJ5c0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099006)(4143699003)(11063799006)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y7R8WKsIAHCgV6X5adLtZf4Xzyf12hIu0+kRxNGy4cgNMACs6E2A7pJLQSVsXMZLSPXNvHIrisPlvaAe7NPJGHewvTPpqg8nvq8dxC9eKGWC95Nkm2sVD1mCkyIrwvKii/Tk2CeCJE0kXEGGH0uFBrOlL/ejv7KbgvfJEnLWUmwLRiNv9KxVaavHpTJqytxkEb99JuMHRjUZF2JuxKoyjWVDXIGwO7WRfRHNGIYiiMitAantdbXFH7VcAKzblf7G78MIvM06TFrByrXS7jP8pR8D9f2IyM+lf3q99TqQvC1nbrY3wYPa5EJYUM0CIFDNYJrLsqR/S5ii0UBKzpqVpwoZNZ4KXInMZ0hxLlDBslRhREyBdvNFng3ISf8GFq+cPcUCVCTlzflO0DbOIhkeKJkUChCgIWeVFAZHkvE1hKT42tr5WbZeDNcLcE7gW3AH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 22:03:44.3822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa78b6c4-9667-48ed-c607-08dec0f2d06a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=Michael.Roth@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 15, 2025 at 03:52:00PM -0500, Peter Xu wrote:
> Differenciate it from fully shared guest-memfd use cases.
> 
> When at it, add proper brackets in kvm_handle_hc_map_gpa_range() otherwise
> checkpatch may complain.
> 
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

> ---
>  include/hw/boards.h   | 2 +-
>  backends/hostmem.c    | 2 +-
>  hw/core/machine.c     | 2 +-
>  hw/i386/pc.c          | 2 +-
>  hw/i386/pc_sysfw.c    | 4 ++--
>  hw/i386/x86-common.c  | 4 ++--
>  target/i386/kvm/kvm.c | 3 ++-
>  7 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index a48ed4f86a..3a0a051d19 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -42,7 +42,7 @@ bool machine_usb(MachineState *machine);
>  int machine_phandle_start(MachineState *machine);
>  bool machine_dump_guest_core(MachineState *machine);
>  bool machine_mem_merge(MachineState *machine);
> -bool machine_require_guest_memfd(MachineState *machine);
> +bool machine_require_guest_memfd_private(MachineState *machine);
>  HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine);
>  void machine_set_cpu_numa_node(MachineState *machine,
>                                 const CpuInstanceProperties *props,
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index 70450733db..e2dcae50c4 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -288,7 +288,7 @@ static void host_memory_backend_init(Object *obj)
>      /* TODO: convert access to globals to compat properties */
>      backend->merge = machine_mem_merge(machine);
>      backend->dump = machine_dump_guest_core(machine);
> -    backend->guest_memfd_private = machine_require_guest_memfd(machine);
> +    backend->guest_memfd_private = machine_require_guest_memfd_private(machine);
>      backend->reserve = true;
>      backend->prealloc_threads = machine->smp.cpus;
>  }
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 27372bb01e..3bdce197f7 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1376,7 +1376,7 @@ bool machine_mem_merge(MachineState *machine)
>      return machine->mem_merge;
>  }
>  
> -bool machine_require_guest_memfd(MachineState *machine)
> +bool machine_require_guest_memfd_private(MachineState *machine)
>  {
>      return machine->cgs && machine->cgs->require_guest_memfd;
>  }
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f8b919cb6c..b2d55ceb5e 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -962,7 +962,7 @@ void pc_memory_init(PCMachineState *pcms,
>  
>      if (!is_tdx_vm()) {
>          option_rom_mr = g_malloc(sizeof(*option_rom_mr));
> -        if (machine_require_guest_memfd(machine)) {
> +        if (machine_require_guest_memfd_private(machine)) {
>              memory_region_init_ram_guest_memfd(option_rom_mr, NULL, "pc.rom",
>                                              PC_ROM_SIZE, &error_fatal);
>          } else {
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 1a12b635ad..1c37258654 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -52,7 +52,7 @@ static void pc_isa_bios_init(PCMachineState *pcms, MemoryRegion *isa_bios,
>  
>      /* map the last 128KB of the BIOS in ISA space */
>      isa_bios_size = MIN(flash_size, 128 * KiB);
> -    if (machine_require_guest_memfd(MACHINE(pcms))) {
> +    if (machine_require_guest_memfd_private(MACHINE(pcms))) {
>          memory_region_init_ram_guest_memfd(isa_bios, NULL, "isa-bios",
>                                             isa_bios_size, &error_fatal);
>      } else {
> @@ -71,7 +71,7 @@ static void pc_isa_bios_init(PCMachineState *pcms, MemoryRegion *isa_bios,
>             ((uint8_t*)flash_ptr) + (flash_size - isa_bios_size),
>             isa_bios_size);
>  
> -    if (!machine_require_guest_memfd(current_machine)) {
> +    if (!machine_require_guest_memfd_private(current_machine)) {
>          memory_region_set_readonly(isa_bios, true);
>      }
>  }
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index c844749900..33ac7fb6e9 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -1044,7 +1044,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
>          (bios_size % 65536) != 0) {
>          goto bios_error;
>      }
> -    if (machine_require_guest_memfd(MACHINE(x86ms))) {
> +    if (machine_require_guest_memfd_private(MACHINE(x86ms))) {
>          memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
>                                             bios_size, &error_fatal);
>          if (is_tdx_vm()) {
> @@ -1074,7 +1074,7 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
>      }
>      g_free(filename);
>  
> -    if (!machine_require_guest_memfd(MACHINE(x86ms))) {
> +    if (!machine_require_guest_memfd_private(MACHINE(x86ms))) {
>          /* map the last 128KB of the BIOS in ISA space */
>          x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
>                            !isapc_ram_fw);
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 60c7981138..5d0d02bcaf 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -6050,8 +6050,9 @@ static int kvm_handle_hc_map_gpa_range(X86CPU *cpu, struct kvm_run *run)
>      uint64_t gpa, size, attributes;
>      int ret;
>  
> -    if (!machine_require_guest_memfd(current_machine))
> +    if (!machine_require_guest_memfd_private(current_machine)) {
>          return -EINVAL;
> +    }
>  
>      gpa = run->hypercall.args[0];
>      size = run->hypercall.args[1] * TARGET_PAGE_SIZE;
> -- 
> 2.50.1
> 
> 

