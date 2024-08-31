Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50E4CA100A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2024 00:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skBkW-0006Az-Rm; Fri, 30 Aug 2024 20:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1skBkV-0006AS-Gc
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 20:13:51 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1skBkT-0006kL-SW
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 20:13:51 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c2443b2581so2479a12.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 17:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725063228; x=1725668028; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nha1kAvK1+KgJ/RbMmJ7NXRUgTLy0CUhnayg7xzROYI=;
 b=pmrMLNo2SKTde/gCotZz/7mm6WgtEREtkXDNZuy4OGcLVB5HAYHHo4IusEaz05/WpL
 pTM+X2VEMhw1EUIltWLgM9tC5oTFN7K6k0fKA/yPUeNm7xA9fuxe/SPwMn94H3Fs3yKx
 cGBJxPplJtjDUl4ZWS20Lc5GtHyabX2c6GEnE6zLAfAh9axKKwmfc3gNsUdIhGiEsNaS
 +mvybYTPbhE3u9DgWR45K8ooeVHG9l8QBwt3me0rSQu7TMVpdEgbx7sFQeJv0h/xz1oP
 G3dNCD5VM0DVlAAFy+et9gFR9vplmRiDVlXozFeB3e95Xh/SSJgVpkAQ8RqKY5y1YtEo
 LlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725063228; x=1725668028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nha1kAvK1+KgJ/RbMmJ7NXRUgTLy0CUhnayg7xzROYI=;
 b=RoQAoYeOamK0/AknZRffDxQXe8IFklkFEK+1EycJSC88G3sEwfDN4e744iXstKZBY9
 mDVgdPzrKnxKyvPnXjEP1bceDm4TfvoDs8Jjlf2NB72eBYAUrZyifXMOqIaVZECfbOvR
 an7UtJ/uRuz9KAvNQc/Yq/hS9/RyZmkfGBDrDc+40jKmPGr73eglqqPrQNUl8RDJzhvL
 SiZSJFlrGuxGjiT6UQtlWON63jNeFAjVHbextSBEuz0TzOGIhR4rvW5/quGqz9cLdABh
 /QcdgIuu43qAT8ac/U0zKGOpgabIIJyNlY8V/peaggeRKNOaYA3v3irpnDu0TzmXtw9V
 MyKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgLaYnxBNIq3Rz++rnp/b9HjWxg+4SCE2+mgCvnxOxU/gXqsyc2Hrd3Nb9uuJdy4VTc9V2tG3IFiOD@nongnu.org
X-Gm-Message-State: AOJu0Yw/9nVKhO5zauEunjlMtaePJSnIGKm3H17COPIYW3Q2HTF0Xjig
 td6MEjC4vlNIK9kbJzoiyAAgTmGvARi+UOa3nYJ6/jXuv5iRKnU121iZ7M+xhAaqDN487Pg6gzK
 i80EBeEiU6dHYtc6uGZs4MOz4rH1G88knnzvBHBU7MmxhYLVXj2Kc
X-Google-Smtp-Source: AGHT+IFDxesWyy1oUqevp296pnvN9VcECAhxtQMAOaI88e69SKs60Gt143HqIYu7tAsHRZJClzu4AhI5vLFPokFHnzw=
X-Received: by 2002:a05:6402:430f:b0:5c0:aad5:43db with SMTP id
 4fb4d7f45d1cf-5c245b2fa02mr32774a12.4.1725063227956; Fri, 30 Aug 2024
 17:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240828122258.928947-4-mark.cave-ayland@ilande.co.uk>
From: Octavian Purdila <tavip@google.com>
Date: Fri, 30 Aug 2024 17:13:37 -0700
Message-ID: <CAGWr4cTGPP3XtdGes8VCoUzHQ3pYiPOo-ixrL3hfic4z9_mCjw@mail.gmail.com>
Subject: Re: [PATCH 3/9] fifo8: add skip parameter to fifo8_peekpop_bufptr()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: philmd@linaro.org, Alistair.Francis@wdc.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=tavip@google.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Wed, Aug 28, 2024 at 5:23=E2=80=AFAM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> The skip parameter specifies the number of bytes to be skipped from the c=
urrent
> FIFO head before the peek or pop operation.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Octavian Purdila <tavip@google.com>

> ---
>  util/fifo8.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/util/fifo8.c b/util/fifo8.c
> index 5faa814a6e..62d6430b05 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -72,18 +72,20 @@ uint8_t fifo8_pop(Fifo8 *fifo)
>  }
>
>  static const uint8_t *fifo8_peekpop_bufptr(Fifo8 *fifo, uint32_t max,
> -                                           uint32_t *numptr, bool do_pop=
)
> +                                           uint32_t skip, uint32_t *nump=
tr,
> +                                           bool do_pop)
>  {
>      uint8_t *ret;
>      uint32_t num, head;
>
>      assert(max > 0 && max <=3D fifo->num);
> -    head =3D fifo->head;
> +    assert(skip <=3D fifo->num);
> +    head =3D (fifo->head + skip) % fifo->capacity;
>      num =3D MIN(fifo->capacity - head, max);
>      ret =3D &fifo->data[head];
>
>      if (do_pop) {
> -        fifo->head +=3D num;
> +        fifo->head =3D head + num;
>          fifo->head %=3D fifo->capacity;
>          fifo->num -=3D num;
>      }
> @@ -95,12 +97,12 @@ static const uint8_t *fifo8_peekpop_bufptr(Fifo8 *fif=
o, uint32_t max,
>
>  const uint8_t *fifo8_peek_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *nu=
mptr)
>  {
> -    return fifo8_peekpop_bufptr(fifo, max, numptr, false);
> +    return fifo8_peekpop_bufptr(fifo, max, 0, numptr, false);
>  }
>
>  const uint8_t *fifo8_pop_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *num=
ptr)
>  {
> -    return fifo8_peekpop_bufptr(fifo, max, numptr, true);
> +    return fifo8_peekpop_bufptr(fifo, max, 0, numptr, true);
>  }
>
>  uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
> --
> 2.39.2
>

