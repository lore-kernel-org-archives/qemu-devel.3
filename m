Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A819CA0FF7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgBp-0002Zg-MP; Thu, 28 Aug 2025 13:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1ureqm-0000wp-Fr
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:47:44 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ankeesler@google.com>)
 id 1ureqi-0002qh-QM
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:47:44 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-55f4410f7c9so1343864e87.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756396057; x=1757000857; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AyyrOBBynXugkIwtswIsMyDBzmhP0zBrM1ml36TvSlM=;
 b=UVSHnMPvvQA0dQAvunWqmO+D5NtoV8a91b86V72cN87FZtpRskEJ0/YLsp6D+ZpZak
 V80WwVK1fBjcIeCm/dkxros5T+vo96wBiPlwCjQNZ2aBJupkNKqC5lpGlV1Gq2CzvSO8
 LdCfCzHVqi175cugVF9DzoIb3mlKHwF3C8QTCTXo0ukrilEbANrHqUzhbTCitwLP2MUZ
 7aSb1R7oGI1Y6HdWTKqjLtbaeQQBN20S6L4Kver6nt8NlWOSahMZF9YS7zE6+iaPAETO
 NuCrZ9rof7GJs6oQQK2EpaRr37sii6d1kUnX9Lvgg0UZ/gq2tlO1YC593BAf9QpAOQ4P
 0Oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756396057; x=1757000857;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AyyrOBBynXugkIwtswIsMyDBzmhP0zBrM1ml36TvSlM=;
 b=OI264SshihdSIjiJGSUARA+crvd+6bPKGVkQdUHtgXkCkzE5owWdlt/w077x6DvvAA
 oANAALlQDl//n82FCRnx8wHOuGfX85EhgbO9/NUVxDO24NQHCAVNSJW8Kde3w3QLm88E
 x+8Tg1vcNwawLUTESx52trCgOJ/XR2Q9hU0ptJM9+04YD0/3oQKYVAGvpfoJTKF0YScU
 ioWQ3yYoWjaKRsPcnVB+MoMf9Ww/m6mGpyToknQQ2IU6B0DvU7cGzvyJskzp/UMWhZ3V
 Xm2lc6pbjXtsBPMmdEzZzu6gIOwhqU3Jy5ZITIU4G7hfO5l5J3JXo7RbB9Ht3p7JgDL/
 2aeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVEzdOcT0GjoVKTohRPo8VdysJg7yGEk1VEg0puWL2OvjRlwQCf2gGBR5mJGsy/ZyF9oEsGDMDrBGv@nongnu.org
X-Gm-Message-State: AOJu0YybaTLRgdZW2gSLsn6J+8N/sXacAJ2YzJfISoY2GU7pvE+nozHw
 z/KhbPmNC6HzH42ZivwjIekA21x2SOhRuzH5PM/2RKLwu3GS5TKm4u2y0Qv6Bvav2PlgWRL/eb8
 e3im4J7QaZVcnUuuWHiU8s5LOx4t23oGtPpDknC8=
X-Gm-Gg: ASbGnctNvC0n49KegjLcIZWor7uFE920kib6urGcNEK6tq/zmXsKaWF5m9TOzjGPFUo
 MbU+4cooNxKD4a2Ac18sYfv4vV7YfAKGxLzy1HdsqxjIPBaLmVsU96tzcPampYCN+j+ZgunErZv
 6cliQCQBBbJ9ztu7uCE/cCt68ktKDIdFKcM4AGvFlcUt9x9owTTDiBiY6SzOM9snIijIvfRt3MU
 vSHdmqaa2yiH7gRBkxAKGw//3wlRM1EbLG+Lts7rA0OM88WU1srGQ==
X-Google-Smtp-Source: AGHT+IGBJ+y4p74p5F4usGVQ45sHf3LQQUimo7oskeQL5DVYd1UqesNTY5ntU0Scsf1B09fAPAENJ9wFVahkVu0miis=
X-Received: by 2002:a05:6512:6282:b0:55f:4953:ae91 with SMTP id
 2adb3069b0e04-55f4953b230mr4668374e87.5.1756396056869; Thu, 28 Aug 2025
 08:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250722190824.3419413-1-ankeesler@google.com>
 <20250722190824.3419413-2-ankeesler@google.com> <aK8MHGgp-Dm_Lkmb@redhat.com>
 <CAGZECHOL=v50aV0vcCHdFxb69TmH7mXry2NEhu+EZZnWztRO-A@mail.gmail.com>
 <aK81yUqtwoZ9_29l@redhat.com>
In-Reply-To: <aK81yUqtwoZ9_29l@redhat.com>
From: Andrew Keesler <ankeesler@google.com>
Date: Thu, 28 Aug 2025 11:47:23 -0400
X-Gm-Features: Ac12FXykRMIDzpB4fn4C7JTttyAib_JJaN6siy_5v3XKdXBmVFglGxOt0EPGUfs
Message-ID: <CAGZECHNkRo=Oejh9CgAAV+Qa8f_PgdhvyOy+rAGNRG29Datt1Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/display: Support per-head resolutions with
 virtio-gpu
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000000e63f4063d6ed339"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=ankeesler@google.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

--0000000000000e63f4063d6ed339
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > I think we should probably report an error if xres / yres
> > are set at the global level and also set against any individual
> > output, so the two approaches are mutually exclusive.

> ACK - fixed for the next patch.

Doh, I ran into an error. Seems like if I don't set xres/yres, then it
gets defaulted to 1280x800.


https://gitlab.com/qemu-project/qemu/-/blob/master/include/hw/virtio/virtio=
-gpu.h#L175-176

So...could we just get away with documenting that if you set xres/yres
and outputs[0].xres/yres, then the later is going to overwrite the
former? I'm not sure how to detect if xres/yres has been set globally
to 1280x800, or if we are just getting the defaults.

What do you think?

On Wed, Aug 27, 2025 at 12:44=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:

> On Wed, Aug 27, 2025 at 11:48:34AM -0400, Andrew Keesler wrote:
> > Sending again (replying all this time).
> >
> > > IIUC from the current code, xres/yres are only set against the
> > > first head. The 2nd and later heads are left undefined by the
> > > virtio-gpu-base code at least - I'm unclear if something else
> > > in QEMU will fill in defaults later, or if they set to 0x0.
> >
> > That is correct - xres/yres are only set against the first head in the
> > current code. The wording in my commit message (and cover letter) was
> > misleading. I will fix that to say that "If no
> > virtio_gpu_base_conf.outputs are provided,
> > virtio_gpu_base_conf.xres/virtio_gpu_base_conf.yres will still be
> > respected _for the first head_ for backwards compatibility".
> >
> > The only way I could get QEMU to fill in xres/yres for a 2nd and later
> > head was to trigger virtio_gpu_ops.ui_info via a VNC client.
> >
> > > Is it relevant to set xres/yres on outputs, even when they are
> > > not (yet) enabled ?  Perhaps we should have an explicit 'enabled: boo=
l'
> > > property in the 'outputs' struct ?
> >
> > Maybe you might want to set xres/yres on an output, but not enable it
> > yet? I don't have any concrete examples of when you might want to do
> > that, maybe you have some examples?
>
> No, I don't have an example.
>
> > I feel like I could see a user setting xres/yres on an output,
> > forgetting to set enabled on that output, and then being confused why
> > their head is blank. Because of this, my vote would be to default to
> > enabling an output when it has configuration. I am easily swayed by
> > your guidance, though.
>
> Ok, lets just document that setting xres/yres will cause the
> output to be automatically enabled. We can always retrofit
> an 'enabled' property at a later date if someone arrives with
> a use case for setting res without enabling the output.
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--0000000000000e63f4063d6ed339
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; &gt; I think we should probably report an error if xr=
es / yres<br>&gt; &gt; are set at the global level and also set against any=
 individual<br>&gt; &gt; output, so the two approaches are mutually exclusi=
ve.<br><br>&gt; ACK - fixed for the next patch.<br><br>Doh, I ran into an e=
rror. Seems like if I don&#39;t set xres/yres, then it<br>gets defaulted to=
 1280x800.<br><br>=C2=A0 <a href=3D"https://gitlab.com/qemu-project/qemu/-/=
blob/master/include/hw/virtio/virtio-gpu.h#L175-176">https://gitlab.com/qem=
u-project/qemu/-/blob/master/include/hw/virtio/virtio-gpu.h#L175-176</a><br=
><br>So...could we just get away with documenting that if you set xres/yres=
<br>and outputs[0].xres/yres, then the later is going to overwrite the<br>f=
ormer? I&#39;m not sure how to detect if xres/yres has been set globally<br=
>to 1280x800, or if we are just getting the defaults.<br><div><br></div><di=
v>What do you think?</div></div><br><div class=3D"gmail_quote gmail_quote_c=
ontainer"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 27, 2025 at 12:=
44=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat=
.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On Wed, Aug 27, 2025 at 11:48:34AM -0400, Andrew K=
eesler wrote:<br>
&gt; Sending again (replying all this time).<br>
&gt; <br>
&gt; &gt; IIUC from the current code, xres/yres are only set against the<br=
>
&gt; &gt; first head. The 2nd and later heads are left undefined by the<br>
&gt; &gt; virtio-gpu-base code at least - I&#39;m unclear if something else=
<br>
&gt; &gt; in QEMU will fill in defaults later, or if they set to 0x0.<br>
&gt; <br>
&gt; That is correct - xres/yres are only set against the first head in the=
<br>
&gt; current code. The wording in my commit message (and cover letter) was<=
br>
&gt; misleading. I will fix that to say that &quot;If no<br>
&gt; virtio_gpu_base_conf.outputs are provided,<br>
&gt; virtio_gpu_base_conf.xres/virtio_gpu_base_conf.yres will still be<br>
&gt; respected _for the first head_ for backwards compatibility&quot;.<br>
&gt; <br>
&gt; The only way I could get QEMU to fill in xres/yres for a 2nd and later=
<br>
&gt; head was to trigger virtio_gpu_ops.ui_info via a VNC client.<br>
&gt; <br>
&gt; &gt; Is it relevant to set xres/yres on outputs, even when they are<br=
>
&gt; &gt; not (yet) enabled ?=C2=A0 Perhaps we should have an explicit &#39=
;enabled: bool&#39;<br>
&gt; &gt; property in the &#39;outputs&#39; struct ?<br>
&gt; <br>
&gt; Maybe you might want to set xres/yres on an output, but not enable it<=
br>
&gt; yet? I don&#39;t have any concrete examples of when you might want to =
do<br>
&gt; that, maybe you have some examples?<br>
<br>
No, I don&#39;t have an example.<br>
<br>
&gt; I feel like I could see a user setting xres/yres on an output,<br>
&gt; forgetting to set enabled on that output, and then being confused why<=
br>
&gt; their head is blank. Because of this, my vote would be to default to<b=
r>
&gt; enabling an output when it has configuration. I am easily swayed by<br=
>
&gt; your guidance, though.<br>
<br>
Ok, lets just document that setting xres/yres will cause the<br>
output to be automatically enabled. We can always retrofit<br>
an &#39;enabled&#39; property at a later date if someone arrives with<br>
a use case for setting res without enabling the output.<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div>

--0000000000000e63f4063d6ed339--

