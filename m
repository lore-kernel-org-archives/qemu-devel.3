Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA8CCCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 13:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDN2Q-0006uW-04; Mon, 27 Oct 2025 09:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDN2O-0006u9-Do
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:13:28 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vDN2K-0003M4-CH
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:13:27 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b4f323cf89bso1107905166b.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761570797; x=1762175597; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AfNs3oxLqrcvw23+3uluq86I9fJAQvHji0mg2agejnU=;
 b=ZgVzHFxmzJjSe74tYCVcbm0EZe6rZNKoX9y4kOa26rcKp/HZBVYp/67X/UenD13YNb
 2XmLkU0X2V0KQgJewCV3F55a0pg2bA0ElBNEAHeEcDUJDmS9LuBfY1N0fzyzN4bQdQBH
 SpvQJ2x90bPvQeUmDXws4rNeAorzUsB6TeIeIj36FRdJviz9pL9LCjHbviHnTyLie8Xt
 PLy3viRXbVbsXZcIU+JyJR2OFmMk5oCIeBBtuA9rR9CRAshAKLSu5b+Hl4H8pSwybkl+
 qURax7adEluUnl3Vb7cvDiiqeH8eL5jyu3CO2ktL7I0f2bJScRl7FNf7Iok/L0r8/KIv
 9A4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761570797; x=1762175597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AfNs3oxLqrcvw23+3uluq86I9fJAQvHji0mg2agejnU=;
 b=ZKKt4w8VFc+rFSxkYwOvi8OBZqaBvzS/9JAlLlQehJmIdOL5p7E/++ZTVtQ5bcp5WR
 tPIfYjOhk5PXDhvfLNCRk5Kz523sYVGbYDPxubBpbQ8xC5e+PEd7qg7HF8dyDoqU39vh
 qhzKE4FSoGNfQmNhjb0iQLCkKMSpZ9i0geQNLnHFRqXblAhxAVbD3nWZ5syhImjq2NiO
 50xinskPSmSYUMwRH2DnK1LazTVfZ3UiLAIHgzJvkXT3sD1ahYEY1yqx3QOgiyw1xnsT
 nQEoweSzRNfc8ujgmOVJZedfYRe9qABYf195qbRMxCz/P5ruvxmJU6C0leOhEQVwihV6
 JM5g==
X-Gm-Message-State: AOJu0Yx9/e86a6RKURWZVXQyZnJQW63v9IkA8haGkLEPo2u/h4+OdyjK
 LR4MSV0NA9HLEF8vBRJnTGaZQkMeyBWC9y47+GAFrWOTldV5kQKOVBWGOuZIMvpjqpyrhJv+U+F
 aDNsIN6NiXhihpk8GtYwXhZH/ItIMT0/+GnYMIruPEw==
X-Gm-Gg: ASbGncsw5xbixqArigkwDOgVkZE1tRtd77/v/shswq9OqMVb+bzEXafptSx8AkoGNI6
 emI489AWgrjr9Je+ZqFgTpGslUJO5sXSJtDzxjiAzKd+PUKVa11DgJJKKG2ZxizfosAvPdR92Oa
 rgB+OSMtzCE4gQEfCm5a2+CVN21FYSf7BiVm2M5zHqRhrPYiMfF5EQh1OhA4v92tMGQN6lrZ5sx
 kDuhURGLwjviKuPHn5WN22GJv31pBnuujg6Ansn8zCvk3T/3y+bNLZgLPzgTYeBt17sw+FxrS2f
 ZYw0bNZc5lyMm09X
X-Google-Smtp-Source: AGHT+IEn/PkpkzQDei58UDExwk9Xl8mQu2vdUmstfZCSltTVsochMlqJlFpnSniwrKnwc4NYEQRbuGnW7vduxtI4Ufk=
X-Received: by 2002:a17:907:3e21:b0:b3e:c7d5:4cc2 with SMTP id
 a640c23a62f3a-b647494100fmr4496990566b.38.1761570797406; Mon, 27 Oct 2025
 06:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20251027113910.25379-2-nicolas.parlant@parhuet.fr>
In-Reply-To: <20251027113910.25379-2-nicolas.parlant@parhuet.fr>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 27 Oct 2025 17:12:56 +0400
X-Gm-Features: AWmQ_blVrSlwz_qyJruiVPM8sn3v2I2YLud8un179syAIqWEVWDlNzQWzZIXHyU
Message-ID: <CAJ+F1CJCRfXc0SS5k3OsSwoHsKppQqVeG4U+5iH73UDeS_Ew0w@mail.gmail.com>
Subject: Re: [PATCH] make gdbus-codegen optional, not required by passt
To: Nicolas PARLANT <nicolas.parlant@parhuet.fr>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x634.google.com
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

On Mon, Oct 27, 2025 at 4:59=E2=80=AFPM Nicolas PARLANT
<nicolas.parlant@parhuet.fr> wrote:
>
> passt needs gio but not gdbus-codegen. Make gdbus-codegen optional,
> dbus_display which requires it will still fail as expected.
>
> Signed-off-by: Nicolas PARLANT <nicolas.parlant@parhuet.fr>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  meson.build | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index c5710a6a47..3f7c973127 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1126,8 +1126,7 @@ if not get_option('gio').auto() or have_system
>      gio =3D not_found
>    endif
>    if gio.found()
> -    gdbus_codegen =3D find_program('gdbus-codegen',
> -                                 required: get_option('gio'))
> +    gdbus_codegen =3D find_program('gdbus-codegen', required: false)
>      gio_unix =3D dependency('gio-unix-2.0', required: get_option('gio'),
>                            method: 'pkg-config')
>      gio =3D declare_dependency(dependencies: [gio, gio_unix],
> --
> 2.51.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

