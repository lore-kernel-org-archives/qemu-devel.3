Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFAEC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 06:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDHIO-0001m9-Mn; Fri, 09 May 2025 02:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uDHI4-0001bq-Qd; Fri, 09 May 2025 02:33:00 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uDHI2-0006a0-VR; Fri, 09 May 2025 02:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746772379; x=1778308379;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=6EFiaT0nYvORCtcVuWMkfjhgQbjVLv9V1cMeI30pMKI=;
 b=ca22+mq8k7LglV9QR1556Xpx7ststSXVFc+86YbB0YtDKuS+v1hsnOyu
 4oa7q1KfidWEDrmVgoIho5y23D3MQTeA3bZP7NR8rn9APbjCII3DOpn+e
 DrFsOP783dgT5YGKz64tbTwa10qMNGjxl02YoWLEfiqeGDH4y/0gnIiBS
 20edppjW4Hr9B880tWpFJ7RVftnpSqLw1bWy+KL36S2QQZ+FN45GTy4uV
 Z9TB5W2PbI7RZ1BJq5DijLw4QKViKApVITLunfAe6wj0uTGZnZ6jo4znS
 VYRN5bFjkhAj3nZ7OgO4fuDfp3q629OY81lVlFs5qq9qLDcuOjdFJrA8n g==;
X-CSE-ConnectionGUID: mYtupA0gSTGTnc72yaPe3g==
X-CSE-MsgGUID: Eoc+PbUzTRiEsASMP//gkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48737057"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="48737057"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 23:32:55 -0700
X-CSE-ConnectionGUID: awG5SpBiR5OmJ7es03eNog==
X-CSE-MsgGUID: 3vPGJfzmToOTqbYQ0fgKXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="141299293"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 08 May 2025 23:32:48 -0700
Date: Fri, 9 May 2025 14:53:50 +0800
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
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 10/27] hw/i386/pc: Remove linuxboot.bin
Message-ID: <aB2mfvdqMOImbNcQ@intel.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-11-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250508133550.81391-11-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

On Thu, May 08, 2025 at 03:35:33PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  8 May 2025 15:35:33 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v4 10/27] hw/i386/pc: Remove linuxboot.bin
> X-Mailer: git-send-email 2.47.1
> 
> All PC machines now use the linuxboot_dma.bin binary,
> we can remove the non-DMA version (linuxboot.bin).
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/i386/pc.c                  |   3 +-
>  pc-bios/meson.build           |   1 -
>  pc-bios/optionrom/Makefile    |   2 +-
>  pc-bios/optionrom/linuxboot.S | 195 ----------------------------------
>  4 files changed, 2 insertions(+), 199 deletions(-)
>  delete mode 100644 pc-bios/optionrom/linuxboot.S

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


