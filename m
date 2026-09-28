Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB70CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 18:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBG0Q-0008Rh-2l; Mon, 28 Sep 2026 14:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBG0H-0008Qs-Bq
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 14:23:06 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBG0F-00058w-Gh
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 14:23:05 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e56a1b327so2738769d50.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 11:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790619782; cv=none;
 d=google.com; s=arc-20260327;
 b=ej6tuxFcubAYw91qLPAi5DwMnMV/lRBZoxd+v3OBQ87fwQzjNd0O0xJKPnzSrEhA8m
 n52HR+Zo02VUlO8QYyt39Ob0wNPR+rcQh/7ZljZ8kdpoOtQpniUWNkvK7KRuwXjzPMhz
 iQTzYqt5CvNJhEmP3Ik8s3c9LLQunMoesb/hy/dX29GGppvWeAvYDSsnQ7FZolEH7zf+
 uYcWteMDg4WgBKh1F02h1TssAeacwnvfbyv+KhWmgzJlAqDnkmmn6o7u2GW3XdO0Qsyt
 k8GJrrXKz78TUC9wOH5TBycT5jOTTPAbMpw65/wIkhRROJGy6/bNT5XVUJHvWm7JYchU
 qpSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=T2iNR5FQsp70JtKxZOrNk2y83HYHAPVGZSVmLsoewpA=;
 fh=1aI44e0p5XplGskc+UeFLoNCjn/8ANQtrjF8ujCp7vc=;
 b=DnKX+Y7K57hjfK/nrSh5gHbeXuh9yCX+Pq282FKgeMjZdllGXpZZej3ItNZ/1NDPVb
 WoM97WJPc8YYjQXKSJZbU3yIuie0CnjCJacPJv5n5ATvuBdISApDdLbDx9lBMQCanYFw
 ZZJkiHHWhAd31HibV6XPu9f/gtCMLgwt5pYUOxTAr9EKMN6h1wKoiEcrY6QsKkVkPYfP
 oQTf1x3dj2NKJx3VtxUtBfLkfQ7KsJrtfain9fdI8u/Hq6M4vFhwzYa8Dy2HjR5ii1xh
 iFBZlaf4V3Tb8adn07oByB7ZbdRjY24MgLgUyMpzjvIe6ND3Mb4E+Xxunn7VNEl4lCOV
 hDdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790619782; x=1791224582; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=T2iNR5FQsp70JtKxZOrNk2y83HYHAPVGZSVmLsoewpA=;
 b=babxks+PJ6lZlWqare5YMm+m3PUSIuZXWa3/9Y37Te6F/7jwRu5sofbCaH1+mxytX9
 +3mSQtSGmQ6ER5V79vpGXskUr51N7qPszZcLtWWsTiWsyMU1xTw44CgAepCGvvi+unFb
 ok+ct2CQadSIg5SSlFNALcEFm4I/bUqqXNzTEPuLtMWQEulamMl2xoDx+RlsgcAEZh6L
 M8wWOTHSYRakSuVKzj+v1MVXWdEyMAmdMqobPhQMHd++JvbO7beZ33/muQZdJGIQYhxk
 RF+OWe0ga6uZSG3Si8ohXx78LWCh/XNKy/YAv6rNP2taTLyJOL9F7x/QJy2y/iDgsutp
 KJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790619782; x=1791224582;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T2iNR5FQsp70JtKxZOrNk2y83HYHAPVGZSVmLsoewpA=;
 b=yuQgRru9EiZe0l+VwoLljoZgIr4izxMQ15aR4mEbRDyNmxE6DylTJ1vLpNqH7L2A0e
 2venxRNL9PnXPt56hnzqnKvAnexwIV8dSF/Zt/B6smzDR3mgfin3+Dl45s726eQPZrHP
 nd6HRr86qLOtsOM/6crxN8V1xCAbr7TDpVJYYzKegogcnpOFzD/RrYOtBUDPLSoCtxUx
 v2+/PXHV2zGGHcM4w7TqwHREBN8HGKQIt9CjN99szCqwua2kVScibNzDH4yXbIudn/9t
 HdAUhzFmLHqSF/NYU/qrYyT8VcB9KmSLzNnUm0iL4+Lik1X341K+9nBD8fvrhYk0ro1N
 D2fw==
X-Gm-Message-State: AFq9FYKVMpsjS46BYJZc/CDmjDLVlETFzN/MaALvYhC81/5syl025xyc
 hgVyRfsg2YKYY5tTad1AMTZMldqTNu8rqfuYFoHN8kJrm9YO4S4RXicQnKeTkfAln3sGNOeApVq
 1pXBzYhxd6i5PdDOQosAmP1DKRExzCj0xVxbLq0ShaQ==
X-Gm-Gg: AYBFou2LUObYSBaGo/n66KOB2A4tt3yG+UBtnx2CaRx80dhQZReRIxg0P7VYravakpp
 TmMLm5bLLRD7u2cI+JhsGAkI6NphhoD8sUMM23LnnGRfjwDfJPxwWxWfv+dtxkKlujUMh5K+EwU
 xgieHGjws639DrODYmCKy3KT5NG4sBGqlnJkFJPefxZVD2V7g89nUuAn1Cb16ycT0YFcDXrxONp
 iFrunvRJG45sAHLBGGbKT9Q/b1QXDAqOZ8eZrNWWr8iZtMg8egXwQJKgLeLT9dfSQ1p2vV48nbH
 w5vnVtKki4WXb7lVoUCdTeyLfcZGI1rX8A91NMkSKWujxy4fQNcDMrz7uePVFYl5A9Dq2F24GUl
 nuj7wjnIQxoq93t66g+Kod+ArEeetJuFqzQCS/F8=
X-Received: by 2002:a05:690e:1697:b0:671:7e90:70f4 with SMTP id
 956f58d0204a3-672ed2263f0mr7677894d50.10.1790619781443; Mon, 28 Sep 2026
 11:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260921214710.29422-1-shentey@gmail.com>
 <20260921214710.29422-2-shentey@gmail.com>
In-Reply-To: <20260921214710.29422-2-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 19:22:49 +0100
X-Gm-Features: AclHuK9ptH5nI8v-P9ELzPhwoodstuoK8rQto_4bAwC2L9-Wz5OjI2fcKU_CqCw
Message-ID: <CAFEAcA_xVcfC9UrxM4jjW8HOGoq96iuOABdbVB9Ftfxjq2zMAg@mail.gmail.com>
Subject: Re: [PATCH 01/42] hw/watchdog/wdt_imx2: Fix handling of write-once
 WCR bits
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>, 
 Alistair Francis <alistair@alistair23.me>, Alexander Graf <agraf@csgraf.de>, 
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 21 Sept 2026 at 22:47, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Guests such as u-boot may experience inadvertant reboots when configuring
> the WCR register. Apparently there is a typo in the WCR locked bits
> handling: The locked values for s->wcr must come from itself rather than
> from s->wicr. While at it remove the redundant locked attributes for the
> bits which stick to one once written with one.

"while at it" is one of those phrases that tends to suggest
this should be more than one commit. It's doing a lot more
than fixing the bug where we use wicr when we should have used wcr.

> Note that removing the locked attributes required a migration break. Defer
> that to a subsequent patch to help backporting.
>
> Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog
> support")
> cc: qemu-stable
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/watchdog/wdt_imx2.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
>
> diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
> index c83d4107c1..aaf4695db2 100644
> --- a/hw/watchdog/wdt_imx2.c
> +++ b/hw/watchdog/wdt_imx2.c
> @@ -59,9 +59,8 @@ static void imx2_wdt_reset(DeviceState *dev)
>
>      s->wicr_locked = false;
>      s->wcr_locked = false;
> -    s->wcr_wde_locked = false;
>
> -    s->wcr = IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS;
> +    s->wcr = IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS | (s->wcr & IMX2_WDT_WCR_WDT);

This doesn't look right. Reset should be "cold start power on", so
the reset value of WCR shouldn't depend on what s->wcr happens
to contain now. It's also not mentioned in the commit message.

>      s->wsr = 0;
>      s->wrsr &= ~(IMX2_WDT_WRSR_TOUT | IMX2_WDT_WRSR_SFTW);
>      s->wicr = IMX2_WDT_WICR_WICT_DEF;
> @@ -156,23 +155,11 @@ static void imx2_wdt_write(void *opaque, hwaddr addr,
>      case IMX2_WDT_WCR:
>          if (s->wcr_locked) {
>              value &= ~IMX2_WDT_WCR_LOCK_MASK;
> -            value |= (s->wicr & IMX2_WDT_WCR_LOCK_MASK);
> +            value |= (s->wcr & IMX2_WDT_WCR_LOCK_MASK);
>          }
>          s->wcr_locked = true;
> -        if (s->wcr_wde_locked) {
> -            value &= ~IMX2_WDT_WCR_WDE;
> -            value |= (s->wicr & ~IMX2_WDT_WCR_WDE);
> -        } else if (value & IMX2_WDT_WCR_WDE) {
> -            s->wcr_wde_locked = true;
> -        }
> -        if (s->wcr_wdt_locked) {
> -            value &= ~IMX2_WDT_WCR_WDT;
> -            value |= (s->wicr & ~IMX2_WDT_WCR_WDT);
> -        } else if (value & IMX2_WDT_WCR_WDT) {
> -            s->wcr_wdt_locked = true;
> -        }
>
> -        s->wcr = value;
> +        s->wcr = value | (s->wcr & (IMX2_WDT_WCR_WDT | IMX2_WDT_WCR_WDE));

This looks correct, but I think it would be helpful to have a
comment that notes that WDZST, WDBG and WDW are "write-once only"
whereas WDT and WDE are "write one once only". The difference is
a bit subtle otherwise.

thanks
-- PMM

