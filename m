Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65121E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 13:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXh4G-0005Mn-SZ; Tue, 14 Jan 2025 08:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tXh43-0005KC-Ja
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:34:42 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tXh40-0006mH-N7
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:34:39 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so117942105ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 05:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1736861674; x=1737466474;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OffJjBdXql451CcVEgj84gO5ioKPxRaqGL4X58UaYXk=;
 b=XnVcqFH317G1iRpomg6Vrl4/ZjwwS117Q8q0iJKtNu9NLwN3HYAWHmmZIefvin5sVv
 AIuK6tA4YGcDUrsC/H0iPEMUr88xbvoVe+y/vGmEQ3YLTPeRx7dYrVesb4f+6fFOVQ3s
 BpMSmIjUZ7BYDYk3yjzMxbO+2IkttbmJowzHB+ZUyr1FyXGL8uFTqNCP1X0w/K3jmp3c
 BrIkDYfPwhZJFhFER3rrNUbkKVWZ7V6P45pymKCIowRNYZdKxRNkgmerc/F7GDGPABmJ
 lXrqQJ7y/10uNCE8TkgJ9rNdiY2akH3AZEQOjcjY5Cc4lWDMC/PBm/MqQYrAIOabMaTB
 oiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736861674; x=1737466474;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OffJjBdXql451CcVEgj84gO5ioKPxRaqGL4X58UaYXk=;
 b=OwMUtNeP8mxGstAOuCoU+ZRZ9z0+moof/YiCm/8PrLPzNDORX+GwSYUvHtoHgBCUfK
 d6tqYuDKUIatEg3In/E24ZvAAwBgG1yw0eucrD3TfKkwfGjRIQc63ropdWJ5bRyOARyD
 zPrKrJ5R0rQNrLRmRKGRvhe2XFc0ubHg9FXov8v+8Ipv/81rBRuGYLK+vNys4cHWTFie
 EONFhpy2uZ05wm5UeoyZicQrfzkXQ6KabuEUgyvOSowIBGjcoD8WkewLIiEQ48pEKqOi
 xGuSl4ehr9dPmc65sMB/XvT5eVfEnK84xStfM5p5PwkSirZR6tvaXsfLtlIYLmFSKwXQ
 +vpA==
X-Gm-Message-State: AOJu0YxTv/9O1/uhVEZahI6sZKy2sKKxo6D3lROM8UI82lYdsdWnuST/
 xNyKGPhvAtChavAs8UlV7dLHgl2iwVklxairPF1WoRVXNMTJhAAt5mpjg1Kzp+w=
X-Gm-Gg: ASbGncuIgaIPoNPYj6pIRlcpoI6U22g2nNgawYVREAOqzBR2flIcCaWfjvood3ngKgU
 YPCwSxz6l2SJfsstHRpxS4wwHbjJIG6MzGBmeSm1dR8kUa9dRvbrkigQiKMZ246+GZhmp1eTXRX
 JWXHmbbvr3ytF01OaHcyk7Ky7VJOo+KKiUzKWJkjjQC8HbvWmJfofr+5MbDnnyOpjx/PZZvPbYO
 iFpf7K7wHtknc6e6gvXRLBn3AVVujZ5TTMM5SUcPIt3HdwJ/OP8LQ6U1XWl
X-Google-Smtp-Source: AGHT+IGBTrO+0m6tWWXI2fKd5x8B6Y883N6Brsb4DPaIXaArvRUOdx7a2hbY+8J+6eYTvNmiKT0uRQ==
X-Received: by 2002:a05:6a21:789a:b0:1e1:9bea:659e with SMTP id
 adf61e73a8af0-1e88d3612e6mr46712901637.35.1736861673915; 
 Tue, 14 Jan 2025 05:34:33 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:4641:6dae:60a7:e5ab])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d4056ac6fsm7611875b3a.68.2025.01.14.05.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 05:34:33 -0800 (PST)
Date: Tue, 14 Jan 2025 07:34:26 -0600
From: Corey Minyard <corey@minyard.net>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 11/13] hw/i2c/imx_i2c: Convert DPRINTF() to trace events
Message-ID: <Z4Zn4oGoIdmiVTEI@mail.minyard.net>
References: <20250111183711.2338-1-shentey@gmail.com>
 <20250111183711.2338-12-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250111183711.2338-12-shentey@gmail.com>
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=corey@minyard.net; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Jan 11, 2025 at 07:37:09PM +0100, Bernhard Beschow wrote:
> Also print the QOM canonical path when tracing which allows for distinguishing
> the many instances a typical i.MX SoC has.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

This seems reasonable.

Acked-by: Corey Minyard <cminyard@mvista.com>

> ---
>  hw/i2c/imx_i2c.c    | 21 +++++----------------
>  hw/i2c/trace-events |  5 +++++
>  2 files changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
> index c565fd5b8a..d62213b9e0 100644
> --- a/hw/i2c/imx_i2c.c
> +++ b/hw/i2c/imx_i2c.c
> @@ -25,18 +25,7 @@
>  #include "hw/i2c/i2c.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> -
> -#ifndef DEBUG_IMX_I2C
> -#define DEBUG_IMX_I2C 0
> -#endif
> -
> -#define DPRINTF(fmt, args...) \
> -    do { \
> -        if (DEBUG_IMX_I2C) { \
> -            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX_I2C, \
> -                                             __func__, ##args); \
> -        } \
> -    } while (0)
> +#include "trace.h"
>  
>  static const char *imx_i2c_get_regname(unsigned offset)
>  {
> @@ -152,8 +141,8 @@ static uint64_t imx_i2c_read(void *opaque, hwaddr offset,
>          break;
>      }
>  
> -    DPRINTF("read %s [0x%" HWADDR_PRIx "] -> 0x%02x\n",
> -            imx_i2c_get_regname(offset), offset, value);
> +    trace_imx_i2c_read(DEVICE(s)->canonical_path, imx_i2c_get_regname(offset),
> +                       offset, value);
>  
>      return (uint64_t)value;
>  }
> @@ -163,8 +152,8 @@ static void imx_i2c_write(void *opaque, hwaddr offset,
>  {
>      IMXI2CState *s = IMX_I2C(opaque);
>  
> -    DPRINTF("write %s [0x%" HWADDR_PRIx "] <- 0x%02x\n",
> -            imx_i2c_get_regname(offset), offset, (int)value);
> +    trace_imx_i2c_read(DEVICE(s)->canonical_path, imx_i2c_get_regname(offset),
> +                       offset, value);
>  
>      value &= 0xff;
>  
> diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
> index f708a7ace1..1ad0e95c0e 100644
> --- a/hw/i2c/trace-events
> +++ b/hw/i2c/trace-events
> @@ -56,3 +56,8 @@ npcm7xx_smbus_recv_fifo(const char *id, uint8_t received, uint8_t expected) "%s
>  
>  pca954x_write_bytes(uint8_t value) "PCA954X write data: 0x%02x"
>  pca954x_read_data(uint8_t value) "PCA954X read data: 0x%02x"
> +
> +# imx_i2c.c
> +
> +imx_i2c_read(const char *id, const char *reg, uint64_t ofs, uint64_t value) "%s:[%s (0x%" PRIx64 ")] -> 0x%02" PRIx64
> +imx_i2c_write(const char *id, const char *reg, uint64_t ofs, uint64_t value) "%s:[%s (0x%" PRIx64 ")] <- 0x%02" PRIx64
> -- 
> 2.48.0
> 
> 

