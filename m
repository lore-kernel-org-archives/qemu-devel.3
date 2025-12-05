Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BC8D2F7D1
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 10:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRT7r-0007fB-A3; Fri, 05 Dec 2025 05:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vRT7q-0007f2-29
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 05:33:22 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vRT7o-0002xd-Hs
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 05:33:21 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6443bc360bdso1687238d50.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 02:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764930799; x=1765535599; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kXfINn6d6AVvIaVaiK0+GAywxgUy3ybiY67UBJ9l20A=;
 b=CUlXBxWPWQMpattGLTzrsasr9xVk0SF6SbVGkW2X+uzrKfw/SiZFo+uRGkERk8oeaz
 nIy8WQFATuNuSydPY34i8TmiZ4i6L/RgAbiSjOUz5YoDn+b9PWXiOPl1SYFjt/yh94Hh
 lFs1cZwxzPL9LuOVZU6zicH2Ujkh02wXoG1iQt0kgRPrM6gQjW6017NlyiWE2F44H0nJ
 2J5JeShOyKsUuatjZy9vqJA+dE8PS1q5qLs+181OEnl3tAtapdrA/gZu+gxUaWRLgHcf
 Q/BTqlRKXUD6utPsxN+A37ZT+2zwa6MyI/lUE4QdXkUYjTnlMI3xQeXkBtz5CcDX0EXh
 5V3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764930799; x=1765535599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXfINn6d6AVvIaVaiK0+GAywxgUy3ybiY67UBJ9l20A=;
 b=K4xVfZpGc7+/BqcVdSFLsjjYtXcsovo4AWyBvXSlX67hfKLiEL12BgNrGuEOvzEwpX
 d8+tW10scHlG+CvXjTgdCcU540N23g1y7VBtxcK2f7sSaeH/G9Ej5PF3icv/RxL3QgAP
 wON8I4r/cjpIiveySJho3BsrtVfE6lBaqVfGjkDyaWL2ZPA14i8zWZE1wOyW1SNofJKy
 axOvteIvANMZwqRw0FtswPR1uY5gqOyx2ienb2js7kpv7/ZpQSY5rlEZNskh/B2L44e4
 21KXwv3ay/l/GpBOH8XwUEJ5jrydYiGuY32sX2oNLCzX9qBRxVOTC8iqN0bc9+F+lQGQ
 QB2g==
X-Gm-Message-State: AOJu0Yx0NI3+whRknYcfUCrkZ8ELNGYqBtDHwZpsjngm4Cf/AV37YdsO
 wgRG2qqdu0SdMna9fFTB60nGXpqyx1PoPYjAuRy32rVTte5/0urLbsEvZTSGpZEzAWcBn3amU+U
 xKmcqpd7/3R89Z5jOgLkiTtK7vhjBdiKVGPgK0RYfig==
X-Gm-Gg: ASbGncscA3I+EyIVRna88hzAWpnVU8Y0vb8I6mW8CVxrdMScYD+NvNu+8l75Be14ZCY
 vZ2Sya2PnRvMFBnQsD7xd2lmBHlf+JdjhcoFT+ffIjluOLubyu6DPYNEG9/4H8qk6HCLFMiqvVl
 rh5yQyNWAv0MzYiRa4TTqXT+jvmsfGFpPFmxThXBPfGKZb56fq/VLnywLR6n66Nkl4G/40sOokq
 JclvYTvC+1O+UX/BwB+c+M4lnzSkQkezsa+zV8XIenouM3HQcWf7nboCUyPFb+F3ocS80eqcReq
 KB5Yv74=
X-Google-Smtp-Source: AGHT+IH6mxOJqFMjAvr9XptP5rLAw42Tq7oDzPgl7MwyhCBT840pd2o5DOaXj6ZwhIYy3wfW8OoFWidQTwXgwcxZmWg=
X-Received: by 2002:a05:690c:23c5:b0:787:e3c0:f61f with SMTP id
 00721157ae682-78c1890e3c6mr98833737b3.57.1764930799132; Fri, 05 Dec 2025
 02:33:19 -0800 (PST)
MIME-Version: 1.0
References: <20251204193311.1281133-1-jim.macarthur@linaro.org>
In-Reply-To: <20251204193311.1281133-1-jim.macarthur@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Dec 2025 10:33:07 +0000
X-Gm-Features: AWmQ_bmb6yVFxlVe983n5vyLxNt5308SiNUPWg-0a4kSuLvE2jObWnsbQbxzSeg
Message-ID: <CAFEAcA_s2fDnr6PQfvjjYT_wnmMg1YUw=tVY5SnM2-QrDAh68A@mail.gmail.com>
Subject: Re: [PATCH] hw/dma/omap_dma.c: Use 64 bit maths for
 omap_dma_transfer_setup
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Thu, 4 Dec 2025 at 19:34, Jim MacArthur <jim.macarthur@linaro.org> wrote:
>
> If both frame and element count are 65535, which appears valid from my
> reading of the OMAP5912 documentation, then some of the calculations
> will overflow the 32-bit signed integer range and produce a negative
> min_elems value.
>
> Raised by #3204 (https://gitlab.com/qemu-project/qemu/-/issues/3204).
>
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>  hw/dma/omap_dma.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
> index 101f91f4a3..93e6503ff9 100644
> --- a/hw/dma/omap_dma.c
> +++ b/hw/dma/omap_dma.c
> @@ -504,9 +504,19 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
>      struct omap_dma_channel_s *ch = dma->opaque;
>      struct omap_dma_s *s = dma->dma->opaque;
>      int frames, min_elems, elements[__omap_dma_intr_last];
> +    uint64_t frames64, frame64, elements64, element64;
>
>      a = &ch->active_set;
>
> +    /*
> +     * We do maths with the frame and element fields which exceeds
> +     * a signed 32-bit integer, so convert all these to 64 bit for future use.
> +     */
> +    frames64 = a->frames;
> +    frame64 = a->frame;
> +    elements64 = a->elements;
> +    element64 = a->element;

The real hardware is surely not doing 64-bit arithmetic though.
It's presumably working with elements * frames as unsigned 32 bit
multiplication.

-- PMM

