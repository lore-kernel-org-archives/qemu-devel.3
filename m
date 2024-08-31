Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFA1CA101B
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2024 00:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skCBI-0004H0-Tt; Fri, 30 Aug 2024 20:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1skCBC-0004GR-Qq
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 20:41:27 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1skCBB-000105-2l
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 20:41:26 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c2443b2581so2579a12.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 17:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1725064883; x=1725669683; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GedHJZZzFLfB1zG6eaBg6ODQ1zPF5kQ4SXzd4PaoPJo=;
 b=t8qpXdkb/KTR3PohNbP0sHMEKO1Uof2HvV5sBkHE4gNou35BALeAZEyz/mkK+GH8Cy
 YR3Lgvzi4W4JmETAcNLhCH0BwRmawK9LITuTb2t3pwtsC32+4m19kp6FsIoSIr9F4s5Y
 Mplg3SIkjuxiShCHU2KuPvqOOPdbcaTZryZ6nEsZ7cRO71cZwgGYAusxc9FHY5OZ/U7s
 g/7gbWANKcF2SR/KAd97oAessNYdzmHNNnvZMDHs62nWwrqm0dM8z3sQkdT1OJ09GBjY
 Rz5LNtZJ5BAaBs5OqVmK3Bu81QFjGgbYwpJQEpCuJg3I+XYmLtnIW03pJG6f/vL2GZVD
 fGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725064883; x=1725669683;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GedHJZZzFLfB1zG6eaBg6ODQ1zPF5kQ4SXzd4PaoPJo=;
 b=UO10BsatW3J7mcyq/FHw5bLaxkUFvD3+YvTB7lxZ3r3n5m3K6mqOGYA9hmyqSO/CFe
 jxsr0qc42HcmlL4nT9Ai6pH1jHbAlBr1nZNjoLcXlg7LxE51z6QAiqA+i1IOx0wYv5pX
 vc2hRGn2/aVa3BOwY0zUtILC1wzn5weHK+RmqqfqZbICms/tcZmUoF+X6ANpJvW8s5lL
 t2g5+Fp9HJXzrN/tS1+xvUxsNnaLt/U4LuzMa/hYJACeSJ76u3CHwZfUc9SILrWQs4Pc
 N0PKwksO+41+/5VzuK42LDyC3JX5QK91CtSlzf+BtMFhQ0yFfIBC5Q74Qy5huf54wP1z
 GqcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC+CL2HT7r7CFAc+RMzJoqVpCVsaSWF/yB9OM+YNR0d0g5jeCvyeDZ5tqw0/eVSDoXnIpNaEU0LofV@nongnu.org
X-Gm-Message-State: AOJu0YzdY5s95JItlxrlINT19AXs+xXzQmCGsSuFXItoAaorrI8hLMsv
 Q3er/Ut0MMXcFk5zHRNjiSsRdrNjpvWz2b5I9JNqBemMtuGa/vOa6OvIrqac8qQfr7SYshGMwXf
 KsE9qkkr89TruWzqaKfD9X8GfnCZuqufVFEqO
X-Google-Smtp-Source: AGHT+IEm286Y5+gGVSgo6YuIHJD03UYjc8ecMewKqrFmG801aKyLbfo2W+JVnoKVpqef7APL6gWU/fmrUEBckoLxHmY=
X-Received: by 2002:a05:6402:2687:b0:5aa:19b1:ffc7 with SMTP id
 4fb4d7f45d1cf-5c244360b96mr83321a12.2.1725064882586; Fri, 30 Aug 2024
 17:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <20240828122258.928947-7-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20240828122258.928947-7-mark.cave-ayland@ilande.co.uk>
From: Octavian Purdila <tavip@google.com>
Date: Fri, 30 Aug 2024 17:41:11 -0700
Message-ID: <CAGWr4cQx_iH9wZxzfauxC7_ueWJ5QJ_YYnrgwiAQA=+Vgg-3aQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] fifo8: honour do_pop argument in fifo8_peekpop_buf()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: philmd@linaro.org, Alistair.Francis@wdc.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=tavip@google.com; helo=mail-ed1-x52f.google.com
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
> Pass the do_pop value from fifo8_peekpop_buf() to fifo8_peekpop_bufptr() =
to
> allow peeks to the FIFO buffer, including adjusting the skip parameter to
> handle the case where the internal FIFO buffer wraps around.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Octavian Purdila <tavip@google.com>


> ---
>  util/fifo8.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/util/fifo8.c b/util/fifo8.c
> index 5453cbc1b0..1031ffbe7e 100644
> --- a/util/fifo8.c
> +++ b/util/fifo8.c
> @@ -117,7 +117,7 @@ static uint32_t fifo8_peekpop_buf(Fifo8 *fifo, uint8_=
t *dest, uint32_t destlen,
>      }
>
>      len =3D destlen;
> -    buf =3D fifo8_peekpop_bufptr(fifo, len, 0, &n1, true);
> +    buf =3D fifo8_peekpop_bufptr(fifo, len, 0, &n1, do_pop);
>      if (dest) {
>          memcpy(dest, buf, n1);
>      }
> @@ -126,7 +126,7 @@ static uint32_t fifo8_peekpop_buf(Fifo8 *fifo, uint8_=
t *dest, uint32_t destlen,
>      len -=3D n1;
>      len =3D MIN(len, fifo8_num_used(fifo));
>      if (len) {
> -        buf =3D fifo8_peekpop_bufptr(fifo, len, 0, &n2, true);
> +        buf =3D fifo8_peekpop_bufptr(fifo, len, do_pop ? 0 : n1, &n2, do=
_pop);
>          if (dest) {
>              memcpy(&dest[n1], buf, n2);
>          }
> --
> 2.39.2
>

