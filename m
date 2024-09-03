Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD628CD3448
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slWod-0008Tc-Ba; Tue, 03 Sep 2024 12:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slWoa-0008FC-N2
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:55:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1slWoM-0000oG-Ka
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725382520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TzGHsTPwbo7y9GvAFEd0eWxpbpA9qjgaCZBT9AhWJio=;
 b=GDNylC0MSIIgHgDbhEB7S9kO42YAfButSgh+Z4+hdb3dOWsmuk66UAATlOOfsL8k5hYGVs
 pmy9MdZMqeY6fn+5TCTN2//V/TJSS50caVaaw5dzKMlaCQbr4nVwS8TlFvCFpS0t4AXB0L
 yoUdXHWnIh2dqVzyzCBoVIV4dSmGjnQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-04KanFS2NYiOMYXlgduxxA-1; Tue, 03 Sep 2024 12:55:19 -0400
X-MC-Unique: 04KanFS2NYiOMYXlgduxxA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5bed5e6c46eso4184572a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725382518; x=1725987318;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TzGHsTPwbo7y9GvAFEd0eWxpbpA9qjgaCZBT9AhWJio=;
 b=cpOfgY/wf+nF27N7Vu43Yls3D+ka8fLAyamRY+XAId6hZ0g/iFDr+WTAgHl0zbBX/I
 VE+FLRW53Yuoxe6Z8wNWmSqqY8ECLjinI0OLDgnM4S9pZAqYjIc1NZGT53MyV9siSoha
 kuI6dXlrWF7AuxnCDezzxozyxZl16wzubRSKWVoff25Nwo4PZo7jHsFuFu7ouEcZAnXc
 SyBZJF7fntdYSSWPtbOoi5pVfzBLo5tkxEfCU0tB5QDjwT7AjEcLmr22xGW175KKlTpn
 4qdvMC5w0jX0wSaJI4isHfzpwfRxNAjw4sbqCi+Xc2/jblhP92yWP3aFnENCUmSYTx7u
 WNOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN8UNGvcgjHOhMnXLVGG2T5HiK+DpCnovsWiryqm0fsYxca2DRvYmTHy/jTMotURhrwG2al7hCdeWL@nongnu.org
X-Gm-Message-State: AOJu0Ywifst9TfL3DaoMVUAyLKIFi98zGnM4cmH0J0L5KavlaNBI7Blo
 dPlj0Xp/0Gxoq+/A1R047pVXES1NkY/B22NJjwbYp4wVVfNVhfARnNqzLYtjYBcTY9Lj46YQb3f
 x4XCkxpcs/Sh9RqJ8QCDSKfHg50zKhn4e9pGQLQca7VeMB2gcJI4M
X-Received: by 2002:a17:907:a02:b0:a7a:9f0f:ab26 with SMTP id
 a640c23a62f3a-a89d878234bmr820436566b.23.1725382517905; 
 Tue, 03 Sep 2024 09:55:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOOwIAUmzXiaQjI7KvsVaIIway9hBrm5uO6ZkNkD46qFDDNSr4EcL61eA8tKCsyG7rst9zew==
X-Received: by 2002:a17:907:a02:b0:a7a:9f0f:ab26 with SMTP id
 a640c23a62f3a-a89d878234bmr820432466b.23.1725382517235; 
 Tue, 03 Sep 2024 09:55:17 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.101.29])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a8989196975sm707109066b.135.2024.09.03.09.55.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 09:55:16 -0700 (PDT)
Message-ID: <762867ba-8980-44f6-a9a6-5e766bc6a60b@redhat.com>
Date: Tue, 3 Sep 2024 18:55:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 00/53] arm: Drop deprecated boards
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 9/3/24 18:06, Peter Maydell wrote:
> This patchset removes the various Arm machines which we deprecated
> for the 9.0 release and are therefore allowed to remove for the 9.2
> release:
>   akita, borzoi, cheetah, connex, mainstone, n800, n810,
>   spitz, terrier, tosa, verdex, z2
> We get to drop over 30,000 lines of unmaintained code. So it's
> a big patchset but it's almost all deletions.
> 
> We have some command line options which were documented as only used
> by the pxa2xx LCD display driver: -portrait and -rotate.  These
> allowed the user to tell the display device to rotate its output by
> 90/180/270 degrees (and the ui input layer to correspondingly rotate
> mouse event coordinates to match).  I didn't realize these existed
> when we deprecated the pxa2xx machines -- do we need a separate
> deprecate-and-drop period to remove the command line options?  (If
> so, I can drop the relevant patch from this series.)

They are not specific to PXA; PXA LCD is the only one that supports 
passing it to the guest, but the logic is generic: if (for whatever 
reason) your VM generates output that is rotated, you can use the option 
to rotate mouse input.

It's okay to remove it without deprecation notice, but also to keep it. 
Your choice, it's not a lot of code.

Paolo

> The series includes removal of some code which while not strictly
> specific to these machines was in practice used only by them:
>   * the OneNAND flash memory device
>   * the PCMCIA subsystem
>   * the MUSB USB2.0 OTG USB controller chip (hcd-musb)
> 
> Removing these machines hopefully will make it easier to complete
> some API transitions (e.g.  there is only one caller of the
> ui/input-legacy.c function qemu_add_kbd_event_handler() left, and
> five of qemu_add_mouse_event_handler(); a lot of
> qemu_register_reset() calls have gone; and so on).
> 
> (There will be a trivial conflict with my reset patch that gets rid
> of direct setting of DeviceClass::reset in some places, but I'll fix
> that up when merging.)
> 
> thanks
> -- PMM
> 
> Peter Maydell (53):
>    hw/arm: Remove deprecated akita, borzoi, spitz, terrier, tosa boards
>    hw/input: Drop ADS7846 device
>    hw/adc: Remove MAX111X device
>    hw/gpio: Remove MAX7310 device
>    hw/ide: Remove DSCM-1XXXX microdrive device model
>    hw/display: Remove tc6393xb device
>    hw/arm/KConfig: Replace ZAURUS with ZAURUS_SCOOP
>    hw/arm: Remove 'cheetah' machine
>    hw/arm: Remove 'connex' and 'verdex' machines
>    hw/arm: Remove 'mainstone' machine
>    hw/misc: Remove MAINSTONE_FPGA device
>    hw/arm: Remove 'z2' machine
>    hw/arm: Remove STRONGARM->PXA2XX dependency
>    hw/timer/pxa2xx_timer: Remove use of pxa.h header
>    hw/arm: Remove pxa2xx.c
>    hw/sd: Remove pxa2xx_mmci.c
>    hw/input: Remove pxa2xx_keypad
>    hw/display: Remove pxa2xx_lcd.c
>    hw/dma: Remove pxa2xx_dma
>    hw/pcmcia: Remove pxa2xx pcmcia device
>    hw/arm: Remove pxa2xx_gpio
>    hw/arm: Remove pxa2xx_pic
>    hw/timer: Remove pxa27x-timer
>    vl.c: Remove pxa2xx-specific -portrait and -rotate options
>    hw/arm: Remove 'n800' and 'n810' machines
>    hw/misc: Remove cbus
>    hw/display: Remove Blizzard display device
>    hw/input: Remove tsc2005 touchscreen controller
>    hw/input: Remove tsc210x device
>    hw/rtc: Remove twl92230 device
>    hw/input: Remove lm832x device
>    hw/block: Remove OneNAND device
>    hw/usb: Remove tusb6010 USB controller
>    hw/usb: Remove MUSB USB host controller
>    hw: Remove PCMCIA subsystem
>    docs: Document removal of old Arm boards
>    hw/arm: Remove omap2.c
>    hw/gpio: Remove TYPE_OMAP2_GPIO
>    hw/char: Remove omap2_uart
>    hw/intc: Remove omap2-intc device
>    hw/sd: Remove omap2_mmc device
>    hw/misc: Remove omap_sdrc device
>    hw/misc: Remove omap_gpmc
>    hw/timer: Remove omap_gptimer
>    hw/timer: Remove omap_synctimer
>    hw/block: Remove ecc
>    hw/ssi: Remove omap_mcspi
>    hw/misc: Remove omap_tap device
>    hw/display: Remove omap_dss
>    hw/misc: Remove omap_l4 device
>    hw/misc/omap_clk: Remove OMAP2-specifics
>    hw/dma: Remove omap_dma4 device
>    hw: Remove omap2 specific defines and enums
> 
>   MAINTAINERS                             |   58 +-
>   docs/about/deprecated.rst               |   15 -
>   docs/about/removed-features.rst         |   15 +
>   docs/system/arm/gumstix.rst             |   21 -
>   docs/system/arm/mainstone.rst           |   25 -
>   docs/system/arm/nseries.rst             |   33 -
>   docs/system/arm/palm.rst                |   23 -
>   docs/system/arm/xscale.rst              |   35 -
>   docs/system/target-arm.rst              |    5 -
>   configs/devices/arm-softmmu/default.mak |    7 -
>   include/hw/adc/max111x.h                |   56 -
>   include/hw/arm/omap.h                   |  350 +--
>   include/hw/arm/pxa.h                    |  197 --
>   include/hw/block/flash.h                |   14 -
>   include/hw/display/blizzard.h           |   21 -
>   include/hw/display/tc6393xb.h           |   21 -
>   include/hw/input/lm832x.h               |   28 -
>   include/hw/input/tsc2xxx.h              |   41 -
>   include/hw/misc/cbus.h                  |   31 -
>   include/hw/pcmcia.h                     |   66 -
>   include/hw/usb/hcd-musb.h               |   49 -
>   include/sysemu/sysemu.h                 |    1 -
>   hw/adc/max111x.c                        |  236 --
>   hw/arm/gumstix.c                        |  141 --
>   hw/arm/mainstone.c                      |  175 --
>   hw/arm/nseries.c                        | 1473 ------------
>   hw/arm/omap2.c                          | 2715 -----------------------
>   hw/arm/palm.c                           |  324 ---
>   hw/arm/pxa2xx.c                         | 2393 --------------------
>   hw/arm/pxa2xx_gpio.c                    |  365 ---
>   hw/arm/pxa2xx_pic.c                     |  359 ---
>   hw/arm/spitz.c                          | 1284 -----------
>   hw/arm/tosa.c                           |  327 ---
>   hw/arm/z2.c                             |  355 ---
>   hw/block/ecc.c                          |   91 -
>   hw/block/onenand.c                      |  872 --------
>   hw/char/omap_uart.c                     |  113 -
>   hw/display/blizzard.c                   | 1026 ---------
>   hw/display/omap_dss.c                   | 1093 ---------
>   hw/display/pxa2xx_lcd.c                 | 1451 ------------
>   hw/display/tc6393xb.c                   |  568 -----
>   hw/dma/omap_dma.c                       |  451 +---
>   hw/dma/pxa2xx_dma.c                     |  591 -----
>   hw/gpio/max7310.c                       |  217 --
>   hw/gpio/omap_gpio.c                     |  557 -----
>   hw/ide/microdrive.c                     |  644 ------
>   hw/input/ads7846.c                      |  186 --
>   hw/input/lm832x.c                       |  528 -----
>   hw/input/pxa2xx_keypad.c                |  331 ---
>   hw/input/tsc2005.c                      |  571 -----
>   hw/input/tsc210x.c                      | 1241 -----------
>   hw/intc/omap_intc.c                     |  276 ---
>   hw/misc/cbus.c                          |  619 ------
>   hw/misc/mst_fpga.c                      |  269 ---
>   hw/misc/omap_clk.c                      |  527 +----
>   hw/misc/omap_gpmc.c                     |  898 --------
>   hw/misc/omap_l4.c                       |  162 --
>   hw/misc/omap_sdrc.c                     |  167 --
>   hw/misc/omap_tap.c                      |  117 -
>   hw/pcmcia/pcmcia.c                      |   24 -
>   hw/pcmcia/pxa2xx.c                      |  248 ---
>   hw/rtc/twl92230.c                       |  882 --------
>   hw/sd/omap_mmc.c                        |   63 -
>   hw/sd/pxa2xx_mmci.c                     |  594 -----
>   hw/ssi/omap_spi.c                       |  380 ----
>   hw/timer/omap_gptimer.c                 |  512 -----
>   hw/timer/omap_synctimer.c               |  110 -
>   hw/timer/pxa2xx_timer.c                 |   25 -
>   hw/usb/hcd-musb.c                       | 1553 -------------
>   hw/usb/tusb6010.c                       |  850 -------
>   system/globals.c                        |    1 -
>   system/vl.c                             |   11 -
>   ui/input.c                              |   36 -
>   hw/Kconfig                              |    1 -
>   hw/adc/Kconfig                          |    3 -
>   hw/adc/meson.build                      |    1 -
>   hw/arm/Kconfig                          |   90 +-
>   hw/arm/meson.build                      |    9 -
>   hw/block/Kconfig                        |    6 -
>   hw/block/meson.build                    |    2 -
>   hw/display/Kconfig                      |    3 -
>   hw/display/meson.build                  |    4 -
>   hw/dma/meson.build                      |    1 -
>   hw/gpio/Kconfig                         |    7 +-
>   hw/gpio/meson.build                     |    3 +-
>   hw/ide/Kconfig                          |    6 -
>   hw/ide/meson.build                      |    1 -
>   hw/input/Kconfig                        |   13 -
>   hw/input/meson.build                    |    5 -
>   hw/input/trace-events                   |    3 -
>   hw/meson.build                          |    1 -
>   hw/misc/Kconfig                         |    1 -
>   hw/misc/meson.build                     |    6 -
>   hw/pcmcia/Kconfig                       |    2 -
>   hw/pcmcia/meson.build                   |    2 -
>   hw/rtc/Kconfig                          |    4 -
>   hw/rtc/meson.build                      |    1 -
>   hw/sd/meson.build                       |    1 -
>   hw/sd/trace-events                      |    4 -
>   hw/ssi/meson.build                      |    1 -
>   hw/timer/Kconfig                        |    3 +
>   hw/timer/meson.build                    |    4 +-
>   hw/usb/Kconfig                          |    8 -
>   hw/usb/meson.build                      |    2 -
>   qemu-options.hx                         |   16 -
>   tests/avocado/machine_arm_n8x0.py       |   49 -
>   106 files changed, 39 insertions(+), 30338 deletions(-)
>   delete mode 100644 docs/system/arm/gumstix.rst
>   delete mode 100644 docs/system/arm/mainstone.rst
>   delete mode 100644 docs/system/arm/nseries.rst
>   delete mode 100644 docs/system/arm/palm.rst
>   delete mode 100644 docs/system/arm/xscale.rst
>   delete mode 100644 include/hw/adc/max111x.h
>   delete mode 100644 include/hw/arm/pxa.h
>   delete mode 100644 include/hw/display/blizzard.h
>   delete mode 100644 include/hw/display/tc6393xb.h
>   delete mode 100644 include/hw/input/lm832x.h
>   delete mode 100644 include/hw/input/tsc2xxx.h
>   delete mode 100644 include/hw/misc/cbus.h
>   delete mode 100644 include/hw/pcmcia.h
>   delete mode 100644 include/hw/usb/hcd-musb.h
>   delete mode 100644 hw/adc/max111x.c
>   delete mode 100644 hw/arm/gumstix.c
>   delete mode 100644 hw/arm/mainstone.c
>   delete mode 100644 hw/arm/nseries.c
>   delete mode 100644 hw/arm/omap2.c
>   delete mode 100644 hw/arm/palm.c
>   delete mode 100644 hw/arm/pxa2xx.c
>   delete mode 100644 hw/arm/pxa2xx_gpio.c
>   delete mode 100644 hw/arm/pxa2xx_pic.c
>   delete mode 100644 hw/arm/spitz.c
>   delete mode 100644 hw/arm/tosa.c
>   delete mode 100644 hw/arm/z2.c
>   delete mode 100644 hw/block/ecc.c
>   delete mode 100644 hw/block/onenand.c
>   delete mode 100644 hw/display/blizzard.c
>   delete mode 100644 hw/display/omap_dss.c
>   delete mode 100644 hw/display/pxa2xx_lcd.c
>   delete mode 100644 hw/display/tc6393xb.c
>   delete mode 100644 hw/dma/pxa2xx_dma.c
>   delete mode 100644 hw/gpio/max7310.c
>   delete mode 100644 hw/ide/microdrive.c
>   delete mode 100644 hw/input/ads7846.c
>   delete mode 100644 hw/input/lm832x.c
>   delete mode 100644 hw/input/pxa2xx_keypad.c
>   delete mode 100644 hw/input/tsc2005.c
>   delete mode 100644 hw/input/tsc210x.c
>   delete mode 100644 hw/misc/cbus.c
>   delete mode 100644 hw/misc/mst_fpga.c
>   delete mode 100644 hw/misc/omap_gpmc.c
>   delete mode 100644 hw/misc/omap_l4.c
>   delete mode 100644 hw/misc/omap_sdrc.c
>   delete mode 100644 hw/misc/omap_tap.c
>   delete mode 100644 hw/pcmcia/pcmcia.c
>   delete mode 100644 hw/pcmcia/pxa2xx.c
>   delete mode 100644 hw/rtc/twl92230.c
>   delete mode 100644 hw/sd/pxa2xx_mmci.c
>   delete mode 100644 hw/ssi/omap_spi.c
>   delete mode 100644 hw/timer/omap_gptimer.c
>   delete mode 100644 hw/timer/omap_synctimer.c
>   delete mode 100644 hw/usb/hcd-musb.c
>   delete mode 100644 hw/usb/tusb6010.c
>   delete mode 100644 hw/pcmcia/Kconfig
>   delete mode 100644 hw/pcmcia/meson.build
>   delete mode 100644 tests/avocado/machine_arm_n8x0.py
> 


