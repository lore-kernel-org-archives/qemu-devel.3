Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79F7EDEC08
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 05:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxeZY-0001Xa-Mq; Wed, 04 Mar 2026 00:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxeZT-0001Wf-9M
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 00:14:56 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vxeZR-0002nr-Rx
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 00:14:54 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-65fa4713bd3so10954507a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 21:14:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772601292; cv=none;
 d=google.com; s=arc-20240605;
 b=E6X5Zmv7y7Cw7VuxWbENyL3KKKsY2k/lBdo572OxLo9VqIJk8NMsJJYD+bG666rAx3
 w24WOxTbJ/krN8a1mLo6lSZSE7Im1bHimlxFV8Mtq12acS0DQ0+Y0zDIaVxhUa7zH2jv
 EUgRrUezFIMt9hv3yhb6zLT5+8eXD+ma4AielScOfh5nl8z8m6yChRQUxgNHdqrxzA04
 n/ElUV60bpQp/QsAFD7wA4eE4zGGfbYCTXiVYA1cGSvstcYysXyT6C3mQnxi4+dXq+Vc
 gjnj4y0gL+yv6yrBrNyC3t9AAG3+GyDor6nCRRQa8JU/FiyTdLEgCkhGmsfLG0A+Bj5U
 +Dmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+JUWNpVdNqOp67nGa//HsTPRtBg327INM+szNovyugU=;
 fh=SQmLttdHIQuq3A+Mii99oLuEUoDRwjQE4gGZH2ySfCI=;
 b=ehLwppfLRXUhhfBoQ4AejlXYii+oDk12w7wZpqIh52QNDs6m3qfBJpK0XuHlk99lUo
 UAn4gfXj7iIQfJIOieSABz1h10GQ2Qu2O0/4wRho/SeLDs0RNPV/8yOHW3RRsednOr17
 7bmT5Frrzm1fqrczfCbkEolO9fvbjE2FvSzSG0mbJOwAGIGPal641/nhzYblC9P6Mdiv
 U4VuIttE6x2KL+J+VISDXGRFwcISb/T/ssCxokaVydf3ilAWT4Eo0zx/ntCjy3Mm6KPR
 GcokrITqcrgzFkuAWoWLub9IWYwtqC42LZgokCvLKqaaBRuSigjxOCMx0bqHmRGm5RYQ
 QZYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772601292; x=1773206092; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+JUWNpVdNqOp67nGa//HsTPRtBg327INM+szNovyugU=;
 b=MKU+tIEHn8NUoc9Rlbxzfu9/K4M2iNq1MSa/kD4xP9zvvlsnuRGaqkzxzFmGl8XUZU
 i3XGRjGPDU7Ec+4cszE5o629xw5DZrqtmF06IF9x7l+i2caVGhugSQ95QyTvSAf70bnu
 qgDWIk9HGV5yLPVnOTLnlgQAvXCjy+tWWZg6AL6Y+pLPJusIseVLyUHMSdrLR5ttinIH
 B77wcfXNBI//2NQT7CCZbUQwZP7nHCrjaENYkw9pYP4ZklpdgloXT1TJ+sYK70QFTk/0
 4mvhSfk7oACpeezpV/8aI7LVOY3rwT4AdDrbeVr4ppfeAHfkGcp0rWO5swcNlEkBEjbC
 aU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772601292; x=1773206092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+JUWNpVdNqOp67nGa//HsTPRtBg327INM+szNovyugU=;
 b=WjChP3pBm/R0lnca+BtR4rPT8VNOQnT777CHukzlWt6R+d8HBIH5vktWq1woXO/sMo
 jjFYcR28Qxyy57yh0UQdZca7eeQ+CeBOqej+4Kmml/mzKhSDVn/EV69rErGnSn+FQofw
 EBC9w0enAKymIarlqrBReMIu6TDS7NI4h8K1DPRqI+ad8mkP0+3wjAlOSlkRXJhUwTel
 S+0z+Mh2yWciwylsXuL1rVgj9vimHpJE5skdXzJuwLNN+hHKnF4GBe+17u9CaymZTcRe
 G1LRA1dfTgRwKd1HDisset7QMhlTFQTSCDtDtGdo9ZeQSk4aC0fcn3hoX9qf7GLc31XE
 Q0Mw==
X-Gm-Message-State: AOJu0YzCUXm4VVHyYa5+EJrACosJiM2MdO8CX7pt+pj3a7O4eQKZa59X
 MrCuL3dAR+kN+UnL9C5jTI2UjdKixQ/UfXyp8ptm/L9ETtbfR/tMTYcihd80COsBEMZE2d0VoF7
 IEqkkuW7CazJ97jzTQ/cgjbAOffEyAto=
X-Gm-Gg: ATEYQzxU7NI2vZJoeiftdtl8/Y0qiNDbymvBY54pWrN72b0BQs5O4VjVgDoQON7BA2I
 AIhLdd8+nXWSHnvDmMQdMqIZJ8mhRXRIcyPJ+v0RpjvPXSLbYN1G7aEfDFjF6dU8SF5KSkwn9oK
 Yiy2vtE9P/eArK0drgCoULbw+xHZ7rPaWqZnd3mWwRH4jK43PvOZ/5AwcZ8QLML01bA5FaA5FUw
 +LfGB8dPr/d5oEmz1OO48kz97kqiDjAUfPxNAEYz5dyLjIso+fF2Xfk0orVHDhGURglCq97quZm
 9zNXiSmfGxoie9Ig34eqRXYQc7YrznaZ6geGKQ==
X-Received: by 2002:a05:6402:510d:b0:65f:aecc:4f1e with SMTP id
 4fb4d7f45d1cf-660f00d728dmr337561a12.29.1772601291976; Tue, 03 Mar 2026
 21:14:51 -0800 (PST)
MIME-Version: 1.0
References: <20260304030816.33209-1-jay.chang@sifive.com>
In-Reply-To: <20260304030816.33209-1-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Mar 2026 15:14:25 +1000
X-Gm-Features: AaiRm53SxYpXu8Ol9-ViN78FudQ7-of_Yq7N-0C6_iSAb4WRmORgANIiriog4vk
Message-ID: <CAKmqyKPSGOtmCun=xBt8W+tOjqjXTyn5XS=BNbx8WemudSbDJQ@mail.gmail.com>
Subject: Re: [PATCH] hw/dma: sifive_pdma: Set done bit upon completion
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Mar 4, 2026 at 1:09=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wro=
te:
>
> Ensure that the 'done' bit is set upon transfer completion, even if
> an error occurs, since all transfers are considered completed regardless
> of success or failure.
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/dma/sifive_pdma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/dma/sifive_pdma.c b/hw/dma/sifive_pdma.c
> index 6d06ec0375..7b22e51492 100644
> --- a/hw/dma/sifive_pdma.c
> +++ b/hw/dma/sifive_pdma.c
> @@ -153,6 +153,7 @@ done:
>  error:
>      s->chan[ch].state =3D DMA_CHAN_STATE_ERROR;
>      s->chan[ch].control |=3D CONTROL_ERR;
> +    s->chan[ch].control |=3D CONTROL_DONE;
>  }
>
>  static inline void sifive_pdma_update_irq(SiFivePDMAState *s, int ch)
> --
> 2.48.1
>
>

