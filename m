Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010E0C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 03:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV1Sf-0003TE-5e; Tue, 30 Jan 2024 22:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rV1Sd-0003Sr-Lf
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 22:40:27 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rV1Sc-0005EA-28
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 22:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706672426; x=1738208426;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5BWH/FDpGN4wqK3bRSej8yHnFryVSr/ULTUTxOx275k=;
 b=iH4HdqcaL2/RK4JNWFhnb3z/3nrYyv2bVqFyQfApjNtkh0WW8EDuql85
 pMgBksrImR9s6FPpUyk1TcqUi4vShzFO1PEJx7z3S1YnBfmTSs5Ftseir
 snvefyb5A/QmE6wo0Pmzx/ZaEa9yI5gf38DP0bWzg9JNr/BmQ1Umm5v/G
 NUD+vFXObOy+CHdSFkkmErCGTx5ThDrK0PfTmMgMVdxs10r+wCqzwjbee
 o4ZxeT7bj6HxN2Xu6QDKT4PSKs6zNQ/DggypaSPUof4L1yN5VhfX9oVQB
 yDz+JWespP2bkpF8Wi906072nll1/a9tGARrvQta3jT1qjgmlR2k8Uqt/ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2419900"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="2419900"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2024 19:39:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822421510"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="822421510"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 30 Jan 2024 19:39:53 -0800
Date: Wed, 31 Jan 2024 11:53:23 +0800
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
Subject: Re: [PATCH 2/5] vmbus: Switch bus reset to 3-phase-reset
Message-ID: <ZbnEM2Y1YBrBzKD/@intel.com>
References: <20240119163512.3810301-1-peter.maydell@linaro.org>
 <20240119163512.3810301-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119163512.3810301-3-peter.maydell@linaro.org>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Fri, Jan 19, 2024 at 04:35:09PM +0000, Peter Maydell wrote:
> Date: Fri, 19 Jan 2024 16:35:09 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 2/5] vmbus: Switch bus reset to 3-phase-reset
> X-Mailer: git-send-email 2.34.1
> 
> Switch vmbus from using BusClass::reset to the Resettable interface.
> 
> This has no behavioural change, because the BusClass code to support
> subclasses that use the legacy BusClass::reset will call that method
> in the hold phase of 3-phase reset.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/hyperv/vmbus.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
> index c86d1895bae..380239af2c7 100644
> --- a/hw/hyperv/vmbus.c
> +++ b/hw/hyperv/vmbus.c
> @@ -2453,9 +2453,9 @@ static void vmbus_unrealize(BusState *bus)
>      qemu_mutex_destroy(&vmbus->rx_queue_lock);
>  }
>  
> -static void vmbus_reset(BusState *bus)
> +static void vmbus_reset_hold(Object *obj)
>  {
> -    vmbus_deinit(VMBUS(bus));
> +    vmbus_deinit(VMBUS(obj));
>  }
>  
>  static char *vmbus_get_dev_path(DeviceState *dev)
> @@ -2476,12 +2476,13 @@ static char *vmbus_get_fw_dev_path(DeviceState *dev)
>  static void vmbus_class_init(ObjectClass *klass, void *data)
>  {
>      BusClass *k = BUS_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>  
>      k->get_dev_path = vmbus_get_dev_path;
>      k->get_fw_dev_path = vmbus_get_fw_dev_path;
>      k->realize = vmbus_realize;
>      k->unrealize = vmbus_unrealize;
> -    k->reset = vmbus_reset;
> +    rc->phases.hold = vmbus_reset_hold;
>  }
>  
>  static int vmbus_pre_load(void *opaque)
> -- 
> 2.34.1
> 
> 

