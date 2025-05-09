Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183E7C3ABC5
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 02:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDDTi-0007S2-N7; Thu, 08 May 2025 22:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uDDTO-0006zK-8G; Thu, 08 May 2025 22:28:26 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uDDTM-0002tJ-6M; Thu, 08 May 2025 22:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746757704; x=1778293704;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=HbeDO7ZVXvOmx4YVzsa4pjo9QCbE4vkbbC4HZsiYVtQ=;
 b=KIDVFBfOO5zmeAvV4GkLPJOX89xVF5BCue7fnnqPv1UpYzlDaoPxYtsS
 M+zoZUVfLG+okWuBVATnWtb3ZA6iKOZGr7Y+rHeTTtAMnXKwZF9ihXRGa
 0tB7FoX7KYSxK9Vxtoq4kJTN2Bk97fAFzXoagDNGKEj46WpT7eX+quTyx
 1Q3HOvEdkAAST8WUO9ByIYeswNZTNk9kCq/WpxtzNZsHDVD8sm9xm043k
 1L3HnaCp2iyZU22THaetabwbRguSocTQ5DTtrZHvqSJ7Uj3jW06a5FO9B
 Sx+EZ2igA0JHbXWlkKyrToLR1jOtKk56au3velcbzgsIvxv9NZG0Od2Td g==;
X-CSE-ConnectionGUID: mycNg7TCTxKPZq2o7/Hu/g==
X-CSE-MsgGUID: 7yUVTqjnTp6kLj+vUhlr4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="47827607"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="47827607"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 19:28:19 -0700
X-CSE-ConnectionGUID: tXMqZeFxRrOJzvCFF6Qm8A==
X-CSE-MsgGUID: wBhidVKCTveefVXArIqFKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="141686752"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 08 May 2025 19:28:12 -0700
Date: Fri, 9 May 2025 10:49:14 +0800
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
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v4 03/27] hw/nvram/fw_cfg: Rename fw_cfg_init_mem() with
 '_nodma' suffix
Message-ID: <aB1tKnGs4slN5AEi@intel.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250508133550.81391-4-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
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

On Thu, May 08, 2025 at 03:35:26PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  8 May 2025 15:35:26 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v4 03/27] hw/nvram/fw_cfg: Rename fw_cfg_init_mem() with
>  '_nodma' suffix
> X-Mailer: git-send-email 2.47.1
> 
> Rename fw_cfg_init_mem() as fw_cfg_init_mem_nodma()
> to distinct with the DMA version (currently named
> fw_cfg_init_mem_wide).
> 
> Suggested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/nvram/fw_cfg.h | 3 ++-
>  hw/hppa/machine.c         | 2 +-
>  hw/nvram/fw_cfg.c         | 7 +++----
>  3 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


