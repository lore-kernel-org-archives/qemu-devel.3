Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8174C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 18:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgndy-00080E-4t; Mon, 06 Jul 2026 14:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgndu-000801-An
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 14:02:06 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgnds-0001mZ-Hx
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 14:02:05 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-66771ded50aso1561656d50.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 11:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783360923; cv=none;
 d=google.com; s=arc-20260327;
 b=eeJ4esZ/d2gNRZ+B3lhBShr9LrTGQxHGH+ouOrNZ0FNOzX+4RvzH9+B5dD8TssLYWi
 Nxfs7KHj/nVq5vS0aJmyGc4tFTMztrviFCrykpCQ2KFld6ijcwYCZzi0A0VszEnWeobl
 1N44Ytx7AEA+tmOEFAP+tqp+LDJIV4wR/cnqZxR/FDo/pyj/Boi5evSl+9z7pmYi5VJJ
 aAF8BA60oHPF8gc6RN10vIS0DJFoC4xyJmlv4mTKVtfOElNJucyg38lDJpmtNIacfyGa
 Uvp1Y5k2F9ZoAjRqk4MVd5vShwOZfK5RbMhXo2+Bb/l63dFhej2PlMbTDonWpC5nHwNL
 4vcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PRIo7JX0dg5nMUku49n19GTUy24gWyqUZVrYxKU3tXA=;
 fh=Uguf3R8TxHhR5mHh7gfIcuDS6LQ7EA6DU0T80F8k7F4=;
 b=T20bpbbWoQWlXgtPr9UYo+6ApjTljdXDC217DyCQQeQkHqKg9Z9yXWZPYWQwU2OVwj
 wNJZyphrx0xBQwAYAsebtkUFvKBLSsHjPncRjr5+/Fi7SSNOaKkgQvC5Lj0TNR9oH3VX
 XX1zTMEsy3jj7KcJjcyOvkuE4096jiIyfua9onGIq+flfYMSskQLTHRaeRd8DjCjg783
 E8A7A8Rv3xj6okAKV1z1LENJGS6Eg08hRI5gM5jUqD6uhzHEP0WnGHAKJsMcwPjbkmxV
 M8uLfawx4DTdlYe22+ll9lVKSKffU1RuRCU57dp88FVLjfriihN4P9nAuoDVkZ+uaL2m
 Okaw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783360923; x=1783965723; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PRIo7JX0dg5nMUku49n19GTUy24gWyqUZVrYxKU3tXA=;
 b=AKTnACYctvYfiHYUgBslpPf6cIs7f8k+PUc9bE8vWqtpD6G2vWUVS/EIoJqRBm1cii
 kJ/Wyv+ddMoLDHazWw4QLDdV7eqs71cSDCQvnwysweXlfSsAmpCUEW9V+CYGrqLgyaiN
 uce4+4PXrSon39b3eWsY5lwKBnvmuLSLLH3f7iMgcN3HGHB5FG38/0ZB9LlaxQo8rrAd
 OMKB4bfLNuP4RRlZrLeD2cMS9B/jGYkXL2h+HHCRM3cDYdLEgBa4KOILfsnYNdgXbwDe
 Xv1NH49gU7FqrXQfi1AdexSvhfxG5OmP1M9f6D6OFELT81Qc0C7ao8IuWbYVoEHI49ID
 GjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783360923; x=1783965723;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRIo7JX0dg5nMUku49n19GTUy24gWyqUZVrYxKU3tXA=;
 b=fWcqfOhDBHYdjLGn/meBIaG4kWVKJ1SREjm6hWYAXfrLOJRjjodQiybKJYaxYbA/9X
 b+d6kzofTTBvOp5QoXcC4CT9cePWjfNSXlWCruPb/i5LopXiHgdHVCLUKyWKjremkhhr
 LvLNGlESFNwh36/9jRpYXvmvSaDeWrTyyIj9MjvV9XJVDy4jpnkzpy5gWJwR64OGtm3z
 TIyxHzLU6kbF4+uRMOty8zCPwwDDIgUtA8H5A5Xk+x3F4Ud1znAzTzAjbLmHaRb7yHX9
 0hMdqVx3wwehrAILWQRfZKQsKN361/b0HHxNwRNkGm4ZJkMLTFRZybi05gljxPT7yj/9
 8INA==
X-Gm-Message-State: AOJu0YwYz3aBxsMgf0NcGdJY0it9qCaeK3jgKika5jJoQoORH3yJ91u4
 QetINLFSAn+rC5Q3/Pin4Sg5zoR7mkMIm8Q94/WIH/BXBnMEC58FUKfJzXU1CviA7NYPMaZ2tcX
 WAB282xx70jdXnYzF6zKmsoTlLi3MVpFMJvf1OQYHJZmPBDg4K093xBQ=
X-Gm-Gg: AfdE7cnCoLteetOxNz1lyeR/BOnZNo58jO4Vl06tOnfciHSI/NQsXs/HyKXTPaSYlaO
 jqI+zGHbkv9voVW0pfE8dgjHZYD2dEWNKeJXPYKes1+0ejUMjL1n9pri/FXJa4CA1UBnkuBqlR1
 0uTsR+uId9EcRRT9GNDl09C5VAOWgINm5ePDS84iWreSZba0ldJ+2UY3qEWQy1rOfaLgr7GGT+N
 GokrK916yPLOsBybri5MzD0yWogItDbgzAunoCHqxcFQ1eFQw7loVIL9/sgwz4gSuGA2iZ2Wv+e
 xdTLY6p1A3S+UZNHhfhsB0ab7Wb0lIxxWXVZJIqPXRU45ZQ6NBFlWWEJ
X-Received: by 2002:a05:690e:4384:b0:664:ae68:33b6 with SMTP id
 956f58d0204a3-6677fab6bdbmr1025383d50.18.1783360922998; Mon, 06 Jul 2026
 11:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <aQtAotYvzFY0Vpft@tcarey.uk>
In-Reply-To: <aQtAotYvzFY0Vpft@tcarey.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jul 2026 19:01:51 +0100
X-Gm-Features: AVVi8CdEi8FKEYPhkair-aJKrhlg57NL3yfupk2uerP5WenNEBPJ8zfSByZfCoM
Message-ID: <CAFEAcA_ZDvuCKGrGZuUYFQKL-7cG3dcNVgyo55P-WRMas6e4VQ@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/edu: restrict dma access to dma buffer
To: Torin Carey <torin@tcarey.uk>
Cc: qemu-devel@nongnu.org, Jiri Slaby <jslaby@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Wed, 5 Nov 2025 at 14:39, Torin Carey <torin@tcarey.uk> wrote:
>
> The EDU device doesn't enforce any bound checks on the addresses provided,
> allowing users of the device to perform arbitrary reads and writes to QEMU's
> address space.
>
> Signed-off-by: Torin Carey <torin@tcarey.uk>
> ---
>  hw/misc/edu.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)

This patch got lost because of a tangent conversation, but the
bug was recently re-reported as
https://gitlab.com/qemu-project/qemu/-/work_items/3852
and I think the patch itself is good and we should apply it.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3852
Fixes: 7b608e5d6c1 ("hw: misc: edu: use qemu_log_mask instead of hw_error")

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index cece633e11..a4b01269e8 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -103,7 +103,7 @@ static void edu_lower_irq(EduState *edu, uint32_t val)
>      }
>  }
>
> -static void edu_check_range(uint64_t xfer_start, uint64_t xfer_size,
> +static bool edu_check_range(uint64_t xfer_start, uint64_t xfer_size,
>                  uint64_t dma_start, uint64_t dma_size)
>  {
>      uint64_t xfer_end = xfer_start + xfer_size;
> @@ -115,13 +115,15 @@ static void edu_check_range(uint64_t xfer_start, uint64_t xfer_size,
>       */
>      if (dma_end >= dma_start && xfer_end >= xfer_start &&
>          xfer_start >= dma_start && xfer_end <= dma_end) {
> -        return;
> +        return true;
>      }
>
>      qemu_log_mask(LOG_GUEST_ERROR,
>                    "EDU: DMA range 0x%016"PRIx64"-0x%016"PRIx64
>                    " out of bounds (0x%016"PRIx64"-0x%016"PRIx64")!",
>                    xfer_start, xfer_end - 1, dma_start, dma_end - 1);
> +
> +    return false;
>  }
>
>  static dma_addr_t edu_clamp_addr(const EduState *edu, dma_addr_t addr)
> @@ -148,16 +150,18 @@ static void edu_dma_timer(void *opaque)
>
>      if (EDU_DMA_DIR(edu->dma.cmd) == EDU_DMA_FROM_PCI) {
>          uint64_t dst = edu->dma.dst;
> -        edu_check_range(dst, edu->dma.cnt, DMA_START, DMA_SIZE);
> -        dst -= DMA_START;
> -        pci_dma_read(&edu->pdev, edu_clamp_addr(edu, edu->dma.src),
> -                edu->dma_buf + dst, edu->dma.cnt);
> +        if (edu_check_range(dst, edu->dma.cnt, DMA_START, DMA_SIZE)) {
> +            dst -= DMA_START;
> +            pci_dma_read(&edu->pdev, edu_clamp_addr(edu, edu->dma.src),
> +                         edu->dma_buf + dst, edu->dma.cnt);
> +        }
>      } else {
>          uint64_t src = edu->dma.src;
> -        edu_check_range(src, edu->dma.cnt, DMA_START, DMA_SIZE);
> -        src -= DMA_START;
> -        pci_dma_write(&edu->pdev, edu_clamp_addr(edu, edu->dma.dst),
> -                edu->dma_buf + src, edu->dma.cnt);
> +        if (edu_check_range(src, edu->dma.cnt, DMA_START, DMA_SIZE)) {
> +            src -= DMA_START;
> +            pci_dma_write(&edu->pdev, edu_clamp_addr(edu, edu->dma.dst),
> +                          edu->dma_buf + src, edu->dma.cnt);
> +        }
>      }
>
>      edu->dma.cmd &= ~EDU_DMA_RUN;

