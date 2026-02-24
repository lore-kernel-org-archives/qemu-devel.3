Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1EEEFB7ED
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 02:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuiTs-0008HS-Mz; Mon, 23 Feb 2026 21:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vuiTr-0008HG-6R
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 21:48:59 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vuiTp-0005yC-Nd
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 21:48:58 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-65bfc858561so9618374a12.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 18:48:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771901336; cv=none;
 d=google.com; s=arc-20240605;
 b=U09PvOfa7Myqt6zmv/oCxgmlraDAlyy+bhESOZKEJSvJcKFDj0qYgMhiVYQSBr/8TX
 mu+4+VPJfSv2cyMdTC8uHYR0p7UrmniU67JvujUts30cPNo8dXkZ3/Cr3/0fcd7E5BdT
 12ZxnjKDagCR8iLnpZdASuzxVIUqwNIGDlgmjOYJ+DIA3TX17SSvSMkfxJIDxLRRQn5F
 dCqmLZfnEZ8+31PO82DnIa4aKR1skl30OpWgQi/E9nKKcUT/UZHL+Lf6CKowvrWLsqWP
 OqKeDQCOhJziF1XUn4l/4cI2GIsxi4hadizV8YaokzdxlldRkEWD7yQGu/UiamBDorOe
 yGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2Chk4MWAK7MVTWJvjeFqxOqAI5QUuDw3LsU66r1uBNk=;
 fh=x18+ItHhoMt1uQi9qFsD2UgJewF1CZzzz8hcug2Jd4g=;
 b=U3quY2h0i+hPlpRgl9JC0DnYEKvQM9as1ckBInyzzOznZ1BxI674SikKKjluuwTVZ3
 DKcQ5PZ3Nx0TjhTfHNG0qPHf8KQPln8GZNgDnl5QvaWwgFEBvHaRxN3fxtUbwoZ6qnn6
 sduI6o9S/r2tjunWd+cm3p1uEMoV78dby8eb6X6q/DcAY9EE07BJ28tf0KW+/iCLK6oY
 wSpa41GfihkefvA//rclmsP+meyfc5f1XMq8pCPuwX7vS6FuOprrfv2Ms2/Qrz0pUTBX
 z8GzoFmbA5bGs+lxnDF8rBda4iO/yclvk92YvenVlrSAKWP/RPypkC8QBsLW+tqEV6dc
 X/qQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771901336; x=1772506136; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Chk4MWAK7MVTWJvjeFqxOqAI5QUuDw3LsU66r1uBNk=;
 b=Yfke6qAQtQPtigt4nGt10W7chVTKWM0KWLA7eQKVhAoyMk4eJhvBm4zXqZ5HespSer
 AQ1qZ8oGSemUlvWpRQ9SvroDXjfn7g4b6N2l37EKUDy0pVNGMrsO+HQUNxYWr3KMXi38
 IQauymlOWl7oFHStLlioByzkr9CdNciGnTvpXEytnMgvfpmlQn/zQJiFABu40Br2RVh8
 3SxIzUoMXRyX9w82IMA01ySWLkATD7bRlRx/K7272Cfuif/dO0i+ThGqC/b21i8Ai5wk
 hQlI3P0A13ZpBE0xHviJ1XsDjJYwAzrw49aeAyc62pteKXwOYrbs+YsnJym/Z+Ss/S+w
 xLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771901336; x=1772506136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2Chk4MWAK7MVTWJvjeFqxOqAI5QUuDw3LsU66r1uBNk=;
 b=VpsKzAFcOf8gAUUd2M9H1RNNSQ3OGJ8qFWYqORaggjWjRKIQimvvIzQEH+Y8T0PzrW
 ieS/XRFD/+UfZpT73iWWRtRWNBvm6wriS+ib4Ra1VF6qLQD4JkooA2RcWa035iiYqsg4
 3rjQYGCr8LbtsUWwfWfYK5YpOwBw2BV7Fn1imbtNI5tvSA9L1xZJxLN2c1ry1q9F0QZE
 6g+EjZaTznp/paoGJ+e2bEOIqE30IhiIJe/H7zzMnIvAK82IVlY34W1cuvvazpfCl1+w
 BROHOWlDnu9MJNEbNJ8ACpoXXRDePkIWI4VoID7s87y8KiUAmaFuUMQCV8Xx0/NV6adQ
 ChVA==
X-Gm-Message-State: AOJu0Yz0feW3LOy5nV4YNKcFIQhvTw1Yu/OJ7Y1875X59mao5kAZcJ7H
 OUgKTFmeOZRA/Zu8oEi3CpBOx/v8T2dGyZLTXeAKNGOY4VbV5vl2PaDMauNmg0IXK6RLTRMX/6n
 S91yNx1qpw0OZxvIgeMJTb+FEHUkF2mQ=
X-Gm-Gg: ATEYQzwyKEIGt9n+U+nz1ZDIBV2+LhwCKfrB6kBjX+dBTFpfJXKSzG77GYJgrpCIbhc
 rA1VaLsaWgF5WcMsiPoIke1Qs0a/F+x953gdsPOXhquGSYNlOQGtJfEAu4+Z7QATiBbqCjL0lvP
 SAdfMfzDOJ0CoZc3LLwlsDR15DRKk3zPGX3UGXkXchiKqVKlXmhiK8B02ZGc8QIYJLTVpmKeg6G
 rVCUO/eNc3RjgMJW5xLuef4RPx2EwjCSu/kLouIydVFIIeBY+AJ2V1FywVluilk5XzOxp7LZEv7
 J7tW/+EGMYK5qnLk/zbLgtRdKNOZbpJ7i+g8S7b9Aa7JP6wq
X-Received: by 2002:a05:6402:5255:b0:65c:9d6:82b7 with SMTP id
 4fb4d7f45d1cf-65ea4ee2ad9mr6197911a12.10.1771901335568; Mon, 23 Feb 2026
 18:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20260223095905.67709-1-cuiweixie@gmail.com>
In-Reply-To: <20260223095905.67709-1-cuiweixie@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 24 Feb 2026 12:48:28 +1000
X-Gm-Features: AaiRm53JsPApWIZaXA8VLK58nt5ZH6wZ9ntFtjDB54UdDFZvPXDg1DpFXNicB_w
Message-ID: <CAKmqyKMo9cg6-=wFXPT+61wEFf80Sd6eZyyCG5TDBrAuNJBaRQ@mail.gmail.com>
Subject: Re: [PATCH] hw: copy paste bug
To: Weixie Cui <cuiweixie@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
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

On Mon, Feb 23, 2026 at 11:39=E2=80=AFPM Weixie Cui <cuiweixie@gmail.com> w=
rote:
>
> Signed-off-by: Weixie Cui <cuiweixie@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/ssi/xilinx_spips.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index a4718fb72d..f6e717bc01 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -369,7 +369,7 @@ static void xilinx_spips_reset(DeviceState *d)
>      memset(s->regs, 0, sizeof(s->regs));
>
>      fifo8_reset(&s->rx_fifo);
> -    fifo8_reset(&s->rx_fifo);
> +    fifo8_reset(&s->tx_fifo);
>      /* non zero resets */
>      s->regs[R_CONFIG] |=3D MODEFAIL_GEN_EN;
>      s->regs[R_SLAVE_IDLE_COUNT] =3D 0xFF;
> @@ -397,7 +397,7 @@ static void xlnx_zynqmp_qspips_reset(DeviceState *d)
>      memset(s->regs, 0, sizeof(s->regs));
>
>      fifo8_reset(&s->rx_fifo_g);
> -    fifo8_reset(&s->rx_fifo_g);
> +    fifo8_reset(&s->tx_fifo_g);
>      fifo32_reset(&s->fifo_g);
>      s->regs[R_INTR_STATUS] =3D R_INTR_STATUS_RESET;
>      s->regs[R_GPIO] =3D 1;
> --
> 2.39.5 (Apple Git-154)
>
>

