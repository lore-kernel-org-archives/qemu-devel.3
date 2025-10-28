Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B5ACCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 13:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDk8a-0006SA-Lo; Tue, 28 Oct 2025 09:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDk8Y-0006S1-9q
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:53:22 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDk8U-0006we-OA
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:53:21 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4e4d9fc4316so64390941cf.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 06:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761659596; x=1762264396; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QwpKffiIzZfIj3OR8x2H74w/HHbZRzvGrYIknNZdOzg=;
 b=kO9zYGBHbN4KeCKvx/lx9NVt7I5a127bEzKg9tKvxXY5aFuopUd7EaR6JFZXRjRIaA
 VLWufT+HpHCqg0kipk1Y5bhlkmjVEgziWr4smfVVg3iI6l4t6lhHoASA11MQJLBsiizQ
 AU9XuoDGnWKS82S9EjlJMe2x2rF5IiYcvkOPUyrCI21vFIXn698ojYSHvBNQfJeoS0Gh
 U4VUSTQEXpJTMY0hkT1xWx/JSxpUP+lQaFs2RbqdZUqzJhGKPdl3XA1U0l3qLzlYgerg
 N+Rc3cQS+mojDf895/sydpptKebsv522FB/M+TGaIFEyvRCwjF97IFNCXl8o76QJvs4c
 V8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761659596; x=1762264396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QwpKffiIzZfIj3OR8x2H74w/HHbZRzvGrYIknNZdOzg=;
 b=QOv/mI2ZB9SLSvqU2XNJWZ26Tj827p2FPFg0uxNDdUiB3CkL3x/WTQxR6TL9r5I9wF
 YDUKvyH62y2ekpmBoJ1EQXBvHr4J+kvqQp950feDGyz2GUZYCMojBEyVe6mEUwpCC0FP
 XQ7MiIkk76JqmSX/bby9/Sn3eDX9i3RoEEZ6IJeFXCR5zTivq0/IgKuGTyTylEkFZq03
 Lnv13TcPcM7H8FP86ys1DEVoaAI1SvVjIvoxA+XRbjAMmHWjW/nfw0UtIiuFjoerTUQf
 TNFLJVpZOdATMR5rlDVCFMqtfWsn+1vQvejooOs/PqxlspLFvTz9pIz0AD+bKiQ1M52s
 2VCQ==
X-Gm-Message-State: AOJu0YzIW5o0JvUf/Fp1Nnz3iljsgY+Yp5fZs5k77XeCQGGuZQbyZOOQ
 54MQXmP6ht7DjjUvLiJbGuAdiidayrohcRZ1mwMh6aegPwM1W9zURyjjiMu50Z+YEpoCHgpj3+3
 VHsnSwXaJ6ec8S04QSztr4pXoqyWUQrz4JvRA8V0=
X-Gm-Gg: ASbGncswSt1xqA94+qJeE3vWOgP5AMmkO7VDw2ioAeEbcg3SnKk2/CADPYqqNnWdMmi
 cMFem8uYxO9eeewPBjKp/VCod/102PFaFbYFMMSxvBNixX2s6f00BSokVqhscLfXigsgdnAl1tP
 b6zztvUjLj5fOaWtgsDC21nfPCB1I0IbTJhLieskzyDvNHXbCevBZOx6I4FTB+DJc15oZIKLIGo
 nCFltg5uvPqz70rB5fOcRWEo39Cr7hc7F92gNE5XMyD9z7EmYcTczOghQxr1U7ZXhzlGlQXiFdN
 pamz1DQYGkLhwfrb
X-Google-Smtp-Source: AGHT+IGECE4bYPYCjFR0nW9wttV57exmgIDs/hHdGyhQgJe9oimQdp0WKHLsyXurDPb3khSQgRLCx/dOq6tg6S1H4qQ=
X-Received: by 2002:a05:622a:3cc:b0:4e8:8d97:ccad with SMTP id
 d75a77b69052e-4ed0764464cmr42147321cf.78.1761659595955; Tue, 28 Oct 2025
 06:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20251022150743.78183-1-philmd@linaro.org>
 <20251022150743.78183-7-philmd@linaro.org>
In-Reply-To: <20251022150743.78183-7-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Oct 2025 17:53:02 +0400
X-Gm-Features: AWmQ_bnZljpW8NnDYiIA7o4nX_5Ycbepq7bQ05Yabzi5ihs-2zRzaNlVdGoTMRg
Message-ID: <CAJ+F1CKXgp5cFk+yLDSM698rcV_OgxY_RvbripnjgVeVA01DOA@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] chardev/char: Allow partial writes in
 qemu_chr_write()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Wed, Oct 22, 2025 at 7:10=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> If qemu_chr_write_buffer() returned an error, but could
> write some characters, return the number of character
> written. Otherwise frontends able to recover and resume
> writes re-write the partial chars already written.
>
> Cc: qemu-stable@nongnu.org
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  chardev/char.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 30b21fedce4..5c8130b2435 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -189,7 +189,7 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, in=
t len, bool write_all)
>          replay_char_write_event_save(res, offset);
>      }
>
> -    if (res < 0) {
> +    if (res < 0 && offset =3D=3D 0) {
>          return res;

If write_all=3D=3Dtrue, we should still return an error, I guess.


>      }
>      return offset;
> --
> 2.51.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

