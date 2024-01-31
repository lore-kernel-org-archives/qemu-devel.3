Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EF4C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 03:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV1X0-0005tb-9w; Tue, 30 Jan 2024 22:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rV1Wy-0005tJ-HP
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 22:44:56 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rV1Wt-0005pC-CW
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 22:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706672691; x=1738208691;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AYUWX5XLzBgWV6jAaAyhHU9raTNKoF6D4QyI0moHs6o=;
 b=npvaQPVTMsVztTRhwTGLDdijHraPv1NseGVEkqbCeBAk71NAOzH3jVqm
 dIv0irJWn6ZhjKp76IaD42qelmXZKV6A4ysKna3Oz3lO8KBZeqnu4JRbP
 vorggxUQMebY76sx1ce0yxZHAHsbpbuePN/deiK9GcnH4B7QvfGaMDzxg
 KmuGcZd1Ik1n80Ff7u8M/wNT9YwXOhYpq2dj1tpy+AeUL2THbjhvbUMeY
 f7M4g8lAMzdjjrnCN+STw5EHEs/o3mc+M7x5BczHC31/XO0DoYy4scRqm
 SomDsc7bmaOx33fAEE8qrVU5P5L5T6hUieDj11Sa4h1ATDPjaA3/5Vv4i A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3350112"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3350112"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jan 2024 19:44:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="931693687"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; d="scan'208";a="931693687"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2024 19:44:46 -0800
Date: Wed, 31 Jan 2024 11:58:16 +0800
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
Subject: Re: [PATCH 5/5] hw/core: Remove transitional infrastructure from
 BusClass
Message-ID: <ZbnFWB1vJjW0CmzX@intel.com>
References: <20240119163512.3810301-1-peter.maydell@linaro.org>
 <20240119163512.3810301-6-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119163512.3810301-6-peter.maydell@linaro.org>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Jan 19, 2024 at 04:35:12PM +0000, Peter Maydell wrote:
> Date: Fri, 19 Jan 2024 16:35:12 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 5/5] hw/core: Remove transitional infrastructure from
>  BusClass
> X-Mailer: git-send-email 2.34.1
> 
> BusClass currently has transitional infrastructure to support
> subclasses which implement the legacy BusClass::reset method rather
> than the Resettable interface.  We have now removed all the users of
> BusClass::reset in the tree, so we can remove the transitional
> infrastructure.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/qdev-core.h |  2 --
>  hw/core/bus.c          | 67 ------------------------------------------
>  2 files changed, 69 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

It seems the similar cleanup for DeviceClass needs a lot of effort.

> 
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 151d9682380..986c924fa55 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -329,8 +329,6 @@ struct BusClass {
>       */
>      char *(*get_fw_dev_path)(DeviceState *dev);
>  
> -    void (*reset)(BusState *bus);
> -
>      /*
>       * Return whether the device can be added to @bus,
>       * based on the address that was set (via device properties)
> diff --git a/hw/core/bus.c b/hw/core/bus.c
> index c7831b5293b..b9d89495cdf 100644
> --- a/hw/core/bus.c
> +++ b/hw/core/bus.c
> @@ -232,57 +232,6 @@ static char *default_bus_get_fw_dev_path(DeviceState *dev)
>      return g_strdup(object_get_typename(OBJECT(dev)));
>  }
>  
> -/**
> - * bus_phases_reset:
> - * Transition reset method for buses to allow moving
> - * smoothly from legacy reset method to multi-phases
> - */
> -static void bus_phases_reset(BusState *bus)
> -{
> -    ResettableClass *rc = RESETTABLE_GET_CLASS(bus);
> -
> -    if (rc->phases.enter) {
> -        rc->phases.enter(OBJECT(bus), RESET_TYPE_COLD);
> -    }
> -    if (rc->phases.hold) {
> -        rc->phases.hold(OBJECT(bus));
> -    }
> -    if (rc->phases.exit) {
> -        rc->phases.exit(OBJECT(bus));
> -    }
> -}
> -
> -static void bus_transitional_reset(Object *obj)
> -{
> -    BusClass *bc = BUS_GET_CLASS(obj);
> -
> -    /*
> -     * This will call either @bus_phases_reset (for multi-phases transitioned
> -     * buses) or a bus's specific method for not-yet transitioned buses.
> -     * In both case, it does not reset children.
> -     */
> -    if (bc->reset) {
> -        bc->reset(BUS(obj));
> -    }
> -}
> -
> -/**
> - * bus_get_transitional_reset:
> - * check if the bus's class is ready for multi-phase
> - */
> -static ResettableTrFunction bus_get_transitional_reset(Object *obj)
> -{
> -    BusClass *dc = BUS_GET_CLASS(obj);
> -    if (dc->reset != bus_phases_reset) {
> -        /*
> -         * dc->reset has been overridden by a subclass,
> -         * the bus is not ready for multi phase yet.
> -         */
> -        return bus_transitional_reset;
> -    }
> -    return NULL;
> -}
> -
>  static void bus_class_init(ObjectClass *class, void *data)
>  {
>      BusClass *bc = BUS_CLASS(class);
> @@ -293,22 +242,6 @@ static void bus_class_init(ObjectClass *class, void *data)
>  
>      rc->get_state = bus_get_reset_state;
>      rc->child_foreach = bus_reset_child_foreach;
> -
> -    /*
> -     * @bus_phases_reset is put as the default reset method below, allowing
> -     * to do the multi-phase transition from base classes to leaf classes. It
> -     * allows a legacy-reset Bus class to extend a multi-phases-reset
> -     * Bus class for the following reason:
> -     * + If a base class B has been moved to multi-phase, then it does not
> -     *   override this default reset method and may have defined phase methods.
> -     * + A child class C (extending class B) which uses
> -     *   bus_class_set_parent_reset() (or similar means) to override the
> -     *   reset method will still work as expected. @bus_phases_reset function
> -     *   will be registered as the parent reset method and effectively call
> -     *   parent reset phases.
> -     */
> -    bc->reset = bus_phases_reset;
> -    rc->get_transitional_function = bus_get_transitional_reset;
>  }
>  
>  static void qbus_finalize(Object *obj)
> -- 
> 2.34.1
> 
> 

