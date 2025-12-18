Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2522AD68BE7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 07:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW8KB-0004NF-2R; Thu, 18 Dec 2025 02:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vW8Jc-0004E7-L2; Thu, 18 Dec 2025 02:20:48 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vW8JY-0000ak-B8; Thu, 18 Dec 2025 02:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766042444; x=1797578444;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=WJEIgxu3+zm1akya5uEapVzOpJ64gXw/82xWr1E4ihU=;
 b=CbxUNgg9L4yKL/BvK4mo/CuQF7nUDrPiDIEVb8fx57kcZPHSGwGlMLsR
 1nu+rX9872cTP0o8dTeBLhCtXXV+FZFJCunbo9MrzCNx7owq3friTPoAW
 GPpJqJen9Km4u0JBM4CT/clyycJ84Z5tO83FKpZgJs0WGKGGBi02z/tno
 sy1IMTVJ2rM95hbLyc01XS6m8w5CjN5lYjEJHBS2qgZI+CesslmbDUqFr
 c2X46vjjKYP/v+tHWpGZtoA3/IFrtkUN0+tmynHtydKTl4q0y3w6yCK+2
 A/mbHcx5OKy43xXD80p5twxNwlKyke77lR94Ztdmb74BW3+q3P2jQx8O4 A==;
X-CSE-ConnectionGUID: RAoOdFC+RVqOKrAjtI9I8Q==
X-CSE-MsgGUID: bOCPdOwLQ1ue11vgpjcqww==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="66986693"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="66986693"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 23:20:30 -0800
X-CSE-ConnectionGUID: Wvc3fFGoR+mxeHpJsuEI3A==
X-CSE-MsgGUID: L6Cpx68PQoy7+Y2uTiOR7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="203582897"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 17 Dec 2025 23:20:21 -0800
Date: Thu, 18 Dec 2025 15:45:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Peter Krempa <pkrempa@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH v5 16/28] hw/i386: Remove linuxboot.bin
Message-ID: <aUOxBg3bVii1HAOx@intel.com>
References: <20251202162835.3227894-1-zhao1.liu@intel.com>
 <20251202162835.3227894-17-zhao1.liu@intel.com>
 <20251217155530.3353e904@imammedo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251217155530.3353e904@imammedo>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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

On Wed, Dec 17, 2025 at 03:55:30PM +0100, Igor Mammedov wrote:
> Date: Wed, 17 Dec 2025 15:55:30 +0100
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH v5 16/28] hw/i386: Remove linuxboot.bin
> X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
> 
> On Wed,  3 Dec 2025 00:28:23 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
> 
> > From: Philippe Mathieu-Daudé <philmd@linaro.org>
> > 
> > All machines now use the linuxboot_dma.bin binary, so it's safe to
> > remove the non-DMA version (linuxboot.bin).
> 
> after applying this patch:
> 
> git grep linuxboot.bin
> 
>     option_rom[nb_option_roms].bootindex = 0;                                    
>     option_rom[nb_option_roms].name = "linuxboot.bin";                           
>     if (fw_cfg_dma_enabled(fw_cfg)) {                                            
>         option_rom[nb_option_roms].name = "linuxboot_dma.bin";                   
>     }        
> 
> perhaps it should be fixed in previous patch

Thanks, I find this change was included in the previous patch (patch 15).

And I have a GitLab branch and hopefully it could help apply and review:

https://gitlab.com/zhao.liu/qemu/-/commits/remove-2.6-and-2.7-pc-v5-11-26-2025

Regards,
Zhao


