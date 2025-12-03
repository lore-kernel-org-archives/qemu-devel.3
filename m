Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D02D12D75
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQoZP-0000xj-BT; Wed, 03 Dec 2025 10:15:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQoZK-0000x6-TQ; Wed, 03 Dec 2025 10:15:02 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQoZI-0003Bu-PW; Wed, 03 Dec 2025 10:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764774900; x=1796310900;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Dhw8fv3CIwT8oGsLVbK4XVzTRdwtyRhTvyp06Yg14dA=;
 b=SbriqtujuZDnwZr6gV4vwJdpD7xaXc/+z3LDa0fJKr7H60r6jsMeome6
 DBv38oNGzKA2+4cWzfl83hIcE6oBbFP+Nre2DKcpEyuzyx+yGlgJ7YmgB
 82ojAZAGjfwFr/gKXH4kMxf3mpGHPOSanbEFFjIx9JWutnnAEva7lOCBk
 HlPcIcIx8dvI+EHS7Udvm1akwG4jJK/e/MvXRQ+8TNJSKCmegLHFHAg2F
 iBC3HjBlH0tkykGFqPMfq2jok3Vcx+y1Kh8kBsrn6FHeqsMU8HL8MGRLm
 CGWhweUEMtWCjW9MSYBittfuelebhZLE1eE2wIwEBV4pKJGqK6XuRrcZd A==;
X-CSE-ConnectionGUID: wn9WRBBLTvOMIOAE3t+Zgw==
X-CSE-MsgGUID: DM7gEMfARliJBjmUe35slA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="70622268"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; d="scan'208";a="70622268"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2025 07:14:54 -0800
X-CSE-ConnectionGUID: FbgYcUlHT/CNn3V4JacTMw==
X-CSE-MsgGUID: eGvCaaZqT0m05lj1Gtzkqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; d="scan'208";a="199176729"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 03 Dec 2025 07:14:51 -0800
Date: Wed, 3 Dec 2025 23:39:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH-for-11.0 v6 05/13] hw/nvram/fw_cfg: Propagate I/O
 MemoryRegion to fw_cfg_init_io_dma()
Message-ID: <aTBZtv7SHRUGbidV@intel.com>
References: <20251203060942.57851-1-philmd@linaro.org>
 <20251203060942.57851-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251203060942.57851-6-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Dec 03, 2025 at 07:09:33AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed,  3 Dec 2025 07:09:33 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-11.0 v6 05/13] hw/nvram/fw_cfg: Propagate I/O
>  MemoryRegion to fw_cfg_init_io_dma()
> X-Mailer: git-send-email 2.51.0
> 
> To allow callers to use I/O MemoryRegion different than the
> global get_system_io(), pass it as argument.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/nvram/fw_cfg.h | 4 ++--
>  hw/i386/fw_cfg.c          | 3 ++-
>  hw/i386/microvm.c         | 3 ++-
>  hw/i386/pc.c              | 3 ++-
>  hw/nvram/fw_cfg.c         | 5 ++---
>  5 files changed, 10 insertions(+), 8 deletions(-)

...

> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 94d22a232ac..69f04d74a15 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -289,6 +289,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
>      X86MachineState *x86ms = X86_MACHINE(mms);
>      MemoryRegion *ram_below_4g, *ram_above_4g;
>      MemoryRegion *system_memory = get_system_memory();
> +    MemoryRegion *io_memory = get_system_io();
>      FWCfgState *fw_cfg;
>      ram_addr_t lowmem = 0xc0000000; /* 3G */
>      int i;
> @@ -319,7 +320,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
>          e820_add_entry(0x100000000ULL, x86ms->above_4g_mem_size, E820_RAM);
>      }
>  
> -    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,
> +    fw_cfg = fw_cfg_init_io_dma(io_memory, FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,

It seems here we can use get_system_io() directly :).

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

>                                  &address_space_memory);
>  
>      fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, machine->smp.cpus);

