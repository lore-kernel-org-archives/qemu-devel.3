Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFECBC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6U23-00064V-Jd; Tue, 15 Sep 2026 10:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x6U20-000647-GX
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 10:21:09 -0400
Received: from mail-oo2-x0c.google.com ([2607:f8b0:4864:31::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x6U1z-0008Ve-1b
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 10:21:08 -0400
Received: by mail-oo2-x0c.google.com with SMTP id
 46e09a7af769-804e42309a5so1240898a34.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 07:21:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789482065; cv=none;
 d=google.com; s=arc-20260327;
 b=i1T6HzF325sd3k/ZReWXJwveYNdOIetX1EYNhSNkWs6/jdkvXiI8hGxeNa7WFCqHmP
 cKmxMOlIwVPUQn5OscRyr15Vw+G7aTyh7K4+ukI838T2avYavjCMJWgO1Pf1hCSVilZ1
 J8OUKZk0MF1rQAYKoBVVzhWVKgx5QkNqH9u2aB/t8N4oBfy9FZLFh93SGUrlB/AIIm0S
 8fxfbJdgb48tuKUJ+0ZKa9UR7TbSlMfOAgNhSOHlP7phpFMLxNex9dweFINnFzfxwfOp
 YZ5CaJ1k9AlSStQ+1FVXNMT+g8jEplucyV7KiiQasGcYac1q7xy6NRELT0uNfxfjLV6U
 u+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4ccEufg6Fx9pmngr+HxmTLLsNVOotaoPLjZrvNHTROs=;
 fh=jL8xgK7DVka9pHcnl1Orc/yspZye8rAD3rmhsUJvzG8=;
 b=TbUBCAiyG3xA2l+fAL+F+9PQRS4vbWpTwOW4jiMRakq67RKbcvdOVfm1gBJewSjE4n
 2j36gZRDwKPhOkCioL8+mbES/P+3NYuOpaRxs6qUj8abCtJYPOk1Y9ox/jCHk/4ORQKn
 bA/xPO1iq88cEOFHYqy5BiUihDV4CJFufN+BO/USXapOBt4bTTxt7kxLOdZtyZdQF+2v
 i9RJFCrzNiMRQywzQ2D7TPTT3ZQpygr63FebJFc1t2VxLEAhyNWg7p7Bwu+HIS5a3Ky/
 QGNsg4ldtkBHt8YMumGeAzWjLl1t4yEs8G0vxoF42JQ+S2EeVdhdvAQ3EyLnukrQSd+h
 zSJw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789482065; x=1790086865; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4ccEufg6Fx9pmngr+HxmTLLsNVOotaoPLjZrvNHTROs=;
 b=K5fcjCWg1Mup26X82x5aWgi0d5HADLfC51EOO12bFj0u5bqggqeWj3riVqRFX/txxq
 8ebtFHVo3YseTM+S1IF7UNKGv920XILKwGGa4+kVKoAqD4/Suy1LLCtiPZgdE/QLSixs
 8ZnO7j+VuB7NQR5lf0nsA824IWwxHKeKlUQcuIjdpxlActGF6o+HWUqxF0fTtfeqOZk3
 lH2Bl3DLqWDX/ofUH7HjgztRBKe+BsA9bcsRNhUF25n4ltNZHn5M2KcsuHJcoroOwnmS
 4tRY9232uymZEG/32IwtjwZiF6IR1d/VyoyFC8u25M4u2HzzpB23KPMwUrKkb/BROcGa
 IB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789482065; x=1790086865;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4ccEufg6Fx9pmngr+HxmTLLsNVOotaoPLjZrvNHTROs=;
 b=Y1OiOy5Q19OVZ1uu0PZzXUr77840geiWLeuttZ+YRA1IN0+6Mpr1VWydBeiksrrNuP
 DYY6Q6tHSpY9asZfJVrj2ImP0JZHUoTRK/2EIbeSOL7lbcTon+cULSL/g2oZjdur6A0f
 jIkP8aV0/OiiCKs5M8HRmDg6ofIFZGgsRcaz1hsld6eMWzvS7e6xh9HO6smjaiqmcExU
 fkQPhJnp2wqmGgfsGz66VyioOAVz3vqAYB+DrgeSV8u71w6w06FPOEbRmVLrfZtNmt6J
 HUEeUNdLvQcAzGvJT3m3lb7446ubIojWXKwBmXzWfzLhEspqpKkYA53WR5uok1HDZXdt
 VCCQ==
X-Gm-Message-State: AFuF++n3KNrEuhwplOOhN9dPMbShZj48aeRFSpUK5+1ydYkJb5o+NRzT
 frLqsLU+Mjcgr7wuVfSYGNCiad9nIGadYFl4gwsbKLiVF5kk5s0ZERtQmWVKEA5SAWDXDmRQ3bl
 Irt4c6pyGYdkzBPfa2jN1HOcE7DWjJGI=
X-Gm-Gg: AYBFou1s8/0kdAQ3HTJJ08UHrGzip2PLXrSYBQpTfUBKeIa8ddsHTrtkfgLe043Yovb
 IDRc3CorUY3yoO+V1XEyDstn5JfFxdVv/Pgm0KxsH0muL0SHYv5vbga7ezfEQT9yQ1Z/2XbCsVM
 upSAirfOl0APf+0VfNE3AINHGXd5YGdtqSxLSDdpiLuioS8zi7NItSmRh/gyJIsmr2Ch6XIrMsu
 ROQx3mvFNpTjICwm61ss+zaHWm41mseuXXd6EivlKwdqauCATGYyGz+pd+FkYAFQBwyM3o3FY0z
 yl0rJQZXT0e7wRWXd1wx36rnHPJmJf1XuXIVo1mDTEXr5ldRolz0FKvdx8Lak9CA/sdhAI3xO9G
 UpYvSC5AXdUo=
X-Received: by 2002:a05:6820:f00b:b0:6b1:3534:a5b8 with SMTP id
 006d021491bc7-6c53f047111mr4747146eaf.15.1789482065004; Tue, 15 Sep 2026
 07:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260915134412.4187164-1-farosas@suse.de>
In-Reply-To: <20260915134412.4187164-1-farosas@suse.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 15 Sep 2026 18:20:52 +0400
X-Gm-Features: AcwNN1XoB7REDXtOOhTqRYPJb_6-nkToECI6luQvvzhcZSNrVR5vnNiLHXtUy0M
Message-ID: <CAJ+F1CJXna98dT+dqVC2=fUtbTiWTUU2eQNqLWAV5wM4wzbGQQ@mail.gmail.com>
Subject: Re: [PATCH] qemu-option: Cope with a missing QemuOptsList
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:31::c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oo2-x0c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Sep 15, 2026 at 5:45=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> It's a common pattern in vl.c to chain the qemu_find_opts() output
> into the first argument of qemu_opts_parse_noisily():
>
> opts =3D qemu_opts_parse_noisily(qemu_find_opts("spice"), optarg, false);
> if (!opts) {
>     exit(1);
> }
>
> In cases such as spice that have the group defined in the module file,
> it's possible to reach qemu_opts_parse_noisily() with a NULL QemuOptsList=
 if
> the module is not present in the host filesystem.
>
>   $ ../configure --enable-modules --enable-spice
>   $ make
>   $ mv qemu-bundle/usr/local/lib64/qemu/ui-spice-core.so{,.not}
>   $ ./qemu-system-x86_64 -spice a
>   qemu-system-x86_64: -spice a: There is no option group 'spice'
>   Segmentation fault (core dumped)
>
> Return NULL from qemu_opts_parse_noisily() if there is no list.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  util/qemu-option.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 9fbf425f86..0ec12d252c 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -945,6 +945,10 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list=
, const char *params,
>      QemuOpts *opts;
>      bool help_wanted =3D false;
>
> +    if (!list) {
> +        return NULL;
> +    }
> +
>      opts =3D opts_parse(list, params, permit_abbrev, true,
>                        opts_accepts_any(list) ? NULL : &help_wanted,
>                        &err);
> --
> 2.53.0
>
>

