Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E02CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 14:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOcbO-0004kp-SQ; Thu, 27 Nov 2025 09:04:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vOcbK-0004c8-FH; Thu, 27 Nov 2025 09:04:04 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vOcbH-00039u-Sw; Thu, 27 Nov 2025 09:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764252240; x=1795788240;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=wbIpXOHrAhUYTz4YKeYSdJQ6eJC9BtOYzZPt+wa1Bpo=;
 b=hM7eGOu1nGVv+WcBcuQ5dPKzxGszP/o9K2zDjHqJrna2AjlT4XQm9AfH
 2/YfOcPnm8VBLWVrmgepslh52D3nuTKm3hTN+StPflEjQHvGmvlwLqQdr
 dDSL7eyIa8FPfngz3OZOLsN8jilZQcZiKMFW1C7qQaZqx+qdziyAsrIYc
 RqwcFIJJmprpiGMmdGP251VmpEC4TbM2Wr6gMWFCs6thGE8b2IQgNxOJu
 prM6/Ij+iZSVyK3myKNnUa8XBptE902ubyprdOSulMdB+GqKhqHbITuC0
 xTWA6fHWb32Ab3RZRDUDxnE86Zj/1sO6bfgwD2hcCHAjYbeSMacl+NvD+ g==;
X-CSE-ConnectionGUID: uB61wwTdRSu8SckVRq6c3Q==
X-CSE-MsgGUID: 8Ds/8cKWRpmo6ZtfLZDMRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="76988049"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; d="scan'208";a="76988049"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 06:03:56 -0800
X-CSE-ConnectionGUID: ZiYc/Z/CSz60FVKebjEsIQ==
X-CSE-MsgGUID: ybI2bXHdSTGszpa08vP/ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; d="scan'208";a="216594607"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 27 Nov 2025 06:03:48 -0800
Date: Thu, 27 Nov 2025 22:28:28 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 kvm@vger.kernel.org, Sergio Lopez <slp@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Jason Wang <jasowang@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v4 09/27] hw/nvram/fw_cfg: Remove
 fw_cfg_io_properties::dma_enabled
Message-ID: <aShgDDow//CQsMhF@intel.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-10-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250508133550.81391-10-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
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

On Thu, May 08, 2025 at 03:35:32PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  8 May 2025 15:35:32 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v4 09/27] hw/nvram/fw_cfg: Remove
>  fw_cfg_io_properties::dma_enabled
> X-Mailer: git-send-email 2.47.1
> 
> Now than all calls to fw_cfg_init_io_dma() pass DMA arguments,

Yes,

> the 'dma_enabled' of the TYPE_FW_CFG_IO type is not used anymore.
> Remove it, simplifying fw_cfg_init_io_dma() and fw_cfg_io_realize().

but the 'dma_enabled' of the TYPE_FW_CFG_IO type is still used in
hw/sparc64/sun4u.c:

    dev = qdev_new(TYPE_FW_CFG_IO);
    qdev_prop_set_bit(dev, "dma_enabled", false);

The creation of TYPE_FW_CFG_IO is similar to fw_cfg_init_io_dma(), but
it still has little difference so I find sun4uv can't use
fw_cfg_init_io_dma() directly for now, or it may require more careful
clarification that it can use fw_cfg_init_io_dma().

So, at least we have to keep "dma_enabled" property in
fw_cfg_io_properties[].

...

> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index 27254a0e9f1..ee594364415 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -991,10 +991,7 @@ void x86_load_linux(X86MachineState *x86ms,
>      }
>  
>      option_rom[nb_option_roms].bootindex = 0;
> -    option_rom[nb_option_roms].name = "linuxboot.bin";
> -    if (fw_cfg_dma_enabled(fw_cfg)) {
> -        option_rom[nb_option_roms].name = "linuxboot_dma.bin";
> -    }
> +    option_rom[nb_option_roms].name = "linuxboot_dma.bin";
>      nb_option_roms++;
>  }

But now all x86 machines have enabled dma, so it's still possible to
drop "linuxboot.bin".

For this, I think we could add a DMA check in the x86 common code to
guarantee DMA is enabled and then we won't need to constantly check
DMA enable in every corner.

Regards,
Zhao


