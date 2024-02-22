Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D31CC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5am-0003mC-Co; Thu, 22 Feb 2024 04:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rd5al-0003lg-65; Thu, 22 Feb 2024 04:42:11 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rd5ai-000556-Hs; Thu, 22 Feb 2024 04:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708594928; x=1740130928;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=VE+AO8expNQv4N6ileIqZhZJt4t/WBQa7Vz+9zXa078=;
 b=M64bS3hNblRf0u/HRj3b4vACZaqRP4/vRMO9Y+7GUGNLScvjuNLeH5/p
 eSq1w2vZyJof2HPO6u0lHMOh9bekrvr69zeX3glsInhnorf43I/OJMwM1
 tY11AX0Y1BocEPZAFD4rov3vPnKzJbaHjQQBN5qcC35UfyOWPRdY5um2D
 BSFPVeGqDgSpHkB5E7uIvlciEJiAEZ1SIBqAyxBDtQjDxmBkd/mqeiZuQ
 7m5EgX/DH3IB5VZ2Bffjk6F4/K9atKQp6bNIOgsc+uy4RhqH3Ze26BwZY
 Q75P5H7EkjsDjFzrCE+HSyDZUhAkdpp9nxIp4rx1VSvP1PHnqwy6HYhgv Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="14224125"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; d="scan'208";a="14224125"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2024 01:42:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5379949"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 22 Feb 2024 01:42:01 -0800
Date: Thu, 22 Feb 2024 17:55:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH 10/21] hw/usb: Inline usb_new()
Message-ID: <ZdcaHXUFaAN9E+4F@intel.com>
References: <20240216110313.17039-1-philmd@linaro.org>
 <20240216110313.17039-11-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216110313.17039-11-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
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

On Fri, Feb 16, 2024 at 12:03:01PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Fri, 16 Feb 2024 12:03:01 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 10/21] hw/usb: Inline usb_new()
> X-Mailer: git-send-email 2.41.0
> 
> Inline the 2 uses of usb_new().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/usb.h    | 1 -
>  hw/usb/bus.c        | 9 ++-------
>  hw/usb/dev-serial.c | 2 +-
>  3 files changed, 3 insertions(+), 9 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/include/hw/usb.h b/include/hw/usb.h
> index 32c23a5ca2..2d820685cc 100644
> --- a/include/hw/usb.h
> +++ b/include/hw/usb.h
> @@ -500,7 +500,6 @@ void usb_bus_release(USBBus *bus);
>  USBBus *usb_bus_find(int busnr);
>  void usb_legacy_register(const char *typename, const char *usbdevice_name,
>                           USBDevice *(*usbdevice_init)(void));
> -USBDevice *usb_new(const char *name);
>  bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp);
>  USBDevice *usb_create_simple(USBBus *bus, const char *name);
>  USBDevice *usbdevice_create(const char *cmdline);
> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
> index 148224f06a..a599e2552b 100644
> --- a/hw/usb/bus.c
> +++ b/hw/usb/bus.c
> @@ -329,11 +329,6 @@ void usb_legacy_register(const char *typename, const char *usbdevice_name,
>      }
>  }
>  
> -USBDevice *usb_new(const char *name)
> -{
> -    return USB_DEVICE(qdev_new(name));
> -}
> -
>  bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp)
>  {
>      return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
> @@ -341,7 +336,7 @@ bool usb_realize_and_unref(USBDevice *dev, USBBus *bus, Error **errp)
>  
>  USBDevice *usb_create_simple(USBBus *bus, const char *name)
>  {
> -    USBDevice *dev = usb_new(name);
> +    USBDevice *dev = USB_DEVICE(qdev_new(name));
>  
>      usb_realize_and_unref(dev, bus, &error_abort);
>      return dev;
> @@ -693,7 +688,7 @@ USBDevice *usbdevice_create(const char *driver)
>          return NULL;
>      }
>  
> -    dev = f->usbdevice_init ? f->usbdevice_init() : usb_new(f->name);
> +    dev = f->usbdevice_init ? f->usbdevice_init() : USB_DEVICE(qdev_new(f->name));
>      if (!dev) {
>          error_report("Failed to create USB device '%s'", f->name);
>          return NULL;
> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> index 63047d79cf..6e79c46d53 100644
> --- a/hw/usb/dev-serial.c
> +++ b/hw/usb/dev-serial.c
> @@ -624,7 +624,7 @@ static USBDevice *usb_braille_init(void)
>          return NULL;
>      }
>  
> -    dev = usb_new("usb-braille");
> +    dev = USB_DEVICE(qdev_new("usb-braille"));
>      qdev_prop_set_chr(&dev->qdev, "chardev", cdrv);
>      return dev;
>  }
> -- 
> 2.41.0
> 
> 

