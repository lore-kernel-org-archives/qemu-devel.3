Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD75CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 14:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOch6-00007j-LW; Thu, 27 Nov 2025 09:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vOch2-00005J-J6; Thu, 27 Nov 2025 09:09:56 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vOcgz-00040M-Bx; Thu, 27 Nov 2025 09:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764252593; x=1795788593;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=bQdYilWGa9Wi2rdUzt6QN0o4fezK94Yfgc3qXyRYmE0=;
 b=L9bVZuWXdzRN5jQIae+lIy1PcPXhm02Tf9q0fyRm5jfT4ctGb+aOQy2A
 R0hCOurfxe4f7vn5zKJc7NK695PV0rQTe6KFm8dn2anE1MgWzY6oO6sbB
 vDKZ/cyvWJBS2rUAwott8J8UX11zY4LJ2DZot9KzfAgKIMnuSghxT1EmO
 Y9zDFb7YvyVZn/NEGWgupoDT5Uu+Hw4MAQp+2J4bBqOJiJbm/rTw2K5up
 ZNkx7pdsTs01ethu1dX3fU1Bt7SgcJlMzBNeCZp0Lke2A7OtTy2F0Bnoh
 i9KE4hfRu1hYcyWs75rjTtT4D2fyGq7slrsjKG50EDhcSQ8qVUMdnrElB w==;
X-CSE-ConnectionGUID: Gr+69KyaTJKrcitki+L2eQ==
X-CSE-MsgGUID: 32DugJjOTBCkHilmXCP30g==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="77402711"
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; d="scan'208";a="77402711"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 06:09:49 -0800
X-CSE-ConnectionGUID: H8ufkZXVQg67BZP6Ctky/g==
X-CSE-MsgGUID: 2bH9/39aR9GF4XcDljhEyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,231,1758610800"; d="scan'208";a="193042281"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 27 Nov 2025 06:09:42 -0800
Date: Thu, 27 Nov 2025 22:34:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
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
 Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?iso-8859-1?Q?Cl=E9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 10/27] hw/i386/pc: Remove linuxboot.bin
Message-ID: <aShhbuuW/CVsoLvP@intel.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-11-philmd@linaro.org>
 <20250509180411.10f6e683@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250509180411.10f6e683@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Fri, May 09, 2025 at 06:04:11PM +0200, Igor Mammedov wrote:
> Date: Fri, 9 May 2025 18:04:11 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH v4 10/27] hw/i386/pc: Remove linuxboot.bin
> X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
> 
> On Thu,  8 May 2025 15:35:33 +0200
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
> > All PC machines now use the linuxboot_dma.bin binary,
> > we can remove the non-DMA version (linuxboot.bin).
> > 
> > Suggested-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > ---
> >  hw/i386/pc.c                  |   3 +-
 
(After a long interval, more of a note.)

> linuxboot.bin is referenced in a few more files:
> 
> hw/i386/x86-common.c:    option_rom[nb_option_roms].name = "linuxboot.bin";

this case is removed in previous patch (which considerred x86 machines
all have DMA enabled).

> hw/nvram/fw_cfg.c:    { "genroms/linuxboot.bin", 60 },

this case is removed in commit 6160ce208419 ("hw/nvram/fw_cfg: Remove
legacy FW_CFG_ORDER_OVERRIDE").

Regards,
Zhao


