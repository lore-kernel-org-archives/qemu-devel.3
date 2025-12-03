Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B92D15D86
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQokc-0006BP-1M; Wed, 03 Dec 2025 10:26:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQoka-0006AO-3h; Wed, 03 Dec 2025 10:26:40 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQokY-00023c-8i; Wed, 03 Dec 2025 10:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764775598; x=1796311598;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Jrc8P4puiHEWVgK5gKHDVPB4edrZpUnxl7rtp5oYUy8=;
 b=jVD9kHJvCjmfU9K5/McOEiScXP3biRSs7him7K55UeLf4QWb1noF8IYi
 ZcHdXyiaNl0MfusyPqqsDyMY7zex+z25upGZooOkDlEq6y/F8OPjcZsGH
 UrElGzV48HTbMj7r0alVoUMIQs6l14iinxF15+YSklmy0GDjjMrbtuMSa
 rVmZtJtq5itlsEVJVtJ8u0MoYeEmv1vFkau4ogeU7Qq1uK3JsoYEk/q2h
 Bj8LmkzP8fqc0Zk1CtjYJHZFMLHU2rs8u0cZLVXJ9wWtK9zvbCeeiHCiz
 smsFSpUtbkmw66K09DnQSTOwqTkYnucFaolKCfkn8pAQwWjQTeh0nNsy+ w==;
X-CSE-ConnectionGUID: W3Cy0NTSTgqSUVLV+HoGpA==
X-CSE-MsgGUID: LLQ4j/H7SseyavfcdlAXgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="54323027"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; d="scan'208";a="54323027"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2025 07:26:34 -0800
X-CSE-ConnectionGUID: M+KB5REsSvuzF70W5+fI9g==
X-CSE-MsgGUID: N2mvK8ajRTiHQAJDmkCSxw==
X-ExtLoop1: 1
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 03 Dec 2025 07:26:32 -0800
Date: Wed, 3 Dec 2025 23:51:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [PATCH-for-11.0 v6 08/13] hw/sparc64/sun4u: Use
 fw_cfg_init_io_nodma()
Message-ID: <aTBccn2LIv7puGzR@intel.com>
References: <20251203060942.57851-1-philmd@linaro.org>
 <20251203060942.57851-9-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203060942.57851-9-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
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

Hi Philippe,

> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 82c3e7c855b..6dc9f64b74d 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -683,14 +683,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>                             graphic_width, graphic_height, graphic_depth,
>                             (uint8_t *)&macaddr);
>  
> -    dev = qdev_new(TYPE_FW_CFG_IO);
> -    qdev_prop_set_bit(dev, "dma_enabled", false);
> -    object_property_add_child(OBJECT(ebus), TYPE_FW_CFG, OBJECT(dev));

There's another difference: fw_cfg_init_io_nodma() uses `machine` as the
parent and here sun4uv uses `ebus`.

I think maybe one reason to use `ebus` is because...

> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> -    memory_region_add_subregion(pci_address_space_io(ebus), BIOS_CFG_IOPORT,
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^
... because the parent region is managed by ebus.

Perhaps we should add another argument: Object *parent?

> -                                &FW_CFG_IO(dev)->comb_iomem);
> -

Thanks,
Zhao


