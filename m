Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F183BFF886F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 06:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbk8-0006u4-43; Tue, 28 Apr 2026 02:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHbk1-0006sC-O4
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:16:18 -0400
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHbjz-000136-VJ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 02:16:17 -0400
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-2d8ffdc31d0so2793981eec.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 23:16:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777356974; cv=none;
 d=google.com; s=arc-20240605;
 b=fX+lymzwoErFm3aJdd2ygtomp49IRSLp5vSUiLp+FthPYSaZ/iizC4tMdDgme68sY0
 oWW+WaVLOJ5P35GwbS6iOeK+J2PhKhTZhzw4pJNOhTPm4aAIsTsZhVWVi9qBDFortVjI
 gzlXPUEsVGFoyzW/4moDwJ8zB19RAO2jk3Hd/nmGd55BMeHO9BNuDbjcmS26Dvs25UUU
 Gz6NCP4ESENMM5WSabBngjJIvHIPSF9QynCXaQaRohcat8jp/526vhLDXKw7LxFWaQSz
 TLnWDdMd1C7eNqBd3D8aBSr83KtYgM4//reok97PTjsjp6RvyVbRv6UjZ9U8+HlilJAn
 OLow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2dOBHRaGvuQxnPccomI7bJCXmVZwYQ5QB2PSNIreMPs=;
 fh=lOBSB/Hs2AAkL9G+pX/8nWevA4VW0M0kVZpTB7kbXLg=;
 b=fsW9jLXIHPyXWK0+8p7PLSVXMBPp8tUGjsN4/Prm+CtgX3CejirCaTdBR25VJCV0b1
 Xei8r0nu/nhEvvHfDWEUhA7NWpqZAyL+TmoUElcQznKJIbnuCTTq1bJFcURdHI973TZv
 pCeBO6Qz1F4p9J6gm48q18H7KFG9ekSz7NiQqRqQMaVurOFZE3N8AzVgCM+B8aBkM8Oh
 7ZbkTliRa3Tl5ogB0WRgcXKgfpNorI5UhIQG1rXJUxljHce5zzekdIpDH8D5RIC6ugWC
 ntoGfr6S6iZ0SeXZ8w33arqqwtDI2n0U2A6WJTRVnnHJpvX+BgJEY3xlUMXeqbV3krIS
 N0Vw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777356974; x=1777961774; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2dOBHRaGvuQxnPccomI7bJCXmVZwYQ5QB2PSNIreMPs=;
 b=MSxu2RqyQfVOLcay9dwhSThDYk7ikWfkYn4TYWigVwxjYJ6YIZW0sO6oNObUWc9Mre
 zVVieJHj2X7qt1b55PUlHJIMP+DI6FZGcjxsh+zbLVMxvHoHnnkHVZZuvp55Bhq1lrNH
 US8rpC/5Osez+uDwNvwZMNxMjLlZnMYk8fxpYYQrB9Rr1HX6Sem4H37ifiPtrnzWFIKs
 iRTw0OIlXEgZkdDt9NDR1rryXTviQHYnGEHDS+0dSNhNjuzrnurLVckaQPrR1F2yFasH
 wgZOV6Lx5wvk/vtZEDgZfiBO1/LTcl4WlQO0FePfXJ/vzxra67Bnx2QE/8giQEeaExT0
 2Zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777356974; x=1777961774;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2dOBHRaGvuQxnPccomI7bJCXmVZwYQ5QB2PSNIreMPs=;
 b=rhoEuERYYDqLB1Ph+5x3AW+Scn8QHjmvCAEY/4YekbJWC9gyA2W/WGDwS6kT/ELcl8
 QUWJiiY3YsxsBhSsXIk2/WkzJUnvhUIG5LPEc4PNTsTzbl2HG9viF2F5f0Tv9IQri9wU
 bG0O/y+wqOfb84eHpMkwWg93PTXOsa91suzjO4FvIYWT8F/Y6pJPcXvAB+GysC8Md4U2
 kCsyvOt5zTPdKtCCLkKk0dILke7Kr+4ntzuW0/+HljKLRsk58hVeRK8IEYAXmbdKzOcE
 QvA0kaZntFgpWkBQlg8HkxwxfC5VlVW1mv7QhLt9KX5G9sI3u1MxzXXUc/gP+oFvPBxr
 o1Gw==
X-Gm-Message-State: AOJu0YzB8kc8+JI2gsiz+c0xzZpmEEzL8v8kiAN6vAX6o6D/IX/kWVZH
 OfB+ygBreYMePVwg2l4nkjFtBy8Li0ormCoKKquu7pmA1obFPJVQn4j6btqqreQYobatYs+gh/V
 eTnugLND1JkNYe6i6Ny6oLLLXIj6Aq0Q=
X-Gm-Gg: AeBDievfzKsQwHyRqn3NTrvzj7rYAy1sjfXdDTg5yK1QNjttLZXeeP5o+43kiVSI7mR
 zd4+M6vyDB4wau3iTGCEOnliSR76m9mmDizLeJ8r0iBD2saa/+2Jq/zfpzWcBZwhz8gxVlmL3g1
 d5REudebS10Z1Cqsh7PGwgUWWLR+Eggy71bScUKU1WLVtQpte4HZI7ocqvytHS+L7mKwczhZOv1
 6T+VZizj+0rcj9gY0LhrnP1miT8irvJHTko9EP7Dik2XBVMxQCOUzeVWQXT2o0O1cpxz28Xssfp
 Qu9H5pV3vfh74ziYT3Tv4Gg3BS1BcW5uMuwUryJbl455on/XLX8=
X-Received: by 2002:a05:7300:73c7:b0:2e6:e504:5435 with SMTP id
 5a478bee46e88-2ed0a015a63mr879217eec.12.1777356974100; Mon, 27 Apr 2026
 23:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260427223928.2742270-1-luc.fast2004@gmail.com>
In-Reply-To: <20260427223928.2742270-1-luc.fast2004@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Apr 2026 10:16:01 +0400
X-Gm-Features: AVHnY4JvwDhkzLh3hsw8skf9bQ9lbpQq6XEnVo-sr1AW0bKIGAMEek6IOmV5Nqs
Message-ID: <CAJ+F1C+fKiDfVOC1JTNeZiX2rY22+1CdaHi_t84JJaf_=tU4vA@mail.gmail.com>
Subject: Re: [PATCH] hw/audio/fmopl.c: Convert malloc, free to g_malloc0,
 g_new and g_free
To: Lucas Cardoso <luc.fast2004@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132c.google.com
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

On Tue, Apr 28, 2026 at 3:48=E2=80=AFAM Lucas Cardoso <luc.fast2004@gmail.c=
om> wrote:
>
> In accordance with QEMU's coding style guidelines, replace raw memory
> allocation functions (malloc/free) with their GLib equivalents
> (g_new/g_malloc0/g_free).
>
> Also removes the old generic error-handling code from
> OPLOpenTable(), since the Glib functions abort the program automatically
> if memory is exhausted.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1798
> Signed-off-by: Lucas Cardoso <luc.fast2004@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/audio/fmopl.c | 41 +++++++++++------------------------------
>  1 file changed, 11 insertions(+), 30 deletions(-)
>
> diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
> index a63ad0f04d..aeefc4c9fe 100644
> --- a/hw/audio/fmopl.c
> +++ b/hw/audio/fmopl.c
> @@ -607,26 +607,10 @@ static int OPLOpenTable( void )
>         double pom;
>
>         /* allocate dynamic tables */
> -       if( (TL_TABLE =3D malloc(TL_MAX*2*sizeof(int32_t))) =3D=3D NULL)
> -               return 0;
> -       if( (SIN_TABLE =3D malloc(SIN_ENT*4 *sizeof(int32_t *))) =3D=3D N=
ULL)
> -       {
> -               free(TL_TABLE);
> -               return 0;
> -       }
> -       if( (AMS_TABLE =3D malloc(AMS_ENT*2 *sizeof(int32_t))) =3D=3D NUL=
L)
> -       {
> -               free(TL_TABLE);
> -               free(SIN_TABLE);
> -               return 0;
> -       }
> -       if( (VIB_TABLE =3D malloc(VIB_ENT*2 *sizeof(int32_t))) =3D=3D NUL=
L)
> -       {
> -               free(TL_TABLE);
> -               free(SIN_TABLE);
> -               free(AMS_TABLE);
> -               return 0;
> -       }
> +    TL_TABLE =3D g_new(int32_t, TL_MAX * 2);
> +    SIN_TABLE =3D g_new(int32_t *, SIN_ENT * 4);
> +    AMS_TABLE =3D g_new(int32_t, AMS_ENT * 2);
> +    VIB_TABLE =3D g_new(int32_t, VIB_ENT * 2);
>      ENV_CURVE =3D g_new(int32_t, 2 * EG_ENT + 1);
>         /* make total level table */
>         for (t =3D 0;t < EG_ENT-1 ;t++){
> @@ -696,10 +680,10 @@ static int OPLOpenTable( void )
>  static void OPLCloseTable( void )
>  {
>      g_free(ENV_CURVE);
> -       free(TL_TABLE);
> -       free(SIN_TABLE);
> -       free(AMS_TABLE);
> -       free(VIB_TABLE);
> +    g_free(TL_TABLE);
> +    g_free(SIN_TABLE);
> +    g_free(AMS_TABLE);
> +    g_free(VIB_TABLE);

To make this function idempotent, I would rather use
g_clear_pointer(), but that might not be necessary

>  }
>
>  /* CSM Key Control */
> @@ -1081,11 +1065,8 @@ FM_OPL *OPLCreate(int clock, int rate)
>         /* allocate OPL state space */
>         state_size  =3D sizeof(FM_OPL);
>         state_size +=3D sizeof(OPL_CH)*max_ch;
> -       /* allocate memory block */
> -       ptr =3D malloc(state_size);
> -       if(ptr=3D=3DNULL) return NULL;
> -       /* clear */
> -       memset(ptr,0,state_size);
> +    /* allocate memory block and zero-initialize */
> +    ptr =3D g_malloc0(state_size);
>         OPL        =3D (FM_OPL *)ptr; ptr+=3Dsizeof(FM_OPL);
>         OPL->P_CH  =3D (OPL_CH *)ptr; ptr+=3Dsizeof(OPL_CH)*max_ch;
>         /* set channel state pointer */
> @@ -1128,7 +1109,7 @@ void OPLDestroy(FM_OPL *OPL)
>         }
>  #endif
>         OPL_UnLockTable();
> -       free(OPL);
> +    g_free(OPL);
>  }
>
>  /* ----------  Option handlers ----------       */
> --
> 2.51.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

