Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795F5C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 01:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7QFA-0006pb-N6; Wed, 15 May 2024 21:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1s7QF8-0006pL-Uf
 for qemu-devel@nongnu.org; Wed, 15 May 2024 21:49:15 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1s7QEt-00007R-D3
 for qemu-devel@nongnu.org; Wed, 15 May 2024 21:49:14 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5b27369b0e3so4124926eaf.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 18:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715824136; x=1716428936; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=BbsXdeS+vEJXYUcPtYiKroQxxkqPrXWLVeJjdbE7laQ=;
 b=gNIRmjDd+o0hOGwQOrOjHmsxvkqD7M0UOQDF4WS75bdvyPqz5o41xdcdjJ/S5Uj2fZ
 8jTWcLgOKB2gav34uKwHSTek/Z3GTQ0+MWROxBxnSKupbREVqm/hdq0QCoWyInHoqejZ
 UplcBUs5UNF1HZd56S698rqi0S4eNCrfhUSZNup7g2dUYJ/ytv9NZ5r4eLzw+2fSinUD
 9oZZdEoiZAnAHt9AcAgpq8a94lZ0yXoHkFF7Fr5mlnuX940Ue227TxzrQxrJpiyoPxxJ
 YEnsO8jdhugcBDG5DElxs3jhVEAOETqp0IF1+2EgRADM5OfHJB+hYSFCj88BDncFLIN/
 fl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715824136; x=1716428936;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BbsXdeS+vEJXYUcPtYiKroQxxkqPrXWLVeJjdbE7laQ=;
 b=mJwH+Quo+ywD/Fchw4bh4Hb6LL8UbtjObXnoadtPuH0BL5spCVa1JVYU9Ff4qGa4kZ
 hyRZmUfQMffa3Mi1r9i9IAxlGe7u7PbFS9PZRorzatV2luzqM5dMBn01Vudj5N9RjY4Q
 Cf/6lPERofANb/M/Y1eZC8TvWR7KHxrHay/p3wpqZvkyXB1abf46rMpgf9VIyGVPgUma
 HG6/RP74cp438oUvSKrnctAU0QM2uhMxD23ycwMxmBN4RYRZzmjkthEjPOWlh6GK3iTf
 iRdfCHqZsASGLpNVz9XQsICOBcQJCY/dcfmZGM5MCA2DvistEhqM1moftNZstvOHqk+N
 RCRg==
X-Gm-Message-State: AOJu0YzI5p6PHEDP6FcVme7wQRhETAYDgG9XKPk7M9Hp2hLXOsAy9fLP
 EPpZtKsK/xTgWTAb9iV7aogZOK+4/ei50825HuoO20y4D5mxNZk=
X-Google-Smtp-Source: AGHT+IEpVyOZJZJFWKt7ru3dR8ZWcb2EuCAk6ibyArKXzAavHJg2ZDMV1xoPoRBjVJm8qxrAVGxdzw==
X-Received: by 2002:a05:6871:b330:b0:23d:bf8d:2453 with SMTP id
 586e51a60fabf-24172e02ed6mr15323240fac.42.1715824136006; 
 Wed, 15 May 2024 18:48:56 -0700 (PDT)
Received: from serve.minyard.net ([47.184.136.52])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2412a3c7d64sm3271073fac.11.2024.05.15.18.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 18:48:55 -0700 (PDT)
Received: from mail.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:7c63:af71:5b96:9225])
 by serve.minyard.net (Postfix) with ESMTPSA id CF42C1800B7;
 Thu, 16 May 2024 01:48:54 +0000 (UTC)
Date: Wed, 15 May 2024 20:48:53 -0500
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Corey Minyard <cminyard@mvista.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH-for-9.1 0/4] hw/i2c: Convert to spec v7 (inclusive)
 terminology
Message-ID: <ZkVmBdsBRffmlYTR@mail.minyard.net>
References: <20240408213339.83149-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240408213339.83149-1-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=tcminyard@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  minyard@acm.org
X-ACL-Warn: ,  Corey Minyard <minyard@acm.org>
From:  Corey Minyard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Apr 08, 2024 at 11:33:34PM +0200, Philippe Mathieu-Daudé wrote:
> Mechanical (mostly) conversion inspired by Wolfram [*] to
> use inclusive terminology, similarly to the other renames
> we did 3 years ago, shortly before the I2C spec v7 was
> published.

Sorry, I've been extremely busy on this.

Since the spec has been redone, I'm good with the renames.

As far as the >80 character lines, I'm fine either way.  I actually like
to keep them in 80 characters, but the Linux kernel has moved away from
that, and if it's easier to read with a longer line, that's probably
better.

-corey

> 
> Posted as RFC to get feedback, if no objection I plan to
> finish the conversion (SMBus and rest if hw/i2c/).
> 
> [*] https://lore.kernel.org/all/20240322132619.6389-1-wsa+renesas@sang-engineering.com/
> 
> Philippe Mathieu-Daudé (4):
>   hw/i2c: Fix checkpatch block comment warnings
>   hw/i2c: Fix checkpatch line over 80 chars warnings
>   hw/i2c: Convert to spec v7 terminology (automatically)
>   hw/i2c: Convert to spec v7 terminology (manually)
> 
>  include/hw/display/i2c-ddc.h     |   2 +-
>  include/hw/gpio/pca9552.h        |   2 +-
>  include/hw/gpio/pca9554.h        |   2 +-
>  include/hw/i2c/aspeed_i2c.h      |   4 +-
>  include/hw/i2c/i2c.h             | 123 ++++++-------
>  include/hw/i2c/i2c_mux_pca954x.h |   2 +-
>  include/hw/i2c/smbus_slave.h     |   4 +-
>  include/hw/nvram/eeprom_at24c.h  |   8 +-
>  include/hw/sensor/tmp105.h       |   2 +-
>  hw/arm/aspeed.c                  | 290 +++++++++++++++++--------------
>  hw/arm/bananapi_m2u.c            |   2 +-
>  hw/arm/cubieboard.c              |   2 +-
>  hw/arm/musicpal.c                |   6 +-
>  hw/arm/npcm7xx_boards.c          |  44 ++---
>  hw/arm/nseries.c                 |   6 +-
>  hw/arm/pxa2xx.c                  |  36 ++--
>  hw/arm/realview.c                |   2 +-
>  hw/arm/spitz.c                   |  12 +-
>  hw/arm/stellaris.c               |   2 +-
>  hw/arm/tosa.c                    |  14 +-
>  hw/arm/versatilepb.c             |   2 +-
>  hw/arm/vexpress.c                |   2 +-
>  hw/arm/z2.c                      |  20 +--
>  hw/audio/wm8750.c                |  18 +-
>  hw/display/ati.c                 |   4 +-
>  hw/display/i2c-ddc.c             |  10 +-
>  hw/display/sii9022.c             |  16 +-
>  hw/display/sm501.c               |   2 +-
>  hw/display/ssd0303.c             |  14 +-
>  hw/display/xlnx_dp.c             |   2 +-
>  hw/gpio/max7310.c                |  14 +-
>  hw/gpio/pca9552.c                |  14 +-
>  hw/gpio/pca9554.c                |  14 +-
>  hw/gpio/pcf8574.c                |  12 +-
>  hw/i2c/aspeed_i2c.c              |  16 +-
>  hw/i2c/core.c                    |  90 +++++-----
>  hw/i2c/i2c_mux_pca954x.c         |   6 +-
>  hw/i2c/imx_i2c.c                 |   2 +-
>  hw/i2c/smbus_slave.c             |  12 +-
>  hw/input/lm832x.c                |  14 +-
>  hw/misc/axp2xx.c                 |  14 +-
>  hw/misc/i2c-echo.c               |  14 +-
>  hw/nvram/eeprom_at24c.c          |  26 +--
>  hw/ppc/e500.c                    |   2 +-
>  hw/ppc/pnv.c                     |   4 +-
>  hw/ppc/sam460ex.c                |   2 +-
>  hw/rtc/ds1338.c                  |  14 +-
>  hw/rtc/m41t80.c                  |  12 +-
>  hw/rtc/twl92230.c                |  16 +-
>  hw/sensor/dps310.c               |  14 +-
>  hw/sensor/emc141x.c              |  16 +-
>  hw/sensor/lsm303dlhc_mag.c       |  16 +-
>  hw/sensor/tmp105.c               |  16 +-
>  hw/sensor/tmp421.c               |  20 +--
>  hw/tpm/tpm_tis_i2c.c             |  12 +-
>  55 files changed, 541 insertions(+), 506 deletions(-)
> 
> -- 
> 2.41.0
> 
> 

