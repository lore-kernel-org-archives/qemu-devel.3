Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69BFEC01CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4dmy-0005wt-R2; Mon, 23 Mar 2026 07:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4dmx-0005wU-Hf
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:49:43 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4dmw-0002E7-1N
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:49:43 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64ae222d978so4168307d50.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 04:49:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774266581; cv=none;
 d=google.com; s=arc-20240605;
 b=IBWpQrSltVJleS+JdFb+3oTWFo6utepeiMfKtnneEUDUBEtevQdyQtd3ltiFbEH3SN
 udA+XkGLz9ifooAGvVjAPJdO1t0FtbQ4IjrnsvH5zqmGyIdfwBXLfrQsq8hNeOFQOS9v
 dAkuaDh+ClWKYKRIeHaIgFMwxjlvBJN64CgMaIDlrHHay+OPXYVHMk8+6zjLc6FxltZX
 xSiDoaxZYOJRVApnb5GC8iS14SW2JbLYBBwjyWZ47k8K2HD6rdtz8nxzOtYogI7eRJLQ
 aPRe0+mCGHSm3HWOrcrqRCNegWWqFwb4BR6X0V27bvoSphEwBtnCU6dLp/soIVM1Nfl5
 pbmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=a/I1sHcUTA9qsXLQZGVHbSeHDN/6/UdW2iP3Bh5paiU=;
 fh=gS8oh9EHdcTDcglskGyIv3/M5LtfI+jKdwGYJC227W4=;
 b=Y2/m1gYQ4kdAWplQdb3FS41jO8isCi9tmuQ3IWAigRkvcXpJP+Q1HzUaxGqyF3KBM/
 SGTY0nqz2KZC0Ec1KzI7Ky26/q7CYk92SbbT9YCYrjFJ8M2LkbDYDXdQ40doHR/7g/hu
 y/XA+zHXhhLb5sIfrYQY6XdEUReZ9U3HaqQACcOs/9rv8hrPZ/HOjFCvY7nZFoBO83jB
 ljtBHwrtNsBTaiL0C4qCnaxHGFeA0Bzu0C2jIC3drlKz0nbilfpc3uQxsaDCurHKEEAz
 5HdXohR/CC5oJcIEfWqVAqrxNJuj/t/1gAHchHk5r9mDyyoQNJdkY+s60LcpAj+dutrG
 2ElQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774266581; x=1774871381; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a/I1sHcUTA9qsXLQZGVHbSeHDN/6/UdW2iP3Bh5paiU=;
 b=wpaOF6fJqQGdvUPqoq0bDFPPJZPJ04qv3B+vmvp0avxlI2SStH/SCCQpKqoq7et7bL
 fiDHj+zd1akjyC1KoQRv4Ap3owuV552aDmZf8JhSlezymQjlWSWfEKvi4lgqvJPbGyyc
 6+OyVGud1HZCP8pyP92+ig8QtJoKkZ2dhVNusBohIqC9mpR9QzMmTUIKJnLGSRHpl0Kg
 A4yQe5gBXR7RZQDpnK3Xvy5DMZv7fBRR5I28h9SPzh7XKbb3IBstQZTn/hAvj15oAMnD
 Mq6IIJVeOQFOMj7HH1jADJoiOJlu0FYGP/JWWt8C17piteHI+wBk7P2n+VRE9ZPe9im1
 lYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774266581; x=1774871381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/I1sHcUTA9qsXLQZGVHbSeHDN/6/UdW2iP3Bh5paiU=;
 b=QNra8FbSRati8JsTEb3ge+3lup93/iccWh5eW1jz4Po4Kx/Dw9sURc2hF9OVvZ36QK
 OmGOqndewpzEYpk2Ebg72WMZULKglC7FjfMLw0+ataUDwTOg+I7GJLRJtR5/L7XeAtIh
 BgFvVP4s8kgrnFv1iff/ZfSR1WvuHYsdOrFWDQ9SXAAW5GrmfyFdOF8W2u6lQ2aJFLs5
 tblI4GP8GMIrMW6bl7NgEnythy4ZoDGo7mRYxTcI06iPISGj2XvEo/r0PxVmvygWzWzk
 7VTAfPgmnL4tcJLKhyC/iCKgegjdYC1yTAMcjxa+7rDqzTi5Cv9Py1Us6yu7SYKNoFni
 1NpA==
X-Gm-Message-State: AOJu0YzlyGOQbSBjAXgCmcF9+3lJTP+aMx6TcxA7Vylt0gXb/bODuRep
 MAhvP1qxLrsBWC8SF6ASG3LS01XeDDp6U9AgiAKmaoDY9+EmmhLRioW5qKi29tBVi8T3XTTRdPt
 T0pmXo6FyGRtXNAShHm4/3ivUpNvRcsAQSj1E8LxH4A==
X-Gm-Gg: ATEYQzzhRrjPHYaCiw4+p+iyE65KfQl/3UC/id5owhoc3avwPZlv85ZbSbl0SV8B2rY
 a5k5nLULNZmieIv36Y6FRC8wkpoZFHS5PZnInSbgLPPqLv7qJCSpnNgC1pnxMtS2taswD9zoAY4
 gBHN9k14xLIghNIjwvEPVpZhXYTKupd5urUuYHsc5xdchxyyy+X036QWnYu80SVx3w9q76qHKUv
 +y8QS7Ftee2rL84psFpIJyHGASb+k5qsGJBVuWKnkPd8H4N42LGR29i0gWY3eOWYfcQLzpqKV2h
 2PZvJWtMf4DFzClrfMJm+HWUWpgvCGIQBJZ8JmjCAkfz7EIwZaupI5aKd9L9TV1+XCXHFhL/O/5
 fQw==
X-Received: by 2002:a05:690c:4990:b0:795:294c:fd4d with SMTP id
 00721157ae682-79a90b7acafmr126214287b3.37.1774266580781; Mon, 23 Mar 2026
 04:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774099044.git.dingtao0430@163.com>
 <3411a43d161ef59db3db1d7ed0f84839d50ceb33.1774099044.git.dingtao0430@163.com>
In-Reply-To: <3411a43d161ef59db3db1d7ed0f84839d50ceb33.1774099044.git.dingtao0430@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2026 11:49:29 +0000
X-Gm-Features: AaiRm53HhedbXWr_RWJu6Gfz2JH9Ik2ijt8qkpuhXrrQ02EO0bn5VFgKHhiSubk
Message-ID: <CAFEAcA_0JMqY-RCKtKL0uaVKFVfmPSR2-Ta7Eo2FHY9qRp0ThQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] PL011 generate receive timeout interrupt
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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
> After changing the read_trigger, no interrupt will be generated when the data
> in the rx FIFO of pl011 does not reach the FIFO level. This will cause input
> in the console to have no effect in Linux, until data input exceeds the FIFO level.

This sounds like you created a regression in patch 1 and are now
fixing it here. You should order changes to avoid doing that.

> But UART will generate an interrupt after a timeout period after RX receives the data.
> The relevant description of this in TRM :
>     *The receive timeout interrupt is asserted when the receive FIFO is not empty, and no
>     more data is received during a 32-bit period.
>
> To simplify this operation, pl011 immediately generates an RT interrupt upon receiving data,
> which means the period is triggered instantly. (QEMUTimer triggering is also optional)
>
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> ---
>  hw/char/pl011.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index c96a706da1..58803f0fc2 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -200,6 +200,9 @@ static void pl011_fifo_rx_put(void *opaque, uint32_t value)
>      }
>      if (s->read_count == s->read_trigger) {
>          s->int_level |= INT_RX;
> +    }
> +    if (s->read_count) {
> +        s->int_level |= INT_RT;
>          pl011_update(s);
>      }
>  }
> @@ -281,6 +284,7 @@ static uint32_t pl011_read_rxdata(PL011State *s)
>      }
>      if (s->read_count == 0) {
>          s->flags |= PL011_FLAG_RXFE;
> +        s->int_level &= ~INT_RT;
>      }
>      if (s->read_count == s->read_trigger - 1) {
>          s->int_level &= ~INT_RX;

But if we do this, what was the point in changing patch 1 so as to
make read_trigger accurate? Now we are back to where we were
before, where we trigger an interrupt when there's any data in
the FIFO. (At least we do understand better now why we see the
problem...)

thanks
-- PMM

