Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F56EC54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpr6i-00085p-RF; Fri, 31 Jul 2026 13:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oliverhenryc@gmail.com>)
 id 1wpr6h-00085Y-Kl
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:33:15 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oliverhenryc@gmail.com>)
 id 1wpr6f-0006EZ-Sq
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:33:15 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c160875e029so15119766b.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:33:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785519192; cv=none;
 d=google.com; s=arc-20260327;
 b=PyyI8B0BatEcpDbCJslppQFWR2jVJm9mc+EYiaK60qh+XhtVPsg6Hqj3Z+5lYPh2gh
 WqCQAyG/kXZmPyc1Yzy6jmjpfjwIaaMNFIJh9I5YLRMiBwVFYNwM7hMOOcCHvRF7khTi
 rpD0+hZEBX1u8fcqt2V6CxsNBFPRVgluoFFyTIlNZvLb8MdfriTIDCBWeYhMSk1gbzV/
 T2Cq4OWQvB/Y8NLm2Xr3BGoX3iagBy2LFmo4fTF4i+HJ2z+FJkn/NV5iS1F3ighR8Bqn
 HNjAXHDug1pFAzFWy3FEjNfI/WoszgK+pw7rtBaW9Pp611m9OamJqscTfPWJdWYwHs+Y
 xqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sxrDHD3fHtsaGAoO9OlKh4eK82emC/L4hcej619Vp7w=;
 fh=vPinGPxx/1+aDQf02ZUnvpyuMQtJPOpb7Jete3Oc3CQ=;
 b=X+FhT/iazDkeuN00tM4Jh1IET8ewTHhkA21G/mwwCnSmjEbS8Y1VmVGKVvdCk7L/o6
 GhEffB9DLLIPKOcxmG2nhqjmTpenBP4Ceq2YFmXj4eAvxp/rXNLCu0cmfXDp64WK69qL
 JgzEKnihyKFpF6CWVDoLUu2IpeMGxy51rrmnK6q8IXROIzlsgnfl9zlGhHbb6kdIssl3
 8qHZBHYry8SobQx7EC4TC0biOj0VLFmJF+SxsO5+/sGdQol2rbTVyIog74OUvk5sg74w
 urdIsjypbvNDUHIrV8gVdo4ecHKtY7cmWUvHuFTR5c9QW9ctShOWcNl9sREa/HgNVBuo
 /DTA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785519192; x=1786123992; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sxrDHD3fHtsaGAoO9OlKh4eK82emC/L4hcej619Vp7w=;
 b=M8Qd6g3DrWFnGfYIrKNzvjx3rZ78hTkrslncsOTiA08MAtjVogVCPsvG2ODU2LvBdC
 DtkaadtS3ic/Q2PN3LWkxMYln7EckWsyPP48O2TYYQ8RvnBs+aYfikVUDpJRuhiV5aha
 sZBYQ3vejkQCMq6j5FQ/QiroJ/DJdR6z/S+PsSs+1O4JGkNs+fdf9In8l/ISoW/gdd6+
 r27iWhW2hn7DQ7kjgDJeut5CCnmlLVAgomSaPjro6Qy/76yg325JZvIbAI0AwGtuPlOk
 7u9lDq9XV1SMhjpg2CxPccVLBB/UiKNw60jcVXDykkQkHhSilSHpin70IePuHkO7tbNj
 H11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785519192; x=1786123992;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sxrDHD3fHtsaGAoO9OlKh4eK82emC/L4hcej619Vp7w=;
 b=a7OnNKc4FspZ2oPgVoY2tmdsAg8X/lgQxuMA8pzf4/mo+0WHa4yZWa72c48nOC22yF
 Q7lwbpptx0l9KNa7h+Os7bBUemdz2pU3pZoA1dcBuS5bDXdxusdRBG0BwyJ9UHvb9dqE
 /Rvr6UyqF3DxvoEGr+m3Et3Gg6DFXGfRfVXgzvO/U8wWioJoNReVJS89xr4kY/BaS+UP
 Hpqd25PIX35AOiYSplVRzRCW3eE0PuYfC/HViCaHd7prDXY9sFloQTbjnAwV0okxj2HS
 0NCfm8+Dih46gJvLdPuoMM/qn55Zt/sbWORtqvXqcnUZrhweKkT0bU921LLz+XPFPIiG
 rpwA==
X-Gm-Message-State: AOJu0Yza1saond/IsNCMg/RGniH0s3DmKRmAp1u3H9vLoFmabz40BYt+
 uPMGO0mD0ElzdeqvLJcNECuK402be6xppNapbYuxpu7texmn9ejmbMVFWmANymSl0q7qV0YxWgj
 Ef0qZ3HFiL2+hdVhjrTUhZNM/1xkOgJc=
X-Gm-Gg: AR+sD12H0Wpa0/iEqOpsAeYfl0sK/MFwieTUr+CNGELqiSQ5praL79JMCHnBISQlGEd
 ADT8PM5pYChBhVo8IG91oVNKrIoJaRM4T+2tj4+JwQ1E4+5JK1YQ+NXxGaAb+uqAai+iT4QJOCm
 NHNzX9unrh/79MsqAe5Gdc0ytuLZQ/PM//SXkENFB2R9kmK49KpALfNeEhZoSaFMLzKYrHvJCu4
 WsjMQHelBLzz2BjUuKg+u8U33osH/qwnTyTEDHnfmdbfbrUXv/Xo4IWtbV9Q4IXMJIyT/GMiLkR
 dOpg4bXr3zGB5cIuSXXQSLzt2pPzwev+vg5gZIEUWNvBt5AF4wKLzhPwtuQFcJILDgXYoXKxQy5
 K
X-Received: by 2002:a17:907:3c8a:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c1fe81e28b1mr35315466b.3.1785519191902; Fri, 31 Jul 2026
 10:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260730230449.963-1-oliverhenryc@gmail.com>
 <92c3b7f6-4afa-7a61-1843-fbfe855cb9c4@eik.bme.hu>
In-Reply-To: <92c3b7f6-4afa-7a61-1843-fbfe855cb9c4@eik.bme.hu>
From: Oliver C <oliverhenryc@gmail.com>
Date: Fri, 31 Jul 2026 13:32:59 -0400
X-Gm-Features: AUfX_mzELJy5RAhrwtYdjCOh4PbrYxECvhHuyBykSc9l1H0w-MwJ2QihGgSJaZQ
Message-ID: <CAGxFFDP0mL-6fZcMQkJm7V1mDepC64Y+YFN-CcgqP0OrMX3w4A@mail.gmail.com>
Subject: Re: [PATCH] sdl2: fix HighDPI display scaling
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 marcandre.lureau@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=oliverhenryc@gmail.com; helo=mail-ej1-x634.google.com
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

> Does this mean that on hiDPI displays now a 640x480 guest screen
> (like BIOS or legacy guest) shows a tiny unusable window?

This is correct, but:

> ...the issue that other ui backends should do the same so just changing
> one backend may lead to inconsistency.

the gtk backend exhibits the same behavior as the sdl backend with my chang=
es,
i.e. it creates a 640x480 guest screen in physical pixels (my machine has a
4k monitor with 150% scaling), just like the new changes. So these changes
in fact make it more consistent. Although, I just noticed that gtk has
a 'scale' option,
which scales the window size, and stretches the surface to it. I
suppose this can
be added to sdl. I think it would also be a good idea to enable linear filt=
ering
when stretching the surface, so it doesn't look as blurry.

> Despite the patch is just two lines maybe it's not a trivial change.

Gotcha, sorry this is my first time sending a patch through mailing
list, so thanks for bearing with me.

Oliver

On Fri, Jul 31, 2026 at 7:05=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Thu, 30 Jul 2026, Oliver Clarke wrote:
> > This makes sdl2 windows work well with dpi scaling. It fixes the issue
> > of the display surface being stretched to fit the dpi corrected window
> > (which created a blurry result).
> >
> > Note, this does not do any scaling, it just tells the os to not scale
> > the window. Before, when the console requested size 640x480, the logica=
l
> > size of the window was 640x480, and the physical size was scaled by the
> > dpi scaling. Now, both the logical and physical size will be 640x480.
> > This is unlike most dpi aware programs which usually do have the scaled
> > physical size, then also make the render target that scaled size as
> > well. This doesn't make as much sense for QEMU, since the guest is
> > responsible for modesetting, and they should get the exact physical
> > pixels they request (if i modeset to 3840x2160, I wouldn't want this to
> > be scaled in any way).
>
> Despite the patch is just two lines maybe it's not a trivial change. Does
> this mean that on hiDPI displays now a 640x480 guest screen (like BIOS or
> legacy guest) shows a tiny unusable window? In that case maybe this needs
> to be switchable with a property or turn off scaling of 4k and higher
> resolutions but then we get to the issue that other ui backends should do
> the same so just changing one backend may lead to inconsistency. Did you
> check how is this handled in other ui backends?
>
> Regards,
> BALATON Zoltan
>
> > Signed-off-by: Oliver Clarke <oliverhenryc@gmail.com>
> > ---
> > ui/sdl2.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/ui/sdl2.c b/ui/sdl2.c
> > index 1c97d23a47..1910477db4 100644
> > --- a/ui/sdl2.c
> > +++ b/ui/sdl2.c
> > @@ -102,7 +102,7 @@ void sdl2_window_create(struct sdl2_console *scon)
> >         flags |=3D SDL_WINDOW_OPENGL;
> >     }
> > #endif
> > -
> > +    flags |=3D SDL_WINDOW_ALLOW_HIGHDPI;
> >     scon->real_window =3D SDL_CreateWindow("", SDL_WINDOWPOS_UNDEFINED,
> >                                          SDL_WINDOWPOS_UNDEFINED,
> >                                          surface_width(scon->surface),
> > @@ -907,6 +907,7 @@ static void sdl2_display_init(DisplayState *ds, Dis=
playOptions *o)
> >     char *dir;
> >
> >     assert(o->type =3D=3D DISPLAY_TYPE_SDL);
> > +    SDL_SetHint(SDL_HINT_WINDOWS_DPI_AWARENESS, "permonitorv2");
> >
> >     if (SDL_GetHintBoolean("QEMU_ENABLE_SDL_LOGGING", SDL_FALSE)) {
> >         SDL_LogSetAllPriority(SDL_LOG_PRIORITY_VERBOSE);
> >

