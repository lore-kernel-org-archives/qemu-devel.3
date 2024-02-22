Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E4AC54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 14:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd9ik-0007Yf-Og; Thu, 22 Feb 2024 09:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd9ij-0007YG-CV
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 09:06:41 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd9iW-0002if-Th
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 09:06:40 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-563bb51c36eso8884003a12.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 06:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708610786; x=1709215586; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/gN+lxFiYIXXg/JZudh8kyx+u16dFl+hMXNnhT9WrOo=;
 b=cahoZx/EJXNOvr/Y6daFJZHEoZ5WHBgXd8fzS94h4TNsLmX5JsGyAk/xBqybNgR+nh
 8pWd61NnFpyNExKTRhZq8dqt7L9JiF7uImJvtOabT8XjUX7eVUAhHBCzmLJkXp3mLIkG
 yMcPbwAzxC5ChstOufFXWKyUCDVPaGkGpwz9XQBJGTC3w/jh9pDfFuiQB3hZ30Bb/Tpd
 H6ZP15Kwup9S5sp793lbpsfGOStG2dCgOQ0xJB2Pw6KAxKUaWWWeZTKj4BvipdnjTTiE
 fd5/3QtZi2yQu/G+/neTDqGGXf9mganalrqzaK6OXAK+2xte98vyqHjSNkRqF39jFTsT
 0vJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708610786; x=1709215586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/gN+lxFiYIXXg/JZudh8kyx+u16dFl+hMXNnhT9WrOo=;
 b=NfxO2vJQsH7cNJ6ZBr1Wt9uwD8YjiLsZ09rzCDUO43wAdWDs8MdPGkk0WjH0D31fvp
 YW5cyGUFMvs9U2zJOT/5tzkQ/LbD4XiyiDTWyyGiov1QFtJLdKk1mmtW3DLjsLTJmney
 Zi7gHDtANSON/rtTSXd3b8D80UljNUpxgtpcER96EnAKiHjPcYtJLIWRxNo6SaOOS7yb
 /6tCtWavuys8c6nJgWGZXcnBqViFMcqVUSSj/ePjpv71NVIS4/5bo0g/Ha2lm+9uBGmb
 pGBZI6dqVuKYYZth1De4Qj6pb5zwvTgnUQdvn9IcMmVjJb2tmO5262iXSbyAKkU+ZBC/
 j1Pw==
X-Gm-Message-State: AOJu0YyPLmK4n9PqZV5OvRdjanS4QHl/eaCPRXOwihp+IdZZ0FEM0kh3
 kF0K/ePaUZdcAldqw7DqRz2nROKcHJj1Af9rV6Dci8zYofCDV2dhm4ueuxIhPKjUBRjVHsznz/N
 n37v9KXRB/hu1yKU0vXPR8Hm2IkGIHtlkeUt4+x0glzbLQa4s
X-Google-Smtp-Source: AGHT+IF02gvykkI6XZZ4GPePorXt5xtP9a+7v3+xoe+4aFAWp8n4Trk31PRR9qf4nexwbyIFEDcnwYdHulOqnoQpEEY=
X-Received: by 2002:aa7:db42:0:b0:565:d5b:c9ab with SMTP id
 n2-20020aa7db42000000b005650d5bc9abmr2697386edt.39.1708610786663; Thu, 22 Feb
 2024 06:06:26 -0800 (PST)
MIME-Version: 1.0
References: <20240219105637.65052-1-sai.pavan.boddu@amd.com>
In-Reply-To: <20240219105637.65052-1-sai.pavan.boddu@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 14:06:15 +0000
Message-ID: <CAFEAcA-NBxOa9fXW6kEN4cyFgxwzO1dWOHxsUNcOj35YYnY6Tg@mail.gmail.com>
Subject: Re: [PATCH v2] xlnx-versal-ospi: disable reentrancy detection for
 iomem_dac
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, 
 Kevin Wolf <kwolf@redhat.com>, Francisco Iglesias <frasse.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 19 Feb 2024 at 10:56, Sai Pavan Boddu <sai.pavan.boddu@amd.com> wrote:
>
> The OSPI DMA reads flash data through the OSPI linear address space (the
> iomem_dac region), because of this the reentrancy guard introduced in
> commit a2e1753b ("memory: prevent dma-reentracy issues") is disabled for
> the memory region.
>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> ---
> Changes for V2:
>         Added code comments.
>
>  hw/ssi/xlnx-versal-ospi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
> index c7b95b1f37..c479138ec1 100644
> --- a/hw/ssi/xlnx-versal-ospi.c
> +++ b/hw/ssi/xlnx-versal-ospi.c
> @@ -1772,6 +1772,12 @@ static void xlnx_versal_ospi_init(Object *obj)
>      memory_region_init_io(&s->iomem_dac, obj, &ospi_dac_ops, s,
>                            TYPE_XILINX_VERSAL_OSPI "-dac", 0x20000000);
>      sysbus_init_mmio(sbd, &s->iomem_dac);
> +    /*
> +     * The OSPI DMA reads flash data through the OSPI linear address space (the
> +     * iomem_dac region), because of this the reentrancy guard needs to be
> +     * disabled.
> +     */
> +    s->iomem_dac.disable_reentrancy_guard = true;



Applied to target-arm.next, thanks.

-- PMM

