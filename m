Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B08AD711D6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 08:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWVik-0001LA-7e; Fri, 19 Dec 2025 03:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vWVii-0001Kl-9N; Fri, 19 Dec 2025 03:20:16 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vWVig-0000bq-8p; Fri, 19 Dec 2025 03:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766132414; x=1797668414;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=rbqD8yaIdenCZwbjEjjw/OflDKuC2ytzzOoneMqP9Fc=;
 b=HOBL+1CT0zHt9OZj5tSl4SWoSkocT/zmSVVlO7kTBsZVy+I70W8DhCcS
 zuaCoiUnJs2L7LOr5TtUD52D1N0IYmZD+NBqJjDxY/5g/FZ7CPM4qebOP
 64w2+FEyeFCZlV+6ACUgL/SL3+o6lnkn+Eqr7cWP2du61q5IFgpQmX2ps
 hP/PkdbAwJ24bOg0nXRG+ZdMl/38G8BA3sWzz8V0DwOK0lX6YNCpDKYQc
 udMoy0Ojeq8OuxB3IPHNQBdUY/j0M5vO78JKeJC4I1hoNNiqbBQashFqY
 bCfDkpXZ0O9xe9/zc+25ZCvB/HfOgwxQdG/P1ZgATKkHJQpNhbgwnTHtz g==;
X-CSE-ConnectionGUID: mIdrep4iRbGJxeIb6hfTIA==
X-CSE-MsgGUID: 1pRzE470RNuNJg7/ZZ3dpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="70662220"
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; d="scan'208";a="70662220"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2025 00:20:10 -0800
X-CSE-ConnectionGUID: /IV1u42/TVakiYPS8EdN1g==
X-CSE-MsgGUID: 7sbsnnn2QKuos6f3534EGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,159,1763452800"; d="scan'208";a="203196386"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 19 Dec 2025 00:20:01 -0800
Date: Fri, 19 Dec 2025 16:44:51 +0800
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
Message-ID: <aUUQgyGDiwV7NC0U@intel.com>
References: <20251202162835.3227894-1-zhao1.liu@intel.com>
 <20251202162835.3227894-17-zhao1.liu@intel.com>
 <20251217155530.3353e904@imammedo> <aUOxBg3bVii1HAOx@intel.com>
 <20251218153333.6cb6e080@imammedo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251218153333.6cb6e080@imammedo>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

> > On Wed, Dec 17, 2025 at 03:55:30PM +0100, Igor Mammedov wrote:
> > > Date: Wed, 17 Dec 2025 15:55:30 +0100
> > > From: Igor Mammedov <imammedo@redhat.com>
> > > Subject: Re: [PATCH v5 16/28] hw/i386: Remove linuxboot.bin
> > > X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
> > > 
> > > On Wed,  3 Dec 2025 00:28:23 +0800
> > > Zhao Liu <zhao1.liu@intel.com> wrote:
> > >   
> > > > From: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > 
> > > > All machines now use the linuxboot_dma.bin binary, so it's safe to
> > > > remove the non-DMA version (linuxboot.bin).  
> > > 
> > > after applying this patch:
> > > 
> > > git grep linuxboot.bin
> > > 
> > >     option_rom[nb_option_roms].bootindex = 0;                                    
> > >     option_rom[nb_option_roms].name = "linuxboot.bin";                           
> > >     if (fw_cfg_dma_enabled(fw_cfg)) {                                            
> > >         option_rom[nb_option_roms].name = "linuxboot_dma.bin";                   
> > >     }        
> > > 
> > > perhaps it should be fixed in previous patch  
> > 
> > Thanks, I find this change was included in the previous patch (patch 15).
> 
> Yep, sorry for confusion. /I forgot to apply #15, hence it led to a stray linuxboot.bin/

You're welcome and thanks for your review!

Regards,
Zhao


