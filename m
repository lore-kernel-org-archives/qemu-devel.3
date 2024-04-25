Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8DFC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 09:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzvNO-00021H-2c; Thu, 25 Apr 2024 05:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzvNN-00020w-4p
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 05:26:45 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzvNJ-0003Al-Tq
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 05:26:44 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57222fc625aso774082a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 02:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714037190; x=1714641990; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rTcffbbh8St6G03hXiCUZ15jJjGKzFrEgvJRCgxAEUc=;
 b=iycjK0CwcH1R6gl+sbxhVb7vJItlq+zdKCGvKUbgkpIxOBQR2SUy/+L1g2BV30T/Mw
 biCzEtwl7NW0WjTCK+1zZDng12Z/Y7aXqbabKw/RfuFfarTlBLPz2w9mv7J2Lb/S0C3D
 n02DzWA1xmo0l9AaNwPGo6fIiluYhINyHJPf7o+dxUoaEO2n56orQlxsl2SXVbw9LCgA
 IfZMVS48xPeIY3Me4FOUWSFrW6/wmjxmmiFJzQ4LnrHnYPgrK8byU/gOa9yk5KyRGWKl
 73NZFoz6kFIjcDVOV1939aVNsiOPI6CHPtZLPT/29dWyCZTlwqaMYmD1rep4ZjhLVlPC
 WDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714037190; x=1714641990;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rTcffbbh8St6G03hXiCUZ15jJjGKzFrEgvJRCgxAEUc=;
 b=JzoWj6IFftecPfAI1ZzmuRo/7aB3+HG6xW63gZ9LCnddToOztjh6ygPOeNM6wcymCf
 zw1A6xBgOlkmUNXvN6fSjbYEO3tNqGw9wMnOmwfuyqq9yGcRAJl5Ho6exiUmbomnvbZj
 93oYRtQAkTUD3d6wmEVTcnilYX46Tm/wezLHq8tCnm7UTGbbhCko4TLNCboIP8axO2Jd
 +1H1kh8yrTAw8ZuA/nri+Mfzpp4JfP1A+vvcpZNyFq2GXdYMSBa0yfZOCZlAAXKBT+AB
 1HjnuOnDvqjMne6I6B2ADo2zPsN9juUJObskrt3R0f+RnIRLAVxwwD0ox4NSYiTwKsMK
 f4cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAPlJNie9A3xF95hnMaCVssD/or2ZMsKZqGLf1UWyr5ZiWzU5f5iMTy8GoDUBWYj7HBKMFlEJvXzubgy0TmnQvBfAXGY0=
X-Gm-Message-State: AOJu0YxaDFjByn9LfXJhXENK1+aiKdZC1L+Ku35mZvBK7OoOtAuyeNMi
 WpUhoetqJs8dWJuSoadpTQLcwdAchc835NP3908q69tSoKEUv9AmpOB+C95fPKh8XM5lm8mambD
 3tqTO/hmu+AKR0Vm/RGFGHOdJjl8aaFhHzx060A==
X-Google-Smtp-Source: AGHT+IGyrGc53FuIcUI9NmHGq/In0vHAgY8gP8zEdtDntnoLKPyjQf3mcJ0tHypclf18Ha85cdOKtP/ev3khvC382qA=
X-Received: by 2002:a50:d70f:0:b0:570:1161:111f with SMTP id
 t15-20020a50d70f000000b005701161111fmr4632748edi.15.1714037190260; Thu, 25
 Apr 2024 02:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-=kk_TQVRLLQvH96DC-ffmDqd_hU5=z=Og8ntYGxPUeg@mail.gmail.com>
 <20240424181321.20844-1-adiupina@astralinux.ru>
In-Reply-To: <20240424181321.20844-1-adiupina@astralinux.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Apr 2024 10:26:18 +0100
Message-ID: <CAFEAcA-6td71-XBL6dp49L2uZGTbMphJcFeZbi6ReZrm3AHNbA@mail.gmail.com>
Subject: Re: [PATCH] fix host-endianness bug
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: Alistair Francis <alistair@alistair23.me>, "Konrad,
 Frederic" <Frederic.Konrad@amd.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
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

On Wed, 24 Apr 2024 at 19:13, Alexandra Diupina <adiupina@astralinux.ru> wrote:
>
> Add a function xlnx_dpdma_read_descriptor() that
> combines reading the descriptor from desc_addr
> by calling dma_memory_read() and swapping desc
> fields from guest memory order to host memory order.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: d3c6369a96 ("introduce xlnx-dpdma")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
>  hw/dma/xlnx_dpdma.c | 38 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
> index 1f5cd64ed1..5fd4e31699 100644
> --- a/hw/dma/xlnx_dpdma.c
> +++ b/hw/dma/xlnx_dpdma.c
> @@ -614,6 +614,38 @@ static void xlnx_dpdma_register_types(void)
>      type_register_static(&xlnx_dpdma_info);
>  }
>
> +static MemTxResult xlnx_dpdma_read_descriptor(XlnxDPDMAState *s, uint8_t channel,
> +                                        uint64_t desc_addr, DPDMADescriptor *desc)
> +{
> +    if (dma_memory_read(&address_space_memory, desc_addr, &desc,
> +                            sizeof(DPDMADescriptor), MEMTXATTRS_UNSPECIFIED)) {
> +        s->registers[DPDMA_EISR] |= ((1 << 1) << channel);
> +        xlnx_dpdma_update_irq(s);
> +        s->operation_finished[channel] = true;

I think these three lines in the if() here should remain at the callsite --
although we only have one place that reads a descriptor at the
moment, different callers might in theory handle the descriptor-read
failure differently.

> +        return MEMTX_ERROR;

Otherwise this looks good; thanks.

-- PMM

