Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5D6C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 10:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY1WE-0000vA-5h; Thu, 08 Feb 2024 05:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rY1WC-0000uz-PY
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 05:20:32 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rY1WB-0001tg-Cj
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 05:20:32 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-42c4bbbf25cso3295191cf.3
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 02:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707387630; x=1707992430; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MfEmbPnvA2lSmgoLtPUPXs+FIaCImkZBECeIMM7eZ0M=;
 b=aGrQUZxCjhXVF+7B9waUk5hq2Latyrk05IXI7AMcR6GzvsVkCB/34VvKf+2mpZfAkq
 CnYM3tPr3urANS5ajM5nBH0nc3E9Ov3YJk0Eiq1VnsmLAG1fLCwyBZLs7uH3N4PQ4+NO
 iViymrh3bsz4jyV7RWDvJr50z6PXDLGDhtDwoiPqFyCkTh11MBFjPv/b5HrdjLuPO8ne
 i3YgULjTpvikujC9f9wBJpn5MGsX0LhGKSiFb1tDxUnRHXaMFC7uNyWZw3TzI242uXln
 qIUwN9mH9vHMDUfDpSgKdUkal4QXC/Dm7RNvZj5JGwclU3EtWIvqjZzuuavdU9xFD3MU
 paJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707387630; x=1707992430;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MfEmbPnvA2lSmgoLtPUPXs+FIaCImkZBECeIMM7eZ0M=;
 b=g+VUfoOCH5Gwrv7GzPATooIwJYP8ePt7aCGBg9JOXEgGx9TahGKPlj2u+LjTFBJqoS
 zCwYwZ1Oqog6jEwe21zIPoyko0fe7xkqbYRCz7hqYJCiw02NNMX8yd1muCaes/gH7EDO
 Ni9cTzOWRa5nDIeVLRquJQ4PvOOf9ZfTVuIAN8aTP3Fi/oW4IQsDYbA/ZUg0NktbUnhe
 EEexkmg2uU0L0vF4OutDCTnGy/C0f8NHnvbIlfip8bEqjyFH7R5V+eniWen03I8FDqku
 nLiqKZvth5kopQhmpbTLDBGkTyDlqSHnMLobTUsnaa/+fhm++eh/3K00q2na9h4muECU
 i+dA==
X-Gm-Message-State: AOJu0YwfDTywPZ25EPKTqBxC2BU4UIX2JsRy6OOqh4jYSCIs9ijjLudg
 /jfsQ7BD3UVYIxNvBKPkNPQtidgVDZQincntGJnLFMTWypZMGmxffCH/XT13oEmFlQmb5vS05zT
 ByRDxLRyRg+kgQdXF5WJD/47O4vI=
X-Google-Smtp-Source: AGHT+IHQfRrh0fBfjzccvLDJ3lx3a7BJCIroaXIVhqkOLWYdvCLfnYRc0tI6dMG+jPaiWf4odDwtUBINtIQUuG/XWWM=
X-Received: by 2002:ac8:4e49:0:b0:42b:f724:3e07 with SMTP id
 e9-20020ac84e49000000b0042bf7243e07mr11367931qtw.44.1707387629966; Thu, 08
 Feb 2024 02:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20240207172024.8-1-bobby825@126.com>
In-Reply-To: <20240207172024.8-1-bobby825@126.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 8 Feb 2024 14:20:18 +0400
Message-ID: <CAJ+F1CK4qyjf2VUMp_z_QV2OA3zxrvGaDTJUvrmrGumgNKsTUQ@mail.gmail.com>
Subject: Re: [PATCH] ui/console: Fix console resize with placeholder surface
To: Tianlan Zhou <bobby825@126.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Wed, Feb 7, 2024 at 10:38=E2=80=AFPM Tianlan Zhou <bobby825@126.com> wro=
te:
>
> In `qemu_console_resize()`, the old surface of the console is keeped if t=
he new
> console size is the same as the old one. If the old surface is a placehol=
der,
> and the new size of console is the same as the placeholder surface (640*4=
80),
> the surface won't be replace.
> In this situation, the surface's `QEMU_PLACEHOLDER_FLAG` flag is still se=
t, so
> the console won't be displayed in SDL display mode.
> This patch fixes this problem by forcing a new surface if the old one is =
a
> placeholder.
>
> Signed-off-by: Tianlan Zhou <bobby825@126.com>
> ---
>  ui/console.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/console.c b/ui/console.c
> index 7db921e3b7..832055675c 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1577,7 +1577,7 @@ void qemu_console_resize(QemuConsole *s, int width,=
 int height)
>      assert(QEMU_IS_GRAPHIC_CONSOLE(s));
>
>      if ((s->scanout.kind !=3D SCANOUT_SURFACE ||
> -         (surface && surface->flags & QEMU_ALLOCATED_FLAG)) &&
> +         (surface && !is_buffer_shared(surface) && !is_placeholder(surfa=
ce))) &&
>          qemu_console_get_width(s, -1) =3D=3D width &&
>          qemu_console_get_height(s, -1) =3D=3D height) {
>          return;
> --
> 2.38.1.windows.1
>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

