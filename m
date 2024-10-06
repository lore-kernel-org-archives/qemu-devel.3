Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A39CFB43F
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2024 14:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxS0k-0001aN-1D; Sun, 06 Oct 2024 10:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sxS0i-0001Zz-90
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 10:13:24 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sxS0g-0000cT-8G
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 10:13:24 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c5b954c359so4231848a12.1
 for <qemu-devel@nongnu.org>; Sun, 06 Oct 2024 07:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728224000; x=1728828800; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1tKe0gAfWmD9TphGK1i3DWefKUjIjA3Gvmpc92ZzKCk=;
 b=CTfWioZM2r9v/tR3uttjlcgQy+u+Kh6JS2RecDmTe+PNp/hqXPzMnIJkCBkKZ5jOMU
 ajLsxQ5kwAo9r1mSTEzG3Vx+SS1iEZy3CoYEnxmksOkXv/Qg65AscHZLFNilhu534rF8
 ABVn2jf5+cbHJtgHhXA0RN7Vn85C4G4IAiObl+VDJo30cByPzZPDUqhj4GWQ/LR4UNSv
 Hb5CDLuQhVneglz6/s9ZvzkgeWwWsJELQXONLaRSGVPhSbdmVc+lHco95AsbIwz0isiT
 XMLJFWFdbF+INsXWUB3yNeaXqhqlQH5Sx3Z9zp5p397OgVpvKwI0zq2ppsqBV9qo3Kit
 sbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728224000; x=1728828800;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1tKe0gAfWmD9TphGK1i3DWefKUjIjA3Gvmpc92ZzKCk=;
 b=YOkBlRbCup/2XvKfZmVXy5jNt8JcIqhF5EQYuHO8kqKiGvNetwWUIw+bVqqLu+Zht7
 PtjWn6XgZSeGIf/qx4ndkMv9h42K++XokhieHUllk+ozNIllqoct81URP2j3oXIjyEtY
 mLSMAO3XDpTb7Y8AFpAKEbkctOtuXB2a7Fqg2IhIR+bAMn2jHxyAZUUss5Oh5Oqo/HO3
 7uUUKUp2a11+e7+QWaJf406wTYoVvMl3X9O5Ew40Vh2sowc5eJKdRAhwKNCh0JNr5kpA
 yREkGn76IzWNxUWK4v4fAeHy19GD3ZcuHQNGkwlKGhvIcOrgEHb/5heZKtbyVPxpI5yx
 7xVg==
X-Gm-Message-State: AOJu0Ywq1OcCRR7dgU/A0/EvvAFhQw3JSnZQu5uEAF0MwZoeCU9XPWud
 FIxH2PRbb8dXBmlB6YiUz0F7FEmQo63dPHUJ+Gyn/MoWYujdIXGsy3BYFm5vsLKp67uAo221lQ5
 SO6FXI4lT00zybnNsmXlOYole/x9X8pQTZR/JafDlWHW6dkNo
X-Google-Smtp-Source: AGHT+IEamKXv940QqJf/8HAIlpJfZZIxKARHm1pA8ONWkzhxm7nFOJZRfw4/t2iKd1TcqMETw+Mas5JDbO6JrEUIFP4=
X-Received: by 2002:a05:6402:3490:b0:5c8:9476:2bf with SMTP id
 4fb4d7f45d1cf-5c8d2ed349amr8224100a12.35.1728223999924; Sun, 06 Oct 2024
 07:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1728141040.git.chao.liu@yeah.net>
 <1193cf07fbfa67f94ebad9bd897358f248f703cb.1728141040.git.chao.liu@yeah.net>
In-Reply-To: <1193cf07fbfa67f94ebad9bd897358f248f703cb.1728141040.git.chao.liu@yeah.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 6 Oct 2024 15:13:09 +0100
Message-ID: <CAFEAcA_3ah0wU5XF7U9QeB4ZXCBhWNnTUWqknN_sWvFq5oKR+A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] xilink_zynq: Add various missing unimplemented
 devices
To: Chao Liu <chao.liu@yeah.net>
Cc: qemu-devel@nongnu.org, bin.meng@windriver.com, edgar.iglesias@gmail.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Sat, 5 Oct 2024 at 17:06, Chao Liu <chao.liu@yeah.net> wrote:
>
> Add xilinx zynq board memory mapping is implemented in the device.
>
> Remove a ignore_memory_transaction_failures concurrently.
>
> Source: Zynq-7000 SoC Data Sheet: Overview, Chapter: Memory Map
>
> See: https://www.mouser.com/datasheet/2/903/ds190_Zynq_7000_Overview-1595492.pdf
> Signed-off-by: Chao Liu <chao.liu@yeah.net>
> ---
>  hw/arm/xilinx_zynq.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 37c234f5ab..77010bebeb 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -34,6 +34,7 @@
>  #include "hw/net/cadence_gem.h"
>  #include "hw/cpu/a9mpcore.h"
>  #include "hw/qdev-clock.h"
> +#include "hw/misc/unimp.h"
>  #include "sysemu/reset.h"
>  #include "qom/object.h"
>  #include "exec/tswap.h"
> @@ -229,6 +230,16 @@ static void zynq_init(MachineState *machine)
>          zynq_machine->cpu[n] = ARM_CPU(cpuobj);
>      }
>
> +    /* PL AXI */
> +    create_unimplemented_device("zynq.pl-axi.port0", 0x40000000, 1 * GiB);
> +    create_unimplemented_device("zynq.pl-axi.port1", 0x80000000, 1 * GiB);
> +
> +    /* IOP devices */
> +    create_unimplemented_device("zynq.iop-devices", 0xE0000000, 256 * MiB);

These clearly are not devices, they are covering a big range
of memory space. What is the behaviour of the real hardware
if you access these address space ranges?

> +    /* Programmable register access via AMBA APB bus */
> +    create_unimplemented_device("zynq.amba", 0xF8000000, 32 * MiB);
> +
>      /* DDR remapped to address zero.  */
>      memory_region_add_subregion(address_space_mem, 0, machine->ram);
>
> @@ -394,7 +405,6 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
>      mc->init = zynq_init;
>      mc->max_cpus = ZYNQ_MAX_CPUS;
>      mc->no_sdcard = 1;
> -    mc->ignore_memory_transaction_failures = true;

As I've said in my review on the previous series, there is no point
in adding big "unimplemented device" ranges merely in order to
remove the setting of ignore_memory_transaction_failures.

thanks
-- PMM

