Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29D6EC01CB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4dWm-0000zb-7X; Mon, 23 Mar 2026 07:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4dWk-0000z1-8l
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:32:58 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4dWi-0008Ax-KU
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:32:58 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64aedd812baso68938d50.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 04:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774265575; cv=none;
 d=google.com; s=arc-20240605;
 b=EvY1uu/2rb7XeqSDVxDNe6H2eaHhiDLjTTN+U0Gc9XgawmuAjk14GLeT9RKsqa13Ds
 QBmgKtlUQhEXu5Hz/MyTa18fwLInfHnnjFZ8YcBS+N+/5KJ47ODSnCgAu44SEvqGhtE1
 LDVhEXOLf78tlPFEILIEUno8u46V0l28oQ6CkKxCVr5RQtkd55wrbtm8EalXa0HHKyeH
 +DTIiUpEfkwvyXnXqgB3+NyaEjtoCqS8Tf62j/BPwQPKUqi2P4AXmQ1u+r085lyasfF0
 8ejT+JESSYlIbW6JCTev/K9JkA/zmqegWJpaAUcPBecDmin5W8+zbvPQe9d6FX8eDWVs
 qiwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Uce4dAExkWdTa9B8+QY2xBvUaXU6jGLUBPzqr4+fI2k=;
 fh=gS8oh9EHdcTDcglskGyIv3/M5LtfI+jKdwGYJC227W4=;
 b=ZNlCdOJd2nLqSDvUhmuJvf34On7edymUOMSuNubVZkJ9kSpxn5B5OO14680zNvwKeV
 lh1kdvfPlsWSqRAEO3YTl8/2G29/ds8dE2WjbKTBLTG8jIMnfpA318nQ/kiqlRUm5GHX
 KJB8KZ36UnVjLyBrAKmvORLRL8P7L6kGyDcYOjy+FKGc75etrOj/ZbXsdRUculzIB7q0
 RyWGcUj4yKrtdUCGESpjjhdVuhj97uRFMUooRD5oeYHCyU4iAa+AkjIbhg9ln1uozP+k
 mmVHdbkTxMy5ntude1A93/jMdQ7Cs9DHbqLJf69REtUgb6YsOyfgbVhjKW3enKuLjp8k
 MtGA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774265575; x=1774870375; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uce4dAExkWdTa9B8+QY2xBvUaXU6jGLUBPzqr4+fI2k=;
 b=QRv4BBsv6azUBhB4/hfY3LmQ4lGn0DogEyXuaxtP38ky/phcpPJpdlTJMF/GZPmW8A
 OSYuBt2Agv4gSBdiGJgv3LHnrLA+ScWEyIDL9vyx9gurmq5lqLMjEHM+jgBs4uLRyAEd
 Pr150Kkq6ENZf/Bm2FJQpz/BEV4jl4I/FHmHEAN6Qa4k4j3OC3YGHm2HzaxUtxhgOi1I
 IWdiKbUBH3547hADAQG5ZGr8gMW9sMnrg3Tc6cPyEXL2g4elnmdHAHKO90Lw8f61tBXn
 Ch9LApVkXtZjajI3/WY+7rR/45253PurcXot7xn2tknOVZF27uazFcFx3Wqg0Lkd1wSL
 pOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774265575; x=1774870375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uce4dAExkWdTa9B8+QY2xBvUaXU6jGLUBPzqr4+fI2k=;
 b=cbz64dVZPTNhBS+6VfYqOZ/aR+A1lBKKdtVszQRuBac/qsjFKPdOpqlftBh42Ay02V
 Yr+Bl8QdbdEVZ4joAALunhIUGPTEmtYX6EAuQaqosL7bRBHS3gZZKkHzzWAbIYmy7riR
 Qwb2Pyoml/FcMs9NjFtnWqv+g2I7X9u0rSFYtDmKwOZKk0CgWuesE7CmGFEY/GBeu/yS
 YDmDW3HLW1tfFvhkRdTHZ6ZQOmS/bK7WCQ54G+HCDEwBou7LYNc0LqhjUYiqW0MDpPxG
 UoMHhRwoRXwv9GNN9QFhiUhbRXcoc9itzmJNGNUx8DL8T1eC8EmwIyoGVfHB/U/BCEhf
 l7ig==
X-Gm-Message-State: AOJu0YxEOw4yvOvxSh+4U7z0W8JPKvn1RDkYSiXa49DfR8mFFRhzncIj
 73vgjEeCLz2leLN2+UzhwW3sTiCO+w49E8kN4j0CAXODZtkv9VHKZB5lSqgLztEJ3TLvPGuD3vu
 qqTB6QDlysu6DMlqnzGsFSnZvNZIRSOu5EpnTqUKztg==
X-Gm-Gg: ATEYQzylm/+6vl+jIE84kYNcL+EN8O433zRoGD5TLBNvyPkF4bbTlrJntp5BhZPmXw0
 n/AEWxRkxrZzqz/i5oin5dvpxAbbswbCcRCJc8kN67wpX+xIkh7TPiwvDdhH6+05Zqg/ELyMKV6
 aR8iBwww1F/a8ATm0qfhBIw5mLpcheaeJzUMtAhvnK6XkGkn/TMSIf7Xr0tY0kKJ00AmGiWTi+h
 koMKEeZAfipbyfMKt8T4oEo7pkjlPYVSuNuDYLEO5JW+DGUZZ+jhhGZahYst+67vIfTP61oAWmC
 fx7AualqeENH4ZskBWyu6pOM9cWY2Jpb5nze7wGqlYfoBvtyUTuh9zrR/YFXP5T/ANE=
X-Received: by 2002:a05:690c:6983:b0:79a:6d99:b242 with SMTP id
 00721157ae682-79a909612camr120586737b3.0.1774265574862; Mon, 23 Mar 2026
 04:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774099044.git.dingtao0430@163.com>
In-Reply-To: <cover.1774099044.git.dingtao0430@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2026 11:32:42 +0000
X-Gm-Features: AaiRm525KdEGD6QFdc1qMCIQHFRKN2woDuFxGxjdWhgdlLBavvHfWVDHrTJezbY
Message-ID: <CAFEAcA8S3=pUo9Dw0Lc3sWF0PHK-F-hpObDG-t_zCK7-QuaUBg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] PL011 and PL080 for dma transfer
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Sat, 21 Mar 2026 at 15:47, Tao Ding <dingtao0430@163.com> wrote:
>
> The PL080 implementation in QEMU currently supports memory-to-memory data transfers
> but lacks support for peripheral-related data transfers.

This is true, but do we actually need it ? The PL080 is an ancient
peripheral which we use only in a couple of devboards, where nobody
has complained about the feature being missing despite these
boards having been in QEMU for decades.

It's correct that the versatile boards ought in theory to be modelling
the peripheral DMA and wiring up the UARTs to the DMA controller,
but what's your motivation for implementing this ?

> Change in Versatilepb.c :
> -----------------------------------------
> diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
> index 254b1610b3..ee0056e831 100644
> --- a/hw/arm/versatilepb.c
> +++ b/hw/arm/versatilepb.c
> @@ -281,7 +281,7 @@ static void versatile_init(MachineState *machine, int board_id)
>      }
>
>      pl011_create(0x101f1000, pic[12], serial_hd(0));
> -    pl011_create(0x101f2000, pic[13], serial_hd(1));
> +    DeviceState *pl011_dev = pl011_create(0x101f2000, pic[13], serial_hd(1));
>      pl011_create(0x101f3000, pic[14], serial_hd(2));
>      pl011_create(0x10009000, sic[6], serial_hd(3));
>
> @@ -292,6 +292,15 @@ static void versatile_init(MachineState *machine, int board_id)
>      sysbus_realize_and_unref(busdev, &error_fatal);
>      sysbus_mmio_map(busdev, 0, 0x10130000);
>      sysbus_connect_irq(busdev, 0, pic[17]);
> +    sysbus_connect_irq(busdev, 3, qdev_get_gpio_in(pl011_dev, 0));
> +    sysbus_connect_irq(busdev, 4, qdev_get_gpio_in(pl011_dev, 1));
> +
> +    sysbus_connect_irq(SYS_BUS_DEVICE(pl011_dev), 6, qdev_get_gpio_in(dev, 0));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(pl011_dev), 7, qdev_get_gpio_in(dev, 1));
> +
> +    sysbus_connect_irq(SYS_BUS_DEVICE(pl011_dev), 8, qdev_get_gpio_in(dev, 16));
> +    sysbus_connect_irq(SYS_BUS_DEVICE(pl011_dev), 9, qdev_get_gpio_in(dev, 17));

These don't seem to match the channel numbering for the UARTs
documented in the versatilepb manual, and only cover one UART:

https://developer.arm.com/documentation/dui0224/i/programmer-s-reference/direct-memory-access-controller-and-mapping-registers?lang=en

If we're going to implement this, we should correctly model
it in the versatile board and have the test in tests/qtest.

thanks
-- PMM

