Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E340ECD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 13:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKFbn-0005y0-Ex; Tue, 05 May 2026 09:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKFbm-0005xo-6Z
 for qemu-devel@nongnu.org; Tue, 05 May 2026 09:14:42 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKFbk-0003Nj-Op
 for qemu-devel@nongnu.org; Tue, 05 May 2026 09:14:41 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-651b4d09141so6355008d50.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 06:14:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777986879; cv=none;
 d=google.com; s=arc-20240605;
 b=Gw+xrpN2L8jQzBYl/ipBW2dLhxwrF49SswRfPhEAuPhxYteI5LkVCST4DxV9FWd+c8
 6UK22Ae7AGo0aP0f+XNPaxGaMXhSdlEdbddgLyRYYFpVvXWwuqGXr9rf3fEYjaEyV7Jy
 YCC8/jcu/jgDMY3Hk3I+8OJUvHd3nJPlmUOBu2+mjXnkBGM1shDirt0f8l92YV1siHgU
 c/rME+6j1gkarn8V+2QykCvzwHvAJ9I58igyIcI9NHVuS7ZprLSrKZxJvp2or7CZX1B+
 12H5W87NidYudmcWp0w49hZLLCOrB0FbTJ1uNvLmG8Q5wD12wNgeiny4V+upiaMvMoK2
 sYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jFj+m3ANLwfBL8TVDVO9I/954+yCRi97jEpvmTYX538=;
 fh=V1D/6XYVUI1/Iqxcqp+K29qGZgJ5iJe5U9bTAolPSKc=;
 b=MUbhq+Vg2sA8fkzXCuDJhRNgiId+avlYzE5TJIexgbhkcymH6b+da5yjNtGRSCNc6d
 YVoc67+TRS9yqK99n3d0YvQ4lePSyO7e1PGLXRQvN7NUsNMZrbZ3G0f8aYfQACPDiUjb
 McU6YeUgUEfoYXr4laJKaRQsM25GLAwz03Nc4daTmt446kTg21kKaQlhThcGB2Qen8I4
 iC5pNzOFLJHu0tYubaa/MVgNwxTqhPk+jQSTp/7JnpBZGVVzoJ8oFYoo/H53gOxL31vu
 DI2M0HBk6JrY1DRxBE6nYH4Bb7yZLpGA8X1S4AZLjCLu5O02mUYOg+t6MgQBPiNrXqTR
 X8Kw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777986879; x=1778591679; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jFj+m3ANLwfBL8TVDVO9I/954+yCRi97jEpvmTYX538=;
 b=Au6NJ1ddNOfqwm5JE1JBlRZjlGlTdulkICwIuG6VbMQmYxK66dGhOPOmU3VgImUiSK
 dLo6f6OLw8yU3fI9BsrR7vjhTEW/DncyO7xaswZVDGa1xi6wPH194YXfINdQ2WQh2/eG
 Upazik6hSoWoBH8Ei5ik93den5nu57G//XbAB8HSilq7QHDWozLstlglZoGMnMnIWz5o
 UiHQTtILKcjIfvIOGt0YUyBAqmlIOSEqIM2FaoGTf4BTOM//GNGaRNAe8dOV4tM9XXGF
 F6QxcimdvaQ7O54eDDKrFjpxS+bQgTVNhrMahAjxQrIqcegFReeNRzNWdDuXQtXPJQul
 /QRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777986879; x=1778591679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFj+m3ANLwfBL8TVDVO9I/954+yCRi97jEpvmTYX538=;
 b=N71haKWeyeIT7WNK0hAv2uytMt8UNnJw3zqRuoEAnQ2mz8uYdyqqZlsJPiEVyBk9zx
 vpAk5sTOgeKp/RRR4P35ui3EF1VtuYqtwJf61/KppbVfbO/n20ym6gD/ByqFrKmF9YKd
 7WCxXuF8M/Ngy4LhcB+Dwhh6Fw+drxeQhj7ciLCOA7zsnIxWIKp0+PcCThvY/qkJovgb
 YoT3LuIHFdRTbP20Xri3Q8zty6FMZnvXGxsKt4rgRlO+Rf8DKLzd4ZRgnOi9mWAcvpTr
 yux3pFAieTi3hM0X0ZLZhE32/En+/MI5VH/mDE5FXHI0Cruc+xLwUGKVAF9bJVEqavY6
 l/UA==
X-Gm-Message-State: AOJu0YyjdVMsq0pkQ4yy2QzOLPHdfv/wlVKqBOAN1NMRejkedD+JKtU2
 N1a82uHACC4Y9I6/7wosunSZgAXz/g2zIJ6SRUdAMKI/02Y3ITAi7DvOQ2iTFHMcP6K2vhIe3Tz
 4W8ed7uucvb9y1gXvsZp/yAd57TGOZqytvRrJmFzuNqsrq8BWSVUgH/E=
X-Gm-Gg: AeBDievUAIqD9wNUHfeZPEOkt2B0UNDSjhNpcVeSttYPCAtrlmrxslV0TWdQCetnFgR
 hoQ9XrRZKZr+mvh10NJmuXYY2Asb/jUiSFxpxGOgXbR6xRHGuVYeKSTFhuC44SBGZUStMIB2rCC
 IOMak/1Q8TNPrUzw4/Oc7bOlPYx52c+YGbJUJfdwED/1c/lfjjeCuNydVvKJLiE6WmiihHq1e5R
 Q+dr9pFJqFn6OLIxPHZCVrfTHgv7F947W+zK1uQsQPoSoqpcGwdpgIaG2RvcFMtbeOo5p+JBau/
 yvvk+oyP3O4FqYbzH+Bb+lMs8l8upsscv03ex/UsOurCcg4InOdBTkg9R5SCGXTrFblVLY8wkP6
 mSQ==
X-Received: by 2002:a05:690e:134f:b0:65c:6f05:ae25 with SMTP id
 956f58d0204a3-65c6f05b481mr1390070d50.30.1777986879340; Tue, 05 May 2026
 06:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260505110036.47574-1-munkhuu0825@gmail.com>
In-Reply-To: <20260505110036.47574-1-munkhuu0825@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2026 14:14:27 +0100
X-Gm-Features: AVHnY4J6rzzHl8etgGPGLf0fiHPd-ufv6Ds-nnh5TT3q5R77mc_XrpIlKbSk1-E
Message-ID: <CAFEAcA8s+YW9n78=75VMetVP-10mMiTkzrxCHgHK7kdvP-50jg@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fix memory leak in ohci_service_iso_td()
To: munkhuu0825@gmail.com
Cc: qemu-devel@nongnu.org
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

On Tue, 5 May 2026 at 12:01, <munkhuu0825@gmail.com> wrote:
>
> From: heropd <munkhuu0825@gmail.com>
>
> Fix a memory leak in ohci_service_iso_td() by calling
> usb_packet_cleanup() before freeing USBPacket.
>
> Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3463


> ---
>  hw/usb/hcd-ohci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index 6ed8046fc2..43c49a42ec 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -748,6 +748,7 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed)
>      usb_handle_packet(dev, pkt);
>      if (pkt->status == USB_RET_ASYNC) {
>          usb_device_flush_ep_queue(dev, ep);
> +        usb_packet_cleanup(pkt);
>          g_free(pkt);
>          return 1;
>      }

I don't really understand the USB subsystem, but something seems
odd here. The case when usb_handle_packet() can set the
p->status to USB_RET_ASYNC is when it has added it to a queue,
either directly ("QTAILQ_INSERT_TAIL(&p->ep->queue, p, queue);")
or by calling usb_queue_one(). The usb_device_flush_ep_queue()
does not (as far as I can tell) remove the queued packet. So it
seems wrong to me that this code path frees the packet, and
also if we call usb_packet_cleanup() it will do
    assert(!usb_packet_is_inflight(p));
which I think will fire.

It's possible that we can't ever actually get to this code --
the usb_handle_packet() has a claim "hcd drivers cannot handle
async for isoc" and some assertions about that, which suggests
maybe that the intent is that we won't ever return USB_RET_ASYNC
for an iso TD. But if so, we should be asserting that.

> @@ -756,6 +757,7 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed)
>      } else {
>          ret = pkt->status;
>      }
> +    usb_packet_cleanup(pkt);
>      g_free(pkt);

This one's probably OK -- is it the one that fixes the repro
case in the bug report?

thanks
-- PMM

