Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD1AC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsCi-0000CA-Q9; Mon, 05 May 2025 05:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBsCQ-0008SO-15
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:33:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBsCM-0002N9-D1
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:33:20 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-441c99459e9so6248315e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746437597; x=1747042397; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RP1SxWFy3y21M/55BX5c21okdbyYV4ky+7yqUWS3uNw=;
 b=v3+jk+bFiTCblB0LqX6i7T4GWl55zQVfKB3fFr3PZ+S+uP+Uuu8/6dh+g8TSzZKxHI
 BiK/RBXwuf15zjkhcqjyJuLNWRKqrB++6X8Q51M7/NIks7qwUsOxdy3nR6Dd5BJCxc3y
 OfuQ7x5pCYLYr3Cu1o7sphkv/TXB5s98xl0SRZslDEfSAUR+bLOeHs07+zbFyCTW1+EK
 e2zBoXcdvK8OX59/e+1UBQO89rg/krd6Fxv6BS++juU7s3ZSTqKDIk7tEQYvGpU8cEax
 8eenaoeVOv8OqQ0K+nnDamJtd6q/tiPwHZa25dkWp9jKohIqb9jMhAqUdbmKBPDo9S5L
 7GLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746437597; x=1747042397;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RP1SxWFy3y21M/55BX5c21okdbyYV4ky+7yqUWS3uNw=;
 b=UCP2k4Y7s7ZYf6qysIXVx71YJTE3d9pccoy7ybF5uAa4GLSzMQpcp0rc6MzD0mgtHS
 7wiR/NTP2pyifaQmBKrLPrEnyVx7hWWHOcpwkYPCAXiRcgy9PhvruFtlu/IKD1pz+mzh
 YyK5i5mozVvoMV2XBmkW7eiq5D09JWsOvA2ZnTsmnjbgRjPZE/TmeiUTMA5lO2l1ZuI1
 3Y6eCCGHbOM3tvtzZwVZHN+s+OvQSByWgT894DpfuAn09n+rruQ8E9qNGqyWkMEFEf9r
 k5E4UvziuUi5kx5AOEWr8Bvb3zh2y67yfxhjBwCZ5Y46d7DHnjUd3YESEtGt6D9ozhIC
 imog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXfB+3Cx2YY9LE1q395pTvoyxrayBLsoRPKXlom5UV6VKiqztzJgi9kCBsMCn7T+S0TQ3n0rfB2upH@nongnu.org
X-Gm-Message-State: AOJu0YxoyTdBY+hXPd/dHKkkt8TfOrSLPFwJplz3OWZLxXSM/C24OrAt
 sG9pjaRjt61xoMag/ibTegg2sH/J/zsVO2WX5HB8n+u22UbbilK8TLO+o+jK4nI=
X-Gm-Gg: ASbGncuCPel3t/uj+m311XEq2TcGaMiT3ksYoT7hi9Zsycu/TOi9Rd/OOvgWMOwssk+
 uhjzY3Pku0BGibrFIhPpOrz/VvGMjbptJJvYQzMeM7ZAflBREZbX2++NH3ku79ww+3mWpqnZwiL
 1WUFkd3pemfivcOALfBuIcBFAOhfH+ZGfQUuOPHDnrAh/ymyjIezehHwIGWpCYT5pwswiuRsATP
 XRbl87heehqbdAvzjetZR+K7Yt5sWoUQwlxp0fzhJMCdLgohdL5lWUs8dQHgXmrUiqt7+2kkzli
 gC6O96HcFleziAhAaMhuFF1praGT6uucTM1/mxUN+60op8VicwcEw+d8YMYx9Rbq1ZKaBvjm1DN
 M6cF8Ot/bw1CCKJE/L1DR6q2TJKh0
X-Google-Smtp-Source: AGHT+IFh3RdWa0wkfZDaUv/y3MJtL7GfMm7CI24PVFxaDnC6P7de6mx9+/JxepbshfnpEt7/BFOnNA==
X-Received: by 2002:a05:600c:1c1c:b0:43c:fe5e:f040 with SMTP id
 5b1f17b1804b1-441bbf34170mr91113465e9.23.1746437596674; 
 Mon, 05 May 2025 02:33:16 -0700 (PDT)
Received: from [10.194.152.213] (29.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.29]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89cc50esm130475655e9.8.2025.05.05.02.33.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:33:16 -0700 (PDT)
Message-ID: <2d3d33c3-21a6-4432-9d9e-7332c5de63bb@linaro.org>
Date: Mon, 5 May 2025 11:33:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/npcm8xx_boards: Add auto zero flash image and
 device part number
To: Tim Lee <timlee660101@gmail.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, wuhaotsh@google.com,
 chli30@nuvoton.com, kfting@nuvoton.com
References: <20250401085903.224787-1-timlee660101@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250401085903.224787-1-timlee660101@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/4/25 10:59, Tim Lee wrote:
> Fix flash device part number to `mx66l1g45g` according image-bmc run on npcm8xx
> evb board (SPIFlash...SF: Detected mx66l1g45g, total 128 MiB)
> 
> And add auto zero flash image size to resolve error below after executing
> `./qemu-system-aarch64 -machine npcm845-evb -drive file=image-bmc`
> 
> Error message:
> qemu-system-aarch64: mx66l1g45g device '/machine/unattached/device[73]'
> requires 134217728 bytes, mtd0 block backend provides 67108864 bytes
> 
> Tested:
> Build passes and runs ./qemu-system-aarch64 -machine npcm845-evb normally
> 
> Signed-off-by: Tim Lee <timlee660101@gmail.com>
> ---
>   hw/arm/npcm8xx_boards.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
> index 3fb8478e72..11b792c613 100644
> --- a/hw/arm/npcm8xx_boards.c
> +++ b/hw/arm/npcm8xx_boards.c
> @@ -27,6 +27,7 @@
>   #include "qemu/error-report.h"
>   #include "qemu/datadir.h"
>   #include "qemu/units.h"
> +#include "system/block-backend.h"
>   
>   #define NPCM845_EVB_POWER_ON_STRAPS 0x000017ff
>   
> @@ -59,10 +60,21 @@ static void npcm8xx_connect_flash(NPCM7xxFIUState *fiu, int cs_no,
>   {
>       DeviceState *flash;
>       qemu_irq flash_cs;
> +    BlockBackend *blk;
> +    uint64_t blk_size, perm, shared_perm;
>   
>       flash = qdev_new(flash_type);
>       if (dinfo) {
>           qdev_prop_set_drive(flash, "drive", blk_by_legacy_dinfo(dinfo));
> +        blk = blk_by_legacy_dinfo(dinfo);
> +        blk_size = blk_getlength(blk);
> +        if (blk_size < fiu->flash_size) {
> +            blk_get_perm(blk, &perm, &shared_perm);
> +            blk_set_perm(blk, BLK_PERM_ALL, BLK_PERM_ALL, &error_abort);
> +            blk_truncate(blk, fiu->flash_size, true, PREALLOC_MODE_OFF,
> +                         BDRV_REQ_ZERO_WRITE, &error_abort);
> +            blk_set_perm(blk, perm, shared_perm, &error_abort);

This won't work on read-only storage.

> +        }
>       }
>       qdev_realize_and_unref(flash, BUS(fiu->spi), &error_fatal);
>   
> @@ -194,7 +206,8 @@ static void npcm845_evb_init(MachineState *machine)
>       qdev_realize(DEVICE(soc), NULL, &error_fatal);
>   
>       npcm8xx_load_bootrom(machine, soc);
> -    npcm8xx_connect_flash(&soc->fiu[0], 0, "w25q256", drive_get(IF_MTD, 0, 0));
> +    npcm8xx_connect_flash(&soc->fiu[0], 0, "mx66l1g45g",
> +                          drive_get(IF_MTD, 0, 0));
>       npcm845_evb_i2c_init(soc);
>       npcm845_evb_fan_init(NPCM8XX_MACHINE(machine), soc);
>       npcm8xx_load_kernel(machine, soc);


