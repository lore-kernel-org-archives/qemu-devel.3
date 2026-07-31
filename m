Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A1FC5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpsLl-0006ln-Tv; Fri, 31 Jul 2026 14:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oliverhenryc@gmail.com>)
 id 1wpsLk-0006lU-RG
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:52:52 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oliverhenryc@gmail.com>)
 id 1wpsLj-0001F8-1u
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:52:52 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c160875e029so16093766b.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 11:52:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785523969; cv=none;
 d=google.com; s=arc-20260327;
 b=hsK6Mcs9oQt3GstfK403DH3KTFCHa0PQE9/QY6BvTZo9y53E2flC72tkVMkV2oPnUa
 oQTM4F7xYBUxDG9q4ITGiJgXqZ5je5dcbI93Vg569F3boBKNg3pLZqA9P7PxfY5fHZL2
 0n/5CYP2Ez6n0plLVpgFTa7nnO5Ubvn0kjhHhTMPw2+oiFsFZLeZstZG/5sk7phhFpKP
 QEB70/K6l/eURXtyU8XLvwAUSgxmSJZMeD5Rv9iNXzUYLUkyP3tJ1Y60yyws/cUyLuA7
 WmWjDJehePpoNanuJmUtMyHO9S7ZvgA8tpy8q3pzToFq2AX/SdM0zHD/1c+ljGva7t92
 HtGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OGLYYWq7fwy2M+52CVFM+m3Chs05YhXvvGvDgdhd6Oo=;
 fh=vPinGPxx/1+aDQf02ZUnvpyuMQtJPOpb7Jete3Oc3CQ=;
 b=qv5KdFNVIQkiEQ/Qhrq9cw2OQsl/m8oBC9m4YwVHcwSgIyDd/FzzZB7ChaopmOTtb/
 0GjWDo6yWP9TmkwdDugpo8dbFwo3tJBRh6myUw3foBEeOnz9U7iNeXJ5+na6q+9f5RGY
 3mbutSs0za3gQrPI8O2t6tHclYoKSE8M0qgauR/Tm8XDxwyQywldETMRiXSzfEkxoGu3
 EcDcxkCMoC1IRlh5+bJgzGSqQHvwfm5TQIBcEAxeAOT+tS5IPtgmHUvEfLSN59w+uZlk
 65bMtrFcUMijEJ0BvsFW7aXWppjLTYcDTa9qZ0mt1i33p7oalfSOb7/Z4WW6Biy8/97F
 X/5Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785523969; x=1786128769; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OGLYYWq7fwy2M+52CVFM+m3Chs05YhXvvGvDgdhd6Oo=;
 b=JL4DLa2R80kt7RkaHdt16WY0RLrb8FuOwD70Wgn949eB+HwSc7Z2oKDZhtDu4VF8ZO
 FKv8cB7Lf4vbr8D/RlJ0CWaenetn60AK63Iw287kz38WUBwYHg7fgZJ1TUDHkA4kPRXV
 7493yQvXWJSutfK+AYE5dcK53OvGQUkD+jvE4X2S4x2sUth4E+NVp/yIEShEFK7EkAiB
 684Di4Rsa1+4E2ZqOBFliajvc5nh+CQ9j1VwX5dZBtPmzIvypQOSoOGQIhuM/5Sfkp5L
 NBqymzf7wrrcm8WkeTbT7QL6xSyRuTXpzhGxqcdvxAMq1TJ4hcf+Z9KfoWdnW7+kiU5w
 B5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785523969; x=1786128769;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OGLYYWq7fwy2M+52CVFM+m3Chs05YhXvvGvDgdhd6Oo=;
 b=aNokdFeIeHvfR+Ha45nkcXqlAPXkIKy8QrYO7GXyAmVaH0jJDChn1ZN0O6aBsrdFFM
 6iliItcm53cT7y78C3UVvc4050gkzoZNj80eP1/oEOg/YHCzKXK5Rwgvty2AccbdBUHF
 S5+2ZTZL6rqmb1RBMvPThk/OPs3ZJp7TMIuxjdL7ZM0v7BIerzjJgUKOmgnm2sOze/qP
 PgpCZujvSd33i3owFm82HS7OtTlJEiJoth8WLTEvpWJCamyS2dypDB/e8gqYlsEcRZdP
 j736Qpw/0NbOIpAVllnI9PI0r/B8um3iM4G5eFAuN+LIrModW22IUCmfrQGpLhbd9onO
 XkJw==
X-Gm-Message-State: AOJu0Yxax2snLQaxqwz4XbMtsFiamQf32m2CGoGECXlkbcC7vKjOD1bX
 aLt3GB9sMO9M8vB8pZTWbuIZYit2ieJE3c0sHNhrzjoSV5oYXyMefjXLqSdm+q5iMXDp8aoqwpZ
 t//Y0FQ4UTDxpl17L/Wr1M27qTG7BVww=
X-Gm-Gg: AR+sD12kPT24V7EVQxGsgL4KOtpo+i/HI9cmYAxnBMWDlIsby2fJqtfpixxEyToYrdi
 vWmcqee0AViut164e02yKArr75qXVdsw+4OWvlRN9J+54XnUeIuDLVDTEXhnqE03WmhBU3LdxOR
 ar8pGWuk4CeZzj4HOa+xF3/Jzzw3A9sEcffQWt2atniD+187/BGtydAh2QLvkiVwQMHLrfmSg5P
 4tndgnMmygdfCzv3TnfTJGEWTlYh7yOPkCScRUKGxUQ+28Bke/55cY4xoZaeNKkbrIJMUhJIVaK
 G+ddj4qNMmKe8bmjaFcUu4I/Oqkj42vmPzM1FjkpJcf+5xho9y0FCRPcX6FiwR0GfqX6z+yYdmB
 3
X-Received: by 2002:a17:907:3c8a:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c1fe81e28b1mr46802166b.3.1785523969029; Fri, 31 Jul 2026
 11:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260730230449.963-1-oliverhenryc@gmail.com>
 <92c3b7f6-4afa-7a61-1843-fbfe855cb9c4@eik.bme.hu>
 <CAGxFFDP0mL-6fZcMQkJm7V1mDepC64Y+YFN-CcgqP0OrMX3w4A@mail.gmail.com>
In-Reply-To: <CAGxFFDP0mL-6fZcMQkJm7V1mDepC64Y+YFN-CcgqP0OrMX3w4A@mail.gmail.com>
From: Oliver C <oliverhenryc@gmail.com>
Date: Fri, 31 Jul 2026 14:52:34 -0400
X-Gm-Features: AUfX_mziftBdcNwbbitJEWDgS8cdSxNBfleZgmrjg5rH5EJqvyWfM_vhpUKsP1Y
Message-ID: <CAGxFFDPnTmeEhVa_sK87W14E=pr=36F+i9OmwQEO5nyh=1Ew+w@mail.gmail.com>
Subject: Re: [PATCH] sdl2: fix HighDPI display scaling
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 marcandre.lureau@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=oliverhenryc@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

I added a scale option for sdl that works the same as gtk.
I said linear filtering in my last response, but I meant point
filtering. I played around with point filtering,
but it looks pretty bad with non-integer scaling (e.g. 150% scaling to
match my setup). It does however
look quite nice with an integer scale, so maybe this could be
configurable as well?

What's the process for amending a patch? Do I reply with the
additional patches, reply with the whole patch, or create a new
thread?

Thanks,
Oliver

On Fri, Jul 31, 2026 at 1:32=E2=80=AFPM Oliver C <oliverhenryc@gmail.com> w=
rote:
>
> > Does this mean that on hiDPI displays now a 640x480 guest screen
> > (like BIOS or legacy guest) shows a tiny unusable window?
>
> This is correct, but:
>
> > ...the issue that other ui backends should do the same so just changing
> > one backend may lead to inconsistency.
>
> the gtk backend exhibits the same behavior as the sdl backend with my cha=
nges,
> i.e. it creates a 640x480 guest screen in physical pixels (my machine has=
 a
> 4k monitor with 150% scaling), just like the new changes. So these change=
s
> in fact make it more consistent. Although, I just noticed that gtk has
> a 'scale' option,
> which scales the window size, and stretches the surface to it. I
> suppose this can
> be added to sdl. I think it would also be a good idea to enable linear fi=
ltering
> when stretching the surface, so it doesn't look as blurry.
>
> > Despite the patch is just two lines maybe it's not a trivial change.
>
> Gotcha, sorry this is my first time sending a patch through mailing
> list, so thanks for bearing with me.
>
> Oliver
>
> On Fri, Jul 31, 2026 at 7:05=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.h=
u> wrote:
> >
> > On Thu, 30 Jul 2026, Oliver Clarke wrote:
> > > This makes sdl2 windows work well with dpi scaling. It fixes the issu=
e
> > > of the display surface being stretched to fit the dpi corrected windo=
w
> > > (which created a blurry result).
> > >
> > > Note, this does not do any scaling, it just tells the os to not scale
> > > the window. Before, when the console requested size 640x480, the logi=
cal
> > > size of the window was 640x480, and the physical size was scaled by t=
he
> > > dpi scaling. Now, both the logical and physical size will be 640x480.
> > > This is unlike most dpi aware programs which usually do have the scal=
ed
> > > physical size, then also make the render target that scaled size as
> > > well. This doesn't make as much sense for QEMU, since the guest is
> > > responsible for modesetting, and they should get the exact physical
> > > pixels they request (if i modeset to 3840x2160, I wouldn't want this =
to
> > > be scaled in any way).
> >
> > Despite the patch is just two lines maybe it's not a trivial change. Do=
es
> > this mean that on hiDPI displays now a 640x480 guest screen (like BIOS =
or
> > legacy guest) shows a tiny unusable window? In that case maybe this nee=
ds
> > to be switchable with a property or turn off scaling of 4k and higher
> > resolutions but then we get to the issue that other ui backends should =
do
> > the same so just changing one backend may lead to inconsistency. Did yo=
u
> > check how is this handled in other ui backends?
> >
> > Regards,
> > BALATON Zoltan
> >
> > > Signed-off-by: Oliver Clarke <oliverhenryc@gmail.com>
> > > ---
> > > ui/sdl2.c | 3 ++-
> > > 1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/ui/sdl2.c b/ui/sdl2.c
> > > index 1c97d23a47..1910477db4 100644
> > > --- a/ui/sdl2.c
> > > +++ b/ui/sdl2.c
> > > @@ -102,7 +102,7 @@ void sdl2_window_create(struct sdl2_console *scon=
)
> > >         flags |=3D SDL_WINDOW_OPENGL;
> > >     }
> > > #endif
> > > -
> > > +    flags |=3D SDL_WINDOW_ALLOW_HIGHDPI;
> > >     scon->real_window =3D SDL_CreateWindow("", SDL_WINDOWPOS_UNDEFINE=
D,
> > >                                          SDL_WINDOWPOS_UNDEFINED,
> > >                                          surface_width(scon->surface)=
,
> > > @@ -907,6 +907,7 @@ static void sdl2_display_init(DisplayState *ds, D=
isplayOptions *o)
> > >     char *dir;
> > >
> > >     assert(o->type =3D=3D DISPLAY_TYPE_SDL);
> > > +    SDL_SetHint(SDL_HINT_WINDOWS_DPI_AWARENESS, "permonitorv2");
> > >
> > >     if (SDL_GetHintBoolean("QEMU_ENABLE_SDL_LOGGING", SDL_FALSE)) {
> > >         SDL_LogSetAllPriority(SDL_LOG_PRIORITY_VERBOSE);
> > >

