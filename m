Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233B1CA0EC8
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 23:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjozT-00077U-A3; Thu, 29 Aug 2024 19:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjozS-00072w-3O
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:55:46 -0400
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjozQ-0005cZ-Ie
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:55:45 -0400
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4fcf60f4653so378473e0c.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 16:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724975743; x=1725580543; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cR1CBBBGpYQz18u0CvU9iffNAyt7Scq/ss3kmSOlKyM=;
 b=gwSNqLvBy/dj3HJiXYQH8WtCwBe1LMWZGJ2J7ZFSKNXVdrM7Z1Ujwt7fVfJblT0WG7
 XGpILriBUzYsVIUpEgG1xU7zbWmy8YSTn9+UlbWjm2AlWOc2s1PxnyChbjwnLcmtRdHn
 pR/xEB5MF+aRatpx2WjP/tDg7veIhLlz8fDcqWdGptGoMMySfhfJvEuEvHeFCHOAB273
 lvl7QgWK01jo9D0rn4Q5XNqWoSIIW26trYXij6HYd3n+1Qai+Dh/eAfGA3Oy7lR+BzTi
 pzbxp+Jqk4SUpHIOjRm0FtDLtse1G5zv2btWuF7LiJ0HTw1uDaPNk0/NrSWNHpzmuODY
 rqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724975743; x=1725580543;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cR1CBBBGpYQz18u0CvU9iffNAyt7Scq/ss3kmSOlKyM=;
 b=VyMSgZ+FhJd6ENQHpwMpoeehSaBu1hkGOBtPnopiM5XEmBe+g5Pz6PZgFqulVu2NT0
 A3tZ7gR+arYyXEb21auXed/SQCqJN3V52YyMFWFNZWRy3lO5Aevcg1P08XRB9y0cBd+3
 Ual1hoJ9lbWspJ3mJ7ENHfjuhk4SU3X4W5xDqjq9IEczdWN5Gm5IaII2DWAth8hT/aNF
 5PjYwlkgYIMyyzxRsOVX7C09NdpP7WFTnYslAakM0z7jOoomiEfpZH/WXdgAthRFCbQz
 C42rS+GgOT0SEpdzYa8Uu1YUZYcAbzngvbYG05sScFe2119x3ftJRSqB31bqXGiqqRPo
 wqYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOHwunmWY4NFdjgDqZxIufT1Ph1XfMJ/LFoO3MBUZ7srxn/INeCNdX/70EBPL4fGEc++BtLenHoooM@nongnu.org
X-Gm-Message-State: AOJu0YwKADyCZOKyv1+23toJXkJ3/UGkxpnVZ5VsoSw9DybYoNIfwMmB
 D4CAweE1Sosh4WRF+gYUGgEzPtq3tYSnfLM/iPBFeS7A/OOkYqLHk/J4LzHzNfYS5CTAwegKptL
 pAmCn+ZxhXQSiy7dpqq9ujJh2w30=
X-Google-Smtp-Source: AGHT+IFuFjhBzbLg0b4fyTK5JOItI7vGNpfXxSb5ir97GSLcYX565iUURyKKyBLQGzSBHbSlrNK4EyceB+5XTzM6TXc=
X-Received: by 2002:a05:6122:220f:b0:4ef:280f:96ea with SMTP id
 71dfb90a1353d-4ffe4a825f0mr4628567e0c.4.1724975743490; Thu, 29 Aug 2024
 16:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-6-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240828122258.928947-6-mark.cave-ayland@ilande.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 30 Aug 2024 09:55:17 +1000
Message-ID: <CAKmqyKOyeFzDTQ0dbBABOrPH=70u7vHNabD_NWHjZLbPrSmkcA@mail.gmail.com>
Subject: Re: [PATCH 5/9] fifo8: rename fifo8_pop_buf() to fifo8_peekpop_buf()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Aug 28, 2024 at 10:25=E2=80=AFPM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> The fifo8_pop_buf() function will soon also be used for peek operations, =
so rename
> the function accordingly. Create a new fifo8_pop_buf() wrapper function t=
hat can
> be used by existing callers.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  util/fifo8.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/util/fifo8.c b/util/fifo8.c
> index efe0117b1f..5453cbc1b0 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -105,7 +105,8 @@ const uint8_t *fifo8_pop_bufptr(Fifo8 *fifo, uint32_t=
 max, uint32_t *numptr)
>      return fifo8_peekpop_bufptr(fifo, max, 0, numptr, true);
>  }
>
> -uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
> +static uint32_t fifo8_peekpop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t d=
estlen,
> +                                  bool do_pop)
>  {
>      const uint8_t *buf;
>      uint32_t n1, n2 =3D 0;
> @@ -134,6 +135,11 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, u=
int32_t destlen)
>      return n1 + n2;
>  }
>
> +uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
> +{
> +    return fifo8_peekpop_buf(fifo, dest, destlen, true);
> +}
> +
>  void fifo8_drop(Fifo8 *fifo, uint32_t len)
>  {
>      len -=3D fifo8_pop_buf(fifo, NULL, len);
> --
> 2.39.2
>
>

