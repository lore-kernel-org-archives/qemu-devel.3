Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66ACBC87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 21:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujlEx-0002fA-DV; Wed, 06 Aug 2025 17:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ujlEw-0002dw-6h
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 17:00:02 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1ujlEu-00068L-Ev
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 17:00:01 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-af8fd1b80e5so55544766b.2
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 14:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754513999; x=1755118799; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a5WX42//zteNgRuz53SiD9dS8i3OKA3uwg+zySoqgPE=;
 b=CleUokOx/yzdijp4z+k7J8vs/SDmwWSNkA4UWXqruFuwzflwGnR9oz1bRTi+Sao+IB
 f7RfppRFSQjrvxk8oi6MnEsGkHqtbz+GATz20V4QYr5o8tlRHzD3vxDdWK2pJBq4khDO
 VboAEK/ztMTcCDSsN283Lip/7JIlW88yWSaWKW5SrB7P1YB7XyInMhfpX99GhlcTHvMi
 /mSIZK6IiSITmOKKQhWlSaApFYacovhmtnZIC2d9Db8E3tWoCQO9JeAYttL+vNrxkimR
 Aew+hLi2hHA94XufTkFOLgCIAP2Gh2u4p7ILUTQL6XLhQhq3DNasd5mln+/tlT7yDdxk
 Z71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754513999; x=1755118799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a5WX42//zteNgRuz53SiD9dS8i3OKA3uwg+zySoqgPE=;
 b=Rq5L1uzVvcW9zcts/2OG/O/rAIP6n3NWMwDq7+2eRrdcizHzf5ZoiPlp0qS2idvZeR
 Vk7DzUkne1DJA183SbbECn6uc5Jq2Nx5K3fT4y2WaV2j2iX/BigiPM+u5Y8tzsCcJFu1
 0vteK2UckixdSaedGq07uiVbKR8A/lbJYezZREl1GCH8pQI1EP5y4aVTQhZw8uKzD4Zr
 lFjQlDKRHDDPV3gt2LlQpdYyYN6fdyZrsnW0AV5XsCoQe2e2SzsgB4Y5bf1oZZiWrSiH
 XJzw5QVib08y4uVLl7lz0JNEZzVZ9luyaDFCHENxBpyDp0BMd7hjxD2Z4uD9cy1FuwPr
 M+HQ==
X-Gm-Message-State: AOJu0YxkBcfHgys3RMVniTHpvTvBdSoxtY1hBn96J2xAgVZGZMa+mNxb
 lYH81OaB6tHrdDhFo68cTaKmf74yWeJmrunaDE2tuP9BuvwOnqwmdgfxXeZZnVO1FuiDqn8QCbA
 76mmWjoUkTde9nrlJVsqd0J+z2vGXeENE8cvr
X-Gm-Gg: ASbGncvpngFZoEFUJFg7TBfZ+8fXudMUNBJYyss7nBEVKOIcg7vg5ncdmR5I2/CDI7W
 XNk097WVPuplEvZMwjdvlPCAvrNeGobwUI4ZWavuZRGnjgd7jeO8pfETE4DgmOvQx7fR62sffdG
 7XNZyilN0QAXiocGbhUzIB0FY1XH/CtStH9xvkBPtcUmsVBxgp1ohSPUQzM+F8evVQNcBBP3l6k
 G2r+g==
X-Google-Smtp-Source: AGHT+IFtIZKR6s8FUx8UpKdNSVPputNDgXw0Fr4DdJf0KrDM9bFEvifx/HgN38aWDJOe4KG/nqOW3GQ5VXOeuyGu6Jo=
X-Received: by 2002:a17:907:7241:b0:ad8:9c97:c2e5 with SMTP id
 a640c23a62f3a-af98feff474mr390558166b.0.1754513998579; Wed, 06 Aug 2025
 13:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250806195530.1789560-1-marcandre.lureau@redhat.com>
 <20250806195530.1789560-2-marcandre.lureau@redhat.com>
In-Reply-To: <20250806195530.1789560-2-marcandre.lureau@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 6 Aug 2025 16:59:46 -0400
X-Gm-Features: Ac12FXwssgG1c7_DTT_tfFFIgiHSNjeI5_IbzVtcol3H4FMuN4tf52IAU6DeRmo
Message-ID: <CAJSP0QVb_YCOujyKdjXFhAiYFdaaY7UgabtSoesi6f5M95w5jg@mail.gmail.com>
Subject: Re: [PULL 1/1] ui/curses: Fix infinite loop on windows
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, 
 William Hu <purplearmadillo77@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62d.google.com
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

On Wed, Aug 6, 2025 at 3:56=E2=80=AFPM <marcandre.lureau@redhat.com> wrote:
>
> From: William Hu via <qemu-devel@nongnu.org>

The pull request merging script rejects this pull request because the
author's email address was mangled by the mailing list:

ERROR: pull request includes commits attributed to list

Please fix up the commit author's email address in your branch and
send a v2 pull request. Thank you!

Stefan

>
> Replace -1 comparisons for wint_t with WEOF to fix infinite loop caused b=
y a
> 65535 =3D=3D -1 comparison.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2905
> Signed-off-by: William Hu <purplearmadillo77@proton.me>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> [ Marc-Andr=C3=A9 - Add missing similar code change ]
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-ID: <tSO5to8--iex6QMThG3Z8ElfnNOUahK_yitw2G2tEVRPoMKV936CBdrpyfbe=
NpVEpziKqeQ1ShBwPOoDkofgApM8YWwnPKJR_JrPDThV8Bc=3D@proton.me>
> ---
>  ui/curses.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/ui/curses.c b/ui/curses.c
> index a39aee8762..eccb585948 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -265,7 +265,12 @@ static int curses2foo(const int _curses2foo[], const=
 int _curseskey2foo[],
>
>  static void curses_refresh(DisplayChangeListener *dcl)
>  {
> -    int chr, keysym, keycode, keycode_alt;
> +    /*
> +     * DO NOT MAKE chr AN INT:
> +     * Causes silent conversion errors on Windows where wint_t is unsign=
ed short.
> +     */
> +    wint_t chr =3D 0;
> +    int keysym, keycode, keycode_alt;
>      enum maybe_keycode maybe_keycode =3D CURSES_KEYCODE;
>
>      curses_winch_check();
> @@ -284,8 +289,9 @@ static void curses_refresh(DisplayChangeListener *dcl=
)
>          /* while there are any pending key strokes to process */
>          chr =3D console_getch(&maybe_keycode);
>
> -        if (chr =3D=3D -1)
> +        if (chr =3D=3D WEOF) {
>              break;
> +        }
>
>  #ifdef KEY_RESIZE
>          /* this shouldn't occur when we use a custom SIGWINCH handler */
> @@ -304,9 +310,9 @@ static void curses_refresh(DisplayChangeListener *dcl=
)
>          /* alt or esc key */
>          if (keycode =3D=3D 1) {
>              enum maybe_keycode next_maybe_keycode =3D CURSES_KEYCODE;
> -            int nextchr =3D console_getch(&next_maybe_keycode);
> +            wint_t nextchr =3D console_getch(&next_maybe_keycode);
>
> -            if (nextchr !=3D -1) {
> +            if (nextchr !=3D WEOF) {
>                  chr =3D nextchr;
>                  maybe_keycode =3D next_maybe_keycode;
>                  keycode_alt =3D ALT;
> --
> 2.50.1
>
>

