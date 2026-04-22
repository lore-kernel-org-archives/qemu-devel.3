Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE410F9B5E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFTE4-0004FG-Rs; Wed, 22 Apr 2026 04:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wFTDv-0004EK-0G
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:46:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wFTDs-0004SP-GE
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776847574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wrQwsl89XzUazpGeyAMI3WHV90bg0/b0U9leX7R/mIg=;
 b=c8fioNDUyJBtGYxNEuPv++llFWuqAjPbpkYZ7ksNc1IGfJ4VkmfwhMRyJvumlYJrcgeoCZ
 9KyXxOb4y24pAijhhuqzJdnIgeOdLlNRsitRiwQxRP9xyzJFdn4nhZ0+RlFd6PrTUsT39z
 wYR5QQe++BXITiu5WyKnlSMdPfJpy4g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-fLrTpveqNzW19a5XTl0jFg-1; Wed, 22 Apr 2026 04:46:13 -0400
X-MC-Unique: fLrTpveqNzW19a5XTl0jFg-1
X-Mimecast-MFC-AGG-ID: fLrTpveqNzW19a5XTl0jFg_1776847572
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4411a529bc0so2230741f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776847572; x=1777452372; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wrQwsl89XzUazpGeyAMI3WHV90bg0/b0U9leX7R/mIg=;
 b=dKVU/nIWBMxLVqG/OrSDoHU5JIpO55uSDcyE2iSApH9c0cPQAuGMCGElpjSRKQwkst
 pOUL+LUwnd/FxNoHKJIFEs3WgAcIggH611gaQVIU5RGz+o3xQ8suV3teOrwDMbd0Rq7M
 fZ9RMmcqpRWGdZruX9s5EE9pNtz1o+l1ZBELqnj7qm0VN+sIzsLckdFDe2+NNEL5ns7q
 ZE194ucil0u1BYV3edhugJ1CxUMHHUPA0j5MApPUTkyxZD9uwW0WHJaQww/gopTYs6YC
 WUJAoRHCvQVhzmS5iMxK/vI7ZV+aJCil5QDBfUe9SRmU6T+iW2X4VE4yn2GwaZCwtcjv
 AZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776847572; x=1777452372;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wrQwsl89XzUazpGeyAMI3WHV90bg0/b0U9leX7R/mIg=;
 b=nc0Cr0w2pYcgSYEP64cmGWXcoTGkC+MaJFx9TbhcxU8n6JIU6HwvXGMp5Hp3atucTj
 tXkTn/IYq5I4+EmeV8Wlp/5M7DHZ1Zw0Rl6GprKgndlCJa9rhCdltQzen5V82h3Ghl3V
 sB/m1Q3zAkMGl1lP1ro2GYAp/08YrZYrTnIen0DHrvRWjWjWFME/QRO1dtkJJv4O0taP
 htdMfYBRt1dyRs9Q5Bsv2jP5jTVipsACRws2Dv6vh8rQHPIKYMNUp9pMzIoQxPLoJ00h
 Wt2rFg61OppeWo3VtHhs/UNeRcMZ+ZbKA4UQDXq+Bd9LmS21ruF/UwfRuj0TLu7Aplje
 F/YA==
X-Gm-Message-State: AOJu0YyokorENUKzft+v7PDLoKPiDxLOpF7FKvnYL8xknaLz5TYUxZM+
 7yHn2onsaZCsVFgqXDnEFO0kk5K3CE5mXQjbv41JxO9syJCnKJgmDyWTM6CIdceD6oE1zfiP40O
 APZ7L2Z9uRnuck24HcDgNaY6EercoagQSG5zl/iCoPc3Yde6o7lX+aNs9
X-Gm-Gg: AeBDieuoMRp4bwHYBzqk9PXVIa/hOezif1Pi+gVOGNd7Wc5LhfahySjWuEQyCNAQpIr
 I0R4vkEKYU2HiWcp2nL6Jr+E9KxxgPHBEdGXwFcMA63YZDxPmhuZ4U7eT8z6ukUnYiszWTpMh+x
 YDmSn2QocalNsufZsyV6DtDRKmqTdM17bZSWwMn/vlIQOAoc7V1A4aqb3P95oSFBefcGrTGYOEb
 Sss7QFjpug5tPHaSQksZPxAoTzODplrOteC41hgYms5KbcH1gG/bHGxHcP9pNPOPFFuyt6ejPvW
 yEoo/83HWogNCTmX2McJRp+zpM8k6d0CcOIv64boPi1oqsQVHi8ZdNKEj1cKxBMubqbVg9GW1ZW
 LrfhM+fLdiLkTTxKd3o7xt7fIpg3WTLpGbew8Ho1xGuXX1dTXur7Fbg==
X-Received: by 2002:a5d:5f92:0:b0:43b:9c73:2933 with SMTP id
 ffacd0b85a97d-43fe3dc1795mr32896689f8f.15.1776847571324; 
 Wed, 22 Apr 2026 01:46:11 -0700 (PDT)
X-Received: by 2002:a5d:5f92:0:b0:43b:9c73:2933 with SMTP id
 ffacd0b85a97d-43fe3dc1795mr32896617f8f.15.1776847570637; 
 Wed, 22 Apr 2026 01:46:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d5b1sm47962589f8f.30.2026.04.22.01.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 01:46:10 -0700 (PDT)
Date: Wed, 22 Apr 2026 04:46:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bin Meng <bmeng.cn@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Aurelien Jarno <aurelien@aurel32.net>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Darren Kenny <darren.kenny@oracle.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH v2 02/10] MAINTAINERS: Remove my disfunctional emails
Message-ID: <20260422044555-mutt-send-email-mst@kernel.org>
References: <20260422080406.62638-1-philmd@linaro.org>
 <20260422080406.62638-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422080406.62638-3-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 22, 2026 at 10:03:57AM +0200, Philippe Mathieu-Daudé wrote:
> With retrospective, mentioning email in authorship wasn't
> really useful, more now than these addresses are dead:
>  - f4bug@amsat.org
>  - philmd@redhat.com
> Simply remove them.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/sd/sdmmc-internal.h                      | 2 +-
>  include/crypto/tls-cipher-suites.h          | 2 +-
>  include/hw/i2c/arm_sbcon_i2c.h              | 2 +-
>  include/hw/misc/bcm2835_thermal.h           | 2 +-
>  include/hw/misc/led.h                       | 2 +-
>  include/hw/timer/bcm2835_systmr.h           | 2 +-
>  include/qemu/units.h                        | 2 +-
>  crypto/tls-cipher-suites.c                  | 2 +-
>  hw/i386/fw_cfg.c                            | 2 +-
>  hw/i386/pc_sysfw_ovmf-stubs.c               | 2 +-
>  hw/misc/bcm2835_thermal.c                   | 2 +-
>  hw/misc/led.c                               | 2 +-
>  hw/ppc/fw_cfg.c                             | 2 +-
>  hw/sd/sd.c                                  | 2 +-
>  hw/timer/bcm2835_systmr.c                   | 2 +-
>  hw/usb/bus-stub.c                           | 2 +-
>  stubs/fw_cfg.c                              | 2 +-
>  stubs/hotplug-stubs.c                       | 2 +-
>  stubs/qdev.c                                | 2 +-
>  tests/qtest/fuzz-sb16-test.c                | 2 +-
>  tests/qtest/fuzz-sdcard-test.c              | 2 +-
>  tests/qtest/sdhci-test.c                    | 2 +-
>  tests/functional/aarch64/test_raspi3.py     | 2 +-
>  tests/functional/arm/test_bflt.py           | 2 +-
>  tests/functional/arm/test_raspi2.py         | 2 +-
>  tests/functional/m68k/test_nextcube.py      | 2 +-
>  tests/functional/mips/test_malta.py         | 2 +-
>  tests/functional/mips64el/test_fuloong2e.py | 2 +-
>  tests/functional/mips64el/test_malta.py     | 2 +-
>  tests/functional/mipsel/test_malta.py       | 2 +-
>  tests/functional/ppc/test_40p.py            | 2 +-
>  tests/functional/qemu_test/tesseract.py     | 2 +-
>  32 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
> index c115f472efe..f9282a9712d 100644
> --- a/hw/sd/sdmmc-internal.h
> +++ b/hw/sd/sdmmc-internal.h
> @@ -1,7 +1,7 @@
>  /*
>   * SD/MMC cards common
>   *
> - * Copyright (c) 2018  Philippe Mathieu-Daudé <f4bug@amsat.org>
> + * Copyright (c) 2018  Philippe Mathieu-Daudé
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or later.
>   * See the COPYING file in the top-level directory.
> diff --git a/include/crypto/tls-cipher-suites.h b/include/crypto/tls-cipher-suites.h
> index 3bd2003f32d..31697a7d6de 100644
> --- a/include/crypto/tls-cipher-suites.h
> +++ b/include/crypto/tls-cipher-suites.h
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (c) 2018-2020 Red Hat, Inc.
>   *
> - * Author: Philippe Mathieu-Daudé <philmd@redhat.com>
> + * Author: Philippe Mathieu-Daudé
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> diff --git a/include/hw/i2c/arm_sbcon_i2c.h b/include/hw/i2c/arm_sbcon_i2c.h
> index 39b99f57bfb..537de428e1f 100644
> --- a/include/hw/i2c/arm_sbcon_i2c.h
> +++ b/include/hw/i2c/arm_sbcon_i2c.h
> @@ -5,7 +5,7 @@
>   *
>   * Copyright (c) 2006-2007 CodeSourcery.
>   * Copyright (c) 2012 Oskar Andero <oskar.andero@gmail.com>
> - * Copyright (C) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
> + * Copyright (C) 2020 Philippe Mathieu-Daudé
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> diff --git a/include/hw/misc/bcm2835_thermal.h b/include/hw/misc/bcm2835_thermal.h
> index 13ffc61c1a7..04eda5cb83f 100644
> --- a/include/hw/misc/bcm2835_thermal.h
> +++ b/include/hw/misc/bcm2835_thermal.h
> @@ -1,7 +1,7 @@
>  /*
>   * BCM2835 dummy thermal sensor
>   *
> - * Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
> + * Copyright (C) 2019 Philippe Mathieu-Daudé
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
> index 4d077a7c43e..89ccbad4660 100644
> --- a/include/hw/misc/led.h
> +++ b/include/hw/misc/led.h
> @@ -1,7 +1,7 @@
>  /*
>   * QEMU single LED device
>   *
> - * Copyright (C) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
> + * Copyright (C) 2020 Philippe Mathieu-Daudé
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835_systmr.h
> index 0674a18f12d..770e464937b 100644
> --- a/include/hw/timer/bcm2835_systmr.h
> +++ b/include/hw/timer/bcm2835_systmr.h
> @@ -1,7 +1,7 @@
>  /*
>   * BCM2835 SYS timer emulation
>   *
> - * Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
> + * Copyright (c) 2019 Philippe Mathieu-Daudé
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> diff --git a/include/qemu/units.h b/include/qemu/units.h
> index 692db3fbb26..4764e301e5b 100644
> --- a/include/qemu/units.h
> +++ b/include/qemu/units.h
> @@ -2,7 +2,7 @@
>   * IEC binary prefixes definitions
>   *
>   * Copyright (C) 2015 Nikunj A Dadhania, IBM Corporation
> - * Copyright (C) 2018 Philippe Mathieu-Daudé <f4bug@amsat.org>
> + * Copyright (C) 2018 Philippe Mathieu-Daudé
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
> index d9b61d0c08a..a6566f13c9b 100644
> --- a/crypto/tls-cipher-suites.c
> +++ b/crypto/tls-cipher-suites.c
> @@ -3,7 +3,7 @@
>   *
>   * Copyright (c) 2018-2020 Red Hat, Inc.
>   *
> - * Author: Philippe Mathieu-Daudé <philmd@redhat.com>
> + * Author: Philippe Mathieu-Daudé
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index 5670e8553ea..858e6ca9c53 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -4,7 +4,7 @@
>   * Copyright (c) 2019 Red Hat, Inc.
>   *
>   * Author:
> - *   Philippe Mathieu-Daudé <philmd@redhat.com>
> + *   Philippe Mathieu-Daudé
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   *
> diff --git a/hw/i386/pc_sysfw_ovmf-stubs.c b/hw/i386/pc_sysfw_ovmf-stubs.c
> index b53906a0521..42e300ddec4 100644
> --- a/hw/i386/pc_sysfw_ovmf-stubs.c
> +++ b/hw/i386/pc_sysfw_ovmf-stubs.c
> @@ -4,7 +4,7 @@
>   * Copyright (c) 2021 Red Hat, Inc.
>   *
>   * Author:
> - *   Philippe Mathieu-Daudé <philmd@redhat.com>
> + *   Philippe Mathieu-Daudé
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   *
> diff --git a/hw/misc/bcm2835_thermal.c b/hw/misc/bcm2835_thermal.c
> index 0dc1be15b4a..413c4179fed 100644
> --- a/hw/misc/bcm2835_thermal.c
> +++ b/hw/misc/bcm2835_thermal.c
> @@ -1,7 +1,7 @@
>  /*
>   * BCM2835 dummy thermal sensor
>   *
> - * Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
> + * Copyright (C) 2019 Philippe Mathieu-Daudé
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> diff --git a/hw/misc/led.c b/hw/misc/led.c
> index d9256aaaf56..8b758c1b76d 100644
> --- a/hw/misc/led.c
> +++ b/hw/misc/led.c
> @@ -1,7 +1,7 @@
>  /*
>   * QEMU single LED device
>   *
> - * Copyright (C) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
> + * Copyright (C) 2020 Philippe Mathieu-Daudé
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> diff --git a/hw/ppc/fw_cfg.c b/hw/ppc/fw_cfg.c
> index a88b5c4bde2..071cf855c23 100644
> --- a/hw/ppc/fw_cfg.c
> +++ b/hw/ppc/fw_cfg.c
> @@ -4,7 +4,7 @@
>   * Copyright (c) 2019 Red Hat, Inc.
>   *
>   * Author:
> - *   Philippe Mathieu-Daudé <philmd@redhat.com>
> + *   Philippe Mathieu-Daudé
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   *
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 13ea54df380..ebe6e35b15e 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -6,7 +6,7 @@
>   *
>   * Copyright (c) 2006 Andrzej Zaborowski  <balrog@zabor.org>
>   * Copyright (c) 2007 CodeSourcery
> - * Copyright (c) 2018 Philippe Mathieu-Daudé <f4bug@amsat.org>
> + * Copyright (c) 2018 Philippe Mathieu-Daudé
>   *
>   * Redistribution and use in source and binary forms, with or without
>   * modification, are permitted provided that the following conditions
> diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
> index 00bcfcd05c6..06a919b1f8b 100644
> --- a/hw/timer/bcm2835_systmr.c
> +++ b/hw/timer/bcm2835_systmr.c
> @@ -1,7 +1,7 @@
>  /*
>   * BCM2835 SYS timer emulation
>   *
> - * Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
> + * Copyright (C) 2019 Philippe Mathieu-Daudé
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   *
> diff --git a/hw/usb/bus-stub.c b/hw/usb/bus-stub.c
> index a7c3909e967..7cf1b494117 100644
> --- a/hw/usb/bus-stub.c
> +++ b/hw/usb/bus-stub.c
> @@ -1,7 +1,7 @@
>  /*
>   * QEMU USB device emulation stubs
>   *
> - * Copyright (C) 2021 Philippe Mathieu-Daudé <f4bug@amsat.org>
> + * Copyright (C) 2021 Philippe Mathieu-Daudé
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> diff --git a/stubs/fw_cfg.c b/stubs/fw_cfg.c
> index bb1e3c8aa95..e7a9f714f35 100644
> --- a/stubs/fw_cfg.c
> +++ b/stubs/fw_cfg.c
> @@ -4,7 +4,7 @@
>   * Copyright (c) 2019 Red Hat, Inc.
>   *
>   * Author:
> - *   Philippe Mathieu-Daudé <philmd@redhat.com>
> + *   Philippe Mathieu-Daudé
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   *
> diff --git a/stubs/hotplug-stubs.c b/stubs/hotplug-stubs.c
> index 23a1678dbbc..0f592ee1391 100644
> --- a/stubs/hotplug-stubs.c
> +++ b/stubs/hotplug-stubs.c
> @@ -4,7 +4,7 @@
>   * Copyright (c) Red Hat
>   *
>   * Authors:
> - *  Philippe Mathieu-Daudé <philmd@redhat.com>,
> + *  Philippe Mathieu-Daudé,
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   *
> diff --git a/stubs/qdev.c b/stubs/qdev.c
> index 7e957b3e524..61596de5f87 100644
> --- a/stubs/qdev.c
> +++ b/stubs/qdev.c
> @@ -4,7 +4,7 @@
>   * Copyright (c) 2021 Red Hat, Inc.
>   *
>   * Author:
> - *   Philippe Mathieu-Daudé <philmd@redhat.com>
> + *   Philippe Mathieu-Daudé
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   *
> diff --git a/tests/qtest/fuzz-sb16-test.c b/tests/qtest/fuzz-sb16-test.c
> index fc445b18710..9995ad88685 100644
> --- a/tests/qtest/fuzz-sb16-test.c
> +++ b/tests/qtest/fuzz-sb16-test.c
> @@ -1,7 +1,7 @@
>  /*
>   * QTest fuzzer-generated testcase for sb16 audio device
>   *
> - * Copyright (c) 2021 Philippe Mathieu-Daudé <f4bug@amsat.org>
> + * Copyright (c) 2021 Philippe Mathieu-Daudé
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> diff --git a/tests/qtest/fuzz-sdcard-test.c b/tests/qtest/fuzz-sdcard-test.c
> index cd134cdf556..6d8be9d1195 100644
> --- a/tests/qtest/fuzz-sdcard-test.c
> +++ b/tests/qtest/fuzz-sdcard-test.c
> @@ -1,7 +1,7 @@
>  /*
>   * QTest fuzzer-generated testcase for sdcard device
>   *
> - * Copyright (c) 2021 Philippe Mathieu-Daudé <f4bug@amsat.org>
> + * Copyright (c) 2021 Philippe Mathieu-Daudé
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> diff --git a/tests/qtest/sdhci-test.c b/tests/qtest/sdhci-test.c
> index 7b32711c8f8..cde132228eb 100644
> --- a/tests/qtest/sdhci-test.c
> +++ b/tests/qtest/sdhci-test.c
> @@ -1,7 +1,7 @@
>  /*
>   * QTest testcase for SDHCI controllers
>   *
> - * Written by Philippe Mathieu-Daudé <f4bug@amsat.org>
> + * Written by Philippe Mathieu-Daudé
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or later.
>   * See the COPYING file in the top-level directory.
> diff --git a/tests/functional/aarch64/test_raspi3.py b/tests/functional/aarch64/test_raspi3.py
> index 74f6630ed26..ae9eed3589f 100755
> --- a/tests/functional/aarch64/test_raspi3.py
> +++ b/tests/functional/aarch64/test_raspi3.py
> @@ -3,7 +3,7 @@
>  # Functional test that boots a Linux kernel on a Raspberry Pi machine
>  # and checks the console
>  #
> -# Copyright (c) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
> +# Copyright (c) 2020 Philippe Mathieu-Daudé
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  
> diff --git a/tests/functional/arm/test_bflt.py b/tests/functional/arm/test_bflt.py
> index f273fc83546..835a3354a03 100755
> --- a/tests/functional/arm/test_bflt.py
> +++ b/tests/functional/arm/test_bflt.py
> @@ -2,7 +2,7 @@
>  #
>  # Test the bFLT loader format
>  #
> -# Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
> +# Copyright (C) 2019 Philippe Mathieu-Daudé
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  
> diff --git a/tests/functional/arm/test_raspi2.py b/tests/functional/arm/test_raspi2.py
> index d3c7aaa39b0..fe644f04cf4 100755
> --- a/tests/functional/arm/test_raspi2.py
> +++ b/tests/functional/arm/test_raspi2.py
> @@ -3,7 +3,7 @@
>  # Functional test that boots a Linux kernel on a Raspberry Pi machine
>  # and checks the console
>  #
> -# Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
> +# Copyright (c) 2019 Philippe Mathieu-Daudé
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  
> diff --git a/tests/functional/m68k/test_nextcube.py b/tests/functional/m68k/test_nextcube.py
> index 71c160d0262..d917cf5424f 100755
> --- a/tests/functional/m68k/test_nextcube.py
> +++ b/tests/functional/m68k/test_nextcube.py
> @@ -2,7 +2,7 @@
>  #
>  # Functional test that boots a VM and run OCR on the framebuffer
>  #
> -# Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
> +# Copyright (c) 2019 Philippe Mathieu-Daudé
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later.  See the COPYING file in the top-level directory.
> diff --git a/tests/functional/mips/test_malta.py b/tests/functional/mips/test_malta.py
> index e8f49f130be..7048d91a9fd 100755
> --- a/tests/functional/mips/test_malta.py
> +++ b/tests/functional/mips/test_malta.py
> @@ -2,7 +2,7 @@
>  #
>  # Functional tests for the big-endian 32-bit MIPS Malta board
>  #
> -# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
> +# Copyright (c) Philippe Mathieu-Daudé
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  
> diff --git a/tests/functional/mips64el/test_fuloong2e.py b/tests/functional/mips64el/test_fuloong2e.py
> index 35e500b0221..d449e3c39a7 100755
> --- a/tests/functional/mips64el/test_fuloong2e.py
> +++ b/tests/functional/mips64el/test_fuloong2e.py
> @@ -2,7 +2,7 @@
>  #
>  # Functional tests for the Lemote Fuloong-2E machine.
>  #
> -# Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
> +# Copyright (c) 2019 Philippe Mathieu-Daudé
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2 or later.
>  # See the COPYING file in the top-level directory.
> diff --git a/tests/functional/mips64el/test_malta.py b/tests/functional/mips64el/test_malta.py
> index bc750cb7ad6..163bbaf5ca3 100755
> --- a/tests/functional/mips64el/test_malta.py
> +++ b/tests/functional/mips64el/test_malta.py
> @@ -2,7 +2,7 @@
>  #
>  # Functional tests for the little-endian 64-bit MIPS Malta board
>  #
> -# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
> +# Copyright (c) Philippe Mathieu-Daudé
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2 or later.
>  # See the COPYING file in the top-level directory.
> diff --git a/tests/functional/mipsel/test_malta.py b/tests/functional/mipsel/test_malta.py
> index 59ab4a60585..25bcb33c945 100755
> --- a/tests/functional/mipsel/test_malta.py
> +++ b/tests/functional/mipsel/test_malta.py
> @@ -2,7 +2,7 @@
>  #
>  # Functional tests for the little-endian 32-bit MIPS Malta board
>  #
> -# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
> +# Copyright (c) Philippe Mathieu-Daudé
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2 or later.
>  # See the COPYING file in the top-level directory.
> diff --git a/tests/functional/ppc/test_40p.py b/tests/functional/ppc/test_40p.py
> index ed272147f6e..4c1c9bad6ec 100755
> --- a/tests/functional/ppc/test_40p.py
> +++ b/tests/functional/ppc/test_40p.py
> @@ -2,7 +2,7 @@
>  #
>  # Functional test that boots a PReP/40p machine and checks its serial console.
>  #
> -# Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
> +# Copyright (c) Philippe Mathieu-Daudé
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later. See the COPYING file in the top-level directory.
> diff --git a/tests/functional/qemu_test/tesseract.py b/tests/functional/qemu_test/tesseract.py
> index ede6c6501e2..862faec2d2e 100644
> --- a/tests/functional/qemu_test/tesseract.py
> +++ b/tests/functional/qemu_test/tesseract.py
> @@ -1,6 +1,6 @@
>  # ...
>  #
> -# Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
> +# Copyright (c) 2019 Philippe Mathieu-Daudé
>  #
>  # This work is licensed under the terms of the GNU GPL, version 2 or
>  # later. See the COPYING file in the top-level directory.
> -- 
> 2.53.0


