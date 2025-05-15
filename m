Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B4AC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 08:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFTdo-0003vJ-0L; Thu, 15 May 2025 04:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uFTdc-0003lx-OX; Thu, 15 May 2025 04:08:20 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uFTda-0000ey-SJ; Thu, 15 May 2025 04:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747296499; x=1778832499;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1AnATLoCvpWdtTCkDZsBgKnp3pMIZcVXqd27NhUqOtA=;
 b=LvGWjzSHv3VY7pncxdXCP8KWMdo9g6nJHGgRmc3X4xGg4tsfDhfyys6W
 HOoQGg1f/wdJvGBaLD9fnQmpVTF7rUCsCvQdEVorHbpYOQcKW9mo8uJKe
 Vohft0V6OhRHZzZhSljWoTTyfd4pizoFYicyOu8GDNlDplhVPtA2Kni9I
 6+N9jmkFdAyG0yfseU9qtG1Haw75svuCWDH8eet0OFmcME36Mu5bJe6cd
 tS3mXbm1/p/Ila/Zusdf/Xd0nOxoC9Nf8Upw7uUjmO6KgdSg9M4gT3tlF
 g51FMhZmab02dj3fw4sqC/r6fmlXkBC5r4strLyL5tkbhK+VrDrzmX3M4 w==;
X-CSE-ConnectionGUID: O2BqWi/6Rxmtb7QmRS1RpQ==
X-CSE-MsgGUID: VBZp4VhWTOWao409x2y8qQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49088626"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; d="scan'208";a="49088626"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 01:08:13 -0700
X-CSE-ConnectionGUID: zUkxVkykSFCEb485bRZwWw==
X-CSE-MsgGUID: AE6yTCKbQjS55KgTgA+1xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; d="scan'208";a="138792583"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2025 01:08:02 -0700
Message-ID: <c6ece176-ac65-40ea-aca2-285c2fd9a9a7@intel.com>
Date: Thu, 15 May 2025 16:08:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/27] hw/nvram/fw_cfg: Factor
 fw_cfg_init_mem_internal() out
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
 <20250508133550.81391-6-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250508133550.81391-6-philmd@linaro.org>
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
> Factor fw_cfg_init_mem_internal() out of fw_cfg_init_mem_wide().
> In fw_cfg_init_mem_wide(), assert DMA arguments are provided.
> Callers without DMA have to use the fw_cfg_init_mem() helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/nvram/fw_cfg.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 10f8f8db86f..4067324fb09 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -1053,9 +1053,9 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>       return s;
>   }
>   
> -FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
> -                                 hwaddr data_addr, uint32_t data_width,
> -                                 hwaddr dma_addr, AddressSpace *dma_as)
> +static FWCfgState *fw_cfg_init_mem_internal(hwaddr ctl_addr,
> +                                            hwaddr data_addr, uint32_t data_width,
> +                                            hwaddr dma_addr, AddressSpace *dma_as)
>   {
>       DeviceState *dev;
>       SysBusDevice *sbd;
> @@ -1087,10 +1087,19 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
>       return s;
>   }
>   
> +FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
> +                                 hwaddr data_addr, uint32_t data_width,
> +                                 hwaddr dma_addr, AddressSpace *dma_as)
> +{
> +    assert(dma_addr && dma_as);
> +    return fw_cfg_init_mem_internal(ctl_addr, data_addr, data_addr,
> +                                    dma_addr, dma_as);
> +}
> +
>   FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
>                                     unsigned data_width)
>   {
> -    return fw_cfg_init_mem_wide(ctl_addr, data_addr, data_width, 0, NULL);
> +    return fw_cfg_init_mem_internal(ctl_addr, data_addr, data_width, 0, NULL);
>   }
>   
>   


