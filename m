Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D76C369DC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 06:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCXzE-000656-Rm; Wed, 07 May 2025 02:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCXzB-00064g-8p
 for qemu-devel@nongnu.org; Wed, 07 May 2025 02:10:29 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCXz8-00073d-M7
 for qemu-devel@nongnu.org; Wed, 07 May 2025 02:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746598227; x=1778134227;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=cEJlIC35LNJ6mZqUIhG6KoNvxvlXWpmPbJuPIAWGBh0=;
 b=Jv9UVFlTcR6pCxkHZb6QyCx0mGF0HRYm4AoQXLYrz0TzKhygJ5XVxk6b
 xROGEg20vgelnJk+ofID8apEyMHbKldM6C6Jp/ZgXUpKNGHhiDyEbXRwF
 wnj/2fyXfBJizZEUQWE4p8g77EUJaChpjbAnMbeZ8v31RxnTAL4A/3b0e
 CDYGVRsmrBHi8u3bVcTpdhqcF+0fyUxdlZsvAykonkW9ni4l62njPnxIJ
 ALV1q6R79L2aAkkdrLlH8vVlHb9moocP1Crj72IQlJZ12zRxCJxpiZ88q
 nMoI1GvCV4jY/WNiJH3h51K6cE1/BOFjkQKZt93kAI8QUmr5gJ2NLmrUM w==;
X-CSE-ConnectionGUID: Y4JysiItTSCofymepr7aaQ==
X-CSE-MsgGUID: 47QLO3l/SCSnaE3kd4TzYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47406008"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="47406008"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 23:10:23 -0700
X-CSE-ConnectionGUID: M88GSDUQSZK5OHHKI3imOQ==
X-CSE-MsgGUID: 8QZc+tBkQcy5FEff2sdz1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="135817665"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 06 May 2025 23:10:19 -0700
Date: Wed, 7 May 2025 14:31:20 +0800
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
Subject: Re: [PATCH v3 03/19] hw/mips/loongson3_virt: Prefer using
 fw_cfg_init_mem()
Message-ID: <aBr+OFe2KKKYnGEb@intel.com>
References: <20250502185652.67370-1-philmd@linaro.org>
 <20250502185652.67370-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250502185652.67370-4-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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

On Fri, May 02, 2025 at 08:56:35PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Fri,  2 May 2025 20:56:35 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 03/19] hw/mips/loongson3_virt: Prefer using
>  fw_cfg_init_mem()
> X-Mailer: git-send-email 2.47.1
> 
> fw_cfg_init_mem_wide() is prefered to initialize fw_cfg
> with DMA support. Without DMA, use fw_cfg_init_mem().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/mips/loongson3_virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> index de6fbcc0cb4..41733988729 100644
> --- a/hw/mips/loongson3_virt.c
> +++ b/hw/mips/loongson3_virt.c
> @@ -286,7 +286,7 @@ static void fw_conf_init(void)
>      FWCfgState *fw_cfg;
>      hwaddr cfg_addr = virt_memmap[VIRT_FW_CFG].base;
>  
> -    fw_cfg = fw_cfg_init_mem_wide(cfg_addr, cfg_addr + 8, 8, 0, NULL);
> +    fw_cfg = fw_cfg_init_mem(cfg_addr, cfg_addr + 8, 8);

EMM, I'm not sure if I'm basing on the wrong code base... in which patch
does fw_cfg_init_mem() accept the third argument?

>      fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)current_machine->smp.cpus);
>      fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)current_machine->smp.max_cpus);
>      fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, loaderparams.ram_size);
> -- 
> 2.47.1
> 

