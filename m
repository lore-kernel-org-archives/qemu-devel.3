Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AA4C369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 06:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCY4g-0002Qn-95; Wed, 07 May 2025 02:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCY4e-0002QD-HK
 for qemu-devel@nongnu.org; Wed, 07 May 2025 02:16:08 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCY4c-0007RY-5m
 for qemu-devel@nongnu.org; Wed, 07 May 2025 02:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746598566; x=1778134566;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=toK8JBayB+qMbxO0Sa+do0Oe6ClHwS1jvRr9XyrUsWc=;
 b=MREXBKFZLhREy8lvOWuUSzOrRvs8bWNIgepgCY33d7Fm/XpD5PW6rugC
 4CF8I8QWKtrgR2X/HmWDVKpeH5D4VYATBQZb2SVNH4zq6pKxgjs2yHiuq
 z3T1RdmtqJDeKWAyG0XrPY5bmG5+KLx/hh3upJK436i6tB+lB0QKoGL5D
 1zkjLkhGg0TjxVH5yI5EOSH1BIcxt5OaHfBNsYMq7mgy1yIC8NO3PLz1q
 LNoDJupvC75NOQXz4h5GgM37Zx5IxKybyHBNnA0j99pxwwCmlUdlfUw2+
 1B23X7VILQDpRv5Z2pBvLkFb6sLxYcb+/7PVR8EvHrZlI1Eb9XNJDywZ+ A==;
X-CSE-ConnectionGUID: I4vELF2/S+emoynHmWZJzA==
X-CSE-MsgGUID: HbOo7QsyQy6hdvBGfDzwaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="52124562"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="52124562"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 23:16:02 -0700
X-CSE-ConnectionGUID: pQ/Dpfd5Siu2Rkfp3d43Jg==
X-CSE-MsgGUID: mifFJOiySfSf/sUm/awUfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="140587428"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 06 May 2025 23:15:58 -0700
Date: Wed, 7 May 2025 14:36:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Amit Shah <amit@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 04/19] hw/nvram/fw_cfg: Factor
 fw_cfg_init_mem_internal() out
Message-ID: <aBr/i95gBcTDH3xN@intel.com>
References: <20250502185652.67370-1-philmd@linaro.org>
 <20250502185652.67370-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250502185652.67370-5-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Fri, May 02, 2025 at 08:56:36PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Fri,  2 May 2025 20:56:36 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 04/19] hw/nvram/fw_cfg: Factor
>  fw_cfg_init_mem_internal() out
> X-Mailer: git-send-email 2.47.1
> 
> Factor fw_cfg_init_mem_internal() out of fw_cfg_init_mem_wide().
> In fw_cfg_init_mem_wide(), assert DMA arguments are provided.
> Callers without DMA have to use the fw_cfg_init_mem() helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/nvram/fw_cfg.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 54cfa07d3f5..d119c10d308 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -1053,9 +1053,9 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>      return s;
>  }
>  
> -FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
> -                                 hwaddr data_addr, uint32_t data_width,
> -                                 hwaddr dma_addr, AddressSpace *dma_as)
> +static FWCfgState *fw_cfg_init_mem_internal(hwaddr ctl_addr,
> +                                         hwaddr data_addr, uint32_t data_width,
> +                                         hwaddr dma_addr, AddressSpace *dma_as)
>  {
>      DeviceState *dev;
>      SysBusDevice *sbd;
> @@ -1087,11 +1087,19 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
>      return s;
>  }
>  
> +FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
> +                                 hwaddr data_addr, uint32_t data_width,
> +                                 hwaddr dma_addr, AddressSpace *dma_as)

How about mentioning DMA in the name? fw_cfg_init_mem_dma.

> +{
> +    assert(dma_iobase && dma_as);
> +    fw_cfg_init_mem_internal(ctl_addr, data_addr, data_addr, dma_addr, dma_as);
> +}
> +
>  FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr)

OK, now I'm sure fw_cfg_init_mem() only accepts 2 arguments. :-)

>  {
> -    return fw_cfg_init_mem_wide(ctl_addr, data_addr,
> -                                fw_cfg_data_mem_ops.valid.max_access_size,
> -                                0, NULL);
> +    return fw_cfg_init_mem_internal(ctl_addr, data_addr,
> +                                    fw_cfg_data_mem_ops.valid.max_access_size,
> +                                    0, NULL);
>  }
>  
>  
> -- 
> 2.47.1
> 

