Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A9AF41980
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 09:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCwrW-0008FD-6C; Wed, 15 Apr 2026 05:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wCwrU-0008EY-1k
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 05:48:44 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wCwrS-0003uP-2C
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 05:48:43 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so12436547eec.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 02:48:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776246520; cv=none;
 d=google.com; s=arc-20240605;
 b=ToOKlCIAxipK+hitwxwLbhQ1OVWWSQpW/MQgCduuj/w9TIlHSqSTpTgbM5qFi748Cu
 /Vifv/sbBN3RhKq+xsMNzE+nRba03voYwkZ5IzXZAV4Osh7sRRYp9hVrIXjy8gFL1k3T
 ixXWmm2Vx/HUiVlvBcfm/qa6i88csWKXqevmN1OTfRXYxTC7SUIeBYiEQOeOjXjZzqOz
 x9ucv3WlnTOSX3Vq4ckXRFhWPTo15zsAqOIov/ROj3REendfq3KrKU9N/Q4ogj0mg0el
 4jdjnSS8AX97eHjlRzpVCMx8VcNfB6ZlvLwCSW1izStiaKgy61Wqvug8iKAOPvehbZv4
 1mRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zn2b50tY026EE/sybTX+yDj4CYErgWLza+0zOzkCKB8=;
 fh=5sV4ndrvjvymr/oiDT4cMm2hI32i1qZ5NC+WqYkdp9Y=;
 b=VHom8dRc3/f+50l3qeAhcuXEmp8cXd8NIFGSsoXv9sqQ9Ciosb0YmuI6iQGZh1Y7TC
 Orj6IYBI/IMdh5qsAbRC7jNEfRDmhH3+TqgImkFZD8cCfk2E6ogwbCzUMR/g+UZZjOx2
 TxgpMwLY/BDuOuDUIVldb2EwqoULCA00K3ST9wuZtUsBpuVl8roD/wrou9bhmsS+C4KR
 cnWo4RQUqyQ/TBAfCSdYMSatyTYTWffOJxLyL1UNH3d2/11ejGpGRLULusFO6/mOB1dp
 I1odLVXpQiYmxDWCgFMDi2oGppBs0NcGLxeb2SP76/Ff0f3CPFkqTOcziIIdyfJJT0Os
 T5tg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776246520; x=1776851320; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zn2b50tY026EE/sybTX+yDj4CYErgWLza+0zOzkCKB8=;
 b=mIa/LZY4w6aJYNvEsSPy58d4l8li+SBgov7Wx49vWmhVpSsd/90yn7/HQfyQeNsVMd
 prA+D7NnwWVvDWlVvmlQ1A8uXCAgxD2NXk/oiX2ntT0PRgBWlMDgicz0B2UPpf0ImlqK
 cS8uDi6/tFdh3nvCdY3bMX+3xm2+LSMSJRM+KOAhKOFSGvgrswJ2Yfaum7d2Mti9VRmE
 KjYnelTXUIdVYpQ9TV24SpbCc6HRK+mxHYdeichBoCPcBA660WdlJKci65Cc7uSD889e
 7fUT8sNo2aq6gfhFa8LpqwAYy1mJU0nU3AAzxPBMTbpB+80/0BeNIRi9mJ/FKe6+ejpN
 tz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776246520; x=1776851320;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zn2b50tY026EE/sybTX+yDj4CYErgWLza+0zOzkCKB8=;
 b=RMlEFZoRp46dmXEwumSofL8FkgUt6iv0pkzWOqPBwwbBmOqRJXvti/ZlJ5LeLDIU+h
 EnZdFxjtMufhhwPrp/G/ULi5uChqbVgR2TXBWmxACzgm3aG24PZ/bRyiQ70380qasAHr
 VsloTNHB5gOHl9AJlpBfR2AITAj8UBDd1C/fRanvNybyUjZPhM/chWhWp4aCGNtNd9pY
 1qWkFC/MnKrt/Ek7fXYPsAaL19WeHYWNtnVOVqdENPFTWFxv08zG3MlfTqGmN16G++em
 FqfwwoSX8MB4Q/7dR+CWDl3yZpQP8TlhTkE22uf5nkd3A1GFadpHcPN4dPu5W/frxrgm
 4NKA==
X-Gm-Message-State: AOJu0YyaFNIOuZfCk8av91rPhx9zqHRAr50lEMpBzWQUoTFC8EgzTAqQ
 6aveF4fq6c/0I18/jv5Uwl0fSfY5E5iLAr1YzI1Bjt0wUM36N5liycjfDaGLEU5PHgQd36/J4GD
 Tc7LRPpL2V1JSt9ngUBM3lvzbT8B2Yos=
X-Gm-Gg: AeBDietAGUz+rjL2RpdEmamLChyQtiT2Q+24KftxrtOoJXSShegGl1sXLAX+XRdXM6A
 4tacsL6aVWj9h4Txk8XBMEMGeWLG3oeOQ+3/Yx7tQ+kbDLttlqS6Hnnk73uzpKxQud79yBAjAHm
 YOhQUk686fCa/o60i9upr/H2+YhRbvokfqddzT+FI62/ibteGy7iw4dbFNg13+QcuTIY0eXsUR3
 PH1CyWJrsnAZMj/dlY00Y29X/Q9tQm9pKoUZvPpDbpa6MezYlqIA34oAi7+h9/AUJMGvadQIqKl
 FawCcMtjvJ8pdXPsrev5INCRNKBNWqFwe2t5Ua9h
X-Received: by 2002:a05:7300:7255:b0:2c0:c415:cfd6 with SMTP id
 5a478bee46e88-2d587d83956mr11981294eec.13.1776246519936; Wed, 15 Apr 2026
 02:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260413164338.42894-1-mohamed@unpredictable.fr>
 <20260413164338.42894-2-mohamed@unpredictable.fr>
In-Reply-To: <20260413164338.42894-2-mohamed@unpredictable.fr>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 15 Apr 2026 13:48:27 +0400
X-Gm-Features: AQROBzCiaxdHjz5_lIwVTSmDw1iX3AG8LHVyivOwkebWU_pRe-Zde9LfcmJgyoM
Message-ID: <CAJ+F1C+8Lgb3kNRfpHfuMN4L_O_uWqsNe+55stCsct86LHUCTQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial COM: windows serial COM PollingFunc don't sleep
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Werner de Carne <werner@carne.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1330.google.com
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

Hi

On Mon, Apr 13, 2026 at 8:56=E2=80=AFPM Mohamed Mediouni
<mohamed@unpredictable.fr> wrote:
>
> From: Werner de Carne <werner@carne.de>
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1802
> Signed-off-by: Werner de Carne <werner@carne.de>
> ---
>  chardev/char-win.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/chardev/char-win.c b/chardev/char-win.c
> index fef45e83aa..f13d526e2f 100644
> --- a/chardev/char-win.c
> +++ b/chardev/char-win.c
> @@ -28,7 +28,7 @@
>  #include "qapi/error.h"
>  #include "chardev/char-win.h"
>
> -static void win_chr_read(Chardev *chr, DWORD len)
> +static int win_chr_read(Chardev *chr, DWORD len)
>  {
>      WinChardev *s =3D WIN_CHARDEV(chr);
>      int max_size =3D qemu_chr_be_can_write(chr);
> @@ -40,7 +40,7 @@ static void win_chr_read(Chardev *chr, DWORD len)
>          len =3D max_size;
>      }
>      if (len =3D=3D 0) {
> -        return;
> +        return 0;
>      }
>
>      ZeroMemory(&s->orecv, sizeof(s->orecv));
> @@ -56,6 +56,8 @@ static void win_chr_read(Chardev *chr, DWORD len)
>      if (size > 0) {
>          qemu_chr_be_write(chr, buf, size);
>      }
> +
> +    return size > 0 ? 1 : 0;
>  }
>
>  static int win_chr_serial_poll(void *opaque)
> @@ -67,8 +69,9 @@ static int win_chr_serial_poll(void *opaque)
>
>      ClearCommError(s->file, &comerr, &status);
>      if (status.cbInQue > 0) {
> -        win_chr_read(chr, status.cbInQue);
> -        return 1;
> +        if (win_chr_read(chr, status.cbInQue)) {
> +                       return 1;

indent is off

> +               }
>      }
>      return 0;
>  }
> @@ -147,8 +150,9 @@ int win_chr_pipe_poll(void *opaque)
>
>      PeekNamedPipe(s->file, NULL, 0, NULL, &size, NULL);
>      if (size > 0) {
> -        win_chr_read(chr, size);
> -        return 1;
> +       if (win_chr_read(chr, size)) {
> +                       return 1;

same

Otherwise
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> +               }
>      }
>      return 0;
>  }
> --
> 2.50.1 (Apple Git-155)
>
>


--=20
Marc-Andr=C3=A9 Lureau

