Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C95CC47DD9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 02:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpfgi-0001az-NA; Wed, 27 Mar 2024 22:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpfgf-0001ae-Oi
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 22:40:18 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpfgd-0002vQ-83
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 22:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711593615; x=1743129615;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=zTxJu4xM4kn0z9PQ0Rt+v2caByjzuL9GhxzAuveBmyw=;
 b=muJxO9F3koT75GJAPUvwVgDIRko/SqYq8mDrrDq4h8nU5FpSIXnK0v/g
 gT3jp1bOqqS1kk3oD1IRYjqNjHAo/1rIEANj+KufdUVTConS98C/47kmC
 qNW3kvM3goji7mkE40VRTpK+HhbUH9zBegaj3ZOmBc+AaofNOJ1A1z753
 CJTQxQ583V38F0s7EBA43OE/Iub5kwZ0ZKwigAEC8LlcHApJXhFuUr0L0
 DJVfmIUOfOias3TR1gmXnotCsGuFcjtXc5q9lhDJPjFXKjk1cvW/A5xdR
 TzUJJGwrUONqXScf86kgSqbgWZ2vhWMax8mC8VA/YVvwVbln7f/ASJ32Q Q==;
X-CSE-ConnectionGUID: jK4hZ3MbTHKngtytKTExug==
X-CSE-MsgGUID: iX//9bCwT+S/BQhK/x7/JA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6949051"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6949051"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 19:40:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="16503318"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 27 Mar 2024 19:40:08 -0700
Date: Thu, 28 Mar 2024 10:54:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH-for-9.1 v2 12/21] hw/i386/pc: Remove
 PCMachineClass::enforce_aligned_dimm
Message-ID: <ZgTby3L9623ofMWC@intel.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-13-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327095124.73639-13-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Mar 27, 2024 at 10:51:14AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed, 27 Mar 2024 10:51:14 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-9.1 v2 12/21] hw/i386/pc: Remove
>  PCMachineClass::enforce_aligned_dimm
> X-Mailer: git-send-email 2.41.0
> 
> PCMachineClass::enforce_aligned_dimm was only used by the
> pc-i440fx-2.1 machine, which got removed. It is now always
> true. Remove it, simplifying pc_get_device_memory_range().
> Update the comment in Avocado test_phybits_low_pse36().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/i386/pc.h                  |  3 ---
>  hw/i386/pc.c                          | 14 +++-----------
>  tests/avocado/mem-addr-space-check.py |  3 +--
>  3 files changed, 4 insertions(+), 16 deletions(-)

[snip]

> diff --git a/tests/avocado/mem-addr-space-check.py b/tests/avocado/mem-addr-space-check.py
> index af019969c0..ad75170d52 100644
> --- a/tests/avocado/mem-addr-space-check.py
> +++ b/tests/avocado/mem-addr-space-check.py
> @@ -31,8 +31,7 @@ def test_phybits_low_pse36(self):
>          at 4 GiB boundary when "above_4g_mem_size" is 0 (this would be true when
>          we have 0.5 GiB of VM memory, see pc_q35_init()). This means total
>          hotpluggable memory size is 60 GiB. Per slot, we reserve 1 GiB of memory
> -        for dimm alignment for all newer machines (see enforce_aligned_dimm
> -        property for pc machines and pc_get_device_memory_range()). That leaves
> +        for dimm alignment for all machines. That leaves

Just nit, better align it here.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

>          total hotpluggable actual memory size of 59 GiB. If the VM is started
>          with 0.5 GiB of memory, maxmem should be set to a maximum value of
>          59.5 GiB to ensure that the processor can address all memory directly.
> -- 
> 2.41.0
> 

