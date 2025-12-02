Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07931D116F5
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 14:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQR7e-00050p-1w; Tue, 02 Dec 2025 09:12:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQR7Y-0004zn-DK; Tue, 02 Dec 2025 09:12:48 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQR7V-0000n6-Mc; Tue, 02 Dec 2025 09:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764684766; x=1796220766;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=aJaYH3znAEtvfWy8ObOCzqWUUuF3YuHU7SuXuJqKynQ=;
 b=Y6cIMtyBX1wWI5FGXNSinJWxv7f+FgOxbwZBJ84dWg+p8xpCbmrWmdJz
 AQNuuNYVDLkH+tiUvUlT0K3tpGSHdV/bap3yXE/wCbznDDnJgsDwUByvJ
 luZYD3jWbCFhRFcVn1KjDzDo/vxTFMq7sLrztUNcyLNdz8jpO8iMczHT5
 5rU2RgLeCOgd92tcQE8r7Nf8ZwHAw1WPjAFj9rrsmoGOso34cmByXGzOB
 MZEarInycq1n+vxKhYpul7Xv/8daTQlq3LrcIWxh0JYRQS9RiSj2q29yt
 fGjtZvdwc1cR11Wtz1kbqShdHPRu/sYhLRWLG31vQoIhycytYlqpyb02Q w==;
X-CSE-ConnectionGUID: l2a2d3QLQ3uO9WcRyC0Yyw==
X-CSE-MsgGUID: WJ34HpGNSjGr2BdZh11Y1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="69244854"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="69244854"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 06:12:41 -0800
X-CSE-ConnectionGUID: AsDAqZKXTPKEo4/369JIMA==
X-CSE-MsgGUID: Gz3JRl+JRD++Z8OWe6OqgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="195194782"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 02 Dec 2025 06:12:34 -0800
Date: Tue, 2 Dec 2025 22:37:17 +0800
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
Subject: Re: [PATCH v4 05/27] hw/nvram/fw_cfg: Factor
 fw_cfg_init_mem_internal() out
Message-ID: <aS75nb+h31F8uZuc@intel.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508133550.81391-6-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> +FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
> +                                 hwaddr data_addr, uint32_t data_width,
> +                                 hwaddr dma_addr, AddressSpace *dma_as)
> +{
> +    assert(dma_addr && dma_as);
> +    return fw_cfg_init_mem_internal(ctl_addr, data_addr, data_addr,
                                                            ^^^^^^^^^
a typo: data_width...The type was converted "silently", making it easy
to be missed.

> +                                    dma_addr, dma_as);

Thanks,
Zhao


