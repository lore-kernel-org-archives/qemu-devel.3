Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AFBC83F1F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 09:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZo0w-0000Id-Av; Thu, 10 Jul 2025 05:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZnrW-0007jD-GZ; Thu, 10 Jul 2025 05:46:46 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZnrT-0002h3-C4; Thu, 10 Jul 2025 05:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752140799; x=1783676799;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KsJBwQm7jotQHrejxQWn6P4Z3ISBUQvN4ol1P1OSiZU=;
 b=T1YYHiDEO2mknvAR8y0n1mO8OW72kPcG4bTTUKiNT8d2ARfbyb623PUS
 3dg9jfptOs5ssvSb8JyGhQ2DPZgf0EhyEFTJKn9/AS4s8C0L9yR3VFVhB
 IyoG41nyPBkj2j7MupfjzhJMxSQ2ooKNGVAallyHNJli62Fbg6y8gFVDe
 uZpuvAZgz4/MDCzQjdFkSynQY8rTZamqrCGOfXUgnmVhAMIa774e3MS5G
 PUxEkCpDjkfyVRuWlc36yC7fy99lEmmredePStEL2xgdTh39qB4HKY2VJ
 erisgvODhneHh8Ftuc3/1tbtCEyafdGxvEkR/qwpj0YEtm0E7urzWSwL7 w==;
X-CSE-ConnectionGUID: dusPHC9aS92SLrdatAt23Q==
X-CSE-MsgGUID: 86AqWbjJSzy9DxtAGHTwIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="65115313"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; d="scan'208";a="65115313"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 02:46:34 -0700
X-CSE-ConnectionGUID: 98/hivaeRoGpjle1olRHnA==
X-CSE-MsgGUID: D8GMkoCOSoGydcfV3mtW3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; d="scan'208";a="156150690"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 10 Jul 2025 02:46:30 -0700
Date: Thu, 10 Jul 2025 18:07:58 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: qemu-arm@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Auger <eauger@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 2/2] hw/i386: Add the ramfb romfile compatibility
Message-ID: <aG+Q/rdKXgmCRRBF@intel.com>
References: <20250704030315.2181235-1-shahuang@redhat.com>
 <20250704030315.2181235-3-shahuang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704030315.2181235-3-shahuang@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jul 03, 2025 at 11:03:15PM -0400, Shaoqin Huang wrote:
> Date: Thu,  3 Jul 2025 23:03:15 -0400
> From: Shaoqin Huang <shahuang@redhat.com>
> Subject: [PATCH v9 2/2] hw/i386: Add the ramfb romfile compatibility
> 
> ramfb is a sysbus device so it can only used for machine types where it
> is explicitly enabled:
> 
>   # git grep machine_class_allow_dynamic_sysbus_dev.*TYPE_RAMFB_DEVICE
>   hw/arm/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc,
> 		  TYPE_RAMFB_DEVICE);
>   hw/i386/microvm.c:    machine_class_allow_dynamic_sysbus_dev(mc,
> 		  TYPE_RAMFB_DEVICE);
>   hw/i386/pc_piix.c:    machine_class_allow_dynamic_sysbus_dev(m,
> 		  TYPE_RAMFB_DEVICE);
>   hw/i386/pc_q35.c:    machine_class_allow_dynamic_sysbus_dev(m,
> 		  TYPE_RAMFB_DEVICE);
>   hw/loongarch/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc,
> 		  TYPE_RAMFB_DEVICE);
>   hw/riscv/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc,
> 		  TYPE_RAMFB_DEVICE);
> 
> So these six are the only machine types we have to worry about.
> 
> The three x86 machine types (pc, q35, microvm) will actually use the rom
> (when booting with seabios).
> 
> For arm/riscv/loongarch virt we want to disable the rom.
> 
> This patch sets ramfb romfile option to false by default, except for x86
> machines types (pc, q35, microvm) which need the rom file when booting
> with seabios and machine types <= 10.0 (handling the case of arm virt,
> for compat reasons).
> 
> At the same time, set the "use-legacy-x86-rom" property to true on those
> historical versioned machine types in order to avoid the memory layout
> being changed.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  hw/core/machine.c             |  2 ++
>  hw/display/ramfb-standalone.c |  2 +-
>  hw/i386/microvm.c             |  3 +++
>  hw/i386/pc_piix.c             | 10 ++++++++++
>  hw/i386/pc_q35.c              |  3 +++
>  hw/vfio/pci.c                 |  2 +-
>  6 files changed, 20 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


