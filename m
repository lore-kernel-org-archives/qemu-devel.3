Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D675CD6E5D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUXDb-0008Ca-9G; Tue, 02 Jun 2026 18:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUXDa-00083s-12
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 18:04:14 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUXDX-00076r-7d
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 18:04:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=js+ioKI6SmzsVc1W1Uvql9Qg/S1NddF6aLlepfYMl/2DWft4GF/xVc1QpJKh0UUaJ9xB3RrdDY6ytEn9hHg7zovhAe3DbKn6gAmm96XS3K/WQpnf8kbk7NUZjvwHAyrOE6LPxW7N7WPjmm/BDrQcdG1HCJPY0dwpjl210tt4bbj8qzbHjYw9Twa+Di6WLDdi0aEojkdTm7E4izqx+wxgXkZWHTZcw+R7WplU634FFDwxaR33Y4aaH6mizBy7YgcCPchJcgutq813Of5XyANWN1l9lwott4NGMcRMR+bDWJNknzWHwQrWcFLyK+V1dPtFEaPbgCRo/hsQSx0uOqHYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtZMlTJ3oCnYklgro0fmdMADSxSBaG6l9/ojDHHhTIo=;
 b=jDH5gjtKrOHbqRXl/bIz3Es32008aopwHnA9hTAkC7o3nMBzNj6BvnmxXcabkC0GxaHYTf9cKzsR8+px6A+vEQINI6mCs58OT+o+G44rg2wZQQUW2oyWG943j/X9VrkwreYtPB7qyKm+dO3cqfpIUClETq6HCU1/n4LzxSZScL7aAmBMfMV1mkm8cGA3JN0aD6PqDghLoajKJGgL3hPWw68qkVqQney8h0t75Bapjh00SoSvNM1ZKagSAdVMTGOf2yRqKVsyWNQ04fRZ0N2jFFVvB5pDl8xVeCAxCZGyJ5QHiuNvlhkzbHMZ0onpsQr60j4ouYUAqWxpXfZYTlJbGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtZMlTJ3oCnYklgro0fmdMADSxSBaG6l9/ojDHHhTIo=;
 b=ja/3LW8R9qGOI+XiC9e91ytwgexfxU2rIrH0NOcbrjERe9boDu0ZyBZIhWNZ79BjgI7Mg3loOZOoPLBhYX6a9rKVTrwJxh2zN39ovmHBCZiKLSrtcXvDVxrR3Fv2+SmkQOi7yWfk6neZkKKaE29HTYPxBebNY//FFj/C7AEN5lA=
Received: from PH5P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::14)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 22:04:05 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:510:34b:cafe::a4) by PH5P222CA0009.outlook.office365.com
 (2603:10b6:510:34b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 22:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 22:04:04 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 17:04:04 -0500
Date: Tue, 2 Jun 2026 16:49:16 -0500
From: Michael Roth <michael.roth@amd.com>
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, Juraj Marcin <jmarcin@redhat.com>, "David
 Hildenbrand" <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Chenyi
 Qiang" <chenyi.qiang@intel.com>, Fabiano Rosas <farosas@suse.de>, "Alexey
 Kardashevskiy" <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 10/12] memory: Rename
 memory_region_init_ram_guest_memfd() to *_private()
Message-ID: <nj7a4wqakvofse6sk657m3nb6ayryksmv3drdfs6ei4vhph4iz@cuvvxmyzt6ww>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-11-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251215205203.1185099-11-peterx@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: 6668e1f9-ee6d-41df-5eeb-08dec0f2dca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: FsPivLKMqr6sKIjCnrdVc0uD8REEUFcAMSuCNgdaD9ClYwIiETGA5LczM+i5sZ0WysFAAhRUiF9JNjT9dJKi8yIOVWfwiaEbMuNCfzpHaNHeJoap61NpDckNLx+8/0ri0BKzeWS4qrPPdU75C8rAD4yr3HpTnQs+XdvoXBYy0iHdRMizKkVZOqLHYMOKW6aNkWpnRm5mwo8NoIeww17yPFM5W7WQWaSJeJ1xya+7OFIOt3SLgrE5MQ9OnfpgE2yNFBKkgnd/WMOfPkesg1qMdMGOdoasxrlCkFp0eBOkvOM8TiFsCxM+D9XVDUGaO3/GlBv1T7muEJiXx7kzuoNH9cDKL35RSocK2313o3U89pfHPm6M0g5DhLGnbSc7MCrpfEwyJnonoX5sq3prVYTQgCYSS6dgE8/XADGSnEgf8XVGWbND2dPzU4KQlF1ScP9IGchYt1YhPdMeIxRy4rxALlvZoizaEaP8kkoyxie2goNzy8weMwlFxwVWfrzniOno64XwhrbbPqj61c6vgS4tlGU+Mx6zxP4inaSj9ixnjdZGIQQXG1IztVieLH1yyMaWiWtIWbu1MjxU2WrjoTIImvSQyRh5zMQG8vq8DeRxfSqUu81NSrmh8mxIEuwfyGB6yIdkM/477kHUXoEPAFJ9X0IhfT89Pu1PP290diwlyPnnEgMfvGVyr9qtU24usj4u9Fwy0pBLv2SxGiX7XZtijy/2kOchLYQWz8aCF56mkB0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6i1IhxhMe3a9V5Likwij1iYSyiIGYdB9Mm1Gy5NvdaVdpXxbKu2KpBzAYp+MdOdK5FyATxAT5ZVOvIN2POxAWhLQeE90dcDYAYlDOUSRbFSNudqnWqdEZHIsf0tH1v2pZ/CgsczDT440bRNngVIG9JUWkWqsO05/mgP2Tu0rUbEjpUk/GmHGxFiqTXuab5ut97DmIyzwZt0CSH0gJSqjDlHkRkv2rekg5ua8kRcSmsyGb6pMowVO7Wfe/obDEdXtUbnFaGl69uN98f6vJJIAi3kzhG8Qi1r3FLVpTJUqHhbhdmqMxRIHwIwELq5JVkRYiuiMEkgNRxbst5RPyxZmcA59ZZRB7hXArx2SUKPWVwvcz+25h0Qk4qbbbU+1e9VEmaQ6KhzzDYlTS2D9FqTDGTbWqIrAw7mCpoAXXwV/YCHZwO9Rx1GXXQqNK66/jfCU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 22:04:04.9000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6668e1f9-ee6d-41df-5eeb-08dec0f2dca9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Dec 15, 2025 at 03:52:01PM -0500, Peter Xu wrote:
> Differenciate it from fully shared guest-memfd use cases.
> 
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

> ---
>  include/system/memory.h | 10 +++++-----
>  backends/igvm.c         |  4 ++--
>  hw/i386/pc.c            |  4 ++--
>  hw/i386/pc_sysfw.c      |  4 ++--
>  hw/i386/x86-common.c    |  4 ++--
>  system/memory.c         | 10 +++++-----
>  6 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 9b58303bb8..b3d000a563 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -1693,11 +1693,11 @@ bool memory_region_init_ram(MemoryRegion *mr,
>                              uint64_t size,
>                              Error **errp);
>  
> -bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
> -                                        Object *owner,
> -                                        const char *name,
> -                                        uint64_t size,
> -                                        Error **errp);
> +bool memory_region_init_ram_guest_memfd_private(MemoryRegion *mr,
> +                                                Object *owner,
> +                                                const char *name,
> +                                                uint64_t size,
> +                                                Error **errp);
>  
>  /**
>   * memory_region_init_rom: Initialize a ROM memory region.
> diff --git a/backends/igvm.c b/backends/igvm.c
> index 905bd8d989..91631829e5 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -221,8 +221,8 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
>              g_strdup_printf("igvm.%X", region_identifier);
>          igvm_pages = g_new0(MemoryRegion, 1);
>          if (ctx->cgs && ctx->cgs->require_guest_memfd) {
> -            if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
> -                                                    region_name, size, errp)) {
> +            if (!memory_region_init_ram_guest_memfd_private(
> +                    igvm_pages, NULL, region_name, size, errp)) {
>                  return NULL;
>              }
>          } else {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index b2d55ceb5e..41dfbbdcf0 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -963,8 +963,8 @@ void pc_memory_init(PCMachineState *pcms,
>      if (!is_tdx_vm()) {
>          option_rom_mr = g_malloc(sizeof(*option_rom_mr));
>          if (machine_require_guest_memfd_private(machine)) {
> -            memory_region_init_ram_guest_memfd(option_rom_mr, NULL, "pc.rom",
> -                                            PC_ROM_SIZE, &error_fatal);
> +            memory_region_init_ram_guest_memfd_private(
> +                option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE, &error_fatal);
>          } else {
>              memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
>                                  &error_fatal);
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 1c37258654..ad55d4eba6 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -53,8 +53,8 @@ static void pc_isa_bios_init(PCMachineState *pcms, MemoryRegion *isa_bios,
>      /* map the last 128KB of the BIOS in ISA space */
>      isa_bios_size = MIN(flash_size, 128 * KiB);
>      if (machine_require_guest_memfd_private(MACHINE(pcms))) {
> -        memory_region_init_ram_guest_memfd(isa_bios, NULL, "isa-bios",
> -                                           isa_bios_size, &error_fatal);
> +        memory_region_init_ram_guest_memfd_private(
> +            isa_bios, NULL, "isa-bios", isa_bios_size, &error_fatal);
>      } else {
>          memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
>                                 &error_fatal);
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index 33ac7fb6e9..27854a9164 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -1045,8 +1045,8 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
>          goto bios_error;
>      }
>      if (machine_require_guest_memfd_private(MACHINE(x86ms))) {
> -        memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
> -                                           bios_size, &error_fatal);
> +        memory_region_init_ram_guest_memfd_private(
> +            &x86ms->bios, NULL, "pc.bios", bios_size, &error_fatal);
>          if (is_tdx_vm()) {
>              tdx_set_tdvf_region(&x86ms->bios);
>          }
> diff --git a/system/memory.c b/system/memory.c
> index d70968c966..28810dcb29 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -3746,11 +3746,11 @@ bool memory_region_init_ram(MemoryRegion *mr,
>      return true;
>  }
>  
> -bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
> -                                        Object *owner,
> -                                        const char *name,
> -                                        uint64_t size,
> -                                        Error **errp)
> +bool memory_region_init_ram_guest_memfd_private(MemoryRegion *mr,
> +                                                Object *owner,
> +                                                const char *name,
> +                                                uint64_t size,
> +                                                Error **errp)
>  {
>      DeviceState *owner_dev;
>  
> -- 
> 2.50.1
> 
> 

