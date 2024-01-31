Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6D1C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 03:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV1TJ-000426-VU; Tue, 30 Jan 2024 22:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rV1TI-000400-EA
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 22:41:08 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rV1TE-0005Ju-TV
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 22:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706672465; x=1738208465;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=SsMF/XjkR9KbJrORHqb0wo7J/9pMVHTwKFoP7xTkUss=;
 b=BaXMtUXbYjumxVUfo/TmjEWMD4TyehUpmIjLaKkcQJMQirWayi/b08HN
 yT51/Znez2FMH3hiD0xQwQvlA5rjUlq1h/FO2QjxuqFsSwt30FPjYQr/u
 s5hOd/BL+IeBeFJUHcSCLHTENROMLmsmS/Rou6/VRgPmBmjXhbdSvR41u
 jJoH/wOz5rt8pzPAs/tO6Y4JOkZ9rjQpW/nrPLBHAU3wUCc2HJLxwsEDn
 JgIhtIKtFTQk0HDrnsb1blxFUHMM1AtJSS9jqR3PDASbxCjAXcfDdaKcX
 D9twoiRlpWjqTOA7oX4uuMkDUbLcjU9P1oDPMwDNUzr8PK83GnCylW/eS g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="21993531"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="21993531"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2024 19:41:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="30350445"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 30 Jan 2024 19:41:00 -0800
Date: Wed, 31 Jan 2024 11:54:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 4/5] hw/s390x/css-bridge: switch virtual-css bus to
 3-phase-reset
Message-ID: <ZbnEdejLyCTScl2r@intel.com>
References: <20240119163512.3810301-1-peter.maydell@linaro.org>
 <20240119163512.3810301-5-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119163512.3810301-5-peter.maydell@linaro.org>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Jan 19, 2024 at 04:35:11PM +0000, Peter Maydell wrote:
> Date: Fri, 19 Jan 2024 16:35:11 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 4/5] hw/s390x/css-bridge: switch virtual-css bus to
>  3-phase-reset
> X-Mailer: git-send-email 2.34.1
> 
> Switch the s390x virtual-css bus from using BusClass::reset to the
> Resettable interface.
> 
> This has no behavioural change, because the BusClass code to support
> subclasses that use the legacy BusClass::reset will call that method
> in the hold phase of 3-phase reset.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/s390x/css-bridge.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
> index 15d26efc951..34639f21435 100644
> --- a/hw/s390x/css-bridge.c
> +++ b/hw/s390x/css-bridge.c
> @@ -56,7 +56,7 @@ static void ccw_device_unplug(HotplugHandler *hotplug_dev,
>      qdev_unrealize(dev);
>  }
>  
> -static void virtual_css_bus_reset(BusState *qbus)
> +static void virtual_css_bus_reset_hold(Object *obj)
>  {
>      /* This should actually be modelled via the generic css */
>      css_reset();
> @@ -81,8 +81,9 @@ static char *virtual_css_bus_get_dev_path(DeviceState *dev)
>  static void virtual_css_bus_class_init(ObjectClass *klass, void *data)
>  {
>      BusClass *k = BUS_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>  
> -    k->reset = virtual_css_bus_reset;
> +    rc->phases.hold = virtual_css_bus_reset_hold;
>      k->get_dev_path = virtual_css_bus_get_dev_path;
>  }
>  
> -- 
> 2.34.1
> 
> 

