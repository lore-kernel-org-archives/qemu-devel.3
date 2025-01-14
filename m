Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296ACE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 12:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXgJn-0006TM-9z; Tue, 14 Jan 2025 07:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tXgJY-0006SX-5D; Tue, 14 Jan 2025 07:46:38 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tXgJU-0006bl-B2; Tue, 14 Jan 2025 07:46:34 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aaf6b1a5f2bso166659066b.1; 
 Tue, 14 Jan 2025 04:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736858787; x=1737463587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lc6G0g6PijK+XrVeugz51uJN0px5BHFplyrpznO9mLo=;
 b=Je+HT88QI/p+YPkJrANsQxpB0uBlLBd3wGMxwexttYm6Kt+noNTTRRmSHvjg1dDeVC
 vG28M0LBDtX3RdRLJyWocit8TmSI5sONU7+fDCtf8YuSTPwS0ZgEnWyO50dbAGZnXbk4
 VNjvBUC7x6KN7+S3rLmyQ0nBTAXi16hks0gnhi/vGuHtBz3Vg3gZjzcAM9Ry2pukIedt
 s27L0XYpcpwbb+cy+bXlilpeagHana5cJfJIhVE2ogOvBhyK8vreAjz+pEHwmK8fEOS1
 QSDZ/G+BleM2Ig2BnC7kSXdN4Jxz6M3pQvRpDDGwO5cUL0RLi24dZybNOt6Jfz93Eucw
 7v6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736858787; x=1737463587;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lc6G0g6PijK+XrVeugz51uJN0px5BHFplyrpznO9mLo=;
 b=WTGf4tfJFavx79AYdWCjfqJBe1UmG+ir9pQ671rXVukvReaHgX77Msd6VpA9nd7acE
 9hCyVrimTF43lqoNICMGACWGhdM2mVNsG09r+gGs0RFAgrs5a6+cNGOfL3Q53/nJn8Ca
 yFfq2crzIjRpTHOCIgnXUmJqa5RzHm5hla/TnGNPmU9ZTHCNTvhy4dRsvkLxDNk5GsbN
 WSTacb83stb1bmF5180SgR/Sc2Cv9Bdl3YWpAsWAUVgw9kfIgnlZzOM/uyBMWfp/rpyU
 9KyV2kO8hrgcj1zI5nCM65JpHaOIcRLodu+48ubdIHKJnRPKZbv+yKT5VixRP++6ftG+
 wLQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaPXmb64YRrgyXT8ES2Hzq+gG7JOtxFCsC4ehqF1C6No4C9HhdQrz3pHfEgNAunjU4i2zLOHMihQ==@nongnu.org,
 AJvYcCWNSd/cm0lJxqZCc0KMIwYvqBI6QVTRo0HBUBUI0nD29XPZY/pcyjuI/w2wOBWksd83DDXsp3Aq6VNBSQ==@nongnu.org
X-Gm-Message-State: AOJu0YzV+lJU3hw38xxVsaIQ1jMtbvozG/MoyTbOnWxKesWITmr+0O8I
 Q2pw8b9rbcNOcCX/n38ULGUVXy6RK0ZTdmaitIZdFQ7+AaFQiCZSWf4tug==
X-Gm-Gg: ASbGncsMU5zOiAeQi5vmi6eV3o0JBKnLoc7b7aTGSLxwsAKPe4/33zBhvGIhxoGZZs9
 IN3AKI0Pt6hV7aONGqce4c0pcpRvZKtpRP0tCfOkr9RkWhP2RculiJc8quXiM4TmQCrNfLuY3Kr
 ie4vZvqa48s7FAe7Rq1Z0FcWRERBjIlmvzM4FZuyhdds+Uhpl1QaXQ63kERUkoMXangHp4ZiPkl
 phmmee2GR3eHMVK3qjXMPpeDbFmX2qpzHpfID8VtKEkqvJNo7ZXa5BrHw2B5K/RdyXbpVR+BLYJ
 vzJ/dhovYxP9K0ubnqJeoohRbZ4=
X-Google-Smtp-Source: AGHT+IH/0KT2j91e+KUkkKWU2w6meYLubN3fH7uF2MQ0toPW+R4GH9GG6fbIbY3rVhM7EzmFHZu28Q==
X-Received: by 2002:a17:907:72d5:b0:aab:ef03:6d46 with SMTP id
 a640c23a62f3a-ab2c3c63f95mr1900260866b.4.1736858787008; 
 Tue, 14 Jan 2025 04:46:27 -0800 (PST)
Received: from [127.0.0.1] (business-90-187-110-129.pool2.vodafone-ip.de.
 [90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90d73a9sm629541766b.58.2025.01.14.04.46.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 04:46:26 -0800 (PST)
Date: Tue, 14 Jan 2025 12:46:26 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 00/13] i.MX and SDHCI improvements
In-Reply-To: <20250111183711.2338-1-shentey@gmail.com>
References: <20250111183711.2338-1-shentey@gmail.com>
Message-ID: <D73FEABB-ACDF-4B05-9494-81B9B8740AEB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 11=2E Januar 2025 18:36:58 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>This series fixes some details in i=2EMX platform devices, improves SDHCI=

>
>compatibility with U-Boot and modernizes some code=2E
>
>
>
>The first 5 patches are bugfixes 1/ resolving infinite loop in U-Boot esd=
hc
>
>driver, 2/ fixing a character echoing issue in imx-serial, 3/ fixing IRQ =
sharing
>
>issue in Designware PCIe emulation, and 4/ fixing GPIO level preservation=
 across
>
>resets in imx-gpio=2E
>
>
>
>Patches 6 and 7 modernize SD card emulation by turning presence and
>
>write-protect GPIOs into qdev GPIOs and then further allowing the GPIOs t=
o be
>
>inverted, just like device tree allows=2E
>
>
>
>The rest of the series is cosmetics including turning DPRINTF() into trac=
e
>
>events which eases debugging=2E
>
>
>
>v2:
>
>* Drop redundant implementation of TYPE_OR_IRQ (David, Zoltan)
>
>* Use absolute QOM paths when tracing in imx_gpio and imx_i2c (Phil)
>
>* Trace hexadecimal values in imx_serial (Phil)
>
>* Do NOT move inversion of presence and write-protect GPIOs since that ch=
anges
>
>the internal logic of the device
>
>
>
>Bernhard Beschow (13):
>
>  hw/sd/sdhci: Set SDHC_NIS_DMA bit when appropriate
>

>  hw/char/imx_serial: Fix reset value of UFCR register
>
>  hw/char/imx_serial: Update all state before restarting ageing timer
>
>  hw/pci-host/designware: Expose MSI IRQ
>
>  hw/gpio/imx_gpio: Don't clear input GPIO values upon reset
>

Does anybody feel comfortable enough reviewing the above four patches? I h=
it those issues while working on i=2EMX machines=2E

The below two patches are less critical for my work but there were patches=
 with discussions floating around recently, e=2Eg=2E [1]=2E

Thanks,
Bernhard

[1] <https://patchew=2Eorg/QEMU/20250108100240=2E960593-1-clg@redhat=2Ecom=
/>

>  hw/sd/sd: Remove legacy sd_set_cb() in favor of GPIOs
>
>  hw/sd/sd: Allow for inverting polarities of presence and write-protect
=
>
>    GPIOs
>

>  hw/char/imx_serial: Turn some DPRINTF() statements into trace events
>
>  hw/timer/imx_gpt: Remove unused define
>
>  tests/qtest/libqos: Reuse TYPE_IMX_I2C define
>
>  hw/i2c/imx_i2c: Convert DPRINTF() to trace events
>
>  hw/misc/imx6_src: Convert DPRINTF() to trace events
>
>  hw/gpio/imx_gpio: Turn DPRINTF() into trace events
>
>
>
> include/hw/arm/fsl-imx6=2Eh                  |  4 +-
>
> include/hw/arm/fsl-imx7=2Eh                  |  4 +-
>
> include/hw/char/imx_serial=2Eh               |  2 +-
>
> include/hw/pci-host/designware=2Eh           |  1 +
>
> include/hw/sd/sdcard_legacy=2Eh              |  1 -
>
> hw/arm/fsl-imx6=2Ec                          | 13 ++++-
>
> hw/arm/fsl-imx7=2Ec                          | 13 ++++-
>
> hw/char/imx_serial=2Ec                       | 65 ++++++++++++++--------=

>
> hw/gpio/imx_gpio=2Ec                         | 19 +++----
>
> hw/i2c/imx_i2c=2Ec                           | 21 ++-----
>
> hw/misc/imx6_src=2Ec                         | 23 ++------
>
> hw/pci-host/designware=2Ec                   |  7 +--
>
> hw/sd/sd=2Ec                                 | 39 ++++++-------
>
> hw/sd/sdhci=2Ec                              | 11 +++-
>
> hw/timer/imx_gpt=2Ec                         |  4 --
>
> tests/qtest/libqos/arm-imx25-pdk-machine=2Ec |  5 +-
>
> tests/qtest/libqos/i2c-imx=2Ec               |  4 +-
>
> hw/arm/Kconfig                             |  2 +
>
> hw/char/trace-events                       |  5 ++
>
> hw/gpio/trace-events                       |  5 ++
>
> hw/i2c/trace-events                        |  5 ++
>
> hw/misc/trace-events                       |  6 ++
>
> 22 files changed, 151 insertions(+), 108 deletions(-)
>
>
>
>-- >
>2=2E48=2E0
>
>
>

