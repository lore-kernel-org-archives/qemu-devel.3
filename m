Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B661C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 08:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFTnp-0006Yv-Jj; Thu, 15 May 2025 04:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uFTmx-0004UN-90; Thu, 15 May 2025 04:17:59 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uFTmt-0002J6-AU; Thu, 15 May 2025 04:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747297076; x=1778833076;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=J0d7qIZ0wAM9NtgBW44TtLkYeQrux0sEamdBuRSRMrc=;
 b=c/VW0JvykPdwzRGwubb/0nxsvznsD33wzeDXiAM8x+ElVT/VquuRrj3M
 BDT6m4pk8SOuK7wvDP+pkGHvG2URz/dhiOuUE/HcIx+ZjiRQMm6O+zuKH
 GKX7iVTKnvXvRD18QzQqrp/l+WZIxHp0phlB79lO+tMKnLLmgQLG37kKO
 fovOgg2axRi/aphjotvZLULBSSJrGgYHmXf76OA14Txy9xMn5sI2ZxE0t
 kL2G9IkoRZaXCUqzujOw5df5mygH6NIT1tQ4BwOr4TDUp3TUJZpfkAPw9
 z+7ZOFdSWAPYkD5NET5omo5teRq1XJn/VznCm+JsZZo1shBWahh2mNSMI A==;
X-CSE-ConnectionGUID: fVcagOJGTyKnc0nqajqjwg==
X-CSE-MsgGUID: joYNj3EFQNy8mpRwqhKQVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49089798"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; d="scan'208";a="49089798"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 01:17:50 -0700
X-CSE-ConnectionGUID: hqga7r+1R4WuaPQz4z97Ew==
X-CSE-MsgGUID: w3HeNXTfQGigkpkjZsqihg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; d="scan'208";a="169367933"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 01:17:42 -0700
Message-ID: <0805f8a8-1680-4962-80e3-6b43a6e344b6@intel.com>
Date: Thu, 15 May 2025 16:17:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/27] hw/nvram/fw_cfg: Rename fw_cfg_init_mem_wide()
 -> fw_cfg_init_mem_dma()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Jason Wang <jasowang@redhat.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-7-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250508133550.81391-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
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

On 5/8/2025 9:35 PM, Philippe Mathieu-Daudé wrote:
> "wide" in fw_cfg_init_mem_wide() means "DMA support".
> Rename for clarity.

PS: at the time when fw_cfg_init_mem_wide() was first introcuded,
'wide' was exactly for data_width. see commit 6c87e3d5967a.

> Suggested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

with the usage in hw/loongarch/fw_cfg.c fixed,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   include/hw/nvram/fw_cfg.h | 6 +++---
>   hw/arm/virt.c             | 2 +-
>   hw/nvram/fw_cfg.c         | 6 +++---
>   hw/riscv/virt.c           | 4 ++--
>   4 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index d5161a79436..c4c49886754 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -309,9 +309,9 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>                                   AddressSpace *dma_as);
>   FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
>                                     unsigned data_width);
> -FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
> -                                 hwaddr data_addr, uint32_t data_width,
> -                                 hwaddr dma_addr, AddressSpace *dma_as);
> +FWCfgState *fw_cfg_init_mem_dma(hwaddr ctl_addr,
> +                                hwaddr data_addr, uint32_t data_width,
> +                                hwaddr dma_addr, AddressSpace *dma_as);
>   
>   FWCfgState *fw_cfg_find(void);
>   bool fw_cfg_dma_enabled(void *opaque);
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9a6cd085a37..7583f0a85d9 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1361,7 +1361,7 @@ static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
>       FWCfgState *fw_cfg;
>       char *nodename;
>   
> -    fw_cfg = fw_cfg_init_mem_wide(base + 8, base, 8, base + 16, as);
> +    fw_cfg = fw_cfg_init_mem_dma(base + 8, base, 8, base + 16, as);
>       fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)ms->smp.cpus);
>   
>       nodename = g_strdup_printf("/fw-cfg@%" PRIx64, base);
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 4067324fb09..51b028b5d0a 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -1087,9 +1087,9 @@ static FWCfgState *fw_cfg_init_mem_internal(hwaddr ctl_addr,
>       return s;
>   }
>   
> -FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
> -                                 hwaddr data_addr, uint32_t data_width,
> -                                 hwaddr dma_addr, AddressSpace *dma_as)
> +FWCfgState *fw_cfg_init_mem_dma(hwaddr ctl_addr,
> +                                hwaddr data_addr, uint32_t data_width,
> +                                hwaddr dma_addr, AddressSpace *dma_as)
>   {
>       assert(dma_addr && dma_as);
>       return fw_cfg_init_mem_internal(ctl_addr, data_addr, data_addr,
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index be1bf0f6468..3ddea18c93e 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1266,8 +1266,8 @@ static FWCfgState *create_fw_cfg(const MachineState *ms)
>       hwaddr base = virt_memmap[VIRT_FW_CFG].base;
>       FWCfgState *fw_cfg;
>   
> -    fw_cfg = fw_cfg_init_mem_wide(base + 8, base, 8, base + 16,
> -                                  &address_space_memory);
> +    fw_cfg = fw_cfg_init_mem_dma(base + 8, base, 8, base + 16,
> +                                 &address_space_memory);
>       fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)ms->smp.cpus);
>   
>       return fw_cfg;


