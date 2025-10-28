Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8668CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 15:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDlL9-00031d-DU; Tue, 28 Oct 2025 11:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDlL6-00031S-Bg
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:10:24 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDlL1-00086f-IM
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:10:23 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-63e11347fd9so6866124d50.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761664214; x=1762269014; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dYcNs8rXS1rm9tm0lxQH2FHKYvfVD+8qNk6YsMg56HU=;
 b=d00b5slITaEJxITwYDRE5Adxs7nW0n7nEX3EBdIPnWnWRVTEkwJl98Afdnip9PltyD
 kx1uD9EbFxdFHYz1B/tDN8GpYZniuQHAwuVmvdoNX4MJgR4Brc3P8QiViV5GUKG4SIaQ
 qsCRsrf3LigKt/5+sXBY31KVWyUmOa/zn75KeWyDy11KJnbQu3p4x23VVwoKcH25JIeL
 G1zSo/fvP2NoW0RxHPLz5cRizAcMnv+QrHE2/KSnAj5Ua5y2jdjBWnL+PEQ4O+Xkkbuv
 uXyHm7OKjyvVfCp8FImNlZ1xKQR5zM4CaxTHUXj8pL0zq7r7JDfg/sjnH+zLY21hI1Tw
 tvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761664214; x=1762269014;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dYcNs8rXS1rm9tm0lxQH2FHKYvfVD+8qNk6YsMg56HU=;
 b=ZX4tG8V0eZDDHlf5FyBZmg7fmVm/+dTvWqVfQsJkB5Iu3wXzsXVOOVbMScWeUu8Yxp
 +nZAiqbaw0Mbpa/lVoHcCY/kvaaA165SMbJzCykW2ej48pXnQaMjuNHZ/BzirlJ7+t1b
 55SQd/u5qiZ8vxhjpY8UOv3Jqpz+SUanpal6DmY4ijUCQSvPrqt/MjXnXaMZiEtS/wQz
 LUpghmvC8HzsQ2LvEKkjGrN6+JLafD1TUtpLGHvUa2FgOv4bCsESQlCF5Uf7H8Cxfdwx
 Wchshp4Beq53ZxFuUdlQb4SGZFm6a5JfNZIMqffFWlb8COQS33aXRdreLs/5zGrH+G8q
 OuAQ==
X-Gm-Message-State: AOJu0YxYqTPMQ9otZXE2TFQnSOZ+yy3j7WC9c8G7NLOhl7NMe8I/i604
 uINqAQfCMaxMXg2Wg7jLyiUkbHPWZV+mEifgAbnofFRLAgrTlUNLHP8aDOi5vVE6ixRXnXaN/8A
 o/JXmV4YnOhaudI/Vd2oEMVnVllAakfVxETgaXjq1vQ==
X-Gm-Gg: ASbGncuPPHW6HVi+ZMyN6tFzk3dFxeLkcLF5z0BUXzqSVEM8Ef7FTfRPW4+sgzB3v7r
 qMpTylrZg0oUAPYNOBf/Z3iCTB6GTU4g6ayxmnxToG+O3CzeeH0+BwRAVfpOvpat8LZGIEzOGwT
 9FtJiJt8/mfwqSQFrkWWeMIvWM5/xv3b5eWVtWyIRaph2wbhlcPC1WsOaAC3luo5Rwzdzya9NNL
 c3UJuteVo57iESnqQpOEdc8LRsl6hsPD2BDo7TGbzXWZLTOFTV7KDzw3b5EsQ==
X-Google-Smtp-Source: AGHT+IHVm/mHu01rL9mv161GpmbbE8cM5xl7E+V+bdyX3Ii6z8UFAGOd4fxeSguEoFUitxzAN+nLY+sHeyF6MmgxCLM=
X-Received: by 2002:a05:690e:1503:b0:63e:1ee2:eb03 with SMTP id
 956f58d0204a3-63f6ba8a0e8mr3560413d50.45.1761664212476; Tue, 28 Oct 2025
 08:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230707090628.2210346-1-jasowang@redhat.com>
 <20230707090628.2210346-3-jasowang@redhat.com>
In-Reply-To: <20230707090628.2210346-3-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Oct 2025 15:10:00 +0000
X-Gm-Features: AWmQ_bmjW1xUuotHYqbYE5R67xZSCQMm8IbeVSx1-yKrpAIwriMwfPzpXJc2A4w
Message-ID: <CAFEAcA_=dzzvbABCqt9mo70-e+c9FuVq0fr8_NPN67LSfv_=cQ@mail.gmail.com>
Subject: Re: [PULL 02/15] hw/net: e1000: Remove the logic of padding short
 frames in the receive path
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 Bin Meng <bmeng@tinylab.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Fri, 7 Jul 2023 at 10:06, Jason Wang <jasowang@redhat.com> wrote:
>
> From: Bin Meng <bmeng@tinylab.org>
>
> Now that we have implemented unified short frames padding in the
> QEMU networking codes, remove the same logic in the NIC codes.
>
> This actually reverts commit 78aeb23eded2d0b765bf9145c71f80025b568acd.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/net/e1000.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index aae5f0b..093c2d4 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -888,7 +888,6 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
>      uint16_t vlan_special = 0;
>      uint8_t vlan_status = 0;
>      uint8_t min_buf[ETH_ZLEN];
> -    struct iovec min_iov;
>      uint8_t *filter_buf = iov->iov_base;
>      size_t size = iov_size(iov, iovcnt);
>      size_t iov_ofs = 0;
> @@ -905,15 +904,7 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
>          return 0;
>      }
>
> -    /* Pad to minimum Ethernet frame length */
> -    if (size < sizeof(min_buf)) {
> -        iov_to_buf(iov, iovcnt, 0, min_buf, size);
> -        memset(&min_buf[size], 0, sizeof(min_buf) - size);
> -        min_iov.iov_base = filter_buf = min_buf;
> -        min_iov.iov_len = size = sizeof(min_buf);
> -        iovcnt = 1;
> -        iov = &min_iov;
> -    } else if (iov->iov_len < MAXIMUM_ETHERNET_HDR_LEN) {
> +    if (iov->iov_len < MAXIMUM_ETHERNET_HDR_LEN) {
>          /* This is very unlikely, but may happen. */
>          iov_to_buf(iov, iovcnt, 0, min_buf, MAXIMUM_ETHERNET_HDR_LEN);
>          filter_buf = min_buf;

Hi; I'm investigating https://gitlab.com/qemu-project/qemu/-/issues/3043
and part of the problem seems to be this commit.

The repro case puts the e1000 into loopback mode, and then makes
the e1000 send out a zero-sized packet, which the net/ code feeds
back into the e1000's receive path. This then falls over because
the code in e1000_receive_iov() is not expecting a zero length iov
and walks off the end of the iov. Before this code was removed,
we would have padded the packet out to the minimum frame length.

If the idea is that ethernet device models can now assume
the packet is not short, who is responsible for ensuring
this for cases like loopback? Is it a bug in the e1000
transmit path? Or should the net core code be padding?
Is there somewhere we can conveniently assert that we
really did do the padding so that other cases which got
missed at least assert rather than walking off buffers?

thanks
-- PMM

