Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E2AC3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2a0-0005xl-6E; Wed, 17 Jul 2024 07:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sU2Zi-0005Np-IY
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:12:03 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sU2Ze-000321-NL
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721214714; x=1752750714;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=OfSdfKwVT7TCXUf75AnKcWA+A254vwD/M0yrWJKuCO8=;
 b=Pr1uq8JyZYgBH5r6M0FcWMxiT01LW8QQ5juIx0/RU20noXNERmtDXIQd
 kiPCiyPmRZpy/Ij+L9g2503fu3ugZyfs3lW6F1kU6sw8RwnWFvdtC3ibb
 7Gq4VLA1QfMOdjd0ab6/j21FpC1hrsXV5oUfv9jhCCooH07wZ4ecFlNJR
 QdYFiTfMnNbv88wdvn0cRIuRqmYk4mLLR4dxJsdfUZjepLis3P6jZtb79
 3z/3Qjk5kWyKFOAE+YpRn39l+JeC27XP6IJabF2Ki/z0wVg5kqawPySeX
 IxXcBBUFjPSzaYOv11Kw0VIqcOaSjEiX3Mp9PB/vLLLTS46LEnzRp+hQl Q==;
X-CSE-ConnectionGUID: u0hBMhzaQT2OHVVqAN66BQ==
X-CSE-MsgGUID: cZkiPayHSFeUweugSNTtzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18847867"
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; d="scan'208";a="18847867"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2024 04:11:48 -0700
X-CSE-ConnectionGUID: NVc2gc/RQwCBEIOQI5JZHQ==
X-CSE-MsgGUID: k1Bl7Ub2Spu0ycWscuyG7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; d="scan'208";a="55492145"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 17 Jul 2024 04:11:47 -0700
Date: Wed, 17 Jul 2024 19:27:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] hw/nubus/nubus-virtio-mmio: Fix missing ERRP_GUARD() in
 nubus_virtio_mmio_realize()
Message-ID: <ZpeqoZC02URH4847@intel.com>
References: <20240715095939.72492-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240715095939.72492-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

If possible, can this one catch a ride with your PULL too?

Many thanks!
Zhao

On Mon, Jul 15, 2024 at 05:59:37PM +0800, Zhao Liu wrote:
> Date: Mon, 15 Jul 2024 17:59:37 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: [PATCH] hw/nubus/nubus-virtio-mmio: Fix missing ERRP_GUARD() in
>  nubus_virtio_mmio_realize()
> X-Mailer: git-send-email 2.34.1
> 
> As the comment in qapi/error, dereferencing @errp requires
> ERRP_GUARD():
> 
> * = Why, when and how to use ERRP_GUARD() =
> *
> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> * - It must not be dereferenced, because it may be null.
> ...
> * ERRP_GUARD() lifts these restrictions.
> *
> * To use ERRP_GUARD(), add it right at the beginning of the function.
> * @errp can then be used without worrying about the argument being
> * NULL or &error_fatal.
> *
> * Using it when it's not needed is safe, but please avoid cluttering
> * the source with useless code.
> 
> But in nubus_virtio_mmio_realize(), @errp is dereferenced without
> ERRP_GUARD().
> 
> Although nubus_virtio_mmio_realize() - as a DeviceClass.realize()
> method - doesn't get the NULL @errp parameter, it hasn't triggered the
> bug that dereferencing the NULL @errp. It's still necessary to follow
> the requirement of @errp, so add missing ERRP_GUARD() in
> nubus_virtio_mmio_realize().
> 
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  hw/nubus/nubus-virtio-mmio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/nubus/nubus-virtio-mmio.c b/hw/nubus/nubus-virtio-mmio.c
> index 58a63c84d0be..a5558d3ec28b 100644
> --- a/hw/nubus/nubus-virtio-mmio.c
> +++ b/hw/nubus/nubus-virtio-mmio.c
> @@ -23,6 +23,7 @@ static void nubus_virtio_mmio_set_input_irq(void *opaque, int n, int level)
>  
>  static void nubus_virtio_mmio_realize(DeviceState *dev, Error **errp)
>  {
> +    ERRP_GUARD();
>      NubusVirtioMMIODeviceClass *nvmdc = NUBUS_VIRTIO_MMIO_GET_CLASS(dev);
>      NubusVirtioMMIO *s = NUBUS_VIRTIO_MMIO(dev);
>      NubusDevice *nd = NUBUS_DEVICE(dev);
> -- 
> 2.34.1
> 

