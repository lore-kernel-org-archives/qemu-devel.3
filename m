Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67866CA0EC8
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 23:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjp2i-0003qo-NL; Thu, 29 Aug 2024 19:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjp2g-0003gJ-8g
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:59:06 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sjp2X-0005j0-PH
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:58:59 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-4fcf9102c8bso419582e0c.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 16:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724975936; x=1725580736; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+AQUvkE8egu+LZuwk+Fm8JzwF+4QrDgYAYgQ/xFZxk=;
 b=npWwibUOaCZcG9eyiWS6QW8kR3+oBGp4ZCZha34MTV0MlRS1hgWNORD0c23TckEsBk
 ITW9u9ytVhFUhLeBCzfN3aUule3MnoGmXgKyRxaV8rSU5Rz47AWjM4+1Qy7McB9qJ+Im
 Gke0RPNovQFb9ySl7Xed3UhnSS52aI5kfhpC62Rmaa5ME9qbDHKGr4Q6uRF1KOqENulD
 0PCc1wyPC4AidQS3Ieh5wEi0GnHHy1wMNoOYY2hN+yLXh2bzW/xSLOVLIPP1DPRjn27W
 W5R1qUUFkDgLwAv6qo16B3D3o0T4fuxyQrJwDZ7X7G22DcSRrPq8OC0EUsBBeFqg9fVm
 Asww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724975936; x=1725580736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+AQUvkE8egu+LZuwk+Fm8JzwF+4QrDgYAYgQ/xFZxk=;
 b=uat6uNyET+27p0hgACD4+bEI87t/VkgCYGK5B9PBsoU7/CsOSPR1EBiMRFfc3L3VYY
 vesBOPyigvDZgQiMj+9bfuMorJZw1nyt7wSZCpmuskQRZkoFmkYFODC6ZE5HjpOpiRye
 M2QoG7CXFdgOqCGsQNG37x5Ho/vMruUzfxH9kxy3WQHjUvN6g/cW02LqlPv7p2bAF60w
 otUaiE5yqq6bXjMIlOxqcR60NEeNUZoB8vSzW1Q2R7H06vxMxVedB54hNrVuuhFb1Bjo
 +LlPRmN3SR8qov/8ywVje8muOUD1SzRt5SacMtVFKWx03A3aZ0GICUiAytcJ477qGkAj
 0vWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn4qhH9fgyvCo/MltdKE3YpZlZDboX9dTCr5eXLYF3Kx3k8J3KiV+0NES6q9DKXmbb0KlulliJ2Zto@nongnu.org
X-Gm-Message-State: AOJu0YxqPv5caM052JPEys3lJT7I371farDnaquJpR/djlGFKAiOJ/bg
 axO4PzYrNYB0Dnrjn1groNhHb0CkDa5EBXmvOoaIzzp6GJH2mZ9KiMwO09DvU4VjAjBy8JoHCPX
 +IGBrWKLnOuTC9EJMSrir2DMQJME=
X-Google-Smtp-Source: AGHT+IHxbk/yp7puHOQjnVp7nDuZQIJQAiT8z7lQHk/MEDrVpsofoykcYBk2UsDO8l319QGfPGg22UCdIjo/fs54IU0=
X-Received: by 2002:a05:6122:3198:b0:4d3:3846:73bb with SMTP id
 71dfb90a1353d-4ffe4bb8f9dmr4964678e0c.7.1724975936541; Thu, 29 Aug 2024
 16:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-8-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240828122258.928947-8-mark.cave-ayland@ilande.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 30 Aug 2024 09:58:30 +1000
Message-ID: <CAKmqyKNJEQpPhmo_J0pSfwoNXXUN5ax=KXySbkdSfZD5QKv6Ug@mail.gmail.com>
Subject: Re: [PATCH 7/9] fifo8: add fifo8_peek_buf() function
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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
> This is a wrapper function around fifo8_peekpop_buf() that allows the cal=
ler to
> peek into FIFO, including handling the case where there is a wraparound o=
f the
> internal FIFO buffer.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/qemu/fifo8.h | 14 ++++++++++++++
>  util/fifo8.c         |  5 +++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
> index d1d06754d8..d09984b146 100644
> --- a/include/qemu/fifo8.h
> +++ b/include/qemu/fifo8.h
> @@ -76,6 +76,20 @@ uint8_t fifo8_pop(Fifo8 *fifo);
>   */
>  uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen);
>
> +/**
> + * fifo8_peek_buf:
> + * @fifo: FIFO to read from
> + * @dest: the buffer to write the data into (can be NULL)
> + * @destlen: size of @dest and maximum number of bytes to peek
> + *
> + * Peek a number of elements from the FIFO up to a maximum of @destlen.
> + * The peeked data is copied into the @dest buffer.
> + * Care is taken when the data wraps around in the ring buffer.
> + *
> + * Returns: number of bytes peeked.
> + */
> +uint32_t fifo8_peek_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen);
> +
>  /**
>   * fifo8_pop_bufptr:
>   * @fifo: FIFO to pop from
> diff --git a/util/fifo8.c b/util/fifo8.c
> index 1031ffbe7e..a8f5cea158 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -140,6 +140,11 @@ uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, u=
int32_t destlen)
>      return fifo8_peekpop_buf(fifo, dest, destlen, true);
>  }
>
> +uint32_t fifo8_peek_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
> +{
> +    return fifo8_peekpop_buf(fifo, dest, destlen, false);
> +}
> +
>  void fifo8_drop(Fifo8 *fifo, uint32_t len)
>  {
>      len -=3D fifo8_pop_buf(fifo, NULL, len);
> --
> 2.39.2
>
>

