Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F283DC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5Vi-0007dP-Gx; Thu, 22 Feb 2024 04:36:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rd5Vh-0007cL-88; Thu, 22 Feb 2024 04:36:57 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rd5Vf-0004PU-K6; Thu, 22 Feb 2024 04:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708594615; x=1740130615;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=5Hts59FU1BFvUeYUiy8EAY+SoeJmaBVdhyCkh13F13s=;
 b=cUEMgRCEgymhw/b9MRRsXQ78rynIg0yMqUb/EXzBbCLEJsRqqS7IuhXB
 ki0Elut30zkJT/widWrdlO8kI96d1f+7lxeOHkyzAc1bAv/x0tWP8jsVE
 +P57ioRvUbn2Xh978J8AfU+AXytquPwiKaCanDHyHTw3MqmfRv5pt5c2r
 KP83S3SGzd7gFAnSzVLif/AyLykdv2MhZ8EJzW+UVzlU2YUjt08XrmZyQ
 2oaDWnBdGNqZETUAGf3XjhpRMSBKOyrOWi/klfNuyU/p7BM7qEC/Uo/hi
 ZKhOgYRzAZj106Ub+by/EdeMSVrHZ09Y6LjLvMzv54vhyIFnu17CZJCFI w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13935516"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; d="scan'208";a="13935516"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2024 01:36:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; d="scan'208";a="36266789"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 22 Feb 2024 01:36:49 -0800
Date: Thu, 22 Feb 2024 17:50:28 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [PATCH 06/21] hw: Replace DEVICE(object_new) -> qdev_new()
Message-ID: <ZdcY5KEhh9gxEp1/@intel.com>
References: <20240216110313.17039-1-philmd@linaro.org>
 <20240216110313.17039-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216110313.17039-7-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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

On Fri, Feb 16, 2024 at 12:02:57PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Fri, 16 Feb 2024 12:02:57 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 06/21] hw: Replace DEVICE(object_new) -> qdev_new()
> X-Mailer: git-send-email 2.41.0
> 
> Prefer QDev API for QDev objects, avoid the underlying QOM layer.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/arm/musicpal.c | 2 +-
>  hw/core/qdev.c    | 2 +-
>  hw/sparc/sun4m.c  | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
> index 2020f73a57..74e4d24aab 100644
> --- a/hw/arm/musicpal.c
> +++ b/hw/arm/musicpal.c
> @@ -1238,7 +1238,7 @@ static void musicpal_init(MachineState *machine)
>                            qdev_get_gpio_in(pic, MP_TIMER4_IRQ), NULL);
>  
>      /* Logically OR both UART IRQs together */
> -    uart_orgate = DEVICE(object_new(TYPE_OR_IRQ));
> +    uart_orgate = qdev_new(TYPE_OR_IRQ);
>      object_property_set_int(OBJECT(uart_orgate), "num-lines", 2, &error_fatal);
>      qdev_realize_and_unref(uart_orgate, NULL, &error_fatal);
>      qdev_connect_gpio_out(uart_orgate, 0,
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index c68d0f7c51..a271380d20 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -171,7 +171,7 @@ DeviceState *qdev_try_new(const char *name)
>      if (!module_object_class_by_name(name)) {
>          return NULL;
>      }
> -    return DEVICE(object_new(name));
> +    return qdev_new(name);
>  }
>  
>  static QTAILQ_HEAD(, DeviceListener) device_listeners
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index d52e6a7213..fedc4b8b3f 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -979,7 +979,7 @@ static void sun4m_hw_init(MachineState *machine)
>      sysbus_mmio_map(s, 0, hwdef->ms_kb_base);
>  
>      /* Logically OR both its IRQs together */
> -    ms_kb_orgate = DEVICE(object_new(TYPE_OR_IRQ));
> +    ms_kb_orgate = qdev_new(TYPE_OR_IRQ);
>      object_property_set_int(OBJECT(ms_kb_orgate), "num-lines", 2, &error_fatal);
>      qdev_realize_and_unref(ms_kb_orgate, NULL, &error_fatal);
>      sysbus_connect_irq(s, 0, qdev_get_gpio_in(ms_kb_orgate, 0));
> @@ -1000,7 +1000,7 @@ static void sun4m_hw_init(MachineState *machine)
>      sysbus_mmio_map(s, 0, hwdef->serial_base);
>  
>      /* Logically OR both its IRQs together */
> -    serial_orgate = DEVICE(object_new(TYPE_OR_IRQ));
> +    serial_orgate = qdev_new(TYPE_OR_IRQ);
>      object_property_set_int(OBJECT(serial_orgate), "num-lines", 2,
>                              &error_fatal);
>      qdev_realize_and_unref(serial_orgate, NULL, &error_fatal);
> -- 
> 2.41.0
> 
> 

